Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02878C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA5D2087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FJRZXoB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA5D2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeJDWaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:30:24 -0400
Received: from mail-cys01nam02on0054.outbound.protection.outlook.com ([104.47.37.54]:18880
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727869AbeJDWaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ii3kUvklkMyjKv/KZKvZ0U/8TK00+4QAZeczvI6Ah4k=;
 b=FJRZXoB87tZPV2Zqhi3FTzhvJ6dZ1wYZ0TaRedoAztzNh1Iu7N5tJLAf/S4lj0NZRp3QshwOx/g1xArHfD7AOx1iEne17JKxaKsKVmNIPyJAO7itR4QidM6RRHilEfQRGTNB94apJtogT0/6UN6kpV0MjlQvL0iiZ+UhovCDdL4=
Received: from BN6PR02CA0088.namprd02.prod.outlook.com (2603:10b6:405:60::29)
 by BYAPR02MB4470.namprd02.prod.outlook.com (2603:10b6:a03:10::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.18; Thu, 4 Oct
 2018 15:36:13 +0000
Received: from BL2NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by BN6PR02CA0088.outlook.office365.com
 (2603:10b6:405:60::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.18 via Frontend
 Transport; Thu, 4 Oct 2018 15:36:12 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT056.mail.protection.outlook.com (10.152.77.221) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1207.19
 via Frontend Transport; Thu, 4 Oct 2018 15:36:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:55790 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g85ff-0002YQ-AO; Thu, 04 Oct 2018 08:36:11 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g85fa-0000EC-76; Thu, 04 Oct 2018 08:36:06 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w94Fa36i031104;
        Thu, 4 Oct 2018 08:36:03 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g85fW-0000Bj-NM; Thu, 04 Oct 2018 08:36:03 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id ADB5B1214C9; Thu,  4 Oct 2018 21:06:01 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <sudeep.holla@arm.com>,
        <amit.kucheria@linaro.org>, <leoyang.li@nxp.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v8 08/10] edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
Date:   Thu, 4 Oct 2018 21:05:26 +0530
Message-ID: <1538667328-9465-9-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
References: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39850400004)(136003)(346002)(2980300002)(438002)(199004)(189003)(2906002)(478600001)(90966002)(2616005)(106002)(6266002)(110136005)(476003)(126002)(446003)(486006)(426003)(4744004)(54906003)(44832011)(336012)(16586007)(11346002)(47776003)(72206003)(316002)(42186006)(2201001)(186003)(52956003)(36756003)(217873002)(356003)(305945005)(106466001)(5660300001)(8936002)(26005)(36386004)(103686004)(81156014)(7416002)(81166006)(6666003)(8676002)(63266004)(14444005)(76176011)(48376002)(4326008)(51416003)(50226002)(50466002)(107986001)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4470;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT056;1:ws5JBWmNbBOh6rVyTfhc8NhH95SvMwCWCcD0ASmASGtTMYhh/MkvN9kDIIvGqBJmLNkoS1KWIM50KjV4MYvgBHsYffYKFijqHTgpBYjuOQJQ9SiLUe2gfonDj1+cMBSz
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d73fdbc5-47ed-4e9b-0c8c-08d62a0f1d35
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4470;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4470;3:sSp3PxpPjFv72x58Fg51HKcSivELN911KfPFwvDyKiOP7wEwAsBZSzCBKYk35eGb+FPHofjv19tpG6Xyra/hvPJmRY6PgjP4as42NUEVhhOYo9PoTghD8S8UJL039ApX+zDdnhPEqUHDPa7/RaRQIqXNpzf1qGDDkTk0N4DlM/PYwoA0/4YsqHrIvSqR6Oao0Kt7Vz7PEoS+feJnPXRfXZQ1uRc+7hW0GGMRDYcOAFs5ZYtC2wCOZBCao/C0sr5R5eEBt9kmc4zIp04cHqT8ijsMMUABBnoRNYaiQMEyrziPZ9oT+jQUpAt4e8ns5kgfCbsEvkUbOguXT6UxlaT08doVrooN4GcmAZy2jW5NDxg=;25:a7Vf7TVjG++ihdJjJ3D6mb3WmZgny2tfUzfYZr+DaD/P1MKGpDmNBd7cnqzqvXZgPeu2f4GTBAWuBMJi0zzZH4dX40RsBItj16y4dG9bHbdbnbC9tR8B9cXji10vaEoU4j84FXhQ9oVIdEWfnNyrK+MZxjrBYseAg9npwpAue2pIrHg3c5tjwTHwT72/YmtM9t6L9/Xd1NeyAivzsuNsAQ6QaiQWiZfjz3ZDezTvc20R0yYCZiPPgW1R4yQ/knXY/CbAbOEbns8LhWqhDBB65qdQOf8eD3ptpTrumYsgQIRt/oSoyo4qSwk3pmq3AZuQ3Hhhv1rM415bl2MlPBamGg==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4470:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4470;31:KvO8m9RJzb7aL4ZiWhDbC2pl5wCMKiweZbYNosouZjF4XVJr6ptC5A98HCimJp9pfKZGhrB+0PNtgxKUQKHdJ6y5Nk/tD6LuDRpMMV9dxn4SuJravSTNq6iRB6nCidHL7pqO8Uf12jC3vLNfXaXVEOuEDITFXBt6rRi7vCkTiGB9drZ3TPudi84h7k0/7SG9KAep8tTr8vVYKfmaGZb61v6a+un4zGLDJvSdfdUhhbE=;20:fWuSeMBIlgL3SuLx7ZHqPtg9D3M69zDqgGN7GExZS04sozXhl9ca9wL+PC/pE+AlBqUsTV1BKi1HNn/6tZ0BRQ6AlhRVRVw3cFUajtKS4+TLD7/qoXLwOhTaphu6PJPn8F/9BSd4F3RSQDAryfuJjZ6of3xsIB0cAy7+sXghB+SycuX5P72HC23MJFMKA8fVovwHBP7/ldqpoy9DKpeG1x8+QWluiiDKUGxTvsFkRXw/JFswHzGvVFxXCjK7MParqMK46TkylzwopYFpB/MxcDLq4Dyg7tUMUvb2GTaCPwetxLc+mRq7Tthflem6dCIvIRbzEEowcdxJZbKmWtcflL4aa7VfJRU0aSyfaNfCuf2Y+f/UBkOPcLJEtxjQpiFFT/EMcForGq2wx8hJ7PvKpzLlmTFyEBS4rIJXV83AU7UjBb936gLrh8l+v1BJ2HE2HrNFEmlWtwILwYCFoOEiIzT3YFcl7bQ1FJbVQDFeBc5CwNlcp6shgERcJBP7qXZ+
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4470DA35BFBB59383BAC37C3C1EA0@BYAPR02MB4470.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(105169848403564)(163750095850);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991048);SRVR:BYAPR02MB4470;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4470;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4470;4:18+EN9inVUm6YCduzZ5SqpmuTr6eZ1at7+4lC0FDOqom7pIP8W2SSB6Rzfr6xdngqssBejVjdKRRz2G3uz1M504gUkh7iTgM1ic2u2s9/OaFZK0TXA4MsYdjkLS+rz333yTRrc+GQxkvIec7qt7q50u1KOIh+Q0IvlrASQwlENpufAyvGJnYO5Y8+tNANOieGu/zJGWUVLFQQ7smvAMORdOqmarz3ZIpva/4FXNc343fkZX3+dcY3ezM7v5uyHRRxIWeKTR88SIWkADMjLgxsySK858qUAZ6J8KkcM2O/CSVLu7/B1z/9bjqfY1uoi5AosPXdFX2VmWQyPGJ4EeqaR7bUbQXMRCrufBGROoc8zD+t8Xo1IOXsx1+x4Cr3f0q
X-Forefront-PRVS: 0815F8251E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4470;23:8uMexe/cbPWPvA9GvxwSrdHhkpBtTNkjwXMbp+oW5?=
 =?us-ascii?Q?k5CqUEVPGwzHm9zPe9CNOWDsZwhXYy2CE5pmYAxYOHOBjCNJUvyyBr6NOqW+?=
 =?us-ascii?Q?zKgkrwnFFTw/8cb4YK0/V8bMYkS4VpfkF28fvPMFTePW5z2klOe9tF6OM3NA?=
 =?us-ascii?Q?iUPuhgc7KZ9sUgD113aVP/9fMPxJrbde3A9631pCP/aLv3ioyhooiUa0cwdB?=
 =?us-ascii?Q?XpV3uwj6SVGHjJ8V76U3TDRLC4GCBXrC48Vl51zyBFeVYw3JbVo3Yd3Vhcea?=
 =?us-ascii?Q?8FOn+oCLFPWHHO6V8NqA3GRHjIvmKeQ9qePpRVao2dvhUmAvVPk1+FVhMAzp?=
 =?us-ascii?Q?BDqXoxAdUTCajYYZbyVw5UXHQtV9YIi6dIMHMxZo20LWzMdGxhwTc9wX4mZ7?=
 =?us-ascii?Q?NbjKIZdbTNdaHWPC7dXA36W35MagiLWYkdrJZ9SuePwH1n4mujApFnYsVEfe?=
 =?us-ascii?Q?xKD3Teq4ZBF9UpCmcORKGfoByFqleTCiCLLnVYcl5/Dn6tAyUQSexIA15yrY?=
 =?us-ascii?Q?XYVu5IvWj6FBSG2JzDETHSuv+FxBkGRrbWmNbrUNQ1YVbsEKFlPLWau/NLBL?=
 =?us-ascii?Q?we3utwAddLYW+QFn9upDMNeTdAyj7ETlUJDnrFJof2y0T9y5Z2Vm6XbVfs/F?=
 =?us-ascii?Q?i9qfmsljv+cto/lU9KoaGmtKcmYgMAcnLWQM5ZuIlvd9EDQsOMfabP9muV/S?=
 =?us-ascii?Q?8jEQ+xYJRDQxoANCWJR0u/uu8kDyexA/PPpiQ4YqIunj49derlSn59wNLeAy?=
 =?us-ascii?Q?/8cSw6eC6V4f67syFBRQJ0hGyX1Sct2f2rjODdN08tmJp8qIm6L/3O712OlZ?=
 =?us-ascii?Q?9Tm5fHBuLgz0UetSCBIOmUHAoFLMDHBVL/89P69StgeJaayqq6MaVq4oBliv?=
 =?us-ascii?Q?xzRe+i4XxksppB8Kaa32iYjdaB8ENjfUG4jQuxsbFRFA0bcNYrtIPDlairKb?=
 =?us-ascii?Q?7pduXtscmLu6gf1TYdrjMvFq/5SZVBXi7sB+ymxoXd9wOey7grncI08zgl0q?=
 =?us-ascii?Q?dpJVG2z04Z0I12eUh4VCj4j6KgT3OZ8h3UOCCPsrbF5bRtXr7mNNsnw7PTnH?=
 =?us-ascii?Q?OCKgLywMOZKlgG2eUisuZqe3h+l1x258rwh+HXPSTsahETrwmw375KDca/rU?=
 =?us-ascii?Q?0XegJyuoXrklJsTDp9Jm27ng65xcDBTi7xLvO15O4tl+LxxbD1DeceV+igPv?=
 =?us-ascii?Q?krond0x6u/vtI3PO7nvojeNCSe6Ge5dBHXBWkF9srTIaH+kEuTz64ZE0xCZY?=
 =?us-ascii?Q?gxvWEC3Png0RAViRUlI6pwWFbac0S6aHxjqg4l9a3DKP17FwX4Lv3V1OIcG2?=
 =?us-ascii?Q?wnUwDbOmR07MmnBf9XV08o=3D?=
