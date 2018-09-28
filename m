Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B6CC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F5C20676
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KCoVJYwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F5C20676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbeI1VFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:05:40 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:41688 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeI1VFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:05:40 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id A0F0B10C004C;
        Fri, 28 Sep 2018 07:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1538145694; bh=4IerRvNCRoBUloaYVlCmS3x8cTKmn1sVeG2yKTlk2tQ=;
        h=From:To:Cc:Subject:Date:From;
        b=KCoVJYwIScgvWftCNEy/r5ft9v96znLbLfVEl0RoqNsjVTg8HO0jheYy79fcch1XF
         YnCC1zLWC3G7G947xTieTOUIqKcHdz/jMfyIcK1FQ/7lFsZa3VOacGRNPgEPxnkSw+
         MSVQDdo9odkuslewlxeMzv/PFMUA+1/Wzw5aVqsYOv0jTPBMod+c6G3sjn/7tmtnve
         jyzGKHc/Ph+sjBdKXryroSXiuJguGjnWdem1GPST1eEHexOpV7lGIXwbU2Q3UZqVH2
         9O20WQQX95FbmBKBcyb9jZ9DYgRSIdpqwDk6gxAYOaCbiQ9+8Jbk6n5G7aUfK8P3ot
         MrxPLTqkdiU1w==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.38])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9CAF35578;
        Fri, 28 Sep 2018 07:41:29 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        stable@vger.kernel.org,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] DRM: UDL: get rid of useless vblank initialization
Date:   Fri, 28 Sep 2018 17:41:26 +0300
Message-Id: <20180928144126.21598-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UDL doesn't support vblank functionality so we don't need to
initialize vblank here (we are able to send page flip
completion events even without vblank initialization)

Moreover current drm_vblank_init call with num_crtcs > 0 causes
sending DRM_EVENT_FLIP_COMPLETE event with zero timestamp every
time. This breaks userspace apps (for example weston) which
relies on timestamp value.

Cc: stable@vger.kernel.org
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 drivers/gpu/drm/udl/udl_main.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index f455f095a146..1b014d92855b 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -350,15 +350,10 @@ int udl_driver_load(struct drm_device *dev, unsigned long flags)
 	if (ret)
 		goto err;
 
-	ret = drm_vblank_init(dev, 1);
-	if (ret)
-		goto err_fb;
-
 	drm_kms_helper_poll_init(dev);
 
 	return 0;
-err_fb:
-	udl_fbdev_cleanup(dev);
+
 err:
 	if (udl->urbs.count)
 		udl_free_urb_list(dev);
-- 
2.14.4

