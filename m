Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72992C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F17D20882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="NjnPeY5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F17D20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754433AbeGIIWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:22:34 -0400
Received: from mail-cys01nam02on0064.outbound.protection.outlook.com ([104.47.37.64]:7927
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751388AbeGIIWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNwLLXouCQqRDSxmN1kdJ1vceBdIffPALUZBAlOeCpQ=;
 b=NjnPeY5sWCeT8F4hVPwtc9fflylC0WC76/LkA10dhAR7nVc1BGdm2vjNkdeHscv5VOX5hLdAkOPnQRX0KwXEADBs3vh9zsphnuVzYH9uo/AM29MJMGNbzHoZTJTYN3+ww3RnPbgBoBTwlIeLUrergkQhREOnfGCC32g1MFtQEEg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 DM5PR03MB2634.namprd03.prod.outlook.com (2603:10b6:3:43::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Mon, 9 Jul 2018 08:22:27 +0000
Date:   Mon, 9 Jul 2018 16:20:34 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: [PATCH v3 1/3] serial: 8250: introduce get_divisor() and
 set_divisor() hook
Message-ID: <20180709162034.212022e5@xhacker.debian>
In-Reply-To: <20180709160942.11a74f7a@xhacker.debian>
References: <20180709160942.11a74f7a@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR06CA0046.apcprd06.prod.outlook.com
 (2603:1096:404:2e::34) To DM5PR03MB2634.namprd03.prod.outlook.com
 (2603:10b6:3:43::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b60af21-1267-4dd1-0573-08d5e5751c3d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2634;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2634;3:lXV7zQlnmIgTgnY6afWSsw2JmXhNiDB2ohmWYZC7IHqovNcokO2nmFDZ4SrP0+rjKFq9njjBwV1izJB2nXOBSqLWxA7XiHIZWPhD9ipsuw4uQb9JD3jgjF5hF+5SdPhuJ9YdDT6nQmSUKRVxCFBWKaohQxir8PeCxfIIBvT2k2WGwMtWkWHyAVq69VBoB8h5gn1mVRCLkZ+DRRk1yO44dk2fqRUObKXQNCi1G2DlBaiEyb3QHOR8h0PIzyk4p4W8;25:e3laLwJsp3eHI/enkehTDcI0IpMaDphjsCwm7567Mu3B0uD7PyOiSLFRq6JDTAbF9+tqib2L595ahZZ/aCh0qIXNym0ybDCwmsPrGnN2cF2DEDg8xchk6LId0KCwBof5Q+JFncXAO6tVppq8BOGEBRyLpK26NwuPzeIprYgePDVI8y2PmrU+qgReEfwXYe4ofbgGYZpXw6OTX2JHNSupWdn/K8x7Uclw1eB1orjqbaM61l6jrC5wUcDVES7odmny+OWeUCnryHaxwBgZfmSOgs3MdW5Sp6J1C11mN440yXKK82bq1cVrFogA5LUxDidLPhEAEjKtvUvGhVx84erN/Q==;31:htrQemoSx/iABUxjfbXleul2Im6cwYBwNWP78YBBXAzXHz3GOQ7YKIy8eZ4SY6xPLVNRIPmj4AvIw68/WRF/OK8HxHm06E28xf4SyqABu8NpzFMdyT2lNCkaWgk6AMPOWh0F758IaATyVSPlk3b6OY5GbYiq6R6A2ccPRpZKLtiypPJV77ZOb4dyDLqYEem9kK95bFC543k/UCqHgAdbUPnCxNa5y+xVhH0L8lRKDkg=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2634:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2634;20:SezcT4rBuOVhumwFhvbLh1C68+WWRomvWR08b28bMifCM+ETlzGc1JiNmFoJMkEQeHqRolJ/SzdrVuzdR9FYOUykuV9oUmph5pQQMUlMUDZMUkmJVX72vk6d9jG5ifpkAkEW/xW4QVAccoMDu8YqK1EOtUylm2/Ub0g/7FulTOIjlh5JP/gM+ysrVYEUev2iHua4D1oktsYSVqEXNA6yrWKJyzxHW5EkcYr4ioDWw0ZJbIdp8qEPOwEayVpsyLuamiZ044qgLaiejfnyRLS9NM2hDAP9xutceP/EoTr84pZlvxAHf3FgDaHXmrM78EGXCfBZz7nv7bbvbG9O8SANoArIxEQZF+EY/u4GpTxlzHelfwyxfYO7Ir4dzm47BEIRNiJOrozmYk0Jdaczu3m2/rKd96+NgPVCAQD+HxejcmnqtHO3E2IUXcVKlCY61mTSVgBPnpFny9z+jN/2Gt+ILnmffttf2oi0C3yBrHbtMfnF/QTCUxkJvSRfpxTcubNC;4:0a9E7Ql6eJnJm+GTtOPW/zGxP8AYNqyo1k79OQEXyqDNIiV9Dzck4IsnTLH6ZazcbjfyolHSiOwPl2BGGf2JIWCI+Ek8GrV09nL4b5020qDydwcY4VON/nxlnrb5rgFM3N30v/V+Dx1wsuG68V1npq3EyQ6WGmVHjTvyYkyfLxR5u9EdjIX6twHsGE+E71fvkcilx3nZGKhDaeCUGuhhcAl4Zib1A9z3JhjLD442inaITAlRxJbSfY4/MnORg6kQrBwCpDUeQ3lnDou2drzKiSAfSJ14D5Qdk954Rb5Wv38dMB5B33nTfVOw4o85LJ35
X-Microsoft-Antispam-PRVS: <DM5PR03MB2634C6B75AC9E4517943A5D8ED440@DM5PR03MB2634.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM5PR03MB2634;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2634;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(376002)(396003)(199004)(189003)(476003)(50466002)(230700001)(3846002)(1076002)(9686003)(6116002)(23726003)(316002)(105586002)(446003)(2906002)(54906003)(110136005)(52116002)(7696005)(11346002)(72206003)(16526019)(956004)(97736004)(478600001)(25786009)(26005)(33896004)(386003)(486006)(186003)(76176011)(6506007)(4326008)(106356001)(575784001)(53936002)(6666003)(66066001)(68736007)(50226002)(8936002)(8676002)(305945005)(7736002)(81156014)(81166006)(5660300001)(55016002)(86362001)(47776003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2634;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2634;23:KPc/1RuBp/zRp0IK1L0nE/CB6fPCqdga8faBVuu2e?=
 =?us-ascii?Q?O+d3EZoU0XDD0lJTprwk7QdwaSOkSyJcVe9rAHN2arDGfOwqKoReKYDBwEhf?=
 =?us-ascii?Q?l3dtZY2HY6f71l7YZP1e6+zW8WlAdZC32/2N/m68nvCypTWqSfBAC4w8cpKI?=
 =?us-ascii?Q?Ty8IBV/sdOCZayqVZCs9VkLdTAg9APNp71UTNsp36V8Sl3jouh5Zk5/ukZz0?=
 =?us-ascii?Q?HU1SxWSmwrKYYRBCS/pml5P2N7cSmiFXzGOPflVR5yNfJ9QB9kN5vFrSNG4n?=
 =?us-ascii?Q?ee8KIEM2lxfZ2JyBbog/TfJRCcguGqq0YF7p1MOFZe/ytaftwDozVlXUWH/H?=
 =?us-ascii?Q?+iDrKMftJwj1+UjDtGbKYy/cjQ1N8tkrTsB31kCslxDyKFlMR6JSfBBtJvij?=
 =?us-ascii?Q?Td/zFupimqZMo0pGnlENqo+R99aD9WyldfSXY8PVMrIm1fhS+x8h+YgBI/Q+?=
 =?us-ascii?Q?QprIYVaLXkTos9oJXWuDh109Mx8UjPmtFhjV30hCd0Xfajh1YC8+PruA5W5B?=
 =?us-ascii?Q?aoClfJRLKClSXdy7QNBDOV1GILrSkhK6locSSdOTLMYExjfltL/sX9hOG/Cy?=
 =?us-ascii?Q?dk56q/ksbGVYRDWUE9+aLpPIdQPjt+DU2AMEjohrNhju4E+D2q6KeFq6bjV+?=
 =?us-ascii?Q?oM5ipKVA6C7+I/vkHKWufKSwCljKYBylziycAztIcIRysA0iLCW5hRbUzq1B?=
 =?us-ascii?Q?tpNNM8x2s+NZ22u7d53q8FNzA9NQ8cBrvSA7vyzpemzuwWc3fK29CEJ7qo3X?=
 =?us-ascii?Q?TevntyT5zCTP22I6TGME3IPpSkWQSG5LleidN68lBA80hwAlC9jI/poHll6+?=
 =?us-ascii?Q?Jemr9xlL6GGqK9KHW7JmTjNnELbx+9pMob7u9oVDok40YU9RCmk9fJtGExPc?=
 =?us-ascii?Q?SV9zoyD4JweDK+g/nEcJ8qjDv0Kfcn9xx8yW5WD5rnBfn5Zt3bHa0lgPJ2Sh?=
 =?us-ascii?Q?8pYWCrFmTr9ItTCGl9sr6u/jPRa85SQdl5qUZw7FCADIE4Szf7fA1FP0FMif?=
 =?us-ascii?Q?O7VczELLX6APoWH9HZ/hQsWtFYu9VGGpzNCogGDPD40W4CKMDl0zfgVY3XRy?=
 =?us-ascii?Q?g5ej68Ka6s4685bZxCOvj/ovDMnRH5tzXdfweonGQw8ScSiJGXivh47H4S/r?=
 =?us-ascii?Q?8yjGlTmSM2AmQ8FXPoScR4voY+xXdwNbeGucjPHNPW9v+hhpsVlZdp9PQ+dJ?=
 =?us-ascii?Q?ocYrgoUV2rq+PYyJhfQBrEYprQKmaGrSLtK+Olt2BqNA3y+R7GzSOtAHVK8a?=
 =?us-ascii?Q?xfm9LvFS/cVcZsSCqA5chUEwCn22q4NA4zN4VCR?=
X-Microsoft-Antispam-Message-Info: ch3/pdYcac/hGnPvlVnezRbbq0ivld7pozFO6iyrG+tBI3YsZfw4Yw1UrYWkGl1hzYQEv9A5d263AttqTd03YjvNP3G5NMwRqORW9BRl8dWBx7soIYEVWstRGIf/NnRWnBmajMkyO3XZXxFOy6jrPt0joznROrdbPVM+DAS5pkaWECnjjnVJRVgpzoKmIJ6mnDjvVvWx5G9KmTWUqFASZeTDAioSuQsOPIgBKoCcHeWaVD7RrZw8ejKAyR2oEHuXmYX0MY6ttaJGsF/GxoOCt5O3gBydZOK2LO/Nb53vMJ6YqBCKMPPdZHtDVwADhaa5Yjaw/7Iwi9/P/L4cx56aJhkjpOz/j9XgZeMThZ3ikZw=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2634;6:hTzdPKXoarwCB0OQkZddHYbmIxsBmsibozgjnbT44tha3qzPSwxYZ+s1aRtMHT4ab/+FayhzJmuQydtmmEuLt0pLmMBZR9Z7TgVdafYDepN3HBD9oFkIBOxUSmAZhiWzFVRNOubHC8MNDaAgLq1doGkEAPnS+yqzbP4wWJX/9mrQR++0kFle6G9njTs/5+lWIUPdRw8Qp/JLn2oFlSo4DaYws0DFWmijBIUzflYI6pOQCjlNJePa5nWxnjFQbwH/tTfwEWBBQGPIQ4tjNdJ4L54hvMJNdCqeze2TpGlvrq9ISfmmZ9dX0gqubLSVN3jHwOQDFvAcWsoSOdSM38XX5uzeusou1I+yrx/cLzG/A73ppsdfa4BZIZiMs5ElvZQFFVHBe3Ojr5MUpm/3/OyPuhWFq/EDVU3DrZFAXBdpvtj6Yt8elqdSqXbuffGgIxXG0BI8+gMBIDdCp+mWsDEnmw==;5:AcPgj9MbSb3/Nu+rLo6kHi7HpDWO7jiWTo0wDgjXCEr36e/Z/KZGNhcNYi+hSmjX244uvUBbuQz45nFxS3sTwjbLGdyBlPi84D53Cu5V4uuzkSpD2JLsPdUbUZg8FLz8FLrZ8X8zZzijCgvIu6F41tEnfbP03BWPd4117nf5aQw=;24:4uXo1vCNjX3ZUDdeSQM/BD2gpDRLKSW31pm7KT3KvdF28C/y9NMsAld+ELptHg43ZCd7BCw+Qai+PxATGcxg/DP8TTstEUAMmiGTTjTLTJE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2634;7:B/izQk/NNwTbEzSetght2wy1qcz5sXtxnGnR6wJnaj8xow594njpWuGXBAvLTwGIsWCaVLepO8HttSYqcaADCFc9lMv59ZgY2OOoakZyx2ch69chKFjzo9vHdq3u+XFGo9UNZ4Nh4xKkk5yZRDY2d5/qCkcl+vxBiPAkxT61NjlEMMDVWUPGnw9BDdKrxJ/aXhKUuQ0d+p9oAOKeS4XZhv7C3tdSKg6M569BfEx13SIBwwdVB9KmqLDfD30Jr19R
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:22:27.2833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b60af21-1267-4dd1-0573-08d5e5751c3d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2634
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add these two hooks so that they can be overridden with driver specific
implementations.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_core.c |  4 ++++
 drivers/tty/serial/8250/8250_port.c | 27 +++++++++++++++++++++++----
 include/linux/serial_core.h         |  7 +++++++
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 9342fc2ee7df..a0bb77290747 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1023,6 +1023,10 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 			uart->port.get_mctrl = up->port.get_mctrl;
 		if (up->port.set_mctrl)
 			uart->port.set_mctrl = up->port.set_mctrl;
+		if (up->port.get_divisor)
+			uart->port.get_divisor = up->port.get_divisor;
+		if (up->port.set_divisor)
+			uart->port.set_divisor = up->port.set_divisor;
 		if (up->port.startup)
 			uart->port.startup = up->port.startup;
 		if (up->port.shutdown)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 709fe6b4265c..ce0dc17f18ee 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2498,9 +2498,9 @@ static unsigned int npcm_get_divisor(struct uart_8250_port *up,
 	return DIV_ROUND_CLOSEST(port->uartclk, 16 * baud + 2) - 2;
 }
 
-static unsigned int serial8250_get_divisor(struct uart_port *port,
-					   unsigned int baud,
-					   unsigned int *frac)
+static unsigned int serial8250_do_get_divisor(struct uart_port *port,
+					      unsigned int baud,
+					      unsigned int *frac)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned int quot;
@@ -2532,6 +2532,16 @@ static unsigned int serial8250_get_divisor(struct uart_port *port,
 	return quot;
 }
 
+static unsigned int serial8250_get_divisor(struct uart_port *port,
+					   unsigned int baud,
+					   unsigned int *frac)
+{
+	if (port->get_divisor)
+		return port->get_divisor(port, baud, frac);
+
+	return serial8250_do_get_divisor(port, baud, frac);
+}
+
 static unsigned char serial8250_compute_lcr(struct uart_8250_port *up,
 					    tcflag_t c_cflag)
 {
@@ -2570,7 +2580,7 @@ static unsigned char serial8250_compute_lcr(struct uart_8250_port *up,
 	return cval;
 }
 
-static void serial8250_set_divisor(struct uart_port *port, unsigned int baud,
+static void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
 			    unsigned int quot, unsigned int quot_frac)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
@@ -2603,6 +2613,15 @@ static void serial8250_set_divisor(struct uart_port *port, unsigned int baud,
 	}
 }
 
+static void serial8250_set_divisor(struct uart_port *port, unsigned int baud,
+				   unsigned int quot, unsigned int quot_frac)
+{
+	if (port->set_divisor)
+		port->set_divisor(port, baud, quot, quot_frac);
+	else
+		serial8250_do_set_divisor(port, baud, quot, quot_frac);
+}
+
 static unsigned int serial8250_get_baud_rate(struct uart_port *port,
 					     struct ktermios *termios,
 					     struct ktermios *old)
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 06ea4eeb09ab..406edae44ca3 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -127,6 +127,13 @@ struct uart_port {
 					     struct ktermios *);
 	unsigned int		(*get_mctrl)(struct uart_port *);
 	void			(*set_mctrl)(struct uart_port *, unsigned int);
+	unsigned int		(*get_divisor)(struct uart_port *,
+					       unsigned int baud,
+					       unsigned int *frac);
+	void			(*set_divisor)(struct uart_port *,
+					       unsigned int baud,
+					       unsigned int quot,
+					       unsigned int quot_frac);
 	int			(*startup)(struct uart_port *port);
 	void			(*shutdown)(struct uart_port *port);
 	void			(*throttle)(struct uart_port *port);
-- 
2.18.0

