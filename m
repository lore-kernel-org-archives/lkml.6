Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC21C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7AB520823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KcCpK+PH";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="tWGDaTPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfBFKOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:14:36 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:52932 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726598AbfBFKOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:14:12 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x16AAHKq019413;
        Wed, 6 Feb 2019 02:13:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=lQHzIhOtOTzf4ATNxmUuUFKuTu61+ra8LZuUsaY+jDs=;
 b=KcCpK+PHx4cmYUBNxYM68PWAWl7v/EDieH8JATUCvOa6LUcLfS7E6mamOlhYlLbLXJoA
 GV/SMUevwrHJ0mCs0ytXPmleOYdQyz7Cxgj4box8pvWJt2ktbNkRsHolHFFnfBIXlSmv
 Fw5YFtX5OGxmgIpG+bSpv6mI0rRPupmjxr/ZSTxHrW5tH0wP1dwePS59r7l2RAeh2lut
 Xdr/raEk8nu6trYH9Ca/jVg8xkZt/1EMBi5ZeNdukEfw7bA8ol4NGvIYsoXH7EcxpdU8
 EoIgLxpkOH2P9xejvGtOYBGvi1vlXFnGthwDAPPgy9iayRrD2nwueyiHBlV/IwdOY8e6 rg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2qfc17k9k4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Feb 2019 02:13:59 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 6 Feb
 2019 02:13:58 -0800
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.57) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 6 Feb 2019 02:13:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQHzIhOtOTzf4ATNxmUuUFKuTu61+ra8LZuUsaY+jDs=;
 b=tWGDaTPtNknoebSpI2HG8zX74N4RYS93p5gueYbU3I1eh5P5rqfPapQO2Q1JHHvOD825Az7RYbBXuGuRRObfA9e2jlaHcPek9pRckejiiefg+zgItD1r46LFl4HekdgFqExU3Sx0tSC44OB6tG4xOhDh36lD1Nl8mqNk3P9hKNk=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.184.11) by
 CY4PR18MB1238.namprd18.prod.outlook.com (10.172.176.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 10:13:56 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::1517:6511:71e8:6137]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::1517:6511:71e8:6137%10]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 10:13:56 +0000
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
Subject: [PATCH 3/8] net: thunderx: make CFG_DONE message to run through
 generic send-ack sequence
Thread-Topic: [PATCH 3/8] net: thunderx: make CFG_DONE message to run through
 generic send-ack sequence
