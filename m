Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF09C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB18214C5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="poIx8WKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB18214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389207AbeHPKDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:03:48 -0400
Received: from mail-by2nam03on0080.outbound.protection.outlook.com ([104.47.42.80]:57960
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389125AbeHPKDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quY6qzD9nwm/qmutVepZhhxGZe2/Ceiw1PXj2TOZn18=;
 b=poIx8WKZjZm/jtror5W9e55GhgDaD1MEJFqDbS4uZBia/NgpeUgm40ISXbp4DRipBwPz/XMPOuuboSwjqa56xUbEYdZB/CohoiCxZFgIET8VUk9rNP+gob4V9Rv7VAk5hIKocl7JMajs+h7cnFl97Vf1z+Qcphv6CU2y+4KCxaE=
Received: from SN6PR02CA0013.namprd02.prod.outlook.com (2603:10b6:805:a2::26)
 by DM6PR02MB4330.namprd02.prod.outlook.com (2603:10b6:5:2a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.20; Thu, 16 Aug
 2018 07:07:03 +0000
Received: from CY1NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by SN6PR02CA0013.outlook.office365.com
 (2603:10b6:805:a2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1038.22 via Frontend
 Transport; Thu, 16 Aug 2018 07:07:03 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT055.mail.protection.outlook.com (10.152.74.80) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Thu, 16 Aug 2018 07:07:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1fqCN3-0007uK-VK; Thu, 16 Aug 2018 00:07:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1fqCMy-0000y9-P0; Thu, 16 Aug 2018 00:06:56 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7G76mQB028389;
        Thu, 16 Aug 2018 00:06:48 -0700
Received: from [172.19.2.167] (helo=xsjjliang50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jliang@xilinx.com>)
        id 1fqCMq-0000pj-0i; Thu, 16 Aug 2018 00:06:48 -0700
From:   Wendy Liang <wendy.liang@xilinx.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <rajan.vaja@xilinx.com>,
        <jollys@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wendy Liang <jliang@xilinx.com>
Subject: [PATCH 6/7] remoteproc: Add Xilinx ZynqMP R5 remoteproc
Date:   Thu, 16 Aug 2018 00:06:29 -0700
Message-ID: <1534403190-28523-7-git-send-email-jliang@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
References: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39860400002)(376002)(2980300002)(438002)(189003)(199004)(51234002)(2201001)(36756003)(47776003)(305945005)(575784001)(9786002)(81156014)(2906002)(356003)(81166006)(8676002)(8936002)(44832011)(478600001)(106466001)(50226002)(63266004)(4326008)(107886003)(110136005)(54906003)(50466002)(336012)(16586007)(446003)(486006)(11346002)(5660300001)(48376002)(476003)(2616005)(426003)(106002)(126002)(316002)(6666003)(6636002)(76176011)(36386004)(14444005)(7696005)(77096007)(26005)(186003)(51416003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4330;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT055;1:oUFJC2K4urqULV3/DpuZXF/pRoeYfasfByjHWTgWr7qniyZncGbGRTkuBb4NEV1YvV2iFXEIgFQZR85t9w3Ivy4YvvCrE8Gn5KmSUgGCTOUDT7SoNbxWOFGqDCzm2Gg6
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df8c04f4-dd15-4c23-3d73-08d60346de38
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4330;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;3:WDLriTQsh9h0ARZXt1mQHSEvQ62xom6Hu1i7pBvXHdbBeGILJNEz/SCZxSuke+z2mhClHlWKOtgjE9uET1CuxPvUH4D46d3nDBc9ovv/cUlD8e/zJq4ibrHTG/U8wOnVLuvw0M84lWtIoxyJY+mpKc60S+v2QE7wObJd4+D5Rnf1/zAibcdZm2PHiV1Hvx5iBcyGCOVwjQYU6Xjzx+cTkPLTVEvfDW4Mx8nVfY8gEkMZFX7alrHpuXNWd1NvP7I+07SUmcd/240qiWHo3WyOb187itdWNvDQNdtEm2rPCSTJY3uSTgUjTBh0SyV+5YLGUCl5QqDiO/HT1ku2TScMpdF/7+Yof5GUkdfLsw29CqA=;25:ZZAd9MVt7424lQLmRl1oyJAPctKfSrIOo38S7A5+SKBmVaLOQdgJfFJUm02LcKp4TDMpaOruPtTobE4MI2On7elJpfKQekhtG+MT5slO7WBIqmLAGyEJ9M23u7rTm5z2xT59GRcn+vkOc83q9UhQ46KuQnSyE5cmFiFnxK8Ab/79vTasSZ3FlAwQONw8lSmgzjfuczfMKmqF/tqzHY5pqkYceO/9eQXl9tSHCcKOLEfLpFczZvMV9HcoILNOkl1gJRlqGflGZu5aJ4/J+4OIq29vXq6mJpF9FG/nBRYcubmK8Dg+28zw2IbMvT3MdlEXSlebhpk+VbZ9wXZTtuEpRw==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4330:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;31:bxMEqZREiykq7oK+uc+eafT5dlwEBi9hlp9oixm4d1tzExFiliXeSc8lJc7TuSFqgKY1uKEw//GQlO6sZJemReE4XdXys19QYuI61/hAdIPIqKBZ0pjLUO9uP8+Vihq21LLbMm+Onqq/y4JKmjxvzRBypUZaNXSaX809M/j20CISXf0Z2mBTtLCwY3v3axtH70I9gk6fHupbxOmVQGI2R5025guQs9nhUam8e22AfeU=;20:x9wkd+lu649CHx5YIilRZxAK+hn6tJkjOTlAwDS+joS5Rdgo2vmi/z4/9Lf62VjJRAwf9GYG8VP/ttBisd9LdvEXsFfPivyj967Burk95VVKEUWpC5Xn+6MdyQF8u9jOpwsJ3qLjbtZnB+G911wiaGZFJoPSC39GHIGMIo6CVp356Ip3f6bzgy7xDz3w7h4J6bTEpUJNniM5/PXuuL1wVX/NFiQhKi6yi6kmeDb6A5Vqdq109qkX7C0GHRwESatHciyAvLxT2zb0X/GtQuOPROrBHiraIuT8nKjeTHIHFraFyU71lqR/WCOG3WNfgx3Lre8xNw+j1HnYpMPnfjtruFHMhgKxNzBCNHCok2it80sv5XKv7i+/WHk2jTi34glifMjlf24zlJb1Kz9MF8jVLNieeO5muqDBwegI7GYdgCkO7B8dVDOAa0T/sophIbqClyoi+FvCukZwBjGhTenKBhT1ZSYKVsLihNp21X9Ak26dCM2Ttr36uX44osIrtnOf
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4330845585775882B592111FB03E0@DM6PR02MB4330.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699016);SRVR:DM6PR02MB4330;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4330;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;4:IfAArWxBEwWqevrrQfsA/0dz4SBDIpTozW5HHUDG+IO3a7Jy8FSkrkByCfFTeVyHYKNWdRQMb3MidSQUKMiwhROqaeGwNuUffgLyc4qmJhp064NIj+gC1cJ4AeZ4nHSMQ1qh7yq/CSlQEhrWp6KCjNi/3pwDmVHUu5N1EF/aTP4FEA1K0/SIc2yfmM9g6HEA5kDWOReLbwehkVJ1Ifq/hPE8uMZWUckdvwVBZqVxt49FkfqLTkDak4k6tnsKswwb31A1BNpxUJ9bIn9PN2bg3y24v6xrYZX6CjGd1CbZCEZZnhrSd1FOMpYCxWQvbljC
X-Forefront-PRVS: 07665BE9D1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4330;23:2rihax1r7gaghXy3GscHfs8ANzT20UdR7zt2yJx/q?=
 =?us-ascii?Q?5y8vYS5Ax3mA33a7yPPQujWTteHxR8O77hGJLVvH4iACzy6FtKo+N5Fj4IY3?=
 =?us-ascii?Q?YeXoX5KT9TkAxBwGD6uemW6S02Yn2LoDXxkDWrlS45lLXem0U40KcHnDQuut?=
 =?us-ascii?Q?PRe+AmI5sHE9C24ko5unnWKNlg8+uJVvvyn8DRU6cq320eYkKo6NDJCCtyP0?=
 =?us-ascii?Q?HINIdsKZAo66fvgD2hqHwsPQR/lETfcW07s7wysrx2dNMPlI/CKswmiAq9k9?=
 =?us-ascii?Q?R22gbgR8Q/DZcP32B4b8FN6Gk1oCqCkxNqaTQKWNyEZ4qYDswaW2xbgPC95q?=
 =?us-ascii?Q?a10pGNqSE7IEOEYpE2A77cHhO2sa1S5/54K1TqW9zhNOOpLWsgW8uIUH1GLe?=
 =?us-ascii?Q?0RNuFxxo56/Fd8wLACe/Y6ocy+ZKbFS2OnPVt3AESLC/bd7wks07siXvt+xo?=
 =?us-ascii?Q?YWjtAh2CkUEn/5LDfOdt9BMAS6r2KgoR4/SjZX8LKrSfGd1yoEy5w8/GVPd3?=
 =?us-ascii?Q?NggGXyP5uShS6pKXkgfXHCJd8ezuTuwy9wHRUHfoKQtR35sDe5qWmETLMHig?=
 =?us-ascii?Q?oWL8lAFvHK58GKsUxejNXpXZ0X0zWYD+Ds0YuIVht++JzjQtp8pUIXwCJgQC?=
 =?us-ascii?Q?nlD7kuswiXoU5jwJRuArIP9CfEnPqJgN1W5/BYDnAch/Z09jfI3ET1zpCeUw?=
 =?us-ascii?Q?gDhTN7O2YH6fsCFlUruRl79TML+nFep3IzhDOFsKI6hGdDHM1gpmJ/anmBHB?=
 =?us-ascii?Q?XvpJn8tUb8kgLU3OKfLgF+ZQiPKHVm4DhiyCRqljdi2w3r9+1RsEgv1TLpX9?=
 =?us-ascii?Q?vpKPWftp6AD2netEL81dbf0TA/bAQpd2RNHhd4DjQCiIxwoU5LrvyLG+WVKH?=
 =?us-ascii?Q?SADEQKZiH+FYOfw9uB1+VZ97izf5lm44KAOP851dunciRfXHGsdryE8w+Z0T?=
 =?us-ascii?Q?9lmm2SG4jnwtqtgY+FA4maUD+WFvafcYpoMin0bKyJglkdUExYED6ir0dpFz?=
 =?us-ascii?Q?55TKHZvhPkw60ORZPCaoVfbMtWYw7Jy8wWKVl0ZPdvPZTdHkJ43BsxyycZfu?=
 =?us-ascii?Q?IwAd8ruV32zRaBuAzkULbJwmQgxKCthPTOeZm0DFeF9m7ni92U4gf/ylimgQ?=
 =?us-ascii?Q?ee70UEjXksVMf6eGLunH20MFQK35FOtIIArXwIIWVJOIyUoRsNj9u0/13nlm?=
 =?us-ascii?Q?mqjiV7XrZ4I5wCe/T/kKq8RCpA0Xb8z6lZ8eF3cDVHbGIFOWgFCiAjloQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: zvgK4qcve8IlHh+VANZSqR87k5eF9m5yclWaYI5Udm1cQRRGSK3xoT6kORX72Q/LXERBM1LgELu7NnvCZ3tAhb3rJPwlndQ+eh9wQWLJI1KgXCE3y6DPttwVvvWM6WijWnv0AfbWdS9OUh22EMXFqotJ92zP47Rza2TCe+WiF6i1xh6Gt+OFZzJ/zheOojzGbdL87bBnirsKjr7cM7rlpatsWznQF9t4WaTyW139nvlriFOgpDnm+KiVwUEN3h9daEKgESOPovC/DgaCUBj6dX1wwgSvFKdXgFm5pc1RIeruvKxqSaWxLdkgBw25/Kmz4wfIzqH6rL/HnEuUApReU+g3NIDihVxp4UNlJNyb+j4=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;6:ZoBdE3dvZxNz8QS+YjbWaeW/ezd09Ws+CEmPPWAC3vKfT1EcxMWUTcxrubzBv753uwbQCnZhtR/DerlcQMmVfG+g30NgMukT7qdAAHasRmVs/sRG3KQ+jtJOGJT/gv1dZ1hlMzTT2TmNkKWwORwB1DfURjXM7YdhmPiP088J8Qc0CNCtfwlhBcm2gLfNdoO3TCIUOceC72KVAJH2J0VYPziWlikCuIWUNLje8nOREEqGnk5Izxf6MQpjO7EIGlAm1474CihEt1t4SYGHRunH5195+1wy3rD1lmpbkopG12LE1rdHzNEfjYWWjOXIZbid1adN6L9veCW6g1rrMdzZBmZWDDjoHy9/COmKWhx3Ir7RMuaju48SlmtwUbLC44sM3AftjF1xzGYaCy3/Qx8ocsFODXEj4/yQJH3MzRhqqJ2VJaU/mvgrkZPG1tvZTIB8VJvu+FT/OxJzTYrWTxAmCA==;5:x5FK0yX6wl4JvgO3bSOFwSpqaIQu2y3077t7AV99I0rFhTfMufARUuvoWyPdGlR/FFLlfHCouLmAF1SEbr603n2F/wW/dlCNOuSdSep4PbcRQFX1b6qDj04J83dQGokz7hhe0vUad6OLKGMEOm0fF2srbea3y1cggWNru6f2GJA=;7:O9vXkrPTt5zXOwyNbetf/wH/g1K2Y2WMUib7VRE4RolCweAN1Pcp+KrjvducY0b82IoTWntJ5HT7O/bZYQTApj/lflI1UUYziiqAUauZPWo3z0a9D9wLa84iKS9yy7CMp4/a/s7KitWXinpi5whwBLu/gVsPlDp64Jv4ks4Wk59UVBEr2mNEeEXORvb85YGETGB7edKIrQWjwhKeJOCIBuOSAr8SvGTwD9tnZn/6sdYg0nN7Q6a75hJXvg1zK9/6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 07:07:02.4388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df8c04f4-dd15-4c23-3d73-08d60346de38
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4330
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are cortex-r5 processors in Xilinx Zynq UltraScale+
MPSoC platforms. This remoteproc driver is to manage the
R5 processors.

Signed-off-by: Wendy Liang <jliang@xilinx.com>
---
 drivers/remoteproc/Kconfig                |   9 +
 drivers/remoteproc/Makefile               |   1 +
 drivers/remoteproc/zynqmp_r5_remoteproc.c | 692 ++++++++++++++++++++++++++++++
 3 files changed, 702 insertions(+)
 create mode 100644 drivers/remoteproc/zynqmp_r5_remoteproc.c

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index cd1c168..83aac63 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -158,6 +158,15 @@ config ST_REMOTEPROC
 config ST_SLIM_REMOTEPROC
 	tristate
 
+config ZYNQMP_R5_REMOTEPROC
+	tristate "ZynqMP_r5 remoteproc support"
+	depends on ARM64 && PM && ARCH_ZYNQMP
+	select RPMSG_VIRTIO
+	select ZYNQMP_FIRMWARE
+	help
+	  Say y here to support ZynqMP R5 remote processors via the remote
+	  processor framework.
+
 endif # REMOTEPROC
 
 endmenu
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 02627ed..147923c 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -23,3 +23,4 @@ qcom_wcnss_pil-y			+= qcom_wcnss.o
 qcom_wcnss_pil-y			+= qcom_wcnss_iris.o
 obj-$(CONFIG_ST_REMOTEPROC)		+= st_remoteproc.o
 obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+= st_slim_rproc.o
+obj-$(CONFIG_ZYNQMP_R5_REMOTEPROC)	+= zynqmp_r5_remoteproc.o
diff --git a/drivers/remoteproc/zynqmp_r5_remoteproc.c b/drivers/remoteproc/zynqmp_r5_remoteproc.c
new file mode 100644
index 0000000..7fc3718
--- /dev/null
+++ b/drivers/remoteproc/zynqmp_r5_remoteproc.c
@@ -0,0 +1,692 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Zynq R5 Remote Processor driver
+ *
+ * Copyright (C) 2015 Xilinx, Inc.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/remoteproc.h>
+#include <linux/interrupt.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/slab.h>
+#include <linux/cpu.h>
+#include <linux/delay.h>
+#include <linux/list.h>
+#include <linux/genalloc.h>
+#include <linux/pfn.h>
+#include <linux/idr.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+
+#include "remoteproc_internal.h"
+
+/* IPI reg offsets */
+#define TRIG_OFFSET		0x00000000
+#define OBS_OFFSET		0x00000004
+#define ISR_OFFSET		0x00000010
+#define IMR_OFFSET		0x00000014
+#define IER_OFFSET		0x00000018
+#define IDR_OFFSET		0x0000001C
+#define IPI_ALL_MASK		0x0F0F0301
+
+/* RPU IPI mask */
+#define RPU_IPI_INIT_MASK	0x00000100
+#define RPU_IPI_MASK(n)		(RPU_IPI_INIT_MASK << (n))
+#define RPU_0_IPI_MASK		RPU_IPI_MASK(0)
+#define RPU_1_IPI_MASK		RPU_IPI_MASK(1)
+
+/* PM proc states */
+#define PM_PROC_STATE_ACTIVE 1u
+
+/* Maximum TCM power nodes IDs */
+#define MAX_TCM_PNODES 4
+
+/* Register access macros */
+#define reg_read(base, reg) \
+	readl(((void __iomem *)(base)) + (reg))
+#define reg_write(base, reg, val) \
+	writel((val), ((void __iomem *)(base)) + (reg))
+
+#define DEFAULT_FIRMWARE_NAME	"rproc-rpu-fw"
+
+static bool autoboot __read_mostly;
+
+struct zynqmp_r5_rproc_pdata;
+
+/**
+ * struct zynqmp_r5_rproc_pdata - zynqmp rpu remote processor instance state
+ * @rproc: rproc handle
+ * @workqueue: workqueue for the RPU remoteproc
+ * @ipi_base: virt ptr to IPI channel address registers for APU
+ * @rpu_mode: RPU core configuration
+ * @rpu_id: RPU CPU id
+ * @rpu_pnode_id: RPU CPU power domain id
+ * @mem_pools: list of gen_pool for firmware mmio_sram memory and their
+ *             power domain IDs
+ * @mems: list of rproc_mem_entries for firmware
+ * @irq: IRQ number
+ * @ipi_dest_mask: IPI destination mask for the IPI channel
+ */
+struct zynqmp_r5_rproc_pdata {
+	struct rproc *rproc;
+	struct work_struct workqueue;
+	void __iomem *ipi_base;
+	enum rpu_oper_mode rpu_mode;
+	struct list_head mems;
+	u32 ipi_dest_mask;
+	u32 rpu_id;
+	u32 rpu_pnode_id;
+	int irq;
+	u32 tcm_pnode_id[MAX_TCM_PNODES];
+};
+
+/**
+ * r5_boot_addr_config - configure the boot address of R5
+ * @pdata: platform data
+ * @bootmem: boot from LOVEC or HIVEC
+ *
+ * This function will set the RPU boot address
+ */
+static void r5_boot_addr_config(struct zynqmp_r5_rproc_pdata *pdata,
+				enum rpu_boot_mem bootmem)
+{
+	const struct zynqmp_eemi_ops *eemi = zynqmp_pm_get_eemi_ops();
+
+	pr_debug("%s: R5 ID: %d, boot_dev %d\n",
+		 __func__, pdata->rpu_id, bootmem);
+
+	if (!eemi || !eemi->ioctl) {
+		pr_err("%s: no eemi ioctl operation.\n", __func__);
+		return;
+	}
+	eemi->ioctl(pdata->rpu_pnode_id, IOCTL_RPU_BOOT_ADDR_CONFIG,
+		    bootmem, 0, NULL);
+}
+
+/**
+ * r5_mode_config - configure R5 operation mode
+ * @pdata: platform data
+ *
+ * configure R5 to split mode or lockstep mode
+ * based on the platform data.
+ */
+static void r5_mode_config(struct zynqmp_r5_rproc_pdata *pdata)
+{
+	const struct zynqmp_eemi_ops *eemi = zynqmp_pm_get_eemi_ops();
+
+	pr_debug("%s: mode: %d\n", __func__, pdata->rpu_mode);
+
+	if (!eemi || !eemi->ioctl) {
+		pr_err("%s: no eemi ioctl operation.\n", __func__);
+		return;
+	}
+	eemi->ioctl(pdata->rpu_pnode_id, IOCTL_SET_RPU_OPER_MODE,
+		    pdata->rpu_mode, 0, NULL);
+}
+
+/**
+ * r5_release_tcm() - release TCM
+ * @pdata: platform data
+ *
+ * Release TCM
+ */
+static void r5_release_tcm(struct zynqmp_r5_rproc_pdata *pdata)
+{
+	const struct zynqmp_eemi_ops *eemi = zynqmp_pm_get_eemi_ops();
+	int i;
+
+	if (!eemi || !eemi->release_node) {
+		pr_err("Failed to release TCM\n");
+		return;
+	}
+
+	for (i = 0; i < MAX_TCM_PNODES; i++) {
+		if (pdata->tcm_pnode_id[i] != 0)
+			eemi->release_node(pdata->tcm_pnode_id[i]);
+	}
+}
+
+/**
+ * disable_ipi - disable IPI
+ * @pdata: platform data
+ *
+ * Disable IPI interrupt
+ */
+static inline void disable_ipi(struct zynqmp_r5_rproc_pdata *pdata)
+{
+	/* Disable R5 IPI interrupt */
+	if (pdata->ipi_base)
+		reg_write(pdata->ipi_base, IDR_OFFSET, pdata->ipi_dest_mask);
+}
+
+/**
+ * enable_ipi - enable IPI
+ * @pdata: platform data
+ *
+ * Enable IPI interrupt
+ */
+static inline void enable_ipi(struct zynqmp_r5_rproc_pdata *pdata)
+{
+	/* Enable R5 IPI interrupt */
+	if (pdata->ipi_base)
+		reg_write(pdata->ipi_base, IER_OFFSET, pdata->ipi_dest_mask);
+}
+
+/**
+ * event_notified_idr_cb - event notified idr callback
+ * @id: idr id
+ * @ptr: pointer to idr private data
+ * @data: data passed to idr_for_each callback
+ *
+ * Pass notification to remoteproc virtio
+ *
+ * @return: 0. having return is to satisfy the idr_for_each() function
+ *          pointer input argument requirement.
+ */
+static int event_notified_idr_cb(int id, void *ptr, void *data)
+{
+	struct rproc *rproc = data;
+
+	(void)rproc_vq_interrupt(rproc, id);
+	return 0;
+}
+
+static void handle_event_notified(struct work_struct *work)
+{
+	struct rproc *rproc;
+	struct zynqmp_r5_rproc_pdata *local;
+
+	local = container_of(work, struct zynqmp_r5_rproc_pdata, workqueue);
+	rproc = local->rproc;
+	idr_for_each(&rproc->notifyids, event_notified_idr_cb, rproc);
+}
+
+static int zynqmp_r5_rproc_start(struct rproc *rproc)
+{
+	struct device *dev = rproc->dev.parent;
+	struct zynqmp_r5_rproc_pdata *local = rproc->priv;
+	enum rpu_boot_mem bootmem;
+	const struct zynqmp_eemi_ops *eemi = zynqmp_pm_get_eemi_ops();
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	if (!eemi || !eemi->force_powerdown ||
+	    !eemi->request_wakeup) {
+		pr_err("Failed to start R5\n");
+		return -ENXIO;
+	}
+
+	/* Set up R5 */
+	if ((rproc->bootaddr & 0xF0000000) == 0xF0000000)
+		bootmem = PM_RPU_BOOTMEM_HIVEC;
+	else
+		bootmem = PM_RPU_BOOTMEM_LOVEC;
+	dev_info(dev, "RPU boot from %s.",
+		 bootmem == PM_RPU_BOOTMEM_HIVEC ? "OCM" : "TCM");
+
+	r5_mode_config(local);
+	eemi->force_powerdown(local->rpu_pnode_id,
+			      ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+	r5_boot_addr_config(local, bootmem);
+	/* Add delay before release from halt and reset */
+	usleep_range(400, 500);
+	eemi->request_wakeup(local->rpu_pnode_id,
+			     1, bootmem,
+			     ZYNQMP_PM_REQUEST_ACK_NO);
+
+	/* Make sure IPI is enabled */
+	enable_ipi(local);
+
+	return 0;
+}
+
+/* kick a firmware */
+static void zynqmp_r5_rproc_kick(struct rproc *rproc, int vqid)
+{
+	struct device *dev = rproc->dev.parent;
+	struct zynqmp_r5_rproc_pdata *local = rproc->priv;
+
+	dev_dbg(dev, "KICK Firmware to start send messages vqid %d\n", vqid);
+
+	/*
+	 * send irq to R5 firmware
+	 * Currently vqid is not used because we only got one.
+	 */
+	if (local->ipi_base)
+		reg_write(local->ipi_base, TRIG_OFFSET, local->ipi_dest_mask);
+}
+
+/* power off the remote processor */
+static int zynqmp_r5_rproc_stop(struct rproc *rproc)
+{
+	struct device *dev = rproc->dev.parent;
+	struct zynqmp_r5_rproc_pdata *local = rproc->priv;
+	struct rproc_mem_entry *mem, *nmem;
+	const struct zynqmp_eemi_ops *eemi = zynqmp_pm_get_eemi_ops();
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	if (!eemi || !eemi->force_powerdown) {
+		pr_err("Failed to stop R5\n");
+		return -ENXIO;
+	}
+
+	disable_ipi(local);
+	eemi->force_powerdown(local->rpu_pnode_id,
+			      ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+
+	return 0;
+}
+
+static void *zynqmp_r5_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
+{
+	struct rproc_mem_entry *mem;
+	void *va = NULL;
+	struct zynqmp_r5_rproc_pdata *local = rproc->priv;
+
+	list_for_each_entry(mem, &local->mems, node) {
+		int offset = da - mem->da;
+
+		/* try next carveout if da is too small */
+		if (offset < 0)
+			continue;
+
+		/* try next carveout if da is too large */
+		if (offset + len > mem->len)
+			continue;
+
+		va = mem->va + offset;
+
+		break;
+	}
+	return va;
+}
+
+static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct firmware *fw)
+{
+	int ret;
+
+	ret = rproc_elf_load_rsc_table(rproc, fw);
+	if (ret == -EINVAL)
+		/* No resource table */
+		return 0;
+	else
+		return ret;
+}
+
+static struct rproc_ops zynqmp_r5_rproc_ops = {
+	.start		= zynqmp_r5_rproc_start,
+	.stop		= zynqmp_r5_rproc_stop,
+	.kick		= zynqmp_r5_rproc_kick,
+	.da_to_va       = zynqmp_r5_rproc_da_to_va,
+};
+
+/* Release R5 from reset and make it halted.
+ * In case the firmware uses TCM, in order to load firmware to TCM,
+ * will need to release R5 from reset and stay in halted state.
+ */
+static int zynqmp_r5_rproc_init(struct rproc *rproc)
+{
+	struct device *dev = rproc->dev.parent;
+	struct zynqmp_r5_rproc_pdata *local = rproc->priv;
+
+	dev_dbg(dev, "%s\n", __func__);
+	enable_ipi(local);
+	return 0;
+}
+
+static irqreturn_t r5_remoteproc_interrupt(int irq, void *dev_id)
+{
+	struct device *dev = dev_id;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct rproc *rproc = platform_get_drvdata(pdev);
+	struct zynqmp_r5_rproc_pdata *local = rproc->priv;
+	u32 ipi_reg;
+
+	/* Check if there is a kick from R5 */
+	ipi_reg = reg_read(local->ipi_base, ISR_OFFSET);
+	if (!(ipi_reg & local->ipi_dest_mask))
+		return IRQ_NONE;
+
+	dev_dbg(dev, "KICK Linux because of pending message(irq%d)\n", irq);
+	reg_write(local->ipi_base, ISR_OFFSET, local->ipi_dest_mask);
+	schedule_work(&local->workqueue);
+
+	return IRQ_HANDLED;
+}
+
+/* zynqmp_r5_get_tcm_memories() - get tcm memories
+ * @pdev: pointer to the platform device
+ * @pdata: pointer to the remoteproc private data
+ *
+ * Function to create remoteproc memory entries for TCM memories.
+ */
+static int zynqmp_r5_get_tcms(struct platform_device *pdev,
+			      struct zynqmp_r5_rproc_pdata *pdata)
+{
+	static const char * const mem_names[] = {"tcm_a", "tcm_b"};
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	int num_mems = 0;
+	int i, ret;
+	struct property *prop;
+	const __be32 *cur;
+	u32 val;
+	const struct zynqmp_eemi_ops *eemi = zynqmp_pm_get_eemi_ops();
+
+	/* Get TCM power node ids */
+	i = 0;
+	of_property_for_each_u32(np, "tcm-pnode-id", prop, cur, val)
+		pdata->tcm_pnode_id[i++] = val;
+
+	/* Request TCMs */
+	for (i = 0; i < MAX_TCM_PNODES; i++) {
+		if (pdata->tcm_pnode_id[i] != 0) {
+			ret = eemi->request_node(pdata->tcm_pnode_id[i],
+						 ZYNQMP_PM_CAPABILITY_ACCESS, 0,
+						 ZYNQMP_PM_REQUEST_ACK_BLOCKING
+						);
+			if (ret < 0) {
+				dev_err(dev, "failed to request TCM: %u\n",
+					pdata->tcm_pnode_id[i]);
+				return ret;
+			}
+			dev_dbg(dev, "request tcm pnode: %u\n",
+				pdata->tcm_pnode_id[i]);
+		} else {
+			break;
+		}
+	}
+	/* Create remoteproc memories entries for TCM memories */
+	num_mems = ARRAY_SIZE(mem_names);
+	for (i = 0; i < num_mems; i++) {
+		struct resource *res;
+		struct rproc_mem_entry *mem;
+		dma_addr_t dma;
+		resource_size_t size;
+
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   mem_names[i]);
+		mem  = devm_kzalloc(dev, sizeof(struct rproc_mem_entry),
+				    GFP_KERNEL);
+		if (!mem)
+			return -ENOMEM;
+		/* Map it as normal memory */
+		size = resource_size(res);
+		mem->va = devm_ioremap_wc(dev, res->start, size);
+		mem->len = size;
+		dma = (dma_addr_t)res->start;
+		mem->dma = dma;
+		/* TCM memory:
+		 *   TCM_0: da 0 <-> global addr 0xFFE00000
+		 *   TCM_1: da 0 <-> global addr 0xFFE90000
+		 */
+		if ((dma & 0xFFF00000) == 0xFFE00000) {
+			if ((dma & 0xFFF80000) == 0xFFE80000)
+				mem->da -= 0x90000;
+			else
+				mem->da = (dma & 0x000FFFFF);
+		}
+		dev_dbg(dev, "%s: va = %p, da = 0x%x dma = 0x%llx\n",
+			__func__, mem->va, mem->da, mem->dma);
+		list_add_tail(&mem->node, &pdata->mems);
+	}
+	return 0;
+}
+
+/* zynqmp_r5_get_reserved_mems() - get reserved memories
+ * @pdev: pointer to the platform device
+ * @pdata: pointer to the remoteproc private data
+ *
+ * Function to create remoteproc memory entries from memory-region
+ * property.
+ */
+static int zynqmp_r5_get_reserved_mems(struct platform_device *pdev,
+				       struct zynqmp_r5_rproc_pdata *pdata)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	int num_mems;
+	int i;
+
+	num_mems = of_count_phandle_with_args(np, "memory-region", NULL);
+	if (num_mems <= 0)
+		return 0;
+	for (i = 0; i < num_mems; i++) {
+		struct device_node *node;
+		struct resource res;
+		resource_size_t size;
+		struct rproc_mem_entry *mem;
+		int ret;
+
+		node = of_parse_phandle(np, "memory-region", i);
+		ret = of_device_is_compatible(node, "rproc-prog-memory");
+		if (!ret) {
+			/* it is DMA memory. */
+			dev_info(dev, "%s, dma memory %d\n", __func__, i);
+			ret = of_reserved_mem_device_init_by_idx(dev,
+								 np, i);
+			if (ret) {
+				dev_err(dev, "unable to reserve DMA mem.\n");
+				return ret;
+			}
+			continue;
+		}
+		ret = of_address_to_resource(node, 0, &res);
+		if (ret) {
+			dev_err(dev, "unable to resolve memory region.\n");
+			return ret;
+		}
+		mem  = devm_kzalloc(dev, sizeof(struct rproc_mem_entry),
+				    GFP_KERNEL);
+		if (!mem)
+			return -ENOMEM;
+		/* Map it as normal memory */
+		size = resource_size(&res);
+		mem->va = devm_ioremap_wc(dev, res.start, size);
+		mem->len = size;
+		mem->dma = (dma_addr_t)res.start;
+		mem->da = (u32)res.start;
+		dev_dbg(dev, "%s: va = %p, da = 0x%x dma = 0x%llx\n",
+			__func__, mem->va, mem->da, mem->dma);
+		list_add_tail(&mem->node, &pdata->mems);
+	}
+	return 0;
+}
+
+static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
+{
+	const unsigned char *prop;
+	struct resource *res;
+	int ret = 0;
+	struct zynqmp_r5_rproc_pdata *local;
+	struct rproc *rproc;
+
+	rproc = rproc_alloc(&pdev->dev, dev_name(&pdev->dev),
+			    &zynqmp_r5_rproc_ops, NULL,
+		sizeof(struct zynqmp_r5_rproc_pdata));
+	if (!rproc) {
+		dev_err(&pdev->dev, "rproc allocation failed\n");
+		return -ENOMEM;
+	}
+	local = rproc->priv;
+	local->rproc = rproc;
+
+	platform_set_drvdata(pdev, rproc);
+
+	/* Override parse_fw op to allow no resource table firmware */
+	rproc->ops->parse_fw = zynqmp_r5_parse_fw;
+
+	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(&pdev->dev, "dma_set_coherent_mask: %d\n", ret);
+		goto rproc_fault;
+	}
+
+	/* Get the RPU power domain id */
+	ret = of_property_read_u32(pdev->dev.of_node, "rpu-pnode-id",
+				   &local->rpu_pnode_id);
+	if (ret) {
+		dev_err(&pdev->dev, "No RPU power node ID is specified.\n");
+		ret = -EINVAL;
+		goto rproc_fault;
+	}
+	dev_dbg(&pdev->dev, "RPU[%d] pnode_id = %d.\n",
+		local->rpu_id, local->rpu_pnode_id);
+
+	prop = of_get_property(pdev->dev.of_node, "core_conf", NULL);
+	if (!prop) {
+		dev_warn(&pdev->dev, "default core_conf used: lock-step\n");
+		prop = "lock-step";
+	}
+
+	dev_info(&pdev->dev, "RPU core_conf: %s\n", prop);
+	if (!strcmp(prop, "split0")) {
+		local->rpu_mode = PM_RPU_MODE_SPLIT;
+		local->rpu_id = 0;
+		local->ipi_dest_mask = RPU_0_IPI_MASK;
+	} else if (!strcmp(prop, "split1")) {
+		local->rpu_mode = PM_RPU_MODE_SPLIT;
+		local->rpu_id = 1;
+		local->ipi_dest_mask = RPU_1_IPI_MASK;
+	} else if (!strcmp(prop, "lock-step")) {
+		local->rpu_mode = PM_RPU_MODE_LOCKSTEP;
+		local->rpu_id = 0;
+		local->ipi_dest_mask = RPU_0_IPI_MASK;
+	} else {
+		dev_err(&pdev->dev, "Invalid core_conf mode provided - %s , %d\n",
+			prop, local->rpu_mode);
+		ret = -EINVAL;
+		goto rproc_fault;
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ipi");
+	if (res) {
+		local->ipi_base = devm_ioremap(&pdev->dev, res->start,
+					       resource_size(res));
+		if (IS_ERR(local->ipi_base)) {
+			pr_err("%s: Unable to map IPI\n", __func__);
+			ret = PTR_ERR(local->ipi_base);
+			goto rproc_fault;
+		}
+	} else {
+		dev_info(&pdev->dev, "IPI resource is not specified.\n");
+	}
+	dev_dbg(&pdev->dev, "got ipi base address\n");
+
+	INIT_LIST_HEAD(&local->mems);
+	/* Get TCM memories */
+	ret = zynqmp_r5_get_tcms(pdev, local);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to get TCM memories.\n");
+		goto rproc_fault;
+	}
+	dev_dbg(&pdev->dev, "got TCM memories\n");
+	/* Get reserved memory regions for firmware */
+	ret = zynqmp_r5_get_reserved_mems(pdev, local);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to get reserved memories.\n");
+		goto rproc_fault;
+	}
+	dev_dbg(&pdev->dev, "got reserved memories.\n");
+
+	/* Disable IPI before requesting IPI IRQ */
+	disable_ipi(local);
+	INIT_WORK(&local->workqueue, handle_event_notified);
+
+	/* IPI IRQ */
+	if (local->ipi_base) {
+		ret = platform_get_irq(pdev, 0);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "unable to find IPI IRQ\n");
+			goto rproc_fault;
+		}
+		local->irq = ret;
+		ret = devm_request_irq(&pdev->dev, local->irq,
+				       r5_remoteproc_interrupt, IRQF_SHARED,
+				       dev_name(&pdev->dev), &pdev->dev);
+		if (ret) {
+			dev_err(&pdev->dev, "IRQ %d already allocated\n",
+				local->irq);
+			goto rproc_fault;
+		}
+		dev_dbg(&pdev->dev, "notification irq: %d\n", local->irq);
+	}
+
+	ret = zynqmp_r5_rproc_init(local->rproc);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to init ZynqMP R5 rproc\n");
+		goto rproc_fault;
+	}
+
+	rproc->auto_boot = autoboot;
+
+	ret = rproc_add(local->rproc);
+	if (ret) {
+		dev_err(&pdev->dev, "rproc registration failed\n");
+		goto rproc_fault;
+	}
+
+	return ret;
+
+rproc_fault:
+	rproc_free(local->rproc);
+
+	return ret;
+}
+
+static int zynqmp_r5_remoteproc_remove(struct platform_device *pdev)
+{
+	struct rproc *rproc = platform_get_drvdata(pdev);
+	struct zynqmp_r5_rproc_pdata *local = rproc->priv;
+	struct rproc_mem_entry *mem;
+
+	dev_info(&pdev->dev, "%s\n", __func__);
+
+	rproc_del(rproc);
+
+	list_for_each_entry(mem, &local->mems, node) {
+		if (mem->priv)
+			gen_pool_free((struct gen_pool *)mem->priv,
+				      (unsigned long)mem->va, mem->len);
+	}
+
+	r5_release_tcm(local);
+	of_reserved_mem_device_release(&pdev->dev);
+	rproc_free(rproc);
+
+	return 0;
+}
+
+/* Match table for OF platform binding */
+static const struct of_device_id zynqmp_r5_remoteproc_match[] = {
+	{ .compatible = "xlnx,zynqmp-r5-remoteproc-1.0", },
+	{ /* end of list */ },
+};
+MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
+
+static struct platform_driver zynqmp_r5_remoteproc_driver = {
+	.probe = zynqmp_r5_remoteproc_probe,
+	.remove = zynqmp_r5_remoteproc_remove,
+	.driver = {
+		.name = "zynqmp_r5_remoteproc",
+		.of_match_table = zynqmp_r5_remoteproc_match,
+	},
+};
+module_platform_driver(zynqmp_r5_remoteproc_driver);
+
+module_param_named(autoboot,  autoboot, bool, 0444);
+MODULE_PARM_DESC(autoboot,
+		 "enable | disable autoboot. (default: true)");
+
+MODULE_AUTHOR("Jason Wu <j.wu@xilinx.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ZynqMP R5 remote processor control driver");
-- 
2.7.4

