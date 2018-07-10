Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86497C5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 03:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C762089E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 03:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="N17vb54C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C762089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754605AbeGJDRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 23:17:22 -0400
Received: from mail-eopbgr710049.outbound.protection.outlook.com ([40.107.71.49]:62458
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754549AbeGJDRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 23:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjnM4VrE68YE68uuN5Hk45z87mp9HdYOBKoyfxFhINc=;
 b=N17vb54CB3OzWShJlrhoUaSh8YQDK0acs560r3mVTJwDNW7RkChM/njjHyjDbggjWDupu6fO1tUx8zTTmQgZgv0TN425AAkGepsFz2IJ0rnDeX0o/+QxZBu/qoHo006YYhawUH9UR/kOM2NWpRnw+Rrk5NH6C5jui9tuOOLKWck=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BN6PR03MB2627.namprd03.prod.outlook.com (2603:10b6:404:59::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Tue, 10 Jul 2018 03:17:12 +0000
Date:   Tue, 10 Jul 2018 11:15:16 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: [PATCH v4 3/3] serial: 8250_dw: add fractional divisor support
Message-ID: <20180710111516.13b8c570@xhacker.debian>
In-Reply-To: <20180710110942.5b0a016e@xhacker.debian>
References: <20180710110942.5b0a016e@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: LNXP265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::26) To BN6PR03MB2627.namprd03.prod.outlook.com
 (2603:10b6:404:59::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 570379ef-6aa8-4270-46e3-08d5e613a23e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB2627;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2627;3:NMSovE884lSP3RGoWowW9v33g6rFRLgCbj3i/c/1Tsgnd6c1rPaD7u06PLoCzZGXxvzwKlzYA+OJdCYZQA5W2CHT+2RDrPoUtaKRIlrykjjjIfrKjLKDFHzuxDKwW0SZUbQ8AVM8g7u1Uk59AqcwkisYFzXgVoqMnLdZ7Fx4ypUcWkT162azuz950lpetit8k691HvLG7efAjul06zxHTlX/q7Dn1AF2Cw9rXqgJ6d31bP0yONNQ+9oAc93t0BvV;25:vNI0KRKpL1nfMERSCDxJEcgLQajFpPif0ECIw+x3C0RfBkhPwS9f8PAO0s/HhqQDrPPNWSuo7EQai2vY9am9HZ7Q01jyQE7sSnaxqW2KOukAdMa+IME64T8ZRMGqpuOroOVQDCLr9Q1wTzDk1yQ0lSr4quI7aqxsfLdymajhgRmGs2qLct84YisHbpTbL1Ddm8TqB6BMMXZLZSbazo5dnZnVldje/9R04U3E4G33bjf7VhG/P1jEq38kpYQvJz7ivvwXFiq4a/tQCzfUrPQlbyEZB8ng244jfsE2i1NnzuJm4GT2Pz33mHqq1zxRkitDvQv55MKccQjNETj4nPdt8w==;31:TH+HWMzP3nRGIw/+qqNAOrTtFtxe7pPnwFcdrwjSWSSSnWI8fbuOBKR+PTWe039DjlXpSkaA8UCi/uLcmaBSUshV+wm7IE6FXDX9dKX0BEObp9ubSyQ0QV+/kK8vY/oB2k8KIiBuxWlKXZWPIf/mFGCiArZ4KNXGEAOws8nENBcvbPApCcxBKYTc2yvZMr5gSgnOhr0C78rAq84/+irPJvTnzUB5uU6Ptlo2n+ASQnU=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2627:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2627;20:/V4nd6G4aRp5iU5SQ7ZLTrBUb7nf2m5fnoD4vOtW+DG9sJRmtYQDlIkrZLcvfX+tyaSshf6EegIs8jfG1+9ZtEHd3Sb6XxFjg/v/EUdJIzfbEpfJGOkizv/qgy2flU34esZRilNS/RBley8HxvMKa3fK7FGwGBhVQJ768dpQvppIVBrXmmemWjTVd5paGPcQoyeAIjoOVHVaO9+etEb8uygBRYH2Dmh6DwmXbMBrqTAzTaQvRLQe/DkTGYtggy0Dw38KzNi7qb3dqAnEf6CNFckq1glw/TShbPW7/jOYKC1D5asscKELljJGFVkmmKljAvRUX+Y1gHQClOJf7Lhu+Hjc1Qi6MFOFg9DBlB4f3m+GMC39Dvf65MwHgtpT14UPAEDK9HwXxXvxrfYhEV8Q7z6JPeH+hxDLtnzb7ODoZJlHtufLZ3GcVw2vKZhtzDT3I+BzEuu97UtASzaSZhAnBfcrHhTaJymbg2vsGdpowpu+VzHkQcTT+dqw4zntk2Jz;4:Q4S6F6awmTT2lr8aCb20AsEZRe43RIZzfDZV45m/MBMpt9W5tRbjj/oH0a1ooJtf3DG8Wy+BdPWEo0EC6z7IjcOr/ACZ3YrW9V1Uxu1VNzedp1qI+NoAPhXVgdUXkymGQc8OSUOdCGISxZ5RsY73sELrtC0q9K4k3Qjq7osHdu8FmA2liqoHoe6N+GdKPo5RfDddP/Keq6Fy/9cqQjWRUqGZ3pRQE5U8k6vhDYlEy96EFPxxB/KXRs1er1wAfV3/F7BJAiB69DEln2aNbvBC/A==
X-Microsoft-Antispam-PRVS: <BN6PR03MB2627B1C9B8F611CC385D6ED5ED5B0@BN6PR03MB2627.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN6PR03MB2627;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2627;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39860400002)(366004)(199004)(189003)(7736002)(486006)(47776003)(16526019)(52116002)(76176011)(7696005)(33896004)(386003)(66066001)(6506007)(316002)(54906003)(25786009)(11346002)(26005)(8936002)(81156014)(81166006)(8676002)(186003)(956004)(110136005)(446003)(305945005)(476003)(2906002)(105586002)(72206003)(55016002)(1076002)(106356001)(9686003)(86362001)(6116002)(23726003)(3846002)(50466002)(5660300001)(478600001)(97736004)(4326008)(53936002)(68736007)(50226002)(230700001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2627;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2627;23:6AXeb4hiDKOueQ8N2fFKRHrIkaG6cLI8+lVH0Zvqt?=
 =?us-ascii?Q?YdV/jzWu/HTXHFbINdJ88a55gaB2zrqOkV2P2pTyhYldm9rAm3VrysuG1IOI?=
 =?us-ascii?Q?D/Hzr7iwV7QVHwFuPw5vp2q0sFgRWCi43wiwHX3uNmmkfb9rwvzEueyt3Omh?=
 =?us-ascii?Q?CFd8G/OVEPWCPlTNirnkVbLbUHmoSpyduR+nsuy1Q7GKGkhcW2wtyOo5IAYg?=
 =?us-ascii?Q?p5b9V8TwNO2ZG4WNLpqXNv71OTnkyQ/zLhfJMFPxVPJynJitVaD/ZS8JxSJo?=
 =?us-ascii?Q?1Yx2UubEokr1ccWkyYdf98+wNTQ6GhWSnYlGlNZ6TheHFZ1ea8kbjNDHjUdF?=
 =?us-ascii?Q?jQIlKrlngdKjkLpZcamCDdMCyM6e2MwmRTs9Solk87niusrzgT4Psq8TlAYd?=
 =?us-ascii?Q?SU87kAjBrnh7WmW+rweXejhIiKP1sPRssuAd6VDND9b06CadAiZeKQl5hAxq?=
 =?us-ascii?Q?Dw6pNH69DUwRkdFiYfxumtnGjV1scpg+pCSnZJlXdTHllmILmXqAJtAgjW2R?=
 =?us-ascii?Q?TsEQ2ocHdOUgSjn5gRjzOmKGdw9zbPl5XygxfL5y0Vv6GFwozcrCtEh+B2GT?=
 =?us-ascii?Q?TZ2LEkSIOuAUknNKS75vnT8Q6uySFq9Q6UrTHGAcOvKXbNu1JzptCtgRDB/4?=
 =?us-ascii?Q?7Tiw94NvCtEJmLqsATQimSOVMP9GZV2gHmdyIjUncLaiSlgRiZRTchF8CyrH?=
 =?us-ascii?Q?2bOlld7yRxo5k59x0KBFajVq9ghEPt9jQSC3cQKZEB7ViW1t7I6tsnzt7xvy?=
 =?us-ascii?Q?QogSEtvyCiV0bLZwMiS79gXY+gqe/fRp38ZDSjyHq3OxAvevugBfaHruXFGG?=
 =?us-ascii?Q?lzialzvjAnf5jQwy7lCJusH81sQE/1/OtGhhGu9lVmywWpQyEeyu5q0tNxWn?=
 =?us-ascii?Q?OV7ns+IpUjJ4EoAEjehII78sY2GN0+laafHVkoAME+ozOPeow6E4lm8Cm1o5?=
 =?us-ascii?Q?wGbX/gyqscBI8sFHCFaa1ZhDN61SObQWnZA5/nJvbYwtP0DoCIezS2e+f+YB?=
 =?us-ascii?Q?3S1DnOU99k1XCBWo9+utZhYxdWKuAziqQUHrtD2kcRW0dTTxVXGDwrMixIla?=
 =?us-ascii?Q?4ewZiZ9SAkjWaNiAi+DB/Q1zARCqO+la8obWC/Yy/tJtTajMkoldFMLQWzkK?=
 =?us-ascii?Q?HOwG+dWYQSUK33B7ZcYwgIdw2dx2srmX++9B7E/uJ7axyKGBv+gwufgdHQvC?=
 =?us-ascii?Q?PtTDWJLE0WC5IIS+vOqjc0er7mHe5UCDjIkJFXZuxUjaH8G1zC/yDcoAg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: CuY/cmNC92HkgTvCgj0polYtndahHyr6occuQrpywViCNn9ozpf99XzoD7I0UZa8eMtxM3Faqa9p2skXR1LrHqxciPiVC+5rqM89+uk5RquD3bnGnED5he26igTqdi08rDU7wQ0WDF+Dm1KPBJuCKb74HgwbfM5OaFnoyaibuDe0NUUuTT3eJLdU7JgjckAGLpVPEu3AUc9gNY01DKzR65E02mEmn1esDnWOEaS2xz18YZIsTwAUqi375zOP6zULAz0VSz2uv8bqAQH9Imo/olz5s4H3ai9FMzPfhbHpfR8Mf1NfPEJOV7BmmLMVXW6yXMRyvCvAX2HMteBryTmtFhhe2IxtCVKy/rn864sSjJY=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2627;6:yYz7Ze43dv/m7aVWnxL0K2MdyHqSSFchr0ziNcOjlTqzxgFzWYYukYhHoPkl4HL3NklEclEDoB+UCT6HzDHCEK+GnJzkUYyNm27nb7TaFOMnWfCreSMD86QiO64MJWZoRyIVm+yKkgdTqa7tM9+WsT813BSAF5em6n3oRnecprYiRaqtOJ9TBhkBSwpGyiM7CzF+GqmcxRcy1p79OADeUDkQ/5NL+2nPD3faJljHHNfO6ZgBZErCO/f+PoDim+ZShnu2JMg0cJBPFYRVLrMv03V/qU40L5RBkO3wY14dOCjG1Bn2ktYcE9+ahAmry2KTt4wvpGYz4eFUoky0qVryRvp086lLNzXCazMq5RSmli/CuHKJORFBa6bnJlZL9K0wahJ+nPzC6h+hsMWxecXHd0lWn2+Sxb0NXt1QvXhsWo4UJM3g3YSg4oJiRwO7n3ckhg+kIyUu3xIIKiBmDzsVIA==;5:MlPBbdanYXtYVdyuLpiL3Ymid9OJ+KE65DpWbu+ZWvzLmReEtTDtu0rFfEq80NrTFf6Y5XazS3HvdRCWNUvMPSQV7YBpZMSUloGy38ptaH4aKsxnwWyAAR1yeOFPGyknnwzw7QVQpj0bYPKAhCGACV/SSOWAXg9gAzHmxjRXGRg=;24:ql2Nq/Y28Fap/rTPB1gAyK8OQF9T63n7SyJEC6XLn3AgoZ9OEGyy8buzvEVXQsgvVFX0E9kCVnYWy/g4J+Q6YLr0MThBEW3HzyOXB4qLT0I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2627;7:GkDjYfJo+4+VvIjVoUvWWk6A118goxLbj8pOFY27qAM+5VHZ2WIHMd3nF4S+39gNveQs/gCuqthh/IT+Sa7R8US0xPGgBtScrth4DEQlGDSZWCC/ys/kFWrFT34uDQ7dauxJve/XG25JXJmMLK40u+6ieYjLOfmia6EQc0tjc4MzohcrkieRro/4/FJC4Y3ddOQRJNK0kXNZwC9wbsCq8YioAddUcovB4QNKWao8BdN/ct3sMmLJdo99JnNE3eyz
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 03:17:12.1582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 570379ef-6aa8-4270-46e3-08d5e613a23e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2627
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
index fa8a00e8c9c6..ad08d7a3b93b 100644
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
+	unsigned int quot, rem;
+	struct dw8250_data *d = p->private_data;
+
+	quot = p->uartclk / (16 * baud);
+	rem = p->uartclk % (16 * baud);
+	*frac = DIV_ROUND_CLOSEST(rem << d->dlf_size, 16 * baud);
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

