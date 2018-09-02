Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BCDC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCAE2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gmSOeGGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FCAE2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeIBRUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:04 -0400
Received: from mail-sn1nam02on0123.outbound.protection.outlook.com ([104.47.36.123]:20160
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727989AbeIBRUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHi9pmtxxip60MQvylB6c/NyLZQipvpOgZwFmW6AJAA=;
 b=gmSOeGGgtee8uY3v8ChXh+e279WotpN0UZnP6YmGavcuCUFoawVk1d99UVt8fr0QCmzVqeAnarNg/XK19HcaWEBCP94viM3eOWgOeKwSfSnxlsuPqh58Z6E9VXsmXs2WgcyOC5fwXXnSIRmE/4skrIdoWIFOLjTIjH7P7fXTu+Q=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0135.namprd21.prod.outlook.com (10.173.189.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:12 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:12 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefan Hajnoczi <stefanha@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 045/131] device-dax: avoid hang on error before
 devm_memremap_pages()
Thread-Topic: [PATCH AUTOSEL 4.18 045/131] device-dax: avoid hang on error
 before devm_memremap_pages()
Thread-Index: AQHUQr1obE7dzdp+1UGq0dqcZSilNQ==
Date:   Sun, 2 Sep 2018 13:03:57 +0000
Message-ID: <20180902064601.183036-45-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0135;6:XzMnN1u3bxjR6O1nsotMfTnuLPLVsvg4r6fDriWIFmStJhhpXTkSivcMxnJC04fbIdfT/KuNEIM/7eDifNhrvqEu3Rjhc5pJ3fYjAnhbu2/hJPafNvNJ1ZVkqfb6QCNEC8bmjT+dNa3vohLDgZ3DSbVamxYxDJ+86rsYwqLO1vXhgu8LTx0oLi81laNlfPSBj0OvPbB/XK+1QZiVHQo2EK3BruLwHKDRZakTXrT4aWZGz0u1fON49kBJfAOCG7thM5sFm7L9nDcWzPGLE0GO/xyqC+vRrJxnrQ5ErNoqzhEqzEz0rWBG8kVZHd8th4CZa/9QXNQTSECSoMNeC/gqBdOwVn3bPMEy80mlvbN9xa0wAnn6H98zrw9r/r78KDIZ+BCKq14+A2O1Y6JgHA/PDE7E/nQVPdKdyyzjGvuo+0LEGRVTgZn9ktPmpIcxIHCmp27QHScJoVu/jE144MjI6g==;5:mLTA36VgutLlh/TdOPin1w1wUYCprSqA4c+2mQf5r3lVMArOHtrc1POoxb7On2GUMbf1AYFjH5ve1rAs3ag1fiua4HrgIh0J1MwOjGpOIkc14tIA4uKISQsil2qdk7iTvzX+PGaLdvJNxkMQprChJZw+OdtDKEZlLfie7cOJn9A=;7:7iSPzd6J2p1roJh6dSln0/+aP9Fmx+TSECBtYdz0q83YUPjHKmVCijCKcymEk28TDF9bM+46+72PJjFX4KWxHGTEZoe19EEPGB+1INN58ckG2pVuHw8tAv7z/WW3ALqmk88ZZvD/5/QdK+QzZN0o32tnPETxm6EgtxUCDrLC17Fhl9NDM15jwpE6xZN2R0yBY8TUrzXCCpBa4mycwtx2MLz0LicsIhXXRLgyY/ZLqCjEAIlRg20Sj4KasORg7Djp
x-ms-office365-filtering-correlation-id: c2965d39-3126-40ff-27e2-08d610d4942b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0135;
x-ms-traffictypediagnostic: CY4PR21MB0135:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01357B7B806B3420F8E83303FB0D0@CY4PR21MB0135.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0135;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0135;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(478600001)(76176011)(53936002)(2616005)(6512007)(476003)(446003)(11346002)(36756003)(486006)(106356001)(305945005)(6486002)(6436002)(97736004)(102836004)(6506007)(5250100002)(2906002)(256004)(72206003)(2501003)(10290500003)(14454004)(86612001)(186003)(26005)(217873002)(99286004)(86362001)(2900100001)(575784001)(22452003)(81156014)(81166006)(10090500001)(316002)(107886003)(8676002)(105586002)(6116002)(8936002)(25786009)(4326008)(7736002)(5660300001)(6666003)(110136005)(54906003)(1076002)(68736007)(66066001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0135;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vzcD4Knj1kHyYocKmzW+vCoJWRXwCom/6eiDEPuZ0S/adA92F4lIm7YOO3th3jSnuacfIsD8XXYXQ8AYJqyb3nZYxXsjRkB91Csr5d+xB0tYSX/K5OqZhjMW94b8VgmwkwEB1alotBZXa6w3uZGSuybqHKZJm+zJHy6AQINzXo8xS/QqL0zvHki7up9Y1NwmZcGefrLMtSaxhNLICsvfMgAC+RYWkBssvb/M6ASZx6e52eCxPCvodnlMzfvVNmxj4MbEWFnPHaStRSmHkieWURCm4jB40H9lMxpm+vZMjMaOYex5rC0sw62NecFTgY6rxIJaFz1gKBk3ZUclsyL1d9fGLOtRvBJZqFUSUbeMl6w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2965d39-3126-40ff-27e2-08d610d4942b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:57.7249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

[ Upstream commit b7751410c180a05fdc21268f8661b1480169b0df ]

dax_pmem_percpu_exit() waits for dax_pmem_percpu_release() to invoke the
dax_pmem->cmp completion.  Unfortunately this approach to cleaning up
the percpu_ref only works after devm_memremap_pages() was successful.

If devm_add_action_or_reset() or devm_memremap_pages() fails,
dax_pmem_percpu_release() is not invoked.  Therefore
dax_pmem_percpu_exit() hangs waiting for the completion:

  rc =3D devm_add_action_or_reset(dev, dax_pmem_percpu_exit,
  				&dax_pmem->ref);
  if (rc)
  	return rc;

  dax_pmem->pgmap.ref =3D &dax_pmem->ref;
  addr =3D devm_memremap_pages(dev, &dax_pmem->pgmap);

Avoid the hang by calling percpu_ref_exit() in the error paths instead
of going through dax_pmem_percpu_exit().

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/dax/pmem.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index fd49b24fd6af..99e2aace8078 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -105,15 +105,19 @@ static int dax_pmem_probe(struct device *dev)
 	if (rc)
 		return rc;
=20
-	rc =3D devm_add_action_or_reset(dev, dax_pmem_percpu_exit,
-							&dax_pmem->ref);
-	if (rc)
+	rc =3D devm_add_action(dev, dax_pmem_percpu_exit, &dax_pmem->ref);
+	if (rc) {
+		percpu_ref_exit(&dax_pmem->ref);
 		return rc;
+	}
=20
 	dax_pmem->pgmap.ref =3D &dax_pmem->ref;
 	addr =3D devm_memremap_pages(dev, &dax_pmem->pgmap);
-	if (IS_ERR(addr))
+	if (IS_ERR(addr)) {
+		devm_remove_action(dev, dax_pmem_percpu_exit, &dax_pmem->ref);
+		percpu_ref_exit(&dax_pmem->ref);
 		return PTR_ERR(addr);
+	}
=20
 	rc =3D devm_add_action_or_reset(dev, dax_pmem_percpu_kill,
 							&dax_pmem->ref);
--=20
2.17.1
