Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C67C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6AFC20823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KR1q2gFJ";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="pwhqokLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbfBFKOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:14:20 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:52934 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729230AbfBFKON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:14:13 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x16AA6d8019338;
        Wed, 6 Feb 2019 02:14:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=k+/kamL+0JDKgGW/yjdVpT8Vb6R5L+6Z+CgAEFu6Fpk=;
 b=KR1q2gFJ1RWmScptvOVIKxqTX7Apx69cNHXgvwV3iVlYyNjOwZexOope6EYZd3NxpaaD
 zl3EJv+sDhF3uWkqGHlXZggpbhOcQ72IKI8UCdNQAMAsW5Ga4Sm79h/IDkW24Evbt2yy
 6N826JNBIRTejaPB0D9ZzOqFeOk4E95Y7OZHznethVJ2HCjeGzV2gtAYMJ4Lr7ePqKts
 n4GOsQc0rVkjZ1y44QpvGZ2EZc0MOWJLP35iz+IsiVvG7ndXQG74GHD/Rog0W7gr7bUk
 n32i/tMnMovwFdCc7Q7bmR3leW+CRU5ftcsVSOV5ae2m3b2xxTBlPCtgOplearhnHWdp FQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2qfc17k9ke-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Feb 2019 02:14:02 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Feb
 2019 02:14:01 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.50) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Feb 2019 02:14:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+/kamL+0JDKgGW/yjdVpT8Vb6R5L+6Z+CgAEFu6Fpk=;
 b=pwhqokLq4QiROZ6Zj9MeiAHxww/ubIZdSuCgtSNH5kt1IpE5Ctt0IOth8FLqeoVpS5FPb2YE8TDrGwXE6/yy4qWinSWGsHtxPkeVRwj8JmkKxyCKDprrVKEQooeAGKMoInLXD+IZeo6Eb9Wzt18a+TchOQMy8iEIxQ7iWbdfVDs=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.184.11) by
 CY4PR18MB1238.namprd18.prod.outlook.com (10.172.176.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 10:14:00 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::1517:6511:71e8:6137]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::1517:6511:71e8:6137%10]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 10:14:00 +0000
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
Subject: [PATCH 8/8] net: thunderx: check status of mailbox IRQ before sending
 a message
Thread-Topic: [PATCH 8/8] net: thunderx: check status of mailbox IRQ before
 sending a message
Thread-Index: AQHUvgSs0J6ut9Y8XUW6zLYnywhS6w==
Date:   Wed, 6 Feb 2019 10:13:58 +0000
Message-ID: <20190206101351.16744-9-vlomovtsev@marvell.com>
References: <20190206101351.16744-1-vlomovtsev@marvell.com>
In-Reply-To: <20190206101351.16744-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR18MB1238;20:G3q8hEJ0TxL8Rvc2mmjVIWL5Gn5VYuBe3Iii3PY910uZC0C4krVXP6tD7UTOGAVSRN+xzlh9t6te5i4oamNhUf5TjZ9bcgwlNCRVL1lhBAD4WleTFLIifv8Nc/bLRcW+5Y4PMQmfPiP5bntm3AcZeBVYLw7pJ9GmgMIXr5YdS5E=
x-ms-office365-filtering-correlation-id: c1d30b46-4f4c-4ccc-8209-08d68c1bcfee
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:CY4PR18MB1238;
x-ms-traffictypediagnostic: CY4PR18MB1238:
x-microsoft-antispam-prvs: <CY4PR18MB1238880109D35406A358C260CD6F0@CY4PR18MB1238.namprd18.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(366004)(346002)(39860400002)(199004)(189003)(2501003)(14444005)(256004)(2201001)(86362001)(4326008)(105586002)(6512007)(106356001)(36756003)(486006)(68736007)(102836004)(1076003)(6436002)(66066001)(6506007)(97736004)(14454004)(8936002)(71190400001)(26005)(316002)(81166006)(81156014)(11346002)(107886003)(54906003)(110136005)(76176011)(7736002)(8676002)(99286004)(305945005)(71200400001)(186003)(478600001)(15650500001)(6486002)(2906002)(476003)(25786009)(2616005)(446003)(53936002)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR18MB1238;H:CY4PR18MB1112.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SnMQDUAf5330wiWTZ3vqcIGUu7F04i3/2vDbMOUunPPiZJLYT2lXxRGsD+ZfGEpl1GPUCZKstWbx9RLgGTN0ZdpSagMYStmN0HS1C+Wn//yF9Jmq6XGd9zMOdssJaate0QCnzigVEiKCi1CrwFKnssrHn+yoeHL4Q9NDZalRVwMrHpxPoCqUPrZcThK5S1EtNFtqb4wus2pcpp5v9P6wgSOOY6TeyHqEN+jRRbm00FLr9dAi6cIunaogYhb/K90FYkwe5M1uT77VXxwxS2TG0Xsbq4p8YDtEG1pfUBsbeKNijR/J0pVXcaatwFyCghbokgRhOu3kNWHmzC6mMuN7dGyuMRNX4vdfM7kAETz2+RlnnR1BocAday0/gFZAHhUDE2cnl5xce+4sOc+eFuKUsqLFi4t65qRNfJo3GRmApos=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d30b46-4f4c-4ccc-8209-08d68c1bcfee
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 10:13:58.4560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1238
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-06_06:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=771 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902060081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prevent mailbox data re-writing at VF side we need to check if
there is an active mailbox IRQ from PF, and if there is no one proceed with
sending message to PF. Having spinlock at irq handler and message send
routing wont help since by the moment when code flow would reach the irq
handler and acquire spinlock the message send routine could be already
invoked and thus re-write data in the mailbox.

