Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A628C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4344120840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="E/3Oo+pq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4344120840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbeJAHXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:23:18 -0400
Received: from mail-by2nam01on0116.outbound.protection.outlook.com ([104.47.34.116]:2013
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729581AbeJAHPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuO7IgWxL0W1PJbRRTsMRflW1xXLjfnMuENClYz7lq8=;
 b=E/3Oo+pqzft+9G1Vofo3mwhXkI/Or9bKj6gUfH1DiiGSbzUsh2n7L/ROSn1pekkWgrrwGI//Py19dbjh/iL1Y92Upa4RqC5+fLDSy9nH/bdjokrxZIQTgCLg7H/Q/Ut5AgV3bFBLaqFaPTEv0Qlcr3Qi4Nw/st5IXy7mo3R2TRA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0854.namprd21.prod.outlook.com (10.173.192.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.4; Mon, 1 Oct 2018 00:39:44 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:44 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 19/37] drm/nouveau/disp: fix DP disable race
Thread-Topic: [PATCH AUTOSEL 4.14 19/37] drm/nouveau/disp: fix DP disable race
Thread-Index: AQHUWR8ommlgw0dy6EOFh2bT6R9RPQ==
Date:   Mon, 1 Oct 2018 00:39:05 +0000
Message-ID: <20181001003850.147107-19-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0854;6:VO3ao0ZJcdZ44IRfqBepjjKtrdJGOBN79nVYQXJcPlH2mPv7JgDb3AxR9WJqTuUjGSytgWbRde06JJc/qGGMxFbxabrp//KrVgWZ8OY7IupPU+emNvZON5cHC65XQixNO3viXHjrAKxoF3PQ395suUhye3Eb7JicqbXO7yqDbpRx0TEcrmDdugE0ig2IhMfOUKtacWfFlO1lE1/x38u0iDGYAlzScQRnf5RxuNKa2r9l3pj5nV4UqW4+G+JGq5v0ZQ7anKWFNK2uMTLtN0z9uNTy0s7lMk0e6PCPiUqVbrlhV5cY3jxd+IaKGzacyH4/lZixHDPmnO4L0o0ULTXA/2n1dfFJ1JWEuIg6hd6HqhlD+1oiOg+Vy9vZpCMBZ3t+3nyYNMeuD7BmAGRAsqOQOA1mIu89YTee+SCJWkNCxWuJJEU5M31glxkaRq+dpQAKkiQyDTE1gPduHd0OVqlkFA==;5:UZq1npL08D5nw3DDydYopDMO95avfN3T68F0MBkj6h7O9jbB9qpTAu3b4qm4p6EYTKRVMzfQ5HHKU6XWykBwAyCbYlX6WF9yGKro+Tm2Mi9YowmQyNOoymobCTFlALlECMEicArqYJqeMxyvOM2tFNmmvPqO6/7Vv8FBFzkVzWQ=;7:JNtsCTJKLaEkexm+tRIq2qmdhY9S9YugLUFZSfSgxlxCRwwAvRAqIIM7OQCIDZXvLM8wBQu/ZPh6gQLagmYiRhlkWS4Gkvi8xKotlxRWod3zhVH59KNQ7ylC4f1zhnFMw38JYGRPxkHQ6tW0tjV0z2PohCBpZXvuWNpIS34TMQjwCU6Onokj216KlPWnNkOCmOYfPutZOHAqjWbhA9nT/pknsldUigsAuykyb2hb+HjAhmR5xrp7xGnz+yBVqnkR
x-ms-office365-filtering-correlation-id: fbd54689-19a6-4a92-95a0-08d6273661f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0854;
x-ms-traffictypediagnostic: CY4PR21MB0854:
x-microsoft-antispam-prvs: <CY4PR21MB0854B8E1BC0E01105408B9A3FBEF0@CY4PR21MB0854.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0854;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0854;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(6116002)(3846002)(217873002)(5250100002)(1076002)(71200400001)(97736004)(71190400001)(76176011)(6506007)(99286004)(36756003)(6346003)(26005)(2906002)(446003)(86362001)(11346002)(476003)(102836004)(2616005)(14454004)(2501003)(10090500001)(107886003)(4326008)(22452003)(486006)(316002)(34290500001)(186003)(256004)(66066001)(86612001)(305945005)(25786009)(2900100001)(6486002)(106356001)(7736002)(6512007)(53936002)(81166006)(81156014)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(10290500003)(6436002)(478600001)(72206003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0854;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: tiDF1evF4DOCIPPkeird2Fw2oRqKYVdiJnGL+FGbhaQ+GD3BPNHiYTBzBpwZ4OHMwi8cFD7pAPjKhwSIQ0GV6Nq2hdwk2hTIZhW8k4FKWXUgIs6YnHcH2fyTm1p/TLQPjIulQ3kTa/czNzqXBsDPdAQX0rS/KiqCVXqEgA3SRwmWBT842QcMPxDYnsaew11U/TSGwe/+0ss1eqIP2I8q/AyklXQbn12Rk+RZ9C1HPcU9qr2A3NHxXTLE7U6wpR8uSSXLStFJx7XBMZWG6fbwUYtelqq2RSM5FEDMnhnZKDa8oOP9gkLfT2dJmbj7w16jQxasVv1UguYZ2crmOSXElgJSIG/GcXR4ahsNO9ZCp/k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd54689-19a6-4a92-95a0-08d6273661f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:39:05.0941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit e04cfdc9b7398c60dbc70212415ea63b6c6a93ae ]

If a HPD pulse signalling the need to retrain the link occurs between
the KMS driver releasing the output and the supervisor interrupt that
finishes the teardown, it was possible get a NULL-ptr deref.

Avoid this by marking the link as inactive earlier.

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c   | 17 ++++++++++++-----
 drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c |  6 +++---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c |  2 ++
 drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h |  3 ++-
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c b/drivers/gpu/dr=
m/nouveau/nvkm/engine/disp/dp.c
index 7c5bed29ffef..6160a6158cf2 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c
@@ -412,14 +412,10 @@ nvkm_dp_train(struct nvkm_dp *dp, u32 dataKBps)
 }
