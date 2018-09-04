Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59145C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B0820661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 12:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B0820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeIDQxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 12:53:13 -0400
Received: from mail-co1nam03on0044.outbound.protection.outlook.com ([104.47.40.44]:21133
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727217AbeIDQxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 12:53:13 -0400
Received: from BYAPR02CA0055.namprd02.prod.outlook.com (2603:10b6:a03:54::32)
 by BN7PR02MB5172.namprd02.prod.outlook.com (2603:10b6:408:23::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.14; Tue, 4 Sep
 2018 12:28:10 +0000
Received: from SN1NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by BYAPR02CA0055.outlook.office365.com
 (2603:10b6:a03:54::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1080.15 via Frontend
 Transport; Tue, 4 Sep 2018 12:28:10 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.100)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.100 as permitted sender)
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT055.mail.protection.outlook.com (10.152.72.174) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Tue, 4 Sep 2018 12:28:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:35315 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1fxARF-0003pP-Nb; Tue, 04 Sep 2018 05:28:09 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1fxARA-0007D9-Iq; Tue, 04 Sep 2018 05:28:04 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w84CS3Br019905;
        Tue, 4 Sep 2018 05:28:03 -0700
Received: from [172.23.37.106] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1fxAR8-0007C2-Sb; Tue, 04 Sep 2018 05:28:03 -0700
From:   <shubhrajyoti.datta@gmail.com>
To:     <linux-can@vger.kernel.org>
CC:     <shubhrajyoti.datta@gmail.com>, <netdev@vger.kernel.org>,
        <davem@davemloft.net>, <mkl@pengutronix.de>, <wg@grandegger.com>,
        <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH] can: xilinx: Enable clocks even when CONFIG_PM is disabled
