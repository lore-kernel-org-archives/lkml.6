Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6974AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D782083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VAGMNfnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D782083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731418AbeIGFVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:21:01 -0400
Received: from mail-bl2nam02on0097.outbound.protection.outlook.com ([104.47.38.97]:7296
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727282AbeIGFVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExJ5cv/kYH74B2wS2jgLrQ3YFAqF38Z65HSM+L0tNmI=;
 b=VAGMNfnXi7cGr8JNRMP17pxGu+WKbt+qT2K0J3j5PCinrOemXXMlg6MGGoehdxnVTXYabLVUAtHmpb7OabsB41b9evLh1RJ+CoJPgXMClUnO6rUyYn2WNEBUv7MU517NegQ8Ov1UNgTc+aSzAGrIcTOv58QWRswv2ovlwn7Ytzs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0631.namprd21.prod.outlook.com (10.175.115.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:42:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 18/19] s390/qeth: reset layer2 attribute on layer
 switch
Thread-Topic: [PATCH AUTOSEL 3.18 18/19] s390/qeth: reset layer2 attribute on
 layer switch
Thread-Index: AQHURkNBqL2uCzsWaU288jJGgN3A5Q==
Date:   Fri, 7 Sep 2018 00:39:38 +0000
Message-ID: <20180907003923.58019-18-alexander.levin@microsoft.com>
References: <20180907003923.58019-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003923.58019-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0631;6:nE4n7g9Tb5Q1/CPIRe0SfyyS4jlW2v0jZEYSOi7GT8a3pRs7lYDjKeF/xzYcTA5lb+IXvQ4h2Cb7BE8tp/A/7ro3Xkwf0+uaJ8RdcB9yS02l3Y4kUIqscvSYc9CxApaWtxkq9gicv/hiomaeyThmcyW+0CEFS00gX+tdFfRRw63ymZTG/ArrYrjQRxOEN4u1A8sUD8q9IsnBJwPCNKgrI46lhfp7BpJ+Todbm1wddi4Zh6n1CLTeNhzoLzOCjZp45Cidxs9V2AwyYGNZdP7TmH08X/ekoYdAmEyD3qP+zEWPtdjYVKxiFq7pDq5Epv3Tg0XeaKxK/LUyhS1B2KIKcyvZkyZVI2lGodmgBiW1i7tDEIdPnQgdhV7p5MYOiKPLnztpQ2u4WHZl5hkOmaL8wkgWnOHWO6cHHSRAbdNA0/rIPD2bU+FToRgnKIws/RBpE7zWuy92Jx2SyHutfidAVw==;5:QtrVGmhU1neHHfgvO95yyw56xh55unMW5KREK5SOwzw68SDzs+SpIdsjjAcREZg28/ZwkI5TgHb9JKIaeUOxcjIbULPNSpYvJKkZI7DoyEVS4h4NOcYBT+rvryl9iZin3sbulolyPxIJPBVbThXb68gYZxM2UatgNxkVwSHS3nQ=;7:faykZHBkvk73iIZZX9i3HJVDTwcebmyi0YZDNKGISfgvCMRFqkNYsWME8nh++nqxgnFdde0Eibj5BN7RzUVVt2Ap3PfcOMpt3a+9r7fInPBq96ua6/FsyrF8S8YDv3ovArmMfWOiTvUN8a6TqRh288KexfFeSrHWlHbo+kWoOol9UY3h5/JTgFUlzNnGLM8loWu+qKVF52FzqAGMfviGDIJ5160rcMXzYuS8Aw7jXq9P72bvDSeXm53M8ZlOLshQ
x-ms-office365-filtering-correlation-id: 76e5e757-fa81-40b3-76ce-08d6145ad4b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0631;
x-ms-traffictypediagnostic: CY4PR21MB0631:
x-microsoft-antispam-prvs: <CY4PR21MB0631CD0655B1B41B2100856AFB000@CY4PR21MB0631.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0631;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0631;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(189003)(199004)(8676002)(72206003)(5660300001)(26005)(66066001)(6486002)(2501003)(14454004)(8936002)(6506007)(81166006)(36756003)(97736004)(10290500003)(81156014)(478600001)(22452003)(6346003)(4326008)(217873002)(10090500001)(102836004)(1076002)(107886003)(6436002)(256004)(68736007)(106356001)(110136005)(486006)(11346002)(6666003)(186003)(6512007)(99286004)(2900100001)(105586002)(7736002)(305945005)(6116002)(2616005)(3846002)(316002)(5250100002)(54906003)(2906002)(86612001)(25786009)(476003)(76176011)(446003)(53936002)(86362001)(575784001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0631;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 4b2F3jsJMmG9nXTmAqWCmo1M6xfXxCR3Z2R9yzjfTwKjTz43mEsKrro65p38yM2Sgl20UUDdsShueIC/kIRbGXEkVHxgQCNmxjJ4sYBBrUej/75rK9ge7s8Y03e0lm5N17oxQkKjyBePde/TY1R00skBnkHmiMQFiGIs0fepN74dWuWKLq2SArYorC7LleRdMRsITOm9BBRmR1J/rsM7TPLiky9mXQpCWI0XIEEl2ATbzYho6nU/V1ca13rpH0c0vUQriG1wgiv6kpNKx99wsV2c24tAclLn8AWJWfMwuDmtUBnqMEbXSDIKXb7RzUfSLYmkiQK8TLhSXLXe2P7nwC0++/D9A4HnawHqiw1UuJE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e5e757-fa81-40b3-76ce-08d6145ad4b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:38.3383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit 70551dc46ffa3555a0b5f3545b0cd87ab67fd002 ]

After the subdriver's remove() routine has completed, the card's layer
mode is undetermined again. Reflect this in the layer2 field.

If qeth_dev_layer2_store() hits an error after remove() was called, the
card _always_ requires a setup(), even if the previous layer mode is
requested again.
But qeth_dev_layer2_store() bails out early if the requested layer mode
still matches the current one. So unless we reset the layer2 field,
re-probing the card back to its previous mode is currently not possible.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/s390/net/qeth_core_sys.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_=
sys.c
index 9d5f746faf72..9eeabfe30747 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -456,6 +456,7 @@ static ssize_t qeth_dev_layer2_store(struct device *dev=
,
 	if (card->discipline) {
 		card->discipline->remove(card->gdev);
 		qeth_core_free_discipline(card);
+		card->options.layer2 =3D -1;
 	}
=20
 	rc =3D qeth_core_load_discipline(card, newdis);
--=20
2.17.1
