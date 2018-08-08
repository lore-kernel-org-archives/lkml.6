Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B18FC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70D821AA8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=janustech.onmicrosoft.com header.i=@janustech.onmicrosoft.com header.b="UOf/CnNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70D821AA8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=janustech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731554AbeHIAsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 20:48:53 -0400
Received: from mail-by2nam01on0105.outbound.protection.outlook.com ([104.47.34.105]:43115
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729221AbeHIAsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 20:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=janustech.onmicrosoft.com; s=selector1-janustech-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnvuHec8WH22c1Ru7c1S0VqTFGxQrfsgTD+XnwUdD2U=;
 b=UOf/CnNHKlX6o5cWx4tXsj7+NFzDTaz+xbE0Y3hcB+6znNY6E0PI6scMCNd434B+ulOL6lvl7+1JhvlHcUCOV7IKpJoGfbGHaB/FCBTmz5FnsANjBUBIyuQsCYtDCU6KPDo5nga0of6AlYsMOBzF5PI70SwfPFRE4Z29ch/lCDw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lbloch@janustech.com; 
Received: from Jupiter.local (141.226.29.227) by
 SN2PR07MB2623.namprd07.prod.outlook.com (2603:10b6:804:8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.21; Wed, 8 Aug 2018 22:27:06 +0000
From:   Leonid Bloch <lbloch@janustech.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Leonid Bloch <lbloch@janustech.com>
Subject: [PATCH] gpio: it87: Add support for IT8613
Date:   Thu,  9 Aug 2018 01:26:36 +0300
Message-Id: <20180808222636.6381-1-lbloch@janustech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [141.226.29.227]
X-ClientProxiedBy: VI1PR04CA0099.eurprd04.prod.outlook.com
 (2603:10a6:803:64::34) To SN2PR07MB2623.namprd07.prod.outlook.com
 (2603:10b6:804:8::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e54d2a8-8bbe-473a-3df5-08d5fd7e1352
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN2PR07MB2623;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR07MB2623;3:98fJYyRLdy63tSYxK0daNYByMhmDyCeDpA+waZUA6i/gSkC9BIFTZpPHoBX4r8HSx1fIklnKW71e9EQvvprVy/2cQpxSP80mxDMv/9ydf64WHKoqlYpFHXkvELetF1lRNzQl7Nb/hndcUObINfTtGdtC+QE8uw+OrQsdCPb67INfqKC4hyLd/WvQVbMXWqN+xvWMgfIwD8sebsiI3GNIqxIcZnRTi/ny46xdh5TR37dLC5TpL4ncOTJyR+TrQOwI;25:AD41e8Rop8R/OSFDKBQFXVSjLvvFOibFK2lQKbfssfNosXoYqmGsZtRYQbn/WSmpep65J1NZ8Fxg8569g+cPL50ajPIBROJbiW/hxz1Xc7OcSn1xgFKXqTxW5pjaeSPsn24iVNzpcp5EWSAkWL7Wa2i20tkGUoMONyzeAJJioUkayJDvyD9bD8kyX4LbCVFm0JxyJekFMGuWG95TwcOEZkM1hUpIDK4LWz628s9eGi4OqWtO+fusujgF8zVSFu1/7q3P3rmpjQXS2I13oIbByjUjVl96lVeP1lo7ZF8uJROCsvCPWT/NdnEXxwvegbZsTfQQyCSJ4xtWLYdZyCvo/g==;31:qFsV932J8TALP6kr9HhV89UyvFd5IQbA+lqwcO335qPx2jb7mcGX79Ok6eKA5U9RzMDVuauET2URXSAUfk4JwGZU9ATh3J3fSNigWEGl3MiPoprokvklTTnDOP4XZugHZs9TZl2F0BkCM0Df0uO3k7FzVcwBto2WocrrjP3fPHIY1ATjfS9PyQSuvNWaLtdVwGjLgWfQ87yJcGZqXkT2HlTQBYvUCxrh6MBE16XwHcQ=
X-MS-TrafficTypeDiagnostic: SN2PR07MB2623:
X-Microsoft-Antispam-PRVS: <SN2PR07MB2623F34C1545681C3BAC3A69CA260@SN2PR07MB2623.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123560045)(2016111802025)(20161123562045)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:SN2PR07MB2623;BCL:0;PCL:0;RULEID:;SRVR:SN2PR07MB2623;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR07MB2623;4:x844x39wb5cLGvETXmDu41L+lHYbxq0wVhxuVUIg2+TBdYeko98pwIdew/7kbxOrvHRyUplf/TMk79l9yhYV+ibdmcN8qT0M4ld4I1KHJPDN/wDjekTczDqCnQNAwfuTnaLnx0dyUzvUtbCkM9TdC1AXOAFuzF2DziB3PkkyxfpwqRk/Iyk7A5DPwnxhFi/WrZQIXy4Fs83kMlN+/94kt6DghHzWvNCkQGM9N0JDeOmQDOBGRJv+5lYOK32EaszwgnpUsJH6x1aibJpu7i2ICA==
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(39830400003)(346002)(396003)(189003)(199004)(186003)(14444005)(48376002)(1857600001)(97736004)(2351001)(50466002)(2906002)(105586002)(3846002)(1076002)(106356001)(52116002)(6116002)(8936002)(476003)(54906003)(51416003)(956004)(16526019)(16586007)(107886003)(50226002)(316002)(486006)(6506007)(36756003)(386003)(2616005)(5660300001)(81156014)(25786009)(86362001)(6666003)(575784001)(6916009)(53936002)(4326008)(81166006)(6486002)(305945005)(68736007)(478600001)(26005)(47776003)(6512007)(66066001)(8676002)(7736002)(2361001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR07MB2623;H:Jupiter.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: janustech.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR07MB2623;23:wdcz1Oc+5vEmTdY+s1xC4c9c3N2ZlITm957OST5jA?=
 =?us-ascii?Q?aBtvzIBW6wuH0RoE5qurz710TJMQhoChu8Y5oCB0uTZ3HNrEgaeYZJphK9U+?=
 =?us-ascii?Q?oHmnX6f0I0RmGcMJf1JwY3HWk742aVAr3o4Tk/1sAqeR+U+IgMHLyCpElO8N?=
 =?us-ascii?Q?XJP/3/wMfr+QG7L+5BuQ89HTNioF9DMM8oCN1Rz2OkFExIpq/WYWQDI6iWYt?=
 =?us-ascii?Q?kFwXfyC0nYLo9lfeGy8DwFhkcQhdaJ6YcmdwTmSWFoJBYG9kDrIKFi6cg3gb?=
 =?us-ascii?Q?tvRnci7N3WC9HBeAdmxhWRz6iw9W3ZV4HiFKbnqB2xwRRegDrBopaTJnP6mO?=
 =?us-ascii?Q?7wusrGxSAhiwThe6AGWtPORXVYa2XZsoa7z5j0btEGJ+kbP0LXOzaVKaZFi4?=
 =?us-ascii?Q?PwPdfC8TuuYpehWiVYwEEE8cfSbPo8rNA5zCK9/EjB7ARdSiNeuy6xCfkerO?=
 =?us-ascii?Q?9VmMM5mX8zQ1Sbx3C5LWitgqiJzRBOQN5+y8H8T4NpYFEOOs2rmgwOpk2EOa?=
 =?us-ascii?Q?o0P9n92tdvE9DwGVv5MBVzQPuvVGYzDATYNdut7wK6HrRfgngX7IxM5+1D/S?=
 =?us-ascii?Q?YzMQe5WuktDVLB/hjwqGUP8Sevd6/5ahHjBwlmM2AoR9iPitD5LBI0f7TBRw?=
 =?us-ascii?Q?/MBYNiK5CwP2ZkL0JHvyqst7UAXUXBFBhCBOU/PTLs03RS7w6LJ/HlWWBPdt?=
 =?us-ascii?Q?57Fm6WJYpJ5Tf1kNC1n3OB45Rap4MUxeksjr4NN0jEgOMCd9hLyY9xM5NUzB?=
 =?us-ascii?Q?s/qq+JAfUOOukcKnA0IGnEbN+oPEpft88EiKd5uyIabiYz97FQZRJlaYv+ZH?=
 =?us-ascii?Q?ssB5U1tQMvbH4JNSrKhbnLslp5nDVYIdDoGi05womquBCevPaQTpkTKY6h4T?=
 =?us-ascii?Q?OSQoHtyHJ+HsK5JXXp8wAbq79FrAMPeEkFQdM+5ilk0+nr16vSm9+S+b4f35?=
 =?us-ascii?Q?dgD3kpORG/Y3DSHpj8uuZLTNHqARAYXhPj/eyqBq0oyqAXASvfqQZwgBNH9z?=
 =?us-ascii?Q?BrMlT5r66OJlEWYjSZg0EcH3buGt6Qy5VI7RSj8N7NV2OgULSS44SruYLfoy?=
 =?us-ascii?Q?yEX5UVNEFxxpSQaKUG6CjLe4or6gWTXvlKvoBy0Mit4/WuwEuM5WZuPsXEpp?=
 =?us-ascii?Q?wgv/cg3rNfgk0zXBAkf9EUmj7LjF6DkU7wrc+BemBDPG/yoQE+w00mi/1cSJ?=
 =?us-ascii?Q?M5DrlyIpng4pUcmmvJNB6CPALEDKQYFHB2s/GQ/8EXKMgmu4Eozarz2vz8tk?=
 =?us-ascii?Q?wb/Q6z3RmCZ0j7F9dM0VtQwi6aQPtFlwodBLK47?=
X-Microsoft-Antispam-Message-Info: xwVTOD+VUFmU2OW2gwddVdA00SCXgb6+NNpC2dqaa8j5Kot70V5k1vzXf8vzN1PsyKhAZS+LVdVLlC1ceuan88qBtyVWocrU4ezEfUi7lVOB9MAJiZ4vT4AXsxV+cda9OwA43+XeTO9R8BfGUqe93g8NDQx99bcwSv+DWKM/aht0qmrpX1uZ9Qax44ewIQEAoaQP/CVE+FUVbWkZJjinjb6Hs0gn0noZmj4/U7uqwyr6v613w+70Itq82G4c0+lvEVepPDoH0rZNC3qcU7qcKbdAL2gzOEod0u/RumBPc4QlXLp7H9sEXTdSG6MNJxeKNv1tTXde48brDwGKAd+fz6JhUDGDSX0u4VSwo5s3x9Y=
X-Microsoft-Exchange-Diagnostics: 1;SN2PR07MB2623;6:S87SfFTz9QbnuxtniiXGKLlmLWgNeGPP2vHpFIjvOaloj6Z+EhJQrGXHq9x9fIaeJ03z8/uGcoN/O1ZPEy2Er80ej0MnqmMplEzyGqeaqh+NmbeSSk6KIYl+GFN47V0VVcdBUvzELAHX+LbmkgRBRGyXwi9acaMfUVhsQeh3CZgz3Hj8CUljgwtpK0rS+wViq/7OwbpaxotBdBfzOqeQ/KP4wdsy/wX+1LdC5MiQy4GHK5D7YY0yMT8lfxJNNNzw42uYakZ8Hk3wbgW9c1JVTESL98YucFEvSTaxLQIPizELxaB8u91uW/3vk3rEoJMZrTAeOLNy/eiwD8+Uoxg8o3VujpsIULavAkF0C3mghQshjcXVwQPyicBXxlnGCk5Oovj604+sMjRWolaWnChE+8OYF0mqYVit++BUbJL3mIju4JjOdbd4ign8RAaJ8oAqBVUCMRt4X1WopfIlWTxx0g==;5:ZerI1KkT9UoX5Vo8Hiilif4sLNrT9hChS+5xkLJD4Q66UaUYF3if3ck/5dxZi9vdbATvmtul+/4e13OuyuHLCfsRn6jHrBx+rCH9zuKNVaKw4IFJgBvYY0MbQV5/Go/QnFStW2MdlIqHVIrpHSE7aPLn2qPPdpurDfCV4XwEpSQ=;7:bB91d+VI/eI8b1e2+19HBlT4Oav3CN2tldTTNLUvrFk1fkrd/z4j8vAOMzrNwxTB2HnfVRMVx0y1w2qWMCVjL2tKcBGCzmKqgx4kd3kAfdECs6973gA7U21CFzmcAV+UBFPUS7nbxOCoQaS8oeJF6Bz13O9mzgB80IbnpeoGAz2k9ajcGXubK+Z5LIOeUH4TA0ijPgAzmGA29jKn37j9zT6EaqVbBrgHpno6ni5MGN8TLRvRgjiqJBmCUnHozvHd
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: janustech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 22:27:06.2937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e54d2a8-8bbe-473a-3df5-08d5fd7e1352
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 34eb020e-3cf3-43a1-afeb-f5cf1310628e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR07MB2623
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was tested on actual hardware and found to work fine, but currently
the official specifications of this chip could not be obtained to
confirm the numbers.

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
---
 drivers/gpio/Kconfig     | 3 ++-
 drivers/gpio/gpio-it87.c | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 71c0ab46f216..f1179599aa7e 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -684,7 +684,8 @@ config GPIO_IT87
 	  Say yes here to support GPIO functionality of IT87xx Super I/O chips.
 
 	  This driver is tested with ITE IT8728 and IT8732 Super I/O chips, and
-	  supports the IT8761E, IT8620E and IT8628E Super I/O chip as well.
+	  supports the IT8761E, IT8613, IT8620E, and IT8628E Super I/O chips as
+	  well.
 
 	  To compile this driver as a module, choose M here: the module will
 	  be called gpio_it87
diff --git a/drivers/gpio/gpio-it87.c b/drivers/gpio/gpio-it87.c
index 7cad14d3f127..b1fe26927e44 100644
--- a/drivers/gpio/gpio-it87.c
+++ b/drivers/gpio/gpio-it87.c
@@ -35,6 +35,7 @@
 
 /* Chip Id numbers */
 #define NO_DEV_ID	0xffff
+#define IT8613_ID	0x8613
 #define IT8620_ID	0x8620
 #define IT8628_ID	0x8628
 #define IT8728_ID	0x8728
@@ -306,6 +307,14 @@ static int __init it87_gpio_init(void)
 	it87_gpio->chip = it87_template_chip;
 
 	switch (chip_type) {
+	case IT8613_ID:
+		gpio_ba_reg = 0x62;
+		it87_gpio->io_size = 8;  /* it8613 only needs 6, use 8 for alignment */
+		it87_gpio->output_base = 0xc8;
+		it87_gpio->simple_base = 0xc0;
+		it87_gpio->simple_size = 6;
+		it87_gpio->chip.ngpio = 64;  /* has 48, use 64 for convenient calc */
+		break;
 	case IT8620_ID:
 	case IT8628_ID:
 		gpio_ba_reg = 0x62;
-- 
2.17.1

