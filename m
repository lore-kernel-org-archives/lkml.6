Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF49BECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567A421521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JmFIProv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567A421521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388391AbeITIaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:30:35 -0400
Received: from mail-dm3nam03on0120.outbound.protection.outlook.com ([104.47.41.120]:36173
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388366AbeITIad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65e7+4RL3qxqCHVW1nxFJcK4Gv9Jyku/bfeDytVJYSE=;
 b=JmFIProv2LmST6RwcNbaKtXFTuz/+uOtbPSh87c3tMokGX7UTz6cRHd6k8C+TNP0qqN5Ta0gfPirtS7nBu1ydOxSBfNv2nmrybjsNmTHOo4gwAAKyl3D6WEB05CZsk3/byphLTQxbcaVI2pf8rRUcXBycALxHp3JM7eCYN8kypE=
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
Subject: [PATCH AUTOSEL 4.14 04/25] qed: Avoid sending mailbox commands when
 MFW is not responsive
Thread-Topic: [PATCH AUTOSEL 4.14 04/25] qed: Avoid sending mailbox commands
 when MFW is not responsive
Thread-Index: AQHUUIxiFxkq2UD9aUuItnenL9Yfxg==
Date:   Thu, 20 Sep 2018 02:48:17 +0000
Message-ID: <20180920024810.58594-4-alexander.levin@microsoft.com>
References: <20180920024810.58594-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024810.58594-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0119;6:XvAxsp99EKM3PMzCToUpghunnNbLzsu9iLSXjeLWyLJood15255FI74DjxZ/TgczQggM37Au/3Hz30TuDMuTr+YMrbwEKEI+FLsNj+/Bjn1YXAkyhbnSSZX9Gr0/zJhKIzsJ8iqHtmJrQMrqahiZpMbb2D8niqv9PV7EeCP+5LZfBq+SCejFRRJZneEVPsCJ6lLTOxhfiqzzK3z9XVjTyO0/oLH8S1lAx5Emjb0yEJ6n9vpOl3tqS+t24/ir6s+LCOYhkque+vh+vNpPebfpshLG1/XilSstZrjP0MAquoYhjiCMb7Tqheg2deag8s0KtIgmHwQn+tfY0xEV2bsg7W2PSPqKbHHv7UpF/VT3QvYBomDmTzfcg/kH0esVg9uM+tRVcjFblJCnjx1jDLrZ3bA5z6f51A/yAQAW4d/NfAOaw5B6cQ/CIDncqGD1lvMxBMLsnn1W93aB8iBKEM3EbA==;5:Ykm+V1VO9djx2UEtK8LiT93BmVh1QkT4/2GB1aUmPoLH0+Ovlb4Tw7YTOUGzuR1MrfJRAtcm939QHrosr1+JS34TLA4In1ZEBYj2q4G6jj/jzgMcrmhQQ63mkna6j37EBOChAUmbUwREtvHGwJwIPcsYTzwAdw5TqEgnOByS01E=;7:FlLxY6KC7AyOul5fmfXFcJRRK5zMFWi0D9qWmxinJr0ub5iKaQngsTjjcuOE6f0hoTV8FMIaKXcXcnZkJZwfB83gCNjRjYHM6on4HGbu4/PmZr12rkI9AtqsxwbdlE6v6mi7lrebHnW9ZCV2hKuN3rBR1wQQQnhV6YoyeWuKIm6y6HUo29I8E/ihGnXBeZbxgd9uxRpjnISBz8kv9WJ0+Fmxt8z1AzGJFGZGDwlSiKHoMAclSL6mK8xpmGqH6QsC
x-ms-office365-filtering-correlation-id: 5e5880ca-a35b-4690-6ac5-08d61ea390ea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0119;
x-ms-traffictypediagnostic: CY4PR21MB0119:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0119994C5CDBF0889F44A752FB130@CY4PR21MB0119.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0119;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0119;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(5660300001)(54906003)(1076002)(478600001)(10090500001)(72206003)(22452003)(107886003)(110136005)(316002)(68736007)(4326008)(76176011)(3846002)(6116002)(25786009)(14454004)(106356001)(99286004)(6666003)(105586002)(102836004)(15650500001)(6506007)(5250100002)(186003)(2501003)(26005)(6486002)(6436002)(53936002)(6512007)(66066001)(486006)(476003)(2616005)(10290500003)(11346002)(446003)(97736004)(36756003)(2900100001)(2906002)(8936002)(305945005)(575784001)(217873002)(7736002)(86362001)(8676002)(86612001)(256004)(71200400001)(14444005)(71190400001)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0119;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Hf+9WtKLoTHf3XEspmk0POg4XuHw3djLTyKSAF8ocR3H97fkZ6D7o/2+sW1G06kbdLBKeFNuN8wI8qEVR/9pgWx0pRZkdDVFgcBCA0iyQ4L+i3WIHrhSUWVxKTOoch2AKUQdXQ48JMqs4dxGVRwlK46sxEoAcUFvsuzrI6Gb6zYfTqUiZm3yuY5T3Yf6Cwuk5NqTmwu9yypArc3vslu0AgVPFhue24BLherxsMCvUteA/hGguuJRDIOFPas51GqcoEuridcUnlpc2lAie/8FXVdvCR2gIyJQDNxtCYmcNKPTVczrSgr7Aq8zpHxt5SAiMSjwz5CrXosKZrvQiRjzXjnc1EELacMbGA6z9ucMJ7Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5880ca-a35b-4690-6ac5-08d61ea390ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:17.1322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <Tomer.Tayar@cavium.com>

[ Upstream commit b310974e041913231b6e3d5d475d4df55c312301 ]

Keep sending mailbox commands to the MFW when it is not responsive ends up
with a redundant amount of timeout expiries.
This patch prints the MCP status on the first command which is not
responded, and blocks the following commands.
Since the (un)load request commands might be not responded due to other
PFs, the patch also adds the option to skip the blocking upon a failure.

Signed-off-by: Tomer Tayar <Tomer.Tayar@cavium.com>
Signed-off-by: Ariel Elior <Ariel.Elior@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/qlogic/qed/qed_mcp.c     | 52 ++++++++++++++++++-
 drivers/net/ethernet/qlogic/qed/qed_mcp.h     |  6 ++-
 .../net/ethernet/qlogic/qed/qed_reg_addr.h    |  1 +
 3 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethern=
et/qlogic/qed/qed_mcp.c
index a1e1092fa3ce..7938abe9a301 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -319,6 +319,12 @@ int qed_mcp_reset(struct qed_hwfn *p_hwfn, struct qed_=
ptt *p_ptt)
 	u32 org_mcp_reset_seq, seq, delay =3D QED_MCP_RESP_ITER_US, cnt =3D 0;
 	int rc =3D 0;
=20
+	if (p_hwfn->mcp_info->b_block_cmd) {
+		DP_NOTICE(p_hwfn,
+			  "The MFW is not responsive. Avoid sending MCP_RESET mailbox command.\=
n");
+		return -EBUSY;
+	}
+
 	/* Ensure that only a single thread is accessing the mailbox */
 	spin_lock_bh(&p_hwfn->mcp_info->cmd_lock);
=20
@@ -444,6 +450,33 @@ static void __qed_mcp_cmd_and_union(struct qed_hwfn *p=
_hwfn,
 		   (p_mb_params->cmd | seq_num), p_mb_params->param);
 }
=20
+static void qed_mcp_cmd_set_blocking(struct qed_hwfn *p_hwfn, bool block_c=
md)
+{
+	p_hwfn->mcp_info->b_block_cmd =3D block_cmd;
+
+	DP_INFO(p_hwfn, "%s sending of mailbox commands to the MFW\n",
+		block_cmd ? "Block" : "Unblock");
+}
+
+static void qed_mcp_print_cpu_info(struct qed_hwfn *p_hwfn,
+				   struct qed_ptt *p_ptt)
+{
+	u32 cpu_mode, cpu_state, cpu_pc_0, cpu_pc_1, cpu_pc_2;
+	u32 delay =3D QED_MCP_RESP_ITER_US;
+
+	cpu_mode =3D qed_rd(p_hwfn, p_ptt, MCP_REG_CPU_MODE);
+	cpu_state =3D qed_rd(p_hwfn, p_ptt, MCP_REG_CPU_STATE);
+	cpu_pc_0 =3D qed_rd(p_hwfn, p_ptt, MCP_REG_CPU_PROGRAM_COUNTER);
+	udelay(delay);
+	cpu_pc_1 =3D qed_rd(p_hwfn, p_ptt, MCP_REG_CPU_PROGRAM_COUNTER);
+	udelay(delay);
+	cpu_pc_2 =3D qed_rd(p_hwfn, p_ptt, MCP_REG_CPU_PROGRAM_COUNTER);
+
+	DP_NOTICE(p_hwfn,
+		  "MCP CPU info: mode 0x%08x, state 0x%08x, pc {0x%08x, 0x%08x, 0x%08x}\=
n",
+		  cpu_mode, cpu_state, cpu_pc_0, cpu_pc_1, cpu_pc_2);
+}
+
 static int
 _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 		       struct qed_ptt *p_ptt,
@@ -530,11 +563,15 @@ _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 		DP_NOTICE(p_hwfn,
 			  "The MFW failed to respond to command 0x%08x [param 0x%08x].\n",
 			  p_mb_params->cmd, p_mb_params->param);
+		qed_mcp_print_cpu_info(p_hwfn, p_ptt);
=20
 		spin_lock_bh(&p_hwfn->mcp_info->cmd_lock);
 		qed_mcp_cmd_del_elem(p_hwfn, p_cmd_elem);
 		spin_unlock_bh(&p_hwfn->mcp_info->cmd_lock);
=20
+		if (!QED_MB_FLAGS_IS_SET(p_mb_params, AVOID_BLOCK))
+			qed_mcp_cmd_set_blocking(p_hwfn, true);
+
 		return -EAGAIN;
 	}
