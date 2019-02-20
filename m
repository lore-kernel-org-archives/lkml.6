Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C829C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D40720665
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DG2WB07d";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="N3xDBXqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfBTLDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:03:02 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:57050 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727705AbfBTLDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:03:01 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1KAxWY9017731;
        Wed, 20 Feb 2019 03:02:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=m0icPlnjdw0MyawfU+Zn1B167+3UcdNfOpnu4IYQv50=;
 b=DG2WB07dPlOFRDfy11O9NKqNANXyGZDX05YukzdK4j8Brzwf1wLttA0ofcvOaYqD9R3b
 M9IpuBh7uhuvfOfX4MvcQTXHHDEXh0+z/+gPnGn+QwnCoU0fInGVPaCux/ngs4P4zzrt
 +ed5mIsmoTy2okDMNeCDav/dOZHoyFDSoft1l8uELF83Oqxh6h68powHRxL9CB/YuQNv
 Ob3/G2hbGVKroxYVEgfTx/ZPSTS8WfknT1TkpxR1kqT81zUlu4Sk+2XsUcia9hxXUmrs
 L2KBLsCuIXyqm1IIlbiUitOjk9F/JVhJHMK49U+Ep/teXnBOujO0K4p4WQvopUPfOL8K GQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2qrtta9gjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Feb 2019 03:02:50 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 20 Feb
 2019 03:02:49 -0800
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.58) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 20 Feb 2019 03:02:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0icPlnjdw0MyawfU+Zn1B167+3UcdNfOpnu4IYQv50=;
 b=N3xDBXqAk1VdKV21v8UlLuVohSpUr23EG/I9Amw03GlIrdJQY+L0g3vrP6/kyqglYMlK/Z2DU6+uHqNnFW6qrhPcflhMgRdQuNCZpQzgmdakvhO74DEqU0GRdZkIhzJm5TMnx0+rrXYzUZi2bazLVDuj86FkuCodgZPI+wpghn8=
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
Subject: [PATCH v3 4/8] net: thunderx: add nicvf_send_msg_to_pf result check
 for set_rx_mode_task
Thread-Topic: [PATCH v3 4/8] net: thunderx: add nicvf_send_msg_to_pf result
 check for set_rx_mode_task
