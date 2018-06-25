Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C24AC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F93E208EB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F93E208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933693AbeFYMjM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:39:12 -0400
Received: from inva021.nxp.com ([92.121.34.21]:41974 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932246AbeFYMjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:39:10 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 100BE20000A;
        Mon, 25 Jun 2018 14:39:09 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D0587200079;
        Mon, 25 Jun 2018 14:39:08 +0200 (CEST)
Received: from az84smr01.freescale.net (az84smr01.freescale.net [10.64.34.197])
        by inv1260.na-rdc02.nxp.com (Postfix) with ESMTP id 4599840C72;
        Mon, 25 Jun 2018 05:39:08 -0700 (MST)
Received: from titan.ap.freescale.net ([10.192.208.233])
        by az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id w5PCd34L025070;
        Mon, 25 Jun 2018 05:39:04 -0700
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     netdev@vger.kernel.org, madalin.bucur@nxp.com,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v4, 00/10] Support DPAA PTP clock and timestamping
Date:   Mon, 25 Jun 2018 20:37:06 +0800
Message-Id: <20180625123716.28993-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is to support DPAA FMAN PTP clock and HW timestamping.
It had been verified on both ARM platform and PPC platform.
- The patch #1 to patch #5 are to support DPAA FMAN 1588 timer in
  ptp_qoriq driver.
- The patch #6 to patch #10 are to add HW timestamping support in
  DPAA ethernet driver.

Yangbo Lu (10):
  fsl/fman: share the event interrupt
  ptp: support DPAA FMan 1588 timer in ptp_qoriq
  dt-binding: ptp_qoriq: add DPAA FMan support
  powerpc/mpc85xx: move ptp timer out of fman in dts
  arm64: dts: fsl: move ptp timer out of fman
  fsl/fman: add set_tstamp interface
  fsl/fman_port: support getting timestamp
  fsl/fman: define frame description command UPD
  dpaa_eth: add support for hardware timestamping
  dpaa_eth: add the get_ts_info interface for ethtool

 Documentation/devicetree/bindings/net/fsl-fman.txt |   25 +-----
 .../devicetree/bindings/ptp/ptp-qoriq.txt          |   15 +++-
 arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi   |   14 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi        |   14 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi        |   14 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi       |   14 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi       |   14 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi      |   14 ++-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |   88 ++++++++++++++++-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.h     |    3 +
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |   39 ++++++++
 drivers/net/ethernet/freescale/fman/fman.c         |    3 +-
 drivers/net/ethernet/freescale/fman/fman.h         |    1 +
 drivers/net/ethernet/freescale/fman/fman_dtsec.c   |   27 +++++
 drivers/net/ethernet/freescale/fman/fman_dtsec.h   |    1 +
 drivers/net/ethernet/freescale/fman/fman_memac.c   |    5 +
 drivers/net/ethernet/freescale/fman/fman_memac.h   |    1 +
 drivers/net/ethernet/freescale/fman/fman_port.c    |   12 +++
 drivers/net/ethernet/freescale/fman/fman_port.h    |    2 +
 drivers/net/ethernet/freescale/fman/fman_tgec.c    |   21 ++++
 drivers/net/ethernet/freescale/fman/fman_tgec.h    |    1 +
 drivers/net/ethernet/freescale/fman/mac.c          |    3 +
 drivers/net/ethernet/freescale/fman/mac.h          |    1 +
 drivers/ptp/Kconfig                                |    2 +-
 drivers/ptp/ptp_qoriq.c                            |  104 ++++++++++++-------
 include/linux/fsl/ptp_qoriq.h                      |   38 ++++++--
 26 files changed, 361 insertions(+), 115 deletions(-)

