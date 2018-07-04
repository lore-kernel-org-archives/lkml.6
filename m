Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5FFC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E8B2466A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="IKUGSey6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E8B2466A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934472AbeGDJFG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:05:06 -0400
Received: from mail-eopbgr690069.outbound.protection.outlook.com ([40.107.69.69]:4176
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932479AbeGDJFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JaMNsS3vwktw4/r0uBLPLuB2GZ8ktL3kYEHZlsK0ko=;
 b=IKUGSey6YHkp9L+1yn32UI6Rxo5xrroXE8KtYrk/VNhpxBjo169XEG5ulO1o5VRvnzXipBkVf1vK/VxSDCOrnbu9CN8zsB4NzkHoraUIp2JdDTuTZ8b3PKIUWPtXgZRNMTo2E5E4koODoV6amNlG/+ZWArbMX14tIe+Ue6AWJ8Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 DM5PR03MB2636.namprd03.prod.outlook.com (2603:10b6:3:43::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Wed, 4 Jul 2018 09:04:57 +0000
Date:   Wed, 4 Jul 2018 17:03:10 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/3] serial: 8250_dw: add fractional divisor support
Message-ID: <20180704170310.56772d77@xhacker.debian>
In-Reply-To: <20180704165908.4bb8b090@xhacker.debian>
References: <20180704165908.4bb8b090@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: KAWPR01CA0061.jpnprd01.prod.outlook.com
 (2603:1096:402:b::21) To DM5PR03MB2636.namprd03.prod.outlook.com
 (2603:10b6:3:43::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3e79e8e-6ed4-463c-62af-08d5e18d37fd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2636;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;3:9AjkwSVdFhxVXKzTAxCWbQVhaar/Pwed9iLvBei3xppvl+dzA3T2Y0AaRJ7t6RcjTloc7C428XImFL5IIC7bb8ijHPYlOom1QPhGETOCBVDMA/Xr/hxlz7uF5gD0NBKsO14deCqkzbtp1EN5XsWwBEtl9lItosnvUoQgzZOqOiyZFVDUAknJXNrVqSsS6akdlrycj/fMs05tJhgH9DvtUY73l/KE1xhE/SeKCh1xnfpi0axnjte3pig0Tj8TS4Bc;25:vid1yXNoiZHVn6WqVxBiUjomQvBXTbJsDmiSmOozXDF5l5kldCWeM5Z/mwjjKZ1XpUlrhOrFs3HOgt6Z+B4A1Yeq7IwQ2/5oxKbVoHIRNar/yPfqg1vP1MSdzDjdXOBhMaD0MZkmj5xjt4k67efmx4qIK1U6vUo3MyIoXXTrHTltacedHq1iemirZCXG4ieN+Ey31RBNmbDaGgKizImw5v44ZU4UmFMylJWUBtfqnnu8kycVOfsVGEbGGjAB3hu3Z8Vg4PSLnm/2Ij86Xtt1VIhyEh0IqKsThR5GD9MPcRRxdkamdoK0kgbTTcwyAmg43XRePYzXkZzk4UbYkjr+jQ==;31:JJP+TQQje/ZjHRtozkluaakhvo8A2EoHCB7EFgMMSJljU62mJ3QBQOeEOKnYvDezd7wMQdBz191A5X/zJl67aq4Ba0dDXoBCDLscQKkr9XlFA3STQRhh38wqsnt236UNMT4sdkmd0N1M8bEjJ97XWDfE1mu5BCMlhYjpMmhIpRDKTeZtQ+5nQF9AJwV6rE/79+3MgI0fWHtVxbYJCmwwmbrG2SCrbthveWjg1j8GIug=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2636:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;20:GhgK3RjfQOCjQsx46bpGkVMcwKhRQSwrU24xmAWzXjHTCGiqf4Qi31CjgFvTC+upDq/ctrcwynQ6LUpx+URIewdAQRo/dK602ntAArsr0Mm91wUNPBcx2ILPqKc9bp0TRNGch9T6XH5ATRudS+qnLgUaHvfCwuE2SdAwF75ten/VAR3qZ/TaEHIuVmnjwalxQBvtFfC1AyE6a6VmRVWOF5tn7g8IfPVz7S6BXeBWQs8RGOCb1mV/oI5J6sOtTRUCZnyp0V/WCcgyjmeONVgAmvzIDAGteyLYuP28WxVZTLz9YC435EK8Gc7eMIRqTrmEfRTVgTofdGxryYRpMyMtxgColjyvVnc88nOEGgCA6ONeJzqhNdx+tdi6NNEJo82P13bcydP7QvYc1AmV5uljjin22HEpEiO1v71/g9InIV4zbXTdOuPxrpWrPXB0fXfNJzZp2BK53YOZobFxCCGEt1uApbxZZfLDLsntxnmJPsuJZNvWcw2Isdp3uFi1cZ5H;4:AzfgUEqv/072PU3GRdEqHyzvRBl3z9AoKzeNTfpDBud2eWtE/thIwuHxHaAK7juNUPmItQMofhhINwmnkTRXWbqUYCaFaRhIpReTKTT846bp5QcFsy+7Zz2F0XFmnjtPuSc02tunwlik9Ty3TNJjYPTlZ/zDfWwfxs0wJwwiW90lrFgsizS5tb1sxLDPtLl+E6uj9Mz61y441tWUR2W5zVD7HF3bICdbQm0ebxQZi5nwG5iq9ydys/UVVNPyOxT2hjEV2roRdV6mv0ASEmpyHQ==
X-Microsoft-Antispam-PRVS: <DM5PR03MB263656918D0ADA2CEFF10779ED410@DM5PR03MB2636.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR03MB2636;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2636;
X-Forefront-PRVS: 0723A02764
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(136003)(376002)(39850400004)(199004)(189003)(1076002)(3846002)(23726003)(4326008)(6116002)(50226002)(81166006)(8936002)(68736007)(81156014)(8676002)(105586002)(7736002)(305945005)(25786009)(11346002)(6666003)(446003)(476003)(5660300001)(106356001)(956004)(486006)(2906002)(66066001)(47776003)(97736004)(53936002)(230700001)(478600001)(72206003)(55016002)(9686003)(33896004)(110136005)(86362001)(386003)(6506007)(186003)(16526019)(26005)(316002)(52116002)(7696005)(50466002)(76176011)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2636;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2636;23:4l3rZMPgVZao1q3S6zUPp1rD8f3Z6TIJpBbD/o/Ri?=
 =?us-ascii?Q?DwexBV9w7Rx5RMvBbZj+VOFrybOpoogZjtsu25HZQLGAYvzh9hQcrZvZFGX8?=
 =?us-ascii?Q?tN3tLjffULua6FKVvL7tSO0QQ2gK40+KiqsablnZdTv+vFy96Skod3udIgRk?=
 =?us-ascii?Q?eKi/NOf7SBztdCHHDtuxeK6yM/VyCWp/B65/NWgBm1Oveg2j4iaB0dBjbsXi?=
 =?us-ascii?Q?jnnakeBv3zao2kJ9p1Bh6Sp9/9mlT9pR4i2ArXcVbSgLcacEfl6SEZEd44v+?=
 =?us-ascii?Q?JjbM4rfFnotEEu3vOtncngftpfea6FUa9nREJPJD4DK3KeovrcZTdW5Ix8GR?=
 =?us-ascii?Q?Qg5WGWDBJzfI+WE9fxe9SBp3624i5vehU9loUag6yE7TB2YvTG1tbIsku7v5?=
 =?us-ascii?Q?SpDAaxCtCo5v8eWd3eh2rZ3bdqPV5mxSWRHiM78E7TLEJ1SOlrHX2SSROuyW?=
 =?us-ascii?Q?cSXef43pb2DhFr9OogejLiQDQJMsAeOAay16uzSEvAKlz2Bc0hOJtnUPzHY7?=
 =?us-ascii?Q?yMKZbadFNUYWZavZo2E9lVCWdNKNvsmlOh/4GOH/Vqh6ZF6tVmmj+lOHF7q4?=
 =?us-ascii?Q?r737Y3vxprYG5uT3NxYmJ4mxaQSJHDM2GhdYS2RN/J/AIQWGj9sGNkXXZMWw?=
 =?us-ascii?Q?grysPSWrCFz/vsOHrojNjEamSNky/jB19rC+oD8r7LHz9YkpacmCkECnUeR9?=
 =?us-ascii?Q?OZ5qtfIScW/Gwe6cFCyfb1hdwFWQ0ePR/gJUTrbHjec0tmyLUJFmUDsAZgjF?=
 =?us-ascii?Q?tUa6n3NII3tLnDD1TwCyu+DhlwyqNp4rTYQ5MRIgeaqD/HlXCyIsTdmP7sgm?=
 =?us-ascii?Q?qFZijlzlmzvCrxb6tj432CDHR7G/Aw5N8hHdxD2h1cuXsqu68ZYLF0BmTCRD?=
 =?us-ascii?Q?aSGbzb2lcE0Dn4lu4qC9SN9Fril50xJyx9EzeiPNcHR/ai/dfCWs598TTff8?=
 =?us-ascii?Q?K4LKubKMDmlhgBxWC4uX6AGVvRJ/xC3tG+uEW2MpSvk0dELmN4TFrF12Mnxn?=
 =?us-ascii?Q?UzcGkO9TFMXxovQTBzcoWOCGL7hvTLcx9OtTRGwrq5ejk3cRsCrQgb4ghc3x?=
 =?us-ascii?Q?C1973tOlyy1N5I6mazkEQenjRsYcNJGDS/D8CozoHa8xt5L4K+1EXc+7zAYD?=
 =?us-ascii?Q?DJU89jQzUcA99Bm/2OSZC1MkbsQyCdyIvl0eMH9mwkzbqVbd3KwzJRKnQLXD?=
 =?us-ascii?Q?NHycg8qmjbXlRoGEqN+uu0fnSUI4bGGT8sPLl/m7/9dEh8y6XwAZ5a5xQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 92kaxRK5gQnXg+b2XMPahdDT3sHO7UtqOEiU9nhdJkKjJp6ByXicbl4gbMXKLsKg6/wbipP3A3FNYmtTYDM2n8hXESoD23BU3ynEfvZMORyNUpWv/M4NUC4bk+RTMee2Cbco1U+wNx/CCKKJGef6p7WTkNvHZKICLiYTo2KDV1y/MHVIh95DpdGJPEz5p43V3rw2uSvZGvInmlhquFJcJ7YRkIBYewTvcp2zrMr9QnhBUebMKiF0MJB9wqnDMrBogLnpfvL1uSd6LFYW1UQ8CIuzNLAbKHI/uxbwm99/C8GZI5Vr/9Xxu9BML3Df/+vaFHP4KoEUI6Df4AkFJXPXbi/1blZwu0Wb+yOw8g2+vBg=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;6:xViCafPLyserLkzCO83WdAEU0iuUW1sl8dOwrg/YwsFGipGx7e7YVc6C+IGOecL9apMlLPmUlGRXPCw49cGBPsYqUfb8NsHDQhnExtQTKfqeCPdVjJ+x7g8rOqqn1dnEFnaeuLIIBeAVbjJl/0skApUFoCv2HoeOQ9Jd7St5e5Rp7GnqjjRf5TygqT5oqRLMX41U9n/2ZFMDtyleNFDmJ5HYuMmsPr2IG7HKCP+YpgdWhHpHiwwMuBQ7VhDEi9CxFJ6V77mrhgWO+uH77fO3VY8jdenATgn8nbZd7O6a7Cn/EBrNHYZa/n6rlAChJZ8fYzELtrUppOXdz9mYfGuiNcE+gG8p1cPYc/EGJuadXkej2gfWbbNBsU+2MYZ3d1moduXOIlMgbLVVeKzji+huYJlitDd7dwgIArqcKohrwpZLDTzgia6vb+hnYnrq7T0RiQkmQTmqn8kJygJTaY+lBA==;5:JHu5dD+pAGSzjlNCTOfiuaCLI7/ymkY+f9GAmBl809eMntGR6NsX7KF4dOyQzZxAnzKiWcmI9s2Q1i7VukxpAFEOeKrXGIvx3BMoFkOHsRbNZueItSjfV9DDs9IalHtgH9/11Ioq6h0TnQWlwlTxP7J/U8CbYnW0JeUXvyAB9hA=;24:cqLlLG3eYAZ44/rQ7/pZwXEOFnHTwLkWRC4RUbHVZdka2vBkJtpV8csGiar6RmtMibBIOHc2hhEhyPjrmDfydP6vabm9gbVa6wpHpIuT+5g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;7:TNmkkfw8vBDbwZcuBZ8JBL3RSMJ6qwVXFGSH5PKgJWC+OkMlYPN7a63C/kmzepuAI4OkvlKEYXpsGg090GwAFyXjczdIP4iEmEPGHcToqYUFCuhQyajqnEBJL2JR9LFWrg+OX0bc+3t191qE2pZmM7Vp35T0Vyk+u6k7TJ6FJzll/5dbm+jBkdYiLNGgwqI3hB8n9kRu45fhjs+b20S/0RDEra9jskm7VXxIjnd0Xm8fcWlrrUgSezPH091yL6EQ
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2018 09:04:57.1159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e79e8e-6ed4-463c-62af-08d5e18d37fd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2636
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
valid divisor latch fraction register. The fractional divisor width is
4bits ~ 6bits.

Now the preparation is done, it's easy to add the feature support.
This patch firstly checks the component version during probe, if
version >= 4.00a, then calculates the fractional divisor width, then
setups dw specific get_divisor() and set_divisor() hook.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/tty/serial/8250/8250_dw.c | 53 +++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index aff04f1de3a5..b9630f633388 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -31,9 +31,12 @@
 
 /* Offsets for the DesignWare specific registers */
 #define DW_UART_USR	0x1f /* UART Status Register */
+#define DW_UART_DLF	0xc0 /* Divisor Latch Fraction Register */
 #define DW_UART_CPR	0xf4 /* Component Parameter Register */
 #define DW_UART_UCV	0xf8 /* UART Component Version */
 
+#define DW_FRAC_MIN_VERS		0x3430302A
+
 /* Component Parameter Register bits */
 #define DW_UART_CPR_ABP_DATA_WIDTH	(3 << 0)
 #define DW_UART_CPR_AFCE_MODE		(1 << 4)
@@ -65,6 +68,7 @@ struct dw8250_data {
 
 	unsigned int		skip_autocfg:1;
 	unsigned int		uart_16550_compatible:1;
+	unsigned int		dlf_size:3;
 };
 
 static inline int dw8250_modify_msr(struct uart_port *p, int offset, int value)
@@ -351,6 +355,33 @@ static bool dw8250_idma_filter(struct dma_chan *chan, void *param)
 	return param == chan->device->dev->parent;
 }
 
+/*
+ * For version >= 4.00a, the dw uarts have a valid divisor latch fraction
+ * register. Calculate divisor with extra 4bits ~ 6bits fractional portion.
+ */
+static unsigned int dw8250_get_divisor(struct uart_port *p,
+				       unsigned int baud,
+				       unsigned int *frac)
+{
+	unsigned int quot;
+	struct dw8250_data *d = p->private_data;
+
+	quot = DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4), baud);
+	*frac = quot & (~0U >> (32 - d->dlf_size));
+
+	return quot >> d->dlf_size;
+}
+
+static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
+			       unsigned int quot, unsigned int quot_frac)
+{
+	struct uart_8250_port *up = up_to_u8250p(p);
+
+	serial_port_out(p, DW_UART_DLF >> p->regshift, quot_frac);
+	serial_port_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
+	serial_dl_write(up, quot);
+}
+
 static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 {
 	if (p->dev->of_node) {
@@ -414,6 +445,28 @@ static void dw8250_setup_port(struct uart_port *p)
 	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
 		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
 
+	/*
+	 * For version >= 4.00a, the dw uarts have a valid divisor latch
+	 * fraction register. Calculate the fractional divisor width.
+	 */
+	if (reg >= DW_FRAC_MIN_VERS) {
+		struct dw8250_data *d = p->private_data;
+
+		if (p->iotype == UPIO_MEM32BE) {
+			iowrite32be(~0U, p->membase + DW_UART_DLF);
+			reg = ioread32be(p->membase + DW_UART_DLF);
+		} else {
+			writel(~0U, p->membase + DW_UART_DLF);
+			reg = readl(p->membase + DW_UART_DLF);
+		}
+		d->dlf_size = fls(reg);
+
+		if (d->dlf_size) {
+			p->get_divisor = dw8250_get_divisor;
+			p->set_divisor = dw8250_set_divisor;
+		}
+	}
+
 	if (p->iotype == UPIO_MEM32BE)
 		reg = ioread32be(p->membase + DW_UART_CPR);
 	else
-- 
2.18.0

