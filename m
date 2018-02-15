Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2178418-1518720062-2-365866075416733612
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720061; b=NDLedqplNkzdNpUy8OKvPXPrf1KV+0JXxs+zgDCJLNroS/w
    G5n55i48NkAljh9w20hc4wMbpOrmMa4ya08e5sEWYedZ287VhIsH7V++ISxV8RrY
    r1PFdQA7Za39CAleLsqWgmvtiUqAmRJl/A5Jt3CcXWJZUxjZczluq5+UTkqAytRP
    er7GTwqvcIbQhGjEh3a38FZpdYGm7LKLMjtmdSKWKJktB6nL8wauJafzc+arfvRi
    6JtvuZEH1HUloE/Z2z4ArQEbkmNtzgD48CAlL09tRbzw7UPpfzE7VJPijyBqgD84
    rkzmm3dvEJQIXQJ+QroNerCP53RVwPqSHw8Ifow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720061; bh=h33NF49W0ArvjsGglEWmh6a6YS
    G/tEx6k+iWUpSQhdo=; b=HxaWzRNmkK5dEYpBn4T1GBlgF3MVxubHWW8Wpy8id7
    iOqQITSlIcckJ6yNUu1if7MKi9CiASpi56fpMtjaIxIcaQg8ERl4UB4kGj70saxO
    iJNg8nalQ6s5UxaiyYlTpVoFs5+ovE0ikFIfC5FToIhe0MJEx37m3uMNPFUPyyTU
    ECIy2TJzgyg3XHTOMEx+V0ca73dmddeuhesOR2hYGaKIxL5Z+PjJmqI6iy08+pyB
    lgOTpYCeBmH3Q+/PoVcZ8HojgUEWLF6fAKTccoGdc703VCUYQGfIx3af0GdXLw3A
    LfwKXxJ5A0K0/WFo773OcPlRWPFXsVk8/HR2wTbG9mLQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162840AbeBOSk3 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:40:29 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51584 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162755AbeBOPXs (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:23:48 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.4 075/108] media: v4l2-compat-ioctl32.c: move helper functions to __get/put_v4l2_format32
Date: Thu, 15 Feb 2018 16:17:12 +0100
Message-Id: <20180215151232.742005560@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 486c521510c44a04cd756a9267e7d1e271c8a4ba upstream.

