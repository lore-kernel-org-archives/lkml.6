Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9225FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E20D217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="yYHHpMZN";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="SogVXoae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbfBRJwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:52:46 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:56034 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729618AbfBRJwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:52:35 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1I9qFes025146;
        Mon, 18 Feb 2019 01:52:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=nvm9WEeyu3R+87lgZmtx2Cp9YsTJqvTE8s/+MVVULrc=;
 b=yYHHpMZNl75ImEcB810MtSyTXk+3c+NB3lWmyOLyfKq6CXBOtV//4bU6GSxJRaddCu/f
 Do0Ylu7bGWMa05a8cJIJxo9gO07lFYiEa8n7IkHsHSbiuW+ahc1c4mzmEdT5fGYZij5k
 /oKTFAKhv72p4KMjKFCRdrNv4AXJUeIElUzQLTJ66TIZkFWX4FF/Gm0S9zcCSFI5S+d/
 0vu+0hm+wKPGuI+kqijhBN/Y02uUauoVdPI90KxQQZ9tdjPImF6VzZkwM3TlR9/MLE6O
 0Jqxtp69Ofw5G1wICnppNpoqPuud9j6cyT/xU2L6dPpt8znLdYJcwf29nTkdxkrHpln+ 5g== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2qpjwpw11q-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 18 Feb 2019 01:52:26 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 18 Feb
 2019 01:52:22 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.51) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 18 Feb 2019 01:52:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvm9WEeyu3R+87lgZmtx2Cp9YsTJqvTE8s/+MVVULrc=;
 b=SogVXoaeeVKTqrF5kLtM2YB+zc1QBPe5D9bdqA6BAdR5B3whVoOjNvrNRexi4kilNH+d4kxXtE3078zD677Ni1LjpTtn9cR1UFXxRB5fprD0u69ONzkkljj44AgeUirQ6rIL7C445lP0y2jDkV0AEN7YIlboe2fy1WzaeMtKikc=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.183.147) by
 CY4PR18MB0968.namprd18.prod.outlook.com (10.173.182.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Mon, 18 Feb 2019 09:52:18 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4%4]) with mapi id 15.20.1622.020; Mon, 18 Feb 2019
 09:52:18 +0000
From:   Vadim Lomovtsev <vlomovtsev@marvell.com>
To:     "sgoutham@cavium.com" <sgoutham@cavium.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "dnelson@redhat.com" <dnelson@redhat.com>,
        Vadim Lomovtsev <vlomovtsev@marvell.com>
Subject: [PATCH v2 7/8] net: thunderx: add LINK_CHANGE message handler at
 nicpf
Thread-Topic: [PATCH v2 7/8] net: thunderx: add LINK_CHANGE message handler at
 nicpf
Thread-Index: AQHUx2+hRK9wTP1kTUyzlZoJklf3ng==
Date:   Mon, 18 Feb 2019 09:52:16 +0000
Message-ID: <20190218095159.3847-8-vlomovtsev@marvell.com>
References: <20190218095159.3847-1-vlomovtsev@marvell.com>
In-Reply-To: <20190218095159.3847-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40641d39-9080-4194-0881-08d69586c519
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR18MB0968;
x-ms-traffictypediagnostic: CY4PR18MB0968:
x-microsoft-exchange-diagnostics: 1;CY4PR18MB0968;20:Oa5uwfQSRMBmN1PQjyYKSLtP/Yb9COVaGHkW08OXoaNvZ+wYlmQD8vVCXeAWVTi9YGBAkyZaafMwN31vOsQEgudXDVzBl6p3rHn3iDYOxNC/SSip5QnK4ouXWtQE0nFeac5Ty+gcvMTeGBjOC1ZUI1HIM+zp26FfybHk6mLqBRw=
x-microsoft-antispam-prvs: <CY4PR18MB096860118F874CB059CDAB61CD630@CY4PR18MB0968.namprd18.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(396003)(376002)(366004)(346002)(136003)(199004)(189003)(486006)(7736002)(305945005)(316002)(4326008)(110136005)(54906003)(25786009)(99286004)(8936002)(476003)(5660300002)(186003)(2616005)(76176011)(81166006)(81156014)(6436002)(446003)(11346002)(14454004)(2906002)(8676002)(71190400001)(71200400001)(14444005)(6506007)(256004)(68736007)(1076003)(2501003)(2201001)(36756003)(6486002)(53936002)(86362001)(106356001)(102836004)(26005)(15650500001)(97736004)(3846002)(105586002)(66066001)(6116002)(478600001)(6512007)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR18MB0968;H:CY4PR18MB1112.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lNj5zcBvdDGJkLpPvoIWUK3ScN3ak7mSaDT+dKald72nctwWrfLdUIxv65NDq7BgL9t/z1MD5Q6LMblzPQVLUc8a08vw8Zbw/3oa7/kBOpuCJ37+Od/KSxHvPUigrAltEa10QUC11v53ST+OdwKtwDBrXak7h1l1dIkHKynDtYwdv9EhdmzO8r8y0ATAQVvYHUQHH+2Y8RCg8kBmrRNfJPlDDyyBMWteapmhiRZ1EdEwB3tGpOjCfDlVqe7JqnYULfPWpuBl8k4VfJYbqzarDUwIO+79wWlR3EkJ0DoRqop8iLofzdzAFZFlW0IvU9eVWvuIRgxwEctkAp2TS7VSQa0mxyeSN2h0OFzwC/ws8YZwA282yRc263wP6nIU/2GF/WM07LRke13cYBg/GHCCsdXoTbrjWdTL56uEU2HiDOA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 40641d39-9080-4194-0881-08d69586c519
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 09:52:16.2393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB0968
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-18_07:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902180075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the link change polling task to VF side in order to
prevent races between VF and PF while sending link change
message(s). This commit is to implement link change request
to be initiated by VF.

