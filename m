Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC16C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8772173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QaFiAqsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8772173F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbeHCNkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 09:40:05 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:51850 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbeHCNkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 09:40:05 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180803114406epoutp044281d25ac58f46c590a4fb96fd389dd4~HXS0TV8Fh3114031140epoutp04W
        for <linux-kernel@vger.kernel.org>; Fri,  3 Aug 2018 11:44:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180803114406epoutp044281d25ac58f46c590a4fb96fd389dd4~HXS0TV8Fh3114031140epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533296646;
        bh=63fcJ9sVin9e9wt84gwljiEEDFPi/g6ArEHBK3VRNK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QaFiAqsJIqGq9F+5nzMmAvMTWfAMcXTxma32M93pWqhnlVb51fXrxyl4LmdihOiu5
         s1cSzubICKc15tqmHVefL84Z5wdHf5rH6T5CJ5iNrMu+jmFq1lHmOVxiqY4HBosw0V
         LpzOUQQ3KzEC1cIvJ6HiSg37DA7DGVNncC1IPLo8=
Received: from epsmges5p2new.samsung.com (unknown [182.195.40.195]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20180803114405epcas5p196da73ce4166e889c010e12fb1a2a017~HXSzRHG551943319433epcas5p18;
        Fri,  3 Aug 2018 11:44:05 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FC.7B.04309.500446B5; Fri,  3 Aug 2018 20:44:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20180803114404epcas5p1c5aaec7ca27e520b5cba52b0d7f09124~HXSyqLTJ81698916989epcas5p1G;
        Fri,  3 Aug 2018 11:44:04 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180803114404epsmtrp2905815bc5599ca51d8494a8007cad782~HXSyo3h9s1489414894epsmtrp2b;
        Fri,  3 Aug 2018 11:44:04 +0000 (GMT)
X-AuditID: b6c32a4a-9cbff700000010d5-25-5b6440052bc1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BB.3E.03889.400446B5; Fri,  3 Aug 2018 20:44:04 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.161.94]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180803114402epsmtip267acf64e223f5cbec9a318197d5649d4~HXSwrwSEW1260212602epsmtip2R;
        Fri,  3 Aug 2018 11:44:02 +0000 (GMT)
From:   Satendra Singh Thakur <satendra.t@samsung.com>
To:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     vineet.j@samsung.com, hemanshu.s@samsung.com, sst2005@gmail.com,
        Satendra Singh Thakur <satendra.t@samsung.com>
