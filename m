Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DC1C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DAC208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="cAKHj6c2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DAC208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389738AbeHARDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:03:05 -0400
Received: from mail-eopbgr690075.outbound.protection.outlook.com ([40.107.69.75]:35941
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389452AbeHARDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ADO+wGmqtpTyoSSLEgGSM4alBR7rWDCkLI0UX7UU1s=;
 b=cAKHj6c2mDyyrsE1ETYsN6iRtR5Os0N30bQrCktXM7pM/KlklxqDR0ViHfS5hpMbdGtZO2U/N8Wdw0MZwwiowonp8Jq0fR9fKTg+TlPRcm5s6V5M7Vw5Cjl2ncWbW01iYD9g+xIxImI9MMfOkdkrKxJXzq7z8+EXBH532i6Rr7A=
Received: from BN3PR03CA0069.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::29) by DM2PR03MB560.namprd03.prod.outlook.com
 (2a01:111:e400:241c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 15:16:51 +0000
Received: from BN1BFFO11FD014.protection.gbl (2a01:111:f400:7c10::1:165) by
 BN3PR03CA0069.outlook.office365.com (2a01:111:e400:7a4d::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1017.15 via Frontend Transport; Wed, 1 Aug 2018 15:16:50 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; pmeerw.net; dkim=none (message not signed)
 header.d=none;pmeerw.net; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1BFFO11FD014.mail.protection.outlook.com (10.58.144.77) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1017.15
 via Frontend Transport; Wed, 1 Aug 2018 15:16:50 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w71FGniT015023
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Wed, 1 Aug 2018 08:16:49 -0700
Received: from linux.analog.com (10.50.1.113) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Wed, 1 Aug 2018
 11:16:49 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v2 2/6] dt-bindings: iio: accel: Add docs for ADXL372
Date:   Wed, 1 Aug 2018 18:16:39 +0300
Message-ID: <1533136599-31714-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39850400004)(376002)(2980300002)(438002)(199004)(189003)(7636002)(44832011)(54906003)(47776003)(2351001)(7416002)(356003)(106002)(106466001)(53416004)(426003)(316002)(8676002)(305945005)(186003)(2906002)(478600001)(966005)(6306002)(5660300001)(16586007)(72206003)(6916009)(126002)(51416003)(4326008)(486006)(48376002)(8936002)(2616005)(246002)(36756003)(26005)(476003)(50466002)(50226002)(77096007)(336012)(7696005)(6666003)(1720100001)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB560;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD014;1:bwPoI0mQPieGqx9XJ0CsSRnFqFW5P7N2dKVjL1UF2iuzd7PYV2Pcj46cTMUJqyKjnEr9GVgh3y8QtLxjyvgcJfu2JxrY6zDfcwNIzNs86cDEw4keDCPICnM2csg6FwPx
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72bb7cc1-6a00-4ceb-61b4-08d5f7c1ce45
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM2PR03MB560;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB560;3:sYt3M0DD6BtjY9xdoFrdkHRP81y0I84kfNVnW0f1fpSgkyTonq94GP9Rr6varVLq25iigRpG4mwv9TixppiscIt0De8zQi8v6JuFJNN6UzajQpzf/izAX7MfninoXIWNAjGJLRivNve1Tr7piFYfGM+WqplAjQhWSBW8BtkR5bhMyWMwGB3R2uo46fZYnGbGcUuYp2yNkO/6u473Qg2lQIQHJb32ianH3qNXwELcqOnJgs3cyYgYE5N5iAnnyyuTbDRGZsFe0AKfSEpu8hy5OykjfYPECKy215A3jvS+EzN0kn/fjtDTM9VxyYcjFy/OFYQVOF3055oDHTmaahtPI/W4gaew0hfnw2ws/byPXtU=;25:HOjffC1etOz09Pfi+9w5MccFkofIJdvPzsr+gbBSTucBFOO/50wwiLkGPvDHHGY5Dq2z8t+Juzwq3sukT1eEOijtnpgaG43frWFp39eIPlMTH4LTcH720yYIL4R7i4LJiioNejyX26AubIJ4kcy6Ezkute/kt7Cb2Yj266seI+FRUYlPyqKW9pTnTqDhdU7tPEo8Awxc9UidYN8S0ZJ8Bws1B/L3HO2qr1mdDJrhwaZLsSJTrHVYUa9GyKglo4wwBaZl5xLKWpKEyQkM0hzWXYcKfF0IRLkkKClw6HaoyYTCLYwV09AeAs26YkHw/fLO13U/MovoT3Jbqg76gogwmQ==
X-MS-TrafficTypeDiagnostic: DM2PR03MB560:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB560;31:uETkFTa2SiMw5Vo3qEgeE6zerYzfuv43jbwo9pFFZ3D74JBhPzcKpxY0Xt0GD5yJjkzTKLKsvr3a8+Px3eCCq1RCbvqaXZWI7h2NLFQgADzxJZ9DmBsIO4m6jogTfAgVaLvR2H4PXCaQ6YJ4pu2TaBdgkfBzVEF/PugTV2UY4M0hJs9VPKu5hmtHfaIAGg7a80QUTwTjA/RbKC50GjeK/Zp4YbN6S+DO9DRs7MVldjs=;20:ykfROR0oKJKwhTHYcQC35B9KOcT219lSmyDmuboE+J7haGfzFSYZPIABKRB4H9iLukmzO3o2GhDpJQ3dsZPSIjyXjkplZRttFC+adyXSfBhLEhHT9zrvAZewHtvvpAm4Cr0LFbw3s+i9Ry7dhdWE0tNTXGyOTJ2odI7xwVwGyRnqxw3PPuXQTwiLjzI/Q24FsiTNw+LFDMs+O3WwlWYYeDx8rHci0p554FvVa4QvS70KsJmRJa2s5RwqczoDWIgTRCuJ9PpCKErVQBWiSTLSesKGJ1agE4SZMkVGlykoZCf32zQ2HGAD8XcZQM9Tawawo39hLsSMC6soSnNkg62aQg6xsgRw4VmJMxE6rRNyqX6V3TXstzI+hMzkH3zZxjlQcjk/gTXg3Tjr/j0OjwLkNg/gAIITyvg48vNweShRspwLJQrv6Ago5/U3p98tIcXJWdjvQiF7HArDZAyEta3OAhBNlcQ5q3jlU9ZSDO+rKxsxrjVPtxnbgV7N0kB/W/5M
X-Microsoft-Antispam-PRVS: <DM2PR03MB560FA30D43B6568C6F8BAF79D2D0@DM2PR03MB560.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(232431446821674)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM2PR03MB560;BCL:0;PCL:0;RULEID:;SRVR:DM2PR03MB560;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB560;4:d82JMuDzmhmNkivEACMtXQAw+ZPSduVcbT9AqSRT8GtPQLSzAA1DHJuW0KdlsaPQxSr0sAbVYbEuQ5BhE/J5UPRTOUoC6sJUMtsxEo3VK0G5HInL5vRLXIJrujEzljUPe1GpKKMHoqXDqnHyIRXxsG9HgKWG1fUfQsOIVhcAJrvzGtHvD32ki+s5g/9yQ+iKsQ35MWs+b39zo7LBhSwf5cCVHvPZ0HGfMBSvHEOt95tXtElpCuF8/NpurDvr4Ztzvvt/k4ZbOIOmnc/8pRHGizLQn9CZ/0OMXiHU2wnh0keIjHSNm3UhuQAe+mhhh79uOafbegnokxg//pW0kEvBXptHx7L0b1MxGDq8CzWisV80YuTyWFEFl73eTG3CF5ye
X-Forefront-PRVS: 0751474A44
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR03MB560;23:c9kzRdNU1yqWevP9iOh6H0+Z/dRhl7Zm+6FuhfhHvS?=
 =?us-ascii?Q?ku323s8DwJTetO1f/JyuB8puMb8g4a8oYosusCSEfq95+Ey9eUqI2fyBJ3ha?=
 =?us-ascii?Q?lfi7EQ8MtXDTEgmFqgZWrqFVVnyq2FG+efUehAFMWrxo+sz5PjOmtgWhQsUp?=
 =?us-ascii?Q?b9uC9+QJ+qzaKNus27zIr0Q2hRbibDY2ZOuAuJaL4XLMZ7UFGIwsiaoBcMJs?=
 =?us-ascii?Q?eLxA/OY3gEclfWHXzWm1h40HXiF8RmvleXZsyk3+a6f7E/6qOS1WhLjwxx5U?=
 =?us-ascii?Q?G8K6HJr+NhQccvaHXhTuhmYuP3hARV0ZCGVNNxCe6JpsOhEeNLy0LGe0hAP8?=
 =?us-ascii?Q?6gAN9qbQRIWi/jcA7UrT62utkgyrM7FdxbvK/2D1FNYtdUWIRJIbznhi8KLt?=
 =?us-ascii?Q?CLRUp9xTor5qq+C5oW1AliygVcVJQakVUyOMe8KFZLJQS2b1GO17Zen5CUhV?=
 =?us-ascii?Q?imbG+SxNOhOQnDrAYmO6qH13imResUAa7tHh8vLc64hpKbdFCGXeYQhobd3M?=
 =?us-ascii?Q?INu/d9gAy3xTLpEZbuo1OPWdy1wWlqyyc3oiTDBZjFTBqHAjfoeQ0XZjKRfV?=
 =?us-ascii?Q?mo9h/7OgH4FgLga/n4UViECYXavm3WrCxA2P84KGxFTc5Z9+RzplOvvkl+1k?=
 =?us-ascii?Q?m8sU00mepCGkyIOqB8cztGyr8IP0EJHrToDFAU2ZgGX6sxXEi/0cnfQa8A9g?=
 =?us-ascii?Q?0z86Nefna7hvcM88bfS1nfUH7i3kuTQc0oSuhosIPIHdZmomALnrRHTGdVpC?=
 =?us-ascii?Q?Sug65KShjxzPgFn39Ka9gKNcADdOWBtOAOQVqU8/LOg5sDvjVadNPkJl9oER?=
 =?us-ascii?Q?kDyT0I/Cvus4ZSGjkbDEDBkNrDHH+BP6+g4OJPwtzMn+NY0+R+1KCoT9f9u+?=
 =?us-ascii?Q?P3RnRtd73rEYpEbDwZmzd+rmmkEa5TbdS2g9w9Qj4IW/zZSzwWUIcj7ihKDS?=
 =?us-ascii?Q?biQrdJI9u/BH25ishUr3zH9H3CVb0OLkX/AFEoYt7wHi7c1m+iuLW00oPz5U?=
 =?us-ascii?Q?GKUygqpkxN7KWb1Qq5gZiotkQlLf6CChJMLy6nyY1ibgI9WFaPVK9qKPO+H6?=
 =?us-ascii?Q?o4sPTV99ediRqcvbus67JKo+dZA3HnGTHHvOfm89lxs89RmR8NJTdnfLfKdJ?=
 =?us-ascii?Q?leh20DgQY=3D?=
