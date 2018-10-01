Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5BCC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B4B2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="m0WuBr1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B4B2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbeJAHOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:06 -0400
Received: from mail-by2nam01on0099.outbound.protection.outlook.com ([104.47.34.99]:20832
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726694AbeJAHOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjcnaDUOW5HDZbnSW7Y8QAvUirkj3iIaPcG+WyxZnok=;
 b=m0WuBr1uqam2Qkw6bFCmPhZVHllSorxbIu2Ovim+yF5SVWh0xzp8aNDcqC5qYTmQytIoG3+RArNGkN3AOlsdDN7V1F0imW71AA4K5BhBrudvqT4lML5EuMij1FBcBtDorj7hQDWEcq2RrNgxrWsQT/LhzOncKMwOY3PRFk+h+cY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:38:53 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:53 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 33/65] drm/nouveau/disp: fix DP disable race
Thread-Topic: [PATCH AUTOSEL 4.18 33/65] drm/nouveau/disp: fix DP disable race
Thread-Index: AQHUWR8PFbh6bcx76EWV9/oLMSABig==
Date:   Mon, 1 Oct 2018 00:38:23 +0000
Message-ID: <20181001003754.146961-33-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:SkNxsixVJOUaasSQ4iID3M5BLkpPGxQJlAySR5WllfWl7zaCSipUI+3bPKutqzmeMQxGVI+arC5a7G3M3G63I12r8XlB8TdPbdpXcW7EqZyk7CfZA5RPHe8IJ1yuiSsKdrFcoMYFyAtHmiH/kD6jMfm1cgblRTBnGlQ/20Slo3zWNnBrSPjD1nSkRzexbxLJmoWMw2FFYCrQgefKhx4f99x++74luGGkZ617x88LKjrcYjBFshZcXA19KifA6qz4mKzafTCmPaQPWZ8BDW/qPkVMHJ/MxmHIsgPBfAz4Rw2ZFelwfGGNlcpx5Aa5fKHSNFyad+dvzpnN8M8/QATdBhe69C9Z4dGbqMIQSUvsTNcDC0MwyvuJXHi4/AM8LDbxQ4BUeQli7/dvLj6dNRoqAWsfwJbn1HNR1/fyMQ9/RkpXu26hnemutYp0LlldKh8j2zvWvyrNTqgBlG8AkfcKbA==;5:GkBMxxC9CQWeQzljxITu8c+cf9ZuG1RmcWhDk0/cFIen1uNnZ5gLX0bL1reTneW24OQHCah+8CojlcAtTTzk4XWosBd1w7NsbM1LIK4EoFuR3z0ZJXD6zfz3CxYL2A/eI0nk9ewBnASJTZQPxkESBDLxOa0BRYEtNsyQ3vtHkl8=;7:qfJV1tKNxv97u0PVpoqxl4DLtcrnLGLuuGp1LfWp7psHhb8jMtSlVFfGFAJSU/j3/jYHjTiwA7tboSWVCWj3tRE2VATlHzv0NUId+2MvrKQ3r0ga8NqxhEhYE4GrRto8YPjdHRacpYDAYBq0Ba887F+VFiVwz8u3w29Uby/wWCxXPXoA71ZmEXOKFfVknZ2Ks2GA5Tm8KZTTxtpSFfUhBf+fiD4oHqupXSgMUTTSd7eiVs+v5YwtWrB/GHMxUvM/
x-ms-office365-filtering-correlation-id: 30cbd793-ad4c-40b4-6888-08d627364360
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0181415DAA3FD76659D49658FBEF0@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(6512007)(71200400001)(71190400001)(6116002)(3846002)(2906002)(6436002)(1076002)(34290500001)(446003)(7736002)(478600001)(11346002)(53936002)(6486002)(66066001)(25786009)(2616005)(4326008)(476003)(81166006)(106356001)(72206003)(102836004)(86612001)(486006)(10290500003)(2900100001)(6506007)(76176011)(256004)(8676002)(217873002)(97736004)(6666003)(107886003)(105586002)(81156014)(99286004)(54906003)(110136005)(5660300001)(2501003)(14454004)(5250100002)(22452003)(186003)(305945005)(26005)(68736007)(316002)(36756003)(8936002)(86362001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 58ww1Tf+942Wl4oLXMQb4IdH4N2beWq87fCI7zDBw/KpP0LjFdtd83Yw8srYn7K1z4H009KBgr05blCDs1qgw2f9eyDX89blvDXDp7AP+m6WSTnLDtrZiJwWe36rv8Xc7Wn6HKoXRyx37VmfoUSfpA5I8v1RSJSp16wX2hmIi1TuYk7MqCSCEA8wG+ok1/fEhikVThfMh7HVfbV+ywkEpr+NTaxbbyUnRhk0NpOGYMfMvz/ZNTwYfj/kvM12QmHCaAJGdK1ZkQrKzf5mH7kVtb6wppsMJyDNU/7toAHBC5n4v6VVkXQ0RiN/p66pqQ1/FlCiLhbrjk/tSysX4SD+oQ2Vq3PyeeDP/dJ2iXxIb2I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30cbd793-ad4c-40b4-6888-08d627364360
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:23.6168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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
index f89c7b977aa5..def005dd5fda 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
@@ -501,11 +501,11 @@ nv50_disp_super_2_0(struct nv50_disp *disp, struct nv=
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
