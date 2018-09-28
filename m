Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E57C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A844E204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UvDkgOk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A844E204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbeI1XiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:38:25 -0400
Received: from mail-cys01nam02on0088.outbound.protection.outlook.com ([104.47.37.88]:55981
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728453AbeI1XiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifTdhn7stSnkiOmi8dlEO6iSODQ0W9jNfR3IYrq8DJw=;
 b=UvDkgOk3GuTZIUzM8uOopI0uquBtITeshb76f/CoCQtpQ++GLwwERZGPYdItSh9d7eP5+PKgdgqX8a6M11vAGC+HIcDNYuMtBwVhNfJap/8nUG6OU3M2lNDbyGbFX4+dp752CKtAsAmmQLvkWnWt2Uuu2ysmiM4AhXpqNlHOoME=
Received: from MWHPR0201CA0069.namprd02.prod.outlook.com
 (2603:10b6:301:73::46) by DM6PR02MB4473.namprd02.prod.outlook.com
 (2603:10b6:5:20::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22; Fri, 28 Sep
 2018 17:13:39 +0000
Received: from BL2NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by MWHPR0201CA0069.outlook.office365.com
 (2603:10b6:301:73::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.22 via Frontend
 Transport; Fri, 28 Sep 2018 17:13:38 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT022.mail.protection.outlook.com (10.152.77.153) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Fri, 28 Sep 2018 17:13:38 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:40622 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g5wKf-0002Lv-DE; Fri, 28 Sep 2018 10:13:37 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g5wKa-0004HW-9L; Fri, 28 Sep 2018 10:13:32 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8SHDTcU010119;
        Fri, 28 Sep 2018 10:13:29 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g5wKW-0004H1-T1; Fri, 28 Sep 2018 10:13:28 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <olof@lixom.net>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <michal.simek@xilinx.com>,
        <arm@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v4 1/4] Documentation: xilinx: Add documentation for eemi APIs
Date:   Fri, 28 Sep 2018 10:13:15 -0700
Message-ID: <1538154798-6828-2-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538154798-6828-1-git-send-email-jollys@xilinx.com>
References: <1538154798-6828-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(2980300002)(438002)(189003)(199004)(48376002)(34290500001)(9786002)(50466002)(305945005)(186003)(5660300001)(77096007)(26005)(106002)(356003)(110136005)(76176011)(7696005)(2906002)(51416003)(36756003)(2201001)(6666003)(54906003)(63266004)(47776003)(6306002)(50226002)(81156014)(486006)(126002)(81166006)(966005)(4326008)(107886003)(336012)(16586007)(476003)(106466001)(8936002)(2616005)(11346002)(72206003)(426003)(8676002)(316002)(36386004)(446003)(478600001)(44832011)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4473;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT022;1:VZXo0dM+VWKRNWPPRzrw6Skd33sn47Vp+2QIo3rNKKRKm3YlSCTvOnvM+G/eMM4wt3t/pm9EDK1G+0EA1/HezVzwabz9myag++3MIlEoXLrG/va0Tzyh23PcApNAzAe9
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59c3b622-3a9a-430a-5866-08d62565bb3c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4473;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4473;3:RPTBYqaP1cfONZs3LdTz7SYNgq0N/ac/8DgFUr8/ZTpFs25stU7vaXkkHOLN3gg3pImrtbX0pnUQ9w9nPQIvtt8PkLJsi9ZoA4TFssKkccirWAdYvMXA5q4VTPOPKS4LsmJSHkePXwXo8ahMq3B82T3Z2909Dctst77uyeqnYVck9p29cC/6D1+w8t3bAI64j2hzholT7HfxPO/7UbkWG/4QpkCXunRZd9WsNPmifd08cqvtysEGGqEzUKOA3aCQGXw799CPdMPB7BuJS8cemK/tNaW7OEkBZHSK0ux/rT4ALhqOHeq/e41o4BrI69XzlWvK7jEs+bTC1L/QGbQpxH+fjnZuANR8TWUMVMqVDFQ=;25:6hQ7ekuSn9/+MqZwF2zLHIrekfRMl9X8rXttGys3Q3Ee041ts5PPCaWKwu7Xm9j01wUS+zAVHEM92Lqj+AxeCgzv88DuQW/YIHqqt0ZDhHDrFNqZWAOgVjGVHPo1Fmr6T3L+vst1RajvN1jQUUisrziuEfAhMbSp+D9GbeX7wnShs/tzArU/5ku33HdfKWlr2c4Czv7oPyaYyg3Gj8bOD87lIHr6ZvbPB4R30un6nbrr8GB/y8DIq2lrZCMrdFnplgRN4FFPaW58GldnyrPa2zOajjcxpgPrWRhPXsY9raw4yp8GFnqbp3dr7NSQRdrnCZAMftInTF2oUXRCBCeeYQ==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4473:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4473;31:Zb9yJJrGk536QLUulImBV68YdnOSDEfjNjQWgP+V65EPFBGg2qr50zL4n1QzC349ct7t0wCss+1bYHEc26CfG3uyk8q7D6D3fsxt3Xqe9Gicws0B/FTbx5vxCaP6ZVFF1zo0hoTKYukM2tRY/3ziIUbNHcc5G0NGfyyQL/4GfnlAcyR8vxGWpRDcEHU6kB0Z9/4QaHrRfyDd87ScbOWct05vBiSY6IOUanSzkQ4t18A=;20:Vno5lPFUyhKJXJb4RYCo4EXR1xzrEYLdDQhTYEBUYFgByLrNKhCBb2KAQp4RjHW462D+JfIikSDq6nd/c7gIku4nmcUizgnyVs/hjToYMLjX5S/hytneN/ntIsYzWYP3Cox9MJL37UG0rCPMPPs+QGxWYudvaV7m8Kfy61IIYNA7S7VZF/UkStHzaueN+VKpXb/VfSaBUHV+FbZZyqS2JoEoISIEqyWRLtMVFjnF116qvqlrTzWC0LRHPVY0btH50y0Qx3eQfEhzKsvz1rbQAnAc+JLhR2+VsfXuBuSfMWAjUGejvJnKcfFQ/KTB4438+KDN4L3pZ2dNZFhBnua51yFEKNQ+7fnoaSpK5B1ozCF9EKEtv8m48OqmFGWgO/Su+TsI+huGdG8nmx6ToqQjdJUy7JWNLdO6/dDynQ++yHAARy+0jtSIqxOTrUHaHsQRQ00qZojYA4UIwB9Wnje0K8Hgv1N0qn2hbZaC7Uh5QkxaTQgjVsHjG8jKFvWZi6MR
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB44735A259738CD964A582886B8EC0@DM6PR02MB4473.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(189271028609987);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(93006095)(93004095)(3002001)(6055026)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:DM6PR02MB4473;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4473;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4473;4:R+3EYpZUNv4qrOc8YMkU7gJ+WYLlxHO4+rZvYn41rM7uVgQ0/IwFBPj3PWFkTlswfCvLSJLxGxVECZpdhyox1EHtfzCzstI5Nuc30GsjMOyrGmIYHLYHWHq75KR8QdRxLPLQmAtCrZrz6aSJ9JXsCkx4hIf6hLCnhIjCUoSrAfdct7BIIXAcSz0bVArIEVkN9Ia+y1N5rA3boa9PJhf6usG5Mc7cg2mWoJDLcbWVvgIruFHMdPm/aKdJkNQh7C9eYR4Pp8j/GC8xHa4uxiIrGFfEWaBzg1XpDJx8xgdNunqJgxv3FMmZfEMF53JGtr/ogn2Rk1jXmoWy8U9+GqTe7SCwvHimsXXNoT3adIt3t+c=
X-Forefront-PRVS: 0809C12563
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4473;23:QNHfqffd7mcBdJ6dEB/eR/UyzQZslN1Ezx6Ntne2S?=
 =?us-ascii?Q?+UmyFYcpX71ZZr3/A5kK+JW849T7m36gIO3w4VQ2VAyPftq1rTsNg5ZNfzUd?=
 =?us-ascii?Q?yT3c7AM4IT3Rrb4+oab7I7V4EZwN+RLfEbNnNSmXv1so50q0x3w0AR+PevWV?=
 =?us-ascii?Q?D49RwNFfNtK4P4ho/hCLJkjbCMpN21e+D2lwmXroiVABjs8E0URd2ff9rOir?=
 =?us-ascii?Q?RthlnmfHh4WNCPH81M7j+53vLjaVP94BD5u/8XgKKzVG/J8OcJ4ln15aFnW4?=
 =?us-ascii?Q?e4t8qur+ndviMPqV7c1JcPDTj9JpqcTpb5CsMqZphxkn02B0v1BPcoSh2L+G?=
 =?us-ascii?Q?vHSCb+xifK47faoiANHm7K7lEPbwj2A7LZUXWgB3yDE5nXSEwP0drsxxlXD8?=
 =?us-ascii?Q?m+zTRa+E0Y+GoAI7H9dp3FYL4bm0i2JO5UHodivZzNyPzWHunYa6n10SG3fp?=
 =?us-ascii?Q?Hp6aAy1k0iTG7+ozzg6h4BqGibpsnVaHyZO+S7rdrooWvHSSKcj0fESToi9z?=
 =?us-ascii?Q?ezGdiUzbsk5ZiCAZsfOsORBUZvrCFh5uvztZdFTvW/sUyGGRJ3WWfI/oiM6G?=
 =?us-ascii?Q?ywmMmEIBNvcBakOX2JQekKlCWOyhBTP9veFi0D2yYY6a2a6FVXtAAjeGlZ8Y?=
 =?us-ascii?Q?IW+SrwVURM8oLkGjdDD7wSET2MkaU4mfBPN71bJSn/ltTKRR+SGGSUG9rZta?=
 =?us-ascii?Q?4puL3a1bok8W1zQk3OKqcITMtV07NF92A3W5LloQ6dXLY9ZxcrPazoPbPqdf?=
 =?us-ascii?Q?3nOiWKkufXCGYRMLuCq9zx4LORGIoP8Ob5T1hIbCFSpmQKeiO9RSNuMabX0i?=
 =?us-ascii?Q?+obTqv05xc9JF0XatBYDV3ojks2UxmV3DCCvKJ7evYrFcPpwK34cTKvlOOpf?=
 =?us-ascii?Q?FmrptYe4L5p0swFfXcawPMwU/MBSaooy0DZDR3WbSBZLulkB2Fd6diiM/HqZ?=
 =?us-ascii?Q?yxeqmJfddXlelyyD2h3u3/0tlDaWMDlMPq+DjnPkqc+PYzfxnHRcPW/92w4k?=
 =?us-ascii?Q?R57C9dOnkTzqxYBjw7T+9mT3o8qA/U0IQPKSl8DV7sZMD1WwwlGWGM4ASlBa?=
 =?us-ascii?Q?AAIbSGUEqfbP/Vtkx0ZASdQaBPCKKIKUq/oghl6tRusHdWOQPAnKpkaBsZOk?=
 =?us-ascii?Q?CPI55S2t9xgMg33WPmSi8LGZ5H0mDYF072+DYyYd3WYwTVN2Ii9xox3Vu+mb?=
 =?us-ascii?Q?jQ495Id9Vo27aB63gfaZT6ptPxE52UjZ+ieTUuWqF3eTyUOK/rcqSlITrb8P?=
 =?us-ascii?Q?1BxVIHquqJBd91yGy5/AvEmFrt0SK9/5PYmGm73?=
X-Microsoft-Antispam-Message-Info: UfhOIvQgzgna0OUN3H2dnBb5PALitL7/54M0YmgItoQzeRDPu2OkGcXrbWRAyjrPKQ/h8FCWew4tUOmUMgkSlx4dcxqsAbMWnRpqi8d6zoCm75E3cOVo/n60CtaSEPkAfNp5nzq2JN1fCqbueh/LLb7mWNtxVtzgYTv61EeJBwkXwahmkjIch2SMtvE3QRwv56IKkBQ9sjpkktuhQjTf55KgNvhLIvs+jbpGpjqlK6NFHYgRZGM2bY0nqQgPXMbVKdIyB1HOGsThltQeL7bbywiUgVefpA/QZl5FOd57NBtqZ0cPTn1Ecvr8KvEpnsJoAhWQpybcbivme99bhDxfADHRYSKLtqWkUB2bv0v4EVk=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4473;6:X4cpUDjYavjUIEcOx9XD1fngojcys01WPKAYzmZNpmhoYgA/5PAkwUn6yEt7gvPhLrvnOxvc9K8tLzQBW0jqwEqARqEY8ik159rqOnReuUXV/AhW1VKC7A5Upxoxdrci98wfHoBfSglEkM1DihTUmBI01nMQ5EeLjyJNkexQYn3bD5ZWGJIN8PJ7xwUgwA1ohKSg5HHwi7qy3JbkVX6WVLrjll4h6zg/af+TYpOauahUQbf3HFEA4uYqO9QY96X8vMgQl8A1kY6DxIlgR8Vk3GuWHrZoDxO335teHzCoi5NkpdI8xlkhesOyYc9akT2lsakuBHnj9EzXyayqsp5sHsLV2XdhpRohHV4fObVC/m8jkSCfMKKyPlHMKiivm5JMYD2lWXKzzT92Qxgj0U2Hwu0v3XiuI27Q/NeVgW6y/k4C8UaZLVBHHYjspddcgdOLIx0Hlb1azOOX+hxXKOCYig==;5:QA4vn7eI1e8kSRL5y7NSfd3vFqjNJ1E6tbcqbduwHmRnpx8nM8jFCwU4GVpH+09MKVqzvzX5DzGE4+7ZtQcF/tyqRkawM12/QmIsoQVbKhc0JaLN8xZlxVVV/v71Htt8NruV75Wdb5w3KWOLsjrEW329yA7gx89oi6bVenUkR/M=;7:48SGR3xRxuQeBPEbmhKc/Vu0AOUej94pLlKR1Qx+EaMKx3KiBZj7uyRLA2lZOTXv0yWJtK6oChpZ97z6YUq8Md5lFGH3JAjFxqUv2Whglk3xlUuedqfRDd04A3VbroNDaWMKglIWN5hI2lrYkfvROer2lEOXMoSeL3if32thmb5Kgf4TgcPlpwZoj4Ub3QAPmyVdRHCCeOdaM1RMfr9ASqs6i5fhtxQgxUxzcppwaQMozrddlrNcYAFyxS6pz6ro
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2018 17:13:38.0222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c3b622-3a9a-430a-5866-08d62565bb3c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4473
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation for embedded energy management interface (EEMI)
APIs. It includes information about eemi ops and how to use them.
It also includes API information and supported IOCTL IDs which can
be used for device and control configuration.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 Documentation/xilinx/eemi.txt | 67 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/xilinx/eemi.txt

diff --git a/Documentation/xilinx/eemi.txt b/Documentation/xilinx/eemi.txt
new file mode 100644
index 0000000..0ab686c
--- /dev/null
+++ b/Documentation/xilinx/eemi.txt
@@ -0,0 +1,67 @@
+---------------------------------------------------------------------
+Xilinx Zynq MPSoC EEMI Documentation
+---------------------------------------------------------------------
+
+Xilinx Zynq MPSoC Firmware Interface
+-------------------------------------
+The zynqmp-firmware node describes the interface to platform firmware.
+ZynqMP has an interface to communicate with secure firmware. Firmware
+driver provides an interface to firmware APIs. Interface APIs can be
+used by any driver to communicate with PMC(Platform Management Controller).
+
+Embedded Energy Management Interface (EEMI)
+----------------------------------------------
+The embedded energy management interface is used to allow software
+components running across different processing clusters on a chip or
+device to communicate with a power management controller (PMC) on a
+device to issue or respond to power management requests.
+
+EEMI ops is a structure containing all eemi APIs supported by Zynq MPSoC.
+The zynqmp-firmware driver maintain all EEMI APIs in zynqmp_eemi_ops
+structure. Any driver who want to communicate with PMC using EEMI APIs
+can call zynqmp_pm_get_eemi_ops().
+
+Example of EEMI ops:
+
+	/* zynqmp-firmware driver maintain all EEMI APIs */
+	struct zynqmp_eemi_ops {
+		int (*get_api_version)(u32 *version);
+		int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
+	};
+
+	static const struct zynqmp_eemi_ops eemi_ops = {
+		.get_api_version = zynqmp_pm_get_api_version,
+		.query_data = zynqmp_pm_query_data,
+	};
+
+Example of EEMI ops usage:
+
+	static const struct zynqmp_eemi_ops *eemi_ops;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	eemi_ops = zynqmp_pm_get_eemi_ops();
+	if (!eemi_ops)
+		return -ENXIO;
+
+	ret = eemi_ops->query_data(qdata, ret_payload);
+
+IOCTL
+------
+IOCTL API is for device control and configuration. It is not a system
+IOCTL but it is an EEMI API. This API can be used by master to control
+any device specific configuration. IOCTL definitions can be platform
+specific. This API also manage shared device configuration.
+
+The following IOCTL IDs are valid for device control:
+- IOCTL_SET_PLL_FRAC_MODE	8
+- IOCTL_GET_PLL_FRAC_MODE	9
+- IOCTL_SET_PLL_FRAC_DATA	10
+- IOCTL_GET_PLL_FRAC_DATA	11
+
+Refer EEMI API guide [0] for IOCTL specific parameters and other EEMI APIs.
+
+References
+----------
+[0] Embedded Energy Management Interface (EEMI) API guide:
+    https://www.xilinx.com/support/documentation/user_guides/ug1200-eemi-api.pdf
-- 
2.7.4

