Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9E8C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4722087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbfB0MND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:13:03 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:57985 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729973AbfB0MNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 07:13:02 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1RC64sh028656;
        Wed, 27 Feb 2019 13:12:44 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qtvtx68gh-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 27 Feb 2019 13:12:44 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 78A6634;
        Wed, 27 Feb 2019 12:12:43 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2BDBE5266;
        Wed, 27 Feb 2019 12:12:43 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 27 Feb
 2019 13:12:43 +0100
Received: from localhost (10.201.20.122) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 27 Feb 2019 13:12:42
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <broonie@kernel.org>, <robh@kernel.org>, <arnd@arndb.de>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <fabio.estevam@nxp.com>
CC:     <linux-kernel@vger.kernel.org>, <loic.pallardy@st.com>,
        <benjamin.gaignard@linaro.org>, <kernel@pengutronix.de>,
        <linux-imx@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 0/7] Introduce bus domains controller framework
Date:   Wed, 27 Feb 2019 13:12:25 +0100
Message-ID: <20190227121232.24873-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bus domains controllers allow to divided system on chip into multiple domains
that can be used to select by who hardware blocks could be accessed.
A domain could be a cluster of CPUs (or coprocessors), a range of addresses or
a group of hardware blocks.

Framework architecture is inspirated by pinctrl framework:
- a default configuration could be applied before bind the driver
- configurations could be apllied dynamically by drivers
- device node provides the bus domains configurations

An example of bus domains controller is STM32 ETZPC hardware block
which got 3 domains:
- secure: hardware blocks are only accessible by software running on trust
  zone.
- non-secure: hardware blocks are accessible by non-secure software (i.e.
  linux kernel).
- coprocessor: hardware blocks are only accessible by the corpocessor.
Up to 94 hardware blocks of the soc could be managed by ETZPC and 
assigned to one of the three domains.

At least two other hardware blocks can take benefits of this:
- ARM TZC-400: http://infocenter.arm.com/help/index.jsp?topic=/com.arm.d...
  which is able to manage up to 8 regions in address space.
- IMX Ressource Domain Controller (RDC): supports four domains and up to eight regions 

This version has been rebased on top of v5.0-rc8.

Benjamin

Benjamin Gaignard (7):
  devicetree: bindings: Document domains controller bindings
  domainsctrl: Introduce domains controller framework
  base: Add calls to domains controller
  devicetree: bindings: domainsctrl: Add STM32 ETZPC bindings
  bus: domainsctrl: Add driver for STM32 ETZPC controller
  ARM: dts: stm32: Add domainsctrl node for stm32mp157 SoC
  ARM: dts: stm32: enable domains controller node on stm32mp157c-ed1

 .../bindings/bus/domains/domainsctrl.txt           |  55 +++++
 .../bindings/bus/domains/st,stm32-etzpc.txt        |  14 ++
 arch/arm/boot/dts/stm32mp157c-ev1.dts              |   2 +
 arch/arm/boot/dts/stm32mp157c.dtsi                 |   7 +
 drivers/base/dd.c                                  |   9 +
 drivers/bus/Kconfig                                |   2 +
 drivers/bus/Makefile                               |   2 +
 drivers/bus/domains/Kconfig                        |  14 ++
 drivers/bus/domains/Makefile                       |   2 +
 drivers/bus/domains/domainsctrl.c                  | 234 +++++++++++++++++++++
 drivers/bus/domains/stm32-etzpc.c                  | 140 ++++++++++++
 include/dt-bindings/bus/domains/stm32-etzpc.h      |  25 +++
 include/linux/domainsctrl.h                        |  70 ++++++
 13 files changed, 576 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/domains/domainsctrl.txt
 create mode 100644 Documentation/devicetree/bindings/bus/domains/st,stm32-etzpc.txt
 create mode 100644 drivers/bus/domains/Kconfig
 create mode 100644 drivers/bus/domains/Makefile
 create mode 100644 drivers/bus/domains/domainsctrl.c
 create mode 100644 drivers/bus/domains/stm32-etzpc.c
 create mode 100644 include/dt-bindings/bus/domains/stm32-etzpc.h
 create mode 100644 include/linux/domainsctrl.h

-- 
2.15.0