These helper functions do not really help. Move the code to the
__get/put_v4l2_format32 functions.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |  104 +++++---------------------
 1 file changed, 20 insertions(+), 84 deletions(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -89,78 +89,6 @@ static int put_v4l2_window32(struct v4l2
 	return 0;
 }
 
-static inline int get_v4l2_pix_format(struct v4l2_pix_format *kp, struct v4l2_pix_format __user *up)
-{
-	if (copy_from_user(kp, up, sizeof(struct v4l2_pix_format)))
-		return -EFAULT;
-	return 0;
-}
-
-static inline int get_v4l2_pix_format_mplane(struct v4l2_pix_format_mplane *kp,
-					     struct v4l2_pix_format_mplane __user *up)
-{
-	if (copy_from_user(kp, up, sizeof(struct v4l2_pix_format_mplane)))
-		return -EFAULT;
-	return 0;
-}
-
-static inline int put_v4l2_pix_format(struct v4l2_pix_format *kp, struct v4l2_pix_format __user *up)
-{
-	if (copy_to_user(up, kp, sizeof(struct v4l2_pix_format)))
-		return -EFAULT;
-	return 0;
-}
-
-static inline int put_v4l2_pix_format_mplane(struct v4l2_pix_format_mplane *kp,
-					     struct v4l2_pix_format_mplane __user *up)
-{
-	if (copy_to_user(up, kp, sizeof(struct v4l2_pix_format_mplane)))
-		return -EFAULT;
-	return 0;
-}
-
-static inline int get_v4l2_vbi_format(struct v4l2_vbi_format *kp, struct v4l2_vbi_format __user *up)
-{
-	if (copy_from_user(kp, up, sizeof(struct v4l2_vbi_format)))
-		return -EFAULT;
-	return 0;
-}
-
-static inline int put_v4l2_vbi_format(struct v4l2_vbi_format *kp, struct v4l2_vbi_format __user *up)
-{
-	if (copy_to_user(up, kp, sizeof(struct v4l2_vbi_format)))
-		return -EFAULT;
-	return 0;
-}
-
-static inline int get_v4l2_sliced_vbi_format(struct v4l2_sliced_vbi_format *kp, struct v4l2_sliced_vbi_format __user *up)
-{
-	if (copy_from_user(kp, up, sizeof(struct v4l2_sliced_vbi_format)))
-		return -EFAULT;
-	return 0;
-}
-
-static inline int put_v4l2_sliced_vbi_format(struct v4l2_sliced_vbi_format *kp, struct v4l2_sliced_vbi_format __user *up)
-{
-	if (copy_to_user(up, kp, sizeof(struct v4l2_sliced_vbi_format)))
-		return -EFAULT;
-	return 0;
-}
-
-static inline int get_v4l2_sdr_format(struct v4l2_sdr_format *kp, struct v4l2_sdr_format __user *up)
-{
-	if (copy_from_user(kp, up, sizeof(struct v4l2_sdr_format)))
-		return -EFAULT;
-	return 0;
-}
-
-static inline int put_v4l2_sdr_format(struct v4l2_sdr_format *kp, struct v4l2_sdr_format __user *up)
-{
-	if (copy_to_user(up, kp, sizeof(struct v4l2_sdr_format)))
-		return -EFAULT;
-	return 0;
-}
-
 struct v4l2_format32 {
 	__u32	type;	/* enum v4l2_buf_type */
 	union {
@@ -199,23 +127,27 @@ static int __get_v4l2_format32(struct v4
 	switch (kp->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
-		return get_v4l2_pix_format(&kp->fmt.pix, &up->fmt.pix);
+		return copy_from_user(&kp->fmt.pix, &up->fmt.pix,
+				      sizeof(kp->fmt.pix)) ? -EFAULT : 0;
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
-		return get_v4l2_pix_format_mplane(&kp->fmt.pix_mp,
-						  &up->fmt.pix_mp);
+		return copy_from_user(&kp->fmt.pix_mp, &up->fmt.pix_mp,
+				      sizeof(kp->fmt.pix_mp)) ? -EFAULT : 0;
 	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY:
 		return get_v4l2_window32(&kp->fmt.win, &up->fmt.win);
 	case V4L2_BUF_TYPE_VBI_CAPTURE:
 	case V4L2_BUF_TYPE_VBI_OUTPUT:
-		return get_v4l2_vbi_format(&kp->fmt.vbi, &up->fmt.vbi);
+		return copy_from_user(&kp->fmt.vbi, &up->fmt.vbi,
+				      sizeof(kp->fmt.vbi)) ? -EFAULT : 0;
 	case V4L2_BUF_TYPE_SLICED_VBI_CAPTURE:
 	case V4L2_BUF_TYPE_SLICED_VBI_OUTPUT:
-		return get_v4l2_sliced_vbi_format(&kp->fmt.sliced, &up->fmt.sliced);
+		return copy_from_user(&kp->fmt.sliced, &up->fmt.sliced,
+				      sizeof(kp->fmt.sliced)) ? -EFAULT : 0;
 	case V4L2_BUF_TYPE_SDR_CAPTURE:
 	case V4L2_BUF_TYPE_SDR_OUTPUT:
-		return get_v4l2_sdr_format(&kp->fmt.sdr, &up->fmt.sdr);
+		return copy_from_user(&kp->fmt.sdr, &up->fmt.sdr,
+				      sizeof(kp->fmt.sdr)) ? -EFAULT : 0;
 	default:
 		pr_info("compat_ioctl32: unexpected VIDIOC_FMT type %d\n",
 			kp->type);
@@ -246,23 +178,27 @@ static int __put_v4l2_format32(struct v4
 	switch (kp->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
-		return put_v4l2_pix_format(&kp->fmt.pix, &up->fmt.pix);
+		return copy_to_user(&up->fmt.pix, &kp->fmt.pix,
+				    sizeof(kp->fmt.pix)) ? -EFAULT : 0;
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
-		return put_v4l2_pix_format_mplane(&kp->fmt.pix_mp,
-						  &up->fmt.pix_mp);
+		return copy_to_user(&up->fmt.pix_mp, &kp->fmt.pix_mp,
+				    sizeof(kp->fmt.pix_mp)) ? -EFAULT : 0;
 	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY:
 		return put_v4l2_window32(&kp->fmt.win, &up->fmt.win);
 	case V4L2_BUF_TYPE_VBI_CAPTURE:
 	case V4L2_BUF_TYPE_VBI_OUTPUT:
-		return put_v4l2_vbi_format(&kp->fmt.vbi, &up->fmt.vbi);
+		return copy_to_user(&up->fmt.vbi, &kp->fmt.vbi,
+				    sizeof(kp->fmt.vbi)) ? -EFAULT : 0;
 	case V4L2_BUF_TYPE_SLICED_VBI_CAPTURE:
 	case V4L2_BUF_TYPE_SLICED_VBI_OUTPUT:
-		return put_v4l2_sliced_vbi_format(&kp->fmt.sliced, &up->fmt.sliced);
+		return copy_to_user(&up->fmt.sliced, &kp->fmt.sliced,
+				    sizeof(kp->fmt.sliced)) ? -EFAULT : 0;
 	case V4L2_BUF_TYPE_SDR_CAPTURE:
 	case V4L2_BUF_TYPE_SDR_OUTPUT:
-		return put_v4l2_sdr_format(&kp->fmt.sdr, &up->fmt.sdr);
+		return copy_to_user(&up->fmt.sdr, &kp->fmt.sdr,
+				    sizeof(kp->fmt.sdr)) ? -EFAULT : 0;
 	default:
 		pr_info("compat_ioctl32: unexpected VIDIOC_FMT type %d\n",
 			kp->type);
