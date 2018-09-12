Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B947C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327FE2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327FE2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeILOD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:03:29 -0400
Received: from inva020.nxp.com ([92.121.34.13]:60192 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbeILOD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:03:29 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A0B131A0112;
        Wed, 12 Sep 2018 10:59:53 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 941A81A0102;
        Wed, 12 Sep 2018 10:59:53 +0200 (CEST)
Received: from enigma.ea.freescale.net (enigma.ea.freescale.net [10.171.81.110])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 149A8205F0;
        Wed, 12 Sep 2018 10:59:53 +0200 (CEST)
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Roy Pledge <roy.pledge@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/12] crypto: caam - add DPAA2 (DPSECI) driver
Date:   Wed, 12 Sep 2018 11:59:25 +0300
Message-Id: <20180912085937.22489-1-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch set adds the CAAM crypto engine driver for DPAA2
(Data Path Acceleration Architecture v2) found on ARMv8-based SoCs
like LS1088A, LS2088A, LX2160A.

v1 -> v2:
5/12 - new patch fixing sparse endianness-related warnings
2/12 - changed commit message, since it's not a straightforward revert
3/12, 8/12, 11/12 - fixed sparse and compiler warnings

Previous versions:
v1: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1763549.html
RFC: https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg27290.html

Driver consists of:
-DPSECI (Data Path SEC Interface) backend - low-level API that allows
to manage DPSECI devices (DPAA2 objects) that sit on
the Management Complex (MC) fsl-mc bus
-algorithms frontend - AEAD, skcipher and ahash algorithms implementation

Patches 1-4 are fsl-mc bus and DPIO dependencies.
Stuart, Laurentiu, Leo, Roy, please review the patches and let me know
if you have anything against going with them through the cryptodev tree.

Patch 5 fixes sparse endianness-related warnings in regs.h helper functions.

Patches 6-11 are the core of the patch set, adding the driver.
For symmetric encryption the new skcipher interface is used.

Patch 12 enables driver on arm64. It will be built only if dependency
on DPIO (CONFIG_FSL_MC_DPIO) is satisfied.

Note: multiple modprobe/rmmod won't work without the following patches
[5/7,v7] bus/fsl-mc: support dma configure for devices on fsl-mc bus
https://patchwork.kernel.org/patch/10594179
[7/7,v7] arm64: dts: ls208xa: comply with the iommu map binding for fsl_mc
https://patchwork.kernel.org/patch/10594171
(for LS1088A a similar DT update is needed)

Thanks,
Horia

Horia Geantă (12):
  bus: fsl-mc: add support for dpseci device type
  soc: fsl: dpio: add back some frame queue functions
  soc: fsl: dpio: add frame list format support
  soc: fsl: dpio: add congestion notification support
  crypto: caam - fix implicit casts in endianness helpers
  crypto: caam - add DPAA2-CAAM (DPSECI) backend API
  crypto: caam - add Queue Interface v2 error codes
  crypto: caam/qi2 - add DPAA2-CAAM driver
  crypto: caam/qi2 - add skcipher algorithms
  crypto: caam - export ahash shared descriptor generation
  crypto: caam/qi2 - add support for ahash algorithms
  arm64: defconfig: enable CAAM crypto engine on QorIQ DPAA2 SoCs

 arch/arm64/configs/defconfig        |    1 +
 drivers/bus/fsl-mc/fsl-mc-bus.c     |    5 +
 drivers/crypto/Makefile             |    2 +-
 drivers/crypto/caam/Kconfig         |   55 +-
 drivers/crypto/caam/Makefile        |   10 +-
 drivers/crypto/caam/caamalg_qi2.c   | 5165 +++++++++++++++++++++++++++++++++++
 drivers/crypto/caam/caamalg_qi2.h   |  223 ++
 drivers/crypto/caam/caamhash.c      |   79 +-
 drivers/crypto/caam/caamhash_desc.c |   80 +
 drivers/crypto/caam/caamhash_desc.h |   21 +
 drivers/crypto/caam/compat.h        |    1 +
 drivers/crypto/caam/dpseci.c        |  426 +++
 drivers/crypto/caam/dpseci.h        |  333 +++
 drivers/crypto/caam/dpseci_cmd.h    |  149 +
 drivers/crypto/caam/error.c         |   79 +-
 drivers/crypto/caam/error.h         |    6 +-
 drivers/crypto/caam/regs.h          |   30 +-
 drivers/soc/fsl/dpio/dpio-service.c |   58 +
 include/linux/fsl/mc.h              |    6 +
 include/soc/fsl/dpaa2-fd.h          |  242 ++
 include/soc/fsl/dpaa2-global.h      |   15 +
 include/soc/fsl/dpaa2-io.h          |    4 +
 22 files changed, 6885 insertions(+), 105 deletions(-)
 create mode 100644 drivers/crypto/caam/caamalg_qi2.c
 create mode 100644 drivers/crypto/caam/caamalg_qi2.h
 create mode 100644 drivers/crypto/caam/caamhash_desc.c
 create mode 100644 drivers/crypto/caam/caamhash_desc.h
 create mode 100644 drivers/crypto/caam/dpseci.c
 create mode 100644 drivers/crypto/caam/dpseci.h
 create mode 100644 drivers/crypto/caam/dpseci_cmd.h

-- 
2.16.2

