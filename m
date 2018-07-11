Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD5AC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3416C20854
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="mPvrzd0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3416C20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbeGKHmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:42:38 -0400
Received: from mail-eopbgr690066.outbound.protection.outlook.com ([40.107.69.66]:44352
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725808AbeGKHmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmgX9qnHU/CdarIfQtmal25sLLVXa+sAfouX5ZWqY/s=;
 b=mPvrzd0JNkgvcvzKKwkjMmj7XbbJ3I4/BeAX1oPl7eeG6WPvXTtFLvAxmUrwIUTl67CAje9Dz7aXPLR/QYYo1cPVk4rlfoYe43TOwapxUtBtgthulIQ2riU63AHCZ0E2k5+0mRwLXRueiSlKffVp59qAc+NqzvA6/dwwSo48tqs=
Received: from SN4PR0201CA0044.namprd02.prod.outlook.com
 (2603:10b6:803:2e::30) by DM6PR02MB4457.namprd02.prod.outlook.com
 (2603:10b6:5:29::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.17; Wed, 11 Jul
 2018 07:37:32 +0000
Received: from CY1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by SN4PR0201CA0044.outlook.office365.com
 (2603:10b6:803:2e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.17 via Frontend
 Transport; Wed, 11 Jul 2018 07:37:32 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT043.mail.protection.outlook.com (10.152.74.182) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.930.16
 via Frontend Transport; Wed, 11 Jul 2018 07:37:30 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:56071 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fd9go-0000fv-BK; Wed, 11 Jul 2018 00:37:30 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fd9gj-0003Za-7L; Wed, 11 Jul 2018 00:37:25 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6B7bJUV027525;
        Wed, 11 Jul 2018 00:37:19 -0700
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fd9gc-0003UL-FA; Wed, 11 Jul 2018 00:37:18 -0700
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <boris.brezillon@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <f.fainelli@gmail.com>,
        <mmayer@broadcom.com>, <rogerq@ti.com>, <ladis@linux-mips.org>,
        <ada@thorsis.co>, <honghui.zhang@mediatek.com>,
        <miquel.raynal@bootlin.com>, <linus.walleij@linaro.org>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasureshkumarrelli@gmail.com>, <michals@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH v11 2/3] memory: pl353: Add driver for arm pl353 static memory controller
Date:   Wed, 11 Jul 2018 13:06:51 +0530
Message-ID: <1531294612-29526-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531294612-29526-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1531294612-29526-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(2980300002)(438002)(199004)(189003)(106002)(107886003)(14444005)(2201001)(50226002)(426003)(486006)(126002)(476003)(4326008)(356003)(51416003)(316002)(7696005)(16586007)(36386004)(110136005)(54906003)(39060400002)(575784001)(8676002)(8936002)(76176011)(9786002)(81166006)(81156014)(305945005)(5660300001)(446003)(6666003)(11346002)(63266004)(47776003)(478600001)(7416002)(2616005)(106466001)(36756003)(336012)(186003)(50466002)(2906002)(48376002)(77096007)(26005)(921003)(107986001)(5001870100001)(217873001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4457;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT043;1:9cXesgDgH9MVguBWVO7H2iDxo47FgCDdYtDSM/MEKP7XgzX+IiBlQ0Oo8EtZtEAx9jJAy+JlLqwV5DU2x+L7gp8yirAJ9cVeYxs2TNAdWfJ0a/wMmd86YvGwp7jlQCSF
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 230d68d7-5177-49b9-0481-08d5e7012972
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM6PR02MB4457;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;3:9i/f9J6sAxR5lIFAtFP5WwENoMypa3W1Z846oWM2Emti9GQaW6PyqxA/CojxYqLXjs+74tRpk31NtViosfefPR0KnrHh+e6jZau1+WDeqRNgNc6dSHypbJ09nDBtqGaeFWR4UrnfC1wrdCmNR3e2FyVeXp8EwxrKfa9fKfth5ROxlozUOgmSVyCRh5+rHks/MQhzI0qjObXDVorMCCXG4VKFPxYuN1hPTfpPQltoJQ00nT8USWrUEhlMo1hMF2O6oU9sG6otzQ/zVzdlC/PObe0jLzAA5B7MG9MaNEaBTZoq7Rcys6Qfp2p8tSKwEJAXn6vNIQ4K1fDmcarz1LX+7vr0On3hahc5uZ3t7ygxU5w=;25:0Ph59uNwNRBlIirubM+zKK9rNB+bQj8ZJF2npxelSlRKvC5dE4xZfHTeGTkO/OFhnO0wi8Fr+1P+7g7MZHMND+Jct+tAI2phWdTcI2wMtaduSTztsA9hQK8TruSiFjaxb5tULeXVl8ndm3Kk5u3rFb68miR15yAp/1TyRoTmA4nd/ZP46pbm6rlsKUsZTDUAe/fQt+7M7AxMfMud+Uuo/QUIm2rp61ntW3YVH7QJKjEnN94B+B+poJf6n7L+ZnaArskHTsTHmOMnC73Uv5kI/FU1DLhtFbLm1jVEljijkh6ap3OGvVK1NkiheXsvO+NoSd89sqGyuFpyMEtIzkmvYA==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4457:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;31:s/A5Zt/JZiEjSTtJ9H9zEx9j5nJxTADjn7fYAfM1dWUJDGhq4L7yxm5W/tqvTbftFqICUM6g8w77gIaO68mNIcTkcyrtAlvpSHbhH8AAVVzpJwfAzTRiDdEjqwqFFiQgepcZ+OdSfnicfFu3ypvT3TGVH5157ySyMP2w40pHp/RvqQlgKPn2lfte7LEqMVaNQ1hmJrRRrbGzg0mKuVwqXNnVI8u7QSZrN/1/ACA4M+I=;20:hAyTuMU0lB7WoNXDuMUsUrW2u9UggW0II5WOJt9xue6NWvUGMxY+BU7YeVEOaztf5bqBuoGQvXqIOJzPIhZ90O6idaroq+sMSTqsrWuJN3Xw2BzWJYsZCMHbbZUkWihC9hQWvDco33qhQCbbCjV7sNbyP1/76rmK0cRSZUDmC2gkVKy6D2cCiRF9sRptuhBH3c8TzL1zXh/9gagZwOQL5p5v+wF2yaWr0l02wnYBTVBawpvI1MLIGQLjuGNX/WAtoNhpUD2JpmMcmtZp1vHsoq+5n6hYngIcFQYkCWLUMBXfl4VReVUuRHPabktymbrsWM/RdHeFvmmBvxibbOQKKJtNi0wxnusOVeHDKf1nxVTnC5jq9kBIjEMqDAOcT9SZr8D1v8Qqf7Z6BkAh5p9zrs9S7eLM7bwhoIq85dpKGYJr88JmBETe0NcJy+5T0uFJZjbj6aph7y1YOqPu+Ghv1f5kjrOlPFTWck5vmEXFSB9P8sWrJ5zAuW6EwQPAYSxj
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4457E59CA8B35C9DD25717F6AF5A0@DM6PR02MB4457.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4457;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4457;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;4:6KfmZt0iKFZS8xk5DIZekXgkKwtxl8NWouLAZKmbRRrodclXF68rJsX68EkjrGrkp5gM6ijq2qKCszpjwtgIq4tjvimoN41L3Pu5hofWbiYSzCWMJVc0ea9PBqx6MyrcWgjFT+1xih1g6/s0WqQb8pCJ2EgR/2JJCQirAxLo0/TipJrCZAcjfttxUzHEoJpcT7cMkyFVOrQVZerFRpnJBbh0UyFyyZ+UbodamW+O3JbzUZeJbUTgomgUf39xCqrhKyxaf+YkzfZeYEgKMJZDk5LN5qg/AnAQeyqY9kG8rhP7Hf6Pdri+aqFXzc4RNINP
X-Forefront-PRVS: 0730093765
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4457;23:8Ka9o0HAaQcnBFxC9JXQWFlhK6m8o/wJaug6qWZm/?=
 =?us-ascii?Q?bVtfvzaQF4YwIZ8HuCRIs3AtMU8dPwakIltMDoXi5hzdgUUoNrImv92DtdXX?=
 =?us-ascii?Q?m4Gx6RsDw2SYdlRjrgKUfNdtm43Jki3RvvCVittNmPWDEKxzp2hGumGsclVp?=
 =?us-ascii?Q?s1aASu3WVlFIZCiNCEwQGRKFfR4L1hoLEfjkakS+kJNowQz5FrFAVZnXLZmo?=
 =?us-ascii?Q?xmcAB8DNkxBfyt2v9Sc0YoPYhCODwsWF31OtcEyiCWvXXY5GQEOTv00TMg1m?=
 =?us-ascii?Q?anBFBVunHSghYbpj+SOXLsTxrQF4UoRpsnnNceFZpdJxf7YK7u6hLDLL60R6?=
 =?us-ascii?Q?CpVGfo//tVCWLMgXPLXOogXtyq6D3kjbHX86t2QZgpX3up/j5f9pB1tbfloV?=
 =?us-ascii?Q?k711969EIn/P3Q6DNt3QLj5vn6MT8pejTc71crVuw5pLxLKemx/EIGiEPnca?=
 =?us-ascii?Q?2BQvvWkP3yE5rKz4zKf0phpk41GFEaS8Szo0HLsYJv0xajh4QN95sh4TBCOm?=
 =?us-ascii?Q?TBejkQymhfrxHjxHcFOeETOfC62q8MgYSNx9Z4fEhFs9re4wnMv3qJ31C695?=
 =?us-ascii?Q?xUOgCXwKjDdZRMMvncgNxaHEU+P+p80ELT0qqhE6nJiZINzThyUstOlBOZVa?=
 =?us-ascii?Q?NYTFo8ufcvO2/NFhpUi8ECORzGSm0yAer+F8YXnG19eSVjROSjxltk45idIn?=
 =?us-ascii?Q?YD5YQhpwGQWAQBojX+M/FY8Tec9rH7EtqFduSF3f2QHw8wVMrQPGQ7XAsFAS?=
 =?us-ascii?Q?maIQN8N4lIZDZMBmj/rXXfgu0Asj4VcjoLmPShLVmoEhMnZUK7EfyBKmrCci?=
 =?us-ascii?Q?Ys4214O0MI3/g4PPLGEWCl2Ugsa5bxHEu7sZ3m1ULtyytGmdhUfP9tztNKAI?=
 =?us-ascii?Q?p5Yy4XDqWl1x/vYqlcW5wucupH8CYhxi4kaTasSw327EEHLlTsPw1hqwMGZw?=
 =?us-ascii?Q?8nPqtnIw8M35UEjbfM8zDoRApLw8DzhLhCwdJE0O8otCTQdLUO+T5ekGl/Mb?=
 =?us-ascii?Q?nYOA00KlRpQx4jr/iqJoGPcfQIzRzy9cBeDWE6vNAVLdFWJLJRPZ8Ygby8A7?=
 =?us-ascii?Q?j/cZlCpde+JO10L5JMEsACKfJyw41x5Dr2EuT6mT6sYm3QkkT5kRvSST+p4F?=
 =?us-ascii?Q?yqtGfwCRU0MJd8iUMW+tcZrYyWdjQeCV82AIT3rkf75zxTMClZ2KxCeWYvdS?=
 =?us-ascii?Q?6/jqx2wmy82kZ+0Tq7hmKArDJeZ9PIZsHP3uki1GaNkl9t+9mdYQLZruTtVH?=
 =?us-ascii?Q?bTCQ5Tkyb6WybKthEEZORZGm8DCBQ2j8+ky0tZyfWOZNM+qYABZzs4ewEegG?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: 0/EMd2fEe2pVk4QXsLMz/r4zISnbdgKEpRMYnGRfx/bIHKUcyiGtC48cP9jG7EFFvH2RcYyP2SKWyl5PRM8eyPhSxFTNVQwKRtL+R03jcv40qrfabS5IfAZIVZi+VEQAKslCKDbp6ltP3t3hGkFtlA5RLoVMoaxca3XyAS1c1gtMxgzPsLajbONalxebNFrYD2VJbHFJ89VW/8gT4s5DRWVZfuNe/EViCujFyf5WDrniyI8x1QU+r0fEB3YYYESCRPVyZ+JisZK4FN7E65D94Am72mLMG+n5azqAcxxxMawSXKmfnx4jttIZQDItG1FAhpws+tGHLPCc1lvCIiw0A/cVlDJpaLlLn9lTTauy+7Q=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;6:2NWV0sXlutVZMk62XXxWCKsFehNuJocCF9noYJKF+u937tJLpD5+IRaXqmyemtFDQ4S2rbQHnFH7wptGRw4E0ot4+M6cc2scbiaLUcdz0/uIcWGbe98qzquYcIblgCcpq52y6xyuOmpz2ixOfKi2aBGC6vK8KLv1Lnr4wqOLR0dqt077rq2COLPxgE7j+XEI7btTueu9R+sjcLQ+Pa4UvXb7DQspuk1lsCiZaK9sSg9rPG5STK6W65/vSVLVvi3whb0jFDSBCcYe4yeFTBHwkWG+SUrRGAu0awxdEYaMOAeUAUJ3RKUhX8846wcosFL0I3w16GNo9CmG5FwJqo+gC/s2PHQCZ5/0oBEzqk8i7XkH3u+tQbA4YtwJx0vcNOkbStP7IDuUhF7AHfpEPSEzK7UKbnnaL8V6cr0oh9rmgHw2AvHJZXQv+w0ZMgzluAprdkRum7JFNtOAHC3cKD/MBQ==;5:kvS//iWsOy4I9oVDbCJpELqKt10i8lEiLnl7fZQIoaomXhYIlZovUzHuG8YxbkmmhaRFx1lkzyCdAf/yKNCytYqC2aGJOV3fCpn8J4NkqG2pb0QcalqQ3NxSzEygAXOVuE1seqhiL6J1RMp0z4jydWz9uk5v+/b0hJfQb9LJBIo=;24:Hsm2uU/vrjyu87L2z6Tnr0MrnH7vl9P0yof2EDnSAnId4804D64NQ8T0yKB/pmEvCVUDWsnZrYxcAFjeteCgH30r95QMQ9MyB+SubjOfMgw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;7:9wJdjeh6sQXCgA8J2yYooy1UeUizJN3eos4WkS9cnNEyypgfFpjsHrtaknzyPSprethFlgYs9NuGHrJKD0K4Q2A0jlT6bPKqi5xJzw9F/fQNnW1VNCn0DILkEbG5NFEHGFRmHBCtsRRe619Qx/g7YgDFkkyCdNu5ol5qQy5xveGnMwm16GlzPtPyqPRbxNXKpK4rQZ1FNouSFfJ7zDjjfJQJrArHbbxp24QXtlDg7WvVj4qPaW9j8WD3f5AA2xnG
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2018 07:37:30.8489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 230d68d7-5177-49b9-0481-08d5e7012972
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4457
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for arm pl353 static memory controller. This controller is used in
Xilinx Zynq SoC for interfacing the NAND and NOR/SRAM memory devices.

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
Changes in v11:
 - Added amba device registration and removed platform device, since it
   is an ARM Primecell Peripheral and it should register as an amba device
   as per Linus Walleji.
Changes in v10:
 - Corrected typos in commit message like xilinx to Xilinx
 - Added SoC specific compilation check in Kconfig as below
   "depends on ARCH_ZYNQ"
 - Modified return type from int to bool to the function
   pl353_smc_ecc_is_busy
 - Defined Macros for values in pl353_smc_get_ecc_val and modifed
   the logic to read ecc value from all 4 registers
 - Assinged the timeout value in pl353_smc_init_nand_interface()
   after declaration
 - Added compatibles on another line and aligned the data with them
 - Removed pl353-smc.h from platform-data and moved it to include/linux
Changes in v9:
 - Addressed the comments given by Julia Cartwright to the v8 series.
Changes in v8:
- None
Changes in v7:
- Corrected the kconfig to use tristate selection
- Corrected the GPL licence ident
- Added boundary checks for nand timing parameters
Changes in v6:
- Fixed checkpatch.pl reported warnings
Changes in v5:
- Added pl353_smc_get_clkrate function, made pl353_smc_set_cycles as public
  API
- Removed nand timing parameter initialization and moved it to nand driver
Changes in v4:
- Modified driver to support multiple instances
- Used sleep instaed of busywait for delay
Changes in v3:
- None
Changes in v2:
- Since now the timing parameters are in nano seconds, added logic to convert
  them to the cycles
---
 drivers/memory/Kconfig     |  10 +
 drivers/memory/Makefile    |   1 +
 drivers/memory/pl353-smc.c | 468 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pl353-smc.h  |  30 +++
 4 files changed, 509 insertions(+)
 create mode 100644 drivers/memory/pl353-smc.c
 create mode 100644 include/linux/pl353-smc.h

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 19a0e83..1a84125 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -153,6 +153,16 @@ config DA8XX_DDRCTL
 	  Texas Instruments da8xx SoCs. It's used to tweak various memory
 	  controller configuration options.
 
+config PL353_SMC
+	tristate "ARM PL35X Static Memory Controller(SMC) driver"
+	default y
+	depends on ARM
+	depends on ARCH_ZYNQ
+	depends on ARM_AMBA
+	help
+	  This driver is for the ARM PL351/PL353 Static Memory
+	  Controller(SMC) module.
+
 source "drivers/memory/samsung/Kconfig"
 source "drivers/memory/tegra/Kconfig"
 
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index 66f5524..58e794d 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_TEGRA20_MC)	+= tegra20-mc.o
 obj-$(CONFIG_JZ4780_NEMC)	+= jz4780-nemc.o
 obj-$(CONFIG_MTK_SMI)		+= mtk-smi.o
 obj-$(CONFIG_DA8XX_DDRCTL)	+= da8xx-ddrctl.o
+obj-$(CONFIG_PL353_SMC)		+= pl353-smc.o
 
 obj-$(CONFIG_SAMSUNG_MC)	+= samsung/
 obj-$(CONFIG_TEGRA_MC)		+= tegra/
diff --git a/drivers/memory/pl353-smc.c b/drivers/memory/pl353-smc.c
new file mode 100644
index 0000000..bab5626
--- /dev/null
+++ b/drivers/memory/pl353-smc.c
@@ -0,0 +1,468 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM PL353 SMC driver
+ *
+ * Copyright (C) 2012 Xilinx, Inc
+ * Author: Punnaiah Choudary Kalluri <punnaiah@xilinx.com>
+ * Author: Naga Sureshkumar Relli <nagasure@xilinx.com>
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/pl353-smc.h>
+#include <linux/amba/bus.h>
+
+/* Register definitions */
+#define PL353_SMC_MEMC_STATUS_OFFS	0	/* Controller status reg, RO */
+#define PL353_SMC_CFG_CLR_OFFS		0xC	/* Clear config reg, WO */
+#define PL353_SMC_DIRECT_CMD_OFFS	0x10	/* Direct command reg, WO */
+#define PL353_SMC_SET_CYCLES_OFFS	0x14	/* Set cycles register, WO */
+#define PL353_SMC_SET_OPMODE_OFFS	0x18	/* Set opmode register, WO */
+#define PL353_SMC_ECC_STATUS_OFFS	0x400	/* ECC status register */
+#define PL353_SMC_ECC_MEMCFG_OFFS	0x404	/* ECC mem config reg */
+#define PL353_SMC_ECC_MEMCMD1_OFFS	0x408	/* ECC mem cmd1 reg */
+#define PL353_SMC_ECC_MEMCMD2_OFFS	0x40C	/* ECC mem cmd2 reg */
+#define PL353_SMC_ECC_VALUE0_OFFS	0x418	/* ECC value 0 reg */
+
+/* Controller status register specific constants */
+#define PL353_SMC_MEMC_STATUS_RAW_INT_1_SHIFT	6
+
+/* Clear configuration register specific constants */
+#define PL353_SMC_CFG_CLR_INT_CLR_1	0x10
+#define PL353_SMC_CFG_CLR_ECC_INT_DIS_1	0x40
+#define PL353_SMC_CFG_CLR_INT_DIS_1	0x2
+#define PL353_SMC_CFG_CLR_DEFAULT_MASK	(PL353_SMC_CFG_CLR_INT_CLR_1 | \
+					 PL353_SMC_CFG_CLR_ECC_INT_DIS_1 | \
+					 PL353_SMC_CFG_CLR_INT_DIS_1)
+
+/* Set cycles register specific constants */
+#define PL353_SMC_SET_CYCLES_T0_MASK	0xF
+#define PL353_SMC_SET_CYCLES_T0_SHIFT	0
+#define PL353_SMC_SET_CYCLES_T1_MASK	0xF
+#define PL353_SMC_SET_CYCLES_T1_SHIFT	4
+#define PL353_SMC_SET_CYCLES_T2_MASK	0x7
+#define PL353_SMC_SET_CYCLES_T2_SHIFT	8
+#define PL353_SMC_SET_CYCLES_T3_MASK	0x7
+#define PL353_SMC_SET_CYCLES_T3_SHIFT	11
+#define PL353_SMC_SET_CYCLES_T4_MASK	0x7
+#define PL353_SMC_SET_CYCLES_T4_SHIFT	14
+#define PL353_SMC_SET_CYCLES_T5_MASK	0x7
+#define PL353_SMC_SET_CYCLES_T5_SHIFT	17
+#define PL353_SMC_SET_CYCLES_T6_MASK	0xF
+#define PL353_SMC_SET_CYCLES_T6_SHIFT	20
+
+/* ECC status register specific constants */
+#define PL353_SMC_ECC_STATUS_BUSY	BIT(6)
+#define PL353_SMC_ECC_REG_SIZE_OFFS	4
+
+/* ECC memory config register specific constants */
+#define PL353_SMC_ECC_MEMCFG_MODE_MASK	0xC
+#define PL353_SMC_ECC_MEMCFG_MODE_SHIFT	2
+#define PL353_SMC_ECC_MEMCFG_PGSIZE_MASK	0xC
+
+#define PL353_SMC_DC_UPT_NAND_REGS	((4 << 23) |	/* CS: NAND chip */ \
+				 (2 << 21))	/* UpdateRegs operation */
+
+#define PL353_NAND_ECC_CMD1	((0x80)       |	/* Write command */ \
+				 (0 << 8)     |	/* Read command */ \
+				 (0x30 << 16) |	/* Read End command */ \
+				 (1 << 24))	/* Read End command calid */
+
+#define PL353_NAND_ECC_CMD2	((0x85)	      |	/* Write col change cmd */ \
+				 (5 << 8)     |	/* Read col change cmd */ \
+				 (0xE0 << 16) |	/* Read col change end cmd */ \
+				 (1 << 24)) /* Read col change end cmd valid */
+#define PL353_NAND_ECC_BUSY_TIMEOUT	(1 * HZ)
+/**
+ * struct pl353_smc_data - Private smc driver structure
+ * @memclk:		Pointer to the peripheral clock
+ * @aclk:		Pointer to the APER clock
+ */
+struct pl353_smc_data {
+	struct clk		*memclk;
+	struct clk		*aclk;
+};
+
+/* SMC virtual register base */
+static void __iomem *pl353_smc_base;
+
+/**
+ * pl353_smc_set_buswidth - Set memory buswidth
+ * @bw:	Memory buswidth (8 | 16)
+ * Return: 0 on success or negative errno.
+ */
+int pl353_smc_set_buswidth(unsigned int bw)
+{
+	if (bw != PL353_SMC_MEM_WIDTH_8  && bw != PL353_SMC_MEM_WIDTH_16)
+		return -EINVAL;
+
+	writel(bw, pl353_smc_base + PL353_SMC_SET_OPMODE_OFFS);
+	writel(PL353_SMC_DC_UPT_NAND_REGS, pl353_smc_base +
+	       PL353_SMC_DIRECT_CMD_OFFS);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pl353_smc_set_buswidth);
+
+/**
+ * pl353_smc_set_cycles - Set memory timing parameters
+ * @timings: NAND controller timing parameters
+ *
+ * Sets NAND chip specific timing parameters.
+ */
+void pl353_smc_set_cycles(u32 timings[])
+{
+	/*
+	 * Set write pulse timing. This one is easy to extract:
+	 *
+	 * NWE_PULSE = tWP
+	 */
+	timings[0] &= PL353_SMC_SET_CYCLES_T0_MASK;
+	timings[1] = (timings[1] & PL353_SMC_SET_CYCLES_T1_MASK) <<
+			PL353_SMC_SET_CYCLES_T1_SHIFT;
+	timings[2] = (timings[2]  & PL353_SMC_SET_CYCLES_T2_MASK) <<
+			PL353_SMC_SET_CYCLES_T2_SHIFT;
+	timings[3] = (timings[3]  & PL353_SMC_SET_CYCLES_T3_MASK) <<
+			PL353_SMC_SET_CYCLES_T3_SHIFT;
+	timings[4] = (timings[4] & PL353_SMC_SET_CYCLES_T4_MASK) <<
+			PL353_SMC_SET_CYCLES_T4_SHIFT;
+	timings[5]  = (timings[5]  & PL353_SMC_SET_CYCLES_T5_MASK) <<
+			PL353_SMC_SET_CYCLES_T5_SHIFT;
+	timings[6]  = (timings[6]  & PL353_SMC_SET_CYCLES_T6_MASK) <<
+			PL353_SMC_SET_CYCLES_T6_SHIFT;
+	timings[0] |= timings[1] | timings[2] | timings[3] |
+			timings[4] | timings[5] | timings[6];
+
+	writel(timings[0], pl353_smc_base + PL353_SMC_SET_CYCLES_OFFS);
+	writel(PL353_SMC_DC_UPT_NAND_REGS, pl353_smc_base +
+	       PL353_SMC_DIRECT_CMD_OFFS);
+}
+EXPORT_SYMBOL_GPL(pl353_smc_set_cycles);
+
+/**
+ * pl353_smc_ecc_is_busy - Read ecc busy flag
+ * Return: the ecc_status bit from the ecc_status register. 1 = busy, 0 = idle
+ */
+bool pl353_smc_ecc_is_busy(void)
+{
+	return ((readl(pl353_smc_base + PL353_SMC_ECC_STATUS_OFFS) &
+		  PL353_SMC_ECC_STATUS_BUSY) == PL353_SMC_ECC_STATUS_BUSY);
+}
+EXPORT_SYMBOL_GPL(pl353_smc_ecc_is_busy);
+
+/**
+ * pl353_smc_get_ecc_val - Read ecc_valueN registers
+ * @ecc_reg:	Index of the ecc_value reg (0..3)
+ * Return: the content of the requested ecc_value register.
+ *
+ * There are four valid ecc_value registers. The argument is truncated to stay
+ * within this valid boundary.
+ */
+u32 pl353_smc_get_ecc_val(int ecc_reg)
+{
+	u32 addr, reg;
+
+	addr = PL353_SMC_ECC_VALUE0_OFFS +
+		(ecc_reg * PL353_SMC_ECC_REG_SIZE_OFFS);
+	reg = readl(pl353_smc_base + addr);
+
+	return reg;
+}
+EXPORT_SYMBOL_GPL(pl353_smc_get_ecc_val);
+
+/**
+ * pl353_smc_get_nand_int_status_raw - Get NAND interrupt status bit
+ * Return: the raw_int_status1 bit from the memc_status register
+ */
+int pl353_smc_get_nand_int_status_raw(void)
+{
+	u32 reg;
+
+	reg = readl(pl353_smc_base + PL353_SMC_MEMC_STATUS_OFFS);
+	reg >>= PL353_SMC_MEMC_STATUS_RAW_INT_1_SHIFT;
+	reg &= 1;
+
+	return reg;
+}
+EXPORT_SYMBOL_GPL(pl353_smc_get_nand_int_status_raw);
+
+/**
+ * pl353_smc_clr_nand_int - Clear NAND interrupt
+ */
+void pl353_smc_clr_nand_int(void)
+{
+	writel(PL353_SMC_CFG_CLR_INT_CLR_1,
+	       pl353_smc_base + PL353_SMC_CFG_CLR_OFFS);
+}
+EXPORT_SYMBOL_GPL(pl353_smc_clr_nand_int);
+
+/**
+ * pl353_smc_set_ecc_mode - Set SMC ECC mode
+ * @mode:	ECC mode (BYPASS, APB, MEM)
+ * Return: 0 on success or negative errno.
+ */
+int pl353_smc_set_ecc_mode(enum pl353_smc_ecc_mode mode)
+{
+	u32 reg;
+	int ret = 0;
+
+	switch (mode) {
+	case PL353_SMC_ECCMODE_BYPASS:
+	case PL353_SMC_ECCMODE_APB:
+	case PL353_SMC_ECCMODE_MEM:
+
+		reg = readl(pl353_smc_base + PL353_SMC_ECC_MEMCFG_OFFS);
+		reg &= ~PL353_SMC_ECC_MEMCFG_MODE_MASK;
+		reg |= mode << PL353_SMC_ECC_MEMCFG_MODE_SHIFT;
+		writel(reg, pl353_smc_base + PL353_SMC_ECC_MEMCFG_OFFS);
+
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pl353_smc_set_ecc_mode);
+
+/**
+ * pl353_smc_set_ecc_pg_size - Set SMC ECC page size
+ * @pg_sz:	ECC page size
+ * Return: 0 on success or negative errno.
+ */
+int pl353_smc_set_ecc_pg_size(unsigned int pg_sz)
+{
+	u32 reg, sz;
+
+	switch (pg_sz) {
+	case 0:
+		sz = 0;
+		break;
+	case SZ_512:
+		sz = 1;
+		break;
+	case SZ_1K:
+		sz = 2;
+		break;
+	case SZ_2K:
+		sz = 3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	reg = readl(pl353_smc_base + PL353_SMC_ECC_MEMCFG_OFFS);
+	reg &= ~PL353_SMC_ECC_MEMCFG_PGSIZE_MASK;
+	reg |= sz;
+	writel(reg, pl353_smc_base + PL353_SMC_ECC_MEMCFG_OFFS);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pl353_smc_set_ecc_pg_size);
+
+static int __maybe_unused pl353_smc_suspend(struct device *dev)
+{
+	struct pl353_smc_data *pl353_smc = dev_get_drvdata(dev);
+
+	clk_disable(pl353_smc->memclk);
+	clk_disable(pl353_smc->aclk);
+
+	return 0;
+}
+
+static int __maybe_unused pl353_smc_resume(struct device *dev)
+{
+	int ret;
+	struct pl353_smc_data *pl353_smc = dev_get_drvdata(dev);
+
+	ret = clk_enable(pl353_smc->aclk);
+	if (ret) {
+		dev_err(dev, "Cannot enable axi domain clock.\n");
+		return ret;
+	}
+
+	ret = clk_enable(pl353_smc->memclk);
+	if (ret) {
+		dev_err(dev, "Cannot enable memory clock.\n");
+		clk_disable(pl353_smc->aclk);
+		return ret;
+	}
+
+	return ret;
+}
+static struct amba_driver pl353_smc_driver;
+static SIMPLE_DEV_PM_OPS(pl353_smc_dev_pm_ops, pl353_smc_suspend,
+			 pl353_smc_resume);
+
+/**
+ * pl353_smc_init_nand_interface - Initialize the NAND interface
+ * @adev:	Pointer to the amba_device struct
+ * @nand_node:	Pointer to the pl353_nand device_node struct
+ */
+void pl353_smc_init_nand_interface(struct amba_device *adev,
+					struct device_node *nand_node)
+{
+	unsigned long timeout;
+
+	pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_8);
+	writel(PL353_SMC_CFG_CLR_INT_CLR_1,
+	       pl353_smc_base + PL353_SMC_CFG_CLR_OFFS);
+	writel(PL353_SMC_DC_UPT_NAND_REGS, pl353_smc_base +
+	       PL353_SMC_DIRECT_CMD_OFFS);
+
+	timeout = jiffies + PL353_NAND_ECC_BUSY_TIMEOUT;
+	/* Wait till the ECC operation is complete */
+	do {
+		if (pl353_smc_ecc_is_busy())
+			cpu_relax();
+		else
+			break;
+	} while (!time_after_eq(jiffies, timeout));
+
+	if (time_after_eq(jiffies, timeout))
+		return;
+
+	writel(PL353_NAND_ECC_CMD1,
+	       pl353_smc_base + PL353_SMC_ECC_MEMCMD1_OFFS);
+	writel(PL353_NAND_ECC_CMD2,
+	       pl353_smc_base + PL353_SMC_ECC_MEMCMD2_OFFS);
+}
+
+static const struct of_device_id pl353_smc_supported_children[] = {
+	{
+		.compatible = "cfi-flash"
+	},
+	{
+		.compatible = "arm,pl353-nand-r2p1",
+		.data = pl353_smc_init_nand_interface
+	},
+	{}
+};
+
+static int pl353_smc_probe(struct amba_device *adev, const struct amba_id *id)
+{
+	struct pl353_smc_data *pl353_smc;
+	struct device_node *child;
+	struct resource *res;
+	int err;
+	struct device_node *of_node = adev->dev.of_node;
+	void (*init)(struct amba_device *adev,
+		     struct device_node *nand_node);
+	const struct of_device_id *match = NULL;
+
+	pl353_smc = devm_kzalloc(&adev->dev, sizeof(*pl353_smc), GFP_KERNEL);
+	if (!pl353_smc)
+		return -ENOMEM;
+
+	/* Get the NAND controller virtual address */
+	res = &adev->res;
+	pl353_smc_base = devm_ioremap_resource(&adev->dev, res);
+	if (IS_ERR(pl353_smc_base))
+		return PTR_ERR(pl353_smc_base);
+
+	pl353_smc->aclk = devm_clk_get(&adev->dev, "apb_pclk");
+	if (IS_ERR(pl353_smc->aclk)) {
+		dev_err(&adev->dev, "aclk clock not found.\n");
+		return PTR_ERR(pl353_smc->aclk);
+	}
+
+	pl353_smc->memclk = devm_clk_get(&adev->dev, "memclk");
+	if (IS_ERR(pl353_smc->memclk)) {
+		dev_err(&adev->dev, "memclk clock not found.\n");
+		return PTR_ERR(pl353_smc->memclk);
+	}
+
+	err = clk_prepare_enable(pl353_smc->aclk);
+	if (err) {
+		dev_err(&adev->dev, "Unable to enable AXI clock.\n");
+		return err;
+	}
+
+	err = clk_prepare_enable(pl353_smc->memclk);
+	if (err) {
+		dev_err(&adev->dev, "Unable to enable memory clock.\n");
+		goto out_clk_dis_aper;
+	}
+
+	amba_set_drvdata(adev, pl353_smc);
+
+	/* clear interrupts */
+	writel(PL353_SMC_CFG_CLR_DEFAULT_MASK,
+	       pl353_smc_base + PL353_SMC_CFG_CLR_OFFS);
+
+	/* Find compatible children. Only a single child is supported */
+	for_each_available_child_of_node(of_node, child) {
+		match = of_match_node(pl353_smc_supported_children, child);
+		if (!match) {
+			dev_warn(&adev->dev, "unsupported child node\n");
+			continue;
+		}
+		break;
+	}
+	if (!match) {
+		dev_err(&adev->dev, "no matching children\n");
+		goto out_clk_disable;
+	}
+
+	init = match->data;
+	if (init)
+		init(adev, child);
+	of_platform_device_create(child, NULL, &adev->dev);
+
+	return 0;
+
+out_clk_disable:
+	clk_disable_unprepare(pl353_smc->memclk);
+out_clk_dis_aper:
+	clk_disable_unprepare(pl353_smc->aclk);
+
+	return err;
+}
+
+static int pl353_smc_remove(struct amba_device *adev)
+{
+	struct pl353_smc_data *pl353_smc = amba_get_drvdata(adev);
+
+	clk_disable_unprepare(pl353_smc->memclk);
+	clk_disable_unprepare(pl353_smc->aclk);
+
+	return 0;
+}
+
+/* Match table for device tree binding */
+static const struct of_device_id pl353_smc_of_match[] = {
+	{ .compatible = "arm,pl353-smc-r2p1" },
+	{ },
+};
+
+static const struct amba_id pl353_ids[] = {
+	{
+	.id = 0x00041353,
+	.mask = 0x000fffff,
+	},
+	{ 0, 0 },
+};
+MODULE_DEVICE_TABLE(amba, pl353_ids);
+
+static struct amba_driver pl353_smc_driver = {
+	.drv = {
+		.owner = THIS_MODULE,
+		.name = "pl353-smc",
+		.pm = &pl353_smc_dev_pm_ops,
+	},
+	.id_table = pl353_ids,
+	.probe		= pl353_smc_probe,
+	.remove		= pl353_smc_remove,
+};
+
+module_amba_driver(pl353_smc_driver);
+
+MODULE_AUTHOR("Xilinx, Inc.");
+MODULE_DESCRIPTION("ARM PL353 SMC Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/pl353-smc.h b/include/linux/pl353-smc.h
new file mode 100644
index 0000000..2939d49
--- /dev/null
+++ b/include/linux/pl353-smc.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * ARM PL353 SMC Driver Header
+ *
+ * Copyright (C) 2017 Xilinx, Inc
+ */
+
+#ifndef __LINUX_MEMORY_PL353_SMC_H
+#define __LINUX_MEMORY_PL353_SMC_H
+
+enum pl353_smc_ecc_mode {
+	PL353_SMC_ECCMODE_BYPASS = 0,
+	PL353_SMC_ECCMODE_APB = 1,
+	PL353_SMC_ECCMODE_MEM = 2
+};
+
+enum pl353_smc_mem_width {
+	PL353_SMC_MEM_WIDTH_8 = 0,
+	PL353_SMC_MEM_WIDTH_16 = 1
+};
+
+u32 pl353_smc_get_ecc_val(int ecc_reg);
+bool pl353_smc_ecc_is_busy(void);
+int pl353_smc_get_nand_int_status_raw(void);
+void pl353_smc_clr_nand_int(void);
+int pl353_smc_set_ecc_mode(enum pl353_smc_ecc_mode mode);
+int pl353_smc_set_ecc_pg_size(unsigned int pg_sz);
+int pl353_smc_set_buswidth(unsigned int bw);
+void pl353_smc_set_cycles(u32 timings[]);
+#endif
-- 
2.7.4

