Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3141AC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C202084E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="T3hIZAaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C202084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732549AbeGLPsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:48:22 -0400
Received: from mail-eopbgr710054.outbound.protection.outlook.com ([40.107.71.54]:62720
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727277AbeGLPsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXOmG2wwKGmdJTKIxSk9j58/2+1dzinWvUCIPt36964=;
 b=T3hIZAaSu1wJA/uXCIIQsdhz7AyysR567xI/+YDnjCaZyw43ng94EvrY16K4hsOfnF9bZ+9X4ANV9lkB78HLCOaFOKQtdJq83F9cu0FWgoGaqxlnERztqNqzWfpO4TQCu7m8xE3xIDm+2r8HAqfKmRZVHtES/fqB+rntCZ5KKGU=
Received: from BN6PR03CA0066.namprd03.prod.outlook.com (2603:10b6:404:4c::28)
 by BN3PR0301MB1218.namprd03.prod.outlook.com (2a01:111:e400:403d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.20; Thu, 12 Jul
 2018 15:36:08 +0000
Received: from BL2FFO11FD009.protection.gbl (2a01:111:f400:7c09::178) by
 BN6PR03CA0066.outlook.office365.com (2603:10b6:404:4c::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.906.26 via Frontend Transport; Thu, 12 Jul 2018 15:36:08 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; pmeerw.net; dkim=none (message not signed)
 header.d=none;pmeerw.net; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BL2FFO11FD009.mail.protection.outlook.com (10.173.161.15) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.21
 via Frontend Transport; Thu, 12 Jul 2018 15:36:08 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w6CFa7Xj003741
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Thu, 12 Jul 2018 08:36:07 -0700
Received: from linux.ad.analog.com (10.50.1.113) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Thu, 12 Jul 2018
 11:36:07 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Michael.Hennerich@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 3/5] iio:adxl372: Add FIFO and interrupts support
Date:   Thu, 12 Jul 2018 18:36:00 +0300
Message-ID: <1531409760-20070-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(2980300002)(438002)(199004)(189003)(126002)(2906002)(8676002)(316002)(6666003)(48376002)(107886003)(54906003)(426003)(16586007)(336012)(246002)(47776003)(44832011)(4326008)(478600001)(72206003)(6916009)(2616005)(476003)(106466001)(50226002)(26826003)(26005)(14444005)(8936002)(5660300001)(486006)(2351001)(36756003)(51416003)(77096007)(50466002)(305945005)(7636002)(356003)(7696005)(186003)(106002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0301MB1218;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD009;1:v69NOaUBupkA5bHJIKv2rOixlNrUsfp8Dw98Y4BXjRPfUBuuz07O9T7KPJeSx1xY+EEQD3IohnO6ZArCfMBJ0Nj1H/a3UMD/qqoUOz0FQjBtJVwBl0bQ1l40fDxZ5q6B
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48253e63-a041-4b7b-36ef-08d5e80d3041
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(4608076)(2017052603328)(7153060);SRVR:BN3PR0301MB1218;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0301MB1218;3:FKkPdmbN6BIWgmC11HAjddGWjBM/Osi3DZ8xHSqrLy/pqXsK9p+wmqcuKrDHv0qVdRNFV6Gp1O2U7QmT+5ZZDpiEX1OJfN+wF1tPMD4W6pXwgXLrqhblDKEfJzSdLIHtEVTadqTfFc5aDxIeoHN01ZCRL6EPre6GZPp+IlGp6LiOgzNjrG3Vi3P0gtNk4rGoEAHMMRrM49MaISXwz6BVJyb3UzNLeLPRATCLphLnZn7wtt77mr+y6iJ+EQE+aEu4CHNfcLT44PufEftlKoctIn5WjX4J70mY2dD5fibDiJVJIkoD97pKGXFfTvRf25yynz+cr8giYYzHs9wdP7MFQlko6wqETGIYaU7oYopf6Yk=;25:Kee9XF7aoB10ra+AoyLnCe0yn81JDCC6qI7SY7V/6NhrwNW2yU4IlzdRYy+GXNwi0nQXUO3zqtHURAt3PfP+NsDIZ1wvySjDlLl2ogYpZcfaj/W7te2AeXkKseCLcC+47vwB9fliiBfYW+iBGAW5s/Z2S6mQBWCWAkVdAjjEdQGMs2oaO26GshiYGWBaVEgmMzE5guWuG2OBdVhILuunmBZUTgqslgRGuOOQvzWiBeFxGgpAunPtI/JGkJOujawnDdrOZ18QQ4mldKmsc1IIjmuaAZJhEQmul0hTL4PMYcLHjXbeMUuvV9iYBvKyd8nqihhw8fK0MpmYPqOcazQ51g==
X-MS-TrafficTypeDiagnostic: BN3PR0301MB1218:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0301MB1218;31:6VbI9Z+4jZSN81E/dBpSGMahMiDhKGYZ4F7NNpaQ9pM8fX/g7PBoWlRrepT8yJnRxspKFJbisCxYvrW7NxxkP+yZlH2F2LUcg3buF6vkRt+2gBSZPr5ANZQutUY1ZKv5LYKw2EGZlQFT5MfHF1U9WPTQWcUM4Kr4TzoSrBN4zeRsW2fG9JuSiuNf3EzTFYe33nh7h7VxXLW0eBzfxfDSOu1h2kQ2iK800GLo+tHnzY8=;20:++k965CX9QwqwZepP6OjSNXWyFQWDEGvNENUZSzJxlSzHiNMbMI+UojZeUv8p/2fDgPICPBJADvZwqBATRh4P7tniw5pwMzrsIXL569dNHB8vDFxmKIN2BvssffvQETtT/M4Zt8uwxjlkeQ+JC/N/4sXL7woz4MxA0ghXrfwWVyr8m2XD9xm2fXvx7yvLOVLWnh29ZFOOMnOp1EEN14nk511nE5juFuyuX4f/BT+ThX5H/W9Ttopp9XxumngMd02oXtyTHsfhaeg5N2P6vBTDEnhPWCoLnlY/xJnEDcCNXcrW7j9GV61uhkH/wbuYOpGKDzba7Tvka+QONgbB59/hmzaUcymXRDpN+ZRTfE5ZM25L/lf5ROKDYsE/BZU5OEOqjTXHJoYrhx15EUkM+iNHYZ8FdaQ2PLnTTaPK//dI8BAcWXAx4WhESmVo21e0MLHwhhRxwyzI9bkZpZkNSZptm89eR9voduB+LZWt6CGsE/gCX2f1+bOCpfYAMxcxpKz
X-Microsoft-Antispam-PRVS: <BN3PR0301MB121837519C0A833F8F9BC9A59D590@BN3PR0301MB1218.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BN3PR0301MB1218;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0301MB1218;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0301MB1218;4:Doc+pJRdj+RSqemiifp9uKykx6l24R16BjuHjjXFn3N3m+Yi+8Ly0By1qRpYI0/nW+LziyQtDa1qUFcaBjBcEuK4vyYwj0aqaAKBAELCAy7taGfDM0POevrC61WTU1VM8pgZHk7PlIZvG1H+m8yyweZQu6SDNuEILHl6/zp+ZCc5bXF7Jmx45rJCMYleMx9x0d/6dk6PKGFzc44N9POFH0oalSRxcIIgnBAdN640DtC0v8bg3vevStmQHasYC3Cu+S/0h5NYkoRyflhkpsQ+R5x+JyL/b69vowWrkhZ9zULENCovEmDVBZs8H14iP6je
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0301MB1218;23:Nq8T20b1LAC0M9iJiHO8PSAr5PVnGV3uvp+Zie3?=
 =?us-ascii?Q?5UYU/5VOaKwT07GzmpwDJdCxMxQ/9AlEWbpycCJUU2rGlzrodesQK/zTGD9V?=
 =?us-ascii?Q?+QFtTya/rzlrmvxzLhpy5C9GUDjbGmSk8mm6JB52XSiiNPo6PaLLMIHXJc+A?=
 =?us-ascii?Q?i1ncMLzR4hkH2IyD+YQj12u8sNKxeT7Lhnibm83Pct7A1kb14zwIBw940pZk?=
 =?us-ascii?Q?REn0bpPODDmpnFeN1pm0LX23zVvGYVK8MwJ6X07gk8GQ92rrCb/3EWN+7VVA?=
 =?us-ascii?Q?GasNft45zPA3M6UXOkRBYfbxdfkaw/EMKCIGf0/1FTLfel+tI3EzvgtdhM0T?=
 =?us-ascii?Q?TOMuMXjNzxGg4DolV3LV1UMlR28DCoKMYtt72q64xWgkNaZeUPN722epR/fi?=
 =?us-ascii?Q?Me9dpDLZJAh6igT8OVJbkJPQVQwyT7Fo2o4wyBdzhl46KVG0DWbuZkriFrlD?=
 =?us-ascii?Q?OfykDq/Steb/50YFRyepOgVGU8obDymorbh9OTS/HYn/oZajZAErf3ABklHl?=
 =?us-ascii?Q?EQ53V5qsXr0rOUHp5mgEpwIoTgkFAEcKKbVOrS1V7+u/kxzx2yJpu5IJJfU+?=
 =?us-ascii?Q?lVmtOgjSslKuhwok5WdeceVMdPEJs7UXNgFRPy0P2Iydlb1EAg54+xWdrau/?=
 =?us-ascii?Q?9oqdTO2RiJgbHSutl4kHMi7BW0YxWhaxXZBOMj0t09kcOZmWwGkB8AclSOoD?=
 =?us-ascii?Q?XDyOLcOtldKygEC2ZPuNQNVXt7gsLieDmkuOAJB7S06ROC0RnO51F7+qUvSG?=
 =?us-ascii?Q?64jotiPWCn033spGcZ4JhG92XlQnTDBRVRrYP6ULGLCVqRhPqn77Hh5NIFcJ?=
 =?us-ascii?Q?EeBCbGXYsbx7K+F/r0liVmpQvrv+rV8QnC3jJMzwE2uErjkyhRW/CfXaOgSI?=
 =?us-ascii?Q?E/hjIkOnlZsQLKW2HZSPCmOajjXawiGi2qPxm9FWP4Vjyufkq/c8mGIMD3n7?=
 =?us-ascii?Q?s9Ega+DOkp9hK0hSHfYtj6B7gFq5p4rZtMGVYrz4f1VMQeF+iewQxh+FK32y?=
 =?us-ascii?Q?ZnTSOypZnR4RrpPR18yKtHTOvzS5jybMidF3z3BrsZ2CrBjnGV/S2JhvscDI?=
 =?us-ascii?Q?DJqOSQvE=3D?=
X-Microsoft-Antispam-Message-Info: Zi4nSksbgr95S3sbEEd/ZoUHRhbQklpjDHrbtA17IXQs2gPvmxnzakL7ksKDMRgyksgmR3xMOThRSyp/IsckmOMpsnZDn1rfBRYrKIRBPPTGH5hel+miM+p3837YqDsqgM93IiJXEqAHVnuYd1ioiG5FnkNj7QAhTj6MHSvY3GLZYooUTGDvj14c6zwcDezTKn3vVPalNljw4NLmfdT4IzyPykLNAogXj6F622dMPNL4Obj1qwBhqaypc+wVPswRD6GugGEnrm1hKMXY7+dQpCwZski/e5HZqCxytpgcDX7nV4WxdZ2YvhbXpgKAswX6A8dzbZ/M3NET9bGi2g/7EPRT5ZqwBDaTFij89+FKfko=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0301MB1218;6:dez1mzE8wuub1tfSakUOIfgn1vk1H7oRn2uOyDKGoGQhliXfbtrKOOOky6L+jitM7NYaMrVWKfqm8kI+GfBOfvaRPvv08bya0ZL1y0vGaxDp2JBR08wgIiLBoS7oEwNhPo6XgjdAt5Vtx6Pf99oTockNaJhkqfvixlLYs/ISUXq3QntE4TPB0bYAV6U4BlgS6qFMCaUAOd/LMcwPbMmJdsJz08RH0skcmvJTF5Yt013rX3STd4PGvN02uyGmBIl1Co4zllPvw1RLzjxKmkaCrduYuaLlFBDmu9fOY6PoBYcczzpp21DLAIHpuF3mEYDv+oiOQAmToO9d4wh5PONMI8gNa7N43wNolUR064aAElIh/dLHYphZ1HeVCzVMs/7a0VeYYOpQ5ZUoslpSe2hpdxWBukgGbLqekTa5nsvW/+0vfk4D9+HCF16Gn2vyBA+2TVQ+6BiqGiEVQywGusYRZw==;5:UGRU4kMpzS2b5H1VEnWhHrgaJufMpwFgDF3SPj5VCZX9PFh4EfC2QeRoC7ZYSXq4YZgIqIwn5JDnG8tFXbE6DCtgzXE7qyY8umuTwVqfRcJCyW33SZ/N+k9OBlwIW2Ex9Cg6rf0iYqXr8MVsnPPQwE7rSjzpiCSuBfMGaVBjwGQ=;24:rOLGRZxAFaljFYMyRNgcV5bDVpNxWgb1mvMsb40Remz/fVLOv3DGS35XhuJQFKtXsmcYiW3JIKzrvDhEsIVjTFBVWOYUl7xRJdSe4Nzvurg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0301MB1218;7:OZXfBCGSvo8yflfNFEfd5HY5wCkEe5Bx7Ns2Cy0keurlFIhRhj+wJDHlMxEvm6bnUWxtnqBycAppyqLGvdRCvqVgeK2gAk/llnHTX2Tm7Pv/3B5bEBvMk6S7wjpDLtYHLkftmv3aj+CG/1U1A6djX32FJ7tZdWGM1gN7DnjLG91w35Ypx9WGA+4KcCJC4OlaPmqhThwB6AOFyK1GKQQZxrBp4SAMfU7S/dK6GsmKsBoA4TWUUwhorsWOWTLSovzZ
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 15:36:08.3342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48253e63-a041-4b7b-36ef-08d5e80d3041
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0301MB1218
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the adxl372 FIFO. In order to accomplish this,
triggered buffers were used.

The number of FIFO samples which trigger the watermark interrupt can be
configured by using the buffer watermark, while the format depends on the
selected channels.The FIFO data along with the timestamp is pushed to the
IIO device's buffer.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 .../devicetree/bindings/iio/accel/adxl372.txt      |   7 +
 drivers/iio/accel/adxl372.c                        | 346 ++++++++++++++++++++-
 2 files changed, 352 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adxl372.txt b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
index fea4baf..73d7e03 100644
--- a/Documentation/devicetree/bindings/iio/accel/adxl372.txt
+++ b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
@@ -7,10 +7,17 @@ Required properties:
  - reg: SPI chip select number for the device
  - spi-max-frequency: Max SPI frequency to use
 
+Optional properties:
+ - interrupt-parent: phandle to the parent interrupt controller
+ - interrupts: interrupt mapping for GPIO IRQ, it should by configured with
+ 		flag IRQ_TYPE_EDGE_FALLING
+
 Example:
 
 	accelerometer@0 {
 		compatible = "adi,adxl372";
 		reg = <0>;
 		spi-max-frequency = <1000000>;
+		interrupt-parent = <&gpio>;
+		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
 	};
diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 62ce238..645902d 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -6,12 +6,20 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
+#include <linux/gpio/consumer.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 /* ADXL372 registers definition */
 #define ADXL372_DEVID			0x00
@@ -126,6 +134,8 @@
 #define ADXL372_INT1_MAP_LOW_MSK		BIT(7)
 #define ADXL372_INT1_MAP_LOW_MODE(x)		(((x) & 0x1) << 7)
 
+#define ADXL372_FIFO_SIZE			512
+
 /*
  * At +/- 200g with 12-bit resolution, scale is computed as:
  * (200 + 200) * 9.81 / (2^12 - 1) = 0.958241
@@ -167,6 +177,28 @@ enum adxl372_bandwidth {
 	ADXL372_BW_3200HZ,
 };
 
+enum adxl372_fifo_format {
+	ADXL372_XYZ_FIFO,
+	ADXL372_X_FIFO,
+	ADXL372_Y_FIFO,
+	ADXL372_XY_FIFO,
+	ADXL372_Z_FIFO,
+	ADXL372_XZ_FIFO,
+	ADXL372_YZ_FIFO,
+	ADXL372_XYZ_PEAK_FIFO,
+};
+
+enum adxl372_fifo_mode {
+	ADXL372_FIFO_BYPASSED,
+	ADXL372_FIFO_STREAMED,
+	ADXL372_FIFO_TRIGGERED,
+	ADXL372_FIFO_OLD_SAVED
+};
+
+static const int adxl372_samp_freq_tbl[5] = {
+	400, 800, 1600, 3200, 6400,
+};
+
 #define ADXL372_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
 	.address = reg,							\
@@ -193,12 +225,27 @@ static const struct iio_chan_spec adxl372_channels[] = {
 struct adxl372_state {
 	struct spi_device		*spi;
 	struct regmap			*regmap;
+	struct iio_trigger		*dready_trig;
+	enum adxl372_fifo_mode		fifo_mode;
+	enum adxl372_fifo_format	fifo_format;
 	enum adxl372_op_mode		op_mode;
 	enum adxl372_act_proc_mode	act_proc_mode;
 	enum adxl372_odr		odr;
 	enum adxl372_bandwidth		bw;
+	u8				fifo_set_size;
+	u8				int1_bitmask;
+	u8				int2_bitmask;
+	u16				watermark;
+	__be16				fifo_buf[512];
 };
 
+static int adxl372_read_fifo(struct adxl372_state *st, u16 fifo_entries)
+{
+	return regmap_bulk_read(st->regmap,
+				ADXL372_RD_FLAG_MSK(ADXL372_FIFO_DATA),
+				st->fifo_buf, fifo_entries * 2);
+}
+
 static int adxl372_read_axis(struct adxl372_state *st, u8 addr)
 {
 	__be16 regval;
@@ -313,6 +360,114 @@ static int adxl372_set_activity_threshold(struct adxl372_state *st,
 				 buf, ARRAY_SIZE(buf));
 }
 
+static int adxl372_set_interrupts(struct adxl372_state *st,
+				  unsigned char int1_bitmask,
+				  unsigned char int2_bitmask)
+{
+	unsigned char buf[2];
+	int ret;
+
+	buf[0] = int1_bitmask;
+	buf[1] = int2_bitmask;
+
+	/* INT1_MAP and INT2_MAP are adjacent registers */
+	ret = regmap_bulk_write(st->regmap,
+				ADXL372_WR_FLAG_MSK(ADXL372_INT1_MAP),
+				buf, ARRAY_SIZE(buf));
+	if (ret < 0)
+		return ret;
+
+	st->int1_bitmask = int1_bitmask;
+	st->int2_bitmask = int2_bitmask;
+
+	return ret;
+}
+
+static int adxl372_configure_fifo(struct adxl372_state *st)
+{
+	unsigned char buf[2];
+	int ret;
+
+	/* FIFO must be configured while in standby mode */
+	ret = adxl372_set_op_mode(st, ADXL372_STANDBY);
+	if (ret < 0)
+		return ret;
+
+	buf[0] = st->watermark & 0xFF;
+	buf[1] = ADXL372_FIFO_CTL_FORMAT_MODE(st->fifo_format) |
+		 ADXL372_FIFO_CTL_MODE_MODE(st->fifo_mode) |
+		 ADXL372_FIFO_CTL_SAMPLES_MODE(st->watermark);
+
+	/* FIFO_SAMPLES and FIFO_CTL are adjacent registers */
+	ret = regmap_bulk_write(st->regmap,
+				ADXL372_WR_FLAG_MSK(ADXL372_FIFO_SAMPLES),
+				buf, ARRAY_SIZE(buf));
+	if (ret < 0)
+		return ret;
+
+	return adxl372_set_op_mode(st, ADXL372_FULL_BW_MEASUREMENT);
+}
+
+static int adxl372_get_status(struct adxl372_state *st,
+			      u8 *status1, u8 *status2,
+			      u16 *fifo_entries)
+{
+	unsigned char buf[4];
+	int ret;
+
+	/* STATUS, STATUS2, FIFO_ENTRIES2 and FIFO_ENTRIES are adjacent regs */
+	ret = regmap_bulk_read(st->regmap,
+			       ADXL372_RD_FLAG_MSK(ADXL372_STATUS_1),
+			       buf, ARRAY_SIZE(buf));
+	if (ret < 0)
+		return ret;
+
+	*status1 = buf[0];
+	*status2 = buf[1];
+	/*
+	 * FIFO_ENTRIES contains the least significant byte, and FIFO_ENTRIES2
+	 * contains the two most significant bits
+	 */
+	*fifo_entries = ((buf[2] & 0x3) << 8) | buf[3];
+
+	return ret;
+}
+
+static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct adxl372_state *st = iio_priv(indio_dev);
+	u8 status1, status2;
+	u16 fifo_entries, i;
+	int ret;
+
+	ret = adxl372_get_status(st, &status1, &status2, &fifo_entries);
+	if (ret < 0)
+		goto err;
+
+	if ((st->fifo_mode != ADXL372_FIFO_BYPASSED) &&
+	    (ADXL372_STATUS_1_FIFO_FULL(status1))) {
+		/*
+		 * When reading data from multiple axes from the FIFO,
+		 * to ensure that data is not overwritten and stored out
+		 * of order at least one sample set must be left in the
+		 * FIFO after every read.
+		 */
+		fifo_entries -= st->fifo_set_size;
+
+		ret = adxl372_read_fifo(st, fifo_entries);
+		if (ret < 0)
+			goto err;
+
+		for (i = 0; i < fifo_entries * 2; i += st->fifo_set_size * 2)
+			iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
+	}
+err:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 static int adxl372_setup(struct adxl372_state *st)
 {
 	unsigned int regval;
@@ -397,7 +552,12 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
 		ret = adxl372_read_axis(st, chan->address);
+		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
 			return ret;
 
@@ -413,9 +573,159 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static ssize_t adxl372_get_fifo_enabled(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl372_state *st = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", st->fifo_mode);
+}
+
+static ssize_t adxl372_get_fifo_watermark(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl372_state *st = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", st->watermark);
+}
+
+static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
+static IIO_CONST_ATTR(hwfifo_watermark_max,
+		      __stringify(ADXL372_FIFO_SIZE));
+static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
+		       adxl372_get_fifo_watermark, NULL, 0);
+static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
+		       adxl372_get_fifo_enabled, NULL, 0);
+
+static const struct attribute *adxl372_fifo_attributes[] = {
+	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
+	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
+	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
+	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
+	NULL,
+};
+
+static int adxl372_set_watermark(struct iio_dev *indio_dev, unsigned int val)
+{
+	struct adxl372_state *st  = iio_priv(indio_dev);
+
+	if (val > ADXL372_FIFO_SIZE)
+		val = ADXL372_FIFO_SIZE;
+
+	st->watermark = val;
+
+	return 0;
+}
+
+static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+	u8 fifo_set_size, accel_axis_en;
+	int bit, ret;
+
+	if (!st->watermark)
+		return -EINVAL;
+
+	ret = adxl372_set_interrupts(st,
+				     ADXL372_INT1_MAP_FIFO_FULL_MSK,
+				     0);
+	if (ret < 0)
+		return ret;
+
+	fifo_set_size = 0;
+	accel_axis_en = 0;
+	for_each_set_bit(bit, indio_dev->active_scan_mask,
+			 indio_dev->masklength) {
+		accel_axis_en |= bit;
+		fifo_set_size++;
+	}
+
+	switch (accel_axis_en) {
+	case 0:
+		st->fifo_format = ADXL372_X_FIFO;
+		break;
+	case 1:
+		if (fifo_set_size == 1)
+			st->fifo_format = ADXL372_Y_FIFO;
+		else
+			st->fifo_format = ADXL372_XY_FIFO;
+		break;
+	case 2:
+		if (fifo_set_size == 1)
+			st->fifo_format = ADXL372_Z_FIFO;
+		else
+			st->fifo_format = ADXL372_XZ_FIFO;
+		break;
+	default: /* case 3 */
+		if (fifo_set_size == 3)
+			st->fifo_format = ADXL372_XYZ_PEAK_FIFO;
+		else
+			st->fifo_format = ADXL372_YZ_FIFO;
+		break;
+	}
+
+	/*
+	 * The 512 FIFO samples can be allotted in several ways, such as:
+	 * 170 sample sets of concurrent 3-axis data
+	 * 256 sample sets of concurrent 2-axis data (user selectable)
+	 * 512 sample sets of single-axis data
+	 */
+	if ((st->watermark * fifo_set_size) > ADXL372_FIFO_SIZE)
+		st->watermark = (ADXL372_FIFO_SIZE  / fifo_set_size);
+
+	st->fifo_set_size = fifo_set_size;
+	st->fifo_mode = ADXL372_FIFO_STREAMED;
+
+	ret = adxl372_configure_fifo(st);
+	if (ret < 0) {
+		st->fifo_mode = ADXL372_FIFO_BYPASSED;
+		adxl372_set_interrupts(st, 0, 0);
+	}
+
+	return ret;
+}
+
+static int adxl372_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+
+	adxl372_set_interrupts(st, 0, 0);
+	st->fifo_mode = ADXL372_FIFO_BYPASSED;
+	adxl372_configure_fifo(st);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops adxl372_buffer_ops = {
+	.postenable = adxl372_buffer_postenable,
+	.predisable = adxl372_buffer_predisable,
+};
+
+static int adxl372_dready_trig_set_state(struct iio_trigger *trig,
+					 bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct adxl372_state *st = iio_priv(indio_dev);
+	unsigned long int mask = 0;
+
+	if (state)
+		mask = ADXL372_INT1_MAP_FIFO_FULL_MSK;
+
+	return adxl372_set_interrupts(st, mask, 0);
+}
+
+static const struct iio_trigger_ops adxl372_trigger_ops = {
+	.set_trigger_state = adxl372_dready_trig_set_state,
+};
+
 static const struct iio_info adxl372_info = {
 	.read_raw = adxl372_read_raw,
 	.debugfs_reg_access = &adxl372_reg_access,
+	.hwfifo_set_watermark = adxl372_set_watermark,
 };
 
 static const struct regmap_config adxl372_spi_regmap_config = {
@@ -451,7 +761,7 @@ static int adxl372_probe(struct spi_device *spi)
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &adxl372_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
 
 	ret = adxl372_setup(st);
 	if (ret < 0) {
@@ -459,6 +769,40 @@ static int adxl372_probe(struct spi_device *spi)
 		return ret;
 	}
 
+	ret = devm_iio_triggered_buffer_setup(&st->spi->dev,
+					      indio_dev, NULL,
+					      adxl372_trigger_handler,
+					      &adxl372_buffer_ops);
+	if (ret < 0)
+		return ret;
+
+	st->dready_trig = devm_iio_trigger_alloc(&st->spi->dev,
+			  "%s-dev%d",
+			  indio_dev->name);
+	if (st->dready_trig == NULL)
+		return -ENOMEM;
+
+	st->dready_trig->ops = &adxl372_trigger_ops;
+	st->dready_trig->dev.parent = &st->spi->dev;
+	iio_trigger_set_drvdata(st->dready_trig, indio_dev);
+	ret = devm_iio_trigger_register(&st->spi->dev, st->dready_trig);
+	if (ret < 0)
+		return ret;
+
+	indio_dev->trig = iio_trigger_get(st->dready_trig);
+
+	ret = devm_request_threaded_irq(&st->spi->dev, st->spi->irq,
+					iio_trigger_generic_data_rdy_poll,
+					NULL,
+					IRQF_TRIGGER_RISING |
+					IRQF_ONESHOT,
+					indio_dev->name,
+					st->dready_trig);
+	if (ret < 0)
+		return ret;
+
+	iio_buffer_set_attrs(indio_dev->buffer, adxl372_fifo_attributes);
+
 	return devm_iio_device_register(&st->spi->dev, indio_dev);
 }
 
-- 
2.7.4

