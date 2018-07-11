Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB387C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66ABE208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="C8P4uIhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66ABE208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeGKHQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:16:43 -0400
Received: from mail-eopbgr720044.outbound.protection.outlook.com ([40.107.72.44]:8172
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726575AbeGKHQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQ99kCLOH+nlmJcUSHCHXSEQQw+mlIb/Wc8fgLp77ew=;
 b=C8P4uIhrnIF3xSIHDZXuKhuMCXEbqHDIUWzSDho2cmxeuOfAConT2URD3NRvmC5LkSXpZ62xCotAgcokt4g48xWDZnB1gvwP2YrTAjEndh0TuLTRFn78da+cea/nRd8MFLci024cJdBhAZ+dxVd7qqJJHYLjU/bAyeR+YT1bSjU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 DM5PR03MB2633.namprd03.prod.outlook.com (2603:10b6:3:43::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Wed, 11 Jul 2018 07:13:44 +0000
Date:   Wed, 11 Jul 2018 15:11:11 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: [PATCH v5 3/3] serial: 8250_dw: add fractional divisor support
Message-ID: <20180711151111.6f417020@xhacker.debian>
In-Reply-To: <20180710111516.13b8c570@xhacker.debian>
References: <20180710110942.5b0a016e@xhacker.debian>
        <20180710111516.13b8c570@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: MR2P264CA0020.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::32) To DM5PR03MB2633.namprd03.prod.outlook.com
 (2603:10b6:3:43::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57afed61-0749-4b8a-7830-08d5e6fdd914
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2633;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2633;3:7hPW7vHj5VJkAYLBlTLlCZPsMpVJVG2Eig287PbfnPp+5UAfWSBgw8VigT6p0TXNcwdDfgBJE9SGxViF+qtH7E9iFIbCeIsSpYT7rnKWCvId8pSONWV4FNKi4NwtRDue4v+YerX6OmTd8CHiCVoC/OZrwPP+P/kfHeGRxkkedI/vfW7rFg9EG+S+fOY6sEtyaVy39IfFpm5/SEeQ/8MdZQkyIAIzOlR2EqyH9MJYOtLaCsJTBmW0+86phYs2dsdM;25:hdcjhG+iJLZemxTy8gMBImSQU5vXUBTMSzMuvPmGCmnzjKaUfCmkQ5OHMUwrg2zULeFYJ0YldBguYdO3VubrGapXcL6DJXmiSWkvleqwBuN5ZLvwWDcykE87vVTsRvCvvGaZW0Wc1e0QhlamYZXwvojYM+auoPGJLdFKbl2Rq1Eb0EfGeKz0ISwKe8hRGjOAfMqvnkb+deJc+BYwA227/MyeWxJEn/jZ+418P/fnSSEI5tWIFqVywBxRALFW5IggF8dR3B5cUjBEAwL53+j3nO7l5Cl31qtTMqL81WZAOUAhXPB73O4JXEhoRfvir6g0b55NCjy4xuHltoO6lRobBw==;31:idLfoS+8pMPekJD3xM/K+/iDbEx+glIz2C9tNHRdAnpZQ/v7pZ7RptLJDn63AFz5g4gRFgUhx5IPOXDLjHUae9pO7xV3ezbrad3G5pPivSG+ssLXddN8FsBHJcSNgvPp98K/UUxWHF0v7kCVxqJUefOEVolUFzw545bCEok7Zu8enyiwbbhk7fcdCU9m8FyLVCTVVjff12HZx7NSzHc1B5iMoSsfD4SgcSYuOS7HhlQ=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2633:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2633;20:5Rusbvy+e1vIiBmzxI/lIWFX6cqSYUDdcQb+O28jbudc8rlQ3KUVigI+zB4HFe+g90lGcCixhgVmo+2J734S+Skrkffkol49DvgNOeXX3bHWkoTPBlAV70lGe/dtFvrJu2oJhqHdeKSH+t5vQMLgbBvpw/nNjXuIei9HxkrG/2EdWyakNTioG+Q+SYMHryrIuxA3Ze/ChJg2vmZv4Y5Mvy0c+WFYKzlEJEamQV/Ovl0E5272GQGmSiFAJV/kW6cwkBInyetGkCxYbQORZKRVa/FnSeTVQ3cj7eeMKQHEDO9JMqnW1Lpoc7wbdQdhrh9kHs3OZ83SLKwruZrGkdpzOvUkXGiGoPL7FiDQ4pTlNLr4USXGNRJ8+0H1IxTuGw3KZCs3ZgX8sJQ4Qq59rDhKvhjI8Mx7bDVisbhIFz01VBZpy2CNHGwOwHkXoNdmcsW8+/YMWJ9Val8UOmKU7wzwsdolDM/O5ilRMkjb/KkeIgLWjeb+ELYRvteAGpMk1yLe;4:1+KAt/+e3UrBdEXLoHEoPuYXwpbnXv1ZopJlSVQUcgONpkNicgWL0fY1q0Tz2HDvXkRGbQ9wjgTIYp1IJeFVQDOWBBARxRNsWMXDMaOSfHVk8+KCIdPHP2ax1fCeX1/f51zZUgJpH06ihdSswoEZ5higQ7s2qw1QFQFzVfJAj/24kSK+jB6GWGu3wNJgPe972cXDQry12sIMBnubc0GiZSgbWOraYJSYC7IyNvdyYCnmySCnOc/lm9myJ2dSUa9nl670lFyOxU9pPUZzBB0fPw==
X-Microsoft-Antispam-PRVS: <DM5PR03MB263331F1B77D97E78601F522ED5A0@DM5PR03MB2633.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM5PR03MB2633;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2633;
X-Forefront-PRVS: 0730093765
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(366004)(136003)(396003)(199004)(189003)(81156014)(81166006)(55016002)(8936002)(6506007)(386003)(26005)(186003)(2906002)(4326008)(8676002)(16526019)(9686003)(3846002)(25786009)(23726003)(6116002)(5660300001)(1076002)(6666003)(230700001)(97736004)(54906003)(110136005)(47776003)(50226002)(486006)(476003)(53936002)(105586002)(106356001)(478600001)(446003)(11346002)(956004)(86362001)(68736007)(305945005)(7736002)(66066001)(72206003)(7696005)(76176011)(52116002)(33896004)(316002)(50466002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2633;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2633;23:9jOzWY8CFGWr4c3SX/KJJdMBQaWBsaSIWTezBmtwy?=
 =?us-ascii?Q?VaF9H/CpN17+nwPG2xsCpU66FxaXK2/4ta0QSMHz7X1564Zg2Eg8r9MOAeMC?=
 =?us-ascii?Q?J1ej7EIyBKFnqbWrO33e2JC7ECmtBDLGlD4KZpj9y9Jijb2ttB5Z9/Gpv5Pn?=
 =?us-ascii?Q?ZFG4RlwZ8bztad9zEUOPWugX9091XLlR6EhPVr+QaOKU18Ek6Rotpi80PN3D?=
 =?us-ascii?Q?Zzh8Z0doJyydQQ1bjFwtKUuZMG/dXCxilQ1Et8lCSplM+WYiUotJsasuD0bJ?=
 =?us-ascii?Q?iHz4Yjb4tUqoT6HUpG5TN3f1XvTFoJblbhEbsyR/wl5VsaWn5zxPEjV82/Q+?=
 =?us-ascii?Q?DTgpnoM/iFWvtTVwm5BRVgc7JXtWu80Rg380NF24jjQgwM+jLKKyWo9lwoKq?=
 =?us-ascii?Q?aT0/3NmWwBRZaFXzWYAbZe2naExqf6Sbfqx9tae+wv5Fn7afYFAY4IdmJQAU?=
 =?us-ascii?Q?SM1qBszEXbOloezPqd/vPShK+uK5Vy8w3w/cAgAGb5vWZKCrEeYZFDJXDNLY?=
 =?us-ascii?Q?+Fen8cGSrDNBefd+/rUGMp1BgpplsgZTqPWJZZur6zdEv+ouEgUYdfyOnWG4?=
 =?us-ascii?Q?zmIhBNkX45e3FbHdxLurkaOH1kGacSS1mf+r3oxp8FZpO90hPyzSGvaHpsA2?=
 =?us-ascii?Q?Mz4bU/EhsKGAxrsZg0agoqhm+O5VTKxgSzS4Av4IfWs6kJAIUWR7gIomYcDx?=
 =?us-ascii?Q?jPWYAWQdYNkvn82LLb/Obz+q4qfZjdO4ZswhPV0XO8x/Q775quxUflwxfNxR?=
 =?us-ascii?Q?y5GjZftuReS2Hv//xkRM0m1R0jT1wY6ye2/kj+UF7eiavv2xcTH1yA1rgqgE?=
 =?us-ascii?Q?oP5shDx00BhaEgSlgyJZXGO6wj6msCIrVjlO5EDJqClRHeoQQ2ldpwDxNU85?=
 =?us-ascii?Q?HwD29O7XTJYU2WMczZWApQtznw5KFAdhGp12Q/+yxO/yr/v7tq4cyELog+j1?=
 =?us-ascii?Q?Jt7pLvqfn5dTn0TpjQD5BNZYY+c/oVXB4Y+mlugBg4T/mp/9CdiYQGuOi/4h?=
 =?us-ascii?Q?x2vSW51yuPIxAyDBC4i0s/v2ZA9HEn0SOgyr45ceUlmaRFG/ocH5RxckauB2?=
 =?us-ascii?Q?bgssBbn7LbLasmpzAB91kmo+QibDjVbG4eprup9e3jEMRF6pqXL8nwGOyPrv?=
 =?us-ascii?Q?N1yaWcQDcueD4VpuTSoAxh+NTBQY9LLIplCHCLB9iU79ASJ5i2OotVCycX3w?=
 =?us-ascii?Q?hNiCwdCexd5rgU4ojV66PnGM7iCRRVielYEbzB+6uBWLyYebU3z7CBA0ZTjW?=
 =?us-ascii?Q?2UpKfuLqbGa0zyFxsY=3D?=
X-Microsoft-Antispam-Message-Info: 0kMVpIRke1jqo/xCBYKTbecPSMB2rdkfxzYvG9XnYTRauexUOtw+iOaeKc6JA1Eiw+vQhOb9e+pSm+KIf2RVu2gZ+HoTUHC6q5dBdx3I6UBZcFrN7g7K6zL4TdtIq/dIc+EqDf1cE4Ihq8FpmSOsPRNFM1pqbNeSlv4m9JKgj5BAoYZQ6WU7+hx5UX2CQSY3xdsnCmbTXC4nHYObi7GDYqXHu8HXv25mPZRmRYEPXXht+IvAJCR4WWnPMa2qOhh5qjq34qRGnhf662oT8ozJCRBMn1PSqvLDRkcAzW2XN7Qgcf9I/82nkfR0VcpiOsuIEC7P3NUD3+iPzDQsQ+FCTFPLUKFjDjXNOY2CdULVMTs=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2633;6:lik+el+X0p5KczOAPzcw+heLTsK2ZglB3WtAh+c7Wd5EPFfLhfD3xW5tIEntLaydHQO4mLrwqeNBeaYwhUdSam33oCWI7cmedEHRlIXLzXLce0+w9a8LzrQcM/QzM9QRwG+S3J9sFp6r+IZDrqKKeWQwc7hPcNXqKmYpofn0OE985FmzjT6JaUub41vwGtu9g+ViCHLWBq4BWU55+pRaxteUt4Dd88G67y4PjKp8wWRajTBiStA6gAUu0wXv4iOCQVbzngCpnF/5590Pt0mMl1ZIv0rTx6D75WCiSVXH2CVkdgH8lrKQjWWcdRG3L0rqbW5h29jxrbVR8vt8d0Wt22rU8ZtHgMiWDyhrxt76thiXB5/8YrSq8YarsfQcEKZ2KYyE4e7WCItBBcu6EsNuhroQXX6anw1sVnO4oxb8mp5ACszq8QlDHUzuvL0V1FvJqX9bMs1Ko3647rCTM1Dt8g==;5:cyGsdkIbYviCATPj4+vfiwxdmDM3WEhAAig6nYFu+db+U/s1q0Xok/xmyS4a2ONziVFYiu/65xBFLIwutbJ/kbaC2XYGFbUK1ysag4OEMA+7WHImkV5SOc/RPtWgzdlE+6Uyj171pYAg3ew5iMCuKm6dGKfh7Z/5IMr2l5hgNqI=;24:lkEoYRpZ0DlAj/SCPALggYeiVfJYiJHr7fIMqHM44l96rJ+b1RsEGtz5t8S2YgkXt4NAGIavzNkNNx5QEPhHE7HBmRfp3Ac85Ew0kVUMTQQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2633;7:A/6tPEzy40uBFBfH/XVqMUCuYhAx2rUKNItWUa0fIvlvojDp7dfPkhmniLv17gCqqzOgS37qCmUDs0p9sD7s/gZgCl6DdTnghZ214q31X1/jzqQtpE3MtI4z4TyaLf9DizshPBBnUR9D3e202I3US7k/jKZ/Nf5KBYxg3yP1hFj8+iTYBqtbUMgH22Hf3KUQmdmWv/of65Bv0d9JhcUyPOl25MbmG4DElVzlMvi3CLJSn5Fnn+7SK+S5rlq3ef1m
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2018 07:13:44.9103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57afed61-0749-4b8a-7830-08d5e6fdd914
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2633
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

