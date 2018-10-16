Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90BDC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FCA2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Y5Ybj0Qc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Zm5kbe5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FCA2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeJPWBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:01:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44978 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeJPWBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:01:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3839D60769; Tue, 16 Oct 2018 14:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539699073;
        bh=InM/hjtFO+AKpCBvS2k7elQU/r9rpSlchG6DDQ9+3qU=;
        h=From:To:Cc:Subject:Date:From;
        b=Y5Ybj0QcKg+yG0raAWLcZsGrc9tCbatIlQYTN1HPLRuMYpPYh90WEQ4Os/4QGAixn
         3lH+BuROgMPsA/mHxtuvJZOvS9HI3pdvR0b5VUW/u0+KwOGkzXjigUOCdwhTbwWzLD
         1JmiEwUD+yFaggNiHJ1x5nTBOJWyrGhynl00wR6M=
Received: from msavaliy-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: msavaliy@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6332360558;
        Tue, 16 Oct 2018 14:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539699072;
        bh=InM/hjtFO+AKpCBvS2k7elQU/r9rpSlchG6DDQ9+3qU=;
        h=From:To:Cc:Subject:Date:From;
        b=Zm5kbe5gUHjflDk7QjDFyNhGDrSLYd7mOFBMbD0k+TtAmTbVYF17/nuemG9i2dfgI
         4QK2Atrtb/71f/9wiWo6++4s6gny+AtmazL0N9lXBzGKi+b4pIauCZ/mIKJUkkY6Zl
         YYSuSZv+k8d8dgMH44078/y1Rhi531E4amJeMrQw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6332360558
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=msavaliy@codeaurora.org
From:   "Mukesh, Savaliya" <msavaliy@codeaurora.org>
To:     alokc@codeaurora.org, dianders@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
Subject: [PATCH] tty: serial: qcom_geni_serial: Rectify UART suspend mechanism
Date:   Tue, 16 Oct 2018 19:41:00 +0530
Message-Id: <1539699060-3055-1-git-send-email-msavaliy@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>

UART driver checks for the PM state and denies suspend if state is ACTIVE.
This makes UART to deny suspend when client keeps port open which is not
correct. Instead follow framework and obey suspend-resume callbacks.

Signed-off-by: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 36 ++++++-----------------------------
 1 file changed, 6 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 29ec343..93598d7 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1327,49 +1327,25 @@ static int qcom_geni_serial_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused qcom_geni_serial_sys_suspend_noirq(struct device *dev)
+static int __maybe_unused qcom_geni_serial_sys_suspend(struct device *dev)
 {
 	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
 	struct uart_port *uport = &port->uport;
 
-	if (uart_console(uport)) {
-		uart_suspend_port(uport->private_data, uport);
-	} else {
-		struct uart_state *state = uport->state;
-		/*
-		 * If the port is open, deny system suspend.
-		 */
-		if (state->pm_state == UART_PM_STATE_ON)
-			return -EBUSY;
-	}
-
-	return 0;
+	return uart_suspend_port(uport->private_data, uport);
 }
 
-static int __maybe_unused qcom_geni_serial_sys_resume_noirq(struct device *dev)
+static int __maybe_unused qcom_geni_serial_sys_resume(struct device *dev)
 {
 	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
 	struct uart_port *uport = &port->uport;
 
-	if (uart_console(uport) &&
-			console_suspend_enabled && uport->suspended) {
-		uart_resume_port(uport->private_data, uport);
-		/*
-		 * uart_suspend_port() invokes port shutdown which in turn
-		 * frees the irq. uart_resume_port invokes port startup which
-		 * performs request_irq. The request_irq auto-enables the IRQ.
-		 * In addition, resume_noirq implicitly enables the IRQ and
-		 * leads to an unbalanced IRQ enable warning. Disable the IRQ
-		 * before returning so that the warning is suppressed.
-		 */
-		disable_irq(uport->irq);
-	}
-	return 0;
+	return uart_resume_port(uport->private_data, uport);
 }
 
 static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_geni_serial_sys_suspend_noirq,
-					qcom_geni_serial_sys_resume_noirq)
+	SET_SYSTEM_SLEEP_PM_OPS(qcom_geni_serial_sys_suspend,
+					qcom_geni_serial_sys_resume)
 };
 
 static const struct of_device_id qcom_geni_serial_match_table[] = {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

