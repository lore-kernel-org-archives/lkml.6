Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95393C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BE421526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ZNadjdsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BE421526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732318AbeITPOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:14:00 -0400
Received: from mail-cys01nam02on0089.outbound.protection.outlook.com ([104.47.37.89]:61520
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731755AbeITPOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rv7+rOosiyUIuL1PmMdDfsDEjb1/gAdZycZjgZVHR1E=;
 b=ZNadjdspBBR1gpvWXZshloWSXEECynwVoS3lVeTlB+ZZ11YImFy4JMMfDehm8y/4ZgUeSAim5gxRqNqdBm44GxsSzpm0phVYhCMwN/RXukDulfNABwUbMa6StRc4Jo2h/5BP2PlXRFtO/lzpEOmMVqHCjJp271UgJPqnYd+Y5v8=
Received: from DM6PR02CA0030.namprd02.prod.outlook.com (2603:10b6:5:1c::43) by
 BYAPR02MB5109.namprd02.prod.outlook.com (2603:10b6:a03:70::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Thu, 20 Sep 2018 09:31:19 +0000
Received: from SN1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by DM6PR02CA0030.outlook.office365.com
 (2603:10b6:5:1c::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Thu, 20 Sep 2018 09:31:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT025.mail.protection.outlook.com (10.152.72.87) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Thu, 20 Sep 2018 09:31:18 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:58987 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g2vIs-0002Zr-4e; Thu, 20 Sep 2018 02:31:18 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g2vIn-0007oX-0p; Thu, 20 Sep 2018 02:31:13 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g2vIf-0007jV-12; Thu, 20 Sep 2018 02:31:05 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 3B73312167E; Thu, 20 Sep 2018 15:01:04 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <adrian.hunter@intel.com>, <manish.narani@xilinx.com>,
        <amit.kucheria@linaro.org>, <sudeep.holla@arm.com>,
        <leoyang.li@nxp.com>, <jollys@xilinx.com>, <rajanv@xilinx.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH v2 3/4] sdhci: arasan: Add support to read and set tap delays from DT for ZynqMP
Date:   Thu, 20 Sep 2018 15:00:44 +0530
Message-ID: <1537435845-6682-4-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537435845-6682-1-git-send-email-manish.narani@xilinx.com>
References: <1537435845-6682-1-git-send-email-manish.narani@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39850400004)(396003)(2980300002)(438002)(3190300001)(199004)(189003)(2906002)(305945005)(48376002)(54906003)(106002)(50466002)(51416003)(90966002)(42186006)(316002)(7416002)(50226002)(110136005)(106466001)(478600001)(8936002)(81166006)(76176011)(16586007)(81156014)(5660300001)(63266004)(6636002)(6666003)(217873002)(336012)(47776003)(103686004)(44832011)(186003)(72206003)(8676002)(4326008)(36756003)(11346002)(52956003)(2616005)(446003)(476003)(26005)(126002)(356003)(486006)(6266002)(36386004)(2201001)(426003)(921003)(107986001)(2101003)(83996005)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5109;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT025;1:CtGh12X5dluxB7gyzzBIlmpXdlajYysFKLZdOSM9TIA/SGIx3D7XUSMBLWjeJlg4ZBgYjKIoepJW1hr7NW9nfuOtmN02F+uCr300qXce0ES5B8OCaKUS2ogLv5fAClOW
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46f58700-54b2-4496-4308-08d61edbd217
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB5109;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5109;3:YFMB6XnkqjZkpYMqiqPU3Ta1dDGCNHzVP8fTiptJvr4gKiljmTuEOyd/5RH2sVaa/u0InAgYplVlIWT3XtBPFHuVQPKBSlRlu+Vxu1nd6Ko1guTkUyQm6j8SOFUeRRIZQ2OE0m0QUctljVmoPdvg0jHBZcR98NaQCV5LdPC2dpLg3boLSro3hcuwQcfkRoSWg1LK8QNn0TDMED9L2+ITNVrvgiSpe+bpG4XcuYMYVfat5VghEgTgibFwmHvmcLMEKtOO7Sy68QDgNGvfzEbwKJ3cr6dlc1ApQ+Bjnv71kGnRc+UP0C42dliHtnB0uwAIuhTtlS5i7BceUsF/MXM1LdFFfxMbrvaP4F4xS87EMOY=;25:LjVdzNksu1LWVeXl6xGOiXWw0uIMfbAeioKEjVNIVwOzuChwH81rTu6Jqmsl31M1jSDHT/pMgSz2wwkkL0gxzgd9LG2oaOOOYSWojDSxnHMrkFiyUw6kPOwk9+kdnRxNjRHb4kTDNaeJBZklZa+wBxKH5zYDtc7uwzgnUlJ8hy6Ck+s4iimyEdFkYns7zFnLGgy8pXh6UqChl9EFEGdc8cS7mQtr+ekbv7FMn+lNYrOCrK2BraZYSj7YY4oHovqN6PfDqmH91PLsGQqOt0SUNQF97ePNVwpdrZAIazPbJqebkUWkkj9oun8pvfBKOckQJkSsj9O8ec3bLvyzjcnRhA==
X-MS-TrafficTypeDiagnostic: BYAPR02MB5109:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5109;31:QOR4H8rYTH1xMffeXio5cCneJfuZ8XCTEWJden0jWBL1zw/mR0pCCzn10q307b8Wpd909oSA1bYgleGPrevTNBONdwxzbP+G1Uta8DMbgdn0jSrX5xokOt5KE7W124R2X/whhFkFRPSyy+JmvAY4LRSHqjKTg92VCpkSQA3UjGmK/GhvdOI7rEXPP5iC7S1zeepC4iRr78f7OorcMraTSitWa3A7cXRCdxbYghvWQt0=;20:ryQgjoZ9e4t8hVdZkSDR2mDJytflExUypui7gLPqKcjGFWuI2DV1lNdaniC/uqFm3mQZJhp01CRp0hVnG//uoV2akJtAk3UwsaxHmGOXPg9XnjJFx22Nus2dIHFVlWUzH7aoo4o00LUstcs5J/doUtJPgHIx5BkYAhgLSD6uKQXLdTS6A8lyDzXBeaJfXBQUNVrQmV/xiPwI5Pqjjyp3vkY8XUjNhXskTBMXDnLv4Ct2vtCBqVWl5LfC+l9huUnk8OVJwkY2nogP4GiEmzXTh0x5MGlIAXrnpqH4Artr5y2yeTPkANWKBL6IQwKU5EoEHqObTdF+ZIp9ShsDjQ/TYY/bHUL6zpDGb6FBRZPosYvGH1FyvXQsLuv0AaL5ur3EyHeRlSgnyNtGoSOXqme1gov6nk8owqjylk4AyIi6RxPN5P2NKb6B9TrmY2Uljmxc1RpChB1c2Kd6N8nHmTrom2qJUASpZJcnDNmeNqVANTBNi6mm+8v4qoTExX76oIHL
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB5109A14CCC12CD7C7D7C32C2C1130@BYAPR02MB5109.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(105169848403564);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3002001)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:BYAPR02MB5109;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB5109;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5109;4:7l+TJbPS9HfHEMWbXaCC/UNdaO1QMsPrpH0iUD3LHB+0kkw35OFi6d3WSXC+u8Je5rEyGKpdC/wehnAMY7MQtDW50z8sm80A4GWxy8R9A0r+Jrjoho/+LxMZf1KjYvJAu5z5Xb10poY+pbLcZRQdGQkjRAmPWp0u8oGbL3v9ONi4KklybFKR8ZgrQFhnjVQ1w5fvGLOZBe3R+1Q5A3v0s0PEJEZwh6C31ewxrWTvIxbAR155ueOoR+AVNlzrVGq/VNe7AxmVPHGcwQmRmJxZkIHmOICg62sYpiUGs96GvphUNCCy2GStwYzASS9gjeFu0JBC5px3GOuU50hD9Z7blkte441JmuUlqv3vH3C6pNY=
X-Forefront-PRVS: 0801F2E62B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB5109;23:OhMFFhN5ME6rLRlUa6KFQo2jFJ7o5yHQG72Qrxbtu?=
 =?us-ascii?Q?ZVMOCro+RQEyYAUu14yh+URCxJTzA8zXdRzaT1sY2KKN+s90ah+kQKillTLS?=
 =?us-ascii?Q?EiMSuchh8zTryqFNzssvHw3YNzR3FWAeTeUL/boLABQCgLGwXa+Z0zLDICaX?=
 =?us-ascii?Q?Vc+p+pCH3JG8hCZ45b8QEqnhB22Ng+3UECZmTTZ8Q2l8zSOl3re4hRMy2Z3M?=
 =?us-ascii?Q?FtJJrWC9kcNONA4GkV9tpsgFEaYXCaPaZcUh9vOuFPSuMrQ/Hd29LEwGgKTQ?=
 =?us-ascii?Q?4sdrQ1Exm4NlHL7W5RLS75edcqN0yinWX50+/B1m1CXAjN51fvHi4EUrVVeM?=
 =?us-ascii?Q?CCE0Cu5CdTOrzyl2LdPgquXAk5XhGjL5REAaor0hi/DRKH1nH/tJuAsUoIix?=
 =?us-ascii?Q?65/t7k0DhviaNEdJEFtMC7OQceXsB8GfpcQqykzXs/5ARySXXMtpWt2Xe1wa?=
 =?us-ascii?Q?XpXFiG2LaVNukTJeiTipkfKuoBivZjxDrclWYrsUeGxTuf+Xe8Nch4cJoLEm?=
 =?us-ascii?Q?KH7y/8u2iNyukfbXhqzOokDJwSmpp28EKVYptXFF4FDvlKajlazfL3g8v7rm?=
 =?us-ascii?Q?9hQyr3LC6TL8sNHVZqXHOAfXL1kUsFCLc8k/sN1DMvaCBKqb/BMW+iG+fRZW?=
 =?us-ascii?Q?8IB+McPDUK6UmkASxt+w6AwT47M9IRoXEZ2kY/vpT4KLSHfXAuTiuQsTb0De?=
 =?us-ascii?Q?EmNCjYz66RPwrvwasttIIPnLeALC/tUqIcuruJJzOAngin49rpZYUZFAfMvU?=
 =?us-ascii?Q?kC7KtF0hqgVM+ch06Ztpd8Swyst4kAi4AfDNaJxAXYGj5WgwwXM/PRgENNqr?=
 =?us-ascii?Q?i0ZzouiUEbhZMElSHgUmSbJiDYw8/gwHUzjkIrUKckmXke+Cv0Xx4i8LnMtY?=
 =?us-ascii?Q?StncqVl81naZs+/dWR7n46V+8gdrPKlylF/Cp6O+gcW6qOyAxof4EWggqfPL?=
 =?us-ascii?Q?RYf43IsZ4yR88GDuIw/94Lds5W3bBkoFaKbfBiAEnHtpZOGU21tqP7/4aV79?=
 =?us-ascii?Q?wJ9+ygYU5jPlsP8oYl0OAkRdYGWKyyDrlu2uN1y7bUpwgItr/qq6BMbT/yxQ?=
 =?us-ascii?Q?8BDDX35h85DYAZzYDwFSmeb7Cg2DnJYpnpkm+l/Tcj9rmjNtOEhJ9+ph1tE4?=
 =?us-ascii?Q?v1zTkWkx4eZ5Qg0ifyFmwowlTXtQLbJolTeB0mD5JT3Jkav7UQ6+ha1n/3xi?=
 =?us-ascii?Q?8096v9znBQFKT5bFIY+3ldiA7DhONOnSQMFihCFq3aZ7sJzX9Qj5FofjhFrx?=
 =?us-ascii?Q?ZBXhTuY7lBxZXJWSagPn7CBVbnQHynZ2G3tgGUuz1wk0cEOWQLd8ctMs7doN?=
 =?us-ascii?Q?WAu7bytDEdwn7wwUCijRPYhlDyGqDZXTIwJdqMSA5+KFDgkMfQj8BKoGAKj4?=
 =?us-ascii?Q?tdrnxMUv+OJRxPFc2AkxHKjN8s=3D?=
