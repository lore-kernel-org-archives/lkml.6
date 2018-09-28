Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FD4ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F030204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="o7+duBT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F030204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbeI1Xi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:38:26 -0400
Received: from mail-sn1nam01on0053.outbound.protection.outlook.com ([104.47.32.53]:42976
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728451AbeI1XiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vCzQhuRHarQbbE3PXhCcPtrd6OcslaCWvAzyxXFERs=;
 b=o7+duBT1NMOTod0hYTSD3mfXYP+CiFC0qmO92j0XLN0uqenYvdFQjVU0Q+CphxvBZp+I/lB92ARcyxvJjV/LoXXsNUjbyOLo0vo5EvKrmY6AbFPNvUamgggfSp3NH7vDE/v3LIocv+mbokzSQIHEhQd6jkJeYatqZt5pcZiHidQ=
Received: from BN7PR02CA0010.namprd02.prod.outlook.com (2603:10b6:408:20::23)
 by BL0PR02MB4467.namprd02.prod.outlook.com (2603:10b6:208:4a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.20; Fri, 28 Sep
 2018 17:13:38 +0000
Received: from BL2NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BN7PR02CA0010.outlook.office365.com
 (2603:10b6:408:20::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1185.20 via Frontend
 Transport; Fri, 28 Sep 2018 17:13:38 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT030.mail.protection.outlook.com (10.152.77.172) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Fri, 28 Sep 2018 17:13:38 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g5wKf-0006al-Hp; Fri, 28 Sep 2018 10:13:37 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g5wKa-0004HW-E4; Fri, 28 Sep 2018 10:13:32 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8SHDT6Z019274;
        Fri, 28 Sep 2018 10:13:29 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g5wKW-0004H1-W7; Fri, 28 Sep 2018 10:13:29 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <olof@lixom.net>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <michal.simek@xilinx.com>,
        <arm@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v4 3/4] dt-bindings: clock: Add bindings for ZynqMP clock driver
Date:   Fri, 28 Sep 2018 10:13:17 -0700
Message-ID: <1538154798-6828-4-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538154798-6828-1-git-send-email-jollys@xilinx.com>
References: <1538154798-6828-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(376002)(39860400002)(2980300002)(438002)(199004)(189003)(476003)(50226002)(126002)(54906003)(11346002)(48376002)(14444005)(446003)(44832011)(72206003)(50466002)(16586007)(106466001)(106002)(6666003)(426003)(7696005)(8676002)(47776003)(2616005)(2201001)(36386004)(76176011)(63266004)(486006)(51416003)(316002)(9786002)(34290500001)(305945005)(186003)(77096007)(2906002)(4326008)(26005)(81166006)(8936002)(81156014)(478600001)(356003)(110136005)(336012)(5660300001)(107886003)(36756003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4467;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT030;1:ZHS8FBS+GqgLsgATnxMvS6Erg2ZhCK6OuBpZFcvpBsLWKYpx21BdgUqsbK9idecqTSPRT2gwmg0kjHZWToKKZ2ZaMRMG7nD4/1b7nj+7yVVFGQfAgHvODdBpdy4Vh0w5
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3534ec48-2d18-4bc9-e679-08d62565bb51
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4467;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4467;3:4bRvhSYryAzjdOs9hyWoCmgaupLPwa0HDGzmI9nMGtT4dx8TrPoQfuivn+yZNewhT90PTWP1ngwlmE9ONplzrr+opGjoXFfL8z7FhhufbGPDLpxucisQrouVL21Pkapsm++X1uySbe1nPTYNdj69REEO2Fue0o5BdJEm5BR/Dv/wIAMuIpu9jYLjyGzE1sOH1l8gzYf4xCoUv9XSnhXuvmIFX7pQ+8D6qsAkkYLyYTQgjP2nC49Mq+bN8UHn1bpRa1hx8dmGDXQbNCx9XazJb4mQCXbTtY96G8srFdC5cViHlaYkJTAiI5Jo0ti834kR3c18vzKdyy4bKo1iOmwqUmmJCV2kljO4TJXhUZUeniA=;25:aqzOSN7PmVLS4mzCZRvZqMlERLIwkheZa1niQviaKBVNflEKzL+NIocPhA9gotWoA+X4/eagmu0PX17QaUIaiZ2+5Y/tmmLWiHYlhRoFdp75eCm+fVLETC88tFQTHoHXPR8Pd38B1JiXOrEoXHMmuMfCr7EjkeBqIVPeP0OKLKRUZCI7vGRupU3LSjMueLD1V8+SpQp/pu0qwFQwobaRxRO9xfem3TerikDGbnOmI/smayoOaFqhcQjsWe4w1ZaPzJBwmahFFvTz+1xuIiyPLej1KGwYqaICEzLCtt6MQtGm2EDdwhtMsq8+uISInurSfowWw0+epHe5PqXnNuabjw==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4467:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4467;31:Zk1uqEi+m/2jKfXmqlaW+JHnxYf5SBRwg/d4r5RZmXMBme3q9HX1hFxVueX6bMKzgXxbNG5a53SuKc6zObgSp0/BaUnvf/tUpsLtfSG0lRJt6IYJ+QhwmBsHrYyQxwN+ZEsi1Eomn5EjNuXxYaev4q98tTZ3SlpRV0R9G9dq5xa8L+YIgTp1AbadBeS2WPtml9PnMY11FgJiVeWK9WtBjrw89spQRb+VMfx5LDrzJLc=;20:INGHHPlQg6hF7ssyHBH7oCJbjsx5x8nsKruBRw1WxUhAFrV/3XTwe/50IhwsL3RgcpUyzf19MK7k4ysuswvUf8y7cwqZVsw6PLObVkjz94oSCaB1eSo1W7koFJnUNUnIqUt/IbGj0CzcPJJim0mXhKLPrSJZPSYK9jF85s164uodS7qUJ/p6bQmo0n1Qc9/nyP73oy/LDEjRemmGZnBHMRfS0IbfMmE3Ow4Llxh3604XG8gtRsYjJgjoqdXLc3vn+15oLLRCsBDl6Quqsmn3Etx4ZMr1nl+XG08kM+etQqE3pSxoN4Hxb9IZK057icjGh5CX3pQZVwpEiRvv5E0c2+ad7xqoswOkN6EN4l70Z2CEPubsAkZ7D/uDTqoKD0ENaifA/Rsn69SP/3PSV5Xfao2NHqGoGOSOWOCLgc82xPBM2oEyJ23bJhjPr2QBxX4k9gtH3Z3LsBv44WEkYylvcsI/kLkBVhCzSkmPz+ABOlA7bZ5TTwsEcwQIzwSnwt3p
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB446708BBCEC9FA17A652DEC2B8EC0@BL0PR02MB4467.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:BL0PR02MB4467;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4467;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4467;4:oCnvW6Fk6LpbMGBOWV3lajcdViCPrd9VKeMYWzhZYufSBdXoMn7f07dr/9+w2uF1wAukxdTP14/ETsrEfebtlom1pGZ+S6Wg2OiWFCbm5LBp2QnMLZ8Zj4rLAR0GUV/NdSoQd+18nitnpCiRric+1RMk/kf2qe7PIw3dK+NMfq6EWMZIJkoSXr7f3GxBDeHlRpdAHKlEjqoyKFnCRIL/BrhWJeASWr+ZV5YE0ONNBNzGW9iB39zg1zebY9KXjqBglQ8tubWGJJRvsPEjHFfJEJGTPJXsPe63JScCXsvuVTFq1SZS21I7nZyOyb3cAvAg
X-Forefront-PRVS: 0809C12563
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4467;23:cxJLv1mijq3r7y3YKvXqsBRpLXbcHvgtYxFHA1pGd?=
 =?us-ascii?Q?V0Ed3lsOGBWWPLG7umIDWk81ko5Jj16MnsfnVliut39XR5o6BGY524rxncFs?=
 =?us-ascii?Q?H7aosdrRnQ5jXaMZd9UO+wvTdQcUecJQhxGyQdboWwsXpU79bDTAu8WwZhO4?=
 =?us-ascii?Q?uv/t8URVJ7yrNTCQMD9WUt4BbJ0xFDUaE7zunYwtII2fssTbZlonbsBlkQiN?=
 =?us-ascii?Q?UhdWK216GXf82FoKPMieVPbbY204XW5OGwRZvh0Ym8UxpwpwsbZQBSmB5S+R?=
 =?us-ascii?Q?Rr8E1hwfBwZLMEWu5cN2cCQGIcgJJnPRks3ug4/Z+hxg/0DNGqpAlvIXOrXs?=
 =?us-ascii?Q?hmhrz1MK9Ehi05teDBo0QJEN4mmuKTrqjNcN8ng92CqNZIQUf9/fHkKlEJdj?=
 =?us-ascii?Q?4+WhKZzJLRG/dYO6ekkdHXkUjYn6FZ5tnL1aGu6SQmCehKfuk3t1inlkqFkt?=
 =?us-ascii?Q?Q+JgMZ6iYxagtjiDNIwmhjZgx79rYsTCXtP3cl4DiLIpS2L6gsGcotS1Awqo?=
 =?us-ascii?Q?+rTch0n3tH8J0CVWFbDzCVJBW1VTPpbDopT1C5FUQUPr8dmTuNrJzz8okNzr?=
 =?us-ascii?Q?LIGDUTgJhx7TcABazPr/RfdfGMbnvvNJ7DH3uJZzQAWEDNWEB5lcSpt7Ofyn?=
 =?us-ascii?Q?qXR3pBf0lBP8Uqt20ZPfL0ki/uer2QQaQTNjohSP6vVea3D0enOI8DF0Xi6a?=
 =?us-ascii?Q?sBS9pHwd2xhv0fxrg3mqYVwBvPCOkotDVVqRyLAjX3MIfCRtgm3oBraTB8f7?=
 =?us-ascii?Q?tzwN2NGXgb5C6ckBkGLV/S62iGPcFbj0J3mhVqSMFNmsgesGGt6wKMWk8BD8?=
 =?us-ascii?Q?XonliYgYTX0GObvBVa+F5ChBryXAGjlgu6ZtvWDXvQxdbhmgZTowlouNVneW?=
 =?us-ascii?Q?uVetxAaPdEbwMmcU7cGQNdEvVcPHRseu8KqXDF5+LrzRudzLEa5ez3VRZCEx?=
 =?us-ascii?Q?RxJdFY5Qbb6Y40FjDpQK8xoCxdUrte/9PvO4ZpiayHRJMFkIpTacH0DCRWya?=
 =?us-ascii?Q?TiPjMcSrMN1/YKRNcDYsbQHBTyrBngSnl9na6h0tN6Kfur3zPuvxXV2XdZ2a?=
 =?us-ascii?Q?MCGlBhQbMe5rc5sL5VRDDpLVW2oz5F7dWpmLrPlTtvYaimMGmOGyAyAYb/No?=
 =?us-ascii?Q?DT36MwUSMLsV5pB49B1vMw4kqz5cOjdnzluLfEzxS+oYCpcYziKjmuXfKKg6?=
 =?us-ascii?Q?h8wgeXrV6pqTf9qoBYAze6imjZpn4GBugjf?=
X-Microsoft-Antispam-Message-Info: kux2s4Mo+yo1b4vF99CMYBGHE3akuY+qL9FthA73tMYXsp3cHarXxAcKPuJlp3lXCH6W2mxHMEGJjYxKAeh29gxu+O2vbuiwqhtzTZvfDQFNUQT9uvffpX3jPN1xmcUzB6lq2AQ4Nh2cZYGxZ1g74QppqSb/CraVb6pOZkJp04lk2k7HfTDSONOEArtuATIFOUWvMYsCDx2grJ+vJvkEg7vWaszxIpEFu1uzJDrFIicS+drpp/vpYeDD/pqO+lcFHV9jn527lQOZnlvfTMmKlUb5L2oykPaA4Tx28t+HyVKlo8+QxDaHx8BGPSD1do9UTXOznKio9USOUYZI5Oj8ySl6M25N5rnAq5g+bfQaj0o=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4467;6:EIlJCbUzwxXJDMQ4ZtGj7GBwSYr2YXJhsmmoaUm4qM+l9ejLBlIfzMQWM11/CeHNTnvPq/nxQytGi/STxf37aUk4MM5pqj9/KyCoWzDmYo4dzGWFGaDLmzH+gJlY+spYd0nrRON6Arqojw7ekjRwfhbr3kWDdihgCSIxDgEMjTBrIUjznT+7Vh8C+UG7TLHA5NBn6HQCeRlIZJUvOUT69V01FIdBnn8v82YfjpLWef3yEiwRxUWUQdI2EpnsskfZD/vLOI86tkzM1fdMJ43V7E/XosFkpbp6OWwpzJ3rD8uCADd/kQV2wXFdDxlfL7eMQ4RN66CTL9XfFMqY1233yosAqinpmqghdesnRjFjr0aeWRmrfNvupikKW5ZuSMIPbi/zxoAr01u458+LIWTCAVwBszEADu3RoVWIqvtJrw5jYJ0gmOJ1V2ostlT7bOu87W1fWN1uEXNW7gskahCCWg==;5:fo9lXxaAx3M7Lyk4I30l2p0JGZpe4SmMyorxrK3dTDjI8MD/CExaEX1/Pk6uDJfVz8OvlMxNI1JOO/AtRZ7tBO7R4IHdTNwxia9gi6V0OtVmHutWTSwlFZQRLz5HrY9TooCOG+8jUTYXCfcFjVHpLhjvPlXxOY613zqWefQ5JZo=;7:qluNLZpcpDg8Ov/KY+4P9aQWNHqq41QQ9E5YWC64rhzgLj29J8hW1QHWTPMRQdqiV8j0CstxkB9vPuWGG8/bvPGea5xJCvJ7zy0CN04yiQVGd5hJVmEq+PGnt6z0HXbAa25CegtcziqVKRzFpxcSy1J1xZ49eEC21C/hbK0V93SkuqgD1RmrFdA7Qg02NFFy0EoBZk9NZ3OJ68zRUwQiSA6zlp639O8ieDKdBpZzuj11EGI38GfkRGjdEwYh+w0J
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2018 17:13:38.1635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3534ec48-2d18-4bc9-e679-08d62565bb51
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4467
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation to describe Xilinx ZynqMP clock driver
bindings.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  53 ++++++++++
 include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 +++++++++++++++++++++
 2 files changed, 169 insertions(+)
 create mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
index 1b431d9..614bac5 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -17,6 +17,53 @@ Required properties:
 		  - "smc" : SMC #0, following the SMCCC
 		  - "hvc" : HVC #0, following the SMCCC
 
+--------------------------------------------------------------------------
+Device Tree Clock bindings for the Zynq Ultrascale+ MPSoC controlled using
+Zynq MPSoC firmware interface
+--------------------------------------------------------------------------
+The clock controller is a h/w block of Zynq Ultrascale+ MPSoC clock
+tree. It reads required input clock frequencies from the devicetree and acts
+as clock provider for all clock consumers of PS clocks.
+
+See clock_bindings.txt for more information on the generic clock bindings.
+
+Required properties:
+ - #clock-cells:	Must be 1
+ - compatible:		Must contain:	"xlnx,zynqmp-clk"
+ - clocks:		List of clock specifiers which are external input
+			clocks to the given clock controller. Please refer
+			the next section to find the input clocks for a
+			given controller.
+ - clock-names:		List of clock names which are exteral input clocks
+			to the given clock controller. Please refer to the
+			clock bindings for more details.
+
+Input clocks for zynqmp Ultrascale+ clock controller:
+
+The Zynq UltraScale+ MPSoC has one primary and four alternative reference clock
+inputs. These required clock inputs are:
+ - pss_ref_clk (PS reference clock)
+ - video_clk (reference clock for video system )
+ - pss_alt_ref_clk (alternative PS reference clock)
+ - aux_ref_clk
+ - gt_crx_ref_clk (transceiver reference clock)
+
+The following strings are optional parameters to the 'clock-names' property in
+order to provide an optional (E)MIO clock source:
+ - swdt0_ext_clk
+ - swdt1_ext_clk
+ - gem0_emio_clk
+ - gem1_emio_clk
+ - gem2_emio_clk
+ - gem3_emio_clk
+ - mio_clk_XX		# with XX = 00..77
+ - mio_clk_50_or_51	#for the mux clock to gem tsu from 50 or 51
+
+
+Output clocks are registered based on clock information received
+from firmware. Output clocks indexes are mentioned in
+include/dt-bindings/clock/xlnx,zynqmp-clk.h.
+
 -------
 Example
 -------
@@ -25,5 +72,11 @@ firmware {
 	zynqmp_firmware: zynqmp-firmware {
 		compatible = "xlnx,zynqmp-firmware";
 		method = "smc";
+		zynqmp_clk: clock-controller {
+			#clock-cells = <1>;
+			compatible = "xlnx,zynqmp-clk";
+			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
+			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
+		};
 	};
 };
diff --git a/include/dt-bindings/clock/xlnx,zynqmp-clk.h b/include/dt-bindings/clock/xlnx,zynqmp-clk.h
new file mode 100644
index 0000000..4aebe6e
--- /dev/null
+++ b/include/dt-bindings/clock/xlnx,zynqmp-clk.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ */
+
+#ifndef _DT_BINDINGS_CLK_ZYNQMP_H
+#define _DT_BINDINGS_CLK_ZYNQMP_H
+
+#define IOPLL			0
+#define RPLL			1
+#define APLL			2
+#define DPLL			3
+#define VPLL			4
+#define IOPLL_TO_FPD		5
+#define RPLL_TO_FPD		6
+#define APLL_TO_LPD		7
+#define DPLL_TO_LPD		8
+#define VPLL_TO_LPD		9
+#define ACPU			10
+#define ACPU_HALF		11
+#define DBF_FPD			12
+#define DBF_LPD			13
+#define DBG_TRACE		14
+#define DBG_TSTMP		15
+#define DP_VIDEO_REF		16
+#define DP_AUDIO_REF		17
+#define DP_STC_REF		18
+#define GDMA_REF		19
+#define DPDMA_REF		20
+#define DDR_REF			21
+#define SATA_REF		22
+#define PCIE_REF		23
+#define GPU_REF			24
+#define GPU_PP0_REF		25
+#define GPU_PP1_REF		26
+#define TOPSW_MAIN		27
+#define TOPSW_LSBUS		28
+#define GTGREF0_REF		29
+#define LPD_SWITCH		30
+#define LPD_LSBUS		31
+#define USB0_BUS_REF		32
+#define USB1_BUS_REF		33
+#define USB3_DUAL_REF		34
+#define USB0			35
+#define USB1			36
+#define CPU_R5			37
+#define CPU_R5_CORE		38
+#define CSU_SPB			39
+#define CSU_PLL			40
+#define PCAP			41
+#define IOU_SWITCH		42
+#define GEM_TSU_REF		43
+#define GEM_TSU			44
+#define GEM0_REF		45
+#define GEM1_REF		46
+#define GEM2_REF		47
+#define GEM3_REF		48
+#define GEM0_TX			49
+#define GEM1_TX			50
+#define GEM2_TX			51
+#define GEM3_TX			52
+#define QSPI_REF		53
+#define SDIO0_REF		54
+#define SDIO1_REF		55
+#define UART0_REF		56
+#define UART1_REF		57
+#define SPI0_REF		58
+#define SPI1_REF		59
+#define NAND_REF		60
+#define I2C0_REF		61
+#define I2C1_REF		62
+#define CAN0_REF		63
+#define CAN1_REF		64
+#define CAN0			65
+#define CAN1			66
+#define DLL_REF			67
+#define ADMA_REF		68
+#define TIMESTAMP_REF		69
+#define AMS_REF			70
+#define PL0_REF			71
+#define PL1_REF			72
+#define PL2_REF			73
+#define PL3_REF			74
+#define WDT			75
+#define IOPLL_INT		76
+#define IOPLL_PRE_SRC		77
+#define IOPLL_HALF		78
+#define IOPLL_INT_MUX		79
+#define IOPLL_POST_SRC		80
+#define RPLL_INT		81
+#define RPLL_PRE_SRC		82
+#define RPLL_HALF		83
+#define RPLL_INT_MUX		84
+#define RPLL_POST_SRC		85
+#define APLL_INT		86
+#define APLL_PRE_SRC		87
+#define APLL_HALF		88
+#define APLL_INT_MUX		89
+#define APLL_POST_SRC		90
+#define DPLL_INT		91
+#define DPLL_PRE_SRC		92
+#define DPLL_HALF		93
+#define DPLL_INT_MUX		94
+#define DPLL_POST_SRC		95
+#define VPLL_INT		96
+#define VPLL_PRE_SRC		97
+#define VPLL_HALF		98
+#define VPLL_INT_MUX		99
+#define VPLL_POST_SRC		100
+#define CAN0_MIO		101
+#define CAN1_MIO		102
+
+#endif
-- 
2.7.4

