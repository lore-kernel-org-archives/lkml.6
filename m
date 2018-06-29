Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E44C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDFE127F58
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDFE127F58
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755459AbeF2O1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:27:17 -0400
Received: from mail.netline.ch ([148.251.143.178]:44677 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752225AbeF2O1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:27:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 53CA32A6051;
        Fri, 29 Jun 2018 16:27:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Vs6wdnUK9dzf; Fri, 29 Jun 2018 16:27:12 +0200 (CEST)
Received: from kaveri (252.228.127.176.dynamic.wline.res.cust.swisscom.ch [176.127.228.252])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id 6F9AD2A6046;
        Fri, 29 Jun 2018 16:27:11 +0200 (CEST)
Received: from daenzer by kaveri with local (Exim 4.91)
        (envelope-from <michel@daenzer.net>)
        id 1fYuMg-0000Y7-R2; Fri, 29 Jun 2018 16:27:10 +0200
From:   =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: Use kvzalloc for allocating blob property memory
Date:   Fri, 29 Jun 2018 16:27:10 +0200
Message-Id: <20180629142710.2069-1-michel@daenzer.net>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michel Dänzer <michel.daenzer@amd.com>

The property size may be controlled by userspace, can be large (I've
seen failure with order 4, i.e. 16 pages / 64 KB) and doesn't need to be
physically contiguous.

Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
---
 drivers/gpu/drm/drm_property.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
index 1f8031e30f53..cdb10f885a4f 100644
--- a/drivers/gpu/drm/drm_property.c
+++ b/drivers/gpu/drm/drm_property.c
@@ -532,7 +532,7 @@ static void drm_property_free_blob(struct kref *kref)
 
 	drm_mode_object_unregister(blob->dev, &blob->base);
 
-	kfree(blob);
+	kvfree(blob);
 }
 
 /**
@@ -559,7 +559,7 @@ drm_property_create_blob(struct drm_device *dev, size_t length,
 	if (!length || length > ULONG_MAX - sizeof(struct drm_property_blob))
 		return ERR_PTR(-EINVAL);
 
-	blob = kzalloc(sizeof(struct drm_property_blob)+length, GFP_KERNEL);
+	blob = kvzalloc(sizeof(struct drm_property_blob)+length, GFP_KERNEL);
 	if (!blob)
 		return ERR_PTR(-ENOMEM);
 
@@ -576,7 +576,7 @@ drm_property_create_blob(struct drm_device *dev, size_t length,
 	ret = __drm_mode_object_add(dev, &blob->base, DRM_MODE_OBJECT_BLOB,
 				    true, drm_property_free_blob);
 	if (ret) {
-		kfree(blob);
+		kvfree(blob);
 		return ERR_PTR(-EINVAL);
 	}
 
-- 
2.18.0

