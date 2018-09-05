Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02954C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEE12073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YMJIiTDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EEE12073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbeIFAn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:43:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38837 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbeIFAnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:43:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id t84-v6so2126389pgb.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 13:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aED8WBvFuaDXsWIn/cMHY20Vmk+mx3p7TF8ggA2zkyo=;
        b=YMJIiTDDv//Q22XDlwK3SY9MDSnSxzItcdFU0M6vgacth60S1Xk6jtCIqvZzW7lAIB
         5TMN2CO1Z1qxWED11Ef/XloOD9EGyguserEJV4FEB2rW/AErXOfJcTUY51MsLEJWlPAH
         kFi9w3R/T+DKVq+znWgfugjynhjTSqge8FBPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aED8WBvFuaDXsWIn/cMHY20Vmk+mx3p7TF8ggA2zkyo=;
        b=Elqj8rpTnCDTi2ljv5IeooFwgsPsQSKbSiig/MfZHFTn21FMFQcONqLjo0M+HD8jdt
         fd8X63WkcT+jZnMOIZpTmY6emcgY8UD83Jx3bK4ffd+5I9CkoFPW64oOeQHjZgZXQfBR
         cgSpk/km6jVbbcvX5rf9Rl51LTYzW+vz7oxlgCVzS2NbcEDKGspFsD7FYCvj/peUTp9g
         wk9nLWXULNTViOGSgLVln2A3/Br7+6wy/C0jq1GnWdTwlEDAo6k2XGgcUyHF+LUdtic4
         k0TBLpGY+EdVgS/6Zn9VSWd4ugM8gHgZn/6bZwNB0SYR0JDH+n4WMB2lMtK/EbIbxy4S
         rtWw==
X-Gm-Message-State: APzg51CyxRZfLeHpSlxplZq6xb0rzKVZH82/5gXac92ZK8dtRT0Pt0AE
        WDc7keBpThbCUNzCKSgmOiyqsA==
X-Google-Smtp-Source: ANB0VdYJusZIniK2wOtzhsC4M8MINVlye9AUqfo2z34aP4g/ddjZSlqMQzoo8ZByWY3jHy9UIneT5g==
X-Received: by 2002:a62:f5c1:: with SMTP id b62-v6mr42879296pfm.158.1536178329495;
        Wed, 05 Sep 2018 13:12:09 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id l3-v6sm3505100pff.8.2018.09.05.13.12.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 13:12:08 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, mka@chromium.org,
        evgreen@chromium.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH] tty: serial: qcom_geni_serial: Fix serial when not used as console
Date:   Wed,  5 Sep 2018 13:11:46 -0700
Message-Id: <20180905201146.261438-1-dianders@chromium.org>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you've got the "console" serial port setup to use just as a UART
(AKA there is no "console=ttyMSMX" on the kernel command line) then
certain initialization is skipped.  When userspace later tries to do
something with the port then things go boom (specifically, on my
system, some sort of exception hit that caused the system to reboot
itself w/ no error messages).

Let's cleanup / refactor the init so that we always run the same init
code regardless of whether we're using the console.

To make this work, we make rely on qcom_geni_serial_pm doing its job
to turn resources on.

For the record, here is a trace of the order of things (after this
patch) when console= is specified on the command line and we have an
agetty on the port:
  qcom_geni_serial_pm: 4 (undefined) => 0 (on)
  qcom_geni_console_setup
  qcom_geni_serial_port_setup
  qcom_geni_serial_console_write
  qcom_geni_serial_startup
  qcom_geni_serial_start_tx

