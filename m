Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE405C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF64218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="W4lX10V5";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="JaUez7wW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbfBRJwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:52:42 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:56022 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729613AbfBRJwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:52:35 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1I9qE5e025142;
        Mon, 18 Feb 2019 01:52:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=mD57Pz4kw6vQvhnuaEVlrO3B59YB1i1nAdFGqNum71s=;
 b=W4lX10V539DNHukNGSotraYIaZHQVxqKhM6o4pSCy5gqcTLG18+zN3YfCJCyhxOXPCKa
 DiuA/+hiQusWqywqfO0oWl1ZCdtGKC2qCZyrfx9ZapQBchwjubBN1UVZEF5c7Tsa0lZU
 xsYJCg28I3Gu3T6fTXOfDzAbf5P3cRB9iie8nrmy/KspaCRdWJ8V7lAp/RlFX+d1GLw5
 uVau04J3UqXKWeIxaAjOvlDaksADOdzaWmQ5fjepzzOvIY8CQAIghLqk4mN34opmtcFi
 p1nlDsNnGce+X2Pstv/bs/I6lpMB1Vb1GsFPQNh/9Jdj0vPNwaZ5ri5ZAuZZ0v/ArJw6 aw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2qpjwpw14e-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 18 Feb 2019 01:52:24 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 18 Feb
 2019 01:52:20 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.51) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 18 Feb 2019 01:52:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mD57Pz4kw6vQvhnuaEVlrO3B59YB1i1nAdFGqNum71s=;
 b=JaUez7wWf+8tFr5TaJgj9b5JTk0K3UHBnnA5UaX5C0UCAUl4L62RP1xgWyMZISTxmMOGx8i0jI1lPKmaLw/3IO5ecbRB48FNUqOgg73D1YT+/Thg2ry5kluIC4BNo1aa4qmF/DpbXHW7AI9ZzDSm7u0b2qaG7mIDTzeY7lgU7PE=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.183.147) by
 CY4PR18MB0968.namprd18.prod.outlook.com (10.173.182.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Mon, 18 Feb 2019 09:52:17 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4%4]) with mapi id 15.20.1622.020; Mon, 18 Feb 2019
 09:52:17 +0000
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
Subject: [PATCH v2 5/8] net: thunderx: rework xcast message structure to make
 it fit into 64 bit
Thread-Topic: [PATCH v2 5/8] net: thunderx: rework xcast message structure to
 make it fit into 64 bit
Thread-Index: AQHUx2+gxB5G9fdx+kyPVr0BEHDEvA==
Date:   Mon, 18 Feb 2019 09:52:15 +0000
Message-ID: <20190218095159.3847-6-vlomovtsev@marvell.com>
References: <20190218095159.3847-1-vlomovtsev@marvell.com>
In-Reply-To: <20190218095159.3847-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d41fecc0-c4c7-467b-ede1-08d69586c480
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR18MB0968;
x-ms-traffictypediagnostic: CY4PR18MB0968:
x-microsoft-exchange-diagnostics: 1;CY4PR18MB0968;20:gRe9O/mnVGiv6l5vHLlwb+q9k57uXjl9LFPNocpN9DqrWc0lwwJi1+9k29zpOqfwPPXjJf7NESx2TcpdTSQQhJ4sdmGgxIjul/P/ppNnvOnE87LNqiGzzY1jx+4ewzQrzrOhEawTnJz4ZR2AZp43PKOoV0yhxC8Zvua2Roi1H/M=
x-microsoft-antispam-prvs: <CY4PR18MB0968FF63C9301F4F75017D34CD630@CY4PR18MB0968.namprd18.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(396003)(376002)(366004)(346002)(136003)(199004)(189003)(486006)(7736002)(305945005)(316002)(4326008)(110136005)(54906003)(25786009)(99286004)(8936002)(476003)(5660300002)(186003)(2616005)(76176011)(81166006)(81156014)(6436002)(446003)(11346002)(14454004)(2906002)(8676002)(71190400001)(71200400001)(14444005)(6506007)(256004)(68736007)(1076003)(2501003)(2201001)(36756003)(6486002)(53936002)(86362001)(106356001)(102836004)(26005)(15650500001)(97736004)(3846002)(105586002)(66066001)(6116002)(478600001)(6512007)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR18MB0968;H:CY4PR18MB1112.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0qru0rrGbV++BUuUiH1HR8szFNjBM8HJuI2sMkcoGBgyQhPAfe9AvJkzSfmhLLoub1xNxsiIaPOOj/69SiZfsNrnNV7D7JMalK6fGlQMeTLo5ITYjgVUzFyDj/owYxpdDPd/IZXUwGkpK5gb9osxreTzIk8wRd8xIwEi6Jtm7qJ0W/jZFh3WLCyJnKdI3ZGpgU9C5ENVx/SrRYK4EagVhRbVNisfgf7/gojezqu5yu+YSJ0tqLem4BTz3zTwIg7/qLJ2LQVHUKhuD0/M6oq0BH+fGJIcE5+pd2XFfTN5U/q88N6MTfoRbccIiAjUZmcX0fMJb9R6OE1+re7xY91DOCtzPnXC0LbQVC+6p/QwJJAcnd0C3JaKckli1yeBp6E5SG7I/7am/faFfbZAowgxYPiXaS5C6EeDMp5uGi+C2ZQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d41fecc0-c4c7-467b-ede1-08d69586c480
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 09:52:15.6298
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
 mlxlogscore=350 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902180075
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
index dbd8862d60d6..30c7f54b4f17 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1964,7 +1964,7 @@ static void __nicvf_set_rx_mode_task(u8 mode, struct =
xcast_addr_list *mc_addrs,
 		 * its' own LMAC to the filter to accept packets for it.
 		 */
 		mbx.xcast.msg =3D NIC_MBOX_MSG_ADD_MCAST;
-		mbx.xcast.data.mac =3D 0;
+		mbx.xcast.mac =3D 0;
 		if (nicvf_send_msg_to_pf(nic, &mbx) < 0)
 			goto free_mc;
 	}
@@ -1974,7 +1974,7 @@ static void __nicvf_set_rx_mode_task(u8 mode, struct =
xcast_addr_list *mc_addrs,
 		/* now go through kernel list of MACs and add them one by one */
 		for (idx =3D 0; idx < mc_addrs->count; idx++) {
 			mbx.xcast.msg =3D NIC_MBOX_MSG_ADD_MCAST;
-			mbx.xcast.data.mac =3D mc_addrs->mc[idx];
+			mbx.xcast.mac =3D mc_addrs->mc[idx];
 			if (nicvf_send_msg_to_pf(nic, &mbx) < 0)
 				goto free_mc;
 		}
@@ -1982,7 +1982,7 @@ static void __nicvf_set_rx_mode_task(u8 mode, struct =
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
