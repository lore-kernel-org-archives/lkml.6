Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBCCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A1120685
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="cQhxERgC";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="sgQTpMXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfBTLDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:03:35 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:41398 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726370AbfBTLDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:03:06 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1KB08VE012140;
        Wed, 20 Feb 2019 03:02:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=+ccWsz+uliVVMXyMUuYIdBeRenifW0T4mGikL9fw7/0=;
 b=cQhxERgCFzCx0JfL4Oi1k6ZUH0CCGIviq0o687rxun1YcBWZesbjgUObv1GlYp4NrFbY
 d6PjbgQfIFGIW7gb4mWS11pz9DXtBGGJvrLbmPrbkAEkGRyPS+Mm4iruhP7yGNTKS4CU
 LDW/MMm36N1g8cWmTx+anPGzPQ+FmS3y37a6mp4RmK+Js4Y0Jf50sGsGMC/3rm85G/rS
 EY61ue58jwbAs11fyOYM+sRkcoRaIqbvXEcRIEOstZh+tNcxk9znBlyVQszWM0MfZA/N
 IsdmH+5jd0xXWpl7ouQYlD+/j6E4cfuSPdB8MaxDoXsv1eToZ1VdShN8YFumuOhrepif hw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2qrh8xbr2r-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Feb 2019 03:02:53 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 20 Feb
 2019 03:02:51 -0800
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.58) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 20 Feb 2019 03:02:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ccWsz+uliVVMXyMUuYIdBeRenifW0T4mGikL9fw7/0=;
 b=sgQTpMXmBzdpKViOnrmti7dfxicddoPyDE1ED8sFY9KTowlS+46gdQunzLJCppQGIXzfsTGgGpFxOuNuYCP5Q4GqGK0h2PZ8MdJdC5gk/vWWUB4lsQNAHKi4NYCkidfddF5xC28kHK1s7JVi7No5hDTUf8WtQFd9jwIZYWDRcN8=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.183.147) by
 CY4PR18MB1350.namprd18.prod.outlook.com (10.173.247.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 20 Feb 2019 11:02:47 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4%4]) with mapi id 15.20.1643.014; Wed, 20 Feb 2019
 11:02:47 +0000
From:   Vadim Lomovtsev <vlomovtsev@marvell.com>
To:     "sgoutham@cavium.com" <sgoutham@cavium.com>,
        "sunil.kovvuri@gmail.com" <sunil.kovvuri@gmail.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "dnelson@redhat.com" <dnelson@redhat.com>,
        Vadim Lomovtsev <vlomovtsev@marvell.com>
Subject: [PATCH v3 8/8] net: thunderx: remove link change polling code and
 info from nicpf
Thread-Topic: [PATCH v3 8/8] net: thunderx: remove link change polling code
 and info from nicpf
