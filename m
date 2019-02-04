Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF0DC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 07:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA71E2083B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 07:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="WUJyg2QG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfBCHLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 02:11:21 -0500
Received: from mail-eopbgr780049.outbound.protection.outlook.com ([40.107.78.49]:35755
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727273AbfBCHLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 02:11:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHrHe4BTaOJ4pY5V1Dgt8VzZYC0cCr7iOJq1Ry4jvnI=;
 b=WUJyg2QGXVMdl6A4Hsb09A0CB1OFkNbvboYzwbHb96OUaa+m/NHh0btD/OIVCJX2SF25jrHbMS7YNJ3isSIp+tnbmlXoI/YgGiLBfN1EUBNiV/t68YxfiUM7YiKlmlPmNv1Pg/W2b0BqdBUvm+oIH81eZk5dk7jEeNEG9DOlnZQ=
Received: from BYAPR02CA0069.namprd02.prod.outlook.com (2603:10b6:a03:54::46)
 by DM5PR02MB2652.namprd02.prod.outlook.com (2603:10b6:3:41::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.20; Sun, 3 Feb
 2019 07:09:38 +0000
Received: from CY1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BYAPR02CA0069.outlook.office365.com
 (2603:10b6:a03:54::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.20 via Frontend
 Transport; Sun, 3 Feb 2019 07:09:37 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT018.mail.protection.outlook.com (10.152.75.183) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Sun, 3 Feb 2019 07:09:37 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:49945 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gqBuK-0008Jk-Pz; Sat, 02 Feb 2019 23:09:36 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gqBuF-0002QL-Lc; Sat, 02 Feb 2019 23:09:31 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x1379Owa001986;
        Sat, 2 Feb 2019 23:09:24 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gqBu7-0002P8-Cm; Sat, 02 Feb 2019 23:09:23 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <jollys@xilinx.com>, <rajanv@xilinx.com>, <nava.manne@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] firmware: xilinx: Add zynqmp_pm_get_chipid() API
Date:   Mon, 4 Feb 2019 12:39:49 +0530
Message-ID: <20190204070951.6933-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190204070951.6933-1-nava.manne@xilinx.com>
References: <20190204070951.6933-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39850400004)(346002)(136003)(396003)(2980300002)(189003)(199004)(11346002)(6666004)(50466002)(126002)(110136005)(7696005)(2906002)(356004)(2616005)(36386004)(8676002)(9786002)(81156014)(76176011)(77096007)(476003)(81166006)(26005)(336012)(50226002)(486006)(48376002)(186003)(2201001)(426003)(478600001)(446003)(63266004)(1076003)(305945005)(106466001)(14444005)(8936002)(47776003)(106002)(36756003)(316002)(51416003)(16586007)(921003)(107986001)(2101003)(83996005)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2652;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT018;1:cktlacDj5jI3YU7g2xqkB2ckK1Q8FnqP6yKXcfI2O1V8nyEp7MPp8Gig5OlwVFSifg7Y/NomNkKk/3OdnT9lI6ajjex4p9J3ypRxBswlYm0YwvTOtkF/sS0Q2Cns2z85GmIjaYLC7xOXgYSiTr3gHg==
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e0469c6-c7f6-47d3-2f42-08d689a68efa
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:DM5PR02MB2652;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2652;3:jdMnbPfvMxIq58rbrj4FYZS+WLKNXog9QkVIhwhLNQsrlJ36aZl8u5Y/WrJP072Ev/cv3fha9yp0eq9/r/AdIa5My9Id5D4JGihSJhOCL8MLi2YJ5rSGs0umpxcAOfWqyUGJnA/FmlIdzf6UfjwEot6JU56hfZAEvUFRpfP2ORgT3pq+6KFzStzqxW3QcpK1WmIme/qWbZd6yP5TGX0cyW8eZWAjmZctkpWCy6tY9yNRRide2LAtnMHs2Ys5HrsCrp4HfVG1vYPElCu2KhgoXlyvXdTrR8NTp9P+yNk/B/IJSWaEUSu7eYv/qrhwquMS2dOw6YvmMuCEIsYsCT5pu0nq6KQIyMeWSXYtlnWp8LDRC7cnk+U8rbQKD+XHoF+d;25:nt4pO45RcbZUJURq0UoZMG63PnRyGsMNZigOAPLgWSLS40plFbXcrMbkSHDpW/wfBrN00QzCO3uFzgxxQFpuLhXzpwL2EYE8dNnzLw6InEKLHbQERGYQ7iTSvPvNDx10RKRYtqQkec04oFMMD4pnhMenM7HkIUdSynQpC3uSgT/eJVM5bEe53jAyMpbFqD4CktAz7FxFeW5bf+G8dYx2NBsCRqdDZtHcsDFCk6skNaeF2Q35CVqbXSt2BK7bwCXIdPTHy8N8Mp92JsuIiBaSBY258mmreLAjoHY087avZyX5ERqB/g7YvW+SDpH9Zq/tpwCpN+VBrHhn3bpRYEaBgQ==
X-MS-TrafficTypeDiagnostic: DM5PR02MB2652:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2652;31:m7x5Sm9Ig7gHMu51BtqZsT1F2VGETrZ2bJLpeAMo5ZHn8RM4A5gHoewLoDevGNzKKPJddpVNPxPHIufMVfX+X+ZD9k38j45/gpSJ4KBRCH66o4YTvUtQstYd8xwCg6XYsnSsZVkZzYtM2mEeudjYKo9/a3BZmQbGulMHi+8SiF/ii87ehhRMR/0oP/5djqXu33BndgujEMZg2ln6eCWKYhOC6nfyyl/TEP3EaNTVFHs=;20:fkFbjK2U3aXeQPZP6vm6+ZByUOeYqHr7AkkOvkBBnm/DsOKUqvKxhg59Mo20FduEHTugF4HU8pG5Elj7I8sim6cfVF/AnG1NljwVC166HoQ9xR6EtuSGYJfZt2e4OrYAIbL3StJi/kdzNzGDy34ZptvXW6khWHsXgZkdXW8SC+CTZpG4PjIatKimEDktSHJWG8AtaL+PvseaQb4YH62GudwtqjOACpNqs3OQWob2fBHd10ZLtEyoh0/g+3/WJyzQyMjmUmo/6nrp43Cg03wq2n+2oBnOkTy2BCJXEFdjg4NB14qUi8PRJiC1gZdruuW43uagvjFhQC4vzBSPEjkirg26nfI6NaUBynhKRCmAHp2CC0cQrFP2bAnHl+ra4PqmeAqHY5uhstyeoEXRQ7VGdhtf9nwFOWK9sngtRVE4wKhJMrRpWrqZ9UW2RX4vSsw0Wr9DemrFObFEhjYD5AvukGnEtR3FFxpK0AgSI4RnmOEQBip4RjX8iMG/evLIIaJg
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR02MB265237918CD87D5F0E2A075DC26C0@DM5PR02MB2652.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2652;4:Oc4LFGW9B3rZSImebNG5uz5llZbISdbNxhabRtK5n5+DlCTrSM0Vrx/gwyj1V6xs3VzaAc2I1MYwoA3dmA2c2gZIqilq8RrY3Pf3pxGB8tZwutp0U3owGfwN/MuOV6IywCrKIZL1l7C5BySBI0/oB2qRXz3mg1n/ibvxggeJQ/vVyNLBMkdJQiLqZHA8pQrsUCXriaiHLbFs4ffqZTFunbsQYVNDfyZwpq+uDTEX26GutSY9BLATCOp+vbW85bvgMa98SfDfIbn69ZzDiNH1VkM06pmtAe+v2RtE08qE37PgJggRZU+hIgnkEYrnwTBZ
X-Forefront-PRVS: 0937FB07C5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR02MB2652;23:IT2vMqf4sq8sgXy3RxL7dh7o+3IryhHg3GYXtv79N?=
 =?us-ascii?Q?lptqyPAoyMyVbQ30cxf2lTOIJfNwOL0Qgh4TQjiPBd6xjppAkEUXSukE/4a/?=
 =?us-ascii?Q?SATXm00iXKpEkTIjwN4Fd5SpvGHIQecc7saJa3zWiMhiEmK4WkOys+GdmIqx?=
 =?us-ascii?Q?hw3WckSDz5UOR1OTLiYFEYY+bqYOjhqjaqboRkzJF6mPFHkryk57lZMnEkM/?=
 =?us-ascii?Q?TJk9iBfyRm9mhD5b+uT6GR1dF1Z5YEVQkv4MChrk+gKyqT/7a/94zirQi8JU?=
 =?us-ascii?Q?A+lj3Oc4evd/6ZHvlv2Xh7Ph/5qxpkKBk4ly5s5l6EaAQTw65UPwhM0j7qlz?=
 =?us-ascii?Q?K2Rz3ULX9lEjFoK8giv1lnIw/OesePndJUrCOPhyiPSVKr+8SxHvZh6kTfso?=
 =?us-ascii?Q?N7mh/es49jMXv/nBN1XgveZgLy8S2VyVRga1RrNyu0788hePe8TNnerEy/u5?=
 =?us-ascii?Q?5rJaa3k/m3sESmskywy51NdLbuIUeTg5gW10nnRamdEryd4mBxiHHrQTkfps?=
 =?us-ascii?Q?DbaKayPUy7zoK8dqOaPGhARsy9tsEQiwopPub0+NkQGRI0/I4aMakxUEY+dR?=
 =?us-ascii?Q?CJ9i59t0XHMI74mR0BOpg3WCTf7KIpotiE5btk9LPTBnkp/OxRb8J/dznQN6?=
 =?us-ascii?Q?0vfJ6/UGV6Hv+kq+/73JYs7+TSsGVHQrSx73V/RlrwBp6/VW9+bJm+w5TZ6J?=
 =?us-ascii?Q?bxjoDLHEvAyH2aGeeXrFSOIFMG5yjT+Exduf09VQW1wCePwP4IooMswuDfdx?=
 =?us-ascii?Q?YzByoO2DY792lTS2Rg+3PyiuflXAi1C8XokTi1gIg2hxJh2ahoYPMJH66WfJ?=
 =?us-ascii?Q?4g4TI//dpGbAy/ufgTK2yPi6wu/Tp8gt+ax7brutRbXc/2qh+VLpVaHf4Cbp?=
 =?us-ascii?Q?rc3C+BHBahRLpPy8tMKYy24L8Wctjmqw7bu2H0f8JU0xnprBB1oDcGIpPTSc?=
 =?us-ascii?Q?u+ioKygRniv/FtjsM8R4zzMZbu9mEsBNf7un3MNXagR7Ytih/wCIeaD7E0VA?=
 =?us-ascii?Q?U1bwt1C0tvLUASw3uMc5Yn6F+x4gTkhDIod0S+F2kkiGWmEp7oUlxgPgaYcX?=
 =?us-ascii?Q?hAy7v39Aj28maRqkDg6oqUwrkI07fK/E5t0UMiz/muPH5jnxQCfqQgmReZyd?=
 =?us-ascii?Q?TNwBI1yo1+49Qm8gCFjNyShwxv/KqMYarDOGl5i6uVnRLHB+fOhgw=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: bELBhRYTqMj2otBCgMR1VT0+xNS7N6eujNSbSb9cmEU4nWxejy8O0mJINAqrmBrTD2y3oNFUef2hdq5YrWez7LPls862nWjDd5Hir5VfS75igP429WO3nkvhiwkWeRWue2c9EBFh8g5N4xN5YchDPkAMlevi01fY67w/Z2UK1sCrPaCxlmBpeG5xEmgCFoCegLC7bG0QcOrlmrM5l5nOrqWXgGBuRvNh1phPnchOEieZuGmxLatwSg4rcAa/65jMaAttRaDfND+le1Ta5hgMVkaFtPlW3U6gScqkHQBzkGgxi4QwUTkzOttc01zJ/IHO4Dvw39wf5uj/MZ6uqaO5lMVmKEFzHWctbWJDZCB/jSwbJka/uWuRzcfRigz093SfrRKOcg9a/79ieU0wygvXU8d3rZ4/Y9N9Js7MR40KBwI=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2652;6:XyXrnAbL3xpZ669aIhjTCnqPD2ir6QKUvokS/oxz+rzX1pes37KekFkFiQrUfmOdEMPuMqO4Z92HVGPrb4yBLQzvttHHgioQ1Cgu7ZQTNFyCsNwTZWucqdyy+XqoWw8jgNuUElMflRgjtw8OEGQ0a5hRtEQ53HdWWAIYqOARsnLUIwBq6NT07WrO9MMx9IFv0GoHb8BK1r5QGgP4TOA6bvxfXkvXkefZtInC5CJ5LV42c9RbKY9QVa1CBFY6KWeAngPOJHh5z+jUMGOo+WYO9ML/D1710CwqV0ZUmILAXUq/CFqmvvmIHDXvMnC7FJKLtuh7cMDKKUrYMyv9OgTwfiEAQpGO9Hqxc0pdK4kc8OFwM2Bz2IQ5NJGl/jZYGX6d2RVyCXa3u+zrWeh0QgkIhHggTZc4MjZVzYUN4Z/L57JYMkFcNMqLpr4ebikv/JrtCFlW/glAM6whT08YLDdHAw==;5:kEIwDJAcBEQ/C1cY2l4WSuEp1nrVP9yNa0IXXOvpHfaOFQaGoGNSsRbslhVKKX4YkKungfun+R/yyn/UPw0zsXCSfrbB2dcL9VbApW0v0Kt90SscWxAuexzHN1AGGrMMfY5ocA7UVYanqvFt/qh5giKSdSUBk+9RkYJg1otJZdJBQIn0M4MLav/q4pAyfAo3etV3lAsPbPhlMaDU49p5DA==;7:bG6Vs0LAPzcYYUL6R/gQe1pOoa50B1PkppmH26nnlL98I9lUB0w3L154W2dZJZHE8xGwg3IQaTF7pbeYCLvWf2IaAtvnkRW7q+G4iI3FrMT8UV+cd+Q1hO3VtVZ/QucUNXpyUmQD+7EL/7Of1fYYoQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2019 07:09:37.2474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0469c6-c7f6-47d3-2f42-08d689a68efa
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2652
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new API to provide access to the
hardware related data like soc revision, IDCODE... etc.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
		-None.
Changes for v1:
                -None.

Changes for RFC-V3:
                -corrected typo error in commit msg.

Changes for RFC-v2:
                -New Patch.

 drivers/firmware/xilinx/zynqmp.c     | 24 ++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 9a1c72a9280f..af2a209fc2da 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -186,6 +186,29 @@ static int zynqmp_pm_get_api_version(u32 *version)
 	return ret;
 }
 
