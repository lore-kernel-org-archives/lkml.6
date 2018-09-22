Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E53ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489012086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Ph8v6PbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489012086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390535AbeIUTbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:31:48 -0400
Received: from mail-eopbgr700043.outbound.protection.outlook.com ([40.107.70.43]:43072
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389581AbeIUTbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTalefFMsUOoUKkNjAQNa6h1K2jZo7PuZfsIoSRD1/8=;
 b=Ph8v6PbRZYzk9L1qSM1evaH9u8R93p/oJFAgJcgFbZ5SE+cabruHhcgBQl2IK95DB1r2++s5H/jT1JDH3MoBS/Zyach4sVxfW8J0baAPnqaSenGjrd4GEJzOnh+/s8bwkOvOrB0h1OTtrbDiiihEb3SoUhYCLHNyqblj77Ip9N4=
Received: from MWHPR0201CA0094.namprd02.prod.outlook.com
 (2603:10b6:301:75::35) by BYAPR02MB4469.namprd02.prod.outlook.com
 (2603:10b6:a03:10::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Fri, 21 Sep
 2018 13:42:45 +0000
Received: from SN1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by MWHPR0201CA0094.outlook.office365.com
 (2603:10b6:301:75::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Fri, 21 Sep 2018 13:42:45 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT023.mail.protection.outlook.com (10.152.72.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Fri, 21 Sep 2018 13:42:44 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1g3Lhk-0005Ec-94; Fri, 21 Sep 2018 06:42:44 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1g3Lhf-0008DO-5K; Fri, 21 Sep 2018 06:42:39 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8LDgUMF015643;
        Fri, 21 Sep 2018 06:42:31 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1g3LhW-0008AC-D6; Fri, 21 Sep 2018 06:42:30 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <srinivas.kandagatla@linaro.org>,
        <jollys@xilinx.com>, <rajanv@xilinx.com>, <sboyd@kernel.org>,
        <nava.manne@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v3 2/3] dt-bindings: fpga: Add bindings for ZynqMP nvmem driver
Date:   Sat, 22 Sep 2018 19:11:48 +0530
Message-ID: <20180922134149.5693-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180922134149.5693-1-nava.manne@xilinx.com>
References: <20180922134149.5693-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(2980300002)(438002)(189003)(199004)(305945005)(16586007)(63266004)(106002)(14444005)(217873002)(2201001)(76176011)(1076002)(8936002)(8676002)(81156014)(36756003)(9786002)(50226002)(478600001)(51416003)(36386004)(186003)(48376002)(11346002)(47776003)(126002)(81166006)(7696005)(336012)(486006)(476003)(106466001)(2616005)(2906002)(356003)(110136005)(6666003)(5660300001)(316002)(50466002)(26005)(446003)(426003)(77096007)(921003)(107986001)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4469;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT023;1:YQyP7ED9/1oiek+9FxFm7tSjYSiKkkIz9BMxfteDTQ1NHuZ/6jDQnErXHJiE/qtONx7u9zBtDl8CU/wduycaosHNqHUuJf7kVG5EZyWVB+SEFA3P4IIr6zoyWc5zcJ2k
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e49e6d44-868c-4a43-d2fe-08d61fc81c5d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4469;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4469;3:ncH2dWTW904MaQNqqalmvnkujUmhERcmySWedo4fM12kCTBYssuQkQ/310koEDMQb95OtIZ1nM+EDlTMFERaMZwyFgAX1vrEoOG9ms9Gf2jO014OiuDuYkOqvjHHCYdhaBM1O/YbP+xMqvDZvsfTnmn78/9wZLUlxbwY06OcAPVm3moKYHaXZxhY3gi4Vyy21ZGuCEx+o/t3GLKRnRu3VZ6jEssG/I2L5XCNU/mLugRvQGSmte/zNp9g9nFKs2N8X+fQHrG9n6V6umQEIezDrlwFyORFz+Zq0KXR4iYB1RS2/jA4qIGGcFbHAO0zaRpiypeeu0/+ZG5/1o01hpJxjCgyPQZdhPNOhEt5LpwfqDE=;25:JXfXc13GGICDhc9Sd09MEMzk5khpNO60bgDLpe3bF9egsWrA9fZwLKoWakxbWe089G5sZYMIB9Kx+ceLZd2gHIHcEded4nfZANmhR6P+xcWmcN49iDjk33G6bOr9te0VrINV83Yheg9Fp537NUlt6ytB2ClPRH7UlBi5tUPpKYlgtQVLDb4aKvNOW+BSQ1vWCMTwBitCNckOLMixn5tDvX+O74Y7O3X0uI/9f/oeepViNKFyYW67vdSmyNvp3ZsAWdgu3sTG/WPLck2WwxVTpSOJ3WFJakNZCDTxyEJqxuNSVLoJ+zIsLvtdcyYRKvSwvxbVYRmI1u9c8KaQd9mzzw==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4469:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4469;31:yOTsqU30JIgE9dT3PDwYaItZu1PmJW5ESUrhoNwozZ94tivgVAo/8jppcNwlDoUMr1MaCxn4d/XSW0BmHKxECByEECFn1fVNEjR+z0h+TLgsKsWdPif96I2DL5n8hc1Q1ZzWrvMauMdtJ2SHX/HcjtiAf2d4x9wgZgm7h1RvqLRVIiCPDFFBYDIa/Whwaf5atTiv7hNs5kYHfrJZQuZx+xjP8xMkyglunQI2rJeIEHU=;20:r+n5JKNfVyuHq164Cxu1fMz/+qfsp7h7d7S8pel8UoZC2UEi1633bT+F9+2sDmdSVPjSrt1b2Um9QfQWNRKE5y+TyH1DU35ploHhKuBW1H9Oy5XJxJHuO9CZh3J4uq7VYXsn1ywYElRCUoxZrE5QqwmoVo9Y4zng51UiyYfq0oWz+ZfkXTLXDBokyg+00PdlQFSVq+2aEPclhtWPhIm0MSiUFtQZeif/qUtA40jK+cnQhbbbbRwUe9J2CKRH0lXDWjYym6ET77RjFRixpG5GGsZyanrWD73V6um27ZG8bPnSuGzgTap/FhGFxqoZ8Il8fdtBFuYu7A2mr0LyHK34KTjPCjJYmHhAWXIzeOPG4gR2FbT95XOID7T+vBGlCrz8gCq+y9CkXJhIKL3ubTUo+ES3HgUjpV6tacovak0EYdLFcByTthj7FxP7lgBbogFJ3ADScJXY039HC2AQAlQhGyoItzo0h/ButEBAXhGycKWmByKflZD56CisETMqwmy9
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB446945CBBA2E760AF20FBA74C2120@BYAPR02MB4469.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:BYAPR02MB4469;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4469;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4469;4:t3RXj6N6Syl0Hprsy8fo5L5El9pRYTi84kChMs2EBtrMua7kbWDO+B7iwQV0yL+rW9WQ5o5podX1UhQryiET+8h1xJWZ3eEEEJsJpkF8vruZ57bIzf2JT1t3sD+kjVzfGl+wic6jBzmE8JuW1cpM9FKqX0hlfUWks6R2OojZQ558QSHU/eOO7VHlFQJDffAx2s63JtO8wn1nsJPo+TgRQB1HntFwmhfptuEbnIJbZ0lvuPdsUu/rrcYKN8VZCV1fjCd3SbrFHgFEETk/DqfWJvPls9Jw2VFK8xq3aKVzOi51ri3FGUFtUjEO+FG7h/dS
X-Forefront-PRVS: 0802ADD973
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4469;23:cOCweWvdpeQJWw68YWLU1HXd1czgwSylR7n2yDQ0Q?=
 =?us-ascii?Q?vm5RENdCFZ6+anVmK2VNAn2bfahTsrWeI6QPWJFDaaryiCP/WfWW7QfjtKj1?=
 =?us-ascii?Q?mtDAr5vu48VG6zWmz6xbWWNHlcQimkQ8VAI2F5tDR5C+QWyl/p8FqcoHqphD?=
 =?us-ascii?Q?15LDxE+mDb3gsndSbCWCQQur6/NigDloBK3nZRFsCLWosb8apE5ZfHZvhQns?=
 =?us-ascii?Q?NS+g0dm4jE7HPsS3cWMotgPobOtUreFIzu//PO6/U0pGSmjfyeRo8SJpP5T5?=
 =?us-ascii?Q?tJ0RwQbl3AXM5z/3mGnv7I6zR1z1M7OcdO0g+SmPp64DI1XjbNpiHATYDmjI?=
 =?us-ascii?Q?SPsa5Xd48B1AI6n5/b9xtHW1cTw+sDDHCBz09Qt1MKRSFS/TRHvnOyM4unlt?=
 =?us-ascii?Q?klzjNQXLDn/M8DyG33H8BcBXkZiqzoHn6f/JuG6QRMkNDXtl0qzlSEhS6jQ2?=
 =?us-ascii?Q?bYLt6eX442+pFTGBsgKLsfFLZy0nUIWUruV3sHXQjhErZW1Z149QCjDc72cp?=
 =?us-ascii?Q?I3OfcGokxMIwK6Unh1p5v8ZTaLqOfikcQ3JOSje+iW+J4gvbcFZbmWia6RMc?=
 =?us-ascii?Q?5dqbR5EIjBaoMIzdNqQHBN6No95AGMOUUStWJa5/WemWBJOtiNUs7AlBZ9Xt?=
 =?us-ascii?Q?tFC8Ib0yYYhLSpJMtTQBHwxu4Owu1PQSk0FNYpVA7cMQEnAbAuiLSs7MdJqw?=
 =?us-ascii?Q?UrMsHe4h6tSmgIIASlqASMGSvBYsTCWV9+Sg+ZO14p69WoQ0A7Vd9MrB0g/X?=
 =?us-ascii?Q?Pr0GFt2RNaMaYYBmignH1NnUAyZomE13YC/8ZA9js4RWa4Qtez5hPnCVPeoE?=
 =?us-ascii?Q?U0JuPDzJRvyVOkyebfjzfUhAFHsAy3ypi0n13hv9m6cS6PxrHsuuhkVuou2t?=
 =?us-ascii?Q?LNXrhVsm2BJT9pYFT/aFU6Pjd7jUx8PmPI5IeStfKYYzwUWGAxPDfpMTd0GM?=
 =?us-ascii?Q?fM80GT6nBx8Ifxs0PgCuDSy6mwDwtKbmlyMdo0U3kBYJ4TZEgz98sSN0kZbx?=
 =?us-ascii?Q?hTKIZQ9fZThlJIiKNdsD+lMT6Xt8jJZiRAjLJjHbqYq5esXg2YPXfJQaEwld?=
 =?us-ascii?Q?drLiUXUMxpeEMogh6NrGGCcFoUSuueflBPJ+I409OZRKjd5gL9TeA9c9NF+C?=
 =?us-ascii?Q?X4WZA+FDlVZK4DP61rqLceECl7Gm3E8BML3t8/N7KtbtlucslA7VeWDGkxE4?=
 =?us-ascii?Q?mMYg0Y2UH6iwniFc6UT8rFVc7ZojibLJPez?=
X-Microsoft-Antispam-Message-Info: pbCdslke9OxVya+zrfkABRlk3xzHFAjan8ByWUSGaOAMEk1VraENlKNi4Aou+RsTgIalq6/TRriQqWw0epL3SgT/mg1h3eV78fVRDeU7LLUhCFA16qYBsVK/OoaXsnEJFFgN7ifCalLDw2K0+roJd6q4rQj1xTaNqvKNGHOn+3ZxS7tkbfHbvzhbLtwwDwkj3aOKUjTqkfden2pBoBj4x3M5da7GEPSzILo9d4UVaCMz5gIg3j9hVubhNwg/PK36sMYftOIK3SVJoDd4yJlWJJFEfMhUpGqxQs9CPWk4Hk/TCL8uUzssGvo1xzFpj668x6IoeCcIdT3MVfi0FKUPIpTud5d/ZG4Dj/edlwQZo88=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4469;6:nqFiEO5sUHdXVCMwyBiXdz8D/hS9qhRmRl5wXxRLxU/0fF5MKR6bqrWyfJi9+PdWZaCzsUmEiYPwl49EN6yk6GBY7bsOyMnajqsTBJ9DLaLU+B/2uRPJbfqlHBLFyuEOQFeIidCnKm0JV6Z7VtdghjVnH8iMUW40MmOJIaLtibm9y5uE119lOkHdwg40uTIssPM2ugGyjILSS2FBBib0guyd5TTSfhGmwH8d6Z6N3gjPHge8tcjVV9stHrQp/FF0bsAf5J2+W4FXXaKwUr7wXcT7SodCwizK9yRKQpFFdWUuE+1whnB20uZQd5xzy2f8lneCXMxgDlVkkIhRO+Uu7oMnqlMik7KZrQoI/p2E9zyR/UkT0m4jvSYMYAm/CTf7hFtRhlEwvCh/P5yipuOCLgi7fEBpS9hH02typADxaljUbXlnCOalNOJpkvJReMkUMEHb3UklVB9Ns0ntskZm3A==;5:VfYmIkN9uo8mJ1BHWpvuXRFu5sZNDk3usEopPdz8EtvU7xcsAzW5Qoxc1P9wbYpzE5yAcEXIFngUJAVXPG44O68imUqrYHCg3WOlYQC82+CghweM9QtnyDDldGnZZNjFmqvKUxUncbbWk1SSGvGAjdE+r5Q5wWF/RtrUF4Nt6Tc=;7:AH61AQpTWEYVXdYKUnKLb7AiEc4wh4y9+yvVLwfCCkW1ebgSa685retPadnpTMrK0UgqSirz9M1rFXUyICQ4CbgYyONIwPoL5+R3KEywZ//qvyU6jPNLh9Uq0yi9m8l4DlkbA0yfYTD3qsUQB2N+rGpXzvHwH1mfWmjxbpaxmbgMH5mocJCIx8ctki7xPipLno0sq1FGHM4gh+vS5z0K4H8OwHA1mkEthZDtwmKC+ard7ACd+keQfwPIXP+LOrBg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 13:42:44.6522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e49e6d44-868c-4a43-d2fe-08d61fc81c5d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP nvmem driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v3:
		-None.
Changes for v2:
                -Moved nvmem_firmware node as a child to
                 firwmare node.

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
index 1b431d9bbe44..4b95fcc4dcb3 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -17,6 +17,19 @@ Required properties:
 		  - "smc" : SMC #0, following the SMCCC
 		  - "hvc" : HVC #0, following the SMCCC
 
+--------------------------------------------------------------------------
+=  Zynq UltraScale+ MPSoC nvmem firmware driver binding =
+--------------------------------------------------------------------------
+The nvmem_firmware node provides access to the hardware related data
+like soc revision, IDCODE... etc, By using the firmware interface.
+
+Required properties:
+- compatible: should be "xlnx,zynqmp-nvmem-fw"
+
+= Data cells =
+Are child nodes of silicon id, bindings of which as described in
+bindings/nvmem/nvmem.txt
+
 -------
 Example
 -------
@@ -25,5 +38,27 @@ firmware {
 	zynqmp_firmware: zynqmp-firmware {
 		compatible = "xlnx,zynqmp-firmware";
 		method = "smc";
+		nvmem_firmware {
+			compatible = "xlnx,zynqmp-nvmem-fw";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			/* Data cells */
+			soc_revision: soc_revision {
+				reg = <0x0 0x4>;
+			};
+		};
 	};
 };
+
+= Data consumers =
+Are device nodes which consume nvmem data cells.
+
+For example:
+
+	pcap {
+		...
+		nvmem-cells = <&soc_revision>;
+		nvmem-cell-names = "soc_revision";
+	};
+
-- 
2.18.0

