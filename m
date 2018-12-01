Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB71C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F63320868
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="V22XnMp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F63320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeLAW0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 17:26:10 -0500
Received: from mail-eopbgr710068.outbound.protection.outlook.com ([40.107.71.68]:18184
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726747AbeLAW0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 17:26:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahctcdk8rvmwpdhLPaVOMaEEMZfojjuUc4y5mbAl6kM=;
 b=V22XnMp45u+azvqFn6coTakE3wKlfu/hDFrRcKBl3NyyvdbZELLNPdrEwTxx6ZcVVHk1WIr45L/Hp9EyNZTtZ44OmkeMXtfYuLdaYBFIowogSoGXwCqTuRiKoz3nhKp7gJj3tzUmxYP6RLyJVsW2eTMpbX4oT3cb0pVDrFvtOu0=
Received: from CY4PR02CA0026.namprd02.prod.outlook.com (2603:10b6:903:117::12)
 by DM5PR0201MB3510.namprd02.prod.outlook.com (2603:10b6:4:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1361.19; Sat, 1 Dec
 2018 11:13:46 +0000
Received: from CY1NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by CY4PR02CA0026.outlook.office365.com
 (2603:10b6:903:117::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1382.21 via Frontend
 Transport; Sat, 1 Dec 2018 11:13:46 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT039.mail.protection.outlook.com (10.152.75.140) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1382.18
 via Frontend Transport; Sat, 1 Dec 2018 11:13:45 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:46520 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gT3DU-0005oI-Kf; Sat, 01 Dec 2018 03:13:44 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gT3DP-0001kp-H5; Sat, 01 Dec 2018 03:13:39 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wB1BDYjb015261;
        Sat, 1 Dec 2018 03:13:35 -0800
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1gT3DK-0001js-Id; Sat, 01 Dec 2018 03:13:34 -0800
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id C09B6604D5; Sat,  1 Dec 2018 16:43:33 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        <martin.petersen@oracle.com>, Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Ian King <colin.king@canonical.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <v.anuragkumar@gmail.com>, Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v7 06/10] usb: dwc3: don't issue no-op trb for stream capable endpoints
Date:   Sat, 1 Dec 2018 16:43:27 +0530
Message-ID: <1543662811-5194-7-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(2980300002)(3923003)(199004)(189003)(5660300001)(90966002)(36386004)(7416002)(478600001)(42186006)(103686004)(16586007)(106002)(316002)(2171002)(6266002)(48376002)(50466002)(305945005)(39060400002)(63266004)(2906002)(4326008)(486006)(126002)(6666004)(2616005)(356004)(476003)(446003)(426003)(11346002)(336012)(106466001)(107886003)(36756003)(51416003)(26005)(6346003)(186003)(47776003)(81166006)(54906003)(50226002)(14444005)(575784001)(8936002)(110136005)(8676002)(52956003)(81156014)(76176011)(107986001)(921003)(5001870100001)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3510;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT039;1:5rpPmfYddxvi1Wsw+KSjrznPSD4VzxE65bfrgQ1R5hKXaq/tksDfAqtQ7qchpfa8ndKLdqsHYvEZ33xHDYEWeDA9i6hUu5qWCZ5IHea5QFHT66/wEgls5jKjbsRg3nlk
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da52f029-1170-4163-76e3-08d6577e0fbf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5PR0201MB3510;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;3:ZMkVcli3AX1SZLTv/tn3KnLsLfK2xOIw5RmCSoMrum540FGD4yvgogr98D00vDNa4oEG+gFStFUpuKKuPFOKN36JQbv3zQ23rA250q3y2PArQN4MNSdGh8Mnl2cKVLl9Ywf7IUGx5FKQrobEsE8B2e/X56PLvGrc0uN7zGH7mNa49907EXPhzNHh9Y4GAmfsa5dHBo3GFtvA/ikVQyAa1jAQ3d+3B7K2+zcuA7v/82jYYjCdVdA9CP5tM6ZBabMPilO55cahsX8U//ukL27ds/OayucZxI84b11MU1XUe70ik2VTYERuQlfEo13Q9nwPre8CYgiOsFH+wbl9wOjAK/irA7QunUyYFgPaAyCrOWA=;25:LAOv8CSrE10dBSYVBPZWMaGiup063KmHUKJfwh19bKXyubdkatUn3iN5Vh3lQ/LC8wNBq+/LK/eUVe4JLym61lL+VdPIxfDHKXY/5HAi+nv3j1WBMLxVbPvW+163e4qOh73oEmpAThDHIySams3GBI+7og5na/sAiALM7KsBpW1CiSFoswmlyuyFHoWQiMqEHb/nDgF4qVLbQpfCGZFShZLhek7RRZVMJLxOjBCpIzjxDowXMthRk9GWtP7YA7tqadtxm6Pm69YOCJM6c4OmftKOT9nU/WqdHlkfA4pXWMx0xb/4nab1QZG3WtLCD59bj8lltg6mWRKWAXfQEaLlag==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3510:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;31:W3SSRDDEBXeDnE/RGPudo0kNCNWKwylYH74A6h+65zdvvzPlaKxKEzOWeS4s29sqD4fXPuV13vneicXOtRytbpjjBErRWKHZFEDcFntqIRx8RPYSVc/KXzqB3qhOqbSyJAjvu7pXVokos98qBeHwalo7ztCzoKhzDKGhL4Uh4yfAZOdEGoWYju6y6I+wK5hEAQpQQDLSkz7/iROhD4LZUh6YOL7yJ/WNMlPUbnDqgD0=;20:wrG/7ES55ZJ6QS0EQdRvuZ1fXkrNRQHzRJE/0pbssUy4452fSfMT9zijIRiH2I3KaSF4FtCyzK+X9ijeZVNEl1KSLZVXSkN6hkvKdqEmltqudpjRFdOrNr4UQPSCYpNW2BAq6R+DeNQdI+/gX/OJqOXAHywfxcvmIcRGGQdQdphMMIQgLhg8tPaYHOK9WN/9Uih4QMf2pVLk/+aJ0ALyfPsUrtUjUf2uoDRy+mWE8LppC+Z3Cb4hIBjvPAEBLkVECcULH9yBGBg7fzuqSOj1DcNy6SHzZzsylR8O6ZQCXcQsj30htz0lWQd2zfLIF+PrtefveKVi/p9eAQPhLQvWHkNGVEcWt38cgG+36GHQ+HAYCzwg3MOh5MEVwPM94cnmCdE5mGTX47KAnSkmSS3ofXwsbX6AfHFWEWIUbNNxP/f0PCyFEf1sAkfEhYcwzjV2OLYHWTnnJvlfp3WCBz2GfiVn4yIZtSXkV9ojQCZdwRTfhMi//ddhLTXaXsotwgbc
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB35101A425CCA446C545CC7E3A7AC0@DM5PR0201MB3510.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3002001)(10201501046)(3231454)(999002)(944501475)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR0201MB3510;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0201MB3510;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;4:lfH3/7Lakq33LS979gX3zKN5f+niZ9TuDIDwBFCYmXwbWxbHME3gLIX6HxenVs0czOofrqOgPCf03XHvt1Gq0I0C2IYrptfCyT95aDIb+WJuafccVnB5CnH8nPtrKheLAU0VEqrEpPIRwf6gbBCDFaTad3IGxWOpC66S8HzvIeUzEdo1HKFM8y8DSFt+tmH/Limo+qRoP22xy2sPqj0zbazMr+8k8MMG01KuNPMJ6ikDbNfOwhy/5SbOHO3PugfpzuxOvfC03ZetInB9ReMEQA==
X-Forefront-PRVS: 087396016C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0201MB3510;23:m6MwN0BZrRA7TQfHFMe+syTf0agKjaC5KMHMGH+?=
 =?us-ascii?Q?+W8dfOQUo+BrGdZMl6qwWZEQ2H2YhIMp4aBD+2czL1UJ/ZuS4WgA+8JHVwan?=
 =?us-ascii?Q?kk4FrY+PwNjvGZgxqGHBc0RnMBov0tFRlBh3y7ydzXWZZpz0YZcI3qlB8FJw?=
 =?us-ascii?Q?W9yfTMsKPWc5THQD0GiC18OwoOD52Psl+5/ycRAJ83lJzOJfoeyg4bFbrAFd?=
 =?us-ascii?Q?lK+kHFv/jC6GW0bh2P+ILBkJXxGla/r9vIX7FtT6k6xssCjoDUxEf9enhGlr?=
 =?us-ascii?Q?CBOLhXxfCPp56LTKK23iJDv2wmTW+1KMZsdAPrMvkQsjFsy7SOLIHKAqJqof?=
 =?us-ascii?Q?7ERklnRfB/lTIzQpKyCKyQE/h4H918J3d0Qp1i60pBoWdrKUmfuIVZqb/10i?=
 =?us-ascii?Q?1/EYE92HbQe2ATApKA43ww99ay8UImDkH1w1T+CtvS3ZjXuwQRWKuTX5je3s?=
 =?us-ascii?Q?kU35/zU5LotXPtQL9TeuW6B6bb1Ywb0oEtskPgf9EaqaiGz2mQwrCRt4a4j2?=
 =?us-ascii?Q?GP47W3VnLw6cuAkzyQW1QO8GGG4L1NtiQCEdS6A7tVWfkPGn0P99uQxo3Nr+?=
 =?us-ascii?Q?pa11lczhfMG2kPkL9lRJR7o87LVMYlgFJkd6OktxmWuHPrhLCRcjHnY+17nE?=
 =?us-ascii?Q?xKiKyOuSOuvbPNWooKRQjCkvAJYJ7wwjZGN1QqLzjRdkFOXIeQiEaNro5FV3?=
 =?us-ascii?Q?e2SCiSFNveFZlK/HNLI/DBbMuFleqVm946Z6zUvon2n8h2Pm91j7oWAUf0ZH?=
 =?us-ascii?Q?86vSiFys0Hfvmc09fj8R8lO/Dx9oVZPGfm8jDt7gyb748U2RoQ/oKKDI3fCe?=
 =?us-ascii?Q?nWoJCDvEKwAlxuFg73KG6kUr3Apk6TrXGjzg1C/l0N2Y9QnhJuVGKh8qZIh2?=
 =?us-ascii?Q?dYSZpUX7sG0V1tzZegXVKiRX1SGPJjPGqj/eu5YMyYD1YZ+q/NAhqDjqbzMk?=
 =?us-ascii?Q?lLM0wdJBf7ClwOOUj8DNOKwgvh4V7A1X6TMV5ExcE7fU8uhvgb5nUDG/HGSX?=
 =?us-ascii?Q?91v9dR6fnKWL44qVMuFYXsDJG1RE4gkXeWmuqi8miNmM8FWEeYNN96IaqEen?=
 =?us-ascii?Q?MNfn/NI0myntOE8XvaYHlopQNRljVd1IdF7AaTESRYzDAnu6IU25VC49r34g?=
 =?us-ascii?Q?XVbnANktU2id0qYCqqm96rOmNCv3Jw1PF47EAvzyURHCJ0t8jY9W+7Vw+maU?=
 =?us-ascii?Q?iMLJI7V7pKnT7Yg+DG2rMdUHmRscs2367YbAQKSCnGbde0ivyHJcL72JE6X6?=
 =?us-ascii?Q?xO45YDRN6roGo1PgP3aPRi/U7Ts98ErCNDZ9L+baCkU65V3dGr0+D+oqbObK?=
 =?us-ascii?Q?tzL5P2RZLZ3TCJ1NrPIu+t3dUmZQL4S5Locg9PKaP8LHDgXHnQgCpxFNDCgu?=
 =?us-ascii?Q?UKStLBoVmaAIiwGww1UfxP/L5VB4=3D?=
X-Microsoft-Antispam-Message-Info: PPcnOUByFCjCUSg+fq5rf2VUaB+eh8sD0xwKPUTcSNl/ZOSGYbO5iIU9N6dDOloH3qfDabTBiWAFigPf4enjr+aIePVxuU7syrPSjezQ32KDUynO6NUnMq3YhVIWygMJQ52ChNKg780D47MNauQR4X2szMhkPYmBztGchxf+tCNbBGxHkOmZgMbhgsdncxzvotbf8000TyN41c774i6WLHTZXwTidoWQIqb+2UKCvzwJzslzKJRy2PUJHyyXW57GXBFJh8mBOa2/FrwqnbbxwtoiMiXqZzMwgjZiUbaXO6gJPbmD2cDXP2MBJ0Mix3PtEZEOi6Jf7rCNKsd9vL+7ujWb/ae0U6ybNPQiNtbRsGo=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;6:gFt1y97hDVNzgdYAdnBdOLgmmMbnVuYGrLQR4bNn2UmN0w7Ayu9DUiGqxdPE9FFQjE2cOY85lV2+bN9HSBkRrvE4vp7Lg5NZr93Q0kzp2VA/zuVJ/LfBUD7APvL0u6Iafg568Sj6KHb36/apDm+ZO63DMSgZDqwCBJ2vM+bWgzEQS/G8nnQ+MHU4WLdtzjBSvxeaBLo8ODiimD3lP/SpLe4c8KgsC+VgHvBe1exN+uysLo1G4vR+C9R1d4vGwqIucgOFK3eDx9B0//3ElWlDoYSudEGGhaQbXwrE3bsYQCzmHkMm9IWUXWSMXnyLq7hyQHsQwc1bwi3/GB7VQ9HDkf2g5P5qX15aqyJFc/IXeqlSkDgpgTtEnIvb+GIKi2cryn8/Q3W09ol+gl6jc3RRjT+gxPysvVbcV5o5Dc/a6ChqSPBQqiSP7eYHks48Yxd+sEI3iGehy4h9QWtoYngwbA==;5:SZOjj8osJQYGBy32M5flGQWkf5JMR6C6U6OSmy3hfpD73DR8e8C6627lkcW7pM7OGF/ddOGITc+2z6oXAPznXwQkbkIW7M5pldbMBYpPpEHMrAmmzxN+E/dvSuqsCy/0ec8UF7Fx64wrH1S1WAMLpu9t1HUFk1TBNP+Pc3WM/44=;7:0d5xIaGzBekHlvj3spZmYKjFpNh+tsh8lWYzrAam71E13+0+M6kKKS4hEOWgZpn5hO4QY24lgnFYNXpOzDDDlftcSHlI69e66uG/M4VbzKSpOnvm8xQfGIDrtFXej6UTRlnfrErjknVpFocPs/UVZQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2018 11:13:45.1049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da52f029-1170-4163-76e3-08d6577e0fbf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3510
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stream capable endpoints require stream id to be given
when issuing START TRANSFER. While issuing no-op trb the
stream id is not yet known, so don't issue no-op trb's on
stream capable endpoints.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v7:
	1. Reverted to dep->stream_capable from dep->endpoint.stream_capable

 Changes in v6:
	1. Replaced dep->stream_capable with dep->endpoint.stream_capable

 Changes in v5:
	1. None

 Changes in v4:
	1. None

 Changes in v3:
	1. None

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 3edfc0b..78c9bc6 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -673,7 +673,7 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 	 * Issue StartTransfer here with no-op TRB so we can always rely on No
 	 * Response Update Transfer command.
 	 */
-	if (usb_endpoint_xfer_bulk(desc) ||
+	if ((usb_endpoint_xfer_bulk(desc) && !dep->stream_capable) ||
 			usb_endpoint_xfer_int(desc)) {
 		struct dwc3_gadget_ep_cmd_params params;
 		struct dwc3_trb	*trb;
-- 
2.1.1

