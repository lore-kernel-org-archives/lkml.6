Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAADC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 00:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C822084A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 00:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U0qdt04S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C822084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbeJ3JgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 05:36:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44209 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeJ3JgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 05:36:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id w3-v6so4718777pgs.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 17:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TE49An1zFFtJ+IdMUHGtuRHRbV/615YwoE46NHTF3GE=;
        b=U0qdt04SzswoeoSwEAZZDrCDOqsGM2l9HdbhwAu8QNnNPz8cE5O5Ne31aKG4H6vqC6
         VGO9mavopK/YnV17psAk8Iatu6M8WabCILqhoUKVCE+uvpvCzMcBgeX5UredbNMXVEn0
         Xye5amJKCmpQcHqiABmfrvmgeNDRiqk0Q/UQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TE49An1zFFtJ+IdMUHGtuRHRbV/615YwoE46NHTF3GE=;
        b=cogN8OUM2p4nWLLbZwfbkQ+oRVLAW/heYhw14YvmOC1CYaMAdBy5ODj88Us5Mdr/zP
         DT75q1g/lCWmVedy/mgojwB94R5Cx8yl5wJCnrDjCLYxsAcv5tco0Ik3J3wULCAcZaaX
         JgX0KZYp443K5RNOXAgln6A0xxDnUjdk6NSg1LqCUc+npgivuZMco98fqG9dUCRX/Lsr
         Sb//njy7XVU+KK4gLNADlQqxKox7NMbseJ8AxZzWtGo1zic/BpRZ4zceXyEi3tj9OoBq
         NY+b9EJHTYCgC8lLQ7ycnV+I4hJS01URBMD0VbzgLJR4NYA/tOi9vSgiQW3TmJ9WPrvG
         2dBA==
X-Gm-Message-State: AGRZ1gJVf8EM7KO02m+PZEYraDNWbyPAUFQrKqpgNBBsoO7K74dooLeT
        bornaJC9YefWfpUK2RE5sBfN1A==
X-Google-Smtp-Source: AJdET5fCu/7b9ONgCnTWUWkjHmICTT6GT7ZxYQ/U5HCYXSUlAbHL+tl4hNb3zgI+3N/1tEatKvS84Q==
X-Received: by 2002:a62:418a:: with SMTP id g10-v6mr688804pfd.44.1540860303211;
        Mon, 29 Oct 2018 17:45:03 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id y1-v6sm24289644pfy.89.2018.10.29.17.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 17:45:02 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        Dmitry Grinberg <dmitrygr@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 3/3] Bluetooth: hci_qca: Set HCI_QUIRK_USE_BDADDR_PROPERTY for wcn3990
Date:   Mon, 29 Oct 2018 17:44:15 -0700
Message-Id: <20181030004415.237101-4-mka@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181030004415.237101-1-mka@chromium.org>
References: <20181030004415.237101-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set quirk for wcn3990 to read BD_ADDR from a firmware node property.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- patch added to the series

tested with https://lore.kernel.org/patchwork/patch/1003830
("Bluetooth: hci_qca: Add helper to set device address.")
---
 drivers/bluetooth/hci_qca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index f036c8f98ea3..0535833caa52 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1193,6 +1193,7 @@ static int qca_setup(struct hci_uart *hu)
 		 * setup for every hci up.
 		 */
 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
+		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
 		hu->hdev->shutdown = qca_power_off;
 		ret = qca_wcn3990_init(hu);
 		if (ret)
-- 
2.19.1.568.g152ad8e336-goog

