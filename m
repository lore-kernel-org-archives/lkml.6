Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F333AECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99159214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KRb5Gfdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99159214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbeIQI1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:17 -0400
Received: from mail-bn3nam01on0109.outbound.protection.outlook.com ([104.47.33.109]:29664
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728417AbeIQI1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdZbEnOXoBCzWoN+pNGF5XCTSat0ARjKTvU6tLfY0X4=;
 b=KRb5Gfdqna6Rm75cRiEI0QIXfDoGmTDD7abwldluyUXV8ZZgr+AxplHjjPEJgeWypdLKKMne24Dzxux8uwzE7SiELAMRq0OqZL8NCJgMlC36fbGCy1qA04DGgf2ZbElNaqmuqL142Am1YNIhKolTm0KoUAjLwPh1ZqH1k9rE7WE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0502.namprd21.prod.outlook.com (10.172.122.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.7; Mon, 17 Sep 2018 03:01:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 068/136] nfp: fail probe if serial or interface
 id is missing
Thread-Topic: [PATCH AUTOSEL 4.18 068/136] nfp: fail probe if serial or
 interface id is missing
Thread-Index: AQHUTjKmfkkMLlu7uU+HDfUDZ8vzJg==
Date:   Mon, 17 Sep 2018 03:00:54 +0000
Message-ID: <20180917030006.245495-68-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0502;6:WlcSWnpGQOqQPWMb0SY2ZtOlRAx8VYlh6ogBF4CHAT+Fj7KxxXv77jgx/9ZKzPsDLboNLb+eygKM9gjYclrMzqyP66ayeEZ/vBgVFuq+vxORJcvUprEW8lC2+7VzbJyA0ZrrRn6ET+ihlNXLnKt11fxeUjtN6qHPAu0jV/2LvWWY+vdfKSY+PTubarnqk9yIn45kCKIGgA4svgQsKKoaJH3f2MccR9EWifErirzNNbOj8f4XYmKV64So7m9Ob6zJirEBqYUCqfscbKcq0/JsRuxajRKmAAEFcfAqtCMkiRmXrqXqG8ef2Y0TVWYoRjBxQgWsKqne8pyO6cXK9kk5kB046uyRDjpiCuB58/aKlHvY6xGfQmmhbZE+3YKW4QrXtzvXDXDqdIstUXPEytnJwpvmcylc8e+krbIDNNkyKxKRdgmhCVbrMLcwT936toX+TKgQ0KXbrX8A2nV7MBP96g==;5:/FmxC6dVB8I+dX/6s9aFKFbbmKQdTeq087klIxbS1mQkVQIrjn8b9HxupJivTp6+OnU3cRo5ewAH2fbV0EiRsu1QcaodPp2l9izNTpEnBqI5F95rnu2duFb+ynad6zSkmA1PN79K7iIf4ZJtL4vmoRXJv63Ok2tv2MR+q8Jaiug=;7:I5eR+pavRgmJ57Z7FVhfmKcbGzeBG4tHs1HhGtHACtNl0q647qi5nxLRQ+6Vcwj+h0Qio/9PJ4CMRrrGlCmA3K0QSZAoNE6TVkYZJEhkHQ/ECbmpq2Bnj9yr4q4c27vcdlUQw+8R8DUwrqDn+bShD4TVC3D8TQdmMuzeagY8oRa682tkwlXxiyNtDd7jT5/FktzGRyHQnTuVCff89wwt/J8mwb+VrPToZWRby11GEOecjYXuOmk4wjK5itcXj0dv
x-ms-office365-filtering-correlation-id: 865b32b9-aa94-4689-3ed8-08d61c49ecec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0502;
x-ms-traffictypediagnostic: CY4PR21MB0502:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB050284406725B0FB7F4A1A75FB1E0@CY4PR21MB0502.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0502;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0502;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(40224003)(86362001)(2616005)(99286004)(5660300001)(575784001)(1076002)(6116002)(3846002)(10290500003)(39060400002)(2900100001)(72206003)(68736007)(8676002)(22452003)(26005)(217873002)(86612001)(486006)(76176011)(66066001)(102836004)(2906002)(476003)(14444005)(186003)(256004)(6506007)(446003)(11346002)(36756003)(316002)(5250100002)(6512007)(97736004)(2501003)(107886003)(110136005)(54906003)(6486002)(8936002)(53936002)(81156014)(81166006)(10090500001)(25786009)(305945005)(7736002)(105586002)(106356001)(478600001)(4326008)(14454004)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0502;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OP9IQjxA7mhsPcgHm7Ol4+j9CcnQjLy4WreEv3+OqXPtsEDR7wW1CncqDXj9eqsqrE4D7fVh9qc3SPI89nGTyeDksSsbYQxUSYNsl6SaH7icBOspyKnAz8qyYgO3dmLbv/VPFHbR0hZlBp9pZm78NrjG3c+zhtsnKPIfYgXrUQ9vBBiTUMbFiuz7azsCg1VgouWOZxZpbOaUIXmSgKc2/Tl3A7PGU3MuGiKm7TaQ/gfZ1dFGYXyILYFRFql/8VKZhstNZeLIk6q1VJX6sTPXrUhE4rPJZvKr+OmcDjCbMvzq5kDG8DgcbtERRbGvZeiRcr1oDIJ6dYp1v9vpxKwfENWY9YfONa7aumGVbiVS4gI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 865b32b9-aa94-4689-3ed8-08d61c49ecec
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:54.7138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0502
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
index 749655c329b2..c8d0b1016a64 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
@@ -1248,7 +1248,7 @@ static void nfp6000_free(struct nfp_cpp *cpp)
 	kfree(nfp);
 }
=20
-static void nfp6000_read_serial(struct device *dev, u8 *serial)
+static int nfp6000_read_serial(struct device *dev, u8 *serial)
 {
 	struct pci_dev *pdev =3D to_pci_dev(dev);
 	int pos;
@@ -1256,25 +1256,29 @@ static void nfp6000_read_serial(struct device *dev,=
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
index b0da3d436850..c338d539fa96 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_cpp.h
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_cpp.h
@@ -364,8 +364,8 @@ struct nfp_cpp_operations {
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
index ef30597aa319..73de57a09800 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_cppcore.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_cppcore.c
@@ -1163,10 +1163,10 @@ nfp_cpp_from_operations(const struct nfp_cpp_operat=
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
@@ -1176,9 +1176,19 @@ nfp_cpp_from_operations(const struct nfp_cpp_operati=
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
@@ -1191,7 +1201,7 @@ nfp_cpp_from_operations(const struct nfp_cpp_operatio=
ns *ops,
 	err =3D device_register(&cpp->dev);
 	if (err < 0) {
 		put_device(&cpp->dev);
-		goto err_dev;
+		goto err_free_cpp;
 	}
=20
 	dev_set_drvdata(&cpp->dev, cpp);
@@ -1238,7 +1248,7 @@ nfp_cpp_from_operations(const struct nfp_cpp_operatio=
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
