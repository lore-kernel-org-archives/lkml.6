Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B977ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE8A21477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JmtAm7qe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE8A21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeIOGrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:00 -0400
Received: from mail-bn3nam01on0134.outbound.protection.outlook.com ([104.47.33.134]:14354
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727966AbeIOGq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6BNztpDZA7ITNEHaJGOm/5F8SzAXsMlRJGHeGlsvjY=;
 b=JmtAm7qeEYnTgG36VSHOEMAbgzDzBYYpPojA6zIH+IKYJn9v4PDoXk0r1/PJTjPJ0L3NG5aDDGVvbeLyXx3sSRk+CZA6DvRwX/8fnKpLnW6HwRXcDyF+LhE7HjVrhYqK59L8FI7RVGk5pRpbRzxN6K2C4Ls80aMuWrquxUNEiMY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:29:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:29:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Philipp Puschmann <pp@emlix.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 09/92] Bluetooth: Use lock_sock_nested in
 bt_accept_enqueue
Thread-Topic: [PATCH AUTOSEL 4.18 09/92] Bluetooth: Use lock_sock_nested in
 bt_accept_enqueue
Thread-Index: AQHUTJOboaNY5GoVtkCzFVJufIqIIg==
Date:   Sat, 15 Sep 2018 01:29:55 +0000
Message-ID: <20180915012944.179481-9-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:fGQmkE+1FM88Vn4vUJ/c7EZn7mELWiLklFKRzRB9tBMEwDz2xrzPQ4xl2dJgXZIDHbWIyEgwXannHz47YvM9fZpJcALwvA6jH9wylwpsS6eMKv+/zOFdrX7XaeadtOyESkqNG/AI/WUq8lRbw3miqKgiOc4Mj2wCU7V2lX+WTYsQ0uW9T2MIjwHnrjDjknAWPRBrQUw94Vr6D4EkDkHMjT11U+VU3znJqRwTeJJ/AJpCfx3UxXT6+X143Qm2fRKWY4danIkL+aqyJmy1g6KHbQShAP+AKYn/N8BULF2eBbbVH0jg+zEENJCsLg/LqXcjrWgVX3Zc8Jz/Dc1W9Hvyx1jbhCQxGvqgKRY+LM2R6Iy0hU5lLzAPmtIHYgaXSO99JJZDXLwWgFqfMShuRrr5sEkm03TulTRJFgWznxtuMnG+KY1EJRZN2LWmDpXN+Zvp36NE/6hdiULwlmHFaip6Vw==;5:K0pIOqWI9ZM92HzDz9qNIE2yc0olxR0OBxzFHJLMS2ztiDffv0kW9YyAH7UQSzdi+/OS23cEhIOdLV3wuG3xPZbfqKvTGhkMi5wFeUF7XSbEtU7Qrny6uhuDr5Rkwn4XiEXUEC8f7F/gTFoMjxZLLCMUNW78cDfFQAuJsdKmk7E=;7:Wb7rBAAqC25ZR+xJHLwSa4jbLafnei3UxFQXqG3E0R+lps2vW9fDjHKGt+jtn6myzX1RG1XYpyhIcMItBeqdr2A53fhTxqhwKQ3Lfi4a9mx1iInQdRYrWz/kuZWnCHZFaTjyV/9blU/6eRdGA2RnFHAPUtwYGvCsuu9nHpByl9kk/4iOpvvP/vkOkyPF2ajQYh7cbxpcoQ7rFttsLQx3IxTQOmAdYECySc72nsFDqpcQmMg/Fxp4jGf4JZTJdoiP
x-ms-office365-filtering-correlation-id: d5f1525c-0d91-41f3-03f3-08d61aaabdfa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB08404A40FC0200E17867BD78FB180@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(39860400002)(396003)(376002)(51234002)(189003)(199004)(14444005)(6116002)(81166006)(2906002)(446003)(478600001)(3846002)(8676002)(106356001)(105586002)(10090500001)(22452003)(8936002)(486006)(2616005)(72206003)(36756003)(11346002)(81156014)(186003)(26005)(14454004)(6506007)(217873002)(4326008)(25786009)(256004)(107886003)(102836004)(6346003)(476003)(1076002)(10290500003)(86362001)(66066001)(6436002)(6486002)(86612001)(53936002)(54906003)(2900100001)(97736004)(7736002)(6512007)(305945005)(76176011)(99286004)(2501003)(5660300001)(316002)(110136005)(5250100002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: TAOphTNotaQvLoa+Cjvo3+xLpuY5IvhOOobDGUjgJKTXx8rIyCq9uc/57VJ9SzWtHlqa24//yc/ZOp0TPz+QGVP1LRwNwmRnRR5dujGHAfBFWDyHJDCH/ordfDwaZirlOcxRfGZbg3bXQAiXeyh/LH3/8w4UB3OGWvoFlgt71aL8hionkjfqD5iGyU4mL9tooKpwP6DMmKYJdjvR234PgBtH9XtoRl6t0aIICrJJRq56QgLr+lx39nnQmrZ2cckWSudauvZOasyIBXD5pFvwcrewy+B3euswpGWyqfyWe8doZw1WNp/VVPDwwalh/upi6rbc7Rzl1DjUwsoR7yK5oKOLgpdK/3WcSbtTGLA99Mk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f1525c-0d91-41f3-03f3-08d61aaabdfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:29:55.2138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Puschmann <pp@emlix.com>

[ Upstream commit b71c69c26b4916d11b8d403d8e667bbd191f1b8f ]

Fixes this warning that was provoked by a pairing:

[60258.016221] WARNING: possible recursive locking detected
[60258.021558] 4.15.0-RD1812-BSP #1 Tainted: G           O
[60258.027146] --------------------------------------------
[60258.032464] kworker/u5:0/70 is trying to acquire lock:
[60258.037609]  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}, at: [<87759073>=
] bt_accept_enqueue+0x3c/0x74
[60258.046863]
[60258.046863] but task is already holding lock:
[60258.052704]  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}, at: [<d22d7106>=
] l2cap_sock_new_connection_cb+0x1c/0x88
[60258.062905]
[60258.062905] other info that might help us debug this:
[60258.069441]  Possible unsafe locking scenario:
[60258.069441]
[60258.075368]        CPU0
[60258.077821]        ----
[60258.080272]   lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
[60258.085510]   lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
[60258.090748]
[60258.090748]  *** DEADLOCK ***
[60258.090748]
[60258.096676]  May be due to missing lock nesting notation
[60258.096676]
[60258.103472] 5 locks held by kworker/u5:0/70:
[60258.107747]  #0:  ((wq_completion)%shdev->name#2){+.+.}, at: [<9460d092>=
] process_one_work+0x130/0x4fc
[60258.117263]  #1:  ((work_completion)(&hdev->rx_work)){+.+.}, at: [<9460d=
092>] process_one_work+0x130/0x4fc
[60258.126942]  #2:  (&conn->chan_lock){+.+.}, at: [<7877c8c3>] l2cap_conne=
ct+0x80/0x4f8
[60258.134806]  #3:  (&chan->lock/2){+.+.}, at: [<2e16c724>] l2cap_connect+=
0x8c/0x4f8
[60258.142410]  #4:  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}, at: [<d22d=
7106>] l2cap_sock_new_connection_cb+0x1c/0x88
[60258.153043]
[60258.153043] stack backtrace:
[60258.157413] CPU: 1 PID: 70 Comm: kworker/u5:0 Tainted: G           O    =
 4.15.0-RD1812-BSP #1
