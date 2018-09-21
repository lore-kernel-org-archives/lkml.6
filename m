Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82EFC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3E72154C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3E72154C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389676AbeIUPey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:34:54 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:29161 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389010AbeIUPey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:34:54 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8L9iYMa008894;
        Fri, 21 Sep 2018 11:46:30 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mmkmu38k0-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Sep 2018 11:46:30 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9E57B38;
        Fri, 21 Sep 2018 09:46:29 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 76A822AC3;
        Fri, 21 Sep 2018 09:46:29 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 21 Sep
 2018 11:46:29 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 21 Sep
 2018 11:46:28 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <benjamin.gaignard@linaro.org>, Gerald Baeza <gerald.baeza@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH V2 00/27] mmc: mmci: add sdmmc variant for stm32
Date:   Fri, 21 Sep 2018 11:45:54 +0200
Message-ID: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

The goal of this serie is to add support of sdmmc for stm32.
Be to able to add this new variant it is needed to do some changes in
mmci core:
-Internalize specific needs of legacy dmaengine.
-Create and setup dma_priv pointer
-Create generic callbacks which share some features (like cookie...)
 and call specific needs

change v3:
-remove __dma_inprogress rename
-remove bad space at end of "st,use-ckin"

change v2:
-rename to mmci_prep/unprep_data
-rename specific dma engine structure to mmci_dmae_next/priv
-follow "_" recommandation
-remove dma prefixe of mmci_dmae_priv fields

Ludovic Barre (27):
  mmc: mmci: internalize dma map/unmap into mmci dma functions
  mmc: mmci: internalize dma_inprogress into mmci dma functions
  mmc: mmci: convert dma_setup callback to return an int
  mmc: mmci: introduce dma_priv pointer to mmci_host
  mmc: mmci: move mmci next cookie to mci host
  mmc: mmci: merge prepare data functions
  mmc: mmci: add prepare/unprepare_data callbacks
  mmc: mmci: add get_next_data callback
  mmc: mmci: modify dma_setup callback
  mmc: mmci: add dma_release callback
  mmc: mmci: add dma_start callback
  mmc: mmci: add dma_finalize callback
  mmc: mmci: add dma_error callback
  mmc: mmci: add validate_data callback
  mmc: mmci: add set_clk/pwrreg callbacks
  mmc: mmci: add datactrl block size variant property
  mmc: mmci: expand startbiterr to irqmask and error check
  mmc: mmci: add variant properties to define cpsm & cmdresp bits
  mmc: mmci: add variant property to define dpsm bit
  mmc: mmci: add variant property to define irq pio mask
  mmc: mmci: add variant property to write datactrl before command
  mmc: mmci: add variant property to not read datacnt
  mmc: mmci: add variant property to request a reset
  mmc: mmci: add clock divider for stm32 sdmmc
  mmc: mmci: add stm32 sdmmc registers
  mmc: mmci: add DT bindings for STM32 sdmmc
  mmc: mmci: add stm32 sdmmc variant

 Documentation/devicetree/bindings/mmc/mmci.txt |  11 +
 drivers/mmc/host/Kconfig                       |  10 +
 drivers/mmc/host/Makefile                      |   1 +
 drivers/mmc/host/mmci.c                        | 646 +++++++++++++++++--------
 drivers/mmc/host/mmci.h                        | 147 +++++-
 drivers/mmc/host/mmci_qcom_dml.c               |  15 +-
 drivers/mmc/host/mmci_stm32_sdmmc.c            | 282 +++++++++++
 7 files changed, 880 insertions(+), 232 deletions(-)
 create mode 100644 drivers/mmc/host/mmci_stm32_sdmmc.c

-- 
2.7.4

