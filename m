Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02952C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A746A21521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="b3s6kR4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A746A21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388441AbeITIfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:35:11 -0400
Received: from mail-dm3nam03on0120.outbound.protection.outlook.com ([104.47.41.120]:36173
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388262AbeITIa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VanLTzRAIICVaPHth3qmdB79EnMnqPqWjILAk666o2Y=;
 b=b3s6kR4bfKFDSglLH05vLDJiJw+vjMKgP6QZi2k4VfvrMCqeuqQAYuxCeauy3XYhiX1tY892EXXyDSkRTEJtyZ7p8HbhpH7ToIKoVHLujZZqB8zTo99eQWKiXMjXi5uKFN5mX8NcckjcJiba5K1YfbP4BNskdaRI7wGmavBFf0s=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0119.namprd21.prod.outlook.com (10.173.189.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:48:36 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:36 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tomer Tayar <Tomer.Tayar@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 01/25] qed: Wait for ready indication before
 rereading the shmem
Thread-Topic: [PATCH AUTOSEL 4.14 01/25] qed: Wait for ready indication before
 rereading the shmem
Thread-Index: AQHUUIxg6G4xqCn3d0e4WHVTxU4frA==
Date:   Thu, 20 Sep 2018 02:48:15 +0000
Message-ID: <20180920024810.58594-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0119;6:MOqDGUsp2Ojq5vB6CNFTEAOU4i07ASaGy416RtyZuuzLijVKNgwD6vwoWa5+A83/2tNNBOk5W+kWXqDBTpn0fDCQoBz1QIKxN/6xLcRPgrQg0x8myIc/4QJ3HiWCDWS/bynuRXux2oVxJdH/ANtMk2oNzVAi2mwYxle3IIGkCnUpBcSbORckSo2uPzfIQ5ZRaB/g5tnTnOVUenaGFdBd7g2JP9NQRDxKGH5I/vPk1WHUinIFntqxfdOgvBXWBadhRnTmnr4NwU/m61vw00sDqMAf+G1i+rOJnkEYbodS5aP9+GtyWQEnvcFl+cjEjjH00qJjuEjLBUHiJVO2refCoXMoQeSr0hbYzAx/N8wX+vCYaQH6R4KP1+8W5VLF87FQQ/QRz6NscxdRSoRZg535ODwmr2y1VYi6nf8dYIGarS1aYNXJuvhkzxUDPkvY0CyZnr0MmY6dw19F960BnX4+JA==;5:ypQh8KlJN9Up7VNi0Bb6DartfBfHjZ2uZQpv8EMoxWpxOsbsoB8R87lr4aXduufuykoSSAE6BM82BWwuIyMrFWGsOFAKfh4DjcvQOSgd0y0VfDaN7sWFNoRF/BZEJMoCDqXb5f8QXNrQyscyVqjXE/WRdv+Eyp129/ZKfDfproQ=;7:EWm4U6tAp1CrqjeEShNof99n2z6udWMwOK2x6VSDw4uptTGy9JovyWsCyXHyaOEaNqf9FfNbXWFUg/Hxu0zChkUKryZoHe5bH+dnTTRIw95SLtrYKsPlwg3Kk0+8o0P4UC52CA+1rtPM1xdicr33fovq/aZ/asvM1EhEyVLfq4/O86iz1IolQNBMy8Z0WenXR/0hL2WAxu/iplEwQ7fR5rOYulOORY08UsZURWyiag9a6Q/EJN8MQMJeIbKfgHSn
x-ms-office365-filtering-correlation-id: 9f1c08b0-08e0-4371-c510-08d61ea39000
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0119;
x-ms-traffictypediagnostic: CY4PR21MB0119:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01194282B9A112CB0C16C9DFFB130@CY4PR21MB0119.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0119;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0119;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(5660300001)(54906003)(1076002)(478600001)(10090500001)(72206003)(22452003)(107886003)(110136005)(316002)(68736007)(4326008)(3846002)(6116002)(25786009)(14454004)(106356001)(99286004)(6666003)(105586002)(102836004)(6506007)(5250100002)(186003)(2501003)(26005)(6486002)(6436002)(53936002)(6512007)(66066001)(486006)(476003)(2616005)(10290500003)(97736004)(36756003)(2900100001)(2906002)(8936002)(305945005)(217873002)(7736002)(86362001)(8676002)(86612001)(256004)(71200400001)(14444005)(71190400001)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0119;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +nab98r+zyTWPA/ae3ySsan+ibVdjX0BQP0Mvj0saO2Od6mKGUiisIU7IZORA6JK/rYdMNtYoID9QCl+nmLutduA1wdyj0cxw/Z2Zmu+Nk6bPmbaZUHVdcSXSQ2ReL0FJSgy+EZoBOZz/x5ZRJnlquZGX3KsmRLm0VQkdaJPzo/c2QQ0iSu5VEtAHBbUmR1v2fOXLnmDm91OuLlStd+2CxvvgaegsYCHSKvW+umQr7O5sTXc2YQ/xPPA5c264MbZHVthGtD4MMZkyHc2w6JY1npgRyaNLWUQpvvcG0xSpQ3MZX9wROz4DNwdqLbjOomqtVBtxEDJPbkAPw1d3cQ22WyxEdjyZ5rTT5v/BqIT79A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1c08b0-08e0-4371-c510-08d61ea39000
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:15.2884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <Tomer.Tayar@cavium.com>

[ Upstream commit f00d25f3154b676fcea4502a25b94bd7f142ca74 ]

The MFW might be reset and re-update its shared memory.
Upon the detection of such a reset the driver rereads this memory, but it
has to wait till the data is valid.
This patch adds the missing wait for a data ready indication.

Signed-off-by: Tomer Tayar <Tomer.Tayar@cavium.com>
Signed-off-by: Ariel Elior <Ariel.Elior@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/qlogic/qed/qed_mcp.c | 50 +++++++++++++++++++----
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethern=
et/qlogic/qed/qed_mcp.c
index 3c469355f5a4..9348d367cfdf 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -182,18 +182,57 @@ int qed_mcp_free(struct qed_hwfn *p_hwfn)
 	return 0;
 }