Date:   Tue, 4 Sep 2018 17:57:58 +0530
Message-ID: <1536064078-21539-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--3.830-7.0-31-1
X-imss-scan-details: No--3.830-7.0-31-1;No--3.830-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131805376900410002;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(136003)(2980300002)(189003)(199004)(1857600001)(77096007)(26005)(76482006)(73392003)(426003)(336012)(4326008)(6916009)(6666003)(82202002)(105596002)(5660300001)(107886003)(450100002)(86152003)(106466001)(83322999)(73972006)(498600001)(14444005)(2351001)(48376002)(63266004)(2616005)(50466002)(50226002)(16586007)(2876002)(54906003)(8676002)(316002)(305945005)(2906002)(55446002)(356003)(51416003)(81166006)(47776003)(86362001)(61266001)(87572001)(9786002)(81156014)(8936002)(36756003)(486006)(476003)(126002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5172;H:xsj-pvapsmtpgw02;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT055;1:s8fmL+VJnMAlmjLFAZpay567GUcrwGF5dmS6eo4AzMyC16j3RA/Bb/OebHFfcAXAtxVIkMQSrWNz7AyoNOC3e65eNDTl60C+2cX6XVArwJR6AjzMTEa31KzigSvyqjca
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e296666d-01de-4aed-1f68-08d61261e010
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(5600074)(711020)(2017052603328);SRVR:BN7PR02MB5172;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5172;3:06s9fcWrEs8yUIi30yRy6VZqSdRbwrcPR9PsvNp5AqYkL2Ue84xHpff5A4UQuklY99nZMd1T/9hr9kDU4Ovy0V4W8XsHsMElvF1sMbtXB19s6OXaFyM9EZumCUgue7sdaLC1IfGHk8SELN+vOKav/3nzXNas3/eIxHJIrNUqTHL4EnKcx+FiAszD1gO1LuOh8nnhbFrBMN2go11TCRswOwFWd1lmFoRjpdhgxsJyhaJndQyU0kPrqdFhZtBVCmfJfYU1v+Xaf90Y78pfY8sibDgs4F98+ohhfKoGnbaGiYhRYcPFYJYAh6UoQjYdnjm7h9GlvFoHVVa565aO/5cr5z6M8jCZaPy3tCUk0gHmEDg=;25:8NsO0veK1sxHXL7p2MUjSPhLx5V+7QezstTVfHH/s/NXibamapelqPinXmJrVG1LMboD2vW+KUXbkwflVH/4gn+RJqQp/tACkw/k3e65Smesp3qMF+WSNu1qtaf0bP7S0JSzNACOTWAIBMWYjvawyOZCnNUB4LAbaPjz23uOAI/H9wk8xsZHr/pt83UEGDPO7wgZ5YqukXdsxD4v0MIdFOLrazFIKQOGgzxYBb9z7T8mHcHRQrcL8Xb4QSALyrswi0ic7tpU4Osj2Asnjfs9GGCfTUZTq5edgyKEtFAEvXZygupr1t5NQkhe8AM6wgYdP7Bb2jMShzzqcvtcIGvc7A==
X-MS-TrafficTypeDiagnostic: BN7PR02MB5172:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5172;31:UqC1b4SBzXx0SS3Y802Kc8Nizh7A7GduPxH+hWHIQ8ccHkRJS/zU3GyVPpRP0K6zflFJorCjXxZ7xINYPoFEu7usFyxo16C4jVubLbQOkLuuTshcjoxTw1lRD+ojqbzOTBAbO0Txi3P3RyRxqSs3Y5ZZ8z+/Bj+V6XJptE/gAC1vvdHM7XPIZ3vWHzx5kABalp9zLb3KQO8HzQCthI62Y/b6Yo14sEv+AsOFRRv3ZaQ=;4:kiAb3I+diVqyDH1CPo75fcvyVAvDU0jJoxczl7etcORTECk51csyd9BRy89V84UXSmuPiNglM6IJpV1VxzoGuzTGUkZo7sfGfw76rPlPLXiedVdjXts6oScSg/srvH9AuPElEhpDsUVZDyXKH3J92IEEQ9iy9tUYIKcMcKpG+7sV9BO7ss+F5AzX0nvOLZaGOOkoOUfR/3oAB+B3qhWv+xXqTGgogN4KZZpi/9krUbb9GHkaRq2QCjflf0SkDqkASKUkeFsRJEV3xP5P1rDWsucUPDQi7iIbSuUbfZfLag4k+QaUQpUuDJcMjmxduvds
X-Microsoft-Antispam-PRVS: <BN7PR02MB5172F2902D4BA2B5E36AE85987030@BN7PR02MB5172.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(6096035)(20161123561025)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123565025)(20161123556025)(20161123563025)(201708071742011)(7699016);SRVR:BN7PR02MB5172;BCL:0;PCL:0;RULEID:(400006);SRVR:BN7PR02MB5172;
X-Forefront-PRVS: 0785459C39
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR02MB5172;23:zwDGHITaIMlriBc7cw8VgzS2dqL5eZD5nsXAwnWou?=
 =?us-ascii?Q?R5VKjMGpOstWfXSW/FGNREAKhs3lSgb8edLA8v4jkyiWy4Wmxe7U4/b1URzj?=
 =?us-ascii?Q?8d5S7JW4DUG5NyoYAFcH0tC6J8ge7eTbbQTmuaEgRMp4xbeqgrYxFwdTUHbo?=
 =?us-ascii?Q?rhgeRKszRdwKG/Yomd49H1R3ml1ye0aN1S196NfTK49zF8QvbpdcXwXvnhjO?=
 =?us-ascii?Q?l8+r0JB2dAx3pR42CCEHs5Voj2Gtx4PFxZtcTrUYdnzOewBPVcLQbagUMpAK?=
 =?us-ascii?Q?i+6504+bpF/HdTyBE3Yc4itUeWpjnDrJg2JaOsPpMl6dah6pJDuk5u5RqOHC?=
 =?us-ascii?Q?MzvSdNRHJOMQsJ9fh4Isg4YcYAU8EFI2IPBNkVrp/bZZ9qc2HY/vxVCBwqIb?=
 =?us-ascii?Q?78YwUIz4LlsueSmWn1FGz0ZDRDwKjdNzmTC0On5O3KMSjTyB5vTnKFaqrMNf?=
 =?us-ascii?Q?A/gUdXs2MtJ6Mesb+s+aPa+WQogeR4CqCTA5vPvwk7z/If9bVgHEG3y3uXXX?=
 =?us-ascii?Q?Fb3s0mPMl5aHmO1wC6SQui4raxxKeZzyY1TC9B+5ko20kq+PstD7vtLxODG4?=
 =?us-ascii?Q?lJcYXMW/br7wRW4ee4a+tl43OifjNlin5iFBsj+MsRG7BjDJhixKsxMMzSlo?=
 =?us-ascii?Q?AAbagUVQwlzGrfq7c3uoyUn5lzp7jiTPAArSanhua+kd/vITk84UMkVrK2V4?=
 =?us-ascii?Q?3D8umnjrX8nHGvZcRtRHWFrZCxhchtHRgOpApqbCmfRbkLuqgmsxFUhZQH26?=
 =?us-ascii?Q?ctkp59/si5pZRAG82cp7lDo/O7vZM/Kkgj3zPc3pRZLeOm5E4aoY39EqjGxX?=
 =?us-ascii?Q?S38IhKID4GrNtLLmc50DSnAb8O6QGJMolu47zrv4oJQxCZoEc5IWYqwfDpce?=
 =?us-ascii?Q?QbUAjh6JjlB+Reh/FPIaQHo0sL3U5aLzHhLQro6vApSTy3v9KcepMXVUo2zE?=
 =?us-ascii?Q?I1nZSANIUksP6L0UVO+006nS8EAcgptsYLNjfaBv0IwdSNloUnR3hTsjVzXd?=
 =?us-ascii?Q?7KLUG0GT2gu/R5A4vEGnLOwqvJINy2I1+0jZb5w9xuQcEHdKFaeIE2SpfsoR?=
 =?us-ascii?Q?qn0RyR+M2AIGz1fG35KGaDkFw/cbLF7/DT2XkdoS1Ol4IZv1pXgL+b9V/yy8?=
 =?us-ascii?Q?QfUvFCplHZ3cDEdZ5SwvIe+wju56XwDoZlDuac0hJASNMi23VkmhTia6eh+i?=
 =?us-ascii?Q?kj8huMDF8orAxA1WN0jmOcqP3NP2pMKxZ7wFAJmZyGH0TcgANvilGnR7C4zs?=
 =?us-ascii?Q?jGyeBn2znH4U9YcOirYCRUP+wWm0TpOoRQ3EgQFo9vyoaeVOT6XYUbdETNf6?=
 =?us-ascii?Q?l2bor7xVT+OegnaK7MYh5xM2LmYP6zaBuQlgwvsQOgv?=
