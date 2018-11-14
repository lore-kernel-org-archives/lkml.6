Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524A2C07E85
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1028022419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Z7uuSJAp";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="LmIqKd91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1028022419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733312AbeKOB23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:28:29 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:38498 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732485AbeKOB22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:28:28 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAEFNoNT016134;
        Wed, 14 Nov 2018 07:24:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=vMAkG/QU0aoUyLXr+ZPvnQE6ttn+KqMxi7f355iFW3M=;
 b=Z7uuSJApbr95lPz0Uk6YgAFFUwZkLHpGvVhWgI6zYSWqG2oAd46ahrHKCC9MqBqbb/kb
 k+N19Wwku9Vyqr1nggNtfC4tr2jZQPCceGhTmUi1VXgLHoczirkrbfzAgzLziimRiC+Z
 6LaKkJAzhXzvk+KnnGtBjSq6pjPfC18MqW73I4KUpNFV4Zn1p/H8noMdfQGTnBkG6j0U
 QNNWNQq91G2Cn8oIVDR6DITZwQ+GY7UCfS6ANnHOl7jkJAw2DzzQp7xzF+TGpSDgv4dF
 YFLHF5Gof0Z7O/mVxnZpgboMPp2sL+NCpUQ6vzclC8NV2wY3UVx8g+jK+Qs/zxwvH8cm yQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp0050.outbound.protection.outlook.com [216.32.180.50])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2nrnvf85p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 14 Nov 2018 07:24:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMAkG/QU0aoUyLXr+ZPvnQE6ttn+KqMxi7f355iFW3M=;
 b=LmIqKd91uu+GATfBzZRCyXPFy22i2V89i3l/ao6l7agqUtCTR8v+g7w886RVO3qQ2DB3RB66xWVk+qPZyCvB9eIn1bhMSuM2MAc93BmuqKNisAn/2/DOK0O/QAw6Dc53jUqLZMLSSTiHJ/EDsjnHyXsDMtVtwBGyXJIRGv60Ju4=
Received: from CO2PR07MB2695.namprd07.prod.outlook.com (10.166.214.8) by
 CO2PR07MB699.namprd07.prod.outlook.com (10.141.226.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.25; Wed, 14 Nov 2018 15:24:39 +0000
Received: from CO2PR07MB2695.namprd07.prod.outlook.com
 ([fe80::d846:c378:fc67:e1cc]) by CO2PR07MB2695.namprd07.prod.outlook.com
 ([fe80::d846:c378:fc67:e1cc%5]) with mapi id 15.20.1294.045; Wed, 14 Nov 2018
 15:24:39 +0000
From:   Janek Kotas <jank@cadence.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] clk: Add Fixed MMIO clock driver
Thread-Topic: [PATCH 2/2] clk: Add Fixed MMIO clock driver
Thread-Index: AQHUfC4o6I9KU4z5pEi/Dni3knNwmw==
Date:   Wed, 14 Nov 2018 15:24:39 +0000
Message-ID: <D3711617-229C-4FA5-9E73-A7A3C025893B@global.cadence.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR07MB699;20:uWQE8qvKD8auMl3at1jsH4FWO0L815kH1Am7XGVHS6AO5Hx/hZLNyWlrClpDI1dqVyOy7lh9SgyThDDfJf+ahIjZhhYLXqflE8hsbs0m+T3y6lHTo4zRr4mPxYXt7eaqK7yb3cuusUhbsQ1skhXK4CBGLe8+WlwlQviW/23xhszn5b5byZ5T3XPGxxKHvj0RBvzKUDguWstbPfynyrTFmKoFZajXvHTviPmxRzFU+vHPQenbi3zB1QELeX+E+e8Z
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d854ec26-ba03-4378-06c4-08d64a454b28
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB699;
x-ms-traffictypediagnostic: CO2PR07MB699:
x-microsoft-antispam-prvs: <CO2PR07MB69963A8270EBA5B713F8CDDD0C30@CO2PR07MB699.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231410)(944501410)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:CO2PR07MB699;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB699;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(136003)(346002)(39860400002)(199004)(189003)(36092001)(6486002)(110136005)(486006)(6436002)(478600001)(71200400001)(105586002)(66066001)(83716004)(71190400001)(81166006)(8676002)(8936002)(81156014)(54906003)(7736002)(106356001)(2900100001)(316002)(82746002)(476003)(14454004)(25786009)(305945005)(99286004)(102836004)(53936002)(3846002)(5660300001)(2906002)(6512007)(6116002)(68736007)(26005)(33656002)(186003)(97736004)(86362001)(4326008)(256004)(6506007)(2501003)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB699;H:CO2PR07MB2695.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: etKgCFG8qs0T0cOV2Dl7qS3qH4Y+K+LsKRrOy4kq/REQHDbHDurSgZdEd954hPhUVA2mBydj0lJrr5PYFZdGaWmgOwh2Y4sdMj9UenhZKj0yXuo1MI380pwovekY3nAK/c6QjzdkrjT7b9MF9nN43btEqOPnzodZuElQ2edMdz0Jr3Sg1W0u0I5ZR76oNKbmPoz1LWfmjCj6qv7JAZAB1VETkb1RTIdPeUgEIpbywLuxQM7eIlBoHjWVL+TMZzyvpA6E9+cMCjRvR3bpMifBmoB/9/1tbY0/3tPVIbaQhTbnB9fft6wLsWiuvVo9DYzme4shiphDCLyVfDCqD4NVeJRYE8OS4RoTQJE/AEOfeok=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <876A739670F1894695401C545B148AEC@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d854ec26-ba03-4378-06c4-08d64a454b28
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 15:24:39.1735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB699
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-14_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811140139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a driver for Fixed MMIO clock.
The driver reads a clock frequency value from a single 32-bit memory
mapped register and registers it as a fixed rate clock.

