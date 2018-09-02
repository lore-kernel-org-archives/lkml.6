Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60359C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2ED20652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Jv1luAUC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2ED20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbeIBRbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:31:44 -0400
Received: from mail-eopbgr680096.outbound.protection.outlook.com ([40.107.68.96]:60224
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729288AbeIBRbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bY1ij/kMbRypBgXt0k9iZbCl52gXOwKLHudhuE18uJ0=;
 b=Jv1luAUCWs5M+UjlfIPmbYgZEK4Xw/mXh/grs9+55VrLf4kd4+o1ExWOGOVIaZt7NGld81ZKgDRc5ij0kg38AYhFycbEdmFw0lqUk4BIN0FNYv2IOgMgLIiyp3dOnuleYDjEhs/uG3Ui/x+W8W1mblaSyUVn3//nk5449Abf2zg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:15:48 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:48 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 10/47] tty: rocket: Fix possible buffer overwrite
 on register_PCI
Thread-Topic: [PATCH AUTOSEL 4.4 10/47] tty: rocket: Fix possible buffer
 overwrite on register_PCI
Thread-Index: AQHUQr8QzBecSOODAUWSzEffWppOdA==
Date:   Sun, 2 Sep 2018 13:15:48 +0000
Message-ID: <20180902131533.184092-10-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:7cgIOL/rH8Adk/OlEbT+sxMDkOnuWx0Qm2P4FaWNdd4EzEyZYTHIFRxhd8FScZ/pFIBte+n4B2OllqwKeVWDhpiC0DFI6A0L9orZGsFdL44mqYy6IQ0WFROyRwBOKGI45VbstWwD5BpmZYRFmXFvx9Up5N16Ume0a1/sNfEkh96PYryN1dz7t3+180TokIF6zxW8QS7JFKTqOfawuJ30rTLkDwFLxeLXmBl2byXW4Jnm7Fy38KdEDvXZCkWc/HLdRAidi+t/i9ATgeeaFjT+Niq3zNoqKW2tFJrSa5bjFrTezVi2fXju1SE/ogFVJBLDCZ/QJ8ZoMdZ1e2PDD3ckJ5BXEEAM7M6c8m6egDZXzWZCheTHI6mRz2ARpKBXjcKv186psCu5KrjMp1A9c0LlqHM9+R/ReZpjXhfJXojqusy4YwQyqjrGgXbTtv8UsAdV6gercTFQGFot/TRDMhASMQ==;5:D6fY0bpl+N2FLJCOTM34BX3THCEmehkqTdTyJwRypu9yZQp2bWTlInZvK7sYd5CroHyspPYWl8TjpWST07hPthlY0IWYYhKQB8zwuj4tBEPSD+G2smJgQMV95Ra9v/nx4Hs9dv4hwIdAO4EYoT/uvMVJZ7lGgVFB9PqATntXTOA=;7:DpiQYHuk8/3V1KxH6bwBxisn9Ya+bT4RUZ4GC9YzkVVviUqdHJ14tbrbnTAHtRnLNGYfjZHM580Psxk1fl5r9vT0roE6+ggV5Pg7bLC9whi5fHOCdZvYDeJTvam7tIFe8wVi25ewIRxkSiyoPb0PUKqzSmq2a5LLnXdFWjbfYWdg+RWeUVNpLAh6N7GXmO+NJm8JDKv8OW9RtJBD3HWJLrIyLLUsgZzkqTGtxItIEjwjLKqxxw541vQlXiXuwNiL
x-ms-office365-filtering-correlation-id: e81b51b5-dd29-436f-1cc7-08d610d6331c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB06295239FE754F4E94459FB8FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(8676002)(478600001)(10090500001)(14454004)(10290500003)(72206003)(476003)(5660300001)(5250100002)(106356001)(110136005)(54906003)(316002)(105586002)(86612001)(4477795004)(102836004)(14444005)(26005)(256004)(6506007)(2616005)(6116002)(217873002)(305945005)(446003)(1076002)(3846002)(2906002)(11346002)(97736004)(6346003)(81166006)(81156014)(7736002)(6436002)(66066001)(25786009)(86362001)(575784001)(4326008)(186003)(53936002)(8936002)(6486002)(22452003)(6512007)(99286004)(2501003)(36756003)(68736007)(2900100001)(486006)(107886003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: lUKpwGiNtylbH4bIYEZ+Oms+pcavmCkCUE91r11fD/e9Areg9wRaIsD7o2Z5YgkS8w5TiWFLgq/kYsOFRBTml85Qcjuia+uLGLwplKS0OhcZDh/vnO8k5zPYxm65ukOaHloqIuNQ67jpEGV18kp66V+L2v49KgXhS+WiBXTvb8oCht11x/W2Cfo2RIBR/iG6xJMe7397LEJ70kyCbSqMhEVBswLGlXBYilgCXgbFxN0ABvnb90DSl2x0rrjwSqZl7K187GI+jKCj47a2uo0UG0BsifGrJZk1AzeCL6i1A6IfxyVBofuQfq8dQ6wh/2Hr3EjmJ+r+FI9vPVkvnZUPEdFIJanbVdxT6NSBzhk++yw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e81b51b5-dd29-436f-1cc7-08d610d6331c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:48.4688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 0419056ec8fd01ddf5460d2dba0491aad22657dd ]

If number of isa and pci boards exceed NUM_BOARDS on the path
rp_init()->init_PCI()->register_PCI() then buffer overwrite occurs
in register_PCI() on assign rcktpt_io_addr[i].

The patch adds check on upper bound for index of registered
board in register_PCI.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/rocket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index 802eac7e561b..2b8f2e0a4224 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -1915,7 +1915,7 @@ static __init int register_PCI(int i, struct pci_dev =
*dev)
 	ByteIO_t UPCIRingInd =3D 0;
=20
 	if (!dev || !pci_match_id(rocket_pci_ids, dev) ||
-	    pci_enable_device(dev))
+	    pci_enable_device(dev) || i >=3D NUM_BOARDS)
 		return 0;
=20
 	rcktpt_io_addr[i] =3D pci_resource_start(dev, 0);
--=20
2.17.1
