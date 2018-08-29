Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C2FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB59A20850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="ZSqOlZox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB59A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbeH2S4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:56:32 -0400
Received: from mail-dm3nam03on0048.outbound.protection.outlook.com ([104.47.41.48]:45773
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727537AbeH2S4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSLBFgb/PfiTjb854Z5tIOBl6RSX9zhPPhM5FpH3K6g=;
 b=ZSqOlZox6j86F4E3foMXYNWbAC50wMPnHM1cLzXZ3WXrrgy1XKh52KrPerCRQMLnHgYpzK4fEmITWnZSXHO3T11pkmjsDvS8tX07oVQRud4oPWLCmPZCHdYI+KjPA22tkEcb7C99Uwj3WknKYl8ZnoUeKTLMH3MgeF3pAPyyCj8=
Received: from CY4PR03CA0014.namprd03.prod.outlook.com (2603:10b6:903:33::24)
 by BN6PR03MB3121.namprd03.prod.outlook.com (2603:10b6:405:3c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.13; Wed, 29 Aug
 2018 14:59:08 +0000
Received: from BL2FFO11FD026.protection.gbl (2a01:111:f400:7c09::177) by
 CY4PR03CA0014.outlook.office365.com (2603:10b6:903:33::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1101.13 via Frontend Transport; Wed, 29 Aug 2018 14:59:08 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BL2FFO11FD026.mail.protection.outlook.com (10.173.161.105) with Microsoft
 SMTP Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id
 15.20.1101.10 via Frontend Transport; Wed, 29 Aug 2018 14:59:07 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w7TEx6jm031508
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Wed, 29 Aug 2018 07:59:06 -0700
Received: from linux.analog.com (10.32.223.103) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Wed, 29 Aug 2018
 10:59:06 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <mark.rutland@arm.com>, <Michael.Hennerich@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH] iio: dac: ad5758: Add support for hard reset
Date:   Wed, 29 Aug 2018 17:58:42 +0300
Message-ID: <1535554722-1094-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(2980300002)(438002)(199004)(189003)(246002)(476003)(2616005)(7636002)(426003)(72206003)(6666003)(8936002)(51416003)(7696005)(126002)(44832011)(336012)(48376002)(50466002)(356003)(77096007)(26005)(486006)(1857600001)(478600001)(8676002)(5660300001)(305945005)(186003)(14444005)(106002)(36756003)(16586007)(54906003)(316002)(2906002)(4326008)(110136005)(47776003)(50226002)(106466001)(53416004)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3121;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD026;1:WgPDU3svr0dzzgE/3JfSjAA7adoExiy/EGNMdFZS54S2hCsmzvdVSqmFLlUjKvu14Dv+3zYFHSJAa4xve2TrCCM2zdYFcrsvA0aDHOOeLTKtp+LpY7itJEs2cV6VliPy
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e432c711-7583-4fe4-17ea-08d60dbff861
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN6PR03MB3121;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3121;3:GfxVVzVNE2u9zqjwWACkfAEPVhDmLKkDnxi6SfZqaDb4Z6JzRPpy7xW1I0eIFunPKLNGBV2/JU4necuRPutcZW2tqPjWGdExAt/X2RJ5mNVzpP77BTfUw901uGpcoFNFSxx6Fgr+BZc5prebJ0yK8d9OwS8E9KmUejndzPHeEczcu5Un4+jaCus5bPSnO2E3NQjAt5mQdu6ryCevCU/GYOl+RdXpM+EvZvOP/qj4WHa77UnO5wsnBkGrv+ieywcyFfIbe3ADcDV1EHFAHRVQtUgXLNYTxgLSFmbbCmle8Y6vCN9VFQZC9KDZ7dnCTvV8KkReHIAhL6XTQqjiNL/SGoJBNtgRz9L9UNbsRjZo6aQ=;25:r4H0ucNl2S5VMyXLvueAluxTZVq7uM19GmjV5RMGMaLOVD9qDLahi5JBMdkYivjwbuGVs6K0iEBMRE4I+O3Zrs7xZe/eRmfMsgIxdryoY69qHbh225YjnMef03NJEd2P1NzJhJjAMM2ts9ooWn2ezFW8qXllrOW+wj7Wmi0t2ZuJRZHe4zDhxk0jUsPVajdTPH46EQzHSsrS9PTTJLxd9j+VblHiw2E77vl8H8rGidxm+TJByT00bbcoF46uGHWvJWBU9kgzA/uCYXMjfTGX8VLA7HcXF4IE+/OV0+kG8/UBSwYp+GSuHmV3QgXVYkM0GZTy8072t+iCe1DzCDIzNA==
X-MS-TrafficTypeDiagnostic: BN6PR03MB3121:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3121;31:3xkpk0sINt4bP6+uz0coUgS0VFOid76x68FhkzRgzUuZK2oAVtbCysWmebNsRMoZ2Igh5bKpEnUbanzZn2Wj1POZCpkQ5PFgIkdx2MlC7QigfZFhWIzvjKfc15Rl1RZIR23fof/67RalKkm+DiMKrc/SygKn4b6OADHLIXZ5Oli4+PWH8jRrdU2MDF9FtZRvtS5VYPCety66njrVydU7DN+D1Le2vwpewQL8dCokyHg=;20:b7XYVGhvY4Zo4SjDBIjs/q+kfOfm0tmmplJ7f4zhL/VqtPNGr50h7UKrldJ7ZYFy2MQ28+YwD0P0d+ago5KjgY0I97sj1Bk4fxZOz+j15QDRdOGMW0a/lc7jfITtUXxdMgbhKeWHBjKKmzxGNMfh+kkmYpz+PY3RSSGVU3ENusAtM7eDXvqG7XoV9er3LffrN5d8+gKEWh4b4Oh+2dkp7KtIZb4rV4WffMfmPOiT4JBWmJ42n7yDWj5QRfXP3Jy+yxIx/BVkYmK6fTiPcYKsB6jFGYfRvbbbQnnAQZJw47VwK9LW6l1A7RahRIe+0LbaxIApWLyxF/j9M/pZ/aez1uRPlb/I3LSBSErr0+jQ6eM+tBF+LesZjdgfMjz8+X+cI1hvI3wD9KKQgL/BFFhL8OjFdmOv+GX2pXobHsEpo1p4/5a/zoXGyB06HjybQQSDbkeHHxi9Z/ivFWFRWL2brQhrc1pD8xlymBN/jsZWFFTR2tqW00TQNkSgxwhLI9X0
X-Microsoft-Antispam-PRVS: <BN6PR03MB3121F85A7D74D229A6CDB79B9D090@BN6PR03MB3121.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699016);SRVR:BN6PR03MB3121;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB3121;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3121;4:MAErg1ltHYK73FsR+MFZbbLwtVNfRlLvxjW8GxjW7zW2vYMS1wiNvlUkAzF0K/8iJJyy8kbEaYt576FqydSIHJHGqF3zzkZ9g9dVkyRoYIrGvns2jNjETSMaYx34vhMXMQX/nQ8KFABrEJN52Mu6l3zzZx5W3Mf0rT4yGjvXok1pXKnbvCZFyvyr/u+7Cj/BTUS4OPZT1p2UFFEbXn3RbV2PXjpGrDwuBaaE42FkAVnsj26sEqjaNDpoYB6aYqgZHsLfP7uZ/Wv1/69XREXmXjbm15uigqs5mx8V+Q9oYmKw8feMRhcRfwooJb1VvFG8
X-Forefront-PRVS: 077929D941
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB3121;23:NLHH2EKoarvScc46wm5Fh4cY5Mz9lbbm0UfknZHt0?=
 =?us-ascii?Q?8ODB3PEd37X5uDTqHj3wxj1/1CPsLQlr6jZNpxuopREeqfaE7pQU5gjFnnQR?=
 =?us-ascii?Q?g4LJGCo2a+L/iz+61TrrRpYXyo8/kG/iwcWxv7xC60Oh5eVBLTObfQ+eDv6C?=
 =?us-ascii?Q?7AZSCI7A84o8iD0TuXSIpt+ZF/5awjNH0RVsmVJYEYsEQus5fRtx/Uy4477i?=
 =?us-ascii?Q?2FTBj9/YKVZ6ZJWFovzM2en6JVCryCuxH09LbV+PFbKMgKhJ1roDUuOdpIqL?=
 =?us-ascii?Q?YBXrpQEA3QZiZaf3hGbLF8pOMZa2m29P1RE5AssgE0k7h0fGqmdkGK2EX2TP?=
 =?us-ascii?Q?Bt0vqG71F3oLaiJCfhi1nltNQpoEAtdxJCbErqaUvZf/FktG4FFuNj5G01lc?=
 =?us-ascii?Q?cj3eekMGr09HL1s4f8Mz8XXcCUkzVSyi/AaERfdqyuwDxWbZKrpRGx/S4rmD?=
 =?us-ascii?Q?bLHRfdfrOjHtmSns9B5GcwSIS7XX58GUtc9XYih63wVnOjMD3vMPP/4YJ/3e?=
 =?us-ascii?Q?SDTbcLBFBuBRm8q7DjxyGiL5dhxKvqE1rKAQoOYT1zXCzn+J+pBsRY1KK3mI?=
 =?us-ascii?Q?0jQe7cqzOCy0cO5R95P01uSnBLEMa3ovnYpEiI5JYDD/OE3JQqe4xMTWs0lK?=
 =?us-ascii?Q?zCnkkzzEsOzUUJ4J1Giwt9LxTi72a4jh2mhXuvpyzgS9kjvBcKZMv2nAmNON?=
 =?us-ascii?Q?+vxDd9rlxYxQiaDLv4FJIIEzDCVf8Ftbc5rFu5oKyBZ+YKEX9M4GuyUtQAkJ?=
 =?us-ascii?Q?c/FC35rBkYMBfCivUaELYMM4mqx6MO/VGL5kXLSXL7uTATvMLu+GDM3vCUxp?=
 =?us-ascii?Q?NG6xxEa6Pa0opWLC7y6ffOtmZ7Ru+pW+uiu3AeIrzZnjQwPJevGpx9dqMuOM?=
 =?us-ascii?Q?/6aCSeIcEl4O0doGLtOBFofkNh5HJN6ZJNbcqQrqTEKHvhPUCcn0Ht7P5ptq?=
 =?us-ascii?Q?BhVX9oD6geIOOyNUyQ0cy6R9HUDcUB1cinr+Lx4jtc1vUN1LGstlHMzToASO?=
 =?us-ascii?Q?AcfYTbZelyvgPnZemBHBHVQ9Uz8xZtO0/euYUAo8WrEDTsKDM1vLKIjtTgNG?=
 =?us-ascii?Q?jXfjsQ=3D?=
X-Microsoft-Antispam-Message-Info: PSGwkSRWXRGnYS8Frg3VAQ4fYBt0Zim4a6kiMD6p0dQ5D/CTj71l7H1ODfgfX68XO9QG8vcWh19BXt5KS90U3E/LeufCGyV/+G4Ky9I+uxXHHKn5ua4le5GalS2+jp+w2cgypCfx7AcHYTIZPNjxsE78lXmoxWOp/dykWVVO8CZUwd1xKPV+3JP13wuETFlTv5ghfP156SDfqtAUo8wHr/ETEp63akt9S9Dx8WWVhCqSfuR6axXvRtxxdFxDu4EURG899Dmrgc75x2Lve1UWHywteBPLUUbERINyPIh7TnsL72bJDUzgN4KExytfMTOPNVYjJHM6RJa862e3rNGlejn+6hn70KrTZnsxRgI3qsU=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3121;6:KWMzyOfB9Uj/veunwpjjWFwOCgDPwp1ScXg/WTCEEhSH/aYaJpOQKXKal+QC1ZRX2tf20WEWxZ4wMeXyqWz/1GnwBWRY63Zj0lfxEfhSzxDUdr6OuTdCAfuUZRDoIND27xg9gYLoJdraLCfKsqfd28XJqGcWNuqriboa6m7NeFpwU1UZXiLFcQy8wqxy3Gq8vnTqbm7M98tDT4hW7jcIuF3Tjr9ej4OmZsBCNDqGaB2werrJEMlV9cCH8M0rLaELQjvSYbJAcqEsJw4kVwQIG4Y5lLWS2+D8ODtYftn1fNb9K+Yg2mVZ3565+B5xkQNAtq9/W7qJq5+ACBSQa/DnQEhlzMz9TdnounIdS1UjFdU4jvmL+SbX4uJAnbZBbRPPfkk/J5+CC02+4trFC1xO+Xp20MOacyRR0DSyH3MVdcfOBRlbjkIC1Zs9J9uQkjeNyFmgSQWg4aFVPx53qvnFYw==;5:R/Zd7jo3k5peh0V1ZNt3fe6paMJDEtZsgIx1J39DOukgcB6BRIMKEmynGLN+/BrNOJ1VjodKF/flxAReK0cM1lOmSGypS0d1NsAMSuMbkCDLXP7epkYQWT5pFbhntnuFNc4ypUhwdm5J0nkWvFGreYYBlfzmqj0DL0kLd0X7IFI=;7:M7lSoFVGx1rUf+ddie/dqLB51PWrlghqEmne11hTR8JssnLJdOTQvw4eOcEdDTu3k9hpwD8DADN8+1c+jy6PUx4pR+fiQ0yZDT9RRQkxDvNeOQXHQzxviP64+4FQ++3sbeugMsXT4iHxnux+iypHgIHmNQbQUNRQGH48l+8bkxZ6vU5AtBlkcpXvoudbR8J8kHFgmXjhLdth6tCyTEE76gzVdjnUeE+mrJ6XgbU1h4nvOll4bLFlXoIShepluVyf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 14:59:07.5594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e432c711-7583-4fe4-17ea-08d60dbff861
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ad5758 has a hardware reset active low input pin. This patch adds a
devicetree entry for a reset GPIO and a new ad5758_reset() function.
During
initialization, it is checked if the reset property is specified and the
the GPIO is being asserted, therefore the device will become active.

When the reset function is called, if the gpio_reset var is set, then
the
GPIO will be toggled, otherwise a software reset is performed.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 .../devicetree/bindings/iio/dac/ad5758.txt         |  5 ++++
 drivers/iio/dac/ad5758.c                           | 27 ++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/ad5758.txt b/Documentation/devicetree/bindings/iio/dac/ad5758.txt
index bba01a5..bbcd789 100644
--- a/Documentation/devicetree/bindings/iio/dac/ad5758.txt
+++ b/Documentation/devicetree/bindings/iio/dac/ad5758.txt
@@ -50,6 +50,9 @@ Required properties:
 
 Optional properties:
 
+ - reset-gpios : GPIO spec for the RESET pin. If specified, it will be
+ 		 asserted during driver probe.
+
  - adi,dc-dc-ilim-microamp: The dc-to-dc converter current limit
 		   The following values are currently supported [uA]:
 			* 150000
@@ -71,6 +74,8 @@ AD5758 Example:
 		spi-max-frequency = <1000000>;
 		spi-cpha;
 
+		reset-gpios = <&gpio 22 0>;
+
 		adi,dc-dc-mode = <2>;
 		adi,range-microvolt = <0 10000000>;
 		adi,dc-dc-ilim-microamp = <200000>;
diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
index bd36333..b5cc5bd 100644
--- a/drivers/iio/dac/ad5758.c
+++ b/drivers/iio/dac/ad5758.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/spi/spi.h>
+#include <linux/gpio/consumer.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -108,6 +109,7 @@ struct ad5758_range {
 struct ad5758_state {
 	struct spi_device *spi;
 	struct mutex lock;
+	struct gpio_desc *gpio_reset;
 	struct ad5758_range out_range;
 	unsigned int dc_dc_mode;
 	unsigned int dc_dc_ilim;
@@ -474,6 +476,22 @@ static int ad5758_internal_buffers_en(struct ad5758_state *st, bool enable)
 					     AD5758_CAL_MEM_UNREFRESHED_MSK);
 }
 