Signed-off-by: Vadim Lomovtsev <vlomovtsev@marvell.com>
---
 drivers/net/ethernet/cavium/thunder/nic.h     |  2 +-
 .../net/ethernet/cavium/thunder/nic_main.c    | 39 ++++++++++++--
 .../net/ethernet/cavium/thunder/nicvf_main.c  | 54 +++++++++++++------
 3 files changed, 76 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethern=
et/cavium/thunder/nic.h
index 86cda3f4b37b..62636c1ed141 100644
--- a/drivers/net/ethernet/cavium/thunder/nic.h
+++ b/drivers/net/ethernet/cavium/thunder/nic.h
@@ -331,7 +331,7 @@ struct nicvf {
 	struct workqueue_struct *nicvf_rx_mode_wq;
 	/* mutex to protect VF's mailbox contents from concurrent access */
 	struct mutex            rx_mode_mtx;
-
+	struct delayed_work	link_change_work;
 	/* PTP timestamp */
 	struct cavium_ptp	*ptp_clock;
 	/* Inbound timestamping is on */
diff --git a/drivers/net/ethernet/cavium/thunder/nic_main.c b/drivers/net/e=
thernet/cavium/thunder/nic_main.c
index 620dbe082ca0..8ab71dae3988 100644
--- a/drivers/net/ethernet/cavium/thunder/nic_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nic_main.c
@@ -929,6 +929,35 @@ static void nic_config_timestamp(struct nicpf *nic, in=
t vf, struct set_ptp *ptp)
 	nic_reg_write(nic, NIC_PF_PKIND_0_15_CFG | (pkind_idx << 3), pkind_val);
 }
=20
+static void nic_link_status_get(struct nicpf *nic, u8 vf)
+{
+	union nic_mbx mbx =3D {};
+	struct bgx_link_status link;
+	u8 bgx, lmac;
+
+	mbx.link_status.msg =3D NIC_MBOX_MSG_BGX_LINK_CHANGE;
+
+	/* Get BGX, LMAC indices for the VF */
+	bgx =3D NIC_GET_BGX_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
+	lmac =3D NIC_GET_LMAC_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
+
+	/* Get interface link status */
+	bgx_get_lmac_link_state(nic->node, bgx, lmac, &link);
+
+	nic->link[vf] =3D link.link_up;
+	nic->duplex[vf] =3D link.duplex;
+	nic->speed[vf] =3D link.speed;
+
+	/* Send a mbox message to VF with current link status */
+	mbx.link_status.link_up =3D link.link_up;
+	mbx.link_status.duplex =3D link.duplex;
+	mbx.link_status.speed =3D link.speed;
+	mbx.link_status.mac_type =3D link.mac_type;
+
+	/* reply with link status */
+	nic_send_msg_to_vf(nic, vf, &mbx);
+}
+
 /* Interrupt handler to handle mailbox messages from VFs */
 static void nic_handle_mbx_intr(struct nicpf *nic, int vf)
 {
@@ -1108,6 +1137,13 @@ static void nic_handle_mbx_intr(struct nicpf *nic, i=
nt vf)
 		lmac =3D NIC_GET_LMAC_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
 		bgx_set_xcast_mode(nic->node, bgx, lmac, mbx.xcast.mode);
 		break;
+	case NIC_MBOX_MSG_BGX_LINK_CHANGE:
+		if (vf >=3D nic->num_vf_en) {
+			ret =3D -1; /* NACK */
+			break;
+		}
+		nic_link_status_get(nic, vf);
+		goto unlock;
 	default:
 		dev_err(&nic->pdev->dev,
 			"Invalid msg from VF%d, msg 0x%x\n", vf, mbx.msg.msg);
@@ -1419,9 +1455,6 @@ static int nic_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *ent)
 		goto err_disable_sriov;
 	}
