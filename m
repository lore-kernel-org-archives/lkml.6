Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE3CC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC18207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC18207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeJXTR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:17:58 -0400
Received: from mail-sn1nam01on0085.outbound.protection.outlook.com ([104.47.32.85]:16800
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727140AbeJXTR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:17:57 -0400
Received: from DM6PR02CA0026.namprd02.prod.outlook.com (2603:10b6:5:1c::39) by
 SN4PR0201MB3566.namprd02.prod.outlook.com (2603:10b6:803:45::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1250.30; Wed, 24 Oct
 2018 10:50:18 +0000
Received: from CY1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by DM6PR02CA0026.outlook.office365.com
 (2603:10b6:5:1c::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.19 via Frontend
 Transport; Wed, 24 Oct 2018 10:50:18 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.100 as permitted sender)
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT034.mail.protection.outlook.com (10.152.75.190) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1273.13
 via Frontend Transport; Wed, 24 Oct 2018 10:50:17 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:37083 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gFGjv-0006QH-GI; Wed, 24 Oct 2018 03:50:15 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gFGjp-0006QD-Rs; Wed, 24 Oct 2018 03:50:09 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9OAo8e7024371;
        Wed, 24 Oct 2018 03:50:08 -0700
Received: from [172.23.37.106] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gFGjo-0006Bq-1Y; Wed, 24 Oct 2018 03:50:08 -0700
From:   <shubhrajyoti.datta@gmail.com>
To:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH] i2c: cadence: Implement timeout
Date:   Wed, 24 Oct 2018 16:20:03 +0530
Message-ID: <1540378203-1655-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--4.500-7.0-31-1
X-imss-scan-details: No--4.500-7.0-31-1;No--4.500-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131848518180387135;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(396003)(2980300002)(189003)(199004)(54906003)(81156014)(476003)(8936002)(486006)(2616005)(126002)(83322999)(110136005)(4326008)(76482006)(14444005)(305945005)(81166006)(16586007)(6346003)(86362001)(48376002)(50226002)(26005)(55446002)(9786002)(107886003)(50466002)(86152003)(8676002)(36756003)(5660300001)(106466001)(73972006)(63266004)(77096007)(1857600001)(51416003)(316002)(498600001)(73392003)(336012)(47776003)(2876002)(61266001)(2906002)(6666004)(356004)(450100002)(87572001)(82202002)(105596002)(426003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3566;H:xsj-pvapsmtpgw02;FPR:;SPF:SoftFail;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT034;1:mWajZUztBA9xGLUscX2zvlj+eBQtP6quCJa1pNja5Az6WCugIxceRa6Hx46tvtINueDmQVAsdTwKlKh2mfm1W7wbe7y2DMwXzyv7KQoq7lQcI/ISo7XDEl176Oz2GEIs
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 011c7b24-881c-4527-f486-08d6399e7cbf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(5600074)(711020)(2017052603328);SRVR:SN4PR0201MB3566;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3566;3:i812pLuEfaVAbTy245yObdiXRWOObbKohflWRKwrliu6lKaug242tKH28FJDe+3byAx34Yks9+3N7Jim3r5UjbVh0QFfYM6F1m/Po01xTjUlo20wr9Hbu6+Qxjmy4geCDtw5/deYlBoBDuseMyNMQyGhoFVzI4tgIp4RqhRcThzUpLOKjCEmXezsdaicE9f+xXFZIggDEeoy7nqDBwN4hfKELpXbu6Xdx7cOfQ4WVkPaRiBIQuHaokJ1uq1H9h5Jhkaoa/ab1lZaE/hcPoMbuEP5LLADNGdlG3zn7oJ5K0WTL6PlYUPCST+nN6tE9YDSaV6Wj56SroAg0aqZVJcsFBUNVCcapZNrtXhgjv00dmo=;25:jJAVvSx0RY3AAqlOOFFdK+Z6/DntxKqKJC6i0Te882XIwL6ljLfuHvBHIS+Wis7QF10219htysq72ijGMmgoDt9Odlpn7vh5oT8Js3TZpTPEJlcMmU47Kxp0eZ7gzze1f5Q4wSgRbuSAMYN5AA5foMrOB0PRrAAXS9lKbXuzNt6EpPf7eIMV4TUym+eGGcyd1G8v/iuk31cvrPUzMHFPWdHAX8PfMa1dSy7igoPcEKnlGpFlIvDdOhAzS21XI2qqK+9KghBkBgb1JYd+0Ub601RMHdTS/R5ZbdzJ/llNZhBwNq+oz56j3+BIozLGN8gjfev6QCPQIcjBNY29I7ttkw==
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3566:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3566;31:o5NWM1CglVkoIXkvKvhQwBZHi36PF20d/uBb0gftnuiXQWggtfHhSqIJPcXVgKGebVWwm3osSaR9RddHKBP3Xbx///ytoJIq4W45/OoHXXe6bCof7TAmNzYVeNTVpxATRzPv+GbB6554wh14ZBqfNRZbzb+0HLjMqGmwneQcgmxJna0Lj4wN0A2cSLM+H7J/6532D+QCQY97ZEiJvIPhs7sgFkV5gQ1DMxG28poPq1g=;4:99Hz9yaq4/ZGwKUhvlL79k5z+8/d+PZa18S011J3MJi7FiCdWmXTDKJDumcnHcA1eysYNSImSs7HLWg7dcTSZWx5OOPIfvxYSUxgANggP+BmDmpB03wJPJbQwWSJqOHgiAwVMXmFMH/CAIu6Isix3W1UnZxfuM19iJalNbuTffVBdk52LLT1ZaSmq5FXsLnTSdUIPlp4kuCXxDjBDvV7Ts8TTKDqIC2Pjd67KpOfGG7SZHz7c95gM6Ur0cl4lANZhZo1SogEimB8s8ywPqvV81CgtP2GHioycmu1qVR9IARXXn3mnZeTz2tJepLjRHBhwCFhi0whJZSP+fnsD28NBg==
X-Microsoft-Antispam-PRVS: <SN4PR0201MB35663CC65B91F6F00A3EB38087F60@SN4PR0201MB3566.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(6096035)(20161123561025)(20161123556025)(20161123559100)(20161123565025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123563025)(201708071742011)(7699051)(76991095);SRVR:SN4PR0201MB3566;BCL:0;PCL:0;RULEID:(400006);SRVR:SN4PR0201MB3566;
X-Forefront-PRVS: 083526BF8A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0201MB3566;23:veOxsdsUwgpxSuozZJeYcRGYoyoOEP4MVChJr4+?=
 =?us-ascii?Q?R5ZPeukzsAs7jtDU+pTOPhmI/2WxSjIU87nAvWKfoF9fTjU9+u+M9FVC/m2+?=
 =?us-ascii?Q?FurZ69dfKY2hNQBBSFfgE19RF3FoQLhIsMkM8eNpraRZeix3l88/HFtG+E27?=
 =?us-ascii?Q?q8xi8hvG0ZW4TbwYkyYHoVLlG5zkaIsr7CxstnKasNVkzvy/h1J9KSeWq/Hn?=
 =?us-ascii?Q?IbsGMmKpUGDZCaW47C6G2AuWY5MU1+NXM1ZUQKz37i+f1R+3T+j1syPWiB8V?=
 =?us-ascii?Q?IzhbyEXbiDIoZpnxyxTAQmFrHUPAZPt0Y9VXkIHk5ArTJlbZPq70jDPgJATS?=
 =?us-ascii?Q?ufDjuT9aPUZLCM9J9TdLKrpRAggj2i4gyFrRICvd/oBlXY006r5a2ye9mKDJ?=
 =?us-ascii?Q?Ssh2CPUolinfnLCKur0VXYZKc6uVRTOJ0HhuW19di8xfzJqQ+I3FG7F80LsW?=
 =?us-ascii?Q?Ez3Pl43rQkbuBhVFS2tQbev+ZTl+E7rRw4dpnD9VzRei214ulP+S5blCwWqi?=
 =?us-ascii?Q?1S6FN/scNxAdI9it8HkFhErBN8ySVEFae6FuS6gs0XT/e28zwWuCX/7Y4KhM?=
 =?us-ascii?Q?nx8ycFtpexewBtF3Ab3jQ6TPTteHcAjfskbjbYb+717/JRsqEuJ4YEkWGNjV?=
 =?us-ascii?Q?z3TpQm/DxfxPgSFfp493cvjSObEL0TW/o+ODlrZEqCL7ZT9dSkuI/wqckLnU?=
 =?us-ascii?Q?AC4hyI4E8Bqxz5JSvvf1w8m87LYSN7yEwBZdikGdrFj5AU/vb4eU5phay7hE?=
 =?us-ascii?Q?HL9AyBrfQ5Yzy6W/UfVsQHqFg5nsEwTJmH5E8kRUCFn625xee8iHXngwMcXU?=
 =?us-ascii?Q?0LxQN/QQDeDutGgHViwoitYHjpP79tEKW6VCHwE2/LwMTDjYwKP4tZPUaDh+?=
 =?us-ascii?Q?L25y01THnkjbZ7coSobq0YxUlPH1Ff/kGppxUsmeJATD4mU0xTQwcjfXmpNZ?=
 =?us-ascii?Q?jEXYFHnHdOIeL9SI5+eag+Pgz0rG7Ltt1okoQF5f/Bxr3P/I4So4U2f/OxOm?=
 =?us-ascii?Q?0JaZAs7ptq5YkGQT211/cYaaRksXXdKab0Kc5grKjPbOeqSGsijw5IyFh934?=
 =?us-ascii?Q?hbRciGV0i649Q7jfNFbrFPNFiG4EZVGmzKUgQA0oLWJGVzcvB/ohxhs7lFzI?=
 =?us-ascii?Q?wUI4zvr3x6yXaznRbk/I0wmWHs1XI5fug1iySnZQz+q4aEiH56Iat4xSXkej?=
 =?us-ascii?Q?byNNYqmpzSHlFkVmRFxVG7cGIbS89cyv7ACbRD4y2yaJUTQc0xcJGMz+HPqr?=
 =?us-ascii?Q?twjyVFbCLZBrI0E3lqYJ3+ZGBSRiwyPFaATUeF0PPDK7bYAlXB6qyb1eaC7f?=
 =?us-ascii?Q?JSLp9Nj5Ema605yDZs7C8rI4LDjlB+WGJMMDIJ/BcXcrY?=
X-Microsoft-Antispam-Message-Info: gqDMcLmYXfj/rJiQ/j0gHcDfz/jwhdRMCsIFZSV3YZtFhbrbMvWnbD28es/GTWRXwVCCY5JRoc1fDn4lHuASMAHGELuas653rcDqHOmhIZnPYg6NaJT6ewlZzPr8A5IrYnCd+SFW5GERxrVq0qMDmB5RihIH4NU1kzbC9Lf8/vxDzhPTA1ZKiQxHXzbstulBYZuMoDqq94peK9iCPgqNVWnGVjvZGmPpfyBftIiHuN1PPHq4Q+8YJo4E59GfTckHi3oIsmHKy7sXGtoprK+p4c/7oAcsyG2P7WtCxbjw+N1o9nrXLjHzSexKRVr4ct3d8XkJcOJw3K0oec/z3fspGze+Gxr+LdjrR5CzBY5zqSc=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3566;6:xIarB7Y7xJ57wFkoUNRzh2Aeib1bTwEYYDmdag7Yn9/bit31rPP+OkDveunHeOIcqMkeD/IABMZEGhXxS0IvA94z9kG0Giy4QZlx9GHrviSeL3C7XM6gUygv3IQ0GUIPAAUDYV9HgK9z2RdVPYiqyVCbrYPnTvzH88UejptiV2a3KBZ8ZTP0uomtoGBAePW5pNhy/NEnDHBlX96I5CShRLRN7adegmTCjHDA9YakDYzWUOVwxziFQZQK1WBq9ZEB5Ds9jM1KLIZA5RilaHhtJlJwQ3rlZ1Uhjrwmr/pA/lR7BDsQgzqVAOLGH5yynrisdS2XO8vHYeZzwsXREqUDiWOZV4qTwZ1y0C4sRu/FVSAJElelOM8TRWRl4M8hUnW5nnVRqT0obcUswcJSus7oPis/5p6lkJYqXnylBm6YauVW7LI5j1VBhl5Yk9xaqnlX8TIQYwtsstEjv6baQtnC7w==;5:7bj7hBiFcotlr8uI3zSaek1SSNtjF0xy2S66CAeXYYrZy/OGUCQtbu+2htrb1261PoGeDPXajf57wbuyolKAH+E6VV137ohVGEr8uRg5LoKiGJYRB/T5sQ0zIMKmaweRfw4aFL/hmDnRNwKF9sMcQ5Qj20XyDiAvOototyIGebU=;7:8NBVFlla/pg3k6a7goWDaKY4RxSgUWMpQMbbFSL3OohkAjZiQuqjO+78F4P2xAsOuxe5puipvJFKpveFwQP8KTbb3J29CaKx/uP1Xd/uIXjgAjOzEj3D6cBC+eg6Za4lrg/ZkyCw4h+rJiwswf3W+C031l00pYqxVKvFK5YeruKfDrzVQBVzT5VlbGHPZyuW0cgAxWfJu89iUsCDxM/vkl2lU12UXhyskX1HxEQvLylx3iT+nAMznh4GP83W1pvF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2018 10:50:17.2105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 011c7b24-881c-4527-f486-08d6399e7cbf
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3566
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

In some cases we are waiting in a loop. Replace the infinite wait with
the  timeout.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/i2c/busses/i2c-cadence.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index b136057..9c38278 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -209,6 +209,7 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 	struct cdns_i2c *id = ptr;
 	/* Signal completion only after everything is updated */
 	int done_flag = 0;
+	unsigned int timeout;
 	irqreturn_t status = IRQ_NONE;
 
 	isr_status = cdns_i2c_readreg(CDNS_I2C_ISR_OFFSET);
@@ -235,6 +236,7 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 	    ((isr_status & CDNS_I2C_IXR_COMP) ||
 	     (isr_status & CDNS_I2C_IXR_DATA))) {
 		/* Read data if receive data valid is set */
+		timeout = 1000;
 		while (cdns_i2c_readreg(CDNS_I2C_SR_OFFSET) &
 		       CDNS_I2C_SR_RXDV) {
 			/*
@@ -253,6 +255,16 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 
 			if (cdns_is_holdquirk(id, hold_quirk))
 				break;
+			timeout--;
+			if (timeout)
+				mdelay(1);
+			else
+				break;
+		}
+		if (!timeout) {
+			id->err_status = -ETIMEDOUT;
+			complete(&id->xfer_done);
+			return IRQ_HANDLED;
 		}
 
 		/*
@@ -262,12 +274,22 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 		 * maintain transfer size non-zero while performing a large
 		 * receive operation.
 		 */
+		timeout = 1000;
 		if (cdns_is_holdquirk(id, hold_quirk)) {
 			/* wait while fifo is full */
-			while (cdns_i2c_readreg(CDNS_I2C_XFER_SIZE_OFFSET) !=
-			       (id->curr_recv_count - CDNS_I2C_FIFO_DEPTH))
-				;
-
+			while ((cdns_i2c_readreg(CDNS_I2C_XFER_SIZE_OFFSET) !=
+			       (id->curr_recv_count - CDNS_I2C_FIFO_DEPTH))) {
+				timeout--;
+				if (timeout)
+					mdelay(1);
+				else
+					break;
+			}
+			if (!timeout) {
+				id->err_status = -ETIMEDOUT;
+				complete(&id->xfer_done);
+				return IRQ_HANDLED;
+			}
 			/*
 			 * Check number of bytes to be received against maximum
 			 * transfer size and update register accordingly.
-- 
2.1.1