...and here is the order of things (after this patch) when console= is
_NOT_ specified on the command line and we have an agetty port:
  qcom_geni_serial_pm: 4 => 0
  qcom_geni_serial_pm: 0 => 3
  qcom_geni_serial_pm: 3 => 0
  qcom_geni_serial_startup
  qcom_geni_serial_port_setup
  qcom_geni_serial_pm: 0 => 3
  qcom_geni_serial_pm: 3 => 0
  qcom_geni_serial_startup
  qcom_geni_serial_start_tx

Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver support for GENI based QUP")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 55 +++++++++++++--------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 29ec34387246..99103c67e1dc 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -851,6 +851,23 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 	unsigned int rxstale = DEFAULT_BITS_PER_CHAR * STALE_TIMEOUT;
+	u32 proto;
+
+	if (uart_console(uport))
+		port->tx_bytes_pw = 1;
+	else
+		port->tx_bytes_pw = 4;
+	port->rx_bytes_pw = RX_BYTES_PW;
+
+	proto = geni_se_read_proto(&port->se);
+	if (proto != GENI_SE_UART) {
+		dev_err(uport->dev, "Invalid FW loaded, proto: %d\n", proto);
+		return -ENXIO;
+	}
+
+	qcom_geni_serial_stop_rx(uport);
+
+	get_tx_fifo_size(port);
 
 	set_rfr_wm(port);
 	writel_relaxed(rxstale, uport->membase + SE_UART_RX_STALE_CNT);
@@ -874,30 +891,19 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 			return -ENOMEM;
 	}
 	port->setup = true;
+
 	return 0;
 }
 
 static int qcom_geni_serial_startup(struct uart_port *uport)
 {
 	int ret;
-	u32 proto;
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 
 	scnprintf(port->name, sizeof(port->name),
 		  "qcom_serial_%s%d",
 		(uart_console(uport) ? "console" : "uart"), uport->line);
 
-	if (!uart_console(uport)) {
-		port->tx_bytes_pw = 4;
-		port->rx_bytes_pw = RX_BYTES_PW;
-	}
-	proto = geni_se_read_proto(&port->se);
-	if (proto != GENI_SE_UART) {
-		dev_err(uport->dev, "Invalid FW loaded, proto: %d\n", proto);
-		return -ENXIO;
-	}
-
-	get_tx_fifo_size(port);
 	if (!port->setup) {
 		ret = qcom_geni_serial_port_setup(uport);
 		if (ret)
@@ -1056,6 +1062,7 @@ static int __init qcom_geni_console_setup(struct console *co, char *options)
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
+	int ret;
 
 	if (co->index >= GENI_UART_CONS_PORTS  || co->index < 0)
 		return -ENXIO;
@@ -1071,21 +1078,10 @@ static int __init qcom_geni_console_setup(struct console *co, char *options)
 	if (unlikely(!uport->membase))
 		return -ENXIO;
 
-	if (geni_se_resources_on(&port->se)) {
-		dev_err(port->se.dev, "Error turning on resources\n");
-		return -ENXIO;
-	}
-
-	if (unlikely(geni_se_read_proto(&port->se) != GENI_SE_UART)) {
-		geni_se_resources_off(&port->se);
-		return -ENXIO;
-	}
-
 	if (!port->setup) {
-		port->tx_bytes_pw = 1;
-		port->rx_bytes_pw = RX_BYTES_PW;
-		qcom_geni_serial_stop_rx(uport);
-		qcom_geni_serial_port_setup(uport);
+		ret = qcom_geni_serial_port_setup(uport);
+		if (ret)
+			return ret;
 	}
 
 	if (options)
@@ -1203,11 +1199,12 @@ static void qcom_geni_serial_pm(struct uart_port *uport,
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 
+	/* If we've never been called, treat it as off */
+	if (old_state == UART_PM_STATE_UNDEFINED)
+		old_state = UART_PM_STATE_OFF;
+
 	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF)
 		geni_se_resources_on(&port->se);
-	else if (!uart_console(uport) && (new_state == UART_PM_STATE_ON &&
-				old_state == UART_PM_STATE_UNDEFINED))
-		geni_se_resources_on(&port->se);
 	else if (new_state == UART_PM_STATE_OFF &&
 			old_state == UART_PM_STATE_ON)
 		geni_se_resources_off(&port->se);
-- 
2.19.0.rc1.350.ge57e33dbd1-goog

