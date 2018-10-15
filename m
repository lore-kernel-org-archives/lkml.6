Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF5EC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776DC2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vgchs/xc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776DC2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbeJPEbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:31:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44480 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeJPEbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:31:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id g2-v6so9703296pgu.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 13:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eQMGNDfhm/QbCjUyIYjH4w5gwm9UjkQ3AvQiY8q6jd4=;
        b=Vgchs/xcn7XdhBYUssm3n/xXwqsMfdkL2IkF0yUYsrrwtlhrK4Vre2yoYBlMmkTN/8
         HHx50uCCyJyQ5lAed0UxYHUOzFBnXEG4TsMuYxYTValSsQ5WT72+VMRGOGSEsOB8ifuB
         rBCJrE8OwDA3hOMkl/uVA+fAFgkJdvHUf/LI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eQMGNDfhm/QbCjUyIYjH4w5gwm9UjkQ3AvQiY8q6jd4=;
        b=l1JdmwopxUZBF5v1fmLCppj+XJa5QdU6t621UxjuJrVW40+/JzcIGr/hsZUdMqpiUE
         qxEwDOdj8FrW/BbAMGK76e1J1kARHPGJgGl4EzNH4S2DUQFiAlkR39m/Ud11RE+/1K3g
         3cQNIJi31kBALjYq5JD59lZ4zkJv1fRuU0CIP4z8gGFZqBhV61L3Zy5nGuE+N9M8CGHx
         LaCVi3gaK5/1ZHYwmhCrpRY8XneRltQgTJAZb6An9H0eAe5wEzceaeAUd4kbLK4DU1Ol
         grBHBgQEZkwhHL1w/LA6S9qS5XSg1rg7M/78TOGIo+CdL2Lyi1MUCgsg8pIwyA928Kwf
         qD/A==
X-Gm-Message-State: ABuFfogkFY4Fo7gH+s8FLhO7piCNtmaUdCVJb4wKR1dto0kdk4BipZOo
        UnlXsPe/ZoFLjhEksP2oVLuCgQ==
X-Google-Smtp-Source: ACcGV60KQYfrFj/y0aiFT6U6U4RK9u0DrM3lE3lLn8ZPqX48jLDqUgA+iMgDj5jfHqyz+0sdrM9GWA==
X-Received: by 2002:a62:6506:: with SMTP id z6-v6mr19017676pfb.20.1539636285522;
        Mon, 15 Oct 2018 13:44:45 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id o62-v6sm14639565pfb.0.2018.10.15.13.44.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 13:44:44 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     gregkh@linuxfoundation.org
Cc:     msavaliy@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alokc@codeaurora.org, mka@chromium.org, evgreen@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH] tty: serial: qcom_geni_serial: Don't slow all ports just for kgdb
Date:   Mon, 15 Oct 2018 13:44:24 -0700
Message-Id: <20181015204425.84537-1-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you turn on CONFIG_KGDB then you'll get CONFIG_CONSOLE_POLL
selected.

If you have CONFIG_CONSOLE_POLL selected then the GENI serial driver
was setting RX_BYTES_PW to 1 for _all_ UART ports.

This doesn't seem like such a good idea.  Let's only set RX_BYTES_PW
to 1 for the console port.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index d3b5261ee80a..9ee6ce725e43 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -89,9 +89,9 @@
 #define MAX_LOOPBACK_CFG	3
 
 #ifdef CONFIG_CONSOLE_POLL
-#define RX_BYTES_PW 1
+#define CONSOLE_RX_BYTES_PW 1
 #else
-#define RX_BYTES_PW 4
+#define CONSOLE_RX_BYTES_PW 4
 #endif
 
 struct qcom_geni_serial_port {
@@ -853,11 +853,13 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 	unsigned int rxstale = DEFAULT_BITS_PER_CHAR * STALE_TIMEOUT;
 	u32 proto;
 
-	if (uart_console(uport))
+	if (uart_console(uport)) {
 		port->tx_bytes_pw = 1;
-	else
+		port->rx_bytes_pw = CONSOLE_RX_BYTES_PW;
+	} else {
 		port->tx_bytes_pw = 4;
-	port->rx_bytes_pw = RX_BYTES_PW;
+		port->rx_bytes_pw = 4;
+	}
 
 	proto = geni_se_read_proto(&port->se);
 	if (proto != GENI_SE_UART) {
-- 
2.19.1.331.ge82ca0e54c-goog

