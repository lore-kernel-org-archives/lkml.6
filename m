Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349DFC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32992086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="aJ+PgcKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32992086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390522AbeIUTbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:31:47 -0400
Received: from mail-co1nam03on0072.outbound.protection.outlook.com ([104.47.40.72]:27764
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389761AbeIUTbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnEQUzwRezXNj2KATqs1sACm0luaDzyFicS4jUyz0b4=;
 b=aJ+PgcKfbB02UvMRbW1lSEAxwuHYEaS9sw+HxQ247qO88UFRKMKs6iEK92JeY3L0xYUlv9S6wNYFEVmjv79T3W3m7JLqObv2eFFauvDZTIMlkbRf3pIw776GFDgJM5p2usodO9UElJ41Y5oZ+iBmeBoCxxM33UMoJhRhokiS2Ro=
Received: from BL0PR02CA0105.namprd02.prod.outlook.com (2603:10b6:208:51::46)
 by BL0PR02MB4466.namprd02.prod.outlook.com (2603:10b6:208:4a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Fri, 21 Sep
 2018 13:42:45 +0000
Received: from CY1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BL0PR02CA0105.outlook.office365.com
 (2603:10b6:208:51::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.17 via Frontend
 Transport; Fri, 21 Sep 2018 13:42:45 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT016.mail.protection.outlook.com (10.152.75.164) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Fri, 21 Sep 2018 13:42:44 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1g3Lhk-0005Ed-Ag; Fri, 21 Sep 2018 06:42:44 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1g3Lhf-0008DO-6q; Fri, 21 Sep 2018 06:42:39 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8LDgYnr015657;
        Fri, 21 Sep 2018 06:42:34 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1g3LhZ-0008AC-Qs; Fri, 21 Sep 2018 06:42:34 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <srinivas.kandagatla@linaro.org>,
        <jollys@xilinx.com>, <rajanv@xilinx.com>, <sboyd@kernel.org>,
        <nava.manne@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v3 3/3] nvmem: zynqmp: Added zynqmp nvmem firmware driver
Date:   Sat, 22 Sep 2018 19:11:49 +0530
Message-ID: <20180922134149.5693-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180922134149.5693-1-nava.manne@xilinx.com>
References: <20180922134149.5693-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(2980300002)(438002)(199004)(189003)(63266004)(316002)(110136005)(16586007)(51416003)(5660300001)(106002)(2906002)(36386004)(186003)(7696005)(9786002)(48376002)(11346002)(36756003)(336012)(76176011)(478600001)(2616005)(26005)(6666003)(81156014)(50226002)(8936002)(81166006)(106466001)(356003)(77096007)(476003)(8676002)(50466002)(2201001)(305945005)(47776003)(426003)(1076002)(217873002)(126002)(486006)(446003)(14444005)(107986001)(921003)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4466;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT016;1:DikyvG4323TbZK48TelD/MyrBIlzibOP6JPEMGCd6BqJU0nGcR3rKqPtF3voNXH0YLqBuU0hzSu2gcTqceb+OpCYy0JfwSIKMnv0+dNN1DRYAtkSQ1Fju4HfWxdnft+5
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7ec95ee-ea17-4e88-4528-08d61fc81c98
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4466;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4466;3:WkXjqs3o3tOB/ioO4aCuh4G//JdDMtT/S9Z2gRt1Z72QNMRMPohy9+cyXkaU1JpSiZN0ACkk+/mVDJnO0EP7blRpjK6Hj8CvKBBEyc7X6403/4OXRdg/xqrMBEh2vapNAY0Ftx9zp4TlfpWpHTMEwWq+fKuDOhNwlyIBnrb09a8z3Q71fGBeoO8bjSsEGTlQZLWr13KSxIp9ZuSFuE8Pq0VcuPpNMy0v//6+dNKAcFfC/4fi5ghScMUEkhQKp/pGDEqdv2yIEYlH+AeUuv5TF8tQkQaBwgo1O2UBl4m0oK0yNigA8WCAb1OggOQpsWLkIrJA1UTOrzqQDAuq3GtNzuxlaM78xAkoU+J1LbxuTwU=;25:Rn4tHbjUwHEX1XSZtDrZ6zmQ+9iFOFPLGPZ2sP61x7cg/F3IP33Rk0ZRQSboZc11ssCD+tp7cLryEVh77AxJlUFnpTAruk9mXtJDmTRNcSyAWpbN0LPgOy0jLoPksfWirmkk5BiLwepc54VGQJ3iTYX/P81lt0taODzIg0U0/S+e2AbPK7T0egZRJ114lJcw0PLVNvpAQ8EcE3pAdcazJOBY+hbUZCfAiyW38qLw02RUF2CFSuxv1Ffzmxro0axLPI928/D3di05UHjVmX/CdpQs1OCz8OrX8ZCcMFmQAZAMub/z4GlZbkrTA8HomugmGHWALw/OVRgcLjeR04gmZg==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4466:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4466;31:1TWKRSXORad2GPsG8hV4M7r1KgnCj98KhKJ13XCiG4xIT05w5sRDM0LHXRpjskmDJhhnOOyOgboWeecVFeztYihBU/RT06ipOM+NyNk4GhuKvcHkv6DqaBu2EcDL5kytwR1XmrrJSdiky/5+z5PFn93S538+60d6z/fCnmXFuhnaRslI4Nbd1aSf0sqFsohGG61vzWN0VYewpRmOL/8Rbla1Sm1mmJ33L4YcN2I4LNQ=;20:mqxqJkm9FDwyCb4/reS3LoZZdrmNO68ttcS4XsL1vcEIDpWHrtnj7tUQ0QJX1uk9ImHSZeliIt+7e/5c9IsnRyUoiw7f2AqVTDcYWHTDvc9/ty8h+wxh5i/FzI3iS4iKVvM1Q4ifzjUG633G6Lu6Lftb/SytZijDZInOCn6p7NpocuqRBcol4fbM625BmuibdITiulxbHp/Qdch/5/1Zgs0HwCUVx2tsUUdlrQ8SRDTT5vEY+OxVz85oOJmf8Px4J4t/g21NdtRroHQ6QJ7d/Z/+U57q8p1S4+SOlKqeuLXXvXG08r0K3zeb9p7Y3tS+cmUQvuFZsBW49CcekTH5LRET1p4m3RYz8vyjENV9zxV7dqr9sIpyEGarYLFoYWElwjJcejMRAVDzjnKIrzqjipoibSKv0/gOe8JO/GXhQEWi1tPvgurTJnYQzxvpXkVLzyHyzBLCetz+bMtkk6t/9zjGCoMlBtMh9lVeD6y6ZaMJ2sVO1t+F0JgiKHXqyWMd
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4466AE00EA71E09374CDE86DC2120@BL0PR02MB4466.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BL0PR02MB4466;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4466;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4466;4:iHMwfn0UYNPz57WvRgNIFKyMILL9i5KKzEUw2fj19z2bPZ41Wp2ZL9W7hN1D3sY48M0S55Io63Ktzw3dOOLH+kBQZ2Ho/0wmgXuJHMDTuu6xePyL0yl9xo7wmKY3tGMYpqVrN7AjqXmtT6sAZmqmnwdrMx3v+6XM6JjVKPD+oQGgXpeu/V/9KwDUqpz1hY53rxEXzSFeIkUi0L41Ttzjng5wBmwoXJX9fB5/NcPo20KEQbwAGQ/CwMrKwcUcsptvYBnb8gnglB9IFkLDQzKhe7pvri4Qh6Kz3PFUnU0YmJQvOwCxTooEq1kPkK6dSOes
X-Forefront-PRVS: 0802ADD973
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4466;23:lQcfG5hevForoF8wJaaKd+pt4FvaZrG1wNnK6Qg0j?=
 =?us-ascii?Q?PAXmhni+xcXrsB6r/hmfXu7XB8F3+mHAdBFjOwBjcjJP9XI8uxCxvJEahGc9?=
 =?us-ascii?Q?HEGlvnS2D5gGoSnqvtx0DIC/PYQ/YM/4+3tLlX/vTTPkPHsqRF28Dltadbob?=
 =?us-ascii?Q?MO7S0CWwZtrOCBM2abHMm0VeL63rt0QZqPcTJtI2rx+uOSf4QDBV5/4dWtIy?=
 =?us-ascii?Q?eFsEoaeXtEj1/P3KoZeV3W7igUw+CKqdSMxsBA3m7b8MzNz3n8kLITYTFsUU?=
 =?us-ascii?Q?uW9DqbqpbiKtJqkMQ1b6zSKnOJ1zZoFhCXENsPE16k/mP8JmUJe4y5bQJWqw?=
 =?us-ascii?Q?NQ1joUt5Z/Ck0foOMP5oolfDidyj9tEMjgTPiElNJftWccSiSZhi0fSyg0DP?=
 =?us-ascii?Q?GOMnx0jtLTzE+1I0V9RKStJZX6GaYtT7C0AEkr7KgB6gAcomWiQaj27tPT+y?=
 =?us-ascii?Q?9G7RUv7qnOJPHUYW/ADUNuHb1w5/xFdinZGRSStfFTnffQB4auO4Fql7+MiZ?=
 =?us-ascii?Q?Vi14Fc4P/+N7CPxVM+1+t+HSFqc/BV+lQC0lBxMSlSVSz8PFlVdn+Rd+zE7w?=
 =?us-ascii?Q?Kt776qfFWXp676r42Og2tmqYhR18c0kfIXxI8aRBwqoTwBO1Tucw0qkrHh90?=
 =?us-ascii?Q?Z6oCtOvlpYoxHhx2ERAqMZWrFLTfkwSIkWw9WiLaXn+mS2Rete3uKdSBBQwx?=
 =?us-ascii?Q?yvx+bTOBzA0D9O7rxzUI8uGJRmOpBMljbMBYu/zy4mPu31iuzCarFFiLcXz8?=
 =?us-ascii?Q?NhgdDMdFrTtbzTwBzbwngL+nPkly9ETiFI6Qq5Jl88MShBpzAWBwZ7Nn/mBA?=
 =?us-ascii?Q?iKFd6Nv462VkrOLVEKPuHdH1nmWczdHmwnpCiu327CMPWk7WenWuYphzf6J/?=
 =?us-ascii?Q?vljEgGw/peDmkJ3vMnRA8nNmomnQiTmP9olEUk+3ghx3jv5+FpRNaSCzaMKI?=
 =?us-ascii?Q?QZkP4CLHrXUVU/1lXiz+i/aYrC4IlmM8qlsXq5tpz0FkuP/ptvzT47eAXCCL?=
 =?us-ascii?Q?y361rb5UegtXZW9uoRMj1qnKbQACvOm+Mri95eqnsqOcUMR1caTSERxG80T5?=
 =?us-ascii?Q?130PRM+P+jj6ZEpxsdI13ksrbbaQqzRYcf8Pa+Fjk+jhn6X9ris7BlW5o/HE?=
 =?us-ascii?Q?T6m+1f0HkvNVmciI454ky9XvfC6Up/z6wRIbpIEqRv+svqu1uoz0MgkBvL03?=
 =?us-ascii?Q?lLemg0VI9Kj13Ciy6kTyvdTyuBJAtACdqwZ?=
X-Microsoft-Antispam-Message-Info: zDm9tRaLVzfYYFJ3yzOYd8SGku6gV0Lr5YwfkJIKRiIuWb2WkbZWo+NH5oo2g2VeeIk6Rm83vQN1s2IpZ1z4e0jZhRuT39KOVueZo60dJ4oxK7MY/5gSeyQ8RVjnfgKxl2R8lpTwXb0HnIs0YhLNfvPVF2X7NQFKCUgzKqDENXFsNrODDPeEhU7WGrhkLS4sKiIpLDVMbpOoAufzaMxYu73ZFX08VDYlYRIcOTUNsoJxg7ED66O5yOTN1p6rODHsMd38qUa0DGFhaRa97daZDyggs4FFp5kWbmb+TsqblUuzZL4+B/0wUPC+WX54WdGZ0sSDEtTezqX/gnqcuXfa1840vUrvFzFBBQ6ezDtYMqw=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4466;6:iP9luGhhOaU5JYWoCBJWuCbMfuaS9a2ZK/NSqiUPurzEzzW2OouOASraASXxariYWwJDtcj2BFnLUkB+1QURcLcrEcxa+5M5bUvVj/0YzzfngfVJgcesBr4zf6Ues1LqXU2efB6v1542myrG4UZwsV6jc+M7H6a3bVroMEWEeiT6WhWNDjqZ2mzKZZ7bl/SxDke49o2ll9FIqxRhrs8ZZhB7t6yAKqPCEmWWTziclGamwPYpNa1CEuFM1MrFwGYjLhdkw0pbDlv1QXu4QSN8gW7E049BH7gbgU1tajj8mVTSouci9/u9FivMJkST6xw5EZC19h10dfb8BDhCDO7MekNSPK/U1hPYeog7moDxNj6ifi1JIoQ1NVCLt5LbL+xUaj18KX1ld1b46s7DpS6zVMNysTAoK03RSIt1gAFyklIUXq2k3/FlnnRIuOABh+x+lL0sEM22nJTnFnDM647acg==;5:zYq/+SRFze4I3l01iNfLkw52UAmR4xI0Trbr0gOaGZPZDEA0GPatqIRdjZ/Q5PGx3ByefZIlRmVSPRfUiqV2lcG6KSzROHF/yRJ7EDBl/KIQwqDId0SxeRoIyiPDk/OW1j3YjcKFofBfTz02vkwvz9x4iqW9xXNOdM9lN6+fb34=;7:2o6+MI17YdYONQnM5b2FiwyFB+sTqoK8EfBQpqFHIIu++OeWCCr5wZBPy6chuPAKHglwEY8ZwFDBUxEWogEHk7sUO0x5AhHcRN21X/w7LptzTFvXS3O/XgPehWKhyeGqx6ab9iWxE9zt89KEQCkQ/afKp7sSbj2qh12YEDrqA6JkRW/2FCqyJO37RNyhQPZzsBtVd6+1osOzIdXAQWRhfkJKY83iOnPUn449wC3RyjNozA22yKR55iQkg8ZPfgB9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 13:42:44.8321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ec95ee-ea17-4e88-4528-08d61fc81c98
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4466
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds zynqmp nvmem firmware driver to access the
SoC revision information from the hardware register.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v3:
		-Changed nvmem_register() to devm_nvmem_register()
		 and pr_debug() to dev_dbg() as suggested by srinivas. 
Changes for v2:
                -None.

 drivers/nvmem/Kconfig        | 10 +++++
 drivers/nvmem/Makefile       |  2 +
 drivers/nvmem/zynqmp_nvmem.c | 86 ++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 drivers/nvmem/zynqmp_nvmem.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 54a3c298247b..2edb1428ef6d 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -181,4 +181,14 @@ config RAVE_SP_EEPROM
 	help
 	  Say y here to enable Rave SP EEPROM support.
 
+config NVMEM_ZYNQMP
+	bool "Xilinx ZYNQMP SoC nvmem firmware support"
+	depends on ARCH_ZYNQMP
+	help
+	  This is a driver to access hardware related data like
+	  soc revision, IDCODE... etc by using the firmware
+	  interface.
+
+	  If sure, say yes. If unsure, say no.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 27e96a8efd1c..0b3abd7f5d02 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -39,4 +39,6 @@ obj-$(CONFIG_NVMEM_SNVS_LPGPR)	+= nvmem_snvs_lpgpr.o
 nvmem_snvs_lpgpr-y		:= snvs_lpgpr.o
 obj-$(CONFIG_RAVE_SP_EEPROM)	+= nvmem-rave-sp-eeprom.o
 nvmem-rave-sp-eeprom-y		:= rave-sp-eeprom.o
+obj-$(CONFIG_NVMEM_ZYNQMP)     += nvmem_zynqmp_nvmem.o
+nvmem_zynqmp_nvmem-y           := zynqmp_nvmem.o
 
diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
new file mode 100644
index 000000000000..b910864e91b7
--- /dev/null
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Xilinx, Inc.
+ */
+
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+
+#define SILICON_REVISION_MASK 0xF
+
+struct zynqmp_nvmem_data {
+	struct device *dev;
+	struct nvmem_device *nvmem;
+};
+
+static int zynqmp_nvmem_read(void *context, unsigned int offset,
+			     void *val, size_t bytes)
+{
+	int ret;
+	int idcode, version;
+	struct zynqmp_nvmem_data *priv = context;
+
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->get_chipid)
+		return -ENXIO;
+
+	ret = eemi_ops->get_chipid(&idcode, &version);
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(priv->dev, "Read chipid val %x %x\n", idcode, version);
+	*(int *)val = version & SILICON_REVISION_MASK;
+
+	return 0;
+}
+
+static struct nvmem_config econfig = {
+	.name = "zynqmp-nvmem",
+	.owner = THIS_MODULE,
+	.word_size = 1,
+	.size = 1,
+	.read_only = true,
+};
+
+static const struct of_device_id zynqmp_nvmem_match[] = {
+	{ .compatible = "xlnx,zynqmp-nvmem-fw", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, zynqmp_nvmem_match);
+
+static int zynqmp_nvmem_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct zynqmp_nvmem_data *priv;
+
+	priv = devm_kzalloc(dev, sizeof(struct zynqmp_nvmem_data), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	econfig.dev = dev;
+	econfig.reg_read = zynqmp_nvmem_read;
+	econfig.priv = priv;
+
+	priv->nvmem = devm_nvmem_register(dev, &econfig);
+
+	return PTR_ERR_OR_ZERO(priv->nvmem);
+}
+
+static struct platform_driver zynqmp_nvmem_driver = {
+	.probe = zynqmp_nvmem_probe,
+	.driver = {
+		.name = "zynqmp-nvmem",
+		.of_match_table = zynqmp_nvmem_match,
+	},
+};
+
+module_platform_driver(zynqmp_nvmem_driver);
+
+MODULE_AUTHOR("Michal Simek <michal.simek@xilinx.com>, Nava kishore Manne <navam@xilinx.com>");
+MODULE_DESCRIPTION("ZynqMP NVMEM driver");
+MODULE_LICENSE("GPL");
-- 
2.18.0

