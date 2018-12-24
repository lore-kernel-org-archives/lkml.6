Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06308C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99E2218AF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="GVVitodl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbeLXJPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:15:48 -0500
Received: from mail-eopbgr50072.outbound.protection.outlook.com ([40.107.5.72]:4656
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725320AbeLXJPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvNIt3x8AJSeZO2jILbPpAxl2IBexAUFFoUf+mtbeLM=;
 b=GVVitodlK0pXQo4h2EreSb7Xrh8udVRcIbB3tM1jGd7d9zlJpKjhRfH93P3XWxje0oszHnNxgCJad+AuUN7hKhSUlO4A4vNge9szzKEQ+2buyaTUvX0RADQwFOCtmp2QmIXj0tzbdaJXxVVkfeFDvswu4g41tfJItrhQrxSUuSE=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0183.eurprd08.prod.outlook.com (10.161.35.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Mon, 24 Dec 2018 09:15:38 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 09:15:38 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH 1/5] drm: Add drm_atomic_get_old/new_private_obj_state
Thread-Topic: [PATCH 1/5] drm: Add drm_atomic_get_old/new_private_obj_state
Thread-Index: AQHUm2k7dLlsBhK6bkSDIihp6zn3UA==
Date:   Mon, 24 Dec 2018 09:15:37 +0000
Message-ID: <20181224091450.2643-2-james.qian.wang@arm.com>
References: <20181224091450.2643-1-james.qian.wang@arm.com>
In-Reply-To: <20181224091450.2643-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SY2PR01CA0039.ausprd01.prod.outlook.com
 (2603:10c6:1:15::27) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0183;6:Q2x8UgeqDMOe10YATUkhjXfNmmyzDD4xoi3EzN9HcV+R3ou4hGAMC31un6uUT0TtGPT17l0WXxn/6gNocUmt9DaCcP/Vj0YIgRSHxbYvJ3205CWSVohOZlcsCIqnMghIrG3WqsymSAq66jqyB7uKDdIws5buZfWIi+If/BTmnSUb0mkCOv/FANyTkFJ5VJf4bkAZPFpdkMkEIomrTbJY1U5adoD8fq+fIoT6LG356u0FNcCfg8F/ijUe5mQxvF8Xk/ANfRiZiWYZBcKeN7UeK7sDoDQR+J2quYbFHXfwVpjI/erzoUoyGaKn6tpTlEGWetBSPlq+n3otqaGBk+5STxXns+r3Ul9gc88eUyDK3WF35wnImRp5J9hONAp9EnVMr/KrRQaZ6Xri3dXkad3vxXm4vn8VHhvakcUubrAM5PBhKWUAz8cngHleGCU1VOzOUyjb+w+7mImU/yKMQI4gYw==;5:q16hE6199FQI0hYP5lDPAunfRVquGyyWFxKu04n5BI7y/pOpbK+TAf7gPAqKH69pqWy46INXrNFZJQzo5dxFxLWBkvLSNM6yvR4K02WDQsW1aixCYXclML6mv5MWmZ9Zf/dh5MlSGvZsyIYqIXgN/RIrRZtzOVWq0tdAKWMW4DE=;7:Np/fuQe65mQbXm7O7CDS/5VcRb/wCvaxwwTIxk1EHuFNYRTtAXcIjtFSAwLEktqcmJWSYV0ljicC3sfQ+ul3pJkOkdCJ+uU7prp8FenxXLNX4eMwDTAA2fDa8TFF5Kc4NCscNgwYTtqODHeVLk1ADA==
x-ms-office365-filtering-correlation-id: 6a452ab9-f452-4897-baf6-08d669805e13
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0183;
x-ms-traffictypediagnostic: AM3PR08MB0183:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB018347BE9278C39A538C2B29B3BB0@AM3PR08MB0183.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0183;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0183;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39850400004)(346002)(376002)(189003)(199004)(5660300001)(54906003)(7736002)(37006003)(256004)(14444005)(6862004)(4326008)(316002)(55236004)(386003)(86362001)(106356001)(14454004)(6506007)(186003)(99286004)(2906002)(105586002)(8936002)(97736004)(76176011)(36756003)(476003)(2616005)(71200400001)(478600001)(1076003)(6486002)(486006)(81156014)(71190400001)(3846002)(26005)(52116002)(68736007)(6116002)(6436002)(11346002)(8676002)(446003)(25786009)(305945005)(102836004)(103116003)(6636002)(81166006)(53936002)(6512007)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0183;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QquWOpGJM0iOt5ptzRnSevgGeVDzMEFV08e9CbXlGGHLXcgJawobSCjlogSKOIbTPN7JsVEw67K+A3VuZ5DTKfuCsSvWEHAvcPDDmosDdgSG5+fSu7ySFjYCqF24LWDcN0jAH7viikcKG9+FUN2rL8+CPFZ8fTOm94qjMSTOq2C/PdTYMSlUImWl0T4u84awae2gNb2rdJ2ijtFYJw3A2lhnZSLj8nuSTXrI3y2BsBQlThx6fQkMLKsKAqq2xP3YRNB0xMKjsqcZVxh1/+c2AZ+4IA1WM5JreOuji2jblgfbt8J9Gh71/zeiHTkviR0s
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a452ab9-f452-4897-baf6-08d669805e13
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 09:15:37.8558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pair of functions return the old/new private object state for the
given private_obj, or NULL if the private_obj is not part of the global
atomic state.

Reviewed-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 drivers/gpu/drm/drm_atomic.c | 45 +++++++++++++++++++++++++++++++++++-
 include/drm/drm_atomic.h     |  6 +++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 9ac26437051b..6ff29f3862fc 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -764,6 +764,50 @@ drm_atomic_get_private_obj_state(struct drm_atomic_sta=
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
@@ -1203,4 +1247,3 @@ int drm_atomic_debugfs_init(struct drm_minor *minor)
 			minor->debugfs_root, minor);
 }
 #endif
-
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index f9b35834c45d..beb7b7fb6067 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -408,6 +408,12 @@ void drm_atomic_private_obj_fini(struct drm_private_ob=
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

