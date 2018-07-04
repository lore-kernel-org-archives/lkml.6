Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D94C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9324F208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="VwfM+4Fq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9324F208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934083AbeGDJCj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:02:39 -0400
Received: from mail-co1nam03on0047.outbound.protection.outlook.com ([104.47.40.47]:3377
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932439AbeGDJCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BkPSalFsSkPJVjHXXPW0MqHlY03OO74gBSLetpCqdU=;
 b=VwfM+4FqQQ9XTdHpEm1a3rVqrZzYsudLRonhN9gJyIlXPiIjO4KVDQP3CjFo6VNjGH/4vNmnSWCU5to1Z7cEVHS8xC2jx/ZO7hSwiN4usNgYdLUDFYTow9+gl8aweTmIx32gliXBvR9dbcVlcg6j/RBfbQPfFJh6fvVgyqh4FP4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 DM5PR03MB2636.namprd03.prod.outlook.com (2603:10b6:3:43::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Wed, 4 Jul 2018 09:02:29 +0000
Date:   Wed, 4 Jul 2018 17:00:40 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/3] serial: 8250: let serial8250_get_divisor() get
 uart_port * as param
Message-ID: <20180704170040.39ac9cf3@xhacker.debian>
In-Reply-To: <20180704165908.4bb8b090@xhacker.debian>
References: <20180704165908.4bb8b090@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0152.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::20) To DM5PR03MB2636.namprd03.prod.outlook.com
 (2603:10b6:3:43::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f0cc7b6-544a-455e-d5c0-08d5e18cdff3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2636;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;3:A7l7j63dUpTdnbJzFfq6jHlkNgYh5uC6z1+sTijiIqP2cT8wpnT6WiHQiuJUHje1z0Z7J2DfZc4Kbf/pqANy8qH23qP3DDa1m0BKVD2oIK/40lT+phky2MeUuU/FGNi4p4LOlFYn47A4OMpAyamTmGocdov6eX0BG8IvI/Jf4fnOkEs+V/UHEZSL5AXayyJxyd4AgRUR9UstohwW42BcfggO4lyzcR3kAiO3r4c77KRYZOuOJqfWRdFVRmdHL0O5;25:6BOp2iIhCosG2eZR5Qc4sUXExDau1YzWxt+fpBDg5EwpCyfXIjRrPk1LeZKot77GLTJetZUX/dHGPjtZds1eRpMqkzZy9lu6RgoUVOw5fXhvwZdzHBS16RLDFCoc1ts4AA8H4b2Y2/RigW0Go5hYvBIZniIvgWcDksblVMKX9Qph3P7YKQH0rPiC2uZgApBcZpNjayvCx/i3acsfMU34osMxAXUt6fIeV7zmjJcR31qMMZnqNwFHbHTDIzmEnwRniRulK/D6S81o9P7Kde9bgdbIxtmUyWhQ3Sv/ClvhisqiTKEzD+uYEWI/P8ewfLImT2B0CTBA6c90j5Wk+UclBg==;31:i1o7gWpBG/o/oQjllfC79cvCdmb83cnR6UgsX+alFsArWdYKgLptYyOh8ZaOJw5KycFrwJnHvWwOzSXLLnqiwYIj9wz9OA9v4vGQPFIQAhdywFPKiPcFxS9EEXnAjMXzuL/tzVAas2XbKmwpKi8JqXwWAcroa2pr9L7t/GZYI2Ovsv9tgwbdJifAFJCSeoh5Z/nx7+4hB6kcv3Sq1ODiVpftprox3yifVgR79ZXEsAQ=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2636:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;20:sz2TIAt/J27qchR/loskcfUa7JG/rIFvSCxD81c9kEhDUyPi9DxzVaFaV1pSTWg+SVnMgB6zW0fM1JlfndH258r0GE+0HjPKyfFz1TOXGGN2Apqsd/n4BQ+0i4MXPXoEt8pHZ8ODL/RDO+wOJaDp2GT7zNjW2iMapCYuTlRCEyp/V13oSdk7vLugQrm+iq+njbSs8C1o2j5zq/a1o4gl8KJOqXjsdnQIIEElLGxLwfRSO//IcdsqF+0BMKuqQ/Ct/BjuOMj0lR4vXSbJDR0p+UK7E39xi0x32I0F8K+bmpQv497OkjVhL+gY+/mZilLqwCeVXWWCWd5bMuzuxoXiL4xoofZviwFI+GlFqzSpJmBiosnPYFgIYjdvMEqIsdJBGcMEPZ0sQA8V05c1UoqWQcXRB7Ci52ZrtPawYYAhITaH5a49kAP5jSZOd+NZgVaFrTebtdPmiS4PB4ROzN18oh2keDNRLDlG8Numm84O+p7h1Ou5tPcpx9tQAN5FoKG7;4:yrZMWFZtGklZTQiLhbqK3PmAetHq9b9bsFiDYKngJW5rqDalv17j8+3txzW68hqEMfj2cBy4uywRLmXokQJNv5GJYjB2AZd0mhgAIHv9CeBjY6jQW2RlfCaIPWWUqZVxUukB6zN517guwSLr4QLfdRMHgld4qX5Iuj/mKF14i+RSVgCkymcHKZl5LhwTwdj1RNSnoZVIWSyK7shFnwQpFftkYgfWHtfjFioAy5XCnCGnBChZdCd7EOJI4EjyPVC69xuR1k+kRwwLLuuFldTGAQ==
X-Microsoft-Antispam-PRVS: <DM5PR03MB263674DADB06632A8ADA5273ED410@DM5PR03MB2636.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR03MB2636;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2636;
X-Forefront-PRVS: 0723A02764
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(136003)(376002)(39850400004)(199004)(189003)(1076002)(3846002)(23726003)(4326008)(6116002)(50226002)(81166006)(8936002)(68736007)(81156014)(8676002)(105586002)(7736002)(305945005)(25786009)(11346002)(6666003)(446003)(476003)(5660300001)(106356001)(956004)(486006)(2906002)(66066001)(47776003)(97736004)(53936002)(230700001)(478600001)(72206003)(55016002)(9686003)(33896004)(110136005)(14444005)(86362001)(386003)(6506007)(186003)(16526019)(26005)(15760500003)(316002)(52116002)(7696005)(50466002)(76176011)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2636;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2636;23:IRHF9wJ9ctdoSAHRW53xX3T9YjYIca5oJG75RaN7V?=
 =?us-ascii?Q?amJNJ4pn1MbKvhM158TAw2X7O2n7Zh2jouzg05f0sIRZfIFvXJsYe0XBNsco?=
 =?us-ascii?Q?I1fNOo6eLvwDxt3UcsLXbMLa+mG7YqApv46vnOP8KvYCK6OOEZDyJwJbRpZR?=
 =?us-ascii?Q?xEIcp9FqUnv4b96w6N1aZev2UCxnkwL5Kg0CdsUOlB9yBcGO7q19J74OBXHr?=
 =?us-ascii?Q?ZEzuZjwRE4vef9yCjV/5n8ZA4nRdLtpL1oRnU2QEjjzh73B82dAYhid3ihus?=
 =?us-ascii?Q?NAVhYedwdezGP48Ru/DgR11fDu+NKyVlAvFNPtuaTJ3mn9jpBpnLTEet/921?=
 =?us-ascii?Q?d9DAF0XGGLrWk0xRp500oVBG0G9OfVrtuIl/MLLedkyhccjEMSir5cr0QUk0?=
 =?us-ascii?Q?PaFOXSuKgj2FxxOMk3nqP0xsMP7Wdac1rhAR2OcuRhkv+JHQBNrRgqqK2z0Y?=
 =?us-ascii?Q?Z7MVolzf3tmEPbBLz6ciWdxs+z1GiDD0jqAz0WqHeXiF9QM1a4633v29c3ML?=
 =?us-ascii?Q?dEeoglCzNcaQKv6t8M51FZryNFU+9Y75Ovp+xeS+6yBnst0FoOIXHGSJIT/s?=
 =?us-ascii?Q?iw3myA45enEaF5CvDKaccmXa0TsYMFrzUJcaZ9DjznhIGytGSo9OD5Yc+V/6?=
 =?us-ascii?Q?0i1j8nwNOP3FRtVCCuABpzMimIyhJKjJGU9uLG6K7CaZWuUYZBGVQa6yL0w1?=
 =?us-ascii?Q?27r1pBazAVQmIEXL5sbmZx4lJs8tg8svww6xCUyDBYVeasLujy6dlQhWPJ/E?=
 =?us-ascii?Q?3RMuQIU8ERoaiE7E49FC/3knRR6d0/fBXt8L+rjVAmp6MRcSebewdwii3Gs5?=
 =?us-ascii?Q?3Xur+IHJF25PW5ywChfGBmuwwsCZrgnDdALvnIUFsWRsQeVKkp6OAqXDE5YK?=
 =?us-ascii?Q?6YI8S7QgM4mcRbUQD6GdKDMsJTA7h8TKDeIuLsAAH+d8AxeTJ/k4+ncHegSl?=
 =?us-ascii?Q?S5w5HLXIPj7u8/berzsJESfjn4kxBMnFcR0pagQdXRUdQJTHt7zY38BQ4fCY?=
 =?us-ascii?Q?xyE6kbot6MzJzGfSSJ0YSKeaLHpUpx4cY5iGHISECPHueZK4oTA/t40HPsFb?=
 =?us-ascii?Q?KYwMWlQOSMiTV/TMPw+hInSnvBAX+tOQoPYPUrqEMx15CZEhGc3pc/m0U713?=
 =?us-ascii?Q?cM9JGWNOaJ/Ir1WBibTuwRRffFZ8++r90x3Jzy+6Rk0EK9aoZ9jFGsvhWDXi?=
 =?us-ascii?Q?XJ5CMEkykME6CVan/hhgf7ADfnfUU150j7vQJPpe59/qd7MdbpMJIKuNM+sc?=
 =?us-ascii?Q?5xilQSKs0Ssm5Qmq//+qRnPOGdSzT3yoxo5C/c1?=
X-Microsoft-Antispam-Message-Info: MOInDcOzZRwBlgKPM7xdC0jIp/rdcS6elJVdFJD66U5uaPygSizdVhomSioGzvthx9adokr9ouDMAMKzs56OfZPOcK0IsvvzfAhCSYaTcaHNP8WSzBJfoMTcWdFRhRiTRSb665BwBzrFrAvTaQMcSOky3HTZQGhsUwk6HnkXX3ZsC06rbFMM+7nQm4sQVQdirsVEsGlPjLJy4M8cU8HfEhK/WTdLAl8lNZt7IxJJqWpx9qmeAdjKqxff1h4iZjjIENG0J3gkzqVMVMQiCScNhRr9OFw2nNv7Ibkgmr0zBUdNrbNu6IvP6ExZzxFe55nMUSJWZA1Rzk2Pe+1p8tsUPYwL0mZPFBwXzWWEfk7CAfA=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;6:VDQk0JIWDyz7Cj29Jaf16grepdcrzRWN14kYoneHW9+SXlWapNvYyZEse40/iZWYKBFASM0rybZtbvz0ykx2JHOxRZH3kQocKtOyF0KLBjJVLlg6UusJvlSxrloSfn94fh0ZdFS19/1dJ8bRhWhQexyYwitO9MxmEHUL/oSS9r04mCD1G35dCY5G8ai+bByHeA6m3m6SGRyCyPWyo2mk2CDPFGAs8KIki+QwmLzOR1zWijjB2XEMBH6Nm+mzY4UEOy6efY16GFR/Kd6fKrnXrTY/B5zZZycqoUzO5cAHQIhXrNnhprDQ+wrxpYPg5GEkvWWkHARZEbPX4N96/W8XFe5hLi1eNFbV4SjIzZTBL9xl+IqR1nziZPZF3QOHQB1+7VbrOn/xV1oh2VPgkYMdCiEIvWxBV2UZ+a+dWvddP4U1xwK3aeyyTzvAf4QvRlc6B3eyk5P9lGC38WF1xBqLZQ==;5:sFz/Uw35H5qIVYU32v5AIX4asxJy8cnl2uqnFMP6gJJxQiHvXUD4oLs9uJOxIfWSkSdZdUSf84d0uv9SEqtuNkMMNxyk7GDK2ZastyfWbcaPzuPYgSiNghzL/LFaolEoUYeZoPaHb1d7o8jrAvRJl3MRo6gz8XsBeiqDoa9+2ro=;24:0Q2PiUxnaV+UsmPeiIoLO5shhe8ZwTwJDz2wdBDCQscjRHXOuMRtuGIwjZT/fwPcxsPR/pjvBcFAzjfZia84YUx/W6p5u/oVg78zm1hTj3I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;7:xfyearyrBk4yvRxPgSYH+ImCDcVVJbcbcm6E4gkeuT+0ib+gJ4WNvM+CVUzCPLuM8B/V01mE40S8ASUTyzH3XMoB6wP15fejeXMhrBeiUGZBroHyoiyfq97ogw0+9Ry7zIFPKlWEmWUYsLGOy2IVMOjMHvOMWVffeMAgbMYfDPpQSpVAH69VdNnkm00CFPssVCJLgcPLxFuRFY8LgLcL3iJXlsbmTqeF6TX9a0IcXGnyDo4IbEZHh2+J//4WKsQs
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2018 09:02:29.1576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0cc7b6-544a-455e-d5c0-08d5e18cdff3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2636
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align serial8250_get_divisor() with serial8250_set_divisor() to accept
uart_port pointer as the first parameter. No functionality changes.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/tty/serial/8250/8250_port.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index cf541aab2bd0..709fe6b4265c 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2498,11 +2498,11 @@ static unsigned int npcm_get_divisor(struct uart_8250_port *up,
 	return DIV_ROUND_CLOSEST(port->uartclk, 16 * baud + 2) - 2;
 }
 
-static unsigned int serial8250_get_divisor(struct uart_8250_port *up,
+static unsigned int serial8250_get_divisor(struct uart_port *port,
 					   unsigned int baud,
 					   unsigned int *frac)
 {
-	struct uart_port *port = &up->port;
+	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned int quot;
 
 	/*
@@ -2636,7 +2636,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	cval = serial8250_compute_lcr(up, termios->c_cflag);
 
 	baud = serial8250_get_baud_rate(port, termios, old);
-	quot = serial8250_get_divisor(up, baud, &frac);
+	quot = serial8250_get_divisor(port, baud, &frac);
 
 	/*
 	 * Ok, we're now changing the port state.  Do it with
@@ -3197,7 +3197,7 @@ static void serial8250_console_restore(struct uart_8250_port *up)
 		termios.c_cflag = port->state->port.tty->termios.c_cflag;
 
 	baud = serial8250_get_baud_rate(port, &termios, NULL);
-	quot = serial8250_get_divisor(up, baud, &frac);
+	quot = serial8250_get_divisor(port, baud, &frac);
 
 	serial8250_set_divisor(port, baud, quot, frac);
 	serial_port_out(port, UART_LCR, up->lcr);
-- 
2.18.0

