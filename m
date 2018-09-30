Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BBFC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80EE5206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K8W3CbLw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80EE5206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeI3KI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 06:08:28 -0400
Received: from mail-eopbgr50082.outbound.protection.outlook.com ([40.107.5.82]:43136
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727436AbeI3KI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 06:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cCRkX2Ud9k3UpCOh8Rd36jOqN9fw+tyfW/YUuw8uRg=;
 b=K8W3CbLw48OHxK5uPYXs5tdvREh3k6RY/bqBYyBNagGAOCOjFWeGya6VJAiZLRkQgWFQbw4iMf5XlX21kO1pFALRs0cT5SAe6PCj/yCLYHCJfrgWfLwtbOfMp7/EStHBoJcS5BYdll7qupBstS//MbH/MFOm6up/bFgQP0aVvIg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM6PR0402MB3909.eurprd04.prod.outlook.com (2603:10a6:209:1b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.25; Sun, 30 Sep
 2018 03:37:07 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux@armlinux.org.uk, ping.bai@nxp.com,
        Aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 1/3] ARM: imx: add i.mx6ulz msl support
Date:   Sun, 30 Sep 2018 11:32:26 +0800
Message-Id: <1538278348-7716-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538278348-7716-1-git-send-email-Anson.Huang@nxp.com>
References: <1538278348-7716-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR04CA0023.apcprd04.prod.outlook.com
 (2603:1096:203:36::35) To AM6PR0402MB3909.eurprd04.prod.outlook.com
 (2603:10a6:209:1b::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2591ea3-8e2b-42fa-fef8-08d6268601aa
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3909;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3909;3:OoHdk7DZv7SqURRaDsRzEKyOjFmoiNPr18TWGrhFimsiyT48caRDjMMABuNhan1V0q95Q6AddarINIQ5Nrvrk3NhVBaax9v4tmLSOnM+CBUVEpBHQlFCTNoRYVbMj7PO8R/2gJGtTDWytwbcO0jOaIkvZ1JhmVSvBObTaEV7pgeMqCzxGl7p/bDWUZsA68rYyF/hHnz39vQWm1e765KBUjJxy7ClRv8MaxyayM+SLreylgsOxXBOzaFyCxsHrYh0;25:L7smpHEV2M5F+EizMWMh8M9p4ZW+ttwB57itjv8p4Prt3H/kw4ZpsPLHVhrEJW5iYQnlNepX5KIvtE5uj2IyiIDKuZ3eDR8+3mcZESTdo8giCixog8jMHtK4XtFQ6QY2OWqT/t82Wx9FgxieYpX46vG34UlePyX4ivz9PRr/DRuuXi9GbvwRWf13fRYJ1sIMm7WGPuA18uqU74ns+rR5ayko2KqPRNl4KosSEaXS/A+7Zupd1vXz1RrGKpwj34hG4aVcwDPq+FWj38YN1Z7bYuukzF9JlFACF+91f+lKSO4x2qNfXc1tDTapWgvU4dPfCWEA9CKIos6PkJdQI2bh7Q==;31:fSJgaFWS31DAKpTk1tkJNnia+Ft/JedsxcvC/cKNK44wBo4kDCAJYDA80q3cKhSj/xWiTyZolDkzUCCN4lUSRkY66+SXDwzJXCE3nRq9krfQ8XIKVd/ac//SNGRCntXwAkDj7irWpa2pT89pvgl38Cd9vnmRwPRJfBnTURJfEtIsC4UPF0fHKwy4E6eLhkfp9uluwCuF2AYMk/PI80kB9G865qmUkS5SLpg+MtFZyQc=
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3909:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3909;20:DkjK8hY3g7I3yd6PGHnGpnkcsYZ4tYCZtre+7OYY6etH1OWG2CwwV8xDOOn88IfB3xLaJ3bih4dWIfjHeMLC9cvtusJFQHUyf2W9yPssffXHvbhRiVIN+lsBAPmAScrNNArcTOkbkXGLuInN/tgtXg21w8IepctyrB4npBxuBwldZ2slWGbsH1SzIk/kJh6E8LhE+pdot7OlTTP88M0bCb4HqxJGru4knkJVBP4llEK8x+Ihzawnurn/IbXHwk2gSio2r4EhfG3eXd63FjBPTke6R3fBjPJ/nJitD9IcL6FPqVv/kB8UVnH2MiTq/g1y/fiy4Rnkrrk6Y4B2xtpDlbLZo9tKM4WqjAozd9E+qM3rAy/cOHagjJWd0NtpZCI8dT0aXWZmc1dzs8TrbMCCItHTiMOcI8jDg9fNKvZv/omLIq6mXKS5JSUlnI/bDLX0Om6G+TX6veTDD7XahOk+EpMNHrJKYU+T5Pwk2VBppET92cNrmhC0v3DbHDRmts21;4:9f50/dYOWre7CnSczomhgSr49C3wNUwCXv/WyUkJzwAHUKSA1sKCzAKu7p1Ub8mHz6VwO7i1JB+YyZwNHPbSvsqddKaDIA8og/AYDvQSrQYlZrXf8DVFAdROD12VyVcA1Zk3Y7DJFEIbPeiLwTQO3gVdpFXznhuGUT6z/V5BLN9rgk3hXXFj59yFnVA08g/sokQW36l6NR3Go0RyEkVe9IGwFl4HCOGvE/Ctg78wdihd46gkWnY6Ea5zrXz/yeqkIaa1UnJ/gpQvjJwX+2w2H00qxZCxgPcmct8cpB3eQZgB+TQZ9SIGLEGB8ih/niER
X-Microsoft-Antispam-PRVS: <AM6PR0402MB39099E700BC86B1D99A4ABB3F5EE0@AM6PR0402MB3909.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:AM6PR0402MB3909;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3909;
X-Forefront-PRVS: 08118EFC2B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(396003)(136003)(189003)(199004)(86362001)(476003)(11346002)(446003)(186003)(26005)(2616005)(956004)(16526019)(81156014)(81166006)(105586002)(486006)(106356001)(50226002)(34290500001)(23676004)(76176011)(52116002)(25786009)(4326008)(8936002)(478600001)(2906002)(66066001)(8676002)(305945005)(6486002)(47776003)(97736004)(53936002)(2870700001)(68736007)(6116002)(3846002)(6666003)(6506007)(386003)(5660300001)(6512007)(7736002)(316002)(36756003)(50466002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3909;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA0MDJNQjM5MDk7MjM6WmE4MkJTMUNQRitBQ3JYdlIzdlovVUNj?=
 =?utf-8?B?ZkkrNjlXMFJES0tlaU5YSEhIYlNPVEhYSStVT3N2SWdYT1hDaUE1QVpXWlBE?=
 =?utf-8?B?U1l3TFRWT0FmTHcwZ0NOaUZNd2xuZzFzV2xKU01nZWZHRm15cmROYitGd3VG?=
 =?utf-8?B?djBZbTFCQzVrWE1rcWhscjhXZXRlNXJBLzZHQUtraW94d1dwSWIzeEhBbmRh?=
 =?utf-8?B?WG9jandvWmg4NnhYNkI3NTNJbEQ0eVc4RVlHZTBoQUd5cXlSOGVmWC9YVGRI?=
 =?utf-8?B?ekNYb0laOXhya3dPMXdnRnZtS1lNODcrRkY3aTBVVlVYUDJMclZGcU1KcDZB?=
 =?utf-8?B?azgvbWF0NUdqbGZBTXJpMm13MEVFcEtCakJobXhBMktOLy91OWJJWjJIc3R6?=
 =?utf-8?B?Tm94SHEwZnRST0RraFlRRm5jRG1GeFY3ODZ3NGsrODQwNjg0bTh6TXgzU0o3?=
 =?utf-8?B?WTlhVVFpd2FJV0lZTGt5bGEyOHFFaFpyRnNUQ3plNHEyVXZjaXh1cEZRYUwx?=
 =?utf-8?B?ZTVhU0tYbEFFc2JSU2tQTnBRSXh5Y0hENHFPS1JidlVuNlFTZDdySHZBMDd0?=
 =?utf-8?B?bWhrNzFKdG1mMFlaNU9xenVkZHFnOGxQS2xlT0F4RVROWm5vRGdjcER6TTZX?=
 =?utf-8?B?VCtZZEFsb0FrUmd1RUNiWlRFdmFhL2g2MkRsd25nZllSdGZqckJ5OGVLQmQw?=
 =?utf-8?B?UVd0K2tLMEJDNHRhQkJha2hPMlI5UzNwcEhDQkFyNWVRcTAreTQ2cTIxbEp2?=
 =?utf-8?B?ZkVZTDhxMlcwME1RUExVaDRZZ0pHcks5UU9nOHVvVmpURTZxRmFNZFBWczZG?=
 =?utf-8?B?SFpPOHhGTi82S1Nkc3dNbHNCZFVrc2tDcnZJa2hJVThVY2R4eWJrOXZ0SS9p?=
 =?utf-8?B?dURoUkpYT0FBU3VlUGlNWG1sWGR4SkNSMHl3QXZ0YlFDdkJnSDlYOUI1cWFT?=
 =?utf-8?B?VHoxTGZnd1F5Q2dYd1ZSbnRjVi9uQUxrY3RDVEVFYi9IcndiWG5QSHl3Uzhy?=
 =?utf-8?B?M0puZE5DSSs2blYvTHdOS3puWnIvL3lycVRjMWRrcS9jVC9HNllPOWNVeWYz?=
 =?utf-8?B?a0pxK1dPMGRxbEl0UlUzY1dmY1ZDREt4T2EzQ1lLZ2h6OFRta0s3NmJsQWRH?=
 =?utf-8?B?Z1BjdkdndnVpWFQrU2FscVpsNzhncnlYK2RBSnpiYVhrYkdseGVTQkUrUU5T?=
 =?utf-8?B?ZDNBaE9TSkZpOFV0dFNjemFUMmJVRFFjUHNkWE1pRUc1dUJMaHNNSWl3ZkdZ?=
 =?utf-8?B?WHJQdmhobm1EbFpIZy9Rb1Jvc2JVWTBCRk83UVVjOU02UGNzTmluRndvNEc4?=
 =?utf-8?B?bmo4dVNtR1hTcW5YZ0h4U1lEckdXUGl5eWxpVVhUdUZmc3Mwa000M3g4OWM4?=
 =?utf-8?B?Nm5KWWdJTm9iaDhWRUtBVjR3MFJONGFEVHF3WGNRQVI0Ykw3SU1Eek1MOFhX?=
 =?utf-8?B?QVl6MFZSVjIrTW0vdExSQ3B4ck5Xd1Npbi9MU1hTc0hTUkJMM0dIR3hKWHA3?=
 =?utf-8?B?WDA3TE5QSG95YlhBZldqOFV0UXFkczJpTzdVcFJsM0NkTXFDcFNBT2xXSmFN?=
 =?utf-8?B?Ukl2RFpkdVNrL3VrdDZRb2JBam53bWJoSnB1OVg2a3M5N0FJaHpYUWJNN3dU?=
 =?utf-8?Q?Y=3D?=
X-Microsoft-Antispam-Message-Info: GmDZemkkcIH3F8spWgWR7Pi3l260ZZKkIuiEy/auOw8orQ12pn/7ygequN9gt9k36TzkjxH8wBiQCJes+Wy95zRkkwpPQ8iJ01KGtr9XF7+8uN69v5n2hOuwKe1kZQnlZp7I55TemhpVGB05O+tZVUK+mGUQ1jlGWhyCSag0Ae4RQSHfDIB/XD14003SeXZCwKRFY82LWwEVbIGVQBcTcUvXZwHYn1utBTRJTJrNG6/dUM83N9PYgX1/JrmMU15XE0YjCLEDsooH/TcKwPkfMDs6kKMwQfGqvyTQWOxu9Xxur+0dSwrUQPxwUQi1/vRc298idXKWf/EJQoVYJciAgWqRQl7JK+kgeNRPCXiDJ8U=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3909;6:RGdGwze6xOEwRrQCjlYQEc8fMPFWAC+KuWUaJmb3nY/62si4EM0SwpNga4Qa2Hd0qvFf3764Tq5NgCk7DPITjnuD/xt2Cshj48PQeVC+XZPg0HPKT5s24988YE1uBIPdAznFVb/QXsGXJgsjNwuDjqfmVYsx6CnCueIrUqwrmKHVTEOvQZNEYKfjhyiJxVglxkCg7n0UF7O5bY03sryxUEJxZI/76JozWr/TbayaxzPynDraCXzZJ5uRZjiRBsrQsoLdvQ9kMMAGVps1eUtTY+SnaElq8P1tZpyQgBqnw/56rjEBY+QQJYTbe6Wqa+mfxxSKVbcKuJX0o+wtfHrCFaMaKgBzEjhgzkUecYLKpN/YfuOWjbyYW2NH94F+qqhdoHv6rO/NrOTieEsv4fE9rI4eggPzp8xbAdXLsrSnqaigUW0ZcbMAa2B7Xv/N4nlI6mZu1S6NuOzypHax5fOMXw==;5:9P58LnCZpOXCbDAGUqprsTFEBdq3dljklGah+5Q7OqRKqTQfSQ1ol1a19LgjrWDQWwE2gJqH/e88kQS5CbLWdub45WZyURk0Ydu7aVqJLdCON5v/6jasQA7IN2E0+lJV8iDB3Ka/SAQQMpIIlBR6ao3gYnEFBZQmbij5dxFEW7c=;7:YQ+AHDGExzXasmibjvnkLU53xDUX7Lj83F2Dsy1y2Jow+VH+0mNkQG+Crl45HRj7ZHlzlE6HywRfhxCDLckB7WZVUABWpTYiaCe3iSfg/r88P2ZIhXu2JrzWbbRsJUAydCBLCB8CvSTOAQdaqBWaYfOnIPBSYaqRUckNU2zjRdWiAle9zKF2XXDK74FxRHLSSGFeSyhoTUIWqZtvntl+t1/THiTp+xvkxg6TrsTQzOMAma/6NSA50Dkn1gmEiPFg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2018 03:37:07.7043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2591ea3-8e2b-42fa-fef8-08d6268601aa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3909
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX 6ULZ processor is a high-performance, ultra
cost-efficient consumer Linux processor featuring an
advanced implementation of a single Arm® Cortex®-A7 core,
which operates at speeds up to 900 MHz.

This patch adds basic MSL support for i.MX6ULZ, the
i.MX6ULZ has same soc_id as i.MX6ULL, and SRC_SBMR2 bit[6]
is to differentiate i.MX6ULZ from i.MX6ULL, 1'b1 means
i.MX6ULZ and 1'b0 means i.MX6ULL.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V2:
	remove "fsl,imx6ulz" on kernel side and add "fsl,imx6ull" into DT machine compatible
	to save code change on kernel side, as well as clock driver.
 arch/arm/mach-imx/anatop.c  | 20 ++++++++++++++++++++
 arch/arm/mach-imx/cpu.c     |  3 +++
 arch/arm/mach-imx/mxc.h     |  7 +++++++
 arch/arm/mach-imx/pm-imx6.c |  4 ++--
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
index 61f3d94..45d618a 100644
--- a/arch/arm/mach-imx/anatop.c
+++ b/arch/arm/mach-imx/anatop.c
@@ -31,6 +31,8 @@
 #define ANADIG_DIGPROG_IMX6SL	0x280
 #define ANADIG_DIGPROG_IMX7D	0x800
 
+#define SRC_SBMR2		0x1c
+
 #define BM_ANADIG_REG_2P5_ENABLE_WEAK_LINREG	0x40000
 #define BM_ANADIG_REG_2P5_ENABLE_PULLDOWN	0x8
 #define BM_ANADIG_REG_CORE_FET_ODRIVE		0x20000000
@@ -148,6 +150,24 @@ void __init imx_init_revision_from_anatop(void)
 		major_part = (digprog >> 8) & 0xf;
 		minor_part = digprog & 0xf;
 		revision = ((major_part + 1) << 4) | minor_part;
+
+		if ((digprog >> 16) == MXC_CPU_IMX6ULL) {
+			void __iomem *src_base;
+			u32 sbmr2;
+
+			np = of_find_compatible_node(NULL, NULL,
+						     "fsl,imx6ul-src");
+			src_base = of_iomap(np, 0);
+			WARN_ON(!src_base);
+			sbmr2 = readl_relaxed(src_base + SRC_SBMR2);
+			iounmap(src_base);
+
+			/* src_sbmr2 bit 6 is to identify if it is i.MX6ULZ */
+			if (sbmr2 & (1 << 6)) {
+				digprog &= ~(0xff << 16);
+				digprog |= (MXC_CPU_IMX6ULZ << 16);
+			}
+		}
 	}
 
 	mxc_set_cpu_type(digprog >> 16 & 0xff);
diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index c6b1bf9..c73593e 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -136,6 +136,9 @@ struct device * __init imx_soc_device_init(void)
 	case MXC_CPU_IMX6ULL:
 		soc_id = "i.MX6ULL";
 		break;
+	case MXC_CPU_IMX6ULZ:
+		soc_id = "i.MX6ULZ";
+		break;
 	case MXC_CPU_IMX6SLL:
 		soc_id = "i.MX6SLL";
 		break;
diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index 026e2ca..b130a53 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -40,6 +40,8 @@
 #define MXC_CPU_IMX6Q		0x63
 #define MXC_CPU_IMX6UL		0x64
 #define MXC_CPU_IMX6ULL		0x65
+/* virtual cpu id for i.mx6ulz */
+#define MXC_CPU_IMX6ULZ		0x6b
 #define MXC_CPU_IMX6SLL		0x67
 #define MXC_CPU_IMX7D		0x72
 
@@ -80,6 +82,11 @@ static inline bool cpu_is_imx6ull(void)
 	return __mxc_cpu_type == MXC_CPU_IMX6ULL;
 }
 
+static inline bool cpu_is_imx6ulz(void)
+{
+	return __mxc_cpu_type == MXC_CPU_IMX6ULZ;
+}
+
 static inline bool cpu_is_imx6sll(void)
 {
 	return __mxc_cpu_type == MXC_CPU_IMX6SLL;
diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 529f4b5..87f45b9 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -313,7 +313,7 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
 		if (cpu_is_imx6sl())
 			val |= BM_CLPCR_BYPASS_PMIC_READY;
 		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul() ||
-		    cpu_is_imx6ull() || cpu_is_imx6sll())
+		    cpu_is_imx6ull() || cpu_is_imx6sll() || cpu_is_imx6ulz())
 			val |= BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
 		else
 			val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
@@ -331,7 +331,7 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
 		if (cpu_is_imx6sl() || cpu_is_imx6sx())
 			val |= BM_CLPCR_BYPASS_PMIC_READY;
 		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul() ||
-		    cpu_is_imx6ull() || cpu_is_imx6sll())
+		    cpu_is_imx6ull() || cpu_is_imx6sll() || cpu_is_imx6ulz())
 			val |= BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
 		else
 			val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
-- 
2.7.4

