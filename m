Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9544C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2524920837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ma1EXk1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2524920837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbeIBRjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:39:39 -0400
Received: from mail-co1nam03on0123.outbound.protection.outlook.com ([104.47.40.123]:41136
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729068AbeIBRaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78F8aUcBY+cJNUMh4Ub4oE05QzapffxQZUs547HWKbY=;
 b=Ma1EXk1kDKLvCOz9E5EPij/YZ1xYvrp7TeBAx0a+39oT0jA6k7PvzDDMGoKAZTcj1JoEbfFZuYOe7n+5cAa6xajJt2TE7aPGGRn1qJyKZQGljthtS5JXS3Cx+8OIZ6NNJYaf8G2+CcXNWadCbxsvQKWCl01hSbszTs1okm6YwlY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:32 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:32 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 26/62] Bluetooth: hidp: Fix handling of strncpy
 for hid->name information
Thread-Topic: [PATCH AUTOSEL 4.9 26/62] Bluetooth: hidp: Fix handling of
 strncpy for hid->name information
Thread-Index: AQHUQr7j7S2tlDpNx0il/AZsSck1sQ==
Date:   Sun, 2 Sep 2018 13:14:32 +0000
Message-ID: <20180902131411.183978-16-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:KumWCVRDDPT4w6SlrWz9Vy8JI2NKUSfAtpeGvBWUe+cqrWE7ELsNlKWgC32nP+BKnb+hPjYQPaLZIjd08lrSPjSHMoyuTjMezB1GJxrBAu1ka3L8dvFqr3xGW3CnpVeJ/7d9VYMehmO27BQedtpo6zjHrMLkZxVOFj+o6ahE3gxZwnUWhTBIibDBul2KZJBIRaGZhwe8Qqgc8yUTSpMhpzk079rxm1fGaYfRn/8x80nCd1/574lKLRLf4uI7TV/LSLezNBWxdvojiCmj2w4Mn8ihmgwov67yPGs5HG03Ogd/i04eJcZPZ6Zn4+a0gpTYhac4GP9Dysp6COUXREwc2dOezou6a+79ONzbjsfJ+7+FOfDSiQbb3jPPoKThJSP3+pInx4Kr8eh0pkdIvkpEchb06Y5lB4iKI/Sy265HTXeB7h74p9xdUdrZU9Z2QQwbv04J56xTRit/mx6ypWDfJQ==;5:KQQhMTEGkazTZRk8MnIVd4h1c8hRNSDK3CUuVsKdJntQOJu98cXdSvsTKznZe/xU3XVi10yQDUbni3f7+i/DlhuTMmKHB/0oXGl9mUYyutStKYmYh+SVXzVKqM2hnv5ApiRVnlkVCrV6+uQYgBwZm7SnMsJ+pX2U1Dh/tiz17Vc=;7:j4sWPurWkWL/byuaN5XMG+Szib6cZkmtKq6+sTnaIPj+0vTjg8y6ub5MPyDq6cfkByKzHQmbsMI5kQB3U89o3VbJ/47IWZK3e07hm+qq13/Sb12UjYRu+jhoY6IR1XC7ogvpLi/feRTuPdZC2OVe8/OU6ESqQphMrLPU7/X47awGiAPrz0EIEuRoDGzYGD+M3f/pE5aRNS1QOPjJCqCag+8EzTx7Tcd+FG/Jt39q2UiUgTEY0zSaU9HHvHKhquGy
x-ms-office365-filtering-correlation-id: 79df120a-e2e8-44f6-eaa3-08d610d605bf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB012091351037D86A3D3B20C2FB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(376002)(396003)(366004)(189003)(199004)(106356001)(53936002)(72206003)(5250100002)(22452003)(97736004)(6512007)(10090500001)(2616005)(2501003)(446003)(11346002)(478600001)(10290500003)(476003)(14454004)(81166006)(186003)(486006)(25786009)(4326008)(36756003)(102836004)(8676002)(81156014)(105586002)(8936002)(2900100001)(99286004)(66066001)(68736007)(110136005)(26005)(107886003)(6506007)(5660300001)(76176011)(14444005)(54906003)(316002)(1076002)(86612001)(3846002)(6116002)(256004)(7736002)(6486002)(575784001)(86362001)(6436002)(305945005)(217873002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ldxue79JoAvaw3K87S6LHBCDeO77zJZcYxGIx4Tc/ie9muh4S8siFkI4aw4lzT1WGPgdc27hUIyHmM/I3S8mY4wTYjuMWGW3HX3Ximezsr645qjHayKV9HqiKi1eov+wlm1/wX1WDenxTJN3mhXXA1TiJ3IdP3uQKpxNj09H1mN8El5qaM6K95QOcZdt9QfqGhSyqofV3+EZfNtDFC2tcdFXKzTf9j/7bI2cZaZ0gtS13XAHVHgro5LEOLUcC92JtKh7KvbhyE2ZybCkx9MnTh3YyqEKDi/337QTyy4bGKPQssorqAcdMR4YLMWF9SKPdrWdt0nx9gCksiiuAVcXlTyy4WwwswD/clKMRmpYQ3g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <33CCBD821E4E6B4D9582DACCA947BCA6@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79df120a-e2e8-44f6-eaa3-08d610d605bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:32.3451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFyY2VsIEhvbHRtYW5uIDxtYXJjZWxAaG9sdG1hbm4ub3JnPg0KDQpbIFVwc3RyZWFt
IGNvbW1pdCBiM2NhZGFhNDg1ZjBjMjBhZGQxNjQ0YTVjODc3YjA3NjViMjg1YzBjIF0NCg0KVGhp
cyBmaXhlcyB0d28gaXNzdWVzIHdpdGggc2V0dGluZyBoaWQtPm5hbWUgaW5mb3JtYXRpb24uDQoN
CiAgQ0MgICAgICBuZXQvYmx1ZXRvb3RoL2hpZHAvY29yZS5vDQpJbiBmdW5jdGlvbiDigJhoaWRw
X3NldHVwX2hpZOKAmSwNCiAgICBpbmxpbmVkIGZyb20g4oCYaGlkcF9zZXNzaW9uX2Rldl9pbml0
4oCZIGF0IG5ldC9ibHVldG9vdGgvaGlkcC9jb3JlLmM6ODE1OjksDQogICAgaW5saW5lZCBmcm9t
IOKAmGhpZHBfc2Vzc2lvbl9uZXfigJkgYXQgbmV0L2JsdWV0b290aC9oaWRwL2NvcmUuYzo5NTM6
OCwNCiAgICBpbmxpbmVkIGZyb20g4oCYaGlkcF9jb25uZWN0aW9uX2FkZOKAmSBhdCBuZXQvYmx1
ZXRvb3RoL2hpZHAvY29yZS5jOjEzNjY6ODoNCm5ldC9ibHVldG9vdGgvaGlkcC9jb3JlLmM6Nzc4
OjI6IHdhcm5pbmc6IOKAmHN0cm5jcHnigJkgb3V0cHV0IG1heSBiZSB0cnVuY2F0ZWQgY29weWlu
ZyAxMjcgYnl0ZXMgZnJvbSBhIHN0cmluZyBvZiBsZW5ndGggMTI3IFstV3N0cmluZ29wLXRydW5j
YXRpb25dDQogIHN0cm5jcHkoaGlkLT5uYW1lLCByZXEtPm5hbWUsIHNpemVvZihyZXEtPm5hbWUp
IC0gMSk7DQogIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn4NCg0KICBDQyAgICAgIG5ldC9ibHVldG9vdGgvaGlkcC9jb3JlLm8NCm5ldC9ibHVldG9v
dGgvaGlkcC9jb3JlLmM6IEluIGZ1bmN0aW9uIOKAmGhpZHBfc2V0dXBfaGlk4oCZOg0KbmV0L2Js
dWV0b290aC9oaWRwL2NvcmUuYzo3Nzg6Mzg6IHdhcm5pbmc6IGFyZ3VtZW50IHRvIOKAmHNpemVv
ZuKAmSBpbiDigJhzdHJuY3B54oCZIGNhbGwgaXMgdGhlIHNhbWUgZXhwcmVzc2lvbiBhcyB0aGUg
c291cmNlOyBkaWQgeW91IG1lYW4gdG8gdXNlIHRoZSBzaXplIG9mIHRoZSBkZXN0aW5hdGlvbj8g
Wy1Xc2l6ZW9mLXBvaW50ZXItbWVtYWNjZXNzXQ0KICBzdHJuY3B5KGhpZC0+bmFtZSwgcmVxLT5u
YW1lLCBzaXplb2YocmVxLT5uYW1lKSk7DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF4NCg0KU2lnbmVkLW9mZi1ieTogTWFyY2VsIEhvbHRtYW5uIDxtYXJjZWxAaG9sdG1h
bm4ub3JnPg0KU2lnbmVkLW9mZi1ieTogSm9oYW4gSGVkYmVyZyA8am9oYW4uaGVkYmVyZ0BpbnRl
bC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jv
c29mdC5jb20+DQotLS0NCiBuZXQvYmx1ZXRvb3RoL2hpZHAvY29yZS5jIHwgMiArLQ0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEv
bmV0L2JsdWV0b290aC9oaWRwL2NvcmUuYyBiL25ldC9ibHVldG9vdGgvaGlkcC9jb3JlLmMNCmlu
ZGV4IDE4MTFmOGU3ZGRmNC4uNTUyZTAwYjA3MTk2IDEwMDY0NA0KLS0tIGEvbmV0L2JsdWV0b290
aC9oaWRwL2NvcmUuYw0KKysrIGIvbmV0L2JsdWV0b290aC9oaWRwL2NvcmUuYw0KQEAgLTc3NCw3
ICs3NzQsNyBAQCBzdGF0aWMgaW50IGhpZHBfc2V0dXBfaGlkKHN0cnVjdCBoaWRwX3Nlc3Npb24g
KnNlc3Npb24sDQogCWhpZC0+dmVyc2lvbiA9IHJlcS0+dmVyc2lvbjsNCiAJaGlkLT5jb3VudHJ5
ID0gcmVxLT5jb3VudHJ5Ow0KIA0KLQlzdHJuY3B5KGhpZC0+bmFtZSwgcmVxLT5uYW1lLCBzaXpl
b2YocmVxLT5uYW1lKSAtIDEpOw0KKwlzdHJuY3B5KGhpZC0+bmFtZSwgcmVxLT5uYW1lLCBzaXpl
b2YoaGlkLT5uYW1lKSk7DQogDQogCXNucHJpbnRmKGhpZC0+cGh5cywgc2l6ZW9mKGhpZC0+cGh5
cyksICIlcE1SIiwNCiAJCSAmbDJjYXBfcGkoc2Vzc2lvbi0+Y3RybF9zb2NrLT5zayktPmNoYW4t
PnNyYyk7DQotLSANCjIuMTcuMQ0K
