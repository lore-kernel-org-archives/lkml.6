Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2794C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6AC24207
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Q+u7ukta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6AC24207
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934453AbeGDJER (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:04:17 -0400
Received: from mail-eopbgr710052.outbound.protection.outlook.com ([40.107.71.52]:56126
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932376AbeGDJEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpN89ai6+Xibe7/1Nhfr8SnDaEN0seF0X5gaMAii7rs=;
 b=Q+u7uktarnJzDMQVeONE9Y2Uxw+ZkH83E5GfBH2tbfAyel8Mmr6FZWl8AdPxdd+jKll5gmACNfNq1FoaIq9rqrtLA0STB/q9QyjShkrEpokIzxSpibCxKMk1oj7zGb+ciF+n7X4xc+boJoHR4jjwzKhwtfodoxhl8vqxiRbu4bM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 MWHPR03MB2639.namprd03.prod.outlook.com (2603:10b6:300:46::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Wed, 4 Jul 2018 09:04:06 +0000
Date:   Wed, 4 Jul 2018 17:02:17 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/3] serial: 8250: introduce get_divisor() and
 set_divisor() hook
Message-ID: <20180704170217.190711ef@xhacker.debian>
In-Reply-To: <20180704165908.4bb8b090@xhacker.debian>
References: <20180704165908.4bb8b090@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR04CA0022.apcprd04.prod.outlook.com
 (2603:1096:404:15::34) To MWHPR03MB2639.namprd03.prod.outlook.com
 (2603:10b6:300:46::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c79730b0-8d11-4470-1d72-08d5e18d19cb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR03MB2639;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;3:jymd4sFQoHODL2TqpCLTHc3iz7nmOZRMFePOncHQ7cTUmKw8C32/1dUYovj2D4MH2nFvD7U16/5ysAtl54J+eGFQPN1G+bEt9OWYlCitzUk+eADo7qGZjKbl0CL1s8gfDGPKz0DRXMfyuVe/WAXYjC9ukKAgBbUPwNTnKhnqf0OH4KIV/zzSGgTGYcCp22OTr6cGwIDDpPWu4CxTt5rR4o1ogLM0LMSlasHDhSg4CTQVe1VNqA1M7wdML6u+kLg3;25:YEPvBxdza+X+ERrPSi0SOcHmKipzIojpF42thRzjlah8RQMhARhaDVeDWyAyil2fx1Wq4rI9RNoLJ9PJ5UDtTuxt5E5JgXoXMsqEDKVGlsuChpnLPTAv89h/9fkbItE4Wkz99M3Mcm9aLXUAcB6M/2NvQqQyAFwqQ5NH5ochUerd+mcCvZ8IsxjFQn4BLIZdb2APAlpWcorJLDc2eqtB7rsoJVE05/vEdBcCRfgRPOkGTYvZPQsH2okzm2YOAXaWhc7htioOdkr5RuTk603GFYxRMnq9TAq/HbnQZPLNFRJMlug9yUl/WBYKWWXDYhMzHul+9YBdxS/VRXR8HahOOQ==;31:xU/vDrpNLGwBJCxcNG2GADp2xGY4BgD0CS/iR30di9nG1y4vnO7FTtZ1gW/DqS3px2aFO38qSgpJoRgX9hI7DetUuBvoj24/z1zkxTjxNA86hOr9lveQTysPPaYXY1fZLPs6W3ziS1iRPbRPb53mwpu1OmGa533RUoWmswnn4OilZpalroOLo1gnDBYLkHHzxW+kOsDcNIsaDOvRfOv+TenHNb1h9cpFrkLtbyPqUcE=
X-MS-TrafficTypeDiagnostic: MWHPR03MB2639:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;20:iszhnwNCvy1+WYbyWwBzDclWPmFHfJ87gH1KfD+tkK+vd1+V776Je6FOPOG9rR3Q9I0kUGrUEj6CgnD55YrrNWt5E+bfpUK7A5c4KDtPQ9n1uUlwhgzd/x3bIvcsxLEHFo72KQqXet7XX4jZRIerbm3Pzp6h4psp1F4Ok7r2PCMtVbMKb/KUQT5PGkB/rDgnfnAQCIQ+AHaSHnxhkBybnHKWIdmqcgE3KsCQz4oBQyhMQCCIZOaI+bCQ5gegjL21AMrPL59aLL5Kd87DYm5PK770dDwGS7fKUMRLQxSs7hXUDpKNBZ0iMD4DITtfVlMmYnb60jbZY3zg/Eb6GrrM8vJaU4dAuiD0uBnNzrKoYP1qO5gb3tE2k+QpgYRFweM476q9SWrpm8T6IvpFn2+k/cPr58GbjjgAy1IcixDLWeT8+lL49XhPS0uMgTof9aJgHdcmoZOnrcyF5lUJpAr2wYgEiPOorIaQqFYFoWyFFHEkOxEP9amwGTEtF4HxzS6h;4:ZnBSiZx/TCv27sLV4y2OHwFMkDw44tOCUS3US8VyIcWESCV5O6F2Yp2lKhcj5o4kR52lDjGs6syfZwbaV6pUsSXbxNAUlWUC3+w190zH1Aj0Z6qU+tRP8J8HoEPcr77gHZidUeUREa72PyaYelagavj7epNYl0/chRKswczNKq8V3FNUwqZXApxVsyIeIndhNmJNr67AG93rVPE/egg5IjOICNsF9Q0UJhnHjqL4ktNKosOaP00MdelCmutCsgIpGLb5tNfGennuEveHbtniDQ==
X-Microsoft-Antispam-PRVS: <MWHPR03MB2639D8F6B90A19190BC5F333ED410@MWHPR03MB2639.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR03MB2639;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2639;
X-Forefront-PRVS: 0723A02764
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(376002)(39850400004)(396003)(199004)(189003)(110136005)(52116002)(86362001)(305945005)(9686003)(3846002)(55016002)(6116002)(5660300001)(7696005)(76176011)(53936002)(50466002)(33896004)(476003)(1076002)(478600001)(7736002)(23726003)(11346002)(956004)(230700001)(486006)(446003)(8936002)(386003)(6506007)(25786009)(106356001)(16526019)(4326008)(186003)(575784001)(2906002)(66066001)(316002)(26005)(72206003)(6666003)(68736007)(50226002)(81156014)(97736004)(8676002)(47776003)(105586002)(81166006)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2639;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2639;23:itr+Q7WHWhYrCJPGgOnpErraG0OoqBVxUlQJ/uLWi?=
 =?us-ascii?Q?ocPMWdE7LCNejewO/LHIOfUVa/7rBuCL+uGolDCxcVWUNBTlKL2GghIm8u7R?=
 =?us-ascii?Q?pU1rC0zZvyr6gR4XiTa2TU6LgAWtFrdwS/ELktuG8LJtp4taNV9dyl1/U14b?=
 =?us-ascii?Q?zQVOCbzVhqxdjgVSb6tXoJLhalaiKmkK9c95uNOZESU69t3lzJVr1bibHc+d?=
 =?us-ascii?Q?BM7k08SZwuSpiKAS3Ce85SaTIToHvnxYWTBopres3tVhRe41SWzY3cwirEhe?=
 =?us-ascii?Q?LEN78I88xOSlQbOawGJJB77W7orpcJY/RybSBg+JHh4goLtU0PA2avACF7Qo?=
 =?us-ascii?Q?Nsf9U6nF3v1VdgBK6WyM931ZaiIRe5M8NKEsat14RqB+CSOrjh8GFLS51j5B?=
 =?us-ascii?Q?mHDSyqN/Vt6c8neAZmPv8YbNW6YBTKyy/ei7jsQ0GVk4WEijfwGXqlGGpDv2?=
 =?us-ascii?Q?rLtt9GBwPhBfAF280hZ6vQV2O3o87QacKoN7ragSU43fq6ck9yn95iPPcaF8?=
 =?us-ascii?Q?eXX7kU7YiyFQ1pQ4400LiLznfwKItJoxQMsTArc3s8ZGVSHgQ5HODEG47KjX?=
 =?us-ascii?Q?nMNyWLN/morTSP1xAtZmkPdqremndI9BhUWDMFWsDeCHKXvel4/4xqVxQik7?=
 =?us-ascii?Q?yUBqBIXl2xVGBr/wYXWy5v+t/s4+Avi2y/kzOO6w/N0q4ydk2iNpDyN33sRM?=
 =?us-ascii?Q?CxNCcg3jAed8PmSjrW+m4dxy1FbTIU10TLJRoFQTuZVBsg/Uh6edSySUbIoV?=
 =?us-ascii?Q?QglW1c0LlU3cGZLO1HxPLy+OAs5ynGSy/vpXOvzc6HQU1kY+2V627z4Hhidk?=
 =?us-ascii?Q?xTWlia0y6754SHxlfUUXIisTAoLa4oFakTWcePCGzaVlmfUARhs0hetVwVIw?=
 =?us-ascii?Q?vhQLoNdxWM2ZKwCptMKW5NpLdvTPyadTaU3C/0ln/E02tlAXhM5t0u8Bn1aD?=
 =?us-ascii?Q?XnnTqK7ckOwgA+wsXKz9EJNEp8gc3iKlMy5u8egeJE8ngktGMvr95W0adz9K?=
 =?us-ascii?Q?HTxRC2pjyIKIyoO3+lLp00HGZUI3r24FuZeCB5Q5yN1Onj8Yi7tOR2XBDbUe?=
 =?us-ascii?Q?GYrvNRK5Z0039yWlLe2woKssoE8OrBEIMNk1P0R3KquCDbppPoDGPPjHssHx?=
 =?us-ascii?Q?7+ihTIM12X6SQbhRkkizgDmj+Vnla0O70qyoUZcZJ8Z50+d6c/b7KCybtVsM?=
 =?us-ascii?Q?ja2QppBdW9bwp/ytzHEEqlO44pjHPixFDpZtaqxXPzwYkbTRR/RaMOXwxxj4?=
 =?us-ascii?Q?CyP3vU+W/DLOFbJZq0=3D?=
X-Microsoft-Antispam-Message-Info: PGxE6m3lJbhIEhvFaWYVbDI3TZM9HAIVQGYLHeSJK2pd+Bj5MQe+XA9sCLzsNYiPQSy6oQ/mN+kIlMbD4B1ePHbZFBpkxeDv7QmhqdstANiBXGjyWk1F2kUyopwbkYGOeCEwuBYvcobJoAhR7mFUgCBVb7J4a5zIdNHbnc3AHWosOaOwZ1gqGZ7I1r5ogBLoPqPXbiV+aUesY8SmPNvFqeqnBm0uGOAq73ancLxNIQ2YEE9bHLnMLe6fQDk/Yd0MDRXANnOwM3DZUIOy4d8IPqAu+RlK+0OqCWPuFzDf3dNpnDPdQ9ZCyDAI0GZt+Vpm4etLE3csg9pbMekzo/KPUpzdxcpZZaDlMnPsDHkNsQ4=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;6:QvHkgP8eJCDRaZzGRAb90ZaVvvzxM4BPfpsyiVGaRUeze4sIDGM32hRXbSDajRm31k9uH3K1LpNuIboMS5gKzH7ov4biTFDk08zVEFMBtNEsc5ffJcL1RFiJMpOQ/OAYD3m6pGRfUSy2uxUy7pyNabxfOExv1zz7fyOVAk28I7l8Ty7LBaY+VMo8O817B7miWydNX/FUWRzhASDFiMPsbFSxtRsUnWnls8YxMj19ezqS7DFVO0scxUv4IRIsFEhneVgiCAsGxUwvG6UX8+tQ5F0Bq6NjkJ7qPIk5ZDZjgy9sdayQdhejkpcWHE+iVUkfmhFNgnCycwJdoI8Z3nHDu83UoWXW95hgjgMTC1uspm5kMQ24zVN3x6Cjgn+1iP5/SQIy8Yi+WaiZENN2GsibRh3c/2irapuK/zKU7A8PNEEVyyMRfDbeBIgXfpocz/6yfUc8io1fOT4Qk+ozON+QDQ==;5:Gzmyaly6qZgC68XyBbtR93fx1xaX6uOt1lKyah4FjvvlrL/19RfNDrfo5JUzuMxZUs0D5N5wQANYt6S/YwyemAzWUNq8VAyx/ZlVZDc/thhrU1IEOl3t784TXAjBRACWSspXKX8i4ldjUqVF47Ak2efcVWifvE+06/umWsOM02U=;24:p2WRt2hxItZ6R/lqU4RByvjPNqpc0TRZ61V45EEmu2Egl1dZhI7w0032KpjgalW+R6U0/eHe7/IpS6wOhvbHOWrPIBVh5LMJWEh002TfRVU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2639;7:5nbmdBsnu+YQctd54Wc/2DEwFaM4lqW+2kqnUHKl/ZoUwyOCyeSAELMH02dMbqdrUO2eEW283UCZijBzlV7uJDDXL268tNaLsWiMw0AgXGHSvEgoyyxsuvCzsQYs1ZVE/0qjLZxpUvWL6XJl0X7DprKwTdEfWfaEX9UNViyDjkrZMtG6cFVycsoXDmtDZ/75ckE1/iDjHM0luvYLQFs4QBI/M53NGKXqtr36fCEc43O+1/j39M0mqe2Hq9JFWg3F
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2018 09:04:06.6179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c79730b0-8d11-4470-1d72-08d5e18d19cb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2639
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add these two hooks so that they can be overridden with driver specific
implementations.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
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

