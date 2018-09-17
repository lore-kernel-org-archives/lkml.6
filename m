Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE4BECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAAA2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MtTlOxF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AAAA2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbeIQI1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:55 -0400
Received: from mail-eopbgr710116.outbound.protection.outlook.com ([40.107.71.116]:59328
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728756AbeIQI1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfvSrna2tcXPxx4iAGYIIKL8uqMEKoijo5gNo5eOqaw=;
 b=MtTlOxF/YuUZacbsAf8biYtH8x9OBhMhxdYmiLUcZTAqnlajX+wmDB81w+px5seQMBBwG5xWZHw2FacVeI/fWGOj/nRv9jTxa/RtZDJeoSCJFQItnv55oa8B50MYYQuueIqamea7JBOsRPsQ7luy4NhivXYU3W5W9V9PEqU0lL0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0790.namprd21.prod.outlook.com (10.175.121.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Mon, 17 Sep 2018 03:02:35 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:35 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 094/136] bitfield: fix *_encode_bits()
Thread-Topic: [PATCH AUTOSEL 4.18 094/136] bitfield: fix *_encode_bits()
Thread-Index: AQHUTjKwxr2xk+mtW0WnCUd9pMTZ8g==
Date:   Mon, 17 Sep 2018 03:01:11 +0000
Message-ID: <20180917030006.245495-94-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0790;6:mvqia1+knAdZQnK/kS1aEqhB9sx43rhrEgHNa50eqdnTqZE0vxzwc2G4CHMX0u2mMpIntfdFlvFaFHqrHkyyYbVi9Bj99F+J+7XgtYFuHkY6qFpU2hTKUqRXH8LBvS0uouN6S2rmTuGnfnxOp11dhH675AWtalNpioqIUUi4bRE42sfXsrwpqcqA8oLSDFojPgcndvr35uXupzWevk7IM38u14j1VuT1TRQibPavMtzsZJUVTP7+P54Q0cqn4U2boQ0e2m9D49tTzse/5JRWb3YnoFQqM+IFdwro7Xrp0eoLN87TzJLpN1f8vWEIAJUtNsGqF5BSU1S/XoypRu2URaNiJtDUwroPDVuONi7WskPGuKGY/09GTeKQ3ChsJ3plDp4c4Jm5R5MrsaCzcwa0DseIrUWRLO7wbtsHVsuRjUPBbCvVRn4P2nUoWWszkhBeJaByMNVrbF17W23yHaVX4Q==;5:KPrtOafdtOgnfA0Z6aVpcduhUFftHmhmmmLwBq227Eq79qCVndwGjriamDVbpJuyDrYETxELx0NFAMI/S6ApUm4Em1tTSxulGmkPtfYYmYYWRxDmRnC57L4jq4JuBqWI4UM7bJpBt+IoU/xlV8B7/hhcvLGnzvjdGTRW7c2xUn0=;7:VPdf5xleqJbeYx4A1k1BXPDSKChH6z05FSrbxglNw+xaLYFgMEkoQK+Zq7sdkBuKGZ2sq9LaictLabeF7goo4mBpEzhNgyIbjnm9aYjJVg3yEQbEpx0LW6zGBDa+e2r7AD0HAt9JQwX2SZIMEUyfw+/HdZv08fdLyw0KzrbApkVezZzod6pej1zkJcYKyK5mJTggHuMYX5MNu6BhZLc3qzvu4DmDsyDqg8PnTtx8E1trYF45Fcc1MZI1XCRM7XKW
x-ms-office365-filtering-correlation-id: 8798d462-ca13-454d-e9e9-08d61c4a04dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0790;
x-ms-traffictypediagnostic: CY4PR21MB0790:
x-microsoft-antispam-prvs: <CY4PR21MB0790743470F9F72FB5722E8DFB1E0@CY4PR21MB0790.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0790;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0790;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(76176011)(22452003)(6666003)(110136005)(99286004)(6436002)(6486002)(2900100001)(2906002)(54906003)(6346003)(10090500001)(5660300001)(7736002)(6512007)(14444005)(217873002)(316002)(256004)(53936002)(36756003)(6506007)(25786009)(106356001)(26005)(86612001)(10290500003)(1076002)(68736007)(476003)(6116002)(3846002)(478600001)(5250100002)(11346002)(446003)(72206003)(2501003)(81156014)(81166006)(8676002)(14454004)(102836004)(107886003)(186003)(2616005)(575784001)(97736004)(86362001)(66066001)(305945005)(486006)(8936002)(4326008)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0790;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Pl0f7+xe7QpE6fPDkAyqAvri8ZCZDDP/YmLFE3bP9w7BoRDnPWJ787dGEA7251kNUGMSPTKVK/yaIaxqg8zcsTPi2MEtktgI4T/Gw4pQXkXpWcA9wFAqwG5PRZbKncTvFMwEMEck0ovjL8jdpkguvvPR0+0QJAIiDKShqLFoCMo8RV8949q+QaseJerHMTgWWLPHx37LTw8+LtUFQkZ6pX1uEJ7KdcD3ApCGJ8VZJ1BDUod2b5Zc636LwEk1SaUOxr3ddoMw1/ir+VcgwKYRZTRk+ymP8l1QjXQ9O0DsYsbpls9YcMM39PSCVQCMk4HCkl2F9jv3q3z9Wk/dbiVdLIH71YsduJAR/SknBU4pLk4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8798d462-ca13-454d-e9e9-08d61c4a04dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:11.4323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes@sipsolutions.net>

[ Upstream commit e7d4a95da86e0b048702765bbdcdc968aaf312e7 ]

There's a bug in *_encode_bits() in using ~field_multiplier() for
the check whether or not the constant value fits into the field,
this is wrong and clearly ~field_mask() was intended. This was
triggering for me for both constant and non-constant values.

Additionally, make this case actually into an compile error.
Declaring the extern function that will never exist with just a
warning is pointless as then later we'll just get a link error.

While at it, also fix the indentation in those lines I'm touching.

Finally, as suggested by Andy Shevchenko, add some tests and for
that introduce also u8 helpers. The tests don't compile without
the fix, showing that it's necessary.

Fixes: 00b0c9b82663 ("Add primitives for manipulating bitfields both in hos=
t- and fixed-endian.")
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/linux/bitfield.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index cf2588d81148..147a7bb341dd 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -104,7 +104,7 @@
 		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask));	\
 	})
=20
-extern void __compiletime_warning("value doesn't fit into mask")
+extern void __compiletime_error("value doesn't fit into mask")
 __field_overflow(void);
 extern void __compiletime_error("bad bitfield mask")
 __bad_mask(void);
@@ -121,8 +121,8 @@ static __always_inline u64 field_mask(u64 field)
 #define ____MAKE_OP(type,base,to,from)					\
 static __always_inline __##type type##_encode_bits(base v, base field)	\
 {									\
-        if (__builtin_constant_p(v) &&	(v & ~field_multiplier(field)))	\
-			    __field_overflow();				\
+	if (__builtin_constant_p(v) && (v & ~field_mask(field)))	\
+		__field_overflow();					\
 	return to((v & field_mask(field)) * field_multiplier(field));	\
 }									\
 static __always_inline __##type type##_replace_bits(__##type old,	\
--=20
2.17.1