X-Microsoft-Antispam-Message-Info: Hfx+f3seKpwuwKMwv8Y0lXgrwTBjkM89BDoXvR5i9bStVf9Wuh1WgH6yjGGrki92ATftsrQ947dAvVMJZnk1nYzUcfakArFO3bgT8zIyBtOkiGCFBArOWaNJ/PFTfk2bgOYkYhpPWVjYm3dVVKoLlM0J4kOJQoi81C0cYV12wap2rIlwBhcdGu3QzOIxzgJuiyG2h/+7FnwQSEVM0UvYCMv/m2TMhp5Qu87MmVaCrRJCXh7sCJ10YfL0UV8u1vNslsHVO1Zt0jtAdOIyOznilx1tb/JabSX9fHLZdo7r1y8PxsBvxcWUQU6PiH14C6OTKUr3aOpLlv2ui9Omer8t2NwnsL1iO+tbWLSqgmVjJRU=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5172;6:CWc07b6CqReZC3gemlOvenZW2j3q6WUoxUnYsaRjeN0PUXfUZKdXj6f4zGvKD5pjTtAJTerHu2PkYDDKDL8Fn4qJc0M9WgIq7Q1BDGvvx2NG9fymTYn6lOCZFH6N5pMrwy9qMfbZes6POuVQsz1KEzdHf9fTHeWyoLk17RGDglUlddHHbEq5/AGPgenan9Q+VLYXGiF6muWDCVIO7FvzrFRx7c0mWi0V0hv1FZGGUGAva2mzEXF87JibxAg5l4IPnxNGeEbWyvI9qWMVT07f27UkmpCCyJ64mkAUsw5TrrCCPhex1V96voeQylMUXlvEALYt6CTbJnEwqnhQpoXTZZ0UOa5PLp2MqsJRQbPyamwsl0Z5zZ8JZtfKkqUHGfIQwrkQeJGWmD08zLemO/k8rSSPaFyUJ2XEL5iUWDRDtlYFe6jOCGx4q/llRrom29NVGX0B6pjmcZwLUFQwgzdWgw==;5:iYduiGKZIGEmz3wNeuSXTV9hbRASVbToKEdHMxf6aYQYiWrL40pIVJciFMr0TQMkfmPyjDi+/044MuTW6UPRCntrO/Ndx9k9yXy6IVX3fqY8J4ikQOoSwBJrEsHRIeLf2NjraiS9nSO/IJYYmhRDwV3k/pvn5UB8CRyXIIbEbG4=;7:9RUnNZzgbQyW6w+J7nSL1cxDIJvqDl6gg1cEajn/hZtTJ6G4j5xVRFpvF14wOa1l7lQ8lej4K9C6SolyOJsRmLjfirniBxc002XmBCFm9S11MbcxZybDzjX8Eqfvjw8Lnvfuh6YwCbsDhNru5kQeFXREr2Jn+1DPqtw/4KDj0+o64ySiCmzjE9QCKbwrgymbQ4JdIbN3jc1/mxjKOWi8CrdXBkkL9nxL9qy6mEqK0x6vTWZ7Dxby5mPo5fw8JV7c
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 12:28:09.8220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e296666d-01de-4aed-1f68-08d61261e010
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Currently the clocks are enabled only in the runtime calls.
When CONFIG_PM is disabled the driver does not work as the
clocks are disabled.
Fix the same by enabling the clocks in probe.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/net/can/xilinx_can.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 131cce1..bf39b52 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -1550,14 +1550,21 @@ static int xcan_probe(struct platform_device *pdev)
 	priv->write_reg = xcan_write_reg_le;
 	priv->read_reg = xcan_read_reg_le;
 
