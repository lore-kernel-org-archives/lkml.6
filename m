Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038A7ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D018214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NzoBinV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D018214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbeIQI16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:58 -0400
Received: from mail-eopbgr710116.outbound.protection.outlook.com ([40.107.71.116]:59328
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729476AbeIQI14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhhY3pDvCcPu2TPN6QvSH9EqM6BEzdPzz2TLeW21CFk=;
 b=NzoBinV+cFHnFbifhgewp8MxCXF+m/D0Sepm4KX2ojBdUze2K4rbvV1/I/bKZFnuBos8OFwbxPp2otZIUlSaUYxX2oXalNl8xyhTYPITBJVeFYWTFW4U0xf3JIvyY8nckjF2j2e750F3abbBL1IL7u2i+d1rwH2lCaSVsTSkXEI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0790.namprd21.prod.outlook.com (10.175.121.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Mon, 17 Sep 2018 03:02:36 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:36 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 096/136] drm/omap: gem: Fix mm_list locking
Thread-Topic: [PATCH AUTOSEL 4.18 096/136] drm/omap: gem: Fix mm_list locking
Thread-Index: AQHUTjKxBNMv8hxTY0uKnnYhkBydSA==
Date:   Mon, 17 Sep 2018 03:01:12 +0000
Message-ID: <20180917030006.245495-96-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0790;6:9Kka6de+B1NmrMwi5OVnloL7xgJyNrBpuqenMnoKQfUiEVBgaIxxqtt1GWnQpI2MIFjSjkeRytAlK0WrkZ+zkFG+Ii1OkOimiLyEcV6hMja1CCwYV+hxyOtNjfbhauhW4i1ygEGhxYytczg2kHcf74OoLzRbOFxpKibyHllWQvzZxa7jDRA39CFy+69wLFjjqYgbMi8SFgvEIjOhArlhZt3OEs9mDlxo5XQZ585ePGeirbS1GIqQJDSeunGyOw40uaAo1c1jtiaSXxYBAlh0X+2xNdaMeOTQH0goFkO7phLv5HULQZvoUp57M3Ip0di2t5b9kPnkqrFunUpt8EZUNBgKZ1dSLP2/1WtcTc7uHeKwdKTNhs50RqCXft5hm/tgsdhf1uPiYqSwuRG1toIWZtp7ANOT8H+FfwYZMIFfXnCgOA0SXZ9cTmIbAOjZtKIYJ44i6TaB+wQ/NGOiRpaoeA==;5:R5FfbKbRvxdRZ2GM3nb62BoERXOSQbDNDkGVgQFG+o3zqtGb71dTBO6LlEdz69Ecng4Aew70Vgx0yyxzVTo72xRXdI8D6F1UkIr09KRjaw747jVKtHI3GsijgfM+QEjj8KX5rtA1HL1ar+DnjSnUvmS5Ah0PKgYMemW4pqekJMM=;7:CpNcYYteHaduIpORVpPJ3vggCCn2/BVw+8VQTuhKQ1y4LQZqXgNcg3c/kGoCony823Ume7ETe8n3G611Yf+WreQevl83c9uXEK3DRrw41eJrQHu6biWOHLyLZO+2Yw0LxydsR1za4hkHSQfCmniqBhUkk9+rKYTQS+GAg38HbHqUVSriEdmnE8ffDm+nzRmyZHNdlKVwumxeYtHvZulRhYzIHyT/MSabl+eeCmVMHcy/aa8H7FdAFCeAVVtwN55W
x-ms-office365-filtering-correlation-id: 61bda3e5-479d-490c-1f20-08d61c4a0555
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0790;
x-ms-traffictypediagnostic: CY4PR21MB0790:
x-microsoft-antispam-prvs: <CY4PR21MB0790B708811940078C9AA3C7FB1E0@CY4PR21MB0790.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(31051911155226)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0790;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0790;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(76176011)(22452003)(6666003)(110136005)(99286004)(6436002)(6486002)(2900100001)(2906002)(54906003)(6346003)(10090500001)(5660300001)(7736002)(6512007)(14444005)(217873002)(316002)(256004)(53936002)(36756003)(6506007)(25786009)(106356001)(26005)(86612001)(10290500003)(1076002)(68736007)(476003)(6116002)(3846002)(478600001)(5250100002)(11346002)(446003)(72206003)(2501003)(81156014)(81166006)(8676002)(14454004)(102836004)(107886003)(186003)(2616005)(575784001)(97736004)(86362001)(66066001)(305945005)(486006)(8936002)(4326008)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0790;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 2DLuxf4BQujsfirAK75aXV5CkLo0E+1LrFjGiPUkL2EQot3sLRSA4Hm8fDJMuUOFpS+V3Ya87MHPkwRKuAh4gTiufJhLTwLy7gn3NnGj95XsAPUx3igI0LGELgMdkEXF4t4ZApGpJZKz9UAZFwKctSHtXU76XwrRiTUjLFLvarKmAe40Z6l/o77w5tgWDEAplOvh7WvDtXkIfN65LhpBBmaftm/MbmRgob1lLK1h1nKb/fs/mkx/LnKEXyPUGNdFFRNciazmkyU9OKLK6chpsWoxYFYe7F5Yrdmh2fmnWmhswmVlLuTd3w5KeJRIT3GK1wv5RaPkbsDULr2LzYtHV1RoOqRkeWLCnj+YJ4YgaLQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bda3e5-479d-490c-1f20-08d61c4a0555
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:12.6042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Vetter <daniel.vetter@ffwll.ch>

[ Upstream commit 5117bd898e8c0a31e8ab3a9b8523aecf0706e997 ]

- None of the list walkings where protected.

- Switch to a mutex since the list walking at device resume time can
  sleep when pinning buffers through the tiler.

Only thing we need to be careful with here is that while we walk the
list we can't unreference any gem objects, since the final unref would
result in a recursive deadlock. But the only functions that walk the
list is the device resume and debugfs dumping, so all safe.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/omapdrm/omap_debugfs.c |  2 ++
 drivers/gpu/drm/omapdrm/omap_drv.c     |  2 +-
 drivers/gpu/drm/omapdrm/omap_drv.h     |  2 +-
 drivers/gpu/drm/omapdrm/omap_gem.c     | 15 +++++++++------
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_debugfs.c b/drivers/gpu/drm/omapd=
rm/omap_debugfs.c
index b42e286616b0..84da7a5b84f3 100644
--- a/drivers/gpu/drm/omapdrm/omap_debugfs.c
+++ b/drivers/gpu/drm/omapdrm/omap_debugfs.c
@@ -37,7 +37,9 @@ static int gem_show(struct seq_file *m, void *arg)
 		return ret;
=20
 	seq_printf(m, "All Objects:\n");
+	mutex_lock(&priv->list_lock);
 	omap_gem_describe_objects(&priv->obj_list, m);
+	mutex_unlock(&priv->list_lock);
=20
 	mutex_unlock(&dev->struct_mutex);
=20
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/o=
map_drv.c
index ef3b0e3571ec..5fcf9eaf3eaf 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -540,7 +540,7 @@ static int omapdrm_init(struct omap_drm_private *priv, =
struct device *dev)
 	priv->omaprev =3D soc ? (unsigned int)soc->data : 0;
 	priv->wq =3D alloc_ordered_workqueue("omapdrm", 0);
=20
-	spin_lock_init(&priv->list_lock);
+	mutex_init(&priv->list_lock);
 	INIT_LIST_HEAD(&priv->obj_list);
=20
 	/* Allocate and initialize the DRM device. */
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/o=
map_drv.h
index 6eaee4df4559..f27c8e216adf 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -71,7 +71,7 @@ struct omap_drm_private {
 	struct workqueue_struct *wq;
=20
 	/* lock for obj_list below */
-	spinlock_t list_lock;
+	struct mutex list_lock;
=20
 	/* list of GEM objects: */
 	struct list_head obj_list;
diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/o=
map_gem.c
index 17a53d207978..7a029b892a37 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -1001,6 +1001,7 @@ int omap_gem_resume(struct drm_device *dev)
 	struct omap_gem_object *omap_obj;
 	int ret =3D 0;
=20
+	mutex_lock(&priv->list_lock);
 	list_for_each_entry(omap_obj, &priv->obj_list, mm_list) {
 		if (omap_obj->block) {
 			struct drm_gem_object *obj =3D &omap_obj->base;
@@ -1012,12 +1013,14 @@ int omap_gem_resume(struct drm_device *dev)
 					omap_obj->roll, true);
 			if (ret) {
 				dev_err(dev->dev, "could not repin: %d\n", ret);
-				return ret;
+				goto done;
 			}
 		}
 	}
=20
-	return 0;
+done:
+	mutex_unlock(&priv->list_lock);
+	return ret;
 }
 #endif
=20
@@ -1085,9 +1088,9 @@ void omap_gem_free_object(struct drm_gem_object *obj)
=20
 	WARN_ON(!mutex_is_locked(&dev->struct_mutex));
=20
-	spin_lock(&priv->list_lock);
+	mutex_lock(&priv->list_lock);
 	list_del(&omap_obj->mm_list);
-	spin_unlock(&priv->list_lock);
+	mutex_unlock(&priv->list_lock);
=20
 	/* this means the object is still pinned.. which really should
 	 * not happen.  I think..
@@ -1206,9 +1209,9 @@ struct drm_gem_object *omap_gem_new(struct drm_device=
 *dev,
 			goto err_release;
 	}
=20
-	spin_lock(&priv->list_lock);
+	mutex_lock(&priv->list_lock);
 	list_add(&omap_obj->mm_list, &priv->obj_list);
-	spin_unlock(&priv->list_lock);
+	mutex_unlock(&priv->list_lock);
=20
 	return obj;
=20
--=20
2.17.1
