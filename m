Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F240EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3104217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbeL1WGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:06:05 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39250 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbeL1WGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 17:06:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id r136so10944090pfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 14:06:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tkj0zZ4jT4ks5JgX7yem5RVPoG0lWAeVNGQme9X/m0U=;
        b=ntPn3o6aa0S0YFHinUiaCR7XwFSkAb/PYS1+nd28AVQXFT8jNoVQHuCW3ROt799e9G
         78zzYVBArTGMnEUmnQMOmaf1nCRywlfHE4pXjj3OJZTzl887Bl3bWc0/2KMmgJLaAXXL
         c6Gfu5OoIaqYazAHm/31svzQJqApshjkXjpJnfxZE8A/V7t/zmyA7Q3KtiUC5jyKkscq
         4f7f6JpnJKnMhkbIbliIqgJiDp/ZPoshCKmporwaLz/WyG2xt7Rs+qclHw6quhXJWmkR
         NaOI3+Gqa16EPeLXyy/eHY2Z7uyuYQjtaMFZVkP+E8c+b2RjcdFNlEbuYsWrd8PFqNfk
         YcSA==
X-Gm-Message-State: AJcUukegCabfz95u7M09psf+FdJebWVisbU5P6cc4LVNgzNg5Xhi5kKh
        8uGoQ3buSkMBG7xY7ctkS+J1OA==
X-Google-Smtp-Source: ALg8bN7w0wvsWFA6QM56Zbs6jGhXk6CgpXsZ8dYedx0M1wZK1oJQg/06A1NWlhNbwhkg6kNdgHOvdQ==
X-Received: by 2002:a63:2507:: with SMTP id l7mr26720711pgl.22.1546034763665;
        Fri, 28 Dec 2018 14:06:03 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f62sm49333537pgc.67.2018.12.28.14.06.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 14:06:02 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        Dmitry Grinberg <dmitrygr@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 0/3] Add quirk for reading BD_ADDR from fwnode property
Date:   Fri, 28 Dec 2018 14:05:43 -0800
Message-Id: <20181228220546.367-1-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.20.1.415.g653613c723-goog

