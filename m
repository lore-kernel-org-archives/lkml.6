Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD14CECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 19:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC7E20881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 19:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="IoaWJQEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC7E20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeIOA4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 20:56:34 -0400
Received: from mail-eopbgr680063.outbound.protection.outlook.com ([40.107.68.63]:54657
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726969AbeIOA4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 20:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrJg8WuU4Q5FHv+Mu37FlEw6dlRWX2QSWzPFzlLmDbs=;
 b=IoaWJQEkMzrz5/E3p6u0ViHBbOg8vnPLfwKI9Yz0aMEhLlS2D2BGthY9tWJUrNefE2qKK7AN2Uov7ZAFyp4w6bffqtP84TzGrAQSqPqIgy6DAExmRR99ekzS1h43eTKz7Muymw+z42Bfqp6sWYpqxA/iA9h9q7wUL/l4KsNUR0g=
Received: from SN4PR0201CA0047.namprd02.prod.outlook.com
 (2603:10b6:803:2e::33) by DM6PR02MB5113.namprd02.prod.outlook.com
 (2603:10b6:5:51::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.15; Fri, 14 Sep
 2018 19:40:19 +0000
Received: from SN1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by SN4PR0201CA0047.outlook.office365.com
 (2603:10b6:803:2e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Fri, 14 Sep 2018 19:40:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT053.mail.protection.outlook.com (10.152.72.102) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1143.14
 via Frontend Transport; Fri, 14 Sep 2018 19:40:19 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g0tww-0005SG-OB; Fri, 14 Sep 2018 12:40:18 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g0twr-0006TC-KJ; Fri, 14 Sep 2018 12:40:13 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8EJe20u012223;
        Fri, 14 Sep 2018 12:40:03 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g0twg-0006EA-6D; Fri, 14 Sep 2018 12:40:02 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v4 2/3] firmware: xilinx: Implement ZynqMP power management APIs
Date:   Fri, 14 Sep 2018 12:39:49 -0700
Message-ID: <1536953990-12755-3-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536953990-12755-1-git-send-email-jollys@xilinx.com>
References: <1536953990-12755-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(2980300002)(438002)(199004)(189003)(126002)(14444005)(51416003)(305945005)(7696005)(356003)(8676002)(26005)(7416002)(76176011)(476003)(2616005)(2201001)(11346002)(47776003)(426003)(16586007)(446003)(336012)(63266004)(478600001)(186003)(44832011)(486006)(72206003)(106002)(77096007)(36756003)(110136005)(50226002)(6666003)(2906002)(36386004)(107886003)(316002)(5660300001)(54906003)(50466002)(4326008)(9786002)(81166006)(106466001)(81156014)(48376002)(8936002)(39060400002)(107986001)(921003)(83996005)(1121003)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5113;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT053;1:Ypsf+rMkjPXw8h5t5pHzfSnQ7i4KVhrotMuhT56LKXpFfhcMKgFleQLd3IyfBWSYXM22TPCluEo636LNdKpmOut759ZWO9VEVPkOdwiiuL/ZWFQyXdBIJX6H8gedpCtt
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ca4619e-26a0-4206-21fd-08d61a79e780
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB5113;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5113;3:vS4ATr6OuK0wIoyctOl8DKefn6soynT539qoDoOmJ0/TYNl4SqKgLm8nGrvebRE0wICTpyxxnp9RD9v2w6E65ip+Jr/271A8Aze674eRjQ4IfKdtuchhjT0VNucxczaZrHcNRVQm5FF+mbHZmFVajGDuV0WHiWfaFjb0Psb20ZszKckBq5+0Z0LWJAj9KkKT+aw5RZh5FmrqbKOJRbTMXVsj3oGLt1VDse9/ta/FmENi3yqQlMfFN+oqu37MXsc/qENrAfk6fiiqAQRjB2cwO6ouLQqgp/F/073Qcw2LClL5NunlI8kiEWQv/ILbkSRw3s1Ls5l/mnd0NsVO6fWihn31VF6sqorADiCTQ8Iu6GQ=;25:tPcvG1n3SzZQfsFjPzdwamQh6gv7XMM4giE5zJdCu8A/5fsiKcY1DTNYoThRlq0rRTQ2oU8SOxk6RoqPtqD88dlGSHwUS0YUq6ol6dJHFazlktBXV4SJLmEU/RBoslMtojjOZMbZ2hb0v5R8NAmXrIdTMTw22SawxmX8aZrxF1wZC6OafT+x/aOPwQwUqsIDjfprkCNyHM/363VVPysv5G20yZrinsXCFwi/tLrWT/UUxPK2fd6FHU31ReIdt+W82zxj+4nE4kxFLpcmF0Cx2B0WLvGsHtggdyIFOvRcY3H3BFW9kNFrE8gXusQf+aG7eISdWWBdNX6/E1enmif+GQ==
X-MS-TrafficTypeDiagnostic: DM6PR02MB5113:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5113;31:loPVp4HnYcuP69hLBruAEx2cZPbCtQZDS0x3h79ZLltL+vEWp5nxLIROhM/V5FEF0rBv64d3GVSZBU8Hw+RLdbHi1JeQSlwghH97wfmqVxaaMOVAo5TPv2r1oT6mvtWXbTfKToapw3rVfa+iEiyyL16xh5jWR7nHhub5y5BItGt9uklcn33zUvVoifr808nZEfLKLUb/T2GSEYountNBzyiB1yiHTEFfibP6gXkr3yI=;20:JY3Shqs0uP6RDHIX4GZmYK+JCbDjbvAnQHqsHjhJ+E7cecYSfLqFdG7llq+pI8ByzoHbHo/k0cqbBPrk79QhB+ha1S7qJYaSpvLKkeR2O7XDNCMR/9KYK2SQyIrGJbLT8z0RjKIJrqUoh9YhTgBpegMbqvY0KwqfKsJhb0g+EmQmoAEBclomyqxRreR8iwFenJkd2NjOyel1fKfi5EpA1WfAqUvHVT2vg/FJ1e+sxLcRMbi06HjY4McbQZZ/pGByOUAgvT2sXEnW35FB8rOXbaHNfyPoKqcy+Sawnj9agoLyDIJotySJ8KhP720I+7YBZF2P5Fwo0xLpy/oSmhCQ/SAIKmL1OgYMQ0wRAbnysk/4BVOFroIWdnIM8q525NtWSvINjWKkhfXGXJcifEX1NTP035qT5Yujp091SlgUhvYt2AiskdKaTUjMv4O8wj34CTZihPTx4aY8ZYRvp/XhNbYg7ZaSfb1T2mFQP5VWx9IfqMR4WNFanvu3O4lCv53h
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB51133C4237AEA5F57A492E23B8190@DM6PR02MB5113.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:DM6PR02MB5113;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB5113;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5113;4:Ai6ub3xbekXxRRIvZ9YvAv9g2liE6e+HERj7RVnD2Q9kwEro1ft1Ga54/TfgsDOlQfN1Ej79tXwf2DA7+p9KQ4PZR8m2UB+TSnIhfBIkyvZYPoFsZw7DMpwtx8h0UiRYZgEArYVtO9JJC/hEdtvVMHdSjduGqme1RwvilHSx7+v4CM9T7xMX6huTcv+jVLteiZeEZ2wqkm6XUWpXkUwrwr3+wqswFmhlWTN3B1XYOjjmQ5F98re4NWQujauyt/T/ROkPI25l7yZxgzC5ZrXp8z55iTm34MnJ26MpPmddo35+NoN5XC2wsXaW5fsa/Kxq
X-Forefront-PRVS: 07954CC105
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB5113;23:2zx1ER7y115h/0eG06jPMBDJ0v3tGrM78ZLnfxpct?=
 =?us-ascii?Q?TE7t1noPnkasrG7cDgH6LaAwStNLVBrWw74dcB5U4PgM0PCYaSwm38bcypWF?=
 =?us-ascii?Q?NgKRsS7rmcCP8fRkhQVFrS+3B1YiGmle1vof0nFg2ouWBawUIqXSsduoilYI?=
 =?us-ascii?Q?quhbyts1RW5B1afxRn1cNoxqqpjTfUthYIb6j8zdj9BvBPuQN1dpix4+DKW3?=
 =?us-ascii?Q?QVr1Mod+C3Khch1sfTkaeEPYeS7DtXAgKXwE/B2ItR6VDGNq/+DgI1NcmJaR?=
 =?us-ascii?Q?MH8djHJO5xuszlQMU9z9v2u+ylkbzbmTeslHek0y0H6Q09gj0hWsQCb+vCM+?=
 =?us-ascii?Q?h1PGxLcg3TLEaIxZgaAMCoN5M6g8qCIM9FMpkgP5HDwVm0ZW4MPPoSqcNCsk?=
 =?us-ascii?Q?HybzG4fbKYtfk8I2yYSBj7aMKEDMOssQPBl7Oq0YFAb6yNAcref4hKA8N6nC?=
 =?us-ascii?Q?UPk8tjVcV5rdTqId/qDTl3iHDCa+go3a+jzQoTH6F0S1NwHOD/xOw9zVUoqb?=
 =?us-ascii?Q?qaLhb+MYCSRdfsX8Xz7V+baTJG3XSIlcRkB7veLmc4MztuEiwQWznVfxRrqc?=
 =?us-ascii?Q?femxfrHk2rXVnJx+9xy+SXkJDMRV6jImh/p0WmvVJAQtnKfZff1yRHdCFnXm?=
 =?us-ascii?Q?Q5zxmAda8hTJP7b/7UoreoNOK/QI/uukmpKPvG9UghjJAwcwyAwLvdL/0M+x?=
 =?us-ascii?Q?fRn/tm188ZZFpI588qXnDJ+iUOgqCQV6lIZK9x0LZUXNCORwHXHdW8Qq7rUS?=
 =?us-ascii?Q?JdUNFs98FYlXiQyjJtA/jVjVUDMrYIoFpAUgVptm/c2T7WzuRwmEXNILFZAP?=
 =?us-ascii?Q?94I7so4coQG4DQnRHK3tC9+pkP1n9Yax1Z6hQn5QF2/STcEfZTlaxMVaX+6T?=
 =?us-ascii?Q?6M4+m1HVqJKSkRsvWWc93N4yuTKOT/OunrOI/99F6KtPTO7TBnpQ8DSsrLIR?=
 =?us-ascii?Q?bBO5lkhx8OCx8AfO9sImMiU0DitdKycfuEU8Qix4inpOEy/rLJ11nwEZnC5G?=
 =?us-ascii?Q?Ro6nzCTLx1FiFvFz9hSqcnkX59zNZw8j1LhYYKD1ZKSyHcnJBexhjBDcq+Nh?=
 =?us-ascii?Q?RxLNVG8JxzqmWmprNuIbQescLbDwA9oNKKBoTjOJSwgr7v9v2cY92V6EzeTc?=
 =?us-ascii?Q?xsqv7cHT2vch2gg5FbjlKTuhSjVXnIY4BsFbOe4X2RvFO970iKqb7fWhI0Ep?=
 =?us-ascii?Q?uKD3LrBSWtxU0xbNLFdF09rP9FQ8ABZZobsLb0ISPoZmpIQsgmcRHj9e9gpY?=
 =?us-ascii?Q?yHfiSB0oSOGzMyYVZbXXjxHby6pbIsnfQqUaz1daNxWoi6mNm9i4EJp2Ob0a?=
 =?us-ascii?Q?24tisdaP7+4BrLeuUGYlc8=3D?=
X-Microsoft-Antispam-Message-Info: VUuO9CdfK2BdLvj1yuwFyfkyHL+mNYg3aTskr4zRhouc4uk0umu5QgDu+aHLx0Nyd8+wJTeAgIQiQZLtymbDLbpuMNGqn/o+ZGdD29fV654jHjrqpnQbN3W+J9YikTS4c9DOezQpMllPI1u2GLhKz77eeoliVslbois1y0R0HxIpzQ7jG7rqDQ1qpr1xtkw8wG87K+K8rIBdLndwCD7YGCeM7bL6XWM4zlIYS9dm28iFFZo/AwL4h9NpPjSL0O7kSvxUlzSS3swWju+whaFGT1jRncxIwVOpCVX1G1bpQka+6s81+QULewMc9xGIQus6dmSaJqPWUO/4YOcY7q56S10M0vmFWV0vbbyVkzrVIJI=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5113;6:eO9wRUsVlpu16NsYIthrrTSWr3q9v0KAIJAAjszzRGq+jSXXTJOpptRD/I2J6jIHER2K5Oy838l7vA34R6KXxY9GA0tUMhENr9X1o4XwT+5sLAHyWoN6jmNaoxlAXUqkb2h5X/me3g5scsnCilzGZMwyF7laxBrvE63pLDERQ3gIEX4+a2gt+9D+0W6ByAQqHo3TbGA7r5wCjbOwGThD7gxX2yqPladOyAxUP9YL7cukpeNopGAD97BYNBf/qEE6EVctdzgGY8ZUo3d5dqI2/0VNWZHGE4ZsWrGKY3ut4xfojOwSHJ06AUsM0hpWf6wkMSeq1OkVKRPQ7dlmCh2w3vWo7uzy1bcMuSc3XL6IZgj3VjaObZTlZBRDX6ihfCKAdGmvI5BP9S79OYkYDCR1UfTA1Xtqlfkupj/76n8b89yY4VifWT7JHot4c0V2GnZ8U1SsdlmWd8ZqgbALLb8rKA==;5:iL4TB/rR/6MdIiVK5y3BBshDuz/3lMg7M8LW3ZAlPTIW4NuNjbRyGtqYbRCS2j/BLCloCFAJ4iVTjyBSFlLjhuB+nuL/wETUdw0slOUFzB73ri5IIGzocCB1E2rkln6c0u0+AkN+fuFZdVSq+atR5TwvrtML7u/k4GD/DKsi8zo=;7://gobCvAVaxQDniGwgffba9HEY/QCVUUyMbpqDH29lN4Cq85hT0bdNwb/+W46XH8eqDL2mkzX3j0pdhtmNq7AW3DjxWdbMhgIyWFePR8N1EjN/E4r/AxtICbnUTTQH5IVzjmcxzyKS7wsU07Aut0k48f40Z6RjxDf2IFk8KRSMezTylaMxdlLHOz7R/dHe8foWEjQNbgNbOunUfe8fJuk7Hx/WxuK4wP6iM07CELPQszRFYX/wqpyKmEDRlWT9pB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 19:40:19.1490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca4619e-26a0-4206-21fd-08d61a79e780
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add Xilinx ZynqMP firmware APIs to set suspend mode
and inform firmware that master has initialized its
own power management.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 29 +++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 20 ++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 84b3fd2..c7a3b6c 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -428,6 +428,33 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 	return ret;
 }
 
+/**
+ * zynqmp_pm_init_finalize() - PM call to inform firmware that the caller
+ *			       master has initialized its own power management
+ *
+ * This API function is to be used for notify the power management controller
+ * about the completed power management initialization.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_init_finalize(void)
+{
+	return zynqmp_pm_invoke_fn(PM_PM_INIT_FINALIZE, 0, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_set_suspend_mode()	- Set system suspend mode
+ * @mode:	Mode to set for system suspend
+ *
+ * This API function is used to set mode of system suspend.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_set_suspend_mode(u32 mode)
+{
+	return zynqmp_pm_invoke_fn(PM_SET_SUSPEND_MODE, mode, 0, 0, 0, NULL);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.query_data = zynqmp_pm_query_data,
@@ -440,6 +467,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.clock_getrate = zynqmp_pm_clock_getrate,
 	.clock_setparent = zynqmp_pm_clock_setparent,
 	.clock_getparent = zynqmp_pm_clock_getparent,
+	.init_finalize = zynqmp_pm_init_finalize,
+	.set_suspend_mode = zynqmp_pm_set_suspend_mode,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 015e130..1424170 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -28,12 +28,21 @@
 /* SMC SIP service Call Function Identifier Prefix */
 #define PM_SIP_SVC			0xC2000000
 #define PM_GET_TRUSTZONE_VERSION	0xa03
+#define PM_SET_SUSPEND_MODE		0xa02
+#define GET_CALLBACK_DATA		0xa01
 
 /* Number of 32bits values in payload */
 #define PAYLOAD_ARG_CNT	4U
 
+/* Number of arguments for a callback */
+#define CB_ARG_CNT	4
+
+/* Payload size (consists of callback API ID + arguments) */
+#define CB_PAYLOAD_SIZE (CB_ARG_CNT + 1)
+
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_PM_INIT_FINALIZE = 21,
 	PM_QUERY_DATA = 35,
 	PM_CLOCK_ENABLE,
 	PM_CLOCK_DISABLE,
@@ -73,6 +82,12 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_ATTRIBUTES,
 };
 
+enum zynqmp_pm_suspend_reason {
+	SUSPEND_POWER_REQUEST = 201,
+	SUSPEND_ALERT,
+	SUSPEND_SYSTEM_SHUTDOWN,
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
@@ -99,8 +114,13 @@ struct zynqmp_eemi_ops {
 	int (*clock_getrate)(u32 clock_id, u64 *rate);
 	int (*clock_setparent)(u32 clock_id, u32 parent_id);
 	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
+	int (*init_finalize)(void);
+	int (*set_suspend_mode)(u32 mode);
 };
 
+int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
+			u32 arg2, u32 arg3, u32 *ret_payload);
+
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
 const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
 #else
-- 
2.7.4

