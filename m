Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9126FC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D36720875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="e+w+OzTS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D36720875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932422AbeGIIV0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:21:26 -0400
Received: from mail-bl2nam02on0056.outbound.protection.outlook.com ([104.47.38.56]:20544
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751211AbeGIIVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNwLLXouCQqRDSxmN1kdJ1vceBdIffPALUZBAlOeCpQ=;
 b=e+w+OzTSxhG2e8GU7qogoMO+uawa8oaq6pY+lKdi7t28W8i/CjWFBr7IyXktFoXcKlT9dyjFGm2g2b8YcUxO41zRwySSvh+ybMyu9/sb55iNyu2zam+4mDLrut+O7XZWkVtvRnHTXFv3Nwk8KyyiQAn1HI5tPGZQ1P2FIVG6I44=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY4PR03MB2631.namprd03.prod.outlook.com (2603:10b6:903:75::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Mon, 9 Jul 2018 08:21:17 +0000
Date:   Mon, 9 Jul 2018 16:19:22 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: serial: 8250: introduce get_divisor() and set_divisor() hook
Message-ID: <20180709161922.3c43f599@xhacker.debian>
In-Reply-To: <20180709160942.11a74f7a@xhacker.debian>
References: <20180709160942.11a74f7a@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0158.jpnprd01.prod.outlook.com
 (2603:1096:402:1::34) To CY4PR03MB2631.namprd03.prod.outlook.com
 (2603:10b6:903:75::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dc8a816-8402-465c-b75c-08d5e574f286
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY4PR03MB2631;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2631;3:L1FUODb4qj1kwXts3ZzUQ+5RAxLfA6uI7wK/RaIny1qiLEQtJROyTsxE0MoHr3SZJTQbEfXoCtdrBRuNyq8rI1SEFOXOMR3ISh0p/oQBVSUXLi05mZFqbgWei9eOcDalvlimY0QroPfDSQ3NOTR4MqmvORF2u142MyxC+6NcM6D+HGb3bTTFGXgSLKokHNJFDyr2LxeS5vpF/fYYqEewTqNv7KAjfbxe5Ds80gb9IF3OvVdPpksIyhOqixz4E2XW;25:OkDx+Q4gc9a4fKzUOZJgLunhE8Y3ExvOUNscvbACbjUnZWZ0Vqoxpiv0H0j9Efo4x7LjThMdzcjl6VScES/xjLXuEtq5XdVKv1mPo/tncYnH9VLoqGl/A/xKqVns0mH8vtPwMVMUsw2P9KsO9jjjKXukRxSIg2UBIGDWSkIIH2aLCOcIdlJxDwWKhqqZlpPI6ah++3O2VtGLKrw3VuQbN/WFzYcFsf+NmbNTU+FtFgpYp04x0wH4N5Fz9UWHWKu2dtnkmwo4sBFBtBW4c4hGGcOb4kkdLdGdF+youm4ctA4xleMZzUwlC6tk7taqNtUjq/VhLXv3wDIoynGPUo6zlA==;31:GiW155nvZZVp2tGFkoVlZxO5WIyUgDopaxAzWtgAeinbJTvQ/6D2dCblQ9I/P+BgbPYwVA4Qd/IU9mLz8WsKgY4YFgmAN1MWjTr2CVG99Qt/GKf0FyqwDY1ytx4aACyH2Pe4ChNlT/5DOdyuKYKAQ80HlrwCKjfgY3TIeCu5+JnMbcPVX4zR7+Kiq7AA0mN0jeTJb4X94q4/dWBm2nOzlyRZdHhzqyTVMFENxPNobps=
X-MS-TrafficTypeDiagnostic: CY4PR03MB2631:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2631;20:ii9d+IvNYhEmV27741kJP7DTwsQ6tzITZpmEkymsT5Ws42QR1parWpbyvUByRiKULTwtFDdXROcvzJvA8rBFH6wAbYoqsZru/Hd65PWzR754AEKNCgnbuK+44x99RqgYebfCljpU/L+DqAxj4aHJKYuERhrmyuJtl7GlOTw488QGo3v1LX4KXXtH689UNmcHpH+5pg2888PcNH2rehrPe/iDmvL0DHib/PF9F03YQLU7s//MkjsAf0ykkcxcVs+CfAsO+LgtPa2LOuSDkOeCQ5vREOq6JkzlD6HvaLptigGW0+GkvlbrIeSEnApzjDiaR8gZcHgj+b67XAf0A/59XQ0a2CKAXvNfMoKBC6q3CA7XJ+UfD+23T2/SCsJlOjmwgO6NrcTc3XDMqlZ8rgJkg7vp7Nvjjia1rkpXzM2xkaJwpb5YkHySApY94RUyU79lASyPkSk7lLKzhAbTcmKjD3sCyemYM3dAOHqZbLzs3avVv6bC4tYvJuUYdBa6Aatu;4:eWbhkyyKpREJh1SgZJv/BGfz2KdU4wibZ8O4OVDhBjBm+TAStR9lPp5ZMnY0BqkA6DIWyhuEIbUWovbMb6yjrTAenqr0Py8DhJlHe04JGVKFTIdE4KMs2eLb12ofVwNjSz64wd6jrO3VnAd1NGhYNnoujGH1zDW3euXD1UO0vbJosNx9lnZswE/kC5+UqLzLssGNgDLo7BsJtHLcwl2aPdyc+a16Zikgj8zsxKrjdSNR3Dwv0uwB9iqu0DXVNjy75KVL9hpGZfYrQ/XIzIJM4ysN5rS6FMnHTKFtnbth+ydmhFG63HA3l8/aCkCK92dH
X-Microsoft-Antispam-PRVS: <CY4PR03MB2631FC2473E529272D215824ED440@CY4PR03MB2631.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY4PR03MB2631;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB2631;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(376002)(366004)(396003)(189003)(199004)(4326008)(186003)(26005)(9686003)(16526019)(55016002)(11346002)(7696005)(52116002)(386003)(6506007)(76176011)(33896004)(476003)(53936002)(7736002)(446003)(486006)(305945005)(956004)(86362001)(575784001)(25786009)(72206003)(230700001)(23726003)(110136005)(3846002)(50466002)(54906003)(1076002)(6116002)(8676002)(6666003)(2906002)(478600001)(106356001)(81156014)(8936002)(81166006)(316002)(50226002)(66066001)(47776003)(68736007)(105586002)(97736004)(5660300001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2631;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2631;23:fEsL+2f/6/825mpCfMQngXBTxPRTuWr6yy+79h01e?=
 =?us-ascii?Q?Tdg28hXf+FGi9GGtnvUApIc/INKyt3+K5uYAJnqsUDVu19CBUKjezBZrHLy3?=
 =?us-ascii?Q?5yjM3LGc/44JAiVzjdJXTydh4D0i+D/wxiDhyLHuX7xB4YLC2RMDdWsONlMY?=
 =?us-ascii?Q?yR9h0266fMtFkkIB26Z8YYxsvYePwSG9TnE8q52OPPQG/M4G7ALRiYcNDpW7?=
 =?us-ascii?Q?+V+uxaloopqeZYMUbuwpS066nWsHwEHJNvm9emuOAjvKpyIGLUzOoT4S8DUh?=
 =?us-ascii?Q?r+JQ0BAVx7ySzXQHEPv1NatIR6cRCdXnqsGrL1Kw1IOQhA9q3fLwTW5rTtit?=
 =?us-ascii?Q?JKkSARcS1JLbRCpH65jqWfuMtAE3JyDbOKmyPJGI+i4W7o7Ye/9WIP9aLLk2?=
 =?us-ascii?Q?hlkYL0b0vXXM55f0nIPXlATtJD8VVboVZHrF2QrFvPeyR7E1Ydw0GOb0les2?=
 =?us-ascii?Q?sySy5MEQXcNSnHgdZwlGpjQTeiLTkRU+XLXQ5dmRFauo7wYqqAY8VRHQV1ws?=
 =?us-ascii?Q?3sdR7VrG9sP5sO1WOtcyqY5TBPycxffgdGUm6FuBBQn0c7srlrsKoO2ZhxJi?=
 =?us-ascii?Q?KyWD5+xgqzOLB2cWlnQTIUDydUOFS3dz9EsrcqZDIYg6vDz0ipv3WjftqiSn?=
 =?us-ascii?Q?/yh5skTw0iLdqjBHi5aIj2Ak1sc6vBPZtJZt0+edkgAYnG1/bmdm/Ms7syd9?=
 =?us-ascii?Q?bLZY6poN8wgonclhSQCaGyTCq/Hm8ym2eYzVJkrj2LWzwxHQ0UM3QsAVGLXH?=
 =?us-ascii?Q?S6Itd8WmyKH0qwdLpzrGO1jRdJ596cL/z8+0aphje5UHDm4XegYl/2UaWY4E?=
 =?us-ascii?Q?E5q/tZHDuP1FkXcZorui46Y68uggb4IbzbgcxmDPn++ooU3CAvhMQYGuOY0u?=
 =?us-ascii?Q?JRMCehWBiOTuV6i3QWpn3HZ9Y/+9yV5oz+J8IokXfQhpywOLgaNg35kRmVVV?=
 =?us-ascii?Q?nLPm36te6O6eSYqpgG+Qcw9W+XdwTYg1zkANU0fp+xtiy7RIXpxcBpuFyy2D?=
 =?us-ascii?Q?BbyyiSGLyZ7lyWfoqZ8CkrqJkWYXZNOjCdMLEMvET9U+x/yU/nV58O1HMLU7?=
 =?us-ascii?Q?yYf+iu1nzb9XJbjJbyFBieJTJxtWiYp71OFWGgAy4wbuelVeLFXdQqcC0Gw+?=
 =?us-ascii?Q?Y9ZkPNn1WzQNwcMmGrnLIQu0+edriGX9UR3P6lc/kCt5Jo3nPwYaRp70y7sI?=
 =?us-ascii?Q?HHaxVmCS2hJbh7Ikx0jJ9DmZHckile44pplz0nMmuJUHpL6iKXO4sHjV76f+?=
 =?us-ascii?Q?LwdA2anHKvMODc8mlegdLCSpGmluqO9clC1piyi?=
X-Microsoft-Antispam-Message-Info: kDKWt6lM+hoyr58hTBON7XmKpeg+xGKwr+I9qsvYOboAp3OCgLrMwHEcUYaZhD7lcYLE1dmc3xtYYaxlauOFaohZSyW4OnSeVwZ6HCsNymfY3eN7eBmrCb6fiyRmzU84K/IA24uZA7GG+YN4O9HvpKhpU3qJvRnShqdgB4sHM0DhibdJ7IUL387LSj611+br1ayZe862Itp7cofNbKcSy/SDnIwjmWqBvuSaaOUKwxh77iPVwvhwFgAdMbOSjpzp69MBo5PKAIbuizrFaQW38uUESzooH35Rl4sf/ZnT1wOT2tueLA6sxKOc+aHsbKWY7sjmeOCpvC7mqeRJLOyk9V4wu52vE6uE6dgq1uSTDds=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2631;6:U6J2/tm7fMkM7xRWtvjp1RehCLhPAUtQ/QdVM8sHckABybwVgXPdPzWkpW5REJA0HanTdY3naczzzQuzJwKrrsgoGZAvGpPl6ssUjlChh14ck7Tr51K4UvGk1DwFggVfm2v8BJTVI9cFR9DW6JSCcz+bWK/gAuI9Em0XGDhDzfy4XTxjil4Qp3/Dg72L3pzROF1oOlsbt5X+OpkldfyI90t4mjgDcTJKJeMSW6NIIQJSbbxylaWvpkUIgbm1smmbkdUN8pj2SOsy2pFiLTD3ShPyC9uQ0udtOkz/dG21WGiLzvsCMOUzkTAQzPAJ9Bt8UknEcqoqDx73wHX4hFzlCjM6Vdnv95JHEXCZ6vkCOFx5AC0SWX1CKRi4Gm3ylq81HCem9aIAvmY1/7JPCy8dCCmcqHQsD1lDpiHOsoGtrK17UeQ0w1oxrPQgCsLeMqBHezD0iWCX3+HSRyPqgrOldg==;5:F+v21E3M6pGasDDNOll+HAyJQGbVrWw42hvUDyfQH/KMEntM5ZrzmxOOXT8sNIv+x9l9ZvR/srDoeNG54B/TOV0sOAvUmW4N/ILPv8EGuYIrtejTDZXaTZkF3RsFcO93guvJJ+Rg9i6AC6nbInZeVhXNb2rKH2E1sNBqYjgiH+Y=;24:Yk/DwWnXIf6CQ8AFeBAX2Ek9Hv/u/tctyBq1YYDT91DohtrF1UTZwHCiTzL82EKDWtnmBdw9hLUmy4z94Z3zcFKyUgZB7Vc/sHjCvVJLDBM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2631;7:RRmsjOTUclKiUM5mrboCmdzNnH6kEErVY/R+tb1G/jpPMxSqpQfpdq5Gy6hePT5tyQayIFe94Dtva5g9okieSjg57F3eFmNAdQtApSYsfkymj00MWLpYh5g72BUG55bP/+jVchyQL3c2RktqDwbQcj2OcX8zRRa4Y84q1qI+aQJQn8xbldWJsFs378eDfeWvDm6BbQlsUaaqCH67nx0Dtr+l3h9RgRpODLcWHbgMkkBgxOEKarsBdFepP4Me1DoD
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:21:17.4491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc8a816-8402-465c-b75c-08d5e574f286
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2631
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

