Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351A4C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2497217CB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="0J0Zi0Vf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2497217CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbeHDL0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:26:12 -0400
Received: from mail-eopbgr710068.outbound.protection.outlook.com ([40.107.71.68]:3680
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726532AbeHDL0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wu2zimiLEw/2nn4gOdA1xuhuDN/TG/aZ0NcIdyTCYE=;
 b=0J0Zi0Vfvk4hG1XRgBb8HbPkkY7CrDHnUSEIq2FbxDb3JZh3cI3/6/skn3R/tPM8xgSSNTtdjAcNOdc09Axdkshj9wl2hfg5hj4Q1kzl758f5nGFX6zqp+GUc6jPol+oRyz4i6pzW3tioZGPKHL03uM1RurqeaSqO8aRDAZC3tk=
Received: from MWHPR02CA0030.namprd02.prod.outlook.com (2603:10b6:301:60::19)
 by SN6PR02MB4461.namprd02.prod.outlook.com (2603:10b6:805:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Sat, 4 Aug
 2018 09:26:05 +0000
Received: from SN1NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by MWHPR02CA0030.outlook.office365.com
 (2603:10b6:301:60::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.14 via Frontend
 Transport; Sat, 4 Aug 2018 09:26:04 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT044.mail.protection.outlook.com (10.152.72.173) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Sat, 4 Aug 2018 09:26:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flsp1-0001kO-Gh; Sat, 04 Aug 2018 02:26:03 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flsow-0002IL-ED; Sat, 04 Aug 2018 02:25:58 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w749PtkX001268;
        Sat, 4 Aug 2018 02:25:55 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1flsos-0002I2-EN; Sat, 04 Aug 2018 02:25:54 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id BCFE61214D0; Sat,  4 Aug 2018 14:55:53 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <mdf@kernel.org>, <edgar.iglesias@xilinx.com>,
        <shubhrajyoti.datta@xilinx.com>,
        <naga.sureshkumar.relli@xilinx.com>,
        <bharat.kumar.gogada@xilinx.com>, <stefan.krsmanovic@aggios.com>
CC:     <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v4 1/4] edac: synps: Add platform specific structures for ddrc controller
Date:   Sat, 4 Aug 2018 14:55:32 +0530
Message-ID: <1533374735-16662-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1533374735-16662-1-git-send-email-manish.narani@xilinx.com>
References: <1533374735-16662-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(136003)(376002)(2980300002)(438002)(189003)(199004)(36386004)(426003)(336012)(52956003)(446003)(316002)(126002)(16586007)(50466002)(11346002)(476003)(90966002)(2616005)(44832011)(48376002)(486006)(42186006)(106002)(26005)(110136005)(54906003)(2201001)(186003)(63266004)(36756003)(50226002)(76176011)(4326008)(6666003)(51416003)(305945005)(8676002)(81166006)(81156014)(106466001)(107886003)(72206003)(6266002)(356003)(478600001)(7416002)(2906002)(5660300001)(47776003)(8936002)(103686004)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4461;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT044;1:zYtDmmzXfH17bs7V2kv7yddKR17PDw4Dy8tly7tP3u16ZBExrDFROTdBjrA8ozi3oVsvpyR7KYwBbmCtGaPNOV0p+b20IWS9JswMtOxOmN/TGFo36OGiyGG05KnOGnG9
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f956b0ba-b174-442a-3e81-08d5f9ec4d21
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4461;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4461;3:7V5fk7hy4vsckPUCJy7LtTkAyDY3T2wmRu50viHCvsfiFu2hFD2T4EF7HBFPAcgv8Ya8Pt5gNq4arPfKAFtr2plaWVbHDQhSMOp8TdMGbi9di6ECL1APmYofxTeZ1l6R/pe+dwe1hfWzla0Qa+WsbDcTf1spJkildGb69GQ9VJ87gVa9DmdPyysXRXDmFX7+W7aFFh76+kESsVJ+sRDls770kK9hMn0Sa68vtlBsnj4DqFA+UiLTab04rW3we9927/yILBKDTSq55e7EdR+gKY3s3WOsjYSRwU0mkvteI54AiksEWQIe76vGYhp9jUH73uUCgmDCVmrawRihQD5TCzqN2lLdAMSyrFLcxF96/eQ=;25:Qt6JbfQP8Ikwd3yl/Z2oedRFYyrUx719cBAUZfYPNx6uHc5BgDGqinB8oNbkHzagw00e7tv1EFrJGtai4CeXNQCTwV1rsl1/0kG/UUXC7B2DV5wRUBr1ra7DRje4E0+KzA5dpW7bHD/Zfoo7FLf1Zmlqc7fcsn37nKqb2pHD/jshz/UmwEjWILXq1XuWSEB88vvWDLH0WShcXkOSIseI2xYPaEq4RN4n2EJI5AgcQh+BIfbm6Vd3jRk7BQ2PN3msZ7iL8sGO0vmVXiVbJHPK2eZI4Th3thzYmy6FXAu8DB291a1LmyLB62AkgPZmLd85NRJb3FvDd4XRIOWwhX/xIA==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4461:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4461;31:wFSMM4uZKtd+Hnc8x2OMqfgvrtpbIZy+lKDbhpQHzkuVwGUW+K24x/I2ycfSloBAUptOjnJl3j0l5VXhW4hbTkxCaPXT0U7UtlCQZi7n0TR2bYclehrzbUVUL8FyYG9cazXOk8a0HPKsaCyZdnbPOIBobOXjZExgJcA9rhd9zGr7NvlPpsNHNfS520cYvSYZInoBQr5cQuj5VWOjP/mq24dNSAGzQhHy8a6MtsL4m0c=;20:OQ7TxTrMxebCipDfUjLa6RkkPrcacJADclgkwH4ah+98FqLlmJYbZ275vEABIZwn6wZCZHSWrbiI+Mt5262ZH021JsujSFFx1oB8DiTNo3/e1rv/KcNQC+LVNqXG3a53VD+bsyfQIzq4+2OUpm0/nB6makp87KwhfYO4tCvTN5ipiSloyJwqcW5CUP68ZVch86LJLh79IyKEl54FDh0C9uGw04kf9ynHXOgQpf+rdyfA2/CWR4Lnh9ApYCW5+wRTLMRY+5dIodqa1vY9V/kx3W6QMpDuFtPhFOT3tCDWW5kM0cJVWVrUy6G1H4H1d15JRHNO+jqDogIpPocDiIFmNC+bh9y1Ga15OgKEeUBDIHmaE7YQo7ORf7kh3YZ7LO+zSkeqbsLUdSvISgTmXWcwCrPGN82dQz8u6WLYYQxEl8rBVpQHQdCUp3RzE+9Mzo446k5hS7SiKAml/NL/ns1zvxI47EGbfBQer7uXdTbOzFtsGsZOJvdVvtzMl59WkKEh
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB44616F5A799441D921CDFA7AC1220@SN6PR02MB4461.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN6PR02MB4461;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4461;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4461;4:sB4mKZuZLYtQBeMDJWVbaTQC9kulmPSLr6EwzyDAQs2ddpzh5QOObE3oiUTq//KGTUmnceDImcWibxeYHT0PlvDzFeQAnk1cm8Oy1/14en71PW400cTXlzHdqknl4Q0vfuNTuvc5awF555/YAQXbVt07aLl6uxXbUGRqIBYPmoFJW+T9en+Qlfx4zE7PNoZJstggOgRYe2+51inJF6lDVy0RQWHhHso7DulyRgbKz6Dnp8BEHsmSmYjPLF8G7jec5A1pbREKB+lWFyXfDnZQdhJ/57A1Z9PtKp8sJ1w/ksHjS5t/GOjUTXRvei8Y7fuB
X-Forefront-PRVS: 0754F7E325
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4461;23:KkyWWjkeWMWk66D2i6VhXMMRv2kXKJvCVBGUAR2ax?=
 =?us-ascii?Q?KMI9dH2Uf9lUr461bFQmVuEuG/lOB9qWEV6gbazs5Acrglehz+rLS1lR2ngn?=
 =?us-ascii?Q?DK36u32GB1OzrPUMd6OTOvt21KIeneksWmw3wcyEY2Kg4ahwGLYGu/NkWbLa?=
 =?us-ascii?Q?nokiBnTeaG7wgTCHrUCrundv8SeEYDjEnY0kyQ6qFXGyk18sIoKfknPkIZcn?=
 =?us-ascii?Q?hxHZ5jO7ZMPlBcP/9DWAwG6CVzkQNW85TFx4sVOcQrCTxHZQSARCbPgOrqZ/?=
 =?us-ascii?Q?pxN+rCz+/HWoI186ID0FtluVQ+uoJlUHif6iaaQAzVIDOmpbtbT+Le6iMczb?=
 =?us-ascii?Q?+z+j65jUxWSBrDkWG4m5z+RNv5ZZ38CcVP0MNKfg9PnmHnhbkF/PbkVIYMXx?=
 =?us-ascii?Q?JQE06oPlBebFAnAS+2ccQsrOyQA4AYUWPnaQayHSR3q/BIssR6GhVwTsKbNX?=
 =?us-ascii?Q?bCKDQ3hiAly1NOaJWT8z0Zv+MYcSOCXEq0dm0gczwRPfPA2YkSP9mDk6NCo8?=
 =?us-ascii?Q?Jul89Rh9xYRIfH/BX+1V994wJw9gvFWzodWO/626bZYjQUqS7WTIG8LpFuHd?=
 =?us-ascii?Q?FNY7twplf5LYB5zqXpaiTsdbLBjdObEKRrio+seJteAIWXqg+GeUNUtlQV75?=
 =?us-ascii?Q?PmhPpXNu0164j7q/eK6ybHN+rLt88hf0/HkfbfdSjBR2Bpjk7yNfPN+nFsmz?=
 =?us-ascii?Q?qNCfYVlKSE5ajq9yc9TBBWdfv3v/6YpG+CmeoSBBony98UVWMqilDiaF13m6?=
 =?us-ascii?Q?RDAFsrohOGHGEQoNv+R6Q0k6lkSAXJzidQ2AtJUKEzzjWmU8fBZGpXcZYOMQ?=
 =?us-ascii?Q?P1bclyddIAhfnyNtXifaoLmjieoUGQi/KysKPET5cuh44xDOh1J0PIQhvxiB?=
 =?us-ascii?Q?Mft8X6vOAC+uPjdRa3ZYrHAxDsihAke9XQVBvpkoHYaaL8bbWWIWwUZmTrBI?=
 =?us-ascii?Q?SillXbwyDI2gvQXpSBex8+JE85kONX4BHkT+AV/LO6vTgBx12D6kbRwCQMEY?=
 =?us-ascii?Q?h3kad7GrjcSXw6+gnxEoyGI9LauDMM9e90/mMRa6nMqOwjKYVnc6r9f+R5RW?=
 =?us-ascii?Q?awRo6y1kVzbOtpoU04yx75ofFmQyVeuNvSO5R+zXKa6m3KLPI7VKu9Eo5duS?=
 =?us-ascii?Q?U910l5DmrxzFd59PRtr6A3lP9qlm36QhVaPsweXw7C+TSgVpXDTz1Vp4qpzP?=
 =?us-ascii?Q?zLpqbvaK6xFZwbdeBk41RT2pIgeMkxjr817i/w5ceTuewQsWyJ/kHe+QC9zq?=
 =?us-ascii?Q?TJbVWzQfTF/Rc8i2z7kLH9dZRYtW5JlEvGmMfO/?=
X-Microsoft-Antispam-Message-Info: yL3EJd3ivbsaGWTK48tvaLjSJIDqZzxPx0SmZlrLTQWUnN7nsjJ7rXRzZw4brj8zIL5ofOZCRpjp9utm3aw+YdkeAu5LGQ3h63MVZBmndpPPxJurKeKIWHEL+l3Ik+X+/aWuU7LDd0k3rm9Aw6x8gtFrSs6kyq6wkFYhEtocF16IMWLCHcWmUmnkjyzwolx+yQhWpXFvM1MSSMmRXVf0i5sW68Hk89Co1VzYDFZtHegHSWmTd6OXVx3nzJfhZQJM4sJkLRbmBrCsXl2T4SjAzl0WhwBJkZfM6eLIYXa4tat5nko9YPOOrG0pjqBGe355pnx9LG4vmFvIOLE8AJvHWR8g+ENxVyDkOgFEs1EgYPI=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4461;6:fZaREZckosfvdUfsdCgkvLoFxjboNeR8eHrrH1oKkva7AL4clrETDkAHqhpmhi3WozObro8n7P9HfNOo/5OI5ljPNCSrjH4BZJDoe6BL30H1ZXlcy28g6usogKYON83bZ4SpIUdCVPit+z+8dni0q7s09HojrdezA73L9HIXgRNSqZ8zv/IF4r/ofch6f9UnJEXqYOuOeCBmgmFWCxdhVroX/9OvVto/UJZ+CjwBCSHPBlciJIRm/yxrMnY+oVxIEJ8+h/Y0i/Y6ZZ41gd1Z9iCyiKk0P+LS04J4x5Sbd0d1xtvPQr7CNCEDBuZA/K+Z1aVx8IPM5aAA43ZDbyG8J1SeyBdAhQ1uS0omY22HIJDQaoyBhmHvgXiF9ehtZ9CX5Bx8Nw+TC/ggXFXipsnfrWPgw543MgW2EKLW9LJkr4gjrK6GfwBJUISMplrXkY2eDiDnqa/QY8g43ce62T7Lmw==;5:0s/VupL7HASWOiRrC2Mv5xkw1erjoi2LWDBjwWzqErL+8mpTZnNKMK83z5YFlVm4R6yDkBillXSKAOzOyUGeF1mA0+g3QxxUO2zJ7xeK1q+bRbWeh8ZhdkFb4VaSxT+fGOb6bGdTze0/r75gZXtqm0t9pe3Bagd4jU4u6LVUies=;7:dbacJclBnY6KIsNBym1NCmtmxszaYRl2uuVOP0++pEI9k4njtL9C1k27wCAXtWUR9OLS79Pd5RkXgyQ8rxccRNg2Icdu+Ow/AJKuketPCTkGywyYmzIFaaR1w7+78r7NNEAFs4I/na4m4g14QGhZLNM1rAiKkD5MDfmq+/WZH9CJXykFvJcc2iDY9dh8GsBCKd7GhG6hquZA93isSxRpZLzQuPdWbKMZBubUi8msE/3dzNqudkbIgAM8229C7qgQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2018 09:26:03.9415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f956b0ba-b174-442a-3e81-08d5f9ec4d21
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add platform specific structures, so that we can add different IP
support later using quirks.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 83 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 65 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 0c9c59e..b3c54e7 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -22,6 +22,7 @@
 #include <linux/edac.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 #include "edac_module.h"
 
@@ -130,6 +131,7 @@ struct synps_ecc_status {
  * @baseaddr:	Base address of the DDR controller
  * @message:	Buffer for framing the event specific info
  * @stat:	ECC status information
+ * @p_data:	Pointer to platform data
  * @ce_cnt:	Correctable Error count
  * @ue_cnt:	Uncorrectable Error count
  */
@@ -137,24 +139,47 @@ struct synps_edac_priv {
 	void __iomem *baseaddr;
 	char message[SYNPS_EDAC_MSG_SIZE];
 	struct synps_ecc_status stat;
+	const struct synps_platform_data *p_data;
 	u32 ce_cnt;
 	u32 ue_cnt;
 };
 
 /**
+ * struct synps_platform_data -  synps platform data structure
+ * @edac_geterror_info:	function pointer to synps edac error info
+ * @edac_get_mtype:	function pointer to synps edac mtype
+ * @edac_get_dtype:	function pointer to synps edac dtype
+ * @edac_get_eccstate:	function pointer to synps edac eccstate
+ * @quirks:		to differentiate IPs
+ */
+struct synps_platform_data {
+	int (*edac_geterror_info)(struct synps_edac_priv *priv);
+	enum mem_type (*edac_get_mtype)(const void __iomem *base);
+	enum dev_type (*edac_get_dtype)(const void __iomem *base);
+	bool (*edac_get_eccstate)(void __iomem *base);
+	int quirks;
+};
+
+/**
  * synps_edac_geterror_info - Get the current ecc error info
- * @base:	Pointer to the base address of the ddr memory controller
- * @p:		Pointer to the synopsys ecc status structure
+ * @priv:	Pointer to DDR memory controller private instance data
  *
  * Determines there is any ecc error or not
  *
  * Return: one if there is no error otherwise returns zero
  */
-static int synps_edac_geterror_info(void __iomem *base,
-				    struct synps_ecc_status *p)
+static int synps_edac_geterror_info(struct synps_edac_priv *priv)
 {
+	void __iomem *base;
+	struct synps_ecc_status *p;
 	u32 regval, clearval = 0;
 
+	if (!priv)
+		return 1;
+
+	base = priv->baseaddr;
+	p = &priv->stat;
+
 	regval = readl(base + STAT_OFST);
 	if (!regval)
 		return 1;
@@ -240,9 +265,10 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
 static void synps_edac_check(struct mem_ctl_info *mci)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
+	const struct synps_platform_data *p_data = priv->p_data;
 	int status;
 
-	status = synps_edac_geterror_info(priv->baseaddr, &priv->stat);
+	status = p_data->edac_geterror_info(priv);
 	if (status)
 		return;
 
@@ -362,6 +388,7 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)
 	struct csrow_info *csi;
 	struct dimm_info *dimm;
 	struct synps_edac_priv *priv = mci->pvt_info;
+	const struct synps_platform_data *p_data = priv->p_data;
 	u32 size;
 	int row, j;
 
@@ -370,12 +397,13 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)
 		size = synps_edac_get_memsize();
 
 		for (j = 0; j < csi->nr_channels; j++) {
-			dimm            = csi->channels[j]->dimm;
+			dimm = csi->channels[j]->dimm;
 			dimm->edac_mode = EDAC_FLAG_SECDED;
-			dimm->mtype     = synps_edac_get_mtype(priv->baseaddr);
-			dimm->nr_pages  = (size >> PAGE_SHIFT) / csi->nr_channels;
-			dimm->grain     = SYNPS_EDAC_ERR_GRAIN;
-			dimm->dtype     = synps_edac_get_dtype(priv->baseaddr);
+			dimm->mtype = p_data->edac_get_mtype(priv->baseaddr);
+			dimm->nr_pages = (size >> PAGE_SHIFT) /
+						csi->nr_channels;
+			dimm->grain = SYNPS_EDAC_ERR_GRAIN;
+			dimm->dtype = p_data->edac_get_dtype(priv->baseaddr);
 		}
 	}
 
@@ -423,6 +451,21 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
 	return status;
 }
 
