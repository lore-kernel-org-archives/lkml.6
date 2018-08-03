Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CC4C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C794A2177F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="em8vzxLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C794A2177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731925AbeHCTvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:51:37 -0400
Received: from mail-eopbgr720058.outbound.protection.outlook.com ([40.107.72.58]:55104
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729987AbeHCTvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeHcqfhBmNmq3+qiRcWBF2dzjyZqhOAmxkz2chz3+sg=;
 b=em8vzxLpipjwDvV7ib9NoNojbhR+Y10UI/FtxNc/yXmmBHmcZUeAHgcQfqk1K4b7nuqdrTHD2lqq3w3ijlTqQALO6flKDnss8DqCVtja9OXb+PZ3RVsg8ovHgHphO/H0Uz6NqSl545Li5z+4ewrUDkdPmpPzxiCZX/8BXx8EL3Q=
Received: from MWHPR02CA0051.namprd02.prod.outlook.com (2603:10b6:301:60::40)
 by CY4PR0201MB3506.namprd02.prod.outlook.com (2603:10b6:910:95::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Fri, 3 Aug
 2018 17:53:54 +0000
Received: from CY1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by MWHPR02CA0051.outlook.office365.com
 (2603:10b6:301:60::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Fri, 3 Aug 2018 17:53:54 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT035.mail.protection.outlook.com (10.152.75.186) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Fri, 3 Aug 2018 17:53:53 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fleGu-0004fk-MD; Fri, 03 Aug 2018 10:53:52 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fleGp-0007cn-IW; Fri, 03 Aug 2018 10:53:47 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fleGl-0007bh-Bn; Fri, 03 Aug 2018 10:53:43 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v11 04/11] firmware: xilinx: Add query data API
Date:   Fri, 3 Aug 2018 10:53:21 -0700
Message-ID: <1533318808-10781-5-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(376002)(396003)(2980300002)(438002)(199004)(189003)(316002)(106466001)(63266004)(14444005)(106002)(54906003)(110136005)(186003)(48376002)(336012)(16586007)(50466002)(47776003)(107886003)(39060400002)(5660300001)(4326008)(76176011)(7416002)(6666003)(7696005)(51416003)(77096007)(26005)(2906002)(476003)(2616005)(356003)(126002)(305945005)(2201001)(446003)(81156014)(81166006)(11346002)(36386004)(8676002)(8936002)(50226002)(426003)(36756003)(486006)(72206003)(9786002)(478600001)(44832011)(107986001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0201MB3506;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT035;1:rHO0CWpu3BkBhjLm5sQEzS8kU4B8BzsZSNTyXn8pPVQZy6q6XTizv8x/hh1yu5wry1vGa936pLJ4AebHHKuktr1GwZURZV5Gtoa9EDRW2u6oEJPuparxwgagFnTk3e5k
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f96ba5b8-4c9b-40ac-b48f-08d5f96a140c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:CY4PR0201MB3506;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3506;3:icf20laLQcgZdqpqBhpbCkReu96OBDGu9KoOR5B3zstZU8lV4txOHYfzZJqka2HbTy3BO7I9Ls1KThGolH4ufqGhaV3UBXRt+nUGUs23bh2S16Osm3yr9IYeIBuEBHW5PiKhoGtHc6jV1J92b4wm3/pGSjPMkgv7C+M6qczYjpqkQ1ErM62iBAYaxG6kWM7zxqxHrByqIEGB42QEh/UUdVvNcEjGqAXyvafTXvUmjpxM82pq8mlBqS+ltvFaE516eVzL2y5PL2GP52FqaGPe0pQ2dXrG/REg8OxbiJ9InA03FatDQZFGyo0G6yA4DDWLTCHAKB6OlZF7kL0k/rOR7OU33SQu9COiqEBXvEl0g3M=;25:snIbKqkfJkhDyWf51lqz+kqNXcYoHqXKskJruUr1unSfP+rieYPSEwzJg+riTjFqnkHTVzJMDQWW9pOwzJvo1RTqWGHuqhs9+IcgPqhOsvg2xhAJOXd6o1XS6LuulnOMKCD0ECcrH7NGtWPBS8FWqfS6iv1nBaXre8fZAFipTsoDSeS4esL176RqefKrPnsOBDhCpbIvBXcXN4Gx4zkqEnPmkSOvbT1eoPBzaUQAacyV2y4Hh/q55AEY8hvvU6L9fKNaebKIqrG45QchzlAsXj+NZlDSDyCccnoXeVQMDUg10NC0O3M9cgUsRnL9hKMiG4sQWwfGDEobVo0NaXVmUw==
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3506:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3506;31:84G5vx0+8ZAwby6IT9aNY8bGeCPuqtIE9Sx0ijSdqocBlbz2VYUIhBP/3IpX1RKMmfGZCGJEdHiSl8ft+q4gODlCVLtU14S3oacBfsotRdhaMBYmmmO/fsU+PTW4Sfpi8RcVAuEHZXqALm9q3LS5noD8ttxBQOkDwoebSZGTl1yVyKc6rGbzGcXvrQKz7d/QQj5pwq6cZNkSlEvCjBMRCkw4qOYtzAah4V1DLLVrhrk=;20:uHnibOv0p9c2GZhcNLdfOwE1EoMsGRtmkKhH0Qqqu5VgIEwx6iceOrpN/WFsJ7SCRDBu6pFY/dId99kb5Q5m7hTkW2ScXBwoOhxDAXDGSZ2ryp2DaiXJ6EJzGDrRgArfdy/Shbb+3BEmchdLVPGzfxoWQZr8VWdGIrrDuXzho/PNsQiWJywexO6Pm5i6H9OFB8tybqgpJcdUV8mSekXeX4MhQLgQ/wEyUeahhLMeIV33UzCkJG8dZ499/Q2/0WsaB1cQxy7w91DdbYqfjKEqD67yhrz6xjnRb2QAJTCXBVI3Q4X6ajQ8ryEPlSt6F/LoenF2IJVOuLTX+aDhkFEg2uToVnt2uLwF+AqA2s3Xkog+cg4BflpcnBfYVJiH0ey04nKKbZXUFjCDsmF6nV7SjriAcqmmiOxOrswQ5HFftKiYLmVJE/mAmkDWUhcBaGpD1/Iw8KwmoDnzZy1dHKZ0Dw2z29IQZja6uEqFZiVjeLxJ6m5HrYLjJ0GYWI+mTz+p
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR0201MB350627A1558BE520E20DC02BB8230@CY4PR0201MB3506.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY4PR0201MB3506;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0201MB3506;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3506;4:f8yeNLyGBcVliADEJi6+6wv81pg1iumiVJILRGKC3y6qFaPNJLAww3Tj3K9JIR+yiMlIHFyv+0RCz9Ub9GyQZj6WkcJUYB+WjkYga9V2Z+twlECgaB3RBNoz/wppsudzTd9RYEuaf1KmEFYKQhzSWnaQXx5L+9lUi76OogHHJX+ZXLR/RL5T89h4P76C4BGGiFhzR4vU9dl/Ey2fU7VRnXrfKwS0LSgnKq7Sy7CdPt51IObIciOBWLFINbanIrN9fBcBMTArdZSuGkv1lR+mDucR1/fzj/vrFzTxihSKX6iCbT1fchDFfhj72uKSq8Ff
X-Forefront-PRVS: 0753EA505A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR0201MB3506;23:hhCwJI0woEpyaZpm9g72KxA7XZ8ta8no71Dnhjs?=
 =?us-ascii?Q?Knczn3Rx9AGJ2FDCKhvKDXACej/b/eW/POMMmL+/3vuKbv3NlbLhac2kdzcN?=
 =?us-ascii?Q?ZC0xLQGfF5+DhQA7qxJvKqUq0lDWiiPLrrxwmn0AfJOniBhJXij38ezoAQop?=
 =?us-ascii?Q?ZPZoKRvTudGmmCDQKN8oulKLb+/iVxyj5a+KH5PGYGyAc7i1+YlYJ6LVfwgY?=
 =?us-ascii?Q?u/FaqBLAqfuT2Th7oTA+ENbpzQKkQX6NObmKb+nHjeo0LdHCcNMI+fxJvZNL?=
 =?us-ascii?Q?q3TTSPe5rgJagYbUkr8heoTd4fc1aXWhmtzf18xbz+tlMArrVT1598CDagk/?=
 =?us-ascii?Q?FeZOCDsCHoqkqOa/4FBNkgeGOnMhKO5QHD3t1B1b+9ZggPwuSdGKGsOegJPn?=
 =?us-ascii?Q?dqqu4EbkqlzFBQELkKh2kCvVFPMkflKZLLyO1VbfaL45eERsGN+fbbI1k680?=
 =?us-ascii?Q?5k2S3p8C4NvKw2pbqtM/aViP6TD+it3NayCky/lM454XyIhY0sK33ghyPuZO?=
 =?us-ascii?Q?th18NrX4y/wzMGc8SVakrsOqBaake4xBT+X6fXqvN6W4jklq2IHRNrrh/Ug9?=
 =?us-ascii?Q?fkJMLefOQoLv+vhkKTrtM2QtGLDjW92lESJO2cCtHsY8sA19VcZBNCZMFCKs?=
 =?us-ascii?Q?QUUFW3ycYmxDnRzbIQ383doIfV4ceFvVcIhcQOEnM7zOtACXmpSnPbZcW4Ed?=
 =?us-ascii?Q?2VAoB4bGSpnI+qLX0OUGn1lN0QP11IbBHcMsfQftsS1wwlvsI14MfO14PcmQ?=
 =?us-ascii?Q?1r/D+S8isVyLXeupAr7QU5xXY+Dzc2ItU+nomqc/74nnJrkxwUGBeXgTD3xT?=
 =?us-ascii?Q?nbnBYjoXaGubdkz9gjusuBni3/zrOHkvx320jotXvlxnX7WRqLyYcOGBHz9r?=
 =?us-ascii?Q?UTteZCNHNOcbQM3AiD6v6FOaGmxrPqXaXYBHcBIppFsENetIPiJR5a0YMNGK?=
 =?us-ascii?Q?keWG/FpToJzfiXv9eTcxTu6iDZ3+OqO5eC4bFFEPj5kBmwKnp/JUqprqdCsz?=
 =?us-ascii?Q?EZplsUC75hs60pKb+GAu5CKudf+u/xsDp37fhvpQBQXXKfY6w5VHIhREqkrO?=
 =?us-ascii?Q?YZ9yRaQSZmuu1eWMGRgWD7yrFFBGoHtivisN4gBnBxqCpb8ZNVJsnYd6BHWi?=
 =?us-ascii?Q?jev59RQgo8R4XOj6Fk6AL9suRUOstiJ3N39VPHl+Yt2zqJXq/UBtPWCsIyzn?=
 =?us-ascii?Q?qeqjtW8I00J6CDkP1lqJsxhGewtgBHWRNCQWKV2C4q30CiEC6xYjSC2xUh8k?=
 =?us-ascii?Q?Uz1bUEKi8f8SrymbEDowsKd91d1K69eacrQy+Qq2a?=
X-Microsoft-Antispam-Message-Info: dyDEXUIAidTbffqF+B2NRr1YzNW0ZHFu9vOnAYHlOhPMuruEK5Witc2qqTGPmU0NWw8RmvHX+TXsO+OxXTloW3qbL9Uu6gB7AgbPYuTrmW4Hv1RWaLJ2mw67NJqs+tYSty/heVylDVRAi9/cFtjsM1fyZzagkfAc0G5dhUP/o+XHlSMbiRZwsXrknNM8+E/i3VC/ZuCtHTk+/AJ6Ri/oIEca9a+c+tiuXbzOM0QcNLNkgIxjE6/VMJ4IuwF7HeoGxRQUT0pYBgG+V42hxL8KbROgn596OGnUUlXEa3nBOVyluENccKtHTiq9GCEKSycC4LAE8gUsvlhW0WQAz+vle/9o0ASpB6m0wCKEHFtGTjc=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3506;6:1VVkvCNT+b3g6vM3dm0htFRYcoKtBvvfYFnzOnhOhjPlAWtli0yFh5Gm878wViRY0RRnQJU8A2Sw4Xf8vLBOYJuzeQwxVgKzZ6RXKCOTP+vbUhPldnU+0wU6dv6RsdQaaITgPQFPnO9EuefOznd214T1m+4tIasVx3rNAubcAwr1LoYNwdu/8EkL9t7GvoVl6RtgrS0nSWTFfTTZicfeH4BJdHnbUTQBFyhC0aftzqn2Kor9bFPwHS4SCRD1tq6e37sKhmTX2xPUFBESHShvXhU/4o0ki/5+BNWldCkVEdBjqawKGCgA2PI64MJu/aig5P86rZV+KmCKJ+jxZLpHKXkqP51vLsqtdheMAlag4BJJSn8ojYt8NruvMeL27ipYenhBw3kCca/hMmfOosQiwsxlZmqellR4acW1MmSBj4tm/xzXJEkeoKyjXotL0e1wyhN18SkWLOjKK8Jt6l4vQg==;5:PZ908xNnr7uVYTc6nj6XU//v9+/Hr8e2pAI7LwX/9QaSdBkiPtT2bFlO5zZ0yTEtKUkPvklTGJbumeKxB3o8G/MDxZqLJ65Jhgv4+S6i44ujuX/n05SbuId07mxnjach4DhPPsNmh4FVTCalGm4HCDUScP/Tu1uRVVmqxkHaQFU=;7:/JWOKkUw8yvyz5ko4LBiuPNs0mZnQok8sHrZkTHBAHaZGSwLyO2mcu6qWnWT1+PcRv1xhppiLQfQm8h9khykQ6e7CJ678AFAvSGsBEUAarGnULzr2JCOps2lyNlPvLRvA/t1n9AH65U57bQrBB0FG/DXAV5aAOJswB6kDQ2UmckL9/+gULpDmArQ0hrrJDO0+fEMuARcg3IDmt33wALvjHRt2vnYuNUqcLXGj2HcHdonQIC+WYVrKzMPoY7EIEce
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 17:53:53.1800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f96ba5b8-4c9b-40ac-b48f-08d5f96a140c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3506
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add ZynqMP firmware query data API to query platform
specific information(clocks, pins) from firmware.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 14 ++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 20 ++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 24cfd9e..8ec5682 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -260,9 +260,23 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
 				   arg1, arg2, out);
 }
 
+/**
+ * zynqmp_pm_query_data() - Get query data from firmware
+ * @qdata:	Variable to the zynqmp_pm_query_data structure
+ * @out:	Returned output value
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
+				   qdata.arg2, qdata.arg3, out);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.ioctl = zynqmp_pm_ioctl,
+	.query_data = zynqmp_pm_query_data,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 2eec6e7..55ed2ba 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -35,6 +35,7 @@
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_IOCTL = 34,
+	PM_QUERY_DATA,
 };
 
 /* PMU-FW return status codes */
@@ -48,9 +49,28 @@ enum pm_ret_status {
 	XST_PM_ABORT_SUSPEND,
 };
 
+enum pm_query_id {
+	PM_QID_INVALID,
+};
+
+/**
+ * struct zynqmp_pm_query_data - PM query data
+ * @qid:	query ID
+ * @arg1:	Argument 1 of query data
+ * @arg2:	Argument 2 of query data
+ * @arg3:	Argument 3 of query data
+ */
+struct zynqmp_pm_query_data {
+	u32 qid;
+	u32 arg1;
+	u32 arg2;
+	u32 arg3;
+};
+
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
 	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
+	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4

