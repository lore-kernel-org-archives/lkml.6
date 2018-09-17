Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1E7ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5125E208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZJNENjWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5125E208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbeIQIrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:47:07 -0400
Received: from mail-dm3nam03on0109.outbound.protection.outlook.com ([104.47.41.109]:36496
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730247AbeIQI3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPkrGIdfYoP8Vsr1zlyLeg3IglQ1MknUcJwAaISQ41c=;
 b=ZJNENjWXlQIaXu9gTmtJWLwRjNJrtOhHqg5Thzq7I37cafkbuc/EUWhhVozf6LjWpGbZ5nLwLQbxTPN2idGtDFbxv1+RTIqodQBEB/Qs4fUpWcCROazg5iu+tZFr6DXuiHl4euj/0kQhZ4tXHPzRJxEcGQEukH5JtQ0OtQcbd6k=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0774.namprd21.prod.outlook.com (10.173.192.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 52/87] nfp: fail probe if serial or interface id
 is missing
Thread-Topic: [PATCH AUTOSEL 4.14 52/87] nfp: fail probe if serial or
 interface id is missing
Thread-Index: AQHUTjLuQIMIvblAXUmSJX7MvViEAQ==
Date:   Mon, 17 Sep 2018 03:02:55 +0000
Message-ID: <20180917030220.245686-52-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0774;6:num3UqtkvhQaWVuxoaSlB0auVB/x2tOwSs2KQiIWRfIY+ue/qy84PXFwgC/HjYZLg1GSgZKj+3CJRWhkan9fcH0dpiBWiQ7wIHzkY+YIPiML8IKifNftijpbMpPnpQmkI0BI2XmI/ivVTBK6BFtiCJ1Mh3lwdOrlYIYUeSZzN4k7ctNgE4SkYY2lkJkgSTcWIAOqXE0s1GdgDjWr9yW/QJ1Rwip8x0dmznOZaHnKsPHeiNv916oS/5q3eLnBBbtqz9qxcaOSDR9u5jOgMuO3N7AfPOAWx8kGyzeSIdzS6o0N5lTAcWRfW43w6ZX8zc6q491WWyqPW46bYvWmqTDtAzdagRW7s8Unu2/KSQtzEXqobd1eUGBQeGT7jCcS4RRJ1ttftj/r1uxwtcNc26G/wya4MxU++q8L5mShTbHE7gkxSZUVEsLfMONM6cNwKaX7FUgFIzDSd+b8d41w7IU4dQ==;5:qXGa00rV2Iyp8zzRH1D4OOx/fX4B9PCPhUYolUEaHtWU0dIm3qW3eO1lFHZFxkxnnnsLGHLqAPPgkcBlebGt6vTVjIZ+sn348ZJwvxvkf1gMHHMNKQSpwM8Q3sGty2jqL9OyZ1XfgSJ54zrJxrHPVoEiUG6litn9IgJmFZYNhpk=;7:AKfO9Y8w3aEIOtsD7/mqsQ4cFnqS9JYKfeNpWzD1AVttLe1vbIdlwf4zUgxDciy6nCXW2zw+Dqyw623hM+S4A0boL96bIQG2EJ+TeMDYxtcJEqsFSf0Ap1hHsYsA1EXxeoN+jdZXKDv9QoioVfmZm70Kjr5iiS3/zifuBuSCO7K2icMm9NyxKvNFAKRZ/+EJ3kgtJnzxavaFqqNkdeerKYOG7r+xnKLQVycTUbbNpu6NJUSPrwlAkzR7VGUp90es
x-ms-office365-filtering-correlation-id: fc1c2870-c302-4887-5df8-08d61c4a4389
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0774;
x-ms-traffictypediagnostic: CY4PR21MB0774:
x-microsoft-antispam-prvs: <CY4PR21MB0774DD356375CFF3B5374EB4FB1E0@CY4PR21MB0774.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0774;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0774;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(39860400002)(346002)(40224003)(199004)(189003)(54906003)(105586002)(316002)(4326008)(6116002)(1076002)(14454004)(305945005)(7736002)(22452003)(81156014)(66066001)(81166006)(99286004)(8936002)(8676002)(3846002)(478600001)(72206003)(53936002)(10290500003)(68736007)(106356001)(6512007)(25786009)(76176011)(110136005)(11346002)(476003)(2616005)(446003)(6436002)(486006)(39060400002)(6506007)(86612001)(10090500001)(102836004)(575784001)(86362001)(6346003)(186003)(26005)(36756003)(97736004)(2906002)(256004)(14444005)(2900100001)(6486002)(217873002)(107886003)(2501003)(6666003)(5250100002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0774;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: aWf7VvefFYOjLKiywH45MCGlUy9zu6XVHUud1s+BHNiQtr6Z3qFPL6516zsITtwvP+y0JzXD492cF91WjgVZnGuuW1A/u/MJinaSfyJkgeEexLOkGmqkoc/wpGPXBslkD8W/YhBFDdY9fMpD6xlPwKNv8M1Q5iQlWao1baogDdmLqZiE1d1993mPAmPz6jixCR6znT8CHLuFjtYA2JNL8DF2U8LtiPueGZLWdkFHEFjkl+e9o9gV0HRyyyccZ1Jo0/CMaxb8VqYKjouMgw0Pt+RyS6QGifPLfxki8BobLrDvGLW/PBA7o7kUmjJ/AmLwcEciiPyi4U1dOS2GekiWdobUsGLtcSaSUa+m6WUChHM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1c2870-c302-4887-5df8-08d61c4a4389
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:55.9311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0774
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit 18aa5b180f00a10c2f63944b4f0ab116bf8ea19b ]

On some platforms with broken ACPI tables we may not have access
to the Serial Number PCIe capability.  This capability is crucial
for us for switchdev operation as we use serial number as switch ID,
and for communication with management FW where interface ID is used.

If we can't determine the Serial Number we have to fail device probe.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 .../netronome/nfp/nfpcore/nfp6000_pcie.c      | 16 +++++++++-----
 .../ethernet/netronome/nfp/nfpcore/nfp_cpp.h  |  4 ++--
 .../netronome/nfp/nfpcore/nfp_cppcore.c       | 22 ++++++++++++++-----
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c b/dr=
ivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
index cd678323bacb..2018893a3d92 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
@@ -1254,7 +1254,7 @@ static void nfp6000_free(struct nfp_cpp *cpp)
 	kfree(nfp);
 }