X-Microsoft-Antispam-Message-Info: lzwhhVIDGoAc6V+KLRDqF1wtBqWtmYaeOcn++p9EgYPIraBzOhTk7C0IupcxZa5x2Az6sxXDExCcV63EjN5ZERWQDwMGgC+olsvod9XGqrAXiB4T0E4ViAJsvvL3X0E6+S8XQlUdBYIGh49twLICIltxatA4ELvkNOAysCK+3BpvgRC9cZ1NkQdTxGgcsXsfrorHRPBK8XqLWRtdfI0hRBdmCyQ9ifXydCYY7UvvThAETj62DGpB5Ee/TjBDh5iAII8QMW4Yt7Zsv0wU00edqJpq8sRm+PmzzciimEBhluh1+NXBZKrvYcvWFms4ZBFgV7A+sZnZFFn67cg/Im1waK17QBtAM+qT5a12pZJKFao=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4470;6:pDm+29VLFqVi/dX0V+eLaMw7SuFGwchK1ucGb1PWXLZ1+ZM5oRQONkcbV3Drdo6KQX7Op7v33V85q8Y03gguRDCUHmuS97sn8iab9SDinZI5vC6hKOjUjep8rPiKjFD8JH28hLm0nt9/kMJO2p9Ezs+Bs4UpdcBp4LCI/fJMJ3YxP20eRy/SDcEHairs5IZKxafBOszX3p3ah5uQhQLja5M4WwFlcltpdo1NWR27eeJNp6+zMhiJ/KNk/Yr9deN+ow6fUs4YBHL2AS1H23tSTVtLRIKggq4kiiXO5X6S6B6VjRcx1QYesFA5IvPng1xFeK+knscdFj9nIRpUCdKTnUJIntHh+Z5aMw/8PJFSFIsLlreO187O6/cKlivFUdDj8ONPYkekaThGBb70nHcZkeJn+tpQsdEsSmeYY0SMAsc/UYXBeAiyJ0ZT/KAtqjX2UkiKvrdIW8RizxD0nFigeg==;5:bGyFnPsvo6BGjz5+w5ZOITp5h0Iq2Yqd2V92UtObqsQC5wJyBSU7fpZQ7cjpYD0Uy+DnYFlWAQaQ+U9K4nddi09vIKN+u5quzfuP5N5bxVSh4ymIzJZJmA2pYqn6lhSyk7xkhgeYH3Mhzxg7mX5WWhlz1IdaveGttm+5OQ/SVh4=;7:AVOIncfDnjk1P+wYnUAFTmNS4z6ODyiKemdxze3HCY0w/9JlEG4nACIOxsimW6zepQ6FCiurusVyXvA2dVAoVnSVqXrH3TbBage8gXiUDAUyGYFxmHXPOtcLd7jsNsnqDQ4/HodfcPC7NlBllbN5KDx5ky9kBZC6EORElRUWbRJSb1pjZ35m2Nz55qfvx9EGIOhlizBiEG03MrPAb9M+XJr9GJSAUgqLoYq8VCpTvvbDPCpkdlR37nvjior94waq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 15:36:11.9114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d73fdbc5-47ed-4e9b-0c8c-08d62a0f1d35
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EDAC ECC support for ZynqMP DDRC IP. The IP supports interrupts for
corrected and uncorrected errors. Add interrupt handlers for the same.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/Kconfig         |   2 +-
 drivers/edac/synopsys_edac.c | 328 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 311 insertions(+), 19 deletions(-)

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
index 94d1398..adfa3bb 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -22,6 +22,7 @@
 #include <linux/edac.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/interrupt.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 