+static const struct synps_platform_data zynq_edac_def = {
+	.edac_geterror_info	= synps_edac_geterror_info,
+	.edac_get_mtype		= synps_edac_get_mtype,
+	.edac_get_dtype		= synps_edac_get_dtype,
+	.edac_get_eccstate	= synps_edac_get_eccstate,
+	.quirks			= 0,
+};
+
+static const struct of_device_id synps_edac_match[] = {
+	{ .compatible = "xlnx,zynq-ddrc-a05", .data = (void *)&zynq_edac_def },
+	{ /* end of table */ }
+};
+
+MODULE_DEVICE_TABLE(of, synps_edac_match);
+
 /**
  * synps_edac_mc_probe - Check controller and bind driver
  * @pdev:	Pointer to the platform_device struct
@@ -440,13 +483,22 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 	int rc;
 	struct resource *res;
 	void __iomem *baseaddr;
+	const struct of_device_id *match;
+	const struct synps_platform_data *p_data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	baseaddr = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(baseaddr))
 		return PTR_ERR(baseaddr);
 
-	if (!synps_edac_get_eccstate(baseaddr)) {
+	match = of_match_node(synps_edac_match, pdev->dev.of_node);
+	if (!match && !match->data) {
+		dev_err(&pdev->dev, "of_match_node() failed\n");
+		return -EINVAL;
+	}
+
+	p_data = (struct synps_platform_data *)match->data;
+	if (!(p_data->edac_get_eccstate(baseaddr))) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
 	}
@@ -468,6 +520,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 
 	priv = mci->pvt_info;
 	priv->baseaddr = baseaddr;
+	priv->p_data = match->data;
+
 	rc = synps_edac_mc_init(mci, pdev);
 	if (rc) {
 		edac_printk(KERN_ERR, EDAC_MC,
@@ -511,13 +565,6 @@ static int synps_edac_mc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id synps_edac_match[] = {
-	{ .compatible = "xlnx,zynq-ddrc-a05", },
-	{ /* end of table */ }
-};
-
-MODULE_DEVICE_TABLE(of, synps_edac_match);
-
 static struct platform_driver synps_edac_mc_driver = {
 	.driver = {
 		   .name = "synopsys-edac",
-- 
2.1.1

