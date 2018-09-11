Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5108C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6492087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DzLj3v5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6492087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeILCjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:39:18 -0400
Received: from mail-sn1nam01on0079.outbound.protection.outlook.com ([104.47.32.79]:55456
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727973AbeILCjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVv4qcrrN7lt1FsWBtGDSkbQVQf9gJuYt7pWPt3lH5g=;
 b=DzLj3v5wsL+OB0v7V5ucoBLtFTBz1s9LPWYhdrprN7qPUF923Sgq2vjTqDqLliqT9kPcxTv4JrcOArw3h3OwGZ+8DVNQGy8d57GRtajgsx4A//V3ghkBn7HFrlhNgCXHJEpU4ID/GYCzNxdxKK9VgrufP/snFISjbXWVdYQtMuI=
Received: from SN4PR0201CA0008.namprd02.prod.outlook.com
 (2603:10b6:803:2b::18) by BL0PR02MB4756.namprd02.prod.outlook.com
 (2603:10b6:208:5d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.15; Tue, 11 Sep
 2018 21:35:19 +0000
Received: from SN1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by SN4PR0201CA0008.outlook.office365.com
 (2603:10b6:803:2b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.16 via Frontend
 Transport; Tue, 11 Sep 2018 21:35:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT061.mail.protection.outlook.com (10.152.72.196) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Tue, 11 Sep 2018 21:35:18 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fzqJa-0000Wp-GK; Tue, 11 Sep 2018 14:35:18 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fzqJV-00052s-CT; Tue, 11 Sep 2018 14:35:13 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8BLZ8TJ003955;
        Tue, 11 Sep 2018 14:35:08 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fzqJQ-00050U-Md; Tue, 11 Sep 2018 14:35:08 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v3 0/3] drivers: soc: xilinx: Add support for ZynqMP PM driver
Date:   Tue, 11 Sep 2018 14:34:54 -0700
Message-ID: <1536701697-23949-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(376002)(2980300002)(438002)(199004)(189003)(9786002)(186003)(26005)(77096007)(426003)(336012)(476003)(2616005)(966005)(106466001)(486006)(72206003)(6306002)(126002)(54906003)(47776003)(44832011)(110136005)(478600001)(2906002)(7416002)(36756003)(50466002)(48376002)(316002)(63266004)(81156014)(2201001)(6666003)(305945005)(39060400002)(81166006)(8936002)(51416003)(4326008)(356003)(107886003)(106002)(16586007)(8676002)(7696005)(50226002)(5660300001)(36386004)(921003)(107986001)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4756;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT061;1:AWrnL3coLNHJg0jxHrTquP7R2yGnaEO2hUeTlxnImgzEaOtg1kithrDq6jkmb5o3asmj1E1f6zqFLqmAozWamyxFsNHQacLGnEU4WwRgq+gTAtqBUkLUNdF2B6hq1CSo
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94752020-d5c9-45f1-4a9e-08d6182e78ca
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4756;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4756;3:lQB6ABoY1y0cV1yV0KKZV1cf4LRI3q3hXQdj2FVULeYuDQGENyVukawl+UPdOcUoqLscd19Cul3zCcgiwlfgyR7ygZJqMvvttcCirVqEg/Y5oeowCOVF2dJXpxHNpknEO1lDiKrj3W3DqOZY9IUxpxrDaKSUBEJdmutZjzluveLXpKsSSGzaiHMATpwJlL/dWBWCvUy1m6oMmFTFmeQAcTWNhaVnCVSd0jqEVPdgLpCBpF7Y7cRizei08UbpTqIzNdI1SUfF/nn4IZ7YytpXZw3ud8egi1mKqccSi8B7GuwcHas1RbnQ1iQVn0RQvwUyD0XT05mzBX4Ky6yVYkwDVqHbVezKat79pQA/P0+gM5Q=;25:NpuyuWvs6AQOorOHG04661TJS8ePKaag9TcLoywiGrTr1CI/whGjFcVKxEPAaMOKCv6ZM0IcZFQnMeVB5Vt7ysHU7LPX12XIZJo4hH2J+PEWQZ1y9NwaL4CmQsBdn3OV7tIXig4SLp1WubuwluqpZxQTfLXnKQ+WeUsw0YLvCnFXsba3pkxoM1xqFC8tacQj7XymK1XK4Q3vGrWviqIZmwrpiy/3UQ/IXlLVQf277gfPgtfmKDGVW0dzFDemXE9uiepWbq7o2j7s9Pg04dbS/CZUUwYF0gEbU00G2t3bPxGaIt5n/el+dQeBYBpxJ4trIGeV8NHJ4hbQMtvIT7P8ag==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4756:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4756;31:bZEcJYoh8yPiHiLdllWevXVHvTu8dxcdHZNXcA9qj0vzJ4c5LJfgefy8ytmzF08pDGZu9oUMHUdc5lCaZYnbh62qSf5RJMrfkCinXlovug8doOYmu8CPT0Oaz+U+XYs9YUH4jCdt5QO4AG9Jb3Q0/MAQ0RAzztmbmakP4Nf7mXNpBZPkMbps7o7NAta34/tE5vYq/85gH5Oc/u98t3q9E9Z3/8AHAgAECOzbX4s5HrA=;20:V4CasYVgIbKWkpXzOutvtRLXw2zEIj5AQEFm9S0D3zrb9TblxJiah1XSUplicRnSRNo7qsyZwyIXh3yUrCRPOg2bJxhhsaMcJO5H9sxCAhGaco1691wQQ8UXlV+DAIM0Nk+ClYuBsDntzydhvcItfk035ednn2Rc+6s83ATEDKx6kbKoItR5TH2gwcxlUglQbV9RYv5LfpAy/j1MDFwpQ/LzHq67U94TvpdtjPVy0JTZcTcYmoL5bRSMqvJAmVMUQPFSfERzU/e5dDZfgtC8qJnC6+Ube5Dlt5qdYyGcVyQGUNNQSyb05SWs+KsRWoIdju0nkGn1G/5huTvilXiwH8xCV2UIjFqMoFtH+PwmY11S8Gpg2UCel1f+D109JGgEuBvGnjYQaBsT+Ao6jEECV/KuGlWFA2KwCCoX8ndWWxNHAlQonI1M6rvRhwiD7+LVn6eaLiGp6AcVar4+/1ArcSiww4e+m+QKGl5O3dFUbUEDL/NfusY5Vud9pOTh35Z0
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB475691CF189C3970B8819442B8040@BL0PR02MB4756.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699050);SRVR:BL0PR02MB4756;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4756;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4756;4:ot53J+2AzAO5/2/t2dDDhhELB28VSc5N19w8BXR7b4m7Iz1nuCV8uDYzapRPWtpz5lkkbBW528SI1FsSM+REsyFStEOyTms75IuQMbXBub7KV0mwYBlxOF9YtPs4HzRjJZDeXvRRAlcFCGcHpfsV/PGM75S1OeqnFchX30nqBogJhU6eBs7X/edwJTgw1OwLHJSaaaAYT20jlX2Z+Pyy7SiHE5SJ4vUrFy7xbW+88jzAd0rcHI5mt+4uYFXocS1HM0ge9tCEBuWD75NJq5H+jA==
X-Forefront-PRVS: 0792DBEAD0
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4756;23:rZM6K/eSBTykMECEXNGUS3+TmS8hYa4kSoIn9WbHu?=
 =?us-ascii?Q?F9ypJ2Xt9g6Q9lqYjnyLK/TCD1vKNgYarzGa3AGuP1UT9BOgVFcPRCTybIuS?=
 =?us-ascii?Q?sLPcc1x2YiU97OyQaVclohwI8K0WmRu3Wp3LNF6ppda7JTU6YgJzcIEmcI9s?=
 =?us-ascii?Q?MM2n4pFMlJCHWZd+wWTkkWnzHp85Y95kppe8340yxF6EOkXus2mN+eCj1n9T?=
 =?us-ascii?Q?0TIv2s8WxMoiCSKoPygNbNNtKHo024KmhLBomUc3PKieOID66L1XwDGOUepW?=
 =?us-ascii?Q?DCw9hlQUqISMQnWcYzVWWe6DSJ+YYU+Tp8afi1OepzeXAEy1q4/6Bd4BxWZO?=
 =?us-ascii?Q?uDMapdm6PfVrR1DhuDTCo3nDpEQ3D1Twipl1v8XRCQEiMDTTIXN2kj2hmMc0?=
 =?us-ascii?Q?7qGeEufe3tWUZvZJB2toBWXIxghog1K6RV4Efa3C9BY4R5s1P0QXRJnbtGlk?=
 =?us-ascii?Q?7BKDCfc7gaFfSvLWgw+qVNz9blS/Wk2eYo/CU7LOnGVnNPHPZSQMBOX8lfMt?=
 =?us-ascii?Q?lYvFYRpEq9GGOcWlohYUHJh/oRJ21TQ1Wagd4gNSSoNssDni8waW0zwhDQb9?=
 =?us-ascii?Q?51X6oHqB2A4XAx6naef6REGqUpXc4rdn0w/A0WAUMNe9J8YNsa+jdxS4K2rH?=
 =?us-ascii?Q?ZSTBM1SCGxKGZiqw0AB93GaVwkhggVtykzCStTLKmJMUkHHYYsOtMVHb4B1D?=
 =?us-ascii?Q?6siuVukSk6DYHNX1ChEWQnor/ibr8U9VcTCYH3UDDDlXj62Uj9WH2TOegmNF?=
 =?us-ascii?Q?v97rDx/VdSy2R5OCx6BV1ym9upqJYXXSOFTedyOviBrf2K2gFTlcuakcqCIg?=
 =?us-ascii?Q?FUjqUOiFceoJGsVlrrO1UAjjOMWM4aSlmvijTHyFhWBqpBVMzWiTZCDn7doG?=
 =?us-ascii?Q?ry87bqdJV1WQqS+JyUaNiIKoQdKPomQ30fMaZUTL4DvgZuTj05t7ODIv8LOL?=
 =?us-ascii?Q?d6JCxKphyVMdpXw7cAeuryURPEx3iuSbvuMb0MmTlEAO/lzXgcqim4+3t89E?=
 =?us-ascii?Q?UXJmxTAIRyhukazAxHtcwR0ToE/i/iLsCfDbBPWBJZds69TzpZTmf2xyJscc?=
 =?us-ascii?Q?CM0FkB92FGMsShHWYKfgVhoCDsbEZqVqEFHOofRET2/OwgHMlWEYecQzRdQt?=
 =?us-ascii?Q?5WZMqLum3Ei0UFbvHb4pJrb8uAsDBP3hxYBidSXRCH8cQmkZaHiKatU+dS5E?=
 =?us-ascii?Q?L9r4HrxPzmfycE1UYBgC+mxyBnHA7oWBy9szSMOJ+Gpdk8OChmDd+xkd3TjZ?=
 =?us-ascii?Q?vohRR0SyAIHP275BNX5wzS4hIIiekCcFwjyTckk?=
X-Microsoft-Antispam-Message-Info: sNIDotbP7aBDiq2Shzj37Yt9wovLKqV7IellYELeOosciuOy7Y9V3KiRs8Kx5oShgn0X993CjNRpj3d5m2eoboSN5nEKj/s/p7OSlMmLGLjGHitnOlqzRkLCx997XBBp1og85D/+3aXYU0iuP7hlLBoKvJbTb8TWG5lnzcCstROje9bdGfvRPDvGFN62bF4Z3yFSzJepxpJGrkvFUN6MPae/MBrzwB7wcvpTFbntmpdmPws+GTh9FXfHnDek5kSPPy3rquJkYJhA/p9xrab3i1miIWllESqygwiDiYJud4hekYpIj6QuMEFLx6/fICN53lYob0DtNwNGfnWe2xtdL35/C7/oqC7jfMntCEnjb1k=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4756;6:VhKmbq+zAEfhsuENyyWcdp5Wl7Erieht2PgcQeADhfP7jG66c4u/JNSE7rKleGFu35b2Yi7DKe1PkJxiA4MYDCCH/sXARVyGmVVY3BbH7rvW8eqxoLjV9dsIqhBdbEDVXQiSqk5Kn1/0s8Ef7n3WmHBrrIruGPP9xhEy4vlZnYVb4nb79xoCkGWW4Dm+kAbLE3WlFE7PDdOwSTWlO8BGGZV9p8O9rPJoUOUsGG7lBEzr1cb7Np4Uv6L6g/Lt+XcHMq4hF1+NxAvO2B+6uJW8iPikLjNbxCcu/BnpcNmUNO+/+HlXpKvcw4EFvaIRKba5idtPzjVco5/sjEh1DMZL1kla4VSORwmgjb61cyh0PEJjWiBw+W6NdvoBUjgju7eqFj1OUp5iaWQsJ10HXIOfrVh8t6JugkSudh5osU7AZ/2mI9juFmLJ8p/qEkpYN7lx1C7nzYlScPcET7TM0BIjgw==;5:BW7mrEh1KwpCsnuLt7OB78bY37PRy3OIdeDRqUzgS8ucKt7hVJwbeo/IepS+WYSgdaqQZdcN9hChmTdcMf/ag4WZC+0VxZlnbzVVTDpFCeMGJxT1R7VigEbPNwhshUv2y/tRElCFAjOwoNBau88aTQ03wN4k8RKdZ7YgKNZGuq4=;7:qzoyDJ5f6Xe3DeJJo+IZcDWGBRFEafz7ZNYWNLPdcvcX/cIp0Xe0LDgrmEn8UYIdmbybVQXIuuse5zb7JIHg5932Qme5dDU9DdO5KgqSbHZzhjNQP2zLs5N8iHFLiBXIWFyNVBMcdfUtHrF/5rjYtUqHCbTEhv6Sw20XHaoWfKKZqcMcavLMS3vcVn7h3uEdHqvIr0en7BwaRrm/cKJMZMH7KwKiKcyLeaQ0PsZapc7dEd4FW9b5tg3vEJ15qY1y
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2018 21:35:18.8745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94752020-d5c9-45f1-4a9e-08d6182e78ca
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ZynqMP PM driver. PM driver provides power management
support for ZynqMP.

This patch series is based on top of Xilinx firmware patch set:
https://patchwork.kernel.org/cover/10555405/

v3:
 - Updated DT bindings as per v2 review comments
v2:
 - Rebased on top of latest firmware driver patch series
 - Updated driver to use shared interrupt instead of mailbox
 
 
Rajan Vaja (3):
  dt-bindings: soc: Add ZynqMP PM bindings
  firmware: xilinx: Implement ZynqMP power management APIs
  drivers: soc: xilinx: Add ZynqMP PM driver

 .../bindings/power/reset/xlnx,zynqmp-power.txt     |  22 ++
 drivers/firmware/xilinx/zynqmp.c                   |  29 +++
 drivers/soc/xilinx/Kconfig                         |  11 +
 drivers/soc/xilinx/Makefile                        |   1 +
 drivers/soc/xilinx/zynqmp_power.c                  | 230 +++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               |  20 ++
 6 files changed, 313 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
 create mode 100644 drivers/soc/xilinx/zynqmp_power.c

-- 
2.7.4

