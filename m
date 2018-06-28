Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF546C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E5327403
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ROcQBd2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E5327403
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966079AbeF1NML (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:12:11 -0400
Received: from mail-dm3nam03on0074.outbound.protection.outlook.com ([104.47.41.74]:44187
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965175AbeF1NMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMCrq8V8sjuHuko0E5k6P+LfsEjlyrWS/4ED/5Pb+rM=;
 b=ROcQBd2jO1LV9c599RFXTncL36X3Dce3Kwvt62zaw2Jp7IdA06DsMuYrc20jyfVfIdw1el5AUMwJKsD8gEgs3elX/tmPhIm9SavyawCX9y3JIXic3NbVKi3WHUApPUXOfw+sCeJYMbtMq5Xp+ZYeQYyDXJ/nF4zRxcWpNNTSwH0=
Received: from BLUPR0201CA0004.namprd02.prod.outlook.com
 (2a01:111:e400:52e7::14) by CY4PR02MB2648.namprd02.prod.outlook.com
 (2603:10b6:903:72::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.20; Thu, 28 Jun
 2018 13:12:04 +0000
Received: from CY1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by BLUPR0201CA0004.outlook.office365.com
 (2a01:111:e400:52e7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.21 via Frontend
 Transport; Thu, 28 Jun 2018 13:12:04 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT028.mail.protection.outlook.com (10.152.75.132) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Thu, 28 Jun 2018 13:12:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:53406 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fYWiQ-0007GR-GQ; Thu, 28 Jun 2018 06:12:02 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fYWiL-0001yd-DW; Thu, 28 Jun 2018 06:11:57 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5SDBsv6027430;
        Thu, 28 Jun 2018 06:11:54 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fYWiH-0001xn-Su; Thu, 28 Jun 2018 06:11:54 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 0C029B20846; Thu, 28 Jun 2018 18:41:53 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>, <joe@perches.com>,
        <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 net-next 0/5] Fixes coding style in xilinx_emaclite.c
Date:   Thu, 28 Jun 2018 18:41:45 +0530
Message-ID: <1530191510-10310-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(2980300002)(438002)(199004)(189003)(50466002)(106002)(2906002)(2201001)(52956003)(336012)(26005)(47776003)(50226002)(186003)(103686004)(14444005)(426003)(36386004)(48376002)(63266004)(126002)(51416003)(106466001)(4326008)(476003)(486006)(6266002)(81166006)(5660300001)(356003)(54906003)(81156014)(16586007)(36756003)(42186006)(8676002)(6666003)(498600001)(90966002)(8936002)(305945005)(2616005)(110136005)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2648;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT028;1:re2W1ruo1yz1RcwqdRTDaVlzPpcb1f/7j5eDiW7Vde9MoG04cCjk+nW3ffvXfWk8ax8wvXselkvHfa7LzT1CS/A5pENOXfiWXh21Lxl5xGWIQzUtlH5jIspYVAJgafmz
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 832dd895-de98-40ab-fc65-08d5dcf8bd93
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:CY4PR02MB2648;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2648;3:TCatmlDMGoZ9n1ZnjzhV8z6AjOniDoKxnjwihaVXhrS4WTI9PikOIcmMnpeYNlMG1+ENokPXqG7UNAtLZN3dvAwXfkDbawXGeADktGnQfwRSEXs31OX9GCoaa6eu0eANB4lI3X2eOYllVAI6P3RcRheVwkNLgaW4rj2NFO8Vxe+UavoeyfRxumXjX0BYBCLrpnlrfKDrGHPGudkbicvockZFipLiNju3yFtegVPmqIJm0HGb0JiNO0C9GvNEUP0CO7vOO8Hi5R3Pz//2ezjdlMZY6POYlA7TLlgSNVElC4QryUgC52PjhFDRTWELnxupezkdMZSkU4Uf9R+PU+VwjkzPu6/LKL4T1EBDccgdkJI=;25:M9tJlgdpeQThckvMOMEOWxdnSsSKbEkJ1d8uxwMwnDI+C8bLazThJRhGFg2Ah3fJFQGGuw1c98RwAROVyeMA9RAly2nRk8T0a7V2/jnIRGTE/FYFk213uACOMXqItv+PabuRfbYaJTG+vmPlcVXHWTudQ4h4zhGU1r0YYtISzk7thz1xab6pobVVRpK+pqcrh+IZ4MTQKb1ErFAujTI2++P4saTObqM9hO4TsjDo75hNBM+mY96gJVYtEQXTFxHCVrpNHz554wqsDyP9gqXJ/g1WtbaenQLIAOb2XpO8dWvjT2N3gla0livutK1O4RAZMH2/K1FFNJaaG4wSs72HHw==
X-MS-TrafficTypeDiagnostic: CY4PR02MB2648:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2648;31:fL7IVGh2bRyEN2Q0M+JgqFdCwGYD5zlQ2BAUMAA48fdE3QFUhJO4NVDVH4jDIaEiI3NqXjNsweczu67X5gkASDYr50IayYgnGRewDq/Cirv6GOnw029nkXeB5rxfbPv4xWdVMFrKH3Dh/AdlcLqPoCI6ZzlI14Fcc9O661aHb21nlQ1a82rDuiU8kW/vtKAne78/KyWMz35lrh+geRsOn30R5mWwtTf/V4xr6uQeifs=;20:OOMklHR7/0PZ93XfORl7Q6Q6lnWPFJJXHWE41UNCp1GCJxUV4aWhqrbrkL8hwgWYyaOqDCKzzSGPuFqPcBNw4JD/+pr3JUg2SAhwt276wkp0GjPPpC6BqS8uZ3U+6vzY59o1MLAGCT/pdLDkazAnwgAHkws/1McJ3jdwNeG3WH3rNtjwA1DCg5rBA9hPheJ4qHeWcP1CEk6R/JL3cvGWiAiO4zUhlUrXIAQ2AKKlKto9GW7bX2UCpb87bBEuhcOM2/JSbDEJDQ9sPfcc/WWijity3wo9UeACq4OTYENJFO6VVkGZ1awXLRxwDpdpxZOw+qQzzAOR9wbcOCY8gw4m8UUS778tf+WUVu+PFrO3aJGio/rME9bCFM6w/a6k/QI4l4rIINFGhPqUCHswnLT0Ge6PQAg1Pupz07BfbK+5lBzboC8Dh7AgS1H/Fjjv10DFrrCBipGf3QuYq3ZT0sV8esDzCTetFDMwMQ6J2P/G2lXpdfKkn/dmsHIL48Xvs97U
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR02MB26482418772DBF651B58CADFC74F0@CY4PR02MB2648.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201703061421075)(201703161042150)(20161123562045)(20161123558120)(6072148)(6042181)(201708071742011)(7699016);SRVR:CY4PR02MB2648;BCL:0;PCL:0;RULEID:;SRVR:CY4PR02MB2648;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2648;4:weBCSEdlZdJeASSA3blNx6Gw+oZw1JxozddJ8Tdc+qcO5l6FdllGJvByEpOhvalPKbJD//14QUAltLU9cd5iXlXsMYt01hMg9e4ZV9Tq1XFlTY+e9KEIv66mkT+ZPp35MagzsU0zitT3x7PmrJGI7M8vmfR3o9XCz/Kgsl0g1dL7b/cm/rNplncV2pjbgtanoau4ZReIvtqE2ahu7ViML9Wp78TWHo+EnmkLDQh59PBb3XQCueJSqS38k1xAHFgfHuId8nIvJ+uLms2mI3Q3Lg==
X-Forefront-PRVS: 0717E25089
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR02MB2648;23:gvLAQEbNcBQYK9mMMZT5lo7ZMK9nI7xMYFg7zV7CT?=
 =?us-ascii?Q?83hd62u4zbfsGxM3jZByfhxQN4FEvxKgJ1mScuVPGx8fYyXixdDcbilxu/ob?=
 =?us-ascii?Q?7I0tRM8u7WHh/fCGcIfpOPwN4jpFW94rLc8O4TOTxwz4IOpZuHxNP2trxsnG?=
 =?us-ascii?Q?QXWDaizA6awHYSJFt+MFja/sWrJEXdbWE58WoAVL17vPxQZNjfkllDMFT3U4?=
 =?us-ascii?Q?WJe3ZyXaEtLYIV0pdfQ9Fv7jw62gX4uNPl9j+hLPXKU2PUQurxrssuKMv/WL?=
 =?us-ascii?Q?+SAqggCOxMzHiR5pQW4Fu9FFIiGK8LGPWR3cf39oeqo7TGfoP7maDMYPzPjz?=
 =?us-ascii?Q?4yx6sOKy+/B33+KoyTVEgVkTjNTTvemvad3UT7gtBBhVRjrmtd4pV5MiENqz?=
 =?us-ascii?Q?KGzjWaEMaBcJy9LacS0+lkDeKW0fJghGoXmYXb8QXtB1KVpCLDXW3DIZmRF2?=
 =?us-ascii?Q?Z+yHOmWwrSFl/g71+HrETZHAKbze6ETs2yq7gaQxuWBt19SwyG5Oo7Lo34oO?=
 =?us-ascii?Q?LYWOaah/qnVaC7mFE886bvz2o6QRUWs0EfvrqyMf2AXosG8cRvOIXIXPS3CI?=
 =?us-ascii?Q?S8BGFadBVTSefAZ1vYpmc5z62SKYO/Vx3awDZQEbnGsEIWBegl2LSgEAMM5H?=
 =?us-ascii?Q?qd234Xt0KIhJcph4DsVNdSbdwXmx7ERWG0KHP5Ns3MINt52z6GOlEP4iauMw?=
 =?us-ascii?Q?/BW9TMfCpY8hTMMzXRHrC4KWWZ7WJvewyN61bX0CbMyEIQt0Os76dNatiTLh?=
 =?us-ascii?Q?4bcwML9vjcBckn0pJ2jDFVW3eFuzSvWzTgJhsuZSAahKr4Fpr9r2KtbHzN06?=
 =?us-ascii?Q?HXrCYLK/EjXjqqGBP/HvbACYLspG6BXvnc75roft6YQcgNY0RQSa9aVVcVVq?=
 =?us-ascii?Q?Hhn3dDZ3Rs8Kyu3CHHi38yvIa/y7lzXedQWcgnLos1DvBGDt9ZA7AVDYxwQz?=
 =?us-ascii?Q?SpgUUzK54B3HbTfvNr69/ohmmIScI7fRFWNZ6ncorFBLJbF/w7fB8t25C9QH?=
 =?us-ascii?Q?IC5MmljGAULp1xviWrYWZeXNhZTo8px7TcW2GdzVGgSoQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: 0LG9OJ3da4pSye95nMy12vulpk3uRsx8h/PZlUoKGKCb60zHVRVcAt8qipxH8CebCe8rDn+dFKx5D4hzWsvZuXy1y47Mc4+LvTRyTt8Y49/hpDsVLib16PO2B/SUsW5LsTYCtRR9UYsbS7a854jLBsZUWhXESBbwsi/1+fSXCdyibc2RkzlSxEpa9nBfweHz8tcRiHbsfLrZYL2q9fBqTl6X5FxCQq7JoxWhkxvjk6sBYN+z2U467Y8E4Yjhs0r+boO8dEW7L2KcBIrAa1F5YrjmPtgAOFOexxE5ecFG0MmcpM2KQ4WhvkkjSks68vZKcB+rxfveficoQJQoQbp4o6m3p70c+CtPum96PoMy9AQ=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2648;6:CVVjfM3KbEpB7AX/fibz5j67yjRVub0hpDEf4UEH79Cpw9szsUzL80S2oIAPjNnNsOyHrZzYbY9vAJUid/h/j2oULeDtPbOPjtgye1Ojqp+3/ilqDNVTCs7xhXhnixCxKNQLXqSd2LPlTEDE47m4OXnJkgnDw+4E1FpAc2JjRNvYkmZZZwe5TUS6BTJ4Buo+zMLCcBIMb79NugrEfEjuwAzAoAm0H3Hl8aoHcio80oh9W+O866QoXbD0DQ/hLB3QS97L3HX8XRdXUWP9KgvCcPqd/UttCKxA/GNr0N6mGzj5jBWzgsXfalLOUnmHqZYtIdYOpIXqYRKfTdX5N57RyO/atkn9rAwR9G43PnX8ic2salN8jPZzKTEdgJEUz73D/xp0J0q7/YHyU7k5gtQaAhzCr5ZnpL4i3zVEM4hKzMdZ+nnmqegl7GDTGZvTMGDDgwitei5e933sQ4c+wUdMaQ==;5:pk9fryFL972p+vaAI89pmoNuJugn2IVyUuD5lECATK5PvZFuWb8d1ENDnYNvUt0Wl1OhaodCLakWnk/TL8LHp+eeXGGHfu6wJw6nXkOqknO/RuJLpJvhz9PRw82sBq5dh9CFTV4QAcIz9j6dPcUnxYTP+8r/h3SzfGU5s1f9DUA=;24:UX//XGo3AyKPGY08PHroAXOAcf75eJaDGNhEnOIsVS56YF5mJ2tfMLxkVHwlncQ7LWZVTH6/JRJxjIxiRgqYIUwbsldGDD6wXeg6KHOhpDY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2648;7:hH9moxbaW3a9pq0VQV2Xf8rUFtlC+NuGP++en3mVP12ZBoAb5CxgBOUR2K+0UgqGB/W6kx6QT8jZGGPhMQU7+pFeSTZeFDw5qGJwFrSAFA3YNphX/sbOjTApNJbHUPmzOQQLFtBO29Fmcirj8PbVOcc9B2l9Vos8puZ+hVdONbwqaK0HWHY39Hies+EyU4PpqN/9qkb1ALQzn9g+r79MeVyIT664bJuhGk6GH4gTrSKaUoagLrkEEY+jwZC6pGPu
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 13:12:02.9635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 832dd895-de98-40ab-fc65-08d5dcf8bd93
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2648
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes checkpatch and kernel-doc warnings in
xilinx emaclite driver. No functional change.

Changes from v2:
-In 2/5 patch refactor if-else to make failure path return early.
-In 2/5 patch coalesce the format onto a single line and add the
missing space after the comma.

Radhey Shyam Pandey (5):
  net: emaclite: Use __func__ instead of hardcoded name
  net: emaclite: Simplify if-else statements
  net: emaclite: update kernel-doc comments
  net: emaclite: Fix block comments style
  net: emaclite: Remove unnecessary spaces

 drivers/net/ethernet/xilinx/xilinx_emaclite.c |  112 ++++++++++++++-----------
 1 files changed, 64 insertions(+), 48 deletions(-)

