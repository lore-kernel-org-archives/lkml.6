Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98923ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C70214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cJ9x7RBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C70214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbeIQIbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:44 -0400
Received: from mail-sn1nam02on0129.outbound.protection.outlook.com ([104.47.36.129]:32192
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728849AbeIQIbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5xV8M2m7kk/J+cwUbyNjF9VC+P3BCehm9cnpuvgWmk=;
 b=cJ9x7RBX+aAoiJ0ewCLptecTQiOQ5+cqxWZzcT7h3grsfiE0vxJxF/qKOK6wquPKGOfJZz7+PZ9u2/4PcwpfmFWzgnAocpntPaCVq3N7loqGTgKONCbLvldu3Chdq0nFHK8KZ/xQdGDaK2qUQidpWFxiK27f6FI9izJ4HVz8S5o=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0166.namprd21.prod.outlook.com (10.173.192.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:06:24 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:24 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johan Hovold <johan@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 51/57] EDAC, i7core: Fix memleaks and
 use-after-free on probe and remove
Thread-Topic: [PATCH AUTOSEL 4.9 51/57] EDAC, i7core: Fix memleaks and
 use-after-free on probe and remove
Thread-Index: AQHUTjMdUe3FAYiBGUi/XW47k/9EYQ==
Date:   Mon, 17 Sep 2018 03:04:15 +0000
Message-ID: <20180917030340.378-51-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0166;6:n4cFTxChQ4Ota2VCzyIAghxxpfNfpKnwXadF8XFIdsg3GL80+ELjPDqZh2gTdIjGnPZBwyjVgpY3L3dQW8qjGrDFtXH9p6yJFJfTh83KlPD9UqG7aA5UAaKvsoyZn4MSmFl+nHbIf0b+9QWNHUGlfJuF63CRHI8znXUTzGC/nvcvkm+qiq3I7ImH4xanacb9y/c4aRX3y3g5w0xeG8kjigo9tycP9HeGlT0zhRY2mzspsKzs/caoQXZGpxdZda8er8E1i6JVTp3i3Y5m/nwOZsUZJdkMRkP+4BZDZSPvWFVBAodgH8VsBG/o138RZsakRP+bLop2aUy0c7OSFxb5MEW3c6r2xLmkq2HLGBgAgetnGusRzPMPU2jNppaTZdvgSFmdBKbZEzieISj1K9RC5Ysz4JUGeoEsje/Sb26JPTLA02OUmdzIt8+eS0KILyJGfaQZU+YzOIPnWqx19vOF0g==;5:1dcX+tn167WwKSpfndUcLFnWLQOE/wQKYePPw+jCe2MzOTrJUAibN2fy4D2es4cFb86SjpB23ElepCS1G0iRbu7AaDvZyItvo6qUhWhXmY8g4klFn0iArSy0LpwPAAsxs/6vWNFpqS7bZW6y/CYb2rlFIFZ2bbJANvBslNscFKM=;7:dQOpwkLJOqK0fUw3GimbbTg2zAbhKSN4byd05sQM4dLzkSyrt4nfiY14JWivXoMzjS7l14I1iQoI5F75ZerS6Mp08QNUEVWVyvVG+h/bB4l7uADayVkmpzRx3oWFWhln8HuIS0pBtEquk1RZn3PJpqaaFHtD93gRuhUBGP2fWNz4Wu7kcNB3r2rJU3MdgsKXvFo+LDnxYATUdIzCgtIIesE4AEg4KZZ/gcu/WSYz47Pte7HOT+KXh6zvjk1AjuTo
x-ms-office365-filtering-correlation-id: a517bd51-2d31-400a-251b-08d61c4a8d9b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0166;
x-ms-traffictypediagnostic: CY4PR21MB0166:
x-microsoft-antispam-prvs: <CY4PR21MB0166B5C35C73B282F7B20FB9FB1E0@CY4PR21MB0166.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0166;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0166;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(39860400002)(396003)(189003)(199004)(305945005)(256004)(14444005)(217873002)(486006)(186003)(966005)(86612001)(66066001)(7736002)(6486002)(102836004)(6512007)(2900100001)(25786009)(14454004)(6666003)(2616005)(476003)(1076002)(575784001)(97736004)(86362001)(6436002)(6306002)(5660300001)(6346003)(316002)(2501003)(6116002)(76176011)(6506007)(105586002)(8676002)(478600001)(3846002)(106356001)(53936002)(68736007)(72206003)(446003)(22452003)(5250100002)(81156014)(8936002)(36756003)(10090500001)(107886003)(4326008)(110136005)(11346002)(99286004)(81166006)(2906002)(26005)(54906003)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0166;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: LGbE3jOLeOpimb6fsFIlOHRBJKO7yjv+JHvglBImhg/rMkK18yy9zO62E3gGiKPHgxn+Y9CZDeLpE1HOHNC59yOrg09wwrdqhV2TsSHoqm9wrDv49Jt73CM6PyrqPy9miCnAQUyI8BMoDiCp6vWrbolq+IZ9p2s/1kKBk9Bto09/Mcm0Nigu+SV0ihyqS0S4Fakzh7qRFVaMPIpNYkHQVTADMutiDB3YL3jRtbtXsnDJ/7oOhb14j+xfqtjo0ztb5AobRy955UQuDc+qIJZGSznDZrKRaRV3qoKZ9hdXAk3FadXf+autdFH1VC07FvXbFEVS6QIo1ZnMSIMJeOwMiIiHvSAehzWCzeJzGltgdUs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a517bd51-2d31-400a-251b-08d61c4a8d9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:15.1020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 6c974d4dfafe5e9ee754f2a6fba0eb1864f1649e ]

