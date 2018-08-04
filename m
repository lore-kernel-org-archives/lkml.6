Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF66C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 18:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3E4217BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 18:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="UG0UPIIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3E4217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbeHDUlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 16:41:19 -0400
Received: from mail-eopbgr690055.outbound.protection.outlook.com ([40.107.69.55]:50400
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728054AbeHDUlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 16:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zuwz7ciavBQqMHIfDDEZjSngr+F8aIqcTvA+kxa73CY=;
 b=UG0UPIIR/yIYUoQNY71LQgHtI2x23dVMbYwfk6VhNSHwogO7bzajF18+9oztEzBa61TzfWvjA1/ufJvlgzutL9mVLv6eHCZ7a6tiLggM4lNG41A3NiakngA1XuiILwJi1gTnXzF5nvjIe4lWVK23FCsvEItIb7ul/Wwr/I/Rlh4=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB585.namprd06.prod.outlook.com (10.141.229.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Sat, 4 Aug 2018 18:38:00 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287%8]) with mapi id 15.20.1017.018; Sat, 4 Aug 2018
 18:37:59 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "javier@javigon.com" <javier@javigon.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] lightnvm: pblk: take write semaphore on metadata
Thread-Topic: [PATCH V2] lightnvm: pblk: take write semaphore on metadata
Thread-Index: AQHUKy4oY4UxBppQIUyZHCwFhVt5lKSv7XKAgAAAu9w=
Date:   Sat, 4 Aug 2018 18:37:59 +0000
Message-ID: <9526B6A2-7DE5-467B-B4E4-D5B51BCFB242@cnexlabs.com>
References: <1533303011-2855-1-git-send-email-javier@cnexlabs.com>,<17e4f9c3-856a-9e7b-8d36-e93ebc7dbf0b@lightnvm.io>
In-Reply-To: <17e4f9c3-856a-9e7b-8d36-e93ebc7dbf0b@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [83.94.206.14]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB585;6:0+Zvgh0FW8pQSg4s5wq3J9x0CfrLsLLWV9shWnbGoGKg81Vjoogz/ulSBw5KxhVhlTCzr9lORjZBCFP3n6jnGNdgcr5dHbtL52hUIpOjKMTJURotGbfMesc2pUO1DwnGVqlyPARvGhU04i62OYsNznOEgjH6+92LAGOMO47+oRvUY/0ILoTJNdPsBbiiU2uPq4ThYTdPQJ2ntWRVK1Q/W3yYuUq6kKerBSsVHN4j0D6gXQJ4AYx1GX9v+ICsDzSJmELYljJhi5dNXrK6EVl3C0k9ZLweK0am+0udbx5/DIy0LsFYbHx2bLpZm77cs51NaX6PwBruy8UgSOlimvksjLbKZCTRQbTmnj8aTDp8B3l06kYfrqr3zYI3tDed8/+nlB0SMdvke0AKycWet6+KEyPhSmv+seWLoQznY9nsCxwNd1mGUgAnbr+0ftvOhA6XWjoi7+pxoBrAPK/jWmzT4g==;5:jhQwiPta8T+0OfnIk3LkwJzVIbrGfJ/nISb6rin/EYHudgobhPa1/tLzLopCBXDKI7TjJx3BOG+QnxT4nuHdN71wnzcFNCDPH4Lj8vlqoL0O2tgUX6iIFVMyc7XdKzg5b8tiGADxASgYDFvO/BqkSE1iTNVnBCFVfX8P0UX+RKU=;7:XaASXUHjgPJW8sTUYVrjv9KG4j9Se4gfZYBZzeNHJGEtdmG2c3GP0sFSqeuM4WO3hjBGYgQbof6vXX+PX3p2iR9qe++IxWfU4tbgwbSH8zeLkZBoBVHyRWYMTU/L1aaiT4DvsPV48Y55O3QX/kFsIy1Qo/uDd3p1I6b1Pl0xUli1NjhduHwM34b+hGxyDAybm/3jbJJk2vlhQC9kzyjUAVqynBcGXcSfrbYsuZhnh7lK+nn1a5JShEyyshoBJeuh
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a838815d-c2d1-483a-e7ed-08d5fa396781
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR06MB585;
x-ms-traffictypediagnostic: CO2PR06MB585:
x-microsoft-antispam-prvs: <CO2PR06MB585F94D182A8D3F2649ADD0BA220@CO2PR06MB585.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB585;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB585;
x-forefront-prvs: 0754F7E325
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(136003)(39830400003)(199004)(189003)(8676002)(6246003)(2906002)(14454004)(54906003)(81166006)(81156014)(66066001)(26005)(106356001)(5660300001)(5250100002)(25786009)(68736007)(97736004)(105586002)(8936002)(53936002)(83716003)(76176011)(4326008)(2900100001)(256004)(11346002)(82746002)(53546011)(99286004)(7736002)(14444005)(102836004)(305945005)(229853002)(2616005)(6506007)(86362001)(36756003)(6436002)(316002)(6116002)(6512007)(486006)(33656002)(476003)(3846002)(446003)(186003)(6486002)(6916009)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB585;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eyfrTmGswup2tzAD2vuvQwsCfn6Hhgco+m+k/8ZcgJkGOjuSF1plnvi+nPmlv2RB5kXYvzEa2Qfyev9odWICXwCOaP9Mdy5lU8OK8lEqL72naH8+v0/BbN1bylS1TbcBr5fcm9outgOqjaDBIJ07SVia8rnTr4/Swx6Bla/yonBM/NfHoXs5zXtpR7TxxCQUuv1Q0MftXTsB0jPPo/BmQbBAMQFrXnKudtv/7roNsUQsba1rfd6PNxBOyv9xLgz75bPPUCzgBcNR6n5drP5ct6ceC/Fqgsdk5lvys0OqC6k7h72vaCansjRzxxVpkKq7fSzlZM2JpkB/2/e0J58F9Ppt6zUi0TjG03K7qkRNbI4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a838815d-c2d1-483a-e7ed-08d5fa396781
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2018 18:37:59.8198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB585
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gNCBBdWcgMjAxOCwgYXQgMjAuMzUsIE1hdGlhcyBCasO4cmxpbmcgPG1iQGxpZ2h0
bnZtLmlvPiB3cm90ZToNCj4gDQo+PiBPbiAwOC8wMy8yMDE4IDAzOjMwIFBNLCBKYXZpZXIgR29u
esOhbGV6IHdyb3RlOg0KPj4gIyBDaGFuZ2VzIHNpbmdlIFYxOg0KPj4gICAtIEZpeCBkb3VibGUg
SS9PIG9uIHRoZSByZWFkIHBhdGggKGJ5IE1hdGlhcykNCj4+ICAgLSBJbXByb3ZlIGNvbW1pdCBt
ZXNzYWdlIChieSBKZW5zKQ0KPj4gcGJsayBndWFyYW50ZWVzIHdyaXRlIG9yZGVyaW5nIGF0IGEg
Y2h1bmsgbGV2ZWwgdGhyb3VnaCBhIHBlciBvcGVuIGNodW5rDQo+PiBzZW1hcGhvcmUuIEF0IHRo
aXMgcG9pbnQsIHNpbmNlIHdlIG9ubHkgaGF2ZSBhbiBvcGVuIEkvTyBzdHJlYW0gZm9yIGJvdGgN
Cj4+IHVzZXIgYW5kIEdDIGRhdGEsIHRoZSBzZW1hcGhvcmUgaXMgcGVyIHBhcmFsbGVsIHVuaXQu
DQo+PiBTaW5jZSBtZXRhZGF0YSBJL08gaXMgc3luY2hyb25vdXMsIHRoZSBzZW1hcGhvcmUgaXMg
bm90IG5lZWRlZCBhcw0KPj4gb3JkZXJpbmcgaXMgZ3VhcmFudGVlZC4gSG93ZXZlciwgaWYgdGhl
IG1ldGFkYXRhIHNjaGVtZSBjaGFuZ2VzIG9yDQo+PiBtdWx0aXBsZSBzdHJlYW1zIGFyZSBvcGVu
LCB0aGlzIGd1YXJhbnRlZSBtaWdodCBub3QgYmUgcHJlc2VydmVkLg0KPj4gVGhpcyBwYXRjaCBt
YWtlcyBzdXJlIHRoYXQgYWxsIHdyaXRlcyBnbyB0aHJvdWdoIHRoZSBzZW1hcGhvcmUsIGV2ZW4g
Zm9yDQo+PiBzeW5jaHJvbm91cyBJL08uIFRoaXMgaXMgY29uc2lzdGVudCB3aXRoIHBibGsncyB3
cml0ZSBJL08gbW9kZWwuIEl0IGFsc28NCj4+IHNpbXBsaWZpZXMgbWFpbnRlbmFuY2Ugc2luY2Ug
Y2hhbmdlcyBpbiB0aGUgbWV0ZGF0YWRhIHNjaGVtZSBjb3VsZCBjYXVzZQ0KPj4gb3JkZXJpbmcg
aXNzdWVzLg0KPj4gU2lnbmVkLW9mZi1ieTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyQGNuZXhs
YWJzLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvbGlnaHRudm0vcGJsay1jb3JlLmMgfCAxOCAr
KysrKysrKysrKysrKysrLS0NCj4+ICBkcml2ZXJzL2xpZ2h0bnZtL3BibGsuaCAgICAgIHwgIDEg
Kw0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2xpZ2h0bnZtL3BibGstY29yZS5jIGIvZHJpdmVycy9s
aWdodG52bS9wYmxrLWNvcmUuYw0KPj4gaW5kZXggMDA5ODRiNDg2ZmVhLi42NDMyZmFmNWIxOWMg
MTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2xpZ2h0bnZtL3BibGstY29yZS5jDQo+PiArKysgYi9k
cml2ZXJzL2xpZ2h0bnZtL3BibGstY29yZS5jDQo+PiBAQCAtNDkzLDYgKzQ5MywyMCBAQCBpbnQg
cGJsa19zdWJtaXRfaW9fc3luYyhzdHJ1Y3QgcGJsayAqcGJsaywgc3RydWN0IG52bV9ycSAqcnFk
KQ0KPj4gICAgICByZXR1cm4gbnZtX3N1Ym1pdF9pb19zeW5jKGRldiwgcnFkKTsNCj4+ICB9DQo+
PiAgK2ludCBwYmxrX3N1Ym1pdF9pb19zeW5jX3NlbShzdHJ1Y3QgcGJsayAqcGJsaywgc3RydWN0
IG52bV9ycSAqcnFkKQ0KPiANCj4gTml0cGlja2luZyBhIGJpdC4gSXQgbG9va3MgdG8gbWUgdGhh
dCBhIGZ1bmN0aW9uIHRoYXQgaGFzIHNlbWFwaG9yZSBpbiBpdHMgbmFtZSwgc2hvdWxkIHRha2Ug
dGhlIHNlbWFwaG9yZSBpbiBhbGwgY2FzZXMgdW5sZXNzIGl0IHJldHVybnMgYW4gZXJyb3IuIFdo
ZW4gaXQgb25seSBkb2VzIGl0IG9uIHdyaXRlcywgaXQgY3JlYXRlcyBjb25mdXNpb24uDQo+IA0K
PiBNYXliZSB0aGlzIHdvdWxkIGJlIG9uZSBvZiB0aGUgY2FzZXMgd2hlcmUgaXQgaXMgb2theSB0
byBoYXZlIHRoZSBsb2dpYyBpdCBpbiB0aGUgY2FsbGVyIGZ1bmN0aW9uLCBvciBkbyBzdWNoIHRo
YXQgaXQgdGFrZXMgYSBmbGFnIGlmIGl0IHNob3VsZCB0YWtlIHRoZSBzZW1hcGhvcmUuIFRoYXQn
bGwgbWFrZSBpdCBleHBsaWNpdCB3aGVuIGl0IGlzIGRvbmUuDQoNCkkgdGhpbmsgaXTigJlzIGNs
ZWFuZXIgdG8gbWFrZSBhIGhlbHBlciBhcyB0aGUgcGF0dGVybiByZXBlYXRzIG9uIGFsbCB3cml0
ZSBzeW5jIEkvT3MuIEnigJltIG9rIHdpdGggbW92aW5nIHRoZSBjaGVjayB0byB0aGUgY2FsbGVy
IGFuZCBvbmx5IHVzaW5nIHRoaXMgaGVscGVyIG9uIHRoZSB3cml0ZSBwYXRoLiBJIGNhbiBzZW5k
IGEgVjMgbmV4dCB3ZWVrLiANCg0KSmF2aWVyLiA=
