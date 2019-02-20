Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FC7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606C120685
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="xOFnFv39";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="axa2fRew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfBTLDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:03:06 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:57044 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727694AbfBTLDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:03:00 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1KAxWYA017731;
        Wed, 20 Feb 2019 03:02:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=I7MHGovnPMTZkAD/w9P/e+ROzRiIkQC8nHEvFMKyCCY=;
 b=xOFnFv39BZ4Vfmpu+iiLLHWvWKCyeEreDii6h4GruKNRFoNkVSk9EVkJUE4XJ2aomUCQ
 kPOvlbXVSYItD4qxRKUXfkHJyk4e1GTILnjktx/LdscS23LRFz5C55RCKSlrs8RyVVZs
 wxrsxo3XrA53RP0zwML7kq5YR7oUapVNnDs8YUTXLGgLnToqIKmRS4I7ElpmuCELl5bV
 d3QoLZxAmK5c6k7vAKj9lQnerPBSHXtT8vhZjPGQHtsJneFMFsJcPMBKlYDAA7N19pqh
 P9mztxsqxRe6WEDG9ETqHmFRqUTfTLB/Xdfeei1YkGsWMczMhb+WogRLu/sdm0uXkLym fg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2qrtta9gjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Feb 2019 03:02:50 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 20 Feb
 2019 03:02:49 -0800
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.58) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 20 Feb 2019 03:02:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7MHGovnPMTZkAD/w9P/e+ROzRiIkQC8nHEvFMKyCCY=;
 b=axa2fRewKfDnCUfatECLzBBQ9xrph6unVJZ3OkiKK+nT4HxpdpadlX32BTyVRK9z4bGeTF+oRIizn1unm/LeGkue9B3W96DOQoc1Jg04CauYR3MkdvT3DOefBkPgLthC0uze742ldmN8yDmU/K5+/aIvgvgcu1Ia49WytIOs4Ws=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.183.147) by
 CY4PR18MB1350.namprd18.prod.outlook.com (10.173.247.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 20 Feb 2019 11:02:45 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4%4]) with mapi id 15.20.1643.014; Wed, 20 Feb 2019
 11:02:45 +0000
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
Subject: [PATCH v3 5/8] net: thunderx: rework xcast message structure to make
 it fit into 64 bit
Thread-Topic: [PATCH v3 5/8] net: thunderx: rework xcast message structure to
 make it fit into 64 bit
