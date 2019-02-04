Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_FUTURE_24_48,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A00C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 07:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4562083B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 07:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="eusAR+r5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfBCHJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 02:09:43 -0500
Received: from mail-eopbgr800052.outbound.protection.outlook.com ([40.107.80.52]:47472
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbfBCHJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 02:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VPpJWatAVauEfGM00K/2YJ8HXVAzPLhnhrytnyCSx0=;
 b=eusAR+r5q102tlQROpseCm2IsG2YqmGlbK2kekfgEuE6JdO84PB4UztwbOwTa60U4Si7U1Szqedi0+xMC8bD463gonqlcUwaF314npBEAczEWcDJAQOXhR9Txf/BXTtV0kMf2xmB97pCBN1wHZAc1QrtDujT5OWJBDfR/kZRJGo=
Received: from SN4PR0201CA0042.namprd02.prod.outlook.com
 (2603:10b6:803:2e::28) by BL2PR02MB2145.namprd02.prod.outlook.com
 (2a01:111:e400:c74b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.22; Sun, 3 Feb
 2019 07:09:38 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by SN4PR0201CA0042.outlook.office365.com
 (2603:10b6:803:2e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.17 via Frontend
 Transport; Sun, 3 Feb 2019 07:09:37 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Sun, 3 Feb 2019 07:09:37 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:49946 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gqBuK-0008Jl-Rj; Sat, 02 Feb 2019 23:09:36 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gqBuF-0002QL-NA; Sat, 02 Feb 2019 23:09:31 -0800
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1379U9r002044;
        Sat, 2 Feb 2019 23:09:30 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gqBuD-0002P8-C3; Sat, 02 Feb 2019 23:09:29 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <jollys@xilinx.com>, <rajanv@xilinx.com>, <nava.manne@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: nvmem: Add bindings for ZynqMP nvmem driver
Date:   Mon, 4 Feb 2019 12:39:50 +0530
Message-ID: <20190204070951.6933-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190204070951.6933-1-nava.manne@xilinx.com>
References: <20190204070951.6933-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39850400004)(136003)(346002)(2980300002)(189003)(199004)(1076003)(36756003)(16586007)(14444005)(26005)(106466001)(6666004)(356004)(63266004)(77096007)(186003)(7696005)(51416003)(106002)(76176011)(2201001)(110136005)(478600001)(305945005)(47776003)(50466002)(336012)(426003)(81166006)(81156014)(2616005)(126002)(11346002)(446003)(476003)(486006)(48376002)(9786002)(8936002)(8676002)(316002)(2906002)(36386004)(50226002)(107986001)(921003)(2101003)(5001870100001)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR02MB2145;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT057;1:yJBdbDGPDvHJHTXswX1f95lqc7mhKQYAZDbKV+kRjbmXXXpE7lTdcW0Lt1LyPAx8CAUVNANmQBPdWCs/wNe6n9qNToL7rVHE4ycLIZU1pG7wFcDiJi2mPAX9cP4BDY/MPW05BR6e31ysA5AFWEgaGw==
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c6c802a-d605-4f8c-2974-08d689a68efa
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:BL2PR02MB2145;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB2145;3:3EWHxSpS1HICMBSrIKTIa2CvAufPRzXE7M4aIj5lCPxfR2u1biKNwlx8Iv4bYdxfZC4A1kq5mJG4q4yrL/fqrE27EEwQBU+Ve6sxCHuTDb8V9/GDrAysEX2WHPR+tYSp8sTOuB5dbr0Bk013uho1yTeCxJoR3MRCtzSp7LMO+4ziPWcNYPTCo7+l7GED3S9d2E+ZTFd7d/Ake8TJX0b7ewQdpF8vp4jA/vSiptKDDX/UXITFKAtV0Sb7FHuKlRWnvMOAVER5lfUEkcOVEjPu5Ov2RhPsm5Tr/BNN0AsYvzpDvY8KZxZbspgqia93whu3WghP2rYgPyrSXuXNXX+oeLvELYaOP/tL/ULIDQSV5VqhhTxs4b3sQdrd0GQJf4mm;25:e72VyRQu0Z2qUnqtIT4AoeqlPh/Rkb7nNRm43CVpid23hPUpBwXqHrcCuYIQCU4cXJMgoPU0AenoRK6Hdlc43FglMJhax2pM4jo+kBBjIIoq/SyvVAi0nYdocuyhm5U16K/h1AlHZQqiVjIh8k3/QXzUoGGwgnM/LcAs46bEM2LontcNVlPpze/kvxiJHW5Py/rBUeBO6R4mV/4Um4+z2MbmHvBYVxYM0WVTFpR5B3eb50+XBnGb5bwyXNP3K0IaR7Id3cD46yT6ONMIEsxQ9J8C4d7o4dPo3nBWbmUgenjam62sUrh2cz4vFkbyWkYvVqdydj//hw1C1bzq9fdHug==
X-MS-TrafficTypeDiagnostic: BL2PR02MB2145:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB2145;31:0ci2ojIgQQ7o35Yewim/iT8H1OGA/ws/YRV5hQ8WK2PX3iqJQXyQNBZYwVsaJR7434/14QLSLRK4YjlwMqjytRfeX4ZdSJsr/0Afm12iYBlLfcgDWYbfPxoEunjWK9KE//GsTO096ggtdjfgLhaDX7MJ6IciB/kRt264DtIbZtk8L+aAOTVAqZcphQ9DOf3VZOzwhFQ5RlWw7YE8/O5RoioQOpBSrX7G22gtU2W7CMw=;20:ghbIPfNyCAI4ZYY0W2O31ln6sdUw0L4ZMnSqp1XrqsZrWJGW2F3aujq37bC8YBJngdpLyCc3YAMxQOBBMcwoNWol+18G9Sf7c1/E5wdgJoGKzJFsA4SREqxM1fKlHsXPaTWBqMI2IYZZyyTI9u2IsWR39i/6eqTU8aqvYvOjJ6P9zP1dLYG0Tf9zdYwYSsryCI15Df4S8nuieOfDJIlnAVOtrt2XOV3VYA8nVI9pU/xj6raM2M/7Fu/6j49+6A8FUdmXICzzRDpDuJDeK+Ixmni54Z0dPrWD3ipuh5gM+w0sYplQx2IqVfMKssmDSi2wUQgKNiPFYGaNlDpuIHEFh3K4+MKnQoNZEC/RJ78u3xDcyofOh+a/sPjY2HpKWJqjggq8i25yizAWAfSPdWOJwMwz8lHbWFLAN6TKCHw2/2Tb55oYspLgDaD6Y78bEb45MUE50wABlrXh3sRtyaj4JrV2IT6rZaQhaErIFcwGwHpbLPv4AtJpMBSU5QFMFJqq
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL2PR02MB21456F95E31F1FE588242524C26C0@BL2PR02MB2145.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB2145;4:OEWFcN7PVumugTFxGAf1p22QsKDN4FpTVGsO15QDo/HKDvwH6fdaaeAICntZbGPiEcD+mPafu6dEmPGJmhNdhD3nvWMEs8YzhiRuNlzuKrhYWP4yAkoeSorExhOSXKxMgB2oiplLgz5DGRM9UN0UvXiBd51rHnniC650NPD51hxXEEHDlY9px4gkPNqEkFha8swJNhN+Gzt4oY0+NK4wm8eYQy+TXLCVuqSuPMTJmtanVzjemE7S3oPd9a/QVN4z799J/oV2si6oHR2uMBhPZ4dxNGAJzYhnNTyHaqGstQ3lc3552eDEz7HRjKmxa4yh
X-Forefront-PRVS: 0937FB07C5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR02MB2145;23:FEcXl6JhsQtebv21BS851RK5MedJcAmjqnmXv/R3e?=
 =?us-ascii?Q?iizcmYY1gFO4NttKbP/BFlo78shF5X/0ub+6LvghX2OfLF0D92z7VyLjFU5I?=
 =?us-ascii?Q?+Gz9dkfWeFKr3Mjy/KSaeRfVcrR3D19viQFsyZZsfkkk70fDAf/v5YsgLmrn?=
 =?us-ascii?Q?1sRRbz6jvahG+gWxhoD3YSAOSTVixnM6U43GGNrK2or7iOHkXfngy7OLCkOD?=
 =?us-ascii?Q?OSb8HXj2nOo5n8+9bkbSiXzoNMizaPnqBZ2nTHNH0hTBi5+OyBFInDqDPD5Y?=
 =?us-ascii?Q?R9FZbHajvzs4BGnZBBuFCUSd1FBoFWe3hT5YfPUof3SwYBUsaCs3WW+A6oMJ?=
 =?us-ascii?Q?3q7q5iqr+6qJJToA6t8xaGz/AO2U93N/7+B3Af+GrT9cIZKB/7/X62iiXQKf?=
 =?us-ascii?Q?jCZbwkrRYETWZqPjMxiHThogdBGmapWENqejOSE/VrvgNKaFQhxxL2xNd3GB?=
 =?us-ascii?Q?+G7tnHlV85VZMeaolyvT49yWIcKEg/lmV2SMxFQO1S2BtpY0bWZAkdHMfN7Y?=
 =?us-ascii?Q?s1tqgr8hVqhIEvP8i6+/T/kalCRU7Bne5OM3tyKYSZtSIAmLrsThsmD7Y0dC?=
 =?us-ascii?Q?LjnjlG6kr57V/XgKNo3i9M/1ZOUvQWgE9WDIriomCIqCjrNh3VTyZtE6UUFz?=
 =?us-ascii?Q?tz8rOQu0GMyhczsilmk5wQm/4kazqizE3CNCW59ggWfeiACBktCJd/R89lzx?=
 =?us-ascii?Q?/uxT8B4QgoSpXXl/QBOCNxSqpSv1dnmBm4qOjdZRs6nsXh3K32kiu7Ybob8H?=
 =?us-ascii?Q?Fw8YRo/bu7ak7cA8uTRua2QIk6NEtwAPXzrG6Z7rEBcCItM9CIU0Xyct/61v?=
 =?us-ascii?Q?lNf55oYh2UXLKOX/Axh4EfQPCAwvnZkA9OBBY79usFCYqUR/MbZopyrFrQLW?=
 =?us-ascii?Q?yfVtw4zT2SdJ/Wyqex1Cmcn1HZfNPoxJ9UFcDcGjcd6LJL8QVXKrWv2E+XNv?=
 =?us-ascii?Q?gMl+I5d+/Oaki15Osfv7bwOjKzzNxX9pk/6K/6R9/Sso3JppyOVZwmcG57/j?=
 =?us-ascii?Q?npMmIXoEFvzAtKZj1JjKywzQ3cEZJCdv6R+sems+zbStVJOil545BkSru/pr?=
 =?us-ascii?Q?nefn2RDle05n2cvBk70AxzcmklpSnRLDYC0l8pi0pm/Dhx7J5ykbPMNVXzLZ?=
 =?us-ascii?Q?BZfSHT674y2hJFF6wzKmt6pMwHDbMUhgE1I1+nl7z2ez53TaQqxag=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 3FzxJa0fEBDgShAt5sb9ZKrbbdtzsrVkCJjVJaHJ+eOslyPVkjtFcnBUSF/B4y2EQOLMyRmYwWIFIlD1tsfsZ3YjmST8/oLaIPl41IUNdJ04b3I6FAKQ2mh0TfN6a2v94h4dH99UEOCzSK0OcHyHLeHu8y1jYuMmwnEYc+ahMLgruDUGRYlnexPqQQOSPdwN0ILTrB6Wi43tpd+Llt4Ny/Kd/O1kDrvcvZS1/Jy8oNTInzgDo8mEckFTpG/H+YMBb3qgNPRYq7HLqtBNh4YBaxSya/mn9PsbHZSRIsZMBPDDm1377To/beFS4qsuRW4LqrBXuE2kvqjC84NCjCfHX6/ewewJ8tu+7h8sqgvEGMQCy9haSUvmQW+I4ejBwgoHEuqQBh04j1YcPNZ5ie8dgQPmT+UcRzy1XmiIJ+kpO5U=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB2145;6:yek58ipmWyluvR42CweQAgy003ZghDlvXjUyS7YkXMpXV4rkOEqBAGe4Ga+126pD7M703NtNJ1hi4soFHckPS2Kt6kg+pAKuioK9nradbcM2SF/v84+A9AXoN/8+9nyTCbeGJRkLyZmU/ZMZF58mHAaiGqSUGmVfOnT7Q9n2GIUP8PSJL+T0HXpJSpR3uHX5fDhst2Kuc71n5TbqACpgPwqnRQgxgKyCgIUY6fO9JcAqeB2ZN9SRQNi9x7jX7H1ThuLtzVdTj63ns6t0eCM2mkAPzRy60xf3s1DHaUA4BtvrIc9AsP/w+RMEyQ+mzHRaQYI60oSPc+Elxwlf1BW5Onwv5yelUxHOUsuyxN4uF6Hjh9xT00mXiZaI7TXRpKgqpXfiv+Sv01CSNPSFN7y6JbQg4Ve09LvFqz4QzA6fEZd3pU+Gs2gqLVnWCuL8h3WJlNPiGG434rlBNM0a5zmO9g==;5:IMRqNK5/dSVHnHK+5gjtFIr9x2UuCYnMkmgcM2cDKB2jzqDolxax2opnh4xwQfB9vNWLrHFbG9YfRhyaiu/UCPVTnBUpHB1cwu7QNhLBWnPgp32F13/0CgpRO/eCNt9eJRFVQJ21VKlSP0oQHI+N6WfVIyjEAy006XKrFcEVXoxQsAWL6iXQnN1WeabasZfvMv/CrFVh+0/5hs/543hqbA==;7:K1++VvWjTrPE9onuRJ/cUrusB3hZiFbq6E5Wq4sh2/XW7MsracBdXrfUJewwRaftvYiyvRdWMw469zoJFVriljwsZnRDqayWRRdIdsUfrKPQOD1f5qCOQWl/zZoYloaX7ntqRf9JTFml0R/450nUHg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2019 07:09:37.3027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6c802a-d605-4f8c-2974-08d689a68efa
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR02MB2145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP nvmem driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/nvmem/xlnx,zynqmp-nvmem.txt      | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt

diff --git a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
new file mode 100644
index 000000000000..2043c8284f8c
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
@@ -0,0 +1,47 @@
+--------------------------------------------------------------------------
+=  Zynq UltraScale+ MPSoC nvmem firmware driver binding =
+--------------------------------------------------------------------------
+The nvmem_firmware node provides access to the hardware related data
+like soc revision, IDCODE... etc, By using the firmware interface.
+
+Required properties:
+- compatible: should be "xlnx,zynqmp-nvmem-fw"
+
+= Data cells =
+Are child nodes of silicon id, bindings of which as described in
+bindings/nvmem/nvmem.txt
+
+-------
+ Example
+-------
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		compatible = "xlnx,zynqmp-firmware";
+		method = "smc";
+
+		nvmem_firmware {
+			compatible = "xlnx,zynqmp-nvmem-fw";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			/* Data cells */
+			soc_revision: soc_revision {
+				reg = <0x0 0x4>;
+			};
+		};
+	};
+};
+
+= Data consumers =
+Are device nodes which consume nvmem data cells.
+
+For example:
+	pcap {
+		...
+
+		nvmem-cells = <&soc_revision>;
+		nvmem-cell-names = "soc_revision";
+
+		...
+	};
+
-- 
2.18.0

