Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id TRt9AXilGFt5agAAmS7hNA
	; Thu, 07 Jun 2018 03:24:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E5E6E608BA; Thu,  7 Jun 2018 03:24:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 723BB60452;
	Thu,  7 Jun 2018 03:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 723BB60452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753538AbeFGDYg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 23:24:36 -0400
Received: from inva021.nxp.com ([92.121.34.21]:33467 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753142AbeFGDYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 23:24:34 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DB4C92001CE;
        Thu,  7 Jun 2018 05:24:32 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9BD042000F7;
        Thu,  7 Jun 2018 05:24:32 +0200 (CEST)
Received: from az84smr01.freescale.net (az84smr01.freescale.net [10.64.34.197])
        by inv1260.na-rdc02.nxp.com (Postfix) with ESMTP id 50B1240A56;
        Wed,  6 Jun 2018 20:24:32 -0700 (MST)
Received: from titan.ap.freescale.net ([10.192.208.233])
        by az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id w573OSwN023286;
        Wed, 6 Jun 2018 20:24:29 -0700
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org, madalin.bucur@nxp.com,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v2, 00/10] Support DPAA PTP clock and timestamping
Date: Thu,  7 Jun 2018 11:22:46 +0800
Message-Id: <20180607032256.39802-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is to support DPAA FMAN PTP clock and HW timestamping.
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
  fsl/fman_port: support getting timestamp field
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
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |  101 ++++++++++++++++++-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.h     |    3 +
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |   39 ++++++++
 drivers/net/ethernet/freescale/fman/fman.c         |    3 +-
 drivers/net/ethernet/freescale/fman/fman.h         |    1 +
 drivers/net/ethernet/freescale/fman/fman_dtsec.c   |   27 +++++
 drivers/net/ethernet/freescale/fman/fman_dtsec.h   |    1 +
 drivers/net/ethernet/freescale/fman/fman_memac.c   |    5 +
 drivers/net/ethernet/freescale/fman/fman_memac.h   |    1 +
 drivers/net/ethernet/freescale/fman/fman_port.c    |   12 +++
 drivers/net/ethernet/freescale/fman/fman_port.h    |    3 +
 drivers/net/ethernet/freescale/fman/fman_tgec.c    |   21 ++++
 drivers/net/ethernet/freescale/fman/fman_tgec.h    |    1 +
 drivers/net/ethernet/freescale/fman/mac.c          |    3 +
 drivers/net/ethernet/freescale/fman/mac.h          |    1 +
 drivers/ptp/Kconfig                                |    2 +-
 drivers/ptp/ptp_qoriq.c                            |  104 ++++++++++++-------
 include/linux/fsl/ptp_qoriq.h                      |   38 ++++++--
 26 files changed, 375 insertions(+), 115 deletions(-)