@@ -272,6 +273,8 @@
  * @bank:	Bank number.
  * @bitpos:	Bit position.
  * @data:	Data causing the error.
+ * @bankgrpnr:	Bank group number.
+ * @blknr:	Block number.
  */
 struct ecc_error_info {
 	u32 row;
@@ -279,6 +282,8 @@ struct ecc_error_info {
 	u32 bank;
 	u32 bitpos;
 	u32 data;
+	u32 bankgrpnr;
+	u32 blknr;
 };
 
 /**
@@ -385,6 +390,68 @@ static int zynq_geterror_info(struct synps_edac_priv *priv)
 }
 
 /**
+ * zynqmp_geterror_info - Get the current ECC error info.
+ * @priv:	DDR memory controller private instance data.
+ *
+ * Return: one if there is no error otherwise returns zero.
+ */
+static int zynqmp_geterror_info(struct synps_edac_priv *priv)
+{
+	struct synps_ecc_status *p;
+	u32 regval, clearval = 0;
+	void __iomem *base;
+
+	base = priv->baseaddr;
+	p = &priv->stat;
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
+	if (!p->ce_cnt)
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
+	edac_dbg(2, "ECCCSYN0: 0x%08X ECCCSYN1: 0x%08X ECCCSYN2: 0x%08X\n",
+		 readl(base + ECC_CSYND0_OFST), readl(base + ECC_CSYND1_OFST),
+		 readl(base + ECC_CSYND2_OFST));
+
+
+ue_err:
+	regval = readl(base + ECC_UEADDR0_OFST);
+	if (!p->ue_cnt)
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
  * edac_handle_error - Handle controller error types CE and UE.
  * @mci:	EDAC memory controller instance.
  * @p:		Synopsys ECC status structure.
@@ -399,9 +466,25 @@ static void edac_handle_error(struct mem_ctl_info *mci,
 
 	if (p->ce_cnt) {
 		pinf = &p->ceinfo;
-		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-			 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-			 "CE", pinf->row, pinf->bank, pinf->col);
+		if (!priv->p_data->quirks) {
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type:%s Row %d Bank %d Col %d ",
+				  "CE", pinf->row, pinf->bank, pinf->col);
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "Bit Position: %d Data: 0x%08x\n",
+				 pinf->bitpos, pinf->data);
+		} else {
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type:%s Row %d Bank %d Col %d ",
+				  "CE", pinf->row, pinf->bank, pinf->col);
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "BankGroup Number %d Block Number %d ",
+				 pinf->bankgrpnr, pinf->blknr);
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "Bit Position: %d Data: 0x%08x\n",
+				 pinf->bitpos, pinf->data);
+		}
+
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
 				     p->ce_cnt, 0, 0, 0, 0, 0, -1,
 				     priv->message, "");
