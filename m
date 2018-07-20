Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D896ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D981020856
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="SjFtMmsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D981020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388370AbeGTNTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:19:12 -0400
Received: from mail-eopbgr20098.outbound.protection.outlook.com ([40.107.2.98]:61498
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387823AbeGTNTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DsLxYgEtWDRXqrsEnejhLG9THtCSppWp2mvj5znkKo=;
 b=SjFtMmsGx6UEJR150KX+v4FVF8uufDk/zVeDg1NEhZgVgCmFn5BBrygzNKUpCnZGa/zaUKMjnfwBjPt8x+mEbB6JVF23OqntqlEldQOEUZt8tkmZLrcGyA9W6FmHOWzCMA15QEEaIkMk5ZyC9DX8DcWVk1YxVzS7XY5uUAt0YzA=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2048.eurprd05.prod.outlook.com (10.167.195.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Fri, 20 Jul 2018 12:31:07 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::dc61:4a61:b84:357e%8]) with mapi id 15.20.0973.016; Fri, 20 Jul 2018
 12:31:07 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 2/2] ASoC: tegra: probe deferral error reporting
Thread-Topic: [PATCH 2/2] ASoC: tegra: probe deferral error reporting
Thread-Index: AQHUIABUe+tvL+Nfh0CxF11WAEwB4qSYBuQAgAAEKYA=
Date:   Fri, 20 Jul 2018 12:31:07 +0000
Message-ID: <1532089865.19673.13.camel@toradex.com>
References: <20180720080424.31505-1-marcel@ziswiler.com>
         <20180720080424.31505-2-marcel@ziswiler.com>
         <20180720121612.GC10784@sirena.org.uk>
