Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C61C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92EA2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92EA2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbeKGTDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:03:37 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34477 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeKGTDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:03:37 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gKKDo-0007yx-7E; Wed, 07 Nov 2018 10:34:00 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gKKDj-0004rS-UC; Wed, 07 Nov 2018 10:33:55 +0100
Date:   Wed, 7 Nov 2018 10:33:55 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>,
        kernel@pengutronix.de
Subject: Re: =?iso-8859-1?B?W1JDRqBQQVRDSCx2Miwy?= =?iso-8859-1?B?LzJd?= pwm:
 imx: Configure output to GPIO in disabled state
Message-ID: <20181107093355.e4n3irrnkybqsjvc@pengutronix.de>
References: <1539163920-9442-3-git-send-email-michal.vokac@ysoft.com>
 <20181012085720.GA9451@taurus.defre.kleine-koenig.org>
 <fa96ae2a-c2cc-b47a-1198-5daffa7c865f@ysoft.com>
 <20181012160854.hmgpokxgsrqdzobx@pengutronix.de>
 <e4289ee5-3fc1-2848-1cae-77d29b5ed93c@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4289ee5-3fc1-2848-1cae-77d29b5ed93c@ysoft.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michal,

just to state it more explicitly, I think the following patch (not even
compile tested) is much preferable over your approach:

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 1d5242c9cde0..af88644b5efb 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -216,7 +216,14 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
 			cr |= MX3_PWMCR_POUTC;
 
 		writel(cr, imx->mmio_base + MX3_PWMCR);
-	} else if (cstate.enabled) {
+	} else if (cstate.enabled && state->polarity == PWM_POLARITY_NORMAL) {
+		/*
+		 * When disabled in hardware the output pin goes to 0
+		 * independant of the polarity setting. The expectation of some
+		 * people however is that after disabling the pin goes to the
+		 * inactive level which isn't given for an inversed pwm, so
+		 * only disable for normal polarity.
+		 */
 		writel(0, imx->mmio_base + MX3_PWMCR);
 
 		clk_disable_unprepare(imx->clk_per);

I think it solves most if not all problems you want to address with the
pinctrl stuff.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
