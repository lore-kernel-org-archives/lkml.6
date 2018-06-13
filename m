Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 41788C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7159208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="jktxHcHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7159208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934848AbeFMHfg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:35:36 -0400
Received: from mail-sn1nam01on0083.outbound.protection.outlook.com ([104.47.32.83]:21216
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754476AbeFMHfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YGMMgnLbux35anQyO3vS8z3tDDI2frT1+2tOwz3i+Q=;
 b=jktxHcHrCjvht1EODhh4Se/I6ENyh+8HtFAbOVK8zssiLk0WilO37Bruiu/8enSQ6Pxyidvesa6EGjPQE7UUnqniWyBX1k6VZdsMJ+DXWilFOALhKZ/5e5cbh+ODrRy/W46clQ+TdXIS6jWmqrmADgz1FYSQhR8ujFHNoYMNxFw=
Received: from MWHPR0201CA0103.namprd02.prod.outlook.com
 (2603:10b6:301:75::44) by DM6PR02MB4956.namprd02.prod.outlook.com
 (2603:10b6:5:11::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Wed, 13 Jun
 2018 07:35:24 +0000
Received: from BL2NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by MWHPR0201CA0103.outlook.office365.com
 (2603:10b6:301:75::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.841.16 via Frontend
 Transport; Wed, 13 Jun 2018 07:35:24 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT052.mail.protection.outlook.com (10.152.77.0) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Wed, 13 Jun 2018 07:35:23 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:35815 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fT0JP-0007cy-2A; Wed, 13 Jun 2018 00:35:23 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fT0JJ-0003Ht-VU; Wed, 13 Jun 2018 00:35:18 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5D7ZCMG014893;
        Wed, 13 Jun 2018 00:35:12 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fT0JE-0003Gi-Eo; Wed, 13 Jun 2018 00:35:12 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 9EC34B20464; Wed, 13 Jun 2018 13:05:11 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <dan.j.williams@intel.com>,
        <appana.durga.rao@xilinx.com>, <lars@metafoo.de>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH 1/2] dt-bindings: dmaengine: xilinx_dma: Add VDMA vertical flip property
Date:   Wed, 13 Jun 2018 13:04:47 +0530
Message-ID: <1528875288-9140-2-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1528875288-9140-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1528875288-9140-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(376002)(39380400002)(2980300002)(438002)(189003)(199004)(336012)(76176011)(6666003)(106002)(107886003)(2906002)(478600001)(305945005)(90966002)(356003)(50466002)(48376002)(186003)(26005)(36386004)(11346002)(110136005)(6266002)(36756003)(2201001)(426003)(446003)(5660300001)(106466001)(50226002)(52956003)(54906003)(4326008)(81166006)(316002)(51416003)(42186006)(16586007)(103686004)(59450400001)(486006)(47776003)(476003)(8936002)(81156014)(126002)(63266004)(8676002)(2616005)(107986001)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4956;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT052;1:ber+eUqTdV0wa5kfTCqy7zZDc/ORO0imnoO9NS+IOLF5QPpm9S2LqVpBBQKk/XxUgE2o7wdJDwGCe85WmJHtz32wEFrfnTsKFwDSPQxzpmqZqfQxAZBouELITHLSC6AX
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c00bfa74-1376-42ff-2b02-08d5d100398b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM6PR02MB4956;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4956;3:YKMJIUzbMooRc8oDpUm0Euaavo4KF7A4ONpZxrkRSrhVTrpuptzoVjb3kcocX86+idUdJ4aCoADEV8B2SkFxEPmIal9FxhYN21gD92Am2LJJTrGTSjkzHWA7iWXDOHLbomMLT9/HVaU5q7Aw/9ZCUe/cwIakR5KprmoKVi/mWCN0Eho6as4ti/4j2uh10kVUOY1qBRBgqvBlr/grCXE48Yw3B3un1/o1mJ8wDqA541sJ/jXxBXEk9kaPp/632oUK4hussw2LKRBbMgob2WvWdtA9FrSQQknEd8xXCziJGUjUQ+pjEBd9+S1ExxypCxMu1JSvJ3rLfRhTAW5D1tZTylV8y/3dZ/Qy5bWXJNIT5Rs=;25:vMLWzhWUeCl/flu6Rm5TBa3CpRPaKGGV0aj2OyDVMKTbMqwrLEuPw8CBYzxmrnXyezmEMS6KKJqVBWds7VpKlFMWvgQFce4CQPPZhNlEq6x9uZr7yhuCCBdnGQ+YFG06o8jI1YZSZHIbJG3NoQWfTRQdFt2ECCwa80cfzUS2IbcjfKHqOSJAtoVabUJjmhJ+0pkhM094u299fPKm1X5E7INaz9e5QoX5KpR42PcrSuAoCSFAn2AdyDV+dLyepu3yt9pM5cnuubn7FASJevkWvYcHG7TNvXizNB3aihxVLJdQezb2+PonfqkDtQYxbkMA5uB70HG/sF4QfWCBd5YmNw==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4956:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4956;31:3YxkCGQl5l1CQcK4tUAiSPAW9CSMxB0wvtb0Jqw5R1WMnUFmkesmo8dL0Aowtr28Wi2HJ4R7BE8TFdsnCi6jz/p6pytNt84HQbSQEaHJvq6PRvUDJnE3beGClRlo6ocEqZfetUesHRHx602Y5JX/bM9hdOuneXNFf69xn4bCqT9Ut4v2lQa+YiyMKzUpWp7ByU6TG2XElPWjOTqtfr9ghGFWYyeE0hZob2V4fgZWC1A=;20:lIPKAu2Oxsk7dmWkrYnPV4uQTmGAxxMCUwp+/jjrtUrF4bL/j/kL+PWwBDy1Tr+2K2KzVWlVwIRMSfvziPCIEWs/w1E+YRpQVK3xQrb53JoRz1eECzFxHdE1RAtjR+QhQ8+oALWssyfHtvZqsiVCKNyaWJLssPQZ7lvLdrWsjBxR+PF2wStD2UCfZmNJ7DnkzBR3rS1AjMMof9RdrZBh6gBdwWiVemUYQA3F7NMIg5x6PenZJPBnadYHyU3WHnpxu2DkqlGhZd4jIFza/5CnyRfcY/8fN6yBqs0jN61Y0Kc5y6KGJEmXNZ4EcC8QzvL49bMcMAxFN8bao5NXIQZ4l5nM5bFhFFBZbJV0fpLZtk+j8wlu4eu+4VYQFYUMAsDDyth02RC0eMAPZApymTuVGLoMRSdFs92O6C37oMPxFLI0xKe3r5sxlwBhvl2XyVzWJI8gi6LeGNbD9KwBPLanLzJ+cOUeAaGrsSFotdNuR+v25vn2LsB9arcS7dVTJPZB
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB495603C3E5A1F9A74F183546C77E0@DM6PR02MB4956.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4956;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4956;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4956;4:YVjPk6JGzRg+82OZP+JzGWp/IyXKXfbAJPRcfo30DItTBJg2JpkaTtLpy/v+hFRvWCKH7kBpgbIIfKO1IP6R1dVqa9rBZSIaTxrHoAL558JSYqqj/KLx3yh24k4p2dH+8jpkLK5cHcKtWSU5vgmhJvjwTndA4/mYVjyjD3D78oe7gusirqYfKzsnXImUE4NYGwOavhgfWJVJOKq3X0hNQve14ETO1EQYpzNGXokqWTWJoQarsDkPVdWetqtd+xCt+vE9aKnZ+HZDVSUkmf0zi/G7NwkfzWnWp1D/FePswaHoR+ijx84V05IRcyvE98kB
X-Forefront-PRVS: 07025866F6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4956;23:543YbOkPBdwoqwiR8YCz6xXBYQGwnjLc0lwF5sWhC?=
 =?us-ascii?Q?QRcZXYGIrxL0JjYzdWHEiQlUe8j8mJzPsAquHPInjeKa31f96EkOCtZ7aLsr?=
 =?us-ascii?Q?Z+N/KsGF4Q4/p14XfdukXgcWS04biPz8aTTvfzkcYlaWNU7p3X0F4NnCVQgo?=
 =?us-ascii?Q?jVa656/Hgy11PlrkAWM4a18Sio84yih5bzO10nBJTEZFcAvHPl6DYOnCk0lB?=
 =?us-ascii?Q?YIuvxKI8fu2s4v8RpIxc1N3yaYXMXLCe0LRzfBpZeQKJxNLRbU+LYWfxtnyZ?=
 =?us-ascii?Q?qszs0uOH5KVnBWbRP8VBL5+hYIon2umc5IxC0hoV9/lc2+0oyS0J1irZWW0R?=
 =?us-ascii?Q?r7U/VGhD/WDAHCGAXYPnPprdhX2cNZrl6pXDUvVdkEzYFxWVR/vU+bdUfukE?=
 =?us-ascii?Q?kxLk6XSliLKkpH0VdzvL1h2fYXYpE6GKW6Kw8LKE6tpepfXNfhLe7CfrXtki?=
 =?us-ascii?Q?oChXOJbQ1DAA2yKawQ1JbZrAdrsAtKH7/4TDlySbpw7ngdekLqCA8rM+Zow3?=
 =?us-ascii?Q?75oFQJNiMpCoDRMEE/WThug6qFKF9F64jzjfF/NH6Pijxo6hnOnrtH9j+MRQ?=
 =?us-ascii?Q?6ZVMljrrhjKJZLoBv7Y/TgR5v7dPbRfP7VfYKLqMh4893ArTojjNBrq9Jyru?=
 =?us-ascii?Q?bIgP31ybMGlxqgwVz9UZvQ3t5Jt+RiOnUyOj5IneX6UdgYXFYLB7gyHZaOuZ?=
 =?us-ascii?Q?HBlziNQK4S8iKyHjpqMWwmBbxEsW3uGGphArwb05jDM6JyKkiH3kjlqOFfgi?=
 =?us-ascii?Q?IvEhfO5GqjHyRcuiRofqbN5/n42U/DL/mAsdd5apfIgkV2Rb7f6qHg3DD1c0?=
 =?us-ascii?Q?V3vomPoqRPra8vTXsRdkolPi/GqA4p6nxTEgsJnNSqm/Nqduni7N4KrJ/qh6?=
 =?us-ascii?Q?/KcsJNfJbjhgZWbp/jhx+pAULin5jf5Mt87D8cFYijZ0KHl/xPOUup89ShHK?=
 =?us-ascii?Q?qhgITj8C37YAuxmGS8UlXAK2HFRkEhRDHEcqxaQLn38UjhTc/c8vx+TOOFjH?=
 =?us-ascii?Q?DINi+HVJxY+f6z/gZ6oO5blEAtN14wJTzIrmhMz1Q3rMFBXAiYl4RuqoYW+a?=
 =?us-ascii?Q?TMMrWMvEY1LKuxIEupFhaKpo6gqLjDY4qUMF/ZK7YPTl4YGnpryejhCHZpwG?=
 =?us-ascii?Q?KUcipw81cJJayNItBm2kdxmEzGtokS9vZsCIyHUTJSh/X7Xl6BTyLhQPmqxL?=
 =?us-ascii?Q?lsrymSYIZ3eM2lMEzzIISPq6MjwhtJMNGBXfIdjwppNBcRJp7ND0BwVvvu7v?=
 =?us-ascii?Q?WdUc1Ca1BC34Jgbqgo=3D?=
X-Microsoft-Antispam-Message-Info: 6Co1K0wkjGplFvYOz3phHQIiI1JhZiQfUQkeQIZNxvVqb9qtQQKxKRlY9zVqIC6X32VgikeS+DA3tzyd4mSvzMJ6pTAIRoS++16wbqMQnGwFpN7eqWgJkBo5R74eMu+vJx5BWCdci8TeKz6zgcz560dkafyNj3CeZ+hc6pU81MAtC7SDg5CK/83HCurB/sj8
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4956;6:fyotF+D14YnhzWNeBJzIAPJDwEKimTlJ7Dej/zJ8Bk7QUlLU5pj61U1lwI3ilv3UiyB8PBmZa5UvGhpFvhrIe9WF6k9FPW/ycI+Un1mpioj1RtbhM9h5JNInOThyZPWIj09kBNCNRFqfHAx1LDV+lrR16L/C57tZywTHiWXKiWTPBfXGKA7waayE4NF7xYAuCfLwLsu1GVgUSq1RLZced2rKldI516taR87f6R7S9LlKu2DHoWUGROjfnKASwA89qTZ5cFSN7FtGkqHOpF4eTnlNqAt886PRO+TQyJ9TeCFlpOjBOUitQsIEordZjmNTMUa2oMDQ7ZqKc3DtJkZ7j/T/+mG7PIE7pPyzcTk13sP73jHG6dqSdlCglpywPK2/vW8jQdPynQmITxdZiK6G294Tmnejg7IFzBQRQQHJb9RyVGjdBLBcr2/rCPbjnMmwn7+743lahXjAy1TncO1vNA==;5:ub+Jthiynwz9G4iKjzMIXvmzxhKP24BUAFVNYCV0XIbgeffr+HF+P7LKv0/WBnsSrdVNl3ZIhYYp2Ykd9y4POwjCdSjpTnzMf0wOyV4mnJsPSc48K0yWK22zzh+TehcoDTkkZIJQxrh7/vsyP5w2kOJ0Dfn5VRM9E37PXwbAVHE=;24:B/7yWa0LkYskr6lrTOXu/SyL/UnsZCbTyryb4qq9HJiteHM/aGxaChxqEny39o9/Dn8HesCcv/teD4H4A9cuhcblufKi60RCtE/S5Bipoqo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4956;7:+cZtDwQ266cNeWhqkCTYmXW78YuldfWstuX5AUtauCUVu0HsYeNWz6hINxzG5ofCnlLRizM7gcaUW4UtOXEm4CfoBRbptTc7rKer2JoHotkZSxp9JLCRkpfb5gM0ODMP97uLDCwF9nscGO5dgUlgXTcp4HEkCRrzDl5uJEa9e4t9bqIbLrJCJL2ryEBN/4FxpojSOwiQxc2/lXSuzPNFoYr9LB0niazURIMvHl23PhZagtWgHhnvXlbVAzrZKaO+
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 07:35:23.6545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c00bfa74-1376-42ff-2b02-08d5d100398b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4956
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXI VDMA core supports Vertical flip in S2MM path when Enable
Vertical Flip (Advanced tab) is selected. To allow vertical flip
programming define an optional 'xlnx,enable-vert-flip' channel
child node property.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index a2b8bfa..174af2c 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -66,6 +66,8 @@ Optional child node properties:
 Optional child node properties for VDMA:
 - xlnx,genlock-mode: Tells Genlock synchronization is
 	enabled/disabled in hardware.
+- xlnx,enable-vert-flip: Tells vertical flip is
+	enabled/disabled in hardware(S2MM path).
 Optional child node properties for AXI DMA:
 -dma-channels: Number of dma channels in child node.
 
-- 
1.7.1

