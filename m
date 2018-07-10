Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F622C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 03:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045FD2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 03:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="HO0whaNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045FD2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754594AbeGJDQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 23:16:34 -0400
Received: from mail-by2nam03on0054.outbound.protection.outlook.com ([104.47.42.54]:56595
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754551AbeGJDQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 23:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkvLDubnQoXKOsaraEE5tysys5NXbGMIcBYWCj1zUZw=;
 b=HO0whaNQWb4a0nE7Z4gb+wHcs6nDM6cKx5X1T7PYVdw6NPal2ItQtLI3CFiaFNF8vQa3KplJ/3hNs//sgPkIlvpUOuXWep2x0X+KZLHWniMWrF2att9Bh3cTsw0NCILEs71W5o6nhoMGdKqMJaA8xLEOQjprwnHKTn/pZkfGn/Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 DM5PR03MB2634.namprd03.prod.outlook.com (2603:10b6:3:43::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Tue, 10 Jul 2018 03:16:23 +0000
Date:   Tue, 10 Jul 2018 11:13:27 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: [PATCH v4 2/3] serial: 8250: export serial8250_do_set_divisor()
Message-ID: <20180710111327.072584c0@xhacker.debian>
In-Reply-To: <20180710110942.5b0a016e@xhacker.debian>
References: <20180710110942.5b0a016e@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: PR0P264CA0027.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1::15) To DM5PR03MB2634.namprd03.prod.outlook.com
 (2603:10b6:3:43::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cad5610e-0b57-4cef-f324-08d5e613855f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2634;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2634;3:W81/Fc9onxnCpzv+25uGjsOfN346LVNErBg+CSc4yvR2LsbjgC9WStt76mw1BPaF33faxafsCTjpxAO+J/yhdqEKvjtcGZue+iTRZe2r0t3d1is/h2Xer9q1Kt7wTFtoLaxUvTS3A1bFZ8qhoZIeweSYRojFlmeaC22Zl8VCYZqykPoDN1xNFE+G+8lQHFgzlaT4MK/7RYg4z1KerU0V6j7k59EZd3am6MktT76j56Ybl+/wJvfzX5CPYwLcgv+E;25:lAWx2yGSJMd1kdXhqJasaHRDb64WB09COoMzjU67c0HS27Q5Ae7sJmOhd2GVEkRdnLO9khiX4xDqrx+VijemPl/Weo2WFrr53X7ypobrWOvsiPC6DeavfohSRpzKVBrdJoWkfz8JaPJMLJfABH84PghxPPfFJvbWvN5KfmA1YdQV+7/pxLhaGzqv+ToR8sZsqlzXmjWBQAL5+t8oeiXKhln/1uDSrC7OqLhBfW/h1iN+Rn+elLAM/gFeU16WzHZl2KIZFBpsFmq9Pg7jmCUnyGLinznX8Q/bp8CLEJkoG/QXzz6U8lZKBHTxdFQJe68V/VOrvgTWYUQcFdy6M5BriA==;31:8pCLLB5QXFRtYuMgrOinaTqi6RKTOLQ/MeBYHb7uBEQ9pKtssvRnYKUmQ2qTz6qhO2aJkByoNFhz0uE+VPPD7Mr9mPBGP0HmzaXHzQsUEZTo3yjpMpFEJZI4kiwJ8IqoJ6w8xIMx4l7wz4m2QVSgwMKM9yAqqliOtq2c7M591jYRxavovElQ9D1WbHYH+VgWnBslTXEkGn9O9d8nxOtjE3IQTxAzIvj3MnNDnjUvwCE=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2634:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2634;20:cy+/+XKdYciD1COQVyZ49wOm89vFzo+3UhiajSlBx6wyUdGeLEHd+MAcSacpqeLuUI0w+ssQKIsmSjqvA2YsuSEwrDfril/n3Pza3IpQkIcsdmYRTN+J8iHPMzHuR4U6/g1zhD7ZhhNd8n++D3Z/mHlB9nzPfLLsa0LQCpaOkhUGJStVv/s0azAxdFmnp9vPlucOxiVOacXHh90f56N7FVEOWmyAf7JODwepxkdmfjeXS5IgQp16J4jGjj5y1qstPrLBFnKAfHSCsBp8CMRibn3mbpABlVr75cLuSVIcuUgovVxGetnfd+MOlhJI9qNkD0onB+oBwXEvsNVeDQEUHfCpR2DPOkxTByztJb4k65OoxmKL/Rd+naoMTvIx5xROmxXLePz9tMpzR3vD+ag34/C7q8MuArzWdkY5Mvu3/B8lktqyCYVB14XhSyrHUTVYeBAK0esryOG5rNyfbpr+hcWKd1DYedh0Isn+lAKZTccLxUOXeiWefaPliPOPo/9g;4:2B+vtcm4DTGgv39mKVVMXK1D0kND21sl5Ec7wE5KVlfCtm/kg7goJeiqQGxSrscKsvVO2sHUIjpvzJ/hzZIfX8WRqfWAk2Yv26b2lP44U7295zqpU8KvNTNThHbvSchZHrUfMmgYqtGb8MujO3Esi3DPJYlbLqn/8Q6X/yim+RajR46YOl3UVwKLGeG1Dy+q7tuzMdfIPGE89uTLSiZJ/xY+Il5Vk4Yt7WrdSAZIkuKI0LfX4ejGVa/OJrVt5BzbeFbMoUfKWOtBIaa+GO5b2w==
X-Microsoft-Antispam-PRVS: <DM5PR03MB2634DE41B7C6AEA1FA4603B8ED5B0@DM5PR03MB2634.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM5PR03MB2634;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2634;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(366004)(396003)(376002)(189003)(199004)(76176011)(26005)(486006)(186003)(15760500003)(97736004)(50466002)(3846002)(230700001)(9686003)(1076002)(6116002)(23726003)(316002)(105586002)(476003)(446003)(110136005)(54906003)(52116002)(7696005)(2906002)(956004)(72206003)(478600001)(25786009)(11346002)(33896004)(6506007)(386003)(16526019)(106356001)(86362001)(53936002)(575784001)(81166006)(4326008)(50226002)(66066001)(8936002)(8676002)(305945005)(81156014)(5660300001)(55016002)(7736002)(68736007)(47776003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2634;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2634;23:39VwGf2IvuNKl84xR8uVtCp8eFxk/9V1VVzw6BuGp?=
 =?us-ascii?Q?CDSxIpCy+WZ8LgxnNXUEfIJTG1UhufvpCuGyCEZGrBosuhAuEnmpSHm9rfLe?=
 =?us-ascii?Q?eX8eFm67G8kSv/21OARxyG72xv+2j6M6AXOcACwtn3I98ezpvMWWQy0wYXmU?=
 =?us-ascii?Q?F5ifmbp+BYfreM4QRcWMl6zPlVoxnfAgQTnodWHwGTPU9NecdE5JXGHGDwXg?=
 =?us-ascii?Q?IXCR6f2MP4V0iBp1zVxWoZjekmCUMrI9a3xwE1t5R2BZs1K8bO8D3YCVwwM/?=
 =?us-ascii?Q?bVuY3p2LOWpIQ1gPU+htap3q1xyo/9TFaM4hFlz7kKX7fTHmIJrdhvgnrBNH?=
 =?us-ascii?Q?9fIUXCeHid9sNXV4PTs4ISNFCAadJHQKpY/+YD3fTScbArzugxp/lk0W59Vq?=
 =?us-ascii?Q?rkecJE+tMRZTE+xfteo9k9ZD4ZHPxCSkPy7AdvPy1Z7HrAWM7O9omkFL0ASc?=
 =?us-ascii?Q?tY/hsMliT/zl9cB2DfsO+07Nu2F0muPLXHZWUsT3vN4o36nijdDZZ80YCT7p?=
 =?us-ascii?Q?W/vNCDyn/ma1d4Ewl8eo4Tm79FeSDM7RhK7gA5qJ6xviwIlwmLmT9qGVCpln?=
 =?us-ascii?Q?GDCfOioRlFkg9z5kkHHj47xDgeeBvqKk+5BGJmuX3pDBxOS4kX8WB7sRrKRH?=
 =?us-ascii?Q?VXWjXYNXKBbYvsXSCQLhfIHfSJmQBjN/MhB2s78PaYxl9W92wxKumAcOKZhF?=
 =?us-ascii?Q?Bt9/DlaYk9qEsMEA54mI785z/FFpyTL0vMAe9YUtUksym42ttJiR+a8DTzAK?=
 =?us-ascii?Q?Tof7Skx9Mbmnjz3klKWX+kD7kf/VL04LbE+UfMeXeY0HLTJddWDA7XbWbyyX?=
 =?us-ascii?Q?tkpPGgd1/9wubmSCdZmKJXWrwvAVQMaNgLfZYcJihg1c55HmnfzydRkI2h0G?=
 =?us-ascii?Q?KqRLzwUbFzo8YqGkjk5/BZFkI/tQFg6l+gw1lcB89KgFO4RYg1cg8Pc5sq+U?=
 =?us-ascii?Q?vvuXPX/Vl/nGtIAHTR1QcrblFAXGtcl/nGzVGDaJhoyr7N7fFawjCHqWAHgF?=
 =?us-ascii?Q?VntdJFKLfls2ukefP5k5qEdgBUBO7HoSITMmDASVzb3ROnndeqiOBoVzptVH?=
 =?us-ascii?Q?Kd9Gnz4Z5V/NlOoPEZZT3C9ulUBV8f8Q+IhhPu3PerriJD/4+e/JsxOYvcDc?=
 =?us-ascii?Q?lKA3rzeXLMdMRhw91c1YKcWdk1T9oFlq18aUBqlGGsBauBlMadwdE8aUpPnZ?=
 =?us-ascii?Q?M+e1W7inRJzfLiE3HE2WcY6FDdzlnJNujdb/SpAaDTABQ8JociLOwinx955+?=
 =?us-ascii?Q?pgi75LaXS6igVVoTCBfUKJxkr5/Vv+QcZFgvlBE?=
X-Microsoft-Antispam-Message-Info: 8NnBTcw+TIicK0+JqUKAF7OsgF01sqJh5RIwmlbB0t5Lto7/aHN5P8iXrqXYhjIpBGLLAVQRdJJL6r9HfhnX23cyywYVNqbjXDvFZCl1Aw/gWSn+y3Zx+i5z1rzSppflrYH20ECqBwBmDIwoBc+I3Zpr5y/4vir/fH2vf8gexCcd6GvxHcGdTce0b68s01y0iG3qOyKZhnShBxduMFmtIuYx078+OoPo9Z6lZdP1ZlZ8nMc3urRDf3JPNLOElwAsmUxYAP2msJiqe2XkaMeDJPq6XE0roClVMnoj7LXwPiEVwXVQiugTaTcXZeKHYBOWTooxQoPm+/cE1jMa7V5cDcoNTbN7DNEM4mgZE4cPSSw=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2634;6:ogkqoGPtCjLpvixERaQ0Kq4ddUhexwpDmAACttN4R04/J5eSPnfEJ5TKUJ2raBSWDq9/Yin11UphbQ3AVzfWl70qqlWJ4xzBzkgeVplTacJnDS67pJhxOmMHw/Y5LdcSxlYBCjH9oQrQWPhtp4DkJDy8jZA2obBe02baDRZUG0n2h1TtkiN+3JnF4+k1rB5+QnA/6lprXG7Znnh0V/CtWAV+h5J2+y+lYvHFubgVTcwqMXvfAHHjL2ni+SVa9NSYP7sCg+Fq43DHOqmytKNmLKGz1jcs3JA5YJAmEGlg/Qb2oN0gslgfg4D1zZhWkG+uBRNgFIqKVGZZnufJqPTLvyY3cYrpgqXYbSoRgjar44H49aZSPIPQeynzZbaEpUD6jK4oShMsq+NIO3ZwCAWcwGa6lVkKkqnl0CwcPVCYB3b5E/pPJ6ckli7CiNke+z7IRr5gQP4oXYZDSgtDIEr1Hw==;5:iPMKLvy6VbfXA4quAacfq1Na7WrsPVwsnIUjGknVZ0RF6/aDvrKZVuM8sMJeh5Yg4yoVg01oX1lWS+IiYLayCJikEs7sD5B6IEJ2EcRDpwXK91iTOgqk20OFP9fjbz22/2NLpUmzUvrbuBpVcQwjRvMcq6WrfQRfplpfr6A+XvY=;24:vKWQBf7gk6VD83scDjd0jTPHeFwISCgph4aKQYjjpqSmnfWUJ3ggPHEg5gdNULogQMsFJekDxrguUHNC7x85b0ioiUCmmiJQm4YzPTvn5rY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2634;7:TtHKRi22YPU2/O4JJQ/JJlwIcJxJzZA8M3uFlrzqLVi/cjyqJNUd4B9vC4BP2jM8RXxa4ZpQEGdYdAfuuS0rkHdkMh7OnXMeZ0gzXumk0a6KCXElDZGPoGbYgvsjAFDwumiUW1s0JFY/H3lN4P7P75abI46g12QPRfrGZTG0v+UAmE+3JInoG/jND5NBabYFtFx7aMftOFKplpb4XAIdEsFU4IOCVvNiUno0DDN7AN90JMWjFtfvz5v9QMQ3VQR2
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 03:16:23.2865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cad5610e-0b57-4cef-f324-08d5e613855f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2634
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers could call serial8250_do_set_divisor() to complete its
own set_divisor routine. Export this symbol for code reusing.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/tty/serial/8250/8250_port.c | 5 +++--
 include/linux/serial_8250.h         | 3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index ce0dc17f18ee..945f8dc2d50f 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2580,8 +2580,8 @@ static unsigned char serial8250_compute_lcr(struct uart_8250_port *up,
 	return cval;
 }
 
-static void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
-			    unsigned int quot, unsigned int quot_frac)
+void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
+			       unsigned int quot, unsigned int quot_frac)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 
@@ -2612,6 +2612,7 @@ static void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
 		serial_port_out(port, 0x2, quot_frac);
 	}
 }
+EXPORT_SYMBOL_GPL(serial8250_do_set_divisor);
 
 static void serial8250_set_divisor(struct uart_port *port, unsigned int baud,
 				   unsigned int quot, unsigned int quot_frac)
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 76b9db71e489..18e21427bce4 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -160,6 +160,9 @@ extern void serial8250_do_shutdown(struct uart_port *port);
 extern void serial8250_do_pm(struct uart_port *port, unsigned int state,
 			     unsigned int oldstate);
 extern void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl);
+extern void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
+				      unsigned int quot,
+				      unsigned int quot_frac);
 extern int fsl8250_handle_irq(struct uart_port *port);
 int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
 unsigned char serial8250_rx_chars(struct uart_8250_port *up, unsigned char lsr);
-- 
2.18.0