[60258.165945] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[60258.172485] Workqueue: hci0 hci_rx_work
[60258.176331] Backtrace:
[60258.178797] [<8010c9fc>] (dump_backtrace) from [<8010ccbc>] (show_stack+=
0x18/0x1c)
[60258.186379]  r7:80e55fe4 r6:80e55fe4 r5:20050093 r4:00000000
[60258.192058] [<8010cca4>] (show_stack) from [<809864e8>] (dump_stack+0xb0=
/0xdc)
[60258.199301] [<80986438>] (dump_stack) from [<8016ecc8>] (__lock_acquire+=
0xffc/0x11d4)
[60258.207144]  r9:5e2bb019 r8:630f974c r7:ba8a5940 r6:ba8a5ed8 r5:815b5220=
 r4:80fa081c
[60258.214901] [<8016dccc>] (__lock_acquire) from [<8016f620>] (lock_acquir=
e+0x78/0x98)
[60258.222655]  r10:00000040 r9:00000040 r8:808729f0 r7:00000001 r6:0000000=
0 r5:60050013
[60258.230491]  r4:00000000
[60258.233045] [<8016f5a8>] (lock_acquire) from [<806ee974>] (lock_sock_nes=
ted+0x64/0x88)
[60258.240970]  r7:00000000 r6:b796e870 r5:00000001 r4:b796e800
[60258.246643] [<806ee910>] (lock_sock_nested) from [<808729f0>] (bt_accept=
_enqueue+0x3c/0x74)
[60258.255004]  r8:00000001 r7:ba7d3c00 r6:ba7d3ea4 r5:ba7d2000 r4:b796e800
[60258.261717] [<808729b4>] (bt_accept_enqueue) from [<808aa39c>] (l2cap_so=
ck_new_connection_cb+0x68/0x88)
[60258.271117]  r5:b796e800 r4:ba7d2000
[60258.274708] [<808aa334>] (l2cap_sock_new_connection_cb) from [<808a294c>=
] (l2cap_connect+0x190/0x4f8)
[60258.283933]  r5:00000001 r4:ba6dce00
[60258.287524] [<808a27bc>] (l2cap_connect) from [<808a4a14>] (l2cap_recv_f=
rame+0x744/0x2cf8)
[60258.295800]  r10:ba6dcf24 r9:00000004 r8:b78d8014 r7:00000004 r6:bb05d00=
0 r5:00000004
[60258.303635]  r4:bb05d008
[60258.306183] [<808a42d0>] (l2cap_recv_frame) from [<808a7808>] (l2cap_rec=
v_acldata+0x210/0x214)
[60258.314805]  r10:b78e7800 r9:bb05d960 r8:00000001 r7:bb05d000 r6:0000000=
c r5:b7957a80
[60258.322641]  r4:ba6dce00
[60258.325188] [<808a75f8>] (l2cap_recv_acldata) from [<8087630c>] (hci_rx_=
work+0x35c/0x4e8)
[60258.333374]  r6:80e5743c r5:bb05d7c8 r4:b7957a80
[60258.338004] [<80875fb0>] (hci_rx_work) from [<8013dc7c>] (process_one_wo=
rk+0x1a4/0x4fc)
[60258.346018]  r10:00000001 r9:00000000 r8:baabfef8 r7:ba997500 r6:baaba80=
0 r5:baaa5d00
[60258.353853]  r4:bb05d7c8
[60258.356401] [<8013dad8>] (process_one_work) from [<8013e028>] (worker_th=
read+0x54/0x5cc)
[60258.364503]  r10:baabe038 r9:baaba834 r8:80e05900 r7:00000088 r6:baaa5d1=
8 r5:baaba800
[60258.372338]  r4:baaa5d00
[60258.374888] [<8013dfd4>] (worker_thread) from [<801448f8>] (kthread+0x13=
4/0x160)
[60258.382295]  r10:ba8310b8 r9:bb07dbfc r8:8013dfd4 r7:baaa5d00 r6:0000000=
0 r5:baaa8ac0
[60258.390130]  r4:ba831080
[60258.392682] [<801447c4>] (kthread) from [<801080b4>] (ret_from_fork+0x14=
/0x20)
[60258.399915]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:0000000=
0 r5:801447c4
[60258.407751]  r4:baaa8ac0 r3:baabe000

Signed-off-by: Philipp Puschmann <pp@emlix.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/bluetooth/af_bluetooth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 3264e1873219..deacc52d7ff1 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -159,7 +159,7 @@ void bt_accept_enqueue(struct sock *parent, struct sock=
 *sk)
 	BT_DBG("parent %p, sk %p", parent, sk);
=20
 	sock_hold(sk);
-	lock_sock(sk);
+	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
 	list_add_tail(&bt_sk(sk)->accept_q, &bt_sk(parent)->accept_q);
 	bt_sk(sk)->parent =3D parent;
 	release_sock(sk);
--=20
2.17.1
