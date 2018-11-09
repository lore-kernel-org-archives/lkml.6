Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C0AC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 05:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73E02086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 05:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="lfMbInve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B73E02086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbeKIOkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 09:40:00 -0500
Received: from mail-eopbgr730061.outbound.protection.outlook.com ([40.107.73.61]:23520
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727485AbeKIOj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 09:39:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roeT6PkHh/aVszWzaBzPoWO0CPTmw2vcQ0b//vsu+rQ=;
 b=lfMbInvecQDxxPPZfkVNqWL4jeVpGGgoVfNxWCPj6QzDc3lh7q+K9eZlljHyEjZPPtgqqTn5OUizCFCgUC6XTchVsSZhnKE34wGNTD6LBKRBiLQAo42SYCVg571/TLJE2MIjXLp/KElSiTNPKaMlwtcsBwkTlIeHuWuqRYRHKYQ=
Received: from BN7PR02CA0032.namprd02.prod.outlook.com (2603:10b6:408:20::45)
 by SN6PR02MB4463.namprd02.prod.outlook.com (2603:10b6:805:a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.26; Fri, 9 Nov
 2018 05:01:02 +0000
Received: from SN1NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by BN7PR02CA0032.outlook.office365.com
 (2603:10b6:408:20::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.25 via Frontend
 Transport; Fri, 9 Nov 2018 05:01:02 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT046.mail.protection.outlook.com (10.152.72.191) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.11
 via Frontend Transport; Fri, 9 Nov 2018 05:01:01 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:41608 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1gKyuj-00049e-Gs; Thu, 08 Nov 2018 21:01:01 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1gKyue-0001Kw-Cq; Thu, 08 Nov 2018 21:00:56 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wA950lRU025562;
        Thu, 8 Nov 2018 21:00:47 -0800
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1gKyuU-0001Cd-O4; Thu, 08 Nov 2018 21:00:47 -0800
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <boris.brezillon@bootlin.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <michals@xilinx.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasuresh12@gmail.com>, <robh@kernel.org>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH v12 0/3] Add support for Arasan NAND Flash controller
Date:   Fri, 9 Nov 2018 10:30:38 +0530
Message-ID: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(136003)(376002)(2980300002)(438002)(189003)(199004)(81156014)(8936002)(50226002)(63266004)(16586007)(50466002)(6636002)(51416003)(305945005)(316002)(7696005)(4326008)(2201001)(54906003)(81166006)(8676002)(110136005)(2906002)(217873002)(478600001)(7416002)(36756003)(5660300001)(9786002)(77096007)(426003)(106002)(26005)(106466001)(186003)(2616005)(36386004)(107886003)(336012)(48376002)(47776003)(356004)(39060400002)(6666004)(476003)(486006)(126002)(107986001)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4463;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT046;1:ZYGydmIhmq0UJG1SvRhRzmahNEqdDhLoZ8bGsoEaBtVEDQgFS2vfjITE4HmiLArZfiu896gDfZtvBLAqlFPY3piiQBDvyCCtGYcxoLsK1lnfS3yEwZ+zkrlYXDk96JO0
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6761f0b-0250-4e1d-92de-08d6460058ce
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4463;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4463;3:o4swIpjyvAoNs/X8iIB1EoycbECYefBGqvQkoalzG4+iStj/1E81/RylNEERgYQNIYlrqzsr+IRlM+6E9kVhiaAE14s5wRynJbQk/2VonYEJ4ss8dIjI/iQKOtJtik2y3dOA9/fvG2Ji8czKmyR7D+OCZNwDu2WAz9qRua2w3dE5OaVY62KmgAxIV7l6Xcra2U2Yz/+nR+OgNQoVyseYiKSphdWGCiLjXKZvNggXaj6tjMdnHV55H+svWHcUvtnWU2R+s2bGhHDQZ+7TjiZcY4crg2dFzMoc1fQxNKq5+dBrFNsGbdtKu0yItO/A5IS+OK0zFXx6JiE8YkTq1stDR+XHG89qi8k3jK9eG+URepY=;25:dB6xYH8+Ln0b1trUCr9BDaqpsEeUneKA4qzlwqPa6NKkNgbtFRjjnw+4YdkC6KC2VWnmfNN71E3fvrs8quwITWhSvNsDYzP0tAgjGIWyVhKdgwd4Py3v0Kc1dJlwtdXL/A/RVntjUCik9ptsj4QTPU8I6CI98gCPorWHYRoi9bRX4ah8Q3KfDUeW8m1HOUvnM6vSYSjly3vUUllQ1P3cF4ORDf8rNw90u9tqt2BAVv46X1HPORsIisrIdC3PEjX+cO24/yL/Ov2MzaJRTH9nq4/tCBkWu/4YVYHdYTbuDXwYBED/UfU8b1Cr0uU9Wx91YQypaN+mIdVdavuqgLm24w==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4463:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4463;31:qwl6yfvTRh3LP0NoQs52WK0woQibOMV44YKx3tgGZQsQAfKVC8GEzMIWxwiUxiNic4yOv7XtUnQaBzODckcSrGMQSyFIa6DeyZ1pa2dwQxXTpD0wS9EnDZW1CjaGFpUDtlMcGe5UuH+o1G1B0eMULO9FYQBmr6FaJjusF85THVfbbxrp+cWVMfijTcCuaJGP6xF5NiS4YqgnG0GTx1ALQfiUWYSrULXjJzEPNaGUc4E=;20:F+WfjyYHfZNvqo3uTHlEy1742K9eU3y2de7tQ/GDJ0b7mGSPJtulMqD5sB1VS9LDy29sKG+bt3FRTrZzQrcI96ncqvOORDDjMqIkqqefjGDz+x99fkP6KbEBJm31I7oYGMLBbi8eEyXTG6yFaU3cZsRthJ9Qar1/WnV3RgAAJXEGjUYeP9NCt//4oDLPAxUZiZT5zcQiG9a896bLF2DN2VESv+ab+hUpjmAVxKve3iMNL7uPZM8jVvJdqawstkq66/knOIvZljYd4sFAjWKMeUSNO/3xdobjun7XX1vYx1/DckVPwsjATmB+Wq2BbUy1rF/fNNVUcBSGYHt0AUGjygEFLx8b2ALp7GOOm4hp1MnCAlDRVx7seEu+jsegiqTWq/Ks9FUU35hmkHW7Cc+9j3mv5fPbwBTFZPvY6Sb8yxy63rJ+eH5fKVbnv2mkVC08nLUqutwaQfatDnY+ifVw+D1dsAL3+5AIRYj9rqyj7rDzp5Bx1dpfKSidxBCTGUzW
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4463F6B311FC86C3D74785C7AFC60@SN6PR02MB4463.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN6PR02MB4463;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4463;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4463;4:R2mu310CIrOoOMvX9/loeuj3/yEo/OAENEFr5bttkabsH2UgtruPOuWgp8Uv+br9a/WSL/1N5kRV9i2yluJ8EaEfnz1wLKa+vimljnVTE21tpUqg8hWmgW56bAhIGiRiFiM9HRDHcKHsEbjiI4eQpQ+QY2uHE7M9g2BLdA4eB+2gr2eUAuGlFq7DtXEYBrJRScaGS4Cuql2JLrKYW5wWzcJlKuPo7NoB57+PwEliGzr5XdI29lc70Ubq64We0oG3tkdboPN19LFYjw7Xv6muyQ==
X-Forefront-PRVS: 08512C5403
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4463;23:BXwVBY8Y1hSbDfzxAZEMLmkwpzAX1LPvXJM0ueINR?=
 =?us-ascii?Q?naIu0F00fCswp59RexOs6Q6l1HrOJeHglHqbR4JS8hxllGvr6B/yzQchx+Zb?=
 =?us-ascii?Q?pq6msGINfoIgbfr47sdDpw2l0O0NuFbvPBoJyexHlJurFYn+eOzzYDCCEEPE?=
 =?us-ascii?Q?UP6RBZH8VWs3nGGhLmvEFxSDxNE4yjWhjHrfrIC3BZcCfGLMxhgcExixjbTQ?=
 =?us-ascii?Q?orYaOy6A8fB/bZ2umhafZfaLlezhFMgKxGuQbSdK3J4QTLYvTQYI4t4dQjOk?=
 =?us-ascii?Q?SF55yAiuNOoLL6lHcwcMBEW50jkzREgKbqQ1w6CRV1215TgIPUbdTGaNxsCw?=
 =?us-ascii?Q?+LjykEhU4IZ6+Ry6gjEuOeuO5xO6m2q66ch/NveCSsheMqPEjPMrq2hat/3y?=
 =?us-ascii?Q?iTdNeeiWhz/oGmFPjjaRPdCDSTRhll9JMNhcCQTpGA1qtZTOFzdN2fj/1Hj1?=
 =?us-ascii?Q?572u8+nYdimjCAX0xc970S2yJ66g15RsXtJdw0f0U8muzaBHJ9qhcgViLWG8?=
 =?us-ascii?Q?9AZnGj7hbVqLHiqf2YSd+3s04HVrxDkxC6RvQZZRJtrE4+f2m0ug878M6q7m?=
 =?us-ascii?Q?QaLBTADU57m0dpbJA+u3BebHwMveqZ/Qd5oAnFoRoWHIP3vCHdq/L/U9Wr8J?=
 =?us-ascii?Q?97tVZgSwZB7yszrBgh5HTh6EsEn5tWx6W4HzeWo19m/HbuRkW1NodcMqgiwg?=
 =?us-ascii?Q?ZfycomOojBvNTwjZ0luIkTa2TTqiG5WsdOUM4ov3x63cdpFymbYxslijOfiS?=
 =?us-ascii?Q?wuK6cGt5t/B/FIeGEbu1M4/Bv2HYQoVTxNNv2FNJAVUji0MaMeeAqVeEQd8v?=
 =?us-ascii?Q?eqJ1JMvLhb5XQkPeKJ/GnT1a0ZMtG4d8dCVHNQbQmZ7tDY/lIrMC9eMCionD?=
 =?us-ascii?Q?LVhMVbxCW7T3/QIB+izxVSmEvjQqk5ZSZNuMfitRiH0+OdNF/il7JKyqFssl?=
 =?us-ascii?Q?IvVLKui1oFsovebllGZaIHWV/iSyyrdvMFVrjsZdNeq0DWAak3DmwEfPDva1?=
 =?us-ascii?Q?U/4SiB14VNKMQDcFQdSJR7QpIIQOhh8SRGGMlovUsdXEp8V9Pqelmkt3193U?=
 =?us-ascii?Q?YZhS93Alvex4YP03nC1TFwI4Eb2SfLBwK4c2MM2RmGCngFzJk9o+gIOKrUf1?=
 =?us-ascii?Q?BMtUZ/Sq4zd78lLSfKVqPF01/WnBNJo7cqScVF3YTQznYwkuneI6cuVuV6kT?=
 =?us-ascii?Q?rQdwNGBxuSt22aCejhGIV47pfUgnfgM6rcx?=
X-Microsoft-Antispam-Message-Info: 1JUsLLMZBzu8Ow6RDqhSwErIavctV6iu9+VMveAufvLHCEVScTC8kR8fN0pVYpO+khHGTTn94YxUYYaLixixz+xiSF00A5aaTyfDdBLqWjZ8PjrFyyDcI7dL1U5Y5Vy4zPkjYZAv1q7Hp1NW0bRn/0UPnDcPIH6/NsWJsaY1dgk6Q/md/3fk5Bf/klTWGy+MN/ON3xKLi5zDRJmKE6kEMgIcgKufCGZZb5xW712YOdE07NBdAqHjfaabxzM3qvEn9AAhwdFcoAwuLy01iXJb8sgmR6uarl3gxzBcy3spANLxH7oC+JnwecITxzzijwPurWL9Aua2yqFIchbjBYtQBhTO6TXtPp43qo7ONufgcSk=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4463;6:OlheJDZoG2XuQXTtHKr0SBK8b+wKqE9dIEDVozmBYz/Yb0thy41d9W4knyElM2kip1ldhjflUEq0KJlHDLWpb8HX0ziK/hb4MpeGtTSNglVWiV3LR22HJiw0io6p7KzF1Gn5Ef9xM5sP0aR2kASO+V31OOQ47kv72/YewkL1IRZevePde1yMAG7+AfoyA6IR97otjjBVkrJkRioyZspOKoH5x97vCMkfZWJIU7f+2rfkQMJNxiIndbDzh3cfglYuedEOeN5z4HXw5ZljPoBGMVL9ZcfIxyqDzz0yYBU2mCmFe6SgtMp7Y8Lm5/x9IhwyT9+hPztvajst9ctmzZiFF+O67MM8wWT3fPckt9KFBhHMF97ML73FbgBZYHz0Ifq/pmVX2EE3MkWj0HMV9dlyYMjE38UouGOJR6c6s4PrzksSpUyRYwMkC0iIuHPIk8vWv1Q0BfaNqH3cRkXXQfsNXA==;5:W9u9x16XxEC/1cvwb9A5UM2cmzQnyse6x3lTE6E5TSpcyaz/vzyt9xvBrvxfvCbzLiUA3DMlHNLdPOryX0LahcAtWqGyu8ODC/MhSes6g/sK3UcKsiPe/m+HmwtE5pzsAxEOOyXrjOE44HOLTQsO2Dx3kt+WyDMqxv8M+1Y73ek=;7:mMVUejWethEy1Iw6lYobntP5YWDa0ZRrB92C4qTSvnrs1Rav0wRbhweu1tJw8wvOWLH+X6WDRhFEwC5OJfQcKvSuSRI63cBMLV4iWQ0LiDZIQEelHrwbfsm+6aacjXoqQw6a6dmy8AW4OX2LVGFKWQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2018 05:01:01.9318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6761f0b-0250-4e1d-92de-08d6460058ce
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4463
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the basic driver support for Arasan NAND Flash controller.
We are reinitiating the patch series by fixing the comments given by Miquel and Boris.
Major changes are exec_op() implementation related.
Rebased to 4.19 nand tree.
Tested MT29F32G08ABCDBJ4.

As suggested by Boris, it also adds a new varaible called mode in struct nand_sdr_timings,
which will give directly the sdr operating mode. and it is useful for some controllers,
where we can set direclty the operating mode instead of timings.

Naga Sureshkumar Relli (3):
  dt-bindings: mtd: arasan: Add device tree binding documentation
  mtd: rawnand: Add an option to get sdr timing mode number
  mtd: rawnand: arasan: Add support for Arasan NAND Flash Controller

 .../devicetree/bindings/mtd/arasan_nand.txt        |   32 +
 drivers/mtd/nand/raw/Kconfig                       |    7 +
 drivers/mtd/nand/raw/Makefile                      |    1 +
 drivers/mtd/nand/raw/arasan_nand.c                 | 1238 ++++++++++++++++++++
 drivers/mtd/nand/raw/nand_timings.c                |    6 +
 include/linux/mtd/rawnand.h                        |    1 +
 6 files changed, 1285 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/arasan_nand.txt
 create mode 100644 drivers/mtd/nand/raw/arasan_nand.c

-- 
2.7.4

