Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5513DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFFC21850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SHaAZtZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfBZTrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:47:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33281 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfBZTrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 14:47:03 -0500
Received: by mail-pl1-f196.google.com with SMTP id y10so6750084plp.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 11:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LCbCIF5IQuuQJ3QG6T83ySsLS8CLXxsAai5+jAMCBmk=;
        b=SHaAZtZY5O0CHhvd3WuETZ2xHezujR/erx5FNKSO7aR1nofIv9ln7puEu+1GzzC/ow
         X80D8T1nnvMrZJyDtGDO7uSWXZtvvc8scmHMbbSxEU8ZLJ+N226NU+b+Y2rCwWuUQtuK
         8GsY6OGImmR3LjQ+oQAWVtVAzhugdx6UdO4Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LCbCIF5IQuuQJ3QG6T83ySsLS8CLXxsAai5+jAMCBmk=;
        b=j+zXHIEUcSM5PTgvTYkjm0Ao72q2GJlzU12CUwsBfQzxrH33E2DmfwyZ32XxT2bT49
         WXy7M6S7uMACpDajJZYLj3sjUk+iwH3gxJPgRgi7y8leGpL9KSsKbTFYvoSbSJyebbRO
         pJpdRq5RsJonkTD+Xn/RUTZ1dGcYuK9OdQOVHF9H93vTQnav7lOvdP228Z3BI30Z1Nd0
         svDFcXnlsld3UZv0ozHvM4JnoCPKELhltqpfxvzKRIwuppP46EmV7kEhuch0H64kRA+n
         g25D8awTxEKA7OycJMyRukUb3uoxb+16dgMNRPS5JLYGotvYak0NafAgnw/c/fqeF9Lp
         i6Vg==
X-Gm-Message-State: AHQUAubz7zY1fFVt0BqHEjMFlehWi90dcV3pwVNuPg0egT5taVr2LBmN
        swT/ba9BuAuNaWCsEZdhxeDRRw==
X-Google-Smtp-Source: AHgI3IZsUksvTssNBRU66VpClxBBkDof0Oc8eNapnuZJIlXLYDofkYHolvQ69ObNivMlZQo2pS/iyg==
X-Received: by 2002:a17:902:b402:: with SMTP id x2mr27545273plr.53.1551210422176;
        Tue, 26 Feb 2019 11:47:02 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id r6sm15766498pgk.91.2019.02.26.11.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 11:47:01 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 1/3] Bluetooth: hci_qca: Pass boolean 'on/off' to qca_send_power_pulse()
Date:   Tue, 26 Feb 2019 11:46:45 -0800
Message-Id: <20190226194647.146078-2-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
In-Reply-To: <20190226194647.146078-1-mka@chromium.org>
References: <20190226194647.146078-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are only two types of power pulses 'on' or 'off', pass a boolean
instead of the power pulse 'command'.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
Changes in v2:
- added 'Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>' tag
---
 drivers/bluetooth/hci_qca.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 5e03504c4e0ca..e4128774e9686 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1004,10 +1004,11 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
 		hci_uart_set_baudrate(hu, speed);
 }
 
-static int qca_send_power_pulse(struct hci_uart *hu, u8 cmd)
+static int qca_send_power_pulse(struct hci_uart *hu, bool on)
 {
 	int ret;
 	int timeout = msecs_to_jiffies(POWER_PULSE_TRANS_TIMEOUT_MS);
+	u8 cmd = on ? QCA_WCN3990_POWERON_PULSE : QCA_WCN3990_POWEROFF_PULSE;
 
 	/* These power pulses are single byte command which are sent
 	 * at required baudrate to wcn3990. On wcn3990, we have an external
@@ -1138,12 +1139,12 @@ static int qca_wcn3990_init(struct hci_uart *hu)
 
 	/* Forcefully enable wcn3990 to enter in to boot mode. */
 	host_set_baudrate(hu, 2400);
-	ret = qca_send_power_pulse(hu, QCA_WCN3990_POWEROFF_PULSE);
+	ret = qca_send_power_pulse(hu, false);
 	if (ret)
 		return ret;
 
 	qca_set_speed(hu, QCA_INIT_SPEED);
-	ret = qca_send_power_pulse(hu, QCA_WCN3990_POWERON_PULSE);
+	ret = qca_send_power_pulse(hu, true);
 	if (ret)
 		return ret;
 
@@ -1289,7 +1290,7 @@ static void qca_power_shutdown(struct hci_uart *hu)
 	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
 
 	host_set_baudrate(hu, 2400);
-	qca_send_power_pulse(hu, QCA_WCN3990_POWEROFF_PULSE);
+	qca_send_power_pulse(hu, false);
 	qca_power_setup(hu, false);
 }
 
-- 
2.21.0.rc2.261.ga7da99ff1b-goog

