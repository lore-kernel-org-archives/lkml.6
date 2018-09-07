Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472F9C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0730B2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0730B2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbeIHCZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:25:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56482 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729963AbeIHCZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:25:11 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 447F7A95;
        Fri,  7 Sep 2018 21:42:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vignesh R <vigneshr@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 4.4 39/47] pwm: tiehrpwm: Fix disabling of output of PWMs
Date:   Fri,  7 Sep 2018 23:10:35 +0200
Message-Id: <20180907210908.681769529@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210904.607934824@linuxfoundation.org>
References: <20180907210904.607934824@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vignesh R <vigneshr@ti.com>

commit 38dabd91ff0bde33352ca3cc65ef515599b77a05 upstream.

pwm-tiehrpwm driver disables PWM output by putting it in low output
state via active AQCSFRC register in ehrpwm_pwm_disable(). But, the
AQCSFRC shadow register is not updated. Therefore, when shadow AQCSFRC
register is re-enabled in ehrpwm_pwm_enable() (say to enable second PWM
output), previous settings are lost as shadow register value is loaded
into active register. This results in things like PWMA getting enabled
automatically, when PWMB is enabled and vice versa. Fix this by
updating AQCSFRC shadow register as well during ehrpwm_pwm_disable().

Fixes: 19891b20e7c2 ("pwm: pwm-tiehrpwm: PWM driver support for EHRPWM")
Cc: stable@vger.kernel.org
Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pwm/pwm-tiehrpwm.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -384,6 +384,8 @@ static void ehrpwm_pwm_disable(struct pw
 		aqcsfrc_mask = AQCSFRC_CSFA_MASK;
 	}
 
+	/* Update shadow register first before modifying active register */
+	ehrpwm_modify(pc->mmio_base, AQCSFRC, aqcsfrc_mask, aqcsfrc_val);
 	/*
 	 * Changes to immediate action on Action Qualifier. This puts
 	 * Action Qualifier control on PWM output from next TBCLK


