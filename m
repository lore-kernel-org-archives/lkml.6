Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2461BECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF202098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="1gvjX1Kh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF202098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbeIQT4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:56:24 -0400
Received: from mail-bn3nam01on0084.outbound.protection.outlook.com ([104.47.33.84]:4340
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728839AbeIQT4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxYznD8722s7a2M8FIzPk7h2tOrvoGk+tafkb7UnGyg=;
 b=1gvjX1KhqfN4t2ArqZ0QcKbN0CNnV6qEySb1btALxb9E2OYHCCnwutxxTyfA5uKZPMmp6lJzssw62GAgtwOP7upot5YJeTWVUI6i//R7RXw5hl/i/39LqJeoIYqcRUJ9ktykLuChtJ+gvKmSZUJ2Agn0UkIe61tEzCm3VoxJqRM=
Received: from BN7PR02CA0031.namprd02.prod.outlook.com (2603:10b6:408:20::44)
 by BL0PR02MB4468.namprd02.prod.outlook.com (2603:10b6:208:4a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Mon, 17 Sep
 2018 14:25:41 +0000
Received: from SN1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BN7PR02CA0031.outlook.office365.com
 (2603:10b6:408:20::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.17 via Frontend
 Transport; Mon, 17 Sep 2018 14:25:41 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT029.mail.protection.outlook.com (10.152.72.110) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Mon, 17 Sep 2018 14:25:40 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1uT6-00056U-8u; Mon, 17 Sep 2018 07:25:40 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1uT1-0005Mt-5X; Mon, 17 Sep 2018 07:25:35 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8HEPPdZ003531;
        Mon, 17 Sep 2018 07:25:25 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g1uSq-0005LQ-GB; Mon, 17 Sep 2018 07:25:24 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id A904F12159B; Mon, 17 Sep 2018 19:55:23 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>, <leoyang.li@nxp.com>,
        <sudeep.holla@arm.com>, <amit.kucheria@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 4/7] edac: synopsys: Add macro defines for ZynqMP DDRC
Date:   Mon, 17 Sep 2018 19:55:02 +0530
Message-ID: <1537194305-9243-5-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(2980300002)(438002)(189003)(199004)(103686004)(476003)(72206003)(356003)(486006)(186003)(63266004)(478600001)(48376002)(4326008)(2616005)(50466002)(90966002)(305945005)(11346002)(44832011)(126002)(2906002)(36756003)(8676002)(5660300001)(42186006)(336012)(426003)(110136005)(7416002)(54906003)(6266002)(50226002)(52956003)(446003)(6666003)(36386004)(2201001)(8936002)(316002)(16586007)(51416003)(26005)(106466001)(47776003)(76176011)(106002)(81156014)(6346003)(81166006)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4468;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT029;1:Q0uDU4tO23SbhIC2BUKMSmjb16d2ag3+zlDvCXE3x1bF97DR/KxOL2PyEi8XNh4GEJKnaflbfgb+fjoLwbKmJP8hjkkoXAnp7lc3kU47GGJaalfWEG8WJq4NiLpuNC+Y
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e6195f7-af2c-407a-21e8-08d61ca97247
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4468;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4468;3:DT7d54XNcOPR1qzEPFNk6+VHlmXRAySy+fZ/rK1yw0cUDb88kzFb3qyDv26EMk8TeyFBpJrWVs6eY9TvB5RigsymADSKlvMfIDLBVdR7H8F51Z5G0lwexNFIuxJOkWjm3zMwTEax43fUYVkQYORyXnT3nNS6aZxXUIc4sq3owuP4WOBLfA3lFpQSxp8xqz5D58x11/qII1zgRxvR4GuPAG9gqbPEEdgAD73zOV9U4sZ5K1Li6ouCvafx1/qOM8Ps42cAPTAKkdQY28e3wRuLF9nmwCSVnIo4dMfFbZqPeHLq554Rx4sVWChYkPm8/1mdMHKNt101rM+CtjDZtB64YqtvQ9KSZoPTOjPYjfwhwhY=;25:n9wAPlzUr03h3PBJqdM2KD7WHvUMyg9CPIPwyWjVc7opGHFtknBDAnVldD02K8rZxtyalu1rojh+fCdXubeU5Q5aQMkKLPwrHkqWfL/2C39qW3rfV1eoxgj7BYjcSVCdJ5yfzjBoQuHcI1917NjB738pqKgk7xRe0Ah/fFSY5dvrWSD5eBWzRIXL2KH1OUGdNypPNrSwAz3c3RoAtTFmWzCbKn9ldnmbm2ZG7Sg47MTfyQxpHSPyeCWqzpzc7PLc1a6gNn/RlWB3hfosUHmNtruoXlDL84qXnCzhUxMY1hRUrNxbpx43rcKO4FM5oUR5x7BYvkPWvQ2I9V4sOnuKjQ==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4468:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4468;31:0ivaJwyBMjfCnEhKxRGfNoMZAvXvNwXC2g3GC+gbI2NTmiXceSH0ZisPNFVcnJX/4gKAoKyh/YzGD0qHRjinwYA24fW8MRvU6Q5iUmhwiivsCEOYf+K/TGGJsk6UVv80F4a+adsmdEjcyyK7PIr1VgybJLdacLGb1RfNqdzqrGWpjaFDXv551RUj7ZPvqb+LFF2b9neOlMKSlMapjRkd6HexbcRGlAZfKbRJFbWuo/4=;20:yuOSLBg3zOovXNXajmL/REsTFtndG3CCUnWSPFAnKYgkWbP0ccE9TNUkCobaT5o+DqllAHN8aZ0WDv9KZGuHrmpiCnRgrZiCx8X+kSWdrc6/sBchYebb1WqpsBX8NLoDmMdIpTNM2TBn63y1Cg5A5n3qa16iaRM00w45xcjhnfn6sJRks0dRSwQ5aC8Ond6d/6ZKVKJ9xUd22CT6o5VJcumOr3cdfYJWsOp+sUBO9C8UC9itcmV1HB6y0qJ9okqG8EsZPYxbbRDcs8ql0Re7eMjPcQbfppYA5pLYd4Q5qzZibBlqpltG78xQp75G4o1FrsWrgtgTW22CQi30FbExEkmXje5FTGY5ruUAICxoV/62tgqPGdJPIMvSID+s5BAkN6ZQJTMoDzBbddt5VJS3WhA1VByO20H4AiECOM9RvIC/vuKrOu//XvgriAF0iRWfcirpKAjs9bb6AYmnLMuMOamhONIPxiJgGJAUAYtlw5WUD220RI0nuqtYPuMXuoPU
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB446839F273921C0959A1FCCFC11E0@BL0PR02MB4468.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(105169848403564);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:BL0PR02MB4468;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4468;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4468;4:G7SwPHBkUDs0MRdkJk2D3VbLxKIS+Yf0jiSYDh5RAJypVuWCgvehamLvY8e3JmnhoimwCv60Pmi56FgmfKsL8+2WPRBA6TZGm7nwjpbLeNiUNF3c5rb/eFB4nE2eKFmME7XP4Dlvh9FNiLf3VzSJoZ7kdAEIDE316VklAZ63cg9e/Z5srUUdzvQ+SGccjhmk5cN7P2636HTlKNmO1aXYGH8C5m8cP5OeT+bbqUXvPvPkSPE8l7CqWB94Ytfde0NAiaHNghrFaIrRl6WivHOh9PlDUrwMSCk5b9xcyWIql4olCkqbVf0V3FXjyEqBvOcXCIHW3BhvuODCnBdRFaGMWL/+I+jccYGopCM6VEB/cPU=
X-Forefront-PRVS: 0798146F16
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4468;23:OvcGnBfc1lJBi19JGzGtGQsYehTr864XhmTMO9Fi0?=
 =?us-ascii?Q?7m72EDpgb/nXmhxNVPIeAc33W6Z4tBjlFSkwuRQmdr7ct2yTFa+WRBYZWrM0?=
 =?us-ascii?Q?226+wswU8mmhqTNeYRd0jhF28J8MVkaVc3YtaxYuveT53N14stQH1RiLv8jk?=
 =?us-ascii?Q?brVFofxGm2gHF/g261gZHyjvCnfwwqJDgs6Py99t4ugGFmMdPHzLpDdVBL1T?=
 =?us-ascii?Q?sUDTpHPwFSeJzJwCTJ44Z8tfwvQjL5S49M5ly+ClAewXFrbO108QZRPexk6k?=
 =?us-ascii?Q?Vv+HZF0PdyFeJZr+R1WewK2aricVF+yyyb90slBH75zZySExkkzi8XJ1J7ZD?=
 =?us-ascii?Q?Hx4LjxT5ruf9o/YjyUaxanF6uiegmmrPep5XTl3Btr5cdk1heytociCZvldu?=
 =?us-ascii?Q?zgo0U+HZE476bLB7aQzWoadWRrBPype2h5uso5IMQ7rrt/an6a63ouOe3IJB?=
 =?us-ascii?Q?8BEDaBpdWqezvc5mdfCqhuvmodrnrolGucQCUeyfffgSe+1WAk+GQi1fxOuq?=
 =?us-ascii?Q?GrD4KnxILpeLmrBjJ98lkfoc5iR3EB9BnRmofJZLa/8AHurTzzMRjpzTATj1?=
 =?us-ascii?Q?RxVmowFL8SoFbDdc0Ck6+9WFtYXFQhyGOLLFuYy0xjFWJn94SzfW6ABefh/V?=
 =?us-ascii?Q?faBgbL81qfggO2WSPZ1XMi6E7eKWPOXJfXZMSQ3NAjsovN6mc47v5c2KoeWW?=
 =?us-ascii?Q?pzpvtK0AHCYdNo2LpjAoSmhKWSqCASzzMWLgQ5P9LDOavkMHJLqLiKp3rJUu?=
 =?us-ascii?Q?lY7owK65KUSeqN8SIk8qWruvnE+68hx25ojclQZb5oCSCvS/yZhyLhawbVVH?=
 =?us-ascii?Q?ZzJbCSQA1KJsNCrFHGfI6SiR7DW/YQxTGFNKK62wQQH6BEdpQeuOoKFx48ns?=
 =?us-ascii?Q?vtJNZ5+3TNH3K8UHYRZvgwsgvwJzA84GKhBihsOgNlH9HTDyHwBgr+AnkxhB?=
 =?us-ascii?Q?NDrjpVfI5j+/EDT1chbGahqSon5z04k973WIyrI8hSoB4eqEg9E6PH+BF0cX?=
 =?us-ascii?Q?XIf0YAACrTw8krd7zQ6duD9pzuK0XG4fjluAw6GgT0eVWv1kncKoDrRf24wu?=
 =?us-ascii?Q?9BCRHp9alcBL0DebDq1If1AzE/7gM9ECG3GT5LkPXwWZk8Q9zt2hFIa1ooXO?=
 =?us-ascii?Q?S/SZ+lBM5q1qu4nCsA18SjcEd1p8TqZeCf9DV84V5ij1BJxac+iW7zIIG9KX?=
 =?us-ascii?Q?i4LJlYvcFMOnSl1UtR/aUwqe8B0Kshfvn1l6i7EadnpXxnEunc9U0uk9/kWJ?=
 =?us-ascii?Q?ojKBiMBW7916k1COTQ=3D?=
X-Microsoft-Antispam-Message-Info: g+UnuQsvH42eUruLjq2tchJZzofIcTZVsaLWHf7Zvz2SIhegj21xos8OXmby+T79+s10QmQxlmlv67HNJL3wV1BUz8Lx2LVzU/E1JbEvw4Bk2oPQh11ovsfLenc/WAxfmDQYE/zhdgkQEm1ynYm5YpYYJ4Xr7x/o4acJ8LD0H9qyDBzza1hF+39EsWS8+69iyaI5NpESfvpF29qh7A+Y9s0kh8Ktit5IAdvXKkrUfFKsdo3O9fDLWMHzn2P9v+6UCtGnhC4p/XwZzTZ2g7tiw90USj2a4NLjUJFeFgirYlGZGqGj1KKbCrdVCCY5d4FbVSVTCC/cmGRyKRgzmlmXXrM4xVIdeTImflyacQckYvI=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4468;6:ilrP0BMnD7eRlUJurOt4mX9UHcVR5XqTwpz3IYyKoocYWALpuPLRreZNpXKKb+D1p3iCruOJ5mk0I1QVCS/z3jr3TnF58rrZaT5s/Xke2uZzLWuVQlMJvSn94ZNd9IXFGEx2NXE+jRbFjJWezMp1F9R8b9SDTEJ1PgbExZDHfWMAYiYB87Fm8/9LnkZ06xVKlL672xHN7GWEmycWfyyEy3dLm5sNuW+qgiqN/hjvYSeYjMPrWLNt4Xbwu6ktt9jL7xLUEVb0nkhZAVWvpVYO2ouMv4ffDKfR0HWvFYofuJCP6TcU6Ritp1qXGxhMJh8/tZ8dsstuYa4FNgAAJJeTp07QwJFWP3P/LgjFa9Mh6y6/crC7KvK74ZzHZd/ei0P1gvXd1/LlsM9UU4vP48l9btBnRGVNmyjv3g7KBsKCLmpVJnUu7GQJ1AUYI07PUf93hjfPLlljmqJe2NcVfc689w==;5:0v3KfXFT+2anTw8tinIwGipVIORsST5hsTIAifn9Dq4wWz8yjS8di+KkmhXtR7rVKTPm5eex0imzrSRWKp5IRFeCrhp4pgNLLKYMhbr3fRjycetiHYqKZAB3BStudvohYnigGrgizgMbj8+cf77GRjYMlrJgaCMNAO6CWxTw44A=;7:D6R8WcRJOk3K+kkufkziquPQIw8odZ3mx94grqyOW4YzpmABcs2xX5EZBPuaw5ZdRqT0ka/86CccRr/i1kL8y0OA5pjLfUVYYJ72cb38SZC5fc8bbtL7d4nzNYwogf5IwFYfgdBgf+UdHOXKdntgZ4aFCiMnN0QUalF3tq7SFq+DJuTZMLB8hOhy6ECIrU5qNHCYNfeARsonjV0j3zvgzMga6aVJyUva3IMxMgEhhXb1MS2/0eXjQOd+weeH7k2d
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 14:25:40.6975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6195f7-af2c-407a-21e8-08d61ca97247
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4468
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macro defines for ZynqMP DDR controller. These macros will be used
for ZyqnMP ECC operations.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 168 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index eb458e5..6bf7959 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -97,6 +97,174 @@
 #define SCRUB_MODE_MASK		0x7
 #define SCRUB_MODE_SECDED	0x4
 
+/* DDR ECC Quirks */
+#define DDR_ECC_INTR_SUPPORT		BIT(0)
+#define DDR_ECC_DATA_POISON_SUPPORT	BIT(1)
+
+/* ZynqMP Enhanced DDR memory controller registers that are relevant to ECC */
+/* ECC Configuration Registers */
+#define ECC_CFG0_OFST			0x70
+#define ECC_CFG1_OFST			0x74
+
+/* ECC Status Register */
+#define ECC_STAT_OFST			0x78
+
+/* ECC Clear Register */
+#define ECC_CLR_OFST			0x7C
+
+/* ECC Error count Register */
+#define ECC_ERRCNT_OFST			0x80
+
+/* ECC Corrected Error Address Register */
+#define ECC_CEADDR0_OFST		0x84
+#define ECC_CEADDR1_OFST		0x88
+
+/* ECC Syndrome Registers */
+#define ECC_CSYND0_OFST			0x8C
+#define ECC_CSYND1_OFST			0x90
+#define ECC_CSYND2_OFST			0x94
+
+/* ECC Bit Mask0 Address Register */
+#define ECC_BITMASK0_OFST		0x98
+#define ECC_BITMASK1_OFST		0x9C
+#define ECC_BITMASK2_OFST		0xA0
+
+/* ECC UnCorrected Error Address Register */
+#define ECC_UEADDR0_OFST		0xA4
+#define ECC_UEADDR1_OFST		0xA8
+
+/* ECC Syndrome Registers */
+#define ECC_UESYND0_OFST		0xAC
+#define ECC_UESYND1_OFST		0xB0
+#define ECC_UESYND2_OFST		0xB4
+
+/* ECC Poison Address Reg */
+#define ECC_POISON0_OFST		0xB8
+#define ECC_POISON1_OFST		0xBC
+
+#define ECC_ADDRMAP0_OFFSET		0x200
+
+/* Control register bitfield definitions */
+#define ECC_CTRL_BUSWIDTH_MASK		0x3000
+#define ECC_CTRL_BUSWIDTH_SHIFT		12
+#define ECC_CTRL_CLR_CE_ERRCNT		BIT(2)
+#define ECC_CTRL_CLR_UE_ERRCNT		BIT(3)
+
+/* DDR Control Register width definitions  */
+#define DDRCTL_EWDTH_16			2
+#define DDRCTL_EWDTH_32			1
+#define DDRCTL_EWDTH_64			0
+
+/* ECC status register definitions */
+#define ECC_STAT_UECNT_MASK		0xF0000
+#define ECC_STAT_UECNT_SHIFT		16
+#define ECC_STAT_CECNT_MASK		0xF00
+#define ECC_STAT_CECNT_SHIFT		8
+#define ECC_STAT_BITNUM_MASK		0x7F
+
+/* DDR QOS Interrupt register definitions */
+#define DDR_QOS_IRQ_STAT_OFST		0x20200
+#define DDR_QOSUE_MASK			0x4
+#define	DDR_QOSCE_MASK			0x2
+#define	ECC_CE_UE_INTR_MASK		0x6
+#define DDR_QOS_IRQ_EN_OFST		0x20208
+#define DDR_QOS_IRQ_DB_OFST		0x2020C
+
+/* ECC Corrected Error Register Mask and Shifts*/
+#define ECC_CEADDR0_RW_MASK		0x3FFFF
+#define ECC_CEADDR0_RNK_MASK		BIT(24)
+#define ECC_CEADDR1_BNKGRP_MASK		0x3000000
+#define ECC_CEADDR1_BNKNR_MASK		0x70000
+#define ECC_CEADDR1_BLKNR_MASK		0xFFF
+#define ECC_CEADDR1_BNKGRP_SHIFT	24
+#define ECC_CEADDR1_BNKNR_SHIFT		16
+
+/* ECC Poison register shifts */
+#define ECC_POISON0_RANK_SHIFT		24
+#define ECC_POISON0_RANK_MASK		BIT(24)
+#define ECC_POISON0_COLUMN_SHIFT	0
+#define ECC_POISON0_COLUMN_MASK		0xFFF
+#define ECC_POISON1_BG_SHIFT		28
+#define ECC_POISON1_BG_MASK		0x30000000
+#define ECC_POISON1_BANKNR_SHIFT	24
+#define ECC_POISON1_BANKNR_MASK		0x7000000
+#define ECC_POISON1_ROW_SHIFT		0
+#define ECC_POISON1_ROW_MASK		0x3FFFF
+
+/* DDR Memory type defines */
+#define MEM_TYPE_DDR3			0x1
+#define MEM_TYPE_LPDDR3			0x8
+#define MEM_TYPE_DDR2			0x4
+#define MEM_TYPE_DDR4			0x10
+#define MEM_TYPE_LPDDR4			0x20
+
+/* DDRC Software control register */
+#define DDRC_SWCTL			0x320
+
+/* DDRC ECC CE & UE poison mask */
+#define ECC_CEPOISON_MASK		0x3
+#define ECC_UEPOISON_MASK		0x1
+
+/* DDRC Device config masks */
+#define DDRC_MSTR_CFG_MASK		0xC0000000
+#define DDRC_MSTR_CFG_SHIFT		30
+#define DDRC_MSTR_CFG_X4_MASK		0x0
+#define DDRC_MSTR_CFG_X8_MASK		0x1
+#define DDRC_MSTR_CFG_X16_MASK		0x2
+#define DDRC_MSTR_CFG_X32_MASK		0x3
+
+#define DDR_MAX_ROW_SHIFT		18
+#define DDR_MAX_COL_SHIFT		14
+#define DDR_MAX_BANK_SHIFT		3
+#define DDR_MAX_BANKGRP_SHIFT		2
+
+#define ROW_MAX_VAL_MASK		0xF
+#define COL_MAX_VAL_MASK		0xF
+#define BANK_MAX_VAL_MASK		0x1F
+#define BANKGRP_MAX_VAL_MASK		0x1F
+#define RANK_MAX_VAL_MASK		0x1F
+
+#define ROW_B0_BASE			6
+#define ROW_B1_BASE			7
+#define ROW_B2_BASE			8
+#define ROW_B3_BASE			9
+#define ROW_B4_BASE			10
+#define ROW_B5_BASE			11
+#define ROW_B6_BASE			12
+#define ROW_B7_BASE			13
+#define ROW_B8_BASE			14
+#define ROW_B9_BASE			15
+#define ROW_B10_BASE			16
+#define ROW_B11_BASE			17
+#define ROW_B12_BASE			18
+#define ROW_B13_BASE			19
+#define ROW_B14_BASE			20
+#define ROW_B15_BASE			21
+#define ROW_B16_BASE			22
+#define ROW_B17_BASE			23
+
+#define COL_B2_BASE			2
+#define COL_B3_BASE			3
+#define COL_B4_BASE			4
+#define COL_B5_BASE			5
+#define COL_B6_BASE			6
+#define COL_B7_BASE			7
+#define COL_B8_BASE			8
+#define COL_B9_BASE			9
+#define COL_B10_BASE			10
+#define COL_B11_BASE			11
+#define COL_B12_BASE			12
+#define COL_B13_BASE			13
+
+#define BANK_B0_BASE			2
+#define BANK_B1_BASE			3
+#define BANK_B2_BASE			4
+
+#define BANKGRP_B0_BASE			2
+#define BANKGRP_B1_BASE			3
+
+#define RANK_B0_BASE			6
+
 /**
  * struct ecc_error_info - ECC error log information.
  * @row:	Row number.
-- 
2.1.1

