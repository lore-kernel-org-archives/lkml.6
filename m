Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D00CCC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9BB208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9BB208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933919AbeFLNQn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:16:43 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57495 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933864AbeFLNQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:16:39 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5CDE5IF017839;
        Tue, 12 Jun 2018 15:15:54 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2jjegrr42r-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 12 Jun 2018 15:15:54 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C28E33F;
        Tue, 12 Jun 2018 13:15:49 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 94A2AA54A;
        Tue, 12 Jun 2018 13:15:49 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.44) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 12 Jun
 2018 15:15:49 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 12 Jun
 2018 15:15:47 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 00/19] mmc: mmci: add stm32 sdmmc variant
Date:   Tue, 12 Jun 2018 15:14:21 +0200
Message-ID: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-12_01:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch series adapts mmci driver to add support for stm32
sdmmc variant. stm32h7 SoC integrates the first revision of
stm32 sdmmc.

This series is composed of 3 parts:
-Prepare mmci driver to manage dma interfaces by adding property.
 New mmci dma API is defined according to the legacy needs.
-Adapt mmci driver to dedicated constraints of stm32 sdmmc variant,
 defined under some specific properties.
-Add stm32 sdmmc variant. As Internal DMA way satisfies data
transfer, the mmci driver hasn't been modified for pio_read/write.
Specific adds-ons to stm32 sdmmc:
 + registers
 + clk/power functions
 + idma interface

Ludovic Barre (19):
  mmc: mmci: regroup and define dma operations
  mmc: mmci: merge qcom dml feature into mmci dma
  mmc: mmci: add datactrl block size variant property
  mmc: mmci: expand startbiterr to irqmask and error check
  mmc: mmci: allow to overwrite clock/power procedure to specific
    variant
  mmc: mmci: add variant properties to define cpsm & cmdresp bits
  mmc: mmci: add variant property to define dpsm bit
  mmc: mmci: add variant property to define irq pio mask
  mmc: mmci: add variant property to write datactrl before command
  mmc: mmci: add variant property to allow remain data
  mmc: mmci: add variant property to check specific data constraint
  mmc: mmci: add variant property to request a reset
  mmc: mmci: send stop cmd if a data command fail
  mmc: mmci: add clock divider for stm32 sdmmc
  mmc: mmci: add stm32 sdmmc registers
  mmc: mmci: add DT bindings for STM32 sdmmc
  mmc: mmci: add stm32 sdmmc idma support
  mmc: mmci: add specific clk/pwr procedure for stm32 sdmmc
  mmc: mmci: add stm32 sdmmc variant

 Documentation/devicetree/bindings/mmc/mmci.txt |  11 +
 drivers/mmc/host/Makefile                      |   3 +-
 drivers/mmc/host/mmci.c                        | 846 +++++++++++--------------
 drivers/mmc/host/mmci.h                        | 237 ++++++-
 drivers/mmc/host/mmci_dma.c                    | 780 +++++++++++++++++++++++
 drivers/mmc/host/mmci_dma.h                    |  33 +
 drivers/mmc/host/mmci_qcom_dml.c               | 177 ------
 drivers/mmc/host/mmci_qcom_dml.h               |  31 -
 8 files changed, 1410 insertions(+), 708 deletions(-)
 create mode 100644 drivers/mmc/host/mmci_dma.c
 create mode 100644 drivers/mmc/host/mmci_dma.h
 delete mode 100644 drivers/mmc/host/mmci_qcom_dml.c
 delete mode 100644 drivers/mmc/host/mmci_qcom_dml.h

-- 
2.7.4