Subject: [PATCH v1] drm/kms/crtc: Improving the func drm_mode_setcrtc
Date:   Fri,  3 Aug 2018 17:13:34 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <66ead941-3c64-45e4-7835-949360e2b01f@linux.intel.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfUgTYRzu3d22c7Q8Ztab1LBLoSR1t5pepSWZcZTE+iJoxTzmm0r7sLvN
        sg9YZeUUIzNKl32DUdKXZaVl5SRTalYW1aBoVGBJ3yujjOrmTfrrffg9H+/Djx+BaX7I44gi
        uxPxds5KKVT45Y4pk5PlWfkm3c5XKqaqp1vGPP7+ScG0BFuVTP/99xjzqLVewRz70owzZ+7v
        wJkX5/2AOXn3KcZ0Nvcqs1TsQfdDnG3xvlCyVwaCcvZw92L2ZeUdGduyt03G7r50GrChJq2R
        WIkyChGXj/h4ZLc48ovsBZnUwqXmbLMhTUcn0zOYdCreztlQJjUv15g8v8gqdqTiSzirSxwZ
        OUGgUmdn8A6XE8UXOgRnJmWiaX0KrUtP0evF17B6pt4gSvJQ4fN2VXFv0obO8jrMDR5NrABR
        BCSnw/fnQqACqAgNeQ1Az8UyPExoyK8A3n5tlIgBAL+0tcuGHVd/PcElog3A3Q3HI45vANb/
        5cNYIYr66mvlYdFo8h2AgbJ78jCBkS4YDGzDwjiGzIFv3h1UhjFOJkJvV0gu/aCFgR7PkCaK
        zIb9J8qwcBAkuxSwa1doyKAmS+CFrT6lZJgHjzR7cQnHwP47lyLzOBj62KaQcA2A2/2LpKBG
        AP0PqyKiObBs3y3RTIjtpsBzralS0VGwavCNLDyGpBqW79RI6gR46m0HNhz/+2hFpDMLAzf6
        I1vZD2C1/4BsD5jg/Z96FIDTYBwqFmwFSDAU6+1ofYrA2QSXvSDF4rA1gaGjS1pwFTT05PoA
        SQBqpPpBosWkkXMlQqnNByCBUaPVHzziSJ3PlW5EvMPMu6xI8AGDuMFqLC7W4hBP2O400wZ9
        Wppuhs4wjUmjqbHqz4uWmjRkAedEaxEqRvywT0ZExbnBibPrmv7QngfePY7NDc8/Bd2D67X8
        tVzvb3UC3ng9RuWxDC539C6LdqtXJEQVJYzx5ZQ8WzP+la/e0H3I5JyEKrWzlvi1a2sTTRVz
        p9ZNfGveJI+tybv91NjXWL71Jp0aHLElvXpTS0+fgsuK7VzVkfxTkZhRE71waqB2zrbxVobC
        hUKOTsJ4gfsHcGEc9ooDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsWy7bCSvC6LQ0q0QfN6SYvecyeZLK58fc9m
        sfPBLnaLV+ffMFtc3jWHzWLhx60sFmvPt7JY3N1wltFi+enrzBbHtl5id+DymN1wkcVj56y7
        7B7bvz1g9Zh3MtDjfvdxJo+dk/YyefRtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfGnYNcBZe0
        Ko51zGRuYLys2MXIySEhYCKx49c1li5GLg4hgd2MEsfmH2CDSEhJLHuzDcoWllj57zk7RNEn
        RonfnyaxgCTYgLqfz5nBCpIQEXjLKNG68zRYglmgUuLc88mMILawgKvEk5ez2UFsFgFViVkn
        PrOC2LwCbhKN16+xQ2yQk7h5rpMZxOYUcJZ4tbgFzBYScJJ4NfEU+wRGvgWMDKsYJVMLinPT
        c4sNC4zyUsv1ihNzi0vz0vWS83M3MYIDVktrB+OJE/GHGAU4GJV4eC+oJkcLsSaWFVfmHmKU
        4GBWEuF92wkU4k1JrKxKLcqPLyrNSS0+xCjNwaIkziuffyxSSCA9sSQ1OzW1ILUIJsvEwSnV
        wMi3551xH2v2Ecdci1lXxCX3XTY+VdB/6sbSoBXrxYq+cNp1HVGIOrTJ+dF0bZ/fgnKeaXFP
        xHrmO13Q/1Ngf3p56eOTjG+OrFlvs7sgU8Dqnqz+n6t5S4pCxT3TPPtX9+i+Oxh/7p/0KbUH
        n1Y7bxfTvdNsXfEjaPEek8m7PgXs782Xcbt5IlSJpTgj0VCLuag4EQDiA+ysVAIAAA==
Message-Id: <20180803114404epcas5p1c5aaec7ca27e520b5cba52b0d7f09124~HXSyqLTJ81698916989epcas5p1G@epcas5p1.samsung.com>
X-CMS-MailID: 20180803114404epcas5p1c5aaec7ca27e520b5cba52b0d7f09124
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180803114404epcas5p1c5aaec7ca27e520b5cba52b0d7f09124
References: <66ead941-3c64-45e4-7835-949360e2b01f@linux.intel.com>
        <CGME20180803114404epcas5p1c5aaec7ca27e520b5cba52b0d7f09124@epcas5p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following changes are done to this func:
1. The declaration of plane and it's assignment plane = crtc->primary
are only used when mode_valid is set. Therefore, moved it inside
the if(mode_valid) statement.

2. The declaration of connector and set_connectors_ptr and out_id
are moved inside the for loop, as their scope is limited within
that block.

