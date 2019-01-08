Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C71BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 01:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A843206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 01:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YVc6FN+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfAHB73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 20:59:29 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44588 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfAHB7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 20:59:25 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so968711pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 17:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6aWVzNk/EuKcySVmNuQJZ7QrEX9QtF5bb3gvxpEHdAA=;
        b=YVc6FN+xBTeTzyrv00fy4tVdrodshrwLlCTP4OsMcc0AKIB1tZJFJ65U2hhqR+Jh2M
         y2cC2/w4LkJidmfIt+nwHJIpkss3MOhv85r1KFNZV0UlTrsFsLTsHopvNo5pCc+Cyd4L
         SDxmupBwHzJTR0RYLNDwfBDOat3y5e1LW9has=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6aWVzNk/EuKcySVmNuQJZ7QrEX9QtF5bb3gvxpEHdAA=;
        b=bgT7BRqWnHBSFR3YqUxg7v3P4HupkW/k0LIKAuz7eJyxRCj8+N27CfVygz/+19sRCZ
         mLjeSzlNHFqf99zhce5qhv0VfD+zg4zNjKnaWxMNoVpoA7sgLEH877uPOML+pYOebxnP
         whfQiImoR8utMkbc2Q6Rm/ZAxF48MRc4tefWp4Qd1K8+d0SPqrvuwqXtBQZd1QIgZ8E1
         8OSP4J30oXbe1gkypD5FyM10ozmLq4wBd7SGVRb8yUnauYLv0v1fEvY8sFE79sQKL6XH
         LfuR1OKkfMoyhbHBGS2D+M7M76XSPsl/YjSx8WvsIbvOHARYXCkaIlULDE65vk4YRUqJ
         qLWA==
X-Gm-Message-State: AJcUukes101qpsXVvxG2gDplVpdi+Zcq3tKRJymKMr5vDSjCBW4NMN8c
        isqw4Dc+dtEJY3c6uWv6UyvBBw==
X-Google-Smtp-Source: ALg8bN4GXSs9Te6U9H0iSlLeEdbQUPTU2J8RjTFKyqXJpj8817sANQW7cC5aYHSez5sbbiJC3wLUtw==
X-Received: by 2002:a63:658:: with SMTP id 85mr12871177pgg.373.1546912764492;
        Mon, 07 Jan 2019 17:59:24 -0800 (PST)
Received: from ryandcase.mtv.corp.google.com ([2620:15c:202:201:ed1c:3d1c:9d92:99cb])
        by smtp.gmail.com with ESMTPSA id p2sm93942693pfb.28.2019.01.07.17.59.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 17:59:24 -0800 (PST)
From:   Ryan Case <ryandcase@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
Subject: [PATCH v2 4/4] tty: serial: qcom_geni_serial: Use u32 for register variables
Date:   Mon,  7 Jan 2019 17:58:38 -0800
Message-Id: <20190108015838.166271-5-ryandcase@chromium.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190108015838.166271-1-ryandcase@chromium.org>
References: <20190108015838.166271-1-ryandcase@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use u32 rather than unsigned long for register variables for clarity and
consistency.

Signed-off-by: Ryan Case <ryandcase@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
---

Changes in v2:
- Updated commit message
- Updated missed rxstale variable

 drivers/tty/serial/qcom_geni_serial.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 626bf7d399aa..6d8a44c12596 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -760,12 +760,12 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 
 static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 {
-	unsigned int m_irq_status;
-	unsigned int s_irq_status;
-	unsigned int geni_status;
+	u32 m_irq_en;
+	u32 m_irq_status;
+	u32 s_irq_status;
+	u32 geni_status;
 	struct uart_port *uport = dev;
 	unsigned long flags;
-	unsigned int m_irq_en;
 	bool drop_rx = false;
 	struct tty_port *tport = &uport->state->port;
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
@@ -844,7 +844,7 @@ static void qcom_geni_serial_shutdown(struct uart_port *uport)
 static int qcom_geni_serial_port_setup(struct uart_port *uport)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
-	unsigned int rxstale = DEFAULT_BITS_PER_CHAR * STALE_TIMEOUT;
+	u32 rxstale = DEFAULT_BITS_PER_CHAR * STALE_TIMEOUT;
 	u32 proto;
 
 	if (uart_console(uport)) {
@@ -943,14 +943,14 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 				struct ktermios *termios, struct ktermios *old)
 {
 	unsigned int baud;
-	unsigned int bits_per_char;
-	unsigned int tx_trans_cfg;
-	unsigned int tx_parity_cfg;
-	unsigned int rx_trans_cfg;
-	unsigned int rx_parity_cfg;
-	unsigned int stop_bit_len;
+	u32 bits_per_char;
+	u32 tx_trans_cfg;
+	u32 tx_parity_cfg;
+	u32 rx_trans_cfg;
+	u32 rx_parity_cfg;
+	u32 stop_bit_len;
 	unsigned int clk_div;
-	unsigned long ser_clk_cfg;
+	u32 ser_clk_cfg;
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 	unsigned long clk_rate;
 
-- 
2.20.1.97.g81188d93c3-goog