-	pm_runtime_enable(&pdev->dev);
-	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0) {
-		netdev_err(ndev, "%s: pm_runtime_get failed(%d)\n",
-			__func__, ret);
-		goto err_pmdisable;
+	ret = clk_prepare_enable(priv->bus_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Cannot enable clock.\n");
+		goto err_free;
+	}
+
+	ret = clk_prepare_enable(priv->can_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Cannot enable clock.\n");
+		goto err_clk;
 	}
 
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	if (priv->read_reg(priv, XCAN_SR_OFFSET) != XCAN_SR_CONFIG_MASK) {
 		priv->write_reg = xcan_write_reg_be;
 		priv->read_reg = xcan_read_reg_be;
@@ -1584,9 +1591,11 @@ static int xcan_probe(struct platform_device *pdev)
 	return 0;
 
 err_disableclks:
-	pm_runtime_put(priv->dev);
-err_pmdisable:
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	clk_disable_unprepare(priv->can_clk);
+err_clk:
+	clk_disable_unprepare(priv->bus_clk);
 err_free:
 	free_candev(ndev);
 err:
@@ -1606,6 +1615,12 @@ static int xcan_remove(struct platform_device *pdev)
 	struct xcan_priv *priv = netdev_priv(ndev);
 
 	unregister_candev(ndev);
+
+	if (!pm_runtime_suspended(&pdev->dev)) {
+		clk_disable_unprepare(priv->bus_clk);
+		clk_disable_unprepare(priv->can_clk);
+	}
+
 	pm_runtime_disable(&pdev->dev);
 	netif_napi_del(&priv->napi);
 	free_candev(ndev);
-- 
2.1.1