The same is true for PF while sending messages to VF.

This commit is to implement mailbox IRQ status check before sending
message to VF from PF. Same is for sending message to PF from VF.

Signed-off-by: Vadim Lomovtsev <vlomovtsev@marvell.com>
---
 .../net/ethernet/cavium/thunder/nic_main.c    | 39 ++++++++-----------
 .../net/ethernet/cavium/thunder/nicvf_main.c  |  3 ++
 2 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nic_main.c b/drivers/net/e=
thernet/cavium/thunder/nic_main.c
index a32c1bd75794..e0041692caef 100644
--- a/drivers/net/ethernet/cavium/thunder/nic_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nic_main.c
@@ -64,7 +64,6 @@ struct nicpf {
 	u32			*speed;
 	u16			cpi_base[MAX_NUM_VFS_SUPPORTED];
 	u16			rssi_base[MAX_NUM_VFS_SUPPORTED];
-	bool			mbx_lock[MAX_NUM_VFS_SUPPORTED];
=20
 	/* MSI-X */
 	u8			num_vec;
@@ -954,8 +953,6 @@ static void nic_handle_mbx_intr(struct nicpf *nic, int =
vf)
 	int i;
 	int ret =3D 0;
=20
-	nic->mbx_lock[vf] =3D true;
-
 	mbx_addr =3D nic_get_mbx_addr(vf);
 	mbx_data =3D (u64 *)&mbx;
=20
@@ -975,7 +972,7 @@ static void nic_handle_mbx_intr(struct nicpf *nic, int =
vf)
 			nic->duplex[vf] =3D 0;
 			nic->speed[vf] =3D 0;
 		}
-		goto unlock;
+		return;
 	case NIC_MBOX_MSG_QS_CFG:
 		reg_addr =3D NIC_PF_QSET_0_127_CFG |
 			   (mbx.qs.num << NIC_QS_ID_SHIFT);
@@ -1044,7 +1041,7 @@ static void nic_handle_mbx_intr(struct nicpf *nic, in=
t vf)
 		break;
 	case NIC_MBOX_MSG_RSS_SIZE:
 		nic_send_rss_size(nic, vf);
-		goto unlock;
+		return;
 	case NIC_MBOX_MSG_RSS_CFG:
 	case NIC_MBOX_MSG_RSS_CFG_CONT:
 		nic_config_rss(nic, &mbx.rss_cfg);
@@ -1062,19 +1059,19 @@ static void nic_handle_mbx_intr(struct nicpf *nic, =
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
@@ -1083,7 +1080,7 @@ static void nic_handle_mbx_intr(struct nicpf *nic, in=
t vf)
 		break;
 	case NIC_MBOX_MSG_PFC:
 		nic_pause_frame(nic, vf, &mbx.pfc);
-		goto unlock;
+		return;
 	case NIC_MBOX_MSG_PTP_CFG:
 		nic_config_timestamp(nic, vf, &mbx.ptp);
 		break;
@@ -1134,8 +1131,6 @@ static void nic_handle_mbx_intr(struct nicpf *nic, in=
t vf)
 			mbx.msg.msg, vf);
 		nic_mbx_send_nack(nic, vf);
 	}
-unlock:
-	nic->mbx_lock[vf] =3D false;
 }
=20
 static irqreturn_t nic_mbx_intr_handler(int irq, void *nic_irq)
@@ -1313,18 +1308,18 @@ static void nic_poll_for_link(struct work_struct *w=
ork)
 		if (nic->link[vf] =3D=3D link.link_up)
 			continue;
=20
-		if (!nic->mbx_lock[vf]) {
-			nic->link[vf] =3D link.link_up;
-			nic->duplex[vf] =3D link.duplex;
-			nic->speed[vf] =3D link.speed;
+		nic->link[vf] =3D link.link_up;
+		nic->duplex[vf] =3D link.duplex;
+		nic->speed[vf] =3D link.speed;
=20
-			/* Send a mbox message to VF with current link status */
-			mbx.link_status.link_up =3D link.link_up;
-			mbx.link_status.duplex =3D link.duplex;
-			mbx.link_status.speed =3D link.speed;
-			mbx.link_status.mac_type =3D link.mac_type;
+		/* Send a mbox message to VF with current link status */
+		mbx.link_status.link_up =3D link.link_up;
+		mbx.link_status.duplex =3D link.duplex;
+		mbx.link_status.speed =3D link.speed;
+		mbx.link_status.mac_type =3D link.mac_type;
+
+		if (!nic_is_mbox_intr_active(nic, vf))
 			nic_send_msg_to_vf(nic, vf, &mbx);
-		}
 	}
 	queue_delayed_work(nic->check_link, &nic->dwork, HZ * 2);
 }
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net=
/ethernet/cavium/thunder/nicvf_main.c
index a05e2989ec76..66e19c207467 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -128,6 +128,9 @@ int nicvf_send_msg_to_pf(struct nicvf *nic, union nic_m=
bx *mbx)
=20
 	mutex_lock(&nic->rx_mode_mtx);
=20
+	while (nicvf_check_is_intr_active(nic, NICVF_INTR_MBOX, 0))
+		msleep(1);
+
 	nic->pf_acked =3D false;
 	nic->pf_nacked =3D false;
=20
--=20
2.17.2
