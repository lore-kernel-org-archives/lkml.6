Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554BFECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB72214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KAaHveVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB72214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbeIQTM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:12:29 -0400
Received: from mail-by2nam03on0067.outbound.protection.outlook.com ([104.47.42.67]:10656
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727375AbeIQTMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbR3fLzO92FLbnn0FpatGAZw4MgV1t8PyiVaoNMXrYk=;
 b=KAaHveVcvoFh1hDf+H/gD5kOGNRu9+9lDn3LBIS3thqK+1NKmA736a580dhSXgyBaxLKBrjoNSPRHyFULgJfIxxuByOKnUcjZ2eX4aHKCbCfm6G5RqDuqrjDRMxe6C2qXvivH23nlyb1ss3r6oBKy6HwGwNmguHS42bb/OD8/KY=
Received: from MWHPR0201CA0041.namprd02.prod.outlook.com
 (2603:10b6:301:73::18) by SN6PR02MB5118.namprd02.prod.outlook.com
 (2603:10b6:805:68::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.15; Mon, 17 Sep
 2018 13:44:54 +0000
Received: from SN1NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by MWHPR0201CA0041.outlook.office365.com
 (2603:10b6:301:73::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Mon, 17 Sep 2018 13:44:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT013.mail.protection.outlook.com (10.152.72.98) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Mon, 17 Sep 2018 13:44:53 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:51777 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1tpc-0000bS-NA; Mon, 17 Sep 2018 06:44:52 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1tpX-00056M-ID; Mon, 17 Sep 2018 06:44:47 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8HDihRg028455;
        Mon, 17 Sep 2018 06:44:43 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g1tpS-00054e-S0; Mon, 17 Sep 2018 06:44:43 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 1338A12142C; Mon, 17 Sep 2018 19:14:42 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>
CC:     <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 1/6] edac: synopsys: Fix code comments and naming convention
Date:   Mon, 17 Sep 2018 19:14:28 +0530
Message-ID: <1537191873-6582-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537191873-6582-1-git-send-email-manish.narani@xilinx.com>
References: <1537191873-6582-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(39850400004)(2980300002)(438002)(199004)(189003)(106002)(336012)(63266004)(316002)(51416003)(76176011)(42186006)(2906002)(16586007)(44832011)(11346002)(446003)(6666003)(5660300001)(48376002)(90966002)(103686004)(8676002)(126002)(2616005)(50466002)(7049001)(186003)(110136005)(486006)(54906003)(36386004)(2201001)(52956003)(14444005)(106466001)(5024004)(476003)(305945005)(72206003)(356003)(4326008)(36756003)(426003)(6266002)(81156014)(8936002)(50226002)(47776003)(26005)(81166006)(478600001)(107986001)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5118;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT013;1:PBMa10QbYxk4/iS9LUuHnJYlVCPanPvwEGsZ6YTie9FTU5cOT5DJ6sYZ14v5/6HX6AAV68VUBqIMLBRvqnP6zOmHjcrN0Q6UFYZ4XlbrKBD0nzDW6gp7pDpiEAT4nWmE
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c762a234-efc3-4981-0ea9-08d61ca3bf63
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB5118;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5118;3:PsqM0LdcwAOyX3r+l68yrCoCbYSmWy4FCL6naChrhoeT4qzVQLSXT6riud89EFBFWhe6ge16odf+Ejps0rZ/oLF1omK3AgpyGSozch9zLXOJto3DyZE+u8H12dIYl5+qxRGxssJ8HWb0hHJ0DcS3Du4ZPIC6qu4Dd9tFDD92Eiko85juk51rJX916NONCbjOKi4xblZ6asuiS5UQT4HLAAVM4NxZLyejgXon9Nn12WOqjIwF8gpJzuEMK7auUUmP3kW29H2T7+sA4WyHzY3NDMa2Ei/rZKv1atosR5qLeVqIkO7Yalji/wWJjtunKDgcopsPT5JnBnpt+TwBCI5AAPTeZNNEtbl+hIoMLEGzbl8=;25:D1szb7KcNhAD/cY+xIFVXMwfRGgm/uZ2czPP7AKPale1cPkNOa5wAM3Oxd7q7S1CmMhF75GjE9XjNuV1Mu50FAuHa0Som76CPJW56c5y9jg+CFi8e8VX5eek5ghmEheCPRR4UcAHnDqNXb5Xiuod7R/q2TqmvPLxxRixZbCrLw8MPdPYISX5YcUhAy5ypc3yceoYaw/jIT3tUaQt8uAF3M7ptQ/uiJ0JYM6Pini962HNBuVZTgmRmcJa36ZDSW/PqksiB4O7HTyKpBXP0Xd2fiS65S6CBK7hYh7PVr045aSduuU2KAihp9T/2tcuMDZ0ulGrvBT7EYviXNiKN/R0Ag==
X-MS-TrafficTypeDiagnostic: SN6PR02MB5118:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5118;31:PJU/FOeqAgO41PbZ5WEgPQYRCnwT6z7BWUlnh2ncElk+ElgD0fU/EpG4MB7/3xqw/INng3ctZ8TufHJuOCZq0jFQSes/uZTKTItpkLzxDcBIR5aNQ/j1ST1yTy2/knzEHo02dkGZGlizcQL9VmjSSvJXEx6VK9WZ5KbDPXIHUeMnfiKf6p00soSLCFm5eMX7O/XdjX+pMx49aX/31IoRjVKGkXqEqAR4wueUh/Y9Y8Y=;20:6U0niNos1vQ1lxP0IphXhKInFtiCGEpqh6XOT+0ucfv3sdVmGccz9/VujE0ss6+OOLuYAk6CON1H2QWLN41TFyO8torLKJ5WNGtHbNGBi2tV7rNfkrQhHwyne9/Iy0ZeMsPM2dE950Kh8H5QmwBCIzZNeLbAjv9FSGQxwiNY+YqRIQcXfDsu4TueCe9nNeb4KQfSgtgfzUYd1VUU3EIXUQ8tzepQMeFMlKESh6vqaLItexYA3o4xy64cOdATiRIYuv5InsBzE9rZPwKTFdPhePWUn7QkMVP02tULUGjbD2Q+lu2mpBuuFVOlHSNEav/9plA1e1JHkjDnKlsZa98zZyMNmhnnuISUloG8QZKrTOj4k7aKohOinnIgfAWndQzZBQ/FKV5NENJtHYzexlAPb+mIY8sOKfXnED3GB06Wrr8h8Dqz5U6Fo9Kr+FjoCTrPcZKTzvI6FaUoOwxVRZdGci7eylyXgrCb8TUxVIkrXvaK5rdFzMFYwfMNO/aLxZdK
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB51187FD626318E05266197ADC11E0@SN6PR02MB5118.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(105169848403564)(163750095850);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050);SRVR:SN6PR02MB5118;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB5118;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5118;4:Fy1+n2X7WgCA7IXcxo1GBET4CtzcKoDKVxKnG7+TsEFpykSBZG0JW4kjonFfq5oV4P7S7Woy+pL9VYnziBNyRFLqQ3IyJY0A6Uhs5ARl/p9imzQpXFP/gKUB2tgJZUIcqRCjuDvSwU8vA0IsPeVbx3gGUhKJxSk1Fn7xgv5wb+sjpbB9m5iMdIpC/KsQ7zGS7Efctcz5w6+CNwooJS52ZSY4wEvbQrVWPl1Ge5jfjtyJmi5dATYC4LJpFd/NKiG65JVTC/iHIv2cThUeqfikDgK1PMEIA957qk5QFBpbJ0Dd+Kg+BlMYLvlq3CEpG8HTr/SzK4eVpREzyy+UJbllUjGcKXXcpVQPdksLqoHNccOe00G2Q+5tSP7uKWP+5pJC
X-Forefront-PRVS: 0798146F16
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB5118;23:iIVTmnGwmITZt5DpXST9FxpB//FzHVOSqCohTG5j3?=
 =?us-ascii?Q?yzbUmChVHXijnJ9NzcjQlkX/xIwSf0mbsAhMu/0rJyhYbjzog79bTdV3cPka?=
 =?us-ascii?Q?DZzIORNdhhyb7HYhE8RJaaDjdUn0KMN/p8KwEju+2G5Pv32DFs0Kzno/z111?=
 =?us-ascii?Q?5BXGGW3ffwRmZgOw7e0lOUt7QJFLOjiI7yk0ajFU5OcN8DVKSFn8hMJBGEDj?=
 =?us-ascii?Q?rPk8h8PCABfjneI844B8yMyS4kGyTRkkI+mgAxx7RlXtsvWWAlpxXF4Cep1i?=
 =?us-ascii?Q?Hm0aJGYikxc2b079zQdfLFBp5OQWXdxgwAptBryCTsLZXnF5xTwWRlHGmLIa?=
 =?us-ascii?Q?JXIKWSsBLLP+fwxCVlje6GRWypyzABRnFNWtv6CZF1yt9YsV/2JR0BPusegI?=
 =?us-ascii?Q?OzNDaRRrbVEyOVVLxx8XIaKSz6OJvFr5U9fK6r6VFN9MLBDQRW73uoA7jF7x?=
 =?us-ascii?Q?Qs+9++9aNCwS9tMVuBjViRPvYzo9qWH21T1jqiFJ3FhNlIbbQo9l97Qc8QNk?=
 =?us-ascii?Q?1nytLAB7T51Tx//TbGV/r9b3h5AhXJTP63SKPJMa99JX4QaqdQvZChFXheQd?=
 =?us-ascii?Q?TZg5V0VxkiavKFZbpnXvPPBOkzCK8FWZXAATyQ8eicslhvwVcWyi0dAENxMl?=
 =?us-ascii?Q?EpcdMoFwEE/gayyf8JBM5YjKLOnVmNCBvkQpbcXZ5hBYgvGJ0bdKSP4dXSrA?=
 =?us-ascii?Q?HCjS6YRSxoMXIVBPe14uATY6DvzXKnLXUNnl2h0cEd2f6M/qDX3fEkTirnLM?=
 =?us-ascii?Q?0wV64yV7dJTBYxLI90QrwPTqVbHhgYNTCiDEx4rygNrLcazQ1ijfofoTV25a?=
 =?us-ascii?Q?fK+Io8POI0jxI3Iem5D8pP6UOV/xfvrvan/UDVvL0ThCFyrBg6n90EFIAJ2C?=
 =?us-ascii?Q?+VYPPL8SW+Z22akCpsYqA59py/xnYgYZAhbvwM0JKl/e4YvePWdtuJsYoJ0W?=
 =?us-ascii?Q?nbAzlFBK3v23oU1fCnRnZZ9Yhvwd5fyLYivZ9Rg3d+waF6mODn74fdb4toBr?=
 =?us-ascii?Q?24KGwLcmRk4kW+JxpUfLhuuOsqziQR8QUz4tgEZhGek+9XoSw+wOtpqBF2HR?=
 =?us-ascii?Q?L3Lzf9j+vIDzqlTGFsRZUdOWSBRlB5Hf0Bw26eaz4VWHCS/jQVfCp1a25hsK?=
 =?us-ascii?Q?rahkOCfx++dvRCchkK/M7G07EzRpnNHVVP96bZPwgyomZaXj8n0LAbtANKaO?=
 =?us-ascii?Q?iYW6sjPOk9cQfyW93NnI6ZDAGR8t2dbjQXw8Yk27Mq/5JdvLrMW1JVg4NTti?=
 =?us-ascii?Q?8GwbAZjm6gHvWTMTuKayDdaUAflGoWyxmakPnMJyvVek6DHSq+TcyeD5jXXm?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: QMkORVSrDZdRK7WeNQPU0j/DUcSBiT1fuoaMc4edwgcrrUtiOmdSClxJh5znwNKxrSks4u+wp/zb+cupm35KSrI86DgraiCkOMwUvyfImeMEZUBKL33W3GG+WybHhMd2+kzo2/kY+l65v/EhZztq0fNsYWeToemsoBIOEhukAmfDrnbPiALKmq0jfBjya7/Zo6ds4OTJXXjVz+CJETBLxWf2ET8AWlVlPO4HEB0X2gmfllLtPHUfaA95IR3OXmmIMBWWhev7ck3Hfl/MfJw6RAEI4RNdem35KkR7Pa9iVgkR+P1i/urO3GfnpafeEqRK4HpQULHgF5QDY+xx4nDDe1NcbHiSFIXemcTFT3I9b6E=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5118;6:sVSGs+XMEZQ6A9of9N7uoeMcoeswej6Pdbkkq1fORpK1pEd1zeNpYszjIeZUvVhsmXx+edRqhxiuTsCLAziPFqKHDs9qWgZbniWCXT+bEspxaRWu+U4C3HecXGzrEK1/l6uXZ6fouN9poi2tYzyyl9F668y9qwF6MpeLmukdGBgjHl/ic4snwJn7F/ci+mVRAv0cPhOAvOqNLQB/HLqJ1ATRqCP9I1YF/ss6LXkKq//YE1eF5bGO7nWLU6XnD71aE04hmZSHrkxEMJAGO04Tz04KQk5GVTG0oR5cRo1QTbg2corXJKnCAXGPoEZnUxAn/HKqq0KWaDcsQDnIoQFqQYTOKwh33zETIKOw0BfmvvqYidyJLCOA7GK1ueuf69R3u8nPxEWwzCo2vsGt16WTWX4O+2aNnQwT346fRzSJp08CoBzVgoZm22XjmwrvGcE+sjxNHqoLURTuwtXU4RmdQA==;5:O116FJglOsCA4QcdDXR+7EbHEOQ0vBmUI7rlyeuxJL2sfdRHnWf5tgXAfDn2pKWvBzAOgv7ky6QarEnrc0E8S5lSqZko/9lPRYHzu31aZNms30idB4XMa2hozfVhInb+dzIR4CSxa8ctw+0SbrU7FSe+hSGU/DBzxefsjGNwnNc=;7:rJhcRTam0WQxXo+E8hO2S73Qldfk5fOVl493kUvXHJBluLEscVH4yTHDeIhx+YI+yd75b6CQrqSem+M4h69VDJd+lgZ40CTjl6DXqulhELoSnatj9OB3zWkN1oE6a+bUseG4F9C/UQWvJuvrgZYdhCtiUcUoDr+xt791cXx/607OlqerytPgLd7uIfCvWRT9HvOglzMCFKIPGJgtNjBtGwuGpwXchLUOpbrWtgV3bRyKGFjoedll6Tv9KeMaXUP4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 13:44:53.1315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c762a234-efc3-4981-0ea9-08d61ca3bf63
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the comments in the Synopsys EDAC driver. Minor changes to function
names and return types are also included.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 176 ++++++++++++++++++++-----------------------
 1 file changed, 80 insertions(+), 96 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 0c9c59e..4963930 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -96,12 +96,12 @@
 #define SCRUB_MODE_SECDED	0x4
 
 /**
- * struct ecc_error_info - ECC error log information
- * @row:	Row number
- * @col:	Column number
- * @bank:	Bank number
- * @bitpos:	Bit position
- * @data:	Data causing the error
+ * struct ecc_error_info - ECC error log information.
+ * @row:	Row number.
+ * @col:	Column number.
+ * @bank:	Bank number.
+ * @bitpos:	Bit position.
+ * @data:	Data causing the error.
  */
 struct ecc_error_info {
 	u32 row;
@@ -112,11 +112,11 @@ struct ecc_error_info {
 };
 
 /**
- * struct synps_ecc_status - ECC status information to report
- * @ce_cnt:	Correctable error count
- * @ue_cnt:	Uncorrectable error count
- * @ceinfo:	Correctable error log information
- * @ueinfo:	Uncorrectable error log information
+ * struct synps_ecc_status - ECC status information to report.
+ * @ce_cnt:	Correctable error count.
+ * @ue_cnt:	Uncorrectable error count.
+ * @ceinfo:	Correctable error log information.
+ * @ueinfo:	Uncorrectable error log information.
  */
 struct synps_ecc_status {
 	u32 ce_cnt;
@@ -126,12 +126,12 @@ struct synps_ecc_status {
 };
 
 /**
- * struct synps_edac_priv - DDR memory controller private instance data
- * @baseaddr:	Base address of the DDR controller
- * @message:	Buffer for framing the event specific info
- * @stat:	ECC status information
- * @ce_cnt:	Correctable Error count
- * @ue_cnt:	Uncorrectable Error count
+ * struct synps_edac_priv - DDR memory controller private instance data.
+ * @baseaddr:	Base address of the DDR controller.
+ * @message:	Buffer for framing the event specific info.
+ * @stat:	ECC status information.
+ * @ce_cnt:	Correctable Error count.
+ * @ue_cnt:	Uncorrectable Error count.
  */
 struct synps_edac_priv {
 	void __iomem *baseaddr;
@@ -142,15 +142,13 @@ struct synps_edac_priv {
 };
 
 /**
- * synps_edac_geterror_info - Get the current ecc error info
- * @base:	Pointer to the base address of the ddr memory controller
- * @p:		Pointer to the synopsys ecc status structure
+ * edac_geterror_info - Get the current ECC error info.
+ * @base:	Base address of the DDR memory controller.
+ * @p:		Synopsys ECC status structure.
  *
- * Determines there is any ecc error or not
- *
- * Return: one if there is no error otherwise returns zero
+ * Return: one if there is no error otherwise returns zero.
  */
-static int synps_edac_geterror_info(void __iomem *base,
+static int edac_geterror_info(void __iomem *base,
 				    struct synps_ecc_status *p)
 {
 	u32 regval, clearval = 0;
@@ -172,7 +170,7 @@ static int synps_edac_geterror_info(void __iomem *base,
 	p->ceinfo.col = regval & ADDR_COL_MASK;
 	p->ceinfo.bank = (regval & ADDR_BANK_MASK) >> ADDR_BANK_SHIFT;
 	p->ceinfo.data = readl(base + CE_DATA_31_0_OFST);
-	edac_dbg(3, "ce bit position: %d data: %d\n", p->ceinfo.bitpos,
+	edac_dbg(3, "CE bit position: %d data: %d\n", p->ceinfo.bitpos,
 		 p->ceinfo.data);
 	clearval = ECC_CTRL_CLR_CE_ERR;
 
@@ -196,13 +194,13 @@ static int synps_edac_geterror_info(void __iomem *base,
 }
 
 /**
- * synps_edac_handle_error - Handle controller error types CE and UE
- * @mci:	Pointer to the edac memory controller instance
- * @p:		Pointer to the synopsys ecc status structure
+ * edac_handle_error - Handle controller error types CE and UE.
+ * @mci:	EDAC memory controller instance.
+ * @p:		Synopsys ECC status structure.
  *
- * Handles the controller ECC correctable and un correctable error.
+ * Handles the controller ECC correctable and un-correctable error.
  */
-static void synps_edac_handle_error(struct mem_ctl_info *mci,
+static void edac_handle_error(struct mem_ctl_info *mci,
 				    struct synps_ecc_status *p)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
@@ -232,38 +230,38 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
 }
 
 /**
- * synps_edac_check - Check controller for ECC errors
- * @mci:	Pointer to the edac memory controller instance
+ * edac_check - Check controller for ECC errors.
+ * @mci:	EDAC memory controller instance.
  *
- * Used to check and post ECC errors. Called by the polling thread
+ * Used to check and post ECC errors. Called by the polling thread.
  */
-static void synps_edac_check(struct mem_ctl_info *mci)
+static void edac_check(struct mem_ctl_info *mci)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
 	int status;
 
-	status = synps_edac_geterror_info(priv->baseaddr, &priv->stat);
+	status = edac_geterror_info(priv->baseaddr, &priv->stat);
 	if (status)
 		return;
 
 	priv->ce_cnt += priv->stat.ce_cnt;
 	priv->ue_cnt += priv->stat.ue_cnt;
-	synps_edac_handle_error(mci, &priv->stat);
+	edac_handle_error(mci, &priv->stat);
 
-	edac_dbg(3, "Total error count ce %d ue %d\n",
+	edac_dbg(3, "Total error count CE %d UE %d\n",
 		 priv->ce_cnt, priv->ue_cnt);
 }
 
 /**
- * synps_edac_get_dtype - Return the controller memory width
- * @base:	Pointer to the ddr memory controller base address
+ * edac_get_dtype - Return the controller memory width.
+ * @base:	DDR memory controller base address.
  *
  * Get the EDAC device type width appropriate for the current controller
  * configuration.
  *
  * Return: a device type width enumeration.
  */
-static enum dev_type synps_edac_get_dtype(const void __iomem *base)
+static enum dev_type edac_get_dtype(const void __iomem *base)
 {
 	enum dev_type dt;
 	u32 width;
@@ -286,20 +284,20 @@ static enum dev_type synps_edac_get_dtype(const void __iomem *base)
 }
 
 /**
- * synps_edac_get_eccstate - Return the controller ecc enable/disable status
- * @base:	Pointer to the ddr memory controller base address
+ * edac_get_eccstate - Return the controller ECC enable/disable status.
+ * @base:	DDR memory controller base address.
  *
- * Get the ECC enable/disable status for the controller
+ * Get the ECC enable/disable status for the controller.
  *
- * Return: a ecc status boolean i.e true/false - enabled/disabled.
+ * Return: a ECC status boolean i.e true/false - enabled/disabled.
  */
-static bool synps_edac_get_eccstate(void __iomem *base)
+static bool edac_get_eccstate(void __iomem *base)
 {
+	bool state = false;
 	enum dev_type dt;
 	u32 ecctype;
-	bool state = false;
 
-	dt = synps_edac_get_dtype(base);
+	dt = edac_get_dtype(base);
 	if (dt == DEV_UNKNOWN)
 		return state;
 
@@ -311,11 +309,11 @@ static bool synps_edac_get_eccstate(void __iomem *base)
 }
 
 /**
- * synps_edac_get_memsize - reads the size of the attached memory device
+ * edac_get_memsize - reads the size of the attached memory device.
  *
- * Return: the memory size in bytes
+ * Return: the memory size in bytes.
  */
-static u32 synps_edac_get_memsize(void)
+static u32 edac_get_memsize(void)
 {
 	struct sysinfo inf;
 
@@ -325,15 +323,15 @@ static u32 synps_edac_get_memsize(void)
 }
 
 /**
- * synps_edac_get_mtype - Returns controller memory type
- * @base:	pointer to the synopsys ecc status structure
+ * edac_get_mtype - Returns controller memory type.
+ * @base:	Synopsys ECC status structure.
  *
  * Get the EDAC memory type appropriate for the current controller
  * configuration.
  *
  * Return: a memory type enumeration.
  */
-static enum mem_type synps_edac_get_mtype(const void __iomem *base)
+static enum mem_type edac_get_mtype(const void __iomem *base)
 {
 	enum mem_type mt;
 	u32 memtype;
@@ -349,54 +347,47 @@ static enum mem_type synps_edac_get_mtype(const void __iomem *base)
 }
 
 /**
- * synps_edac_init_csrows - Initialize the cs row data
- * @mci:	Pointer to the edac memory controller instance
+ * edac_init_csrows - Initialize the cs row data.
+ * @mci:	EDAC memory controller instance.
  *
  * Initializes the chip select rows associated with the EDAC memory
- * controller instance
- *
- * Return: Unconditionally 0.
+ * controller instance.
  */
-static int synps_edac_init_csrows(struct mem_ctl_info *mci)
+static void edac_init_csrows(struct mem_ctl_info *mci)
 {
+	struct synps_edac_priv *priv = mci->pvt_info;
 	struct csrow_info *csi;
 	struct dimm_info *dimm;
-	struct synps_edac_priv *priv = mci->pvt_info;
-	u32 size;
-	int row, j;
+	u32 size, row;
+	int j;
 
 	for (row = 0; row < mci->nr_csrows; row++) {
 		csi = mci->csrows[row];
-		size = synps_edac_get_memsize();
+		size = edac_get_memsize();
 
 		for (j = 0; j < csi->nr_channels; j++) {
-			dimm            = csi->channels[j]->dimm;
-			dimm->edac_mode = EDAC_FLAG_SECDED;
-			dimm->mtype     = synps_edac_get_mtype(priv->baseaddr);
-			dimm->nr_pages  = (size >> PAGE_SHIFT) / csi->nr_channels;
-			dimm->grain     = SYNPS_EDAC_ERR_GRAIN;
-			dimm->dtype     = synps_edac_get_dtype(priv->baseaddr);
+			dimm		= csi->channels[j]->dimm;
+			dimm->edac_mode	= EDAC_FLAG_SECDED;
+			dimm->mtype	= edac_get_mtype(priv->baseaddr);
+			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
+			dimm->grain	= SYNPS_EDAC_ERR_GRAIN;
+			dimm->dtype	= edac_get_dtype(priv->baseaddr);
 		}
 	}
-
-	return 0;
 }
 
 /**
- * synps_edac_mc_init - Initialize driver instance
- * @mci:	Pointer to the edac memory controller instance
- * @pdev:	Pointer to the platform_device struct
+ * edac_mc_init - Initialize driver instance.
+ * @mci:	EDAC memory controller instance.
+ * @pdev:	platform_device struct.
  *
  * Performs initialization of the EDAC memory controller instance and
  * related driver-private data associated with the memory controller the
  * instance is bound to.
- *
- * Return: Always zero.
  */
-static int synps_edac_mc_init(struct mem_ctl_info *mci,
+static void edac_mc_init(struct mem_ctl_info *mci,
 				 struct platform_device *pdev)
 {
-	int status;
 	struct synps_edac_priv *priv;
 
 	mci->pdev = &pdev->dev;
@@ -415,17 +406,15 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
 	mci->mod_name = SYNPS_EDAC_MOD_VER;
 
 	edac_op_state = EDAC_OPSTATE_POLL;
-	mci->edac_check = synps_edac_check;
+	mci->edac_check = edac_check;
 	mci->ctl_page_to_phys = NULL;
 
-	status = synps_edac_init_csrows(mci);
-
-	return status;
+	edac_init_csrows(mci);
 }
 
 /**
- * synps_edac_mc_probe - Check controller and bind driver
- * @pdev:	Pointer to the platform_device struct
+ * synps_edac_mc_probe - Check controller and bind driver.
+ * @pdev:	platform_device struct.
  *
  * Probes a specific controller instance for binding with the driver.
  *
@@ -434,19 +423,19 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
  */
 static int synps_edac_mc_probe(struct platform_device *pdev)
 {
-	struct mem_ctl_info *mci;
 	struct edac_mc_layer layers[2];
 	struct synps_edac_priv *priv;
-	int rc;
-	struct resource *res;
+	struct mem_ctl_info *mci;
 	void __iomem *baseaddr;
+	struct resource *res;
+	int rc;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	baseaddr = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(baseaddr))
 		return PTR_ERR(baseaddr);
 
-	if (!synps_edac_get_eccstate(baseaddr)) {
+	if (!edac_get_eccstate(baseaddr)) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
 	}
@@ -468,12 +457,7 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 
 	priv = mci->pvt_info;
 	priv->baseaddr = baseaddr;
-	rc = synps_edac_mc_init(mci, pdev);
-	if (rc) {
-		edac_printk(KERN_ERR, EDAC_MC,
-			    "Failed to initialize instance\n");
-		goto free_edac_mc;
-	}
+	edac_mc_init(mci, pdev);
 
 	rc = edac_mc_add_mc(mci);
 	if (rc) {
@@ -496,8 +480,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 }
 
 /**
- * synps_edac_mc_remove - Unbind driver from controller
- * @pdev:	Pointer to the platform_device struct
+ * synps_edac_mc_remove - Unbind driver from controller.
+ * @pdev:	Platform_device struct.
  *
  * Return: Unconditionally 0
  */
-- 
2.1.1

