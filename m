Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5983EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09ACE2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OO8I9UFz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Px6hOeyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfBUAdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:33:05 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:14692 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfBUAdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550709186; x=1582245186;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=oScnSknFb7fUqMAU3m0bZhVOyMiIJmmC/98wkj6WLT8=;
  b=OO8I9UFzt/7oB+04CRdCPAKx3evrS8aDBDGKNO4x1xlejtva0GgDZH6M
   kXHO2339CcOYokvIufmFzagTaWYXuGs6KcdXVCXNeJ0tyusV1oE7Kuukd
   oeUhfaTFZGqK9NVtup6ws7dcgjX1Tv9yhvPW49YrRrY81Fu7at9ho3b00
   Ob5VD92WzBXlwEGttHE/QdbkhgZTNPcdx3SGx6tQOpSvZvVTEFVHZpmmB
   6vNdIQAoaO7PMtCpKDOkYKoPHfDkcoleDyKj9xqFCY9dNMr/jImc48w4C
   W7pnMhM46BFCc7K+SNriVFehMUY09HnXdepg0ja73CVcnJ9jnVHgAOVBO
   A==;
X-IronPort-AV: E=Sophos;i="5.58,392,1544457600"; 
   d="scan'208";a="103071170"
Received: from mail-co1nam04lp2054.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.54])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2019 08:33:05 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inH8ZBdiHV7w3+xZ0pr9OeAdu3PfuQspDl0mVP41LaQ=;
 b=Px6hOeyO/KAKqOhtDQcLfQAMcrqsuX1c8+rl3wHbeweVJOYPVIWXyUz0CsuHbv91PCSs6vsuHZnmV9HaPH8Q2xWlmPLBBRd0Pl5G4n5ZZ0mk0j76+9rhq8jNCq+0Vsa9fiX6lnL9VFrEOMuPZfectvxfYMD3SS+M0eV6y2xG4fY=
Received: from CY4PR04MB0392.namprd04.prod.outlook.com (10.173.190.148) by
 CY4PR04MB0918.namprd04.prod.outlook.com (10.171.247.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Thu, 21 Feb 2019 00:33:03 +0000
Received: from CY4PR04MB0392.namprd04.prod.outlook.com
 ([fe80::2057:d590:6918:b286]) by CY4PR04MB0392.namprd04.prod.outlook.com
 ([fe80::2057:d590:6918:b286%10]) with mapi id 15.20.1643.014; Thu, 21 Feb
 2019 00:33:03 +0000
From:   Alistair Francis <Alistair.Francis@wdc.com>
To:     "kraxel@redhat.com" <kraxel@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alistair23@gmail.com" <alistair23@gmail.com>,
        "david.abdurachmanov@gmail.com" <david.abdurachmanov@gmail.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH] drm/bochs: Fix the ID mismatch error
