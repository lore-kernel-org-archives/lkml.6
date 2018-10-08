Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6A2C677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE842145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="foGG6/0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE842145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeJIBfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:35:13 -0400
Received: from mail-bn3nam01on0078.outbound.protection.outlook.com ([104.47.33.78]:6368
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726291AbeJIBfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIRqxjIqSZw8fklunWqz4Itoz5gMdqn0SGQ/qU+mi0c=;
 b=foGG6/0gm1/NqFKE8qqHX/tR9E+9j67GRD06q57koADl+EcXaPYKL3hcoxOwD1SjjpaLwQ0ERzr+lNlYYZUBgeGNtYyux/bWOEQgL1LKW3597PxIeo5DGJprdWBVteDdbLPbMjK8GZo7TIxvrt0XTJAAeKUCNafnKAMpSBgG2hM=
Received: from BN6PR02CA0075.namprd02.prod.outlook.com (2603:10b6:405:60::16)
 by CY1PR0201MB1915.namprd02.prod.outlook.com (2a01:111:e400:527e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.27; Mon, 8 Oct
 2018 18:22:06 +0000
Received: from BL2NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by BN6PR02CA0075.outlook.office365.com
 (2603:10b6:405:60::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.18 via Frontend
 Transport; Mon, 8 Oct 2018 18:22:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT042.mail.protection.outlook.com (10.152.76.193) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1228.17
 via Frontend Transport; Mon, 8 Oct 2018 18:22:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g9aAL-0006B9-So; Mon, 08 Oct 2018 11:22:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g9aAG-0004DT-P4; Mon, 08 Oct 2018 11:21:56 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w98ILt9h024113;
        Mon, 8 Oct 2018 11:21:55 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g9aAF-0004D8-7B; Mon, 08 Oct 2018 11:21:55 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <olof@lixom.net>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <michal.simek@xilinx.com>,
        <arm@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v6 1/4] Documentation: xilinx: Add documentation for eemi APIs
Date:   Mon, 8 Oct 2018 11:21:43 -0700
Message-ID: <1539022906-18073-2-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539022906-18073-1-git-send-email-jollys@xilinx.com>
References: <1539022906-18073-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(376002)(2980300002)(438002)(199004)(189003)(50226002)(26005)(8676002)(81166006)(81156014)(48376002)(2616005)(478600001)(126002)(4326008)(426003)(8936002)(44832011)(5660300001)(486006)(446003)(476003)(11346002)(36756003)(336012)(63266004)(50466002)(9786002)(2201001)(77096007)(76176011)(186003)(316002)(16586007)(110136005)(54906003)(356003)(6666003)(107886003)(72206003)(7696005)(47776003)(305945005)(51416003)(106466001)(2906002)(966005)(6306002)(36386004)(106002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0201MB1915;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT042;1:gxav8RfEf9EVKEV1OROizrenZBDrpgZmYtE/3+krcIDfa/456RLWZTg6VMiQDXVtjPaZK/7jPvLyea4l5xRXwqwTUsc0+Tmb5HenCb9srA3MzmMthJuQRgjDbbbBK4sP
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b56c664-f567-4990-0a1a-08d62d4af383
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:CY1PR0201MB1915;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1915;3:gzw7Y+XsY0qEmTegbhAcQFLjR/Wd+3qqjbYRGNimVQw5VoiLi6iRgxCRgbutnYGt9qm49IZzW/+Ckob+Pseruq4+Fe3q84Yr7SgL5+xLSoLOZLg2x1itdkJOqLFj50TjtKvL1JjDgtnaDxQnXHyCfdbUlYMMWk5f7i30oUlxNKdgny4kDk5sv7mI/QBzK6POyLn8rP/QwbpFRVfekte8O/pbWfB2O0oeNu7K9OXKlvvux6FFO2O3EMRSayKuih7jQxChAX0LACzn2MOPJmMMsQdJgGKj06ePAVjUCaqYB/sYCbB/PJKjjUxVtZURiHOi/EO47Fei4H5InbjFAeSO0Amgm3jTtQ6NLeDm0yhScSk=;25:kC2Dd/yazbNyXw6pIaXSpvIgLrAIa3J2FiZKbZ1fE391XTpfHMrEWaVm/AbjVwfz1YFYpc7/HZ+nY77m3fdsPxORZ0iihCXIOYAMrSXXyzKLEl9FV3kYUGFOILTfxJEggYHcDNvP01bvIfzTJWd/rK8FRlFNDNjs4GTlmtMhtFAn4A3BY8evYBn+vjDbgJkqH57oZoNNY7efM028p9hzbWfC0adMEEA5M6j3PTjETAW6FE8RPfMQQ6K5w2/2cSIAVzGu6xioeD3k5zP8RR6XAGcIaeuMzIbP1eCUf/DqWmgSQxbQ1EUoU1u76wuvF8TI24Ig013evSmkIwRy2a5SwQ==
X-MS-TrafficTypeDiagnostic: CY1PR0201MB1915:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1915;31:XQzZ8MuyS9c4ER05oWG2r1u0Hcb+ukpleKg7L4FsxlLUlIgqN8XnGEr+PACEIUBVijuBOq8UNiD/XDk/XfE7pajJVSzcEvy9hcF+ImOQgT3S7uuibswVAIMLgp/1yZbJRPqeBYMWVnp+fbPSANtpPwy2RPK48yItDYu4u2GD9eDUxMclZ5HIoP3hr94xbXOjT6UlPQXl5tWaZSAs8Y4U5+sx6xgyGH7bl5kFZxdjYU0=;20:KIURjOfs8QxkzfVEugRXOj9q/3tF04Txx1c/5pr1NTnEbO2ND8mwRxbA21ZdPxt5YGJxHQX/Mpl1vZ79aGvXnKa8lSGzIiiBD/hsYFnUPLYjBZCSebCnM/+IpWuSuX/+4NIEBjMNGP0oJH59oczIyyPvUO2oQp9+gdZ4We9Fox/MWP+2MZE1pTfGd1dc7O/qbHhJGFn2oaokAD5O89LJQdjFgo/uvxm8SlWkwFgBPjIL+gx7szEPflP+bupboS1V9cZCFCenEFIizA7JmWss9kpcNjGglaGCyventsdKEtfs2TrV+Wc25nUklpC/1TD7sKm8yX39ZFuF2HkRTzd1jEFQn47YT2H+SPudSlKsZ8Mrov+doY/Gqegr/XUGBMAZEgGDo2A2fNrtr1tJEZ6stcYVHL+bNkQDxc3O4y9BCfkwV88kJ6PSRHbOJBWVEb01O9tbNarvXLBOVFoOZbVwrmlR6S1Xc0aUmCxmwY8iTmYPhbfG2qROTb77fPw5+SXu
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR0201MB1915D010867AD56035DDFD00B8E60@CY1PR0201MB1915.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(189271028609987);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051);SRVR:CY1PR0201MB1915;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0201MB1915;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1915;4:CoKVkSe/Yz33s/HSdswsaC7xPo6C5FR9pUb5L6Sq4OrtGXCZZEQf/cI0f4AJJJxZ8q2BJ5wuND4UynJez8sARSQkRQLcaqcnJLXl2DDge9CdIED9Ts3XYZR4A1YDl4oBk9nMgxojijbtDMf1Fd57bXKxM23RRaJ8BwuRw5lanKdK9t/OBUmNeB052HpzEaYAIWAdM7sWfTLxajTOmRSiG/M3rVMT6hOAPAxAhMkwRXeuWs7JapaeSSe4jzBtxZ3nMGOyWzKvKPBQACsD8W2epkcANp06e+fEEyGvblSpiq8ytJPtBspPitRbmvFC46BtGugoR2P7h5j84k3i0wfQQLpM9+AaNhHKC3gchTh/U3Q=
X-Forefront-PRVS: 081904387B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0201MB1915;23:uNARMeA5GgnGWp3edVVPlRHg22exU9X8U81YQ63?=
 =?us-ascii?Q?re9fQJLMWooIFmidtS63amcROq//VrDAjgCDnyqY9w75/TPb0UHimpQaDbhx?=
 =?us-ascii?Q?89EGZCpbOG8eRGEU3gQSfqo/32oQI/1O9lnpQuLLg1ryrZJ3Rf1Yhm5l6Nv5?=
 =?us-ascii?Q?lrnhjNwJVXQ3bMucvYor5PuKmswpi9fgTjX1mvAjJbgDum2a4WkKEzF5u7yo?=
 =?us-ascii?Q?lEWDKAM09F94dsVbIWg8NKsNNwvil/jl94cUprrd61ZeLkTv+1WZH/xLT0PW?=
 =?us-ascii?Q?trLrmahX5DTUpiE6QA146PQYDETVW/BMbUHNeiG69n/adFKic7sXgRS8fqAQ?=
 =?us-ascii?Q?ClVBTZIQuBsy8VrNRY9erYWeQOQbf/nWR4v0BUUWjMqkW3yOxvB4OsG+aCEt?=
 =?us-ascii?Q?bNK5EjbxC/vlsEMJX3sgLly+k+cYZ4wVdRaBCiLWP9ahZZzinIFL1xKk4k/c?=
 =?us-ascii?Q?Y3chjTUr1f7lVCs5hta3M7vx54Jz+xRu6aFkxA2iS9HDYybUic2QtKHWALQ1?=
 =?us-ascii?Q?IsJoV0jHRLECY3kh8Vr8S0rjLdsER6ZbgItmz5eVEyHeAZh0Imm5BCS9w+Eb?=
 =?us-ascii?Q?4HYkR6mJGpLrBYWi7L55H6RirvRn+DlmwSmbLgYzBVZxNJ/cqobRb4pGKutG?=
 =?us-ascii?Q?yJDij0oGy91SceIvDAwbIT7pEyY4wshm+6+ZPOBsAexO007255GJdbRsLuYT?=
 =?us-ascii?Q?KzRP/asNb3eXW/WOwxBinjn0pzNTBMcMZ5Qt/T6fidxSm/ebOmMdgWdsgdXU?=
 =?us-ascii?Q?5DlPRklWj8Nu7y85fatlgLBBJuGxBroGhf/jPfka1WcdJ2CIs6blFEOixxIK?=
 =?us-ascii?Q?i93WY1A0P/t1M1FoPi+3jeImqJT/SKbwBde4s1pisVr/j4DD5eBYx0fu346C?=
 =?us-ascii?Q?uSzKRPpYOi/bdfoFRlVx0VEMml5d91VcMbgnQTFo7+rNlMz54TGN/BXO8S9D?=
 =?us-ascii?Q?IEUoJvj34l+vtuBTIP+si/d3wp8DA46Xj20C/g9fDLsUBBPWmk2eaIWorpz4?=
 =?us-ascii?Q?2t34Uoi4LuCr7jW1+72Ek6BsM4BkIFq2nJa3q0jYxORXlU+MLZng/uE0Cu35?=
 =?us-ascii?Q?UPzrorsG6VN0pKRC0Gn82+cUIuLdfmPMCENCv2rtH/LBh5eVk+/OrHeWp0/y?=
 =?us-ascii?Q?i7F4FUHOAF9UG39SxIr+OjTL7wCu2KOxo97frMsr+SodxyZi0Wr+hTf0fCf+?=
 =?us-ascii?Q?u53kbrs550HGE/lJ60wsKkCTFl2Cw6zPi6Jr6?=
X-Microsoft-Antispam-Message-Info: cE27IVptb0tFHCzVM7k3McM0Dqcogj9vDwY2FolOz8mwaj2Oq4x+JjTIjW6Q921/rj32G01mDcgGCkh2gsQ41tzavb0o45dSeohat7I5NmnWetX3vt0uyjavhXbzsuZIZO+hmmi10HMkrSF5W48fmfDf/Znk7M8IiCwoU5RxQjYISw0XyqTuBUsvaDc0pINXMvizc6c6ovLbW+hA/cmOYIHz8btfTTYm8og4i2pPRW4prB+1HPEdj0ZgI4wVfX2yHe0U8xIjMS6bEygfKcjXpfbeneBKCLEUWZ3U2HxjjgfUIyv0ndmi0ANJ3zWmYd2bLydqZLXtZu6GPoMzHmnYI6IpiSjAU5w581elRoN/7hE=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1915;6:bmJ2fAaIe+q0jaZQ5LyUcFaRzzLR758xT58cIJC8++EYtyuW3DInxGscwgSuJ1fJJLi6VCCgJq97MSV/WS4AEnJCVa/BsUmVPzjGNSLmqJntYvtanA6DBFb8CPWKtEUnpP3a6nbabjmuibzX0wsQcDffXKjHHznUlJjn7OK/pmFsDGzQoLnNL1TPiamT4uJcMkVWQL7UbY6U8ftG+SHCspUm0tbY6z7CXvt4a99sDdiaW1YuugSQ5avKcT/6WT7ZOGN1hL8BxCn4adCszvw8RxpVuLK2n8uTXOTU9DibO1/gnDotTa8U2mdnGVN3nOiKos4sRO+eLc4P1i6+vafuQfXgl7v+q7juZoKToh+h++5g6zUIDRo7frX26ROutN98094UZZUSVcGMyN/1SPC9Bj0Cb+Fvm7kek4sY4kHdRA/betV9eT5KGwrMeTmvYuKCKd7+aMn1FHYERlNkjcqmPQ==;5:/Mj+aOPIKPZabokkhBP1J4iplo2qAPcJKpHwD6VzEepsDUkYC2TcyGKXTGEnYvRoFUFw/Ivqxm/AUmucZvIkpnKXYuDZG0DE9V6fEEMiSVkdt6phxNxvo+3k3k9RlhrehfjdJ4fFtQPEIiSl+3GWa4gWi74unf7FJwO2hjlsawc=;7:Z57oMiEKIGbrv+3Bykbn651wVWbLnnEW7vFtyn6cL0gtyXGCHK2UmluIr4eLhJEGbJqT3dWQ7ir5Vb3PNaszOTmqVe5948cqjMSRWiCQ8ypMope1YqoCjpwP2QOxC36QPmpJiQXBG8QO8dY2N73ESDSxhQ4gbGkuC61oevfYddvtImWo985gO9m6wWL6YQXRXTTD3FGR83elMBexvxIRKUDlcatWSRcCtapfga/kj8EMNBEhPQAS4aqQH20rdEBe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 18:22:02.8596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b56c664-f567-4990-0a1a-08d62d4af383
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0201MB1915
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
Acked-by: Olof Johansson <olof@lixom.net>
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