=20
-	INIT_DELAYED_WORK(&nic->dwork, nic_poll_for_link);
-	queue_delayed_work(nic->check_link, &nic->dwork, 0);
-
 	return 0;
=20
 err_disable_sriov:
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net=
/ethernet/cavium/thunder/nicvf_main.c
index a05e2989ec76..2ecacd0e1b51 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -245,21 +245,24 @@ static void  nicvf_handle_mbx_intr(struct nicvf *nic)
 		break;
 	case NIC_MBOX_MSG_BGX_LINK_CHANGE:
 		nic->pf_acked =3D true;
-		nic->link_up =3D mbx.link_status.link_up;
-		nic->duplex =3D mbx.link_status.duplex;
-		nic->speed =3D mbx.link_status.speed;
-		nic->mac_type =3D mbx.link_status.mac_type;
-		if (nic->link_up) {
-			netdev_info(nic->netdev, "Link is Up %d Mbps %s duplex\n",
-				    nic->speed,
-				    nic->duplex =3D=3D DUPLEX_FULL ?
-				    "Full" : "Half");
-			netif_carrier_on(nic->netdev);
-			netif_tx_start_all_queues(nic->netdev);
-		} else {
-			netdev_info(nic->netdev, "Link is Down\n");
-			netif_carrier_off(nic->netdev);
-			netif_tx_stop_all_queues(nic->netdev);
+		if (nic->link_up !=3D mbx.link_status.link_up) {
+			nic->link_up =3D mbx.link_status.link_up;
+			nic->duplex =3D mbx.link_status.duplex;
+			nic->speed =3D mbx.link_status.speed;
+			nic->mac_type =3D mbx.link_status.mac_type;
+			if (nic->link_up) {
+				netdev_info(nic->netdev,
+					    "Link is Up %d Mbps %s duplex\n",
+					    nic->speed,
+					    nic->duplex =3D=3D DUPLEX_FULL ?
+					    "Full" : "Half");
+				netif_carrier_on(nic->netdev);
+				netif_tx_start_all_queues(nic->netdev);
+			} else {
+				netdev_info(nic->netdev, "Link is Down\n");
+				netif_carrier_off(nic->netdev);
+				netif_tx_stop_all_queues(nic->netdev);
+			}
 		}
 		break;
 	case NIC_MBOX_MSG_ALLOC_SQS:
@@ -1328,6 +1331,8 @@ int nicvf_stop(struct net_device *netdev)
 	struct nicvf_cq_poll *cq_poll =3D NULL;
 	union nic_mbx mbx =3D {};
=20
+	cancel_delayed_work_sync(&nic->link_change_work);
+
 	/* wait till all queued set_rx_mode tasks completes */
 	drain_workqueue(nic->nicvf_rx_mode_wq);
=20
@@ -1430,6 +1435,20 @@ static int nicvf_update_hw_max_frs(struct nicvf *nic=
, int mtu)
 	return nicvf_send_msg_to_pf(nic, &mbx);
 }
=20
+static void nicvf_link_status_check_task(struct work_struct *work_arg)
+{
+	struct nicvf *nic =3D container_of(work_arg,
+					 struct nicvf,
+					 link_change_work.work);
+	struct net_device *netdev =3D nic->netdev;
+	union nic_mbx mbx =3D {};
+
+	mbx.msg.msg =3D NIC_MBOX_MSG_BGX_LINK_CHANGE;
+	nicvf_send_msg_to_pf(nic, &mbx);
+	queue_delayed_work(nic->nicvf_rx_mode_wq,
+			   &nic->link_change_work, 2 * HZ);
+}
+
 int nicvf_open(struct net_device *netdev)
 {
 	int cpu, err, qidx;
@@ -1536,6 +1555,11 @@ int nicvf_open(struct net_device *netdev)
 	/* Send VF config done msg to PF */
 	nicvf_send_cfg_done(nic);
=20
+	INIT_DELAYED_WORK(&nic->link_change_work,
+			  nicvf_link_status_check_task);
+	queue_delayed_work(nic->nicvf_rx_mode_wq,
+			   &nic->link_change_work, 0);
+
 	return 0;
 cleanup:
 	nicvf_disable_intr(nic, NICVF_INTR_MBOX, 0);
--=20
2.17.2