It can be enabled with COMMON_CLK_FIXED_MMIO Kconfig option.

Signed-off-by: Jan Kotas <jank@cadence.com>
---
 drivers/clk/Kconfig          |  6 ++++++
 drivers/clk/Makefile         |  1 +
 drivers/clk/clk-fixed-mmio.c | 49 ++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 56 insertions(+)
 create mode 100644 drivers/clk/clk-fixed-mmio.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 81cdb4eaca..69c7fb859c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -283,6 +283,12 @@ config COMMON_CLK_STM32H7
 	---help---
 	  Support for stm32h7 SoC family clocks
=20
+config COMMON_CLK_FIXED_MMIO
+	bool "Clock driver for Memory Mapped Fixed values"
+	depends on COMMON_CLK && OF
+	help
+	  Support for Memory Mapped IO Fixed clocks
+
 source "drivers/clk/actions/Kconfig"
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 72be7a38cf..4e61961dc1 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_COMMON_CLK_CDCE925)	+=3D clk-cdce925.o
 obj-$(CONFIG_ARCH_CLPS711X)		+=3D clk-clps711x.o
 obj-$(CONFIG_COMMON_CLK_CS2000_CP)	+=3D clk-cs2000-cp.o
 obj-$(CONFIG_ARCH_EFM32)		+=3D clk-efm32gg.o
+obj-$(CONFIG_COMMON_CLK_FIXED_MMIO)	+=3D clk-fixed-mmio.o
 obj-$(CONFIG_COMMON_CLK_GEMINI)		+=3D clk-gemini.o
 obj-$(CONFIG_COMMON_CLK_ASPEED)		+=3D clk-aspeed.o
 obj-$(CONFIG_ARCH_HIGHBANK)		+=3D clk-highbank.o
diff --git a/drivers/clk/clk-fixed-mmio.c b/drivers/clk/clk-fixed-mmio.c
new file mode 100644
index 0000000000..bbcadab345
--- /dev/null
+++ b/drivers/clk/clk-fixed-mmio.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Memory Mapped IO Fixed Clock driver
+ *
+ * Copyright (C) 2018 Cadence Design Systems, Inc.
+ *
+ * Authors:
+ *	Jan Kotas <jank@cadence.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/of_address.h>
+#include <linux/regmap.h>
+
+static void __init of_fixed_mmio_clk_setup(struct device_node *node)
+{
+	struct clk *clk;
+	const char *clk_name =3D node->name;
+	void __iomem *base;
+	u32 clk_freq;
+
+	base =3D of_iomap(node, 0);
+	if (!base) {
+		pr_err("%pOFn: failed to map address\n", node);
+		return;
+	}
+
+	clk_freq =3D readl(base);
+	iounmap(base);
+	of_property_read_string(node, "clock-output-names", &clk_name);
+
+	clk =3D clk_register_fixed_rate(NULL, clk_name, NULL, 0, clk_freq);
+	if (IS_ERR(clk)) {
+		pr_err("%pOFn: failed to register fixed rate clock\n", node);
+		return;
+	}
+
+	if (of_clk_add_provider(node, of_clk_src_simple_get, clk)) {
+		pr_err("%pOFn: failed to add clock provider\n", node);
+		return;
+	}
+
+	pr_info("%pOFn: registered fixed-mmio-clock at %u Hz\n",
+		node, clk_freq);
+}
+
+CLK_OF_DECLARE(fixed_mmio_clk, "fixed-mmio-clock", of_fixed_mmio_clk_setup=
);
--=20
2.15.0

