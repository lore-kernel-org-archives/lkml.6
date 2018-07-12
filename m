Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5D2C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80EAF20C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="hr6n0PQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80EAF20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391136AbeGLCG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:06:26 -0400
Received: from mail-co1nam03on0081.outbound.protection.outlook.com ([104.47.40.81]:61826
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733093AbeGLCGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNwLLXouCQqRDSxmN1kdJ1vceBdIffPALUZBAlOeCpQ=;
 b=hr6n0PQjum5RezH7ynrqCjSQqgHfLuiVRf6hLJ32Pru7ZEii7c3x84l+JrSYxvxkfUxfeRjE81BHJhPNKXQY9FvcfUmeRlemfMwL1UfvW+3Ml11pvU6+my/xKFnbQ1kXy6V9rSY7dcQwRIlV9KTircx8HHt8qvgnCOBDwESz76o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 MWHPR03MB2640.namprd03.prod.outlook.com (2603:10b6:300:46::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Thu, 12 Jul 2018 01:59:06 +0000
Date:   Thu, 12 Jul 2018 09:57:00 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/3] serial: 8250: introduce get_divisor() and
 set_divisor() hook
Message-ID: <20180712095700.462072fe@xhacker.debian>
In-Reply-To: <20180712095504.4d9583ce@xhacker.debian>
References: <20180712095504.4d9583ce@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: PR0P264CA0007.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::19)
 To MWHPR03MB2640.namprd03.prod.outlook.com (2603:10b6:300:46::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 046df047-a1b8-4d4f-ab89-08d5e79b0ee3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR03MB2640;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;3:wsv1lsS+e3tWZJxFThRU274IOjDWUDLT/u5bJbPL8Q5I+/Kb7b2vokiJ76sallDTm2yZnlT4s1pD2ME50Wo4D1c7n5lpzMNHUdcLZ0Wgp/aHyp3abasMDVUoKxPTOCriNMQKMiOZqZgeNxa8mZqUYnkv7sEMXV3ZbA+sm8webmfLlq2ob3UljGjZlI+aipp8iYq1nuJ/qm6qEVssp/NYjnCU4V2P4slw9QVLUSWYmyujo/2puVP5xLp0DPcyJEc9;25:kJ8nDuyuZDlj8NZf2KaEsDugMk64jnwzFKd35whv0ppqUb6XGokLLoeGNlRMGb41IaWI5SzLmybum5gw9uXr9SMZQ3bYV46E4IaOa9LboeNtC+ZakPiIMIyF6xZtJutpg6ZZvj4zGDnYs5HB5/vF1GQd9uekMKkFCX+kAKGTMt3AMtwzQ6lUbypizNOrZyc0tx3bWsSCdlSI8+GSflTwTl/+yqU4HshzPRAV768lyO56FEng49saeYwlyR7NTSsidURpLgNwZOBGKlgfh3CibjptHYhJ1Ah8RZg+u1Ebbnt9en0MvhhXHAVrWdWsVxyIq8ckvtqOFXv78pOqlkcBFQ==;31:CwPjjasBNMKsDUID7wK7aE4zBoZUjtO3bLYbSLycn+ydES+3FGDcQi5Eaw77bi6cFOEAF5mssS3BwvxXR6vlP9pOnj3akxs1GtTQowZzzD6we15WCfaQpTnP2MTDPaVA7tHl4KDf0dbVxbbdga9I9fz8TL0ioJEqsvILp+OWdyK97yJsSBDUWyU6eO2kR5e5cytsvIra7B+mv8ePqPbfzih4fOsqqdvbw7a609WsjoU=
X-MS-TrafficTypeDiagnostic: MWHPR03MB2640:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;20:sqDJlTdY1X5CPWPCY+lXW0nHvOzGdf48zQORat6B1wzlirt0SkF9EVykNdCrpNiLAxqJrVDlJy5DSHMYZgIM0oFx41f1lQvGjb14w2rnFZvGgy6kOItUsW1OgPUMxvfhb66QPFFcRLK6/mWG5Zisik5yC5mGKWIF0AT2DN40JvHW9UopBklVrOR9Km8VgHS1p2iG+Gu1rARPRT5bYlnnsmMN4SGClkADebATdMQtbr7BqFT7jE/VMYmYJqfBEez5vYU8Tj41S6QkLDTX4tZAuBCLsVuoX/4XabDCzugaciSg9mcOuM+91kT3yFPb6/erptu8QoB7Z73HghsxDdy48ttDVd1k6LsqrVqEnsfrim2uyPjgbhYZwAxJ59C7KcNBmeD9010ngfBgsKwhCKDovzDRWCcLDJwADS7svLnlODJ6pQHTLU+DIBo923OemZzkkoBA4YQDkfPTtQLogegPwCOJik8g5C2nbEdqrPgxSE64udW0ijQYtTROWz8eh43C;4:B5KNAXeMzlFhyMaf8DpJ2LmQpXlMBsASWFAMhOxIr3VVPcsHq2axooCx2U7JOf01aFKuahlFlHKAQ7bLq5Kil9CNt8R3Ybw3vnVAiT+/N72U7XABpj/IaYrWcsvDLP4XHnHudYHgSyEDSD1rZFGRCPM6qLJThoC5eIDYBRy0TIPZulMrP5FSykegRc7U807VozS1QApctgoiAlkrtEbSCMYMraAKkQ+ZzZuuD5r99Zt8eh+wdY+GT3WyqXJD1y+B+YSxN35ZnpRWYwlkhMp+8hEMIxA2eXOkjTK8faxd82AjmTbL5JTDANcJuyZA5pXZ
X-Microsoft-Antispam-PRVS: <MWHPR03MB2640A3782EB9939F04794055ED590@MWHPR03MB2640.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR03MB2640;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2640;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39850400004)(396003)(136003)(346002)(376002)(199004)(189003)(386003)(6506007)(7736002)(26005)(305945005)(2906002)(186003)(76176011)(52116002)(1076002)(7696005)(476003)(50226002)(6116002)(3846002)(81166006)(81156014)(23726003)(956004)(8936002)(8676002)(478600001)(55016002)(9686003)(6666003)(97736004)(68736007)(230700001)(16526019)(33896004)(575784001)(72206003)(86362001)(25786009)(4326008)(486006)(316002)(66066001)(50466002)(47776003)(446003)(11346002)(53936002)(105586002)(106356001)(110136005)(5660300001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2640;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2640;23:oZ+FudfltuLJU45sdOT4bRzV/AUej4MrRCZBJ9kFp?=
 =?us-ascii?Q?0Db0Y3jRqowt36wPvL2P1gCK1kI8AX7ygPsHYimPKGdY/h3M9zq7YqTURLFo?=
 =?us-ascii?Q?xIw9xGfEs3cZ5GaJOn54Rhl0Mr7YSUPTW7yWsOUxAAFh+5j0qfU2d0LzEUNr?=
 =?us-ascii?Q?guuuGGVlDAlqNR0Ppqy3bUUYFXBAv/S5m1oLEjIW2nlQrkPvijTLfmIX0rph?=
 =?us-ascii?Q?VQTRP8yv0SoHOAE7O2CU4r+JTd2o7TnhI+qn/ewB4o9R6OI0H1prx2sOkf5r?=
 =?us-ascii?Q?RXMqWA9NEqaeTMNMy6KBup6gThMfkWyV5fPM/mTK/vvDs5hOqro937nqMs14?=
 =?us-ascii?Q?O2eDSCqoVM8LitAy1cVXEh9M/qmYJ4BDOFOV6SX2rAB4UCEtF0YOZqudfp0V?=
 =?us-ascii?Q?asmj7r4MCwRyefmk7BLZkIFAoFpKSIMt/pLTaJphSd1VoO7zDnWO0fcIJ2It?=
 =?us-ascii?Q?e59FeyQ8B/ea4z3jvlkd3PguepAMGXSVSz5jI4N3F1Gr3IBylMa9e1rQAFAQ?=
 =?us-ascii?Q?18tOcoplN3LZQOoRtM8uoQJls3xCpxuMPM+06u7CPW6IgFkMJgm5/yJ3Dk3g?=
 =?us-ascii?Q?vsA+p+3IrdFtsApHAC1yDCxzbfclaqahTQUWUtCZTAnmzu0ohlo25ETy9BfS?=
 =?us-ascii?Q?2mMkrjPF22Fkx5whVN6EFuzL6JibYNQVMniGVdVfWC0cYZmsIefxq4KgtsIj?=
 =?us-ascii?Q?Qe7nfITdhoKDODbUpTS8+EcgZmeSULCFs4FVvr5lVD6dz9OhbC8rcXQ9kfdX?=
 =?us-ascii?Q?p2pUpRrc6yIbFXSPXMveF7GwiB1xk5eF6Q+AzW5pDhelYgUuDFXo9FkYhPWT?=
 =?us-ascii?Q?GGQ8yc0P1LjOO8Ecq0X3Ph1g8CJEYa3BK34CdszEMPMXCs5LPX0lN8DHyYXX?=
 =?us-ascii?Q?mc1hgISa5V/xuz60ZZ2WpmHP5xfk7m3IiXeaM/nTbhc43hptOGCkVLDMunk1?=
 =?us-ascii?Q?nmFz9mehVMtP6GaNqinWP2n0zrk2g9eEquvwlv01eWh3mkBM39GOurCNShdb?=
 =?us-ascii?Q?Gb0LsqceaOp1Bs0aaao0geXVL+BWh69ne0gS1pM98Hfw21KAZdcWAvR5Vp5E?=
 =?us-ascii?Q?9b1EM8XTI1LBVcz0+GvDh66VnKVBf4LEbpCuOgEXmasfojLW0Fidw8JDBhEg?=
 =?us-ascii?Q?wyaXlrSB9L3g4eGaH9vx8H9G+YDmL/2Rcz+2dBG/HvcldhYTOKyScARMqWIG?=
 =?us-ascii?Q?wwdTdzZYqmSX16Y8su67SWh9vvDsVSEFL42J7nqERoDPq65MSn4zabl9+Y4T?=
 =?us-ascii?Q?ZuA/R4b7DbHzd1l1mU=3D?=
X-Microsoft-Antispam-Message-Info: m/JRspmMBDtIsSFLIwVD013u0N0QyeLx9KdAFrXABzru5I/gKVI4wkwjINvyZWXRNdNZHz0FaF2lk4dEALmhv4+WjK98QJ12/q5LHmGOKxDdI/yaz9PUxQNaYEjK7uqOM5Qr2pWXnye2UxxwqPLMYdFHWiQFrlNg/V9feGxDpUgjC+XKbGZ/lCO+ZVEFyRYZqnd7eXCAJ8u+MWPPvi5TS6e8VunbGIOz9aULMxqgtd4Tv/n22rbbWQVl70PgST4nT1AAQ7RorErkeQMl6rh1VH1QpX0yD7NSy6zqGFNCYZFL9+hhfq75qDTs/auGHufMXyafL+2ZwduRPnZA1LLydfxcJUyjm7LaadseMPdMP3k=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;6:aYc4500wXRd0GJO6qLXrDSvXAE7Hp2eOCUL73p6zQV3MVzpVZ6PYEju4UpZs8QmCZjEY3Qq5fXTHkqZgcIQ/bnvgCpUno01spLlL6k05dBN4BWDmlohebj4tbyFpNljVK6tDx6/xXchkZwBQOYro0ofqMztyJp2TW6K9jMJyO9udNOGtBzaHNOAnMoEnegdq//RGthV2ZHOaQ7DbtBk6VFfFaG5lUfgkwvTqtbuawmAjw4asHwvtxkhyzNG7h+2Xy28CNEnXIbScVHCD4+yZTHIBmyYki+L8kWW9nt1+iHF2HsJex8QYX4I7IlGBtlqBRIJF3OvQ+H0+d8yRhE5axoMFQ94fRQ2ABQylj0XinwtKIUS4S5rsfqVoDCQDx/lTXMRUyNe2ukjw338M2hT96bjNc20imIVCav/aeT2bncFitdDULxQEVSjuLzNcq/fzTDl35fF+tBSKMDmMNbE32A==;5:VGvan25HF+UxScRVB6q/mv7HasMY+eRVhObdDM91L3apY5lZnqiOxEcgV9f1H8H8Fq8k7QZ//FxdlEVvdcZVNwHbfwbfbUouK+7Vxwq+fwg1Gs0UoP2YyZ2MCMPveArbv70D2t8AgzJ0puJIQPQ2nkMsE9aLQ+7KI5IQhAl+viE=;24:BWtdT9YUiBTRgYsOsTaf1U73F0yP+PvsYjbJ5ATJgnWUhZh6X0/9u/BD0Hzk7CRnNYSJUp9uepDn6jIeh0a4cAazv69Jygm2nYqfRU1Q7kQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2640;7:Kety6BZtLGPVWV9pYvQei1mXKe6iK2mv5rzW4PAjwrPVc33ktgz4J1on3vlLyoHtflFco418NCTGiQwQMg50T5CXOrF10KD0ZiUWXp9+EHOwsAi3PA7aTAZ+pZK76fA1dQXA3+ywrbIfpmoEYNCDKHaDHFEGRDXz6p9CTWuyR/kVQBGS5yjZVMCCXU6flIfYbeC4Ve1Rqo1ijsNY0B0kyCx1J4HHTXJvMATDZV6wapAFiuhzYApc3f3Es5YqcZPc
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 01:59:06.9077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 046df047-a1b8-4d4f-ab89-08d5e79b0ee3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2640
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

