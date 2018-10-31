Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174C5ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C740520664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeVT6spJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C740520664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbeKAIfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:35:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728699AbeKAIJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C5DA2064C;
        Wed, 31 Oct 2018 23:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027341;
        bh=FYBFqrhVinhdRvVhAnfmN693wT2oKuIZIHlbaLGu2qE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AeVT6spJTd244ku/9DVe1eqVGfLuGAGH1xdc4WQEpHDOVunHtccoq3BPE7VEUodqj
         hyL2SYyQde7SO3eti2hyhYM3PdMNgg6eIHQerFJq3dOK8EVCNO5xB70OgAOW4nghNZ
         LnKe8u8pBxavlvdUJo50QMTY7yjnGu2CRi7Dl01s=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 073/126] thermal: da9062/61: Prevent hardware access during system suspend
Date:   Wed, 31 Oct 2018 19:07:01 -0400
Message-Id: <20181031230754.29029-73-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
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

