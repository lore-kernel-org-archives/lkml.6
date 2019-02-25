Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE55C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229A8218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PSYhP03j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbfBYXuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:50:20 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40808 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfBYXuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 18:50:20 -0500
Received: by mail-pl1-f195.google.com with SMTP id bj4so5242293plb.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 15:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gysWhoNf4JCT38FdtN46+bbYRxGNbE83eDDRJXMPvAM=;
        b=PSYhP03jg1qBlyreHg7rQEH/m6CK8wTDgQ7jPucQiuIOLSiYpwDsx/7mxHKImORVZs
         V7g4uzM/cAPgcCyFxSkocobWNjkL4ByaOVVZT6lal6d6Zl55Xq2nbZsw385jZzLMs3xN
         1GNUAoLE9L9SEMMMZgn66jZgHT92dsNoi+Ko4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gysWhoNf4JCT38FdtN46+bbYRxGNbE83eDDRJXMPvAM=;
        b=SZyWoPfllV9XBSeCVYDElaUfTysQK0ZcgX2woHiC9FaehjtNN6QLK9vC5U2S67ufNd
         n9IH7BO4yWCH+ovtUX7OqCJCPUAG72JoUHVwsvWWXEh7qCGGTwsvbXLXB1YjeUQGhLne
         aKJJHCIHmZ67wfA566SSxnFTGg5J+yerUUypeUcHadDZ+tQrTqP7PmQg+AVdI6ew6hgN
         PoIrKfksRpTE4uHAILCLMk2znB86Cc4vjxDtICrF5rFIT1NQPdmLxU6i5MA/9qGKVXSK
         Y/xvSi+saDi/OBDiBWUSCUx/PS3KvcYeE3rhoZEn4TbEDVC3SZVXzLNc4FmMUdCRkovP
         aMEg==
X-Gm-Message-State: AHQUAuaW5h21CXeNpj2azChiwNmW0x1fHAywJjjZHcQSE9um1hNjHrYY
        QFz4izPbSNby9MVqSrXShPgKaRigKto=
X-Google-Smtp-Source: AHgI3IbEhUVj7VYpi0vnIBn+2quJkji0675OHfWFzX6utSWLFSxqaSwKQhaJoDhzWz8FBrMmHlydlg==
X-Received: by 2002:a17:902:6804:: with SMTP id h4mr22951260plk.115.1551138619593;
        Mon, 25 Feb 2019 15:50:19 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id y7sm17522967pgf.42.2019.02.25.15.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 15:50:18 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 0/3] Bluetooth: hci_qca: Add delay after power-off pulse
Date:   Mon, 25 Feb 2019 15:49:51 -0800
Message-Id: <20190225234954.82942-1-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
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

 drivers/bluetooth/hci_qca.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

-- 
2.21.0.rc0.258.g878e2cd30e-goog