Thread-Index: AQHUyQvO394FVGRin0iNnndECswptg==
Date:   Wed, 20 Feb 2019 11:02:44 +0000
Message-ID: <20190220110225.9497-6-vlomovtsev@marvell.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20190220110225.9497-1-vlomovtsev@marvell.com>
In-Reply-To: <20190220110225.9497-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84bb55a4-23f0-42b9-ed31-08d69722f1b5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR18MB1350;
x-ms-traffictypediagnostic: CY4PR18MB1350:
x-microsoft-exchange-diagnostics: 1;CY4PR18MB1350;20:L5IvFPoQhzo/y6CVqkWVL+xbhnjZQirG4WxpaVekYdc6YbhnN3JXv+ec0iNvtKtWRWSoU1zY22lF3WNf0Z+pdizc18MQZh8kNucgLDCHNd/ZFBzq78cmOqbZA252twwBYQYCglYpE9JEh768Lwn1pO/r2poiSYDjcjYVIKHCw4Y=
x-microsoft-antispam-prvs: <CY4PR18MB1350938E6D7A8C67C47AC30FCD7D0@CY4PR18MB1350.namprd18.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(86362001)(97736004)(478600001)(476003)(11346002)(2616005)(14444005)(68736007)(446003)(6512007)(5660300002)(256004)(186003)(99286004)(14454004)(76176011)(2906002)(36756003)(6486002)(2201001)(102836004)(6506007)(2501003)(6436002)(26005)(316002)(8936002)(305945005)(15650500001)(7736002)(25786009)(1076003)(53936002)(71200400001)(54906003)(81156014)(4326008)(110136005)(106356001)(107886003)(66066001)(81166006)(6116002)(8676002)(71190400001)(105586002)(3846002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR18MB1350;H:CY4PR18MB1112.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2l9MmCT8mRO0zJxCgWGqVPrAcq3nHG7LGE7+oDlU6LBidaqnqu6kdAb6KnCJzCaapTmNQnBVzPIPODA8m5kl0BYcFEyRmSI7pZEz+df7Moeqwaqi70XRHPLTHGundIeLSCJN2KHoZgffEKYRinGQY/YtMpbt8DCJ8CqLkX/trjJxJ1ee3dXet6f1/V9iQE/YzUok7THAeaVrLnmgZQT5kkgV+hxwuIRS7j14yh4V0Uq9d+AyYKmxpY/4G4ps2lwq4OyjXNLpOo3VSwAbaWo/mK0mKLmaog+gp/hSGj/qaw/zysi+A/RHpYs4V6xyURhnuQ2F+yGtcP4aB+lFpmP13L2vsYOtRbdwgJlhCBa8p7PNRnjwlYd77qv1zOHfxfofujiUNck+koNmr9AeAThMQplKy5bJ3Rl/rJ+6WwvRk6o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bb55a4-23f0-42b9-ed31-08d69722f1b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 11:02:44.6106
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
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=351 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To communicate to PF each of ThunderX NIC VF uses mailbox which is
pair of 64 bit registers available to both VFn and PF.

This commit is to change the xcast message structure in order to
fit it into 64 bit.

Signed-off-by: Vadim Lomovtsev <vlomovtsev@marvell.com>
---
 drivers/net/ethernet/cavium/thunder/nic.h        | 6 ++----
 drivers/net/ethernet/cavium/thunder/nic_main.c   | 4 ++--
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 6 +++---
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethern=
et/cavium/thunder/nic.h
index 376a96bce33f..227343625e83 100644
--- a/drivers/net/ethernet/cavium/thunder/nic.h
+++ b/drivers/net/ethernet/cavium/thunder/nic.h
@@ -577,10 +577,8 @@ struct set_ptp {
=20
 struct xcast {
 	u8    msg;
-	union {
-		u8    mode;
-		u64   mac;
-	} data;
+	u8    mode;
+	u64   mac:48;
 };
=20
 /* 128 bit shared memory between PF and each VF */
diff --git a/drivers/net/ethernet/cavium/thunder/nic_main.c b/drivers/net/e=
thernet/cavium/thunder/nic_main.c
index 90497a27df18..620dbe082ca0 100644
--- a/drivers/net/ethernet/cavium/thunder/nic_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nic_main.c
@@ -1094,7 +1094,7 @@ static void nic_handle_mbx_intr(struct nicpf *nic, in=
t vf)
 		bgx =3D NIC_GET_BGX_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
 		lmac =3D NIC_GET_LMAC_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
 		bgx_set_dmac_cam_filter(nic->node, bgx, lmac,
-					mbx.xcast.data.mac,
+					mbx.xcast.mac,
 					vf < NIC_VF_PER_MBX_REG ? vf :
 					vf - NIC_VF_PER_MBX_REG);
 		break;
@@ -1106,7 +1106,7 @@ static void nic_handle_mbx_intr(struct nicpf *nic, in=
t vf)
 		}
 		bgx =3D NIC_GET_BGX_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
 		lmac =3D NIC_GET_LMAC_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
-		bgx_set_xcast_mode(nic->node, bgx, lmac, mbx.xcast.data.mode);
+		bgx_set_xcast_mode(nic->node, bgx, lmac, mbx.xcast.mode);
 		break;
 	default:
 		dev_err(&nic->pdev->dev,
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net=
/ethernet/cavium/thunder/nicvf_main.c
index 45f06504a61b..da5986ca7bee 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1961,7 +1961,7 @@ static void __nicvf_set_rx_mode_task(u8 mode, struct =
xcast_addr_list *mc_addrs,
 		 * its' own LMAC to the filter to accept packets for it.
 		 */
 		mbx.xcast.msg =3D NIC_MBOX_MSG_ADD_MCAST;
-		mbx.xcast.data.mac =3D 0;
+		mbx.xcast.mac =3D 0;
 		if (nicvf_send_msg_to_pf(nic, &mbx) < 0)
 			goto free_mc;
 	}
@@ -1971,7 +1971,7 @@ static void __nicvf_set_rx_mode_task(u8 mode, struct =
xcast_addr_list *mc_addrs,
 		/* now go through kernel list of MACs and add them one by one */
 		for (idx =3D 0; idx < mc_addrs->count; idx++) {
 			mbx.xcast.msg =3D NIC_MBOX_MSG_ADD_MCAST;
-			mbx.xcast.data.mac =3D mc_addrs->mc[idx];
+			mbx.xcast.mac =3D mc_addrs->mc[idx];
 			if (nicvf_send_msg_to_pf(nic, &mbx) < 0)
 				goto free_mc;
 		}
@@ -1979,7 +1979,7 @@ static void __nicvf_set_rx_mode_task(u8 mode, struct =
xcast_addr_list *mc_addrs,
=20
 	/* and finally set rx mode for PF accordingly */
 	mbx.xcast.msg =3D NIC_MBOX_MSG_SET_XCAST;
-	mbx.xcast.data.mode =3D mode;
+	mbx.xcast.mode =3D mode;
=20
 	nicvf_send_msg_to_pf(nic, &mbx);
 free_mc:
--=20
2.17.2
