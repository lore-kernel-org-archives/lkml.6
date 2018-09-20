Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F22C46470
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F0821525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AXpL2mnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F0821525
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387574AbeITI2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:28:36 -0400
Received: from mail-by2nam01on0122.outbound.protection.outlook.com ([104.47.34.122]:34106
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733225AbeITI2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCt39Xh+DSVwGwZMzihZ1+b45Zn0lPpNmXflXP7CDMQ=;
 b=AXpL2mnjjExhb19U2hoGQSchdORIIggQCEI0g7BTQNUWggC9lgywv5aA+Em5EQz6pdX5sLAfMd6/1GrNTCVmpGlfFWGNAwqNZuDYmrCUFOwqmsWQqe9Y+tDjgO20GWGRltUN/NvUahO9dSL6qWuouo10rrn0IxrZ+5W9V45IP/o=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:47:30 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:30 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tomer Tayar <Tomer.Tayar@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 06/56] qed: Prevent a possible deadlock during
 driver load and unload
Thread-Topic: [PATCH AUTOSEL 4.18 06/56] qed: Prevent a possible deadlock
 during driver load and unload
Thread-Index: AQHUUIxFYUJpM8qUeEqOtdMNZsC38w==
Date:   Thu, 20 Sep 2018 02:47:30 +0000
Message-ID: <20180920024716.58490-6-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:JfTmC26rOql80jC0ME0gBPLCtNSa7aPpsHZshhKRnX1RFozKTij4b4kbkQZ7fYcBlHe+uDwHfDUAzGHYY7kCE7SAZI5WHhoe/KoOUazYnfhw55myDxlmg0UUtt31XyiZo5um/enq7eHIi4fcfT0g+a9w7xmyspoMvE9A1OdCc9w4KgR3oy+BaXvF609Oe+JiuFeRZWTOM1F4gHDtGJAMxOmdXfyloctrOmhlPCQB5su8ZsiDzdKE/KSFkI81YDB9/MaM/CHMqMTJtliOYOOrrLe8kUlAOz3il4ON2FPTY3XX+omd6yGbGPaV2y5y1cyEIjGCnR3eC+rZnMa+XEav12jJPe0PqERCcLLe8BDe7yHqVVQc0VaVDEF06s4oNnPE5VfNn/P427P4czhYZkoXIvXieP8Vw5U++BGBxcsxQMb6AuScBvs/LcN7BBMCf6bA4HJvq8zeSG/wmOAFh4cDAQ==;5:9Q110Nr+CxTawGrl+h3r3VNOSKQtttD79dDPGGe/p2KKeriLllqSs1LhBTA0beTQJGwSjfQybk1bNOusVtg0FRJ8UdY0kp5GVnxwY0HN7azI58umZ54H5obcd4NKeeNequLwK1xRXAQ7VIXG4UaNCIbZdgKt8pvdQerk4tKA3qk=;7:dj5pNf7pKYq17V6wnfM1JHwCK8xQkuj8c4ujpUlDLvCPZw3djMpNhUif2NZp3lXXFoDVoAZJ2PMKtADjKrYXQ63avQdxHb5IK0tUzC8iNrfiidI2iX+5itSL5mhmXyM45vIlxtiII6KkBEDHvhliNHb0GL5zn1qj7571QMakHQtEerGUddfMHwQ2Pi0Jdmh8rKJkyyT/Cu/5H6q0jLyTAufrQkKh0QJHGwxJFTMqHrwNqfeTRwJeE26b0Q9Of5CV
x-ms-office365-filtering-correlation-id: 4d62d186-116e-4108-5236-08d61ea368a5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
x-microsoft-antispam-prvs: <CY4PR21MB0149DBF6A7C9A6465B5705F9FB130@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(86612001)(7736002)(81156014)(305945005)(10090500001)(81166006)(8676002)(105586002)(106356001)(66066001)(2900100001)(6116002)(3846002)(1076002)(486006)(5660300001)(2616005)(476003)(14454004)(478600001)(72206003)(76176011)(22452003)(6346003)(316002)(99286004)(26005)(186003)(6506007)(102836004)(54906003)(110136005)(446003)(11346002)(4326008)(25786009)(107886003)(36756003)(6436002)(6486002)(86362001)(575784001)(2501003)(5250100002)(71200400001)(2906002)(71190400001)(68736007)(8936002)(10290500003)(6512007)(217873002)(97736004)(53936002)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: P8Byjz9p+N5MfZEyt5lslCdo2BiGcj03ydMm6a30Rgtr/SGTXNdJynpcPCgdvK8me42aHGmplqRLh2ZDOZnc02tIfNkRAU0gUB4SQ0hCnlL5aNrBhNjgSWV04is9DuQJo8lvlBSEoJM+/CDU1f2cCtDwvyUTchLMKtZgYx5Y8/iNCh4ADfu+LmoBWSGXQV/+/+hVZnlI8UTPG88pz5cAdVTBiNUkolrjKUbAhFVAHesFjnvMkzTA79/F5Sh0dh62RJozVgIimTpjP9iWzS8bT9h4tRT/ZmzSzW2ljsRU/WQFsrxLAgxtmxwsIRGb4RIPdnOz5oKqgrcc8CRgMb94fXN5l5twMkIbtVBTIHumcMs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d62d186-116e-4108-5236-08d61ea368a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:30.1483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <Tomer.Tayar@cavium.com>