Thread-Index: AQHUyQvPNNMRL8PahkS5zmDrgenu/w==
Date:   Wed, 20 Feb 2019 11:02:45 +0000
Message-ID: <20190220110225.9497-9-vlomovtsev@marvell.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20190220110225.9497-1-vlomovtsev@marvell.com>
In-Reply-To: <20190220110225.9497-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0e67e2e-369d-4a4a-cf8f-08d69722f26b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR18MB1350;
x-ms-traffictypediagnostic: CY4PR18MB1350:
x-microsoft-exchange-diagnostics: 1;CY4PR18MB1350;20:mR6vFwK3JSIoknPmPh5QNwx/vp56KjYrKoaYRlpp+IvDvl5BRLl8KEdFYCepV9ytdQw6BSW9yn8sjSkIvu14ATuyM9dESy/oSmE5IfM7yJgm53ZRywKWxjYmPsBlyrZkN2cpHzwthlSGKgBkXK7W4rlfqEo2G8IAbNl5AcG0+f8=
x-microsoft-antispam-prvs: <CY4PR18MB13504759522EAF63CC289D0CCD7D0@CY4PR18MB1350.namprd18.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(86362001)(97736004)(478600001)(476003)(11346002)(2616005)(14444005)(68736007)(446003)(6512007)(5660300002)(256004)(186003)(99286004)(14454004)(76176011)(2906002)(36756003)(6486002)(2201001)(102836004)(6506007)(2501003)(6436002)(26005)(316002)(8936002)(305945005)(7736002)(25786009)(1076003)(53936002)(71200400001)(54906003)(81156014)(4326008)(110136005)(106356001)(107886003)(66066001)(81166006)(6116002)(8676002)(71190400001)(105586002)(3846002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR18MB1350;H:CY4PR18MB1112.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VVL3aQjgkHdyAn+TAq1u7+tMQel4hvD0AYrhN/KnDf0fVomoiItkORXNq+G20E1frUHz7y3GUWwUJXeZCPu6DGL4kEttsXSca/i3qjApk7XtlMbotNLMGeMLnhfcYi52mYYkmNVk6Pg9xtlNmvjXMIN4LjiWk9B5d+6KuU3myCKBeltVt6/AUkBP+/ryj1+y6gl6zX23xnqhO7a6qmhRgmwA/Z6dFjhlI9CMSlJa/9e3kLhcJM8nGgbmwMn3XgWU63P78GcOIJ0SdLVvxWMMHYXfGuVhAG66basYtQtaZIpluHSSehcYu+aVtGoQIZ3zkALcXchdadY0DQan8chskoqSSPtAyqizgIUkdFbi5yTJr/hgidOsVAjjB8muvBPSc0qsWxIpU0cClN5fSbbwj3kjJEEmuVZwFNvGff1OOq4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e67e2e-369d-4a4a-cf8f-08d69722f26b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 11:02:45.7316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1350
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-20_09:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since link change polling routine was moved to nicvf side,
we don't need anymore polling function at nicpf side along
with link status info for all enabled Vfs as at VF side
this info is already tracked.

This commit is to remove unnecessary code & fields from
nicpf structure.

Signed-off-by: Vadim Lomovtsev <vlomovtsev@marvell.com>
---
 .../net/ethernet/cavium/thunder/nic_main.c    | 114 ++----------------
 1 file changed, 12 insertions(+), 102 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nic_main.c b/drivers/net/e=
thernet/cavium/thunder/nic_main.c
index 8ab71dae3988..c90252829ed3 100644
--- a/drivers/net/ethernet/cavium/thunder/nic_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nic_main.c
@@ -57,14 +57,8 @@ struct nicpf {
 #define	NIC_GET_BGX_FROM_VF_LMAC_MAP(map)	((map >> 4) & 0xF)
 #define	NIC_GET_LMAC_FROM_VF_LMAC_MAP(map)	(map & 0xF)
 	u8			*vf_lmac_map;
-	struct delayed_work     dwork;
-	struct workqueue_struct *check_link;
-	u8			*link;
-	u8			*duplex;
-	u32			*speed;
 	u16			cpi_base[MAX_NUM_VFS_SUPPORTED];
 	u16			rssi_base[MAX_NUM_VFS_SUPPORTED];
-	bool			mbx_lock[MAX_NUM_VFS_SUPPORTED];
=20
 	/* MSI-X */
 	u8			num_vec;
@@ -929,6 +923,10 @@ static void nic_config_timestamp(struct nicpf *nic, in=
t vf, struct set_ptp *ptp)
 	nic_reg_write(nic, NIC_PF_PKIND_0_15_CFG | (pkind_idx << 3), pkind_val);
 }
=20
+/* Get BGX LMAC link status and update corresponding VF
+ * if there is a change, valid only if internal L2 switch
+ * is not present otherwise VF link is always treated as up
+ */
 static void nic_link_status_get(struct nicpf *nic, u8 vf)
 {
 	union nic_mbx mbx =3D {};
@@ -944,10 +942,6 @@ static void nic_link_status_get(struct nicpf *nic, u8 =
vf)
 	/* Get interface link status */
 	bgx_get_lmac_link_state(nic->node, bgx, lmac, &link);
=20
-	nic->link[vf] =3D link.link_up;
-	nic->duplex[vf] =3D link.duplex;
-	nic->speed[vf] =3D link.speed;
-
 	/* Send a mbox message to VF with current link status */
 	mbx.link_status.link_up =3D link.link_up;
 	mbx.link_status.duplex =3D link.duplex;
@@ -970,8 +964,6 @@ static void nic_handle_mbx_intr(struct nicpf *nic, int =
vf)
 	int i;
 	int ret =3D 0;
=20
-	nic->mbx_lock[vf] =3D true;
-
 	mbx_addr =3D nic_get_mbx_addr(vf);
 	mbx_data =3D (u64 *)&mbx;
=20
@@ -986,12 +978,7 @@ static void nic_handle_mbx_intr(struct nicpf *nic, int=
 vf)
 	switch (mbx.msg.msg) {
 	case NIC_MBOX_MSG_READY:
 		nic_mbx_send_ready(nic, vf);
-		if (vf < nic->num_vf_en) {
-			nic->link[vf] =3D 0;
-			nic->duplex[vf] =3D 0;
-			nic->speed[vf] =3D 0;
-		}
-		goto unlock;
+		return;
 	case NIC_MBOX_MSG_QS_CFG:
 		reg_addr =3D NIC_PF_QSET_0_127_CFG |
 			   (mbx.qs.num << NIC_QS_ID_SHIFT);
@@ -1060,7 +1047,7 @@ static void nic_handle_mbx_intr(struct nicpf *nic, in=
t vf)
 		break;
 	case NIC_MBOX_MSG_RSS_SIZE:
 		nic_send_rss_size(nic, vf);
-		goto unlock;
+		return;
 	case NIC_MBOX_MSG_RSS_CFG:
 	case NIC_MBOX_MSG_RSS_CFG_CONT:
 		nic_config_rss(nic, &mbx.rss_cfg);
@@ -1078,19 +1065,19 @@ static void nic_handle_mbx_intr(struct nicpf *nic, =
int vf)
 		break;
 	case NIC_MBOX_MSG_ALLOC_SQS:
 		nic_alloc_sqs(nic, &mbx.sqs_alloc);
-		goto unlock;
+		return;
 	case NIC_MBOX_MSG_NICVF_PTR:
 		nic->nicvf[vf] =3D mbx.nicvf.nicvf;
 		break;
 	case NIC_MBOX_MSG_PNICVF_PTR:
 		nic_send_pnicvf(nic, vf);
-		goto unlock;
+		return;
 	case NIC_MBOX_MSG_SNICVF_PTR:
 		nic_send_snicvf(nic, &mbx.nicvf);
-		goto unlock;
+		return;
 	case NIC_MBOX_MSG_BGX_STATS:
 		nic_get_bgx_stats(nic, &mbx.bgx_stats);
-		goto unlock;
+		return;
 	case NIC_MBOX_MSG_LOOPBACK:
 		ret =3D nic_config_loopback(nic, &mbx.lbk);
 		break;
@@ -1099,7 +1086,7 @@ static void nic_handle_mbx_intr(struct nicpf *nic, in=
t vf)
 		break;
 	case NIC_MBOX_MSG_PFC:
 		nic_pause_frame(nic, vf, &mbx.pfc);
-		goto unlock;
+		return;
 	case NIC_MBOX_MSG_PTP_CFG:
 		nic_config_timestamp(nic, vf, &mbx.ptp);
 		break;
@@ -1143,7 +1130,7 @@ static void nic_handle_mbx_intr(struct nicpf *nic, in=
t vf)
 			break;
 		}
 		nic_link_status_get(nic, vf);
-		goto unlock;
+		return;
 	default:
 		dev_err(&nic->pdev->dev,
 			"Invalid msg from VF%d, msg 0x%x\n", vf, mbx.msg.msg);
@@ -1157,8 +1144,6 @@ static void nic_handle_mbx_intr(struct nicpf *nic, in=
t vf)
 			mbx.msg.msg, vf);
 		nic_mbx_send_nack(nic, vf);
 	}
