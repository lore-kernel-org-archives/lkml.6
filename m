Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14630C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B64620854
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="d7ZcBiLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B64620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbeGKHor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:44:47 -0400
Received: from mail-eopbgr720043.outbound.protection.outlook.com ([40.107.72.43]:40304
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726205AbeGKHor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ex28KpRffTVW+BeEJNHQEtjPLcu5V7yS0zdDOBRNHX4=;
 b=d7ZcBiLlcbCobXt0qThMvopcmTkvS5B9nU2ryLDMcP31dFy3co0J8J+Nl9FxcEhgNVfd2LNMcf/4OD7laGbtuOUtsr352tMYqImGI/KXT5AKxzV4eX0m4XYpiUUc2C7SoGEYXHKBX1ioVIHIdhH7snOHkn+V5xYso3isYrueXrc=
Received: from BYAPR02CA0050.namprd02.prod.outlook.com (2603:10b6:a03:54::27)
 by BYAPR02MB4455.namprd02.prod.outlook.com (2603:10b6:a03:57::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.20; Wed, 11 Jul
 2018 07:37:42 +0000
Received: from BL2NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by BYAPR02CA0050.outlook.office365.com
 (2603:10b6:a03:54::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.930.21 via Frontend
 Transport; Wed, 11 Jul 2018 07:37:41 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT007.mail.protection.outlook.com (10.152.77.46) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.930.16
 via Frontend Transport; Wed, 11 Jul 2018 07:37:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fd9gy-0004hZ-FM; Wed, 11 Jul 2018 00:37:40 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fd9gt-0003aq-CA; Wed, 11 Jul 2018 00:37:35 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6B7bPqh027539;
        Wed, 11 Jul 2018 00:37:25 -0700
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fd9gi-0003UL-Eg; Wed, 11 Jul 2018 00:37:25 -0700
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
Subject: [LINUX PATCH v11 3/3] mtd: rawnand: pl353: Add basic driver for arm pl353 smc nand interface
Date:   Wed, 11 Jul 2018 13:06:52 +0530
Message-ID: <1531294612-29526-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531294612-29526-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1531294612-29526-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39860400002)(376002)(2980300002)(438002)(199004)(189003)(305945005)(53946003)(14444005)(107886003)(81156014)(39060400002)(76176011)(8676002)(2201001)(478600001)(8936002)(4326008)(7696005)(6666003)(63266004)(36756003)(26005)(77096007)(51416003)(50226002)(5660300001)(81166006)(106466001)(9786002)(47776003)(48376002)(16586007)(356003)(50466002)(106002)(426003)(316002)(186003)(54906003)(11346002)(2906002)(2616005)(7416002)(36386004)(476003)(446003)(486006)(110136005)(336012)(126002)(921003)(107986001)(1121003)(217873001)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4455;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT007;1:H7WN+NztpfY3NV0QR78XPeGsR0fS2VPlElrLGEadX0dZGHwzsuVocwFwKll8TuiTAVE4pd+6LMsR3NFoVRR/NZQhUSPThjDv9fy5EEycPHOHOxs0RXivCMALQJmf2ng4
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a03c99cf-9bf2-415b-304b-08d5e7012f38
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BYAPR02MB4455;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;3:gLkoUembEwjYSfCWqglOoxpCY91p5hYT9wYjykt7JOeiURyFZB8d/19X6gfWfhDav05kiFhGztspEJ/djaE1B3pqBjOczSm/DGu0HaLgxXm9w6Bypm9CxgRn/2NGMjopwfCdirzMNQHh7XCCT56fjyD+UMQ/MOYY6BhaQQJgraXP35qpOs2fxCbtIGVc3Vr46ApveOzhw7pE/SuCWF3v2CnSogxPRh3hwEAYV6yszDAsxj71gZyem9SJu3JQs2E6lC7jyLx8nTEYNZC53y5dAjTzw56JGCCSYIFJvcmWXB+6lxp+gu9uJprIImAy2kQ1poPBMorSgZmx0ZfJP87DgK8ytFhOEqg1LtDbHsqRmzs=;25:8O0M/HdTfqE8Sh3KXaxlrlkXgQjpGVOXoeBOFLS1vkDL948EByeNAxcMaG1os2EpRQOMekQw/QHWFhIBog1HAsxJeV5KWlilsh2tlEvS+WwEXIBZDZOtFX46yQfdKv0JgGemvOYc45aGw4IPcsnsmVSjqSWwwct+ToJUJzeGTYTe6qKDSu2H14e3aAfRXbNEXtpH5cZKovpQy/bvIIiMzssfoi6Bzftz0g9JBVD8jg0vOEFSWXobDcQBBcon5fuRqsIPOJqswI2DL3voXvdowcSTrr6SW0X3FFhGWfnZrEDhiu+aKpkuOyCqFhoteBt1I46DOtPlYjM7bB8vXc1kjA==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4455:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;31:6D4SRpAZTHN5CzCFWvdP3wZTJsJ/rfCvVOmE4ADGVbpL0hlPcqJx+PVidVWvCQ8HGtIUxauAkujqgs69ntNtIr1adwuY1yb/A7Z+94ujHtI4vUJAiV6bx21nwhNtUmll/ZAkcOvuwF++c7apN/xZlTrEuvmTdSb1tWAn+Ix5I+KXbgjK1mwrLaGr3DTfzhbz8xNEAP1b7X/lYTCXsALN4MHH1atHJJSJDdUkD7pWws0=;20:ospPY87BgZqHyTtYT6b1JzLO8diUbE/wnhXTS28UTQ2hUBWsUOAbq1cJPBem/VIzcdTYpqbKldZCUUuXmhvlwt1LYBXnHnJd1Ao/MLB8+OI/KlpzubtL2BPwSk7h6jIrYv8eTnPS/TmQsNj47q1iJ3FVcirdp+R4G0KWSruz6EDYY77iTuS9pvSwQS/jxjWwTAKrPlWx5knmek2NaIYmWRwV/57g/+h9trtukKC0xu4DwXByTKYiiSl/DGwM9n545PvDCegl2dNgWhHroDpxJRIftrhGLSKh2s1YKu9eFifoZwuA7eSuYQs7vZp+DYU6m9aCAWK0nF25WVCfsLhPVdnrdzc0Jb97og8Cet5J6ESTvzwRpNoEkCItXlnugfhpeIFyqmzKOS8E+Ua/1tLjdVz/2fPKcSFtxheCg1KVwv5CSL7qrP7dmGPgRs2jnRe3SJe0t4pUL1dkhksTJ9NA22XXWqyDsLfTpengRxcHKl27zccN5RpumXS/+fSYzbDZ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB44554A7F9B61FBB89DBD9642AF5A0@BYAPR02MB4455.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BYAPR02MB4455;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4455;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;4:hj+KL6qbToSbsynaq2OoSu65mYAO247oYRncAeIQT5HZq3z5bqc1+xIhnGPF+S4arg/fqznzhJdVOyPprdDcIjEkN1SBSxDvBALnRninE+2WyS5wJLrVjQKCH04Hko4ObJ2wVPBgyLHuQy/ZbRC7qyAbpDF52RNGabrTGIm0V8kr4rZSPIacjhUD5zDOFYdrduthM/7urGNYALJLHXraSvnF3eAPxK+ymSWy1Mbs+/W73+DX6XYVM5roRs8G6tedFMFa4qL9Bskl6mljnkvUf9tZJXvG6V5+r8hJd0SS76D2PRp0Tt+DhUDTP19gIooY
X-Forefront-PRVS: 0730093765
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4455;23:TVv32VbLSYRMxVZ8537aBb3AGNiIhqO9+5lwzgN11?=
 =?us-ascii?Q?+pFhDTK2E6TYziEI/dKRvOB72GqYzdX9gAEV9kDpj2DAXPRSrv/lr53+jTm0?=
 =?us-ascii?Q?1ZqraXKLXLJI3rTDv9g6OmbsSAC1pGueUodLf9JqhNRreRIUam6KrkD1mhRI?=
 =?us-ascii?Q?MFMf+xcD63T+IkNrxComYl4ZZc/6AvfF1DtcU83aKmrdt5m/H9NOjWxF1l5D?=
 =?us-ascii?Q?HaU8hqM+H4VMBhxy+IzuA7dlX9k1bAzfVF4Rwdk9+5awr86MCyc77/0LtkIv?=
 =?us-ascii?Q?1ti/XbmGD1emEQgZIIMnXxadGb/ApH984FUMGPIckoyN7gszKgRKfp0J795a?=
 =?us-ascii?Q?ZJl/1vTMBEJBFDsg2ugSV7J5QlMpM8l4o0lJFG3cfbFgpxvYmpt8VvxHRxp5?=
 =?us-ascii?Q?z3wynd6P070WPrp8Vlvaa9EXvsq0SAPD41bURhi5iku5fXmsa2mP2Rz5X2nN?=
 =?us-ascii?Q?fD5rk/cHYXO8/PkNVb7HrggOjaobb3kpfHuPl6V6n00YEDDzqK2LIyymgIYQ?=
 =?us-ascii?Q?AJWGigN2GvMKCHzJFQPk3u+xt+LASvrdXe4jkhg5PH8KYMSCazGhCVx4BVfX?=
 =?us-ascii?Q?MM6EvipBPEz7qXTeb+DRTxgCe5/SAfPnKYMV9bRE2gSjwb9HVOA4GJoYeIp7?=
 =?us-ascii?Q?sCXcjhYn1BmfrrOE2JuOgsK2kEBQtJ0xrn52055fIrGow1o/ay0P2QlWKine?=
 =?us-ascii?Q?zwOgst+DlN9mXEkHtRjR5dEZrrzlWEe5mOyPh8WpCT20/itN3z0T0phioTn6?=
 =?us-ascii?Q?i/TrTvrA5Z+jG/ZHSI1loL4VRQiXviux7LWqlRbaiziCyHPQWm8GVGoLI8HV?=
 =?us-ascii?Q?HGeKFCN1mDL1K+JseXeKkHbLjfC/cEI20YyHHzaMojiOdJWysngQmtycXqR6?=
 =?us-ascii?Q?oM1sGvYHr78UrpyRbY8bGPjv3Vss0ELe4TA1W5jdwf+2Cfwngc3aq820LcxX?=
 =?us-ascii?Q?y/0047qrqHgAR7Z9fvkTfQRDCpHYN9QtYNRvjwTTh/SvKB3lyu6mOGWl60IU?=
 =?us-ascii?Q?UJgLIKdFtVUHN4dno6ID1/BiMtzl39NxFeAqf822sUNavU0wJoSSO0UnL1Or?=
 =?us-ascii?Q?EKcT2cSfEAQZcnDTJ8vB3VUl5O8BhxxQo4eUVGeWXo/0XsEXtjBposiQja2m?=
 =?us-ascii?Q?mh3TK7tYS0B4cM+zXmNhuAIpdjCqN47yz+2RgJQsjBP8/PySeo/+CezlWWYs?=
 =?us-ascii?Q?8SPX9nFZWmrmWEhq77yjW3JeO7/maZLJduXjhUzvZPo05O0boJkiJTB9anoF?=
 =?us-ascii?Q?lKaISL5W0C71tGd6L6kiCYNym9AE/lB4GWi+QhByG5O7HgZmcxmD6YFhF9pI?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: Kzt8eWXr7Rv7p60x8ogCAYGAvunAYCnlxjXfcu9FO9YvP1Q6amMJwC3HRftoua+6TIRcyOhFoVZj3y13E9YBVcISOsiBPPwi9c0Y34N5hE+byD2CBtEeS67fyxdLVn1YKLinlWz77o4jj3jCpse7U4A5qw6kZ7cgsEwIIK23r7MmX7QtbipFkQP+8rgOzkSYC22Vk7DPZq5UoQ+vxDfs5Z4qs2vw7JzZHeszsgNOQ42aHa3d/pNsj4HNm+XvM1gZyQMPmO1cFPHjQ18QoX9lqbRKc4Z58m10n951HboqkpJZWs444vXe1VpiwytTTVnn1cRJbtQYIcNUh4XLNC9xWysX6ZWOijKY9eVUzLfDJao=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;6:iKkXVUB0rJh7RtjEIOVOHjAIk8WJ/ChO6lfHOJUH65aObvIwLskXkpim02xSfuFfFNQSQ3fgfNKHnVF/Mwm6S0wpRMYqwmzts+UqZLwy3zSSCcjZ8T3ENieNfAk2TSEcVwLtXObod97qN9gxFEdXYlHy+sBkt1hGjtkmbeZqHeemc5v4UlUYNlbaw4vNn3pUvL8L7d/g4y0sR0Q8LObyBtSkIkFFz0A+cnkZMy3sW8blarVr714l7jT1Q9itPDIYXX7TRwk45zyWPOLUpw3Eyt9sBibIBZizF7XIwhYBJURL63+ejhwC2auibYPtV1GPAuEVDaPOiBwI0y9eiAdIxb8wCJyzVnwq/5gvaP+IlVdXX54iYD7MoZZFfszbfGTTWtVTBJyOOuGnL1fk4gEPkeUzM2u9MSXscSMNB5j6+B0faVY3Nw8e8FotRhWBhRc/x+sbbV4r6fIHUo+TeZDdrA==;5:r4JiCstxTLNE+FommhJAwuGV1sbUY15eQ45uf7gdWIyonVnPQBwVsDNrm3vbnIDmX5wRRGJukzsRGADcPVzzVrqn10kSHQHnZnFU4UAWZpHDeDSNz5CyvWsKyQs1vsCnLwibRTq9pej9ejeAPMpFzpqlj2ElkJxtV5cSMY74+b0=;24:osB33JaomolUyLZJIs6xyK3m6i6mz/hpH1vDiuzEGsgoQOcv80rq/Q1VdMOGuPzMJLHM19x007MZeyRxEyswNWgxnQuJk58YFQUURGeX9KE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;7:wkqDtGH8Xlwpf5AsfOOiM8ugAC/xzNr2uUfmYP2C2OfN5Vn+xCZvJxqNW2YDXpZ5hKBkI71p6KS7EbONwDrW3aTi9qMJWQA0CPoWXh46/PsAMmWng4ihjISTWXpQX3bAVtmCXkJO8VI22nAD68O7p2BEivE2mE3z08Mw9Jp3ojz96x0fygnmm5mZHIZVI6ogeVPDkUjtmXmiTAGT8sd6kNG+vaYdGu5JUGRMOvvlrP0KUfOa0ttmh4Dhx6F+4giW
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2018 07:37:41.1925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a03c99cf-9bf2-415b-304b-08d5e7012f38
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for arm pl353 static memory controller nand interface with HW ECC
support. This controller is used in Xilinx Zynq SoC for interfacing the NAND
flash memory.

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
Changes in v11:
 - Removed Documentation patch and added the required info in driver as
   per Boris comments.
 - Removed unwanted variables from pl353_nand_info as per Miquel comments
 - Removed IO_ADDR_R/W.
 - Replaced onhot() with hweight32()
 - Defined macros for static values in function pl353_nand_correct_data()
 - Removed all unnecessary delays
 - Used nand_wait_ready() where ever is required
 - Modifed the pl353_setup_data_interface() logic as per Miquel comments.
 - Taken array instead of 7 values in pl353_setup_data_interface() and pass
   it to smc driver.
 - Added check to collect the return value of mtd_device_register().
Changes in 10:
 - Typos correction like nand to NAND and soc to SOC etc..
 - Defined macros for the values in pl353_nand_calculate_hwecc()
 - Modifed ecc_status from int to char in pl353_nand_calculate_hwecc()
 - Changed the return type form int to bool to the function
   onehot()
 - Removed udelay(1000) in pl353_cmd_function, as it is not required
 - Dropped ecc->hwctl = NULL in pl353_ecc_init()
 - Added an error message in pl353_ecc_init(), when there is no matching
   oobsize
 - Changed the variable from xnand to xnfc
 - Added logic to get mtd->name from DT, if it is specified in DT
Changes in v9:
 - Addressed the below comments given by Miquel
 - instead of using pl353_nand_write32, use directly writel_relaxed
 - Fixed check patch warnings
 - Renamed write_buf/read_buf to write_data_op/read_data_op
 - use BIT macro instead of 1 << nr
 - Use NAND_ROW_ADDR_3 flag
 - Use nand_wait_ready()
 - Removed swecc functions
 - Use address cycles as per size, instead of reading it from Parameter page
 - Instead of writing too many patterns, use optional property
Changes in v8:
 - Added exec_op() implementation
 - Fixed the below v7 review comments
 - removed mtd_info from pl353_nand_info struct
 - Corrected ecc layout offsets
 - Added on-die ecc support
Changes in v7:
 - Currently not implemented the memclk rate adjustments. I will
   look into this later and once the basic driver is accepted.
 - Fixed GPL licence ident
Changes in v6:
 - Fixed the checkpatch.pl reported warnings
 - Using the address cycles information from the onfi param page
   earlier it is hardcoded to 5 in driver
Changes in v5:
 - Configure the nand timing parameters as per the onfi spec Changes in v4:
 - Updated the driver to sync with pl353_smc driver APIs
Changes in v3:
 - implemented the proper error codes
 - further breakdown this patch to multiple sets
 - added the controller and driver details to Documentation section
 - updated the licenece to GPLv2
 - reorganized the pl353_nand_ecc_init function
Changes in v2:
 - use "depends on" rather than "select" option in kconfig
 - remove unused variable parts
---
 drivers/mtd/nand/raw/Kconfig      |    7 +
 drivers/mtd/nand/raw/Makefile     |    1 +
 drivers/mtd/nand/raw/pl353_nand.c | 1314 +++++++++++++++++++++++++++++++++++++
 3 files changed, 1322 insertions(+)
 create mode 100644 drivers/mtd/nand/raw/pl353_nand.c

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 6871ff0..1c5d528 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -530,4 +530,11 @@ config MTD_NAND_MTK
 	  Enables support for NAND controller on MTK SoCs.
 	  This controller is found on mt27xx, mt81xx, mt65xx SoCs.
 
+config MTD_NAND_PL353
+	tristate "ARM Pl353 NAND flash driver"
+	depends on MTD_NAND && ARM
+	depends on PL353_SMC
+	help
+	  Enables support for PrimeCell Static Memory Controller PL353.
+
 endif # MTD_NAND
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 165b7ef..1c702e1 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_MTD_NAND_HISI504)	        += hisi504_nand.o
 obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand/
 obj-$(CONFIG_MTD_NAND_QCOM)		+= qcom_nandc.o
 obj-$(CONFIG_MTD_NAND_MTK)		+= mtk_ecc.o mtk_nand.o
+obj-$(CONFIG_MTD_NAND_PL353)		+= pl353_nand.o
 
 nand-objs := nand_base.o nand_bbt.o nand_timings.o nand_ids.o
 nand-objs += nand_amd.o
diff --git a/drivers/mtd/nand/raw/pl353_nand.c b/drivers/mtd/nand/raw/pl353_nand.c
new file mode 100644
index 0000000..3fa9ba07
--- /dev/null
+++ b/drivers/mtd/nand/raw/pl353_nand.c
@@ -0,0 +1,1314 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM PL353 NAND flash controller driver
+ *
+ * Copyright (C) 2017 Xilinx, Inc
+ * Author: Punnaiah chowdary kalluri <punnaiah@xilinx.com>
+ * Author: Naga Sureshkumar Relli <nagasure@xilinx.com>
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/rawnand.h>
+#include <linux/mtd/nand_ecc.h>
+#include <linux/mtd/partitions.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/pl353-smc.h>
+#include <linux/clk.h>
+
+#define PL353_NAND_DRIVER_NAME "pl353-nand"
+
+/* NAND flash driver defines */
+#define PL353_NAND_CMD_PHASE	1	/* End command valid in command phase */
+#define PL353_NAND_DATA_PHASE	2	/* End command valid in data phase */
+#define PL353_NAND_ECC_SIZE	512	/* Size of data for ECC operation */
+
+/* Flash memory controller operating parameters */
+
+#define PL353_NAND_ECC_CONFIG	(BIT(4)  |	/* ECC read at end of page */ \
+				 (0 << 5))	/* No Jumping */
+
+/* AXI Address definitions */
+#define START_CMD_SHIFT		3
+#define END_CMD_SHIFT		11
+#define END_CMD_VALID_SHIFT	20
+#define ADDR_CYCLES_SHIFT	21
+#define CLEAR_CS_SHIFT		21
+#define ECC_LAST_SHIFT		10
+#define COMMAND_PHASE		(0 << 19)
+#define DATA_PHASE		BIT(19)
+
+#define PL353_NAND_ECC_LAST	BIT(ECC_LAST_SHIFT)	/* Set ECC_Last */
+#define PL353_NAND_CLEAR_CS	BIT(CLEAR_CS_SHIFT)	/* Clear chip select */
+
+#define ONDIE_ECC_FEATURE_ADDR	0x90
+#define PL353_NAND_ECC_BUSY_TIMEOUT	(1 * HZ)
+#define PL353_NAND_DEV_BUSY_TIMEOUT	(1 * HZ)
+#define PL353_NAND_LAST_TRANSFER_LENGTH	4
+#define PL353_NAND_ECC_VALID_SHIFT	24
+#define PL353_NAND_ECC_VALID_MASK	0x40
+#define PL353_ECC_BITS_BYTEOFF_MASK	0x1FF
+#define PL353_ECC_BITS_BITOFF_MASK	0x7
+#define PL353_ECC_BIT_MASK		0xFFF
+#define PL353_TREA_MAX_VALUE		1
+
+struct pl353_nfc_op {
+	u32 cmnds[4];
+	u32 thirdrow;
+	u32 type;
+	u32 end_cmd;
+	u32 addrs;
+	u32 len;
+	u32 naddrs;
+	u32 addr5;
+	u32 addr6;
+	unsigned int data_instr_idx;
+	unsigned int rdy_timeout_ms;
+	unsigned int rdy_delay_ns;
+	unsigned int cle_ale_delay_ns;
+	const struct nand_op_instr *data_instr;
+};
+
+/**
+ * struct pl353_nand_info - Defines the NAND flash driver instance
+ * @chip:		NAND chip information structure
+ * @dev:		Parent device (used to print error messages)
+ * @nand_base:		Virtual address of the NAND flash device
+ * @nandaddr:		Virtual address of the NAND flash device for
+ *			data read/writes
+ * @addr_cycles:	Address cycles
+ * @mclk:		Memory controller clock
+ */
+struct pl353_nand_info {
+	struct nand_chip chip;
+	struct device *dev;
+	void __iomem *nand_base;
+	void __iomem *nandaddr;
+	u8 addr_cycles;
+	struct clk *mclk;
+};
+
+static int pl353_ecc_ooblayout16_ecc(struct mtd_info *mtd, int section,
+				     struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobregion->offset = (section * chip->ecc.bytes);
+	oobregion->length = chip->ecc.bytes;
+
+	return 0;
+}
+
+static int pl353_ecc_ooblayout16_free(struct mtd_info *mtd, int section,
+				      struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobregion->offset = (section * chip->ecc.bytes) + 8;
+	oobregion->length = 8;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops pl353_ecc_ooblayout16_ops = {
+	.ecc = pl353_ecc_ooblayout16_ecc,
+	.free = pl353_ecc_ooblayout16_free,
+};
+
+static int pl353_ecc_ooblayout64_ecc(struct mtd_info *mtd, int section,
+				     struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobregion->offset = (section * chip->ecc.bytes) + 52;
+	oobregion->length = chip->ecc.bytes;
+
+	return 0;
+}
+
+static int pl353_ecc_ooblayout64_free(struct mtd_info *mtd, int section,
+				      struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section)
+		return -ERANGE;
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobregion->offset = (section * chip->ecc.bytes) + 2;
+	oobregion->length = 50;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops pl353_ecc_ooblayout64_ops = {
+	.ecc = pl353_ecc_ooblayout64_ecc,
+	.free = pl353_ecc_ooblayout64_free,
+};
+
+/* Generic flash bbt decriptors */
+static u8 bbt_pattern[] = { 'B', 'b', 't', '0' };
+static u8 mirror_pattern[] = { '1', 't', 'b', 'B' };
+
+static struct nand_bbt_descr bbt_main_descr = {
+	.options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE
+		| NAND_BBT_2BIT | NAND_BBT_VERSION | NAND_BBT_PERCHIP,
+	.offs = 4,
+	.len = 4,
+	.veroffs = 20,
+	.maxblocks = 4,
+	.pattern = bbt_pattern
+};
+
+static struct nand_bbt_descr bbt_mirror_descr = {
+	.options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE
+		| NAND_BBT_2BIT | NAND_BBT_VERSION | NAND_BBT_PERCHIP,
+	.offs = 4,
+	.len = 4,
+	.veroffs = 20,
+	.maxblocks = 4,
+	.pattern = mirror_pattern
+};
+
+/**
+ * pl353_nand_read_data_op - read chip data into buffer
+ * @chip:	Pointer to the NAND chip info structure
+ * @in:		Pointer to the buffer to store read data
+ * @len:	Number of bytes to read
+ * Return:	Always return zero
+ */
+static int pl353_nand_read_data_op(struct nand_chip *chip,
+				   u8 *in,
+				   unsigned int len)
+{
+	int i;
+	struct pl353_nand_info *xnfc =
+		container_of(chip, struct pl353_nand_info, chip);
+
+	if (IS_ALIGNED((uint32_t)in, sizeof(uint32_t)) &&
+	    IS_ALIGNED(len, sizeof(uint32_t))) {
+		u32 *ptr = (u32 *)in;
+
+		len /= 4;
+		for (i = 0; i < len; i++)
+			ptr[i] = readl(xnfc->nandaddr);
+	} else {
+		for (i = 0; i < len; i++)
+			in[i] = readb(xnfc->nandaddr);
+	}
+
+	return 0;
+}
+
+/**
+ * pl353_nand_write_buf - write buffer to chip
+ * @mtd:	Pointer to the mtd info structure
+ * @buf:	Pointer to the buffer to store write data
+ * @len:	Number of bytes to write
+ */
+static void pl353_nand_write_data_op(struct mtd_info *mtd, const u8 *buf,
+				     int len)
+{
+	int i;
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct pl353_nand_info *xnfc =
+		container_of(chip, struct pl353_nand_info, chip);
+
+	if (IS_ALIGNED((uint32_t)buf, sizeof(uint32_t)) &&
+	    IS_ALIGNED(len, sizeof(uint32_t))) {
+		u32 *ptr = (u32 *)buf;
+
+		len /= 4;
+		for (i = 0; i < len; i++)
+			writel(ptr[i], xnfc->nandaddr);
+	} else {
+		for (i = 0; i < len; i++)
+			writeb(buf[i], xnfc->nandaddr);
+	}
+}
+
+/**
+ * pl353_nand_calculate_hwecc - Calculate Hardware ECC
+ * @mtd:	Pointer to the mtd_info structure
+ * @data:	Pointer to the page data
+ * @ecc:	Pointer to the ECC buffer where ECC data needs to be stored
+ *
+ * This function retrieves the Hardware ECC data from the controller and returns
+ * ECC data back to the MTD subsystem.
+ * It operates on a number of 512 byte blocks of NAND memory and can be
+ * programmed to store the ECC codes after the data in memory. For writes,
+ * the ECC is written to the spare area of the page. For reads, the result of
+ * a block ECC check are made available to the device driver.
+ *
+ * ------------------------------------------------------------------------
+ * |               n * 512 blocks                  | extra  | ecc    |     |
+ * |                                               | block  | codes  |     |
+ * ------------------------------------------------------------------------
+ *
+ * The ECC calculation uses a simple Hamming code, using 1-bit correction 2-bit
+ * detection. It starts when a valid read or write command with a 512 byte
+ * aligned address is detected on the memory interface.
+ *
+ * Return:	0 on success or error value on failure
+ */
+static int pl353_nand_calculate_hwecc(struct mtd_info *mtd,
+				      const u8 *data, u8 *ecc)
+{
+	u32 ecc_value;
+	u8 ecc_reg, ecc_byte, ecc_status;
+	unsigned long timeout = jiffies + PL353_NAND_ECC_BUSY_TIMEOUT;
+
+	/* Wait till the ECC operation is complete or timeout */
+	do {
+		if (pl353_smc_ecc_is_busy())
+			cpu_relax();
+		else
+			break;
+	} while (!time_after_eq(jiffies, timeout));
+
+	if (time_after_eq(jiffies, timeout)) {
+		pr_err("%s timed out\n", __func__);
+		return -ETIMEDOUT;
+	}
+
+	for (ecc_reg = 0; ecc_reg < 4; ecc_reg++) {
+		/* Read ECC value for each block */
+		ecc_value = pl353_smc_get_ecc_val(ecc_reg);
+		ecc_status = (ecc_value >> PL353_NAND_ECC_VALID_SHIFT);
+		/* ECC value valid */
+		if (ecc_status & PL353_NAND_ECC_VALID_MASK) {
+			for (ecc_byte = 0; ecc_byte < 3; ecc_byte++) {
+				/* Copy ECC bytes to MTD buffer */
+				*ecc = ~ecc_value & 0xFF;
+				ecc_value = ecc_value >> 8;
+				ecc++;
+			}
+		} else {
+			pr_warn("%s status failed\n", __func__);
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * pl353_nand_correct_data - ECC correction function
+ * @mtd:	Pointer to the mtd_info structure
+ * @buf:	Pointer to the page data
+ * @read_ecc:	Pointer to the ECC value read from spare data area
+ * @calc_ecc:	Pointer to the calculated ECC value
+ *
+ * This function corrects the ECC single bit errors & detects 2-bit errors.
+ *
+ * Return:	0 if no ECC errors found
+ *		1 if single bit error found and corrected.
+ *		-1 if multiple uncorrectable ECC errors found.
+ */
+static int pl353_nand_correct_data(struct mtd_info *mtd, unsigned char *buf,
+				   unsigned char *read_ecc,
+				   unsigned char *calc_ecc)
+{
+	unsigned char bit_addr;
+	unsigned int byte_addr;
+	unsigned short ecc_odd, ecc_even, read_ecc_lower, read_ecc_upper;
+	unsigned short calc_ecc_lower, calc_ecc_upper;
+
+	read_ecc_lower = (read_ecc[0] | (read_ecc[1] << 8)) &
+			  PL353_ECC_BIT_MASK;
+	read_ecc_upper = ((read_ecc[1] >> 4) | (read_ecc[2] << 4)) &
+			  PL353_ECC_BIT_MASK;
+
+	calc_ecc_lower = (calc_ecc[0] | (calc_ecc[1] << 8)) &
+			  PL353_ECC_BIT_MASK;
+	calc_ecc_upper = ((calc_ecc[1] >> 4) | (calc_ecc[2] << 4)) &
+			  PL353_ECC_BIT_MASK;
+
+	ecc_odd = read_ecc_lower ^ calc_ecc_lower;
+	ecc_even = read_ecc_upper ^ calc_ecc_upper;
+
+	/* no error */
+	if (!ecc_odd && !ecc_even)
+		return 0;
+
+	if (ecc_odd == (~ecc_even & PL353_ECC_BIT_MASK)) {
+		/* bits [11:3] of error code is byte offset */
+		byte_addr = (ecc_odd >> 3) & PL353_ECC_BITS_BYTEOFF_MASK;
+		/* bits [2:0] of error code is bit offset */
+		bit_addr = ecc_odd & PL353_ECC_BITS_BITOFF_MASK;
+		/* Toggling error bit */
+		buf[byte_addr] ^= (BIT(bit_addr));
+		return 1;
+	}
+
+	/* one error in parity */
+	if (hweight32(ecc_odd | ecc_even) == 1)
+		return 1;
+
+	/* Uncorrectable error */
+	return -1;
+}
+
+static void pl353_prepare_cmd(struct mtd_info *mtd, struct nand_chip *chip,
+			      int page, int column, int start_cmd, int end_cmd,
+			      bool read)
+{
+	unsigned long data_phase_addr;
+	u32 end_cmd_valid = 0;
+	unsigned long cmd_phase_addr = 0, cmd_data = 0;
+
+	struct pl353_nand_info *xnfc =
+		container_of(chip, struct pl353_nand_info, chip);
+
+	end_cmd_valid = read ? 1 : 0;
+
+	cmd_phase_addr = (unsigned long __force)xnfc->nand_base +
+			 ((xnfc->addr_cycles
+			 << ADDR_CYCLES_SHIFT) |
+			 (end_cmd_valid << END_CMD_VALID_SHIFT) |
+			 (COMMAND_PHASE) |
+			 (end_cmd << END_CMD_SHIFT) |
+			 (start_cmd << START_CMD_SHIFT));
+
+	/* Get the data phase address */
+	data_phase_addr = (unsigned long __force)xnfc->nand_base +
+			  ((0x0 << CLEAR_CS_SHIFT) |
+			  (0 << END_CMD_VALID_SHIFT) |
+			  (DATA_PHASE) |
+			  (end_cmd << END_CMD_SHIFT) |
+			  (0x0 << ECC_LAST_SHIFT));
+
+	xnfc->nandaddr = (void __iomem * __force)data_phase_addr;
+
+	if (chip->options & NAND_BUSWIDTH_16)
+		column /= 2;
+	cmd_data = column;
+	if (mtd->writesize > PL353_NAND_ECC_SIZE) {
+		cmd_data |= page << 16;
+		/* Another address cycle for devices > 128MiB */
+		if (chip->options & NAND_ROW_ADDR_3) {
+			writel_relaxed(cmd_data,
+				       (void __iomem * __force)cmd_phase_addr);
+			cmd_data = (page >> 16);
+		}
+	} else {
+		cmd_data |= page << 8;
+	}
+
+	writel_relaxed(cmd_data, (void __iomem * __force)cmd_phase_addr);
+}
+
+/**
+ * pl353_nand_read_oob - [REPLACEABLE] the most common OOB data read function
+ * @mtd:	Pointer to the mtd info structure
+ * @chip:	Pointer to the NAND chip info structure
+ * @page:	Page number to read
+ *
+ * Return:	Always return zero
+ */
+static int pl353_nand_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
+			       int page)
+{
+	unsigned long data_phase_addr;
+	u8 *p;
+	struct pl353_nand_info *xnfc =
+		container_of(chip, struct pl353_nand_info, chip);
+	unsigned long nand_offset = (unsigned long __force)xnfc->nand_base;
+
+	chip->pagebuf = -1;
+	if (mtd->writesize < PL353_NAND_ECC_SIZE)
+		return 0;
+
+	pl353_prepare_cmd(mtd, chip, page, mtd->writesize, NAND_CMD_READ0,
+			  NAND_CMD_READSTART, 1);
+
+	nand_wait_ready(mtd);
+
+	p = chip->oob_poi;
+	pl353_nand_read_data_op(chip, p,
+				(mtd->oobsize -
+				PL353_NAND_LAST_TRANSFER_LENGTH));
+	p += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+	data_phase_addr = (unsigned long __force)xnfc->nandaddr;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_CLEAR_CS;
+	data_phase_addr += nand_offset;
+	xnfc->nandaddr = (void __iomem * __force)data_phase_addr;
+	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	return 0;
+}
+
+/**
+ * pl353_nand_write_oob - [REPLACEABLE] the most common OOB data write function
+ * @mtd:	Pointer to the mtd info structure
+ * @chip:	Pointer to the NAND chip info structure
+ * @page:	Page number to write
+ *
+ * Return:	Zero on success and EIO on failure
+ */
+static int pl353_nand_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
+				int page)
+{
+	const u8 *buf = chip->oob_poi;
+	unsigned long data_phase_addr;
+	struct pl353_nand_info *xnfc =
+		container_of(chip, struct pl353_nand_info, chip);
+	unsigned long nand_offset = (unsigned long __force)xnfc->nand_base;
+	u32 addrcycles = 0;
+
+	chip->pagebuf = -1;
+	addrcycles = xnfc->addr_cycles;
+	pl353_prepare_cmd(mtd, chip, page, mtd->writesize, NAND_CMD_SEQIN,
+			  NAND_CMD_PAGEPROG, 0);
+
+	pl353_nand_write_data_op(mtd, buf,
+				 (mtd->oobsize -
+				 PL353_NAND_LAST_TRANSFER_LENGTH));
+	buf += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	data_phase_addr = (unsigned long __force)xnfc->nandaddr;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_CLEAR_CS;
+	data_phase_addr |= (1 << END_CMD_VALID_SHIFT);
+	data_phase_addr += nand_offset;
+	xnfc->nandaddr = (void __iomem * __force)data_phase_addr;
+	pl353_nand_write_data_op(mtd, buf, PL353_NAND_LAST_TRANSFER_LENGTH);
+	nand_wait_ready(mtd);
+
+	return 0;
+}
+
+/**
+ * pl353_nand_read_page_raw - [Intern] read raw page data without ecc
+ * @mtd:		Pointer to the mtd info structure
+ * @chip:		Pointer to the NAND chip info structure
+ * @buf:		Pointer to the data buffer
+ * @oob_required:	Caller requires OOB data read to chip->oob_poi
+ * @page:		Page number to read
+ *
+ * Return:	Always return zero
+ */
+static int pl353_nand_read_page_raw(struct mtd_info *mtd,
+				    struct nand_chip *chip,
+				    u8 *buf, int oob_required, int page)
+{
+	unsigned long data_phase_addr;
+	u8 *p;
+	struct pl353_nand_info *xnfc =
+		container_of(chip, struct pl353_nand_info, chip);
+	unsigned long nand_offset = (unsigned long __force)xnfc->nand_base;
+
+	pl353_nand_read_data_op(chip, buf, mtd->writesize);
+	p = chip->oob_poi;
+	pl353_nand_read_data_op(chip, p,
+				(mtd->oobsize -
+				PL353_NAND_LAST_TRANSFER_LENGTH));
+	p += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	data_phase_addr = (unsigned long __force)xnfc->nandaddr;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_CLEAR_CS;
+	data_phase_addr += nand_offset;
+	xnfc->nandaddr = (void __iomem * __force)data_phase_addr;
+
+	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	return 0;
+}
+
+/**
+ * pl353_nand_write_page_raw - [Intern] raw page write function
+ * @mtd:		Pointer to the mtd info structure
+ * @chip:		Pointer to the NAND chip info structure
+ * @buf:		Pointer to the data buffer
+ * @oob_required:	Caller requires OOB data read to chip->oob_poi
+ * @page:		Page number to write
+ *
+ * Return:	Always return zero
+ */
+static int pl353_nand_write_page_raw(struct mtd_info *mtd,
+				     struct nand_chip *chip,
+				     const u8 *buf, int oob_required,
+				     int page)
+{
+	unsigned long data_phase_addr;
+	u8 *p;
+
+	struct pl353_nand_info *xnfc =
+		container_of(chip, struct pl353_nand_info, chip);
+	unsigned long nand_offset = (unsigned long __force)xnfc->nand_base;
+
+	pl353_nand_write_data_op(mtd, buf, mtd->writesize);
+	p = chip->oob_poi;
+	pl353_nand_write_data_op(mtd, p,
+				 (mtd->oobsize -
+				 PL353_NAND_LAST_TRANSFER_LENGTH));
+	p += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	data_phase_addr = (unsigned long __force)xnfc->nandaddr;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_CLEAR_CS;
+	data_phase_addr |= (1 << END_CMD_VALID_SHIFT);
+	data_phase_addr += nand_offset;
+	xnfc->nandaddr = (void __iomem * __force)data_phase_addr;
+	pl353_nand_write_data_op(mtd, p, PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	return 0;
+}
+
+/**
+ * nand_write_page_hwecc - Hardware ECC based page write function
+ * @mtd:		Pointer to the mtd info structure
+ * @chip:		Pointer to the NAND chip info structure
+ * @buf:		Pointer to the data buffer
+ * @oob_required:	Caller requires OOB data read to chip->oob_poi
+ * @page:		Page number to write
+ *
+ * This functions writes data and hardware generated ECC values in to the page.
+ *
+ * Return:	Always return zero
+ */
+static int pl353_nand_write_page_hwecc(struct mtd_info *mtd,
+				       struct nand_chip *chip,
+				       const u8 *buf, int oob_required,
+				       int page)
+{
+	int eccsize = chip->ecc.size;
+	int eccsteps = chip->ecc.steps;
+	u8 *ecc_calc = chip->ecc.calc_buf;
+	u8 *oob_ptr;
+	const u8 *p = buf;
+	u32 ret;
+	unsigned long data_phase_addr;
+	struct pl353_nand_info *xnfc =
+		container_of(chip, struct pl353_nand_info, chip);
+	unsigned long nand_offset = (unsigned long __force)xnfc->nand_base;
+
+	pl353_prepare_cmd(mtd, chip, page, 0, NAND_CMD_SEQIN,
+			  NAND_CMD_PAGEPROG, 0);
+
+	for ( ; (eccsteps - 1); eccsteps--) {
+		pl353_nand_write_data_op(mtd, p, eccsize);
+		p += eccsize;
+	}
+	pl353_nand_write_data_op(mtd, p,
+				 (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH));
+	p += (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	/* Set ECC Last bit to 1 */
+	data_phase_addr = (unsigned long __force)xnfc->nandaddr;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_ECC_LAST;
+	data_phase_addr += nand_offset;
+	xnfc->nandaddr = (void __iomem * __force)data_phase_addr;
+	pl353_nand_write_data_op(mtd, p, PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	p = buf;
+	chip->ecc.calculate(mtd, p, &ecc_calc[0]);
+
+	/* Wait for ECC to be calculated and read the error values */
+	ret = mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi,
+					 0, chip->ecc.total);
+	if (ret)
+		return ret;
+	/* Clear ECC last bit */
+	data_phase_addr = (unsigned long __force)xnfc->nandaddr;
+	data_phase_addr -= nand_offset;
+	data_phase_addr &= ~PL353_NAND_ECC_LAST;
+	data_phase_addr += nand_offset;
+	xnfc->nandaddr = (void __iomem * __force)data_phase_addr;
+
+	/* Write the spare area with ECC bytes */
+	oob_ptr = chip->oob_poi;
+	pl353_nand_write_data_op(mtd, oob_ptr,
+				 (mtd->oobsize -
+				 PL353_NAND_LAST_TRANSFER_LENGTH));
+
+	data_phase_addr = (unsigned long __force)xnfc->nandaddr;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_CLEAR_CS;
+	data_phase_addr |= (1 << END_CMD_VALID_SHIFT);
+	data_phase_addr += nand_offset;
+	xnfc->nandaddr = (void __iomem * __force)data_phase_addr;
+	oob_ptr += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+	pl353_nand_write_data_op(mtd, oob_ptr, PL353_NAND_LAST_TRANSFER_LENGTH);
+	nand_wait_ready(mtd);
+
+	return 0;
+}
+
+/**
+ * pl353_nand_read_page_hwecc - Hardware ECC based page read function
+ * @mtd:		Pointer to the mtd info structure
+ * @chip:		Pointer to the NAND chip info structure
+ * @buf:		Pointer to the buffer to store read data
+ * @oob_required:	Caller requires OOB data read to chip->oob_poi
+ * @page:		Page number to read
+ *
+ * This functions reads data and checks the data integrity by comparing
+ * hardware generated ECC values and read ECC values from spare area.
+ * There is a limitation in SMC controller, that we must set ECC LAST on
+ * last data phase access, to tell ECC block not to expect any data further.
+ * Ex:  When number of ECC STEPS are 4, then till 3 we will write to flash
+ * using SMC with HW ECC enabled. And for the last ECC STEP, we will subtract
+ * 4bytes from page size, and will initiate a transfer. And the remaining 4 as
+ * one more transfer with ECC_LAST bit set in NAND data phase register to
+ * notify ECC block not to expect any more data. The last block should be align
+ * with end of 512 byte block. Because of this limitation, we are not using
+ * core routines.
+ *
+ * Return:	0 always and updates ECC operation status in to MTD structure
+ */
+static int pl353_nand_read_page_hwecc(struct mtd_info *mtd,
+				      struct nand_chip *chip,
+				      u8 *buf, int oob_required, int page)
+{
+	int i, stat, eccsize = chip->ecc.size;
+	int eccbytes = chip->ecc.bytes;
+	int eccsteps = chip->ecc.steps;
+	u8 *p = buf;
+	u8 *ecc_calc = chip->ecc.calc_buf;
+	u8 *ecc = chip->ecc.code_buf;
+	unsigned int max_bitflips = 0;
+	u8 *oob_ptr;
+	u32 ret;
+	unsigned long data_phase_addr;
+	struct pl353_nand_info *xnfc =
+		container_of(chip, struct pl353_nand_info, chip);
+	unsigned long nand_offset = (unsigned long __force)xnfc->nand_base;
+
+	pl353_prepare_cmd(mtd, chip, page, 0, NAND_CMD_READ0,
+			  NAND_CMD_READSTART, 1);
+	nand_wait_ready(mtd);
+
+	for ( ; (eccsteps - 1); eccsteps--) {
+		pl353_nand_read_data_op(chip, p, eccsize);
+		p += eccsize;
+	}
+	pl353_nand_read_data_op(chip, p,
+				(eccsize - PL353_NAND_LAST_TRANSFER_LENGTH));
+	p += (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	/* Set ECC Last bit to 1 */
+	data_phase_addr = (unsigned long __force)xnfc->nandaddr;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_ECC_LAST;
+	data_phase_addr += nand_offset;
+	xnfc->nandaddr = (void __iomem * __force)data_phase_addr;
+	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	/* Read the calculated ECC value */
+	p = buf;
+	chip->ecc.calculate(mtd, p, &ecc_calc[0]);
+
+	/* Clear ECC last bit */
+	data_phase_addr = (unsigned long __force)xnfc->nandaddr;
+	data_phase_addr -= nand_offset;
+	data_phase_addr &= ~PL353_NAND_ECC_LAST;
+	data_phase_addr += nand_offset;
+	xnfc->nandaddr = (void __iomem * __force)data_phase_addr;
+
+	/* Read the stored ECC value */
+	oob_ptr = chip->oob_poi;
+	pl353_nand_read_data_op(chip, oob_ptr,
+				(mtd->oobsize -
+				PL353_NAND_LAST_TRANSFER_LENGTH));
+
+	/* de-assert chip select */
+	data_phase_addr = (unsigned long __force)xnfc->nandaddr;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_CLEAR_CS;
+	data_phase_addr += nand_offset;
+	xnfc->nandaddr = (void __iomem * __force)data_phase_addr;
+
+	oob_ptr += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+	pl353_nand_read_data_op(chip, oob_ptr, PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	ret = mtd_ooblayout_get_eccbytes(mtd, ecc, chip->oob_poi, 0,
+					 chip->ecc.total);
+	if (ret)
+		return ret;
+
+	eccsteps = chip->ecc.steps;
+	p = buf;
+
+	/* Check ECC error for all blocks and correct if it is correctable */
+	for (i = 0 ; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
+		stat = chip->ecc.correct(mtd, p, &ecc[i], &ecc_calc[i]);
+		if (stat < 0) {
+			mtd->ecc_stats.failed++;
+		} else {
+			mtd->ecc_stats.corrected += stat;
+			max_bitflips = max_t(unsigned int, max_bitflips, stat);
+		}
+	}
+
+	return max_bitflips;
+}
+
+/**
+ * pl353_nand_select_chip - Select the flash device
+ * @mtd:	Pointer to the mtd info structure
+ * @chip:	Pointer to the NAND chip info structure
+ *
+ * This function is empty as the NAND controller handles chip select line
+ * internally based on the chip address passed in command and data phase.
+ */
+static void pl353_nand_select_chip(struct mtd_info *mtd, int chip)
+{
+}
+
+/* NAND framework ->exec_op() hooks and related helpers */
+static void pl353_nfc_parse_instructions(struct nand_chip *chip,
+					 const struct nand_subop *subop,
+					 struct pl353_nfc_op *nfc_op)
+{
+	const struct nand_op_instr *instr = NULL;
+	unsigned int op_id, offset, naddrs;
+	int i, len;
+	const u8 *addrs;
+
+	memset(nfc_op, 0, sizeof(struct pl353_nfc_op));
+	for (op_id = 0; op_id < subop->ninstrs; op_id++) {
+		nfc_op->len = nand_subop_get_data_len(subop, op_id);
+		len = nand_subop_get_data_len(subop, op_id);
+		instr = &subop->instrs[op_id];
+
+		switch (instr->type) {
+		case NAND_OP_CMD_INSTR:
+			nfc_op->type = NAND_OP_CMD_INSTR;
+			if (op_id)
+				nfc_op->cmnds[1] = instr->ctx.cmd.opcode;
+			else
+				nfc_op->cmnds[0] = instr->ctx.cmd.opcode;
+			nfc_op->cle_ale_delay_ns = instr->delay_ns;
+			break;
+
+		case NAND_OP_ADDR_INSTR:
+			offset = nand_subop_get_addr_start_off(subop, op_id);
+			naddrs = nand_subop_get_num_addr_cyc(subop, op_id);
+			addrs = &instr->ctx.addr.addrs[offset];
+			nfc_op->addrs = instr->ctx.addr.addrs[offset];
+			for (i = 0; i < min_t(unsigned int, 4, naddrs); i++) {
+				nfc_op->addrs |= instr->ctx.addr.addrs[i] <<
+						 (8 * i);
+			}
+
+			if (naddrs >= 5)
+				nfc_op->addr5 = addrs[4];
+			if (naddrs >= 6)
+				nfc_op->addr6 = addrs[5];
+			nfc_op->naddrs = nand_subop_get_num_addr_cyc(subop,
+								     op_id);
+			nfc_op->cle_ale_delay_ns = instr->delay_ns;
+			break;
+
+		case NAND_OP_DATA_IN_INSTR:
+			nfc_op->data_instr = instr;
+			nfc_op->type = NAND_OP_DATA_IN_INSTR;
+			nfc_op->data_instr_idx = op_id;
+			break;
+
+		case NAND_OP_DATA_OUT_INSTR:
+			nfc_op->data_instr = instr;
+			nfc_op->type = NAND_OP_DATA_IN_INSTR;
+			nfc_op->data_instr_idx = op_id;
+			break;
+
+		case NAND_OP_WAITRDY_INSTR:
+			nfc_op->rdy_timeout_ms = instr->ctx.waitrdy.timeout_ms;
+			nfc_op->rdy_delay_ns = instr->delay_ns;
+			break;
+		}
+	}
+}
+
+static void cond_delay(unsigned int ns)
+{
+	if (!ns)
+		return;
+
+	if (ns < 10000)
+		ndelay(ns);
+	else
+		udelay(DIV_ROUND_UP(ns, 1000));
+}
+
+/**
+ * pl353_nand_cmd_function - Send command to NAND device
+ * @chip:	Pointer to the NAND chip info structure
+ * @subop:	Pointer to array of instructions
+ * Return:	Always return zero
+ */
+static int pl353_nand_cmd_function(struct nand_chip *chip,
+				   const struct nand_subop *subop)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	const struct nand_op_instr *instr;
+	struct pl353_nfc_op nfc_op = {};
+	struct pl353_nand_info *xnfc =
+		container_of(chip, struct pl353_nand_info, chip);
+	unsigned long cmd_data = 0, end_cmd_valid = 0;
+	unsigned long cmd_phase_addr, data_phase_addr, end_cmd;
+	unsigned int op_id, len, offset;
+	bool reading;
+
+	pl353_nfc_parse_instructions(chip, subop, &nfc_op);
+	instr = nfc_op.data_instr;
+	op_id = nfc_op.data_instr_idx;
+	len = nand_subop_get_data_len(subop, op_id);
+	offset = nand_subop_get_data_start_off(subop, op_id);
+
+	pl353_smc_clr_nand_int();
+	/* Get the command phase address */
+	if (nfc_op.cmnds[1] != 0) {
+		if (nfc_op.cmnds[0] == NAND_CMD_SEQIN)
+			end_cmd_valid = 0;
+		else
+			end_cmd_valid = 1;
+		end_cmd = nfc_op.cmnds[1];
+	}  else {
+		end_cmd = 0x0;
+	}
+
+	/*
+	 * The SMC defines two phases of commands when transferring data to or
+	 * from NAND flash.
+	 * Command phase: Commands and optional address information are written
+	 * to the NAND flash.The command and address can be associated with
+	 * either a data phase operation to write to or read from the array,
+	 * or a status/ID register transfer.
+	 * Data phase: Data is either written to or read from the NAND flash.
+	 * This data can be either data transferred to or from the array,
+	 * or status/ID register information.
+	 */
+	cmd_phase_addr = (unsigned long __force)xnfc->nand_base +
+			 ((nfc_op.naddrs << ADDR_CYCLES_SHIFT) |
+			 (end_cmd_valid << END_CMD_VALID_SHIFT) |
+			 (COMMAND_PHASE) |
+			 (end_cmd << END_CMD_SHIFT) |
+			 (nfc_op.cmnds[0] << START_CMD_SHIFT));
+
+	/* Get the data phase address */
+	end_cmd_valid = 0;
+
+	data_phase_addr = (unsigned long __force)xnfc->nand_base +
+			  ((0x0 << CLEAR_CS_SHIFT) |
+			  (end_cmd_valid << END_CMD_VALID_SHIFT) |
+			  (DATA_PHASE) |
+			  (end_cmd << END_CMD_SHIFT) |
+			  (0x0 << ECC_LAST_SHIFT));
+	xnfc->nandaddr = (void __iomem * __force)data_phase_addr;
+
+	/* Command phase AXI Read & Write */
+	if (nfc_op.naddrs >= 5) {
+		if (mtd->writesize > PL353_NAND_ECC_SIZE) {
+			cmd_data = nfc_op.addrs;
+			/* Another address cycle for devices > 128MiB */
+			if (chip->options & NAND_ROW_ADDR_3) {
+				writel_relaxed(cmd_data,
+					       (void __iomem * __force)
+					       cmd_phase_addr);
+				cmd_data = nfc_op.addr5;
+				if (nfc_op.naddrs >= 6)
+					cmd_data |= (nfc_op.addr6 << 8);
+			}
+		}
+	}  else {
+		if (nfc_op.addrs != -1) {
+			int column = nfc_op.addrs;
+			/*
+			 * Change read/write column, read id etc
+			 * Adjust columns for 16 bit bus width
+			 */
+			if ((chip->options & NAND_BUSWIDTH_16) &&
+			    (nfc_op.cmnds[0] == NAND_CMD_READ0 ||
+				nfc_op.cmnds[0] == NAND_CMD_SEQIN ||
+				nfc_op.cmnds[0] == NAND_CMD_RNDOUT ||
+				nfc_op.cmnds[0] == NAND_CMD_RNDIN)) {
+				column >>= 1;
+			}
+			cmd_data = column;
+		}
+	}
+	writel_relaxed(cmd_data, (void __iomem * __force)cmd_phase_addr);
+
+	if (!nfc_op.data_instr) {
+		if (nfc_op.rdy_timeout_ms)
+			nand_wait_ready(mtd);
+		return 0;
+	}
+
+	reading = (nfc_op.data_instr->type == NAND_OP_DATA_IN_INSTR);
+	if (!reading) {
+		if (nfc_op.cmnds[0] == NAND_CMD_SEQIN &&
+		    nfc_op.cmnds[1] == NAND_CMD_PAGEPROG) {
+			pl353_nand_write_page_raw(mtd, chip,
+						  instr->ctx.data.buf.out, 0,
+						  nfc_op.addrs);
+
+		} else {
+			pl353_nand_write_data_op(mtd, instr->ctx.data.buf.out,
+						 len);
+		}
+		if (nfc_op.rdy_timeout_ms)
+			nand_wait_ready(mtd);
+		cond_delay(nfc_op.rdy_delay_ns);
+	}
+	if (reading) {
+		cond_delay(nfc_op.rdy_delay_ns);
+		if (nfc_op.rdy_timeout_ms)
+			nand_wait_ready(mtd);
+		pl353_nand_read_data_op(chip, instr->ctx.data.buf.in, len);
+	}
+
+	return 0;
+}
+
+static const struct nand_op_parser pl353_nfc_op_parser = NAND_OP_PARSER
+	(NAND_OP_PARSER_PATTERN
+		(pl353_nand_cmd_function,
+		NAND_OP_PARSER_PAT_CMD_ELEM(true),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(true, 7),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
+		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 2048)),
+	NAND_OP_PARSER_PATTERN
+		(pl353_nand_cmd_function,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 7),
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false),
+		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 2048)),
+	NAND_OP_PARSER_PATTERN
+		(pl353_nand_cmd_function,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(true, 7),
+		NAND_OP_PARSER_PAT_CMD_ELEM(true),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
+	NAND_OP_PARSER_PATTERN
+		(pl353_nand_cmd_function,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 8),
+		NAND_OP_PARSER_PAT_DATA_OUT_ELEM(false, 2048),
+		NAND_OP_PARSER_PAT_CMD_ELEM(true),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true)),
+	NAND_OP_PARSER_PATTERN
+		(pl353_nand_cmd_function,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false)),
+	);
+
+static int pl353_nfc_exec_op(struct nand_chip *chip,
+			     const struct nand_operation *op,
+			     bool check_only)
+{
+	return nand_op_parser_exec_op(chip, &pl353_nfc_op_parser,
+					      op, check_only);
+}
+
+/**
+ * pl353_nand_device_ready - Check device ready/busy line
+ * @mtd:	Pointer to the mtd_info structure
+ *
+ * Return:	0 on busy or 1 on ready state
+ */
+static int pl353_nand_device_ready(struct mtd_info *mtd)
+{
+	if (pl353_smc_get_nand_int_status_raw()) {
+		pl353_smc_clr_nand_int();
+		return 1;
+	}
+
+	return 0;
+}
+
+/**
+ * pl353_nand_ecc_init - Initialize the ecc information as per the ecc mode
+ * @mtd:	Pointer to the mtd_info structure
+ * @ecc:	Pointer to ECC control structure
+ * @ecc_mode:	ondie ecc status
+ *
+ * This function initializes the ecc block and functional pointers as per the
+ * ecc mode
+ *
+ * Return:	0 on success or negative errno.
+ */
+static int pl353_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc,
+				int ecc_mode)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct pl353_nand_info *xnfc =
+		container_of(chip, struct pl353_nand_info, chip);
+	int err = 0;
+
+	if (ecc_mode == NAND_ECC_ON_DIE) {
+		pl353_smc_set_ecc_mode(PL353_SMC_ECCMODE_BYPASS);
+		/*
+		 * On-Die ECC spare bytes offset 8 is used for ECC codes
+		 * Use the BBT pattern descriptors
+		 */
+		chip->bbt_td = &bbt_main_descr;
+		chip->bbt_md = &bbt_mirror_descr;
+		bitmap_set(chip->parameters.get_feature_list,
+			   ONFI_FEATURE_ON_DIE_ECC, ONFI_FEATURE_ON_DIE_ECC_EN);
+		bitmap_set(chip->parameters.set_feature_list,
+			   ONFI_FEATURE_ON_DIE_ECC, ONFI_FEATURE_ON_DIE_ECC_EN);
+	} else {
+		ecc->read_oob = pl353_nand_read_oob;
+		ecc->write_oob = pl353_nand_write_oob;
+
+		ecc->mode = NAND_ECC_HW;
+		/* Hardware ECC generates 3 bytes ECC code for each 512 bytes */
+		ecc->bytes = 3;
+		ecc->strength = 1;
+		ecc->calculate = pl353_nand_calculate_hwecc;
+		ecc->correct = pl353_nand_correct_data;
+		ecc->read_page = pl353_nand_read_page_hwecc;
+		ecc->size = PL353_NAND_ECC_SIZE;
+		ecc->write_page = pl353_nand_write_page_hwecc;
+		pl353_smc_set_ecc_pg_size(mtd->writesize);
+		switch (mtd->writesize) {
+		case SZ_512:
+		case SZ_1K:
+		case SZ_2K:
+			pl353_smc_set_ecc_mode(PL353_SMC_ECCMODE_APB);
+			break;
+		default:
+			ecc->calculate = nand_calculate_ecc;
+			ecc->correct = nand_correct_data;
+			ecc->size = 256;
+			break;
+		}
+		if (mtd->writesize <= SZ_512)
+			xnfc->addr_cycles = 1;
+		else
+			xnfc->addr_cycles = 2;
+
+		if (chip->options & NAND_ROW_ADDR_3)
+			xnfc->addr_cycles += 3;
+		else
+			xnfc->addr_cycles += 2;
+
+		if (mtd->oobsize == 16) {
+			mtd_set_ooblayout(mtd, &pl353_ecc_ooblayout16_ops);
+		} else if (mtd->oobsize == 64) {
+			mtd_set_ooblayout(mtd, &pl353_ecc_ooblayout64_ops);
+		} else {
+			err = -ENXIO;
+			dev_err(xnfc->dev, "Unsupported oob Layout\n");
+		}
+	}
+	return err;
+}
+
+static int pl353_setup_data_interface(struct mtd_info *mtd, int csline,
+				       const struct nand_data_interface *conf)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct pl353_nand_info *xnfc =
+		container_of(chip, struct pl353_nand_info, chip);
+	const struct nand_sdr_timings *sdr;
+	u32 timings[7], mckperiodps;
+
+	sdr = nand_get_sdr_timings(conf);
+	if (IS_ERR(sdr))
+		return PTR_ERR(sdr);
+
+	/*
+	 * SDR timings are given in pico-seconds while NFC timings must be
+	 * expressed in NAND controller clock cycles.
+	 */
+	mckperiodps = NSEC_PER_SEC / clk_get_rate(xnfc->mclk);
+	mckperiodps *= 1000;
+	if (sdr->tRC_min <= 20000)
+		/*
+		 * PL353 SMC needs one extra read cycle in SDR Mode 5
+		 * This is not written anywhere in the datasheet but
+		 * the results observed during testing.
+		 */
+		timings[0] = DIV_ROUND_UP(sdr->tRC_min, mckperiodps) + 1;
+	else
+		timings[0] = DIV_ROUND_UP(sdr->tRC_min, mckperiodps);
+
+	timings[1] = DIV_ROUND_UP(sdr->tWC_min, mckperiodps);
+	/*
+	 * For all SDR modes, PL353 SMC needs tREA max value as 1
+	 * These results observed during testing.
+	 */
+	timings[2] = PL353_TREA_MAX_VALUE;
+	timings[3] = DIV_ROUND_UP(sdr->tWP_min, mckperiodps);
+	timings[4] = DIV_ROUND_UP(sdr->tCLR_min, mckperiodps);
+	timings[5] = DIV_ROUND_UP(sdr->tAR_min, mckperiodps);
+	timings[6] = DIV_ROUND_UP(sdr->tRR_min, mckperiodps);
+
+	if (csline == NAND_DATA_IFACE_CHECK_ONLY)
+		return 0;
+
+	pl353_smc_set_cycles(timings);
+
+	return 0;
+}
+/**
+ * pl353_nand_probe - Probe method for the NAND driver
+ * @pdev:	Pointer to the platform_device structure
+ *
+ * This function initializes the driver data structures and the hardware.
+ * The NAND driver has dependency with the pl353_smc memory controller
+ * driver for initializing the NAND timing parameters, bus width, ECC modes,
+ * control and status information.
+ *
+ * Return:	0 on success or error value on failure
+ */
+static int pl353_nand_probe(struct platform_device *pdev)
+{
+	struct pl353_nand_info *xnfc;
+	struct mtd_info *mtd;
+	struct nand_chip *chip;
+	struct resource *res;
+	struct device_node *np;
+	u32 ret;
+
+	xnfc = devm_kzalloc(&pdev->dev, sizeof(*xnfc), GFP_KERNEL);
+	if (!xnfc)
+		return -ENOMEM;
+	xnfc->dev = &pdev->dev;
+	/* Map physical address of NAND flash */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	xnfc->nand_base = devm_ioremap_resource(xnfc->dev, res);
+	if (IS_ERR(xnfc->nand_base))
+		return PTR_ERR(xnfc->nand_base);
+
+	chip = &xnfc->chip;
+	mtd = nand_to_mtd(chip);
+	chip->exec_op = pl353_nfc_exec_op;
+	nand_set_controller_data(chip, xnfc);
+	mtd->priv = chip;
+	mtd->owner = THIS_MODULE;
+	if (!mtd->name) {
+		/*
+		 * If the new bindings are used and the bootloader has not been
+		 * updated to pass a new mtdparts parameter on the cmdline, you
+		 * should define the following property in your NAND node, ie:
+		 *
+		 *	label = "pl353-nand";
+		 *
+		 * This way, mtd->name will be set by the core when
+		 * nand_set_flash_node() is called.
+		 */
+		mtd->name = devm_kasprintf(xnfc->dev, GFP_KERNEL,
+					   "%s", PL353_NAND_DRIVER_NAME);
+		if (!mtd->name) {
+			dev_err(xnfc->dev, "Failed to allocate mtd->name\n");
+			return -ENOMEM;
+		}
+	}
+	nand_set_flash_node(chip, xnfc->dev->of_node);
+
+	/* Set the driver entry points for MTD */
+	chip->dev_ready = pl353_nand_device_ready;
+	chip->select_chip = pl353_nand_select_chip;
+	/* If we don't set this delay driver sets 20us by default */
+	np = of_get_next_parent(xnfc->dev->of_node);
+	xnfc->mclk = of_clk_get(np, 0);
+	if (IS_ERR(xnfc->mclk)) {
+		dev_err(xnfc->dev, "Failed to retrieve MCK clk\n");
+		return PTR_ERR(xnfc->mclk);
+	}
+	chip->chip_delay = 30;
+	/* Set the device option and flash width */
+	chip->options = NAND_BUSWIDTH_AUTO;
+	chip->bbt_options = NAND_BBT_USE_FLASH;
+	platform_set_drvdata(pdev, xnfc);
+	chip->setup_data_interface = pl353_setup_data_interface;
+	/* first scan to find the device and get the page size */
+	if (nand_scan_ident(mtd, 1, NULL)) {
+		dev_err(xnfc->dev, "nand_scan_ident for NAND failed\n");
+		return -ENXIO;
+	}
+	ret = pl353_nand_ecc_init(mtd, &chip->ecc, chip->ecc.mode);
+	if (chip->options & NAND_BUSWIDTH_16)
+		pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_16);
+	/* second phase scan */
+	if (nand_scan_tail(mtd)) {
+		dev_err(xnfc->dev, "nand_scan_tail for NAND failed\n");
+		return -ENXIO;
+	}
+
+	ret = mtd_device_register(mtd, NULL, 0);
+	if (ret) {
+		dev_err(xnfc->dev, "Failed to register mtd device: %d\n", ret);
+		nand_cleanup(chip);
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * pl353_nand_remove - Remove method for the NAND driver
+ * @pdev:	Pointer to the platform_device structure
+ *
+ * This function is called if the driver module is being unloaded. It frees all
+ * resources allocated to the device.
+ *
+ * Return:	0 on success or error value on failure
+ */
+static int pl353_nand_remove(struct platform_device *pdev)
+{
+	struct pl353_nand_info *xnfc = platform_get_drvdata(pdev);
+	struct mtd_info *mtd = nand_to_mtd(&xnfc->chip);
+
+	/* Release resources, unregister device */
+	nand_release(mtd);
+
+	return 0;
+}
+
+/* Match table for device tree binding */
+static const struct of_device_id pl353_nand_of_match[] = {
+	{ .compatible = "arm,pl353-nand-r2p1" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, pl353_nand_of_match);
+
+/*
+ * pl353_nand_driver - This structure defines the NAND subsystem platform driver
+ */
+static struct platform_driver pl353_nand_driver = {
+	.probe		= pl353_nand_probe,
+	.remove		= pl353_nand_remove,
+	.driver		= {
+		.name	= PL353_NAND_DRIVER_NAME,
+		.of_match_table = pl353_nand_of_match,
+	},
+};
+
+module_platform_driver(pl353_nand_driver);
+
+MODULE_AUTHOR("Xilinx, Inc.");
+MODULE_ALIAS("platform:" PL353_NAND_DRIVER_NAME);
+MODULE_DESCRIPTION("ARM PL353 NAND Flash Driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

