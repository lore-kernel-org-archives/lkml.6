Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72E7C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8613A21522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Vosd0eVr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8613A21522
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388714AbeITIeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:34:00 -0400
Received: from mail-dm3nam03on0120.outbound.protection.outlook.com ([104.47.41.120]:36173
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388331AbeITIab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpoUmfOyQPdsInzd6gEjoienImKLdM+jkv0MYF3jLf8=;
 b=Vosd0eVrUmhvn9+DbOD2jpsjSvJN1hDxINcxFH9YL6XS+n7PSZyIKehyu4fY5mTYSAjIvRvDEpYJaNy7qqvhtjizSdD9zUEo+pe+ajYB2j83/IPqe0t2EgSU0Y67SaNicouZHchoSf029+YJNKsHGCvFi04VN3lU/S2MUpOKrQY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0119.namprd21.prod.outlook.com (10.173.189.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:48:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tomer Tayar <Tomer.Tayar@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 03/25] qed: Prevent a possible deadlock during
 driver load and unload
Thread-Topic: [PATCH AUTOSEL 4.14 03/25] qed: Prevent a possible deadlock
 during driver load and unload
Thread-Index: AQHUUIxhDcaeIMml+UWiw/IEi6sFzg==
Date:   Thu, 20 Sep 2018 02:48:16 +0000
Message-ID: <20180920024810.58594-3-alexander.levin@microsoft.com>
References: <20180920024810.58594-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024810.58594-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0119;6:4mycRGYxpTT1okDul1hpX2im0ghrPdtByGDzFVnwG4M3uTW7HQ48jkx+x9BltyxbD6y+PIXW2OKbnoSTdTYm874QGo1NjFBxsuS0Kn2C7i3db7iTflDdKbkkxWf/Gam08CqFLiDSHkkq2e9uR1PQN2kPXCByRC43RDscqdyh3IJu70/D/X/g0z+RZz771kjlR7e47QT1uJwDO09d8c+5WVfKzGOcuc4sYPs4RDVixB4oDE99HKsx2xh4Ol7yVg9Rnx6+OQ0HvC9hzIuORFeJKH9baUUPSqttvbhD0m3tBc4JSzlfEhFG6t9W7Rv7xqLKN3VBQop6wif/rA1F6YxXxubuNwXFbBke6mw8EcFsT2wNeJeKJ98NAVx2aLY7ecEAYA0Sh4jaEQbDS4reO9LlDucMviihurLblRWsvCetRx5bsHFvnGduFHVYPdi6v7P9CInAUi0DzTaw5n7pek9INQ==;5:sJq+uMSLx9oyMl6w+vkJUQZmubJdYmAKTCvuGn/FQhaeIZegOzhN0y5BCVi4dI7nJY9WeaOaG5Kv2dDbh5Azzww8h5KN8FHztkE4QPAyWRlgmFv3xhAChul9bGugerfL+Dv+ZxCN9NHc1OvTHykftqXfiijWJwh7iEYqgjtf2SA=;7:O82+nodS5PrBGwgyd/eA72/pske6E/wctlvau5H6pSrODr6mICU0egKGk16vtvI46zJpcaJ1Om+vUxoDMKBkvxRigemeR7r4s6LgYv6CJWbxssjTnDKW9yNecd3BubZoI+1PxSKa4bhsK7wgf5WzxsmPF3TkuCpttZFTizOi/4OSQsGdky+WH+JRVqn/4RDNpxHBK8wuaGYQW5HHUj6HiCmOrDArmD2S54JHQPPTp68CPcV+2RYW/9XdZd6XVC/2
x-ms-office365-filtering-correlation-id: 9d03dfe4-63df-4de6-6dd6-08d61ea390ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0119;
x-ms-traffictypediagnostic: CY4PR21MB0119:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0119033DF2C67B3CCBE09CA1FB130@CY4PR21MB0119.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0119;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0119;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(5660300001)(54906003)(1076002)(478600001)(10090500001)(72206003)(22452003)(107886003)(110136005)(316002)(68736007)(4326008)(76176011)(3846002)(6116002)(25786009)(14454004)(106356001)(99286004)(6666003)(105586002)(102836004)(6506007)(5250100002)(186003)(2501003)(26005)(6486002)(6436002)(53936002)(6512007)(66066001)(486006)(476003)(2616005)(10290500003)(11346002)(446003)(97736004)(36756003)(2900100001)(2906002)(8936002)(305945005)(217873002)(7736002)(86362001)(8676002)(86612001)(256004)(71200400001)(14444005)(71190400001)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0119;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Bb2JoLJQ3ByEUcuAnd+GB8f+CgOIdpDl/aPE/VMF4k+A70lWh1R6GKo5bV+l1Tg9vsHZ4OtPSdLY83gFVcVc75WdywsnadBlldEjrdTNXCx/OA3e3bU+GZvqb1vAVH4xi8IeNy8wyw2w/5mmH/OA7nB4RSAovLXPa6oBhcKGufp5nZ3Xk/74brQ3S9moaqvq6c5wby9RkadbH90d8nJFnX94zIh+Xx8gAP9ZOyK9eLpK8wXa4cD1EXhhaWEOSMJpTnlIFHDuVVw9xVuWcYgKd7Vnal/lgt8YVp2rljxxUvbKX4OavGnbiWQFUqquYEMi0CxiOQ+zRR4yOs5LSJoxWtsq+y1QaCIOmTMEsXie/VI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d03dfe4-63df-4de6-6dd6-08d61ea390ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:16.5384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0119
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
index 5748bcb26d40..a1e1092fa3ce 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -47,7 +47,7 @@
 #include "qed_reg_addr.h"
 #include "qed_sriov.h"
=20
-#define CHIP_MCP_RESP_ITER_US 10
+#define QED_MCP_RESP_ITER_US	10
=20
 #define QED_DRV_MB_MAX_RETRIES	(500 * 1000)	/* Account for 5 sec */
 #define QED_MCP_RESET_RETRIES	(50 * 1000)	/* Account for 500 msec */
@@ -316,7 +316,7 @@ static void qed_mcp_reread_offsets(struct qed_hwfn *p_h=
wfn,
=20
 int qed_mcp_reset(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 {
-	u32 org_mcp_reset_seq, seq, delay =3D CHIP_MCP_RESP_ITER_US, cnt =3D 0;
+	u32 org_mcp_reset_seq, seq, delay =3D QED_MCP_RESP_ITER_US, cnt =3D 0;
 	int rc =3D 0;
=20
 	/* Ensure that only a single thread is accessing the mailbox */
@@ -448,10 +448,10 @@ static int
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
@@ -474,7 +474,11 @@ _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
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
@@ -503,7 +507,11 @@ _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
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
@@ -538,7 +546,7 @@ _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 		   "MFW mailbox: response 0x%08x param 0x%08x [after %d.%03d ms]\n",
 		   p_mb_params->mcp_resp,
 		   p_mb_params->mcp_param,
-		   (cnt * delay) / 1000, (cnt * delay) % 1000);
+		   (cnt * usecs) / 1000, (cnt * usecs) % 1000);
=20
 	/* Clear the sequence number from the MFW response */
 	p_mb_params->mcp_resp &=3D FW_MSG_CODE_MASK;
@@ -556,7 +564,7 @@ static int qed_mcp_cmd_and_union(struct qed_hwfn *p_hwf=
n,
 {
 	size_t union_data_size =3D sizeof(union drv_union_data);
 	u32 max_retries =3D QED_DRV_MB_MAX_RETRIES;
-	u32 delay =3D CHIP_MCP_RESP_ITER_US;
+	u32 usecs =3D QED_MCP_RESP_ITER_US;
=20
 	/* MCP not initialized */
 	if (!qed_mcp_is_init(p_hwfn)) {
@@ -573,8 +581,13 @@ static int qed_mcp_cmd_and_union(struct qed_hwfn *p_hw=
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
@@ -763,6 +776,7 @@ __qed_mcp_load_req(struct qed_hwfn *p_hwfn,
 	mb_params.data_src_size =3D sizeof(load_req);
 	mb_params.p_data_dst =3D &load_rsp;
 	mb_params.data_dst_size =3D sizeof(load_rsp);
+	mb_params.flags =3D QED_MB_FLAG_CAN_SLEEP;
=20
 	DP_VERBOSE(p_hwfn, QED_MSG_SP,
 		   "Load Request: param 0x%08x [init_hw %d, drv_type %d, hsi_ver %d, pda=
 0x%04x]\n",
@@ -984,7 +998,8 @@ int qed_mcp_load_req(struct qed_hwfn *p_hwfn,
=20
 int qed_mcp_unload_req(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 {
-	u32 wol_param, mcp_resp, mcp_param;
+	struct qed_mcp_mb_params mb_params;
+	u32 wol_param;
=20
 	switch (p_hwfn->cdev->wol_config) {
 	case QED_OV_WOL_DISABLED:
@@ -1002,8 +1017,12 @@ int qed_mcp_unload_req(struct qed_hwfn *p_hwfn, stru=
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
index c7ec2395d1ce..e5d0483f3c44 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.h
@@ -565,14 +565,19 @@ struct qed_mcp_info {
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
 /**
--=20
2.17.1
