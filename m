Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98F0C5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A67B2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfASAXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 19:23:25 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41071 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730114AbfASAXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 19:23:25 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so7355170pfi.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 16:23:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U6jXTWszmCpJkD8ympfWKx7s7ZDO5iBFmCrslgGV8Ig=;
        b=W61B2/s6rTHyBVPdjS/2SBLHEvu8nphScE5E2tUIXd1iaWxJz0YPlq5Y+gaVpITdIs
         ARa1rXZ9+4edx9MvHxQodYjI02SSNVrIVsecT+FCAnqoHTWp+Pelcg/We9gNwiBjRR50
         R1lIvadKQ0vfSOPKGpWb22RvIxtbpOQzbEfVKmP21uW/I0twiQh6vMafX3r7BNdSV/Et
         jhYU24Vtl0OeuPkgI/7Tq1Mrsx0Gosr4Z7nFX0+3ilmqJZ3izdrUNT//hGZZ/hGtlUqU
         xEK4EvTGv+MgOFOrsXLGpv8SScozv3BWVRXXCg+Xy4t6jaSsQf2QpkaGFggfYtzqOZxh
         w3mA==
X-Gm-Message-State: AJcUukchUI2ulyi5sHJGuQGpaYlezd/1FmEfH1K4zorkd+StH9dytBfj
        f6ZnHtv/PQIB5AlQtZKQN9wJAw==
X-Google-Smtp-Source: ALg8bN6B1MLuJKMPiTo0TTwOWBfCFxiDFvGH8Vj1Z6IZpz1E60GHKL8VVhwFKn9qJy9A+yfrdNOnnw==
X-Received: by 2002:a63:1258:: with SMTP id 24mr19582149pgs.114.1547857404107;
        Fri, 18 Jan 2019 16:23:24 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id d129sm13763062pfc.31.2019.01.18.16.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 16:23:23 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] tty: serial: qcom_geni_serial: Allow mctrl when flow control is disabled
Date:   Fri, 18 Jan 2019 16:23:05 -0800
Message-Id: <20190119002305.16639-1-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The geni set/get_mctrl() functions currently do nothing unless
hardware flow control is enabled. Remove this arbitrary limitation.

Suggested-by: Johan Hovold <johan@kernel.org>
Fixes: 8a8a66a1a18a ("tty: serial: qcom_geni_serial: Add support for flow control")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index a72d6d9fb9834..38016609c7fa9 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -225,7 +225,7 @@ static unsigned int qcom_geni_serial_get_mctrl(struct uart_port *uport)
 	unsigned int mctrl = TIOCM_DSR | TIOCM_CAR;
 	u32 geni_ios;
 
-	if (uart_console(uport) || !uart_cts_enabled(uport)) {
+	if (uart_console(uport)) {
 		mctrl |= TIOCM_CTS;
 	} else {
 		geni_ios = readl_relaxed(uport->membase + SE_GENI_IOS);
@@ -241,7 +241,7 @@ static void qcom_geni_serial_set_mctrl(struct uart_port *uport,
 {
 	u32 uart_manual_rfr = 0;
 
-	if (uart_console(uport) || !uart_cts_enabled(uport))
+	if (uart_console(uport))
 		return;
 
 	if (!(mctrl & TIOCM_RTS))
-- 
2.20.1.321.g9e740568ce-goog

