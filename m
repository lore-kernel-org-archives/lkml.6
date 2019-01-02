Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A88DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6AE214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SzScPM8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbfABVhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 16:37:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38880 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729185AbfABVhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 16:37:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so15713898pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 13:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o9d4RK+gluVWnJUlaWD6Scyzt6WnUyNbk7KBnA4mznM=;
        b=SzScPM8YthyOArsjJ48mdlu5xv/5Qekm3Rem4xwKGGa/aqipKnzlmyJwZdPqC8CGaR
         pifl8kgObctOE1Sn+Lnvv55mkR8SvgukLu34qhnbFO7bsTDHWBM6Q48h9sZtJ7P7wD8U
         liG0J8RFYRMcrL2oGlvwz6boEPaG9DZH0UrMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o9d4RK+gluVWnJUlaWD6Scyzt6WnUyNbk7KBnA4mznM=;
        b=b4D52AkyUP+USU108TPeIZm0X25A1IKOrNzRy/RTnTcvh8NuVq2z8SHfn8T/eseMM/
         vFt3Zc6kb4LXaJhifAFk+X/ap/NcdQUcYxwV5bclnRF0r+mHIlsAS8hk0XnfN0qyJ0pT
         Mb2H4P/WRii3X7nJg+7UUz7JjPvn3uUm7EiE8uignLbpnFvT3L3xP1RW+dTA1nNDERNu
         7oed15t/7qNUzF4ay9OsdA+nhjqi9PMwV190EV9c8q4JCLao/YihU67JBa62H55nTPg+
         iit4Xgf/4P4cnJ/Rhn6te7pQZko8yaH1d1cg9g/40f8c4ZiQkI5Pj8rdgmVLHFmh7ct1
         +z3Q==
X-Gm-Message-State: AA+aEWYtGZOSYGyeUn3PcatOZqGxPejkR4zf873OE/WPq1vimnJtSANf
        shNUo213n3HoV8dwSyRUtfxFuA==
X-Google-Smtp-Source: ALg8bN5EW5LkQtEbGodLnf/558y6PUhddq+Bws7ypRMmTsQ9Sprdk6DWsThi8wnr4uokCYQYN8jfaw==
X-Received: by 2002:a62:1992:: with SMTP id 140mr45984312pfz.33.1546465022047;
        Wed, 02 Jan 2019 13:37:02 -0800 (PST)
Received: from ryandcase.mtv.corp.google.com ([2620:15c:202:201:ed1c:3d1c:9d92:99cb])
        by smtp.gmail.com with ESMTPSA id m67sm105323631pfb.25.2019.01.02.13.37.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 13:37:01 -0800 (PST)
From:   Ryan Case <ryandcase@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
Subject: [PATCH 4/4] tty: serial: qcom_geni_serial: Use u32 for register variables
Date:   Wed,  2 Jan 2019 13:36:36 -0800
Message-Id: <20190102213636.40866-5-ryandcase@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20190102213636.40866-1-ryandcase@chromium.org>
References: <20190102213636.40866-1-ryandcase@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ryan Case <ryandcase@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 3103aa0adc86..fa67a2ced420 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -765,12 +765,12 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 
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
@@ -948,14 +948,14 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
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
2.20.1.415.g653613c723-goog

