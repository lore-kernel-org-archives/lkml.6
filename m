Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7391C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBEE20871
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CBEE20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933771AbeGIP5j (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:57:39 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:18670 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S933846AbeGIP5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:57:13 -0400
X-UUID: cba9d5e3e7c0405a9dd2b52ce3252f53-20180709
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1086753255; Mon, 09 Jul 2018 23:57:07 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 9 Jul 2018 23:57:05 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 9 Jul 2018 23:57:05 +0800
From:   <sean.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v5 0/7] add support for Bluetooth on MT7622 SoC
Date:   Mon, 9 Jul 2018 23:56:56 +0800
Message-ID: <cover.1531150733.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

v5 and changes since v4:
 - add Reviewed-by Tag from Ulf Hansson for patch 2.
 - remove default y in Kconfig for btmtkuart selection to avoid overkill for
   users which would like to have less an amount on stuff in kernel.
 - list header declarations in alphabetical order and add a proper blank line
   within.
 - remove unused macro.
 - use sizeof to calculate structure size instead of an aextra macro to hardcode.
 - use struct hci_dev * as input paraments for mtk_hci_wmt_sync and mtk_setup_fw
   for that can be reused in mtk bluetooth with other interfaces.
 - remove unused local variabled in mtk_btuart_recv.
 - remove superfluous :8 for dlen2 in struct mtk_stp_hdr definition.
 - give a reasonable naming for these labels and add a pm_runtime_put_noidle()
   in the path undoing failing pm_runtime_get_sync().
 - Turn __u8 into u8 in struct mtk_stp_hdr.
 - Change coding style for align 80-chars wrap

 Really thanks for these reviews by Johan Hovold and Andy Shevchenko

v4 and changes since v3:
 - refine patch 2 based on commit 919b7308fcc4 to allow that
   dev_pm_domain_attach() will return better error codes. 

v3 and changes since v2
* all changes happen on patch 6
 - fix up SPDX license style for btmtkuart.h.
 - change firmware download from in ACL data to in HCI commands
   and then remove unused mtk_acl_wmt_sync and related code.
 - add a workaround replacing bad vendor event id 0xe4 with 0xff every
   vendor should use.
 - add a sanity check for mtk_hci_wmt_sync to verifying if
   input parameters are valid.
 - add an atomic_inc(&bdev->hdev->cmd_cnt) for __hci_cmd_sync_ev.
 - be changed to use firmware with a header called mt7622pr2h.bin.

v2 and changes since v1
 - Dropped patches already being applied
 - Rewirte the whole driver using btuart [1], and add slight extension
   of btuart to fit into btmtkuart driver. Beware that [1] is also pulled
   into one part of the series for avoiding any breakage when the patchset
   is being compiled.

[1] btuart 
	https://www.spinics.net/lists/linux-bluetooth/msg74918.html

v1:

Hi,

This patchset introduces built-in Bluetooth support on MT7622 SoC.
And, it should be simple to make an extension to support other
MediaTek SoCs with adjusting a few of changes on the initialization
sequence of the device.

Before the main driver is being introduced, a few of things about
power-domain management should be re-worked for serdev core and MediaTek
SCPSYS to allow the Bluetooth to properly power up.

Patch 2: add a generic way attaching power domain to serdev
Patch 3 and 4: add cleanups with reuse APIs from Linux core
Patch 5: fix a limitation about power enablement Bluetooth depends on
Patch 1, 6 and 7: the major part of adding Bluetooth support to MT7622
	
	Sean

Marcel Holtmann (1):
  Bluetooth: Add new serdev based driver for UART attached controllers

Sean Wang (6):
  dt-bindings: net: bluetooth: Add mediatek-bluetooth
  serdev: add dev_pm_domain_attach|detach()
  Bluetooth: Add new quirk for non-persistent setup settings
  Bluetooth: Extend btuart driver for join more vendor devices
  Bluetooth: mediatek: Add protocol support for MediaTek serial devices
  MAINTAINERS: add an entry for MediaTek Bluetooth driver

 .../devicetree/bindings/net/mediatek-bluetooth.txt |  35 ++
 MAINTAINERS                                        |   8 +
 drivers/bluetooth/Kconfig                          |  22 +
 drivers/bluetooth/Makefile                         |   3 +
 drivers/bluetooth/btmtkuart.c                      | 352 ++++++++++++++
 drivers/bluetooth/btmtkuart.h                      | 116 +++++
 drivers/bluetooth/btuart.c                         | 527 +++++++++++++++++++++
 drivers/bluetooth/btuart.h                         |  30 ++
 drivers/tty/serdev/core.c                          |  15 +-
 include/net/bluetooth/hci.h                        |   9 +
 net/bluetooth/hci_core.c                           |   3 +-
 11 files changed, 1118 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
 create mode 100644 drivers/bluetooth/btmtkuart.c
 create mode 100644 drivers/bluetooth/btmtkuart.h
 create mode 100644 drivers/bluetooth/btuart.c
 create mode 100644 drivers/bluetooth/btuart.h

-- 
2.7.4

