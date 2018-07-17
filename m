Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F91ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 03:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852C720C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 03:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pLKHhqUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 852C720C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeGQEE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:04:59 -0400
Received: from mail-ve1eur01on0088.outbound.protection.outlook.com ([104.47.1.88]:12232
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725722AbeGQEE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35fR5iD9ctN6oQAcYfzoiAsNY0wPzJRnxKadAagfZHk=;
 b=pLKHhqUfZcHnCis0tgTeTQvDqQBluUfIgovVAIXLlI9lvbAEqaPpjehPXN5cB7GEGRz3LMQnWtvuu2FQFzJ0BPoA30HB6IpSl1S/ovVktvl/ATcsxXcqxWremjOGnfdaj/gMn52ZPAmI/nYICkNQGnUkLt9YoWBUz0nbQ48Wkp4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 HE1PR04MB1322.eurprd04.prod.outlook.com (2a01:111:e400:5889::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.21; Tue, 17 Jul
 2018 03:33:29 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2] soc: imx: gpc: restrict register range for regmap access
Date:   Tue, 17 Jul 2018 11:28:46 +0800
Message-Id: <1531798126-24360-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:203:36::14) To HE1PR04MB1322.eurprd04.prod.outlook.com
 (2a01:111:e400:5889::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90eaac1d-f19b-4f01-ce61-08d5eb9611eb
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1322;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1322;3:08XJdmhE6yDWT8RXCADQQLpEqw0z0Y8KYN11iwbQb37rdVqpiPh33mHI1n4I9dq6H0Iv8yGLIBz/+C9kUbmmqWYOogIpM9NHoyvG2T6eB1DgWMh1NHw0TSwr1xZwztnq0Hbq/N8mIfec9xugndw/KZTO5FqVCoV6p0SZ6VzPjXSnJm8OrjPSkTvBCk6a6cfLcQbSTIl2KrftAlqMBtkjg6y9rMdH8DZQOfMvCtMORMftbVXqwlsFX8HePqt5d3xO;25:x7C0tcP2py4o/qnH66wUe09ZSBpaJvnCXB3CEZM0Sl6VS2qHZLYTxjrVAryK11WHI+5BV53ChVuis9/LSuhwRC2wpnP2dTjzjB4zDqmLDVfmw5OWDolBQRMH8jphca0TpEktrGGmHYgIdWM3YvAcZp5HQEHBYAPS9i3WBMZ7qU8ve23X8J8HT7ZhtJJugLqjba6ZYaf7Hv5OVb63CsObzKE2yVsFAeSiMH/ENXBVXbvzKYAd26NaqnqZ4GHoImbMn8cKFAdJzY2e4KhiMSFu62kpe7X9+BGxgndvALTP519EkkNB6F0oz5WX9RN2yyXGzqYfQU78j1zTWPVR2uipYw==;31:Nz4f67tI4TT3Npck9/H+KQb+pH5xpwbVNpPT2FtI0/kxjv8fPtiuM0PO5KPGFcEjE/kIk4glM5/nEpfPoj2V40nnR6UDXBxGXGiLH6j9hsmkdfTybhfxCa2EkJw0AjvaNe12kxZQ0wRUeKBX/ffVdwEbLenK0C63TGOKfh5Sp17QQBFCvgbhJLFF6qRZ7TIsuggtto81SHtZ6dd2Kkwa7Bu4cNvBHSLUqfWvHbVnxro=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1322:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1322;20:k8EVHngPpfcsWH3cDG1JSvVrBFE8JAs/U/XFkCYB+eQUBbwvuDbW0yT7g8ljwno/i5fmLD3jY8SSVRb+pa9ZvFWUI1tRb3neNfxNnr0QvOeWGXAqhKHLAm3oH6oK/e9i1Po1I9PUH4EKOINdMveofoUltQnOC2uxP/aSTcCDWh5q/vT41RQCXfLjtex2e6LYJ4Ttt8mCysWi1ejaSFAdHyXKywzevQ2huxOZUPrMDlQz8TTJYrNSceT+7Xl7DYf5h/FvrQrQ8M811AIOXFxW/PmoDwcoPel7ItMMeOqNzD5M6uBvrWmyLQIemTDvtBsPGr6oSTy1KFzc2maE/CFO4pIS0XKGCdu+ud6HbTjYyp6bVQJChsrVUzR7pXXYBIOXy7eGkSYYeTM6tSuEu2VW3Qr3GuuPKNKkmmIeWWRkLGSTpq1oX2juknbg6/LVlNP1tH163OCaCG9xePUqD5QG2IWO6iE4UhLx0k8iSE/qh2ROJgCHalRytUzgYKEiUULK;4:UgJLIiwkjNODDZRbU57R4lxLTG78oN3wFcAG7MqJ3K+cX7W1LPctifGfSTfrYcHsL6EVyPEe41mIf/FDzKaawrCel2H+KIwe1vNWdmXRnOm10YoCi0taWY1kqIme7pJmHL8WcFab0TDMElsFKY8Y330bVNokWTRNSAZEMkgiXn0okXoIEBSCgc8DKV9mKmc4p7iIjwtjh1AqASvM2S7em8aktKrrgdqaVQiU3WiuEnKiHB+31mKWCsSxpIQ8cwkHvyZK1ehNx/Yx0ihrut3Aha1cGvm6gejH8iAANewow/pLVNqH4DM1JFkt595AvlGE
X-Microsoft-Antispam-PRVS: <HE1PR04MB1322651B1A47D4BB02EFD3E2F55C0@HE1PR04MB1322.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1322;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1322;
X-Forefront-PRVS: 073631BD3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(39860400002)(396003)(376002)(189003)(199004)(476003)(47776003)(52116002)(14444005)(956004)(2616005)(97736004)(106356001)(478600001)(16526019)(316002)(45080400002)(16586007)(68736007)(86362001)(50226002)(51416003)(486006)(66066001)(105586002)(81156014)(81166006)(3846002)(6116002)(5660300001)(26005)(6666003)(6506007)(48376002)(4326008)(8936002)(8676002)(50466002)(6486002)(36756003)(386003)(6512007)(53936002)(2906002)(305945005)(25786009)(186003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1322;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1322;23:IhKtTz8MtgsTCYB+3Y7SUexfL5v2WgbtWufHEZjW4?=
 =?us-ascii?Q?oXv8QGkPx9NjR/+00qEo4eOe9zMLAdCBbOLVzCbfn7dQ8xEGph39/eQFN4TP?=
 =?us-ascii?Q?r1wuXJotOQKwwAuUAGNXIw3c92KqdUEAlqTLPk/eL0J/XMZC17uFALky1E0P?=
 =?us-ascii?Q?29J0FXH2qAJaq1S3QTG49BnfgcwIh4C9A3GMECIMTiikoFpBwoY2/B4oQ3//?=
 =?us-ascii?Q?36ydPolkc/1htRewndtXkcG3xMpPs0CYbvTGZQ6OZIyEyuqpTvv8FFtGHHkt?=
 =?us-ascii?Q?vq5G7yvYlOwUZ1lHY8+GeHYZRPdvOQ6sV/NbAu/v99CjegtTEiO5MUDKJ7kW?=
 =?us-ascii?Q?FE6XzQzSLhhF35b/RSjaN9JaHk/X3I6ib32Y94hPUvgeXcUuSdms2t3OxLw6?=
 =?us-ascii?Q?WN48YVYB2ybLDtt2UMlcDnTEbYySatk9oliw1IN4D48EaqpK7L30r8FjWcOu?=
 =?us-ascii?Q?DoWciEv2FwXscPmCkEB0b6hR7CmCyqSrBCy7+p4MPCwuW7fhk0Nq2sC5VtE2?=
 =?us-ascii?Q?HBgnCu+1LP/Sjq4ivVCo3NRBEAO7nzbxnjEda8sNX6tcxh4hd1VbIxgcPnM0?=
 =?us-ascii?Q?YKytvMePvCf7mIx2ZmuYq9Db0dVZEB6ZjoTW4MI5/HG0iAQoxVAymrXcNmuL?=
 =?us-ascii?Q?ZLqlCBVbq5Jskir07yS+OdRym+EPOIxRj9nf6qIGASLxeB7mYpvbFoDHmi2p?=
 =?us-ascii?Q?8SxHl22zsPlnbLhQrIMcCItqcW8l6j9ygK0VbyU+nd+aNXTepXtjTc0nifXA?=
 =?us-ascii?Q?uT33IJaPASPMgSbVjqjAVHla/obE33HXRbyP8+ngBMz6Sipxm4aOMittXQy9?=
 =?us-ascii?Q?9FaB/08MUTexrBKeJd176gMPwScJZes9/ugVNhEzPo7QjZQRw5ss/QQIdUC0?=
 =?us-ascii?Q?Qii5FG2cYOSKlMGzKnKJwUqtfMmYQIW6q2iWytc3BO8DAz/gcIiYapXKH4IQ?=
 =?us-ascii?Q?Me0MhqcN0hIFoDGtvI388WvfhthWYOMc/G9b2EDa05KJTTYN8eDAf9SQWfIp?=
 =?us-ascii?Q?f2DdEAh0X2lqq7kMiMYjtv4u3/utVOc6n3L5Vw0CQySXWVuTq7tDYWgLaAWj?=
 =?us-ascii?Q?ZSyo83BlZYVsB/yJNPTJb3x1/Cc9AUy6y+8w/2W+QSOBfGKkvpvCi5yxVNC7?=
 =?us-ascii?Q?GPSF/5ni5ldKw/bv3ojDmTVXC2uUVA+?=
X-Microsoft-Antispam-Message-Info: AVi+jyZ5Svu2aw5P7xh2q7bwjUsM/aCde1UgrGKgpMArXI8APP2J969Qou4a2cfvGdOYPg2K1s+1KhlkdCYAht7xDN/nrrPFvOmritH3FSbULHmrv6AjPHINm45USEhj35dDlJxIPHOEGhIJUe+rM6GgziJcP2ISewQxyMC7FN0Z4g9lpA67ot5YdySp59rj4y5T/Bz/2Y20olYn0HdyM1ZTH3jZ8QwaNASNABtwi1LweQXfJFA+0ehfzcQYt607fQpd0U9QSJ2BRl9Jv6CUMsHjobwLzPOSyjOCo8zZKAEFCkYOevzlX9bOkm5akXO/Mp5ssQE6Kzvap3nPAsaw5vmjGZ04aoIGILGz5NuQ6uM=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1322;6:FNvV6L/y2BJ3IQtDpZ1HRfkH0TE/9ccISdYOm3JLafom1xlCLrvjbAC/e6xQLO4816+GjeuxNpXc3EuTxERX1buM6pXlWq7V0gmICy2EPGvaBf5aAiMfd/CZDO8Py4/kv8zY+0tXJsyrNZOo4HvLLZA/IjExCxralCal59o1uGI9epDE5MMomLxdcgoQ/Ed8bJh9VrCmS3M2Bd4XeMf7T2Fza0wXqy2JmkMM+HTXvN35Owcq6KSOSrTG/LPDeoRDfyXEnYnSbqfw+aRsOl0KhNjCs44IYHViqPHOT0RNLB8DtGMBcNF51ofKK+aqhC1HSnn7XbAkrr5z0BARLYPs+zQYclr6cCW9ZkuFYnv6wiSWc3q7Zwg4mNH9ixJmO7glhGxuDy2Y3pPoJohmwgFJydnyDa+3ZxNtZKx3LqiUwZdcJpFggj1vVopoPwmhQXlROMogGQ6zzE0p7I92GI5Y2A==;5:Q6VMjVURKi01HhXK4YpR6ye3H2rRJ4mFtHdSuDdM52Z7ek5MQ0QcxGVsmdOWUxVCG59FnD2MB8pJraoZaQg4utURLLRx0xv1Z76K9bMBCAJsjBidEXm5b/gO6HG/aj5wg3fDoQYWVp99uCe27Lv7Lstvur1+Kq4ldB8N6mIpE8k=;24:MGrsYU/PwTcmMtCD3Ar7+5JEQ92aM0w0n5Qhk4F4OVhaClSYKuONaqoZxbOLWiNNq2FIjx/sWCalG9yg7gEZqor8zHn9o/w1D8zJFDkBzEY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1322;7:0V8WuTSKl5Z2jmXXzM1FXnQq2FHBCqtXIz+YJVZSRIuo4CytPEgpcwDxuVQOqnsw/e5UruvW8jf82/Z7g+0TNcgVXeHZGVxkgnG/7+srbEhcr3OeNe2IV/aaA8LgYRj3jyZ5BWP8gYurvxKH/+jA8E6Xsf7dwLx2CElzMua/07nYqFx2JMGXe0urysH+OwC87dJaFBkZ8wGu2a0mXdKKwqfCQXx7B/du4jmr8yxI7MOS/cseQx0AQsD1MKR0ADYR
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 03:33:29.5878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90eaac1d-f19b-4f01-ce61-08d5eb9611eb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1322
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPC registers are NOT continuous, some registers are
reserved and accessing them from userspace will trigger
external abort, add regmap register access table to
avoid below abort:

root@imx6slevk:~# cat /sys/kernel/debug/regmap/20dc000.gpc/registers
[  108.480477] Unhandled fault: imprecise external abort (0x1406) at 0xb6db5004
[  108.487985] pgd = 42b54bfd
[  108.490741] [b6db5004] *pgd=ba1b7831
[  108.494386] Internal error: : 1406 [#1] SMP ARM
[  108.498943] Modules linked in:
[  108.502043] CPU: 0 PID: 389 Comm: cat Not tainted 4.18.0-rc1-00074-gc9f1f60-dirty #482
[  108.509982] Hardware name: Freescale i.MX6 SoloLite (Device Tree)
[  108.516123] PC is at regmap_mmio_read32le+0x20/0x24
[  108.521031] LR is at regmap_mmio_read+0x40/0x60
[  108.525586] pc : [<c059cf74>]    lr : [<c059d1ac>]    psr: 20060093
[  108.531875] sp : eccf1d98  ip : eccf1da8  fp : eccf1da4
[  108.537122] r10: ec2d3800  r9 : eccf1f60  r8 : ecfc0000
[  108.542370] r7 : eccf1e2c  r6 : eccf1e2c  r5 : 00000028  r4 : ec338e00
[  108.548920] r3 : 00000000  r2 : eccf1e2c  r1 : f0980028  r0 : 00000000
[  108.555474] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  108.562720] Control: 10c5387d  Table: acf4004a  DAC: 00000051
[  108.568491] Process cat (pid: 389, stack limit = 0xd4318a65)
[  108.574174] Stack: (0xeccf1d98 to 0xeccf2000)

Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
change since V1:
	add fix tag.
 drivers/soc/imx/gpc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 32f0748..0097a93 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -27,9 +27,16 @@
 #define GPC_PGC_SW2ISO_SHIFT	0x8
 #define GPC_PGC_SW_SHIFT	0x0
 
+#define GPC_PGC_PCI_PDN		0x200
+#define GPC_PGC_PCI_SR		0x20c
+
 #define GPC_PGC_GPU_PDN		0x260
 #define GPC_PGC_GPU_PUPSCR	0x264
 #define GPC_PGC_GPU_PDNSCR	0x268
+#define GPC_PGC_GPU_SR		0x26c
+
+#define GPC_PGC_DISP_PDN	0x240
+#define GPC_PGC_DISP_SR		0x24c
 
 #define GPU_VPU_PUP_REQ		BIT(1)
 #define GPU_VPU_PDN_REQ		BIT(0)
@@ -318,10 +325,24 @@ static const struct of_device_id imx_gpc_dt_ids[] = {
 	{ }
 };
 
+static const struct regmap_range yes_ranges[] = {
+	regmap_reg_range(GPC_CNTR, GPC_CNTR),
+	regmap_reg_range(GPC_PGC_PCI_PDN, GPC_PGC_PCI_SR),
+	regmap_reg_range(GPC_PGC_GPU_PDN, GPC_PGC_GPU_SR),
+	regmap_reg_range(GPC_PGC_DISP_PDN, GPC_PGC_DISP_SR),
+};
+
+static const struct regmap_access_table access_table = {
+	.yes_ranges	= yes_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(yes_ranges),
+};
+
 static const struct regmap_config imx_gpc_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
+	.rd_table = &access_table,
+	.wr_table = &access_table,
 	.max_register = 0x2ac,
 };
 
-- 
2.7.4

