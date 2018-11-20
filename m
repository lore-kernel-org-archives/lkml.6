Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A40C46462
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C4820685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C4820685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbeKUEqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:46:05 -0500
Received: from inva021.nxp.com ([92.121.34.21]:47456 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728516AbeKUEqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:46:05 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 933292000A1;
        Tue, 20 Nov 2018 19:15:35 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8690E200003;
        Tue, 20 Nov 2018 19:15:35 +0100 (CET)
Received: from fsr-ub1664-016.ea.freescale.net (fsr-ub1664-016.ea.freescale.net [10.171.71.216])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 4697320621;
        Tue, 20 Nov 2018 19:15:35 +0100 (CET)
From:   Claudiu Manoil <claudiu.manoil@nxp.com>
To:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, alexandru.marginean@nxp.com,
        catalin.horghidan@nxp.com
Subject: [PATCH net-next v2 0/4] Introduce ENETC ethernet drivers
Date:   Tue, 20 Nov 2018 20:15:30 +0200
Message-Id: <1542737734-21756-1-git-send-email-claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ENETC is a multi-port virtualized Ethernet controller supporting GbE
designs and Time-Sensitive Networking (TSN) functionality.
ENETC is operating as an SR-IOV multi-PF capable Root Complex Integrated
Endpoint (RCIE).  As such, it contains multiple physical (PF) and virtual
(VF) PCIe functions, discoverable by standard PCI Express.

The patch series adds basic enablement for these otherwise standard
buffer descriptor (BD) ring based ethernet devices (PCIe PFs and VFs),
currently included in the 64-bit dual ARMv8 processors LS1028A SoC.
The driver is portable to 32-bit designs, and it's independent of CPU
endianness.

Contributors:
Alex Marginean <alexandru.marginean@nxp.com>
Catalin Horghidan <catalin.horghidan@nxp.com>

TODO list:
* IEEE 1588 PTP support;
* TSN support;
* MDIO support and VF link management;
* power management support;
* flow control support;
* TC offloading with h/w MQPRIO;
* interrupt coalescing, configurable BD ring sizes, and other usual
config options if missing.

Claudiu Manoil (4):
  enetc: Introduce basic PF and VF ENETC ethernet drivers
  enetc: Add ethtool statistics
  enetc: Add vf to pf messaging support
  enetc: Add RFS and RSS support

 MAINTAINERS                                        |    6 +
 drivers/net/ethernet/freescale/Kconfig             |    1 +
 drivers/net/ethernet/freescale/Makefile            |    1 +
 drivers/net/ethernet/freescale/enetc/Kconfig       |   19 +
 drivers/net/ethernet/freescale/enetc/Makefile      |   15 +
 drivers/net/ethernet/freescale/enetc/enetc.c       | 1575 ++++++++++++++++++++
 drivers/net/ethernet/freescale/enetc/enetc.h       |  229 +++
 drivers/net/ethernet/freescale/enetc/enetc_cbdr.c  |  210 +++
 .../net/ethernet/freescale/enetc/enetc_ethtool.c   |  597 ++++++++
 drivers/net/ethernet/freescale/enetc/enetc_hw.h    |  519 +++++++
 drivers/net/ethernet/freescale/enetc/enetc_msg.c   |  164 ++
 drivers/net/ethernet/freescale/enetc/enetc_pf.c    |  921 ++++++++++++
 drivers/net/ethernet/freescale/enetc/enetc_pf.h    |   49 +
 drivers/net/ethernet/freescale/enetc/enetc_vf.c    |  255 ++++
 14 files changed, 4561 insertions(+)
 create mode 100644 drivers/net/ethernet/freescale/enetc/Kconfig
 create mode 100644 drivers/net/ethernet/freescale/enetc/Makefile
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc.h
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_cbdr.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_hw.h
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_msg.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_pf.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_pf.h
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_vf.c

-- 
2.7.4

