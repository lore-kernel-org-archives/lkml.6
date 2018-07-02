Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795B6C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCCC23CAA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="pdJ9oARP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CCCC23CAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965034AbeGBKIm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:08:42 -0400
Received: from mail-bn3nam01on0076.outbound.protection.outlook.com ([104.47.33.76]:64702
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933098AbeGBKIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBDDrU3mCCzyGMorricuFF+M8FaNll9BhF+4kdPiXhw=;
 b=pdJ9oARP7SckEJbKbonR3ADlvwAjX+9A1Bg5Rcn3tmkkm0OJKVZlM8rFdyIN/67GQbtmWddsM/YIgJyq5kW2hEH5k/TUu0pP5wpvI0Pd2EMS9CpI0SG4w8AVq6cdvBd6HbJG957tmD189LtITIlPp7PjMLgcf7+WmLSmRnnkHtg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 DM5PR03MB2636.namprd03.prod.outlook.com (2603:10b6:3:43::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Mon, 2 Jul 2018 10:08:34 +0000
Date:   Mon, 2 Jul 2018 18:06:48 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] serial: 8250_dw: add fractional divisor support
Message-ID: <20180702180648.039dcee3@xhacker.debian>
In-Reply-To: <20180702180428.331b36c5@xhacker.debian>
References: <20180702180428.331b36c5@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:404:56::24) To DM5PR03MB2636.namprd03.prod.outlook.com
 (2603:10b6:3:43::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db781ae2-1974-4251-404f-08d5e003c65f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2636;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;3:Qt2DyVELq4nx5voO11Z97GmrodqZqvvLJUUtka3MyUbiX5MHZmhe6EN7RzhT/jHYYP2SKjJLBTDPpy5j0GoLK8HyUJtM7qy+DXtMui9OfEBrUYTY3/VuSaprkg94k1Lw/AUUDfLy6cZuNwadbrbAQZKSn2N6bnow5Bpu7UN5ixpzprHXW9L/w2oBZT07VQS3LT+NIj7p7M8D+vSqaFZI3Legv/znf4IBzPFLHoRnMHBgClP7XETZzO0Xv6x6A0eg;25:WcnAoFWgFRjSZ+JjPEl5eFj/BqUExITf+eZP2VsxDLNo3GGTv0MHOQ4oomNuVl2SSm9AND+zCZj96Xut7syoq4lvlyz7lW2HQvY1WhZTN8tFEq5d6iuHZEvgK6IWh/dyCMGHCezxrEWZw49iumE2wMd+/51xjOD4OF7UNjwsW8ZAuBMorNaKJsXpa3/wqkuKY2+p/oJFWsA35pau0WwmSwCx1tldadzmIRt+eLVhpaPCZKpu2gpiwrSC83ne5PzwxDAqrc+gGTrWEN0d+SQWHvo41DurwzFzAESxg3T5tOOFdqQrx0ig2yuOPN7cJmSGN97PL1vLcATM1Tvqzt4A0Q==;31:SMu9+ha+W6ez/rd5neS1bYi36hqp6lwF/Iw8lqJOriBi194DOnadg+mavV6qQKhTdJrdbl/uoiXduAcERPCLnHRzWNtiPz7nAC2Sl4Bl60QPHAtr8Hih2cVduGoB9DzKx8rKRQt83BXOelf6GnOjlQDRzXoEThzUq5HFCk+tXn58CVQNlUgptewa3HUksGjo09iU7MIdBudhXx6oXC//UHtrt2S+L3O+/y4g4SrBTcI=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2636:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;20:ovxXd4sTe1/4w6GkNLwl2XQ4x28rEsovqxBl0l+pNYGWuLs1qvGfV27KE1951D35fJWkvkmy53DlXD0GzuEUn7XESEhMfJL265/R/8MkF1pgi4DcntwX7A667fAvnjGFdf3IGXPEBiQjThRhQWneeXQ6tbouTfLbG8UQhGxt4uVV1brDlTDy+uOY0N0TqiAo6L14hkHyqaS9JnYHBv5NYe+UlmIoff3yOtK+VU6QsRs0LzAeg1MGs4r1jU3m/02vSrq6TOXRKZxd52+lWbFxPFVGCV8RLqgNNAsJZ4JvyhtOylFXcA6Ncrvm30HfFZju4ldKRSGijxvSEHwBfqVXNDPuQmqjd1HDjSqcZ8m+tX35ldAve6qmP1CRxVOn7vTFrXqQxNKLI5MRXp5Hf1jzF3ZS42KUbGIc4FJ2OrQcOU3oPMkqGz+GgJs0hwBlGxPrEFuM6kBmbhe6MO/jVzYohbmbO9r3rhR+3TvbMw0CTVRbUKSCjcz36DjlYvzgq7Jv;4:Zxlrr8KzxSu3p2PMRpp8thmmKfEX403I76QK97otvOCuFsOQsK/GcbgZn+VR65F9GDb9fyEhfsbx9KUCer37vFBlsnIjQ8NPg6kn4QPOACOeQTeFISSmngAS2wXeTWb6zjtboala9CQ2Yg1HA1xQcxOnQYfTc/THXIUJHk0zdWq8auORmROgp6DmUnaZG1HXCt5cj5YUb4QzafI69/f0U8WqqdRvjjakCDtnoJf0YR4mzpCWZ8IisoEtGwHcg2LnoQJNkBUk96c3LACFUt7ZHA==
X-Microsoft-Antispam-PRVS: <DM5PR03MB2636D86224E30DE09A9A7B92ED430@DM5PR03MB2636.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM5PR03MB2636;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2636;
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(346002)(136003)(39850400004)(189003)(199004)(25786009)(50226002)(72206003)(446003)(476003)(11346002)(956004)(4326008)(52116002)(7696005)(486006)(105586002)(76176011)(106356001)(305945005)(8936002)(33896004)(7736002)(81156014)(8676002)(55016002)(9686003)(478600001)(81166006)(47776003)(68736007)(230700001)(23726003)(1076002)(6116002)(86362001)(3846002)(6666003)(5660300001)(97736004)(2906002)(6506007)(386003)(186003)(16526019)(316002)(50466002)(26005)(53936002)(66066001)(110136005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2636;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2636;23:FXNEIQ2g9+mO6TN0AQE0mKYULplsUJJxEuJSU2QOW?=
 =?us-ascii?Q?+CwBO0stCLnRaPZFC0iimHACvxBloZCSnaY10attcHu84OJpjllFAUxQ88aR?=
 =?us-ascii?Q?25BRB5BDPYnxVG49GTNoiu/TxpUpk6yBwO2nlN7SXPQOuzuw2mEKmc1WFIdU?=
 =?us-ascii?Q?6IKHfM7kQa8FreFvdBwYnPhPFVvyI8I7oYAZLVMbB8BMhUxeIZkHHfAnIdg8?=
 =?us-ascii?Q?CT3rV+C1D1Zgb7taDJpHiXn41oxnUkJAz+oTGKUi7fDxsaYXKJezkwe3hoGd?=
 =?us-ascii?Q?49HlzHfGfSLaTWT2uzz9Sq4HZCJDvZ/RLUAYRqg8dn0HJ6K7DAXmhGnXUZRI?=
 =?us-ascii?Q?xZxxpOHQ4XOVOPHTvlcbEGzPls55td6w13oSbWeDbhhLV4YyFrqi68jie9mV?=
 =?us-ascii?Q?7fZqCBxbet3rkXGIiQl49rbRRPwVFzTXBwGBowizOOVcZhvmSdDsJp1S5bO0?=
 =?us-ascii?Q?HtIJMCisyCRexGsyE6kMWjEcnfo+eXcS0eq1Az8qADEi2cCuUxu3nGvrCd1G?=
 =?us-ascii?Q?tsaJQbUXzTA8m5zOEcobJQ/rtNfQWIjfb0Wb/TrZKHUloXcgc2R/YzERePwS?=
 =?us-ascii?Q?0jbglsjk4k4ZtlLz+em6dx/1dQDM+ZCQwGjDqc395RC/7zwIt+Bn+ITR6EgJ?=
 =?us-ascii?Q?wNHCHnS6tk0ETS5zhFwu43a9FtqH3QLCrBzsbXPD3JylggGt1ToadCxO6wPI?=
 =?us-ascii?Q?t7bCc0UYoUE2Y7IfxvBo5MeZvCZAZfKoPyPcZyKcaW7m3OEwSdO5zGpy9Y4m?=
 =?us-ascii?Q?nQEVnI0ZjPYlCgDDFFX/doZkxI3DjdBqDOHHPUBg89Vn9ItV/NsZ+DVN5Mxb?=
 =?us-ascii?Q?Yuxd/JU0IyN0wU5GrEysabFG+ElG+ef6PxLaIRTUhkYuPq140KwNEl4xNBqY?=
 =?us-ascii?Q?2dy5eQDkIxznAJSOnsG7Vc3i+CAubPoMcCvZMjmoP5vdoOOpn4OzY56zh43v?=
 =?us-ascii?Q?2/1yWuCJ+pPZLgzJmfhGRi+8ZkmuKHz55ogoE0cvYmPSyUD1hQIlVIfwxQn/?=
 =?us-ascii?Q?3uwP0x4Yj6dPqcmrIG5KLisrtKPgetaVI3D3Sl2xC0DeySi05j6ZCOGfvWVJ?=
 =?us-ascii?Q?SMj5Op+j80huoeviKq4OfDjiADZsdKgsW3nEh+n5mvrKV2iDdV+KkYsfHhh5?=
 =?us-ascii?Q?a/sMEvosax+rvoVI9ECgSH/wbueYuXpovP7IGvZiGSKY4dPYKN18TKzlQzfG?=
 =?us-ascii?Q?eWifbMRYgbK7XX0Ofk1e3VfXl744/tcIyx7CDI7J7DLCLgPj5/987+Ifw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: I+VFu7kbBmLeN55o+ayEQ2ivaXTLQKj0nETsXeaOVIdNMj+uplJs2280UTZlawmWP9xuX/giqxa7gYRb0X7jHWiJ87NpmhwPHZ841efhmIYLGeu6s80WLRL/pBKCp1JlvBffEssvsu/u6wSbsoDhiiu0f/tKZUZ6oxyH+0R38JcCxxL0AYmRby1pmRtltjvUuSWQ5GlOJqg5RkvujDnoa/uIk07jjf23tN0McevBrtuDoIiSzlSDkyx1H8VdAMrt0XpE+0VWNqGr7v6mdLQZAftk6grcqOvOq5AIRtYeoReRRG5jJHFfn8ffh9KR3C5FFGXuwPbEqR3jR1sdV5quIsIAeEIgVCy5ji27zt9WRYM=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;6:EbhR2jVRf9vm84XACRmiScqeDlWZL+8xaT+yBRhoNJvxpqlZCTGH/lKNxSDgaizouqV+bjoO7nI+vnHZtb6Xb5ZosTyElGQA0o+6/KZWr/7gJ4xCnHEIlejrWv4WCcybG1DEUCmokfaIbH+IOYelnyPQ05DYH/V5xgIwRx9/FfLdK0K14mkt8PFFZKZLO9UAQ4FgQR96hh7F8Fj52UI1fwT3SbqgHJzkNk1DNBG5mKtcCYt5il/FljS0pYBLOtnmx9R+l9kZHNfvMihp5CXAwjaQgN6GwI/y8fs6VJgQULQho5PtNQPbl2dZT9vI4j/8d9PUgQ0tpMaLv45jMsHqUIeLxr9LSOiYEt3YyzxcRuO35lyzlE3V22BnbVGuIR80zigQv3NdkYiq0pUkYN5t3KNowPx9L5Vi5aVc29AdDmB9sGaOXv2GhK6oaDqPrtUG6pcPQXaj7PhugHNaDQbNWg==;5:+hWl5OfCCwriiN8HK5miGhNUqjQG98G7SXGgJy+ynqoAYPr4di/Gji/yxe9bw2o7aXB2z4LFbyjm2AWS6VFUghVCGWDx3lrk8qGqcM3Zy4q55Pcndzw5MK/UaQt2QWZRNUdOVKsQKdulFGMsaqufkzoizGJADqbBXVLQz69pamE=;24:vcX84LUNkpIzFu9lgTypytKnHIQNj69StUY8bkgmoOkU5mZyYNGmoVveGDy4bvMLMDEUxGWlT1Br4PaEAdd20MbuOEv+zzLMJb73vyD9C7U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;7:sGVZPI3Djf++LFvDWMwFnNW1xQgUwQ7YSsrEq94XOo9xMLnR2H2Mh3jvOac0t2etf6BWbT5Yxp25vj+OMbNIUH9X6oXGkMt4RoIGHTeeWcMDkKaZfh8sin2V2zbnWQtJ+vYd+wgjxxsWI/07+gGa4tfxlLf1f8MgYj3RcgKlt9a3BboNdlwJKJ6D+qRnsevJ7TEQdsHNhTmCqmRkBDoLI1Dg1p8x77/XUdl3PyfnWIbcMTeDILx+k/kCa5I2r2Iq
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 10:08:34.2783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db781ae2-1974-4251-404f-08d5e003c65f
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
 drivers/tty/serial/8250/8250_dw.c | 54 +++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index aff04f1de3a5..367a73507c5e 100644
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
@@ -351,6 +355,34 @@ static bool dw8250_idma_filter(struct dma_chan *chan, void *param)
 	return param == chan->device->dev->parent;
 }
 
+/*
+ * For version >= 4.00a, the dw uarts have a valid divisor latch fraction
+ * register. Calculate divisor with extra 4bits ~ 6bits fractional portion.
+ */
+static unsigned int dw8250_get_divisor(struct uart_8250_port *up,
+				       unsigned int baud,
+				       unsigned int *frac)
+{
+	unsigned int quot;
+	struct uart_port *p = &up->port;
+	struct dw8250_data *d = p->private_data;
+
+	quot = DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4), baud);
+	*frac = quot & (~0U >> (32 - d->dlf_size));
+
+	return quot >> d->dlf_size;
+}
+
+static void dw8250_set_divisor(struct uart_8250_port *up, unsigned int baud,
+			       unsigned int quot, unsigned int quot_frac)
+{
+	struct uart_port *p = &up->port;
+
+	serial_port_out(p, DW_UART_DLF >> p->regshift, quot_frac);
+	serial_port_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
+	serial_dl_write(up, quot);
+}
+
 static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 {
 	if (p->dev->of_node) {
@@ -414,6 +446,28 @@ static void dw8250_setup_port(struct uart_port *p)
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
+			up->get_divisor = dw8250_get_divisor;
+			up->set_divisor = dw8250_set_divisor;
+		}
+	}
+
 	if (p->iotype == UPIO_MEM32BE)
 		reg = ioread32be(p->membase + DW_UART_CPR);
 	else
-- 
2.18.0

