Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834FEC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB3F2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="H6d3wv37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB3F2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388641AbeIXUxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:53:04 -0400
Received: from mail-by2nam03on0111.outbound.protection.outlook.com ([104.47.42.111]:30644
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388571AbeIXUxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lT7RKghMFUI/YbY0Y2mca43lf0L6bXCcTz6bPK0BGjQ=;
 b=H6d3wv376uyej84D6zytbcYXsOVEOhHV5rcUWSYE97vFXoZMVOZzjJ03cc04U/zTmgnun5wZ5KHZP4M+Csrt0JwzlKCM4+vmNSstKAnIMW6ELaFjO0+c6TdocoDl9OdwUXYYFK4TPJA9x4wrh0R+aW5FRa9UWWMJQnEDXfkAC7k=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:50:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Yuan-Chi Pang <fu3mo6goo@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 06/23] mac80211: mesh: fix HWMP sequence numbering
 to follow standard
Thread-Topic: [PATCH AUTOSEL 4.9 06/23] mac80211: mesh: fix HWMP sequence
 numbering to follow standard
Thread-Index: AQHUVBXKkT5YIPFRYUmlywYIb00SKQ==
Date:   Mon, 24 Sep 2018 14:49:27 +0000
Message-ID: <20180924144919.164617-6-alexander.levin@microsoft.com>
References: <20180924144919.164617-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144919.164617-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:Di9w2cJ2CG7iA7ZGMEqzhs8jIsetx0Xvo4CIkx9vXiOVtkvzcQV/Rbhw2sDqToRyPyrrgoHQZyTEpi/+8XBdXJthERtCUGR0FxSBVf0m9pwHCLkKTDLD4hyxo0q+aDG3eDsd2ABq0Y9t9n7R1wsCpLc9avtKLyW+mRFPxS/KYtzu/51IH0p6+TynmH4/Z/R3k+tJK+tphQuv2rlefECloF1NeFY6J+00ZFknNaCo/A+vNUEPR/xXwXGTSWEBnDQww6b2RD11Rwo5G/RQEeRW4iwOqdQmZ9VLujvt+1uCRi8Z+ktdju1ARpwR7HLDAlELVpn8eOL+L+MUtpjuK9NXE+xo6ByCopAEhDMoVTbsnSCeU6iAmA3A//+3SOcCtqKEuj1HyaN8yXguSssCO15cuYgKGrwMXc6AA6tW035vMHDrliTOdLXEuDS4c3+nciXda/fBo30ri5hykTCmprwvaA==;5:jgP8rgzZapjW5cZMlBR3XUV9xC/FhTfODynxMgl0FFe/8bwBSuOosCzEED+WvtE7SvtOs57bc1ZE41uPbwFNbBU2iV//pPgyJeHItTmGlUcvrd1X9Fml41OWJ1iC2KFg9Xl6pNku8BBhTMspG3BPhHK3H7LcQ0Wpzs7UpP5p9Hk=;7:ZRgbVVOv3m7G/XGDxOz77cBnZbRuq7MU0Osb8Hl/9wEj2za0IFEvJxNsuI3wj5K6yvD9XVZbZ7g+ch36bxaom7TA5At1MZBuWw7tv5Kr0jGMGm96IsFI45cHuqhTE49B7hRAmjnwdJ6JaVJNRGu6Tu/HaJvm6pgF+3ftGcbMeQ8VgDfO+JyU1kQ0s4wWRPfdxxB6Xe2l0wBDakeBEQTC6s3dekFNn6AW9ImKFC7Jv4CKUrCLWV6wqdGE2r3S3Zha
x-ms-office365-filtering-correlation-id: 6da45026-1c9e-4789-0e1d-08d6222d1038
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB018189A38B39A290F1F9B975FB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(575784001)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(14444005)(5250100002)(217873002)(39060400002)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(11346002)(446003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WXENYGfdFWoV5RKVf0EZYeC5l64Yv5weY4Okqfe0Q3sagbWvNadByRp+FArbHW0JZbuFGJ8WFFcqIeimG+IUrwCEyQ8O0lK9fOk6iiTIv9el2O6wzie/Aw3wGLB5Y2RyYlX97dlQKSG06D/8tLSrBj8oFaOy/b9bEmt80clC/aJzj/cJEJXhI6kWrLc+XuBLcvHE1qyUHkEZdYMvsmDrfVZJ35W9UpfVHlnYeWRBZnjqyNt20ai0PDNdyEw7ElG9NeCIJfYvu223Cew9h7NgG2+ESOjmK6Lb6wMZyjsGyNPM4ogb18FtcdWzDYzeGBJiZAdn3G5yYuvNxivSC2MMfz+/XJ/zdIKhEcAlaVQ0voM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da45026-1c9e-4789-0e1d-08d6222d1038
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:27.2050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuan-Chi Pang <fu3mo6goo@gmail.com>

[ Upstream commit 1f631c3201fe5491808df143d8fcba81b3197ffd ]

IEEE 802.11-2016 14.10.8.3 HWMP sequence numbering says:
If it is a target mesh STA, it shall update its own HWMP SN to
maximum (current HWMP SN, target HWMP SN in the PREQ element) + 1
immediately before it generates a PREP element in response to a
PREQ element.

Signed-off-by: Yuan-Chi Pang <fu3mo6goo@gmail.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/mac80211/mesh_hwmp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index fed598a202c8..b0acb2961e80 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -563,6 +563,10 @@ static void hwmp_preq_frame_process(struct ieee80211_s=
ub_if_data *sdata,
 		forward =3D false;
 		reply =3D true;
 		target_metric =3D 0;
+
+		if (SN_GT(target_sn, ifmsh->sn))
+			ifmsh->sn =3D target_sn;
+
 		if (time_after(jiffies, ifmsh->last_sn_update +
 					net_traversal_jiffies(sdata)) ||
 		    time_before(jiffies, ifmsh->last_sn_update)) {
--=20
2.17.1
