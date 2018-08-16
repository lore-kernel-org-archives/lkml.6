Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5534DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE44214C5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="17b8wrWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE44214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389224AbeHPKEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:04:04 -0400
Received: from mail-eopbgr690050.outbound.protection.outlook.com ([40.107.69.50]:17152
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389126AbeHPKDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzvjgdsoh4VGgAtjmPY+LVxBRdDaPT9HGt6kzW02COk=;
 b=17b8wrWOkUNpFcRlObjC+8NQ4MrrDy8ofz50AHw/ijEpHw2Osbo2Thak2kVHxYaV8SK9FehyYgOMUU7oOhjvwr9InaYDFL/oTN7kE5rqM1K0RW8WmZutbViCRk/FiJDdkq33jMnqjgu4tQ/qg26c+TlXR/FuNRnHLz6T8pk9cAw=
Received: from MWHPR0201CA0080.namprd02.prod.outlook.com
 (2603:10b6:301:75::21) by MWHPR0201MB3514.namprd02.prod.outlook.com
 (2603:10b6:301:77::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.20; Thu, 16 Aug
 2018 07:07:03 +0000
Received: from BL2NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by MWHPR0201CA0080.outlook.office365.com
 (2603:10b6:301:75::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.19 via Frontend
 Transport; Thu, 16 Aug 2018 07:07:03 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT005.mail.protection.outlook.com (10.152.76.252) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Thu, 16 Aug 2018 07:07:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:50246 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1fqCN3-0007Hq-Vq; Thu, 16 Aug 2018 00:07:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1fqCMy-0000y9-QY; Thu, 16 Aug 2018 00:06:56 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7G76kAB028379;
        Thu, 16 Aug 2018 00:06:46 -0700
Received: from [172.19.2.167] (helo=xsjjliang50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jliang@xilinx.com>)
        id 1fqCMo-0000pj-Iv; Thu, 16 Aug 2018 00:06:46 -0700
From:   Wendy Liang <wendy.liang@xilinx.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <rajan.vaja@xilinx.com>,
        <jollys@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wendy Liang <jliang@xilinx.com>
Subject: [PATCH 4/7] firmware: xlnx-zynqmp: Add request/release node
Date:   Thu, 16 Aug 2018 00:06:27 -0700
Message-ID: <1534403190-28523-5-git-send-email-jliang@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
References: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(2980300002)(438002)(189003)(199004)(356003)(50466002)(4326008)(36756003)(316002)(54906003)(76176011)(305945005)(36386004)(51416003)(110136005)(16586007)(11346002)(44832011)(14444005)(426003)(446003)(2616005)(126002)(186003)(486006)(336012)(48376002)(47776003)(6636002)(26005)(107886003)(6666003)(476003)(77096007)(2201001)(8676002)(81156014)(81166006)(106466001)(2906002)(478600001)(8936002)(50226002)(63266004)(7696005)(9786002)(106002)(5660300001)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3514;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT005;1:bv+MaKKYtAZ/9SNEoMtD3iaaZFZfRM8/5rc3ZHpP9W5fVzJgMpCI/7vC3dlc7cWxWLiH2XTrp5obRldBtoqAFrQxodvKlRVLPodcH0IygbKZ5/VnvJRnHSGyHVwTx1mo
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b041f3a-c37e-47d7-7489-08d60346de18
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:MWHPR0201MB3514;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;3:a6VB30rrt1i57SRNProKdQ6DVZPoPPBCL6tQPBfZSPQSjElrmOte1ydWwVdD+zREXOSXpHz1QO62FyxeDopAjduyoBNIobZnol9FHbr76is3qWzHD/D2erpfcvZAoczg4tyTcDZxiMQaofzdTMp1oGuFZxf+HKKhAmTFbghmhsM2rI83Tg+CzVbEJw8Czn4aiGMBkLkoN9+S77VWJhDuoSw9GY89gy6b0bLl6nw6v1fDMvIyyV5BhWu6v4qPJ6+mrV0AX5zb3WEeCEmPGTcqMlGUDqEnK58g0IBZ7GSR4EphzgfjYowfvBa1kYDR6kX/tivnGD+w3KJlq/7ZJAQJS2st41hT2/saCGtyeX3XuQA=;25:ldN8UKlrnyeo+LJMK6/DD/u+VHdR3GryKclLUaclP/93UC7c6PVbts2Eqx2ukeNXazEGl8fD6g0Z7MkuzWpZPnpTUVr8a2Nb8HiG1YyV+VbPeJl8q19IXvx29O7hpO4ZZn+fURPP0YCYi7pVJNk5PLTur+roOMeTGwQZpbvPHEa2JMfW3x5xiazuzqB2AL9NTpz+W27lxYcTG8Neq6nbhgtFEve0mDnvK7GxJjyi7EVN447uVBZ5IA2camI/0zEbCY00a/UfetbHJYrTRuCCN+JMreaTu/I7IaK91CYs6qj2vkak43UJtKD3IfpRBusU7UzdIyTYM0C4V037zmOx4A==
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3514:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;31:oR/m2d7idvILtpf74pOoMFPBTtPKQQjknKL9lIeAr4U53Be5HCHBlLnzI+cPj+fB8VyGafKGiya2HPmGyLQvjUr/D7IemL9N8M1HiWyP4WZYqc3mrElx0vvp44ki0O80W1Jl5udAU4/7UB2nltMW0VqVb0a0q3dlIXtjtu21zNSJiaf8XIhLVcKSVt15ekrkkEVBYydzKegacfaHZ0iisOX9qVj/sZcr1FWYIiLAuoE=;20:Eb7oxnwAZX5PZ8vRMCChwcYlmuoMeFBh9gxJICIJvWwLom6/b0Ni6FnZw4T2GWECPG9bhnAxqsPMYso2kYbEkA7iybwol+D5UGZQgDpNhwwpnc8CqkbO6OGOw7Wx0I4B2bzAc21p3xrFtg9SgCmTUL8W2fdhgjKlVm1VQWCZ+esUQz/OUvIu/kv3L4YTUTAZW0Mz1FnnWFs1hnyO2kJjE87e+amhnrmrufHAEj8UZ3ufAxsybHJPqJ7BwgLEkdVEdwq+hS/SsNCtyqduxk4+rimT0EwCCcFSPBc43+DfTbA6GUnF5ZOP3tpKCHk17elTjNRSIZTsPTlpITgNjIan2RG328xlXHrb8yziVRwp6Z5ua1D4+onWsSA1xUOI49n6hwYzZPvwy/2utrWU1GDsn37j30UtkCoR4UpERJ5tuSHAy/89dMZQJa5/AUuVQ7FLfikWEuNqFtg80yiJORF0kOqps86fmtWkAUdZKmP3sQsJAmq0KsoQEceR64RWLjel
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3514A6D7C8360ADD211BC853B03E0@MWHPR0201MB3514.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:MWHPR0201MB3514;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3514;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;4:e3p8QnQ8sm3F2QOHjKwaiVNnlRHNkr3K97CicLi0aZUP5DT1M7VgN6Zq4USsp6am/5ZzK/Gtucv/CgMQuCPGUzXEHdZt5u7p6J6gQo+R3uHrE9XKCaZ0SW1diV+LehFCyXIEc3MOII+V3KvfL+ewpHNwjK3xREO8W9BCg78t8VRDoTN/tSmMr2RDZF2p+34p7TGSIzMdGHDKzYvw223GEVouQayeU3EPRKtaWdfuqsCh/RYLcXk4PkQNjhRnLYrmFSU/ByhLE+SiyuRBxVhp4SAgkD8mHO0bDNS8lT5t/Th+ACjtDy6MpX4AWuMa3c3V
X-Forefront-PRVS: 07665BE9D1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0201MB3514;23:+TS8iKBlZEOqrXIp9uAR/fVP/4tl2PAThmYdiWI?=
 =?us-ascii?Q?WqZC9fCmWoInayDj1tPxmrXHfODFB4SK7McJFeqJ+jhjfcdgnfgNN/KIYOhu?=
 =?us-ascii?Q?HI9F+4PYdFadN/lgO96uOCRoDAI8CWgk+kIbQt2bocS6ZXh1X86ByxDSsBq9?=
 =?us-ascii?Q?ihSJbgQP826AJrtWHigFwE17Tw/M3XsjMOnaxg4YFLkyW3frtiiP9VDU5dkp?=
 =?us-ascii?Q?9wudH3bckav8hubpo9+ngXIp2Iz3bVY6XKJ38TloCoZ5kVoPvq7XO3r4SBFE?=
 =?us-ascii?Q?6pZ1W9HiKFT2WZkWVktF/+/Cad3NeBABSazxNX94mnujcJUuO6y7G6zMwY7B?=
 =?us-ascii?Q?rhbVrWBQi9Vf9O/VX6XNTcv2QOz8e2AhGX3Gqui4uiccuiY5Rp1GSgZm5DYZ?=
 =?us-ascii?Q?16I26CS7hmb2OahX7UzCzXP2Wkn3Pa6bKX8ADOmn6l+FNmyAX8FEl2nF3TPI?=
 =?us-ascii?Q?sxMsIq9lDxDb6DELH2/sneHFwqFHTTHN/KVrd/7/vXuNmASij4nrC7HJYsJT?=
 =?us-ascii?Q?CSd+2iTPRAAW2XJfK7kWr6yl3yZWRZuCVYEEAVFvrTb0CFgmTeIvFDA5ZURV?=
 =?us-ascii?Q?a0ds/CU8LSL6yqlk4t5r/t4LypZTiUkFnVWpPCLScEkIvNYUVT9DDaRvBfMg?=
 =?us-ascii?Q?E4QSFTgQmj2yHRaSDTjknEi3B7E8u+vtIPOb5zRx+RpaaNgxMVdtIUObd17y?=
 =?us-ascii?Q?Fpyu5ZvQC7iKU22lxgcJRcEytuXTQslsZH99YT+f6HMErgxwnPnbLqex09F6?=
 =?us-ascii?Q?nASqXBXezDIKbkdKvonXTAOCPLCMEH9aCBkHWjr8QvB8kkwM6l4sC/y12PVe?=
 =?us-ascii?Q?62cZCSGTFJte7fxfEERDXrHx3jruN4o6Bt/3ten0KYgBbrur+XNs5oxAHhQT?=
 =?us-ascii?Q?HiSTjs7h5xDGNwTjI72li48h5njG8vO1+3XYsd85zqZgNQrY+HDhLk+tbo9g?=
 =?us-ascii?Q?2UQx8h9K/DXcrBTNJw3I3E9NWMPh14tARedEyGa/bqAyFbmp4QScAfjXX6fH?=
 =?us-ascii?Q?RTIM9B2Tza1jxflcpwclsobN87gE4UfNvTevKpo3l9qR92iBKqeGX4bvGV8C?=
 =?us-ascii?Q?Ng8zpTU3PQW/KcrXf+gBhQxfuOBAv3P6+xZZ8MuVw7h4TIwuz3zYKKVLNKoF?=
 =?us-ascii?Q?RgjfGLHH+dbRwlGBMdnLrsSR8lPfMs51wrngPNfABRMVTaMPiZDb9N8YeY6p?=
 =?us-ascii?Q?2o6309ix6joSCktHYPcsbQBZlpdyom3ChNFeP?=
X-Microsoft-Antispam-Message-Info: TxZrp0wbxrONpMH4+m2ipxln3aBiyl3cxJIFgFOpr/bEMD/wUsxWGkO8zcFpwFBJmaiok9YdBBb30YqU3DNFqxbTHGsSUV7wSUd4xwMmjRTy6E6WrInV3ceM+25YFT5oDpStgUhcISA5fLLIhcsa1bvyjID5+4d1MZbTBe+q6NGSTvAJ9a/Rv9bWlLGQ6ko5aQg/rruuZ/IqWdubRejzO+BTCPzaAulZkOjjVtEIwqtKNlLU/YFV26g8yoYmNbDQvBirk2sJNy1gtHDoD/VPJJEFAjSta6RuGx8f8Twt80PJNQV6XA7F2up4Znn6shGEfi95K/l54Uu7vHRPB7rAmn3jColt7MWDA/lWql2+w+Y=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;6:dJ6ROaVQV7Wl7oHvDf4lDe0NlkESEXoYExxM1gqxgVxf7COvOfbgDoFcSujXg/gzcz6pGwPlbL5RQ4Q7cA3G+Yup5oPP7Rf8U2GcUzlqDIv1RJ2/qSIoF74Z4X8DEZESYCuC8l04B4Hw/TFY+WJRcxVNywIlurqy59Nw2uQC3gkK3dwoSj0m+7dh/3dBen6ioAeMXZl/ZNvz46ZmQLDZYB9T9UpClxKjivEhqv8W9LDYdL6Yw7M3N5/+c+QQNNK3BxxCIa07CWw91mvLpdcwlUzbW6RmIIVS85glIqSTTjiwFHStYcP9AuZQfX2v89cyLu4YufCVdbxBguf5MrzFnk/FG7YH2FP7S6/6R658H+W0DgzpaATved13B24JMubOEH1GvW79Re00hgOEG+kFce8daDORtil+JyxJwIRVPnj9xuVQqTZOBA36LEvVNCvxdlN4IypXO+TveDrewjqgYw==;5:i8TzBJNLopINT389kkFeqPuu6pF7UCZjuEQAl9IC5q231bLyNCM1QWyU/mdxU4XMTANuViP/b7L2koQykrcYm/QZ4d7gmFvC8Ro/QStCCEjy2nENHMUaETvsdppA53g9pyZaSmLksk+Uw9LFLSQNRfX3y77PDR0BFrpv1yR0Lvc=;7:k+xfqHlB1MYVue3+mbeueTTfApw82STkDJWpAwGFHFxkmHYR+D1m2rmTUsDVJ35LSQpqHptr61NHyxCSPVFzxR+fHS7mM31RlaIJy9ptsqX37ut/IyuGc35bDD4F9ZIHjnZHwea+DIvzGcwTBkVBC7tF8n3PvGJKjMakThhixV9d+LmcJRKl4cpBQxeSbeZXG+P4dpA1mS0cKzre62gw4krZFY1sBmJw2JVXHhWZL+gs7V/xUtjJD4z/wCvZg8w0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 07:07:02.5742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b041f3a-c37e-47d7-7489-08d60346de18
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3514
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add request/release resource node EEMI operations.

Signed-off-by: Wendy Liang <jliang@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 30 ++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  7 +++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index ce6c746..2e97f60 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -447,6 +447,34 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 	return ret;
 }
 
+/**
+ * zynqmp_pm_request_node - PM call to request a node with specific capabilities
+ * @node:		Node ID of the slave
+ * @capabilities:	Requested capabilities of the slave
+ * @qos:		Quality of service (not supported)
+ * @ack:		Flag to specify whether acknowledge is requested
+ *
+ * Return:		Returns status, either success or error+reason
+ */
+static int zynqmp_pm_request_node(const u32 node, const u32 capabilities,
+				  const u32 qos,
+				  const enum zynqmp_pm_request_ack ack)
+{
+	return zynqmp_pm_invoke_fn(PM_REQUEST_NODE, node, capabilities,
+				   qos, ack, NULL);
+}
+
+/**
+ * zynqmp_pm_release_node - PM call to release a node
+ * @node:	Node ID of the slave
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+static int zynqmp_pm_release_node(const u32 node)
+{
+	return zynqmp_pm_invoke_fn(PM_RELEASE_NODE, node, 0, 0, 0, NULL);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.ioctl = zynqmp_pm_ioctl,
@@ -460,6 +488,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.clock_getrate = zynqmp_pm_clock_getrate,
 	.clock_setparent = zynqmp_pm_clock_setparent,
 	.clock_getparent = zynqmp_pm_clock_getparent,
+	.request_node = zynqmp_pm_request_node,
+	.release_node = zynqmp_pm_release_node,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 83ebadf..02067a3 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -54,6 +54,8 @@ enum pm_api_id {
 	PM_CLOCK_GETRATE,
 	PM_CLOCK_SETPARENT,
 	PM_CLOCK_GETPARENT,
+	PM_REQUEST_NODE = 13,
+	PM_RELEASE_NODE = 14,
 };
 
 /* PMU-FW return status codes */
@@ -130,6 +132,11 @@ struct zynqmp_eemi_ops {
 	int (*clock_getrate)(u32 clock_id, u64 *rate);
 	int (*clock_setparent)(u32 clock_id, u32 parent_id);
 	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
+	int (*request_node)(const u32 node,
+			    const u32 capabilities,
+			    const u32 qos,
+			    const enum zynqmp_pm_request_ack ack);
+	int (*release_node)(const u32 node);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4