Thread-Index: AQHUyQvOBxKBEhJ28keisNExI8uQQw==
Date:   Wed, 20 Feb 2019 11:02:44 +0000
Message-ID: <20190220110225.9497-5-vlomovtsev@marvell.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20190220110225.9497-1-vlomovtsev@marvell.com>
In-Reply-To: <20190220110225.9497-1-vlomovtsev@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74fd8690-ec07-4057-786a-08d69722f16c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR18MB1350;
x-ms-traffictypediagnostic: CY4PR18MB1350:
x-microsoft-exchange-diagnostics: 1;CY4PR18MB1350;20:xvUMaUXDnNozZU7LlPsobv6vf1ZmOe1zdHqNZIKzBCq8b8mfAOzaWmp5m4NhwziWuHyq+sEco6BgNZeID6ural0vBqLTWblNaOkgyL8wwEwEfnbvalKDT3v/3Lwr+08plpB9W8gvuWrnp/vRSOqQp0dvXHhuBFo0d9EVXrabYgk=
x-microsoft-antispam-prvs: <CY4PR18MB1350B9B4FC8EFCD477C0DF19CD7D0@CY4PR18MB1350.namprd18.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(86362001)(97736004)(478600001)(476003)(11346002)(2616005)(68736007)(446003)(6512007)(5660300002)(256004)(186003)(99286004)(14454004)(76176011)(2906002)(36756003)(6486002)(2201001)(102836004)(6506007)(2501003)(6436002)(26005)(316002)(8936002)(305945005)(7736002)(25786009)(1076003)(53936002)(71200400001)(54906003)(81156014)(4326008)(110136005)(106356001)(107886003)(66066001)(81166006)(6116002)(8676002)(71190400001)(105586002)(3846002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR18MB1350;H:CY4PR18MB1112.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e1bDHUQxxB3spsAP5xR8qWNTmlW5nPs+NBSMvi/y0LtkRXSQIuZyejfcuAwbXy7YWjzotyhV6djHuHhs4I+k4K9KkFM2l41cjikZbyqEO3IIWn3Y2GPm2hpJlnGDaThiNGLRNc/WtSg6N66RkkCd5PfTv7uMFo7Xy58I/WkwpfVHxf6pZ5ChhOD7aA9exL1S9MTCE2k/dqlMrjZppuPaCTmqrsIQqWQ5rpdROqqcK2vQuUUqE6/WGH0ieqDXbvbBafqMwVgVM18u+0c9A/PnbC9vz5lnCSF3gHH0SObto0RV1ayb5xa0XuC7ZVAnm9q2gI2Qmlc6DQZ2GnMX/YZnM9TKFR5z3+39RauX3CfR4zSn2klqIGpZbcl3UulQAELPe7zWaJN79801Za7OP99acChiDzgx83JbOmVcUWLWxps=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 74fd8690-ec07-4057-786a-08d69722f16c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 11:02:44.2743
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
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rx_set_mode invokes number of messages to be send to PF for receive
mode configuration. In case if there any issues we need to stop sending
messages and release allocated memory.

This commit is to implement check of nicvf_msg_send_to_pf() result.

Signed-off-by: Vadim Lomovtsev <vlomovtsev@marvell.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net=
/ethernet/cavium/thunder/nicvf_main.c
index 19b58fc3ca41..45f06504a61b 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1953,7 +1953,8 @@ static void __nicvf_set_rx_mode_task(u8 mode, struct =
xcast_addr_list *mc_addrs,
=20
 	/* flush DMAC filters and reset RX mode */
 	mbx.xcast.msg =3D NIC_MBOX_MSG_RESET_XCAST;
-	nicvf_send_msg_to_pf(nic, &mbx);
+	if (nicvf_send_msg_to_pf(nic, &mbx) < 0)
+		goto free_mc;
=20
 	if (mode & BGX_XCAST_MCAST_FILTER) {
 		/* once enabling filtering, we need to signal to PF to add
@@ -1961,7 +1962,8 @@ static void __nicvf_set_rx_mode_task(u8 mode, struct =
xcast_addr_list *mc_addrs,
 		 */
 		mbx.xcast.msg =3D NIC_MBOX_MSG_ADD_MCAST;
 		mbx.xcast.data.mac =3D 0;
-		nicvf_send_msg_to_pf(nic, &mbx);
+		if (nicvf_send_msg_to_pf(nic, &mbx) < 0)
+			goto free_mc;
 	}
=20
 	/* check if we have any specific MACs to be added to PF DMAC filter */
@@ -1970,9 +1972,9 @@ static void __nicvf_set_rx_mode_task(u8 mode, struct =
xcast_addr_list *mc_addrs,
 		for (idx =3D 0; idx < mc_addrs->count; idx++) {
 			mbx.xcast.msg =3D NIC_MBOX_MSG_ADD_MCAST;
 			mbx.xcast.data.mac =3D mc_addrs->mc[idx];
-			nicvf_send_msg_to_pf(nic, &mbx);
+			if (nicvf_send_msg_to_pf(nic, &mbx) < 0)
+				goto free_mc;
 		}
-		kfree(mc_addrs);
 	}
=20
 	/* and finally set rx mode for PF accordingly */
@@ -1980,6 +1982,8 @@ static void __nicvf_set_rx_mode_task(u8 mode, struct =
xcast_addr_list *mc_addrs,
 	mbx.xcast.data.mode =3D mode;
=20
 	nicvf_send_msg_to_pf(nic, &mbx);
+free_mc:
+	kfree(mc_addrs);
 }
=20
 static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
--=20
2.17.2
