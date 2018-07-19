Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88693C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1591F20856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="H/GjboPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1591F20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbeGSKsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:48:40 -0400
Received: from mail-eopbgr710072.outbound.protection.outlook.com ([40.107.71.72]:42025
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727345AbeGSKsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGtZ4sPs9HajwoBLeUFkBvNgJf1Xp5WBbUCqxsE6gmI=;
 b=H/GjboPUo0jA8uCVlrsXe+U6fTgSzvOCwOuhoHY/JtcVv74VPapV+Lf7AWyTQSvd5wlFrUoEJThykTwC5qyOgLYLNoXhqL6SGZjUiUIzUtpM0TjNn4Dse5OGURrZdbV94iWz5grqkShfVj0vv+UYMhhGBpJDxa+Q6pWi6ELj3AI=
Received: from BL0PR02CA0094.namprd02.prod.outlook.com (2603:10b6:208:51::35)
 by SN1PR02MB1630.namprd02.prod.outlook.com (2a01:111:e400:519f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.19; Thu, 19 Jul
 2018 10:06:04 +0000
Received: from BL2NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by BL0PR02CA0094.outlook.office365.com
 (2603:10b6:208:51::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 10:06:04 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT049.mail.protection.outlook.com (10.152.77.118) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Thu, 19 Jul 2018 10:06:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fg5ow-0007dS-Nc; Thu, 19 Jul 2018 03:06:02 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fg5or-0003wa-Jy; Thu, 19 Jul 2018 03:05:57 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6JA5r0O008727;
        Thu, 19 Jul 2018 03:05:53 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1fg5om-0003vr-KQ; Thu, 19 Jul 2018 03:05:53 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id C50901215D6; Thu, 19 Jul 2018 15:35:51 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        <bp@alien8.de>, <mchehab@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
CC:     <anirudh@xilinx.com>, <sgoud@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 3/4] edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
Date:   Thu, 19 Jul 2018 15:35:46 +0530
Message-ID: <1531994747-15196-4-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1531994747-15196-1-git-send-email-manish.narani@xilinx.com>
References: <1531994747-15196-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(346002)(2980300002)(438002)(189003)(199004)(103686004)(8936002)(14444005)(186003)(52956003)(106466001)(76176011)(63266004)(336012)(90966002)(2906002)(26005)(50466002)(106002)(81156014)(2201001)(51416003)(48376002)(81166006)(47776003)(217873002)(54906003)(8676002)(316002)(110136005)(16586007)(4326008)(42186006)(305945005)(6266002)(356003)(44832011)(6666003)(478600001)(50226002)(476003)(126002)(486006)(107886003)(2616005)(36756003)(11346002)(426003)(72206003)(36386004)(53946003)(5024004)(5660300001)(446003)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB1630;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT049;1:8hZ3TptHv5yRaEIeZPNuVr1Hmxbhb4uxDEe7ct4tkPzmV9MESEnyEc/KkjAGFP65+N/qb6Q+S1KnHhFRbVtQDybF5D79nsrcAV9GTgPYrseDeHlSm2JnQLC9/vMnqXiB
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 840c32d6-a7b4-41c4-dab7-08d5ed5f3cb1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN1PR02MB1630;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1630;3:N/229UIyeRVtTRy7+MpL9tdZ411r6lGWkrf2DyVeS/BV4ZQewMzPyzgI+LLD7HYmB6bB8mfWvnTLPGI5f7m2Pnu3hRQh51HRsI1COT5ejeCiH6qN7V+rhPabNbzuYGAoVe5BkVkMbjZwQQ2+HeIOZDs4fYkPDCUokmd2xfv32UlpAASXxe8sChwwDtxIfRTgtRNn2IPaqkCviTBNrRHjo/r2x8WntGGFgv8OmXErQdUcJLOOBnTQAa0pYVPovPv7vsw8V+PT/scLhLyGwEyDGrWfqUJs0Q6LuW9wQh2BOhSDlTvG1BNUl79neF3ctSapX1jBiK67IniBQk8pNeFjx1/RPgUeZk5SYoqxcRagJW8=;25:71wAP6r+NaYPOy7kiyYqd/bpUqJT2y+BmfSumG/FvUmVueqzbYrahUv0Nlph+KntcmmaA5N6lEl599YHNXavxG/t5Bun/8vvh4yJ2PovVa+fa5SpWzF1vC9hPALOAa/wPSOZ7eA83MV1lJcyLkz3z7G3zIjZDBAXsveAGiPptd+gAo4yPXT9VdOwtn2cN7Ltf2FggW3fSG/9s+w1mRd5hKf2WZkLcRvOqY3VG8sV7hEXrisqrjG/m9X413xBgoB4p5QhsYWb3BVyN/Su+U4iF18k6yLDqTfuz6PBBSeWaQcYs19sDtqMwftZ9rV2Kf2H2/M1xd/lGCV2NS86JrlVQkhmo16EeHWqNDcmXcFWgog=
X-MS-TrafficTypeDiagnostic: SN1PR02MB1630:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1630;31:EgE39XEyhG20T2RzFd6aZsd5wg3LNiq7J7lucJibxrmIk64KO5UKaKRCvjnAy+X8lSINchyygccdNxeH9c3eyG13sOPke47uTXBzNHW2k7F2EDBYlsBxbGObeQ/X42EZsaNutdg4sQqC2zrEG9ra9PvOKVYV9aQYPJGnqDoDoeciH3VtEJmqNen5QY1Rdes4KXKdQlMGampu3HlaXWOZiqVEZmPkjV2a26QGeazZjDw=;20:YzXsYvchN2eONPuk3epEL7HssdqWTydLiSfG1yWBBmbCitxIghgnivqTsiJzUF5hhmrVcwR3gTC0keVnR/q6XQF4am1TaCFanIZFw2VZs1ebixh/TfA1y/93vbuRtjFjb72YQMW4Jkb6Hrt57EjA2jhR7sdmSXNHn05lb/cZ48r4SJPFZ7bBw7wMnN92JxL9mqDsyjuES5eSciimO6V00seCHJVL3l0zeV1t9YWmlKEM1dp5pknpLB9pNzHEwOTHYU1D8TR0lHnOH9Kii8pBFkoDJFAphsNXygymzu58knIlzF6n9QmeEYANJ/FO6g4zGhTHQCMd+Uy3DAcevWPCCjsNGDjeTpF4rq0atLTvTqN5J/LZMB72n5QkR8THt7VdHxcEiiA/rGeaU5ZognygMUc6C7jPLyC+kpU1Gis+DFLaM/4JVSjyCx0GAWcFtW+4X/WlZS7LWlxibxeZU9icCiavYkx0ZUpgkKCx7Cfkb90zjbxtcaMz4ofJEG0mu4Vt
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR02MB16301553D40474D77D3F5997C1520@SN1PR02MB1630.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN1PR02MB1630;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB1630;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1630;4:HHKmBRXzqf3+1IermU4M2bP8uA4bYY7PqY0hEmF4AZOCEmliTBwov/wtGdwhB7meMMDkjEugGX+Rk78ugWJGoA77SaIYmhnP+A2O/DavDlLv5JLWLcNu/qGtTbu4pWlhcRHTaZWi50VeVxsM8CORXZK3QiPo8dZcdO2Kdg6tVyIdUUhdWNkkvlhKAg3MF0gDaCaebyxiBT+Gon/iSMIN6N1Fs434FVQiBjuN85PebDEN6Goq92KQOi6eu6SvbJQCvSGnNkucwnmgkJ2HQYLQgMo48aCF0VGK/MOma1+CHqOAACHseeGllELdPOmht9Gl
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR02MB1630;23:MOG4wEidbFUoTmZVfJgQX7wKKqRQBYIF5R9SAhJvh?=
 =?us-ascii?Q?ROHUjDTJsATkD1cGNaDG0ZwaBZQrXFnXC1rhJLzp/GLb6r3W52gnzLscKoYf?=
 =?us-ascii?Q?TVvRGpCv21sZPZZwELbnQAN/PXARCy7A8Qyc9G4NzRBlz7rXtKf/1IooYTpn?=
 =?us-ascii?Q?ba0FFpOmWTkTnwZBLCG8AEMvkDcMfUhY8xgp3mxUp+Urt9Jp6U6NKMEpqIlc?=
 =?us-ascii?Q?ttE3M+gZ2md2/+oz9OP9sTOT5/lQ7z8CVbf12tb4bAw58K4LM8Wq2sc82kv4?=
 =?us-ascii?Q?vLZTEBBjGgN9yHx1d8gYV3A7hhMA7sEuZ027saPtoccZN3GZjzxoRpIS7HzM?=
 =?us-ascii?Q?gKzaaR9n9J7bXl40frKR3UzbaQktCNoE9NN3/PTj10fSt+vSnLvo+dQ/pe4i?=
 =?us-ascii?Q?qbDIZK4noHqj4DrZpR48lOL+ZgOO/cbcE29nF5351sOilY8Y0s6OcGsusRlm?=
 =?us-ascii?Q?ssgxPko0+Ja3qzES2HeQd8fu7SjoamfOPVfiOdMI9mubRjZ957hCb+OiPK9P?=
 =?us-ascii?Q?ce0Orld67N59nYyeXWyYJNhTu+fOGvecXwzgaJqao0d2PpSfDMm7Uwi2xH9u?=
 =?us-ascii?Q?W5v282iqgGBrg1numggXX9d8qe2A2oF8JuXQaZeXmveY/raPdc92/iiNw8TB?=
 =?us-ascii?Q?FwOoPvyjILijOksP91thGNtMKBtXKI1Lvrleju7tz+LFEJU5KDNKGXuuZdJj?=
 =?us-ascii?Q?Q7DZofVkQSzzR+4omGAOAbmfmQsR5omtSGl+yEHn6y+uwl9JNNzlVo/ZtbP4?=
 =?us-ascii?Q?u8nZHLgVMexEwUkpphyWgrWPDACh87dcRoe/P7hJ/UDnYb8WcjUMurYU3VcU?=
 =?us-ascii?Q?uPEZKdEmPPnArvfigJF76jTl2+uGPIROcoLx8wmm4sUBr8m2YP/THKuhT6Ti?=
 =?us-ascii?Q?m541amwpiJuSDBOUWv9wjlO7EF1a1JxXKUZgmOw7EOgrRfoeIdUj8290mEUv?=
 =?us-ascii?Q?yOzpbOCZLJwnCs2GXitM2cFBSlj5HHxZ46a6FLyYrbhmJdBPaIykkivw92oq?=
 =?us-ascii?Q?9TXHDL2xDUHJCCa7TbF9jY8BKLe3VkNzTh6/pBhkEY2peqYQBqSCuZBjgSjD?=
 =?us-ascii?Q?W6NOWe1dQ+tTPae7dcBIwCyhbpBPIq7Oh5tHdC/QHjLiziMXuvES1X2pzBkb?=
 =?us-ascii?Q?E3ZEnOpLzE74XHpDxUxTT0oVrK6xaad3uJ6htm0qlQ6H4fxXbLzQA9RCQpGe?=
 =?us-ascii?Q?Y12qf+Tm4vf/XB+9Ip99jzl/IYySTl43LLxuVRDzfXCptakKGjl/rKsTo2MI?=
 =?us-ascii?Q?fKqL9f7AADd1EMNOvNsqZTaijZJcu1M3ATCZZbaOwSzAmXPp3WqesU6HcR5W?=
 =?us-ascii?Q?ZfgoNztyzv1WBTCAs/VHhY=3D?=
X-Microsoft-Antispam-Message-Info: ghblYxeDQW1gzcsWyOaXZ+j58IXP+Tv2gHvBzf/pinWTGy2eAyIDjRIO+E1v258sLsaSXnHFCfkQMzhO72THFcjjRke0yKFnVNciUmoOy5ijvsTujjiYVTyjFJJtruBn1DWgsURDRAaL7alfyCBV3dcCV4mjgMu1zmBu5VYXJ/lJM4ew6HIzxjEYBGs76FTJjNjAjdD2EnsTUw3hrqoWRm1dsL42mwd7frw3sOukhZAEhnIelCPjZV3h9QJfWxlcnhIA4Jkio8srku9vTiCfKpnbR2NxP2b+4MB43qlYGWx7/fMKwv4uGv07QQ7OJRh/dI+HzMEW+P2s6tErPaOp7YWoxxWtvHlbpcriE/huIy0=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1630;6:yg2Ljxpj9dEHGvwtNFqgmQLIpvuXk46yaTnO9caPQvf0p17dU9lzJqZMqRZp+eE6vKAaehaYpBCswaqw/n800j7apDivr6DtbGwbu0+s7aldubr2jawXiTsrXL012ei/LgJrDYW5PqoqAkgrIWB2mi3P/KUZVtFWNBmRP4KVnfusmB7H2J/Iq4fautESU8tQQEE9j45jYuQm3pgp54x7thxkVcuJWHDsMcUM5wdx70Yqrz1CBK4ZL8hLtv7qMa9omPv/Mosrs1laj2RjFvCHKw7Ut0L8bKT5ChYQMFQi5e2UDxrnJSMp0IrJk9K23UfJu6QWrlXHnyfnUHk0nPWQYppGSzhGv5r7r249Euad9Ykisc7ZWlU/qm73Tq5FD3ciMLq40lodwXFaxiJ/yqQ9rqU1Ey23xfSjGjo7Pp6YTx3cA+aj7oPgSyuroq+ZZgNs7HYP8tOnBLYRPCJ6fI/hEQ==;5:3ZrdKPxAuY+bxMYIIIlOfOgtrT9Af5O9Q7few8c5uqOMHGmbnaZEZnWKhGGxe1N+NvjeY6w8l4CBlVODbbYr2AIK9tSjGL8LS/Wqkc7wbvlyGDmZvo1FY3EmZHtz7I9OqqH0kXJHwRTYiC/114XLKxHPZbynG/gBWSL8fEDaNDY=;24:4ja1rDJuihyT2o4i3wXVPd8/l8hhYH1bnyOF23vNkn96HuqBDXsHMg52kpYmsAjk8DBh0Meq7xvhCVnd9q0/hDm7AoLbD3z8k3nxnykNczQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1630;7:xCnQ3+XDmAi4Jkt+SH/05Al9goi6Xto7rDZErXYhgQFu+WA4uW6+T/navrNk9o2ZVa2TtBlg3A9aXsEIiEVRhbful07n/opuLpKGTKecF46UZZe25E0bCL8Fc9uqUIAcgns7ZWBDNaI3vGi8T99ShGtClFY9qj72820hBKJRhU7Oy020sNGcxE5Am460MMOuS/A6aT+Lvx2xDkGfFyEutMl7kA3HV+B/+qhKkLUa8rv5ILrH+6m2kH0qWTdMT47g
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 10:06:03.4695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 840c32d6-a7b4-41c4-dab7-08d5ed5f3cb1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB1630
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds EDAC ECC support for ZynqMP DDRC IP. The patch also adds
support for ECC Error Injection in ZynqMP. The corrected and uncorrected
error interrupts support is added in this patch. The Row, Column, Bank,
Bank Group and Rank bits positions are determined via Address Map
registers of Synopsys DDRC.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/Kconfig         |   2 +-
 drivers/edac/synopsys_edac.c | 848 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 833 insertions(+), 17 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 57304b2..b1fc7a16 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -441,7 +441,7 @@ config EDAC_ALTERA_SDMMC
 
 config EDAC_SYNOPSYS
 	tristate "Synopsys DDR Memory Controller"
-	depends on ARCH_ZYNQ
+	depends on ARCH_ZYNQ || ARM64
 	help
 	  Support for error detection and correction on the Synopsys DDR
 	  memory controller.
diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 447396e..4380eb9 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -22,6 +22,7 @@
 #include <linux/edac.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/interrupt.h>
 #include <linux/of.h>
 
 #include "edac_module.h"
@@ -98,6 +99,164 @@
 
 /* DDR ECC Quirks */
 #define DDR_ECC_INTR_SUPPORT	BIT(0)
+#define DDR_ECC_DATA_POISON_SUPPORT BIT(1)
+
+/* ZynqMP Enhanced DDR memory controller registers that are relevant to ECC */
+/* ECC Configuration Registers */
+#define ECC_CFG0_OFST	0x70
+#define ECC_CFG1_OFST	0x74
+
+/* ECC Status Register */
+#define ECC_STAT_OFST	0x78
+
+/* ECC Clear Register */
+#define ECC_CLR_OFST	0x7C
+
+/* ECC Error count Register */
+#define ECC_ERRCNT_OFST	0x80
+
+/* ECC Corrected Error Address Register */
+#define ECC_CEADDR0_OFST	0x84
+#define ECC_CEADDR1_OFST	0x88
+
+/* ECC Syndrome Registers */
+#define ECC_CSYND0_OFST	0x8C
+#define ECC_CSYND1_OFST	0x90
+#define ECC_CSYND2_OFST	0x94
+
+/* ECC Bit Mask0 Address Register */
+#define ECC_BITMASK0_OFST	0x98
+#define ECC_BITMASK1_OFST	0x9C
+#define ECC_BITMASK2_OFST	0xA0
+
+/* ECC UnCorrected Error Address Register */
+#define ECC_UEADDR0_OFST	0xA4
+#define ECC_UEADDR1_OFST	0xA8
+
+/* ECC Syndrome Registers */
+#define ECC_UESYND0_OFST	0xAC
+#define ECC_UESYND1_OFST	0xB0
+#define ECC_UESYND2_OFST	0xB4
+
+/* ECC Poison Address Reg */
+#define ECC_POISON0_OFST	0xB8
+#define ECC_POISON1_OFST	0xBC
+
+#define ECC_ADDRMAP0_OFFSET	0x200
+
+/* Control register bitfield definitions */
+#define ECC_CTRL_BUSWIDTH_MASK	0x3000
+#define ECC_CTRL_BUSWIDTH_SHIFT	12
+#define ECC_CTRL_CLR_CE_ERRCNT	BIT(2)
+#define ECC_CTRL_CLR_UE_ERRCNT	BIT(3)
+
+/* DDR Control Register width definitions  */
+#define DDRCTL_EWDTH_16		2
+#define DDRCTL_EWDTH_32		1
+#define DDRCTL_EWDTH_64		0
+
+/* ECC status register definitions */
+#define ECC_STAT_UECNT_MASK	0xF0000
+#define ECC_STAT_UECNT_SHIFT	16
+#define ECC_STAT_CECNT_MASK	0xF00
+#define ECC_STAT_CECNT_SHIFT	8
+#define ECC_STAT_BITNUM_MASK	0x7F
+
+/* DDR QOS Interrupt register definitions */
+#define DDR_QOS_IRQ_STAT_OFST	0x20200
+#define DDR_QOSUE_MASK		0x4
+#define	DDR_QOSCE_MASK		0x2
+#define	ECC_CE_UE_INTR_MASK	0x6
+#define DDR_QOS_IRQ_EN_OFST     0x20208
+#define DDR_QOS_IRQ_DB_OFST	0x2020C
+
+/* ECC Corrected Error Register Mask and Shifts*/
+#define ECC_CEADDR0_RW_MASK	0x3FFFF
+#define ECC_CEADDR0_RNK_MASK	BIT(24)
+#define ECC_CEADDR1_BNKGRP_MASK	0x3000000
+#define ECC_CEADDR1_BNKNR_MASK	0x70000
+#define ECC_CEADDR1_BLKNR_MASK	0xFFF
+#define ECC_CEADDR1_BNKGRP_SHIFT	24
+#define ECC_CEADDR1_BNKNR_SHIFT	16
+
+/* ECC Poison register shifts */
+#define ECC_POISON0_RANK_SHIFT 24
+#define ECC_POISON1_BANKGRP_SHIFT 28
+#define ECC_POISON1_BANKNR_SHIFT 24
+
+/* DDR Memory type defines */
+#define MEM_TYPE_DDR3		0x1
+#define MEM_TYPE_LPDDR3		0x8
+#define MEM_TYPE_DDR2		0x4
+#define MEM_TYPE_DDR4		0x10
+#define MEM_TYPE_LPDDR4		0x20
+
+/* DDRC Software control register */
+#define DDRC_SWCTL 0x320
+
+/* DDRC ECC CE & UE poison mask */
+#define ECC_CEPOISON_MASK 0x3
+#define ECC_UEPOISON_MASK 0x1
+
+/* DDRC Device config masks */
+#define DDRC_MSTR_DEV_CONFIG_MASK 0xC0000000
+#define DDRC_MSTR_DEV_CONFIG_SHIFT	30
+#define DDRC_MSTR_DEV_CONFIG_X4_MASK	0x0
+#define DDRC_MSTR_DEV_CONFIG_X8_MASK	0x1
+#define DDRC_MSTR_DEV_CONFIG_X16_MASK	0x2
+#define DDRC_MSTR_DEV_CONFIG_X32_MASK	0x3
+
+#define DDR_MAX_ROW_SHIFT	18
+#define DDR_MAX_COL_SHIFT	14
+#define DDR_MAX_BANK_SHIFT	3
+#define DDR_MAX_BANKGRP_SHIFT	2
+
+#define ROW_MAX_VAL_MASK	0xF
+#define COL_MAX_VAL_MASK	0xF
+#define BANK_MAX_VAL_MASK	0x1F
+#define BANKGRP_MAX_VAL_MASK	0x1F
+#define RANK_MAX_VAL_MASK	0x1F
+
+#define ROW_B0_BASE		6
+#define ROW_B1_BASE		7
+#define ROW_B2_BASE		8
+#define ROW_B3_BASE		9
+#define ROW_B4_BASE		10
+#define ROW_B5_BASE		11
+#define ROW_B6_BASE		12
+#define ROW_B7_BASE		13
+#define ROW_B8_BASE		14
+#define ROW_B9_BASE		15
+#define ROW_B10_BASE		16
+#define ROW_B11_BASE		17
+#define ROW_B12_BASE		18
+#define ROW_B13_BASE		19
+#define ROW_B14_BASE		20
+#define ROW_B15_BASE		21
+#define ROW_B16_BASE		22
+#define ROW_B17_BASE		23
+
+#define COL_B2_BASE		2
+#define COL_B3_BASE		3
+#define COL_B4_BASE		4
+#define COL_B5_BASE		5
+#define COL_B6_BASE		6
+#define COL_B7_BASE		7
+#define COL_B8_BASE		8
+#define COL_B9_BASE		9
+#define COL_B10_BASE		10
+#define COL_B11_BASE		11
+#define COL_B12_BASE		12
+#define COL_B13_BASE		13
+
+#define BANK_B0_BASE		2
+#define BANK_B1_BASE		3
+#define BANK_B2_BASE		4
+
+#define BANKGRP_B0_BASE		2
+#define BANKGRP_B1_BASE		3
+
+#define RANK_B0_BASE		6
 
 /**
  * struct ecc_error_info - ECC error log information
@@ -106,6 +265,8 @@
  * @bank:	Bank number
  * @bitpos:	Bit position
  * @data:	Data causing the error
+ * @bankgrpnr:	Bank group number
+ * @blknr:	Block number
  */
 struct ecc_error_info {
 	u32 row;
@@ -113,6 +274,8 @@ struct ecc_error_info {
 	u32 bank;
 	u32 bitpos;
 	u32 data;
+	u32 bankgrpnr;
+	u32 blknr;
 };
 
 /**
@@ -131,12 +294,18 @@ struct synps_ecc_status {
 
 /**
  * struct synps_edac_priv - DDR memory controller private instance data
- * @baseaddr:	Base address of the DDR controller
- * @message:	Buffer for framing the event specific info
- * @stat:	ECC status information
- * @p_data:	Pointer to platform data
- * @ce_cnt:	Correctable Error count
- * @ue_cnt:	Uncorrectable Error count
+ * @baseaddr:		Base address of the DDR controller
+ * @message:		Buffer for framing the event specific info
+ * @stat:		ECC status information
+ * @p_data:		Pointer to platform data
+ * @ce_cnt:		Correctable Error count
+ * @ue_cnt:		Uncorrectable Error count
+ * @poison_addr:	Data poison address
+ * @row_shift:		Value of row shifts
+ * @col_shift:		Value of col shifts
+ * @bank_shift:		Value of bank shifts
+ * @bankgrp_shift:	Value of bank group shifts
+ * @rank_shift:		Value of rank shifts
  */
 struct synps_edac_priv {
 	void __iomem *baseaddr;
@@ -145,6 +314,12 @@ struct synps_edac_priv {
 	const struct synps_platform_data *p_data;
 	u32 ce_cnt;
 	u32 ue_cnt;
+	ulong poison_addr;
+	u32 row_shift[18];
+	u32 col_shift[14];
+	u32 bank_shift[3];
+	u32 bankgrp_shift[2];
+	u32 rank_shift[1];
 };
 
 /**
@@ -171,7 +346,7 @@ struct synps_platform_data {
  *
  * Determines there is any ecc error or not
  *
- * Return: one if there is no error otherwise returns zero
+ * Return: 1 if there is no error otherwise returns 0
  */
 static int synps_edac_geterror_info(void __iomem *base,
 				    struct synps_ecc_status *p)
@@ -219,6 +394,65 @@ static int synps_edac_geterror_info(void __iomem *base,
 }
 
 /**
+ * synps_enh_edac_geterror_info - Get the current ecc error info
+ * @base:	Pointer to the base address of the ddr memory controller
+ * @p:		Pointer to the synopsys ecc status structure
+ *
+ * Determines there is any ecc error or not
+ *
+ * Return: one if there is no error otherwise returns zero
+ */
+static int synps_enh_edac_geterror_info(void __iomem *base,
+					struct synps_ecc_status *p)
+{
+	u32 regval, clearval = 0;
+
+	regval = readl(base + ECC_STAT_OFST);
+	if (!regval)
+		return 1;
+
+	p->ce_cnt = (regval & ECC_STAT_CECNT_MASK) >> ECC_STAT_CECNT_SHIFT;
+	p->ue_cnt = (regval & ECC_STAT_UECNT_MASK) >> ECC_STAT_UECNT_SHIFT;
+	p->ceinfo.bitpos = (regval & ECC_STAT_BITNUM_MASK);
+
+	regval = readl(base + ECC_CEADDR0_OFST);
+	if (!(p->ce_cnt))
+		goto ue_err;
+
+	p->ceinfo.row = (regval & ECC_CEADDR0_RW_MASK);
+	regval = readl(base + ECC_CEADDR1_OFST);
+	p->ceinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
+					ECC_CEADDR1_BNKNR_SHIFT;
+	p->ceinfo.bankgrpnr = (regval &	ECC_CEADDR1_BNKGRP_MASK) >>
+					ECC_CEADDR1_BNKGRP_SHIFT;
+	p->ceinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
+	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
+	edac_dbg(3, "ce bit position: %d data: %d\n", p->ceinfo.bitpos,
+		 p->ceinfo.data);
+
+ue_err:
+	regval = readl(base + ECC_UEADDR0_OFST);
+	if (!(p->ue_cnt))
+		goto out;
+
+	p->ueinfo.row = (regval & ECC_CEADDR0_RW_MASK);
+	regval = readl(base + ECC_UEADDR1_OFST);
+	p->ueinfo.bankgrpnr = (regval & ECC_CEADDR1_BNKGRP_MASK) >>
+					ECC_CEADDR1_BNKGRP_SHIFT;
+	p->ueinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
+					ECC_CEADDR1_BNKNR_SHIFT;
+	p->ueinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
+	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
+out:
+	clearval = ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT;
+	clearval |= ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
+	writel(clearval, base + ECC_CLR_OFST);
+	writel(0x0, base + ECC_CLR_OFST);
+
+	return 0;
+}
+
+/**
  * synps_edac_handle_error - Handle controller error types CE and UE
  * @mci:	Pointer to the edac memory controller instance
  * @p:		Pointer to the synopsys ecc status structure
@@ -233,9 +467,17 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
 
 	if (p->ce_cnt) {
 		pinf = &p->ceinfo;
-		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-			 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-			 "CE", pinf->row, pinf->bank, pinf->col);
+		if (priv->p_data->quirks == 0)
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
+				 "CE", pinf->row, pinf->bank, pinf->col);
+		else
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type :%s Row %d Bank %d Col %d "
+				 "BankGroup Number %d Block Number %d",
+				 "CE", pinf->row, pinf->bank, pinf->col,
+				 pinf->bankgrpnr, pinf->blknr);
+
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
 				     p->ce_cnt, 0, 0, 0, 0, 0, -1,
 				     priv->message, "");
@@ -243,9 +485,17 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
 
 	if (p->ue_cnt) {
 		pinf = &p->ueinfo;
-		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-			 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-			 "UE", pinf->row, pinf->bank, pinf->col);
+		if (priv->p_data->quirks == 0)
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
+				"UE", pinf->row, pinf->bank, pinf->col);
+		else
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type :%s Row %d Bank %d Col %d "
+				 "BankGroup Number %d Block Number %d",
+				 "UE", pinf->row, pinf->bank, pinf->col,
+				 pinf->bankgrpnr, pinf->blknr);
+
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
 				     p->ue_cnt, 0, 0, 0, 0, 0, -1,
 				     priv->message, "");
@@ -255,6 +505,41 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
 }
 
 /**
+ * synps_edac_intr_handler - synps edac isr
+ * @irq:        irq number
+ * @dev_id:     device id poniter
+ *
+ * This is the Isr routine called by edac core interrupt thread.
+ * Used to check and post ECC errors.
+ *
+ * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise
+ */
+static irqreturn_t synps_edac_intr_handler(int irq, void *dev_id)
+{
+	struct mem_ctl_info *mci = dev_id;
+	struct synps_edac_priv *priv = mci->pvt_info;
+	int status, regval;
+
+	regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST) &
+			(DDR_QOSCE_MASK | DDR_QOSUE_MASK);
+	if (!(regval & ECC_CE_UE_INTR_MASK))
+		return IRQ_NONE;
+	status = priv->p_data->synps_edac_geterror_info(priv->baseaddr,
+				&priv->stat);
+	if (status)
+		return IRQ_NONE;
+
+	priv->ce_cnt += priv->stat.ce_cnt;
+	priv->ue_cnt += priv->stat.ue_cnt;
+	synps_edac_handle_error(mci, &priv->stat);
+
+	edac_dbg(3, "Total error count ce %d ue %d\n",
+		 priv->ce_cnt, priv->ue_cnt);
+	writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+	return IRQ_HANDLED;
+}
+
+/**
  * synps_edac_check - Check controller for ECC errors
  * @mci:	Pointer to the edac memory controller instance
  *
@@ -310,6 +595,40 @@ static enum dev_type synps_edac_get_dtype(const void __iomem *base)
 }
 
 /**
+ * synps_enh_edac_get_dtype - Return the controller memory width
+ * @base:	Pointer to the ddr memory controller base address
+ *
+ * Get the EDAC device type width appropriate for the current controller
+ * configuration.
+ *
+ * Return: a device type width enumeration.
+ */
+static enum dev_type synps_enh_edac_get_dtype(const void __iomem *base)
+{
+	enum dev_type dt;
+	u32 width;
+
+	width = readl(base + CTRL_OFST);
+	width = (width & ECC_CTRL_BUSWIDTH_MASK) >>
+		ECC_CTRL_BUSWIDTH_SHIFT;
+	switch (width) {
+	case DDRCTL_EWDTH_16:
+		dt = DEV_X2;
+		break;
+	case DDRCTL_EWDTH_32:
+		dt = DEV_X4;
+		break;
+	case DDRCTL_EWDTH_64:
+		dt = DEV_X8;
+		break;
+	default:
+		dt = DEV_UNKNOWN;
+	}
+
+	return dt;
+}
+
+/**
  * synps_edac_get_eccstate - Return the controller ecc enable/disable status
  * @base:	Pointer to the ddr memory controller base address
  *
@@ -335,6 +654,32 @@ static bool synps_edac_get_eccstate(void __iomem *base)
 }
 
 /**
+ * synps_enh_edac_get_eccstate - Return the controller ecc enable/disable status
+ * @base:	Pointer to the ddr memory controller base address
+ *
+ * Get the ECC enable/disable status for the controller
+ *
+ * Return: a ecc status boolean i.e true/false - enabled/disabled.
+ */
+static bool synps_enh_edac_get_eccstate(void __iomem *base)
+{
+	enum dev_type dt;
+	u32 ecctype;
+	bool state = false;
+
+	dt = synps_enh_edac_get_dtype(base);
+	if (dt == DEV_UNKNOWN)
+		return state;
+
+	ecctype = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
+	if ((ecctype == SCRUB_MODE_SECDED) &&
+	    ((dt == DEV_X2) || (dt == DEV_X4) || (dt == DEV_X8)))
+		state = true;
+
+	return state;
+}
+
+/**
  * synps_edac_get_memsize - reads the size of the attached memory device
  *
  * Return: the memory size in bytes
@@ -373,6 +718,35 @@ static enum mem_type synps_edac_get_mtype(const void __iomem *base)
 }
 
 /**
+ * synps_enh_edac_get_mtype - Returns controller memory type
+ * @base:	pointer to the synopsys ecc status structure
+ *
+ * Get the EDAC memory type appropriate for the current controller
+ * configuration.
+ *
+ * Return: a memory type enumeration.
+ */
+static enum mem_type synps_enh_edac_get_mtype(const void __iomem *base)
+{
+	enum mem_type mt;
+	u32 memtype;
+
+	memtype = readl(base + CTRL_OFST);
+
+	mt = MEM_UNKNOWN;
+	if ((memtype & MEM_TYPE_DDR3) || (memtype & MEM_TYPE_LPDDR3))
+		mt = MEM_DDR3;
+	else if (memtype & MEM_TYPE_DDR2)
+		mt = MEM_RDDR2;
+	else if ((memtype & MEM_TYPE_LPDDR4) || (memtype & MEM_TYPE_DDR4))
+		mt = MEM_DDR4;
+	else
+		mt = MEM_EMPTY;
+
+	return mt;
+}
+
+/**
  * synps_edac_init_csrows - Initialize the cs row data
  * @mci:	Pointer to the edac memory controller instance
  *
@@ -440,8 +814,13 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
 	mci->dev_name = SYNPS_EDAC_MOD_STRING;
 	mci->mod_name = SYNPS_EDAC_MOD_VER;
 
-	edac_op_state = EDAC_OPSTATE_POLL;
-	mci->edac_check = synps_edac_check;
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
+		edac_op_state = EDAC_OPSTATE_INT;
+	} else {
+		edac_op_state = EDAC_OPSTATE_POLL;
+		mci->edac_check = synps_edac_check;
+	}
+
 	mci->ctl_page_to_phys = NULL;
 
 	status = synps_edac_init_csrows(mci);
@@ -457,13 +836,409 @@ static const struct synps_platform_data zynq_edac_def = {
 	.quirks				= 0,
 };
 
+static const struct synps_platform_data zynqmp_enh_edac_def = {
+	.synps_edac_geterror_info	= synps_enh_edac_geterror_info,
+	.synps_edac_get_mtype		= synps_enh_edac_get_mtype,
+	.synps_edac_get_dtype		= synps_enh_edac_get_dtype,
+	.synps_edac_get_eccstate	= synps_enh_edac_get_eccstate,
+	.quirks				= (DDR_ECC_INTR_SUPPORT |
+					   DDR_ECC_DATA_POISON_SUPPORT),
+};
+
 static const struct of_device_id synps_edac_match[] = {
 	{ .compatible = "xlnx,zynq-ddrc-a05", .data = (void *)&zynq_edac_def },
+	{ .compatible = "xlnx,zynqmp-ddrc-2.40a",
+				.data = (void *)&zynqmp_enh_edac_def},
 	{ /* end of table */ }
 };
 
 MODULE_DEVICE_TABLE(of, synps_edac_match);
 
+#define to_mci(k) container_of(k, struct mem_ctl_info, dev)
+
+/**
+ * ddr_poison_setup -	update poison registers
+ * @priv:		Pointer to synps_edac_priv struct
+ *
+ * Update poison registers as per ddr mapping
+ * Return: none.
+ */
+static void ddr_poison_setup(struct synps_edac_priv *priv)
+{
+	int col = 0, row = 0, bank = 0, bankgrp = 0, rank = 0, regval;
+	int index;
+	ulong hif_addr = 0;
+
+	hif_addr = priv->poison_addr >> 3;
+
+	for (index = 0; index < DDR_MAX_ROW_SHIFT; index++) {
+		if (priv->row_shift[index])
+			row |= (((hif_addr >> priv->row_shift[index]) &
+						BIT(0)) << index);
+		else
+			break;
+	}
+
+	for (index = 0; index < DDR_MAX_COL_SHIFT; index++) {
+		if (priv->col_shift[index] || index < 3)
+			col |= (((hif_addr >> priv->col_shift[index]) &
+						BIT(0)) << index);
+		else
+			break;
+	}
+
+	for (index = 0; index < DDR_MAX_BANK_SHIFT; index++) {
+		if (priv->bank_shift[index])
+			bank |= (((hif_addr >> priv->bank_shift[index]) &
+						BIT(0)) << index);
+		else
+			break;
+	}
+
+	for (index = 0; index < DDR_MAX_BANKGRP_SHIFT; index++) {
+		if (priv->bankgrp_shift[index])
+			bankgrp |= (((hif_addr >> priv->bankgrp_shift[index])
+						& BIT(0)) << index);
+		else
+			break;
+	}
+
+	if (priv->rank_shift[0])
+		rank = (hif_addr >> priv->rank_shift[0]) & BIT(0);
+
+	regval = (rank << ECC_POISON0_RANK_SHIFT) | col;
+	writel(regval, priv->baseaddr + ECC_POISON0_OFST);
+	regval = (bankgrp << ECC_POISON1_BANKGRP_SHIFT) |
+			 (bank << ECC_POISON1_BANKNR_SHIFT) | row;
+	writel(regval, priv->baseaddr + ECC_POISON1_OFST);
+}
+
+/**
+ * inject_data_error_show - Get Poison0 & 1 register contents
+ * @dev:	Pointer to the device struct
+ * @mattr:	Pointer to device attributes
+ * @data:	Pointer to user data
+ *
+ * Get the Poison0 and Poison1 register contents
+ * Return: Number of bytes copied.
+ */
+static ssize_t inject_data_error_show(struct device *dev,
+					      struct device_attribute *mattr,
+					      char *data)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	return sprintf(data, "Poison0 Addr: 0x%08x\n\rPoison1 Addr: 0x%08x\n\r"
+			"Error injection Address: 0x%lx\n\r",
+			readl(priv->baseaddr + ECC_POISON0_OFST),
+			readl(priv->baseaddr + ECC_POISON1_OFST),
+			priv->poison_addr);
+}
+
+/**
+ * inject_data_error_store - Configure Poison0 Poison1 registers
+ * @dev:	Pointer to the device struct
+ * @mattr:	Pointer to device attributes
+ * @data:	Pointer to user data
+ * @count:	read the size bytes from buffer
+ *
+ * Configures the Poison0 and Poison1 register contents as per user given
+ * address
+ * Return: Number of bytes copied.
+ */
+static ssize_t inject_data_error_store(struct device *dev,
+					       struct device_attribute *mattr,
+					       const char *data, size_t count)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	if (kstrtoul(data, 0, &priv->poison_addr))
+		return -EINVAL;
+
+	ddr_poison_setup(priv);
+
+	return count;
+}
+
+/**
+ * inject_data_poison_show - Shows type of Data poison
+ * @dev:	Pointer to the device struct
+ * @mattr:	Pointer to device attributes
+ * @data:	Pointer to user data
+ *
+ * Shows the type of Error injection enabled, either UE or CE
+ * Return: Number of bytes copied.
+ */
+static ssize_t inject_data_poison_show(struct device *dev,
+					      struct device_attribute *mattr,
+					      char *data)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	return sprintf(data, "Data Poisoning: %s\n\r",
+			(((readl(priv->baseaddr + ECC_CFG1_OFST)) & 0x3) == 0x3)
+			? ("Correctable Error") : ("UnCorrectable Error"));
+}
+
+/**
+ * inject_data_poison_store - Enbles Data poison CE/UE
+ * @dev:	Pointer to the device struct
+ * @mattr:	Pointer to device attributes
+ * @data:	Pointer to user data
+ * @count:	read the size bytes from buffer
+ *
+ * Enables the CE or UE Data poison
+ * Return: Number of bytes copied.
+ */
+static ssize_t inject_data_poison_store(struct device *dev,
+					       struct device_attribute *mattr,
+					       const char *data, size_t count)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	writel(0, priv->baseaddr + DDRC_SWCTL);
+	if (strncmp(data, "CE", 2) == 0)
+		writel(ECC_CEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
+	else
+		writel(ECC_UEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
+	writel(1, priv->baseaddr + DDRC_SWCTL);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(inject_data_error);
+static DEVICE_ATTR_RW(inject_data_poison);
+
+/**
+ * synps_edac_create_sysfs_attributes - Create sysfs entries
+ * @mci:	Pointer to the edac memory controller instance
+ *
+ * Create sysfs attributes for injecting ECC errors using data poison.
+ *
+ * Return: 0 if sysfs creation was successful, else return negative error code.
+ */
+static int synps_edac_create_sysfs_attributes(struct mem_ctl_info *mci)
+{
+	int rc;
+
+	rc = device_create_file(&mci->dev, &dev_attr_inject_data_error);
+	if (rc < 0)
+		return rc;
+	rc = device_create_file(&mci->dev, &dev_attr_inject_data_poison);
+	if (rc < 0)
+		return rc;
+	return 0;
+}
+
+/**
+ * synps_edac_remove_sysfs_attributes - Removes sysfs entries
+ * @mci:	Pointer to the edac memory controller instance
+ *
+ * Removes sysfs attributes.
+ *
+ * Return: none.
+ */
+static void synps_edac_remove_sysfs_attributes(struct mem_ctl_info *mci)
+{
+	device_remove_file(&mci->dev, &dev_attr_inject_data_error);
+	device_remove_file(&mci->dev, &dev_attr_inject_data_poison);
+}
+
+/**
+ * setup_address_map -	Set Address Map by querying ADDRMAP registers
+ * @priv:		Pointer to synps_edac_priv struct
+ *
+ * Set Address Map by querying ADDRMAP registers
+ * Return: none.
+ */
+static void setup_address_map(struct synps_edac_priv *priv)
+{
+	u32 addrmap[12], addrmap_row_b2_10;
+	int index;
+	u32 width, memtype;
+
+	memtype = readl(priv->baseaddr + CTRL_OFST);
+	width = (memtype & ECC_CTRL_BUSWIDTH_MASK) >> ECC_CTRL_BUSWIDTH_SHIFT;
+
+	for (index = 0; index < 12; index++) {
+		u32 addrmap_offset;
+
+		addrmap_offset = ECC_ADDRMAP0_OFFSET + (index * 4);
+		addrmap[index] = readl(priv->baseaddr + addrmap_offset);
+	}
+
+	priv->row_shift[0] = (addrmap[5] & ROW_MAX_VAL_MASK) + ROW_B0_BASE;
+	priv->row_shift[1] = ((addrmap[5] >> 8) &
+			ROW_MAX_VAL_MASK) + ROW_B1_BASE;
+
+	addrmap_row_b2_10 = (addrmap[5] >> 16) & ROW_MAX_VAL_MASK;
+	if (addrmap_row_b2_10 != ROW_MAX_VAL_MASK) {
+		for (index = 2; index < 11; index++)
+			priv->row_shift[index] = addrmap_row_b2_10 +
+				index + ROW_B0_BASE;
+
+	} else {
+		priv->row_shift[2] = (addrmap[9] &
+				ROW_MAX_VAL_MASK) + ROW_B2_BASE;
+		priv->row_shift[3] = ((addrmap[9] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B3_BASE;
+		priv->row_shift[4] = ((addrmap[9] >> 16) &
+				ROW_MAX_VAL_MASK) + ROW_B4_BASE;
+		priv->row_shift[5] = ((addrmap[9] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B5_BASE;
+		priv->row_shift[6] = (addrmap[10] &
+				ROW_MAX_VAL_MASK) + ROW_B6_BASE;
+		priv->row_shift[7] = ((addrmap[10] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B7_BASE;
+		priv->row_shift[8] = ((addrmap[10] >> 16) &
+				ROW_MAX_VAL_MASK) + ROW_B8_BASE;
+		priv->row_shift[9] = ((addrmap[10] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B9_BASE;
+		priv->row_shift[10] = (addrmap[11] &
+				ROW_MAX_VAL_MASK) + ROW_B10_BASE;
+	}
+
+	priv->row_shift[11] = (((addrmap[5] >> 24) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[5] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B11_BASE);
+	priv->row_shift[12] = ((addrmap[6] & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : ((addrmap[6] &
+				ROW_MAX_VAL_MASK) + ROW_B12_BASE);
+	priv->row_shift[13] = (((addrmap[6] >> 8) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B13_BASE);
+	priv->row_shift[14] = (((addrmap[6] >> 16) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 16) &
+				ROW_MAX_VAL_MASK) + ROW_B14_BASE);
+	priv->row_shift[15] = (((addrmap[6] >> 24) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B15_BASE);
+	priv->row_shift[16] = ((addrmap[7] & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : ((addrmap[7] &
+				ROW_MAX_VAL_MASK) + ROW_B16_BASE);
+	priv->row_shift[17] = (((addrmap[7] >> 8) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[7] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B17_BASE);
+
+	priv->col_shift[0] = 0;
+	priv->col_shift[1] = 1;
+	priv->col_shift[2] = (addrmap[2] & COL_MAX_VAL_MASK) + COL_B2_BASE;
+	priv->col_shift[3] = ((addrmap[2] >> 8) &
+			COL_MAX_VAL_MASK) + COL_B3_BASE;
+	priv->col_shift[4] = (((addrmap[2] >> 16) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[2] >> 16) &
+					COL_MAX_VAL_MASK) + COL_B4_BASE);
+	priv->col_shift[5] = (((addrmap[2] >> 24) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[2] >> 24) &
+					COL_MAX_VAL_MASK) + COL_B5_BASE);
+	priv->col_shift[6] = ((addrmap[3] & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : ((addrmap[3] &
+					COL_MAX_VAL_MASK) + COL_B6_BASE);
+	priv->col_shift[7] = (((addrmap[3] >> 8) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 8) &
+					COL_MAX_VAL_MASK) + COL_B7_BASE);
+	priv->col_shift[8] = (((addrmap[3] >> 16) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 16) &
+					COL_MAX_VAL_MASK) + COL_B8_BASE);
+	priv->col_shift[9] = (((addrmap[3] >> 24) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 24) &
+					COL_MAX_VAL_MASK) + COL_B9_BASE);
+	if (width == DDRCTL_EWDTH_64) {
+		if (memtype & MEM_TYPE_LPDDR3) {
+			priv->col_shift[10] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+			priv->col_shift[11] = (((addrmap[4] >> 8) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[4] >> 8) & COL_MAX_VAL_MASK) +
+				 COL_B11_BASE);
+		} else {
+			priv->col_shift[11] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+			priv->col_shift[13] = (((addrmap[4] >> 8) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[4] >> 8) & COL_MAX_VAL_MASK) +
+				 COL_B11_BASE);
+		}
+	} else if (width == DDRCTL_EWDTH_32) {
+		if (memtype & MEM_TYPE_LPDDR3) {
+			priv->col_shift[10] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+			priv->col_shift[11] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+		} else {
+			priv->col_shift[11] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+			priv->col_shift[13] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+		}
+	} else {
+		if (memtype & MEM_TYPE_LPDDR3) {
+			priv->col_shift[10] = (((addrmap[3] >> 16) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 16) & COL_MAX_VAL_MASK) +
+				 COL_B8_BASE);
+			priv->col_shift[11] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+			priv->col_shift[13] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+		} else {
+			priv->col_shift[11] = (((addrmap[3] >> 16) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 16) & COL_MAX_VAL_MASK) +
+				 COL_B8_BASE);
+			priv->col_shift[13] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+		}
+	}
+
+	if (width) {
+		for (index = 9; index > width; index--) {
+			priv->col_shift[index] = priv->col_shift[index - width];
+			priv->col_shift[index - width] = 0;
+		}
+	}
+
+	priv->bank_shift[0] = (addrmap[1] & BANK_MAX_VAL_MASK) + BANK_B0_BASE;
+	priv->bank_shift[1] = ((addrmap[1] >> 8) &
+				BANK_MAX_VAL_MASK) + BANK_B1_BASE;
+	priv->bank_shift[2] = (((addrmap[1] >> 16) &
+				BANK_MAX_VAL_MASK) == BANK_MAX_VAL_MASK) ? 0 :
+				(((addrmap[1] >> 16) & BANK_MAX_VAL_MASK) +
+				 BANK_B2_BASE);
+
+	priv->bankgrp_shift[0] = (addrmap[8] &
+				BANKGRP_MAX_VAL_MASK) + BANKGRP_B0_BASE;
+	priv->bankgrp_shift[1] = (((addrmap[8] >> 8) & BANKGRP_MAX_VAL_MASK) ==
+				BANKGRP_MAX_VAL_MASK) ? 0 : (((addrmap[8] >> 8)
+				& BANKGRP_MAX_VAL_MASK) + BANKGRP_B1_BASE);
+
+	priv->rank_shift[0] = ((addrmap[0] & RANK_MAX_VAL_MASK) ==
+				RANK_MAX_VAL_MASK) ? 0 : ((addrmap[0] &
+				RANK_MAX_VAL_MASK) + RANK_B0_BASE);
+}
+
 /**
  * synps_edac_mc_probe - Check controller and bind driver
  * @pdev:	Pointer to the platform_device struct
@@ -478,7 +1253,7 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 	struct mem_ctl_info *mci;
 	struct edac_mc_layer layers[2];
 	struct synps_edac_priv *priv;
-	int rc;
+	int rc, irq, status;
 	struct resource *res;
 	void __iomem *baseaddr;
 	const struct of_device_id *match;
@@ -527,6 +1302,27 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 		goto free_edac_mc;
 	}
 
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
+		irq = platform_get_irq(pdev, 0);
+		if (irq < 0) {
+			edac_printk(KERN_ERR, EDAC_MC,
+					"No irq %d in DT\n", irq);
+			return -ENODEV;
+		}
+
+		status = devm_request_irq(&pdev->dev, irq,
+			synps_edac_intr_handler,
+			0, dev_name(&pdev->dev), mci);
+		if (status < 0) {
+			edac_printk(KERN_ERR, EDAC_MC, "Failed to request Irq\n");
+			goto free_edac_mc;
+		}
+
+		/* Enable UE/CE Interrupts */
+		writel((DDR_QOSUE_MASK | DDR_QOSCE_MASK),
+			priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
+	}
+
 	rc = edac_mc_add_mc(mci);
 	if (rc) {
 		edac_printk(KERN_ERR, EDAC_MC,
@@ -534,6 +1330,18 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 		goto free_edac_mc;
 	}
 
+	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT) {
+		if (synps_edac_create_sysfs_attributes(mci)) {
+			edac_printk(KERN_ERR, EDAC_MC,
+					"Failed to create sysfs entries\n");
+			goto free_edac_mc;
+		}
+	}
+
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "xlnx,zynqmp-ddrc-2.40a"))
+		setup_address_map(priv);
+
 	/*
 	 * Start capturing the correctable and uncorrectable errors. A write of
 	 * 0 starts the counters.
@@ -557,8 +1365,16 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 static int synps_edac_mc_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+	struct synps_edac_priv *priv;
 
+	priv = mci->pvt_info;
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT)
+		/* Disable UE/CE Interrupts */
+		writel((DDR_QOSUE_MASK | DDR_QOSCE_MASK),
+			priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
 	edac_mc_del_mc(&pdev->dev);
+	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT)
+		synps_edac_remove_sysfs_attributes(mci);
 	edac_mc_free(mci);
 
 	return 0;
-- 
2.1.1

