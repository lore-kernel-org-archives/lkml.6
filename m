Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A860FECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300902064D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="35dsNwzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300902064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbeGQUdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:33:53 -0400
Received: from mail-cys01nam02on0078.outbound.protection.outlook.com ([104.47.37.78]:38976
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729980AbeGQUdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ae3uMsPM9qWtcPtZCcchHnnmLXzK+8XsulKYSv1xPnQ=;
 b=35dsNwznORnkXxpuZ9FhV+AibBqptnFW7QzudmFHTJsqSVMs8lM7gQM6Jf62yKh1AQLpV1x4QOAOioJ+N6KoeKN1aRESnjNg5rXfV86bVPHa8JQvg1vXTE03nQAlW4A3rK4dZY8aMfXyFlfY5AYsqhlTgUkfj4ICpkHMJSHzimE=
Received: from BL0PR02CA0044.namprd02.prod.outlook.com (2603:10b6:207:3d::21)
 by SN1PR0201MB1917.namprd02.prod.outlook.com (2a01:111:e400:5223::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.19; Tue, 17 Jul
 2018 19:59:34 +0000
Received: from SN1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BL0PR02CA0044.outlook.office365.com
 (2603:10b6:207:3d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Tue, 17 Jul 2018 19:59:34 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT029.mail.protection.outlook.com (10.152.72.110) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Tue, 17 Jul 2018 19:59:33 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ffW8C-0001af-Md; Tue, 17 Jul 2018 12:59:32 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ffW87-0004zI-Jd; Tue, 17 Jul 2018 12:59:27 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1ffW85-0004y7-Nf; Tue, 17 Jul 2018 12:59:25 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v10 09/10] dt-bindings: clock: Add bindings for ZynqMP clock driver
Date:   Tue, 17 Jul 2018 12:59:06 -0700
Message-ID: <1531857547-16652-10-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
References: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(376002)(396003)(2980300002)(438002)(199004)(189003)(9786002)(2906002)(26005)(107886003)(186003)(2201001)(426003)(6666003)(44832011)(77096007)(14444005)(5660300001)(126002)(476003)(16586007)(8936002)(50466002)(36386004)(4326008)(2616005)(486006)(54906003)(110136005)(356003)(8676002)(305945005)(11346002)(446003)(48376002)(81156014)(316002)(81166006)(47776003)(76176011)(7416002)(63266004)(7696005)(336012)(106002)(39060400002)(106466001)(51416003)(72206003)(36756003)(50226002)(478600001)(107986001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0201MB1917;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT029;1:HbUrg4R9FJU4/mHVW/PUMz6o58k4QGaGy5Y7eQHWik2ENq89g7NaThjwcjoCI9DoQLW6LmbtNt6Ue97mlFM4Kc6sjrPk8OPrznIfK9NnWHOiQzfoPvNbJo4OpvnNEJCU
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fd01f1a-f4ff-4d2e-4eda-08d5ec1fd133
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN1PR0201MB1917;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1917;3:Ydg5blDcgZxaCWcfvizjZCe3Zs3D24Nl+VAiJeW8XQZzuWSEaeCZ3gVNPFiu+DPD/I3osMajDgXEce0JLzcVlqmrqop2joT+uAf49apdKwlTQflAqQt2wGVvT63GT33re0/Qeg76WAH1cn7YaKDjAFOgR6xl6csWZnkbxz1c2h4NxmHdm64W9xyUgjZZom7yIS9KORGLUNtcoPC5oIWtSKDdV7MxQCSCfiBUufvzF7GU1Ukoh+aVI+1R/StcojTQl/6E1n4U/tu4Y8V7lCFNfYTuExlvQLcHe9Q7wrznMBhVXvRb7UkWKXX1T25P3o67a0bJZHOUW7yj73OnguDSjPzOXrI5Ngv4RfHSimClBsM=;25:ZWm5YDlAScd8EPy8NqFAF6saNd+jeszK2wDN2uDgXQMI7Ebrh+hDp4gA9BU8LjvtU+1rG8oqQediu36pKAJBptPZTZ5W2e0CcAHLqojIAJEF1g4+N+vBf9tIZrmzyPhg9ROXZw1mAoN7L0t0w49VbltmkYZ2orRNULV73vJvqYrUSMe5qPmD2mo2S/3Vyhcd4leRMM0cWdMve/WVGNTXLCoQzZWtUmr/qm8NBR7DFaUF3tOxOxYzq7AQKybP8Vl40gvqopJrEjFCFiRVGjj0Fq65M4B6kyzS25QD+Rtc/SC4mf0dxet93IbuYwESKLdKpuSUY+2d6Yss9Ab6/8Clzw==
X-MS-TrafficTypeDiagnostic: SN1PR0201MB1917:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1917;31:fGynviVRTCX6qJU3yxdKBjool4MYT4UK2oBzhtOrwFsFrohD4ZBABaqL6sCU6GLczYsydHZMtnqcrvI8E6+XE05Uz57lOQX4EyMsNIB4Xue6DV+aHQstDEAlCvcQXi9hj2/dlfGF5i+oOIq34fbuWzhPe/SoLnccp6oaT2KTSB5EreY1Si2krGB2PCVNwcfpnIRJmLReBQtG26zx2SLocwoqrenkZaA6+fLqzvJe7h0=;20:+36Zmy6Uh9+KO39YW96MQuXZuBdFLCHzKykTuCJgnbX1eXj9ynNLWy0z2e7BVhgICKJ7qazwxDixRrljFD3WgLrff0vgDKj44c8KjjYcg70ySGeajUhDpTS0ecGTpBgPmoArsGTYCvwRhnhS8Csy2/r1Vp+tgTSp0gUuXrFJPvKQ6i7ug/C9QOW97pVU1hSpzb9i0w2Fa8JkL9saNZOmuz323FdgjjMe0lhisiTq2A+XUjzcyN++4mdG/vPw+FuNiJtUeI/7iY/aNScYE9Op0d7f6++XgkQhb9ThiYzfOQ1kgjN2VqKLN7SLHGgU/GUUDdQWJQejBhZpzzuwcLMvFD4kXnnwro9jq583AL/rsRK6Lf6UOYp45tRLCXSNj27ve/Kuh/lhW2IR6uOKshJFDnAZVDiDTHPoOf9evFhBFw7/5rqQd6CExhihkOs+01UvqJQfuh7cvzwfk3+OorayQSP/nxkpI+qt/SnXtxBLx4yrk5YCrJXmAkmhIMrXqyia
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR0201MB1917C9387F3FF8AFB330F99BB85C0@SN1PR0201MB1917.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR0201MB1917;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0201MB1917;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1917;4:QDKhWgaEVX0v2PY4+gZve45DyH2BuoVmT7vrIPvxrVrtsUxwYY8XVtvhcOL5N5w7WkUrgB35WSwZWt4E25WKv6eghrAvaeRyEVLzGIfGDM9lQFBfXKxF8ATMhUObjc7cY3hnYmnDHw45RzfFVBlK6ejCCKvjhlbeYdfs2hWTV56ndWJ3zP+JlmPlOngVxv6QIW8n8ufti+kYEHcChAmAvldzV9Vk/l8RShU8AFOXI4pZvJ67XQro4SpuD5S3oRIO461kfY6WlLp8RV9oCjkCUvVQ+xa1DeaeiS8rBtJ7fnKlR3Px85dHY7zFed1GswEi
X-Forefront-PRVS: 073631BD3D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0201MB1917;23:6zsYMNdeFLOVAlrZ8RH3gUqbt/Xe++zEKAlvZnW?=
 =?us-ascii?Q?HwV7P05dEVJ37cstjIwplSig894msBSCaFg8s9oJ9JC7WlHw/AgPwgASy5qX?=
 =?us-ascii?Q?d1Ub7gDcm88uP/Uzde6ZlA91wPptunwTSIdjkIJhopurosGQ1vqX5WGSsDXp?=
 =?us-ascii?Q?MRRoZZUzSVJx4mOX8c5pPA8XPkpre3aLogAQKwhuiEc0wiBB4SajEOK4zFwv?=
 =?us-ascii?Q?kfwxOrIi2D5PrkOqnMJjeyibjDLgL42a22W6JQQOYGG13dUpPrHHhlFuLfp9?=
 =?us-ascii?Q?9jZHC2R6taC6k4pxstiH19xTHYk4I6b3AllRAqBr+u6B0aRzFF68w0xysa2R?=
 =?us-ascii?Q?UMQGpT7VhPY1zixXMB/MwRqb9fVm5IvCpKF18WWii8ASfVeWfwmHRlNxXjZl?=
 =?us-ascii?Q?3SaJNMaMIk9fWPumI8+EiGZ0zNe7NjnN/pDo5Z5gB0M2ZawyFTUMK4Jn8n+2?=
 =?us-ascii?Q?AOf+vVnJE0t0irJrhQV1dWIMzGzmluz1qE8aK+OerkhdxQocFZN2tqnZLUcd?=
 =?us-ascii?Q?Tm0e3AvUqZKd5qqOBcZJBaOxRy10NfAj/TNk6jL88aRqfB8XEccpdHNFAe/N?=
 =?us-ascii?Q?v4XUXBBU2n01iu3QV/WEEgUDlyCOXclYAAG9Ir1gEMcyvwDiphbhW5gcP5Ej?=
 =?us-ascii?Q?LUNQbqaZhSTzEJUm+I9ymIqENuGqaXN4mFRaHBS1BRS//G0E2Pd6kJ1CZS9N?=
 =?us-ascii?Q?MqK4c09uwL1juxewpjMZhinrH+NhSuitHjHHqP1tebgFNbuT1uZh0IqCZgCp?=
 =?us-ascii?Q?Nh1WYtQYfiIZLPG/8ROPKqH8ooZj1ptBi5twJE57FbvuowOz8/SNTIqyFYX7?=
 =?us-ascii?Q?1nwqN1OXT4n3cHy4o6IiMqyj+zb8lgjtsNcKPEcJqS7ZSlfqx15QCqPE3GPl?=
 =?us-ascii?Q?XHNsyA4t1D8vP/+KAe0gFPWG/F60kLwsEqenoGbNeZODjTQfalbq4v3Xt0SO?=
 =?us-ascii?Q?bvqW8RTo9FzXQpkXv53HAwm+FDAr1yEdpDatZFw5j2lNwzHpvMLBrN4jcjSl?=
 =?us-ascii?Q?U73n7Jn+m1diEXLgeGpPgR0iBNsCXXtg10jrqhLUqVzmp2OIMXU0wu359grr?=
 =?us-ascii?Q?5tooUmOOUVGDA9VpDhatT64vk/QEj6C7uULnAJAUgVFpAAsTtah5N3XRyHsH?=
 =?us-ascii?Q?GT1TwVnZ8sgAvB8tJGueNXh6dsSVPD/b02lVknm9VZhj5GHALT1QPtcLmxYs?=
 =?us-ascii?Q?QBuYKTs3oRkpERYK8Do3tUIeyBNFXbv/aqSwcMaLq8W04QW8iLjdARNC9CS4?=
 =?us-ascii?Q?e6ISx65UgBvyHU93pzaflsIOrwyBQcF3GkjMtNP74?=
X-Microsoft-Antispam-Message-Info: YqijupFRXLGYTFW1PAriXtIz8oGX/9OBVlZrQXIm/Ho/5ALcrvcuMoSPsngmMT0hI+vKM3xovDHuzc1mlgwDyHgsQ+KLxAS/o2lNpIqTEPKP49c2+GMph1x1gKcwCTYr9dOkUmo8Ui6ECgUkFoFiMvMDUh3eGBc6pSPCqb0xAZ3R6O43yxbxbLwVdp6jqsHsFqDqnyht9o+8vzcKYlIan4JGYS/Jo+9OAvpPrr1sIO+iPcI1oZ2LoF7TuG55VbQL77k/+3J/9S/Rm+dWdKuPHzcuC24H7xkxCJOO0bYU8/srvZxsSEoKtWbo4rMnzGv8IC6Ek1WIGfJ8qCQ51X1kGgJNm3DDnROo9CpEsWE5hQ8=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1917;6:px7g/v5qN1CFdC/FqZrAurMZC8cspkpeGVIJiIs7msPD18Oxh3iZMu7frXP4lgOxknG/JKo+VxuFHwSce1TV7SR+mnnh0NdYYws0q/96ewaH9j+UXr9+uCMPrvXHyUU9ZmO7NRz4nnWPTrwVklRzRXv9/eTEtDbYIVMChdeXx7eMw6k39QeRAWglv8oJCsgzECXgjptRyDo3xq/9Nth63mw8Uq5i/WLi4x45FYjTqjfChGovtK2uVWbL1sFnO1tKgfvTWHlLRdJx+nRThf86TorMtqBZAv0RYX+1XuXIWO0KbebjC8iJszuABGemt76ZVafsmvnb1DaRl1iqVatqfDLxHn3W73Do4K564K+Ntrfu4tYutOJOh7yO7eGscSKYvxNGaBOgLaVV+UQwzpTzVbRJv9iXUznVlSmsNbZB0c3z80h1VnSzdlrCC21U4Q5XHPREGrnHWxPeXNo+qbgT+Q==;5:JdS2BsYBkBNCa2vSxqZ2jZvjDBCAg/OouwmB2CbN2W0LtOmIVTHyXV9/Y7kWUfDzD0uJPRaw7IsK8DxX74F62yB9MFaC2eh/fAB4hjsgipVU50HoVuOE0FgH0k5uMf29ERNo8ks8YfpxEGu9wgkDnZumG3mZqkTKgamIR2BiKvU=;24:UD3Npm+MkQe++cGXsMrsvSJDDt4dWu/RvyG7nxgnWAZFVyix7YF9Slmqo0a3OeAEGlo7t4jDlz+VNvPMyvPMmd0DKAyOzjRroUosamYWd00=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1917;7:TETfsGekyRgn1AsArOlL9mxRqaSOVyGfUaTiAEwuwa9UMuqZhzDilvZOMfgQyBCeMR5/cslWh7Aa+YxbS68IPZIARTb1gLXwpq0bNY3He64W0sIZTcD5p+rtptbzV2ZxwFvyUhxILsLdLJhExfKdLYwRq3/MZ+HCC2DZUeOlD+V2A4PyOJ6zEnxNqIQQLbSirc/u8RQxrI/V3SH2pS7etBhcgxc36AQPwGsM/QgVx83TDUhihreP3+fSjKPmBkmr
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 19:59:33.2297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd01f1a-f4ff-4d2e-4eda-08d5ec1fd133
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0201MB1917
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add documentation to describe Xilinx ZynqMP clock driver
bindings.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  53 ++++++++++
 include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 +++++++++++++++++++++
 2 files changed, 169 insertions(+)
 create mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
index 1b431d9..d215d15 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -17,6 +17,53 @@ Required properties:
 		  - "smc" : SMC #0, following the SMCCC
 		  - "hvc" : HVC #0, following the SMCCC
 
+--------------------------------------------------------------------------
+Device Tree Clock bindings for the Zynq Ultrascale+ MPSoC controlled using
+Zynq MPSoC firmware interface
+--------------------------------------------------------------------------
+The clock controller is a h/w block of Zynq Ultrascale+ MPSoC clock
+tree. It reads required input clock frequencies from the devicetree and acts
+as clock provider for all clock consumers of PS clocks.
+
+See clock_bindings.txt for more information on the generic clock bindings.
+
+Required properties:
+ - #clock-cells:	Must be 1
+ - compatible:		Must contain:	"xlnx,zynqmp-clk"
+ - clocks:		List of clock specifiers which are external input
+			clocks to the given clock controller. Please refer
+			the next section to find the input clocks for a
+			given controller.
+ - clock-names:		List of clock names which are exteral input clocks
+			to the given clock controller. Please refer to the
+			clock bindings for more details.
+
+Input clocks for zynqmp Ultrascale+ clock controller:
+
+The Zynq UltraScale+ MPSoC has one primary and four alternative reference clock
+inputs. These required clock inputs are:
+ - pss_ref_clk (PS reference clock)
+ - video_clk (reference clock for video system )
+ - pss_alt_ref_clk (alternative PS reference clock)
+ - aux_ref_clk
+ - gt_crx_ref_clk (transceiver reference clock)
+
+The following strings are optional parameters to the 'clock-names' property in
+order to provide an optional (E)MIO clock source:
+ - swdt0_ext_clk
+ - swdt1_ext_clk
+ - gem0_emio_clk
+ - gem1_emio_clk
+ - gem2_emio_clk
+ - gem3_emio_clk
+ - mio_clk_XX		# with XX = 00..77
+ - mio_clk_50_or_51	#for the mux clock to gem tsu from 50 or 51
+
+
+Output clocks are registered based on clock information received
+from firmware. Output clocks indexes are mentioned in
+include/dt-bindings/clock/xlnx,zynqmp-clk.h.
+
 -------
 Example
 -------
@@ -25,5 +72,11 @@ firmware {
 	zynqmp_firmware: zynqmp-firmware {
 		compatible = "xlnx,zynqmp-firmware";
 		method = "smc";
+		zynqmp_clk : clock-controller {
+			#clock-cells = <1>;
+			compatible = "xlnx,zynqmp-clk";
+			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
+			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
+		};
 	};
 };
diff --git a/include/dt-bindings/clock/xlnx,zynqmp-clk.h b/include/dt-bindings/clock/xlnx,zynqmp-clk.h
new file mode 100644
index 0000000..4aebe6e
--- /dev/null
+++ b/include/dt-bindings/clock/xlnx,zynqmp-clk.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ */
+
+#ifndef _DT_BINDINGS_CLK_ZYNQMP_H
+#define _DT_BINDINGS_CLK_ZYNQMP_H
+
+#define IOPLL			0
+#define RPLL			1
+#define APLL			2
+#define DPLL			3
+#define VPLL			4
+#define IOPLL_TO_FPD		5
+#define RPLL_TO_FPD		6
+#define APLL_TO_LPD		7
+#define DPLL_TO_LPD		8
+#define VPLL_TO_LPD		9
+#define ACPU			10
+#define ACPU_HALF		11
+#define DBF_FPD			12
+#define DBF_LPD			13
+#define DBG_TRACE		14
+#define DBG_TSTMP		15
+#define DP_VIDEO_REF		16
+#define DP_AUDIO_REF		17
+#define DP_STC_REF		18
+#define GDMA_REF		19
+#define DPDMA_REF		20
+#define DDR_REF			21
+#define SATA_REF		22
+#define PCIE_REF		23
+#define GPU_REF			24
+#define GPU_PP0_REF		25
+#define GPU_PP1_REF		26
+#define TOPSW_MAIN		27
+#define TOPSW_LSBUS		28
+#define GTGREF0_REF		29
+#define LPD_SWITCH		30
+#define LPD_LSBUS		31
+#define USB0_BUS_REF		32
+#define USB1_BUS_REF		33
+#define USB3_DUAL_REF		34
+#define USB0			35
+#define USB1			36
+#define CPU_R5			37
+#define CPU_R5_CORE		38
+#define CSU_SPB			39
+#define CSU_PLL			40
+#define PCAP			41
+#define IOU_SWITCH		42
+#define GEM_TSU_REF		43
+#define GEM_TSU			44
+#define GEM0_REF		45
+#define GEM1_REF		46
+#define GEM2_REF		47
+#define GEM3_REF		48
+#define GEM0_TX			49
+#define GEM1_TX			50
+#define GEM2_TX			51
+#define GEM3_TX			52
+#define QSPI_REF		53
+#define SDIO0_REF		54
+#define SDIO1_REF		55
+#define UART0_REF		56
+#define UART1_REF		57
+#define SPI0_REF		58
+#define SPI1_REF		59
+#define NAND_REF		60
+#define I2C0_REF		61
+#define I2C1_REF		62
+#define CAN0_REF		63
+#define CAN1_REF		64
+#define CAN0			65
+#define CAN1			66
+#define DLL_REF			67
+#define ADMA_REF		68
+#define TIMESTAMP_REF		69
+#define AMS_REF			70
+#define PL0_REF			71
+#define PL1_REF			72
+#define PL2_REF			73
+#define PL3_REF			74
+#define WDT			75
+#define IOPLL_INT		76
+#define IOPLL_PRE_SRC		77
+#define IOPLL_HALF		78
+#define IOPLL_INT_MUX		79
+#define IOPLL_POST_SRC		80
+#define RPLL_INT		81
+#define RPLL_PRE_SRC		82
+#define RPLL_HALF		83
+#define RPLL_INT_MUX		84
+#define RPLL_POST_SRC		85
+#define APLL_INT		86
+#define APLL_PRE_SRC		87
+#define APLL_HALF		88
+#define APLL_INT_MUX		89
+#define APLL_POST_SRC		90
+#define DPLL_INT		91
+#define DPLL_PRE_SRC		92
+#define DPLL_HALF		93
+#define DPLL_INT_MUX		94
+#define DPLL_POST_SRC		95
+#define VPLL_INT		96
+#define VPLL_PRE_SRC		97
+#define VPLL_HALF		98
+#define VPLL_INT_MUX		99
+#define VPLL_POST_SRC		100
+#define CAN0_MIO		101
+#define CAN1_MIO		102
+
+#endif
-- 
2.7.4

