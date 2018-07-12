Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1703DC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0E120C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="PUcp890f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0E120C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391170AbeGLCI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:08:56 -0400
Received: from mail-eopbgr690088.outbound.protection.outlook.com ([40.107.69.88]:49918
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388243AbeGLCI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjT4Y4jqsigNTllH0JnkemM3GlZS/3pcsKL0RroZavE=;
 b=PUcp890fppHVIh9+z0mzzyVvdirwl7gBUcknJooDeYD4lhbRLHji4gekHglT2kMyb60ZFPEMv72bVEvgu7uPnM5BwKGF/U8ekkd5uNUV+Bm9Jv03fA6JWYnA5W2wH7nQe0rQkQQbris1Q2OIYav0e9xlFrQRqOit9yP76KInO0s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY4PR03MB2629.namprd03.prod.outlook.com (2603:10b6:903:75::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Thu, 12 Jul 2018 02:01:39 +0000
Date:   Thu, 12 Jul 2018 09:59:40 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/3] serial: 8250_dw: add fractional divisor support
Message-ID: <20180712095940.20859423@xhacker.debian>
In-Reply-To: <20180712095504.4d9583ce@xhacker.debian>
References: <20180712095504.4d9583ce@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: MR2P264CA0023.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::35) To CY4PR03MB2629.namprd03.prod.outlook.com
 (2603:10b6:903:75::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6a9e9fd-3086-4696-79d4-08d5e79b6a05
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY4PR03MB2629;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2629;3:80/GG2y3RY7UR1vQeutpHW2VTidYZ639UQdcCtjtLsb0cwPrabiuQus09GbkJA/eX/k/ZJbFnNVtb9ife2DWG+6Y/9oNVtV74qQIAN7XRB9wXWLHSsL9rlC7KrhSHo0zQ/JgQORHwlBJK3wl9bMbmkZxOwdjQZhnjRdD0/iNDJjVVP4iTBQe75ECRg8pZl51HWlTcAqMHGhmHIGEGa9aycHwlagT2BJhMqU68lqE6M2ZxoOFDABg70Cii+03UZde;25:Vy0iaqGFGOFHxFlxShsb96d3xTPpo7y41vnb4b4eVmrU8EuiVKNCUBt/7bZ+luZX+PF9nXqt/MQbQi+/PSV5fmJvK36aSQXBlzjej9RucdrSvsrSU73e1VEpw0UisaP0qj0lcVeXTI4V2WBIuJIST+Ti5dViFvGQkfpfNVr34yI5hEijnTmQHC62IheZMnHslARk4YCmXyaI8eX6HsRSJluXN9Xph48bxHjtaB7SFL3v4M8wV2NgcrVNK6kEIb1vw7Kh0bqICjHtsIvzcRzxaSZ8JpVWldppcyYXeLpoZGwRNtZwTCo4s8MZOvS9DmkeezGfqyo+LDoe75XapP2m5A==;31:jS/HaEB2Ic+roF7fL0WJc8NAKR6EzAY82bYS0kxzwO4lKR4YxzJ8TA4WpFG1ZvWoFuHZ24zSmfHGCMZ05excdGScz38OxGYcQS22o12IaD3cm4KZtjk5Au5L16rXE/xh983b5CLyquND3mc5sIpcxMYMOJunA0aIAvkcDyYnhV7hVYmyjnsxp/kIoIIlpkDUWIGCtggNMxiJMMtXxO8/4LKL4JtOdORl8v5SrEvGmxQ=
X-MS-TrafficTypeDiagnostic: CY4PR03MB2629:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2629;20:L7qH5x/QmuxwkVy/dJPfrvGZWtwJo2q9P5HRBKXgID8CO9RB/0fz5Bw2Xt6QVLfsvaLcfolqqmxL4iKz3D7JSjV5WdJqIofGeTdjpH+T5JDKQ4oZaQKfOl6PkI1bFZ1R70Xq6Hy8cWV0PgQErLziSSjXKjRXFtjh+I7lxyWhnM3McM/YuSDOM+xHtkzgO0t+75/e6JdSSVIDq0iSU6NN+SVGmMx10gwmtb36kYmGgCXj5eJDgqPh1oJ0Yk0KBw/jl9iMYJPbscYCRx7sJA8e9+jliRMi7fMrvHO3qRERnEs3fa9Lf0LE3Lhgr85qOcurHLT4hEOANbHrUpZaIPKdYQVZV3OBjXW+ey8eTR5rQ67y7We7IauDybM/JNcbe5jboudJi9baBBQrjGfg9RVmcMis31v3OmyVaV/DCLLDeLi61bL2TbAJGPSSNmI5rCs2CEZz90eCcmFPEtjdJpJpVqGi0YbgNYKl0xs8x1NQOCneiSZn2Ot/gG9VMIMZHSaj;4:f6LD5wDpkG+ilIRtqiJ+8ibu++Hkm+T66z3z7pUgXBW2cfPex40JKiu96Z1Equ4oUMJzYv81j+HCauUdC5jTB+Gr07Nge4e719dLkrGdiTFeRWEj4zTBu+gKc9OlRX65HaPYME227yOKEeTfmcHbaFHCRgQjHoVqKxzKNDuvWTvK5CMiqU4alCuQvvu6xZhRXrtOStCtkQ/y5IyJx4X3yauXfiZ0p5U4HO6k2YpOeOZzDum4BYDBJ8CVK9jsKHnKHVRehbdjc1JdLUfi48XN4ZJZElIIctu7hsX4JvegLSviNEqfQKgWNR4vNOwXPYjJ
X-Microsoft-Antispam-PRVS: <CY4PR03MB2629D9895562A8176DCB4900ED590@CY4PR03MB2629.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY4PR03MB2629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB2629;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39850400004)(346002)(366004)(376002)(199004)(189003)(110136005)(8936002)(5660300001)(50466002)(8676002)(446003)(81156014)(81166006)(316002)(68736007)(6666003)(486006)(117636001)(106356001)(11346002)(956004)(105586002)(476003)(386003)(6506007)(230700001)(9686003)(25786009)(4326008)(3846002)(1076002)(97876018)(6116002)(23726003)(1970100002)(2906002)(55016002)(16526019)(186003)(7736002)(97736004)(72206003)(70486001)(8266002)(26005)(305945005)(53936002)(47776003)(50226002)(76176011)(86362001)(478600001)(66066001)(33896004)(52116002)(7696005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2629;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2629;23:KAN9UZBBYfHfkNot2S8vRrAiRAsiP+1IP+dQsKsVy?=
 =?us-ascii?Q?aRYNU0APWfJbthgQraWR3himBoaL2EGlG8C4xF4tKQojeTGfc17K7wfKS875?=
 =?us-ascii?Q?vgnkM5c/b3SK0qsdis0s6OGeAszt29aWz63OsO4o36m52xDHzKfqErE6Y/dx?=
 =?us-ascii?Q?CJyRa5k56PdLJqumciGXrjiHTbjQ0nowpV9mgakIX9xZJCLdVElkYXcO/Bdi?=
 =?us-ascii?Q?4JWvK9nHZX3MItYLoAyYuWBvPbGrFyPdpJOKnNpEApU6rnyvPNIoHCT0OscE?=
 =?us-ascii?Q?M5TC9M5Ui0JwNUQ4fLhaYJt9yHBXJK6b0H3h34XlPJQLH8zrKqtzvZsvtcvh?=
 =?us-ascii?Q?4c78O9MzCM51Bwq7QaPIKzn8Tctr+R1nHC5MDe+apWYKwEwcHiXfBtjxwIss?=
 =?us-ascii?Q?YLBFPRC74vnTtT4p5PWppWgsQrIwEVvyHaMsHihIT5fiiuxQK2p2iho2xFGJ?=
 =?us-ascii?Q?ZpzvGJUYmKmeM+4G/XPYaAS2Wc3FOjLds5cJUYbY2TDn+oTV0HPLnxswrQnE?=
 =?us-ascii?Q?DCOhpq3qmrACjnCmyVsaa3c2W00H9L/NXUHjhbQ9/Itb1NSHinwA/w1ODTor?=
 =?us-ascii?Q?u2gLSg6m3618r3XxnJEijAaM19darQTyTVQYwdFPt18+lgONqFHy+MjD6EvE?=
 =?us-ascii?Q?MIMvLXB4idyHD90GqvgG1lz8NHEQAYfvcB4SydkwPIiuG4CDmZ3bCdWoL+eS?=
 =?us-ascii?Q?G07KGdXeH52//3o5GEV2ZCx1wuHrW8833K66tZKvhvBNFOY/Nr5mtG40nPiP?=
 =?us-ascii?Q?3C5UgvBWbbIlUN7yc0VOkoAnMUq7A1ADMzxiOyQtoUrQoBWJkwK/czthG1Sm?=
 =?us-ascii?Q?sOhk/HFokBP0ySWMw2YDKhjvmlNU/u6Wi4Y16B7Abipmc+9CjJIHFeZCMFuR?=
 =?us-ascii?Q?LLDcmx7wyJf/kcQPYO0AxUqrAIDAeiKMu1aBTG7zucEtoHSUBqFZKxc4nTqq?=
 =?us-ascii?Q?5f1Eekomk+lU0py/jriOXD3t4vVhP7owFeMHNIo0J03MGAlWWi/n2jxXAClx?=
 =?us-ascii?Q?9LM+dyMd56QQB7e/Zt1B2LCm45HVn1c1RP4/oQYjrGRxeNwjysoshK4jwyTC?=
 =?us-ascii?Q?xs6BK05C0Y0BA38j3G59O6lmA1y3hyih8uvfQK3uD5mrV9tK95uqmHyzEy4s?=
 =?us-ascii?Q?XN4u2QbAe7d9qPuEGi81yS1TcJmYKrE2g4UCoNNe3/Su9T1TY9GqT4NPQb16?=
 =?us-ascii?Q?CfoKJA8i5J2Xrt8RdVAB+Lp80cpuyOIkS5f0GgFpduMD0PECr/rjosQOgFbe?=
 =?us-ascii?Q?CmYO0dRopHD4AMCGGoxKSX5mV5UbWM3KVi/7H5yLBYSoxQ4yqRY1UNDkR003?=
 =?us-ascii?Q?VlF9HeHy9KizhYPT/L8SUTx4IrpkfxP1WomCwcdojGv?=
X-Microsoft-Antispam-Message-Info: Sf7ZJBVqlUoPF1T4cUf+zJfbEQfyGXAnB3OUbFCtGXNOzrTJi5Z74gyM7QzJ01gWSi3dUa6t0/7xaG3UzNQ7+AQ5/QO+HBAhTm0xWTxPaNx7N07Fa+wZO8agMpX3iGyJwPSCkovGsZgvPJ1PFFBL8GjuaZ3dPIyx1Qa2l9o9QbwDURRD+sbBQt/GzpSOgsd0z/R4raRXFd62FB/yNaY+QO/Pzyq098NgOzINijWiQrHEtnrjFY3szvcKCrZoyccv9+3n148WLi6lNMKDcXvhQFM8auO+N1xfr4mLqtlOrZSq+QZkORaHK+DCSMcah49uSnNJVlYJqTKi9P/sBz8mWCJaFZE0oIDgLS69at0VOi4=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2629;6:PArEe8LqzUu9AzyKMWEaFUcR4vm1xasPs99v/tg/LEU8+cEdZ/nHRGyYc5czn6pXDXVMtKqk+LLv5wkpbDfyFSqkXfwXtQq+KmadqU5luHo7/VHNKa5e/NoWCu79Ovk3WGqLD4T/11PNcRDBmSllB/YVTRKz/kv5mcqeni/1YFCtDaEPjaQXUIPkpBK83MZmPAh/1lmbszPVboe/P35+mn8es17OSIfO3b5FIVwjTh4vUcsjd/v9ZizWTkOq8Xik8LUxe/LjT8Ae+SrxoEAGkcu3CHLTy0M/o51AQhx4jA/2kL3D7BOHsZnCYd5vcd0srsB7NC9um5kV30Zo00f7LOOs8LJ3BrwvK71bVBhQG3CA2nxt4D18NrXea5cn1R/gIFuQumNYiep77vXEPf3/qsRgHX6mwTYQ32ojf/7xAaecHuDG0wto5QuD32Bmc0LM3sL76BVkp35Km1hRfocTpg==;5:cC3n3Zj344ohpfkl4sclN5+y+aEcqVsXewY+6YCIAjZgx0YA50jVYK/XE1ThWNpLe4e+y9Cx3VGOB4dUvNG/BdPI9JTPNUSEXbVJfBcPNFE9/3klPazc5p8z/Ih9MfksAVD3yACFcHTg5ZpnGzMwKJYExPqv+L3NuHXhKvbj+4k=;24:blMZ31pTPIv22W8zWisrZnGBTkPzhxAOPcZRtWE6NHQNMhDyKmmXBlT7kPTbSwar84gSYHcQarpt1pL8jflHUOVGUvSDlOxqrRV96KFZgjU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2629;7:o3+0YizuRm1/W8qbGQhKTq5iy8H7GocPbul+T5SHCR/1gQJ8XW9nXa7KXt5omZErVCqNbeay/vS4Iidx2kTE5PVFpAHgIeSx5zjeyQq3u1LFnlORzN0q0OSQjOTTBgA2Dm9oYa2AbsLUyK5eTXcfgdvjivPh66wMsKBnM3ysyrXkpI0Ld9YZCvh8m6P/Eu6jjD/OMK/lJ18JQ1ZiEshOJZuz4RGpOM7UItnNH+udA2d4G4w2Enj/lJUxj2ZLCFxZ
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 02:01:39.9178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a9e9fd-3086-4696-79d4-08d5e79b6a05
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
valid divisor latch fraction register. The fractional divisor width is
4bits ~ 6bits.

Now the preparation is done, it's easy to add the feature support.
This patch firstly tries to get the fractional divisor width during
probe, then setups dw specific get_divisor() and set_divisor() hook.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 45 +++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index fa8a00e8c9c6..5a60c4814d62 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -31,6 +31,7 @@
 
 /* Offsets for the DesignWare specific registers */
 #define DW_UART_USR	0x1f /* UART Status Register */
+#define DW_UART_DLF	0xc0 /* Divisor Latch Fraction Register */
 #define DW_UART_CPR	0xf4 /* Component Parameter Register */
 #define DW_UART_UCV	0xf8 /* UART Component Version */
 
@@ -55,6 +56,7 @@
 
 struct dw8250_data {
 	u8			usr_reg;
+	u8			dlf_size;
 	int			line;
 	int			msr_mask_on;
 	int			msr_mask_off;
@@ -366,6 +368,37 @@ static bool dw8250_idma_filter(struct dma_chan *chan, void *param)
 	return param == chan->device->dev->parent;
 }
 
+/*
+ * divisor = div(I) + div(F)
+ * "I" means integer, "F" means fractional
+ * quot = div(I) = clk / (16 * baud)
+ * frac = div(F) * 2^dlf_size
+ *
+ * let rem = clk % (16 * baud)
+ * we have: div(F) * (16 * baud) = rem
+ * so frac = 2^dlf_size * rem / (16 * baud) = (rem << dlf_size) / (16 * baud)
+ */
+static unsigned int dw8250_get_divisor(struct uart_port *p,
+				       unsigned int baud,
+				       unsigned int *frac)
+{
+	unsigned int quot, rem, base_baud = baud * 16;
+	struct dw8250_data *d = p->private_data;
+
+	quot = p->uartclk / base_baud;
+	rem = p->uartclk % base_baud;
+	*frac = DIV_ROUND_CLOSEST(rem << d->dlf_size, base_baud);
+
+	return quot;
+}
+
+static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
+			       unsigned int quot, unsigned int quot_frac)
+{
+	dw8250_writel_ext(p, DW_UART_DLF, quot_frac);
+	serial8250_do_set_divisor(p, baud, quot, quot_frac);
+}
+
 static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 {
 	if (p->dev->of_node) {
@@ -426,6 +459,18 @@ static void dw8250_setup_port(struct uart_port *p)
 	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
 		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
 
+	dw8250_writel_ext(p, DW_UART_DLF, ~0U);
+	reg = dw8250_readl_ext(p, DW_UART_DLF);
+	dw8250_writel_ext(p, DW_UART_DLF, 0);
+
+	if (reg) {
+		struct dw8250_data *d = p->private_data;
+
+		d->dlf_size = fls(reg);
+		p->get_divisor = dw8250_get_divisor;
+		p->set_divisor = dw8250_set_divisor;
+	}
+
 	reg = dw8250_readl_ext(p, DW_UART_CPR);
 	if (!reg)
 		return;
-- 
2.18.0

