Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACDFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4520A21773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="h3zm4Avf";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="p/6OPpcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbfBSQTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:19:43 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:58216 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726110AbfBSQTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:19:43 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1JGEtm8025265;
        Tue, 19 Feb 2019 08:18:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=3WxA1qGRzJSKGTiRqSEXjcyAQcbJjRekgSDNDPlQtN0=;
 b=h3zm4AvfL6ca1wqPcNVlFS+2xyQ+DVdIkuXIOkxIdqBmtwLKcqlOrwkIHFG9mlOGrPlI
 c5sUohzPZStcJmcSbfs6kFwFagnG2lqt2vlCbsR+ITm8UcLxrzqWX+d33KI0voBQA4vo
 uEmqzZJpkf+0TiPjEnTJx/vzH7qN4Zvg3WBtR3+HJ8kflk9dsHy1KR9iIanDhD+AspBB
 j6qHjMRa/XCslEexhwWU63NQGptShn5Fcz/cvs8P9zDrtIeYfhrkLCwc613AcK4pALav
 Lghq1t5cdyK0TAgHBd4ABRTf3Ym5eSLG5ZCeNLWqNEcjq0tW0j6WHbJpKrdeLgc+72AT EA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=piotrs@cadence.com
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2054.outbound.protection.outlook.com [104.47.45.54])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2qpeyydy08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 Feb 2019 08:18:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WxA1qGRzJSKGTiRqSEXjcyAQcbJjRekgSDNDPlQtN0=;
 b=p/6OPpcQ10HJ98Cfh8dgu4no9hZT8W+9e0c2PuoNn2dydNPqtDHJjn5CzK6Rq+lWaERwoT1LzPHuUTSi/PYwu1iJgyxbwX8d5wNvUEvDl6m8O8/toG97mOySSOGFX2IQDt/F5ZGEhy0QuuZHS8/fEXkl5+hEknfsufgfOu1Ddbk=
