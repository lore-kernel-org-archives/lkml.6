Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C702C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3FA20855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3FA20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbeIHCNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:13:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48994 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbeIHCNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:13:14 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2D283ED1;
        Fri,  7 Sep 2018 21:30:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vignesh R <vigneshr@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 4.14 75/89] pwm: tiehrpwm: Dont use emulation mode bits to control PWM output
Date:   Fri,  7 Sep 2018 23:10:09 +0200
Message-Id: <20180907210901.163798732@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210852.341064285@linuxfoundation.org>
References: <20180907210852.341064285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vignesh R <vigneshr@ti.com>

commit aa49d628f6e016bcec8c6f8e704b9b18ee697329 upstream.

As per AM335x TRM SPRUH73P "15.2.2.11 ePWM Behavior During Emulation",
TBCTL[15:14] only have effect during emulation suspend events (IOW,
to stop PWM when debugging using a debugger). These bits have no effect
on PWM output during normal running of system. Hence, remove code
accessing these bits as they have no role in enabling/disabling PWMs.

Fixes: 19891b20e7c2 ("pwm: pwm-tiehrpwm: PWM driver support for EHRPWM")
Cc: stable@vger.kernel.org
Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pwm/pwm-tiehrpwm.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -33,10 +33,6 @@
 #define TBCTL			0x00
 #define TBPRD			0x0A
 
-#define TBCTL_RUN_MASK		(BIT(15) | BIT(14))
-#define TBCTL_STOP_NEXT		0
-#define TBCTL_STOP_ON_CYCLE	BIT(14)
-#define TBCTL_FREE_RUN		(BIT(15) | BIT(14))
 #define TBCTL_PRDLD_MASK	BIT(3)
 #define TBCTL_PRDLD_SHDW	0
 #define TBCTL_PRDLD_IMDT	BIT(3)
@@ -360,7 +356,7 @@ static int ehrpwm_pwm_enable(struct pwm_
 	/* Channels polarity can be configured from action qualifier module */
 	configure_polarity(pc, pwm->hwpwm);
 
-	/* Enable TBCLK before enabling PWM device */
+	/* Enable TBCLK */
 	ret = clk_enable(pc->tbclk);
 	if (ret) {
 		dev_err(chip->dev, "Failed to enable TBCLK for %s: %d\n",
@@ -368,9 +364,6 @@ static int ehrpwm_pwm_enable(struct pwm_
 		return ret;
 	}
 
-	/* Enable time counter for free_run */
-	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_RUN_MASK, TBCTL_FREE_RUN);
-
 	return 0;
 }
 
@@ -400,9 +393,6 @@ static void ehrpwm_pwm_disable(struct pw
 	/* Disabling TBCLK on PWM disable */
 	clk_disable(pc->tbclk);
 
-	/* Stop Time base counter */
-	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_RUN_MASK, TBCTL_STOP_NEXT);
-
 	/* Disable clock on PWM disable */
 	pm_runtime_put_sync(chip->dev);
 }


