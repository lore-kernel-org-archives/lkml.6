Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2388AC4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850AF206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lekensteyn.nl header.i=@lekensteyn.nl header.b="MBBHoXAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850AF206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lekensteyn.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeIGCzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 22:55:53 -0400
Received: from lekensteyn.nl ([178.21.112.251]:43855 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728089AbeIGCzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 22:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2015-q1;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=MFbflLwNRU5WISREwEFNq/SoarHy9028ZMj0YzXF0MU=;
        b=MBBHoXAO+B/5pwf8jSKkvqnWjumaxyxebZ1mGrLVACLc/rFp/EylFfpzuSKd+P1RGGee7srVKgamjh0cp4vvntMolaGus2ts2Bl5xr0nhUE4bMBCBpklSzrMS8LITgO3IhtKgomnaeuscCEPACgYu4H1DH/NEBeAGZRqmrwameW7ztC8LyQRqTlV+L56RNjJ2g5SAattUqJcjHUJ7/2R4Ig8+pOQc7lEu14SqAjzO3VohfFZa9oNnXMgAtYaOEk1hqyZVwjdp/mx0bsuQhA5FBOiQtlLy5xk5O/VAX9on2O7pKKuDhosjdaiM7UM3967srzu1oyyftfqZJ9pMlXajA==;
Received: by lekensteyn.nl with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <peter@lekensteyn.nl>)
        id 1fy2bM-0005Us-DR; Fri, 07 Sep 2018 00:18:12 +0200
From:   Peter Wu <peter@lekensteyn.nl>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] bochs: use drm_fb_helper_set_suspend_unlocked in suspend/resume
Date:   Fri,  7 Sep 2018 00:18:07 +0200
Message-Id: <20180906221810.20170-2-peter@lekensteyn.nl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180906221810.20170-1-peter@lekensteyn.nl>
References: <20180906221810.20170-1-peter@lekensteyn.nl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "initialized" member is going away. suspend/resume still works (even
if bochsfb_create is forced to fail).

Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
 drivers/gpu/drm/bochs/bochs_drv.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index c61b40c72b62..0e79d9acf89e 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -107,11 +107,7 @@ static int bochs_pm_suspend(struct device *dev)
 
 	drm_kms_helper_poll_disable(drm_dev);
 
-	if (bochs->fb.initialized) {
-		console_lock();
-		drm_fb_helper_set_suspend(&bochs->fb.helper, 1);
-		console_unlock();
-	}
+	drm_fb_helper_set_suspend_unlocked(&bochs->fb.helper, 1);
 
 	return 0;
 }
@@ -124,11 +120,7 @@ static int bochs_pm_resume(struct device *dev)
 
 	drm_helper_resume_force_mode(drm_dev);
 
-	if (bochs->fb.initialized) {
-		console_lock();
-		drm_fb_helper_set_suspend(&bochs->fb.helper, 0);
-		console_unlock();
-	}
+	drm_fb_helper_set_suspend_unlocked(&bochs->fb.helper, 0);
 
 	drm_kms_helper_poll_enable(drm_dev);
 	return 0;
-- 
2.18.0