@@ -409,9 +492,19 @@ static void edac_handle_error(struct mem_ctl_info *mci,
 
 	if (p->ue_cnt) {
 		pinf = &p->ueinfo;
-		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-			 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-			 "UE", pinf->row, pinf->bank, pinf->col);
+		if (!priv->p_data->quirks) {
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
+				"UE", pinf->row, pinf->bank, pinf->col);
+		} else {
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
+				 "UE", pinf->row, pinf->bank, pinf->col);
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "BankGroup Number %d Block Number %d",
+				 pinf->bankgrpnr, pinf->blknr);
+		}
+
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
 				     p->ue_cnt, 0, 0, 0, 0, 0, -1,
 				     priv->message, "");
@@ -421,6 +514,42 @@ static void edac_handle_error(struct mem_ctl_info *mci,
 }
 
 /**
+ * synps_edac_intr_handler - Interrupt Handler for ECC interrupts.
+ * @irq:        IRQ number.
+ * @dev_id:     Device ID.
+ *
+ * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise.
+ */
+static irqreturn_t synps_edac_intr_handler(int irq, void *dev_id)
+{
+	const struct synps_platform_data *p_data;
+	struct mem_ctl_info *mci = dev_id;
+	struct synps_edac_priv *priv;
+	int status, regval;
+
+	priv = mci->pvt_info;
+	p_data = priv->p_data;
+
+	regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+	regval &= (DDR_QOSCE_MASK | DDR_QOSUE_MASK);
+	if (!(regval & ECC_CE_UE_INTR_MASK))
+		return IRQ_NONE;
+
+	status = p_data->geterror_info(priv);
+	if (status)
+		return IRQ_NONE;
+
+	priv->ce_cnt += priv->stat.ce_cnt;
+	priv->ue_cnt += priv->stat.ue_cnt;
+	edac_handle_error(mci, &priv->stat);
+
+	edac_dbg(3, "Total error count CE %d UE %d\n",
+		 priv->ce_cnt, priv->ue_cnt);
+	writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+	return IRQ_HANDLED;
+}
+
+/**
  * edac_error_check - Check controller for ECC errors.
  * @mci:	EDAC memory controller instance.
  *
@@ -428,10 +557,13 @@ static void edac_handle_error(struct mem_ctl_info *mci,
  */
 static void edac_error_check(struct mem_ctl_info *mci)
 {
-	struct synps_edac_priv *priv = mci->pvt_info;
-	const struct synps_platform_data *p_data = priv->p_data;
+	const struct synps_platform_data *p_data;
+	struct synps_edac_priv *priv;
 	int status;
 
+	priv = mci->pvt_info;
+	p_data = priv->p_data;
+
 	status = p_data->geterror_info(priv);
 	if (status)
 		return;
@@ -476,6 +608,39 @@ static enum dev_type zynq_get_dtype(const void __iomem *base)
 }
 
 /**
+ * zynqmp_get_dtype - Return the controller memory width.
+ * @base:	DDR memory controller base address.
+ *
+ * Get the EDAC device type width appropriate for the current controller
+ * configuration.
+ *
+ * Return: a device type width enumeration.
+ */
+static enum dev_type zynqmp_get_dtype(const void __iomem *base)
+{
+	enum dev_type dt;
+	u32 width;
+
+	width = readl(base + CTRL_OFST);
+	width = (width & ECC_CTRL_BUSWIDTH_MASK) >> ECC_CTRL_BUSWIDTH_SHIFT;
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
  * zynq_get_eccstate - Return the controller ECC enable/disable status.
  * @base:	DDR memory controller base address.
  *
@@ -485,19 +650,43 @@ static enum dev_type zynq_get_dtype(const void __iomem *base)
  */
 static bool zynq_get_eccstate(void __iomem *base)
 {
-	bool state = false;
 	enum dev_type dt;
 	u32 ecctype;
 
 	dt = zynq_get_dtype(base);
 	if (dt == DEV_UNKNOWN)
-		return state;
+		return false;
 
 	ecctype = readl(base + SCRUB_OFST) & SCRUB_MODE_MASK;
 	if ((ecctype == SCRUB_MODE_SECDED) && (dt == DEV_X2))
-		state = true;
+		return true;
+
+	return false;
+}
+
+/**
+ * zynqmp_get_eccstate - Return the controller ECC enable/disable status.
+ * @base:	DDR memory controller base address.
+ *
+ * Get the ECC enable/disable status for the controller.
+ *
+ * Return: a ECC status boolean i.e true/false - enabled/disabled.
+ */
+static bool zynqmp_get_eccstate(void __iomem *base)
+{
+	enum dev_type dt;
+	u32 ecctype;
+
+	dt = zynqmp_get_dtype(base);
+	if (dt == DEV_UNKNOWN)
+		return false;
+
+	ecctype = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
+	if ((ecctype == SCRUB_MODE_SECDED) &&
+	    ((dt == DEV_X2) || (dt == DEV_X4) || (dt == DEV_X8)))
+		return true;
 
-	return state;
+	return false;
 }
 
 /**
@@ -539,6 +728,34 @@ static enum mem_type zynq_get_mtype(const void __iomem *base)
 }
 
 /**
+ * zynqmp_get_mtype - Returns controller memory type.
+ * @base:	Synopsys ECC status structure.
+ *
+ * Get the EDAC memory type appropriate for the current controller
+ * configuration.
+ *
+ * Return: a memory type enumeration.
+ */
+static enum mem_type zynqmp_get_mtype(const void __iomem *base)
+{
+	enum mem_type mt;
+	u32 memtype;
+
+	memtype = readl(base + CTRL_OFST);
+
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
  * edac_init_csrows - Initialize the cs row data.
  * @mci:	EDAC memory controller instance.
  *
@@ -600,13 +817,58 @@ static void edac_mc_init(struct mem_ctl_info *mci,
 	mci->dev_name = SYNPS_EDAC_MOD_STRING;
 	mci->mod_name = SYNPS_EDAC_MOD_VER;
 
-	edac_op_state = EDAC_OPSTATE_POLL;
-	mci->edac_check = edac_error_check;
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
+		edac_op_state = EDAC_OPSTATE_INT;
+	} else {
+		edac_op_state = EDAC_OPSTATE_POLL;
+		mci->edac_check = edac_error_check;
+	}
+
 	mci->ctl_page_to_phys = NULL;
 
 	edac_init_csrows(mci);
 }
 
+static void edac_enable_irq(struct synps_edac_priv *priv)
+{
+	/* Enable UE/CE Interrupts */
+	writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
+			priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
+}
+
+static void edac_disable_irq(struct synps_edac_priv *priv)
+{
+	/* Disable UE/CE Interrupts */
+	writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
+			priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
+}
+
+static int edac_setup_irq(struct mem_ctl_info *mci,
+			  struct platform_device *pdev)
+{
+	struct synps_edac_priv *priv = mci->pvt_info;
+	int ret, irq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "No IRQ %d in DT\n", irq);
+		return irq;
+	}
+
+	ret = devm_request_irq(&pdev->dev, irq,
+			       synps_edac_intr_handler,
+			       0, dev_name(&pdev->dev), mci);
+	if (ret < 0) {
+		edac_printk(KERN_ERR, EDAC_MC, "Failed to request IRQ\n");
+		return ret;
+	}
+
+	edac_enable_irq(priv);
+
+	return 0;
+}
+
 static const struct synps_platform_data zynq_edac_def = {
 	.geterror_info	= zynq_geterror_info,
 	.get_mtype	= zynq_get_mtype,
@@ -615,9 +877,26 @@ static const struct synps_platform_data zynq_edac_def = {
 	.quirks		= 0,
 };
 
+static const struct synps_platform_data zynqmp_edac_def = {
+	.geterror_info	= zynqmp_geterror_info,
+	.get_mtype	= zynqmp_get_mtype,
+	.get_dtype	= zynqmp_get_dtype,
+	.get_eccstate	= zynqmp_get_eccstate,
+	.quirks		= DDR_ECC_INTR_SUPPORT,
+};
+
 static const struct of_device_id synps_edac_match[] = {
-	{ .compatible = "xlnx,zynq-ddrc-a05", .data = (void *)&zynq_edac_def },
-	{ /* end of table */ }
+	{
+		.compatible = "xlnx,zynq-ddrc-a05",
+		.data = (void *)&zynq_edac_def
+	},
+	{
+		.compatible = "xlnx,zynqmp-ddrc-2.40a",
+		.data = (void *)&zynqmp_edac_def
+	},
+	{
+		/* end of table */
+	}
 };
 
 MODULE_DEVICE_TABLE(of, synps_edac_match);
@@ -673,6 +952,12 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 
 	edac_mc_init(mci, pdev);
 
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
+		rc = edac_setup_irq(mci, pdev);
+		if (rc)
+			goto free_edac_mc;
+	}
+
 	rc = edac_mc_add_mc(mci);
 	if (rc) {
 		edac_printk(KERN_ERR, EDAC_MC,
@@ -684,9 +969,10 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 	 * Start capturing the correctable and uncorrectable errors. A write of
 	 * 0 starts the counters.
 	 */
-	writel(0x0, baseaddr + ECC_CTRL_OFST);
-	return rc;
+	if (!(priv->p_data->quirks & DDR_ECC_INTR_SUPPORT))
+		writel(0x0, baseaddr + ECC_CTRL_OFST);
 
+	return rc;
 free_edac_mc:
 	edac_mc_free(mci);
 
@@ -702,6 +988,12 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 static int synps_edac_mc_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+	struct synps_edac_priv *priv;
+
+	priv = mci->pvt_info;
+
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT)
+		edac_disable_irq(priv);
 
 	edac_mc_del_mc(&pdev->dev);
 	edac_mc_free(mci);
-- 
2.1.1

