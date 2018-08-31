Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0109FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A2720661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QYVCQ8H9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A2720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeHaMEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:04:23 -0400
Received: from mail-eopbgr20087.outbound.protection.outlook.com ([40.107.2.87]:7989
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727258AbeHaMEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7fItFfYhljHWMfhdR4Yc3DVEtT93whZXnQ5B/6/Hz0=;
 b=QYVCQ8H9eV1yi9KX5dSUQ6yUmnuCfu/GhuSpXpsjGRmm98eYXYpDKZzjMa5GmP0xYG8fZnfJrl3aL/5vqPXBlqYqCFiQG7BEYD0+IRHFCJjIIP3u+/lvdcuWjlAvtQl1S8szjEcO9uz65JIOgV3h6wV/XnyK/ce7sjzVdoLW3MY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM0PR0402MB3907.eurprd04.prod.outlook.com (2603:10a6:208:f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.17; Fri, 31 Aug
 2018 07:57:59 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@kernel.org,
        colin.didier@devialet.com, clement.peron@devialet.com,
        ping.bai@nxp.com, aisheng.dong@nxp.com, shengjiu.wang@nxp.com,
        matteo.lisi@engicam.com, michael@amarulasolutions.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/7] clk: imx6ul: add mmdc1 ipg clock
Date:   Fri, 31 Aug 2018 15:53:13 +0800
Message-Id: <1535701998-20443-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
References: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::25) To AM0PR0402MB3907.eurprd04.prod.outlook.com
 (2603:10a6:208:f::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06567fef-d57f-48b7-6ca6-08d60f177ca4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3907;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;3:hSKbpe+40Rzxoh1agDEOKj9bggVsscdpq02T5/ij/w7j0UCx6d3hY7haBwyEwRgc87CScdsCSsXhAU6m+KybHORotm2py5qZCO4q7BCIb+aYA9RlIw6IYRdK1wyFLDO5NYzaZ6iXFtypHTrbHw2PMM4y4yN8hJDiscxgi8K93i0FcwwnJec0Bz5dKD6MX9tRtCU0aabL4QhCWxLXIrqtR1MWkG5UsKWHAD+hLDcIjGlch5QVDWulxnplZHQsPQm9;25:ZBY23xxHX4yr04CH8i/nIIX0ccugm1gZhHuTQrPtio1eIz4zU9oZ6EZgpxfBC1k6s24wEhAVAkgDwCD/JGL9o7mvLXIwjJM803YEZsAxg5nsd75lRO1cW3t3FIE1DbsKF2n211JAv0D8OYCPtgFqQ/Yb+A0x/XtG0w3XYCKtzmZlM26FmCno3h0M7BBx7ZnX16t/HHd8IN8/N5s+OiVPGufQFMzYcvUkKstzixjr5xAI1G8hDYrb+U8ec4HdHJCxP2sUTFZWvrRMRJhmeWt+LkAzFCcAclxh31z7KcGWD6SJqma5R3xzesIh7hk4CUBUjvEE/nNE0XjYk7qSCm7B4Q==;31:uTbWBVfam1OUNq4rAxxj31PCCNqg9z7Z2494lEEVr7yBcEhVllj6UwjQLAvmZSKZGVxBaXOlMBIA/fcp9LUAvpnOIxeJmYlOCKkX2CgCngZljQz6RjTE85q/UXVnV9aqMh908iqNLw6e7DEFd3hv5JSlVYs1a+jGYhoOvfHOGutUw2tr3SeZf67RI8LLoEsjH45/GpO5Yx3NnoqNVvoJXRtxpYH7SYfDjdbHTla0ckY=
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3907:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;20:wvFLgrOR6NCWAwvi42pTFcy/sGn/e8Xeab7o8tHf7YmZ7nzgfmd7Kree78StNk+eIsvkNiiBdjVMmumGLYOoTAT/5HPDLmAjupphzXEJ8G+Je07mpohWggwsg9F/JzYRh0QSIX+BIJKzQoEqcbVtcvkNH7vNeKe4bBgRAhKn6cyI7CppxdCHW5DSbiymRT7u61E9Qs8b/sROpW4UDB9JHLuo9h8u/V3Dqyn0SQ95BqQbKAqCU7j/Qauq6DRpFvMmh+An8HTAw5Fnk97HWwGpDLUEw7qMRfr029fB8CLF9Um4TpxR5vsGKTSP18VEemkktqt1sjvRqxlGpMzpZqJe4+ZY92BMnSctNzd65ewA26RN8VmOJ+RNi+8o8CvtQJHgzjsb88T4Hv27MLeG15ebT8nbL2ysQFucjGn0j9NzwKgIPZ+tNXfT0LY4KLmB/uwffmwYh9OxsfZVRThNtkjJOQyMIgeZk0JT2k/c2fRLBw+ENZc2LJl1ShoXErJPoruO;4:ObIcRVNarNBrYeznPiKOKlRzgYB/ZrT1vQyulXx1E2+z7ds/CMjdpOIWhpXvWqGHZHfneQXoGvE/KSpvY4DlnMHmf/O0oW4ok/YfPXc4xF4QoyxMBnPT0iaDzRmSl+BYSNT5dEmwCZGziuY+C2/wVskK+Zgu7KoPybsNv2S7JXv5b4QOxef059D++kstgb1FYIGZ/SflPdQpUVb74NUpv5w4tU7EgdQrtQURC55ZDP5ZpHp2gfktyr2lOuQO9mXj+2OJztHWJVxy4fFhpQyiKPcATCYTO1aBocTD1GkU0E8GB8kyUUxEcUx/cX0vQ7RY
X-Microsoft-Antispam-PRVS: <AM0PR0402MB390760C4C2701D6A5C0EFC32F50F0@AM0PR0402MB3907.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:AM0PR0402MB3907;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3907;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(366004)(346002)(136003)(199004)(189003)(106356001)(105586002)(86362001)(48376002)(50466002)(76176011)(478600001)(51416003)(52116002)(316002)(16586007)(25786009)(2906002)(5660300001)(305945005)(97736004)(4326008)(386003)(6506007)(7736002)(53936002)(50226002)(186003)(16526019)(68736007)(36756003)(8936002)(6666003)(26005)(6486002)(6116002)(14444005)(3846002)(6512007)(66066001)(8676002)(47776003)(81166006)(81156014)(476003)(2616005)(486006)(446003)(11346002)(956004)(7416002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3907;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR0402MB3907;23:itasllsvP2t63gFs22JJcl8I9UhvzCQekp+92PT?=
 =?us-ascii?Q?XbpSQWW2ytm1tUmQxWCnXQrwuCbnZR9MbfkFoRHGdnvx1FND9jzvAKW8iI+O?=
 =?us-ascii?Q?ZlVST+WTE13m1Up3LfQNozNPvAKcQnQ9AUNL+DDRDleq3NgJjlRrGkpyW/mu?=
 =?us-ascii?Q?LrKUdveJtvfTrcS9sX4ogabCg6u760e2nXGuM/xts/1d8KDKW02dF1F92NcK?=
 =?us-ascii?Q?xxTcMcJRHt6NCNXbKg4Fbtvu7H5jpKUKVkOtLEgkIFGIKZxbHB0CaCWCCJ6U?=
 =?us-ascii?Q?aYnPH5hpHTibprya9CDmDiNFPu3/cII3HBnWR2kygMDkC/wLFWGA1JGM0yXn?=
 =?us-ascii?Q?e5iIre3vNiEYXhKn8crRtA0j5YYcuZ2+PPPvW4I+w7q/itSa1NCc3nqG4471?=
 =?us-ascii?Q?yyPSWNLhAhQAaJ3bmvbDv/A7wFfbTpWF2XCf/dlqoeAW/M+cpS7qGvpeR6WU?=
 =?us-ascii?Q?ihZgI6FL6hPDCtTMjDYzWtGr2V5+mxGstpQQAWn3+IzKAfceeriZG15FWK7K?=
 =?us-ascii?Q?e7aLIZUOh17dmxMG/wFQopmF8DW7od9q+z1h6MYu9f6eXC1FMS6u0kD7pcQo?=
 =?us-ascii?Q?a+fFoqvVvglA/jXYMmPKd8wOvUTsjB/O0urWpieg2p4mJiEarodiVDwziQv1?=
 =?us-ascii?Q?FX5VpXEFSEvegaXEYfl49IyKwPGgscDHSK55pajOHUlZaeRrwNCxPOcgIm8F?=
 =?us-ascii?Q?SSzpf35IO4X9lqTHXikSXj5wvrNxt7DxlAnz5IBqAvuAnjgrRR142J9T7Wri?=
 =?us-ascii?Q?RzwUdS228VSXujwAIQcS/mY3wNhIFUhFO6x8gOWKUqyFG9actpfGDP9ejW09?=
 =?us-ascii?Q?9ge77h8LhpPJnnpqHuhj5ZoCctORUA+VnFXq1qazusHOWlplcLmtl/yxVJBP?=
 =?us-ascii?Q?4C8Tr4DguN6pPJfZeTFjVcKPb9wpfuZWFC0wdcCZTIaqWAEPi5+mFqoLAa0A?=
 =?us-ascii?Q?vhPGdOyDNghij3JJHO5c4ik9g3bopuf7wkTqMReQqjMZYnYfJUhUybEEsdrc?=
 =?us-ascii?Q?fVL8Kdmk0Ttk0bsczdsNCoBy37vxaeFFe5as96503JH1km1gIJ6U7/Y9OX4M?=
 =?us-ascii?Q?BSN0ZN8Hh6jYIfS6DJ+jU5FKv37mMCBv9NcNBZhliLhJuRvq6itOnV5wv5D6?=
 =?us-ascii?Q?K4kWIEA9TfIWdtj9Kc7Tfx0t2XGcXvZqteygJFvfmsAWRCDScVfHNO3TegyP?=
 =?us-ascii?Q?6ROV0qBTCwEKQuDQowq1awtZeVMzuLBco8UCWFEA4kLLjGQH3umHyo+Aex9Z?=
 =?us-ascii?Q?h8IugiewdSmKE2vLTmcM=3D?=
X-Microsoft-Antispam-Message-Info: Db6/30Rzy1a4VWWvI6nWb9dUxOnvQy1qkfCfHlCDfQHTPWtkxdYAWV6HCClT/0szPtaG+lib6FKsPawzMNqf8wOhwsoasUViPwMmDHMUitphUXz1X02l5ZRFo4sQI3V3xDvKI1ukTgAUISaH/jcvoO5Mv85JVnjnOmuMN0QfdHR+8tE0O1q4HzD2e+q+2EHfXVTcn/HyaCyt2QA9rQmd5fNxmyID2j12onC91THzb3HEsh1+Li238Z6/9jqoadwsqI3SBz1Dan+NZdekCvK3mIwjjPfy8nZwskdD68qfGGOItjTdWMjlvlp4l+/3xu+Ta+ZblX9y/zCf+Xtltk1lxEOx6DaKt/q3Aavk/E0hujE=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;6:DQOvMuUHbFNDG+PU8AuiuqgjL/yrDRAUDz2GoznIBwubWMakPARJdbFuEpzVZlDmbUoaFusinYoGdqt9xTWsOpaDx2iGdMTb3Qrk/CWACSDzc4ctEbBC4yy+o559rzO9a1OrB42+n6oghzLq2IJYBOhmoU0WE+HCdOoaT4B1dj+p05ZdUeyRKaADhb5PnCbsqdL7mUUXsEfPGqEL1+5j5Bo0SaW0dUn+YzvTQxg44XhtoRanJB5Lr6R7SvYBU7uuxjtm+d7TPHcUOPcD1t/t7oDxbLgPkQziGjSVXTnukL2KmGi4r9fk3wJvHzOacb0Z9uQQ2IPaotuYxcv1YeMzsgnIV5qSMPoM0Eie2xgQRk3Wrcd+nCIvsZzI8LEeEAji3zrxht1H+sRiENwtSBE1HPYVQwejLdssv2MOpi+VGSiOr7duMADuVr7c85NSLiArNgmoPULyxbchc5YcUrxcCw==;5:fW0VOMSrTIiRBeOIMKYrDU163JGyHzG9l1NcDOJDzy/bnA/wHyyb8FgEdDQmAGkFMrBxQk9WztcUz79rAApKxGj+XZb0/f/ZOjnwIUj1QxupuEaUfvdwAjdryz+km3s0AMeM8Wt4MuZGYSxUUIUSpp2ayWn2lxe7H744k5uJRL4=;7:MVm3JNwJ/prWNX8MS7D/6Qt8dbYcHrojWUYtYdA8h+IgduukN5QSUbPuQIZrqORQLlqlkBXb2ezLQnDs4fQKUgYLj+w3AFFbpbY4q3B05ec0eqvZUoQpdItKfAIDSfhQK6a7ZKGFO8rhYvVOFEXDJtQODVgEXizIdxyE6Y0eLzGOwQ2qjHkjpTGRI0KktufPIYUEnYhCDPVoMIioy71mB8ppuYTjllItI5KvXRxFCPkLSTEt94M88M4S+Ipzlvvp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 07:57:59.7599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06567fef-d57f-48b7-6ca6-08d60f177ca4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3907
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6UL has MMDC1 ipg clock in CCM CCGR, add it into
clock tree for clock management.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx6ul.c             | 1 +
 include/dt-bindings/clock/imx6ul-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 361b43f..fd60d15 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -408,6 +408,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_WDOG1]		= imx_clk_gate2("wdog1",	"ipg",		base + 0x74,	16);
 	clks[IMX6UL_CLK_MMDC_P0_FAST]	= imx_clk_gate_flags("mmdc_p0_fast", "mmdc_podf", base + 0x74,	20, CLK_IS_CRITICAL);
 	clks[IMX6UL_CLK_MMDC_P0_IPG]	= imx_clk_gate2_flags("mmdc_p0_ipg",	"ipg",		base + 0x74,	24, CLK_IS_CRITICAL);
+	clks[IMX6UL_CLK_MMDC_P1_IPG]	= imx_clk_gate2("mmdc_p1_ipg",	"ipg",		base + 0x74,	26);
 	clks[IMX6UL_CLK_AXI]		= imx_clk_gate_flags("axi",	"axi_podf",	base + 0x74,	28, CLK_IS_CRITICAL);
 
 	/* CCGR4 */
diff --git a/include/dt-bindings/clock/imx6ul-clock.h b/include/dt-bindings/clock/imx6ul-clock.h
index f8e0476..f718aac 100644
--- a/include/dt-bindings/clock/imx6ul-clock.h
+++ b/include/dt-bindings/clock/imx6ul-clock.h
@@ -259,7 +259,8 @@
 #define IMX6UL_CLK_GPIO3		246
 #define IMX6UL_CLK_GPIO4		247
 #define IMX6UL_CLK_GPIO5		248
+#define IMX6UL_CLK_MMDC_P1_IPG		249
 
-#define IMX6UL_CLK_END			249
+#define IMX6UL_CLK_END			250
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6UL_H */
-- 
2.7.4

