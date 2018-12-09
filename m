Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F85FC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1ED420661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1ED420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbeLIW1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:27:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34706 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726393AbeLIVzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:12 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72b-0002iY-Ln; Sun, 09 Dec 2018 21:55:09 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Z-0003Ek-41; Sun, 09 Dec 2018 21:55:07 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Vignesh R" <vigneshr@ti.com>,
        "Thierry Reding" <thierry.reding@gmail.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.895035047@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 033/328] pwm: tiehrpwm: Don't use emulation mode bits
 to control PWM output
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Vignesh R <vigneshr@ti.com>

commit aa49d628f6e016bcec8c6f8e704b9b18ee697329 upstream.

As per AM335x TRM SPRUH73P "15.2.2.11 ePWM Behavior During Emulation",
TBCTL[15:14] only have effect during emulation suspend events (IOW,
to stop PWM when debugging using a debugger). These bits have no effect
on PWM output during normal running of system. Hence, remove code
accessing these bits as they have no role in enabling/disabling PWMs.

Fixes: 19891b20e7c2 ("pwm: pwm-tiehrpwm: PWM driver support for EHRPWM")
Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -35,10 +35,6 @@
 #define TBCTL			0x00
 #define TBPRD			0x0A
 
-#define TBCTL_RUN_MASK		(BIT(15) | BIT(14))
-#define TBCTL_STOP_NEXT		0
-#define TBCTL_STOP_ON_CYCLE	BIT(14)
-#define TBCTL_FREE_RUN		(BIT(15) | BIT(14))
 #define TBCTL_PRDLD_MASK	BIT(3)
 #define TBCTL_PRDLD_SHDW	0
 #define TBCTL_PRDLD_IMDT	BIT(3)
@@ -357,7 +353,7 @@ static int ehrpwm_pwm_enable(struct pwm_
 	/* Channels polarity can be configured from action qualifier module */
 	configure_polarity(pc, pwm->hwpwm);
 
-	/* Enable TBCLK before enabling PWM device */
+	/* Enable TBCLK */
 	ret = clk_enable(pc->tbclk);
 	if (ret) {
 		dev_err(chip->dev, "Failed to enable TBCLK for %s\n",
@@ -365,8 +361,6 @@ static int ehrpwm_pwm_enable(struct pwm_
 		return ret;
 	}
 
-	/* Enable time counter for free_run */
-	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_RUN_MASK, TBCTL_FREE_RUN);
 	return 0;
 }
 
@@ -396,9 +390,6 @@ static void ehrpwm_pwm_disable(struct pw
 	/* Disabling TBCLK on PWM disable */
 	clk_disable(pc->tbclk);
 
-	/* Stop Time base counter */
-	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_RUN_MASK, TBCTL_STOP_NEXT);
-
 	/* Disable clock on PWM disable */
 	pm_runtime_put_sync(chip->dev);
 }

