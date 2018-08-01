Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67299C46467
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20696208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20696208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbeHAXC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:02:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbeHAXC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:02:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 869B640241D5;
        Wed,  1 Aug 2018 21:15:16 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 363862026D68;
        Wed,  1 Aug 2018 21:15:16 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Lukas Wunner <lukas@wunner.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, stable@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/8] drm/nouveau: Enable polling even if we have runtime PM
Date:   Wed,  1 Aug 2018 17:14:52 -0400
Message-Id: <20180801211459.7731-3-lyude@redhat.com>
In-Reply-To: <20180801211459.7731-1-lyude@redhat.com>
References: <20180801211459.7731-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 01 Aug 2018 21:15:16 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 01 Aug 2018 21:15:16 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having runtime PM makes no difference on whether or not we want polling,
and it's now safe to just enable polling unconditionally in drm_load()
thanks to d61a5c106351 ("drm/nouveau: Fix deadlock on runtime suspend")

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 5fdc1fbe2ee5..ee2546db09c9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -592,10 +592,11 @@ nouveau_drm_load(struct drm_device *dev, unsigned long flags)
 		pm_runtime_allow(dev->dev);
 		pm_runtime_mark_last_busy(dev->dev);
 		pm_runtime_put(dev->dev);
-	} else {
-		/* enable polling for external displays */
-		drm_kms_helper_poll_enable(dev);
 	}
+
+	/* enable polling for connectors without hpd */
+	drm_kms_helper_poll_enable(dev);
+
 	return 0;
 
 fail_dispinit:
-- 
2.17.1