=20
 static void
-nvkm_dp_release(struct nvkm_outp *outp, struct nvkm_ior *ior)
+nvkm_dp_disable(struct nvkm_outp *outp, struct nvkm_ior *ior)
 {
 	struct nvkm_dp *dp =3D nvkm_dp(outp);
=20
-	/* Prevent link from being retrained if sink sends an IRQ. */
-	atomic_set(&dp->lt.done, 0);
-	ior->dp.nr =3D 0;
-
 	/* Execute DisableLT script from DP Info Table. */
 	nvbios_init(&ior->disp->engine.subdev, dp->info.script[4],
 		init.outp =3D &dp->outp.info;
@@ -428,6 +424,16 @@ nvkm_dp_release(struct nvkm_outp *outp, struct nvkm_io=
r *ior)
 	);
 }
=20
+static void
+nvkm_dp_release(struct nvkm_outp *outp)
+{
+	struct nvkm_dp *dp =3D nvkm_dp(outp);
+
+	/* Prevent link from being retrained if sink sends an IRQ. */
+	atomic_set(&dp->lt.done, 0);
+	dp->outp.ior->dp.nr =3D 0;
+}
+
 static int
 nvkm_dp_acquire(struct nvkm_outp *outp)
 {
@@ -576,6 +582,7 @@ nvkm_dp_func =3D {
 	.fini =3D nvkm_dp_fini,
 	.acquire =3D nvkm_dp_acquire,
 	.release =3D nvkm_dp_release,
+	.disable =3D nvkm_dp_disable,
 };
=20
 static int
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c b/drivers/gpu/=
drm/nouveau/nvkm/engine/disp/nv50.c
index 0c570dbd3021..bc18a96bc61a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
@@ -436,11 +436,11 @@ nv50_disp_super_2_0(struct nv50_disp *disp, struct nv=
km_head *head)
 	nv50_disp_super_ied_off(head, ior, 2);
=20
 	/* If we're shutting down the OR's only active head, execute
-	 * the output path's release function.
+	 * the output path's disable function.
 	 */
 	if (ior->arm.head =3D=3D (1 << head->id)) {
-		if ((outp =3D ior->arm.outp) && outp->func->release)
-			outp->func->release(outp, ior);
+		if ((outp =3D ior->arm.outp) && outp->func->disable)
+			outp->func->disable(outp, ior);
 	}
 }
=20
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c b/drivers/gpu/=
drm/nouveau/nvkm/engine/disp/outp.c
index be9e7f8c3b23..bbba77ff9385 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c
@@ -93,6 +93,8 @@ nvkm_outp_release(struct nvkm_outp *outp, u8 user)
 	if (ior) {
 		outp->acquired &=3D ~user;
 		if (!outp->acquired) {
+			if (outp->func->release && outp->ior)
+				outp->func->release(outp);
 			outp->ior->asy.outp =3D NULL;
 			outp->ior =3D NULL;
 		}
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h b/drivers/gpu/=
drm/nouveau/nvkm/engine/disp/outp.h
index ea84d7d5741a..97196f802924 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h
@@ -41,7 +41,8 @@ struct nvkm_outp_func {
 	void (*init)(struct nvkm_outp *);
 	void (*fini)(struct nvkm_outp *);
 	int (*acquire)(struct nvkm_outp *);
-	void (*release)(struct nvkm_outp *, struct nvkm_ior *);
+	void (*release)(struct nvkm_outp *);
+	void (*disable)(struct nvkm_outp *, struct nvkm_ior *);
 };
=20
 #define OUTP_MSG(o,l,f,a...) do {                                         =
     \
--=20
2.17.1
