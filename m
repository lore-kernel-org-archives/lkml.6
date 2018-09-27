Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E15C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB217215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB217215E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbeI0Rus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:50:48 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:46934 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbeI0Rui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:50:38 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id gbYj1y00P3XaVaC06bYjZC; Thu, 27 Sep 2018 13:32:47 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1g5UXD-0001Sj-PM; Thu, 27 Sep 2018 13:32:43 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1g5UXD-0007uQ-OM; Thu, 27 Sep 2018 13:32:43 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] thermal: rcar_thermal: Prevent hardware access during system suspend
Date:   Thu, 27 Sep 2018 13:32:33 +0200
Message-Id: <20180927113235.30354-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180927113235.30354-1-geert+renesas@glider.be>
References: <20180927113235.30354-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On r8a7791/koelsch, sometimes the following message is printed during
system suspend:

    rcar_thermal e61f0000.thermal: thermal sensor was broken

This happens if the workqueue runs while the device is already
suspended.  Fix this by using the freezable system workqueue instead,
cfr. commit 51e20d0e3a60cf46 ("thermal: Prevent polling from happening
during system suspend").

Fixes: e0a5172e9eec7f0d ("thermal: rcar: add interrupt support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/thermal/rcar_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 78f932822d381c9d..ea132e122b174757 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -434,8 +434,8 @@ static irqreturn_t rcar_thermal_irq(int irq, void *data)
 	rcar_thermal_for_each_priv(priv, common) {
 		if (rcar_thermal_had_changed(priv, status)) {
 			rcar_thermal_irq_disable(priv);
-			schedule_delayed_work(&priv->work,
-					      msecs_to_jiffies(300));
+			queue_delayed_work(system_freezable_wq, &priv->work,
+					   msecs_to_jiffies(300));
 		}
 	}
 
-- 
2.17.1

