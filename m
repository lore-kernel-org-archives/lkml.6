Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E541EC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87576208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="f8alJ/OY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87576208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934692AbeFMHfa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:35:30 -0400
Received: from mail-dm3nam03on0068.outbound.protection.outlook.com ([104.47.41.68]:39839
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754471AbeFMHfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZbVUoYRIPW8cAOoI0k/nznKQGroioJ+CdeutyQJnx4=;
 b=f8alJ/OYWLHeUiczjxbK6HlyQRQ78NsrvGSeAv5rCoxptaTMKbr7PuFdnKuXKoX2jeeL2AXPmGrfOJ17uvkOAeSdJlBWRBqs8N231QgiUvbOHqiT8zTxKAgQDDJmFNck19QcZU+ISZ4o3018WbUdLYZffkZ16cGCnEUgu4hX4qA=
Received: from BL0PR02CA0035.namprd02.prod.outlook.com (2603:10b6:207:3c::48)
 by CY4SPR00MB2380.namprd02.prod.outlook.com (2603:10b6:903:76::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Wed, 13 Jun
 2018 07:35:24 +0000
Received: from BL2NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by BL0PR02CA0035.outlook.office365.com
 (2603:10b6:207:3c::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.15 via Frontend
 Transport; Wed, 13 Jun 2018 07:35:23 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT004.mail.protection.outlook.com (10.152.76.168) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Wed, 13 Jun 2018 07:35:23 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:35808 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fT0JO-0007cx-VM; Wed, 13 Jun 2018 00:35:22 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fT0JJ-0003Ht-S4; Wed, 13 Jun 2018 00:35:17 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5D7ZCai014891;
        Wed, 13 Jun 2018 00:35:12 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fT0JE-0003Gg-EU; Wed, 13 Jun 2018 00:35:12 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 92EA8B208D4; Wed, 13 Jun 2018 13:05:11 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <dan.j.williams@intel.com>,
        <appana.durga.rao@xilinx.com>, <lars@metafoo.de>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH 0/2] Enable VDMA S2MM vertical flip support
Date:   Wed, 13 Jun 2018 13:04:46 +0530
Message-ID: <1528875288-9140-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(39380400002)(396003)(2980300002)(438002)(199004)(189003)(42186006)(186003)(16586007)(8936002)(110136005)(2906002)(36756003)(36386004)(426003)(54906003)(26005)(316002)(305945005)(81156014)(48376002)(81166006)(47776003)(336012)(106002)(50226002)(106466001)(51416003)(8676002)(356003)(63266004)(50466002)(52956003)(90966002)(476003)(486006)(107886003)(103686004)(126002)(478600001)(2616005)(6666003)(2201001)(4326008)(5660300001)(6266002)(107986001)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4SPR00MB2380;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT004;1:h0g8ZLMMe68MNz9JyW0FAbB5N8LRkPtfdHa4++9xK8h1xFGi+tytqYosRD4HovHRQFPo126Q0iWKDK0XR6auIw3EIzIxhjhusC9wWRQhlzq1ulunqH4LpNGFJBy3qJdD
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab46d134-cfb6-457a-6b86-08d5d1003986
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY4SPR00MB2380;
X-Microsoft-Exchange-Diagnostics: 1;CY4SPR00MB2380;3:YRTUuvSsJ1byWdbj89kRL8fVc65tDTDY5n4YVde+wwv27Cbn0cixt/CciJbfJlU4v3LOqQgVh2e/A2ELvuybq2aQpxmIwZzrXZ5UGpwMuOSBpkjMuFJ59nhnmtuJeBeIENUty/KcBGZvZUROU/zMn9RmkbSQo/g/E3LcIN9DArMPLWeZED5myWL8Apb3DHfXzpKaaaHFSsuTm8LKmoyWm1mzgFN9uHuTzBD1HHiP1EPM7eP2IuE1xzlHu7GR0Gj2JanAXWUv62Y374CDoCxJGPrXHbWEeITA44zNpP9bHWbb20h3Mb5bZSLv0xofOFGGFxyyTbFFlDZLsb2dIjPbgK4IaqP6SqcDhs6UKqS6OPU=;25:mogdagu8C+1eGWDoC3DF2nYLngJMXgsme6wylszqJyWrMRMkRDgrVW8N8tG1xhKgq4BhSHXy/36o3hBIxk4hkMAMUobyOMaLR7OwoaeESqYgY6zu81r8frPP2Mb8KZZ/7gJbz8n7PfbTKLtyQW7GyQnjbBQuHraRW6uDr6D8BkiqX3A6jmn6lYwqdusLQuaGgtywrJKUVq8tagt32WHTphUFULWLvqh3Nm5FdpD2YhecdQNFu4YkRKMq+scLATlLjqIb4GSfrFXljw/3E0itIlFaBHPTbYm9OAEorvX20JUHUzrbCRm0ooCDfk+i1t1a9FHpjxb6YhcZs2iqTGojxQ==
X-MS-TrafficTypeDiagnostic: CY4SPR00MB2380:
X-Microsoft-Exchange-Diagnostics: 1;CY4SPR00MB2380;31:5tudth889ZwoJbjEQp9avcr2+WsUcwinmEgS8J/IkIz6q/aW2IagiJno7KNd9kVjgtk8orEeWQBr0LIt+KHlC+RlKI/l5a/tLpn94cFq8VOXugpxyRFskyEu3YekBnKUJpibV1UDy6x0I/Vqcu1iWRbE/SsMoy65glqrQ2q3AJNC25l+gpKih8Nmh7vXhQLVPT9Zb4u7QhiK0MDgBOPxG3nj4DR8hXiRZSuD6dwyrX8=;20:7D6m4rifEe0qO+1l6aZ7pM4PgxCHflPEe+4iZZR0GqBa7X3STxCQ1pfFRVNXG4tNxt5fwq3kmPIPc5zjfCpM3OMUlBSqj6luBDfbruPq4kZMveeShUVhJI7QVKJIkNE/YzHDKFF3rE/rvsDj+f1BZESB1IgS3JwmxXSvx3QiHt7VzF3KVPTXks9leESlKHFiVilmqdY8+TsPgJrNhgDSCvFgUPUX35ThmXeqfURbY1rQzIt2aoKIh1Q7a3ZEZd6zHYdVsiXbqKidRjob5N+F9cbfk4Krmek3PFqH3qUPNBkulUIuAij0gxw3LnCO+z3f+1fgoicGylb3kVKLWOuM5p5qCxldR0IMwDxtWOKhAKdDbUkCVYIV7+O+kllEag0F0cFRdzBLnNJSpD8pVBQs10rZGhrd3z4KHklFBiHlV1DO68oQH+s66KwNmHaqOr3+Uy2AmdKzSd9VsiIk8cIPPViqXJGHrN4duPKKWDC7BBvM6lIS/PJoLNbOGWY4qMF2
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4SPR00MB23806CDC0B76D6C4E366C438C77E0@CY4SPR00MB2380.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY4SPR00MB2380;BCL:0;PCL:0;RULEID:;SRVR:CY4SPR00MB2380;
X-Microsoft-Exchange-Diagnostics: 1;CY4SPR00MB2380;4:NJD4/pjQqfOidc7Nto+7qS+/nkBadteAtOOqbWOPc95H11tDqUKd/c+BeaRbEa5m4eYb1jp/y+W5z54ieNuq2ZtF4By4Qo+Jsjsdfvnqw/nK2ipVfrV2Vi4V7eK5wJ/zmvB0/GzZRq4eVg5/Kp8kXeBwn3C+saT41Lc6VMP2VMlQtBEJTUx6GURiZiXhNVaKSoPxfYMBo1d4oHyoLHil5wP79+mn4ykGA1u477EcvxHLkogYSW6S//pTnNcJA2aGikgK9m1vhKcJz1onKwfxXg==
X-Forefront-PRVS: 07025866F6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4SPR00MB2380;23:6ra/RhpEtFQQ7snRfOJ9QutrKi7mMNh7jarlxDCu?=
 =?us-ascii?Q?dwwbVvEjRRnw+Fmtq1DbqIkNbzLyQcPJgE1iE3rxEl0D+ZFgCEwi50/s9AxW?=
 =?us-ascii?Q?NEWY8nAMJIbF0imFXu3nIh9/WFYDfs7a74gl+v7fZ7u8QwyTfU+fMjAi8L4O?=
 =?us-ascii?Q?zmyLNCHUJibAqirNPcvqJUcLHzA/wY62bFBokwX6mHALcEO5Ezy14RP2pRoU?=
 =?us-ascii?Q?XSoga9L5EsQzFs0ERUM3cr42gPdEgPdVvEDCwKOJakxHteF/MVab4lZH1Xi8?=
 =?us-ascii?Q?SyH+9XoiuIJ52Nafmq9wDOYS2EjlaYEn8aKy/tdYa185NQPawksZpSaZEcnQ?=
 =?us-ascii?Q?NjCXycpk1qSYZPnGYIrcavbWrv++cSL0OKjFWvw3IKm9+BwiYM92IKCvdFNl?=
 =?us-ascii?Q?hm/9+vcvB2J/9/Nrghuq/jxdDnbW7X8jWw+CGE+bcy3W4y3JklrD4IvTHrZ9?=
 =?us-ascii?Q?zueGIw4rithSuvCwfDGjttxEJ+/mEAg46kx49ekprBgI2ET4rXy/oHuaW2J6?=
 =?us-ascii?Q?c2tyjjrOPNhHcVQahAfAvzwZANT3Q+WkpN/iLDP6aiAOaygG//K/1Jx5J9aY?=
 =?us-ascii?Q?N7Xyg+nKwUQrZ5uYMm6FPkyhj9MArfp6M92lXOhTL6T3QTmtXlQHqq58+fg1?=
 =?us-ascii?Q?DKQw4hEKPNcmbX2+JfBcHvMkBcz0pfGwEY3c/OfrLGxqNilE7XD4PEezQvJc?=
 =?us-ascii?Q?ibww306rdi1cbBN/s4U3f69n+HnsPexomsadAuslWqkt6HKVpMqGSFN5GRQt?=
 =?us-ascii?Q?iDtkHrn3yCU6iJWbVb+UPZEfFJRoeRGHUwQCUUOl/rjjnD0iDpfC8sAdq4z7?=
 =?us-ascii?Q?m0GcivpHdd2yEnPTbGicDTpdmHmsJgyfu/uI0fcSdBHuItfA8aHITo5N55O1?=
 =?us-ascii?Q?eoYIHivuwFTwun2HqFi1NH3b4IKhlN+1wNihPCgKVnjDcOc1+JPyb5MvKnfm?=
 =?us-ascii?Q?ihhMi87OXXGGW6sLGLRcC8Jdug2tnfGymBLYWZE8/h3k/Dhse6bUdLe4nPkS?=
 =?us-ascii?Q?ebDlsCZ7PkK1FzPPxtb6u8J7JmoJkOcdIIjbvmWu+iGcwXvZDQJEHcoreNhp?=
 =?us-ascii?Q?/BXPL2EeQrQ8iiq7BiNThOLVNnzxDAYB6Iv3PMAu2Z9SHWJSm8n+SqeJniGt?=
 =?us-ascii?Q?Zle5k/vBlrW9SAcZEkRn5q9S5NKqeE+X4K9ap968xd1tVcCrfSNqpuBrTr83?=
 =?us-ascii?Q?7ZOGrw+tugZ0CDg=3D?=
X-Microsoft-Antispam-Message-Info: CN0NpY1/EwAdpDO+yKRRdo/Sv7nagoosQEC0/LIAuZUTXEEznYXTX2m9ELqaK3tAbAV4/FddZmkkJDc00+RDjNBmDhy1guzTBguIpANuc3H4kQc05Bfk2Nwf6+JlOid2ocYz9bSX7nAJBfh69H8rulGc/o7++Xszq+BK3q8gzzxjwVkJt6SHz1swMiTml7tB
X-Microsoft-Exchange-Diagnostics: 1;CY4SPR00MB2380;6:+25x9nO8RCmJL5uEruPLty0xHYHkg0bLZx4370nYvFVwnrsZa3GQdo0D0icX5F2gCSKmkEMt7bZEdtknSsmVSupdxzsTro2ITpJ3jgFWKocP3raGRztpwjcNUowXJruu9hEVvjAx8tgWJJSq5Kfn7qy02/rFRQ84m+AG4OmBOmTLV4vEeq7/SRxS3Bm5eyPrd+iu73bThi0BtSYox+Hl3EyuWKQsak4JnUmvep9UdGDvoSZOicH2vbaf/LavenXlyZzAQD5QkNPrk3oy0eWBGvySWS+ipGcJHXmU+ge4MpepnRab1QC+71YBNFnxxkwjKn1XbjBwdxtzOKJ6TWvodwSUoUO0CelBq3TVmD4Cq2ontqAw270Jmg0EoKNTMa9Dh8BfsLrv2b6CHyBc8fAh274YV9cFj61O4Gvk/4Q5YZyV4L5YLc6Hmwmw8H1drI4TRDcshzG5zX1YvNAxT0c3GA==;5:w7Nm2xN6V3IYzV1c+5KJTGUPuSoFZy5tMyziWOptOEnvEwmWQafsBwJHk8dLepTKOkGMndLEV+Sed6X9ifNIJjqENLo822pM2Z29C8tBc0G1lmodFYgR3PO4YB8WmkfnKVx8vHVL7VvVp93LNetAzqvE8D/DRU9SHRfnB2BpsEw=;24:cWOOqB4z//dYtCWdVFzKZkKRL1/Oe9b2O9a48pVgqOxXGso8GWHlC5szazHHj05FVWoNyQBYNb3SZo322ew4MiizmRukwG5nDWrtDoB+KD8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4SPR00MB2380;7:7z77gacpJEe051RXWIKWqR/lazMio54N99M9/0vN6vuJH5yp5Gi/XGJ2FiSPWsthF7QiwInhanEada4q3UcowOU/g/4TxdcMyX5CnD3Wzv5LEcLOMCJT5xXgG9PeL5vObfccPcVe3dj4TOERUlB5SD2sJF3y6BbqGY2BcnVF6qzIQ0WUCNTMe88STIWU89B/+H8NM/Z/aFhcg8c16E+79EkA00+6dYqrEexAlpmxjUXlMAtRa1flQO09FUiGS//a
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 07:35:23.6390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab46d134-cfb6-457a-6b86-08d5d1003986
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4SPR00MB2380
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXI VDMA core supports Vertical Flip with S2MM as the path when
Enable Vertical Flip (Advanced tab) is selected. This patch series add
DT property for vertical flip and program its state in VDMA start_transfer.

Radhey Shyam Pandey (2):
  dt-bindings: dmaengine: xilinx_dma: Add VDMA vertical flip property
  dmaengine: xilinx_dma: Enable VDMA S2MM vertical flip support

 .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |    2 +
 drivers/dma/xilinx/xilinx_dma.c                    |   22 ++++++++++++++++++++
 include/linux/dma/xilinx_dma.h                     |    2 +
 3 files changed, 26 insertions(+), 0 deletions(-)