Received: from CO2PR07CA0068.namprd07.prod.outlook.com (2603:10b6:100::36) by
 SN1PR07MB2255.namprd07.prod.outlook.com (2a01:111:e400:c456::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16; Tue, 19 Feb
 2019 16:18:38 +0000
Received: from BY2NAM05FT037.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::205) by CO2PR07CA0068.outlook.office365.com
 (2603:10b6:100::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1643.14 via Frontend
 Transport; Tue, 19 Feb 2019 16:18:37 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT037.mail.protection.outlook.com (10.152.100.174) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.11 via Frontend Transport; Tue, 19 Feb 2019 16:18:37 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x1JGIX2i012789
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 19 Feb 2019 08:18:34 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 19 Feb 2019 17:18:31 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 19 Feb 2019 17:18:31 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x1JGIVje023089;
        Tue, 19 Feb 2019 16:18:31 GMT
Received: (from piotrs@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x1JGIUlo023051;
        Tue, 19 Feb 2019 16:18:30 GMT
From:   Piotr Sroka <piotrs@cadence.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        <linux-mtd@lists.infradead.org>, Piotr Sroka <piotrs@cadence.com>
Subject: [PATCH v2 1/2] mtd: nand: Add Cadence NAND controller driver
Date:   Tue, 19 Feb 2019 16:18:23 +0000
Message-ID: <20190219161823.22466-1-piotrs@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190219161406.4340-1-piotrs@cadence.com>
References: <20190219161406.4340-1-piotrs@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(2980300002)(199004)(189003)(36092001)(43544003)(47776003)(54906003)(5024004)(50226002)(42186006)(4326008)(14444005)(356004)(6666004)(316002)(107886003)(446003)(11346002)(426003)(476003)(30864003)(105596002)(19627235002)(2906002)(1076003)(2616005)(126002)(2351001)(106466001)(5660300002)(86362001)(8936002)(36756003)(336012)(486006)(53946003)(478600001)(87636003)(26005)(51416003)(16586007)(8676002)(7416002)(48376002)(76176011)(246002)(6916009)(50466002)(26826003)(186003)(7636002)(305945005)(559001)(579004)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2255;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1248266c-bc62-4e64-dedc-08d69685e728
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN1PR07MB2255;
X-MS-TrafficTypeDiagnostic: SN1PR07MB2255:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2255;20:kZ9Ip3RnBNGJB4aIpBtm3g42V80wjMrhWcHztHgT2in2ECyZ4EhEbJ17nYJGra0oej1hrv/8dccYiF5SgWL0DPi9JrH1A/nlT1d/Il5kG2LjS5viuDI6J0K5IRbjoP2poUfzHDH0lhEkowQS9Nm+9+uZG2LkSSB4e8IHfoeFYSB72oemzbiw/35tn59g5f9v2FRf6wneRGjgh3RTCsK9/quhESkIgvtwYTOc4QRfk0eYE7tS+pL4umvYMY8sgFrFcALwurfpZwN5lysjYBGNKZJ2WdkTw+EPK94nTHMQG4M2n5LudfMW6nfh9JkAVqHhUV/wuAOTLHEdlF46r/XJC7Gdr11gSsgGnDRPpJuZ+oMPHrVifcLEGKj9q9jmxQOFqFPU0xpHE3hr3sfBiHD9RUWOQnf2lDpSMqdVOnnWrrhHwYZV/j/jtXEiGmYyH7Fs6HAxCOMo4NlfyzyltBU/fpDTHncr1e/JzefxWlufFDwAVdfACdOQQYHiXnqkk1PU
X-Microsoft-Antispam-PRVS: <SN1PR07MB2255F5F4048C25DA26BF72B7DD7C0@SN1PR07MB2255.namprd07.prod.outlook.com>
X-Forefront-PRVS: 09538D3531
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB2255;23:OhIQVMYpOeTQ7MLvWC6yAlUg0I7ml9IZ1DJ4msR3d?=
 =?us-ascii?Q?qwQDNYIv/EzIfSDwo2TksQxuDVr4uCIDZx9Ep+4Kui3GdEeBDWax3VAH59NK?=
 =?us-ascii?Q?IJZoU+MLT1yy+PP8xw2q011dxk3C+zaraVLecRkhKgC7j8l71bKZjZDqOKIA?=
 =?us-ascii?Q?0uWyWAO1N37rKSNCEgajUCYzwBEKwVGTLnDw37tnIBnTN1A60OaYzm0dKngu?=
 =?us-ascii?Q?9k7JeYoqqkiU2pJWXGdUAf7KYlpLm7/TO04gGnDg9AdrU+I2dq2/Wt4ucpeT?=
 =?us-ascii?Q?j6N4SK23Rl0CII3Tsm5R0WJ4/MRd/m6lUADabWsX9urFk9Ld1waHXsURbuIK?=
 =?us-ascii?Q?06o7/ALm/vGy2RUtrtoFf4e9wNennLvtqP5h9XaTPZl1mLMPZLCHhTDbTUVQ?=
 =?us-ascii?Q?si8KGVvyoKNO0AxbUFkdoAyf8cVs+iD6f7GsvK0pSWDZT+jmrLe/mFBEeEqJ?=
 =?us-ascii?Q?J0GX41CnfpMgbub1fkBj5EVscONfC+WvQQfbwh6esKnLr8V/Jnudy+8XgdlQ?=
 =?us-ascii?Q?JJ6r2f69Ghs0r4I4XgJPKuqUg9R1cweY5zmG0euQAYGvlJXmhfoSPmFO1tt3?=
 =?us-ascii?Q?Py9MO1m1it7PRNmkrxxP3gHEAiCUFNLgCGawYKNYKV9FgspAR0B2Zq2OSTwV?=
 =?us-ascii?Q?CKTTxD0JD1x/pZpuL8S6eZ7tPe+Do31U9Fs03G73Sl74DWGDhUs2Eh+ihPrJ?=
 =?us-ascii?Q?HoFpGlK0LhLLCBfRlsK682XMm69Pd2XoCecXGyQGePoMY3QN2zarCRrPW2vt?=
 =?us-ascii?Q?Hk1/F7AuZdSFeMnGFkxByr/Qe8CWnBPkugRMJWz34Cb68vha1FK9dKIUqc99?=
 =?us-ascii?Q?pnWXidyrarQ6AWiTKrVaVe9FaTIorNUeesaxuojvUr0B6kO2E2ibaXjw+i7H?=
 =?us-ascii?Q?OuzVDZopcAudjGIUvSri/cBYEAkN/9gidzoQCWKurp7R2R/T0IfpaEDEsXXE?=
 =?us-ascii?Q?af6kVuaHoK3kUpv2RivzS3QSfJ7akieHWWX9Kjj+amLqZl1MbuTQaq7aXY7z?=
 =?us-ascii?Q?TLX1XR3gJEOjk8L7r/PGnqbNVVmyff7ys+YGySnXb7Y8na5rF+4KjBNS3IAE?=
 =?us-ascii?Q?KdvUytsDx0Yd18hZeW9Lu1bfEmj0EF6ROwxGVKfOo26t0H2SZrQzAOkWoSpE?=
 =?us-ascii?Q?t/0wF3aqQ9p1gErYB6erG1rNyXSgUEJpBqjfYta2GB/Ltfx8Pi8QDS0rqWco?=
 =?us-ascii?Q?E1rqjzP6jRWTgv7wMbxo8SfaPx0JA7BUTC2qfn/yKi28KxdjIVmU4D4eOyrW?=
 =?us-ascii?Q?A8jETv2nNmk/jENJxk6A4oxT++FrUFUJTfKMADEusPhcFPtVTjxXonxlCFd1?=
 =?us-ascii?Q?yra49KWIlFy9rAeNAjC9oo=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 7Qzjr5SAu1vxTdRPxZSGMGsTMwv46TZonjDVUR6rEJAH4111QoHZvv/MHpEh10d0yUMwtIe/6DQ/OdqzmWcv7ulSLRz1lo2NidWmxLUVT3AhKsxKI8x9F5DyYVlOsgnODmd4vVZS4vHl/pESjRjcFEINU7GHK4mFv4SFJGDq3WJtcrbATVvmLRKb9gReVr0s8TE8S4obG2InZhCqe36UwuSRV4vCUmdIIR+s+cJyYMmOoeeFRifthQdn1uDRrWFlT4biEJigXqk+GvUEPQhfztYunBcyVgdtoxQr3R9kwp3AZya9h2jeVfmyUcHeKtsaVcRkX9wX5sA94VSehcPQjDkohWL66SfcFI1frWMwnn0MJXijtvJhrWCIziw+xfKgMXxPjqfBEWGvGMO5W346TIvDhvPBdGI1S0a6thBxFG8=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2255;20:wCQXUDMdaEyIrD4sChSKhBSOVoEkmTbLciS6+qljsw17vVyjXqGdonr66Jzz4LQnsFpfkbI0fhHhMcS9SL3Mn1HAY1OB+ujyq3kILbW8qshx+r3pZ6eZrXZELdMxuMyA3vzVcNcHc8cFJSjHlSCmH1ILJicCqgKiogNwtqPF1iKG3SJjnVdZyQknaw0ONBinDQkNlaxxfNSgU22Z2YG2xwefX5hoc7mXp3whbINbBcGVjMo8JLALNuQEslwXUnJ6
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2019 16:18:37.1785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1248266c-bc62-4e64-dedc-08d69685e728
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2255
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-19_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=43 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902190120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds driver for Cadence HPNFC NAND controller.

Signed-off-by: Piotr Sroka <piotrs@cadence.com>
---
Changes for v2:
- create one universal wait function for all events instead of one
  function per event.
- split one big function executing nand operations to separate
  functions one per each type of operation.
- add erase atomic operation to nand operation parser
- remove unnecessary includes.
- remove unused register defines 
- add support for multiple nand chips
- remove all code using legacy functions
- remove chip dependents parameters from dts bindings, they were
  attached to the SoC specific compatible at the driver level
- simplify interrupt handling
- simplify timing calculations
- fix calculation of maximum supported cs signals
- simplify ecc size calculation
- remove header file and put whole code to one c file
---
 drivers/mtd/nand/raw/Kconfig                   |    8 +
 drivers/mtd/nand/raw/Makefile                  |    1 +
 drivers/mtd/nand/raw/cadence-nand-controller.c | 3288 ++++++++++++++++++++++++
 3 files changed, 3297 insertions(+)
 create mode 100644 drivers/mtd/nand/raw/cadence-nand-controller.c

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 1a55d3e3d4c5..742dcc947203 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -541,4 +541,12 @@ config MTD_NAND_TEGRA
 	  is supported. Extra OOB bytes when using HW ECC are currently
 	  not supported.
 
+config MTD_NAND_CADENCE
+	tristate "Support Cadence NAND (HPNFC) controller"
+	depends on OF
+	help
+	  Enable the driver for NAND flash on platforms using a Cadence NAND
+	  controller.
+
+
 endif # MTD_NAND
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 57159b349054..1d5432fb65e3 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand/
 obj-$(CONFIG_MTD_NAND_QCOM)		+= qcom_nandc.o
 obj-$(CONFIG_MTD_NAND_MTK)		+= mtk_ecc.o mtk_nand.o
 obj-$(CONFIG_MTD_NAND_TEGRA)		+= tegra_nand.o
+obj-$(CONFIG_MTD_NAND_CADENCE)		+= cadence-nand-controller.o
 
 nand-objs := nand_base.o nand_legacy.o nand_bbt.o nand_timings.o nand_ids.o
 nand-objs += nand_onfi.o
diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
new file mode 100644
index 000000000000..6ff023c4459b
--- /dev/null
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -0,0 +1,3288 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Cadence NAND flash controller driver
+ *
+ * Copyright (C) 2019 Cadence
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/rawnand.h>
+#include <linux/of_device.h>
+#include <linux/iopoll.h>
+
+#define MAX_OOB_SIZE_PER_SECTOR	32
+#define MAX_ADDRESS_CYC		6
+#define MAX_ERASE_ADDRESS_CYC	3
+#define MAX_DATA_SIZE		0xFFFC
+
+/***************************************************/
+/*  Register definition */
+/***************************************************/
+
+/* Command register 0.
+ * Writing data to this register will initiate a new transaction
+ * of the NF controller.
+ */
+#define CMD_REG0			0x0000
+/* command type field mask */
+#define		CMD_REG0_CT		GENMASK(31, 30)
+/* command type CDMA */
+#define		CMD_REG0_CT_CDMA	0uL
+/* command type reset */
+#define		CMD_REG0_CT_RST		2uL
+/* command type generic */
+#define		CMD_REG0_CT_GEN		3uL
+/* command thread number field mask */
+#define		CMD_REG0_TN		GENMASK(27, 24)
+/* command interrupt mask */
+#define		CMD_REG0_INT		BIT(20)
+
+/* Command register 2 */
+#define CMD_REG2			0x0008
+/* Command register 3 */
+#define CMD_REG3			0x000C
+/* Pointer register to select which thread status will be selected. */
+#define CMD_STATUS_PTR			0x0010
+/* Command status register for selected thread */
+#define CMD_STATUS			0x0014
+
+/* interrupt status register */
+#define INTR_STATUS			0x0110
+#define		INTR_STATUS_SDMA_ERR	BIT(22)
+#define		INTR_STATUS_SDMA_TRIGG	BIT(21)
+#define		INTR_STATUS_UNSUPP_CMD	BIT(19)
+#define		INTR_STATUS_DDMA_TERR	BIT(18)
+#define		INTR_STATUS_CDMA_TERR	BIT(17)
+#define		INTR_STATUS_CDMA_IDL	BIT(16)
+
+/* interrupt enable register */
+#define INTR_ENABLE				0x0114
+#define		INTR_ENABLE_INTR_EN		BIT(31)
+#define		INTR_ENABLE_SDMA_ERR_EN		BIT(22)
+#define		INTR_ENABLE_SDMA_TRIGG_EN	BIT(21)
+#define		INTR_ENABLE_UNSUPP_CMD_EN	BIT(19)
+#define		INTR_ENABLE_DDMA_TERR_EN	BIT(18)
+#define		INTR_ENABLE_CDMA_TERR_EN	BIT(17)
+#define		INTR_ENABLE_CDMA_IDLE_EN	BIT(16)
+
+/* Controller internal state */
+#define CTRL_STATUS				0x0118
+#define		CTRL_STATUS_INIT_COMP		BIT(9)
+#define		CTRL_STATUS_CTRL_BUSY		BIT(8)
+
+/* Command Engine threads state */
+#define TRD_STATUS				0x0120
+
+/*  Command Engine interrupt thread error status */
+#define TRD_ERR_INT_STATUS			0x0128
+/*  Command Engine interrupt thread error enable */
+#define TRD_ERR_INT_STATUS_EN			0x0130
+/*  Command Engine interrupt thread complete status*/
+#define TRD_COMP_INT_STATUS			0x0138
+
+/* Transfer config 0 register.
+ * Configures data transfer parameters.
+ */
+#define TRAN_CFG_0			        0x0400
+/* Offset value from the beginning of the page  */
+#define		TRAN_CFG_0_OFFSET	        GENMASK(31, 16)
+/* Numbers of sectors to transfer within single NF device's page.  */
+#define		TRAN_CFG_0_SEC_CNT	        GENMASK(7, 0)
+
+/* Transfer config 1 register.
+ * Configures data transfer parameters.
+ */
+#define TRAN_CFG_1				0x0404
+/* Size of last data sector.  */
+#define		TRAN_CFG_1_LAST_SEC_SIZE	GENMASK(31, 16)
+/*  Size of not-last data sector. - last*/
+#define		TRAN_CFG_1_SECTOR_SIZE		GENMASK(15, 0)
+
+/* ECC engine configuration register 0. */
+#define ECC_CONFIG_0				0x0428
+/* Correction strength  */
+#define		ECC_CONFIG_0_CORR_STR		GENMASK(9, 8)
+/* Enables scrambler logic in the controller  */
+#define		ECC_CONFIG_0_SCRAMBLER_EN	BIT(2)
+/*  Enable erased pages detection mechanism  */
+#define		ECC_CONFIG_0_ERASE_DET_EN	BIT(1)
+/*  Enable controller ECC check bits generation and correction  */
+#define		ECC_CONFIG_0_ECC_EN		BIT(0)
+
+/* ECC engine configuration register 1. */
+#define ECC_CONFIG_1				0x042C
+
+/* Multiplane settings register */
+#define MULTIPLANE_CFG				0x0434
+/* Cache operation settings. */
+#define CACHE_CFG				0x0438
+
+/* DMA settings register */
+#define DMA_SETINGS				0x043C
+/* Enable SDMA error report on access unprepared slave DMA interface.  */
+#define		DMA_SETINGS_SDMA_ERR_RSP	BIT(17)
+/* Outstanding transaction enable  */
+#define		DMA_SETINGS_OTE			BIT(16)
+/* DMA burst selection  */
+#define		DMA_SETINGS_BURST_SEL		GENMASK(7, 0)
+
+/* Transferred data block size for the slave DMA module */
+#define SDMA_SIZE				0x0440
+
+/* Thread number associated with transferred data block
+ * for the slave DMA module
+ */
+#define SDMA_TRD_NUM				0x0444
+/* Thread number mask */
+#define		SDMA_TRD_NUM_SDMA_TRD		GENMASK(2, 0)
+
+#define CONTROL_DATA_CTRL			0x0494
+/* Thread number mask */
+#define		CONTROL_DATA_CTRL_SIZE		GENMASK(15, 0)
+
+#define CTRL_VERSION				0x800
+
+/* available hardware features of the controller */
+#define CTRL_FEATURES				0x804
+/* Support for NV-DDR2/3 work mode  */
+#define		CTRL_FEATURES_NVDDR_2_3		BIT(28)
+/* Support for NV-DDR work mode  */
+#define		CTRL_FEATURES_NVDDR		BIT(27)
+/* Support for asynchronous work mode  */
+#define		CTRL_FEATURES_ASYNC		BIT(26)
+/* Support for asynchronous work mode */
+#define		CTRL_FEATURES_N_BANKS		GENMASK(25, 24)
+/* Slave and Master DMA data width  */
+#define		CTRL_FEATURES_DMA_DWITH64	BIT(21)
+/* Availability of Control Data feature.*/
+#define		CTRL_FEATURES_CONTROL_DATA	BIT(10)
+/* number of threads available in the controller  */
+#define		CTRL_FEATURES_N_THREADS		GENMASK(2, 0)
+
+/* BCH Engine identification register 0 - correction strengths. */
+#define BCH_CFG_0				0x838
+#define		BCH_CFG_0_CORR_CAP_0		GENMASK(7, 0)
+#define		BCH_CFG_0_CORR_CAP_1		GENMASK(15, 8)
+#define		BCH_CFG_0_CORR_CAP_2		GENMASK(23, 16)
+#define		BCH_CFG_0_CORR_CAP_3		GENMASK(31, 24)
+
+/* BCH Engine identification register 1 - correction strengths. */
+#define BCH_CFG_1				0x83C
+#define		BCH_CFG_1_CORR_CAP_4		GENMASK(7, 0)
+#define		BCH_CFG_1_CORR_CAP_5		GENMASK(15, 8)
+#define		BCH_CFG_1_CORR_CAP_6		GENMASK(23, 16)
+#define		BCH_CFG_1_CORR_CAP_7		GENMASK(31, 24)
+
+/* BCH Engine identification register 2 - sector sizes. */
+#define BCH_CFG_2				0x840
+#define		BCH_CFG_2_SECT_0		GENMASK(15, 0)
+#define		BCH_CFG_2_SECT_1		GENMASK(31, 16)
+
+/* BCH Engine identification register 3  */
+#define BCH_CFG_3				0x844
+
+/* Ready/Busy# line status */
+#define RBN_SETINGS				0x1004
+
+/*  Common settings */
+#define COMMON_SET				0x1008
+/* 16 bit device connected to the NAND Flash interface  */
+#define		COMMON_SET_DEVICE_16BIT		BIT(8)
+
+/* skip_bytes registers */
+#define SKIP_BYTES_CONF				0x100C
+#define		SKIP_BYTES_MARKER_VALUE		GENMASK(31, 16)
+#define		SKIP_BYTES_NUM_OF_BYTES		GENMASK(7, 0)
+
+#define SKIP_BYTES_OFFSET			0x1010
+#define		 SKIP_BYTES_OFFSET_VALUE	GENMASK(23, 0)
+
+#define TOGGLE_TIMINGS0				0x1014
+#define		TOGGLE_TIMINGS0_TCR		GENMASK(29, 24)
+#define		TOGGLE_TIMINGS0_TPRE		GENMASK(21, 16)
+#define		TOGGLE_TIMINGS0_TCDQSS		GENMASK(13, 8)
+#define		TOGGLE_TIMINGS0_TPSTH		GENMASK(5, 0)
+
+#define TOGGLE_TIMINGS1				0x1018
+#define		TOGGLE_TIMINGS1_TCDQSH		GENMASK(29, 24)
+#define		TOGGLE_TIMINGS1_TCRES		GENMASK(21, 16)
+#define		TOGGLE_TIMINGS1_TRPST		GENMASK(13, 8)
+#define		TOGGLE_TIMINGS1_TWPST		GENMASK(5, 0)
+
+/* ToggleMode/NV-DDR2/NV-DDR3 and SDR timings configuration. */
+#define ASYNC_TOGGLE_TIMINGS			0x101c
+#define		ASYNC_TOGGLE_TIMINGS_TRH	GENMASK(28, 24)
+#define		ASYNC_TOGGLE_TIMINGS_TRP	GENMASK(20, 16)
+#define		ASYNC_TOGGLE_TIMINGS_TWH	GENMASK(12, 8)
+#define		ASYNC_TOGGLE_TIMINGS_TWP	GENMASK(4, 0)
+
+/* SourceSynchronous/NV-DDR timings configuration. */
+#define	SYNC_TIMINGS				0x1020
+#define		SYNC_TIMINGS_TCKWR		GENMASK(21, 16)
+#define		SYNC_TIMINGS_TWRCK		GENMASK(13, 8)
+#define		SYNC_TIMINGS_TCAD		GENMASK(5, 0)
+
+#define	TIMINGS0				0x1024
+#define		TIMINGS0_TADL		        GENMASK(31, 24)
+#define		TIMINGS0_TCCS		        GENMASK(23, 16)
+#define		TIMINGS0_TWHR		        GENMASK(15, 8)
+#define		TIMINGS0_TRHW		        GENMASK(7, 0)
+
+#define	TIMINGS1				0x1028
+#define		TIMINGS1_TRHZ		        GENMASK(31, 24)
+#define		TIMINGS1_TWB		        GENMASK(23, 16)
+#define		TIMINGS1_TCWAW		        GENMASK(15, 8)
+#define		TIMINGS1_TVDLY		        GENMASK(7, 0)
+
+#define	TIMINGS2				0x1028
+#define		TIMINGS2_TFEAT			GENMASK(25, 16)
+#define		TIMINGS2_CS_HOLD_TIME		GENMASK(13, 8)
+#define		TIMINGS2_CS_SETUP_TIME		GENMASK(5, 0)
+
+/* Configuration of the resynchronization of slave DLL of PHY */
+#define DLL_PHY_CTRL					0x1034
+#define		DLL_PHY_CTRL_DLL_LOCK_DONE		BIT(26)
+#define		DLL_PHY_CTRL_DFI_CTRLUPD_REQ		BIT(25)
+#define		DLL_PHY_CTRL_DLL_RST_N			BIT(24)
+#define		DLL_PHY_CTRL_EXTENDED_WR_MODE		BIT(17)
+#define		DLL_PHY_CTRL_EXTENDED_RD_MODE		BIT(16)
+#define		DLL_PHY_CTRL_RS_HIGH_WAIT_CNT		GENMASK(11, 8)
+#define		DLL_PHY_CTRL_RS_IDLE_CNT		GENMASK(7, 0)
+
+/* register controlling DQ related timing  */
+#define PHY_DQ_TIMING			0x2000
+/* register controlling DSQ related timing  */
+#define PHY_DQS_TIMING			0x2004
+
+/* register controlling the gate and loopback control related timing. */
+#define PHY_GATE_LPBK_CTRL			0x2008
+#define		PHY_GATE_LPBK_CTRL_RDS		GENMASK(24, 19)
+
+/* register holds the control for the master DLL logic */
+#define PHY_DLL_MASTER_CTRL			0x200C
+#define		PHY_DLL_MASTER_CTRL_BYPASS_MODE	BIT(23)
+
+/* register holds the control for the slave DLL logic */
+#define PHY_DLL_SLAVE_CTRL		        0x2010
+
+/*   This register handles the global control settings for the PHY */
+#define PHY_CTRL				0x2080
+#define		PHY_CTRL_SDR_DQS		BIT(14)
+#define		PHY_CTRL_PHONY_DQS	        GENMASK(9, 4)
+
+/* This register handles the global control settings
+ * for the termination selects for reads
+ */
+#define PHY_TSEL			        0x2084
+/***************************************************/
+
+/* generic command layout*/
+#define GCMD_LAY_CS			GENMASK_ULL(11, 8)
+/* commands complaint with Jedec spec*/
+#define GCMD_LAY_JEDEC			BIT_ULL(7)
+/* This bit informs the minicotroller if it has to wait for tWB
+ * after sending the last CMD/ADDR/DATA in the sequence.
+ */
+#define GCMD_LAY_TWB			BIT_ULL(6)
+/*  type of instruction  */
+#define GCMD_LAY_INSTR			GENMASK_ULL(5, 0)
+
+/* type of instruction - CMD sequence */
+#define		GCMD_LAY_INSTR_CMD	0
+/* type of instruction - ADDR sequence */
+#define		GCMD_LAY_INSTR_ADDR	1
+/*  type of instruction - data transfer */
+#define		GCMD_LAY_INSTR_DATA	2
+/*  type of instruction - read parameter page (0xEF) */
+#define		GCMD_LAY_INSTR_RDPP	28
+/* type of instruction - read memory ID (0x90) */
+#define		GCMD_LAY_INSTR_RDID	27
+/* type of instruction - reset command (0xFF) */
+#define		GCMD_LAY_INSTR_RDST	7
+/* type of instruction - change read column command */
+#define		GCMD_LAY_INSTR_CHRC	12
+
+/* input part of generic command type of input is command  */
+#define GCMD_LAY_INPUT_CMD		GENMASK_ULL(23, 16)
+
+/* generic command address sequence - address fields  */
+#define GCMD_LAY_INPUT_ADDR		GENMASK_ULL(63, 16)
+/* generic command address sequence - address size  */
+#define GCMD_LAY_INPUT_ADDR_SIZE	GENMASK_ULL(13, 11)
+
+/* generic command data sequence - transfer direction */
+#define GCMD_DIR			BIT_ULL(11)
+/* generic command data sequence - transfer direction - read  */
+#define		GCMD_DIR_READ		0
+/* generic command data sequence - transfer direction - write  */
+#define		GCMD_DIR_WRITE		1
+
+/* generic command data sequence - ecc enabled */
+#define GCMD_ECC_EN			BIT_ULL(12)
+/* generic command data sequence - scrambler enabled */
+#define GCMD_SCR_EN			BIT_ULL(13)
+/* generic command data sequence - erase page detection enabled */
+#define GCMD_ERPG_EN			BIT_ULL(14)
+/* generic command data sequence - sector size */
+#define GCMD_SECT_SIZE			GENMASK_ULL(31, 16)
+/* generic command data sequence - sector count  */
+#define GCMD_SECT_CNT			GENMASK_ULL(39, 32)
+/* generic command data sequence - last sector size */
+#define GCMD_LAST_SIZE			GENMASK_ULL(55, 40)
+/* generic command data sequence - correction capability */
+#define GCMD_CORR_CAP			GENMASK_ULL(58, 56)
+
+/***************************************************/
+/*  CDMA descriptor fields */
+/***************************************************/
+
+/** command DMA descriptor type - erase command */
+#define CDMA_CT_ERASE		0x1000
+/** command DMA descriptor type - reset command */
+#define CDMA_CT_RST		0x1100
+/** command DMA descriptor type - write page command */
+#define CDMA_CT_WR		0x2100
+/** command DMA descriptor type - read page command */
+#define CDMA_CT_RD		0x2200
+
+/** flash pointer memory - shift */
+#define CDMA_CFPTR_MEM_SHIFT	24
+/** flash pointer memory  */
+#define CDMA_CFPTR_MEM		GENMASK(26, 24)
+
+/** command DMA descriptor flags - issue interrupt after
+ * the completion of descriptor processing
+ */
+#define CDMA_CF_INT		BIT(8)
+/** command DMA descriptor flags - the next descriptor
+ * address field is valid and descriptor processing should continue
+ */
+#define CDMA_CF_CONT		BIT(9)
+/* command DMA descriptor flags - selects DMA master */
+#define CDMA_CF_DMA_MASTER	BIT(10)
+
+/* command descriptor status  - operation complete */
+#define CDMA_CS_COMP		BIT(15)
+/* command descriptor status  - operation fail */
+#define CDMA_CS_FAIL		BIT(14)
+/* command descriptor status  - page erased */
+#define CDMA_CS_ERP		BIT(11)
+/* command descriptor status  - timeout occurred */
+#define CDMA_CS_TOUT		BIT(10)
+/* command descriptor status - maximum amount of correction
+ * applied to one ECC sector
+ */
+#define CDMA_CS_MAXERR		GENMASK(9, 2)
+/* command descriptor status - uncorrectable ECC error */
+#define CDMA_CS_UNCE		BIT(1)
+/* command descriptor status - descriptor error */
+#define CDMA_CS_ERR		BIT(0)
+
+/***************************************************/
+
+/***************************************************/
+/*  internal used status*/
+/***************************************************/
+/* status of operation - OK */
+#define STAT_OK			0
+/* status of operation - FAIL */
+#define STAT_FAIL		2
+/* status of operation - uncorrectable ECC error */
+#define STAT_ECC_UNCORR		3
+/* status of operation - page erased */
+#define STAT_ERASED		5
+/* status of operation - correctable ECC error */
+#define STAT_ECC_CORR		6
+/* status of operation - unsuspected state*/
+#define STAT_UNKNOWN		7
+/* status of operation - operation is not completed yet */
+#define STAT_BUSY		0xFF
+/***************************************************/
+
+#define BCH_MAX_NUM_CORR_CAPS	        8
+#define BCH_MAX_NUM_SECTOR_SIZES	2
+
+struct cadence_nand_timings {
+	u32 toggle_timings_0;
+	u32 toggle_timings_1;
+	u32 async_toggle_timings;
+	u32 sync_timings;
+	u32 timings0;
+	u32 timings1;
+	u32 timings2;
+	u32 dll_phy_ctrl;
+	u32 phy_ctrl;
+	u32 phy_dqs_timing;
+	u32 phy_gate_lpbk_ctrl;
+};
+
+/* Command DMA descriptor */
+struct cadence_nand_cdma_desc {
+	/* next descriptor address */
+	u64 next_pointer;
+
+	/* glash address is a 32-bit address comprising of BANK and ROW ADDR. */
+	u32 flash_pointer;
+	u32 rsvd0;
+
+	/* operation the controller needs to perform */
+	u16 command_type;
+	u16 rsvd1;
+	/* flags for operation of this command */
+	u16 command_flags;
+	u16 rsvd2;
+
+	/* system/host memory address required for data DMA commands. */
+	u64 memory_pointer;
+
+	/* status of operation */
+	u32 status;
+	u32 rsvd3;
+
+	/* address pointer to sync buffer location */
+	u64 sync_flag_pointer;
+
+	/* Controls the buffer sync mechanism. */
+	u32 sync_arguments;
+	u32 rsvd4;
+
+	/* Control data pointer */
+	u64 ctrl_data_ptr;
+};
+
+/* interrupt status */
+struct cadence_nand_irq_status {
+	/* Thread operation complete status */
+	u32 trd_status;
+	/* Thread operation error */
+	u32 trd_error;
+	/* Controller status  */
+	u32 status;
+};
+
+/* Cadnence NAND flash controller capabilities get from driver data*/
+struct cadence_nand_dt_devdata {
+	/* Delay value of one NAND2 gate from which the delay element is build*/
+	u32 nand2_delay;
+	/* skew value of the output signals of the NAND Flash interface */
+	u32 if_skew;
+	/* is aging feature in the DLL PHY supported */
+	u8 phy_dll_aging;
+	/* is per bit deskew for read and write path in the PHY supported */
+	u8 phy_per_bit_deskew;
+	/* can slave DMA interface is connected to DMA engine */
+	u8 has_dma;
+};
+
+/* Cadnence NAND flash controller capabilities read from registers */
+struct cdns_nand_caps {
+	/* maximum number of banks supported by hardware. */
+	u8 max_banks;
+	/* slave and Master DMA data width in bytes (4 or 8) */
+	u8 data_dma_width;
+	/* is Control Data feature supported */
+	u8 data_control_supp;
+	/* is PHY type is DLL*/
+	u8 is_phy_type_dll;
+};
+
+struct cdns_nand_ctrl {
+	struct device *dev;
+	struct nand_controller controller;
+	struct cadence_nand_cdma_desc *cdma_desc;
+	/* IP capability */
+	const struct cadence_nand_dt_devdata *caps1;
+	struct cdns_nand_caps caps2;
+	dma_addr_t dma_cdma_desc;
+	u8 *buf;
+	u32 buf_size;
+	u8 curr_corr_str_idx;
+
+	/* register Interface */
+	void __iomem *reg;
+
+	struct {
+		void __iomem *virt;
+		dma_addr_t dma;
+	} io;
+
+	int irq;
+	/* interrupts that have happened */
+	struct cadence_nand_irq_status irq_status;
+	/* interrupts we are waiting for */
+	struct cadence_nand_irq_status irq_mask;
+	struct completion complete;
+	/* protect irq_mask and irq_status */
+	spinlock_t irq_lock;
+
+	int ecc_strengths[BCH_MAX_NUM_CORR_CAPS];
+	struct nand_ecc_step_info ecc_stepinfos[BCH_MAX_NUM_SECTOR_SIZES];
+	struct nand_ecc_caps ecc_caps;
+
+	int curr_trans_type;
+
+	struct dma_chan *dmac;
+
+	u32 nf_clk_rate;
+	/*
+	 * Estimated Board delay. The value includes the total
+	 * round trip delay for the signals and is used for deciding on values
+	 * associated with data read capture.
+	 */
+	u32 board_delay;
+
+	struct nand_chip *selected_chip;
+
+	unsigned long assigned_cs;
+	struct list_head chips;
+};
+
+struct cdns_nand_chip {
+	struct cadence_nand_timings timings;
+	struct nand_chip chip;
+	u8 nsels;
+	struct list_head node;
+
+	/*
+	 * part of oob area of NANF flash memory page.
+	 * This part is available for user to read or write.
+	 */
+	u32 avail_oob_size;
+	/* oob area size of NANF flash memory page */
+	u32 oob_size;
+	/* main area size of NANF flash memory page */
+	u32 main_size;
+
+	/* sector size few sectors are located on main area of NF memory page */
+	u32 sector_size;
+	u32 sector_count;
+
+	/* offset of BBM*/
+	u8 bbm_offs;
+	/* number of bytes reserved for BBM */
+	u8 bbm_len;
+	/* ECC strength index */
+	u8 corr_str_idx;
+
+	u8 cs[];
+};
+
+struct ecc_info {
+	int (*calc_ecc_bytes)(int step_size, int strength);
+	int max_step_size;
+};
+
+static struct
+cdns_nand_chip *to_cdns_nand_chip(struct nand_chip *chip)
+{
+	return container_of(chip, struct cdns_nand_chip, chip);
+}
+
+static struct
+cdns_nand_ctrl *to_cdns_nand_ctrl(struct nand_controller *controller)
+{
+	return container_of(controller, struct cdns_nand_ctrl, controller);
+}
+
+static bool
+cadence_nand_dma_buf_ok(struct cdns_nand_ctrl *cdns_ctrl, const void *buf,
+			u32 buf_len)
+{
+	u8 data_dma_width = cdns_ctrl->caps2.data_dma_width;
+
+	return buf && virt_addr_valid(buf) &&
+		likely(IS_ALIGNED((uintptr_t)buf, data_dma_width)) &&
+		likely(IS_ALIGNED(buf_len, data_dma_width));
+}
+
+static int cadence_nand_wait_for_value(struct cdns_nand_ctrl *cdns_ctrl,
+				       u32 reg_offset, u32 timeout_us,
+				       u32 mask, bool is_clear)
+{
+	u32 val;
+	int ret = 0;
+
+	ret = readl_poll_timeout(cdns_ctrl->reg + reg_offset,
+				 val, !(val & mask) == is_clear,
+				 10, timeout_us);
+
+	if (ret < 0) {
+		dev_err(cdns_ctrl->dev,
+			"Timeout while waiting for reg %x with mask %x is clear %d\n",
+			reg_offset, mask, is_clear);
+	}
+
+	return ret;
+}
+
+static int cadence_nand_set_ecc_enable(struct cdns_nand_ctrl *cdns_ctrl,
+				       bool enable)
+{
+	u32 reg;
+
+	if (cadence_nand_wait_for_value(cdns_ctrl, CTRL_STATUS,
+					1000000,
+					CTRL_STATUS_CTRL_BUSY, true))
+		return -ETIMEDOUT;
+
+	reg = readl(cdns_ctrl->reg + ECC_CONFIG_0);
+
+	if (enable)
+		reg |= ECC_CONFIG_0_ECC_EN;
+	else
+		reg &= ~ECC_CONFIG_0_ECC_EN;
+
+	writel(reg, cdns_ctrl->reg + ECC_CONFIG_0);
+
+	return 0;
+}
+
+static int cadence_nand_set_ecc_strength(struct cdns_nand_ctrl *cdns_ctrl,
+					 u8 corr_str_idx)
+{
+	u32 reg;
+
+	if (cdns_ctrl->curr_corr_str_idx == corr_str_idx)
+		return 0;
+
+	if (cadence_nand_wait_for_value(cdns_ctrl, CTRL_STATUS,
+					1000000,
+					CTRL_STATUS_CTRL_BUSY, true))
+		return -ETIMEDOUT;
+
+	reg = readl(cdns_ctrl->reg + ECC_CONFIG_0);
+	reg &= ~ECC_CONFIG_0_CORR_STR;
+	reg |= FIELD_PREP(ECC_CONFIG_0_CORR_STR, corr_str_idx);
+	writel(reg, cdns_ctrl->reg + ECC_CONFIG_0);
+
+	cdns_ctrl->curr_corr_str_idx = corr_str_idx;
+
+	return 0;
+}
+
+static u8 cadence_nand_get_ecc_strength_idx(struct cdns_nand_ctrl *cdns_ctrl,
+					    u8 strength)
+{
+	u8 i, corr_str_idx = 0;
+
+	for (i = 0; i < BCH_MAX_NUM_CORR_CAPS; i++) {
+		if (cdns_ctrl->ecc_strengths[i] == strength) {
+			corr_str_idx = i;
+			break;
+		}
+	}
+
+	return corr_str_idx;
+}
+
+static int cadence_nand_set_skip_marker_val(struct cdns_nand_ctrl *cdns_ctrl,
+					    u16 marker_value)
+{
+	u32 reg = 0;
+
+	if (cadence_nand_wait_for_value(cdns_ctrl, CTRL_STATUS,
+					1000000,
+					CTRL_STATUS_CTRL_BUSY, true))
+		return -ETIMEDOUT;
+
+	reg = readl(cdns_ctrl->reg + SKIP_BYTES_CONF);
+	reg &= ~SKIP_BYTES_MARKER_VALUE;
+	reg |= FIELD_PREP(SKIP_BYTES_MARKER_VALUE,
+		    marker_value);
+
+	writel(reg, cdns_ctrl->reg + SKIP_BYTES_CONF);
+
+	return 0;
+}
+
+static int cadence_nand_set_skip_bytes_conf(struct cdns_nand_ctrl *cdns_ctrl,
+					    u8 num_of_bytes,
+					    u32 offset_value,
+					    int enable)
+{
+	u32 reg = 0;
+	u32 skip_bytes_offset = 0;
+
+	if (cadence_nand_wait_for_value(cdns_ctrl, CTRL_STATUS,
+					1000000,
+					CTRL_STATUS_CTRL_BUSY, true))
+		return -ETIMEDOUT;
+
+	if (!enable) {
+		num_of_bytes = 0;
+		offset_value = 0;
+	}
+
+	reg = readl(cdns_ctrl->reg + SKIP_BYTES_CONF);
+	reg &= ~SKIP_BYTES_NUM_OF_BYTES;
+	reg |= FIELD_PREP(SKIP_BYTES_NUM_OF_BYTES,
+		    num_of_bytes);
+	skip_bytes_offset = FIELD_PREP(SKIP_BYTES_OFFSET_VALUE,
+				       offset_value);
+
+	writel(reg, cdns_ctrl->reg + SKIP_BYTES_CONF);
+	writel(skip_bytes_offset, cdns_ctrl->reg + SKIP_BYTES_OFFSET);
+
+	return 0;
+}
+
+static int cadence_nand_set_erase_detection(struct cdns_nand_ctrl *cdns_ctrl,
+					    bool enable,
+					    u8 bitflips_threshold)
+{
+	u32 reg;
+
+	if (cadence_nand_wait_for_value(cdns_ctrl, CTRL_STATUS,
+					1000000,
+					CTRL_STATUS_CTRL_BUSY, true))
+		return -ETIMEDOUT;
+
+	reg = readl(cdns_ctrl->reg + ECC_CONFIG_0);
+
+	if (enable)
+		reg |= ECC_CONFIG_0_ERASE_DET_EN;
+	else
+		reg &= ~ECC_CONFIG_0_ERASE_DET_EN;
+
+	writel(reg, cdns_ctrl->reg + ECC_CONFIG_0);
+	writel(bitflips_threshold, cdns_ctrl->reg + ECC_CONFIG_1);
+
+	return 0;
+}
+
+static int cadence_nand_set_access_width16(struct cdns_nand_ctrl *cdns_ctrl,
+					   bool bit_bus16)
+{
+	u32 reg;
+
+	if (cadence_nand_wait_for_value(cdns_ctrl, CTRL_STATUS,
+					1000000,
+					CTRL_STATUS_CTRL_BUSY, true))
+		return -ETIMEDOUT;
+
+	reg = readl(cdns_ctrl->reg + COMMON_SET);
+
+	if (!bit_bus16)
+		reg &= ~COMMON_SET_DEVICE_16BIT;
+	else
+		reg |= COMMON_SET_DEVICE_16BIT;
+	writel(reg, cdns_ctrl->reg + COMMON_SET);
+
+	return 0;
+}
+
+static void
+cadence_nand_clear_interrupt(struct cdns_nand_ctrl *cdns_ctrl,
+			     struct cadence_nand_irq_status *irq_status)
+{
+	writel(irq_status->status, cdns_ctrl->reg + INTR_STATUS);
+	writel(irq_status->trd_status, cdns_ctrl->reg + TRD_COMP_INT_STATUS);
+	writel(irq_status->trd_error, cdns_ctrl->reg + TRD_ERR_INT_STATUS);
+}
+
+static void
+cadence_nand_read_int_status(struct cdns_nand_ctrl *cdns_ctrl,
+			     struct cadence_nand_irq_status *irq_status)
+{
+	irq_status->status = readl(cdns_ctrl->reg + INTR_STATUS);
+	irq_status->trd_status = readl(cdns_ctrl->reg
+					 + TRD_COMP_INT_STATUS);
+	irq_status->trd_error = readl(cdns_ctrl->reg + TRD_ERR_INT_STATUS);
+}
+
+static u32 irq_detected(struct cdns_nand_ctrl *cdns_ctrl,
+			struct cadence_nand_irq_status *irq_status)
+{
+	cadence_nand_read_int_status(cdns_ctrl, irq_status);
+
+	return irq_status->status || irq_status->trd_status ||
+		irq_status->trd_error;
+}
+
+static void cadence_nand_reset_irq(struct cdns_nand_ctrl *cdns_ctrl)
+{
+	spin_lock(&cdns_ctrl->irq_lock);
+	memset(&cdns_ctrl->irq_status, 0, sizeof(cdns_ctrl->irq_status));
+	memset(&cdns_ctrl->irq_mask, 0, sizeof(cdns_ctrl->irq_mask));
+	spin_unlock(&cdns_ctrl->irq_lock);
+}
+
+/*
+ * This is the interrupt service routine. It handles all interrupts
+ * sent to this device.
+ */
+static irqreturn_t cadence_nand_isr(int irq, void *dev_id)
+{
+	struct cdns_nand_ctrl *cdns_ctrl = dev_id;
+	struct cadence_nand_irq_status irq_status;
+	irqreturn_t result = IRQ_NONE;
+
+	spin_lock(&cdns_ctrl->irq_lock);
+
+	if (irq_detected(cdns_ctrl, &irq_status)) {
+		/* handle interrupt */
+		/* first acknowledge it */
+		cadence_nand_clear_interrupt(cdns_ctrl, &irq_status);
+		/* store the status in the device context for someone to read */
+		cdns_ctrl->irq_status.status |= irq_status.status;
+		cdns_ctrl->irq_status.trd_status |= irq_status.trd_status;
+		cdns_ctrl->irq_status.trd_error |= irq_status.trd_error;
+		/* notify anyone who cares that it happened */
+		complete(&cdns_ctrl->complete);
+		/* tell the OS that we've handled this */
+		result = IRQ_HANDLED;
+	}
+	spin_unlock(&cdns_ctrl->irq_lock);
+	return result;
+}
+
+static void cadence_nand_set_irq_mask(struct cdns_nand_ctrl *cdns_ctrl,
+				      struct cadence_nand_irq_status *irq_mask)
+{
+	writel(INTR_ENABLE_INTR_EN | irq_mask->status,
+	       cdns_ctrl->reg + INTR_ENABLE);
+
+	writel(irq_mask->trd_error, cdns_ctrl->reg + TRD_ERR_INT_STATUS_EN);
+}
+
+static void
+cadence_nand_wait_for_irq(struct cdns_nand_ctrl *cdns_ctrl,
+			  struct cadence_nand_irq_status *irq_mask,
+			  struct cadence_nand_irq_status *irq_status)
+{
+	unsigned long timeout = msecs_to_jiffies(10000);
+	unsigned long time_left;
+
+	time_left = wait_for_completion_timeout(&cdns_ctrl->complete,
+						timeout);
+
+	*irq_status = cdns_ctrl->irq_status;
+	if (time_left == 0) {
+		/* timeout */
+		dev_err(cdns_ctrl->dev, "timeout occurred:\n");
+		dev_err(cdns_ctrl->dev, "\tstatus = 0x%x, mask = 0x%x\n",
+			irq_status->status, irq_mask->status);
+		dev_err(cdns_ctrl->dev,
+			"\ttrd_status = 0x%x, trd_status mask = 0x%x\n",
+			irq_status->trd_status, irq_mask->trd_status);
+		dev_err(cdns_ctrl->dev,
+			"\t trd_error = 0x%x, trd_error mask = 0x%x\n",
+			irq_status->trd_error, irq_mask->trd_error);
+	}
+}
+
+static void
+cadence_nand_irq_cleanup(int irqnum, struct cdns_nand_ctrl *cdns_ctrl)
+{
+	/* disable interrupts */
+	writel(INTR_ENABLE_INTR_EN, cdns_ctrl->reg + INTR_ENABLE);
+}
+
+/* execute generic command on NAND controller */
+static int cadence_nand_generic_cmd_send(struct cdns_nand_ctrl *cdns_ctrl,
+					 u8 chip_nr,
+					 u64 mini_ctrl_cmd)
+{
+	u32 mini_ctrl_cmd_l;
+	u32 mini_ctrl_cmd_h;
+	u8 thread_nr = 0;
+	u32 reg = 0;
+
+	mini_ctrl_cmd |= FIELD_PREP(GCMD_LAY_CS, chip_nr);
+	mini_ctrl_cmd_l = mini_ctrl_cmd & 0xFFFFFFFF;
+	mini_ctrl_cmd_h = mini_ctrl_cmd >> 32;
+
+	if (cadence_nand_wait_for_value(cdns_ctrl, CTRL_STATUS,
+					1000000,
+					CTRL_STATUS_CTRL_BUSY, true))
+		return -ETIMEDOUT;
+
+	cadence_nand_reset_irq(cdns_ctrl);
+
+	writel(mini_ctrl_cmd_l, cdns_ctrl->reg + CMD_REG2);
+	writel(mini_ctrl_cmd_h, cdns_ctrl->reg + CMD_REG3);
+
+	/* select generic command */
+	reg |= FIELD_PREP(CMD_REG0_CT, CMD_REG0_CT_GEN);
+	/* thread number */
+	reg |= FIELD_PREP(CMD_REG0_TN, thread_nr);
+
+	/* issue command */
+	writel(reg, cdns_ctrl->reg + CMD_REG0);
+
+	return 0;
+}
+
+/* wait for data on slave dma interface */
+static int cadence_nand_wait_on_sdma(struct cdns_nand_ctrl *cdns_ctrl,
+				     u8 *out_sdma_trd,
+				     u32 *out_sdma_size)
+{
+	struct cadence_nand_irq_status irq_mask, irq_status;
+
+	irq_mask.trd_status = 0;
+	irq_mask.trd_error = 0;
+	irq_mask.status = INTR_STATUS_SDMA_TRIGG
+		| INTR_STATUS_SDMA_ERR
+		| INTR_STATUS_UNSUPP_CMD;
+
+	cadence_nand_set_irq_mask(cdns_ctrl, &irq_mask);
+	cadence_nand_wait_for_irq(cdns_ctrl, &irq_mask, &irq_status);
+	if (irq_status.status == 0) {
+		dev_err(cdns_ctrl->dev, "Timeout while waiting for SDMA\n");
+		return -ETIMEDOUT;
+	}
+
+	if (irq_status.status & INTR_STATUS_SDMA_TRIGG) {
+		*out_sdma_size = readl(cdns_ctrl->reg + SDMA_SIZE);
+		*out_sdma_trd  = readl(cdns_ctrl->reg + SDMA_TRD_NUM);
+		*out_sdma_trd =
+			FIELD_GET(SDMA_TRD_NUM_SDMA_TRD, *out_sdma_trd);
+	} else {
+		dev_err(cdns_ctrl->dev, "SDMA error - irq_status %x\n",
+			irq_status.status);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static void cadence_nand_get_caps(struct cdns_nand_ctrl *cdns_ctrl)
+{
+	u32  reg;
+
+	reg =  readl(cdns_ctrl->reg + CTRL_FEATURES);
+
+	cdns_ctrl->caps2.max_banks = 1 << FIELD_GET(CTRL_FEATURES_N_BANKS, reg);
+
+	if (FIELD_GET(CTRL_FEATURES_DMA_DWITH64, reg))
+		cdns_ctrl->caps2.data_dma_width = 8;
+	else
+		cdns_ctrl->caps2.data_dma_width = 4;
+
+	if (reg & CTRL_FEATURES_CONTROL_DATA)
+		cdns_ctrl->caps2.data_control_supp = 1;
+
+	if (reg & (CTRL_FEATURES_NVDDR_2_3
+		   | CTRL_FEATURES_NVDDR))
+		cdns_ctrl->caps2.is_phy_type_dll = 1;
+}
+
+/* prepare CDMA descriptor */
+static void
+cadence_nand_cdma_desc_prepare(struct cadence_nand_cdma_desc *cdma_desc,
+			       char nf_mem, u32 flash_ptr, char *mem_ptr,
+			       char *ctrl_data_ptr, u16 ctype)
+{
+	memset(cdma_desc, 0, sizeof(struct cadence_nand_cdma_desc));
+
+	/* set fields for one descriptor */
+	cdma_desc->flash_pointer = (nf_mem << CDMA_CFPTR_MEM_SHIFT)
+		+ flash_ptr;
+	cdma_desc->command_flags |= CDMA_CF_DMA_MASTER;
+	cdma_desc->command_flags  |= CDMA_CF_INT;
+
+	cdma_desc->memory_pointer = (uintptr_t)mem_ptr;
+	cdma_desc->status = 0;
+	cdma_desc->sync_flag_pointer = 0;
+	cdma_desc->sync_arguments = 0;
+
+	cdma_desc->command_type = ctype;
+	cdma_desc->ctrl_data_ptr = (uintptr_t)ctrl_data_ptr;
+}
+
+static u8 cadence_nand_check_desc_error(struct cdns_nand_ctrl *cdns_ctrl,
+					u32 desc_status)
+{
+	if (desc_status & CDMA_CS_ERP)
+		return STAT_ERASED;
+
+	if (desc_status & CDMA_CS_UNCE)
+		return STAT_ECC_UNCORR;
+
+	if (desc_status & CDMA_CS_ERR) {
+		dev_err(cdns_ctrl->dev, ":CDMA desc error flag detected.\n");
+		return STAT_FAIL;
+	}
+
+	if (FIELD_GET(CDMA_CS_MAXERR, desc_status))
+		return STAT_ECC_CORR;
+
+	return STAT_FAIL;
+}
+
+static int cadence_nand_cdma_finish(struct cdns_nand_ctrl *cdns_ctrl,
+				    struct cadence_nand_cdma_desc *cdma_desc)
+{
+	struct cadence_nand_cdma_desc *desc_ptr;
+	u8 status = STAT_BUSY;
+
+	desc_ptr = cdma_desc;
+
+	if (desc_ptr->status & CDMA_CS_FAIL) {
+		status = cadence_nand_check_desc_error(cdns_ctrl,
+						       desc_ptr->status);
+		dev_err(cdns_ctrl->dev, ":CDMA error %x\n", desc_ptr->status);
+	} else if (desc_ptr->status & CDMA_CS_COMP) {
+		/* descriptor finished with no errors */
+		if (desc_ptr->command_flags & CDMA_CF_CONT) {
+			dev_info(cdns_ctrl->dev, "DMA unsupported flag is set");
+			status = STAT_UNKNOWN;
+		} else {
+			/* last descriptor  */
+			status = STAT_OK;
+		}
+	}
+
+	return status;
+}
+
+static int cadence_nand_cdma_send(struct cdns_nand_ctrl *cdns_ctrl,
+				  u8 thread)
+{
+	u32 reg = 0;
+	int status;
+
+	/* wait for thread ready*/
+	status = cadence_nand_wait_for_value(cdns_ctrl, TRD_STATUS,
+					     1000000,
+					     1U << thread, true);
+	cadence_nand_reset_irq(cdns_ctrl);
+
+	writel((u32)cdns_ctrl->dma_cdma_desc,
+	       cdns_ctrl->reg + CMD_REG2);
+	writel(0, cdns_ctrl->reg + CMD_REG3);
+
+	/* select CDMA mode */
+	reg |= FIELD_PREP(CMD_REG0_CT, CMD_REG0_CT_CDMA);
+	/* thread number */
+	reg |= FIELD_PREP(CMD_REG0_TN, thread);
+	/* issue command */
+	writel(reg, cdns_ctrl->reg + CMD_REG0);
+
+	return 0;
+}
+
+/* send SDMA command and wait for finish */
+static u32
+cadence_nand_cdma_send_and_wait(struct cdns_nand_ctrl *cdns_ctrl,
+				u8 thread)
+{
+	struct cadence_nand_irq_status irq_mask, irq_status = {0};
+	int status;
+
+	irq_mask.trd_status = 1 << thread;
+	irq_mask.trd_error = 1 << thread;
+	irq_mask.status = INTR_STATUS_CDMA_TERR;
+
+	cadence_nand_set_irq_mask(cdns_ctrl, &irq_mask);
+
+	status = cadence_nand_cdma_send(cdns_ctrl, thread);
+	if (status)
+		return status;
+
+	cadence_nand_wait_for_irq(cdns_ctrl, &irq_mask, &irq_status);
+
+	if (irq_status.status == 0 && irq_status.trd_status == 0 &&
+	    irq_status.trd_error == 0) {
+		dev_err(cdns_ctrl->dev, "CDMA command timeout\n");
+		return -ETIMEDOUT;
+	}
+	if (irq_status.status & irq_mask.status) {
+		dev_err(cdns_ctrl->dev, "CDMA command failed\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * ECC size depends on configured ECC strength and on maximum supported
+ * ECC step size
+ */
+static int cadence_nand_calc_ecc_bytes(int max_step_size, int strength)
+{
+	int nbytes = DIV_ROUND_UP(fls(8 * max_step_size) * strength, 8);
+
+	return ALIGN(nbytes, 2);
+}
+
+#define CADENCE_NAND_CALC_ECC_BYTES(max_step_size) \
+	static int \
+	cadence_nand_calc_ecc_bytes_##max_step_size(int step_size, \
+						    int strength)\
+	{\
+		return cadence_nand_calc_ecc_bytes(max_step_size, strength);\
+	}
+
+CADENCE_NAND_CALC_ECC_BYTES(256)
+CADENCE_NAND_CALC_ECC_BYTES(512)
+CADENCE_NAND_CALC_ECC_BYTES(1024)
+CADENCE_NAND_CALC_ECC_BYTES(2048)
+CADENCE_NAND_CALC_ECC_BYTES(4096)
+
+/* function reads BCH configuration  */
+static int cadence_nand_read_bch_cfg(struct cdns_nand_ctrl *cdns_ctrl)
+{
+	struct nand_ecc_caps *ecc_caps = &cdns_ctrl->ecc_caps;
+	int max_step_size = 0;
+	int nstrengths;
+	u32 reg;
+	int i;
+
+	reg = readl(cdns_ctrl->reg + BCH_CFG_0);
+	cdns_ctrl->ecc_strengths[0] = FIELD_GET(BCH_CFG_0_CORR_CAP_0, reg);
+	cdns_ctrl->ecc_strengths[1] = FIELD_GET(BCH_CFG_0_CORR_CAP_1, reg);
+	cdns_ctrl->ecc_strengths[2] = FIELD_GET(BCH_CFG_0_CORR_CAP_2, reg);
+	cdns_ctrl->ecc_strengths[3] = FIELD_GET(BCH_CFG_0_CORR_CAP_3, reg);
+
+	reg = readl(cdns_ctrl->reg + BCH_CFG_1);
+	cdns_ctrl->ecc_strengths[4] = FIELD_GET(BCH_CFG_1_CORR_CAP_4, reg);
+	cdns_ctrl->ecc_strengths[5] = FIELD_GET(BCH_CFG_1_CORR_CAP_5, reg);
+	cdns_ctrl->ecc_strengths[6] = FIELD_GET(BCH_CFG_1_CORR_CAP_6, reg);
+	cdns_ctrl->ecc_strengths[7] = FIELD_GET(BCH_CFG_1_CORR_CAP_7, reg);
+
+	reg = readl(cdns_ctrl->reg + BCH_CFG_2);
+	cdns_ctrl->ecc_stepinfos[0].stepsize =
+		FIELD_GET(BCH_CFG_2_SECT_0, reg);
+
+	cdns_ctrl->ecc_stepinfos[1].stepsize =
+		FIELD_GET(BCH_CFG_2_SECT_1, reg);
+
+	nstrengths = 0;
+	for (i = 0; i < BCH_MAX_NUM_CORR_CAPS; i++) {
+		if (cdns_ctrl->ecc_strengths[i] != 0)
+			nstrengths++;
+	}
+
+	ecc_caps->nstepinfos = 0;
+	for (i = 0; i < BCH_MAX_NUM_SECTOR_SIZES; i++) {
+		/* ECC strengths are common for all step infos */
+		cdns_ctrl->ecc_stepinfos[i].nstrengths = nstrengths;
+		cdns_ctrl->ecc_stepinfos[i].strengths =
+			cdns_ctrl->ecc_strengths;
+
+		if (cdns_ctrl->ecc_stepinfos[i].stepsize != 0)
+			ecc_caps->nstepinfos++;
+
+		if (cdns_ctrl->ecc_stepinfos[i].stepsize > max_step_size)
+			max_step_size = cdns_ctrl->ecc_stepinfos[i].stepsize;
+	}
+	ecc_caps->stepinfos = &cdns_ctrl->ecc_stepinfos[0];
+
+	switch (max_step_size) {
+	case 256:
+		ecc_caps->calc_ecc_bytes = &cadence_nand_calc_ecc_bytes_256;
+		break;
+	case 512:
+		ecc_caps->calc_ecc_bytes = &cadence_nand_calc_ecc_bytes_512;
+		break;
+	case 1024:
+		ecc_caps->calc_ecc_bytes = &cadence_nand_calc_ecc_bytes_1024;
+		break;
+	case 2048:
+		ecc_caps->calc_ecc_bytes = &cadence_nand_calc_ecc_bytes_2048;
+		break;
+	case 4096:
+		ecc_caps->calc_ecc_bytes = &cadence_nand_calc_ecc_bytes_4096;
+		break;
+	default:
+		dev_err(cdns_ctrl->dev,
+			"Unsupported sector size(ecc step size) %d\n",
+			max_step_size);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/* hardware initialization */
+static int cadence_nand_hw_init(struct cdns_nand_ctrl *cdns_ctrl)
+{
+	int status = 0;
+	u32 reg;
+
+	status = cadence_nand_wait_for_value(cdns_ctrl, CTRL_STATUS,
+					     1000000,
+					     CTRL_STATUS_INIT_COMP, false);
+	if (status)
+		return status;
+
+	reg = readl(cdns_ctrl->reg + CTRL_VERSION);
+
+	dev_info(cdns_ctrl->dev,
+		 "%s: cadence nand controller version reg %x\n",
+		 __func__, reg);
+
+	/* disable cache and multiplane */
+	writel(0, cdns_ctrl->reg + MULTIPLANE_CFG);
+	writel(0, cdns_ctrl->reg + CACHE_CFG);
+
+	/* clear all interrupts */
+	writel(0xFFFFFFFF, cdns_ctrl->reg + INTR_STATUS);
+
+	cadence_nand_get_caps(cdns_ctrl);
+	cadence_nand_read_bch_cfg(cdns_ctrl);
+
+	/*
+	 * set io width access to 8
+	 * it is because during SW device dicovering width access
+	 * is expected to be 8
+	 */
+	status = cadence_nand_set_access_width16(cdns_ctrl, false);
+
+	return status;
+}
+
+#define TT_OOB_AREA		1
+#define TT_MAIN_OOB_AREAS	2
+#define TT_RAW_PAGE		3
+#define TT_BBM			4
+#define TT_MAIN_OOB_AREA_EXT	5
+
+/* prepare size of data to transfer */
+static int
+cadence_nand_prepare_data_size(struct nand_chip *chip,
+			       int transfer_type)
+{
+	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
+	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
+	u32 sec_size = 0, last_sec_size, offset = 0, sec_cnt = 1;
+	u32 ecc_size = chip->ecc.bytes;
+	u32 data_ctrl_size = 0;
+	u32 reg = 0;
+
+	if (cdns_ctrl->curr_trans_type == transfer_type)
+		return 0;
+
+	switch (transfer_type) {
+	case TT_OOB_AREA:
+		offset = cdns_chip->main_size - cdns_chip->sector_size;
+		ecc_size = ecc_size * (offset / cdns_chip->sector_size);
+		offset = offset + ecc_size;
+		sec_cnt = 1;
+		last_sec_size = cdns_chip->sector_size
+			+ cdns_chip->avail_oob_size;
+		break;
+	case TT_MAIN_OOB_AREA_EXT:
+		sec_cnt = cdns_chip->sector_count;
+		last_sec_size = cdns_chip->sector_size;
+		sec_size = cdns_chip->sector_size;
+		data_ctrl_size = cdns_chip->avail_oob_size;
+		break;
+	case TT_MAIN_OOB_AREAS:
+		sec_cnt = cdns_chip->sector_count;
+		last_sec_size = cdns_chip->sector_size
+			+ cdns_chip->avail_oob_size;
+		sec_size = cdns_chip->sector_size;
+		break;
+	case TT_RAW_PAGE:
+		last_sec_size = cdns_chip->main_size + cdns_chip->oob_size;
+		break;
+	case TT_BBM:
+		offset = cdns_chip->main_size + cdns_chip->bbm_offs;
+		last_sec_size = 8;
+		break;
+	default:
+		dev_err(cdns_ctrl->dev, "Data size preparation failed\n");
+		return -EINVAL;
+	}
+
+	reg = 0;
+	reg |= FIELD_PREP(TRAN_CFG_0_OFFSET, offset);
+	reg |= FIELD_PREP(TRAN_CFG_0_SEC_CNT, sec_cnt);
+	writel(reg, cdns_ctrl->reg + TRAN_CFG_0);
+
+	reg = 0;
+	reg |= FIELD_PREP(TRAN_CFG_1_LAST_SEC_SIZE, last_sec_size);
+	reg |= FIELD_PREP(TRAN_CFG_1_SECTOR_SIZE, sec_size);
+	writel(reg, cdns_ctrl->reg + TRAN_CFG_1);
+
+	reg = readl(cdns_ctrl->reg + CONTROL_DATA_CTRL);
+	reg &= ~CONTROL_DATA_CTRL_SIZE;
+	reg |= FIELD_PREP(CONTROL_DATA_CTRL_SIZE, data_ctrl_size);
+	writel(reg, cdns_ctrl->reg + CONTROL_DATA_CTRL);
+
+	cdns_ctrl->curr_trans_type = transfer_type;
+
+	return 0;
+}
+
+static int
+cadence_nand_cdma_transfer(struct cdns_nand_ctrl *cdns_ctrl, u8 chip_nr,
+			   int page, void *buf, void *ctrl_dat, u32 buf_size,
+			   u32 ctrl_dat_size, enum dma_data_direction dir,
+			   bool with_ecc)
+{
+	struct cadence_nand_cdma_desc *cdma_desc = cdns_ctrl->cdma_desc;
+	dma_addr_t dma_buf = 0, dma_ctrl_dat = 0;
+	u8 thread_nr = chip_nr;
+	int status = 0;
+	u16 ctype;
+
+	if (dir == DMA_FROM_DEVICE)
+		ctype = CDMA_CT_RD;
+	else
+		ctype = CDMA_CT_WR;
+
+	cadence_nand_set_ecc_enable(cdns_ctrl, with_ecc);
+
+	dma_buf = dma_map_single(cdns_ctrl->dev, buf, buf_size, dir);
+	if (dma_mapping_error(cdns_ctrl->dev, dma_buf)) {
+		dev_err(cdns_ctrl->dev, "Failed to map DMA buffer\n");
+		return -EIO;
+	}
+
+	if (ctrl_dat && ctrl_dat_size) {
+		dma_ctrl_dat = dma_map_single(cdns_ctrl->dev, ctrl_dat,
+					      ctrl_dat_size, dir);
+		if (dma_mapping_error(cdns_ctrl->dev, dma_ctrl_dat)) {
+			dma_unmap_single(cdns_ctrl->dev, dma_buf,
+					 buf_size, dir);
+			dev_err(cdns_ctrl->dev, "Failed to map DMA buffer\n");
+			return -EIO;
+		}
+	}
+
+	cadence_nand_cdma_desc_prepare(cdma_desc, chip_nr, page,
+				       (void *)dma_buf, (void *)dma_ctrl_dat,
+				       ctype);
+
+	status = cadence_nand_cdma_send_and_wait(cdns_ctrl, thread_nr);
+
+	dma_unmap_single(cdns_ctrl->dev, dma_buf,
+			 buf_size, dir);
+
+	if (ctrl_dat && ctrl_dat_size)
+		dma_unmap_single(cdns_ctrl->dev, dma_ctrl_dat,
+				 ctrl_dat_size, dir);
+	if (status)
+		return status;
+
+	return cadence_nand_cdma_finish(cdns_ctrl, cdns_ctrl->cdma_desc);
+}
+
+static void cadence_nand_get_timings(struct cdns_nand_ctrl *cdns_ctrl,
+				     struct cadence_nand_timings *t)
+{
+	t->async_toggle_timings = readl(cdns_ctrl->reg + ASYNC_TOGGLE_TIMINGS);
+	t->timings0 = readl(cdns_ctrl->reg + TIMINGS0);
+	t->timings1 = readl(cdns_ctrl->reg + TIMINGS1);
+	t->timings2 = readl(cdns_ctrl->reg + TIMINGS2);
+	t->phy_ctrl = readl(cdns_ctrl->reg + PHY_CTRL);
+
+	if (cdns_ctrl->caps2.is_phy_type_dll) {
+		t->toggle_timings_0 = readl(cdns_ctrl->reg + TOGGLE_TIMINGS0);
+		t->toggle_timings_1 = readl(cdns_ctrl->reg + TOGGLE_TIMINGS1);
+		t->sync_timings = readl(cdns_ctrl->reg + SYNC_TIMINGS);
+		t->dll_phy_ctrl = readl(cdns_ctrl->reg + DLL_PHY_CTRL);
+		t->phy_dqs_timing = readl(cdns_ctrl->reg + PHY_DQS_TIMING);
+		t->phy_gate_lpbk_ctrl =
+			readl(cdns_ctrl->reg + PHY_GATE_LPBK_CTRL);
+	}
+}
+
+static int cadence_nand_set_timings(struct cdns_nand_ctrl *cdns_ctrl,
+				    struct cadence_nand_timings *t)
+{
+	if (cadence_nand_wait_for_value(cdns_ctrl, CTRL_STATUS,
+					1000000,
+					CTRL_STATUS_CTRL_BUSY, true))
+		return -ETIMEDOUT;
+
+	writel(t->async_toggle_timings, cdns_ctrl->reg + ASYNC_TOGGLE_TIMINGS);
+	writel(t->timings0, cdns_ctrl->reg + TIMINGS0);
+	writel(t->timings1, cdns_ctrl->reg + TIMINGS1);
+	writel(t->timings2, cdns_ctrl->reg + TIMINGS2);
+
+	if (cdns_ctrl->caps2.is_phy_type_dll) {
+		writel(t->toggle_timings_0, cdns_ctrl->reg + TOGGLE_TIMINGS0);
+		writel(t->toggle_timings_1, cdns_ctrl->reg + TOGGLE_TIMINGS1);
+		writel(t->sync_timings, cdns_ctrl->reg + SYNC_TIMINGS);
+		writel(t->dll_phy_ctrl, cdns_ctrl->reg + DLL_PHY_CTRL);
+	}
+
+	writel(t->phy_ctrl, cdns_ctrl->reg + PHY_CTRL);
+
+	if (cdns_ctrl->caps2.is_phy_type_dll) {
+		writel(0, cdns_ctrl->reg + PHY_TSEL);
+		writel(2, cdns_ctrl->reg + PHY_DQ_TIMING);
+		writel(t->phy_dqs_timing, cdns_ctrl->reg + PHY_DQS_TIMING);
+		writel(t->phy_gate_lpbk_ctrl,
+		       cdns_ctrl->reg + PHY_GATE_LPBK_CTRL);
+		writel(PHY_DLL_MASTER_CTRL_BYPASS_MODE,
+		       cdns_ctrl->reg + PHY_DLL_MASTER_CTRL);
+		writel(0, cdns_ctrl->reg + PHY_DLL_SLAVE_CTRL);
+	}
+
+	return 0;
+}
+
+static int cadence_nand_select_target(struct nand_chip *chip)
+{
+	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
+	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
+	int ret;
+
+	if (chip == cdns_ctrl->selected_chip)
+		return 0;
+
+	ret = cadence_nand_set_timings(cdns_ctrl, &cdns_chip->timings);
+	if (ret)
+		return ret;
+
+	ret = cadence_nand_set_ecc_strength(cdns_ctrl,
+					    cdns_chip->corr_str_idx);
+	if (ret)
+		return ret;
+
+	ret = cadence_nand_set_erase_detection(cdns_ctrl, true,
+					       chip->ecc.strength);
+	if (ret)
+		return ret;
+
+	cdns_ctrl->curr_trans_type = -1;
+	cdns_ctrl->selected_chip = chip;
+
+	return ret;
+}
+
+static int cadence_nand_erase(struct nand_chip *chip, u32 page)
+{
+	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
+	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
+	int status;
+	u8 thread_nr = cdns_chip->cs[chip->cur_cs];
+
+	cadence_nand_cdma_desc_prepare(cdns_ctrl->cdma_desc,
+				       cdns_chip->cs[chip->cur_cs],
+				       page, NULL, NULL,
+				       CDMA_CT_ERASE);
+	status = cadence_nand_cdma_send_and_wait(cdns_ctrl, thread_nr);
+	if (status) {
+		dev_err(cdns_ctrl->dev, "erase operation failed\n");
+		return -EIO;
+	}
+
+	status = cadence_nand_cdma_finish(cdns_ctrl, cdns_ctrl->cdma_desc);
+	if (status)
+		return status;
+
+	return 0;
+}
+
+static int cadence_nand_write_oob(struct nand_chip *chip, int page)
+{
+	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
+	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
+	u8 *buf = chip->oob_poi;
+	u32 bbm_offset;
+	int status = 0;
+
+	status = cadence_nand_select_target(chip);
+	if (status)
+		return status;
+
+	bbm_offset = (cdns_chip->sector_count - 1) * (cdns_chip->sector_size
+						  + chip->ecc.bytes);
+	bbm_offset = cdns_chip->main_size - bbm_offset + cdns_chip->bbm_offs;
+
+	/*
+	 * to preseve page layout with ECC enabled
+	 * we send also one data sector filled with 0xFF
+	 * <0xFF 0xFF ....><oob data><HW calculated ECC>
+	 */
+	memset(cdns_ctrl->buf, 0xFF, cdns_chip->sector_size);
+	memcpy(cdns_ctrl->buf + cdns_chip->sector_size, buf,
+	       cdns_chip->avail_oob_size);
+
+	cadence_nand_set_skip_bytes_conf(cdns_ctrl, cdns_chip->bbm_len,
+					 bbm_offset, 1);
+	cadence_nand_set_skip_marker_val(cdns_ctrl,
+					 *(u16 *)(buf +
+						       cdns_chip->bbm_offs));
+
+	status = cadence_nand_prepare_data_size(chip, TT_OOB_AREA);
+	if (status) {
+		dev_err(cdns_ctrl->dev, "write oob failed\n");
+		return status;
+	}
+
+	return cadence_nand_cdma_transfer(cdns_ctrl,
+					  cdns_chip->cs[chip->cur_cs],
+					  page, cdns_ctrl->buf, NULL,
+					  cdns_chip->sector_size
+					  + cdns_chip->avail_oob_size,
+					  0, DMA_TO_DEVICE, true);
+}
+
+static int cadence_nand_read_bbm(struct nand_chip *chip, int page, u8 *buf)
+{
+	int status;
+	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
+	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
+
+	status = cadence_nand_prepare_data_size(chip, TT_BBM);
+	if (status)
+		return -EIO;
+
+	cadence_nand_set_skip_bytes_conf(cdns_ctrl, 0, 0, 0);
+
+	/*
+	 * read only bad block marker from offset
+	 * defined by a memory manufacturer
+	 */
+	status = cadence_nand_cdma_transfer(cdns_ctrl,
+					    cdns_chip->cs[chip->cur_cs],
+					    page, cdns_ctrl->buf, NULL,
+					    cdns_chip->oob_size,
+					    0, DMA_FROM_DEVICE, false);
+	if (status) {
+		dev_err(cdns_ctrl->dev, "read BBM failed\n");
+		return -EIO;
+	}
+
+	memcpy(buf + cdns_chip->bbm_offs, cdns_ctrl->buf, cdns_chip->bbm_len);
+
+	return 0;
+}
+
+/* reads OOB data from the device */
+static int cadence_nand_read_oob(struct nand_chip *chip,
+				 int page)
+{
+	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
+	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
+	int status = 0;
+	u8 *buf = chip->oob_poi;
+	u32 bbm_offset;
+
+	status = cadence_nand_select_target(chip);
+	if (status)
+		return status;
+
+	status = cadence_nand_prepare_data_size(chip, TT_OOB_AREA);
+	if (status)
+		return -EIO;
+
+	bbm_offset = (cdns_chip->sector_count - 1) * (cdns_chip->sector_size
+						  + chip->ecc.bytes);
+	bbm_offset = cdns_chip->main_size - bbm_offset + cdns_chip->bbm_offs;
+	cadence_nand_set_skip_bytes_conf(cdns_ctrl, cdns_chip->bbm_len,
+					 bbm_offset, 1);
+
+	/*
+	 * read last sector and spare data
+	 * to be able to calculate ECC properly by controller
+	 */
+	status = cadence_nand_cdma_transfer(cdns_ctrl,
+					    cdns_chip->cs[chip->cur_cs],
+					    page, cdns_ctrl->buf,
+					    NULL, cdns_chip->sector_size
+					    + cdns_chip->avail_oob_size,
+					    0, DMA_FROM_DEVICE, true);
+
+	switch (status) {
+	case STAT_ECC_UNCORR:
+		dev_warn(cdns_ctrl->dev, "ECC errors occur in read oob function\n");
+		break;
+	case STAT_OK:
+	case STAT_ERASED:
+	case STAT_ECC_CORR:
+		break;
+	default:
+		dev_err(cdns_ctrl->dev, "read oob failed err %d\n", status);
+		return -EIO;
+	}
+
+	/* ignore sector data, copy only oob data*/
+	memcpy(buf, cdns_ctrl->buf + cdns_chip->sector_size,
+	       cdns_chip->avail_oob_size);
+
+	return cadence_nand_read_bbm(chip, page, buf);
+}
+
+static int cadence_nand_write_page(struct nand_chip *chip,
+				   const u8 *buf, int oob_required,
+				   int page)
+{
+	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
+	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
+	int status = 0;
+	u16 marker_val = 0xFFFF;
+
+	status = cadence_nand_select_target(chip);
+	if (status)
+		return status;
+
+	cadence_nand_set_skip_bytes_conf(cdns_ctrl, cdns_chip->bbm_len,
+					 cdns_chip->main_size
+					 + cdns_chip->bbm_offs,
+					 1);
+
+	if (oob_required) {
+		marker_val = *(u16 *)(chip->oob_poi
+				      + cdns_chip->bbm_offs);
+	} else {
+		/* just set oob data to 0xFF */
+		memset(cdns_ctrl->buf + cdns_chip->main_size, 0xFF,
+		       cdns_chip->avail_oob_size);
+	}
+
+	cadence_nand_set_skip_marker_val(cdns_ctrl, marker_val);
+
+	status = cadence_nand_prepare_data_size(chip,
+						TT_MAIN_OOB_AREA_EXT);
+	if (status) {
+		dev_err(cdns_ctrl->dev, "write page failed\n");
+		return -EIO;
+	}
+
+	if (cadence_nand_dma_buf_ok(cdns_ctrl, buf, cdns_chip->main_size) &&
+	    cdns_ctrl->caps2.data_control_supp) {
+		u8 *oob;
+
+		if (oob_required)
+			oob = chip->oob_poi;
+		else
+			oob = cdns_ctrl->buf + cdns_chip->main_size;
+
+		status = cadence_nand_cdma_transfer(cdns_ctrl,
+						    cdns_chip->cs[chip->cur_cs],
+						    page, (void *)buf, oob,
+						    cdns_chip->main_size,
+						    cdns_chip->avail_oob_size,
+						    DMA_TO_DEVICE, true);
+		if (status) {
+			dev_err(cdns_ctrl->dev, "write page failed\n");
+			return -EIO;
+		}
+
+		return 0;
+	}
+
+	if (oob_required) {
+		/* transfer the data to the oob area */
+		memcpy(cdns_ctrl->buf + cdns_chip->main_size, chip->oob_poi,
+		       cdns_chip->avail_oob_size);
+	}
+
+	memcpy(cdns_ctrl->buf, buf, cdns_chip->main_size);
+
+	cadence_nand_prepare_data_size(chip, TT_MAIN_OOB_AREAS);
+
+	return cadence_nand_cdma_transfer(cdns_ctrl,
+					  cdns_chip->cs[chip->cur_cs],
+					  page, cdns_ctrl->buf, NULL,
+					  cdns_chip->main_size
+					  + cdns_chip->avail_oob_size,
+					  0, DMA_TO_DEVICE, true);
+}
+
+static int cadence_nand_write_page_raw(struct nand_chip *chip,
+				       const u8 *buf, int oob_required,
+				       int page)
+{
+	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
+	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
+	int writesize = cdns_chip->main_size;
+	int oobsize = cdns_chip->oob_size;
+	int ecc_steps = chip->ecc.steps;
+	int ecc_size = chip->ecc.size;
+	int ecc_bytes = chip->ecc.bytes;
+	void *tmp_buf = cdns_ctrl->buf;
+	int oob_skip = cdns_chip->bbm_len;
+	size_t size = writesize + oobsize;
+	int i, pos, len;
+	int status = 0;
+
+	status = cadence_nand_select_target(chip);
+	if (status)
+		return status;
+
+	/*
+	 * Fill the buffer with 0xff first except the full page transfer.
+	 * This simplifies the logic.
+	 */
+	if (!buf || !oob_required)
+		memset(tmp_buf, 0xff, size);
+
+	cadence_nand_set_skip_bytes_conf(cdns_ctrl, 0, 0, 0);
+
+	/* Arrange the buffer for syndrome payload/ecc layout */
+	if (buf) {
+		for (i = 0; i < ecc_steps; i++) {
+			pos = i * (ecc_size + ecc_bytes);
+			len = ecc_size;
+
+			if (pos >= writesize)
+				pos += oob_skip;
+			else if (pos + len > writesize)
+				len = writesize - pos;
+
+			memcpy(tmp_buf + pos, buf, len);
+			buf += len;
+			if (len < ecc_size) {
+				len = ecc_size - len;
+				memcpy(tmp_buf + writesize + oob_skip, buf,
+				       len);
+				buf += len;
+			}
+		}
+	}
+
+	if (oob_required) {
+		const u8 *oob = chip->oob_poi;
+		u32 oob_data_offset = (cdns_chip->sector_count - 1) *
+			(cdns_chip->sector_size + chip->ecc.bytes)
+			+ cdns_chip->sector_size + oob_skip;
+
+		/* BBM at the beginning of the OOB area */
+		memcpy(tmp_buf + writesize, oob, oob_skip);
+
+		/* OOB free */
+		memcpy(tmp_buf + oob_data_offset, oob,
+		       cdns_chip->avail_oob_size);
+		oob += cdns_chip->avail_oob_size;
+
+		/* OOB ECC */
+		for (i = 0; i < ecc_steps; i++) {
+			pos = ecc_size + i * (ecc_size + ecc_bytes);
+			if (i == (ecc_steps - 1))
+				pos += cdns_chip->avail_oob_size;
+
+			len = ecc_bytes;
+
+			if (pos >= writesize)
+				pos += oob_skip;
+			else if (pos + len > writesize)
+				len = writesize - pos;
+
+			memcpy(tmp_buf + pos, oob, len);
+			oob += len;
+			if (len < ecc_bytes) {
+				len = ecc_bytes - len;
+				memcpy(tmp_buf + writesize + oob_skip, oob,
+				       len);
+				oob += len;
+			}
+		}
+	}
+
+	status = cadence_nand_prepare_data_size(chip, TT_RAW_PAGE);
+	if (status) {
+		dev_err(cdns_ctrl->dev, "write page failed\n");
+		return -EIO;
+	}
+
+	return cadence_nand_cdma_transfer(cdns_ctrl,
+					  cdns_chip->cs[chip->cur_cs],
+					  page, cdns_ctrl->buf, NULL,
+					  cdns_chip->main_size +
+					  cdns_chip->oob_size,
+					  0, DMA_TO_DEVICE, false);
+}
+
+static int cadence_nand_write_oob_raw(struct nand_chip *chip,
+				      int page)
+{
+	return cadence_nand_write_page_raw(chip, NULL, true, page);
+}
+
+static int cadence_nand_read_page(struct nand_chip *chip,
+				  u8 *buf, int oob_required, int page)
+{
+	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
+	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	int status = 0;
+	int ecc_err_count = 0;
+
+	status = cadence_nand_select_target(chip);
+	if (status)
+		return status;
+
+	cadence_nand_set_skip_bytes_conf(cdns_ctrl, cdns_chip->bbm_len,
+					 cdns_chip->main_size
+					 + cdns_chip->bbm_offs, 1);
+
+	/* if data buffer is can be accessed by DMA and data_control feature
+	 * is supported then transfer data and oob directly
+	 */
+	if (cadence_nand_dma_buf_ok(cdns_ctrl, buf, cdns_chip->main_size) &&
+	    cdns_ctrl->caps2.data_control_supp) {
+		u8 *oob;
+
+		if (oob_required)
+			oob = chip->oob_poi;
+		else
+			oob = cdns_ctrl->buf + cdns_chip->main_size;
+
+		cadence_nand_prepare_data_size(chip, TT_MAIN_OOB_AREA_EXT);
+		status = cadence_nand_cdma_transfer(cdns_ctrl,
+						    cdns_chip->cs[chip->cur_cs],
+						    page, buf, oob,
+						    cdns_chip->main_size,
+						    cdns_chip->avail_oob_size,
+						    DMA_FROM_DEVICE, true);
+	/* otherwise use bounce buffer */
+	} else {
+		cadence_nand_prepare_data_size(chip, TT_MAIN_OOB_AREAS);
+		status = cadence_nand_cdma_transfer(cdns_ctrl,
+						    cdns_chip->cs[chip->cur_cs],
+						    page, cdns_ctrl->buf,
+						    NULL, cdns_chip->main_size
+						    + cdns_chip->avail_oob_size,
+						    0, DMA_FROM_DEVICE, true);
+
+		memcpy(buf, cdns_ctrl->buf, cdns_chip->main_size);
+		if (oob_required)
+			memcpy(chip->oob_poi,
+			       cdns_ctrl->buf + cdns_chip->main_size,
+			       cdns_chip->oob_size);
+	}
+
+	switch (status) {
+	case STAT_ECC_UNCORR:
+		mtd->ecc_stats.failed++;
+		ecc_err_count++;
+		break;
+	case STAT_ECC_CORR:
+		ecc_err_count = FIELD_GET(CDMA_CS_MAXERR,
+					  cdns_ctrl->cdma_desc->status);
+		mtd->ecc_stats.corrected += ecc_err_count;
+		break;
+	case STAT_ERASED:
+	case STAT_OK:
+		break;
+	default:
+		dev_err(cdns_ctrl->dev, "read page failed\n");
+		return -EIO;
+	}
+
+	if (oob_required)
+		if (cadence_nand_read_bbm(chip, page, chip->oob_poi))
+			return -EIO;
+
+	return ecc_err_count;
+}
+
+static int cadence_nand_read_page_raw(struct nand_chip *chip,
+				      u8 *buf, int oob_required, int page)
+{
+	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
+	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
+	int oob_skip = cdns_chip->bbm_len;
+	int writesize = cdns_chip->main_size;
+	int ecc_steps = chip->ecc.steps;
+	int ecc_size = chip->ecc.size;
+	int ecc_bytes = chip->ecc.bytes;
+	void *tmp_buf = cdns_ctrl->buf;
+	int i, pos, len;
+	int status = 0;
+
+	status = cadence_nand_select_target(chip);
+	if (status)
+		return status;
+
+	cadence_nand_set_skip_bytes_conf(cdns_ctrl, 0, 0, 0);
+
+	cadence_nand_prepare_data_size(chip, TT_RAW_PAGE);
+	status = cadence_nand_cdma_transfer(cdns_ctrl,
+					    cdns_chip->cs[chip->cur_cs],
+					    page, cdns_ctrl->buf,
+					    NULL,
+					    cdns_chip->main_size
+					    + cdns_chip->oob_size,
+					    0, DMA_FROM_DEVICE, false);
+
+	switch (status) {
+	case STAT_ERASED:
+	case STAT_OK:
+		break;
+	default:
+		dev_err(cdns_ctrl->dev, "read raw page failed\n");
+		return -EIO;
+	}
+
+	/* Arrange the buffer for syndrome payload/ecc layout */
+	if (buf) {
+		for (i = 0; i < ecc_steps; i++) {
+			pos = i * (ecc_size + ecc_bytes);
+			len = ecc_size;
+
+			if (pos >= writesize)
+				pos += oob_skip;
+			else if (pos + len > writesize)
+				len = writesize - pos;
+
+			memcpy(buf, tmp_buf + pos, len);
+			buf += len;
+			if (len < ecc_size) {
+				len = ecc_size - len;
+				memcpy(buf, tmp_buf + writesize + oob_skip,
+				       len);
+				buf += len;
+			}
+		}
+	}
+
+	if (oob_required) {
+		u8 *oob = chip->oob_poi;
+		u32 oob_data_offset = (cdns_chip->sector_count - 1) *
+			(cdns_chip->sector_size + chip->ecc.bytes)
+			+ cdns_chip->sector_size + oob_skip;
+
+		/* OOB free */
+		memcpy(oob, tmp_buf + oob_data_offset,
+		       cdns_chip->avail_oob_size);
+
+		/* BBM at the beginning of the OOB area */
+		memcpy(oob, tmp_buf + writesize, oob_skip);
+
+		oob += cdns_chip->avail_oob_size;
+
+		/* OOB ECC */
+		for (i = 0; i < ecc_steps; i++) {
+			pos = ecc_size + i * (ecc_size + ecc_bytes);
+			len = ecc_bytes;
+
+			if (i == (ecc_steps - 1))
+				pos += cdns_chip->avail_oob_size;
+
+			if (pos >= writesize)
+				pos += oob_skip;
+			else if (pos + len > writesize)
+				len = writesize - pos;
+
+			memcpy(oob, tmp_buf + pos, len);
+			oob += len;
+			if (len < ecc_bytes) {
+				len = ecc_bytes - len;
+				memcpy(oob, tmp_buf + writesize + oob_skip,
+				       len);
+				oob += len;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int cadence_nand_read_oob_raw(struct nand_chip *chip,
+				     int page)
+{
+	return cadence_nand_read_page_raw(chip, NULL, true, page);
+}
+
+static void cadence_nand_slave_dma_transfer_finished(void *data)
+{
+	struct completion *finished = data;
+
+	complete(finished);
+}
+
+static int cadence_nand_slave_dma_transfer(struct cdns_nand_ctrl *cdns_ctrl,
+					   void *buf,
+					   dma_addr_t dev_dma, size_t len,
+					   enum dma_data_direction dir)
+{
+	DECLARE_COMPLETION_ONSTACK(finished);
+	struct dma_chan *chan;
+	struct dma_device *dma_dev;
+	dma_addr_t src_dma, dst_dma, buf_dma;
+	struct dma_async_tx_descriptor *tx;
+	dma_cookie_t cookie;
+
+	chan = cdns_ctrl->dmac;
+	dma_dev = chan->device;
+
+	buf_dma = dma_map_single(dma_dev->dev, buf, len, dir);
+	if (dma_mapping_error(dma_dev->dev, buf_dma)) {
+		dev_err(cdns_ctrl->dev, "Failed to map DMA buffer\n");
+		goto err;
+	}
+
+	if (dir == DMA_FROM_DEVICE) {
+		src_dma = cdns_ctrl->io.dma;
+		dst_dma = buf_dma;
+	} else {
+		src_dma = buf_dma;
+		dst_dma = cdns_ctrl->io.dma;
+	}
+
+	tx = dmaengine_prep_dma_memcpy(cdns_ctrl->dmac, dst_dma, src_dma, len,
+				       DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	if (!tx) {
+		dev_err(cdns_ctrl->dev, "Failed to prepare DMA memcpy\n");
+		goto err_unmap;
+	}
+
+	tx->callback = cadence_nand_slave_dma_transfer_finished;
+	tx->callback_param = &finished;
+
+	cookie = dmaengine_submit(tx);
+	if (dma_submit_error(cookie)) {
+		dev_err(cdns_ctrl->dev, "Failed to do DMA tx_submit\n");
+		goto err_unmap;
+	}
+
+	dma_async_issue_pending(cdns_ctrl->dmac);
+	wait_for_completion(&finished);
+
+	dma_unmap_single(cdns_ctrl->dev, buf_dma, len, dir);
+
+	return 0;
+
+err_unmap:
+	dma_unmap_single(cdns_ctrl->dev, buf_dma, len, dir);
+
+err:
+	dev_dbg(cdns_ctrl->dev, "Fall back to CPU I/O\n");
+
+	return -EIO;
+}
+
+static int cadence_nand_read_buf(struct cdns_nand_ctrl *cdns_ctrl,
+				 u8 *buf, int len)
+{
+	int len_aligned = ALIGN(len, cdns_ctrl->caps2.data_dma_width);
+	u8 thread_nr = 0;
+	u32 sdma_size;
+	int ret, status = 0;
+
+	if (!cdns_ctrl->caps1->has_dma) {
+		if (len & 3) {
+			dev_err(cdns_ctrl->dev, "unaligned data\n");
+			return -EIO;
+		}
+		readsl(cdns_ctrl->io.virt, buf, len / 4);
+		return 0;
+	}
+
+	/* wait until slave DMA interface is ready to data transfer */
+	ret = cadence_nand_wait_on_sdma(cdns_ctrl, &thread_nr, &sdma_size);
+	if (ret)
+		return ret;
+
+	if (sdma_size != len_aligned) {
+		dev_err(cdns_ctrl->dev, "unexpected scenario\n");
+		return -EIO;
+	}
+
+	if (cdns_ctrl->dmac && cadence_nand_dma_buf_ok(cdns_ctrl, buf, len)) {
+		status = cadence_nand_slave_dma_transfer(cdns_ctrl, buf,
+							 cdns_ctrl->io.dma,
+							 len, DMA_FROM_DEVICE);
+		if (status == 0)
+			return 0;
+
+		dev_warn(cdns_ctrl->dev,
+			 "Slave DMA transfer failed. Try again using bounce buffer.");
+	}
+
+	/* if DMA transfer is not possible or failed then use bounce buffer */
+	status = cadence_nand_slave_dma_transfer(cdns_ctrl, cdns_ctrl->buf,
+						 cdns_ctrl->io.dma,
+						 len_aligned, DMA_FROM_DEVICE);
+
+	if (status) {
+		dev_err(cdns_ctrl->dev, "Slave DMA transfer failed");
+		return status;
+	}
+
+	memcpy(buf, cdns_ctrl->buf, len);
+
+	return 0;
+}
+
+static int cadence_nand_write_buf(struct cdns_nand_ctrl *cdns_ctrl,
+				  const u8 *buf, int len)
+{
+	u8 thread_nr = 0;
+	u32 sdma_size;
+	int ret, status = 0;
+	int len_aligned = ALIGN(len, cdns_ctrl->caps2.data_dma_width);
+
+	if (!cdns_ctrl->caps1->has_dma) {
+		if (len & 3) {
+			dev_err(cdns_ctrl->dev, "unaligned data\n");
+			return -EIO;
+		}
+		writesl(cdns_ctrl->io.virt, buf, len / 4);
+		return 0;
+	}
+
+	/* wait until slave DMA interface is ready to data transfer */
+	ret = cadence_nand_wait_on_sdma(cdns_ctrl, &thread_nr, &sdma_size);
+	if (ret)
+		return ret;
+
+	if (sdma_size != len_aligned) {
+		dev_err(cdns_ctrl->dev, "Error unexpected scenario\n");
+		return -EIO;
+	}
+
+	if (cdns_ctrl->dmac && cadence_nand_dma_buf_ok(cdns_ctrl, buf, len)) {
+		status = cadence_nand_slave_dma_transfer(cdns_ctrl, (void *)buf,
+							 cdns_ctrl->io.dma,
+							 len, DMA_TO_DEVICE);
+		if (status == 0)
+			return 0;
+
+		dev_warn(cdns_ctrl->dev,
+			 "Slave DMA transfer failed. Try again using bounce buffer.");
+	}
+
+	/* if DMA transfer is not possible or failed then use bounce buffer */
+	memcpy(cdns_ctrl->buf, buf, len);
+
+	status = cadence_nand_slave_dma_transfer(cdns_ctrl, cdns_ctrl->buf,
+						 cdns_ctrl->io.dma,
+						 len_aligned, DMA_TO_DEVICE);
+
+	if (status)
+		dev_err(cdns_ctrl->dev, "Slave DMA transfer failed");
+
+	return status;
+}
+
+static int cadence_nand_force_byte_access(struct nand_chip *chip,
+					  bool force_8bit)
+{
+	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
+	int status;
+
+	/*
+	 * Callers of this function do not verify if the NAND is using a 16-bit
+	 * an 8-bit bus for normal operations, so we need to take care of that
+	 * here by leaving the configuration unchanged if the NAND does not have
+	 * the NAND_BUSWIDTH_16 flag set.
+	 */
+	if (!(chip->options & NAND_BUSWIDTH_16))
+		return 0;
+
+	status = cadence_nand_set_access_width16(cdns_ctrl, !force_8bit);
+
+	return status;
+}
+
+static int cadence_nand_cmd_opcode(struct nand_chip *chip,
+				   const struct nand_subop *subop)
+{
+	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
+	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
+	const struct nand_op_instr *instr;
+	unsigned int op_id = 0;
+	u64 mini_ctrl_cmd = 0;
+	int ret;
+
+	instr = &subop->instrs[op_id];
+
+	if (instr->delay_ns > 0)
+		mini_ctrl_cmd |= GCMD_LAY_TWB;
+
+	mini_ctrl_cmd |= FIELD_PREP(GCMD_LAY_INSTR,
+				    GCMD_LAY_INSTR_CMD);
+	mini_ctrl_cmd |= FIELD_PREP(GCMD_LAY_INPUT_CMD,
+				    instr->ctx.cmd.opcode);
+
+	ret = cadence_nand_generic_cmd_send(cdns_ctrl,
+					    cdns_chip->cs[chip->cur_cs],
+					    mini_ctrl_cmd);
+	if (ret)
+		dev_err(cdns_ctrl->dev, "send cmd %x failed\n",
+			instr->ctx.cmd.opcode);
+
+	return ret;
+}
+
+static int cadence_nand_cmd_address(struct nand_chip *chip,
+				    const struct nand_subop *subop)
+{
+	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
+	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
+	const struct nand_op_instr *instr;
+	unsigned int op_id = 0;
+	u64 mini_ctrl_cmd = 0;
+	unsigned int offset, naddrs;
+	u64 address = 0;
+	const u8 *addrs;
+	int ret;
+	int i;
+
+	instr = &subop->instrs[op_id];
+
+	if (instr->delay_ns > 0)
+		mini_ctrl_cmd |= GCMD_LAY_TWB;
+
+	mini_ctrl_cmd |= FIELD_PREP(GCMD_LAY_INSTR,
+				    GCMD_LAY_INSTR_ADDR);
+
+	offset = nand_subop_get_addr_start_off(subop, op_id);
+	naddrs = nand_subop_get_num_addr_cyc(subop, op_id);
+	addrs = &instr->ctx.addr.addrs[offset];
+
+	for (i = 0; i < naddrs; i++)
+		address |= (u64)addrs[i] << (8 * i);
+
+	mini_ctrl_cmd |= FIELD_PREP(GCMD_LAY_INPUT_ADDR,
+				    address);
+	/*0 - 1 byte of address, 1 - 2 bytes of address ...*/
+	mini_ctrl_cmd |= FIELD_PREP(GCMD_LAY_INPUT_ADDR_SIZE,
+				    naddrs - 1);
+
+	ret = cadence_nand_generic_cmd_send(cdns_ctrl,
+					    cdns_chip->cs[chip->cur_cs],
+					    mini_ctrl_cmd);
+	if (ret)
+		dev_err(cdns_ctrl->dev, "send address %llx failed\n", address);
+
+	return ret;
+}
+
+static int cadence_nand_cmd_erase(struct nand_chip *chip,
+				  const struct nand_subop *subop)
+{
+	unsigned int op_id;
+
+	if (subop->instrs[0].ctx.cmd.opcode == NAND_CMD_ERASE1) {
+		int i;
+		const struct nand_op_instr *instr = NULL;
+		unsigned int offset, naddrs;
+		const u8 *addrs;
+		u32 page = 0;
+
+		instr = &subop->instrs[1];
+		offset = nand_subop_get_addr_start_off(subop, 1);
+		naddrs = nand_subop_get_num_addr_cyc(subop, 1);
+		addrs = &instr->ctx.addr.addrs[offset];
+
+		for (i = 0; i < naddrs; i++)
+			page |= (u32)addrs[i] << (8 * i);
+
+		return cadence_nand_erase(chip, page);
+	}
+
+	/*
+	 * in case it is not an erase operation execute
+	 * operation one by one
+	 */
+	for (op_id = 0; op_id < subop->ninstrs; op_id++) {
+		int ret;
+		const struct nand_operation nand_op = {
+			.cs = chip->cur_cs,
+			.instrs =  &subop->instrs[op_id],
+			.ninstrs = 1};
+		ret = chip->controller->ops->exec_op(chip, &nand_op, false);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int cadence_nand_cmd_data(struct nand_chip *chip,
+				 const struct nand_subop *subop)
+{
+	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
+	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
+	const struct nand_op_instr *instr;
+	unsigned int offset, op_id = 0;
+	u64 mini_ctrl_cmd = 0;
+	int len = 0;
+	int ret;
+
+	instr = &subop->instrs[op_id];
+
+	if (instr->delay_ns > 0)
+		mini_ctrl_cmd |= GCMD_LAY_TWB;
+
+	mini_ctrl_cmd |= FIELD_PREP(GCMD_LAY_INSTR,
+				    GCMD_LAY_INSTR_DATA);
+
+	if (instr->type == NAND_OP_DATA_OUT_INSTR)
+		mini_ctrl_cmd |= FIELD_PREP(GCMD_DIR,
+					    GCMD_DIR_WRITE);
+
+	len = nand_subop_get_data_len(subop, op_id);
+	offset = nand_subop_get_data_start_off(subop, op_id);
+	mini_ctrl_cmd |= FIELD_PREP(GCMD_SECT_CNT, 1);
+	mini_ctrl_cmd |= FIELD_PREP(GCMD_LAST_SIZE, len);
+	if (instr->ctx.data.force_8bit) {
+		ret = cadence_nand_force_byte_access(chip, true);
+		if (ret) {
+			dev_err(cdns_ctrl->dev,
+				"cannot change byte access generic data cmd failed\n");
+			return ret;
+		}
+	}
+
+	ret = cadence_nand_generic_cmd_send(cdns_ctrl,
+					    cdns_chip->cs[chip->cur_cs],
+					    mini_ctrl_cmd);
+	if (ret) {
+		dev_err(cdns_ctrl->dev, "send generic data cmd failed\n");
+		return ret;
+	}
+
+	if (instr->type == NAND_OP_DATA_IN_INSTR) {
+		void *buf = instr->ctx.data.buf.in + offset;
+
+		ret = cadence_nand_read_buf(cdns_ctrl, buf, len);
+	} else {
+		const void *buf = instr->ctx.data.buf.out + offset;
+
+		ret = cadence_nand_write_buf(cdns_ctrl, buf, len);
+	}
+
+	if (ret) {
+		dev_err(cdns_ctrl->dev, "data transfer failed for generic command\n");
+		return ret;
+	}
+
+	if (instr->ctx.data.force_8bit) {
+		ret = cadence_nand_force_byte_access(chip, false);
+		if (ret) {
+			dev_err(cdns_ctrl->dev,
+				"cannot change byte access generic data cmd failed\n");
+		}
+	}
+
+	return ret;
+}
+
+static int cadence_nand_cmd_waitrdy(struct nand_chip *chip,
+				    const struct nand_subop *subop)
+{
+	int status;
+	unsigned int op_id = 0;
+	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
+	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
+	const struct nand_op_instr *instr = &subop->instrs[op_id];
+	u32 timeout_us = instr->ctx.waitrdy.timeout_ms * 1000;
+
+	status = cadence_nand_wait_for_value(cdns_ctrl, RBN_SETINGS,
+					     timeout_us,
+					     1U << cdns_chip->cs[chip->cur_cs],
+					     false);
+	return status;
+}
+
+static const struct nand_op_parser cadence_nand_op_parser = NAND_OP_PARSER(
+	NAND_OP_PARSER_PATTERN(
+		cadence_nand_cmd_erase,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ERASE_ADDRESS_CYC),
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
+	NAND_OP_PARSER_PATTERN(
+		cadence_nand_cmd_opcode,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false)),
+	NAND_OP_PARSER_PATTERN(
+		cadence_nand_cmd_address,
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYC)),
+	NAND_OP_PARSER_PATTERN(
+		cadence_nand_cmd_data,
+		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, MAX_DATA_SIZE)),
+	NAND_OP_PARSER_PATTERN(
+		cadence_nand_cmd_data,
+		NAND_OP_PARSER_PAT_DATA_OUT_ELEM(false, MAX_DATA_SIZE)),
+	NAND_OP_PARSER_PATTERN(
+		cadence_nand_cmd_waitrdy,
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false))
+	);
+
+static int cadence_nand_exec_op(struct nand_chip *chip,
+				const struct nand_operation *op,
+				bool check_only)
+{
+	int status = cadence_nand_select_target(chip);
+
+	if (status)
+		return status;
+
+	return nand_op_parser_exec_op(chip, &cadence_nand_op_parser, op,
+				      check_only);
+}
+
+static int cadence_nand_ooblayout_free(struct mtd_info *mtd, int section,
+				       struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = cdns_chip->bbm_len;
+	oobregion->length = cdns_chip->avail_oob_size
+		- cdns_chip->bbm_len;
+
+	return 0;
+}
+
+static int cadence_nand_ooblayout_ecc(struct mtd_info *mtd, int section,
+				      struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->offset = cdns_chip->avail_oob_size;
+	oobregion->length = chip->ecc.total;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops cadence_nand_ooblayout_ops = {
+	.free = cadence_nand_ooblayout_free,
+	.ecc = cadence_nand_ooblayout_ecc,
+};
+
+static int calc_cycl(u32 timing, u32 clock)
+{
+	if (timing == 0 || clock == 0)
+		return 0;
+
+	if ((timing % clock) > 0)
+		return timing / clock;
+	else
+		return timing / clock - 1;
+}
+
+static int
+cadence_nand_setup_data_interface(struct nand_chip *chip, int chipnr,
+				  const struct nand_data_interface *conf)
+{
+	const struct nand_sdr_timings *sdr;
+	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
+	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
+	struct cadence_nand_timings *t = &cdns_chip->timings;
+	u32 reg;
+	u32 board_delay = cdns_ctrl->board_delay;
+	u32 clk_period = DIV_ROUND_DOWN_ULL(1000000000000ULL,
+						cdns_ctrl->nf_clk_rate);
+	u32 nand2_delay = cdns_ctrl->caps1->nand2_delay;
+	u32 tceh_cnt, tcs_cnt, tadl_cnt, tccs_cnt, tcdqsh = 0;
+	u32 tcdqss = 0, tckwr = 0, tcr_cnt, tcr = 0, tcres = 0;
+	u32 tfeat_cnt, tpre = 0, trhz_cnt, trpst = 0, tvdly = 0;
+	u32 tpsth = 0, trhw_cnt, twb_cnt, twh_cnt = 0, twhr_cnt;
+	u32 twpst = 0, twrck = 0, tcals = 0, tcwaw = 0, twp_cnt = 0;
+	u32 if_skew = cdns_ctrl->caps1->if_skew;
+	u32 board_delay_with_skew_min = board_delay - if_skew;
+	u32 board_delay_with_skew_max = board_delay + if_skew;
+	u32 dqs_sampl_res;
+	u32 phony_dqs_mod;
+	u32 phony_dqs_comb_delay;
+	u32 trp_cnt = 0, trh_cnt = 0;
+	u32 tdvw, tdvw_min, tdvw_max;
+	u32 extended_read_mode;
+	u32 extended_wr_mode;
+	u32 dll_phy_dqs_timing = 0, phony_dqs_timing = 0, rd_del_sel = 0;
+	u32 tcwaw_cnt;
+	u32 tvdly_cnt;
+	u8 x;
+
+	sdr = nand_get_sdr_timings(conf);
+	if (IS_ERR(sdr))
+		return PTR_ERR(sdr);
+
+	memset(t, 0, sizeof(*t));
+	//------------------------------------------------------------------
+	// sampling point calculation
+	//------------------------------------------------------------------
+	if (cdns_ctrl->caps2.is_phy_type_dll) {
+		dqs_sampl_res = clk_period / 2;
+		phony_dqs_mod = 2;//for DLL phy
+
+		phony_dqs_comb_delay = 4 * nand2_delay;
+		if (cdns_ctrl->caps1->phy_dll_aging)
+			phony_dqs_comb_delay += nand2_delay;
+		if (cdns_ctrl->caps1->phy_per_bit_deskew)
+			phony_dqs_comb_delay += nand2_delay;
+
+	} else {
+		dqs_sampl_res = clk_period;//for async phy
+		phony_dqs_mod = 1;//for async phy
+		phony_dqs_comb_delay = 0;
+	}
+
+	tdvw_min = sdr->tREA_max + board_delay_with_skew_max
+		+ phony_dqs_comb_delay;
+	/*
+	 * the idea of those calculation is to get the optimum value
+	 * for tRP and tRH timings if it is NOT possible to sample data
+	 * with optimal tRP/tRH settings the parameters will be extended
+	 */
+	if (sdr->tRC_min <= clk_period &&
+	    sdr->tRP_min <= (clk_period / 2) &&
+	    sdr->tREH_min <= (clk_period / 2)) {
+		//performance mode
+		tdvw = sdr->tRHOH_min + clk_period / 2 - sdr->tREA_max;
+		tdvw_max = clk_period / 2 + sdr->tRHOH_min
+			+ board_delay_with_skew_min - phony_dqs_comb_delay;
+		/*
+		 * check if data valid window and sampling point can be found
+		 * and is not on the edge (ie. we have hold margin)
+		 * if not extend the tRP timings
+		 */
+		if (tdvw > 0) {
+			if (tdvw_max > tdvw_min &&
+			    (tdvw_max % dqs_sampl_res) > 0) {
+				/*
+				 * there is valid sampling point so
+				 * extended mode is allowed
+				 */
+				extended_read_mode = 0;
+			} else {
+				/*
+				 * no valid sampling point so the RE pulse
+				 * need to be widen widening by half clock
+				 * cycle should be sufficient
+				 * to find sampling point
+				 */
+				extended_read_mode = 1;
+				tdvw_max = clk_period + sdr->tRHOH_min
+					+ board_delay_with_skew_min
+					- phony_dqs_comb_delay;
+			}
+		} else {
+			/*
+			 * there is no valid window
+			 * to be able to sample data the tRP need to be widen
+			 * very safe calculations are performed here
+			 */
+			trp_cnt = (sdr->tREA_max + board_delay_with_skew_max
+				   + dqs_sampl_res) / clk_period;
+			extended_read_mode = 1;
+			tdvw_max = (trp_cnt + 1) * clk_period
+				+ sdr->tRHOH_min
+				+ board_delay_with_skew_min
+				- phony_dqs_comb_delay;
+		}
+
+	} else {
+		//extended read mode
+		extended_read_mode = 1;
+		trp_cnt = calc_cycl(sdr->tRP_min, clk_period);
+		if (sdr->tREH_min >= (sdr->tRC_min - ((trp_cnt + 1)
+						      * clk_period))) {
+			trh_cnt = calc_cycl(sdr->tREH_min, clk_period);
+		} else {
+			trh_cnt = calc_cycl(sdr->tRC_min
+					    - ((trp_cnt + 1)
+					       * clk_period),
+					    clk_period);
+		}
+
+		tdvw = sdr->tRHOH_min + ((trp_cnt + 1) * clk_period)
+			- sdr->tREA_max;
+		/*
+		 * check if data valid window and sampling point can be found
+		 * or if it is at the edge check if previous is valid
+		 * - if not extend the tRP timings
+		 */
+		if (tdvw > 0) {
+			tdvw_max = (trp_cnt + 1) * clk_period
+				+ sdr->tRHOH_min
+				+ board_delay_with_skew_min
+				- phony_dqs_comb_delay;
+
+			if ((((tdvw_max / dqs_sampl_res)
+			      * dqs_sampl_res) <= tdvw_min) ||
+			    (((tdvw_max % dqs_sampl_res) == 0) &&
+			     (((tdvw_max / dqs_sampl_res - 1)
+			       * dqs_sampl_res) <= tdvw_min))) {
+				/*
+				 * data valid window width is lower than
+				 * sampling resolution and do not hit any
+				 * sampling point to be sure the sampling point
+				 * will be found the RE low pulse width will be
+				 *  extended by one clock cycle
+				 */
+				trp_cnt = trp_cnt + 1;
+			}
+		} else {
+			/*
+			 * there is no valid window
+			 * to be able to sample data the tRP need to be widen
+			 * very safe calculations are performed here
+			 */
+			trp_cnt = (sdr->tREA_max + board_delay_with_skew_max
+				   + dqs_sampl_res) / clk_period;
+		}
+		tdvw_max = (trp_cnt + 1) * clk_period
+			+ sdr->tRHOH_min + board_delay_with_skew_min
+			- phony_dqs_comb_delay;
+	}
+
+	if (cdns_ctrl->caps2.is_phy_type_dll) {
+		u32 tpre_cnt = calc_cycl(tpre, clk_period);
+		u32 tcdqss_cnt = calc_cycl(tcdqss + if_skew, clk_period);
+		u32 tpsth_cnt = calc_cycl(tpsth + if_skew, clk_period);
+
+		u32 trpst_cnt = calc_cycl(trpst + if_skew, clk_period) + 1;
+		u32 twpst_cnt = calc_cycl(twpst + if_skew, clk_period) + 1;
+		u32 tcres_cnt = calc_cycl(tcres + if_skew, clk_period) + 1;
+		u32 tcdqsh_cnt = calc_cycl(tcdqsh + if_skew, clk_period) + 5;
+
+		tcr_cnt = calc_cycl(tcr + if_skew, clk_period);
+		/*
+		 * skew not included because this timing defines duration of
+		 * RE or DQS before data transfer
+		 */
+		tpsth_cnt = tpsth_cnt + 1;
+		reg = FIELD_PREP(TOGGLE_TIMINGS0_TPSTH, tpsth_cnt);
+		reg |= FIELD_PREP(TOGGLE_TIMINGS0_TCDQSS, tcdqss_cnt);
+		reg |= FIELD_PREP(TOGGLE_TIMINGS0_TPRE, tpre_cnt);
+		reg |= FIELD_PREP(TOGGLE_TIMINGS0_TCR, tcr_cnt);
+		t->toggle_timings_0 = reg;
+		dev_dbg(cdns_ctrl->dev, "TOGGLE_TIMINGS_0_SDR\t%x\n", reg);
+
+		//toggle_timings_1 - tRPST,tWPST
+		reg = FIELD_PREP(TOGGLE_TIMINGS1_TCDQSH, tcdqsh_cnt);
+		reg |= FIELD_PREP(TOGGLE_TIMINGS1_TCRES, tcres_cnt);
+		reg |= FIELD_PREP(TOGGLE_TIMINGS1_TRPST, trpst_cnt);
+		reg |= FIELD_PREP(TOGGLE_TIMINGS1_TWPST, twpst_cnt);
+		t->toggle_timings_1 = reg;
+		dev_dbg(cdns_ctrl->dev, "TOGGLE_TIMINGS_1_SDR\t%x\n", reg);
+	}
+
+	if (sdr->tWC_min <= clk_period &&
+	    (sdr->tWP_min + if_skew) <= (clk_period / 2) &&
+	    (sdr->tWH_min + if_skew) <= (clk_period / 2)) {
+		extended_wr_mode = 0;
+	} else {
+		extended_wr_mode = 1;
+		twp_cnt = calc_cycl(sdr->tWP_min + if_skew, clk_period);
+		if ((twp_cnt + 1) * clk_period < (tcals + if_skew))
+			twp_cnt = calc_cycl(tcals + if_skew, clk_period);
+
+		if (sdr->tWH_min >= (sdr->tWC_min - ((twp_cnt + 1)
+						     * clk_period))) {
+			twh_cnt = calc_cycl(sdr->tWH_min + if_skew,
+					    clk_period);
+		} else {
+			twh_cnt = calc_cycl((sdr->tWC_min
+					     - (twp_cnt + 1) * clk_period)
+					    + if_skew, clk_period);
+		}
+	}
+
+	reg = FIELD_PREP(ASYNC_TOGGLE_TIMINGS_TRH, trh_cnt);
+	reg |= FIELD_PREP(ASYNC_TOGGLE_TIMINGS_TRP, trp_cnt);
+	reg |= FIELD_PREP(ASYNC_TOGGLE_TIMINGS_TWH, twh_cnt);
+	reg |= FIELD_PREP(ASYNC_TOGGLE_TIMINGS_TWP, twp_cnt);
+	t->async_toggle_timings = reg;
+	dev_dbg(cdns_ctrl->dev, "ASYNC_TOGGLE_TIMINGS_SDR\t%x\n", reg);
+
+	if (cdns_ctrl->caps2.is_phy_type_dll) {
+		/*
+		 * sync_timings - tCKWR,tWRCK,tCAD
+		 * sync timing are related to the clock so the skew
+		 * is minor and do not need to be included into calculations
+		 */
+		u32 tckwr_cnt = calc_cycl(tckwr, clk_period);
+		u32 twrck_cnt = calc_cycl(twrck, clk_period);
+		u32 tcad_cnt = 0;
+
+		reg = FIELD_PREP(SYNC_TIMINGS_TCKWR, tckwr_cnt);
+		reg |= FIELD_PREP(SYNC_TIMINGS_TWRCK, twrck_cnt);
+		reg |= FIELD_PREP(SYNC_TIMINGS_TCAD, tcad_cnt);
+		t->sync_timings = reg;
+		dev_dbg(cdns_ctrl->dev, "SYNC_TIMINGS_SDR\t%x\n", reg);
+	}
+
+	tadl_cnt = calc_cycl((sdr->tADL_min + if_skew), clk_period);
+	tccs_cnt = calc_cycl((sdr->tCCS_min + if_skew), clk_period);
+	twhr_cnt = calc_cycl((sdr->tWHR_min + if_skew), clk_period);
+	trhw_cnt = calc_cycl((sdr->tRHW_min + if_skew), clk_period);
+	reg = FIELD_PREP(TIMINGS0_TADL, tadl_cnt);
+
+	/*
+	 * if timing exceeds delay field in timing register
+	 * then use maximum value
+	 */
+	if (FIELD_FIT(TIMINGS0_TCCS, tccs_cnt))
+		reg |= FIELD_PREP(TIMINGS0_TCCS, tccs_cnt);
+	else
+		reg |= TIMINGS0_TCCS;
+
+	reg |= FIELD_PREP(TIMINGS0_TWHR, twhr_cnt);
+	reg |= FIELD_PREP(TIMINGS0_TRHW, trhw_cnt);
+	t->timings0 = reg;
+	dev_dbg(cdns_ctrl->dev, "TIMINGS0_SDR\t%x\n", reg);
+
+	//the following is related to single signal so skew is not needed
+	trhz_cnt = calc_cycl(sdr->tRHZ_max, clk_period);
+	trhz_cnt = trhz_cnt + 1;
+	twb_cnt = calc_cycl((sdr->tWB_max + board_delay), clk_period);
+	/*
+	 * because of the two stage syncflop the value must be increased by 3
+	 * first value is related with sync, second value is related
+	 * with output if delay
+	 */
+	twb_cnt = twb_cnt + 3 + 5;
+	/*
+	 * the following is related to the we edge of the random data input
+	 * sequence so skew is not needed
+	 */
+	tcwaw_cnt = calc_cycl(tcwaw, clk_period);
+	tvdly_cnt = calc_cycl((tvdly + if_skew), clk_period);
+	reg = FIELD_PREP(TIMINGS1_TRHZ, trhz_cnt);
+	reg |= FIELD_PREP(TIMINGS1_TWB, twb_cnt);
+	reg |= FIELD_PREP(TIMINGS1_TCWAW, tcwaw_cnt);
+	reg |= FIELD_PREP(TIMINGS1_TVDLY, tvdly_cnt);
+	t->timings1 = reg;
+	dev_dbg(cdns_ctrl->dev, "TIMINGS1_SDR\t%x\n", reg);
+
+	tfeat_cnt = calc_cycl(sdr->tFEAT_max, clk_period);
+	if (tfeat_cnt < twb_cnt)
+		tfeat_cnt = twb_cnt;
+
+	tceh_cnt = calc_cycl(sdr->tCEH_min, clk_period);
+	tcs_cnt = calc_cycl((sdr->tCS_min + if_skew), clk_period);
+
+	reg = FIELD_PREP(TIMINGS2_TFEAT, tfeat_cnt);
+	reg |= FIELD_PREP(TIMINGS2_CS_HOLD_TIME, tceh_cnt);
+	reg |= FIELD_PREP(TIMINGS2_CS_SETUP_TIME, tcs_cnt);
+	t->timings2 = reg;
+	dev_dbg(cdns_ctrl->dev, "TIMINGS2_SDR\t%x\n", reg);
+
+	if (cdns_ctrl->caps2.is_phy_type_dll) {
+		reg = DLL_PHY_CTRL_DLL_RST_N;
+		if (extended_wr_mode)
+			reg |= DLL_PHY_CTRL_EXTENDED_WR_MODE;
+		if (extended_read_mode)
+			reg |= DLL_PHY_CTRL_EXTENDED_RD_MODE;
+
+		reg |= FIELD_PREP(DLL_PHY_CTRL_RS_HIGH_WAIT_CNT, 7);
+		reg |= FIELD_PREP(DLL_PHY_CTRL_RS_IDLE_CNT, 7);
+		t->dll_phy_ctrl = reg;
+		dev_dbg(cdns_ctrl->dev, "DLL_PHY_CTRL_SDR\t%x\n", reg);
+	}
+
+	/*
+	 * sampling point calculation
+	 */
+
+	if ((tdvw_max % dqs_sampl_res) > 0)
+		x = 0;
+	else
+		x = 1;
+
+	if ((tdvw_max / dqs_sampl_res - x) * dqs_sampl_res > tdvw_min) {
+		/*
+		 * if "number" of sampling point is:
+		 * - even then phony_dqs_sel 0
+		 * - odd then phony_dqs_sel 1
+		 */
+		if (((tdvw_max / dqs_sampl_res - x) % 2) > 0) {
+			//odd
+			dll_phy_dqs_timing = 0x00110004;
+			phony_dqs_timing = tdvw_max
+				/ (dqs_sampl_res * phony_dqs_mod) - x;
+			if (!cdns_ctrl->caps2.is_phy_type_dll)
+				phony_dqs_timing--;
+
+		} else {
+			//even
+			dll_phy_dqs_timing = 0x00100004;
+			phony_dqs_timing = (tdvw_max
+					    / dqs_sampl_res - x)
+				/ phony_dqs_mod;
+			phony_dqs_timing--;
+		}
+		rd_del_sel = phony_dqs_timing + 3;
+	} else {
+		dev_warn(cdns_ctrl->dev,
+			 "ERROR %d : cannot find valid sampling point\n", x);
+	}
+
+	reg = FIELD_PREP(PHY_CTRL_PHONY_DQS, phony_dqs_timing);
+	if (cdns_ctrl->caps2.is_phy_type_dll)
+		reg  |= PHY_CTRL_SDR_DQS;
+	t->phy_ctrl = reg;
+	dev_dbg(cdns_ctrl->dev, "PHY_CTRL_REG_SDR\t%x\n", reg);
+
+	if (cdns_ctrl->caps2.is_phy_type_dll) {
+		dev_dbg(cdns_ctrl->dev, "PHY_TSEL_REG_SDR\t%x\n", 0);
+		dev_dbg(cdns_ctrl->dev, "PHY_DQ_TIMING_REG_SDR\t%x\n", 2);
+		dev_dbg(cdns_ctrl->dev, "PHY_DQS_TIMING_REG_SDR\t%x\n",
+			dll_phy_dqs_timing);
+		t->phy_dqs_timing = dll_phy_dqs_timing;
+
+		reg = FIELD_PREP(PHY_GATE_LPBK_CTRL_RDS, rd_del_sel);
+		dev_dbg(cdns_ctrl->dev, "PHY_GATE_LPBK_CTRL_REG_SDR\t%x\n",
+			reg);
+		t->phy_gate_lpbk_ctrl = reg;
+
+		dev_dbg(cdns_ctrl->dev, "PHY_DLL_MASTER_CTRL_REG_SDR\t%lx\n",
+			PHY_DLL_MASTER_CTRL_BYPASS_MODE);
+		dev_dbg(cdns_ctrl->dev, "PHY_DLL_SLAVE_CTRL_REG_SDR\t%x\n", 0);
+	}
+
+	return 0;
+}
+
+int cadence_nand_attach_chip(struct nand_chip *chip)
+{
+	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
+	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	u32 max_oob_data_size;
+	int ret = 0;
+
+	if (chip->options & NAND_BUSWIDTH_16) {
+		ret = cadence_nand_set_access_width16(cdns_ctrl, true);
+		if (ret)
+			goto free_buf;
+	}
+
+	chip->bbt_options |= NAND_BBT_USE_FLASH;
+	chip->bbt_options |= NAND_BBT_NO_OOB;
+	chip->ecc.mode = NAND_ECC_HW;
+
+	chip->options |= NAND_NO_SUBPAGE_WRITE;
+
+	cdns_chip->bbm_offs = chip->badblockpos;
+	if (chip->options & NAND_BUSWIDTH_16) {
+		cdns_chip->bbm_offs &= ~0x01;
+		cdns_chip->bbm_len = 2;
+	} else {
+		cdns_chip->bbm_len = 1;
+	}
+
+	ret = nand_ecc_choose_conf(chip,
+				   &cdns_ctrl->ecc_caps,
+				   mtd->oobsize - cdns_chip->bbm_len);
+	if (ret) {
+		dev_err(cdns_ctrl->dev, "ECC configuration failed\n");
+		goto free_buf;
+	}
+
+	dev_dbg(cdns_ctrl->dev,
+		"chosen ECC settings: step=%d, strength=%d, bytes=%d\n",
+		chip->ecc.size, chip->ecc.strength, chip->ecc.bytes);
+
+	/* Error correction */
+	cdns_chip->main_size = mtd->writesize;
+	cdns_chip->sector_size = chip->ecc.size;
+	cdns_chip->sector_count = cdns_chip->main_size / cdns_chip->sector_size;
+	cdns_chip->oob_size = mtd->oobsize;
+	cdns_chip->avail_oob_size = cdns_chip->oob_size
+		- cdns_chip->sector_count * chip->ecc.bytes;
+
+	max_oob_data_size = MAX_OOB_SIZE_PER_SECTOR;
+
+	if (cdns_chip->avail_oob_size > max_oob_data_size)
+		cdns_chip->avail_oob_size = max_oob_data_size;
+
+	if ((cdns_chip->avail_oob_size + cdns_chip->bbm_len
+	     + cdns_chip->sector_count
+	     * chip->ecc.bytes) > mtd->oobsize)
+		cdns_chip->avail_oob_size -= 4;
+
+	cdns_chip->corr_str_idx =
+		cadence_nand_get_ecc_strength_idx(cdns_ctrl,
+						  chip->ecc.strength);
+
+	ret = cadence_nand_set_ecc_strength(cdns_ctrl,
+					    cdns_chip->corr_str_idx);
+	if (ret)
+		return ret;
+
+	ret = cadence_nand_set_erase_detection(cdns_ctrl, true,
+					       chip->ecc.strength);
+	if (ret)
+		return ret;
+
+	/* override the default read operations */
+	chip->ecc.read_page = cadence_nand_read_page;
+	chip->ecc.read_page_raw = cadence_nand_read_page_raw;
+	chip->ecc.write_page = cadence_nand_write_page;
+	chip->ecc.write_page_raw = cadence_nand_write_page_raw;
+	chip->ecc.read_oob = cadence_nand_read_oob;
+	chip->ecc.write_oob = cadence_nand_write_oob;
+	chip->ecc.read_oob_raw = cadence_nand_read_oob_raw;
+	chip->ecc.write_oob_raw = cadence_nand_write_oob_raw;
+
+	if ((mtd->writesize + mtd->oobsize) > cdns_ctrl->buf_size) {
+		cdns_ctrl->buf_size = mtd->writesize + mtd->oobsize;
+		kfree(cdns_ctrl->buf);
+		cdns_ctrl->buf = kzalloc(cdns_ctrl->buf_size, GFP_KERNEL);
+		if (!cdns_ctrl->buf) {
+			ret = -ENOMEM;
+			goto free_buf;
+		}
+	}
+
+	/* Is 32-bit DMA supported? */
+	ret = dma_set_mask(cdns_ctrl->dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(cdns_ctrl->dev, "no usable DMA configuration\n");
+		goto free_buf;
+	}
+
+	mtd_set_ooblayout(mtd, &cadence_nand_ooblayout_ops);
+
+	return 0;
+
+free_buf:
+	kfree(cdns_ctrl->buf);
+
+	return ret;
+}
+
+static const struct nand_controller_ops cadence_nand_controller_ops = {
+	.attach_chip = cadence_nand_attach_chip,
+	.exec_op = cadence_nand_exec_op,
+	.setup_data_interface = cadence_nand_setup_data_interface,
+};
+
+static int cadence_nand_chip_init(struct cdns_nand_ctrl *cdns_ctrl,
+				  struct device_node *np)
+{
+	struct cdns_nand_chip *cdns_chip;
+	struct mtd_info *mtd;
+	struct nand_chip *chip;
+	int nsels, ret, i;
+	u32 cs;
+
+	nsels = of_property_count_elems_of_size(np, "reg", sizeof(u32));
+	if (nsels <= 0) {
+		dev_err(cdns_ctrl->dev, "missing/invalid reg property\n");
+		return -EINVAL;
+	}
+
+	/* Alloc the nand chip structure */
+	cdns_chip = devm_kzalloc(cdns_ctrl->dev, sizeof(*cdns_chip) +
+				 (nsels * sizeof(u8)),
+				 GFP_KERNEL);
+	if (!cdns_chip) {
+		dev_err(cdns_ctrl->dev, "could not allocate chip structure\n");
+		return -ENOMEM;
+	}
+
+	cdns_chip->nsels = nsels;
+
+	for (i = 0; i < nsels; i++) {
+		/* Retrieve CS id */
+		ret = of_property_read_u32_index(np, "reg", i, &cs);
+		if (ret) {
+			dev_err(cdns_ctrl->dev,
+				"could not retrieve reg property: %d\n",
+				ret);
+			return ret;
+		}
+
+		if (cs >= cdns_ctrl->caps2.max_banks) {
+			dev_err(cdns_ctrl->dev,
+				"invalid reg value: %u (max CS = %d)\n",
+				cs, cdns_ctrl->caps2.max_banks);
+			return -EINVAL;
+		}
+
+		if (test_and_set_bit(cs, &cdns_ctrl->assigned_cs)) {
+			dev_err(cdns_ctrl->dev,
+				"CS %d already assigned\n", cs);
+			return -EINVAL;
+		}
+
+		cdns_chip->cs[i] = cs;
+	}
+
+	chip = &cdns_chip->chip;
+	chip->controller = &cdns_ctrl->controller;
+	nand_set_flash_node(chip, np);
+
+	mtd = nand_to_mtd(chip);
+	mtd->dev.parent = cdns_ctrl->dev;
+
+	/*
+	 * Default to HW ECC engine mode. If the nand-ecc-mode property is given
+	 * in the DT node, this entry will be overwritten in nand_scan_ident().
+	 */
+	chip->ecc.mode = NAND_ECC_HW;
+
+	/*
+	 * Save a reference value for timing registers before
+	 * ->setup_data_interface() is called.
+	 */
+	cadence_nand_get_timings(cdns_ctrl, &cdns_chip->timings);
+
+	ret = nand_scan(chip, cdns_chip->nsels);
+	if (ret) {
+		dev_err(cdns_ctrl->dev, "could not scan the nand chip\n");
+		return ret;
+	}
+
+	ret = mtd_device_register(mtd, NULL, 0);
+	if (ret) {
+		dev_err(cdns_ctrl->dev,
+			"failed to register mtd device: %d\n", ret);
+		nand_release(chip);
+		return ret;
+	}
+
+	list_add_tail(&cdns_chip->node, &cdns_ctrl->chips);
+
+	return 0;
+}
+
+static int cadence_nand_chips_init(struct cdns_nand_ctrl *cdns_ctrl)
+{
+	struct device_node *np = cdns_ctrl->dev->of_node;
+	struct device_node *nand_np;
+	int max_cs = cdns_ctrl->caps2.max_banks;
+	int nchips;
+	int ret;
+
+	nchips = of_get_child_count(np);
+
+	if (nchips > max_cs) {
+		dev_err(cdns_ctrl->dev,
+			"too many NAND chips: %d (max = %d CS)\n",
+			nchips, max_cs);
+		return -EINVAL;
+	}
+
+	for_each_child_of_node(np, nand_np) {
+		ret = cadence_nand_chip_init(cdns_ctrl, nand_np);
+		if (ret) {
+			of_node_put(nand_np);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
+{
+	dma_cap_mask_t mask;
+	int ret = 0;
+
+	cdns_ctrl->cdma_desc = dma_alloc_coherent(cdns_ctrl->dev,
+						  sizeof(*cdns_ctrl->cdma_desc),
+						  &cdns_ctrl->dma_cdma_desc,
+						  GFP_KERNEL);
+	if (!cdns_ctrl->dma_cdma_desc)
+		return -ENOMEM;
+
+	cdns_ctrl->buf_size = 16 * 1024;
+	cdns_ctrl->buf = kmalloc(cdns_ctrl->buf_size, GFP_KERNEL);
+	if (!cdns_ctrl->buf) {
+		goto free_buf_desc;
+		ret = -ENOMEM;
+	}
+
+	if (devm_request_irq(cdns_ctrl->dev, cdns_ctrl->irq, cadence_nand_isr,
+			     IRQF_SHARED, "cadence-nand-controller",
+			     cdns_ctrl)) {
+		dev_err(cdns_ctrl->dev, "Unable to allocate IRQ\n");
+		ret = -ENODEV;
+		goto free_buf;
+	}
+
+	spin_lock_init(&cdns_ctrl->irq_lock);
+	init_completion(&cdns_ctrl->complete);
+
+	ret = cadence_nand_hw_init(cdns_ctrl);
+	if (ret)
+		goto disable_irq;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_MEMCPY, mask);
+
+	if (cdns_ctrl->caps1->has_dma) {
+		cdns_ctrl->dmac = dma_request_channel(mask, NULL, NULL);
+		if (!cdns_ctrl->dmac) {
+			dev_err(cdns_ctrl->dev,
+				"Unable to get a dma channel\n");
+			ret = -EBUSY;
+			goto disable_irq;
+		}
+	}
+
+	nand_controller_init(&cdns_ctrl->controller);
+	INIT_LIST_HEAD(&cdns_ctrl->chips);
+
+	cdns_ctrl->controller.ops = &cadence_nand_controller_ops;
+	cdns_ctrl->curr_corr_str_idx = 0xFF;
+
+	ret = cadence_nand_chips_init(cdns_ctrl);
+	if (ret) {
+		dev_err(cdns_ctrl->dev, "Failed to register MTD: %d\n",
+			ret);
+		goto dma_release_chnl;
+	}
+
+	return 0;
+
+dma_release_chnl:
+	if (cdns_ctrl->dmac)
+		dma_release_channel(cdns_ctrl->dmac);
+
+disable_irq:
+	cadence_nand_irq_cleanup(cdns_ctrl->irq, cdns_ctrl);
+
+free_buf:
+	kfree(cdns_ctrl->buf);
+
+free_buf_desc:
+	dma_free_coherent(cdns_ctrl->dev, sizeof(struct cadence_nand_cdma_desc),
+			  cdns_ctrl->cdma_desc, cdns_ctrl->dma_cdma_desc);
+
+	return ret;
+}
+
+static void cadence_nand_chips_cleanup(struct cdns_nand_ctrl *cdns_ctrl)
+{
+	struct cdns_nand_chip *entry, *temp;
+
+	list_for_each_entry_safe(entry, temp, &cdns_ctrl->chips, node) {
+		nand_release(&entry->chip);
+		list_del(&entry->node);
+	}
+}
+
+/* driver exit point */
+static void cadence_nand_remove(struct cdns_nand_ctrl *cdns_ctrl)
+{
+	cadence_nand_chips_cleanup(cdns_ctrl);
+	cadence_nand_irq_cleanup(cdns_ctrl->irq, cdns_ctrl);
+	kfree(cdns_ctrl->buf);
+	dma_free_coherent(cdns_ctrl->dev, sizeof(struct cadence_nand_cdma_desc),
+			  cdns_ctrl->cdma_desc, cdns_ctrl->dma_cdma_desc);
+
+	if (cdns_ctrl->dmac)
+		dma_release_channel(cdns_ctrl->dmac);
+}
+
+struct cadence_nand_dt {
+	struct cdns_nand_ctrl cdns_ctrl;
+	struct clk *clk;
+};
+
+static const struct cadence_nand_dt_devdata cadnence_nand_default = {
+	.if_skew = 0,
+	.nand2_delay = 37,
+	.phy_dll_aging = 1,
+	.phy_per_bit_deskew = 1,
+	.has_dma = 1,
+};
+
+static const struct of_device_id cadence_nand_dt_ids[] = {
+	{
+		.compatible = "cdns,hpnfc",
+		.data = &cadnence_nand_default
+	}, {/* cadence */}
+};
+
+MODULE_DEVICE_TABLE(of, cadence_nand_dt_ids);
+
+static int cadence_nand_dt_probe(struct platform_device *ofdev)
+{
+	struct resource *res;
+	struct cadence_nand_dt *dt;
+	struct cdns_nand_ctrl *cdns_ctrl;
+	int ret;
+	const struct of_device_id *of_id;
+	const struct cadence_nand_dt_devdata *devdata;
+	u32 val;
+
+	of_id = of_match_device(cadence_nand_dt_ids, &ofdev->dev);
+	if (of_id) {
+		ofdev->id_entry = of_id->data;
+		devdata = of_id->data;
+	} else {
+		pr_err("Failed to find the right device id.\n");
+		return -ENOMEM;
+	}
+
+	dt = devm_kzalloc(&ofdev->dev, sizeof(*dt), GFP_KERNEL);
+	if (!dt)
+		return -ENOMEM;
+
+	cdns_ctrl = &dt->cdns_ctrl;
+	cdns_ctrl->caps1 = devdata;
+
+	cdns_ctrl->dev = &ofdev->dev;
+	cdns_ctrl->irq = platform_get_irq(ofdev, 0);
+	if (cdns_ctrl->irq < 0) {
+		dev_err(&ofdev->dev, "no irq defined\n");
+		return cdns_ctrl->irq;
+	}
+	dev_info(cdns_ctrl->dev, "IRQ: nr %d\n", cdns_ctrl->irq);
+
+	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
+	cdns_ctrl->reg = devm_ioremap_resource(cdns_ctrl->dev, res);
+	if (IS_ERR(cdns_ctrl->reg)) {
+		dev_err(&ofdev->dev, "devm_ioremap_resource res 0 failed\n");
+		return PTR_ERR(cdns_ctrl->reg);
+	}
+
+	res = platform_get_resource(ofdev, IORESOURCE_MEM, 1);
+	cdns_ctrl->io.dma = res->start;
+	cdns_ctrl->io.virt = devm_ioremap_resource(&ofdev->dev, res);
+	if (IS_ERR(cdns_ctrl->io.virt)) {
+		dev_err(cdns_ctrl->dev, "devm_ioremap_resource res 1 failed\n");
+		return PTR_ERR(cdns_ctrl->io.virt);
+	}
+
+	dt->clk = devm_clk_get(cdns_ctrl->dev, "nf_clk");
+	if (IS_ERR(dt->clk))
+		return PTR_ERR(dt->clk);
+
+	cdns_ctrl->nf_clk_rate = clk_get_rate(dt->clk);
+
+	ret = of_property_read_u32(ofdev->dev.of_node,
+				   "cdns,board-delay", &val);
+	if (ret) {
+		dev_warn(cdns_ctrl->dev, "missing cdns,board-delay property\n");
+		val = 0;
+	}
+	cdns_ctrl->board_delay = val;
+
+	ret = cadence_nand_init(cdns_ctrl);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(ofdev, dt);
+	return 0;
+}
+
+static int cadence_nand_dt_remove(struct platform_device *ofdev)
+{
+	struct cadence_nand_dt *dt = platform_get_drvdata(ofdev);
+
+	cadence_nand_remove(&dt->cdns_ctrl);
+
+	return 0;
+}
+
+static struct platform_driver cadence_nand_dt_driver = {
+	.probe		= cadence_nand_dt_probe,
+	.remove		= cadence_nand_dt_remove,
+	.driver		= {
+		.name	= "cadence-nand-controller",
+		.of_match_table = cadence_nand_dt_ids,
+	},
+};
+
+module_platform_driver(cadence_nand_dt_driver);
+
+MODULE_AUTHOR("Piotr Sroka <piotrs@cadence.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Driver for Cadence NAND flash controller");
+
-- 
2.15.0

