Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F55C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BA6223D8
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MG7QnWa5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7BA6223D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388476AbeKLIUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:20:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388413AbeKLIUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:11 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71CC021780;
        Sun, 11 Nov 2018 22:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975415;
        bh=dHemJprAOqXoQM2yrHmwjPYu6caS1GcnNs8zLlxdxbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MG7QnWa57bbKGS4SJbnI6AZHBe1mKh5jyToFXIE8eHpPpo5Z+yLBSa9hlvmKcgdiq
         IWaDItBEbaNcB3SfMHH3bzFT2lw6QVcPZ3uR8fVes23Z3GQpgiMSM/u3xiYriSsJVS
         e2T+UoDz/GpcEsGEQ9NrxUt/brHpUIJjFdFuj9nI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 134/350] thermal: da9062/61: Prevent hardware access during system suspend
Date:   Sun, 11 Nov 2018 14:19:58 -0800
Message-Id: <20181111221713.590171847@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thermal/da9062-thermal.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -106,7 +106,7 @@ static void da9062_thermal_poll_on(struc
 					   THERMAL_EVENT_UNSPECIFIED);
 
 		delay = msecs_to_jiffies(thermal->zone->passive_delay);
-		schedule_delayed_work(&thermal->work, delay);
+		queue_delayed_work(system_freezable_wq, &thermal->work, delay);
 		return;
 	}
 
@@ -125,7 +125,7 @@ static irqreturn_t da9062_thermal_irq_ha
 	struct da9062_thermal *thermal = data;
 
 	disable_irq_nosync(thermal->irq);
-	schedule_delayed_work(&thermal->work, 0);
+	queue_delayed_work(system_freezable_wq, &thermal->work, 0);
 
 	return IRQ_HANDLED;
 }


