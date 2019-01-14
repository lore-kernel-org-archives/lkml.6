Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD66C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800CE20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfANOmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:42:44 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:7999 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726542AbfANOmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:42:44 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0EEaOnt031477;
        Mon, 14 Jan 2019 15:42:38 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2pybxy0gq2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 14 Jan 2019 15:42:38 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 849363A;
        Mon, 14 Jan 2019 14:42:37 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 625B052AB;
        Mon, 14 Jan 2019 14:42:37 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 14 Jan
 2019 15:42:37 +0100
Received: from localhost (10.201.20.122) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 14 Jan 2019 15:42:36
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <broonie@kernel.org>, <robh@kernel.org>, <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, <loic.pallardy@st.com>,
        <benjamin.gaignard@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [RFC 0/7] Introduce bus domains controller framework
Date:   Mon, 14 Jan 2019 15:41:55 +0100
Message-ID: <20190114144202.27315-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this framework is to offer an interface for the
hardware blocks controlling bus accesses rights.

Bus domains controllers are typically used to control if a
hardware block can perform read or write operations on bus.

Smarter domains controllers could be able to define accesses
rights per hardware blocks to control where they can read
or write.

Domains controller configurations are provided in device node,
parsed by the framework and send to the driver to apply them.
Each controller may need different number and type of inputs
to configure a domain so device-tree properties size have to
be define by using "#domainctrl-cells".
Domains configurations properties have to be named "domainsctrl-X"
on device node.
"domainsctrl-names" keyword can also be used to give a name to
a specific configuration.

An example of bus domains controller is STM32 ETZPC hardware block
which got 3 domains:
- secure: hardware blocks are only accessible by software running on trust
  zone.
- non-secure: hardware blocks are accessible by non-secure software (i.e.
  linux kernel).
- coprocessor: hardware blocks are only accessible by the corpocessor.
Up to 94 hardware blocks of the soc could be managed by ETZPC and 
assigned to one of the three domains.

It is an RFC, comments are welcome to help to create this framework, thanks.
Benjamin

Benjamin Gaignard (7):
  devicetree: bindings: Document domains controller bindings
  domainsctrl: Introduce domains controller framework
  base: Add calls to domains controller
  devicetree: bindings: domainsctrl: Add STM32 ETZPC bindings
  bus: domainsctrl: Add driver for STM32 ETZPC controller
  ARM: dts: stm32: Add domainsctrl node for stm32mp157 SoC
  ARM: dts: stm32: enable domains controller node on stm32mp157c-ed1

 .../bindings/bus/domains/domainsctrl.txt           |  35 +++
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
 13 files changed, 556 insertions(+)
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

