Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112FBC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1FB2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbfAaWKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 17:10:39 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33173 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfAaWKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 17:10:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so2134250pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 14:10:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=neu4ijQp4ZwPHccR+4VkX1brGtxFp+6NzRZCUlDIr4A=;
        b=dmBCLEGUd8OYe2sctSnYKZNMAzHsbM65LHQBLzoqEjwFpqmOo8Q879nuRHANhv/BTx
         9r2n2HGQiumGS/QiC2wbgrdVlQ5yZafQKtQOuPkXqJEyg3C3huwK2f9JdfDEEXU3IgXN
         v3ymKrnHEylZvRJzKLiMT+QZXxBlnWsFm76FKOfki4kdooqNe5GAgPM9N32losk2b3dA
         E2bGGFT9UApXy1nLVlFZQcU5iKHP//5THZPDTEfZI8kMq/XVBpu8ebkeJ9ek0y9kBkC/
         IW7HZO47pNrwQpEZRkDMCcDTngZ8BQZdKxg8mi4/5zZY9Mm53TyXL+1kapcV1VwPu97f
         pYSA==
X-Gm-Message-State: AJcUuke8xzo/rMQvzraPPI84xd1qZl79yDssgP4ob1g6umW4fcIu8Ana
        4XnyKwGXUjBk4frGKc45c4Vlrw==
X-Google-Smtp-Source: ALg8bN4oko9mZDz3077iZBqA6kXERrTZyuz0tQmWXjY8mNKHikIlSOdvtgfv45oFWo8ia7wiGLi+WA==
X-Received: by 2002:a62:2a4b:: with SMTP id q72mr36110652pfq.61.1548972636938;
        Thu, 31 Jan 2019 14:10:36 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id r80sm10279879pfa.111.2019.01.31.14.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 14:10:36 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH RESEND 0/3] Add quirk for reading BD_ADDR from fwnode property
Date:   Thu, 31 Jan 2019 14:10:18 -0800
Message-Id: <20190131221021.176809-1-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[initial post: https://lore.kernel.org/patchwork/cover/1028184/]

On some systems the Bluetooth Device Address (BD_ADDR) isn't stored
on the Bluetooth chip itself. One way to configure the address is
through the device tree (patched in by the bootloader). The btqcomsmd
driver is an example, it can read the address from the DT property
'local-bd-address'.

To avoid redundant open-coded reading of 'local-bd-address' and error
handling this series adds the quirk HCI_QUIRK_USE_BDADDR_PROPERTY to
retrieve the BD address of a device from the DT and adapts the
btqcomsmd and hci_qca drivers to use this quirk.

Matthias Kaehlcke (3):
  Bluetooth: Add quirk for reading BD_ADDR from fwnode property
  Bluetooth: btqcomsmd: use HCI_QUIRK_USE_BDADDR_PROPERTY
  Bluetooth: hci_qca: Set HCI_QUIRK_USE_BDADDR_PROPERTY for wcn3990

 drivers/bluetooth/btqcomsmd.c | 29 +++--------------------
 drivers/bluetooth/hci_qca.c   |  1 +
 include/net/bluetooth/hci.h   | 12 ++++++++++
 net/bluetooth/hci_core.c      | 43 +++++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c          |  6 +++--
 5 files changed, 63 insertions(+), 28 deletions(-)

-- 
2.20.1.495.gaa96b0ce6b-goog

