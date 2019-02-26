Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A5FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1684C21850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PxKsiVL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfBZTrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:47:02 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35089 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfBZTrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 14:47:01 -0500
Received: by mail-pl1-f193.google.com with SMTP id p19so6735298plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 11:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VNvnOHOK68RqItWemYHG7QHR5eU/B11GOxVuIIAZwKI=;
        b=PxKsiVL6LJViJL8TlFc4bJ99KuEmXp0XhQpUYrbDL9D2Hhu1HSlEpQu1Fe4gb6D+II
         OzofscBFH1LQ1mZMpGFszSrCzwN1bc0eJ+Q2bsa+8vANaXQn1MrqhKNNETuj0cPnJ2ZP
         GBsVXXGVbu8gjd0AquE6Vbuo3fL4eleaRmZrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VNvnOHOK68RqItWemYHG7QHR5eU/B11GOxVuIIAZwKI=;
        b=VXjKI79gb1jHn+YGT0+fmirc1WGw4++UTcLuHj69PpPqXTNOauFUyr2a9hUld87A0n
         PYAeyc5/RUqePbI+DK/rj1v+fHGBbrA00kF5V58UXkECq1EHxckJLOGVPilNpiRbljPz
         CAPjrMQJYmjPgI7+/4PaE0XPUtRRlSVTDN9mrfcb+JydjiMWEYwRVR9MqmIQ8efOpKKt
         Gx9uOojKbTKlL4XW9IcNsB7PceVLDxQsj7wkGHT9Nxy9YPxxC2zxYjn3ngZSQAoIBSd+
         vodt+AYziWtSlym3qrl+1Y65ne57SDb7h6crUy+aZkQIPLqMs1SCZjjHjxP2yQh98euL
         MOtw==
X-Gm-Message-State: AHQUAuaL/rvL9InlIFEGmGhFmL8Wkryb/xe1+FeXbjEnvz8+4ygLrGSh
        bIg1Nd7mo9dBuMfjmH+Km1hyHA==
X-Google-Smtp-Source: AHgI3IYTW52V7M4VKun9mLCYuFDbsBXUQI+34B/7VXt+f/PAzeL6m7g5j5gYf1WWXU9R8J0V+mryag==
X-Received: by 2002:a17:902:1c9:: with SMTP id b67mr21271373plb.176.1551210421323;
        Tue, 26 Feb 2019 11:47:01 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id r6sm15766498pgk.91.2019.02.26.11.47.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 11:47:00 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 0/3] Bluetooth: hci_qca: Add delay after power-off pulse
Date:   Tue, 26 Feb 2019 11:46:44 -0800
Message-Id: <20190226194647.146078-1-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialization of the QCA WCN3990 often fails at boot time:

 [   15.205224] Bluetooth: hci0: setting up wcn3990
 [   17.341062] Bluetooth: hci0: command 0xfc00 tx timeout
 [   22.101453] ERROR: Bluetooth initialization failed
 [   25.337740] Bluetooth: hci0: Reading QCA version information failed (-110)

A short delay after sending a power-off pulse (which is done immediately
before sending a power-on pulse) fixes this.

Also move the delays to qca_send_power_pulse(), since they are directly
related with sending the pulses. Change the interface of
qca_send_power_pulse() to receive a boolean instead of a power pulse
command, this improves readability of the function with the delays
added.

Matthias Kaehlcke (3):
  Bluetooth: hci_qca: Pass boolean 'on/off' to qca_send_power_pulse()
  Bluetooth: hci_qca: Move boot delay to qca_send_power_pulse()
  Bluetooth: hci_qca: Add delay after power-off pulse

 drivers/bluetooth/hci_qca.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

-- 
2.21.0.rc2.261.ga7da99ff1b-goog