Thread-Topic: [PATCH] drm/bochs: Fix the ID mismatch error
Thread-Index: AQHUyX0BfIJUREpsZE+VI2mcVzWCIA==
Date:   Thu, 21 Feb 2019 00:33:03 +0000
Message-ID: <20190221003231.31625-1-alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-clientproxiedby: BYAPR07CA0047.namprd07.prod.outlook.com
 (2603:10b6:a03:60::24) To CY4PR04MB0392.namprd04.prod.outlook.com
 (2603:10b6:903:b5::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 833432c9-8478-4e4e-00d1-08d69794239f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY4PR04MB0918;
x-ms-traffictypediagnostic: CY4PR04MB0918:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;CY4PR04MB0918;23:+mEdHVPbDgK4oTrmaqM3z/hEe0ddHLuhn7lIp/R?=
 =?iso-8859-1?Q?6I+UFEd6DtPd9a85CQRrVce+gya09fgEBji3Ym5KNJpqbxOYYAIoYBSzXv?=
 =?iso-8859-1?Q?FY/G22bvgtsVy40CKJgZKRS/BEQWO9tYnRzZiCywcTG2VXb2Y+bW6ATRDQ?=
 =?iso-8859-1?Q?g6I+3Oo7qUOJWJ5SvsrQaEVVZ5ZmtPr6QK5swhom10rsIBXq72YZB2EzX/?=
 =?iso-8859-1?Q?9eX6x8xigPJ3UxHVd9aAil+IgScv9zEzv0HuHL83KwrWqsF9ZgD1IZG1GN?=
 =?iso-8859-1?Q?VGfXJbLKeAkcctdFJktwjZE9SbmgghsJUeMSaYwSDALIGFWaIiJpKAhMtc?=
 =?iso-8859-1?Q?05mWK8TWYpmHtyrircQ3O2bvYjGr/mtHidXLWuQAneJ98OvC+RCZaGXOhG?=
 =?iso-8859-1?Q?Q5NAs1DVcZdZ4ESrNEYxevJ7k3cJblJ9twCrE9YPnb40StrgFtXZGfet5Z?=
 =?iso-8859-1?Q?Ydyygf+ACXOJW3SVpsM4Arl5Kmt4P33soZGV9Nk7P1Cd+9aPYyDrAWZSQl?=
 =?iso-8859-1?Q?c1Oq7Eg0tSAcEu/yev+V6/Q/w+SLktic3AgGm6VuJG19tzj4n+i8ls8u1z?=
 =?iso-8859-1?Q?da+xPYq/JzTmuEheYMGMgaNPKEheLqPuA6zxignRsOLvvnRHa90181X8cc?=
 =?iso-8859-1?Q?MeWd2BTCEVQvOML58TBAFQMp081HLv/MKN2eXK2X5N7Ho9Skr4IboflzqA?=
 =?iso-8859-1?Q?VoaAum+nGmaxkK3fYzsJJxkMebeg/wnf1ELvLb8MEf6y5pw3gALYRPc5zs?=
 =?iso-8859-1?Q?AqJm1PLZGWFUf8HIQ26s1NzuegIrsiyzLoWIjsAyBcKsbD/F3DxbqHCMtD?=
 =?iso-8859-1?Q?kxq4OVdOoXoFkxF0dOhX+InLy0vRjecj6yA+BP7ofoapys5Y73oHrB+kL2?=
 =?iso-8859-1?Q?rDwLs2v2pH6jF8Xrqkz3UvOeFIpYSvV5zSqt34QE+EfKQj7YndjiTqBo52?=
 =?iso-8859-1?Q?/gR8XcSMSQcRBjs1GI2HvIwR7H3um6ehKn4B3RBh0phPzRv3gQ58VeBKEd?=
 =?iso-8859-1?Q?7mH503L56g/n8L/3EevGjni5JOHcpj0edPThQfVBu6S8/dvARZngtr+rbI?=
 =?iso-8859-1?Q?P6WXRfMyRsywJYFMDU+tiN5R5qOoO7FtSEb0LorMEEp4ra+IsRL3OksdtK?=
 =?iso-8859-1?Q?uHuG3wibNiDMdZQu6t/gbQCdCAd+bQdvUYTeAWKKMWDjLnIrlHqj9mD46h?=
 =?iso-8859-1?Q?4xh3azqRCfU1mlGQQOKbVSua/PDyNHoMflcwuXg/HYm2DEMqVTE/LLPEFu?=
 =?iso-8859-1?Q?6iWSgz7BVGacWGvoq37hMJeDtgtLU4rr5p+I3HQwgPrzXruSIkilXWESkq?=
 =?iso-8859-1?Q?yk=3D?=
x-microsoft-antispam-prvs: <CY4PR04MB091822CFEFDE44F6E9D1E37E907E0@CY4PR04MB0918.namprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(136003)(39860400002)(396003)(199004)(189003)(6506007)(386003)(7736002)(4326008)(25786009)(5024004)(81166006)(4744005)(305945005)(81156014)(2501003)(50226002)(102836004)(186003)(106356001)(8936002)(26005)(256004)(105586002)(66066001)(1076003)(97736004)(8676002)(68736007)(2616005)(99286004)(478600001)(476003)(44832011)(71190400001)(36756003)(72206003)(71200400001)(486006)(5660300002)(6116002)(2906002)(110136005)(6436002)(3846002)(52116002)(6512007)(53936002)(86362001)(316002)(54906003)(6486002)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR04MB0918;H:CY4PR04MB0392.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fcDWkahwKuaHtg5vhLyV5ONGrMvixLLNZkOqidv9GxLFW2OW0sXEgTE5Xp42I0CTfM7qoOmk8B8mX53Qf3EMmxKnI25PtUmSIG4VbOUjy+OLsTxVZAgjxi/OM+lP8T2Nvh5TOJYBh29IRmlNrGPgdza4hwxkCIzKE4TSmTxBEfoRadcA7Qa/o2eM4YEeZBg91YHht6AP9pcmLBhgrofy+1oNVKpk3KY1FNJvKB1cQwwAuYmlbZUQsbuvV2Lnf0UrFdXCw+c8YHgiEnGo/ukpUFLiND0m8HC5UJPsXgha3fJ8v+AJURMbhGSPt9/g6C0g8baqY59xHBPewVWgeSguAzp0kPazitTLuALM8yMn40/P8NydsAkVyALEilcmIz2Ic2F4/+XgnDH9Vi8msCoicEnjaXhx+InLmbnjsW07sR8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833432c9-8478-4e4e-00d1-08d69794239f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 00:33:02.4748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0918
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running RISC-V QEMU with the Bochs device attached via PCIe the
probe of the Bochs device fails with:
    [drm:bochs_hw_init] *ERROR* ID mismatch

This was introduced by this commit:
    7780eb9ce8 bochs: convert to drm_dev_register

To fix the error we ensure that pci_enable_device() is called before
bochs_load().

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reported-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
---
 drivers/gpu/drm/bochs/bochs_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/boch=
s_drv.c
index f3dd66ae990a..aa35007262cd 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -154,6 +154,10 @@ static int bochs_pci_probe(struct pci_dev *pdev,
 	if (IS_ERR(dev))
 		return PTR_ERR(dev);
=20
+	ret =3D pci_enable_device(pdev);
+	if (ret)
+		goto err_free_dev;
+
 	dev->pdev =3D pdev;
 	pci_set_drvdata(pdev, dev);
=20
--=20
2.20.1

