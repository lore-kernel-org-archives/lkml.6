Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F3AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426FE20866
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AdHIh3sK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbeLSUed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 15:34:33 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38905 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbeLSUed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 15:34:33 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so9994436plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 12:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XEWbkaYcGk5TQTZEZBDJvxQ59YABRHMeDxyNW1ZL+Yc=;
        b=AdHIh3sKbLUrC5B7/genrFbdYCmi6B6ocv2sz8+FLeLSoG1v4tloVIN3uJJTV/XKly
         luC8eAWgY6YIcH07rRhKxBiZMKTq7fJOsCJ8SoOAA0JIxAX3+g2rELFp1kp3McREgLGM
         +LpIvq+zz7MpnFQQIFaU5VwM3Z27caHx8wXcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XEWbkaYcGk5TQTZEZBDJvxQ59YABRHMeDxyNW1ZL+Yc=;
        b=M5MTZfDiy+Ah33LatPyxS2cvvLiTkC4Dg5xOQ0bkC5cSegCAHZjXEnguEat5HXEdwx
         Tqv3bWX+FDyMq+kqhufH4OKzYQvClqykwZa9sx3h0rkDv4npFYszXpmXd5+Z1SvXzMgm
         Wn5YGeQFGmB2WdvONTtFMjoakCjhpSbB6SR1Ad6rSz9fKIi0exnJ6Do9tJiX52kPEQic
         PeYPtEjU+C+8KOJqmPzpkB+CoYBU59+XYcy1iwrG+od6BcemsNFWCCuYBzliKmLejAeq
         FRWCORaBVxSn7QxG3dwdahf0Mg0kZuCIT8gpIsc1/W1uYHqZ+XTTXacP0OxYAZu4Kxcy
         xUXQ==
X-Gm-Message-State: AA+aEWa5Y0uCFgGMaov387+2YRO+os8aKoY3NOaPuLX9nax0VLF6Mifp
        a9jL4v6XyeHSpNUV0m6DchoB0+PewbwfIQ==
X-Google-Smtp-Source: AFSGD/VFHtF+aL9FewSDCJAEIpdYsiDBB/wVNelHAgsdk2Y+DyB6sgdddPzTEa4JW384M6utut/y5A==
X-Received: by 2002:a17:902:930b:: with SMTP id bc11mr22173556plb.17.1545251672703;
        Wed, 19 Dec 2018 12:34:32 -0800 (PST)
Received: from ryandcase.mtv.corp.google.com ([2620:15c:202:201:ed1c:3d1c:9d92:99cb])
        by smtp.gmail.com with ESMTPSA id u123sm23434269pfb.1.2018.12.19.12.34.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 12:34:32 -0800 (PST)
From:   Ryan Case <ryandcase@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Ryan Case <ryandcase@chromium.org>
Subject: [PATCH] tty: serial: qcom_geni_serial: Fix UART hang
Date:   Wed, 19 Dec 2018 12:33:53 -0800
Message-Id: <20181219203353.172335-1-ryandcase@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a serial console write occured while a UART transmit command was
waiting for a done signal then no further data would be sent until
something new kicked the system into gear. If there is already data
waiting in the circular buffer we must re-enable the tx watermark so we
receive the expected interrupts.

Signed-off-by: Ryan Case <ryandcase@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 0c93beb69e73..a694a47747c7 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -442,6 +442,7 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 	bool locked = true;
 	unsigned long flags;
 	u32 geni_status;
+	u32 irq_en;
 
 	WARN_ON(co->index < 0 || co->index >= GENI_UART_CONS_PORTS);
 
@@ -476,6 +477,13 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 		 * has been sent, in which case we need to look for done first.
 		 */
 		qcom_geni_serial_poll_tx_done(uport);
+
+		if (uart_circ_chars_pending(&uport->state->xmit)) {
+			irq_en = readl_relaxed(uport->membase +
+					SE_GENI_M_IRQ_EN);
+			writel_relaxed(irq_en | M_TX_FIFO_WATERMARK_EN,
+					uport->membase + SE_GENI_M_IRQ_EN);
+		}
 	}
 
 	__qcom_geni_serial_console_write(uport, s, count);
-- 
2.20.1.415.g653613c723-goog