=20
@@ -572,6 +609,13 @@ static int qed_mcp_cmd_and_union(struct qed_hwfn *p_hw=
fn,
 		return -EBUSY;
 	}
=20
+	if (p_hwfn->mcp_info->b_block_cmd) {
+		DP_NOTICE(p_hwfn,
+			  "The MFW is not responsive. Avoid sending mailbox command 0x%08x [par=
am 0x%08x].\n",
+			  p_mb_params->cmd, p_mb_params->param);
+		return -EBUSY;
+	}
+
 	if (p_mb_params->data_src_size > union_data_size ||
 	    p_mb_params->data_dst_size > union_data_size) {
 		DP_ERR(p_hwfn,
@@ -776,7 +820,7 @@ __qed_mcp_load_req(struct qed_hwfn *p_hwfn,
 	mb_params.data_src_size =3D sizeof(load_req);
 	mb_params.p_data_dst =3D &load_rsp;
 	mb_params.data_dst_size =3D sizeof(load_rsp);
-	mb_params.flags =3D QED_MB_FLAG_CAN_SLEEP;
+	mb_params.flags =3D QED_MB_FLAG_CAN_SLEEP | QED_MB_FLAG_AVOID_BLOCK;
=20
 	DP_VERBOSE(p_hwfn, QED_MSG_SP,
 		   "Load Request: param 0x%08x [init_hw %d, drv_type %d, hsi_ver %d, pda=
 0x%04x]\n",
@@ -1020,7 +1064,7 @@ int qed_mcp_unload_req(struct qed_hwfn *p_hwfn, struc=
t qed_ptt *p_ptt)
 	memset(&mb_params, 0, sizeof(mb_params));
 	mb_params.cmd =3D DRV_MSG_CODE_UNLOAD_REQ;
 	mb_params.param =3D wol_param;
-	mb_params.flags =3D QED_MB_FLAG_CAN_SLEEP;
+	mb_params.flags =3D QED_MB_FLAG_CAN_SLEEP | QED_MB_FLAG_AVOID_BLOCK;
=20
 	return qed_mcp_cmd_and_union(p_hwfn, p_ptt, &mb_params);
 }
@@ -2047,6 +2091,8 @@ int qed_mcp_halt(struct qed_hwfn *p_hwfn, struct qed_=
ptt *p_ptt)
 		return -EBUSY;
 	}
=20
+	qed_mcp_cmd_set_blocking(p_hwfn, true);
+
 	return 0;
 }