[ Upstream commit eaa50fc59e5841910987e90b0438b2643041f508 ]

The MFW manages an internal lock to prevent concurrent hardware
(de)initialization of different PFs.
This, together with the busy-waiting for the MFW's responses for commands,
might lead to a deadlock during concurrent load or unload of PFs.
This patch adds the option to sleep within the busy-waiting, and uses it
for the (un)load requests (which are not sent from an interrupt context) to
prevent the possible deadlock.

Signed-off-by: Tomer Tayar <Tomer.Tayar@cavium.com>
Signed-off-by: Ariel Elior <Ariel.Elior@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/qlogic/qed/qed_mcp.c | 43 ++++++++++++++++-------
 drivers/net/ethernet/qlogic/qed/qed_mcp.h | 21 ++++++-----
 2 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethern=
et/qlogic/qed/qed_mcp.c
index 34e0db313850..c9dada0d2a44 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -48,7 +48,7 @@
 #include "qed_reg_addr.h"
 #include "qed_sriov.h"
=20
-#define CHIP_MCP_RESP_ITER_US 10
+#define QED_MCP_RESP_ITER_US	10
=20
 #define QED_DRV_MB_MAX_RETRIES	(500 * 1000)	/* Account for 5 sec */
 #define QED_MCP_RESET_RETRIES	(50 * 1000)	/* Account for 500 msec */
@@ -317,7 +317,7 @@ static void qed_mcp_reread_offsets(struct qed_hwfn *p_h=
wfn,
=20
 int qed_mcp_reset(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 {
-	u32 org_mcp_reset_seq, seq, delay =3D CHIP_MCP_RESP_ITER_US, cnt =3D 0;
+	u32 org_mcp_reset_seq, seq, delay =3D QED_MCP_RESP_ITER_US, cnt =3D 0;
 	int rc =3D 0;
=20
 	/* Ensure that only a single thread is accessing the mailbox */
@@ -449,10 +449,10 @@ static int
 _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 		       struct qed_ptt *p_ptt,
 		       struct qed_mcp_mb_params *p_mb_params,
-		       u32 max_retries, u32 delay)
+		       u32 max_retries, u32 usecs)
 {
+	u32 cnt =3D 0, msecs =3D DIV_ROUND_UP(usecs, 1000);
 	struct qed_mcp_cmd_elem *p_cmd_elem;
-	u32 cnt =3D 0;
 	u16 seq_num;
 	int rc =3D 0;
=20
@@ -475,7 +475,11 @@ _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 			goto err;
=20
 		spin_unlock_bh(&p_hwfn->mcp_info->cmd_lock);
-		udelay(delay);
+
+		if (QED_MB_FLAGS_IS_SET(p_mb_params, CAN_SLEEP))
+			msleep(msecs);
+		else
+			udelay(usecs);
 	} while (++cnt < max_retries);
=20
 	if (cnt >=3D max_retries) {
@@ -504,7 +508,11 @@ _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 		 * The spinlock stays locked until the list element is removed.
 		 */
=20
-		udelay(delay);
+		if (QED_MB_FLAGS_IS_SET(p_mb_params, CAN_SLEEP))
+			msleep(msecs);
+		else
+			udelay(usecs);
+
 		spin_lock_bh(&p_hwfn->mcp_info->cmd_lock);
=20
 		if (p_cmd_elem->b_is_completed)
@@ -539,7 +547,7 @@ _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 		   "MFW mailbox: response 0x%08x param 0x%08x [after %d.%03d ms]\n",
 		   p_mb_params->mcp_resp,
 		   p_mb_params->mcp_param,
-		   (cnt * delay) / 1000, (cnt * delay) % 1000);
+		   (cnt * usecs) / 1000, (cnt * usecs) % 1000);
=20
 	/* Clear the sequence number from the MFW response */
 	p_mb_params->mcp_resp &=3D FW_MSG_CODE_MASK;
