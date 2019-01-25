Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C1BC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1220A218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="l0wpH/Sr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfAYH3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:29:23 -0500
Received: from mail-eopbgr800042.outbound.protection.outlook.com ([40.107.80.42]:45406
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726271AbfAYH3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:29:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRfpnl2RW39BQDD+pY9Bhz7TOIMTYe166+eeP0U/x5k=;
 b=l0wpH/SrGkJJlzHlEzJIsJEd9Zjxk/p/nLubNrybAJFk9c+zLsyz5zqOx3JNHQa7aq3I+UGhIyWL9FgyAsVr73U/phirfuvwyInuU15ZmYmCBfrFpiC44YgJe/DzIrceX4yopHl42BgNZb1FYmslvlnVjyS0Ej9B/+/xg8bStgo=
Received: from SN6PR03MB4398.namprd03.prod.outlook.com (20.177.255.219) by
 SN6PR03MB3710.namprd03.prod.outlook.com (52.135.81.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Fri, 25 Jan 2019 07:29:20 +0000
Received: from SN6PR03MB4398.namprd03.prod.outlook.com
 ([fe80::59c4:7034:c325:36f]) by SN6PR03MB4398.namprd03.prod.outlook.com
 ([fe80::59c4:7034:c325:36f%2]) with mapi id 15.20.1558.021; Fri, 25 Jan 2019
 07:29:20 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Vitor Soares <vitor.soares@synopsys.com>,
        Boris Brezillon <bbrezillon@kernel.org>
CC:     "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] i3c: master: dw: fix deadlock
Thread-Topic: [PATCH] i3c: master: dw: fix deadlock
Thread-Index: AQHUtH+vYHS8FVEufUaAlX8QpeU+9Q==
Date:   Fri, 25 Jan 2019 07:29:20 +0000
Message-ID: <20190125152300.248d58f4@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TYXPR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:403:a::14) To SN6PR03MB4398.namprd03.prod.outlook.com
 (2603:10b6:805:fd::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR03MB3710;6:QLSzZMt8MTZF8sycldi1Id+Kv8xkYdfqq7b2t5N3lmy6YMGUGqwC9d/O4Elbz5tvchLjr80Kq/TjWxUyXbx+okyhzFH+9UFx7emK08CoCPKAEhDnRROzIpPSlkgOjtos0cU0mohKDZv/g1o5rsQ2wvQiAgkrmJb2lIKdfODdPl5papxnIioMNTaWauE42GI7fsaLErsIK8nkrNqWZHOmjYr1qMJk44ZwDWnUwT5fRFqkqiRPUfjeoCwjPyJ3b6Flp62BMxqNt/Z7t0V+itcsSq9utvl0PQat3sEbmvVAt++vn9rXPqmXgvf2gLnxbimebXzJGX7yekbcaybpCqrjiRvT95g8oQ7nD40rmm8WLOoe5tDNdNmzmQa9BP/C9lifIrwcymqj9KuSVblwggOer5i3aNvmpf5hb49DCz/fJwnMw32ZurFZYNBmWlQ/ceQ87IZE1v3wdYV3V8C/F4u/7A==;5:O+rKngxkiGQ6WkiRU3SEqKdq+DhSheDA0fyZf7rK6VlcEVlo5pGRJEK68xffBi5ep0e6X0Xh0aPQJYL6cAnai+l/4IJmILPdXREN1JMe1g6jtTPaZ25dRceakn2rQgyGmMANbb+XzVest+gswb5Wpd/NuDX+ofKcs65wrbfdmHirKQktDOUf8NryD+oE6xlcyRLdgRGXEfU24phkOholHQ==;7:gtF2OSFGM62b1y4YqX3qpMRXzeY292HuCpI85TNJXnzyWpmiSxiZ+QBweQjjclt1KWrusB2ej3br0m2DM2mihdSWwPVCYIZ3ME3CCRvj+Kys3suw8X92PzmUuwhAbEhPplyVNp73WRilowKJTjomQg==
x-ms-office365-filtering-correlation-id: 77a2acc3-ff70-4dcb-b299-08d68296d1e1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:SN6PR03MB3710;
x-ms-traffictypediagnostic: SN6PR03MB3710:
x-microsoft-antispam-prvs: <SN6PR03MB37106AF54E6BB13262E318A8ED9B0@SN6PR03MB3710.namprd03.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(376002)(39860400002)(136003)(189003)(199004)(6116002)(3846002)(105586002)(68736007)(7736002)(305945005)(6436002)(81156014)(81166006)(8676002)(2906002)(71200400001)(71190400001)(106356001)(52116002)(26005)(186003)(476003)(33896004)(102836004)(6506007)(386003)(486006)(97736004)(99286004)(110136005)(54906003)(4326008)(256004)(14444005)(25786009)(66066001)(8936002)(1076003)(14454004)(478600001)(50226002)(72206003)(316002)(6486002)(6512007)(9686003)(86362001)(53936002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3710;H:SN6PR03MB4398.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8DlaKU7G5IZaLpzIMi2azw++mppQVTJPnzo/xdMUu/2trJ+WuuPmmyOeZ2MPhl06UDcf+IjTlf4ylOQieUCbH/R0daHZaoMFzow/T5Oyf7KQ8ifXpJVfzzYVdv2vL9LGquMlAbhnCCoqT7n42nfbvkCcnQloGvjLKKC5z+2L/eB0mJSOEuojq6o6sUMqknhRQrO3IFKQwMsZwh2zaTAEz43FIUQHBe6Z/EjMhDmSMkjUFerb4n8KEM2P7ZQ95BHgCv5LaienqNAly/IpPvLCtVKNB8AcmWsWFrclDIG9TeO7Gbwr+zfH1pYKbjr4K2ZqUiEz65gLj+p/diEUVA303DXG/gkagcxhVMlHVHI8wvzOOVYHkmisU/p+6K8CDdLuxcxZ6F0IJgrSZ3mpavwwnDzMI8PbV/XvQkuDvlMAcak=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <53AB63F8794AFB40A52D79CB69A6D823@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a2acc3-ff70-4dcb-b299-08d68296d1e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 07:29:17.9836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3710
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dw_i3c_master_irq_handler(), we already have gotten
&master->xferqueue.lock, if we try to get the same lock again in
dw_i3c_master_dequeue_xfer(), deadlock happens.

We fix this issue by introduing dw_i3c_master_dequeue_xfer_locked()
which does all what dw_i3c_master_dequeue_xfer() does without trying
to lock &master->xferqueue.lock.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/i3c/master/dw-i3c-master.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c=
-master.c
index f8c00b94817f..bb03079fbade 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -419,12 +419,9 @@ static void dw_i3c_master_enqueue_xfer(struct dw_i3c_m=
aster *master,
 	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
 }
=20
-static void dw_i3c_master_dequeue_xfer(struct dw_i3c_master *master,
-				       struct dw_i3c_xfer *xfer)
+static void dw_i3c_master_dequeue_xfer_locked(struct dw_i3c_master *master=
,
+					      struct dw_i3c_xfer *xfer)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&master->xferqueue.lock, flags);
 	if (master->xferqueue.cur =3D=3D xfer) {
 		u32 status;
=20
@@ -439,6 +436,15 @@ static void dw_i3c_master_dequeue_xfer(struct dw_i3c_m=
aster *master,
 	} else {
 		list_del_init(&xfer->node);
 	}
+}
+
+static void dw_i3c_master_dequeue_xfer(struct dw_i3c_master *master,
+				       struct dw_i3c_xfer *xfer)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&master->xferqueue.lock, flags);
+	dw_i3c_master_dequeue_xfer_locked(master, xfer);
 	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
 }
=20
@@ -494,7 +500,7 @@ static void dw_i3c_master_end_xfer_locked(struct dw_i3c=
_master *master, u32 isr)
 	complete(&xfer->comp);
=20
 	if (ret < 0) {
-		dw_i3c_master_dequeue_xfer(master, xfer);
+		dw_i3c_master_dequeue_xfer_locked(master, xfer);
 		writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_RESUME,
 		       master->regs + DEVICE_CTRL);
 	}
--=20
2.20.1

