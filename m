Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E27C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D182089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D182089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbeJPSK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:10:29 -0400
Received: from mail-eopbgr680059.outbound.protection.outlook.com ([40.107.68.59]:26944
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726977AbeJPSKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:10:23 -0400
Received: from MWHPR0201CA0011.namprd02.prod.outlook.com
 (2603:10b6:301:74::24) by MWHPR0201MB3564.namprd02.prod.outlook.com
 (2603:10b6:301:77::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.24; Tue, 16 Oct
 2018 10:20:38 +0000
Received: from BL2NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by MWHPR0201CA0011.outlook.office365.com
 (2603:10b6:301:74::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.24 via Frontend
 Transport; Tue, 16 Oct 2018 10:20:38 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT013.mail.protection.outlook.com (10.152.77.19) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Tue, 16 Oct 2018 10:20:36 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQt-0007Kw-MJ; Tue, 16 Oct 2018 03:18:35 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQo-0002D7-H9; Tue, 16 Oct 2018 03:18:30 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9GAITnD022292;
        Tue, 16 Oct 2018 03:18:29 -0700
Received: from [172.23.37.106] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQn-00028h-6Q; Tue, 16 Oct 2018 03:18:29 -0700
From:   <shubhrajyoti.datta@gmail.com>
To:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <jacmet@sunsite.dk>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [LINUX PATCHv3 6/9] serial-uartlite: Change logic how console_port is setup
Date:   Tue, 16 Oct 2018 15:48:05 +0530
Message-ID: <1539685088-13465-7-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--8.545-7.0-31-1
X-imss-scan-details: No--8.545-7.0-31-1;No--8.545-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131841588375687861;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(39860400002)(2980300002)(54534003)(189003)(199004)(87572001)(450100002)(76482006)(8676002)(54906003)(86362001)(110136005)(16586007)(305945005)(486006)(6666004)(86152003)(2906002)(2876002)(73392003)(356004)(498600001)(26005)(77096007)(11346002)(9786002)(5660300001)(50226002)(48376002)(73972006)(36756003)(2616005)(426003)(126002)(83322999)(446003)(14444005)(81166006)(63266004)(50466002)(47776003)(55446002)(105596002)(106466001)(82202002)(336012)(316002)(4326008)(476003)(76176011)(81156014)(8936002)(51416003)(107886003)(61266001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3564;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT013;1:TGBhHoI5zpsU/n9hZKqKnQ/8t0tO00jZw5lIQVlPKCTMiHz5+otrWktIfWwx+JySPZSP6QsqvhWUERkK7LZlEOJNyQQe7+ezBifTmyRiDdOlcwq90QMXp+i194VfVOlS
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbff4925-7b3a-4b80-4485-08d63351042a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(5600074)(711020)(2017052603328);SRVR:MWHPR0201MB3564;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3564;3:DghsGoDyDXieVe5GisvbTwh0O2KY5fmaQkdPTI7O5e9SMMMwZcAdspPLNMPMP5qsSpftPt0nU77Ai6cgcZuc6tlArafB6T3mkrIlF7UFSVqX7ccZbd3YjyyGoHzNVizHgfTsCT8RLRegrTxito2Z5/+B3ZWnn+u9piHw6agEd58gJXPtFJRQSf+KYKvSK8owrcpJBkaci5bfRZDPLuL45400OPBSGKJol6wzAANEL4xKW4tA609YhngX9pFrTvxtF2GwxrZ6qtkjedhHj9pLPudLUYdvjrJZkpQ0WSYwkDImt1QA9XTxn6UjWxKLuN5//LLURn0Qocw8917ImQg28oSXyPuJwMnOb2It8LnWVXY=;25:fPqYNppReaj8rgaWUoW8Sb3aEfdpXHL84iNyFJyvfiX1BYBd0POsT3fkIIs/1byxkqXXYFbicmk3GUEwZGGMq/E/JSA2oMvUTonhrkkIuZVf7bbkvOAOyOGWgTYQwVu3ZGtrjMHmD8ld0hEtqoDqLpGutxoe5mRXOeGPfvZiCbZVnho99rUy0Yzi7tkkgWdUTdlp+7oIgREOSJqWpCTn1tjlEFztRa6HaAj8bTZAkoL51iVN64RSRiLnY7c+lyVi/WyG8Zo0sUJnylb0YZvJhWU/gj/mfraxAy6RMkdl4nJbUoHkkdT4e6OO2HDXtQK/AqIJ27kDrGjdhns45WNjkw==
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3564:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3564;31:L1J+/+P3nxMltaKyX8/BY1UMqbSIk5PvmrOkp99/xh5FNcI1ImwKTDSkZd5JvhVRWG3j3N1RSCBjaaBpMDuZoRE1XURBDf55tCPrRKw44V+45OdFUM/7JG5V5lMIe8lq9zS4jP2/o9u7OsCzPXxlvbnDlvsWoAkXvGh32eOWgh7Gu+vBUXik5+rRyrp/8RNHVJ9X2NEqtAnAyehA6tX/MZj17NsZfpzwmegqzt+aa/U=;4:bTDL2urG3ynENj1IItc5A847n53gQZY3G31sK4PtSILY2pUJOkV4lEE8nubHMXATk8b5ziI8ZgJ7kCx3S6RV549PnXZR9cQscPX93BGdX4cB0UMILhZiGe4wsjjHxAxVBqY8dNE7rOilHrLGiF9ggsePMvr1yr4YDFZWx4a/OTnkMN+1ekXGzQ+NMundV3z2S/P8qMtwFh+u9dQ7VW7S0bkM5PVyoCubERqT1GnN2dGmLmJE4hBiKDzLn9Nc2dARfvzUmVXfcd2m9naTz/0GUNMucIBJtPa5AC0PUFi4eh7PADeb4e1uqFENHuYV5owI
X-Microsoft-Antispam-PRVS: <MWHPR0201MB35640DD3F4EF53170A0F5FD087FE0@MWHPR0201MB3564.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(6096035)(20161123561025)(20161123563025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123559100)(20161123565025)(20161123556025)(201708071742011)(7699051);SRVR:MWHPR0201MB3564;BCL:0;PCL:0;RULEID:(400006);SRVR:MWHPR0201MB3564;
X-Forefront-PRVS: 0827D7ACB9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0201MB3564;23:QCT3aftxOPMofXmjrfbFO7dDimweLaXiIdmEyEz?=
 =?us-ascii?Q?z6CLTWbUpn9V0mFjayLTN3HbGQvqlS11JU7vBHk0gkiqEWOILPxRXSYRe3t6?=
 =?us-ascii?Q?MAqKzyU3h3AhzVfgwE6Sbl7nj0wyq75p/3dlazQVZbo4eY4pIcL6n2/gAM/T?=
 =?us-ascii?Q?BGtYx/c/nnelozdFfzkUH9vVgsTH9C9PQsi9dwuLBFCNqyVXl90R7pNXGaAm?=
 =?us-ascii?Q?LH69NtftJHV8GXDrhxo2JbcHoznJgSLphBC52iB9sUpr2wZZvxa6kVs2a8dK?=
 =?us-ascii?Q?HYUGMDT+YaJjofX7wTMHTYV8Vtc5UZ3SMUknyzlNxa0L97h6nP9iYqrO1sfc?=
 =?us-ascii?Q?IhP9yVzst0ukUtHCeuqBlA9awXeDSePiQAiDl7ze/lx5Aun6teSIh6CMsCHT?=
 =?us-ascii?Q?F5WCXvjmFVMBPTNCdYnIS2eBMoEdHM0Jf7WJ02H3PHAp3xSWJjxuGkGkjJ+B?=
 =?us-ascii?Q?7kswrMkLXIboyOWvYa/CUfn2tJOKwYEoIrkQA9IH32RmxQ/b4IOWes1PweVX?=
 =?us-ascii?Q?73Wu31jzty9TUI4yJa/kbOhO7pmrUe0JaFvWdafXWJZ9SGRSoPsdZpooPCjb?=
 =?us-ascii?Q?sE48qTpMCPeK0ay2fhw/Zvu+xGfxQgVic/8uSlicgSRMXvlYSvSaIwh4I06V?=
 =?us-ascii?Q?Ve/sLo9GEcaXdpojfwACgT1HWXPWpooibUUsOKpsj39DXDK036EdEuVWRCOM?=
 =?us-ascii?Q?j3X5pY9s484uA7XHYeFyrTXMjFXunHvQlk84AqPzWtMdg99PDRlif1zxrXQx?=
 =?us-ascii?Q?6mD5IIbL1k8I/nHEAohYNxyhdXSkODl3Po+GIroSUXZRcqr+28D43F9HWvbQ?=
 =?us-ascii?Q?ysM0wiz4/JX8bnVNZ4AgEVw9piq36X1wSdtD7493lzJU1rxec5xrPSai64WN?=
 =?us-ascii?Q?EPVqjNUurrZEad7QtJS8N2E9xMbAP9vMcpbWhZnaSszaK+PjTR1JDqQKQO15?=
 =?us-ascii?Q?oLAFLWUepkqbdI8qvlvsjX8wkXvSHwRkR8XxxwpX0LHNJHjNBkJsy96+Ybhz?=
 =?us-ascii?Q?cQ/l+k+x0fWTvNdEFb2CHp45Tnuf1rEYCI3Y+H00msvNgkBpjSekcUmDmc2x?=
 =?us-ascii?Q?e1h9YrZ9CjZAv3tDNpVOd+1Ipoj2dA63VaLoPxNQads6yi8XHMID2V23e+4P?=
 =?us-ascii?Q?K7C3OOfENp/vXhdesbPx1+qBVktuQjZIXrwntrotlxCHiEZh/P4L7yyWViGv?=
 =?us-ascii?Q?p6Vqmi34jIWcCzRt3kzJIDmAr50MD/MuB7E92wRm4leLwjaOgaEA3h79PMHC?=
 =?us-ascii?Q?HXzBPwXt5td9NFL4opRlEds6pSA/eB/piNxCysZYlCmmm3XhWXkf+rC3s/ap?=
 =?us-ascii?Q?VQb+AlGetJzkDUfi00SMYVmRT3tzAwx4dwZD5HNNR4M4B?=
X-Microsoft-Antispam-Message-Info: ASdQibTqYy4ixVdsqy92ejFSvsJ8fMVXWeJbhxTyJYBvFoaLyVwVBz6hj05NAtfTDr7iwY3ywGe68R1/juCIdWjL0JbeKz/aCFFGm77/587HQDSX+ZHxhY28Ob5dnT5Gxh13cQVR1wVcIi3asVVAg37lPy4Wb7tlX3f+5sqaLAttfn89UWxxqF7HBWhvew+RnPNhLBF6mzL6lG4AthiDLujnzy2GbDctvW7kLhMTIyKaI1vAfGagBE90c+JKO/hZ2HBBqxS1bQLnZiS2FHCokMf+ZngmalTcKVbkP45kopeEO1wKjDH2OoBCX1PzDMgZSyMI4cXDly/hudVhn5TNpsIIr5oBXTT8uws+szJsTD8=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3564;6:qxnF4DESbPLRjgrCFFYE3Gv3pFKIkPAJzDwIDapmo/NHAkUSiGLg6rqeMdD0N2HBWpPAIFICMYW4yiqqs2bp1MpjyjiH8WSmyGsjww7NsqlKpBbl1g1VxfE0r1SM8ZqEQ4IXcRG5X13TdMS0PCljlizQpMTVMShfKmhDdFsKBM+LXJs3oJlKG7knUlazlOtsEqmLHlsLmN0arqcG35ArplxPSHbNFQYF54C4k2k6FtZdL6+mfKS9Ol7tdF9wcz9UvBz5hdcjpiC4lyAks1X6kJaTNZC+LZZxEcohMdGMljow6BH14mxxyvDO2/Jnum+PbECAq4CGGdMyZ2l7intcmfThDnMQnQSwyiVTqHJsFFDSooBpSalPWVnt2St5viEvl0kTLBXsImliYnDV6e6H5Kaj9XVXavUgWft409nQuPanBi13yxIwYHuAeeqEd6jk7M80mdvHkCU3ekaBLfXp3Q==;5:IKOlQyDSRI49JFkXDGuosHTbJlc8QJeyiCDsYMkVwJpodhM3eZWgohGWIAPpG/6sDeZyJ0ALDmu7FOqK34Frs7+eBp6OpAAzrAHNHP5qcXTuJxecyGBF5KwX6tX7QHzobQV9Y/NpeafQuD0tPm9b6eH/bA7509IBOAkdLUllhZI=;7:DXYZUj5kbxSR+9PxVaRdsJPW6xLYksl3pi4aE1HCTbBcOWHYCnDjyl35iHOu3i9avjZDKYajOQedizqW6dgc7bSC46evu5+xHGFVhj+uWAIUyqBqTNVMmZpNmsua+Cp7k9/JznFP3Tze8rk3ywTGeiv66/gpMfRzhjM7bYfwBgqXbvvLwZerNODnGA1YD6anoWAsxssGkc9XdS65VAmVJD5ILEaLYEG6fd90d8MTAgrNkg7uJIWcEKT+h8RwOtRM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2018 10:20:36.6156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbff4925-7b3a-4b80-4485-08d63351042a
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3564
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Change logic how console_port is setup by using CON_ENABLED flag
instead of index. There will be unique uart_console
structure that's why code can't use id for console_port
assignment.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/tty/serial/uartlite.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 4a7989d..9c99a1d9 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -665,7 +665,7 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 	 * If register_console() don't assign value, then console_port pointer
 	 * is cleanup.
 	 */
-	if (ulite_uart_driver.cons->index == -1)
+	if (!console_port)
 		console_port = port;
 #endif
 
@@ -680,7 +680,8 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 
 #ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
 	/* This is not port which is used for console that's why clean it up */
-	if (ulite_uart_driver.cons->index == -1)
+	if (console_port == port &&
+	    !(ulite_uart_driver->cons->flags & CON_ENABLED))
 		console_port = NULL;
 #endif
 
@@ -859,6 +860,11 @@ static int ulite_remove(struct platform_device *pdev)
 
 	clk_unprepare(pdata->clk);
 	rc = ulite_release(&pdev->dev);
+#ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
+	if (console_port == port)
+		console_port = NULL;
+#endif
+
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
-- 
2.1.1