-unlock:
-	nic->mbx_lock[vf] =3D false;
 }
=20
 static irqreturn_t nic_mbx_intr_handler(int irq, void *nic_irq)
@@ -1306,52 +1291,6 @@ static int nic_sriov_init(struct pci_dev *pdev, stru=
ct nicpf *nic)
 	return 0;
 }
=20
-/* Poll for BGX LMAC link status and update corresponding VF
- * if there is a change, valid only if internal L2 switch
- * is not present otherwise VF link is always treated as up
- */
-static void nic_poll_for_link(struct work_struct *work)
-{
-	union nic_mbx mbx =3D {};
-	struct nicpf *nic;
-	struct bgx_link_status link;
-	u8 vf, bgx, lmac;
-
-	nic =3D container_of(work, struct nicpf, dwork.work);
-
-	mbx.link_status.msg =3D NIC_MBOX_MSG_BGX_LINK_CHANGE;
-
-	for (vf =3D 0; vf < nic->num_vf_en; vf++) {
-		/* Poll only if VF is UP */
-		if (!nic->vf_enabled[vf])
-			continue;
-
-		/* Get BGX, LMAC indices for the VF */
-		bgx =3D NIC_GET_BGX_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
-		lmac =3D NIC_GET_LMAC_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
-		/* Get interface link status */
-		bgx_get_lmac_link_state(nic->node, bgx, lmac, &link);
-
-		/* Inform VF only if link status changed */
-		if (nic->link[vf] =3D=3D link.link_up)
-			continue;
-
-		if (!nic->mbx_lock[vf]) {
-			nic->link[vf] =3D link.link_up;
-			nic->duplex[vf] =3D link.duplex;
-			nic->speed[vf] =3D link.speed;
-
-			/* Send a mbox message to VF with current link status */
-			mbx.link_status.link_up =3D link.link_up;
-			mbx.link_status.duplex =3D link.duplex;
-			mbx.link_status.speed =3D link.speed;
-			mbx.link_status.mac_type =3D link.mac_type;
-			nic_send_msg_to_vf(nic, vf, &mbx);
-		}
-	}
-	queue_delayed_work(nic->check_link, &nic->dwork, HZ * 2);
-}
-
 static int nic_probe(struct pci_dev *pdev, const struct pci_device_id *ent=
)
 {
 	struct device *dev =3D &pdev->dev;
@@ -1420,18 +1359,6 @@ static int nic_probe(struct pci_dev *pdev, const str=
uct pci_device_id *ent)
 	if (!nic->vf_lmac_map)
 		goto err_release_regions;
=20
-	nic->link =3D devm_kmalloc_array(dev, max_lmac, sizeof(u8), GFP_KERNEL);
-	if (!nic->link)
-		goto err_release_regions;
-
-	nic->duplex =3D devm_kmalloc_array(dev, max_lmac, sizeof(u8), GFP_KERNEL)=
;
-	if (!nic->duplex)
-		goto err_release_regions;
-
-	nic->speed =3D devm_kmalloc_array(dev, max_lmac, sizeof(u32), GFP_KERNEL)=
;
-	if (!nic->speed)
-		goto err_release_regions;
-
 	/* Initialize hardware */
 	nic_init_hw(nic);
=20
@@ -1447,19 +1374,8 @@ static int nic_probe(struct pci_dev *pdev, const str=
uct pci_device_id *ent)
 	if (err)
 		goto err_unregister_interrupts;
=20
-	/* Register a physical link status poll fn() */
-	nic->check_link =3D alloc_workqueue("check_link_status",
-					  WQ_UNBOUND | WQ_MEM_RECLAIM, 1);
-	if (!nic->check_link) {
-		err =3D -ENOMEM;
-		goto err_disable_sriov;
-	}
-
 	return 0;
=20
-err_disable_sriov:
-	if (nic->flags & NIC_SRIOV_ENABLED)
-		pci_disable_sriov(pdev);
 err_unregister_interrupts:
 	nic_unregister_interrupts(nic);
 err_release_regions:
@@ -1480,12 +1396,6 @@ static void nic_remove(struct pci_dev *pdev)
 	if (nic->flags & NIC_SRIOV_ENABLED)
 		pci_disable_sriov(pdev);
=20
-	if (nic->check_link) {
-		/* Destroy work Queue */
-		cancel_delayed_work_sync(&nic->dwork);
-		destroy_workqueue(nic->check_link);
-	}
-
 	nic_unregister_interrupts(nic);
 	pci_release_regions(pdev);
=20
--=20
2.17.2
