Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE5BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E4221533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E4221533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbeI0EXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:23:04 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:56964 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeI0EXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:23:04 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42LBrv15JVz1qxx6;
        Thu, 27 Sep 2018 00:07:59 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42LBrt5tXDz1qqkx;
        Thu, 27 Sep 2018 00:07:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 0kyGAGyhhrvG; Thu, 27 Sep 2018 00:07:56 +0200 (CEST)
X-Auth-Info: e56q0BqvYIfK2/+kHTuL3GAd2vOPcjSNGFpQLrEB5gw=
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 27 Sep 2018 00:07:56 +0200 (CEST)
From:   Lukasz Majewski <lukma@denx.de>
To:     Frieder Schrempf <frieder.schrempf@exceet.de>,
        boris.brezillon@bootlin.com, Mark Rutland <mark.rutland@arm.com>
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, yogeshnarayan.gaur@nxp.com,
        richard@nod.at, Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        prabhakar.kushwaha@nxp.com, han.xu@nxp.com, broonie@kernel.org,
        david.wolfe@nxp.com, computersforpeace@gmail.com,
        dwmw2@infradead.org, albert.aribaud@3adev.fr,
        Lukasz Majewski <lukma@denx.de>
Subject: [RFC/RFT PATCH v1 0/9] mtd: fsl: quadspi: Fixes for fsl-quadspi.c driver (vybrid HW)
Date:   Thu, 27 Sep 2018 00:07:30 +0200
Message-Id: <20180926220739.620-1-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please find following set of patches, which provide improved behaviour
of the fsl-quadspi.c driver on Vybrid vf610 HW.

Below code is based on previous work done by Albert ARIBAUD:
https://patchwork.ozlabs.org/patch/675401/

I've cleaned up the code a bit, make separate patches, exclude not
needed parts and port it to v4.19-rc3.

After applying those patches, the quadspi controller on vf610 works
with UBI/UBIFS.
The problem is with some corner case writes to raw MTD device
(like writing 1023B with single byte writes). Those fail sometimes.

Regression tests can be found in the following repository:
https://github.com/lmajewski/tests-spi/tree/master/tests

(Please read README.txt).

The NXP's community thread regarding HW issues in this block on
the vf610:
https://community.nxp.com/thread/485139

Maybe those patches will be helpful with the new, work in progress
driver for spi-fsl-qspi.c

Lukasz Majewski (9):
  Revert "mtd: fsl-quadspi: Rename SEQID_QUAD_READ to SEQID_READ"
  mtd: qspi: Provide quirk to read only half of RX buffer (NXP's vybrid)
  mtd: spi: Do not setup the default seqid as we got it set for DUAL and
    QUAD
  mtd: spi: Modify the HW capability mask according to supported RX
    lanes
  mtd: spi: Provide LUT entry to perform DUAL read
  mtd: spi: Enhance the fsl_qspi_read() method to support DUAL and QUAD
  mtd: spi: Add SPI_NOR_DUAL_READ property for the 'n25q128a13' Micron
    memory
  mtd: spi: Allocate memory corresponding to maximal fsl-quadspi.c
    controller area
  mtd: spi: Skip reading the Serial Flash Discoverable Parameters

 drivers/mtd/spi-nor/fsl-quadspi.c | 103 +++++++++++++++++++++++++++++---------
 drivers/mtd/spi-nor/spi-nor.c     |   2 +-
 2 files changed, 79 insertions(+), 26 deletions(-)

-- 
2.11.0

