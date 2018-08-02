Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384C0C46463
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A35214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UiWqFya6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A35214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbeHBO03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:26:29 -0400
Received: from mail-bn3nam01on0044.outbound.protection.outlook.com ([104.47.33.44]:39168
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732410AbeHBO02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBaPk4tYolKoqid8bvC3l2lBCqtJ10B9iasJD6BwjFE=;
 b=UiWqFya66OPJeF6cOyCsG8AY3+6yZLddjghV2kPhvh8q0j0dJJ3K0n82IOAb1tu/Whpn7omqRb6Albp+zKsTEHja4ajsTzmBPTTwHgcTN4eL9zlOEIbjlX2bgzTIg5yQbI9CzoxpKy/5/1Nonynv2PbSkzrXoyoqBkOFjhO82Kc=
Received: from CY4PR02CA0008.namprd02.prod.outlook.com (2603:10b6:903:18::18)
 by BL0PR02MB4324.namprd02.prod.outlook.com (2603:10b6:208:40::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Thu, 2 Aug
 2018 12:35:26 +0000
Received: from SN1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by CY4PR02CA0008.outlook.office365.com
 (2603:10b6:903:18::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.14 via Frontend
 Transport; Thu, 2 Aug 2018 12:35:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT038.mail.protection.outlook.com (10.152.72.69) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Thu, 2 Aug 2018 12:35:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flCp6-0001wR-6f; Thu, 02 Aug 2018 05:35:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flCp1-0007PR-2z; Thu, 02 Aug 2018 05:35:15 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w72CZ3OO026401;
        Thu, 2 Aug 2018 05:35:03 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1flCop-0007HH-AQ; Thu, 02 Aug 2018 05:35:03 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 5A61C121417; Thu,  2 Aug 2018 18:05:02 +0530 (IST)
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
Subject: [PATCH v2 0/4] EDAC: Enhancements to Synopsys EDAC driver
Date:   Thu, 2 Aug 2018 18:04:44 +0530
Message-ID: <1533213288-8771-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(346002)(396003)(2980300002)(438002)(199004)(189003)(50466002)(52956003)(44832011)(36756003)(5660300001)(6666003)(6266002)(63266004)(478600001)(54906003)(316002)(106002)(7416002)(16586007)(8676002)(81166006)(50226002)(110136005)(8936002)(4326008)(81156014)(107886003)(2616005)(51416003)(356003)(42186006)(2906002)(90966002)(103686004)(48376002)(106466001)(426003)(26005)(126002)(186003)(336012)(72206003)(486006)(305945005)(476003)(47776003)(36386004)(2201001)(107986001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4324;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT038;1:NpjWDAMBNrs9TdS1a682+DpGgC0N7ov8zOeFpPYYDWxPSrQdilt1fz8VyjoOw0aT5FAiP61TfgwUzUfoWJiG2Ozlkvr363fsTtTYaV+lJCRulautiuP/MSzfgV44lYIG
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08a3525a-0dc5-4075-bdd4-08d5f8746bfa
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4324;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;3:rmcNfDZOd6ZfP1wK2RzHUWg6i6R5orebrtVB+ArwN5ho2Ufj4zGx4JbhHODp5qpfc8DajYRqXxWqNqKrngyo6q8u8rHvpcNaf0nzr3cvVDIyAGV04QQbEUUwAdOLxucl0CPWTfQnuoPJ/z2cfFuAmEqfLneiXu2/QfYUtYtw9TSqBBSIlU41bJFpjRMSN3hP2tUWMvPckFEwSOum2mkBXfE8YKC9kLe1NDiBsivsQciFkXUsnQjsI9Jh8J/OP/TU17Tb6cAAksb1YyNLuRxPhuFxCZ0YYhlJto00JtBQ2sbM8O4NSI05eId8V2xI5D1nehr2Rxalmuo4xoNmR4SA+BTdjvACOiSDwviH1H89El8=;25:y139OHewFS/4DEf2I3eW5inD6MGbEZdYKErP63ahCDtYXaKtS457MIpWKKn6uUil5gGr9Xx8OsRtne4mlM9WNAWuqyYCaO/SEMVuMe1okdsis3g9SMkx41QsUmiqHmSecR+tiS5EQhd53GkqFmKt9dZ1nVDc2YwLt1x1ZE+19IaS5VMLRNXihzw2hplJn2zxoLVzFRpQ7oiOwl8yYssZASO37kY9Hq6/JZJKf+xF0zIgfQEagvBozvnzpdxa89AYI4K6ty6VAeZzFf7+tUyPKcmYsGpsy+aDuTV6CzQXliBp/W6MMZatFppvkWw9LSKTJh351Awv6B6XBCbg832KNg==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4324:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;31:BQOaOBzjXjE2jgQvU6MRiuV2gMHtinS6DZL7fp+RE1PrdntTSRLC1Y3uNQMKTkTGJZ73Qbx9QIEg4lNzuhsAH08FZYXgPs+3jrawbvYKd4h5avn51R2JX+I204rdLAKYawuTIdsuH+fa2qX72HNwDrPlLzifv4DX6H7ds6jtzNkVOkN3lYx/iH3mz9t2wdJvmQDPUv8UKw14CsrbEM3ygrvDcX2tiIB0QDFtsaOrCPQ=;20:R7lJTQOG055nRv/TkXHGHm6qHOvo0Aa2gKGkYwDYNIoMCnFdfCw1f6ipswMftuy9Zt2+00x55uhgtgWlEGlwb1972PxKXXib/MAiyl3NQM8w5f0X8hs1k3YaD7KHveft/absX7jnzhH12t06N8MArBnXA/cGKzVuqG3mY5CcSjzrf8qz8lyt5EjhyjrmHTpAwdT3j1xIZpgkwrtuLJSBT+iVopaWi7OHDgycdaBnjHT/Mo23PF9BRkTRNAsUXwnyu1oC0MNT+Qe00gbXc/0WA19vWtFrQ+8JgOiExgxJT8kyiHOlChA1GZgstMO1ncqfOiNqLA1TMtUvEsZeY8Yt1lhdD8DPiZrOaugwSvNPL/oxkbfzHCj1jwo4SKl4MhIPoPkcPJyhXYszpUNRlAFMNyK6Zw4nvnrc7nppyqYKi+ftniYlY3R5jv3uvC1WZLPzlz1Zy47IKt41P5Tt/hDUknAeh2SST9Hqwzo0GphsmECrhQFdDANMc29S1in3WZEj
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4324AFA05FC883EC154313C1C12C0@BL0PR02MB4324.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4324;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4324;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;4:xMRQGS0ivNnDT8EE5Pd6MiDnw4YRjoBxGikhyB3gnvj2cv2QiCo9e+4YoEOyZEZ4PvMiG2e8Qzm2UpwuUFW8fCZC4TzD/muMSe8oFSbgE+YZ5ZPmZdSC8IrEYF2ADnleVKEozfgVC7mBVMvHdYcnsLzl7R44X2CLv5tEkAqQFMj4q5B32XrUZSucAGcpYFIZRr/MMrurs8z90fInepdd3JFs73O8unEySXqoFE9LWgMafMiDrvXmaTXsWfWHfFAp7C5olV0mmUukdiPGGMHr9g==
X-Forefront-PRVS: 07521929C1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4324;23:AAsFrSB/p3wXvNF42NzyPMgOkVP29kS3AGrlxG9VN?=
 =?us-ascii?Q?wZtGmtaAtrl+cso+v9e5qolEs0BHKt2DYXuxNT0fTlklADECuO0v9KwSHhjo?=
 =?us-ascii?Q?B9DFBufkN+3bC1WfIcfzJgsncLdxpx+cwA8D3R4PNWGy9CBKDMryXu94/abA?=
 =?us-ascii?Q?rBS2cMbFHOER6ndkYKo/ksXLKYGMIX8oIqR2/LQqHJkvNPz/Ptf8rSmko2mG?=
 =?us-ascii?Q?IID2TD2m0F0tEanEP8NRZtU8q6Bkx0J/hm2Qj1rvr956I463+Ga7nPYyzG8t?=
 =?us-ascii?Q?V/7fJsJWYzcWLBLExFbtu6QBUwXAJDpjojAavuX4wqQ6Yxl7FtquqvNORQq6?=
 =?us-ascii?Q?Gdnz2cB9J71oiPszt+iaEMaIzQvvV0jLNa4BbLY6k07i9xxAQLcctqKo1QJa?=
 =?us-ascii?Q?SrdIF4gnm8tjolErXn1WbxG0r2iDP/8s8r8YRhop8X5GrXxd9mk3Qe8dYImh?=
 =?us-ascii?Q?KaI4gqAVxigsemRhfhqcAoI/C0bWPpyjoZ755Gg6jCn4WZB3RaRkuTNUeUdn?=
 =?us-ascii?Q?iWw8lOYg15XgJxaQJnBIRQjED/IFY/iZiQTt2qhMNTWU3K3uLrXgNKy3wekX?=
 =?us-ascii?Q?N+bjVO9gUS9axevN2GDs4nT1hkZAooof4eDWVoaEpxTwONqe26hHfBFAkd9o?=
 =?us-ascii?Q?4ARkc4ZSsNouHb2QnaVPqGYDjTRT2BFn90dWb+1PlacizjET7JAcFMNydRLw?=
 =?us-ascii?Q?4OUvNxXmai4Hf07OAw118G/8pls7fzGdCkzZ7wAuwp+5UQUj4ArrNTuwqq9l?=
 =?us-ascii?Q?+zHD9jZD7xi88wV4/9SlPQZcV6i8Suu0NYDTXM6CuCVONnRa9r3g+voAE52M?=
 =?us-ascii?Q?TJp0sYPxhlKEblL7ll+dWBf15vDvMAwc7ZO1Sh3fVMPmyWtOJlmgHjxn45Fq?=
 =?us-ascii?Q?ZHri1k5eX4JStp0SLhivm/24IU8LpIbH2LeSixw9K4G9Qp72clCTRvFtpCFo?=
 =?us-ascii?Q?ofeRj7/I/y8QWabI0YyB7/SwE2FVCMtNbcEAylaDMbOQyPumcKWbol1ByKUO?=
 =?us-ascii?Q?qaml0UnaDW1Ln75ThNAtagF/iWWJJWDMx5kg2nQGvhPVWnp6yC+NHvVcRQFM?=
 =?us-ascii?Q?ZxjhM2WnqKEA55pZcl6eQx5zkEzdUXWxNVoskYTAsiDsU+/e5iyoP4HYxOMv?=
 =?us-ascii?Q?4PhQCD3SJ7nvVRZiGml+ovzS6ToOZm9paFCE3NVT/2QLxb0PHD0tdbVMSe3F?=
 =?us-ascii?Q?PQaeSlFzuQ1xgIseq4ST5OHmRdrLwE0gKsK?=
X-Microsoft-Antispam-Message-Info: mWuNQUOqYihQXCE9S+RyTpcVOAFKLsu84CBvitoN4AdeeBUE6i6M/WuPk8E5sVdWg+kQ6wlVOJKn53Z+LdNeu1jOcN3xnGRTt9HQLAYw2WY1FAMsi6k/WiXTr26EoD+Rv1BA8gwTXL93rjJBFI6vN/VBvym8rLPhye5TN+wuvZq8v1AjNN4e5ZdZDBBKI0kzTVSNVLqZIAp1v/yUBq0Yzt6rgp2bw3oLsqtD+oauT5oj64u3c7xMixv0NP/Z8YUqDj9xGbSTk8jU9wyc9rY+L2UXiEe4ZJ2A/liEJ9XFyeBOtqt1jMDc5EHpNuk8m8lhBtY1l+P1CGtw7dlfAcDpQUSCWVrLT/2aunxa1L9sWa0=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;6:gGgNJ6e3lN1gIDikWPbHxyVN3V3rdo/0anU1xWPOXZx1svsBoACWegQ0FM02mRk8YIc7z4+JDPCo0eWO1WDgPNSeaamE3Br+AiFMlBl3f5KjJTudTaRGhWolWtPuNDfU4VP+fDukJRWR9rXFcqxfvohHLbSlOum2XGQ8MIxUJ/v7zxDcXEhSoBdDkLLLiMLV5P8Ifk4J7DR5MPGQWIuMuS4JBCQsw9NmUnnPQoWnLpJstXpQUXMtcMhVxbRlvnQg7B+8338pF23v0EUk/B31k9+lS2LjtBiva1ZncoWzhg2nv6F/+D5Dx/RZGXtb7yUxaWf3FUjMVxL5FWI2e3DYM4CC7uhHwYFedWD0EizsTOxihlPUBq356Fg8EJoMnxW+z86NmjGATpxltraXI1p/GfQuv+XrTkIR7qoepuJIfVno0TiV8L3NxAlE6m3I+lGB8vhccaudGSqRvxi92OLWfQ==;5:cC7pQKMuNqWdiVXFR7jc3AkynFZFc8Dsi+Z4mhK5iF58sjMBacQBu+iATsqDQSwWnEdcEfwfLxXDvIIcHF1vkj48L54bArkfehslrgPth0MINyXe0fDj7DpLbMq0JkbpLcQnxA0468b83daKBk5W8bo4S1qasFV2/mKV2QoI6FU=;7:uBVCVpSpD2OAmt6y3suGkfX5Wurka9uq0U5Cp1+Y/PyqRHjmx78c30ZtErcbmiDdsAUHrGCt1OxOUUIw3i5pyQGBBwt5DNiaZe4lv+NqvWxG+mEAkosR5Kn5TTPnnhk4x1ykPcCls4BIqq8A8vtPqQ/W+oAZmrJmkAPmWVixkMwpPgWa6kJ+zw528RYd7LxyoM7qFwH1ECqXXQg94oWOBIQpuWyyCSVTzU/K8tvTCAVySnyQWSgMYQkz10Ll/V3v
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 12:35:20.9906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a3525a-0dc5-4075-bdd4-08d5f8746bfa
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4324
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enhances the current EDAC driver to support different
platforms.This series adds support for ZynqMP DDRC controller in synopsys
EDAC driver. This series also adds Device tree properties and relevant
binding documentation.

Changes in v2:
	- Moved checking of DDR_ECC_INTR_SUPPORT from (1/4) to (3/4) as it is
	  a feature of ZynqMP DDRC
	- The Binding Documentation in (2/4) is modified as per the review
	  comments

Manish Narani (4):
  edac: synps: Add platform specific structures for ddrc controller
  dt: bindings: Document ZynqMP DDRC in Synopsys documentation
  edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
  arm64: zynqmp: Add DDRC node

 .../bindings/memory-controllers/synopsys.txt       |  27 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   7 +
 drivers/edac/Kconfig                               |   2 +-
 drivers/edac/synopsys_edac.c                       | 919 ++++++++++++++++++++-
 4 files changed, 922 insertions(+), 33 deletions(-)

-- 
2.1.1