+/**
+ * zynqmp_pm_get_chipid - Get silicon ID registers
+ * @idcode:     IDCODE register
+ * @version:    version register
+ *
+ * Return:      Returns the status of the operation and the idcode and version
+ *              registers in @idcode and @version.
+ */
+static int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!idcode || !version)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, 0, 0, 0, 0, ret_payload);
+	*idcode = ret_payload[1];
+	*version = ret_payload[2];
+
+	return ret;
+}
+
 /**
  * zynqmp_pm_get_trustzone_version() - Get secure trustzone firmware version
  * @version:	Returned version value
@@ -471,6 +494,7 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
 
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
+	.get_chipid = zynqmp_pm_get_chipid,
 	.query_data = zynqmp_pm_query_data,
 	.clock_enable = zynqmp_pm_clock_enable,
 	.clock_disable = zynqmp_pm_clock_disable,
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 3c3c28eff56a..c435f4b35adf 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,7 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_GET_CHIPID = 22,
 	PM_IOCTL = 34,
 	PM_QUERY_DATA,
 	PM_CLOCK_ENABLE,
@@ -91,6 +92,7 @@ struct zynqmp_pm_query_data {
 
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
+	int (*get_chipid)(u32 *idcode, u32 *version);
 	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
 	int (*clock_enable)(u32 clock_id);
 	int (*clock_disable)(u32 clock_id);
-- 
2.18.0

