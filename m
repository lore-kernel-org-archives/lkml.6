Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554DFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055E12133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="tgavO1nm";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="EbsoCjNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbfB0Mju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:39:50 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:47604 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726419AbfB0Mjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 07:39:49 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1RCa571003232;
        Wed, 27 Feb 2019 04:39:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=hEsT8nxkWcFc1VlLYDWTw46Kf706s78aQ2/3cgJ0PJM=;
 b=tgavO1nmBmZ30SF/0kn3sNLKgkdo1NB+OKzyeTzZIN03WIoOiKf7NWM/R+JpZmz6RqVK
 qblkL+68+XruNWwPCvHcYrRKOiUi4M42yd52+kXkGsnomJHyA2xd0fpLbZ5VSM1cIlWX
 jd3/F0b2x6ls9k7eHI2MES1DIPVYC7CEK0gQ5Rdg43BzTipOCJVpiyPHm+gJS640iSIm
 ZqdbtfQv0SiAB1Od4NUxQ8nZ7lrB0+PafGYAU/FNrGX/wpacUMrFV+mmd0jiJfEbcKAk
 iRpzM95LAQ8fFyUDfoWId7sc7mVlW5vihYUOpYAskJOIeC25UnKvU02SAtz2CfvH2pqi zQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2qwhfgsg92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Feb 2019 04:39:41 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 27 Feb
 2019 04:39:39 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.59) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 27 Feb 2019 04:39:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEsT8nxkWcFc1VlLYDWTw46Kf706s78aQ2/3cgJ0PJM=;
 b=EbsoCjNw0T7fhdNIJcXhSSEHB7Q+4EE7kK2D+j78yiUHBfKazOhP0uOfEPCfxP+14oRP9t9bRiW++INRfWgwvoZJP6GwcCaWE/fvsyMPM/i5+0zL+BglxXzdwh8AeZWCpOsmyEJ5CYLbqqum3zgZ2MWPBChfYK640VCeVxnvBmY=
Received: from BLUPR18MB0130.namprd18.prod.outlook.com (10.160.188.26) by
 BLUPR18MB0001.namprd18.prod.outlook.com (10.160.188.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Wed, 27 Feb 2019 12:39:34 +0000
Received: from BLUPR18MB0130.namprd18.prod.outlook.com
 ([fe80::e80a:2224:e0e4:7ee8]) by BLUPR18MB0130.namprd18.prod.outlook.com
 ([fe80::e80a:2224:e0e4:7ee8%6]) with mapi id 15.20.1665.015; Wed, 27 Feb 2019
 12:39:34 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Robert Eshleman <bobbyeshleman@gmail.com>
CC:     Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ariel Elior <aelior@marvell.com>,
        GR-everest-linux-l2 <GR-everest-linux-l2@marvell.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/8] qed: remove unnecessary memsets
Thread-Topic: [PATCH 4/8] qed: remove unnecessary memsets
Thread-Index: AQHUzmMcezfnxQNw0EitTDzyoP7/EaXzlfAw
Date:   Wed, 27 Feb 2019 12:39:34 +0000
Message-ID: <BLUPR18MB0130A42B2E31A882879D1218A1740@BLUPR18MB0130.namprd18.prod.outlook.com>
References: <cover.1551246708.git.bobbyeshleman@gmail.com>
 <c15478ba2ff607f901c78bd56162509f1f023d52.1551246708.git.bobbyeshleman@gmail.com>
