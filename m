Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962C1C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592DC20823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="S+ULdt6W";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="n+KIEwb+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfBFKOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:14:14 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:39708 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729217AbfBFKOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:14:11 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x16AA75h016819;
        Wed, 6 Feb 2019 02:14:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=tU6PuN2duHKzBXHAYGpkSYO1zEgzSldYz7FyzRR3jFk=;
 b=S+ULdt6WDfMi3ZAiXZfwXpUjg69HIF9dBNkqF3OIs4XS1QtVSzaekcEz+OouO4PtRq9C
 82AJv69vLyvqJniNfmLtjDHimqHzuUZKU1PzQBeaNod8bYVGa8SjTtV0x4+bp9N91pY8
 si5csDf67o5w3Fr1MSvGCDD1n2OyXDNULQWw0vF41Tni4dlTIlJpjejtRBxOVCbm65Y3
 knvcqIgPFSIuf3c/sncFcxb7OBkQ8rIVApOM1mEbri7WO9rtuyD5+5a6Ly0qxjId0Ubb
 l9hyOzRCVAmmQZPdO5oJjSyjEPxft9YuBsO1baXn7IufhSrXWLI3+JCDNYZ711HXwXpY Ew== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2qfc2augvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Feb 2019 02:14:01 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Feb
 2019 02:14:00 -0800
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.57) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Feb 2019 02:14:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tU6PuN2duHKzBXHAYGpkSYO1zEgzSldYz7FyzRR3jFk=;
 b=n+KIEwb+yEVKQ3KwK6YQmDtlzvqZQwwbqp3s4Ua8yz2adAzGiTlG3C25FjUEMTy2G9t9t2Cz6JqHsvc2OfPOA8kNZOFyp3EKMOiDVrBqWgciUzJztbRx95lsl9XDjUn46WmfAontK2aMdMC5pLORXd6WZVeI7856vEiyZNWkmsU=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.184.11) by
 CY4PR18MB1238.namprd18.prod.outlook.com (10.172.176.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 10:13:59 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::1517:6511:71e8:6137]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::1517:6511:71e8:6137%10]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 10:13:59 +0000
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
Subject: [PATCH 6/8] net: thunderx: add mutex to protect mailbox from
 concurrent calls for same VF
Thread-Topic: [PATCH 6/8] net: thunderx: add mutex to protect mailbox from
 concurrent calls for same VF
Thread-Index: AQHUvgSr7chk/cxsr0efvCTqXMS49g==
Date:   Wed, 6 Feb 2019 10:13:57 +0000
Message-ID: <20190206101351.16744-7-vlomovtsev@marvell.com>
References: <20190206101351.16744-1-vlomovtsev@marvell.com>
In-Reply-To: <20190206101351.16744-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR18MB1238;20:+/POTwTGd5sj5zUG/4FjEsix5K+XP3DO7XtmXJKk0eHz2VX5LPaKezHyBH7hEnbk4++tNuTJXKyAmqkbE+mczOMt++QF9c64NDV4/VY3HFL3jJIPL2XysDzuVcYdNUw5jDk5ZPoPthtcUGkKAHqQAp7bvYqwTaJsDe/sZD7TQVg=
x-ms-office365-filtering-correlation-id: 4d031033-060b-4fc8-1756-08d68c1bcf61
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:CY4PR18MB1238;
x-ms-traffictypediagnostic: CY4PR18MB1238:
x-microsoft-antispam-prvs: <CY4PR18MB123810201F42AFC4CEFB41D3CD6F0@CY4PR18MB1238.namprd18.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(366004)(346002)(39860400002)(199004)(189003)(2501003)(14444005)(256004)(2201001)(86362001)(4326008)(105586002)(6512007)(106356001)(36756003)(486006)(68736007)(102836004)(1076003)(6436002)(66066001)(6506007)(97736004)(14454004)(8936002)(71190400001)(26005)(316002)(81166006)(81156014)(11346002)(107886003)(54906003)(110136005)(76176011)(7736002)(8676002)(99286004)(305945005)(71200400001)(186003)(478600001)(15650500001)(6486002)(2906002)(476003)(25786009)(2616005)(446003)(53936002)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR18MB1238;H:CY4PR18MB1112.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Xuzr+CFwfwWVYPZbTITcMW/dQaWojMmZeKqmpLdYERTiltlWIYgW1Qp+cg+NzpJe8XD9ZJWY0ONnKql1bLJuDS+Fu48ixJpa5TVFQZbyDPtrq2oEsbA1IMmOY2hF9XJ2B5+Zc9iiIMxBaAWsrsXOl8w9pzJHwFZZRnAe0/wtMk9yFspfYMzioTAHHz4xlFdp1yPdNvxq9pObOFttMuDwcdSbkSoRa2lGdmchNLoNpqxKAlhIF3Vjg9InrAOCBXfUR5XEaZA88NKyDnN4wX5o81HiW7v4/oKfzQ5dd6kQvmGzWH+c4nPrQiqHn+PjOPhcfDG5fByun3OA8yA7dVG1pqIyC52PrBAVF/LUNly4ji0960iPlcggHXhFx1aRuaKKUBU780deai23elYWrFX17JJrga/fkfaP3jT2rWGJRSg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d031033-060b-4fc8-1756-08d68c1bcf61
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 10:13:57.4061
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
 mlxlogscore=621 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902060081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases it could happen that nicvf_send_msg_to_pf() could be called
