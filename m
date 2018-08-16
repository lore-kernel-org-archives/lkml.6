Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0316FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F05214C5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="b2rsXL8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F05214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389175AbeHPKDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:03:31 -0400
Received: from mail-eopbgr710054.outbound.protection.outlook.com ([40.107.71.54]:43743
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731283AbeHPKD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NO9gv99fne8Be+vdIeini6GfrQyf8+i9xQ9DV78ytNM=;
 b=b2rsXL8ofBR3Z48uzhosorg7Io0LwVkPSNK9rgrtV92wQQQ6h/OLly9z1zTXWRtvuUkMBugsrBmR8BPE728xVA65A0bL1B7oRuz0aaAgZnu3Qz0Je7RZlfItmqmoCfAGLQOcQdCXeS7QTpqF51g9p+h0gy4C36c5nvHoW0oaSto=
Received: from BN6PR02CA0044.namprd02.prod.outlook.com (2603:10b6:404:5f::30)
 by DM6PR02MB4458.namprd02.prod.outlook.com (2603:10b6:5:29::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.20; Thu, 16 Aug
 2018 07:07:02 +0000
Received: from BL2NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BN6PR02CA0044.outlook.office365.com
 (2603:10b6:404:5f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.20 via Frontend
 Transport; Thu, 16 Aug 2018 07:07:02 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT033.mail.protection.outlook.com (10.152.77.163) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Thu, 16 Aug 2018 07:07:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1fqCN3-0007uJ-OE; Thu, 16 Aug 2018 00:07:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1fqCMy-0000y9-Ic; Thu, 16 Aug 2018 00:06:56 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7G76iNA005139;
        Thu, 16 Aug 2018 00:06:46 -0700
Received: from [172.19.2.167] (helo=xsjjliang50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jliang@xilinx.com>)
        id 1fqCMm-0000pj-Be; Thu, 16 Aug 2018 00:06:44 -0700
From:   Wendy Liang <wendy.liang@xilinx.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <rajan.vaja@xilinx.com>,
        <jollys@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wendy Liang <jliang@xilinx.com>
Subject: [PATCH 2/7] firmware: xlnx-zynqmp: Add request ack enums
Date:   Thu, 16 Aug 2018 00:06:25 -0700
Message-ID: <1534403190-28523-3-git-send-email-jliang@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
References: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(396003)(346002)(2980300002)(438002)(189003)(199004)(316002)(50226002)(6636002)(8676002)(8936002)(5660300001)(426003)(478600001)(6666003)(2201001)(44832011)(110136005)(4326008)(16586007)(2906002)(47776003)(81156014)(81166006)(14444005)(476003)(11346002)(126002)(36386004)(446003)(2616005)(48376002)(486006)(7696005)(51416003)(76176011)(106002)(50466002)(54906003)(26005)(36756003)(186003)(305945005)(77096007)(106466001)(336012)(9786002)(356003)(107886003)(63266004)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4458;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT033;1:cDuTHdF44r2A+4TOupQtAdX3Ex8p9AYMJf6sWx6elkuZ7qcFshw50YlOQ9LiCFrJAywYKAHagk3NNO6EZUPMfwxFgzYwrG+U5nMz3yc7VxA/A6OreYraQQyEl68OwBhb
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d523d215-758f-43b4-94bf-08d60346dde9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM6PR02MB4458;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;3:siw8z1ZS3GYkM7gqjQHkODcwvJgNz4icfeT8p+c+7A8olrZFBv3zjuoJXtZX0t8AkAvMQeezZlawboEQ+/KLatehJT+8Tyb0d//rZjctvD9Z7L/DWWdcdLArknPie+gk3mO17DaEvWGIRwohtgXTA974LAEh7/hXz+b1ZF0kdvyORbN4Ou8bwNgADaTSyNDhiC7zr3w2m97Ycn29Nn5KDdTzTAJ63VeTce1soVAq8cSvgATAWVlOBQ2SxYsCkVCKAwPJ0KHbiiLyZ4lNEIHneh5TSHsZ58Mm4gZflOlfNr0tbxomu03XOUo+G0aT2i0nj+93B+wQDVsWerZ77DR3P6RLo4/Sl2ienGjJvMlowIY=;25:eNCaTiDk7xBwJfifIz7O8YaEtBf8WnSK3Q6S2GVGjQQtTj+rDQIbbvLe9RGtFKDQxJFrspPZKCxrrwt1/GJac5F4bwk4fVueDflZ0Gol2eXUMfNAgAz/IKpZKXQyu3aGnDEa6oa3tAugGgmgJ5bgE4Y/dRDkyiOMElueBuLTQaE2zlJiCXR+iGGLw0lEkc4tr1XpynkLS6MZkrni/2uM1ZCXUHqnZ+p1hMIOXAjr8j7AH7iETu5vBgfDON/Br9n7Ajz8b7HnAwRz20bDCjxLRQwSSm9ZO8qjmPm/4ODQSpM+yqLkfJdjc/g8nOYnwapZjR/TGK5NqXa///kPCOWY4g==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4458:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;31:94KsMOsTe/S4yuh5DT6QHt5EcAXuv49Z5DQjvpwz9ucfB1+UB3GwHfOPpxxhMjzDIX75gaHwXkVTEbLStDIdJJgWV6VpH+DpbAZ5LqsK5zxc9HsKX/HPNmge1kLU55AW7zZAFTEnc2n0tDs/pQzKZ38eN8oBhXOSuSSJIuTscPHhkTlFZ56TQR6guvMSfPdKkh4hQDO+5xAMKBamGXkDDqurZvVVSQnflj6ckxY8l8E=;20:B/InDPV3KG41c2yQb/aRIPL8/xGCk2ik4GSphacPXuik8cchAH7pSMSr1NmygbtCJ27XKVv7yy/EGviLWQaPs86lQRIefAXIyb5dmgk5TnzGOruPVRj3qcuk0NV+brC1DHB0U3Sz7jXvIgSzR2ov4EdHgOMUskxGLX66cIG7utjEpyjG+wXiXgHmffik8AAF6InQt1o6WbKg1w4Y0clToUYXfSqXIIYI/ckJ0PIVtCbuN3X35sKy+fGPhe7NgVmscrelKyAp5fIQP96/lkzmVbolnDkQt5ntPhb3quZaRJBA3xi3URbW9ulW03EbJB1HZGhZ1r0w7tgpV6Dnl+CD7EsybZkmaL1tURj0HdjJ1JrHtXS0RFvAV/M4d4/TKYM5Pvkmi50cYW6yuCTCp+W1kTMRGr3+n/8unulfZt+yneT9lBUqF3Mg/Gu8sjkMdMzx7ewF/ON8xjMbJlzzyDWY8Ew8VzoLIxykjMwnD/BcOsSPrUi0m4yhW4pRhVpSkXCp
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB445802D62A768B5F92FFE00AB03E0@DM6PR02MB4458.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:DM6PR02MB4458;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4458;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;4:b72TZ2bj8MnRNSI42B+vtQmvV4NwLAaHV7ucrXq0Gq2tO+gni7s1wHSmw/INb1M3vCE4mh2+/46kVMl9v0f2quVMa5U4tszct4UK7fCmnAHJTFCU0axfr1u/tSUFukvcAACEr2s9wCCDehWX3AaU+WL2yYBOFSMZxpeRuOY6w6U9KrS6r4PmvADW4C7DhWi45FaMWGLiOhRoYx10PnG8NnSs+3rWKodKtoLU/g9ZW4895xzrNDC9yRoYSvklnYpM8HerMNf3exZKngkkCnxuA7Zl/5DO80XSeFooYdS7QtfU+x2DbGVX1wyYf+mILBg0
X-Forefront-PRVS: 07665BE9D1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4458;23:eY3N2DAtgUW2wIgZD6aArtKZ/w/11K2D/yg7JRM+f?=
 =?us-ascii?Q?RQidzJS1+pC8Cd6GXn9ZpGefuTScuac8nPmFNdxzIMzwAAZAVY/NrEMFM8iI?=
 =?us-ascii?Q?xmoBDey3m27lylIhy2K8r9bCzGdyWtnhQ6cc4YpihE9Kscto8LTRHBCqXxpC?=
 =?us-ascii?Q?rEp+Q0UQ9xnCjk/KBpxMmKpc1LtaHB4rFEIReOiVzfTdc4HdWMsQOWpF9Svk?=
 =?us-ascii?Q?4MU2pw1GMAHZXtiyH/Xu/sURs5AhoRWZmNkzWpT5yKpKGQn6OSnlbasMxsK8?=
 =?us-ascii?Q?iMRsm9+1GnB/dagVOdQZY6+28umss3sc623Ub9s0NWMwmxW3Nysrxu2uuCj+?=
 =?us-ascii?Q?UCrYXOD8Glp6T+w6fYJEYdmlr0WEUm6/7xlkaJEbN5BJWrJL8KuBB2W3OuyK?=
 =?us-ascii?Q?2HyMbwZuA2Dj7A3NlG24LNAWCYSS42h/ih2MIJSlzHWArjgFJuPZXP/37Tf0?=
 =?us-ascii?Q?GOzFHGqQCqab1Rvhyyh93A64+oT8wSFRp3R84bmdGTzrE0k8oK/Dx4NytLns?=
 =?us-ascii?Q?zTfPvoKIVm26Uja35jedJqIJRpwc/wCnhmhonh8P7upi0a/KQsALlwj0qm+y?=
 =?us-ascii?Q?ah3kIDF6yg2b85FbzNdMAr+uGVtgz5e9cXCDWB2n0hX/oKzzMs0BE21lXLMH?=
 =?us-ascii?Q?BaHR9nMMT9eco+bAAuZ8p/ZmHg+uvhdBM2/ead+C9uVPpoTJByIQamb6YT7z?=
 =?us-ascii?Q?HEOFmNl0AyWLLSz7AKjSGIvcQ47sjnuKqCRs0J//Ylu2iSb8vo9UypWHJ97C?=
 =?us-ascii?Q?Bwge0gNf3m67w8zz9gAL8efHr/f1CSiSQTLARhigKb9EjLSvXn1749cjuftk?=
 =?us-ascii?Q?mdVwsKNj03UxHijUCzn91N9fltMFKti/pFv1uIMbWcq7qeKeJIrrmjebP47O?=
 =?us-ascii?Q?HNAipXOdOR92LM8qXvVcd5qigiLQ9Qi/dTU3ZaYLsUDUorNKwgFc0FFOH9er?=
 =?us-ascii?Q?qpL34F8hgOFSgGuXMQA/VqvUUjxYHifIyO2x/U/KpDmOGjuv5bngHS2VOiHi?=
 =?us-ascii?Q?lKB5JHYsA97P/Q3NC0mVq0D27Pj+INZIlNyhzIj1+byLBcpB/4YVE8vWCZI1?=
 =?us-ascii?Q?YgBoeXbpgif3r3Q2MRbHe/9J3HLfF5vn4iejF8UaHFJyzvMOIVXHls+PzyJA?=
 =?us-ascii?Q?5MwO8Z18D4qyeFdrRmj+W9ndx95kmfWuT9MeyDs+ayQqzRY96p5yA5FtEJ38?=
 =?us-ascii?Q?77FQMXhbyimlJQ=3D?=
X-Microsoft-Antispam-Message-Info: 1hmy8RheJX3ijaQKsJjSSYqwwwYg+BW96wNDNsm3SuQ/VQKfHnvEe7O+DWMnP6o82hOOy/Ll/g0jj5oMArMqFeo4XF62mFdc6aZZ8Ri7VKeqYxjYqXatlTBZdhs3J4ekzbf17S8PdM/9CHeDWSYSdzMCznxQ8lnwYcYe8i0+UhWSno+Vq2KYRe+6Xo7sGU7nOdeSUenBfLf3sbUGlRDcjH5YNrWipTo9FewauLS+wKTw0tpQ3kJI7ETDe9f/SGUdsVYpRGUPcASLQGhLtsta7AFIW7X7pcV8Wj6m3qiDqqpdG3OHxRAhXQdKvhgdkyL2ASmlhy9guQQQIKH55owYAJURiTJeQ48T0og+2XSVpII=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;6:Y02pHt7gcnx6c6YkHbeC74pbhyZhrkijmnFcjrE7plH4bTIe32IZOY7wvGLj9xckGzKVpl1lK3oaPKxqzlkoR8bQkgOK9Zh6a6GJMqD2sTtm5aKQDoyPX5mqesFlPNTGtvuMAxqF1rCZXejUU6NsqEOZZnLbE3OzligGLh7RcrxRJZHV5tZhGDC3hleTYlChJVQtBlOIDQHZDPYiIH+qaYj1EtDI2HAabSp0/ARk+Zli6MBmWJiOPXvtZmh2qO1WWLXlern91uSjjR2t/xErX83N9rmeqpmJBHDyt3jECU46xgQ7ccBRbWcDl9aM4VmOs/sCztyVB7wxqyPwugSfcnNRgcSlYAKasGd9HGeTBgI506aD3COBY9PVJ/vhN5CwtauCn3e/tEFqevCDL1POz+7J5ziPeevpj9lxOd5GA5VyLkkfItRt0tg6BYPaHrmI4dwO0+5+dpVGYttGcY/i1g==;5:5swosx7yThgPgFMIKKVFw5vbzkE2+zLs6LjFPzjidAfDin9R+Z1iboYICe8bvQ73+dqN/9YIyAN6LBdVTrrpaP/VpGi0rVIKYXfuPj6eNPKMSthN2suSDiDqjoklv6/pv+ZGvO/480RB1+XaqoU4hBQnypkTAD56jLHfME7lRTo=;7:khm3/l5ZwBs1lvUHU3gydSqkFUnJ+68EER2EWZUiJ8idYHiDJHdPUBakjSiRJKIzKVKf02Rv405Yz+UZ+E+EIpgLHvZ+GfEWe6J4uXj5ccaCE6BxaOVepfhby6O6AqPu9sCzxp/uWvz+aSjK7TTtnX7adYIA9Jz3Ud5mTBznKfmj0WfAMuFZIR4IiPxGFdIpa0mcMx44s/Onl56gMvGuz22GfVA2ZAirynvr1uR+gpzKJRXNT9JqRnHwsGQ86oLG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 07:07:02.3451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d523d215-758f-43b4-94bf-08d60346dde9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4458
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add firmware request ack enums which will be used in firmware
request calls.

Signed-off-by: Wendy Liang <jliang@xilinx.com>
---
 include/linux/firmware/xlnx-zynqmp.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 9c4258f..e3b7292 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -32,6 +32,12 @@
 /* Number of 32bits values in payload */
 #define PAYLOAD_ARG_CNT	4U
 
+enum zynqmp_pm_request_ack {
+	ZYNQMP_PM_REQUEST_ACK_NO = 1,
+	ZYNQMP_PM_REQUEST_ACK_BLOCKING,
+	ZYNQMP_PM_REQUEST_ACK_NON_BLOCKING,
+};
+
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_IOCTL = 34,
-- 
2.7.4

