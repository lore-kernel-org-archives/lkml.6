Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50596C07520
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBF62133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qdkubO8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBF62133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbeIMApZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:45:25 -0400
Received: from mail-eopbgr690041.outbound.protection.outlook.com ([40.107.69.41]:4000
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728138AbeIMApX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJzB+KnyFKhLEmWrAsNYQ8EP3hzk/DxRcJ5zh/8+xcg=;
 b=qdkubO8sE65/TPM1WDJTkI2WF24nIO32ajawDOypfRFDLSOlav5HtnUBTdOGRfX8juFSuQA3JAB0OT7+vukA9dgNNP0RszjHEsDELflR7GB6y9zrv72T0Px42gMLsb23hMHTdTDOcdybzV+Cif/hibuBZm/NgJL73ztOPlkNIDI=
Received: from MWHPR0201CA0100.namprd02.prod.outlook.com
 (2603:10b6:301:75::41) by BYAPR02MB5112.namprd02.prod.outlook.com
 (2603:10b6:a03:70::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.15; Wed, 12 Sep
 2018 19:39:15 +0000
Received: from BL2NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by MWHPR0201CA0100.outlook.office365.com
 (2603:10b6:301:75::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Wed, 12 Sep 2018 19:39:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT047.mail.protection.outlook.com (10.152.77.9) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1143.14
 via Frontend Transport; Wed, 12 Sep 2018 19:39:15 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g0Ayo-0002SA-PJ; Wed, 12 Sep 2018 12:39:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g0Ayj-0001JA-La; Wed, 12 Sep 2018 12:39:09 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8CJcwr3003381;
        Wed, 12 Sep 2018 12:38:58 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g0AyY-0001Go-IY; Wed, 12 Sep 2018 12:38:58 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <olof@lixom.net>, <michal.simek@xilinx.com>, <arm@kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v12 1/6] dt-bindings: firmware: Add bindings for ZynqMP firmware
Date:   Wed, 12 Sep 2018 12:38:35 -0700
Message-ID: <1536781120-22794-2-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536781120-22794-1-git-send-email-jollys@xilinx.com>
References: <1536781120-22794-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(346002)(2980300002)(438002)(199004)(189003)(54906003)(9786002)(305945005)(5660300001)(16586007)(47776003)(2906002)(50466002)(81166006)(81156014)(106002)(110136005)(316002)(106466001)(356003)(336012)(48376002)(446003)(426003)(77096007)(107886003)(186003)(63266004)(36386004)(4326008)(478600001)(7696005)(486006)(2616005)(72206003)(6666003)(126002)(476003)(8936002)(26005)(8676002)(36756003)(11346002)(2201001)(50226002)(44832011)(76176011)(51416003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5112;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT047;1:g4jRqbCEa1GWugf9ipjoYViOBWtOmOHMh+Inevau7jBV1ESitNL4mf09LNvBFaUDKgsCuu9FV8aTnitQ64mh6B7cutfkUkduo0hjjK/TkrQWieE77TvGZeweUbrCr8aW
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34635373-281a-4893-210c-08d618e76c6c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB5112;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5112;3:dgr6Her3c4+s3jrH+mfH6g4MGa5GOI0waAnP7FhqwYefZOYKjUpj3I57FHAnICPPQ9xWNg3THIfvr7OuQhvniE87U82ppBxRgqEGsSRb9a31wACxiooS5cZJj7jBJWoB6GiQC8CdRpWQoOkRPbDXhWXrDmhW8IDEekLLR+G61P4iaxseIl6ZLu3PYT8mY3HP2UmeSFm3fIR2WafoEGbp9Odb4qVPd0RGnrq76UtMTaDmPkjOZiuT0Uq142yROS6VwCGtBoIB2sqF+pSvPXRiJ5UzOyk1T6YjVbtlS+mHcNR9wHCgHQ7zsGfFT43AiSoyFuudT0kxphiwMXBeIT+i5PrGaIXUWaEZMSauYTxt8v0=;25:gI1cQ5AOGgLqy2sPMTQ5Q258QRc80eqDFd+TIIp74Lk8xehstIC/yIdGnJA9aC0+4WqnaKn7dg5l8AHdM/Wkr0V6lGG22WDAdT5UoQJ4Lxd9m9kGZQLtGHdWq2igl/blYVwUnN1+CEpJx5ajYuxX5AB+yf3GrPB/aR/76TqM78IT4PdBPq1SOB/wWBFPfeciryFTk56cPmaILBhEdUDTlLhOszgsPNoTuaezTDjdIZh1fHGZUGoNrl0utW18wUaSMNnSsDkCfWif/o/ZgBLkmtcOX72vtX2rQKrOHJvJVhIifPSiLACJF3OyzaWwNwR4uNvV8MefGH8dGt0ctIIXrw==
X-MS-TrafficTypeDiagnostic: BYAPR02MB5112:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5112;31:5/hXjShkXeGaSuuSb3fr9qG+a004KhKoH9WGpUX/EvmxNOJtViNJbR3GQb0qzRhk23kpNlPkZE1USquTM6JeMfirpM0K4rDicyp7Pf9p5jp3jU6RIkS8Jk4AhH3150MD7s19/J0H9uJh9G4dHdQ3fV44x19ux8+ACt1vhyBzpWUPKCSnt8C/MXcmbEl61T9LtR4wGGFXjFruo2p6IID6VeanribawrJBsDPF8jkRQTE=;20:AIn1M3lQiurTDj4a37mpiPhflDv8CBEYTWdokEcMKUK50kNoaFna3geNN+pQNjo/OFr97prQPO8q/epHjDpOIgw031fSa7ybv/QaYtn4aLOBiXQSk5SUU4HgQ9BD/F6STGJHThTcqz3/42LxFjOl6upOQMuXVNo195Rqi5VNHRCZ/f0sh4VyrosIvD3zRjwI/rmCxyWKEYFqAFmUj+msVAY2Pb4/5AWpJzZDE3ecKfAIqu1z64ClUB/+I6qlkDc8qW53SSUqq/0q4zKWgFS//oiR/Xdsx5EmXHFKuGoIjuoTa/ie5nvt7rWV3rFTeDlKW+ttVMKTBiGJ568hMeEWvIu1ZYLfbIlvDCHZfQouitowXUCU9L2mHP9eLS/Q0+QsoF5PTsa6n0TYvDDQymTDhnEHTm/iKVyK18DFqBn79pSOKAMH6VxoznRI5jqWqLfMcIVqFNmR/hp/lKTM1I9wS58YGwWan1YLlIyRvq8lFqWsJRTfXtWLPEoWvKoYTaCR
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB5112510A0A985E28D0EEF097B81B0@BYAPR02MB5112.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:BYAPR02MB5112;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB5112;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5112;4:FSOud1zICseVrCbAfGYrTFfbhtkngCDOpR+jdtZDKDGIKbnQV0si2p3tAenjUZBrZfANIpfsnea//LVL4sIWPaA225ThM3CsEfASWGlZ1og5jRQCYakCPGMG04dZ/wg7GuZgEP75E6Orz0I7nNx0WGGFnsRMjxDtvcuPAVScUDp4/kURPX+FL7K8G4/mmCKMfKMdBAYmTgCa46tt/cP30iO6ks1uskRnxx/qYDvDgmF9aAVpO2X3PaD6/xU1g71eShopZO2xPgt+YWHtITIqImAhYXgUUPKE+a3nC2ZxvFCOo66PMI6JYC8s0tQlOv+F
X-Forefront-PRVS: 07935ACF08
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB5112;23:u1Y/TPxDJbTDlJg1NaizD5boS2OKMEslEbF8nWjNo?=
 =?us-ascii?Q?2qBljdfOLLNhWJ+cXU09GXPm9jGlD5SfT6uG3BULmT6pV/B2hUZQD14bzNvc?=
 =?us-ascii?Q?tHtH6kPXyNVITUkVZH0Dl2J4oxOWdjjE1YIzbdaBl3t79FKyNpJWXWJWNgkX?=
 =?us-ascii?Q?EehAjIw1hJM+XkoryekwE0QAHtaE2yclC3aKdATBf0kTiiq3yW2ISkK5pQre?=
 =?us-ascii?Q?r2DfYQ0A0ew7tU69moMnWJfaSnGXE3JE+MU0pm/eTkFbKzxzmCjMnAgLweul?=
 =?us-ascii?Q?aaG9kJxbkMWdOiVUG9BYGWlMHw0qX4KoV2XxycryjceMBPULoPcautc3yiAu?=
 =?us-ascii?Q?TtLA9mxjYpT3eZ51q0cLbUWPCl3ECoZXejG1tRu6037Y2LpP4/EZVbPUCdzG?=
 =?us-ascii?Q?MRRnPv/LXCgm5Rb20HrurhBQ1g5rBPn7GbrkspX304m8W1e1Cgtwi/hFB9Ie?=
 =?us-ascii?Q?kBjn0Dz3USN4483k5AEfXEs2xNsHWmeqt2UAqJfwuTsEHZuiAZGz3KT3cwh+?=
 =?us-ascii?Q?tfc9+rwVkM7sIE2KRD/l4en/wCy4IxvSBvfs0WKbtDInwTaFptZ5lykylyqp?=
 =?us-ascii?Q?aVYdqBUK5Rrmzy9MnIHjdfXyHZQ7BVoJR3Cvf2D9G6hf87IKFp25eibJZwbZ?=
 =?us-ascii?Q?B1w5FIvndXIC5i1cvEwKOedvkAL0supzONWFykQZrK1QMrWcsAgqHASapePj?=
 =?us-ascii?Q?CgROkjys+ykTtlnD4JiNhBx5ipyKm+6opO/R4JU6GyuHEM6obWNYToFxuioU?=
 =?us-ascii?Q?Q2uOXt26HMjPrM9/E55Ogr6BjqFbEZGu2Yf50Hz+4Jaa1yC1+/Ual61DC6Cw?=
 =?us-ascii?Q?10RBCEGlnKjQtHoFIWAnfMSkwd3d9oqza7b9dNaqKFdZdVwz9A6bfJa330Es?=
 =?us-ascii?Q?BNIlTIXeDu3JvkIbfG6xchIcsYHphKk8n6ar0QnT1jIRyNGCklJYslC89X0Y?=
 =?us-ascii?Q?TkK2h2iO2+luur4mFwDlcixVaGoA9FDsCcJV7LfwfDUwAtEEEDofuGVITeJn?=
 =?us-ascii?Q?SGPeBTf1hgY6TJDRkNdG4nnthWFXccQRA7WSPoqp/XP4jGlucZ5nuDz/cWGC?=
 =?us-ascii?Q?ZpPBwh6NwcnjujqPAP2xr3vNKECobrHVpSJSOzsFZC3yXCvsKCZlH0HzhTAD?=
 =?us-ascii?Q?EzMStvlNr5wwb4nnZgIbLZTCvoj3gploRV4MxhH6yaBkM7mH7YwsQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: 0+RLDZxAgjx3P3MG7fpHAH99dRxqE7lMSE694MM+2SluBPE8/Mh7JLYCDTAJMFBzzQJn4wYi7I8qJ+Zx2qFk+4aUJXB2h4lXMWn3PLZ+WuHGMnI//ZTWPmu8IBORnqZQaPu2ELFTDL0VJnkIrtC+mum4iXnhNHiSGRoyqHmYePO6G1mjGFVa5VvgJqknKpeXB/wkiTu1Erw4tANr4sR4zTXTSxncbSwHfu5d1SrkuC/qkPbTE8UY1sUh85L++mBxTKaYUs3eDDBbiGIuuPI4iT3k+6HV211/vMsWlwlrGX/WKZb8S9G2ZsBcxhL17cLNy3GzFFKnFA82OQ6ffILFyOD4DLyAnU338LP/ZW9pmME=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5112;6:VyEGB2UGiSbYjsoF/CxbK+hTMpA6d48vdS1qpG8kpxIG2R0wpkCcKkzqpG1TEvk5XpL8EpTxx7hTdPBp9xB3UG//DqbNVvW2QAAvJAQVlkvNyZPO2cQu2sSQRk2MpsHh3bs7w/GMai+DSH2uqaLdeykgouOOW1jnjjqx0xXHy7CLeyyMupE54u98XkQdQWjWdX903WBPL5rD+Ii/sAMbQFGELmaFCQ03y8aYYi3ucvjDBKrdLNoHAjATSJtRDp6tR1PshxMMgbIdjkRNP62fYXKCZcvmMm1/ELivqMfUBNaIbcaslTM416iJRLIEYpckCgPOmb/iKuFUvSMAhwLWoZ3iH636mN1hG4jqt22s2pmZDyNE2ERCPVR/PM9aE4FeuC5c/MCvZb4UlmXvnXLi3yHmIcV5GI5CV9LQgYuHwntk03pR+tdYG5Ull9kOnvwR3GA9cAlzXK4JxFMe8xhuGg==;5:trUNAIOKRdQPUdBIyYJMY8tMbwBPtI2qT6jHgBE8ySPhFQBgIBJmT4YO3G605519iw1IuwZPwGg7dMLt6unTobHP/Q6mIlqOElG2mHPADigLQRbeozmog6lH5NxxKwNufQeb46YahjYiH1VEBHjwCvR19evAsAyvCwjm2Tpk5ak=;7:UIGxX2N6/MENo849bdhimfvHJwDzznKfmF3s5Oj0jsX4EUsRBKojCLgyIMX6KwEwCDmu2KlIAFhkwSrHAkYF3yelEiwJ/tTs8Q//9v8WdBc95gBA3M9EO4/8opISCor6sSYAyDGweKcmLs82HbKKXeedklCRgoY7Xg5XQwtifWhjxSJTPV8VD/2dh9VmNaXEXF1wh/R8AWXLWSujR1EWeAoLz5r50c+SUtyAi2lX47vbX18jbjiTKoLASxlsuZ8q
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2018 19:39:15.3166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34635373-281a-4893-210c-08d618e76c6c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add documentation to describe Xilinx ZynqMP firmware driver
bindings. Firmware driver provides an interface to firmware
APIs. Interface APIs can be used by any driver to communicate
to PMUFW (Platform Management Unit).

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
new file mode 100644
index 0000000..1b431d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -0,0 +1,29 @@
+-----------------------------------------------------------------
+Device Tree Bindings for the Xilinx Zynq MPSoC Firmware Interface
+-----------------------------------------------------------------
+
+The zynqmp-firmware node describes the interface to platform firmware.
+ZynqMP has an interface to communicate with secure firmware. Firmware
+driver provides an interface to firmware APIs. Interface APIs can be
+used by any driver to communicate to PMUFW(Platform Management Unit).
+These requests include clock management, pin control, device control,
+power management service, FPGA service and other platform management
+services.
+
+Required properties:
+ - compatible:	Must contain:	"xlnx,zynqmp-firmware"
+ - method:	The method of calling the PM-API firmware layer.
+		Permitted values are:
+		  - "smc" : SMC #0, following the SMCCC
+		  - "hvc" : HVC #0, following the SMCCC
+
+-------
+Example
+-------
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		compatible = "xlnx,zynqmp-firmware";
+		method = "smc";
+	};
+};
-- 
2.7.4