concurrently for the same NIC VF, and thus re-writing mailbox contents and
breaking messaging sequence with PF by re-writing NICVF data.

This commit is to implement mutex for NICVF to protect mailbox registers
and NICVF messaging control data from concurrent access.

Signed-off-by: Vadim Lomovtsev <vlomovtsev@marvell.com>
---
 drivers/net/ethernet/cavium/thunder/nic.h        |  2 ++
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 13 ++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethern=
et/cavium/thunder/nic.h
index 227343625e83..86cda3f4b37b 100644
--- a/drivers/net/ethernet/cavium/thunder/nic.h
+++ b/drivers/net/ethernet/cavium/thunder/nic.h
@@ -329,6 +329,8 @@ struct nicvf {
 	spinlock_t              rx_mode_wq_lock;
 	/* workqueue for handling kernel ndo_set_rx_mode() calls */
 	struct workqueue_struct *nicvf_rx_mode_wq;
+	/* mutex to protect VF's mailbox contents from concurrent access */
+	struct mutex            rx_mode_mtx;
=20
 	/* PTP timestamp */
 	struct cavium_ptp	*ptp_clock;
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net=
/ethernet/cavium/thunder/nicvf_main.c
index 30c7f54b4f17..a05e2989ec76 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -124,6 +124,9 @@ int nicvf_send_msg_to_pf(struct nicvf *nic, union nic_m=
bx *mbx)
 {
 	int timeout =3D NIC_MBOX_MSG_TIMEOUT;
 	int sleep =3D 10;
+	int ret =3D 0;
+
+	mutex_lock(&nic->rx_mode_mtx);
=20
 	nic->pf_acked =3D false;
 	nic->pf_nacked =3D false;
@@ -136,7 +139,8 @@ int nicvf_send_msg_to_pf(struct nicvf *nic, union nic_m=
bx *mbx)
 			netdev_err(nic->netdev,
 				   "PF NACK to mbox msg 0x%02x from VF%d\n",
 				   (mbx->msg.msg & 0xFF), nic->vf_id);
-			return -EINVAL;
+			ret =3D -EINVAL;
+			break;
 		}
 		msleep(sleep);
 		if (nic->pf_acked)
@@ -146,10 +150,12 @@ int nicvf_send_msg_to_pf(struct nicvf *nic, union nic=
_mbx *mbx)
 			netdev_err(nic->netdev,
 				   "PF didn't ACK to mbox msg 0x%02x from VF%d\n",
 				   (mbx->msg.msg & 0xFF), nic->vf_id);
-			return -EBUSY;
+			ret =3D -EBUSY;
+			break;
 		}
 	}
-	return 0;
+	mutex_unlock(&nic->rx_mode_mtx);
+	return ret;
 }
=20
 /* Checks if VF is able to comminicate with PF
@@ -2211,6 +2217,7 @@ static int nicvf_probe(struct pci_dev *pdev, const st=
ruct pci_device_id *ent)
 							nic->vf_id);
 	INIT_WORK(&nic->rx_mode_work.work, nicvf_set_rx_mode_task);
 	spin_lock_init(&nic->rx_mode_wq_lock);
+	mutex_init(&nic->rx_mode_mtx);
=20
 	err =3D register_netdev(netdev);
 	if (err) {
--=20
2.17.2
