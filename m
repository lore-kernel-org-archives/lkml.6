Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6E5C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8142A2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="vZx7uuCT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8142A2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbeJ2U7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 16:59:21 -0400
Received: from mail-eopbgr730055.outbound.protection.outlook.com ([40.107.73.55]:8753
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728416AbeJ2U7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 16:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PcMffk8sAvM3kGc38Xs4hB/MzfCsi5M5xl2Qz2C9XA=;
 b=vZx7uuCTU/PI2ob+/QvRIz1LM0rwnwMw6JOYjKkby0o/nyMTzQvqAdUE8/giwqv3zo7TXeueigxroroCYPPKYgL1+82aq6CZsPRm3zAhmYJ4JU8cbcMUdPUdt1LZXhsODb4ItOwp0kNrUEh+JfbcZZ0B46uunG4bB/NcVVr7d+U=
Received: from MWHPR02CA0008.namprd02.prod.outlook.com (2603:10b6:300:4b::18)
 by SN4PR0201MB3519.namprd02.prod.outlook.com (2603:10b6:803:44::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.27; Mon, 29 Oct
 2018 12:10:50 +0000
Received: from BL2NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by MWHPR02CA0008.outlook.office365.com
 (2603:10b6:300:4b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.19 via Frontend
 Transport; Mon, 29 Oct 2018 12:10:49 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT009.mail.protection.outlook.com (10.152.77.68) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Mon, 29 Oct 2018 12:10:49 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:57545 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gH6Nc-0004m9-Gg; Mon, 29 Oct 2018 05:10:48 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gH6NX-0007jh-D6; Mon, 29 Oct 2018 05:10:43 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9TCAfSg007788;
        Mon, 29 Oct 2018 05:10:41 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1gH6NV-0007j4-4n; Mon, 29 Oct 2018 05:10:41 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 3512C12147A; Mon, 29 Oct 2018 17:40:40 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <manish.narani@xilinx.com>,
        <amit.kucheria@linaro.org>, <sudeep.holla@arm.com>,
        <olof@lixom.net>, <broonie@kernel.org>, <arnaud.pouliquen@st.com>,
        <eugen.hristev@microchip.com>, <linus.walleij@linaro.org>,
        <vilhelm.gray@gmail.com>, <geert@linux-m68k.org>,
        <freeman.liu@spreadtrum.com>, <rdunlap@infradead.org>,
        <tglx@linutronix.de>, <baolin.wang@linaro.org>,
        <gregkh@linuxfoundation.org>, <jdelvare@suse.com>,
        <linux@roeck-us.net>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
Subject: [PATCH v3 0/3] Add Xilinx AMS Driver
Date:   Mon, 29 Oct 2018 17:40:23 +0530
Message-ID: <1540815026-1012-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(396003)(39860400002)(136003)(376002)(346002)(2980300002)(438002)(199004)(189003)(36386004)(90966002)(426003)(486006)(336012)(47776003)(51416003)(39060400002)(72206003)(316002)(14444005)(5660300001)(478600001)(103686004)(16586007)(26005)(186003)(42186006)(110136005)(54906003)(2906002)(6266002)(126002)(4326008)(2616005)(476003)(106002)(44832011)(7416002)(36756003)(50466002)(50226002)(48376002)(81156014)(63266004)(8676002)(305945005)(52956003)(6666004)(8936002)(106466001)(2201001)(81166006)(356004)(921003)(107986001)(2101003)(83996005)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3519;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT009;1:ybr3WdxlLF8Pm/0Z7TeTXzRVz4XQF1m3M/WOyC1xK66HhhhrT4iOFedtYr+A4Vol25zpQq474floGi3mrxL0a9RhFuj1YzARodtpysmwI9s1fL8kEAKMOZ5qfshRTwWm
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcea5f25-1e44-4fa1-62a1-08d63d979080
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN4PR0201MB3519;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3519;3:vFccY6djZMOBa4KAL8N7W+iBzOc/Bvj2JkvsCabHsMUEfhKSVEUyaeafSlEWZUzGMdNcMHjUe1uKHnEd0rGkNozG0eO6bRtA+Irt+gIr4tIYJKW2XPWDWBX7zYu5TX26gSWNt0InHBep9BCn9i4/Rps8r0agCbsEgxFDTFpPaR7JRGGQC29BmV6xCjS8T7FqCN1LfLJYYFz/XJKqgnMZotbXtfL71TwAZC8rsTn293L2OeL/wuSJssY9EReEn2pS5lOXIpO0zOedzlpbeSk6xhdOMrZg2p//eM2HnpjC9XKUGFWBL7545SxUV+T8mA+rKlw0qzmtHnLN4hyqztfetfBaJLZm5nzKaYEkmS1UoZQ=;25:kfbv5jaEhFoKmVu89sNygyas0qopNRmvmyt9sks/iynNmOszbO9lpaKvgRdpHgA5oeJvXMewXz3xrEsK9Kzmt8WcbcAgR2p7K1ZWuRPkMcKpTF69pA3j7hkZkQsN2YSFFUjhnZ7pcTFqtQBV2eDCqqi9rD54tNeHnbpxXE9pKcpwaRSExjyTesc0bazQrtmPDs1pmL5n6rqn6EFkunqUoGkI1r2/ZwzJxWQdJDnbAS9joO4DgreTWkLCF7SUJstS9q3FComFOHgl4YEfyNMu9wm3xV3oAAguAhEF9pwSRgiINZiLXucLXknxaPKu9ctSC5HCxUJMWGG62DUpTVHsGm4GRqAxplb7NogRHj2atTo=
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3519:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3519;31:LJBgnePBfAkwlvmCyrdaKw5LnE0rdsASK4YqFwFPMehqrhhZOlnvVJHFj6vuIi+CWe6w9+YuJ7NBxGHO3wnXX1Rx0+WTYZZ7aWurMMsiwjUJPtbflqYL6bunwcbHj8Rw37EWh3MEpUFmeSt3jtqsQPCvQDSiTGC18gHHf8UfgbTB2JGRISgEwpTNbNL0lKrsHBJV0RQwc8yDK3G4G1PIx/BIfg+fv30mbrWzwmRhNnY=;20:wQo6Xl9Tjq8FstKLx0HgBPRTw9lTZ4zmzxqLlaTsmhplBI8tfSBC2TufQDBu4iw2U9Gfcr7FeWTootHeFN2CePllGAvK5Vd5i6DdM/S7imHKpaT+nM9W4sA4tdXV6J8KbJkPMJInR0Va8lR9pHaurdK3s6Pik4SIDS+G25jQ0+ZvX9J+DnJmeSnF5N+Q2uhOLtGRa7kqvJhcgAa6FlT2MvtxJ7AJZeN6llvmc4D3n+00NhM4F9ngeL+ps1qpoIgbk18kZG+BPSJne2SptoGWYnTVcqZnpMLx2GUzgpl6E1cMz4OB0fImfBVGErPiVJweZ4j5GU3XF63PCjjBHYCjJLCijFdDsYFhNlU/aXuvDCsZxzcHjCBrUSD4FoPtWRUgxbVGukKxsVdHbZZWb4RJMKhwP706xmKSHPlA2dyp3+tfLte+oe+a4idvCUWBlJskwTx4Fi67dFvuryac4POMJvEKIYkFoEq/+RzRqj2Hx1Gsd2fr/PqpJkebXafNZHLp
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN4PR0201MB3519E607BA3F0C65DCEE8D96C1F30@SN4PR0201MB3519.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN4PR0201MB3519;BCL:0;PCL:0;RULEID:;SRVR:SN4PR0201MB3519;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3519;4:2m72kNQrpIaUlomgVDdaYuCmy5utrNveJ8M+NshqM1xUxdaJC+/sxjZH3D/hMzWtTVM6m8zGyYi20m1oWaxPC2YP1emo9MTvmVeMUZG4ipzVU2DeptgU8wGKdBXdlxNabeAJpMXe2BGZqyqrMQ5FClyLRMAeAkK517n5aQwFjU1xWBPxb55rRJxk5uneCLQ7gKU9mLFs5afLpSuaypQoa7fk2KNnRAiezlUEdpmIXST12DbGsfT6A8Tes/uwSwLJa8izmL7WtIriWtM0QuzvwA==
X-Forefront-PRVS: 084080FC15
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0201MB3519;23:7pY5vnfF0wfRBQtaUAehJElZSOPn7zrBEPUUbfn?=
 =?us-ascii?Q?16j8QpGKs/w91+RvvCAUFZlMCqIy7spuFVLL6M5BwL0NAGx10GKSaIeW+t1N?=
 =?us-ascii?Q?XfDFc7PZXZR00zRcA6/UZcnvvKBs0H3yWrXIfk9s3Ng9xCLFv5hLMjpBkNfR?=
 =?us-ascii?Q?HCS7eoVBjg7BEc68/8GHe3+T6srgY/5Jig59zwWIb1+e+aUyiSoWDLgzeMo0?=
 =?us-ascii?Q?2eeQrKCywzzCpn9Kamfj+Ae1CzYsFr7yPY69YBMWG24vRVAACQyTm8meyFFd?=
 =?us-ascii?Q?xPe/J88l5/5oIkFzJDbjxO4w/2XUSYCiHHLiacwR8tNNMt4uL9SN+TrcidU/?=
 =?us-ascii?Q?tQooySfTMzLNOSaRXmNMCFb3/8DAojvTXJgfjlfZCffWjDuJvxaOTVuvCkNT?=
 =?us-ascii?Q?g9zodonxrY5NYYzn8875vpMB81H4LgMWrcYtrMJ6VjaJCeancY3xoz0NFINA?=
 =?us-ascii?Q?nbeIm57P3Valpyf3sUwxB69DO4LNg+LUJNzs3W+5lOmjfrW5806RpgY+1mbz?=
 =?us-ascii?Q?TbS2ELunxmkrvDNKmSVmI7D2eFC2GaUc47MCN7ZVEVUtofTvf4VyFPfIB5sH?=
 =?us-ascii?Q?uuSb69nrcpOUf9nRbKK5a3UjZzYEk8e4DaVPGOeTTxG8lhznnDqTEHKE9dKv?=
 =?us-ascii?Q?9bkSxTwIASMFG3k+HKG9shqJYNn4NGtFIOhrJZEjYzm+J+uQ93qNt4ShFp6s?=
 =?us-ascii?Q?YjLiknzxfY69EN8tY8u1qFG+C7GkDg6Ibgtd5rvv3jMXhOEI2545zyHBEdiq?=
 =?us-ascii?Q?dR8NC7ES+jugSf7MF8yrjppB0WxwIYX3QHj4Foear50g6fEEJfduddvfQGp3?=
 =?us-ascii?Q?Ooz/UoD13+TydEDJ3kvEkr4+7inxXRbcnKUdHflxdUS1hZ3wOFr30AbL8uys?=
 =?us-ascii?Q?uLVCnHtd5WCR/dzzx2aPqN3+yBcwkxRZkLV2UwEJvjlqMtGdYWHvysavtDYY?=
 =?us-ascii?Q?PFgoErIoO9TGk1h1N1ib2w0a22joISIT5v93F4uiag51+hLqGQkjPNzgG2DG?=
 =?us-ascii?Q?UNIchYsXOnPxHk3Ugcu0rdnu8kRITgZuF6FXBT2+1+fne/1rRDqF5MkVcklA?=
 =?us-ascii?Q?eW3FLulMn2ROF/Pg+BsIsHCFR4MuStTxZTHIFlzV+8khWbMu2V9+C8gstp1z?=
 =?us-ascii?Q?q5yvg//cjwyHGA2FS3HVnJTMlFu0rYWq985yKuAln2e+iZkeocXbTVh53y81?=
 =?us-ascii?Q?okAGv/Bc7SG+blJ+vQFASN5kjhUgFLwT36E7vedKkGRq4bYujIQyMHUnhsWh?=
 =?us-ascii?Q?mk96x8XeJ5rP85vq7y0anarUi+aASlEc/kIH82YCM1apLQF05qc6O50lKPpP?=
 =?us-ascii?Q?AWEm9hySqP4gPVKhT8RToMoeZ9MGVRiVQUZVVT/joGdPc?=
X-Microsoft-Antispam-Message-Info: 9XYS39VpGhIobbi3SeMJMAr2jT2kqriGYXOD65zxdWLxrcwSaKuP0xEZlPLoz8E5pPUeESLj1bDlqgv3NIPhqPZnDevlthGydznoheD/5Z1lfpHPdnSX76c0WdflkfFkCSsirwwaFf5IlBGfRTT9Q5e4V0/pFVD7DylNyebzdUD1Wm9wlUsKKZ1tYzv7gwI0Cf6MMOXv5odbKwKNzFt5eMXKOXJJcD83t79FP2PRpbpVlUG5sDitWU8R8CguFkLuHOduiPYounJfBP3wuVmZ8XnqXZ2KW66Fp103jrrDcktkN3XBQLxdcjOhounA0Ec9WbW5SXkW2CWGNkLrQzt5LDSdmOiN5X5Fk4QNFrELh6M=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3519;6:f3pG2B4oVHiv9XjhY+48NiGNe7Gnik06PgVdVNBrHLw7yqDdv2wPXumbtLtJjldiU2paoVjWV1L+tje+7tWvDlJDfNwVP2CeO1atPMOqRSKSRhxPJWRwZgsdGEUJzDCIpx4EvrXKzBSotwX4jJIoNvW/NkV1pDYySXVWUgBYKLCKfrvI2GZLUgmLA8G6fVnzafF/+xavOiCs10mZNSCS7AsGvWHGiubqssahmIBppdgyDC25TUYQXk/jWq1H8zarrsostGPJtbKc8+CkfIUusnLqy3BDtXbRMNV8irmGagkDjQBGMDwpPyi+VbNBjfV6Jvfo9zxKsmwd86z4DGlEBL9orgRWziM9hu2KKRC6thoHLjnN8c6vNinUkqSbjj2b4/bo7/Zknf/f0Gjo7SmV5jd+Iv2CWccPAF/iXjcJZQRIol9xjbkDQ90dDzL5JPP70IKUrBQQgrFCYBy1yeFEOQ==;5:iXRKZDLuYMQAihtEFETqYtiZOLYPVh1vY2eOIeT9zWJUguRZ9LBZK4OSBjt7rKb2Ws3DNoJOCQhpIVYkoxajOgltp9mS8DlOGe+NSxIWzXhWlniBA4zoPDC1n6wHsgF5wq0dbhd1SfouGmKv/AjPvsU3cQV3tWB1pykL8COD9bg=;7:V1U+7jLtXjzgyASeZSfQu2Gf7eG6GJMOH6NDGLNmhzaDTyThV7nlB1/TtvKP2bkAJh+rcR5xYGK6kHxr9Zg937x/pQZwzYwrVd6q/YxDdPy3NoTZh7CY7+NiTWa1zmNtW09OpuvjE/XEm5mftU4Dxg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2018 12:10:49.1786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcea5f25-1e44-4fa1-62a1-08d63d979080
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3519
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Xilinx AMS driver which is used for Xilinx's ZynqMP AMS controller.
This AMS driver is used to report various interface voltages and temperatures
across the system.
This driver will be used by iio-hwmon to repport voltages and temperatures
across the system by using various channel interfaces.
This driver handles AMS module including PS-Sysmon & PL-Sysmon. The binding
documentation is added for understanding of AMS, PS, PL Sysmon Channels.

Changes in v2:
	- Added documentation for sysfs (Patch-2)
	- Addressed code style review comments
	- Patch-2 (Now it is Patch-3)
		- Arranged the includes in alphabetical order
		- Removed the wrapper 'ams_pl_write_reg()' and used writel
		  instead
		- Removed the unnecessary delay of 1ms and used polling of EOC
		  instead
		- Removed spin_lock and used mutex only.
		- Used request_irq() instead of devm_request_irq() and handled
		  respective error conditions
		- Moved contents of xilinx-ams.h to inline with xilinx-ams.c
	- Patch-1
		- Addressed Documentation style comments

Changes in v3:
	- Updated bindings document with the suggested modification in v2 review
	- Removed documentation for sysfs
	- Removed extended names for channels in the Xilinx AMS driver
	- Modified dts to use ranges for child nodes
	- Reduced address and size cells to 32-bit instead of 64-bit

Manish Narani (3):
  dt-bindings: iio: adc: Add Xilinx AMS binding documentation
  iio: adc: Add Xilinx AMS driver
  arm64: zynqmp: DT: Add Xilinx AMS node

 .../devicetree/bindings/iio/adc/xilinx-ams.txt     |  183 +++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   27 +
 drivers/iio/adc/Kconfig                            |   10 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/xilinx-ams.c                       | 1343 ++++++++++++++++++++
 5 files changed, 1564 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
 create mode 100644 drivers/iio/adc/xilinx-ams.c

-- 
2.1.1

