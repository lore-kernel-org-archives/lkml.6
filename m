Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA92AC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA9324F96
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="vwhEEvyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA9324F96
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933007AbeGBKHk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:07:40 -0400
Received: from mail-bn3nam01on0087.outbound.protection.outlook.com ([104.47.33.87]:52768
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753132AbeGBKHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ghN6h60FCpdIRNcG7DyhCMHS/msp1/leh31kSPJQqM=;
 b=vwhEEvyZUt4GC0UT+RyDlPZ6cIFUoYelWWi+AvjFuA3DQaZQJbyF3vTYcxyF72qOZTyZXjGDoGiad8WJhQNM1H2fspplgGXUO0NTI/SLiFABaGpQP2DsHlhLmJLwyVvKTiX1A0MWQrqXct+b7LqjidV8Szj7v7hizj17rpJ9Cog=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 DM5PR03MB2636.namprd03.prod.outlook.com (2603:10b6:3:43::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Mon, 2 Jul 2018 10:07:30 +0000
Date:   Mon, 2 Jul 2018 18:05:45 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] serial: 8250: introduce get_divisor() and set_divisor()
 hook
Message-ID: <20180702180545.7570b40b@xhacker.debian>
In-Reply-To: <20180702180428.331b36c5@xhacker.debian>
References: <20180702180428.331b36c5@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0158.jpnprd01.prod.outlook.com
 (2603:1096:402:1::34) To DM5PR03MB2636.namprd03.prod.outlook.com
 (2603:10b6:3:43::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0d68e52-b843-47a0-cee5-08d5e003a02d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2636;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;3:MBUssnJ4MIZp76Ta/rFr0gqkDBSL90jGBSFSGMLsq4MD723Ft5bCKqE1MXdZX70yM90BD9EShkzpYvlZr+LSx1c8EGMWPrfBqYl/v/nIO/cdhY7NJ7hlJRPpGjEXkt2MI+2f7BwC5BKG5A/FA9c6ZHfFYC3cktgTmPR9dCK1ET0hONGkzEAFx8c97B9Zykd7dvhdAx/1x8a4VGY/V4XGJ87I6age6nHXOKVj7OwKqVyRn+OrZgmkhHyPrvfmfR5K;25:3tBTeiK0Z4eKmuQletQlkSIQN1G/8sVNQ7gR3KG9XpR4morSlCs7XP1e47TROFhD7FtQCZmRkz85+oN5SEYVcLBX//atHe8lg2Kw6m4aUJFR4ZtBWN7sN4fGh8vqsmhdciZzhm507wjf0+DQpXhTwWdEFHKES3tWoYZz9RHcAGmW4M3UiNuGAODCRtojKvenV5cTc750ptoZpTIqSYRlwpVqAxHZfxktDpXYDgGBax+YQtjv2K2B7FPpfOSHUXIAvS7DO/ZpMv4OT0B+mCTRHG80uP/lrkCyvGaf3okRL9dvCjX4sk4b7LA+lPVnAhws6A2oD++FAEwYmW88HTHtkA==;31:mHUKaiDPIkb33tMuVjdP5D3TTK8/giPhopGMoQLVWPymPNeYSTC53xtnIrEAlV1LIU32UWSv6cqAR/IsO+rM2J9S3Irpjl3bT5JmFOo4u7WtOeHl8d6HrbIAQ+fsYItj2YmEmxvLlInEBBZmLoawJmZHBBnTtCx1JanzUf/C/tN+trAU64FgC+EgP/V8tlrPw4m6CqBXVMb2OAZIHIFhANMSSl5Pp2Zmvt2k3C+CHyE=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2636:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;20:S5tAkWk8/VXMCa2fwAwTDiGFPaVSyPWmvJgON6470mxPjcD7fXk5zq4I9eyAmBArqc3M3LgQBIuDaAWtQtoPyyWF/podMWOS/LmAzfLLAfEfGy8u0juCijVMZQhPTt5BD2iH4GUJcEY4XEMEhXj9dUrFwBKamDfcjiEst+i5j3ImgKuV+TPdzZ8tVfdfXUxZZNZZ10y9pibSvMHiIZci1doQnUgmetFeVlXp1HD+pE0tvcUmfOXuIBZgrQpOWlpWs/Q1QMY1kmT02Ia1/w7IzchLshzvgXshgwwr2q1dzh+G/1WyqANPKT2/6EywZTjTOzyvVlcOWbzT3u2sWo9M6pP03sOs+VfUf+SYvLeiPd7Sco+k9dk44UA6nGDP131FbGD3Mi2wF6PXZoDzGQHozSafwREBG1nZt1WPjRZuEDQrNSMlnGNifwoLCMF1Xb7WFIopYF+wvVS86tq6wYOy0Sk3s3MN4C2HR/jwWSX9BUsI8nvfAg9LtGTLWDDGwcFY;4:tcSWC2peFkutmLxhvk3wLLR/AM0wJ6V42PalAWeKbaLV7qGsqaVvavH5/AqoSaXpD85V7zgyK3qUDiwyM0q+vpxR53OYiXbT/R3ilkIkhIlb8DWwTjNwtw4lk9BVgFO7bnFZ2KmHwxzPMeRko4SKxNRsXAvyjdTdBuFoPKW6C+zWDP7MapxfzTcnZ2OnHtoTCIwvvo5RsakBnFoBbljn+HI6oQiN1+rX8wVRnDLPmaW2FOcsObAmf7SzfjlkSD8gLdcKut1fhAqTYLci+hHBfQ==
X-Microsoft-Antispam-PRVS: <DM5PR03MB26365CE9C62F3452B9B43212ED430@DM5PR03MB2636.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM5PR03MB2636;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2636;
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(346002)(136003)(39850400004)(189003)(199004)(25786009)(50226002)(72206003)(446003)(476003)(11346002)(956004)(4326008)(52116002)(7696005)(486006)(105586002)(76176011)(106356001)(305945005)(8936002)(33896004)(7736002)(81156014)(8676002)(55016002)(9686003)(478600001)(81166006)(47776003)(68736007)(230700001)(23726003)(1076002)(6116002)(86362001)(3846002)(6666003)(5660300001)(97736004)(2906002)(6506007)(386003)(186003)(575784001)(16526019)(316002)(50466002)(26005)(53936002)(66066001)(110136005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2636;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2636;23:XK/MNu2ppNzAeLK1x1nV5mIT1rVzGbL3DzSISB0Ek?=
 =?us-ascii?Q?waEiI9Z0W+uHzqE8JgKQaYZetHgUSIu9/ijhW8FJBUGVcNGGSZmTee7LfTHL?=
 =?us-ascii?Q?aDMf6gDJcRrS1YNwMjrf22IXbFXH5wrxa1N/8ce5whhOJc3Y6tbGF+hQXz3e?=
 =?us-ascii?Q?acZ/8ZWk2KVR7TDpzVyANkqfdcSHUiVPdhKjYTULMG+EdIb+Qi3kUOBHNzEb?=
 =?us-ascii?Q?173LV8/brc6b2Eb5Jn1cJ6HgfexLy/40Baj7j5aWr6VKYSrmUBSPzNFW1PYY?=
 =?us-ascii?Q?Yey0BP/xetJn/CCZlo70bPKEDdVcJR9gfaJuTjptpwbjKlo9kfyZNRVopHPi?=
 =?us-ascii?Q?pRENrN8GsaV2B6zPpovdGig1/tvkZgarbN2yiLZWMDbals81tUm2Y8vBEiCT?=
 =?us-ascii?Q?Hal8LJXw+djNcVvdzCrtBzYY3JcnDiQ92Ra4yozrpZ1ZBUCDmBINbqqmXMtq?=
 =?us-ascii?Q?iczX3CqF2ie05CJYQ6NL7pxa6NZNNaJA7AKDgA2f1VW4iv0f56Y+RuyGKzbQ?=
 =?us-ascii?Q?nYys8si+xD1cG33lcsQQnQB9iJtH3xGqSqq7Fx5Lm9EMpRR/SUqhElEDc4LU?=
 =?us-ascii?Q?iFrRBes2mECM6hu8qzBjfQ4bt/mAE4eoKTRzHzTUAg2Bx0XMM7MxN8JbP3HR?=
 =?us-ascii?Q?w1GN0kUH1Lxqj/KzzV0qmqkKw3HFoaIhcpBCkO1FJxIAwsnmQvLpO6DbVUga?=
 =?us-ascii?Q?gs7xXUEfawqX7+wDjM8Llloi69QIs32Y1A9oNAsKx1x1F/a42QDrjsu+L6Co?=
 =?us-ascii?Q?fi0sXScM+DBvSF9VMcZJe/kU6r2hKqObXu7j/o5h5+uyKfkxgrjhrm7mDiFQ?=
 =?us-ascii?Q?OI5R+Ulo1qfo2mKitE9hYx2LFZAXsqs7GEZROPw0SGphIO9dJpxdxqGyLxGu?=
 =?us-ascii?Q?S+HYkbIlVqkYzVvOjZ/+Wk1D90T19HrUkptlRQpKEjbeZw47XOkIoyNTDps/?=
 =?us-ascii?Q?PuQHit92ucjByRkx1K3rUmVEB+g6qjEY1v3pekOML+mkSb6jsTsU2V6jXs+2?=
 =?us-ascii?Q?gfKQZxDss+6O8j57ViSLICsnj+RbrGMhaz/NLsmO8flxJliPL1ChSGJo3gUv?=
 =?us-ascii?Q?m+oCj8I6c99+Y9fF1iXzfFELpgg85oTeU1y7pQPA3rwP0YZk1tOwDKJvnDZN?=
 =?us-ascii?Q?n45I+VL2Qah9zhl99H/+/i9yBHFQ/1DCK/4mDFvvPRnWL5OmDTurpPj8g7zi?=
 =?us-ascii?Q?zTvpUZN7HULIFrZpgynJSHziIkh/NOnzLTEDwyRNlJPIhWzkbV9BF7jrfKbP?=
 =?us-ascii?Q?tJgC10MG4MQ+FraAJY=3D?=
X-Microsoft-Antispam-Message-Info: yg/uIXjPXb07PO3z34MatUiRTgmLP3DEPZws34R8eDQvJRLPaNLzJdwUl+1gS9tpkLeAqFZfdZ3y7pGK2QGPhdT5uAoMAiGcZNyEePP38Aci4zOnBMe8qPfSemxUm99J7YUf8q+XrA+W32lPIVLb/qvxKyRH0hT6n0DIfTGMcAMTx8eoQiFa9n61C38x0vsNC05jPZDLKSvD08x2eyS29CeiYEHULOp+2DInV2z1jjG1O9aPcqLWLiwXA9VT8Ft7Pcm+3YcBOafpNWecDUnZ/SAews+2D6wIOe/PMSX8CUYydn6Hs6HAEYeUYgjai9PErO6e1P9bRJOiUJXyOsSx3jsmtWLZMq4S43W/MhmHef0=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;6:QsFKDxp7fgwrA2/3o83aResqiNQpikulnPAuc05DeTUM6AdEvDwzGKViMUSLCKpEUcarmp6UGB66eRfzEMydv3Q3jnRzeZD42qbzG/uwWKYe88pBio3FyWlsS75HmhkWC1zHek0DAyh7S4PXITlXRtmKJwM/gXh3mcrZ7MLP6u6FYZypyfd6CBZVSYjrx1lgsa32dN4ZPXPgffMo94QX1MdcjqaNSnHOMUWRCsXM2j/Y49bh74rPb0L8bl0bj79whPAn5gmJ+qM3D3OuvPzZKDBPTXDeGBBf5NRZOoFExgQ0cUOQiEVK8VmYuZcljF2amwKF9hJE0EjEq4/1KVPHjCWKqljaAnyCVj8VmPzvVzUk8NdlqqO123athpGJZ7TqEy14P0BvIBZqSe7tTtILd9jjEgFS3YvaB2ZmbAyeJ2ImTypwlA7vX4Rgkxf92aUHVI9PaRs2nbJpDQVfcAPH6Q==;5:VXuY8T3ttXrcp+Tnuk6cZihlSpAAv0p3UY5AUP5fMq5jmkwha1pm+6HGxvupphrgl0IYw08zyqpKN049pQHg+PjO3x3tPcN5sbK0Kjfqow3gtsAN7hIm1zg6RgBfzpRtHFoA+3Y8CeVIemGGAEABSWHnuwdLWd3OsERmCjB3p0Y=;24:fFcGNM56w2/YUMjAf+JHso7fV3fARUHSGuvxL6FRd0tx9Jd+Tv4SjKSGfy3g3BOJIO+mXaHP1svGopelHeu2e3RxpKt/lvMT6qdFp7lVHr4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;7:pJLa/oCxyGvsE0bhQz6oNNXgOsCiBtnCPnMAKC+F4u4efZ1oXsJ2R+SDBzrQSJn2F/ZR0pGS8Sf37J0SMyHf8SZxQq/xfXO6caPOUjwlr1SuMeHs3yL5W+scEg7yyiCo49Bo34IrpwOFbNSjstP4TxmqXFQFM6bUH7wTNscbHa0KUGpR5uoyAlx5uS1wyThUMd2SzxNKKbUqvjHdYbqaDKIZdlUB8pXg4GnEkpvc0ajK44075DKrTVqzRkEB2hmn
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 10:07:30.2269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d68e52-b843-47a0-cee5-08d5e003a02d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2636
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
valid divisor latch fraction register. The fractional divisor width is
4bits ~ 6bits. Add get_divisor() and set_divisor() hook to prepare
supporting this feature in next commit.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/tty/serial/8250/8250_core.c | 4 ++++
 drivers/tty/serial/8250/8250_port.c | 8 ++++++++
 include/linux/serial_8250.h         | 7 +++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 9342fc2ee7df..da0f3849bfce 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1035,6 +1035,10 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 			uart->dl_read = up->dl_read;
 		if (up->dl_write)
 			uart->dl_write = up->dl_write;
+		if (up->get_divisor)
+			uart->get_divisor = up->get_divisor;
+		if (up->set_divisor)
+			uart->set_divisor = up->set_divisor;
 
 		if (uart->port.type != PORT_8250_CIR) {
 			if (serial8250_isa_config != NULL)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index cf541aab2bd0..0060ec54a522 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2505,6 +2505,9 @@ static unsigned int serial8250_get_divisor(struct uart_8250_port *up,
 	struct uart_port *port = &up->port;
 	unsigned int quot;
 
+	if (up->get_divisor)
+		return up->get_divisor(up, baud, frac);
+
 	/*
 	 * Handle magic divisors for baud rates above baud_base on
 	 * SMSC SuperIO chips.
@@ -2575,6 +2578,11 @@ static void serial8250_set_divisor(struct uart_port *port, unsigned int baud,
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 
+	if (up->set_divisor) {
+		up->set_divisor(up, baud, quot, quot_frac);
+		return;
+	}
+
 	/* Workaround to enable 115200 baud on OMAP1510 internal ports */
 	if (is_omap1510_8250(up)) {
 		if (baud == 115200) {
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 76b9db71e489..5093c9ca0980 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -132,6 +132,13 @@ struct uart_8250_port {
 	/* 8250 specific callbacks */
 	int			(*dl_read)(struct uart_8250_port *);
 	void			(*dl_write)(struct uart_8250_port *, int);
+	unsigned int		(*get_divisor)(struct uart_8250_port *up,
+					       unsigned int baud,
+					       unsigned int *frac);
+	void			(*set_divisor)(struct uart_8250_port *up,
+					       unsigned int baud,
+					       unsigned int quot,
+					       unsigned int quot_frac);
 
 	struct uart_8250_em485 *em485;
 };
-- 
2.18.0

