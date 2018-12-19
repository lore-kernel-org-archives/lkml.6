Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C7FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBCA2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U93ZyPbc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbeLSIjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:39:07 -0500
Received: from mail-eopbgr10042.outbound.protection.outlook.com ([40.107.1.42]:16906
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728067AbeLSIjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:39:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQ+2tC6AxaMqxzQcePJSsACdlk6ZPcs3B4lShio9FnI=;
 b=U93ZyPbcChynlb4dGhHgLEXp5PZ4iOJ+eV3TM5UQLIQye78wOqQWAsHnKai1sWttRUdt+valim8U3oGNRjZF9suB4P2LSopqiDk2fKn/VkXy9w75yBUpGbphhS+W+mahTuAo+m7pxVNMsa0NmvXpVoUocJmqI8pMSbf0ZhpFLoA=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4154.eurprd04.prod.outlook.com (52.135.130.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Wed, 19 Dec 2018 08:39:00 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::edcf:3d61:66a6:8bc9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::edcf:3d61:66a6:8bc9%4]) with mapi id 15.20.1446.018; Wed, 19 Dec 2018
 08:39:00 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 1/3] can: rx-offload: add CANFD support based on offload
Thread-Topic: [PATCH 1/3] can: rx-offload: add CANFD support based on offload
Thread-Index: AQHUl3ZK/Ury/NpTxUevLnnrXnBeig==
Date:   Wed, 19 Dec 2018 08:39:00 +0000
Message-ID: <20181219083637.641-2-qiangqing.zhang@nxp.com>
References: <20181219083637.641-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181219083637.641-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR0601CA0014.apcprd06.prod.outlook.com (2603:1096:3::24)
 To DB7PR04MB4618.eurprd04.prod.outlook.com (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4154;6:Nj1cmm+xxv8wF+fqC7VOkt60exn5MFT99f1EK9RKxSoCBka9G8knOpzjOzbKgsGDnCIHpnsqd0jb+5C4vA0+PlQEZhuZGzbsBk0Tn/310YESE+3+sZjnNF5/ug+0MFh6SZ1g1QKxIrwtXHwChjHGDpc+GuPqhLGkMPbImZKwCQ2sAvC7x/F0Jlj8sRVALkI4HOkKQoRHOWkqJoVzPo1eeBw7k0kgmewwmUTm7ViiNTAnn40qUwmE70EBqMEryLJygCHgwfsVwDXMfTI7FaZ1I+yBS6cr6I/Os0HkzEncisMcFxI+MJkoGqrq8HSQBut2TY1AHzg7z5RBvHaCPAyUkE2lG7R0rbDQGjFWqY3zkaTU+W+hsy8n27xXOW4Ak+hxpkU6sZv63+bt/wSA3bOU2/ogJlHA24bsBS72EoSwCjER4vghJtVDoM9IWDhnQt0z/RcZq2lVFMw90kGPLejxmQ==;5:IIN0tlfdthkcMyD30qgMHkuGGp49WuBMfMfVVXA6BQ6pn03btvOWkK2Lq4EL9YjPE+V1kJAuAm8/eDG5tXjP5dtDw9N41AjIZPqpMycIYozTlwRJ3mal/aC/zyvsSajfhwQBNzD/TklXXIW7oyd2N1VWdnP3dxzL4WMwMfuZRM4=;7:h/9h0EK9Xg4Xw7nkvGG51c6GnevIpKVXEQWoiS8Yhx1rW6gAD8aV0qCetJzTPuYYZREjrESztq/g+UfsTopA6RFZE49xHI4QdlRHmASmYAhZxgKUUNxK98HbzBF4GTnsOtVXWZX56FYowaB0iTc8Xg==
x-ms-office365-filtering-correlation-id: 6055cc36-e610-4c95-ff5b-08d6658d6c5b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4154;
x-ms-traffictypediagnostic: DB7PR04MB4154:
x-microsoft-antispam-prvs: <DB7PR04MB4154DEEEBBDEF1352E17CCDCE6BE0@DB7PR04MB4154.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4154;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4154;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(7736002)(6116002)(6512007)(8676002)(81156014)(3846002)(2906002)(1076003)(53936002)(71190400001)(71200400001)(5660300001)(110136005)(52116002)(99286004)(316002)(6506007)(386003)(26005)(54906003)(50226002)(8936002)(81166006)(186003)(6486002)(86362001)(102836004)(76176011)(6436002)(2501003)(97736004)(68736007)(11346002)(25786009)(446003)(66066001)(478600001)(305945005)(4326008)(476003)(105586002)(2616005)(486006)(106356001)(36756003)(14454004)(14444005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4154;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YIUKg7UpB2kGcGsffxC9GndBu8cQkgGzLx9IAAs7SoHXZgVX7Qhmz99HrEl+WN0T9VhGH0lCY81dmqagBMSW3XuGaO3Cthy5ELtmHH6RNJXPBrL0SVil7sEWJjByGBsZNopQ7S4CSQ47Bhm9042oDE7nqOCrhWV6omwfnP4PZpP8hZyygO+jYUvAy1wAxNADW1r3NtQS+s6f3bo54OGeNnTSoP/4Ujoqi3r3T7EzVALF4oSNQVXHudJCuvizPit6lOyQRO/ICq5D6ilBaB+c3swZ7RJms5B5eXoSlgyyRT0KIzN+QBILDcy2sFzgb9OB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6055cc36-e610-4c95-ff5b-08d6658d6c5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 08:39:00.4888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

Using struct canfd_frame instead of can_frame to add support for CAN FD
mode in offload. FlexCAN controller will set the is_canfd variable when
it supports CAN FD mode.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/rx-offload.c   | 16 ++++++++++------
 include/linux/can/rx-offload.h |  4 +++-
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index 2ce4fa8698c7..131fe600deb3 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -55,11 +55,11 @@ static int can_rx_offload_napi_poll(struct napi_struct =
*napi, int quota)
=20
 	while ((work_done < quota) &&
 	       (skb =3D skb_dequeue(&offload->skb_queue))) {
-		struct can_frame *cf =3D (struct can_frame *)skb->data;
+		struct canfd_frame *cf =3D (struct canfd_frame *)skb->data;
=20
 		work_done++;
 		stats->rx_packets++;
-		stats->rx_bytes +=3D cf->can_dlc;
+		stats->rx_bytes +=3D cf->len;
 		netif_receive_skb(skb);
 	}
=20
@@ -122,16 +122,20 @@ static struct sk_buff *can_rx_offload_offload_one(str=
uct can_rx_offload *offload
 {
 	struct sk_buff *skb =3D NULL;
 	struct can_rx_offload_cb *cb;
-	struct can_frame *cf;
+	struct canfd_frame *cf;
 	int ret;
=20
 	/* If queue is full or skb not available, read to discard mailbox */
 	if (likely(skb_queue_len(&offload->skb_queue) <=3D
-		   offload->skb_queue_len_max))
-		skb =3D alloc_can_skb(offload->dev, &cf);
+		   offload->skb_queue_len_max)) {
+		if (offload->is_canfd)
+			skb =3D alloc_canfd_skb(offload->dev, &cf);
+		else
+			skb =3D alloc_can_skb(offload->dev, (struct can_frame **)&cf);
+	}
=20
 	if (!skb) {
-		struct can_frame cf_overflow;
+		struct canfd_frame cf_overflow;
 		u32 timestamp;
=20
 		ret =3D offload->mailbox_read(offload, &cf_overflow,
diff --git a/include/linux/can/rx-offload.h b/include/linux/can/rx-offload.=
h
index 8268811a697e..6448e7dfc170 100644
--- a/include/linux/can/rx-offload.h
+++ b/include/linux/can/rx-offload.h
@@ -23,7 +23,7 @@
 struct can_rx_offload {
 	struct net_device *dev;
=20
-	unsigned int (*mailbox_read)(struct can_rx_offload *offload, struct can_f=
rame *cf,
+	unsigned int (*mailbox_read)(struct can_rx_offload *offload, struct canfd=
_frame *cf,
 				     u32 *timestamp, unsigned int mb);
=20
 	struct sk_buff_head skb_queue;
@@ -35,6 +35,8 @@ struct can_rx_offload {
 	struct napi_struct napi;
=20
 	bool inc;
+
+	bool is_canfd;
 };
=20
 int can_rx_offload_add_timestamp(struct net_device *dev, struct can_rx_off=
load *offload);
--=20
2.17.1