+static int ad5758_reset(struct ad5758_state *st)
+{
+	if (st->gpio_reset) {
+		gpiod_set_value(st->gpio_reset, 0);
+		usleep_range(100, 1000);
+		gpiod_set_value(st->gpio_reset, 1);
+	} else {
+		/* Perform a software reset */
+		return ad5758_soft_reset(st);
+	}
+
+	usleep_range(100, 1000);
+
+	return 0;
+}
+
 static int ad5758_reg_access(struct iio_dev *indio_dev,
 			     unsigned int reg,
 			     unsigned int writeval,
@@ -768,13 +786,18 @@ static int ad5758_init(struct ad5758_state *st)
 {
 	int regval, ret;
 
+	st->gpio_reset = devm_gpiod_get_optional(&st->spi->dev, "reset",
+						 GPIOD_OUT_HIGH);
+	if (IS_ERR(st->gpio_reset))
+		return PTR_ERR(st->gpio_reset);
+
 	/* Disable CRC checks */
 	ret = ad5758_crc_disable(st);
 	if (ret < 0)
 		return ret;
 
-	/* Perform a software reset */
-	ret = ad5758_soft_reset(st);
+	/* Perform a reset */
+	ret = ad5758_reset(st);
 	if (ret < 0)
 		return ret;
 
-- 
2.7.4