=20
-static void nfp6000_read_serial(struct device *dev, u8 *serial)
+static int nfp6000_read_serial(struct device *dev, u8 *serial)
 {
 	struct pci_dev *pdev =3D to_pci_dev(dev);
 	int pos;
@@ -1262,25 +1262,29 @@ static void nfp6000_read_serial(struct device *dev,=
 u8 *serial)
=20
 	pos =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DSN);
 	if (!pos) {
-		memset(serial, 0, NFP_SERIAL_LEN);
-		return;
+		dev_err(dev, "can't find PCIe Serial Number Capability\n");
+		return -EINVAL;
 	}
=20
 	pci_read_config_dword(pdev, pos + 4, &reg);
 	put_unaligned_be16(reg >> 16, serial + 4);
 	pci_read_config_dword(pdev, pos + 8, &reg);
 	put_unaligned_be32(reg, serial);
+
+	return 0;
 }
=20
-static u16 nfp6000_get_interface(struct device *dev)
+static int nfp6000_get_interface(struct device *dev)
 {
 	struct pci_dev *pdev =3D to_pci_dev(dev);
 	int pos;
 	u32 reg;
=20
 	pos =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DSN);
-	if (!pos)
-		return NFP_CPP_INTERFACE(NFP_CPP_INTERFACE_TYPE_PCI, 0, 0xff);
+	if (!pos) {
+		dev_err(dev, "can't find PCIe Serial Number Capability\n");
+		return -EINVAL;
+	}
=20
 	pci_read_config_dword(pdev, pos + 4, &reg);
=20
diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_cpp.h b/drivers=
/net/ethernet/netronome/nfp/nfpcore/nfp_cpp.h
index 5798adc57cbc..87edde1252d2 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_cpp.h
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_cpp.h
@@ -356,8 +356,8 @@ struct nfp_cpp_operations {
 	int (*init)(struct nfp_cpp *cpp);
 	void (*free)(struct nfp_cpp *cpp);
=20
-	void (*read_serial)(struct device *dev, u8 *serial);
-	u16 (*get_interface)(struct device *dev);
+	int (*read_serial)(struct device *dev, u8 *serial);
+	int (*get_interface)(struct device *dev);
=20
 	int (*area_init)(struct nfp_cpp_area *area,
 			 u32 dest, unsigned long long address,
diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_cppcore.c b/dri=
vers/net/ethernet/netronome/nfp/nfpcore/nfp_cppcore.c
index 04dd5758ecf5..59b7f011ed0b 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_cppcore.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_cppcore.c
@@ -1147,10 +1147,10 @@ nfp_cpp_from_operations(const struct nfp_cpp_operat=
ions *ops,
 {
 	const u32 arm =3D NFP_CPP_ID(NFP_CPP_TARGET_ARM, NFP_CPP_ACTION_RW, 0);
 	struct nfp_cpp *cpp;
+	int ifc, err;
 	u32 mask[2];
 	u32 xpbaddr;
 	size_t tgt;
-	int err;
=20
 	cpp =3D kzalloc(sizeof(*cpp), GFP_KERNEL);
 	if (!cpp) {
@@ -1160,9 +1160,19 @@ nfp_cpp_from_operations(const struct nfp_cpp_operati=
ons *ops,
=20
 	cpp->op =3D ops;
 	cpp->priv =3D priv;
-	cpp->interface =3D ops->get_interface(parent);
-	if (ops->read_serial)
-		ops->read_serial(parent, cpp->serial);
+
+	ifc =3D ops->get_interface(parent);
+	if (ifc < 0) {
+		err =3D ifc;
+		goto err_free_cpp;
+	}
+	cpp->interface =3D ifc;
+	if (ops->read_serial) {
+		err =3D ops->read_serial(parent, cpp->serial);
+		if (err)
+			goto err_free_cpp;
+	}
+
 	rwlock_init(&cpp->resource_lock);
 	init_waitqueue_head(&cpp->waitq);
 	lockdep_set_class(&cpp->resource_lock, &nfp_cpp_resource_lock_key);
@@ -1175,7 +1185,7 @@ nfp_cpp_from_operations(const struct nfp_cpp_operatio=
ns *ops,
 	err =3D device_register(&cpp->dev);
 	if (err < 0) {
 		put_device(&cpp->dev);
-		goto err_dev;
+		goto err_free_cpp;
 	}
=20
 	dev_set_drvdata(&cpp->dev, cpp);
@@ -1222,7 +1232,7 @@ nfp_cpp_from_operations(const struct nfp_cpp_operatio=
ns *ops,
=20
 err_out:
 	device_unregister(&cpp->dev);
-err_dev:
+err_free_cpp:
 	kfree(cpp);
 err_malloc:
 	return ERR_PTR(err);
--=20
2.17.1
