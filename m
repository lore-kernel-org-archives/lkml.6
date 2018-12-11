Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72ADC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E8E20851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E8E20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbeLKB5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:57:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16105 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727485AbeLKB5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:57:40 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0F769C8F68573;
        Tue, 11 Dec 2018 09:57:37 +0800 (CST)
Received: from dessert.huawei.com (10.69.192.158) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Tue, 11 Dec 2018 09:57:33 +0800
From:   Zeng Tao <prime.zeng@hisilicon.com>
To:     <laurent.pinchart@ideasonboard.com>
CC:     Zeng Tao <prime.zeng@hisilicon.com>,
        Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Paul Elder <paul.elder@ideasonboard.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: gadget: uvc: configfs: add framebased format support
Date:   Tue, 11 Dec 2018 18:00:43 +0800
Message-ID: <1544522445-28930-1-git-send-email-prime.zeng@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we know, The framebased format can be used to support a lot of
formats other than YUV and MJPEG, for example: H264 or H265.
And Nowadays, the H264 and H265 is used more and more compared to the
MJPEG, so there is a need to support such usecase, although the new UVC
1.5 and the UVC1.1 extensions already support H264, but they are much
more expensive and most of the time, what we need is just a channel to
stream the video frames.

In this patch, we implement the framebased format and set it to H264 by
default, and the users could change the video format as they need through
the guid configfs attribute node.

Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
---
 drivers/usb/gadget/function/uvc_configfs.c | 350 ++++++++++++++++++++++++++++-
 include/uapi/linux/usb/video.h             |  58 +++++
 2 files changed, 401 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