X-Microsoft-Antispam-Message-Info: 2kGn7NoA1Iurfrg+r0QmjKqhIK9Ext4WTMugBuSYNaqjwpHBzN5XpBIcMPURLtLFj8UtXR3n/dVi64lCU4kPo2wCKH179rIk3+xc7y5QgAifiU5CiYQF6N6BPSbe7FtpqzfoG09etsUViNeVWHHiF7mxU2SJI1rRdSZ5XhV+n2WS4tjEDFlngf2CzIyZEhDlw3YbsGJ5bLN1owIvG0rwNLPs1Glu7u9nJA5uG8R+B2Yr/nCwrCIZNXlCxv85pwdGYCEOnoLJg1xl/OSHQ6G1RMg2d9/Tn8uBpHaFqJYizxOXKB7MTsqvI5z6ltnMSs01fDq6E/OPdjGa27wjoW8dfi+a5DC8hulmUq/u8HAcRi8=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5109;6:hpHTnhkmQWHSCt6Z8702ZlsBb94UFY9x52bHdPHa57JHRSrtwZ81VR2eZoAHZwS/XoSK+lYLDEJTLN1EOU0+8bkoUzjjvtt+Z6L7GMMw3sojdCFF8ptEGcBB8P0jfgT3wdBJXPwV4M3i6Q8eaB8jfXKU2EAcrOxk/ZJprUu4Unf8fhNwcpzP4hXZLSCh2r8Mw6VXZofJHLDw1RoYUShJ3PvC611PjrvanlClvGbZyCy29cNc60F5kTyxOxGPNOoh79OB+a2xVvnBWoDgEA3GfvnxmHCHB34/CHYRo+2TEPA7HtrXXvLq8yvsDiopxzPqImpN4mI3LWsmfwXh9+ZHKiCIo80AugUjRVgwZG7RcipN/j8YiwE1wiEPRYejn6dYBTPIB5afisByi8i7KIxJ/pCR8Eu3cYquUvlyN8QAF1GiC49NczphDcWdDavv98CvEbVQUFajT6iFJY47sHAx/g==;5:FjEsPNeOUTjgdjmlUQ7y4VG1pCW7UGMArOmvvDTAJEF6ojSCGHzLNofVwpzEXNNIM3iK550BjdbyosPOm17FqQGwyCTqJIrP1aY3Jc+ZU794A8ZID37cBh76OYuOXSb7LNMqFfg4nGrnzld09KMF9npPWz4icImUiJT7HSGK3tk=;7:lkXbPQOQB6QVUEOVGpvMnvRsfxVkwRteyROSR+BvYmQBtRl8+je0FQ8d6orROGLO26yvnLlcsvC4aQoL/4Y2dPpe5+8nIxJSLiJ2j4IfXQyEch2ViqytE0OieVDCQboGTV2bTFQFa7FLOgbpTqI8l4f/+9vM68YaxobksHA7jdvvc/Qs0HlGf8qOSCqUToPBK5dJgdrdaWKAnm54HT5tLMx4rp1+2xAMTOAd4T6ho+KXe/Cc7x2UuN4E5kt248qX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 09:31:18.5602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f58700-54b2-4496-4308-08d61edbd217
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apart from taps set by auto tuning, ZynqMP platform has feature to set
the tap values manually. Add support to read tap delay values from
DT and set the same in HW via ZynqMP SoC framework. Reading Tap
Delays from DT is optional, if the property is not available in DT the
driver will use the pre-defined Tap Delay Values.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/firmware/xilinx/Makefile            |   1 +
 drivers/firmware/xilinx/zynqmp-tap-delays.c |  39 +++++
 drivers/mmc/host/sdhci-of-arasan.c          | 215 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h        |   4 +
 4 files changed, 259 insertions(+)
 create mode 100644 drivers/firmware/xilinx/zynqmp-tap-delays.c