X-Microsoft-Antispam-Message-Info: vZ+gmtSp6AibS4yWpNm52LhVvoAjB80FaulA3C5TTsddsq9JM7/zqwjPxai1AnpB4NTpRg6EWkP71nja7RpFLb2dpPgFFURQR0x81fAEtxiq/jK9MkkSuPNQ38W0Ld9kEZIv56I75df5uVrWwUxdXsAcx72ot9KVxUmk+vB8elQq4VYtjp7UTRISRW/O+U7vcQu2OREnQOyLRCA9B+c4IK1J+7IOB+XlbecSmeilA87dUnRfXtuzo2Ptvah7erq73WFghu2CgbZ1M79Hzf+miPsTzMFJ2LuWzxU5GL71S/0H0AxdiIHYvkOb9dkyufn3Zs39I1lrwhTLx+3BTWuGktnw4c8Z7yVckP1SAwOK0I0=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB560;6:Qnrk0vAtEudfNOv20Q5795QcRcMA1RWPOZuSp1eaclNcsSxYhDBLfl/FV1SDhlzA4txBxCO5T75N1Nxpvp3CFd7XIgI/OV6+X2MODTnl5LMlQdij0rWcOWvc3/0tFQu+vFGdqea1NdWXUzfJyJJ3qXyJwyBBEBVR5lrPfCj6h4c0cIEne6KF9uAn68T/btRkgD75Ih5k0LZYtFmQgXouoRp3o4xyk5Ylkofo880OvOAFYBIWlsR36oYclXeVWe2JCTCzr4c1Qm9Z0Lxql8ejjn//e0IdbAvDHBi7I3b8uY+RbvDhafowYPz6EPfqmxJWnv+bYE1cLGgcvEbTxeGpbHBI9+UtE603f91O0j+3fytH/3Dk3w/JLUH7EarzwAfJSdDWTQz9LwkuiB7TWyphAShNdQ/5OctdKGnSE7aWK/j29CO8gaBzqbKT7YdKmQhrhZCG3oic97S9dneNEQcajw==;5:i7ngaXF2ppTV8iyCg/DgYyLbpEoL/2S8wZ6JC7AoSYKuP8srLgaFwzLkaiG1Sl3Ci6y/qZFwkuDUBgu4usWe9j6zrc1LR6Vc1iptFCkMXFGrOUJw6igOMbWosHaVPkc70BPEg9EX1E/BRrIn1xV33qv+w8gbyoHRGBJz+2cFU/U=;7:vcvd3ugPAqoLCnE6TKjiOwe3DTa2rTgdPdqt3zpxH+Ci58305tpX6TtxhAlkaG+isbUPX7iwS8RbCHNs5wSeInuDV/jwt+4MDxn0s0vvif2iA4ftfS9tbz8az4WN4/yErPl7wmW6dXHCaVDthD2O1ukPfr6Yl2tly5E82IxUk1HhTfQb2dx5RT3TrSGAfsrKeMr8m2wcrli/eqcvfm65huEVyBBk2/ZNYj3hwRDmvNcO3yoGul6HnHvjLOjKm33g
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 15:16:50.2476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72bb7cc1-6a00-4ceb-61b4-08d5f7c1ce45
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB560
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the device tree binding documentation for the ADXL372 3-axis digital
accelerometer.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- introduced all the DT bindings in a single patch.

 .../devicetree/bindings/iio/accel/adxl372.txt      | 24 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt

diff --git a/Documentation/devicetree/bindings/iio/accel/adxl372.txt b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
new file mode 100644
index 0000000..41493d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
@@ -0,0 +1,24 @@
+Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer
+
+http://www.analog.com/media/en/technical-documentation/data-sheets/adxl372.pdf
+
+Required properties:
+ - compatible : should be "adi,adxl372"
+ - reg: SPI chip select number for the device
+ - spi-max-frequency: Max SPI frequency to use
+
+Optional properties:
+ - interrupt-parent : phandle to the parent interrupt controller as documented
+   in Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+ - interrupts: interrupt mapping for IRQ as documented in
+   Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+
+Example:
+
+	accelerometer@0 {
+		compatible = "adi,adxl372";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		interrupt-parent = <&gpio>;
+		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 2ba47bb..c8dd09c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -548,6 +548,7 @@ M:	Stefan Popa <stefan.popa@analog.com>
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/accel/adxl372.c
+F:	Documentation/devicetree/bindings/iio/accel/adxl372.txt
 
 AF9013 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
-- 
2.7.4