Make sure to free and deregister the addrmatch and chancounts devices
allocated during probe in all error paths. Also fix use-after-free in a
probe error path and in the remove success path where the devices were
being put before before deregistration.

Signed-off-by: Johan Hovold <johan@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-edac <linux-edac@vger.kernel.org>
Fixes: 356f0a30860d ("i7core_edac: change the mem allocation scheme to make=
 Documentation/kobject.txt happy")
Link: http://lkml.kernel.org/r/20180612124335.6420-2-johan@kernel.org
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/edac/i7core_edac.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index 8a68a5e943ea..b60932026e34 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -1177,15 +1177,14 @@ static int i7core_create_sysfs_devices(struct mem_c=
tl_info *mci)
=20
 	rc =3D device_add(pvt->addrmatch_dev);
 	if (rc < 0)
-		return rc;
+		goto err_put_addrmatch;
=20
 	if (!pvt->is_registered) {
 		pvt->chancounts_dev =3D kzalloc(sizeof(*pvt->chancounts_dev),
 					      GFP_KERNEL);
 		if (!pvt->chancounts_dev) {
-			put_device(pvt->addrmatch_dev);
-			device_del(pvt->addrmatch_dev);
-			return -ENOMEM;
+			rc =3D -ENOMEM;
+			goto err_del_addrmatch;
 		}
=20
 		pvt->chancounts_dev->type =3D &all_channel_counts_type;
@@ -1199,9 +1198,18 @@ static int i7core_create_sysfs_devices(struct mem_ct=
l_info *mci)
=20
 		rc =3D device_add(pvt->chancounts_dev);
 		if (rc < 0)
-			return rc;
+			goto err_put_chancounts;
 	}
 	return 0;
+
+err_put_chancounts:
+	put_device(pvt->chancounts_dev);
+err_del_addrmatch:
+	device_del(pvt->addrmatch_dev);
+err_put_addrmatch:
+	put_device(pvt->addrmatch_dev);
+
+	return rc;
 }
=20
 static void i7core_delete_sysfs_devices(struct mem_ctl_info *mci)
@@ -1211,11 +1219,11 @@ static void i7core_delete_sysfs_devices(struct mem_=
ctl_info *mci)
 	edac_dbg(1, "\n");
=20
 	if (!pvt->is_registered) {
-		put_device(pvt->chancounts_dev);
 		device_del(pvt->chancounts_dev);
+		put_device(pvt->chancounts_dev);
 	}
-	put_device(pvt->addrmatch_dev);
 	device_del(pvt->addrmatch_dev);
+	put_device(pvt->addrmatch_dev);
 }
=20
 /*************************************************************************=
***
--=20
2.17.1