=20
+/* Maximum of 1 sec to wait for the SHMEM ready indication */
+#define QED_MCP_SHMEM_RDY_MAX_RETRIES	20
+#define QED_MCP_SHMEM_RDY_ITER_MS	50
+
 static int qed_load_mcp_offsets(struct qed_hwfn *p_hwfn, struct qed_ptt *p=
_ptt)
 {
 	struct qed_mcp_info *p_info =3D p_hwfn->mcp_info;
+	u8 cnt =3D QED_MCP_SHMEM_RDY_MAX_RETRIES;
+	u8 msec =3D QED_MCP_SHMEM_RDY_ITER_MS;
 	u32 drv_mb_offsize, mfw_mb_offsize;
 	u32 mcp_pf_id =3D MCP_PF_ID(p_hwfn);
=20
 	p_info->public_base =3D qed_rd(p_hwfn, p_ptt, MISC_REG_SHARED_MEM_ADDR);
-	if (!p_info->public_base)
-		return 0;
+	if (!p_info->public_base) {
+		DP_NOTICE(p_hwfn,
+			  "The address of the MCP scratch-pad is not configured\n");
+		return -EINVAL;
+	}
=20
 	p_info->public_base |=3D GRCBASE_MCP;
=20
+	/* Get the MFW MB address and number of supported messages */
+	mfw_mb_offsize =3D qed_rd(p_hwfn, p_ptt,
+				SECTION_OFFSIZE_ADDR(p_info->public_base,
+						     PUBLIC_MFW_MB));
+	p_info->mfw_mb_addr =3D SECTION_ADDR(mfw_mb_offsize, mcp_pf_id);
+	p_info->mfw_mb_length =3D (u16)qed_rd(p_hwfn, p_ptt,
+					    p_info->mfw_mb_addr +
+					    offsetof(struct public_mfw_mb,
+						     sup_msgs));
+
+	/* The driver can notify that there was an MCP reset, and might read the
+	 * SHMEM values before the MFW has completed initializing them.
+	 * To avoid this, the "sup_msgs" field in the MFW mailbox is used as a
+	 * data ready indication.
+	 */
+	while (!p_info->mfw_mb_length && --cnt) {
+		msleep(msec);
+		p_info->mfw_mb_length =3D
+			(u16)qed_rd(p_hwfn, p_ptt,
+				    p_info->mfw_mb_addr +
+				    offsetof(struct public_mfw_mb, sup_msgs));
+	}
+
+	if (!cnt) {
+		DP_NOTICE(p_hwfn,
+			  "Failed to get the SHMEM ready notification after %d msec\n",
+			  QED_MCP_SHMEM_RDY_MAX_RETRIES * msec);
+		return -EBUSY;
+	}
+
 	/* Calculate the driver and MFW mailbox address */
 	drv_mb_offsize =3D qed_rd(p_hwfn, p_ptt,
 				SECTION_OFFSIZE_ADDR(p_info->public_base,
@@ -203,13 +242,6 @@ static int qed_load_mcp_offsets(struct qed_hwfn *p_hwf=
n, struct qed_ptt *p_ptt)
 		   "drv_mb_offsiz =3D 0x%x, drv_mb_addr =3D 0x%x mcp_pf_id =3D 0x%x\n",
 		   drv_mb_offsize, p_info->drv_mb_addr, mcp_pf_id);
=20
-	/* Set the MFW MB address */
-	mfw_mb_offsize =3D qed_rd(p_hwfn, p_ptt,
-				SECTION_OFFSIZE_ADDR(p_info->public_base,
-						     PUBLIC_MFW_MB));
-	p_info->mfw_mb_addr =3D SECTION_ADDR(mfw_mb_offsize, mcp_pf_id);
-	p_info->mfw_mb_length =3D	(u16)qed_rd(p_hwfn, p_ptt, p_info->mfw_mb_addr)=
;
-
 	/* Get the current driver mailbox sequence before sending
 	 * the first command
 	 */
--=20
2.17.1
