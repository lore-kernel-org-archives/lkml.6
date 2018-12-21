Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66518C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E99218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VRW09mJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390030AbeLUK7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:59:44 -0500
Received: from mail-eopbgr140104.outbound.protection.outlook.com ([40.107.14.104]:60891
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389941AbeLUK7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6WNrzMbbTUCrQPoGGhFmaqLNKsZTUnPUSbJ1mibdkY=;
 b=VRW09mJxI4yYJZgPtT/cir8TwR92I3f6xKOfBCKkBXlupZrfCt/nWJn6P2vHizuyOkGz2npNN9dVJWzuQl0+0bqJHKbAkMdRlXvZ9lcvjoTj/FwceuRkL9mXj61RB0lmeU3SIQiXtLVkjr8Xg+l6+U320Z6NfEE4pvsXwaJPEUo=
Received: from VI1PR08MB3117.eurprd08.prod.outlook.com (52.133.15.22) by
 VI1PR08MB3168.eurprd08.prod.outlook.com (52.133.15.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Fri, 21 Dec 2018 10:58:59 +0000
Received: from VI1PR08MB3117.eurprd08.prod.outlook.com
 ([fe80::40c5:8008:1ab4:4067]) by VI1PR08MB3117.eurprd08.prod.outlook.com
 ([fe80::40c5:8008:1ab4:4067%4]) with mapi id 15.20.1446.022; Fri, 21 Dec 2018
 10:58:59 +0000
From:   Konstantin Khorenko <khorenko@virtuozzo.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] fbcon: use kvmalloc() for scrollback buffer
Thread-Topic: [PATCH] fbcon: use kvmalloc() for scrollback buffer
Thread-Index: AQHUhW853rUVzeR/Yku9J0nZpQz2waWH9VSAgAE4JQA=
Date:   Fri, 21 Dec 2018 10:58:59 +0000
Message-ID: <4eba60c6-4eb8-5a82-f394-307f835f41e1@virtuozzo.com>
References: <CGME20181126100342epcas3p12a1e6505ff4b73375ac3fcf5d0355d3f@epcas3p1.samsung.com>
 <20181126100253.3299-1-khorenko@virtuozzo.com>
 <a7f6bf30-5094-b669-126d-e4751c17dcbb@samsung.com>
In-Reply-To: <a7f6bf30-5094-b669-126d-e4751c17dcbb@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0047.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::36) To VI1PR08MB3117.eurprd08.prod.outlook.com
 (2603:10a6:803:46::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=khorenko@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB3168;20:VwjWlHlLR/4nRqtP6U1EpCkn+ieg53tyl3EAYGFc/PKeDxLmICKD0r2a87McPxzTWUOQdceEroA1w1z1SWGPG6nROPD0G2jWLBmle510daVMLhQOqtZe95S1+NjyEu2+mETuZgh00lZwgKXgF/2SBZV66jvu+SN1j/ePvz6jcRw=
x-ms-office365-filtering-correlation-id: b09091ae-43e3-490b-1ecd-08d667334f42
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3168;
x-ms-traffictypediagnostic: VI1PR08MB3168:
x-microsoft-antispam-prvs: <VI1PR08MB3168238565E87F74A1877B88C8B80@VI1PR08MB3168.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB3168;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3168;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39850400004)(346002)(396003)(136003)(189003)(199004)(54906003)(25786009)(316002)(6512007)(53936002)(186003)(14454004)(105586002)(106356001)(99286004)(102836004)(86362001)(52116002)(31696002)(386003)(6506007)(53546011)(71200400001)(71190400001)(26005)(76176011)(486006)(97736004)(36756003)(11346002)(7736002)(2616005)(6916009)(446003)(6486002)(68736007)(6436002)(31686004)(6246003)(256004)(14444005)(6116002)(3846002)(305945005)(2906002)(229853002)(476003)(8936002)(478600001)(4326008)(66066001)(81156014)(81166006)(8676002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3168;H:VI1PR08MB3117.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VcivD+mx7hR5Lvc1g/Z8KBFd85qFNtmfu9i77OZzUsARZa4NtCvTJbDxAH14ifIKiMSLzMkOYoHndq/4zNM2/QOD5yt1renhU/1Oc+dpjySqKPzYoE4jk3OiojK8pIWX9cODuZkKf/nV5fFAfjkH3SifEcxXEa3Bt6ZUHyoaAtCZBLnXHIDmNNS58sahQz/j6k1zHyul5LRo60yVZl/QD1wzjAI4JvrJt9DTK2QoalGYfFEV481h0ShqSFqjhRu7jEndhnN15bpKxG71K6BLgmY7HE9MrUb2mOSIdKXYhjfU1tv2aO2Rqeshjjpzy5Iy
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4130ED2A7642E4185BBD35FBD645902@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09091ae-43e3-490b-1ecd-08d667334f42
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 10:58:59.3511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmFydGxvbWllaiwNCg0KT24gMTIvMjAvMjAxOCAwNzoyMSBQTSwgQmFydGxvbWllaiBab2xu
aWVya2lld2ljeiB3cm90ZToNCj4gT24gMTEvMjYvMjAxOCAxMTowMiBBTSwgS29uc3RhbnRpbiBL
aG9yZW5rbyB3cm90ZToNCj4+IFNjcm9sbGJhY2sgZnJhbWUgYnVmZmVyIGlzIHJhdGhlciBiaWcg
LSAzMkssDQo+PiBzbyBpdCByZXF1aXJlcyAzcmQgb3JkZXIgcGFnZSwgc28gbGV0J3MgdXNlIGt2
bWFsbG9jKCkgaW5zdGVhZCBvZg0KPj4gb3JkaW5hcnkga21hbGxvYygpIGZvciBpdC4NCj4NCj4g
SXMgaXQgYWN0dWFsbHkgc2FmZSB0byB1c2Ugbm9uLWNvbnRpZ3VvdXMgbWVtb3J5IGZvciBzb2Z0
YmFja19idWY/DQoNCldlbGwsIHRoYXQncyB3aHkgd2UgbmVlZCBhIHJldmlldy4gOikNCg0KaSd2
ZSBhc2tlZCBteXNlbGYgc2FtZSBxdWVzdGlvbiB3aGlsZSBmaXhpbmcgdGhpcywNCmkndmUgZGln
IHNvdXJjZXMgYSBiaXQgYW5kIGRpZCBub3QgZmluZCBwbGFjZXMgd2hlbiBzb2Z0YmFja19idWYg
aXMgcHJvdmlkZWQgZm9yIERNQSwNCmFsbCBvdGhlciBwbGFjZXMgc2VlbXMgdG8gd29yayB3aXRo
IHZpcnR1YWwgYWRkcmVzc2VzLCBzbyB0aGVyZSBzaG91bGQgYmUgbm8gcHJvYmxlbS4NCg0KRXZl
biBtb3JlIGkgc2F3IGEgZnVuY3Rpb24gd2hpY2ggbWVudGlvbnMgdGhhdCBzb2Z0YmFjayBtaWdo
dCBiZSBub24tY29udGlnaW91czoNCg0KLyogQXMgd2UgbWlnaHQgYmUgaW5zaWRlIG9mIHNvZnRi
YWNrLCB3ZSBtYXkgd29yayB3aXRoIG5vbi1jb250aWd1b3VzIGJ1ZmZlciwNCiAgICB0aGF0J3Mg
d2h5IHdlIGhhdmUgdG8gdXNlIGEgc2VwYXJhdGUgcm91dGluZS4gKi8NCnN0YXRpYyB2b2lkIGZi
Y29uX2ludmVydF9yZWdpb24oc3RydWN0IHZjX2RhdGEgKnZjLCB1MTYgKiBwLCBpbnQgY250KQ0K
DQpTbyBpIHRoaW5rIGl0J3Mgc2FmZSB0byB1c2Uga3ZtYWxsb2MoKSBoZXJlLg0KDQotLQ0KQmVz
dCByZWdhcmRzLA0KDQpLb25zdGFudGluIEtob3JlbmtvLA0KVmlydHVvenpvIExpbnV4IEtlcm5l
bCBUZWFtDQoNCj4+IFNpZ25lZC1vZmYtYnk6IEtvbnN0YW50aW4gS2hvcmVua28gPGtob3Jlbmtv
QHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJj
b24uYyB8IDYgKysrLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9mYmRldi9jb3Jl
L2ZiY29uLmMgYi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJjb24uYw0KPj4gaW5kZXggODk1
OGNjYzhiMWFjLi4yYjFhMzRkM2Y1ZTIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3ZpZGVvL2Zi
ZGV2L2NvcmUvZmJjb24uYw0KPj4gKysrIGIvZHJpdmVycy92aWRlby9mYmRldi9jb3JlL2ZiY29u
LmMNCj4+IEBAIC05OTIsNyArOTkyLDcgQEAgc3RhdGljIGNvbnN0IGNoYXIgKmZiY29uX3N0YXJ0
dXAodm9pZCkNCj4+ICAJCQlpZiAoIXNvZnRiYWNrX2J1Zikgew0KPj4gIAkJCQlzb2Z0YmFja19i
dWYgPQ0KPj4gIAkJCQkgICAgKHVuc2lnbmVkIGxvbmcpDQo+PiAtCQkJCSAgICBrbWFsbG9jKGZi
Y29uX3NvZnRiYWNrX3NpemUsDQo+PiArCQkJCSAgICBrdm1hbGxvYyhmYmNvbl9zb2Z0YmFja19z
aXplLA0KPj4gIAkJCQkJICAgIEdGUF9LRVJORUwpOw0KPj4gIAkJCQlpZiAoIXNvZnRiYWNrX2J1
Zikgew0KPj4gIAkJCQkJZmJjb25fc29mdGJhY2tfc2l6ZSA9IDA7DQo+PiBAQCAtMTAwMSw3ICsx
MDAxLDcgQEAgc3RhdGljIGNvbnN0IGNoYXIgKmZiY29uX3N0YXJ0dXAodm9pZCkNCj4+ICAJCQl9
DQo+PiAgCQl9IGVsc2Ugew0KPj4gIAkJCWlmIChzb2Z0YmFja19idWYpIHsNCj4+IC0JCQkJa2Zy
ZWUoKHZvaWQgKikgc29mdGJhY2tfYnVmKTsNCj4+ICsJCQkJa3ZmcmVlKCh2b2lkICopIHNvZnRi
YWNrX2J1Zik7DQo+PiAgCQkJCXNvZnRiYWNrX2J1ZiA9IDA7DQo+PiAgCQkJCXNvZnRiYWNrX3Rv
cCA9IDA7DQo+PiAgCQkJfQ0KPj4gQEAgLTM2NjUsNyArMzY2NSw3IEBAIHN0YXRpYyB2b2lkIGZi
Y29uX2V4aXQodm9pZCkNCj4+ICAJfQ0KPj4gICNlbmRpZg0KPj4NCj4+IC0Ja2ZyZWUoKHZvaWQg
Kilzb2Z0YmFja19idWYpOw0KPj4gKwlrdmZyZWUoKHZvaWQgKilzb2Z0YmFja19idWYpOw0KPj4g
IAlzb2Z0YmFja19idWYgPSAwVUw7DQo+Pg0KPj4gIAlmb3JfZWFjaF9yZWdpc3RlcmVkX2ZiKGkp
IHsNCj4NCj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBCYXJ0bG9taWVqIFpvbG5pZXJraWV3aWN6
DQo+IFNhbXN1bmcgUiZEIEluc3RpdHV0ZSBQb2xhbmQNCj4gU2Ftc3VuZyBFbGVjdHJvbmljcw0K