Thread-Index: AQHUvgSqM1V8xsK6TEiqR1ob1UmYjw==
Date:   Wed, 6 Feb 2019 10:13:55 +0000
Message-ID: <20190206101351.16744-4-vlomovtsev@marvell.com>
References: <20190206101351.16744-1-vlomovtsev@marvell.com>
In-Reply-To: <20190206101351.16744-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR18MB1238;20:kAghwz0n03USdmdhlejjbXbYnpBw6X3Kjvd0sg2gv568LnfjL4XA6nhpFDjaM6BchtCWz0QY+eEkZe2RiUuKuqvDXY0nwguzjDIjQuLFWeu3T50ZcAlsDC5rLGxmRXKkqX7uRPanBpdfxE5pGQS5R6hXN4b7mnm7GNs/Vo4/9Fk=
x-ms-office365-filtering-correlation-id: 2ba50d09-dd08-4676-1c28-08d68c1bcdf2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:CY4PR18MB1238;
x-ms-traffictypediagnostic: CY4PR18MB1238:
x-microsoft-antispam-prvs: <CY4PR18MB1238F1B8C91AD51F76DF1B98CD6F0@CY4PR18MB1238.namprd18.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(366004)(346002)(39860400002)(199004)(189003)(2501003)(256004)(2201001)(86362001)(4326008)(105586002)(6512007)(106356001)(36756003)(486006)(68736007)(102836004)(1076003)(6436002)(66066001)(6506007)(97736004)(14454004)(8936002)(71190400001)(26005)(316002)(81166006)(81156014)(11346002)(107886003)(54906003)(110136005)(76176011)(7736002)(8676002)(99286004)(305945005)(71200400001)(186003)(478600001)(15650500001)(6486002)(2906002)(476003)(25786009)(2616005)(446003)(53936002)(3846002)(6116002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR18MB1238;H:CY4PR18MB1112.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0A1FOqDXdMT41JB0uSKAXczsIZ/r1sTxT2FgZD8DAmqeceMusDbnHFMfpWkZ9nnJmXHB1600PIAyjd2JgOxVttMR9tfFkfRopty3DhDXQew0HnPe84itM5lU5AJlm7aCgO6MI5eR5/mFw6t4zAIbbnynoBp7E6LTjt7Lj5StnLw6+Qqs0gXprqPlgr9cBQm+qHBfLUAeeLlHdhjJKmaWwSQrGnNBGNy/2zUZVjHCFuA/GCwIZAlorlq8Q9Tc24eZg+ta0uOtsXIDswMTr2DhRetNju+XxdiqjL8QyaO4dTeifa+viRTxCQxD9+iJeRCItVEwkWLRa3a5UyXJ6KtEfMDlztsvTrRyhxrVPkWrYZVX76MeG9u4LchoZz9niBHgA1ZtUN6zmVW3tJEm11jAvQBjnU46CdnkMHPL7g5JxCA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba50d09-dd08-4676-1c28-08d68c1bcdf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 10:13:55.4525
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
 mlxlogscore=834 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902060081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the end of NIC VF initialization it send CFG_DONE message to PF without
using nicvf_msg_send_to_pf routine. This potentially could re-write data in
mailbox. This commit is to implement common way of sending CFG_DONE message
by the same way with other configuration messages by using
nicvf_send_msg_to_pf() routine.

Signed-off-by: Vadim Lomovtsev <vlomovtsev@marvell.com>
---
 drivers/net/ethernet/cavium/thunder/nic_main.c |  2 +-
 .../net/ethernet/cavium/thunder/nicvf_main.c   | 18 +++++++++++++++---
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nic_main.c b/drivers/net/e=
thernet/cavium/thunder/nic_main.c
index 6c8dcb65ff03..90497a27df18 100644
--- a/drivers/net/ethernet/cavium/thunder/nic_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nic_main.c
@@ -1039,7 +1039,7 @@ static void nic_handle_mbx_intr(struct nicpf *nic, in=
t vf)
 	case NIC_MBOX_MSG_CFG_DONE:
 		/* Last message of VF config msg sequence */
 		nic_enable_vf(nic, vf, true);
-		goto unlock;
+		break;
 	case NIC_MBOX_MSG_SHUTDOWN:
 		/* First msg in VF teardown sequence */
 		if (vf >=3D nic->num_vf_en)
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net=
/ethernet/cavium/thunder/nicvf_main.c
index abf24e7dff2d..b0e8a04e0f1e 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -169,6 +169,20 @@ static int nicvf_check_pf_ready(struct nicvf *nic)
 	return 1;
 }
=20
+static int nicvf_send_cfg_done(struct nicvf *nic)
+{
+	union nic_mbx mbx =3D {};
+
+	mbx.msg.msg =3D NIC_MBOX_MSG_CFG_DONE;
+	if (nicvf_send_msg_to_pf(nic, &mbx)) {
+		netdev_err(nic->netdev,
+			   "PF didn't respond to CFG DONE msg\n");
+		return 0;
+	}
+
+	return 1;
+}
+
 static void nicvf_read_bgx_stats(struct nicvf *nic, struct bgx_stats_msg *=
bgx)
 {
 	if (bgx->rx)
@@ -1416,7 +1430,6 @@ int nicvf_open(struct net_device *netdev)
 	struct nicvf *nic =3D netdev_priv(netdev);
 	struct queue_set *qs =3D nic->qs;
 	struct nicvf_cq_poll *cq_poll =3D NULL;
-	union nic_mbx mbx =3D {};
=20
 	/* wait till all queued set_rx_mode tasks completes if any */
 	drain_workqueue(nic->nicvf_rx_mode_wq);
@@ -1515,8 +1528,7 @@ int nicvf_open(struct net_device *netdev)
 		nicvf_enable_intr(nic, NICVF_INTR_RBDR, qidx);
=20
 	/* Send VF config done msg to PF */
-	mbx.msg.msg =3D NIC_MBOX_MSG_CFG_DONE;
-	nicvf_write_to_mbx(nic, &mbx);
+	nicvf_send_cfg_done(nic);
=20
 	return 0;
 cleanup:
--=20
2.17.2