In-Reply-To: <20180720121612.GC10784@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [89.217.215.226]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2048;6:/Ks7wRS0CovCt6450q0xw8eCxzcJAIOMdAwMDg5kvp7ZcbX7dqE1Tz63YotvOxu0kC9frHC/6kDwHbNno+J9l/riE8CiN+5bqYWhV9iJppLZBEPQBHwYIT2Rha12CRBelFOjlSkAfT3r7NdGufjfwC9cHtWjWh08yTLxfK9rwlqHa05PsLNkeYOCfe24whedqUVHp5o5+EwMsi7feww9lsN9JLMWQgwdDGahfBORJKoSGQfV12eQcPz/JUgVf2s7erdYz9MxhLpaptWx8hHmMzfL6endflqxb0E8F1D/rhNqiq0wSobmkSX9sQ8Kc6zJpC5jvUK786K2tcYpDmuoprfOdF5Gv0E2sKfH2uw8wiMHK9HySbKiNUclSGoap0r8aT9Ka5mSbEdJfCSSQZtPcpHyD8W+ApojDgdBCwIKU+KA1AHUwQjE5/DKSqWBiwW2hbYV6XiFWdB7g01V+R9mGQ==;5:wNCt7h3eLHZAjiJpXz0KvxEQGnHXyAhvk9gfvvxDA3fPDhjqEJz8tf1KC1US6ddOqE485vezWcjpg1gNK75LW7vr9dQ3shT7G1uqHCz7EuYpHaeVzy77RJe3qqXfzz4R+0nLzhdmMLQSrOnsD9TGOhn4r89mrxAeejEClUNY7gc=;7:eKwaM3QcdIjAfJYQmO/kJWCS8QFdyUwgFJDl/CZAFu8gEiNDnzxwzyDbb4wJtPv2Km+fGk/T2+nx/92jni5XMeaq6ngHMgyLhcUuUIK9J4/t6DPCPCha7TY5e7lnt1sB/iT/rPBpe22LPFq3br37jLs5bag8LwkcH1sc+PCDT4HvdEah8+JxV/rTpBbDq0zWvs8ZA1lHZrJwROJOSyMx04CByVhQD2sStHFmY20WXuAHD4I64NURhFNqyrBiUU9N
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 06441136-a6b2-49de-2f5e-08d5ee3caad1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2048;
x-ms-traffictypediagnostic: VI1PR0501MB2048:
x-microsoft-antispam-prvs: <VI1PR0501MB20481DAF9AB7F4467F6B0248FB510@VI1PR0501MB2048.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211171220733660);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0501MB2048;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2048;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(39840400004)(376002)(346002)(189003)(199004)(446003)(105586002)(2906002)(39060400002)(36756003)(26005)(86362001)(103116003)(106356001)(25786009)(478600001)(68736007)(6116002)(6506007)(4326008)(5640700003)(14454004)(3846002)(76176011)(229853002)(6436002)(256004)(186003)(54906003)(53936002)(102836004)(5660300001)(2501003)(5250100002)(476003)(2351001)(6512007)(6246003)(2616005)(7736002)(11346002)(44832011)(66066001)(81166006)(81156014)(486006)(8676002)(97736004)(6486002)(305945005)(316002)(99286004)(1730700003)(8936002)(6916009)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2048;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: E5cTki61YDGR5EAl/InltWW7IHBsiM5LTlqpvWgoA8SjBYdleDfETyRBDoL9JEeojgR6rm4RXgHgxNxx/piluI/5XMBBAiGzEcKTwOLcGicwuFolwvLiMrMAuoU+G3buk4zrTOxPekVr+s2YO2GE3LYS/Qfd/Wmf0QyLwId5cLFHDUPCpjSJRXQ3IahvjeKwEWcjUHDmxLmdScR4TLTvxzLYTyJX3xCgMStR256uQanCLgQ7MtOfROmCyKvmpU9WwvMSCAK9L9nrLjFP4b1ppxDRGfvzR+Et/joolfaNfepmVBgb6t5yfeBMAaT4V1UbQsvAO293tqcMecsCkZvu892o0lL7vTWj0GAEhpEFu2I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B6721A59255464FBF580EB4F549AB22@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06441136-a6b2-49de-2f5e-08d5ee3caad1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 12:31:07.2566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA3LTIwIGF0IDEzOjE2ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBGcmksIEp1bCAyMCwgMjAxOCBhdCAxMDowNDoyNEFNICswMjAwLCBNYXJjZWwgWmlzd2lsZXIg
d3JvdGU6DQo+IA0KPiA+IC0JCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJjb3VsZCBub3QgZ2V0IGNv
ZGVjLQ0KPiA+IHJlc2V0IEdQSU9cbiIpOw0KPiA+ICsJCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJj
b3VsZCBub3QgZ2V0IGNvZGVjLQ0KPiA+IHJlc2V0IEdQSU86ICINCj4gPiArCQkJCQkgICAgIiVk
XG4iLCByZXQpOw0KPiANCj4gRG9uJ3Qgc3BsaXQgc3RyaW5ncyBvdmVyIGxpbmVzIGxpa2UgdGhp
cywgaXQgY2F1c2VzIHByb2JsZW1zIHdoZW4NCj4gcGVvcGxlDQo+IGdyZXAgZm9yIGVycm9ycy4g
IEl0J3MgYmV0dGVyIHRvIGdvIG92ZXIgODAgY29sdW1ucy4NCg0KT0ssIHdpbGwgZG8uIEhvd2V2
ZXIsIGluIHRoaXMgY2FzZSBJIGRpZCBub3QgYWN0dWFsbHkgc3BsaXQgYW55dGhpbmcNCnNlYXJj
aGFibGUgYW55d2F5Lg0KDQo+ID4gIAlhYzk3LT5zeW5jX2dwaW8gPSBvZl9nZXRfbmFtZWRfZ3Bp
byhwZGV2LT5kZXYub2Zfbm9kZSwNCj4gPiAgCQkJCQkgICAgIm52aWRpYSxjb2RlYy1zeW5jLQ0K
PiA+IGdwaW8iLCAwKTsNCj4gPiAgCWlmICghZ3Bpb19pc192YWxpZChhYzk3LT5zeW5jX2dwaW8p
KSB7DQo+ID4gLQkJZGV2X2VycigmcGRldi0+ZGV2LCAibm8gY29kZWMtc3luYyBHUElPDQo+ID4g
c3VwcGxpZWRcbiIpOw0KPiA+ICsJCXJldCA9IGFjOTctPnN5bmNfZ3BpbzsNCj4gPiArCQlkZXZf
ZXJyKCZwZGV2LT5kZXYsICJubyBjb2RlYy1zeW5jIEdQSU8gc3VwcGxpZWQ6DQo+ID4gJWRcbiIs
IHJldCk7DQo+ID4gIAkJZ290byBlcnJfY2xrX3B1dDsNCj4gPiAgCX0NCj4gDQo+IFRoaXMgaXNu
J3QgcmVwb3J0aW5nIGFuIGVycm9yIGNvZGUgYXNzb2NpYXRlZCB3aXRoIHRoZSBhdHRlbXB0IHRv
DQo+IGZpbmQgYQ0KPiBjb2RlYy1zeW5jIEdQSU8sIGl0J3MgdGhlIHJlc3VsdCBvZiBzb21lIG90
aGVyIG9wZXJhdGlvbi4NCg0KV2hhdCBleGFjdGx5IGlzIHRoZW4gdGhlIG9mX2dldF9uYW1lZF9n
cGlvKCkgYWJvdmUgcGxlYXNlIGRvaW5nIGlmDQpub3QgZ2V0dGluZyB0aGUgY29kZWMgc3luYyBH
UElPPyBJIGFtIG5vdCBmb2xsb3dpbmcgeW91LCBzb3JyeS4=
