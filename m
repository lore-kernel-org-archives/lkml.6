Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C444C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DED2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RXW/ro75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DED2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeJCXqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 19:46:22 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58730 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJCXqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 19:46:22 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w93GudO1023821;
        Wed, 3 Oct 2018 11:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538585799;
        bh=qScEYM5zHfqp+nd18kabQ7OmGSMnoLM0iLZW25e/4IA=;
        h=From:To:CC:Subject:Date;
        b=RXW/ro75udz3BwjysqkegU6xosUeScnlH0mccx06OcvhS4qrhYP1XSw8dVkELVmaq
         owh3YsgryG+AWPRRRDAsDY5/NptPonWXzBUoHFuA/MzdS8na1RDYQ5YTfea5vE6ovz
         EKzikkTmpHqrP02ewQiaf+wdcRH/JgWWaPXTTFOg=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w93Gudsv010195;
        Wed, 3 Oct 2018 11:56:39 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 3 Oct
 2018 11:56:39 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 3 Oct 2018 11:56:38 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w93GuZMH030968;
        Wed, 3 Oct 2018 11:56:36 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Brian Norris <computersforpeace@gmail.com>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/3] spi-nor: Add Octal SPI support
Date:   Wed, 3 Oct 2018 22:26:00 +0530
Message-ID: <20181003165603.2579-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for octal mode of mt35x flash. Also, adds
support for OSPI version of Cadence QSPI controller.

Based on top of patches adding basic support for mt35xu512aba here:
https://patchwork.ozlabs.org/cover/971437/

Vignesh R (3):
  mtd: spi-nor: Add Octal mode support for mt35xu512aba
  dt-bindings: cadence-quadspi: Add new compatible for AM654 SoC
  mtd: spi-nor: cadence-quadspi: Add support for Octal SPI controller

 .../devicetree/bindings/mtd/cadence-quadspi.txt       |  1 +
 drivers/mtd/spi-nor/cadence-quadspi.c                 |  9 +++++++++
 drivers/mtd/spi-nor/spi-nor.c                         | 11 ++++++++++-
 include/linux/mtd/spi-nor.h                           |  2 ++
 4 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.19.0

