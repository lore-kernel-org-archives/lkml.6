Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC5AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E701120664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tC4ix4sq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E701120664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbeKAIr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:47:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728528AbeKAIHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:07:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C84C20830;
        Wed, 31 Oct 2018 23:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027219;
        bh=FYBFqrhVinhdRvVhAnfmN693wT2oKuIZIHlbaLGu2qE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tC4ix4sqvOfMDC5dYjoXVJYhOtD520wIpGlChVvY10X6giA3GNZktCJy4gPieqJ96
         Q75X2Jovofw/oDHa1FIyJ4vGr9psogBkHvqytW7Usvck1GPVUhHE7wU2HNueKiifYC
         uUk6VG1QRcw8mYjlGtxD443k8uSjx6v5IX6dCl7M=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 084/146] thermal: da9062/61: Prevent hardware access during system suspend
Date:   Wed, 31 Oct 2018 19:04:39 -0400
Message-Id: <20181031230541.28822-84-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 760eea43f8c6d48684f1f34b8a02fddc1456e849 ]

The workqueue used for monitoring the hardware may run while the device
is already suspended.  Fix this by using the freezable system workqueue
instead, cfr. commit 51e20d0e3a60cf46 ("thermal: Prevent polling from
happening during system suspend").

Fixes: 608567aac3206ae8 ("thermal: da9062/61: Thermal junction temperature monitoring driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/da9062-thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index dd8dd947b7f0..01b0cb994457 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -106,7 +106,7 @@ static void da9062_thermal_poll_on(struct work_struct *work)
 					   THERMAL_EVENT_UNSPECIFIED);
 
 		delay = msecs_to_jiffies(thermal->zone->passive_delay);
-		schedule_delayed_work(&thermal->work, delay);
+		queue_delayed_work(system_freezable_wq, &thermal->work, delay);
 		return;
 	}
 
@@ -125,7 +125,7 @@ static irqreturn_t da9062_thermal_irq_handler(int irq, void *data)
 	struct da9062_thermal *thermal = data;
 
 	disable_irq_nosync(thermal->irq);
-	schedule_delayed_work(&thermal->work, 0);
+	queue_delayed_work(system_freezable_wq, &thermal->work, 0);
 
 	return IRQ_HANDLED;
 }
-- 
2.17.1

