Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D212C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB4C20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qb8mk+x4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfAVLG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:06:27 -0500
Received: from mail-eopbgr60069.outbound.protection.outlook.com ([40.107.6.69]:8733
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727048AbfAVLG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:06:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vb4xDvSh1biit9LGbJpSX8k1vvn4pWKFaEw0wRBCD+k=;
 b=qb8mk+x4bb8XnwtsdgXm1TLP7LVku1tPKAUbzjTp5jTZQUWO11f1NMO867XhKNox9Nmo6UvBZr2H2NglB5EZ1c3yCrLVTwjK6OnttWkwgGMu7vCMBUESvVdjcnYwEXDwEc5hd7d6V3Q4rB3XTU+DC6lttrbE5h0LmTtgkUshhXM=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1671.eurprd08.prod.outlook.com (10.169.226.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 22 Jan 2019 11:05:41 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 11:05:41 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v2 1/5] drm: Add drm_atomic_get_old/new_private_obj_state
Thread-Topic: [PATCH v2 1/5] drm: Add drm_atomic_get_old/new_private_obj_state
Thread-Index: AQHUskJpjHcM8yfRTkC5yESOCskYsg==
Date:   Tue, 22 Jan 2019 11:05:41 +0000
Message-ID: <20190122110431.5025-2-james.qian.wang@arm.com>
References: <20190122110431.5025-1-james.qian.wang@arm.com>
In-Reply-To: <20190122110431.5025-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYAPR01CA0021.ausprd01.prod.outlook.com (2603:10c6:1::33)
 To DB6PR0801MB1990.eurprd08.prod.outlook.com (2603:10a6:4:6c::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB1671;6:1Ew3bcHrRNgrypOvbgH/PXR6jh3YKTNftre/ya59NOY7IuDKZb0/71zdMxjTqE0kNul369rH9PybMZK7MRESvrce37hxIsyaXjhanDmQ1Zzu3PwVrRsReg+lEx4tQ44/Onb35ZAfvVDb/82K+iPVzltune5NfQC8ONYJ2dfcXUFiZEOZxMiHcQBhgHPPgo49s+VikGb3Dx8Tw02cV0dZKqr6+mVRGILIiCJZqV3D8CzBuZOBbjb7Rpf4Q0kQJ6wtJfJPHrT3RMcluGsmscWOII9mehNSTX2iAB1lcHH5lvBgrFogJ8i3InOyGSgiItk1Z9gp9jpoAEaPeH2W6xd+YdVH+x8vJ9LFloc3Xs2VnY+tlnkOOhCfvuBFfQZIH0xAVEi4bVy3Ns5dgXvTEJDKj/A2ozHKLjjTIPHb+IUvy5CPjkHKRzDSsaMP0j316a60k1trss7Ni9qQ4VDsToBDkA==;5:OL6B2RrUtqm2XpLL9DN3ToxoZeoR2nBAucQUl5PjoXvMTFnCefqfdwexJ1eadqOSQKkw3UE2xyVWhEQGz13pLGXClvFEmyM2812gUPryUyrMdAxpcI2NfMp1BMj608PUZ15ersJVy629zlccLUviEvJ472ZYron81epUh/EPy49K2T6tCZR6EWMHgcSaj1wRHIASyZVua/F91vNK4yH+zQ==;7:H8WyJeXTXzC7O9i8Unpfc+QVFZe+4CH8fWVldy1zaa3KjeJJqhMPiGyfk0kfMIKEniPshJ3ELdSYYc2+KkxANHCEoLxhUrD3N2RJZsm2Usn1YrWXdPLY21nojzbk++L2vj/jr1HC3mySK28C6YDbBw==
x-ms-office365-filtering-correlation-id: 4b51e808-dd95-41ec-e031-08d680598b33
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1671;
x-ms-traffictypediagnostic: DB6PR0801MB1671:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB167112B4EC24957B3E520F94B3980@DB6PR0801MB1671.eurprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(2906002)(25786009)(86362001)(36756003)(6116002)(3846002)(4326008)(2201001)(6486002)(103116003)(66066001)(105586002)(106356001)(6512007)(2501003)(53936002)(97736004)(6436002)(446003)(68736007)(81166006)(476003)(50226002)(8676002)(71200400001)(71190400001)(316002)(6506007)(52116002)(81156014)(486006)(11346002)(110136005)(54906003)(99286004)(305945005)(102836004)(14454004)(7736002)(26005)(76176011)(386003)(55236004)(1076003)(8936002)(478600001)(2616005)(186003)(14444005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1671;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GoUHaHVPLnJBSVkN+fD/Y38NkpPOw9Qhvw+Q5Nozi6j6Djw8D5+mFmm6kQD7uv8ncw//+ZfnAfBFyYbdH2Lb+ScW3l4rtUKnueoanNS4AnG3tC4jcy8G3DEiZJis19JRGuyKRUTMVpbX/o1izpDNZo04DIEcMmfisn5Z9Pfml0iUa47JOiAGlchiTNcEu0e8Bdw9imGm+soS9YXMWhxHO7kxpYVQNoar7cg7IcvxlJEZ+PJT722AXvRYljCGDQzJAWduIHeYAtdakDs8g7BiTLWqidDofscmRfGjx3RwQtnXe4OTiOm2kfV/DXTGyFUpZIBdIagufKpldX5grMTvK/CjEhNAYiEnT1TlfyHCZZ1+DT3afTkiIMU59eYgDK8jY95PZk/VEHK/YsWSxrvLJ93K0eZBjZELTJ6iZaCpZxA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b51e808-dd95-41ec-e031-08d680598b33
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 11:05:30.5224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1671
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

This pair of functions return the old/new private object state for the
given private_obj, or NULL if the private_obj is not part of the global
atomic state.

Reviewed-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 drivers/gpu/drm/drm_atomic.c | 45 +++++++++++++++++++++++++++++++++++-
 include/drm/drm_atomic.h     |  6 +++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 008224f376fe..900f9f9dedad 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -775,6 +775,50 @@ drm_atomic_get_private_obj_state(struct drm_atomic_sta=
te *state,
 }
 EXPORT_SYMBOL(drm_atomic_get_private_obj_state);
=20
+/**
+ * drm_atomic_get_old_private_obj_state
+ * @state: global atomic state object
+ * @obj: private_obj to grab
+ *
+ * This function returns the old private object state for the given privat=
e_obj,
+ * or NULL if the private_obj is not part of the global atomic state.
+ */
+struct drm_private_state *
+drm_atomic_get_old_private_obj_state(struct drm_atomic_state *state,
+				     struct drm_private_obj *obj)
+{
+	int i;
+
+	for (i =3D 0; i < state->num_private_objs; i++)
+		if (obj =3D=3D state->private_objs[i].ptr)
+			return state->private_objs[i].old_state;
+
+	return NULL;
+}
+EXPORT_SYMBOL(drm_atomic_get_old_private_obj_state);
+
+/**
+ * drm_atomic_get_new_private_obj_state
+ * @state: global atomic state object
+ * @obj: private_obj to grab
+ *
+ * This function returns the new private object state for the given privat=
e_obj,
+ * or NULL if the private_obj is not part of the global atomic state.
+ */
+struct drm_private_state *
+drm_atomic_get_new_private_obj_state(struct drm_atomic_state *state,
+				     struct drm_private_obj *obj)
+{
+	int i;
+
+	for (i =3D 0; i < state->num_private_objs; i++)
+		if (obj =3D=3D state->private_objs[i].ptr)
+			return state->private_objs[i].new_state;
+
+	return NULL;
+}
+EXPORT_SYMBOL(drm_atomic_get_new_private_obj_state);
+
 /**
  * drm_atomic_get_connector_state - get connector state
  * @state: global atomic state object
@@ -1214,4 +1258,3 @@ int drm_atomic_debugfs_init(struct drm_minor *minor)
 			minor->debugfs_root, minor);
 }
 #endif
-
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index cac4a1b6b0e8..a4489b2fe740 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -443,6 +443,12 @@ void drm_atomic_private_obj_fini(struct drm_private_ob=
j *obj);
 struct drm_private_state * __must_check
 drm_atomic_get_private_obj_state(struct drm_atomic_state *state,
 				 struct drm_private_obj *obj);
+struct drm_private_state *
+drm_atomic_get_old_private_obj_state(struct drm_atomic_state *state,
+				     struct drm_private_obj *obj);
+struct drm_private_state *
+drm_atomic_get_new_private_obj_state(struct drm_atomic_state *state,
+				     struct drm_private_obj *obj);
=20
 /**
  * drm_atomic_get_existing_crtc_state - get crtc state, if it exists
--=20
2.17.1

