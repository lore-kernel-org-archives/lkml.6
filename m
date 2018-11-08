Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8D6C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2727D2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2727D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeKHTtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:49:09 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:39346 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726963AbeKHTtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 14:49:06 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA8A8TZM010849;
        Thu, 8 Nov 2018 04:14:15 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2nm9308nah-1;
        Thu, 08 Nov 2018 04:14:15 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 9F164611C8B0;
        Thu,  8 Nov 2018 04:14:14 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 8 Nov 2018
 10:14:14 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wA8AE55r028949; Thu,
 8 Nov 2018 10:14:05 GMT
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <broonie@kernel.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
Subject: [PATCH v4 0/6] Lochnagar Driver
Date:   Thu, 8 Nov 2018 10:13:59 +0000
Message-ID: <20181108101405.14062-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1811080089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version 4 of this series the big change here is splitting up
the device tree into having a node for each of the MFD child
drivers. More detailed change logs are given on each patch.

Lee doesn't like the idea of having both mfd_add_devices and
of_platform_populate in the MFD driver. Stephen had asked on a
previous spin to move the fixed clocks out of the clock driver
into device tree and there is a fixed regulator as well that
is specified through device tree. Those require having the
of_platform_populate there which left the only solution being
to move the MFD children into device tree as well.

I have moved the relevant DT settings to be attached to their
respective nodes in DT although I guess another option would
be to leave all the config on the parent node and just use
the child nodes for binding in the drivers, but I decided that
was less consistent with other DT usage. But could switch over
to it if people prefer.

Thanks,
Charles

Charles Keepax (6):
  regulator: lochnagar: Explicitly include register headers
  regulator: lochnagar: Move driver to binding from DT
  mfd: lochnagar: Add initial binding documentation
  mfd: lochnagar: Add support for the Cirrus Logic Lochnagar
  clk: lochnagar: Add support for the Cirrus Logic Lochnagar
  pinctrl: lochnagar: Add support for the Cirrus Logic Lochnagar

 .../devicetree/bindings/clock/cirrus,lochnagar.txt |   89 ++
 .../devicetree/bindings/mfd/cirrus,lochnagar.txt   |   70 ++
 .../bindings/pinctrl/cirrus,lochnagar.txt          |  141 +++
 .../bindings/regulator/cirrus,lochnagar.txt        |   80 ++
 MAINTAINERS                                        |   17 +
 drivers/clk/Kconfig                                |    7 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-lochnagar.c                        |  360 ++++++
 drivers/mfd/Kconfig                                |    8 +
 drivers/mfd/Makefile                               |    2 +
 drivers/mfd/lochnagar-i2c.c                        |  394 +++++++
 drivers/pinctrl/cirrus/Kconfig                     |   10 +
 drivers/pinctrl/cirrus/Makefile                    |    2 +
 drivers/pinctrl/cirrus/pinctrl-lochnagar.c         | 1145 ++++++++++++++++++++
 drivers/pinctrl/cirrus/pinctrl-lochnagar.h         |  112 ++
 drivers/regulator/lochnagar-regulator.c            |   10 +-
 include/dt-bindings/clk/lochnagar.h                |   26 +
 include/dt-bindings/pinctrl/lochnagar.h            |  132 +++
 include/linux/mfd/lochnagar.h                      |   55 +
 include/linux/mfd/lochnagar1_regs.h                |  157 +++
 include/linux/mfd/lochnagar2_regs.h                |  253 +++++
 21 files changed, 3070 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/cirrus,lochnagar.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/cirrus,lochnagar.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/cirrus,lochnagar.txt
 create mode 100644 drivers/clk/clk-lochnagar.c
 create mode 100644 drivers/mfd/lochnagar-i2c.c
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-lochnagar.c
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-lochnagar.h
 create mode 100644 include/dt-bindings/clk/lochnagar.h
 create mode 100644 include/dt-bindings/pinctrl/lochnagar.h
 create mode 100644 include/linux/mfd/lochnagar.h
 create mode 100644 include/linux/mfd/lochnagar1_regs.h
 create mode 100644 include/linux/mfd/lochnagar2_regs.h

-- 
2.11.0

