Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7F1C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CAC2174C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="WXsIfJMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14CAC2174C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389739AbeHGRIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:08:11 -0400
Received: from mail-by2nam03on0088.outbound.protection.outlook.com ([104.47.42.88]:2560
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388540AbeHGRIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4o/cTSrnix+hZq/D9IWJ50Dfacd09z1mQIbd86DHbc=;
 b=WXsIfJMJd765nZRS3I8AsBUywCxtr1qXrr2CMcCSbASD6r/vlE5x9aQUAk1ncpG/wjJN79eduFCt+2E+SfoFRO8W/vBYgWtbyhgKEVCzA88HbOGnZmT9YNCU6Ro6w1vvvSnmXf6j+uWTdW7ZNTAyiwUNBz9VYUg64JtJATmZBls=
Received: from BN6PR03CA0065.namprd03.prod.outlook.com (2603:10b6:404:4c::27)
 by DM2PR03MB560.namprd03.prod.outlook.com (2a01:111:e400:241c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Tue, 7 Aug
 2018 14:53:27 +0000
Received: from BY2FFO11FD025.protection.gbl (2a01:111:f400:7c0c::160) by
 BN6PR03CA0065.outlook.office365.com (2603:10b6:404:4c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1017.15 via Frontend Transport; Tue, 7 Aug 2018 14:53:26 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BY2FFO11FD025.mail.protection.outlook.com (10.1.15.214) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.13
 via Frontend Transport; Tue, 7 Aug 2018 14:53:26 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w77ErPrU017442
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Tue, 7 Aug 2018 07:53:25 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Tue, 7 Aug 2018
 10:53:24 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/6] dt-bindings: iio: accel: Add docs for ADXL372
Date:   Tue, 7 Aug 2018 17:52:16 +0300
Message-ID: <1533653540-24796-3-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533653540-24796-1-git-send-email-stefan.popa@analog.com>
References: <1533653540-24796-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(346002)(2980300002)(438002)(189003)(199004)(26005)(426003)(77096007)(5660300001)(11346002)(2616005)(126002)(476003)(356003)(53416004)(6306002)(186003)(47776003)(446003)(6666003)(8936002)(50466002)(7416002)(486006)(336012)(2906002)(48376002)(106466001)(8676002)(1720100001)(50226002)(110136005)(16586007)(76176011)(7636002)(305945005)(316002)(4326008)(51416003)(7696005)(36756003)(72206003)(246002)(106002)(54906003)(44832011)(966005)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB560;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD025;1:f2enRwRshevP5uUMvLycARKYdWQA0EekJnHyTgmpEBDsMzEOAyWB+MS3DXkd5y1zLulVfRGFBBr3AHO3NyS4EqplHKUBd4DyTOGwaBX7XDeeVmPuqImdhZGDjlM83jN8
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3eb82ef2-5387-4bd4-425c-08d5fc758809
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM2PR03MB560;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB560;3:V8Ti/TLd5MpUsPr6SwsA23BsJtEjvFcCTckn2DlAvypjaVLhNNoUthnnjU6HaQNEPTblQm0nJLP/0Rq22ruB3xeUKUOfUE9mnXiDIoZw45IuJhqYRJLC3kHOX5/rE4NejEmrWcrUc98eY/fHXHwf6sBHw7x8mVp335AYEu+e93NhJP0lMszGIIarsAiKp6qZ5Q5BYCj7zeNcwzJnNnbwWJEjYauuroZc1JOmM2Ircn6nHt5SrolW3YyTj7Gn4yijTVg+62JY0IJVirGYB3bufFqHFIozXYaueg+2hUHAYkEEXYup0mW/BKBEaQuQE7AeKPaaZpNs4agP2sy/64MhBWhgnlcOvxUDjyE/YwPhI+8=;25:JjbM67lEPo0pYhlcA0f4HxsxI5OcGYoiymHt+N73zfhmM3tc5OImPqh+HT5w9pJRMkqfHvZghSsKk24yIC5Tec6BOYCccBSOTwszYT6RBh7KTiyxrI3FiPHwhszPJHasDoiOIeDyHDjkcEWapW7cSQL78WqXm7vST1KxOJBNMYCHPF8uoFEHZyrEr7QzpjyIBt8+BnQguXVI3+H2ruCUdGgZ95wE6RTYq0WVAiEzRPvobJ/W9jkzQ0opvqA2NXUKETQxWQgcBATrZR7gaDdKYzuv7US6EE2dzLHy+DBnBwzeNuCBb77VfXkgDhp1mrmSX+Zgtzw7miIrwfqxUlgLsw==
X-MS-TrafficTypeDiagnostic: DM2PR03MB560:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB560;31:Ea9hGBfzFu260X9fGLGY1CwzOLo7nLzBMwaV7V65a2MkXZlc78ihVIKcT0Z1yd+T7p0KqlN+SW//35wmCbdSvDgK+3PFmxFsO80fZ5h2Xc9el+Uty45eOX/d7wzzB5ziczZUBrBVSpLswjM2FEjTNa5ykHqddQMLvc33Y45ISfZNDnIalW1elPFEolmpbROS7OQI9a8Cip1VuYf8bE5yZNYNCptUbFYgVq5H6r4bNss=;20:FR01EHLye2ol8yDhrYIjOHGfCkXSWoOWk2wOmOQ16hpYVGuTC6JkGoLvdfDfbXCxBK5gLlTFtGXZjX68iM5IoseGLshKte31PXoR+hRYcuE1LisoJ4WsSLoJNLOdp2u3olEOFJIBA7Goqm6ltCOnBTsvhUJjFzY/lut86ZJtZjh90hJUt0ixIOp85d0PtcWrsL5wcB2QNrfV2VAHjOYnkOABB5moVGclaVwXkmycASsHmQPog4NPjsJSnLy9rlnngCHX4b4h2LaZyTGSBCG9AB+K1tlNiUikDwqU/fWOzNFD15UzZTo195Q54+MM6ON1uKilTQenoZO/VRF86r5bSKNHQKfQlvkMpXriGbbfaX1qx4D7YjtaUpkENpQnkKvkw0f1X2AoY9LY/zcYndG1jQ0r/tY2v+bRDx059WGJbjwACmMY9wt0bAaElio9FYWJP88jWTHfbNGzwQVNxhaYyBSPi4h5QaWmwXqsGENRBDpEiqZMfP3vEVFDrEzeoyxr
X-Microsoft-Antispam-PRVS: <DM2PR03MB560B4C223666F90D41F2DE29D270@DM2PR03MB560.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(232431446821674)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM2PR03MB560;BCL:0;PCL:0;RULEID:;SRVR:DM2PR03MB560;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB560;4:Su5SYS5CQivbO02uVQ0c3310RBONd1w+BRzndmzgB+hpgdmlaDav9D3DyyuuSUCUL2dOYI/EfPbfZfs2YChsKcuNw3nUPKX8ek5cvKP1cJjF3nzw2TMdCucjn2oKgMnalMi6f4AXWhw+oKZP4ZiHlsG+rvbSLFrlMImK7peoAzh1Ne03KD1wvePRRPJxeWppjt4zW4B3r6uf97mFLERJI+ctbLpdeVsgw4AbQGzFOtcY+WZK9hsT21kPp9lTu9qcOnrbWGlNBPivJ/aEz5jmtBl7TNHlrShblktAjSwBauwLQdI2hm7jBatl4aR/TKjhe8WClBZbYZb3Pz0ofgdglgDt6VGiobIsvpwu2E05MmcZjMIGE2pd6xs7GtneLJO4
X-Forefront-PRVS: 0757EEBDCA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR03MB560;23:VfAPqvzjACZQyn3QnHpa4oiiU+xTtnDRrooQvut66+?=
 =?us-ascii?Q?H+BiQoJcKl7+OI9WiEgjoiXNJt2/7IZRs85xIzjm2JPB5Q6rNf6kXewu7vKo?=
 =?us-ascii?Q?aldPOgoN77iCAdMspCWLfE7KtBKhRtyuR8Xu6cjmWwSSu6FZBnjYQUYXUtTM?=
 =?us-ascii?Q?p1vPresToxGDUIck4TUMH+FLmKi1k6iOeotkmp76jzGqp76kSYQ4jV7Fhl2r?=
 =?us-ascii?Q?yzdUkXNtoPCeyswu0U3I0T1ootRaBSaCj35gOMuilEuHMxwuprm76L4KlYjS?=
 =?us-ascii?Q?obCCIA2dvRALxbvagNWVNRnOmvGmZjScCUwZnrfdlrYMsd4ArgvqU1GYYxep?=
 =?us-ascii?Q?8I80GWaVfxALXa3IaGBVRIDg1T6aG5BTBO9DTsSgnPEBudHq0JEzGlI2wIJl?=
 =?us-ascii?Q?z+0fq+y+dX6ATC1Sx9tp+WnMAfpBnGUam2AOf68QvEiocFcfveJHnKnGOnti?=
 =?us-ascii?Q?onRFTFrnGP0MFtHrWs0eJsrmVb6xTUy3v3lTq2kUjWNVyQwkmI1GyWXcDy4C?=
 =?us-ascii?Q?AIoLZx3e0OXLwrMeGLBgn/HfbPO4xHu0Un+rFOJxCHwpMTORYJWs6+642dB9?=
 =?us-ascii?Q?E9bZpwiPWafbp9B3eke6QFNiwitczIJ8kfTAYiC86poyAPt7zzvS+CGLv/8w?=
 =?us-ascii?Q?qEGWOIDNpPHCX3kkJw/LyNS/MLGjtAz3UZTyxnGC+s3vgcffvbl+wg2GKlgG?=
 =?us-ascii?Q?J5tsc7AlX/SkxyvuawN1hVZXaOXQ8FAYrTgtGzQuH4M8JsMhSFvjjGYC5q18?=
 =?us-ascii?Q?jPd4eQIKNqDzBrCsJyyUORoglJQeWH4dvR5YGsLG9QGWiVujr3wyqwKaoMav?=
 =?us-ascii?Q?BCAQ0+myXj9g2PDZ7izRJwlJmzvVP6F50wWNjPGOdHp+9LMRMxyr7d4VYbBB?=
 =?us-ascii?Q?AMi2VL2pMLKNFYsWVdeJJ76R5i2P5l7RNSV2dDN75SL20ILWlWnlmtVVzj6T?=
 =?us-ascii?Q?C8hYEeeCPDRkHZAo4aGnhBQ5mSOYLbYwh/CVZ/Z1g83BlJH3i/kJHb8Tj1Rp?=
 =?us-ascii?Q?p+7F9BvS+NQaP3dI7OIBrr4xhdqU1R1cESSDEBZz7UvpPG/8xcsj/Eht8wo/?=
 =?us-ascii?Q?s/Wz3e5Uwg3sBlTxv+B0RnCWBrI4WB1H2B7qyYva+7bGfPIMjaKAwDgnLUip?=
 =?us-ascii?Q?zp5lZTOskJAUGb0pbN/mrx/nCDmz68?=
X-Microsoft-Antispam-Message-Info: 0BkUFQlEh/8mEuqMDoJDKNHJSwXNAzMtG4y+0orPMy7KtRFllncCSjq6+cnh6rcdfnc2KSG+UGT612Ev20mEwzvtsbf5KdgvgEr7nIpSqkzpcdV7Ke5LZ7Lj3KVBAhPC/HOMTqqSjwMe78KQNGQwICLM2YcZmZ8xt25Kh8tkpt8ZIGZBaAK0ii7/Qb6TSbvpR5PV/cdHfIU6kgrck6eAZBiqgOC17/vs4NRrMin4Egq2elrpDZCR8mAyF29oK4aGLsozVi+Sfpr508ZiUybVUXjz2kZcf0qXUKa6AaP2AqtaSlgdd/A+/Q94ywNuSan+QxBRBKAMeuJYohhTIBNfDVOJFfSWa5R5yCofm5/tPdc=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB560;6:5WMe3L90V8nCilYNmbhbtoE031J4+CuCuD164KBSb3Nb6M938urVXbub3nzjhbcBRrEIWtDkXF2gAYXDg9dascA1L30ZFyQpimB3h2Tc4jjG7bPb2Y3BN4JN+zP2Sc+y6iabrjmji0tKHFxnrT0ayZifDN8pxBzoAVAQXUkLKYyQ+bqhgt7auEQub1KPMpmS/k9SxTjsYXCjhBGLAB6+ZoUYj89xudnMO+j1xVssp8kykNsXUIeR2rfdR5DQfWyytzMLuJvlY+U88oIVX0deEirjnfARS1JQolhQ8qh8PcGS20IxIuWXpKErgtbB2hEr7GDOjJKDk9ozCteCo/hJxcGxsg2BTSl1Gw+YrT4z1jYd9qmbx3vvFZVENDXnIuGbgtYchUPO1PJeFQR5DkTvkUcCuzHM+67DuqNKoHV3hNaAAbIQ2/yIX7nIozrp/daQPLWGhhkm6fsq+P8MjL9X0Q==;5:L6C+MjOEr8X6wXLaXaWcuf9/OghBdigAczYosxc4XaG2VFVynBF3o2TQrWUDcIMqf5y6CwIrAP4jnBtikk4rv1t4e4G8QIYeygMPYc81fQPsx7BYl4mgi1SANRdEuvMgCGLJIb/tP9o0fuy9kcuoSYd4uaPi5UVEjad0rHWa29Y=;7:jUKXcYFMdlijXVMAKI/9AlJNh9cpSTsD5eD6kUg41o2UdKKp0D5mFNut8fBqI5FujwVzN6VKXlzDEZK7si+FYYnrkAmvPQfibW310Sg65xCdIeKwkfKCXmU/m/nchNm0RY8ScGC9KxJGsuGfOHrseqKTddHjsnKejWgmdn4cnMGYp55+UdJa86ZVc6egHt5CyilsulMPw+Bj48oNgGp54dAv9Lun2ms6R7gV1w175+WqbJ4mlUqpQZQebCcVOar8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2018 14:53:26.2568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb82ef2-5387-4bd4-425c-08d5fc758809
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
 .../devicetree/bindings/iio/accel/adxl372.txt      | 22 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt

diff --git a/Documentation/devicetree/bindings/iio/accel/adxl372.txt b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
new file mode 100644
index 0000000..9409984
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
@@ -0,0 +1,22 @@
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

