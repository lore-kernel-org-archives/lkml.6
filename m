Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47218C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58942150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58942150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbeISSOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:14:05 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60404 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727885AbeISSOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:14:05 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DF63F2001F4;
        Wed, 19 Sep 2018 14:36:17 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D2E3F20016E;
        Wed, 19 Sep 2018 14:36:17 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.97])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8F83C2061D;
        Wed, 19 Sep 2018 14:36:16 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     roy.pledge@nxp.com, madalin.bucur@nxp.com, davem@davemloft.net,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 00/21] SMMU enablement for NXP LS1043A and LS1046A
Date:   Wed, 19 Sep 2018 15:35:52 +0300
Message-Id: <20180919123613.15092-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

This patch series adds SMMU support for NXP LS1043A and LS1046A chips
and consists mostly in important driver fixes and the required device
tree updates. It touches several subsystems and consists of three main
parts:
 - changes in soc/drivers/fsl/qbman drivers adding iommu mapping of
   reserved memory areas, fixes and defered probe support
 - changes in drivers/net/ethernet/freescale/dpaa_eth drivers
   consisting in misc dma mapping related fixes and probe ordering
 - addition of the actual arm smmu device tree node together with
   various adjustments to the device trees

Performance impact

    Running iperf benchmarks in a back-to-back setup (both sides
    having smmu enabled) on a 10GBps port show an important
    networking performance degradation of around %40 (9.48Gbps
    linerate vs 5.45Gbps). If you need performance but without
    SMMU support you can use "iommu.passthrough=1" to disable
    SMMU.

USB issue and workaround

    There's a problem with the usb controllers in these chips
    generating smaller, 40-bit wide dma addresses instead of the 48-bit
    supported at the smmu input. So you end up in a situation where the
    smmu is mapped with 48-bit address translations, but the device
    generates transactions with clipped 40-bit addresses, thus smmu
    context faults are triggered. I encountered a similar situation for
    mmc that I  managed to fix in software [1] however for USB I did not
    find a proper place in the code to add a similar fix. The only
    workaround I found was to add this kernel parameter which limits the
    usb dma to 32-bit size: "xhci-hcd.quirks=0x800000".
    This workaround if far from ideal, so any suggestions for a code
    based workaround in this area would be greatly appreciated.

The patch set is based on net-next so, if generally agreed, I'd suggest
to get the patches through the netdev tree after getting all the Acks.

[1] https://patchwork.kernel.org/patch/10506627/

Laurentiu Tudor (21):
  soc/fsl/qman: fixup liodns only on ppc targets
  soc/fsl/bman: map FBPR area in the iommu
  soc/fsl/qman: map FQD and PFDR areas in the iommu
  soc/fsl/qman-portal: map CENA area in the iommu
  soc/fsl/qbman: add APIs to retrieve the probing status
  soc/fsl/qman_portals: defer probe after qman's probe
  soc/fsl/bman_portals: defer probe after bman's probe
  soc/fsl/qbman_portals: add APIs to retrieve the probing status
  fsl/fman: backup and restore ICID registers
  fsl/fman: add API to get the device behind a fman port
  dpaa_eth: defer probing after qbman
  dpaa_eth: base dma mappings on the fman rx port
  dpaa_eth: fix iova handling for contiguous frames
  dpaa_eth: fix iova handling for sg frames
  dpaa_eth: fix SG frame cleanup
  arm64: dts: ls1046a: add smmu node
  arm64: dts: ls1043a: add smmu node
  arm64: dts: ls104xa: set mask to drop TBU ID from StreamID
  arm64: dts: ls104x: add missing dma ranges property
  arm64: dts: ls104x: add iommu-map to pci controllers
  arm64: dts: ls104x: make dma-coherent global to the SoC

 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  52 ++++++-
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |  48 +++++++
 .../net/ethernet/freescale/dpaa/dpaa_eth.c    | 136 ++++++++++++------
 drivers/net/ethernet/freescale/fman/fman.c    |  35 ++++-
 drivers/net/ethernet/freescale/fman/fman.h    |   4 +
 .../net/ethernet/freescale/fman/fman_port.c   |  14 ++
 .../net/ethernet/freescale/fman/fman_port.h   |   2 +
 drivers/soc/fsl/qbman/bman_ccsr.c             |  23 +++
 drivers/soc/fsl/qbman/bman_portal.c           |  20 ++-
 drivers/soc/fsl/qbman/qman_ccsr.c             |  30 ++++
 drivers/soc/fsl/qbman/qman_portal.c           |  35 +++++
 include/soc/fsl/bman.h                        |  16 +++
 include/soc/fsl/qman.h                        |  17 +++
 13 files changed, 379 insertions(+), 53 deletions(-)

-- 
2.17.1