=20
@@ -2071,6 +2117,8 @@ int qed_mcp_resume(struct qed_hwfn *p_hwfn, struct qe=
d_ptt *p_ptt)
 		return -EBUSY;
 	}
=20
+	qed_mcp_cmd_set_blocking(p_hwfn, false);
+
 	return 0;
 }
=20
diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.h b/drivers/net/ethern=
et/qlogic/qed/qed_mcp.h
index e5d0483f3c44..f1fe5e3427ea 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.h
@@ -540,11 +540,14 @@ struct qed_mcp_info {
 	 */
 	spinlock_t				cmd_lock;
=20
+	/* Flag to indicate whether sending a MFW mailbox command is blocked */
+	bool					b_block_cmd;
+
 	/* Spinlock used for syncing SW link-changes and link-changes
 	 * originating from attention context.
 	 */
 	spinlock_t				link_lock;
-	bool					block_mb_sending;
+
 	u32					public_base;
 	u32					drv_mb_addr;
 	u32					mfw_mb_addr;
@@ -575,6 +578,7 @@ struct qed_mcp_mb_params {
 	u32 mcp_param;
 	u32 flags;
 #define QED_MB_FLAG_CAN_SLEEP	(0x1 << 0)
+#define QED_MB_FLAG_AVOID_BLOCK	(0x1 << 1)
 #define QED_MB_FLAGS_IS_SET(params, flag) \
 	({ typeof(params) __params =3D (params); \
 	   (__params && (__params->flags & QED_MB_FLAG_ ## flag)); })
diff --git a/drivers/net/ethernet/qlogic/qed/qed_reg_addr.h b/drivers/net/e=
thernet/qlogic/qed/qed_reg_addr.h
index 887cfb16b53e..d1201bb2d4bb 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_reg_addr.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_reg_addr.h
@@ -557,6 +557,7 @@
 #define MCP_REG_CPU_STATE_SOFT_HALTED	(0x1UL << 10)
 #define MCP_REG_CPU_EVENT_MASK \
 	0xe05008UL
+#define MCP_REG_CPU_PROGRAM_COUNTER	0xe0501cUL
 #define PGLUE_B_REG_PF_BAR0_SIZE \
 	0x2aae60UL
 #define PGLUE_B_REG_PF_BAR1_SIZE \
--=20
2.17.1