diff --git a/drivers/firmware/xilinx/Makefile b/drivers/firmware/xilinx/Makefile
index 875a537..c32b2a3 100644
--- a/drivers/firmware/xilinx/Makefile
+++ b/drivers/firmware/xilinx/Makefile
@@ -2,4 +2,5 @@
 # Makefile for Xilinx firmwares
 
 obj-$(CONFIG_ZYNQMP_FIRMWARE) += zynqmp.o
+obj-$(CONFIG_ZYNQMP_FIRMWARE) += zynqmp-tap-delays.o
 obj-$(CONFIG_ZYNQMP_FIRMWARE_DEBUG) += zynqmp-debug.o
diff --git a/drivers/firmware/xilinx/zynqmp-tap-delays.c b/drivers/firmware/xilinx/zynqmp-tap-delays.c
new file mode 100644
index 0000000..2e5cab3
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp-tap-delays.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Zynq MPSoC Tap Delay Programming
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Manish Narani <mnarani@xilinx.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/types.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+
+/**
+ * zynqmp_set_tap_delay - Program the tap delays.
+ * @deviceid:		Unique Id of device
+ * @itap_delay:		Input Tap Delay
+ * @oitap_delay:	Output Tap Delay
+ */
+void zynqmp_set_tap_delay(u8 deviceid, u8 itap_delay, u8 otap_delay)
+{
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+	u32 node_id = (deviceid == 0) ? NODE_SD_0 : NODE_SD_1;
+
+	if (!eemi_ops || !eemi_ops->ioctl)
+		return;
+
+	/* Set the Input Tap Delay */
+	if (itap_delay)
+		eemi_ops->ioctl(node_id, IOCTL_SET_SD_TAPDELAY,
+				PM_TAPDELAY_INPUT, itap_delay, NULL);
+
+	/* Set the Output Tap Delay */
+	if (otap_delay)
+		eemi_ops->ioctl(node_id, IOCTL_SET_SD_TAPDELAY,
+				PM_TAPDELAY_OUTPUT, otap_delay, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_set_tap_delay);
+
diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 1a8bbd2..57f89af 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -77,6 +77,18 @@ struct sdhci_arasan_soc_ctl_map {
 };
 
 /**
+ * struct sdhci_arasan_zynqmp_data
+ * @mio_bank		Memory IO Bank number
+ * @itapdly		Input Tap Delays array for different host timings
+ * @otapdly		Output Tap Delays array for different host timings
+ */
+struct sdhci_arasan_zynqmp_data {
+	u32 mio_bank;
+	u32 itapdly[MMC_TIMING_MMC_HS400 + 1];
+	u32 otapdly[MMC_TIMING_MMC_HS400 + 1];
+};
+
+/**
  * struct sdhci_arasan_data
  * @host:		Pointer to the main SDHCI host structure.
  * @clk_ahb:		Pointer to the AHB clock
@@ -99,6 +111,7 @@ struct sdhci_arasan_data {
 
 	struct regmap	*soc_ctl_base;
 	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
+	struct sdhci_arasan_zynqmp_data zynqmp_data;
 	unsigned int	device_id;
 	unsigned int	quirks; /* Arasan deviations from spec */
 
@@ -235,7 +248,11 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	struct device *dev = mmc_dev(host->mmc);
+	unsigned int timing = host->timing;
 	bool ctrl_phy = false;
+	u8 itap_delay;
+	u8 otap_delay;
 
 	if (!IS_ERR(sdhci_arasan->phy)) {
 		if (!sdhci_arasan->is_phy_on && clock <= PHY_CLK_TOO_SLOW_HZ) {
@@ -278,6 +295,17 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	sdhci_set_clock(host, clock);
 
+	if (of_device_is_compatible(dev->of_node, "xlnx,zynqmp-8.9a")) {
+		if ((host->version >= SDHCI_SPEC_300) &&
+		    (timing != MMC_TIMING_LEGACY) &&
+		    (timing != MMC_TIMING_UHS_SDR12)) {
+			itap_delay = sdhci_arasan->zynqmp_data.itapdly[timing];
+			otap_delay = sdhci_arasan->zynqmp_data.otapdly[timing];
+			zynqmp_set_tap_delay(sdhci_arasan->device_id,
+					     itap_delay, otap_delay);
+		}
+	}
+
 	if (sdhci_arasan->quirks & SDHCI_ARASAN_QUIRK_CLOCK_UNSTABLE)
 		/*
 		 * Some controllers immediately report SDHCI_CLOCK_INT_STABLE
@@ -723,6 +751,182 @@ static void sdhci_arasan_unregister_sdclk(struct device *dev)
 	of_clk_del_provider(dev->of_node);
 }
 
+/**
+ * arasan_zynqmp_dt_parse_tap_delays - Read Tap Delay values from DT
+ *
+ * Called at initialization to parse the values of Tap Delays.
+ *
+ * @dev:		Pointer to our struct device.
+ */
+static void arasan_zynqmp_dt_parse_tap_delays(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	u32 mio_bank = sdhci_arasan->zynqmp_data.mio_bank;
+	u32 *itapdly = sdhci_arasan->zynqmp_data.itapdly;
+	u32 *otapdly = sdhci_arasan->zynqmp_data.otapdly;
+	struct device_node *np = dev->of_node;
+	int ret;
+
+	/*
+	 * Read Tap Delay values from DT, if the DT does not contain the
+	 * Tap Values then use the pre-defined values
+	 */
+	ret = of_property_read_u32(np, "xlnx,itap-delay-sd-hsd",
+				   &itapdly[MMC_TIMING_SD_HS]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined itapdly for MMC_TIMING_SD_HS\n");
+		itapdly[MMC_TIMING_SD_HS] = ZYNQMP_ITAPDLYSEL_SD_HSD;
+	}
+
+	ret = of_property_read_u32(np, "xlnx,otap-delay-sd-hsd",
+				   &otapdly[MMC_TIMING_SD_HS]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined otapdly for MMC_TIMING_SD_HS\n");
+		otapdly[MMC_TIMING_SD_HS] = ZYNQMP_OTAPDLYSEL_SD_HSD;
+	}
+
+	ret = of_property_read_u32(np, "xlnx,itap-delay-sdr25",
+				   &itapdly[MMC_TIMING_UHS_SDR25]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined itapdly for MMC_TIMING_UHS_SDR25\n");
+		itapdly[MMC_TIMING_UHS_SDR25] = ZYNQMP_ITAPDLYSEL_SDR25;
+	}
+
+	ret = of_property_read_u32(np, "xlnx,otap-delay-sdr25",
+				   &otapdly[MMC_TIMING_UHS_SDR25]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined otapdly for MMC_TIMING_UHS_SDR25\n");
+		otapdly[MMC_TIMING_UHS_SDR25] = ZYNQMP_OTAPDLYSEL_SDR25;
+	}
+
+	ret = of_property_read_u32(np, "xlnx,itap-delay-sdr50",
+				   &itapdly[MMC_TIMING_UHS_SDR50]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined itapdly for MMC_TIMING_UHS_SDR50\n");
+		itapdly[MMC_TIMING_UHS_SDR50] = ZYNQMP_ITAPDLYSEL_SDR50;
+	}
+
+	ret = of_property_read_u32(np, "xlnx,otap-delay-sdr50",
+				   &otapdly[MMC_TIMING_UHS_SDR50]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined otapdly for MMC_TIMING_UHS_SDR50\n");
+		otapdly[MMC_TIMING_UHS_SDR50] = ZYNQMP_OTAPDLYSEL_SDR50;
+	}
+
+	ret = of_property_read_u32(np, "xlnx,itap-delay-sd-ddr50",
+				   &itapdly[MMC_TIMING_UHS_DDR50]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined itapdly for MMC_TIMING_UHS_DDR50\n");
+		itapdly[MMC_TIMING_UHS_DDR50] = ZYNQMP_ITAPDLYSEL_SD_DDR50;
+	}
+
+	ret = of_property_read_u32(np, "xlnx,otap-delay-sd-ddr50",
+				   &otapdly[MMC_TIMING_UHS_DDR50]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined otapdly for MMC_TIMING_UHS_DDR50\n");
+		otapdly[MMC_TIMING_UHS_DDR50] = ZYNQMP_OTAPDLYSEL_SD_DDR50;
+	}
+
+	ret = of_property_read_u32(np, "xlnx,itap-delay-mmc-hsd",
+				   &itapdly[MMC_TIMING_MMC_HS]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined itapdly for MMC_TIMING_MMC_HS\n");
+		itapdly[MMC_TIMING_MMC_HS] = ZYNQMP_ITAPDLYSEL_MMC_HSD;
+	}
+
+	ret = of_property_read_u32(np, "xlnx,otap-delay-mmc-hsd",
+				   &otapdly[MMC_TIMING_MMC_HS]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined otapdly for MMC_TIMING_MMC_HS\n");
+		otapdly[MMC_TIMING_MMC_HS] = ZYNQMP_OTAPDLYSEL_MMC_HSD;
+	}
+
+	ret = of_property_read_u32(np, "xlnx,itap-delay-mmc-ddr52",
+				   &itapdly[MMC_TIMING_MMC_DDR52]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined itapdly for MMC_TIMING_MMC_DDR52\n");
+		itapdly[MMC_TIMING_MMC_DDR52] = ZYNQMP_ITAPDLYSEL_MMC_DDR52;
+	}
+
+	ret = of_property_read_u32(np, "xlnx,otap-delay-mmc-ddr52",
+				   &otapdly[MMC_TIMING_MMC_DDR52]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined otapdly for MMC_TIMING_MMC_DDR52\n");
+		otapdly[MMC_TIMING_MMC_DDR52] = ZYNQMP_OTAPDLYSEL_MMC_DDR52;
+	}
+
+	ret = of_property_read_u32(np, "xlnx,itap-delay-sdr104",
+				   &itapdly[MMC_TIMING_UHS_SDR104]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined itapdly for MMC_TIMING_UHS_SDR104\n");
+		if (mio_bank == 2) {
+			itapdly[MMC_TIMING_UHS_SDR104] =
+				ZYNQMP_ITAPDLYSEL_SDR104_B2;
+		} else {
+			itapdly[MMC_TIMING_UHS_SDR104] =
+				ZYNQMP_ITAPDLYSEL_SDR104_B0;
+		}
+	}
+
+	ret = of_property_read_u32(np, "xlnx,otap-delay-sdr104",
+				   &otapdly[MMC_TIMING_UHS_SDR104]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined otapdly for MMC_TIMING_UHS_SDR104\n");
+		if (mio_bank == 2) {
+			otapdly[MMC_TIMING_UHS_SDR104] =
+				ZYNQMP_OTAPDLYSEL_SDR104_B2;
+		} else {
+			otapdly[MMC_TIMING_UHS_SDR104] =
+				ZYNQMP_OTAPDLYSEL_SDR104_B0;
+		}
+	}
+
+	ret = of_property_read_u32(np, "xlnx,itap-delay-mmc-hs200",
+				   &itapdly[MMC_TIMING_MMC_HS200]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined itapdly for MMC_TIMING_MMC_HS200\n");
+		if (mio_bank == 2) {
+			itapdly[MMC_TIMING_MMC_HS200] =
+				ZYNQMP_ITAPDLYSEL_MMC_HS200_B2;
+		} else {
+			itapdly[MMC_TIMING_MMC_HS200] =
+				ZYNQMP_ITAPDLYSEL_MMC_HS200_B0;
+		}
+	}
+
+	ret = of_property_read_u32(np, "xlnx,otap-delay-mmc-hs200",
+				   &otapdly[MMC_TIMING_MMC_HS200]);
+	if (ret) {
+		dev_dbg(dev,
+			"Using predefined otapdly for MMC_TIMING_MMC_HS200\n");
+		if (mio_bank == 2) {
+			otapdly[MMC_TIMING_MMC_HS200] =
+				ZYNQMP_OTAPDLYSEL_MMC_HS200_B2;
+		} else {
+			otapdly[MMC_TIMING_MMC_HS200] =
+				ZYNQMP_OTAPDLYSEL_MMC_HS200_B0;
+		}
+	}
+}
+
 static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan)
 {
 	struct sdhci_host *host = sdhci_arasan->host;
@@ -863,6 +1067,15 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 	if (of_device_is_compatible(pdev->dev.of_node, "xlnx,zynqmp-8.9a")) {
 		ret = of_property_read_u32(pdev->dev.of_node,
+					   "xlnx,mio-bank",
+					   &sdhci_arasan->zynqmp_data.mio_bank);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"\"xlnx,mio-bank \" property is missing.\n");
+			goto unreg_clk;
+		}
+
+		ret = of_property_read_u32(pdev->dev.of_node,
 					   "xlnx,device_id",
 					   &sdhci_arasan->device_id);
 		if (ret < 0) {
@@ -871,6 +1084,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 			goto unreg_clk;
 		}
 
+		arasan_zynqmp_dt_parse_tap_delays(&pdev->dev);
+
 		host->mmc_host_ops.execute_tuning =
 			arasan_zynqmp_execute_tuning;
 	}
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 40feebc..b00388f 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -144,11 +144,15 @@ struct zynqmp_eemi_ops {
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
 const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
+/* API for programming the tap delays */
+void zynqmp_set_tap_delay(u8 deviceid, u8 itap_delay, u8 otap_delay);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
 	return NULL;
 }
+inline void zynqmp_set_tap_delay(u8 deviceid, u8 itap_delay,
+					u8 otap_delay) {}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.1.1