3. Currently, there are 3 checks on count_connectors
and 4 checks on mode related params (mode_valid, mode, fb).
if (crtc_req->mode_valid) {
if (crtc_req->count_connectors == 0 && mode) {
if (crtc_req->count_connectors > 0 && (!mode || !fb)) {
if (crtc_req->count_connectors > 0) {

In the modified code, there are just 1 check on mode_valid and
2 checks  count_connectors.
Checks on mode and fb are not needed as these variables will
be non-NULL by the end of if(mode_valid) statement if mode_valid is set.
If mode_valid is clear, mode and fb will be NULL.
Therefore, we just check mode_valid and NOT mode or fb.

4. Moved kfree inside if statement

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>

---
 
 v1: Hi Mr Maarten, Thanks for the comments.
     I have fixed some of them and done more modifications to the patch.
     Please review.

 drivers/gpu/drm/drm_crtc.c | 57 ++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 98a36e6..9842985 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -559,12 +559,10 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 	struct drm_mode_config *config = &dev->mode_config;
 	struct drm_mode_crtc *crtc_req = data;
 	struct drm_crtc *crtc;
-	struct drm_plane *plane;
-	struct drm_connector **connector_set = NULL, *connector;
+	struct drm_connector **connector_set = NULL;
 	struct drm_framebuffer *fb = NULL;
 	struct drm_display_mode *mode = NULL;
 	struct drm_mode_set set;
-	uint32_t __user *set_connectors_ptr;
 	struct drm_modeset_acquire_ctx ctx;
 	int ret;
 	int i;
@@ -586,7 +584,6 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 	}
 	DRM_DEBUG_KMS("[CRTC:%d:%s]\n", crtc->base.id, crtc->name);
 
-	plane = crtc->primary;
 
 	mutex_lock(&crtc->dev->mode_config.mutex);
 	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
@@ -596,6 +593,8 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 		goto out;
 
 	if (crtc_req->mode_valid) {
+		struct drm_plane *plane = crtc->primary;
+		/* Handle framebuffer and mode here*/
 		/* If we have a mode we need a framebuffer. */
 		/* If we pass -1, set the mode with the currently bound fb */
 		if (crtc_req->fb_id == -1) {
@@ -636,8 +635,6 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 			ret = -EINVAL;
 			goto out;
 		}
-
-
 		ret = drm_mode_convert_umode(dev, mode, &crtc_req->mode);
 		if (ret) {
 			DRM_DEBUG_KMS("Invalid mode\n");
@@ -669,31 +666,22 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 					      mode, fb);
 		if (ret)
 			goto out;
-
-	}
-
-	if (crtc_req->count_connectors == 0 && mode) {
-		DRM_DEBUG_KMS("Count connectors is 0 but mode set\n");
-		ret = -EINVAL;
-		goto out;
-	}
-
-	if (crtc_req->count_connectors > 0 && (!mode || !fb)) {
-		DRM_DEBUG_KMS("Count connectors is %d but no mode or fb set\n",
-			  crtc_req->count_connectors);
-		ret = -EINVAL;
-		goto out;
-	}
-
-	if (crtc_req->count_connectors > 0) {
-		u32 out_id;
-
+		/* Handle connector here
+		 * crtc_req->mode_valid is set at this point
+		 * and we have mode and fb non-NULL.
+		 * We have already checked mode_valid
+		 * hence, we don't check mode and fb here.
+		 */
+		if (!crtc_req->count_connectors) {
+			DRM_DEBUG_KMS("Mode_valid flag is set but connectors' count is 0\n");
+			ret = -EINVAL;
+			goto out;
+		}
 		/* Avoid unbounded kernel memory allocation */
 		if (crtc_req->count_connectors > config->num_connector) {
 			ret = -EINVAL;
 			goto out;
 		}
-
 		connector_set = kmalloc_array(crtc_req->count_connectors,
 					      sizeof(struct drm_connector *),
 					      GFP_KERNEL);
@@ -703,6 +691,9 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 		}
 
 		for (i = 0; i < crtc_req->count_connectors; i++) {
+			struct drm_connector *connector;
+			uint32_t __user *set_connectors_ptr;
+			u32 out_id;
 			connector_set[i] = NULL;
 			set_connectors_ptr = (uint32_t __user *)(unsigned long)crtc_req->set_connectors_ptr;
 			if (get_user(out_id, &set_connectors_ptr[i])) {
@@ -723,6 +714,18 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 
 			connector_set[i] = connector;
 		}
+
+	} else {
+		/* crtc_req->mode_valid is clear at this point
+		 * if mode_valid is clear, mode and fb will be NULL
+		 * hence, we don't check mode and fb here.
+		 */
+		if (crtc_req->count_connectors) {
+			DRM_DEBUG_KMS("Connectors's count is %u but mode_valid flag is clear\n",
+			crtc_req->count_connectors);
+			ret = -EINVAL;
+			goto out;
+		}
 	}
 
 	set.crtc = crtc;
@@ -743,8 +746,8 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 			if (connector_set[i])
 				drm_connector_put(connector_set[i]);
 		}
+		kfree(connector_set);
 	}
-	kfree(connector_set);
 	drm_mode_destroy(dev, mode);
 	if (ret == -EDEADLK) {
 		ret = drm_modeset_backoff(&ctx);
-- 
2.7.4

