Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91944C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D579208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D579208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389491AbeGJSfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:35:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48248 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388810AbeGJSfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:35:16 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7BF08E78;
        Tue, 10 Jul 2018 18:35:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.17 23/56] drm: Use kvzalloc for allocating blob property memory
Date:   Tue, 10 Jul 2018 20:25:05 +0200
Message-Id: <20180710182504.780939498@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182503.544433950@linuxfoundation.org>
References: <20180710182503.544433950@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michel Dänzer <michel.daenzer@amd.com>

commit 718b5406cd76f1aa6434311241b7febf0e8571ff upstream.

The property size may be controlled by userspace, can be large (I've
seen failure with order 4, i.e. 16 pages / 64 KB) and doesn't need to be
physically contiguous.

Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180629142710.2069-1-michel@daenzer.net
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_property.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/drm_property.c
+++ b/drivers/gpu/drm/drm_property.c
@@ -533,7 +533,7 @@ static void drm_property_free_blob(struc
 
 	drm_mode_object_unregister(blob->dev, &blob->base);
 
-	kfree(blob);
+	kvfree(blob);
 }
 
 /**
@@ -560,7 +560,7 @@ drm_property_create_blob(struct drm_devi
 	if (!length || length > ULONG_MAX - sizeof(struct drm_property_blob))
 		return ERR_PTR(-EINVAL);
 
-	blob = kzalloc(sizeof(struct drm_property_blob)+length, GFP_KERNEL);
+	blob = kvzalloc(sizeof(struct drm_property_blob)+length, GFP_KERNEL);
 	if (!blob)
 		return ERR_PTR(-ENOMEM);
 
@@ -577,7 +577,7 @@ drm_property_create_blob(struct drm_devi
 	ret = __drm_mode_object_add(dev, &blob->base, DRM_MODE_OBJECT_BLOB,
 				    true, drm_property_free_blob);
 	if (ret) {
-		kfree(blob);
+		kvfree(blob);
 		return ERR_PTR(-EINVAL);
 	}
 