@@ -557,7 +565,7 @@ static int qed_mcp_cmd_and_union(struct qed_hwfn *p_hwf=
n,
 {
 	size_t union_data_size =3D sizeof(union drv_union_data);
 	u32 max_retries =3D QED_DRV_MB_MAX_RETRIES;
-	u32 delay =3D CHIP_MCP_RESP_ITER_US;
+	u32 usecs =3D QED_MCP_RESP_ITER_US;
=20
 	/* MCP not initialized */
 	if (!qed_mcp_is_init(p_hwfn)) {
@@ -574,8 +582,13 @@ static int qed_mcp_cmd_and_union(struct qed_hwfn *p_hw=
fn,
 		return -EINVAL;
 	}
=20
+	if (QED_MB_FLAGS_IS_SET(p_mb_params, CAN_SLEEP)) {
+		max_retries =3D DIV_ROUND_UP(max_retries, 1000);
+		usecs *=3D 1000;
+	}
+
 	return _qed_mcp_cmd_and_union(p_hwfn, p_ptt, p_mb_params, max_retries,
-				      delay);
+				      usecs);
 }
=20
 int qed_mcp_cmd(struct qed_hwfn *p_hwfn,
@@ -792,6 +805,7 @@ __qed_mcp_load_req(struct qed_hwfn *p_hwfn,
 	mb_params.data_src_size =3D sizeof(load_req);
 	mb_params.p_data_dst =3D &load_rsp;
 	mb_params.data_dst_size =3D sizeof(load_rsp);
+	mb_params.flags =3D QED_MB_FLAG_CAN_SLEEP;
=20
 	DP_VERBOSE(p_hwfn, QED_MSG_SP,
 		   "Load Request: param 0x%08x [init_hw %d, drv_type %d, hsi_ver %d, pda=
 0x%04x]\n",
@@ -1013,7 +1027,8 @@ int qed_mcp_load_req(struct qed_hwfn *p_hwfn,
=20
 int qed_mcp_unload_req(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 {
-	u32 wol_param, mcp_resp, mcp_param;
+	struct qed_mcp_mb_params mb_params;
+	u32 wol_param;
=20
 	switch (p_hwfn->cdev->wol_config) {
 	case QED_OV_WOL_DISABLED:
@@ -1031,8 +1046,12 @@ int qed_mcp_unload_req(struct qed_hwfn *p_hwfn, stru=
ct qed_ptt *p_ptt)
 		wol_param =3D DRV_MB_PARAM_UNLOAD_WOL_MCP;
 	}
=20
-	return qed_mcp_cmd(p_hwfn, p_ptt, DRV_MSG_CODE_UNLOAD_REQ, wol_param,
-			   &mcp_resp, &mcp_param);
+	memset(&mb_params, 0, sizeof(mb_params));
+	mb_params.cmd =3D DRV_MSG_CODE_UNLOAD_REQ;
+	mb_params.param =3D wol_param;
+	mb_params.flags =3D QED_MB_FLAG_CAN_SLEEP;
+
+	return qed_mcp_cmd_and_union(p_hwfn, p_ptt, &mb_params);
 }
=20
 int qed_mcp_unload_done(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.h b/drivers/net/ethern=
et/qlogic/qed/qed_mcp.h
index 632a838f1fe3..8223daefcc37 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.h
@@ -660,14 +660,19 @@ struct qed_mcp_info {
 };
=20
 struct qed_mcp_mb_params {
-	u32			cmd;
-	u32			param;
-	void			*p_data_src;
-	u8			data_src_size;
-	void			*p_data_dst;
-	u8			data_dst_size;
-	u32			mcp_resp;
-	u32			mcp_param;
+	u32 cmd;
+	u32 param;
+	void *p_data_src;
+	void *p_data_dst;
+	u8 data_src_size;
+	u8 data_dst_size;
+	u32 mcp_resp;
+	u32 mcp_param;
+	u32 flags;
+#define QED_MB_FLAG_CAN_SLEEP	(0x1 << 0)
+#define QED_MB_FLAGS_IS_SET(params, flag) \
+	({ typeof(params) __params =3D (params); \
+	   (__params && (__params->flags & QED_MB_FLAG_ ## flag)); })
 };
=20
 struct qed_drv_tlv_hdr {
--=20
2.17.1
