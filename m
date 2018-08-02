Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3EBC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12913214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rhnVjQnz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12913214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732469AbeHBO0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:26:30 -0400
Received: from mail-bl2nam02on0071.outbound.protection.outlook.com ([104.47.38.71]:14912
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732409AbeHBO03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOQYaEkn6CJfrNy/5WPYE2NiLhkM1Zi4tahiV9x9BrA=;
 b=rhnVjQnzu+YAd3BeTtCul6Wp60rnUnxI9eEyJ/o/+SdJI09RoJpuQb30diF42Isc51FGI3sy0CFB7PtANiWSV8YS4zB8W2nvpRFwC7gA81tWCU6NYIuVesuyQ9Hz19eiz+yziVSxoHGkCE5azLxfKojcP8zybBSZA26Y4o5qhQA=
Received: from SN4PR0201CA0042.namprd02.prod.outlook.com
 (2603:10b6:803:2e::28) by BYAPR02MB4326.namprd02.prod.outlook.com
 (2603:10b6:a03:56::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.21; Thu, 2 Aug
 2018 12:35:26 +0000
Received: from BL2NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by SN4PR0201CA0042.outlook.office365.com
 (2603:10b6:803:2e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Thu, 2 Aug 2018 12:35:26 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT050.mail.protection.outlook.com (10.152.77.101) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Thu, 2 Aug 2018 12:35:21 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:33618 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flCp6-0001m0-0N; Thu, 02 Aug 2018 05:35:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flCp0-0007PR-T5; Thu, 02 Aug 2018 05:35:14 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w72CZ6QR026465;
        Thu, 2 Aug 2018 05:35:06 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1flCor-0007K0-Uy; Thu, 02 Aug 2018 05:35:06 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 2B94B121417; Thu,  2 Aug 2018 18:05:05 +0530 (IST)
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
Subject: [PATCH v2 1/4] edac: synps: Add platform specific structures for ddrc controller
Date:   Thu, 2 Aug 2018 18:04:45 +0530
Message-ID: <1533213288-8771-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1533213288-8771-1-git-send-email-manish.narani@xilinx.com>
References: <1533213288-8771-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(376002)(39860400002)(2980300002)(438002)(199004)(189003)(36386004)(63266004)(81156014)(50226002)(126002)(106002)(6266002)(316002)(476003)(42186006)(54906003)(81166006)(103686004)(4326008)(2616005)(478600001)(47776003)(110136005)(8676002)(107886003)(72206003)(106466001)(16586007)(356003)(50466002)(90966002)(36756003)(5660300001)(186003)(26005)(51416003)(2201001)(52956003)(6666003)(426003)(76176011)(305945005)(486006)(44832011)(11346002)(2906002)(446003)(8936002)(7416002)(48376002)(336012)(107986001)(921003)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4326;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT050;1:G1D3+JifUTKOwA/E96Iz4Zz+q1AlmyFeE+e6Fr5K2Q70z7VORT0eYiH/zHAPBh1si91s99nK0AcvT8Gwht54VFJ5tadWHj5mvPnGBFCYMgbbeFcCw0uge4HtaiH6jPia
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa8861a6-8ba7-43a8-a766-08d5f8746c0a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BYAPR02MB4326;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;3:4WtnHWUpCezR7rr5x6JMKt722VeJCHG781opLtqRJf/cPUUtZvBQD+petJo/lPH0LTfKH3kG4h81uEviuQ1GWPCVR2Iw9R6JogBbqWP9HKEcI0pVwP4A2SVVob5amjjckzQHVVsAlR2ndQjTpmvtRJtdHnFT3QjouIQOE64bfQiwvvZGV2TEPWT/l76BwYqhmA9knV95C0adG5XGDnmIT9iIYLKuLZLwg3a5+Oos9uBSMfDEMFCBepixOh3bDpoJWiimN/lPLPm5G13pyd9kvyQEo3E+xub9JVUukNQsWCRzABlhRVqMuvRCyIxigiWO0GoOBWQNcNPzQXD2JSmZqby6TvjYtlao1PO2FKXPJUA=;25:Ef3/Ao4vO4ji5gAq2A9WkE9S+/C/siT9QrUaG2lAgW3atdwz+ADb/6zYHopGBNDAntDUkPsvcxEQkfDjTInKsDDmHw5MZrBjdtp8hOfHil1NPNByOlb9o1VnWBklN9PFxJXdJCjMTTHNmuUblupD0OoI1ffC/6/xpDAWGcuFL0j7S90bxRUa4rC2d9lbXmPq5qfGaRyKxzI2jbsl1beXt24ikMwbAy0LvHlviwlRBnyRnpRkdl26M5WTSZAraxeary8ymYG1rr9/m9jd/hKSP51A1er7+miedHLBT7JxFvkAzkTncqnZXIc/i2KtwRkWOjAiokZfIvjLHH4UDy9DlQ==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4326:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;31:EJ9v3yCHL6qO7qlBS06sSB/Iyt8zBmG+sTcVa2vun2GHUgRiYYV/Hq00ge8vyjw6PpIfLTxQPfL+luiO1VmDzZA23Ue+VLOWk02MrxweH1Xi5SPHLHqg/OUktTJ3dH1ijghAHztYL9m9usPAiihDihOvc+kTwpBTCXWI0IN5M/oWiohO7uM6px6mKikNj8DMfSchx+YjkAcvdn5Ms5S0cINFJ7UV+Q4+aMmgqWJ9EOY=;20:Ut+fbXTGI55oCBBYykeOBV3W7gBp6sl3ef+fKbPN3yvYTmI6zKR8nGNla7VokudYgDjBJAxbcWhj4tCRl+5R8DCAGc91rCLY/pwrbqE9Q11ERM1kVgaMfdR3RCfPvs+O67eHUZTsOZiVl1XehqoBUZ8RDmFtFRRa8UxgKABFrw0weEg/NKdA1XXuHnZLUEd/i5ndBF50LfDzQ//xgh5FcsCu9Wb1I6cd+mxaQ5saEFSuLtqmjVLcMs/1VAnYwOJFFB3HexDbkGWpt9e3UcYnHR9lGOKP1Z3rSZJtXXxAnkLnM8UR6/dCz9QWdypwZl4f5aQyUY6tDG0PkVz/frPuEqtc4/Eth9ItEVARg0fObP+K6J17oX1ifi6JnNz0fHPXj8geQA8wycmsrhQcbigANgjqiAi2jbls3d8vb8p/QBMdWwZwp/4EZJ/fZi96IgJz2tVfpc2kAfr/W2hifqk8msLswASmTuJa1zIhBVOgSOVQhgOwd2LAec0pg0sQXmQb
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB43262E5FF69E77BF3A262275C12C0@BYAPR02MB4326.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BYAPR02MB4326;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4326;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;4:CoP47k4m9saIFQ+5HuboawtEDMp4YVhP789+B39EmWhpzc2OaZqYq//29IStBmLWNmnbmsDqFVP7sVLHSMyKNw4wG1VH9/X6rAbEi2lU6+/pQ4txHe9obc5EzajT2np9bhRHzCw75brWJEQneMeThTKoYb4z2p8pup0wBtnYQCuQr28B1jy715y69gg4R4cSPsgVeT8fVI4DxiR+ruqW0EMnautZyScjWhVxBG9DA2n7VumuS0PK7AWxQpOCI2g8ebRC8dV9DXJPOlcAojl3E7lGQreTaQ4RnZiaAbUt6+01gPmpr6qdhwrM3AuBTH//
X-Forefront-PRVS: 07521929C1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4326;23:qHXBsifFk5XbBr/3rYfNky8W350LIUl3u+Iys8PJ1?=
 =?us-ascii?Q?hl9Ak4mgaDiboBGGyD/dd1DgOOPjtUwJCbIEVIlLw3qZJ+ileQq1Lhb98tlm?=
 =?us-ascii?Q?N75mevGC0SCkZDDep0Pce1WNawMXwl8f6bLOip2TW03ZkeiiM88Ka8vpqqJT?=
 =?us-ascii?Q?0FGHqe7QIF6xI2rnMtpqUUhXOB0oQ/EAfF1yp3AYsdQMvgj35kd9cf+E5KxH?=
 =?us-ascii?Q?DJ9HsYKIeHIDX7+mBVTvAvblzAsFtCwmqwauyLx+v1LCnC8wBpF54ingp/Mi?=
 =?us-ascii?Q?Wv9VkhXUiPnLxcjH3vYYtm9Tw+G0qg4k3Sxv8a+hW28vSP89jlbCdE94Y187?=
 =?us-ascii?Q?hNeFMSrpSE8imZOxLLOHgZwLa7o/k7ApsmZgG5GovJjBsrXZoET3/RkOQu+m?=
 =?us-ascii?Q?UUy0BuQ9C4hz70AlZIPYZw8ms3jfl6oVRZ5sW6XMTcsT6qiECDuT9sCR/R+8?=
 =?us-ascii?Q?nCHy/Vu8J++VXghF9GbrWpFjR1TH5tNiLzfZEyHIKGjJO1IO5zg/iEVaRMYi?=
 =?us-ascii?Q?MQwE6IhzIh+4NwvpoyXSBCWaXNBzOHq5pP75xmsXwd1FaNHdtYiyeoMKOB0l?=
 =?us-ascii?Q?4Tjr4pPIaldQREQArO73KmW8SxzSnjxLSmg8VXH5qz57P/TQ+rWOhMW5dF6r?=
 =?us-ascii?Q?owZ/MpiJer+jGCOcEGJyvVZQL88Fhii6DtlCk+5QWSU9fWy9NcZRWVQHNKlE?=
 =?us-ascii?Q?reFOuHak9rNN4OgeIZuV6QuAH0IdvUvRQHcZpu9O94kgoA0yKFFFwnH7y1DK?=
 =?us-ascii?Q?4xM6hg9qqzB6jJlBB2BVBPRQAUFGxyD7tGEOfRy81Q7wwEZ+wIXVMyTHj0Q4?=
 =?us-ascii?Q?yu6UZYa1gCUUrihZHJWcr+ZcHaeiaDP5Oq+h0a5VlZCFrXcZ2do8ywGcx4cS?=
 =?us-ascii?Q?BLtGqIVlA9sYU4BMQZ2EX020Y9478rAW8cpfsyPMtzncGZJ/BhiDcFtkgFz8?=
 =?us-ascii?Q?Wgr2Og/Wpy5QwGp6df/sggMSgdxrwf5yR/XTYR4EVYjAAeHzX7rLsyhyyrj8?=
 =?us-ascii?Q?DVT1ETpVT84FL20bPqLM7naoUg6ycnSIzFfXUw8pCZmFmR3kxFjSl2K7rRzN?=
 =?us-ascii?Q?stRVrzsIruqqGnFG/HuTdNe0tupX9n770OjIq4CgX/34K+S4QinTfoll4HRy?=
 =?us-ascii?Q?jGYTen8qoCahkN1Hyso29wgV3jXI2BMEmvxgrD/ZFRSkcEod+BtCQAOMj0B1?=
 =?us-ascii?Q?HaFqJk8fdfWfYLwd5lkLkJeOJx8iQvnXycXdzLXUgUw6oJyBTgFmFB1+xODC?=
 =?us-ascii?Q?gOqrA9tqVZDvwhn+oiXwnmrZmEWOosOhogV70ktaE0vAaYctPl5Spu7MHu2Z?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: /sqgkigddApFTTOzxjIDsOTZjFrwCQSBNR3H2B0TCQCPLPL2cUgvgbMO2C//Qh0ydlcukceT5qmpg+FsvmAhONHj1uGPS4iy5c7Wy7+1Ud3nB+uFFDYgYc961JQeZ4jusADMb8icLu4vUvauaC7fHzqLSX31Fa9uME892+sX80oP6r1TkvOyv8kUXew23ykaP3QlpDqR1hab1ZchlEKkcdxrpX8LIF7n7XCjojhQxH8py18w4yjnqJqdr7C+Mz4D1iDOeqrEYkY7ovb812U0epNa1Ey1SLk7gzo0owXnu1IvDqzYTOn7WF9n6Ixk+v7KbVybk+3k+W/BORcTQ4YlidyIKbLdRfYya39zxePmis8=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;6:FEd29eoI7Pa2Au/Q8ZJAS8W33nogMPxk3YMFPng7PGZSo9QldcdpLp52oGutO6MVtXi1r4Cc/LQNfjXfDCWnFRZVeDk+5tXbketP3ffCde0Ix9IFng7FFQ0R6kBTml+j6mrkje1fa0mQIDNuT3vlU7vbyhqeObBYB/HOrgOz6CT08JlkYdR82e/fiiSTBQcCJbK11y7KB+uL5WLN9fBt25NG+HpA6cW9zpH31P5TkjbiFlGAX5+BeKpoUFySz665VVE3hotuWIL2nFhgbdRUspFQuo9KdlHh2IRWFQs4uZJuA0Q+EFV+V7NmxQLT1imEbUKZ6k4kjh7ifBUWG+8GOXTxllxBme6B8+ln620h6mOfAOJxtxSiBwTACPkjTyc8Z7r6b0RTznelMwPA2weIwh2EcC2QuGXD05mGIIiici1Y64QFQ+LzYzNHfjmmGVjxYlhh3ticMWYz+S91rckcBQ==;5:gRAsG3cdIfqlb6tJg9mAhLuSnOKC6sekCVV08Ui34XZ486SLV09RuuKC5sWRa/bv1iA2sW8C6n6ak36VUXE9ivTAAfwSYUUM6g3atdunBpo7N2BEqr8/1FYeffN8vK9+9iov11KgwXX13ysh1xxqaqh+DZxSCTZB5sNdQMOkqH8=;7:W+X4fqw44rU2+PdXT7/0yY2TuXj2PbTvA7P0vLUHQHlvIKT31YTZsoxeglE579YVtn3P1/gTZSeOcYD+6AhOJB3fThf/smndAmgWWr4uBffldsxUViDBHwLiaQBMeC1dlo34/8nYNcCtV61RFgak2GBBpmzhsyoa+HCBXxhDPoh5r4q8CZCWs76/pjupj0icZLV3/D+bN+zEQS6+uW8kFetm5hx31h3VxxpqHgiojZB6/hTLLIAuHPRh2hP4xdd5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 12:35:21.0167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8861a6-8ba7-43a8-a766-08d5f8746c0a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4326
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds platform specific structures, so that we can add
different IP support later using quirks.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 64 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 0c9c59e..d4798e8 100644
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
@@ -137,11 +139,29 @@ struct synps_edac_priv {
 	void __iomem *baseaddr;
 	char message[SYNPS_EDAC_MSG_SIZE];
 	struct synps_ecc_status stat;
+	const struct synps_platform_data *p_data;
 	u32 ce_cnt;
 	u32 ue_cnt;
 };
 
 /**
+ * struct synps_platform_data -  synps platform data structure
+ * @synps_edac_geterror_info:	function pointer to synps edac error info
+ * @synps_edac_get_mtype:	function pointer to synps edac mtype
+ * @synps_edac_get_dtype:	function pointer to synps edac dtype
+ * @synps_edac_get_eccstate:	function pointer to synps edac eccstate
+ * @quirks:			to differentiate IPs
+ */
+struct synps_platform_data {
+	int (*synps_edac_geterror_info)(void __iomem *base,
+					struct synps_ecc_status *p);
+	enum mem_type (*synps_edac_get_mtype)(const void __iomem *base);
+	enum dev_type (*synps_edac_get_dtype)(const void __iomem *base);
+	bool (*synps_edac_get_eccstate)(void __iomem *base);
+	int quirks;
+};
+
+/**
  * synps_edac_geterror_info - Get the current ecc error info
  * @base:	Pointer to the base address of the ddr memory controller
  * @p:		Pointer to the synopsys ecc status structure
@@ -242,7 +262,8 @@ static void synps_edac_check(struct mem_ctl_info *mci)
 	struct synps_edac_priv *priv = mci->pvt_info;
 	int status;
 
-	status = synps_edac_geterror_info(priv->baseaddr, &priv->stat);
+	status = priv->p_data->synps_edac_geterror_info(priv->baseaddr,
+							&priv->stat);
 	if (status)
 		return;
 
@@ -372,10 +393,12 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)
 		for (j = 0; j < csi->nr_channels; j++) {
 			dimm            = csi->channels[j]->dimm;
 			dimm->edac_mode = EDAC_FLAG_SECDED;
-			dimm->mtype     = synps_edac_get_mtype(priv->baseaddr);
+			dimm->mtype     = priv->p_data->synps_edac_get_mtype(
+						priv->baseaddr);
 			dimm->nr_pages  = (size >> PAGE_SHIFT) / csi->nr_channels;
 			dimm->grain     = SYNPS_EDAC_ERR_GRAIN;
-			dimm->dtype     = synps_edac_get_dtype(priv->baseaddr);
+			dimm->dtype     = priv->p_data->synps_edac_get_dtype(
+						priv->baseaddr);
 		}
 	}
 
@@ -423,6 +446,21 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
 	return status;
 }
 
+static const struct synps_platform_data zynq_edac_def = {
+	.synps_edac_geterror_info	= synps_edac_geterror_info,
+	.synps_edac_get_mtype		= synps_edac_get_mtype,
+	.synps_edac_get_dtype		= synps_edac_get_dtype,
+	.synps_edac_get_eccstate	= synps_edac_get_eccstate,
+	.quirks				= 0,
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
@@ -440,13 +478,22 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
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
+	if (!(p_data->synps_edac_get_eccstate(baseaddr))) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
 	}
@@ -468,6 +515,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 
 	priv = mci->pvt_info;
 	priv->baseaddr = baseaddr;
+	priv->p_data = match->data;
+
 	rc = synps_edac_mc_init(mci, pdev);
 	if (rc) {
 		edac_printk(KERN_ERR, EDAC_MC,
@@ -511,13 +560,6 @@ static int synps_edac_mc_remove(struct platform_device *pdev)
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

