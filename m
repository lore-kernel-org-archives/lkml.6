Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479FCECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6BA21522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="G3zgmryW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6BA21522
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387533AbeITI2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:28:35 -0400
Received: from mail-by2nam01on0122.outbound.protection.outlook.com ([104.47.34.122]:34106
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733294AbeITI2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeOAMfetOK2L6UNOeup/Mmt8zhJVBVKE2CVTX/tyW5Q=;
 b=G3zgmryWaoyHBbcDYqBSMu2cpWTXsLW6vrhX+0vJIFOVYUaXojTXP5REMGvBQa+Q3+gxefwnpnIfhGbkMjxJBQ/GOXK0L7p80STZ6wQc+NW3ob+U79MMQmzcGdGgf5MvDXBR7JjMj91mZG8LQUl1vgQKu46RgXB7woPH9CPljxE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:47:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tomer Tayar <Tomer.Tayar@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 04/56] qed: Wait for ready indication before
 rereading the shmem
Thread-Topic: [PATCH AUTOSEL 4.18 04/56] qed: Wait for ready indication before
 rereading the shmem
Thread-Index: AQHUUIxEjD0WcRVXEUCM+RxpQd5Ijw==
Date:   Thu, 20 Sep 2018 02:47:28 +0000
Message-ID: <20180920024716.58490-4-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:96QolQTBzgv09p1lmlevIDRujW+wZCpO5X3Odw6tjv7ggjV2c36jiNmol5lUTmdeqnvHMpMYubfNGsYLQBUb/+taY9ReQ1diYvbXoOZUA5DNGXFcnIs/oSi9UrHefryV+JrvOV0g6tpE51oyJER65nhxK2txirSCHHQb65YSoG2ATAeG9+tU2y39UojUOsBjCeWd1XkfzaBCm/af9aPpGWpSGtyoS+W6ACjpIntfINgyONd7Klpp5ZcqM+6J5jtvtawQiR/LcsHKB/Jz7l4zuporB1GSyd87dr/lAPFDnaNaInx/XAbH/pk+7Rr2EUpplf+z+2Nnoq2USbUwSVuV3cLARiY81cKI0Rtok6K/9d2Jd+7CcmF3lftMZuZXf/8QhI2YzsYW+JMzN/guPd6NhPkXn/PQXJZSIrFoZraZsI0j9dXZkp63GJnzX+0MeDfER2G+BY46uhXV/YKe+/yjeg==;5:41+ztC21hnKvj19y+ruHm3vU0QyuqbWjSUMjG4brdHskcbMUTQA0hBJdqDhEtW9206n0TnSjjlWSLI+QO/cU+H+RWGPni6ULcvPW1VDeTxM9IoFm06WLtn5KBt+ep9NCEutt8r0OeXu6kNzyH0HB2btoqmE9qMHKQCWSYeM/JM4=;7:wTReljnNUcMdMBUkox5TPTF/+9a69N44ddgfHWkCETazlf+Vwb1I3Q0OpCFmBRK9Hyh1bMgm1l3EP5uWG3KHwKj1unQs2LIDc7+xxzVtdvvHFweoOc2pdCRn0X2DXn2FetFpn7c4gqzEIZpEKnrqrsbLPJbxhOIGqhvLlYSXy/5VIYDNZvC0B+ztkwAHPltEaAfxZsRshetuLtDMqDZB0WnjAZslc75me2evBUaPv870vlK8gflBXp7EDINCwATr
x-ms-office365-filtering-correlation-id: d66c34d5-b174-4055-11d9-08d61ea36780
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
x-microsoft-antispam-prvs: <CY4PR21MB014966E85654333B5616FB1BFB130@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(86612001)(7736002)(81156014)(305945005)(10090500001)(81166006)(8676002)(105586002)(106356001)(66066001)(2900100001)(6116002)(3846002)(1076002)(486006)(5660300001)(2616005)(476003)(14454004)(478600001)(72206003)(76176011)(22452003)(6346003)(316002)(99286004)(26005)(186003)(6506007)(102836004)(54906003)(110136005)(446003)(11346002)(4326008)(25786009)(107886003)(36756003)(6436002)(6486002)(86362001)(2501003)(5250100002)(71200400001)(2906002)(71190400001)(68736007)(8936002)(10290500003)(6512007)(217873002)(97736004)(53936002)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: c4t1PfbG8bryavDrSZn/bYW/LHwdTzo7LC7UyRxY5NQezTLqtdum7XM/ua79kOzzx0RuyuvDUAXugu1BgEjNlZYKodAFsyG8ogOzIZcTQ5mjQEF9d+mmlK9DgaBXsVIdyM9SGJXqSTiQIZQ5uM5Z8lOZZU5qo/5+mlcV8oeC8KNtsx0pLaKYTEP9S0Vm2UI40KKXO3FuclRU8QDxQbKwqQ3kV9+dY+oIGSvSbp+P9xND9Ir5RHhuNKNyPffCJ1tMvRJE2dTKs6FTzdNpQuTN+Qe2jF9xaMkVLX4QLaRErabFbk+vmjVgYPIGaXwbZdOgTWoG6u6uYEEMI6RGg8yiHXf0c3SVJ42MQfY88cZGWKc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d66c34d5-b174-4055-11d9-08d61ea36780
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:28.2734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
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
index cdd645024a32..f3937491d545 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -183,18 +183,57 @@ int qed_mcp_free(struct qed_hwfn *p_hwfn)
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
@@ -204,13 +243,6 @@ static int qed_load_mcp_offsets(struct qed_hwfn *p_hwf=
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
