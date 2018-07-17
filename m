Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F21ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2924E2146F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="lW8b9Q/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2924E2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbeGQNuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:50:14 -0400
Received: from mail-eopbgr730040.outbound.protection.outlook.com ([40.107.73.40]:55470
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731371AbeGQNuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGjnRQ922KKe6zhi6gaEboGcRloHWDA5eCq8uObjM0k=;
 b=lW8b9Q/bcp5bhc6oh89ewmKaYMyhJo6n+jRJKp5BGxIIirZxQD4j/TRviESchEFcS6WSSDxfjiZRL3RTObXQd/qmAQwX2fEPZpUncbdL7NUNstXIwkC37vbfUX2f2+fHbxtjFmM9tNJYuUFwE8Ms9i7rVX6zGTPY65GjazOeZqM=
Received: from CY4PR02CA0043.namprd02.prod.outlook.com (2603:10b6:903:117::29)
 by BLUPR02MB081.namprd02.prod.outlook.com (2a01:111:e400:811::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.952.18; Tue, 17
 Jul 2018 13:17:32 +0000
Received: from CY1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by CY4PR02CA0043.outlook.office365.com
 (2603:10b6:903:117::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Tue, 17 Jul 2018 13:17:31 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT017.mail.protection.outlook.com (10.152.75.181) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Tue, 17 Jul 2018 13:17:30 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1ffPr8-0007XU-5v; Tue, 17 Jul 2018 06:17:30 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1ffPr3-0002GN-2X; Tue, 17 Jul 2018 06:17:25 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6HDHME6026446;
        Tue, 17 Jul 2018 06:17:23 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1ffPr0-0002Fd-Qp; Tue, 17 Jul 2018 06:17:22 -0700
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH] clk: clk-fixed-factor: Clear OF_POPULATED flag in case of failure
Date:   Tue, 17 Jul 2018 06:17:00 -0700
Message-ID: <1531833420-27175-1-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(136003)(376002)(2980300002)(438002)(199004)(189003)(81156014)(8676002)(486006)(9786002)(8746002)(5660300001)(50226002)(4326008)(50466002)(63266004)(8936002)(81166006)(107886003)(48376002)(6666003)(106466001)(26005)(2906002)(47776003)(36756003)(7696005)(51416003)(478600001)(186003)(72206003)(36386004)(426003)(2616005)(126002)(336012)(5024004)(476003)(44832011)(77096007)(316002)(54906003)(106002)(1857600001)(356003)(14444005)(305945005)(110136005)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB081;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT017;1:WO9PzpkUk2umEWt7z3fqIeyFMcjgws6gHggni4lRyOfMLzS/3PqJoFR0trahfKY5ZD9bnbiGwV5RF/+TmdNjJEDbyFgTGID5VFLJmUEfgdfSrzSxgTo/q6Nxg6sZKZ9U
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70b1f36c-4ac4-4389-50b4-08d5ebe7a6cf
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BLUPR02MB081;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB081;3:XJu6POJNX9XbMGeJoNmAF9mKkG/Z1aLJCARy9lu9kri5H+eg898diG4TevYGSXYNViuqNOmZnblRbXG1fTIxjIahg8z0MN2ZZ5/HKcxE9Nh53W2EtaPvCNelUApF1++ihV9wOgTSx4Q7w/8ymYTMQw/zT008oL5fa63PHDFIE3CGlxUz6/krnwGDhH4hs2sGN1CixSbjI9dzCjacIAaWZSqS4xYpn87Z7+po58jjMtC1r3L0OPxRnjprFJMqXW8mZupDGVJY0TNAdQcp74ZDy0k+2wTRJwvGweII+wUJzMQEtMsvQN9616Ed7d14cPsfkbTLjQbIsI92lU2z6Gux56wdsHCd6OQtvEd4YUMwA7A=;25:cSyZdvi8XrxE4eNOuBlHrZv/FfMcIhV5efYax89gOEi7rCAsOx0/oP59SCK6HgOSC3IKIyV51hRscRC/xrpiD/SXqhXkOCDUBiQLgqU4/XXtQAD/F878h/2pmEBW21KbF3f5+HQKSGNspVJ72SZLLDjG49HLWxMFJU+Oj5DjKpMJOawT+BqftuiQFmo45j/tyHgjz3DScBei2oH8b/mDISNsAZ9Y2UK1+jFdAnqIthb8e3EZQ+aD5aWFUwRvxZa9LqTihAW+nXvVmY2PTkN6VwbE/KbC9A+7Kvg31d2bX5HZaka4psLHsFeqvgzioDMQSlfxOVUds2hvZdZhEbpGfw==
X-MS-TrafficTypeDiagnostic: BLUPR02MB081:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB081;31:EBY72TC+FYvzObI6uLwi2rSYen3+ZoapZeiJ3y+5R8/bziU13OaBKvFhG8hn8PWvdjIOhwh6UX+ya0ecM/0eq98RVzpwc/az5P37TmRp7nWUKrz2QpQMaIelCDdArzcBepOwC6ewo6tZfUISCKGiJKQJ3to0sQNmAi2WB5J1pd9/nVwyCsbR5KYJ7+iOlz63wQeavT9cCBtKW0UnS4jCbSbh6x9kHbtL5/o/NZpxl+0=;20:cPyanS8w7yVNySimuz4ctsKVVQsxuJlpMLksAOdUuKrG3MaegIcXTxL7qHIzvgiImJ045PgT4WhzvL9ojL0nfz5yfA4HxSXeVm3gcIwlHZpwi41Z6giKap3b2lk/bivbrfF7g0kn6V51cLRJcYQuLdGyaG4Sh149vjwwvr0F86rgTK6zYh+fwB4kCLBUfG9QdlR/F9T6eOt6QLt2DV/QCNiVkl+StpTJhxjN05e2/YZrlKRuJnXKt0MJ3CP+LStndZEHZ0xrsWx79BRwYRLbU0m8vHmtq/X7geCxBulqFwQjwvVukOu9XWkKNJMfQaVUy7nF7TJK8x2MAYDI7B8psTBAdm6MMJBbQsGhzPTl6+y2U8WCBl+OU8ISrSwMEuj4kj/c2nQ6zHwszKkiNUxaxZmKdIWOLWGaP0bQZeA2PQ2nPLvIShnBnnMEh2mnPSWxcsUv1Gb1HxICb9XnGWToLee+YaPCGMqa8RiZOzGIFhHqZJ+4upGC8djWqjUK46Yi
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB081631A3AD8B9C16E118D31B75C0@BLUPR02MB081.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(223705240517415)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BLUPR02MB081;BCL:0;PCL:0;RULEID:;SRVR:BLUPR02MB081;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB081;4:ZDScYJRHrA+VDNL/3mLK3iEVzUOapZu30oYQ6DMVrZKuXHkIMuXdlnLtNVBeG77BHJJ2Oj733KKNHlfUePVGtwyRCY8UvkP7+PgnUSkdzs0b5WxvfpGuNzKZrBEr/fnIVABO4HdUAEb+CwAjiEzYI+cu4ffICwKDu3TiclBx9eOSOK0tOkU+K9u3XRV2OQU0tqxm91/5eQW0i6DM3jHyWf5oWMvdsiBpJ8S8Q+6SiqKibUadst+WYQkZkeIIY5EXSXjHpHMRG9TA39IIXI4TkW9ePHaiwvveyY0UZlfKQqCv+7QtAkmk/uZ0ZFLKwnVuCfJAdY9J9NlpZIu6BCeQK58CtUbxaihkXChhiGp2C0I=
X-Forefront-PRVS: 073631BD3D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR02MB081;23:LDj9xyG5Q03zPfjc3Z7gX0ZsmDnuNtGxP1OHSeY7NU?=
 =?us-ascii?Q?aHze5H0TcO3NEf/JpgR9MhvfufTC5Iia/5m0lnKmpkKpBlDuUFGHFyDpNkZn?=
 =?us-ascii?Q?dxFxxXve3Ubd0FM8yLyFXBpJYI1F/+gwCLOp1HgOiJiLhhQx5WwVv6KnDx+3?=
 =?us-ascii?Q?yC1qaEc79giYnY7gsRciXublvp2gTkt09AbUOB0TGhv9waYcoFrdTJ9PFG6i?=
 =?us-ascii?Q?0fm7EKk+UDFgx6x917uLgTawT11go4ajFCnZlAHyhC3haYvelBuT9b+Bp6Ba?=
 =?us-ascii?Q?qO3lO+A+9vccY5VDgS70E92khP27nMTVvEAZxP+wtz+sCVdbmWB/xWDE408i?=
 =?us-ascii?Q?pDyFEmoBcvZvGVyuHC1wUe5wrH25zEiFfHqxGH1uJ3G3If2+9p0ROqaL5DhK?=
 =?us-ascii?Q?e9v76mTWse7Qi6HK+PrVITxUYrwt9yjvQkDkXWPnf3AZcS3u5A2lPgqDcg89?=
 =?us-ascii?Q?EC1kcxv4u9ya5PuONG6A7ISfIlm524twaGpYMy50Y1t4qe4xqNjTI5VJjGYR?=
 =?us-ascii?Q?Laj42cSJ/NqoLvyzZmgB/GlZUDEKGIow+Vnaydfv0CCMObHbSBm1xYeBqscZ?=
 =?us-ascii?Q?UJ3Gzbu1cRK2ZTWlfV8qV4eHqlDB0Jbf7dSDHn/3hyGeVKF4+WB/OawqfnwE?=
 =?us-ascii?Q?T3GDxjkMDwDJ1hrWLKu5iguBPMrvRUYDTH+EZkpKXsQC3xoABSken8gBa0Ok?=
 =?us-ascii?Q?n/y4xtz/joY5nNzYKaSu0wpqqo6BdsBQeyGke94tS0kIYWVCwDTAeDxP0mx+?=
 =?us-ascii?Q?Xalb2MwVT2xau+MAfzEUmeyPuuB33sSxXlnceyBqVTwbKjkrz/MsUNLSRW+F?=
 =?us-ascii?Q?CGe5x8H/q9mKFdqwz3/6a0TJWJeKl8YXgx86LR1dTJMwHxWIzZD0XG7yzUF7?=
 =?us-ascii?Q?rFKJseLlV1Nj2nqr4525Hb8bSCuyRFTg9h7NnjuFoFP921j83rWxByYqFWgx?=
 =?us-ascii?Q?gmvP1Wv2brpaYLcoGul7IMe6xWV0vlANlyRGTyRpjpNTcJekBuy21KySNIUX?=
 =?us-ascii?Q?KYtucGD5XVHfaAM9ziwltgu9meVTrOkocIG6YMF9Mn2ObOlSUUvzpzo0XI+Z?=
 =?us-ascii?Q?tUws6lVUbkSFfQJQhKIXolWO/qliTK+ofJ1m5aBFvCIo8NKvzb7tXDjNAhbu?=
 =?us-ascii?Q?Q6E7ut7DZmUfd9HXKyD57eZqvllzs3tNC5EqpspHhA6/2ypOIVwA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 5ZVXvI9FjxjZWeZalMFNGTqahuFVopIZcRPrKvGVftuLWcbJnKTyeQcOz2QTbpqGTOF3QEYgQOepN/MpenKqAgGYRonUkMuywUkZc4a+fPLlznXCGzEKECHxPCklALS19VeRct2ILHDRf7mA0zS4WPSK2tK92lbF5xLgObqlVosQG4IKaggg2/nYWvbTcNnki+op+lwuQqVob1I2IlGBVDItDT/zT/T3LjlB5AAl3RkFuQvUmNWz7cbJQAiaISEue10zvByfacZ2zClwqYTLluZDPbVUUZEOHVqi1JbGpfQcgVSNQ6/7jCR7KNHsL96mPNENVdZxZJuGX3NRcdUTDx7W3QL9PIp4t8Qk8+eY0eo=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB081;6:3geuZ2/WFydTU6oAGSXrmpdp3GDTcNDxTstUBXGYWmqkJVHnabYZl4Bwb2QpUime7+LHiGU1UiQ2A6TodOoS2Ap7xo6F5AhZ6rHUpHwSkObfAWFaKgKecxgMlTYpLatM7/PbZaekqKYnNW7U/2HiRPA6VDr4PKPPBEbQ6L+yrZAT0vUvwpXne60VAxEw4GZx8+Ie5FVnOZvzh2VLGpbaDV4iY1pVeDRoUNV08sH0BZWeotZq139b0bQDGhzOlKPZs69jjGaxJyKvTUgzAbQ0w4SUD9K3AxwFHZBbg6GZ2bMhsZDCNg7a8GXMamuGmWJ7xg0LpM+3qF0KnvOltU4bfiYkolRnpGeL9RvvH6VgQ51oXqHqABX4qSTIX9jQYhKzMFCxpt8rZ+H56KzL2XdexjoxRYMAbbvs9zZ6t/040tEixD9/wIIOlAcIYqzHu3kEHqimMYM5Wgh2Af5O/1BR+g==;5:0RdyVUFp5Ao570DGuepYimgzmEqsVGuV3zcHQ6PAsCLJFMJzciZtdb9lIKRrriqfEUbqZdx972ZJ0xrCyuYkMtYM6sTb3TZhbooxd3XlmFPsLA64GtM4Uc6QRrsOLTGEva2TttDIBKdRKNkyMdiaunENdGquoPC1rJscOkZEIVk=;24:cDtks0rk0HiiWYkoCWBKkbqyZsTFnk8L50imBQ7ZRcTDyFSDGCUBdTibVM0YiDUk02BNJIS7yvYDbz9zZZGaz9D8bBqPrbUdvhSoxPh4Ggo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB081;7:Om3j4n9zbUIMX4enKu7WarUw0JWZC8gwcTWt1pm78cK1M8h539a0oewqAsPT3KM66Eg2W3JtN1i7VkqQmWarmaq9yWFG/Krc7g10MkwSZYUWVv+fAJso1miWDxY/Ts1x4g25MdDvp0QXHM2ATddqVSZ2++nFeFwKUliih1HQz4yyXJ2jOJK8q8LO+YO+ftRF1VqlT6u/YNxKojugWp1AnVsy2HtF1dtxVVaifNltwk9T02Gw+/FDxad0Q+wUOXLf
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 13:17:30.8557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b1f36c-4ac4-4389-50b4-08d5ebe7a6cf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed factor clock has two initializations at of_clk_init() time
and during platform driver probe. Before of_clk_init() call,
node is marked as populated and so its probe never gets called.

During of_clk_init() fixed factor clock registration may fail if
any of its parent clock is not registered. In this case, it doesn't
get chance to retry registration from probe. Clear OF_POPULATED
flag if fixed factor clock registration fails so that clock
registration is attempted again from probe.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
---
 drivers/clk/clk-fixed-factor.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.=
c
index d72ef2d..f3ae4ff 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -177,8 +177,15 @@ static struct clk *_of_fixed_factor_clk_setup(struct d=
evice_node *node)

        clk =3D clk_register_fixed_factor(NULL, clk_name, parent_name, flag=
s,
                                        mult, div);
-       if (IS_ERR(clk))
+       if (IS_ERR(clk)) {
+               /*
+                * If parent clock is not registered, registration would fa=
il.
+                * Clear OF_POPULATED flag so that clock registration can b=
e
+                * attempted again from probe function.
+                */
+               of_node_clear_flag(node, OF_POPULATED);
                return clk;
+       }

        ret =3D of_clk_add_provider(node, of_clk_src_simple_get, clk);
        if (ret) {
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