In-Reply-To: <c15478ba2ff607f901c78bd56162509f1f023d52.1551246708.git.bobbyeshleman@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8856ec0-8a53-4c8e-41f8-08d69cb0a0c2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BLUPR18MB0001;
x-ms-traffictypediagnostic: BLUPR18MB0001:
x-microsoft-exchange-diagnostics: 1;BLUPR18MB0001;20:3Sk6gL//Z9ee6fW70X1JeFxJ9m/Olbt7UN7eB0YjVe7TQvMZYNZlfkLGrSCUMTGzU4t4omZtzTGrYhdMo0hrFh3nYLiibJZHJsUNC/lwY7bcM0VTUwOUXggJN7FulBFOJaF2i9YUAY2avJG1TYl0nmku3SdUCu7w6o4QJcYEkWk=
x-microsoft-antispam-prvs: <BLUPR18MB00019AD8AF36CB3C320EFE22A1740@BLUPR18MB0001.namprd18.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(136003)(376002)(396003)(189003)(199004)(14454004)(229853002)(54906003)(7696005)(99286004)(186003)(26005)(478600001)(6506007)(316002)(105586002)(106356001)(6916009)(97736004)(102836004)(76176011)(66066001)(55016002)(33656002)(4326008)(486006)(53936002)(25786009)(6246003)(9686003)(256004)(14444005)(6436002)(11346002)(446003)(1411001)(476003)(81156014)(81166006)(8676002)(68736007)(2906002)(86362001)(5660300002)(3846002)(6116002)(52536013)(305945005)(30864003)(7736002)(8936002)(71190400001)(74316002)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR18MB0001;H:BLUPR18MB0130.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UHsO0GVloOWpTS99avE61slCt3ELbjnMtvCYGNSHsqyVvQgOirLDIGeW9EWdlL8Cia6DHViqWv/T3F7hKlIGARpspRyXfxgC89P153uJr/1Mvc+9Kt8dnP1+GTaMjZzrFQucsl6KjQMFQ/ok8zMLLSun7oC0wLt2QrOEykhdZiW1LM7RBNpJPgey4N2gKh/qV8yjbY/5WxgCc9cksWxj925liPeASJkatGBRLSk1Chmvr0nTLkO/oZIrckgtwXFJUia4CuH6/xR7Gu1z+xjrHqtDobPArf9vLHoYEz5LILz3zS/nXLRj6d7gocobs9cnDzVTfwhD/cNGUvQXJeVE6gd6gPhQUyDyct1NHeOwd9p71zRfsgNgdM5vnxLngl4OgBLj+51BN3sH1ly0yKBgBqvv0BetmGy6F4iDXyfjEIs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f8856ec0-8a53-4c8e-41f8-08d69cb0a0c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 12:39:34.2574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR18MB0001
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_07:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Robert Eshleman <bobbyeshleman@gmail.com>
> Sent: Wednesday, February 27, 2019 8:10 AM
>=20
> This patch replaces unnecessary memset(,0) calls with simply assigning
> structs to zero.
>=20
> Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
> ---
>  drivers/net/ethernet/qlogic/qed/qed_cxt.c |  4 +-
> drivers/net/ethernet/qlogic/qed/qed_hw.c  |  3 +-
> drivers/net/ethernet/qlogic/qed/qed_mcp.c | 70 ++++++++---------------
>  3 files changed, 25 insertions(+), 52 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/qlogic/qed/qed_cxt.c
> b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
> index c2ad405b2f50..0452ef2fdf1d 100644
> --- a/drivers/net/ethernet/qlogic/qed/qed_cxt.c
> +++ b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
> @@ -902,12 +902,10 @@ static int qed_cxt_src_t2_alloc(struct qed_hwfn
> *p_hwfn)
>  	struct qed_cxt_mngr *p_mngr =3D p_hwfn->p_cxt_mngr;
>  	u32 conn_num, total_size, ent_per_page, psz, i;
>  	struct qed_ilt_client_cfg *p_src;
> -	struct qed_src_iids src_iids;
> +	struct qed_src_iids src_iids =3D {0};
>  	struct qed_dma_mem *p_t2;
>  	int rc;
>=20
> -	memset(&src_iids, 0, sizeof(src_iids));
> -
>  	/* if the SRC ILT client is inactive - there are no connection
>  	 * requiring the searcer, leave.
>  	 */
> diff --git a/drivers/net/ethernet/qlogic/qed/qed_hw.c
> b/drivers/net/ethernet/qlogic/qed/qed_hw.c
> index 70504dcf4087..b8ca3a31409b 100644
> --- a/drivers/net/ethernet/qlogic/qed/qed_hw.c
> +++ b/drivers/net/ethernet/qlogic/qed/qed_hw.c
> @@ -831,7 +831,7 @@ int qed_dmae_sanity(struct qed_hwfn *p_hwfn,
>  		    struct qed_ptt *p_ptt, const char *phase)  {
>  	u32 size =3D PAGE_SIZE / 2, val;
> -	struct qed_dmae_params params;
> +	struct qed_dmae_params params =3D {0};
>  	int rc =3D 0;
>  	dma_addr_t p_phys;
>  	void *p_virt;
> @@ -864,7 +864,6 @@ int qed_dmae_sanity(struct qed_hwfn *p_hwfn,
>  		   (u64)p_phys,
>  		   p_virt, (u64)(p_phys + size), (u8 *)p_virt + size, size);
>=20
> -	memset(&params, 0, sizeof(params));
>  	rc =3D qed_dmae_host2host(p_hwfn, p_ptt, p_phys, p_phys + size,
>  				size / 4 /* size_in_dwords */, &params);
>  	if (rc) {
> diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
> b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
> index e7f18e34ff0d..e1b72fc819a9 100644
> --- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
> +++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
> @@ -642,10 +642,9 @@ int qed_mcp_cmd(struct qed_hwfn *p_hwfn,
>  		u32 *o_mcp_resp,
>  		u32 *o_mcp_param)
>  {
> -	struct qed_mcp_mb_params mb_params;
> +	struct qed_mcp_mb_params mb_params =3D {0};
>  	int rc;
>=20
> -	memset(&mb_params, 0, sizeof(mb_params));
>  	mb_params.cmd =3D cmd;
>  	mb_params.param =3D param;
>=20
> @@ -667,10 +666,9 @@ qed_mcp_nvm_wr_cmd(struct qed_hwfn *p_hwfn,
>  		   u32 *o_mcp_resp,
>  		   u32 *o_mcp_param, u32 i_txn_size, u32 *i_buf)  {
> -	struct qed_mcp_mb_params mb_params;
> +	struct qed_mcp_mb_params mb_params =3D {0};
>  	int rc;
>=20
> -	memset(&mb_params, 0, sizeof(mb_params));
>  	mb_params.cmd =3D cmd;
>  	mb_params.param =3D param;
>  	mb_params.p_data_src =3D i_buf;
> @@ -695,11 +693,10 @@ int qed_mcp_nvm_rd_cmd(struct qed_hwfn
> *p_hwfn,
>  		       u32 *o_mcp_resp,
>  		       u32 *o_mcp_param, u32 *o_txn_size, u32 *o_buf)  {
> -	struct qed_mcp_mb_params mb_params;
> +	struct qed_mcp_mb_params mb_params =3D {0};
>  	u8 raw_data[MCP_DRV_NVM_BUF_LEN];
>  	int rc;
>=20
> -	memset(&mb_params, 0, sizeof(mb_params));
>  	mb_params.cmd =3D cmd;
>  	mb_params.param =3D param;
>  	mb_params.p_data_dst =3D raw_data;
> @@ -821,13 +818,12 @@ __qed_mcp_load_req(struct qed_hwfn *p_hwfn,
>  		   struct qed_load_req_in_params *p_in_params,
>  		   struct qed_load_req_out_params *p_out_params)  {
> -	struct qed_mcp_mb_params mb_params;
> -	struct load_req_stc load_req;
> +	struct qed_mcp_mb_params mb_params =3D {0};
> +	struct load_req_stc load_req =3D {0};
>  	struct load_rsp_stc load_rsp;
>  	u32 hsi_ver;
>  	int rc;
>=20
> -	memset(&load_req, 0, sizeof(load_req));
>  	load_req.drv_ver_0 =3D p_in_params->drv_ver_0;
>  	load_req.drv_ver_1 =3D p_in_params->drv_ver_1;
>  	load_req.fw_ver =3D p_in_params->fw_ver; @@ -843,7 +839,6 @@
> __qed_mcp_load_req(struct qed_hwfn *p_hwfn,
>  		  DRV_ID_MCP_HSI_VER_CURRENT :
>  		  (p_in_params->hsi_ver << DRV_ID_MCP_HSI_VER_SHIFT);
>=20
> -	memset(&mb_params, 0, sizeof(mb_params));
>  	mb_params.cmd =3D DRV_MSG_CODE_LOAD_REQ;
>  	mb_params.param =3D PDA_COMP | hsi_ver | p_hwfn->cdev-
> >drv_type;
>  	mb_params.p_data_src =3D &load_req;
> @@ -959,12 +954,11 @@ int qed_mcp_load_req(struct qed_hwfn *p_hwfn,
>  		     struct qed_ptt *p_ptt,
>  		     struct qed_load_req_params *p_params)  {
> -	struct qed_load_req_out_params out_params;
> -	struct qed_load_req_in_params in_params;
> +	struct qed_load_req_out_params out_params =3D {0};
> +	struct qed_load_req_in_params in_params =3D {0};
>  	u8 mfw_drv_role, mfw_force_cmd;
>  	int rc;
>=20
> -	memset(&in_params, 0, sizeof(in_params));
>  	in_params.hsi_ver =3D QED_LOAD_REQ_HSI_VER_DEFAULT;
>  	in_params.drv_ver_0 =3D QED_VERSION;
>  	in_params.drv_ver_1 =3D qed_get_config_bitmap(); @@ -981,7 +975,6
> @@ int qed_mcp_load_req(struct qed_hwfn *p_hwfn,
>  	in_params.force_cmd =3D mfw_force_cmd;
>  	in_params.avoid_eng_reset =3D p_params->avoid_eng_reset;
>=20
> -	memset(&out_params, 0, sizeof(out_params));
>  	rc =3D __qed_mcp_load_req(p_hwfn, p_ptt, &in_params,
> &out_params);
>  	if (rc)
>  		return rc;
> @@ -1072,7 +1065,7 @@ int qed_mcp_load_req(struct qed_hwfn *p_hwfn,
>=20
>  int qed_mcp_unload_req(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
> {
> -	struct qed_mcp_mb_params mb_params;
> +	struct qed_mcp_mb_params mb_params =3D {0};
>  	u32 wol_param;
>=20
>  	switch (p_hwfn->cdev->wol_config) {
> @@ -1091,7 +1084,6 @@ int qed_mcp_unload_req(struct qed_hwfn
> *p_hwfn, struct qed_ptt *p_ptt)
>  		wol_param =3D DRV_MB_PARAM_UNLOAD_WOL_MCP;
>  	}
>=20
> -	memset(&mb_params, 0, sizeof(mb_params));
>  	mb_params.cmd =3D DRV_MSG_CODE_UNLOAD_REQ;
>  	mb_params.param =3D wol_param;
>  	mb_params.flags =3D QED_MB_FLAG_CAN_SLEEP |
> QED_MB_FLAG_AVOID_BLOCK; @@ -1101,17 +1093,15 @@ int
> qed_mcp_unload_req(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
>=20
>  int qed_mcp_unload_done(struct qed_hwfn *p_hwfn, struct qed_ptt
> *p_ptt)  {
> -	struct qed_mcp_mb_params mb_params;
> -	struct mcp_mac wol_mac;
> +	struct qed_mcp_mb_params mb_params =3D {0};
> +	struct mcp_mac wol_mac =3D {0};
>=20
> -	memset(&mb_params, 0, sizeof(mb_params));
>  	mb_params.cmd =3D DRV_MSG_CODE_UNLOAD_DONE;
>=20
>  	/* Set the primary MAC if WoL is enabled */
>  	if (p_hwfn->cdev->wol_config =3D=3D QED_OV_WOL_ENABLED) {
>  		u8 *p_mac =3D p_hwfn->cdev->wol_mac;
>=20
> -		memset(&wol_mac, 0, sizeof(wol_mac));
>  		wol_mac.mac_upper =3D p_mac[0] << 8 | p_mac[1];
>  		wol_mac.mac_lower =3D p_mac[2] << 24 | p_mac[3] << 16 |
>  				    p_mac[4] << 8 | p_mac[5];
> @@ -1167,7 +1157,7 @@ int qed_mcp_ack_vf_flr(struct qed_hwfn
> *p_hwfn,
>  	u32 mfw_func_offsize =3D qed_rd(p_hwfn, p_ptt, addr);
>  	u32 func_addr =3D SECTION_ADDR(mfw_func_offsize,
>  				     MCP_PF_ID(p_hwfn));
> -	struct qed_mcp_mb_params mb_params;
> +	struct qed_mcp_mb_params mb_params =3D {0};
>  	int rc;
>  	int i;
>=20
> @@ -1176,7 +1166,6 @@ int qed_mcp_ack_vf_flr(struct qed_hwfn
> *p_hwfn,
>  			   "Acking VFs [%08x,...,%08x] - %08x\n",
>  			   i * 32, (i + 1) * 32 - 1, vfs_to_ack[i]);
>=20
> -	memset(&mb_params, 0, sizeof(mb_params));
>  	mb_params.cmd =3D DRV_MSG_CODE_VF_DISABLED_DONE;
>  	mb_params.p_data_src =3D vfs_to_ack;
>  	mb_params.data_src_size =3D VF_MAX_STATIC / 8; @@ -1455,13
> +1444,12 @@ static void qed_mcp_handle_link_change(struct qed_hwfn
> *p_hwfn,  int qed_mcp_set_link(struct qed_hwfn *p_hwfn, struct qed_ptt
> *p_ptt, bool b_up)  {
>  	struct qed_mcp_link_params *params =3D &p_hwfn->mcp_info-
> >link_input;
> -	struct qed_mcp_mb_params mb_params;
> -	struct eth_phy_cfg phy_cfg;
> +	struct qed_mcp_mb_params mb_params =3D {0};
> +	struct eth_phy_cfg phy_cfg =3D {0};
>  	int rc =3D 0;
>  	u32 cmd;
>=20
>  	/* Set the shmem configuration according to params */
> -	memset(&phy_cfg, 0, sizeof(phy_cfg));
>  	cmd =3D b_up ? DRV_MSG_CODE_INIT_PHY :
> DRV_MSG_CODE_LINK_RESET;
>  	if (!params->speed.autoneg)
>  		phy_cfg.speed =3D params->speed.forced_speed; @@ -1505,7
> +1493,6 @@ int qed_mcp_set_link(struct qed_hwfn *p_hwfn, struct
> qed_ptt *p_ptt, bool b_up)
>  			   "Resetting link\n");
>  	}
>=20
> -	memset(&mb_params, 0, sizeof(mb_params));
>  	mb_params.cmd =3D cmd;
>  	mb_params.p_data_src =3D &phy_cfg;
>  	mb_params.data_src_size =3D sizeof(phy_cfg); @@ -1534,7 +1521,7
> @@ static void qed_mcp_send_protocol_stats(struct qed_hwfn *p_hwfn,  {
>  	enum qed_mcp_protocol_type stats_type;
>  	union qed_mcp_protocol_stats stats;
> -	struct qed_mcp_mb_params mb_params;
> +	struct qed_mcp_mb_params mb_params =3D {0};
>  	u32 hsi_param;
>=20
>  	switch (type) {
> @@ -1561,7 +1548,6 @@ static void qed_mcp_send_protocol_stats(struct
> qed_hwfn *p_hwfn,
>=20
>  	qed_get_protocol_stats(p_hwfn->cdev, stats_type, &stats);
>=20
> -	memset(&mb_params, 0, sizeof(mb_params));
>  	mb_params.cmd =3D DRV_MSG_CODE_GET_STATS;
>  	mb_params.param =3D hsi_param;
>  	mb_params.p_data_src =3D &stats;
> @@ -2370,20 +2356,18 @@ qed_mcp_send_drv_version(struct qed_hwfn
> *p_hwfn,
>  			 struct qed_ptt *p_ptt,
>  			 struct qed_mcp_drv_version *p_ver)
>  {
> -	struct qed_mcp_mb_params mb_params;
> -	struct drv_version_stc drv_version;
> +	struct qed_mcp_mb_params mb_params =3D {0};
> +	struct drv_version_stc drv_version =3D {0};
>  	__be32 val;
>  	u32 i;
>  	int rc;
>=20
> -	memset(&drv_version, 0, sizeof(drv_version));
>  	drv_version.version =3D p_ver->version;
>  	for (i =3D 0; i < (MCP_DRV_VER_STR_SIZE - 4) / sizeof(u32); i++) {
>  		val =3D cpu_to_be32(*((u32 *)&p_ver->name[i *
> sizeof(u32)]));
>  		*(__be32 *)&drv_version.name[i * sizeof(u32)] =3D val;
>  	}
>=20
> -	memset(&mb_params, 0, sizeof(mb_params));
>  	mb_params.cmd =3D DRV_MSG_CODE_SET_VERSION;
>  	mb_params.p_data_src =3D &drv_version;
>  	mb_params.data_src_size =3D sizeof(drv_version); @@ -2536,11
> +2520,10 @@ int qed_mcp_ov_update_mtu(struct qed_hwfn *p_hwfn,  int
> qed_mcp_ov_update_mac(struct qed_hwfn *p_hwfn,
>  			  struct qed_ptt *p_ptt, u8 *mac)
>  {
> -	struct qed_mcp_mb_params mb_params;
> +	struct qed_mcp_mb_params mb_params =3D {0};
>  	u32 mfw_mac[2];
>  	int rc;
>=20
> -	memset(&mb_params, 0, sizeof(mb_params));
>  	mb_params.cmd =3D DRV_MSG_CODE_SET_VMAC;
>  	mb_params.param =3D DRV_MSG_CODE_VMAC_TYPE_MAC <<
>  			  DRV_MSG_CODE_VMAC_TYPE_SHIFT;
> @@ -3197,12 +3180,10 @@ qed_mcp_resc_allocation_msg(struct qed_hwfn
> *p_hwfn,
>  			    struct qed_resc_alloc_in_params *p_in_params,
>  			    struct qed_resc_alloc_out_params
> *p_out_params)  {
> -	struct qed_mcp_mb_params mb_params;
> -	struct resource_info mfw_resc_info;
> +	struct qed_mcp_mb_params mb_params =3D {0};
> +	struct resource_info mfw_resc_info =3D {0};
>  	int rc;
>=20
> -	memset(&mfw_resc_info, 0, sizeof(mfw_resc_info));
> -
>  	mfw_resc_info.res_id =3D qed_mcp_get_mfw_res_id(p_in_params-
> >res_id);
>  	if (mfw_resc_info.res_id =3D=3D RESOURCE_NUM_INVALID) {
>  		DP_ERR(p_hwfn,
> @@ -3224,7 +3205,6 @@ qed_mcp_resc_allocation_msg(struct qed_hwfn
> *p_hwfn,
>  		return -EINVAL;
>  	}
>=20
> -	memset(&mb_params, 0, sizeof(mb_params));
>  	mb_params.cmd =3D p_in_params->cmd;
>  	mb_params.param =3D QED_RESC_ALLOC_VERSION;
>  	mb_params.p_data_src =3D &mfw_resc_info; @@ -3277,15 +3257,13
> @@ qed_mcp_set_resc_max_val(struct qed_hwfn *p_hwfn,
>  			 enum qed_resources res_id,
>  			 u32 resc_max_val, u32 *p_mcp_resp)
>  {
> -	struct qed_resc_alloc_out_params out_params;
> -	struct qed_resc_alloc_in_params in_params;
> +	struct qed_resc_alloc_out_params out_params =3D {0};
> +	struct qed_resc_alloc_in_params in_params =3D {0};
>  	int rc;
>=20
> -	memset(&in_params, 0, sizeof(in_params));
>  	in_params.cmd =3D DRV_MSG_SET_RESOURCE_VALUE_MSG;
>  	in_params.res_id =3D res_id;
>  	in_params.resc_max_val =3D resc_max_val;
> -	memset(&out_params, 0, sizeof(out_params));
>  	rc =3D qed_mcp_resc_allocation_msg(p_hwfn, p_ptt, &in_params,
>  					 &out_params);
>  	if (rc)
> @@ -3302,14 +3280,12 @@ qed_mcp_get_resc_info(struct qed_hwfn
> *p_hwfn,
>  		      enum qed_resources res_id,
>  		      u32 *p_mcp_resp, u32 *p_resc_num, u32 *p_resc_start)
> {
> -	struct qed_resc_alloc_out_params out_params;
> -	struct qed_resc_alloc_in_params in_params;
> +	struct qed_resc_alloc_out_params out_params =3D {0};
> +	struct qed_resc_alloc_in_params in_params =3D {0};
>  	int rc;
>=20
> -	memset(&in_params, 0, sizeof(in_params));
>  	in_params.cmd =3D DRV_MSG_GET_RESOURCE_ALLOC_MSG;
>  	in_params.res_id =3D res_id;
> -	memset(&out_params, 0, sizeof(out_params));
>  	rc =3D qed_mcp_resc_allocation_msg(p_hwfn, p_ptt, &in_params,
>  					 &out_params);
>  	if (rc)
> --
> 2.20.1

Thanks,=A0

Acked-by: Michal Kalderon=A0<michal.kalderon@marvell.com>