index bc1e2af..a1fb52b 100644
--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -767,11 +767,13 @@ static const struct uvcg_config_group_type uvcg_control_grp_type = {
 static const char * const uvcg_format_names[] = {
 	"uncompressed",
 	"mjpeg",
+	"framebased",
 };
 
 enum uvcg_format_type {
 	UVCG_UNCOMPRESSED = 0,
 	UVCG_MJPEG,
+	UVCG_FRAMEBASED,
 };
 
 struct uvcg_format {
@@ -1077,9 +1079,15 @@ struct uvcg_frame {
 		u16	w_height;
 		u32	dw_min_bit_rate;
 		u32	dw_max_bit_rate;
+		/*
+		 * dw_max_video_frame_buffer_size is only for uncompressed and
+		 * mjpeg format
+		 */
 		u32	dw_max_video_frame_buffer_size;
 		u32	dw_default_frame_interval;
 		u8	b_frame_interval_type;
+		/* dw_bytes_perline is only for framebased format */
+		u32	dw_bytes_perline;
 	} __attribute__((packed)) frame;
 	u32 *dw_frame_interval;
 };
@@ -1190,6 +1198,7 @@ UVCG_FRAME_ATTR(dw_min_bit_rate, dwMinBitRate, 32);
 UVCG_FRAME_ATTR(dw_max_bit_rate, dwMaxBitRate, 32);
 UVCG_FRAME_ATTR(dw_max_video_frame_buffer_size, dwMaxVideoFrameBufferSize, 32);
 UVCG_FRAME_ATTR(dw_default_frame_interval, dwDefaultFrameInterval, 32);
+UVCG_FRAME_ATTR(dw_bytes_perline, dwBytesPerLine, 32);
 
 #undef UVCG_FRAME_ATTR
 
@@ -1324,7 +1333,7 @@ static ssize_t uvcg_frame_dw_frame_interval_store(struct config_item *item,
 
 UVC_ATTR(uvcg_frame_, dw_frame_interval, dwFrameInterval);
 
-static struct configfs_attribute *uvcg_frame_attrs[] = {
+static struct configfs_attribute *uvcg_frame_attrs1[] = {
 	&uvcg_frame_attr_b_frame_index,
 	&uvcg_frame_attr_bm_capabilities,
 	&uvcg_frame_attr_w_width,
@@ -1337,9 +1346,28 @@ static struct configfs_attribute *uvcg_frame_attrs[] = {
 	NULL,
 };
 
-static const struct config_item_type uvcg_frame_type = {
+static struct configfs_attribute *uvcg_frame_attrs2[] = {
+	&uvcg_frame_attr_b_frame_index,
+	&uvcg_frame_attr_bm_capabilities,
+	&uvcg_frame_attr_w_width,
+	&uvcg_frame_attr_w_height,
+	&uvcg_frame_attr_dw_min_bit_rate,
+	&uvcg_frame_attr_dw_max_bit_rate,
+	&uvcg_frame_attr_dw_default_frame_interval,
+	&uvcg_frame_attr_dw_frame_interval,
+	&uvcg_frame_attr_dw_bytes_perline,
+	NULL,
+};
+
+static const struct config_item_type uvcg_frame_type1 = {
 	.ct_item_ops	= &uvcg_config_item_ops,
-	.ct_attrs	= uvcg_frame_attrs,
+	.ct_attrs	= uvcg_frame_attrs1,
+	.ct_owner	= THIS_MODULE,
+};
+
+static const struct config_item_type uvcg_frame_type2 = {
+	.ct_item_ops	= &uvcg_config_item_ops,
+	.ct_attrs	= uvcg_frame_attrs2,
 	.ct_owner	= THIS_MODULE,
 };
 
@@ -1363,6 +1391,7 @@ static struct config_item *uvcg_frame_make(struct config_group *group,
 	h->frame.dw_max_bit_rate		= 55296000;
 	h->frame.dw_max_video_frame_buffer_size	= 460800;
 	h->frame.dw_default_frame_interval	= 666666;
+	h->frame.dw_bytes_perline = 0;
 
 	opts_item = group->cg_item.ci_parent->ci_parent->ci_parent;
 	opts = to_f_uvc_opts(opts_item);
@@ -1375,6 +1404,9 @@ static struct config_item *uvcg_frame_make(struct config_group *group,
 	} else if (fmt->type == UVCG_MJPEG) {
 		h->frame.b_descriptor_subtype = UVC_VS_FRAME_MJPEG;
 		h->fmt_type = UVCG_MJPEG;
+	} else if (fmt->type == UVCG_FRAMEBASED) {
+		h->frame.b_descriptor_subtype = UVC_VS_FRAME_FRAME_BASED;
+		h->fmt_type = UVCG_FRAMEBASED;
 	} else {
 		mutex_unlock(&opts->lock);
 		kfree(h);
@@ -1383,7 +1415,10 @@ static struct config_item *uvcg_frame_make(struct config_group *group,
 	++fmt->num_frames;
 	mutex_unlock(&opts->lock);
 
-	config_item_init_type_name(&h->item, name, &uvcg_frame_type);
+	if (fmt->type == UVCG_FRAMEBASED)
+		config_item_init_type_name(&h->item, name, &uvcg_frame_type2);
+	else
+		config_item_init_type_name(&h->item, name, &uvcg_frame_type1);
 
 	return &h->item;
 }
@@ -1413,7 +1448,8 @@ static void uvcg_format_set_indices(struct config_group *fmt)
 	list_for_each_entry(ci, &fmt->cg_children, ci_entry) {
 		struct uvcg_frame *frm;
 
-		if (ci->ci_type != &uvcg_frame_type)
+		if (ci->ci_type != &uvcg_frame_type1 ||
+		    ci->ci_type != &uvcg_frame_type2)
 			continue;
 
 		frm = to_uvcg_frame(ci);
@@ -1865,6 +1901,260 @@ static const struct uvcg_config_group_type uvcg_mjpeg_grp_type = {
 };
 
 /* -----------------------------------------------------------------------------
+ * streaming/framebased/<NAME>
+ */
+
+struct uvcg_framebased {
+	struct uvcg_format		fmt;
+	struct uvc_format_framebased	desc;
+};
+
+static struct uvcg_framebased *to_uvcg_framebased(struct config_item *item)
+{
+	return container_of(
+		container_of(to_config_group(item), struct uvcg_format, group),
+		struct uvcg_framebased, fmt);
+}
+
+static struct configfs_group_operations uvcg_framebased_group_ops = {
+	.make_item		= uvcg_frame_make,
+	.drop_item		= uvcg_frame_drop,
+};
+
+#define UVCG_FRAMEBASED_ATTR_RO(cname, aname, bits)			\
+static ssize_t uvcg_framebased_##cname##_show(struct config_item *item,\
+					char *page)			\
+{									\
+	struct uvcg_framebased *u = to_uvcg_framebased(item);		\
+	struct f_uvc_opts *opts;					\
+	struct config_item *opts_item;					\
+	struct mutex *su_mutex = &u->fmt.group.cg_subsys->su_mutex;	\
+	int result;							\
+									\
+	mutex_lock(su_mutex); /* for navigating configfs hierarchy */	\
+									\
+	opts_item = u->fmt.group.cg_item.ci_parent->ci_parent->ci_parent;\
+	opts = to_f_uvc_opts(opts_item);				\
+									\
+	mutex_lock(&opts->lock);					\
+	result = sprintf(page, "%u\n", le##bits##_to_cpu(u->desc.aname));\
+	mutex_unlock(&opts->lock);					\
+									\
+	mutex_unlock(su_mutex);						\
+	return result;							\
+}									\
+									\
+UVC_ATTR_RO(uvcg_framebased_, cname, aname)
+
+#define UVCG_FRAMEBASED_ATTR(cname, aname, bits)			\
+static ssize_t uvcg_framebased_##cname##_show(struct config_item *item,\
+				char *page)\
+{									\
+	struct uvcg_framebased *u = to_uvcg_framebased(item);		\
+	struct f_uvc_opts *opts;					\
+	struct config_item *opts_item;					\
+	struct mutex *su_mutex = &u->fmt.group.cg_subsys->su_mutex;	\
+	int result;							\
+									\
+	mutex_lock(su_mutex); /* for navigating configfs hierarchy */	\
+									\
+	opts_item = u->fmt.group.cg_item.ci_parent->ci_parent->ci_parent;\
+	opts = to_f_uvc_opts(opts_item);				\
+									\
+	mutex_lock(&opts->lock);					\
+	result = sprintf(page, "%u\n", le##bits##_to_cpu(u->desc.aname));\
+	mutex_unlock(&opts->lock);					\
+									\
+	mutex_unlock(su_mutex);						\
+	return result;							\
+}									\
+									\
+static ssize_t								\
+uvcg_framebased_##cname##_store(struct config_item *item,		\
+			   const char *page, size_t len)		\
+{									\
+	struct uvcg_framebased *u = to_uvcg_framebased(item);		\
+	struct f_uvc_opts *opts;					\
+	struct config_item *opts_item;					\
+	struct mutex *su_mutex = &u->fmt.group.cg_subsys->su_mutex;	\
+	int ret;							\
+	u8 num;								\
+									\
+	mutex_lock(su_mutex); /* for navigating configfs hierarchy */	\
+									\
+	opts_item = u->fmt.group.cg_item.ci_parent->ci_parent->ci_parent;\
+	opts = to_f_uvc_opts(opts_item);				\
+									\
+	mutex_lock(&opts->lock);					\
+	if (u->fmt.linked || opts->refcnt) {				\
+		ret = -EBUSY;						\
+		goto end;						\
+	}								\
+									\
+	ret = kstrtou8(page, 0, &num);					\
+	if (ret)							\
+		goto end;						\
+									\
+	if (num > 255) {						\
+		ret = -EINVAL;						\
+		goto end;						\
+	}								\
+	u->desc.aname = num;						\
+	ret = len;							\
+end:									\
+	mutex_unlock(&opts->lock);					\
+	mutex_unlock(su_mutex);						\
+	return ret;							\
+}									\
+									\
+UVC_ATTR(uvcg_framebased_, cname, aname)
+
+UVCG_FRAMEBASED_ATTR_RO(b_format_index, bFormatIndex, 8);
+UVCG_FRAMEBASED_ATTR_RO(b_bits_per_pixel, bBitsPerPixel, 8);
+UVCG_FRAMEBASED_ATTR(b_default_frame_index, bDefaultFrameIndex, 8);
+UVCG_FRAMEBASED_ATTR_RO(b_aspect_ratio_x, bAspectRatioX, 8);
+UVCG_FRAMEBASED_ATTR_RO(b_aspect_ratio_y, bAspectRatioY, 8);
+UVCG_FRAMEBASED_ATTR_RO(bm_interface_flags, bmInterfaceFlags, 8);
+
+#undef UVCG_FRAMEBASED_ATTR
+#undef UVCG_FRAMEBASED_ATTR_RO
+
+static ssize_t uvcg_framebased_guid_format_show(struct config_item *item,
+							char *page)
+{
+	struct uvcg_framebased *ch = to_uvcg_framebased(item);
+	struct f_uvc_opts *opts;
+	struct config_item *opts_item;
+	struct mutex *su_mutex = &ch->fmt.group.cg_subsys->su_mutex;
+
+	mutex_lock(su_mutex); /* for navigating configfs hierarchy */
+
+	opts_item = ch->fmt.group.cg_item.ci_parent->ci_parent->ci_parent;
+	opts = to_f_uvc_opts(opts_item);
+
+	mutex_lock(&opts->lock);
+	memcpy(page, ch->desc.guidFormat, sizeof(ch->desc.guidFormat));
+	mutex_unlock(&opts->lock);
+
+	mutex_unlock(su_mutex);
+
+	return sizeof(ch->desc.guidFormat);
+}
+
+static ssize_t uvcg_framebased_guid_format_store(struct config_item *item,
+						   const char *page, size_t len)
+{
+	struct uvcg_framebased *ch = to_uvcg_framebased(item);
+	struct f_uvc_opts *opts;
+	struct config_item *opts_item;
+	struct mutex *su_mutex = &ch->fmt.group.cg_subsys->su_mutex;
+	int ret;
+
+	mutex_lock(su_mutex); /* for navigating configfs hierarchy */
+
+	opts_item = ch->fmt.group.cg_item.ci_parent->ci_parent->ci_parent;
+	opts = to_f_uvc_opts(opts_item);
+
+	mutex_lock(&opts->lock);
+	if (ch->fmt.linked || opts->refcnt) {
+		ret = -EBUSY;
+		goto end;
+	}
+
+	memcpy(ch->desc.guidFormat, page,
+	       min(sizeof(ch->desc.guidFormat), len));
+	ret = sizeof(ch->desc.guidFormat);
+
+end:
+	mutex_unlock(&opts->lock);
+	mutex_unlock(su_mutex);
+	return ret;
+}
+
+UVC_ATTR(uvcg_framebased_, guid_format, guidFormat);
+
+static inline ssize_t
+uvcg_framebased_bma_controls_show(struct config_item *item, char *page)
+{
+	struct uvcg_framebased *u = to_uvcg_framebased(item);
+
+	return uvcg_format_bma_controls_show(&u->fmt, page);
+}
+
+static inline ssize_t
+uvcg_framebased_bma_controls_store(struct config_item *item,
+				     const char *page, size_t len)
+{
+	struct uvcg_framebased *u = to_uvcg_framebased(item);
+
+	return uvcg_format_bma_controls_store(&u->fmt, page, len);
+}
+
+UVC_ATTR(uvcg_framebased_, bma_controls, bmaControls);
+
+static struct configfs_attribute *uvcg_framebased_attrs[] = {
+	&uvcg_framebased_attr_b_format_index,
+	&uvcg_framebased_attr_b_default_frame_index,
+	&uvcg_framebased_attr_b_bits_per_pixel,
+	&uvcg_framebased_attr_b_aspect_ratio_x,
+	&uvcg_framebased_attr_b_aspect_ratio_y,
+	&uvcg_framebased_attr_bm_interface_flags,
+	&uvcg_framebased_attr_bma_controls,
+	&uvcg_framebased_attr_guid_format,
+	NULL,
+};
+
+static const struct config_item_type uvcg_framebased_type = {
+	.ct_item_ops	= &uvcg_config_item_ops,
+	.ct_group_ops	= &uvcg_framebased_group_ops,
+	.ct_attrs	= uvcg_framebased_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_group *uvcg_framebased_make(struct config_group *group,
+						   const char *name)
+{
+	static char guid[] = { /*Declear frame frame based as H264*/
+		'H',  '2',  '6',  '4', 0x00, 0x00, 0x10, 0x00,
+		0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71
+	};
+	struct uvcg_framebased *f;
+
+	f = kzalloc(sizeof(*f), GFP_KERNEL);
+	if (!f)
+		return ERR_PTR(-ENOMEM);
+
+	f->desc.bLength			= UVC_DT_FORMAT_FRAMEBASED_SIZE;
+	f->desc.bDescriptorType		= USB_DT_CS_INTERFACE;
+	f->desc.bDescriptorSubType	= UVC_VS_FORMAT_FRAME_BASED;
+	memcpy(f->desc.guidFormat, guid, sizeof(guid));
+	f->desc.bBitsPerPixel		= 0;
+	f->desc.bDefaultFrameIndex	= 1;
+	f->desc.bAspectRatioX		= 0;
+	f->desc.bAspectRatioY		= 0;
+	f->desc.bmInterfaceFlags	= 0;
+	f->desc.bCopyProtect		= 0;
+
+	f->fmt.type = UVCG_FRAMEBASED;
+	config_group_init_type_name(&f->fmt.group, name,
+				    &uvcg_framebased_type);
+
+	return &f->fmt.group;
+}
+
+static struct configfs_group_operations uvcg_framebased_grp_ops = {
+	.make_group		= uvcg_framebased_make,
+};
+static const struct uvcg_config_group_type uvcg_framebased_grp_type = {
+	.type = {
+		.ct_item_ops	= &uvcg_config_item_ops,
+		.ct_group_ops	= &uvcg_framebased_grp_ops,
+		.ct_owner	= THIS_MODULE,
+	},
+	.name = "framebased",
+};
+
+/* -----------------------------------------------------------------------------
  * streaming/color_matching/default
  */
 
@@ -2057,6 +2347,10 @@ static int __uvcg_cnt_strm(void *priv1, void *priv2, void *priv3, int n,
 				container_of(fmt, struct uvcg_mjpeg, fmt);
 
 			*size += sizeof(m->desc);
+		} else if (fmt->type == UVCG_FRAMEBASED) {
+			struct uvcg_framebased *f =
+				container_of(fmt, struct uvcg_framebased, fmt);
+			*size += sizeof(f->desc);
 		} else {
 			return -EINVAL;
 		}
@@ -2067,6 +2361,11 @@ static int __uvcg_cnt_strm(void *priv1, void *priv2, void *priv3, int n,
 		int sz = sizeof(frm->dw_frame_interval);
 
 		*size += sizeof(frm->frame);
+		/*
+		 * framebased has duplicate member with uncompressed and
+		 * mjpeg, so minus it
+		 */
+		*size -= sizeof(u32);
 		*size += frm->frame.b_frame_interval_type * sz;
 	}
 	break;
@@ -2077,6 +2376,27 @@ static int __uvcg_cnt_strm(void *priv1, void *priv2, void *priv3, int n,
 	return 0;
 }
 
+static int __uvcg_copy_framebased_desc(void *dest, struct uvcg_frame *frm,
+				       int sz)
+{
+	struct uvc_frame_framebased *desc = dest;
+
+	desc->bLength = frm->frame.b_length;
+	desc->bDescriptorType = frm->frame.b_descriptor_type;
+	desc->bDescriptorSubType = frm->frame.b_descriptor_subtype;
+	desc->bFrameIndex = frm->frame.b_frame_index;
+	desc->bmCapabilities = frm->frame.bm_capabilities;
+	desc->wWidth = frm->frame.w_width;
+	desc->wHeight = frm->frame.w_height;
+	desc->dwMinBitRate = frm->frame.dw_min_bit_rate;
+	desc->dwMaxBitRate = frm->frame.dw_max_bit_rate;
+	desc->dwDefaultFrameInterval = frm->frame.dw_default_frame_interval;
+	desc->bFrameIntervalType = frm->frame.b_frame_interval_type;
+	desc->dwBytesPerLine = frm->frame.dw_bytes_perline;
+
+	return 0;
+}
+
 /*
  * Fill an array of streaming descriptors.
  *
@@ -2131,6 +2451,15 @@ static int __uvcg_fill_strm(void *priv1, void *priv2, void *priv3, int n,
 			m->desc.bNumFrameDescriptors = fmt->num_frames;
 			memcpy(*dest, &m->desc, sizeof(m->desc));
 			*dest += sizeof(m->desc);
+		} else if (fmt->type == UVCG_FRAMEBASED) {
+			struct uvcg_framebased *f =
+				container_of(fmt, struct uvcg_framebased,
+					     fmt);
+
+			f->desc.bFormatIndex = n + 1;
+			f->desc.bNumFrameDescriptors = fmt->num_frames;
+			memcpy(*dest, &f->desc, sizeof(f->desc));
+			*dest += sizeof(f->desc);
 		} else {
 			return -EINVAL;
 		}
@@ -2140,8 +2469,11 @@ static int __uvcg_fill_strm(void *priv1, void *priv2, void *priv3, int n,
 		struct uvcg_frame *frm = priv1;
 		struct uvc_descriptor_header *h = *dest;
 
-		sz = sizeof(frm->frame);
-		memcpy(*dest, &frm->frame, sz);
+		sz = sizeof(frm->frame) - 4;
+		if (frm->fmt_type != UVCG_FRAMEBASED)
+			memcpy(*dest, &frm->frame, sz);
+		else
+			__uvcg_copy_framebased_desc(*dest, frm, sz);
 		*dest += sz;
 		sz = frm->frame.b_frame_interval_type *
 			sizeof(*frm->dw_frame_interval);
@@ -2153,6 +2485,9 @@ static int __uvcg_fill_strm(void *priv1, void *priv2, void *priv3, int n,
 		else if (frm->fmt_type == UVCG_MJPEG)
 			h->bLength = UVC_DT_FRAME_MJPEG_SIZE(
 				frm->frame.b_frame_interval_type);
+		else if (frm->fmt_type == UVCG_FRAMEBASED)
+			h->bLength = UVC_DT_FRAME_FRAMEBASED_SIZE(
+				 frm->frame.b_frame_interval_type);
 	}
 	break;
 	}
@@ -2365,6 +2700,7 @@ static const struct uvcg_config_group_type uvcg_streaming_grp_type = {
 		&uvcg_streaming_header_grp_type,
 		&uvcg_uncompressed_grp_type,
 		&uvcg_mjpeg_grp_type,
+		&uvcg_framebased_grp_type,
 		&uvcg_color_matching_grp_type,
 		&uvcg_streaming_class_grp_type,
 		NULL,
diff --git a/include/uapi/linux/usb/video.h b/include/uapi/linux/usb/video.h
index d854cb1..cae0fc1 100644
--- a/include/uapi/linux/usb/video.h
+++ b/include/uapi/linux/usb/video.h
@@ -566,5 +566,63 @@ struct UVC_FRAME_MJPEG(n) {				\
 	__le32 dwFrameInterval[n];			\
 } __attribute__ ((packed))
 
+/* Frame Based Payload - 3.1.1. Frame Based Video Format Descriptor */
+struct uvc_format_framebased {
+	__u8  bLength;
+	__u8  bDescriptorType;
+	__u8  bDescriptorSubType;
+	__u8  bFormatIndex;
+	__u8  bNumFrameDescriptors;
+	__u8  guidFormat[16];
+	__u8  bBitsPerPixel;
+	__u8  bDefaultFrameIndex;
+	__u8  bAspectRatioX;
+	__u8  bAspectRatioY;
+	__u8  bmInterfaceFlags;
+	__u8  bCopyProtect;
+	__u8  bVariableSize;
+} __attribute__((__packed__));
+
+#define UVC_DT_FORMAT_FRAMEBASED_SIZE			28
+
+/* Frame Based Payload - 3.1.2. Frame Based Video Frame Descriptor */
+struct uvc_frame_framebased {
+	__u8  bLength;
+	__u8  bDescriptorType;
+	__u8  bDescriptorSubType;
+	__u8  bFrameIndex;
+	__u8  bmCapabilities;
+	__u16 wWidth;
+	__u16 wHeight;
+	__u32 dwMinBitRate;
+	__u32 dwMaxBitRate;
+	__u32 dwDefaultFrameInterval;
+	__u8  bFrameIntervalType;
+	__u32 dwBytesPerLine;
+	__u32 dwFrameInterval[];
+} __attribute__((__packed__));
+
+#define UVC_DT_FRAME_FRAMEBASED_SIZE(n)                        (26+4*(n))
+
+#define UVC_FRAME_FRAMEBASED(n) \
+	uvc_frame_framebased_##n
+
+#define DECLARE_UVC_FRAME_FRAMEBASED(n)		\
+struct UVC_FRAME_FRAMEBASED(n) {		\
+	__u8  bLength;				\
+	__u8  bDescriptorType;			\
+	__u8  bDescriptorSubType;		\
+	__u8  bFrameIndex;			\
+	__u8  bmCapabilities;			\
+	__u16 wWidth;				\
+	__u16 wHeight;				\
+	__u32 dwMinBitRate;			\
+	__u32 dwMaxBitRate;			\
+	__u32 dwDefaultFrameInterval;		\
+	__u8  bFrameIntervalType;		\
+	__u32 dwBytesPerLine;			\
+	__u32 dwFrameInterval[n];		\
+} __attribute__ ((packed))
+
 #endif /* __LINUX_USB_VIDEO_H */
 
-- 
2.7.4

