Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1262FC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E0C260E8
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="R0veB6ww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E0C260E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935083AbeFYUeN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 16:34:13 -0400
Received: from mail-eopbgr710109.outbound.protection.outlook.com ([40.107.71.109]:12448
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934651AbeFYUeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 16:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z14P8lAF+nN2JHzN1im/uhZu7TOu0vBt13hahQNp5qM=;
 b=R0veB6ww0UfWQjqEwi6O9mo739CPg3ALRw6XwKQ4NBnBACELUuvm4mbFHx14DVyYlOwzzMHKWYey74hu9gqTcJ/9g1eXZ482i5lB1hGhzYkzlBj7Phyyhs23aSLMwdkN+z0Po4cQdSVxQVIZlqQXu4XYu8yCbLGBBD4Pc7KGhU8=
Received: from CY4PR2101MB0722.namprd21.prod.outlook.com (52.132.100.10) by
 CY4PR2101MB0724.namprd21.prod.outlook.com (52.132.100.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.2; Mon, 25 Jun 2018 20:34:07 +0000
Received: from CY4PR2101MB0722.namprd21.prod.outlook.com
 ([fe80::a849:9c0c:337b:2ee7]) by CY4PR2101MB0722.namprd21.prod.outlook.com
 ([fe80::a849:9c0c:337b:2ee7%5]) with mapi id 15.20.0930.005; Mon, 25 Jun 2018
 20:34:07 +0000
From:   Long Li <longli@microsoft.com>
To:     Tom Talpey <tom@talpey.com>, Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [Patch v2 04/15] CIFS: Add support for direct pages in wdata
Thread-Topic: [Patch v2 04/15] CIFS: Add support for direct pages in wdata
Thread-Index: AQHT+E9f8iesTk+0R0+v7Zd8pFgQO6RuzgyAgALHcvA=
Date:   Mon, 25 Jun 2018 20:34:06 +0000
Message-ID: <CY4PR2101MB0722C0EBEDF150DCD5E88A8ECE4A0@CY4PR2101MB0722.namprd21.prod.outlook.com>
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
 <20180530194807.31657-5-longli@linuxonhyperv.com>
 <4edad13c-e257-ff1c-223a-324f484a936a@talpey.com>
In-Reply-To: <4edad13c-e257-ff1c-223a-324f484a936a@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:a:fdde:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2101MB0724;7:DnC+ol/yah7eV8GPKo9BDafv0HxLQZjU5QKRMEWlSY14NmSrr6is3OYHkrGUQQ9XYr18WcqYtsBazdmgGp+i0UImNi6JVWb+DnwmfLEQdqrq+DdS1wKtN/SDpuKsrnnwU7s6Y/MCuehr7tmgYqkg3hjT58zLzFiGo22UeaeieJEICASuRUWg3+9FAQjwDS0DXoZzB0j8Jks8H1+x6EthwKsy+PWlPHLMKyLUsdQ78Mic8eMpWshFqggiwxEYdbli
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 39b9a232-4814-4dc7-20bf-08d5dadaffbf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:CY4PR2101MB0724;
x-ms-traffictypediagnostic: CY4PR2101MB0724:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR2101MB0724FCC4B2A888ACD7BD6500CE4A0@CY4PR2101MB0724.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(189930954265078)(219752817060721);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY4PR2101MB0724;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2101MB0724;
x-forefront-prvs: 0714841678
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(8990500004)(110136005)(33656002)(229853002)(74316002)(6306002)(9686003)(6246003)(55016002)(6436002)(10090500001)(25786009)(53936002)(68736007)(8936002)(81166006)(22452003)(256004)(106356001)(5250100002)(305945005)(7736002)(2501003)(105586002)(8676002)(46003)(81156014)(316002)(14454004)(102836004)(478600001)(476003)(99286004)(53546011)(446003)(76176011)(486006)(2900100001)(10290500003)(6506007)(2201001)(966005)(2906002)(86612001)(86362001)(5660300001)(575784001)(6116002)(186003)(7696005)(11346002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2101MB0724;H:CY4PR2101MB0722.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CU3VC3Br77xlGLsmlGyap2AK4OyVJikItiwdZpslPdpWKVL4EiEjrHmFxlQ4iO9A+AHryCYD21LELMoNFY/iUingMysAiF5BzgCz5OxT06mWSb27Khp5fnsLBlcwROP7JBwX6qZe4xDG8OXsqlr6CD8eui5fppHZzpQ1f85XkdjpNVbqEhTeXdrtCPB2d/fwjnAldcafGEshOBBtfUkzBrSA7FlQuDSQWeHnWE/EPSoMWaqNxZwJP6uSjIwcagzp5X4WtRifg7p/PFn2bbt68+hrQwmWQtLxQwBow5gCzxvQc/m5AJsyJPLmJANa35vXCUoZPGhEXkPzVXCoUg1BiujLg5rezJEBoVnia6WgxUs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b9a232-4814-4dc7-20bf-08d5dadaffbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2018 20:34:06.9828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2101MB0724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BhdGNoIHYyIDA0LzE1XSBDSUZTOiBBZGQgc3VwcG9ydCBmb3IgZGly
ZWN0IHBhZ2VzIGluIHdkYXRhDQo+IA0KPiBPbiA1LzMwLzIwMTggMzo0NyBQTSwgTG9uZyBMaSB3
cm90ZToNCj4gPiBGcm9tOiBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT4NCj4gPg0KPiA+
IEFkZCBhIGZ1bmN0aW9uIHRvIGFsbG9jYXRlIHdkYXRhIHdpdGhvdXQgYWxsb2NhdGluZyBwYWdl
cyBmb3IgZGF0YQ0KPiA+IHRyYW5zZmVyLiBUaGlzIGdpdmVzIHRoZSBjYWxsZXIgYW4gb3B0aW9u
IHRvIHBhc3MgYSBudW1iZXIgb2YgcGFnZXMNCj4gPiB0aGF0IHBvaW50IHRvIHRoZSBkYXRhIGJ1
ZmZlciB0byB3cml0ZSB0by4NCj4gPg0KPiA+IHdkYXRhIGlzIHJlcG9uc2libGUgZm9yIGZyZWUg
dGhvc2UgcGFnZXMgYWZ0ZXIgaXQncyBkb25lLg0KPiANCj4gU2FtZSBjb21tZW50IGFzIGZvciB0
aGUgZWFybGllciBwYXRjaC4gIkNhbGxlciIgaXMgcmVzcG9uc2libGUgZm9yICJmcmVlaW5nIg0K
PiB0aG9zZSBwYWdlcz8gQ29uZnVzaW5nLCBhcyB3b3JkZWQuDQo+IA0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+DQo+ID4gLS0tDQo+ID4gICBm
cy9jaWZzL2NpZnNnbG9iLmggIHwgIDIgKy0NCj4gPiAgIGZzL2NpZnMvY2lmc3Byb3RvLmggfCAg
MiArKw0KPiA+ICAgZnMvY2lmcy9jaWZzc21iLmMgICB8IDE3ICsrKysrKysrKysrKysrLS0tDQo+
ID4gICAzIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZnMvY2lmcy9jaWZzZ2xvYi5oIGIvZnMvY2lmcy9jaWZzZ2xv
Yi5oIGluZGV4DQo+ID4gNTY4NjRhODcuLjdmNjJjOTggMTAwNjQ0DQo+ID4gLS0tIGEvZnMvY2lm
cy9jaWZzZ2xvYi5oDQo+ID4gKysrIGIvZnMvY2lmcy9jaWZzZ2xvYi5oDQo+ID4gQEAgLTEyMDUs
NyArMTIwNSw3IEBAIHN0cnVjdCBjaWZzX3dyaXRlZGF0YSB7DQo+ID4gICAJdW5zaWduZWQgaW50
CQkJdGFpbHN6Ow0KPiA+ICAgCXVuc2lnbmVkIGludAkJCWNyZWRpdHM7DQo+ID4gICAJdW5zaWdu
ZWQgaW50CQkJbnJfcGFnZXM7DQo+ID4gLQlzdHJ1Y3QgcGFnZQkJCSpwYWdlc1tdOw0KPiA+ICsJ
c3RydWN0IHBhZ2UJCQkqKnBhZ2VzOw0KPiANCj4gQWxzbyBzYW1lIGNvbW1lbnQgYXMgZm9yIGVh
cmxpZXIgcGF0Y2gsIHRoZXNlIGFyZSBzeW50YWN0aWNhbGx5IGVxdWl2YWxlbnQNCj4gYW5kIG1h
eWJlIG5vdCBuZWVkZWQgdG8gY2hhbmdlLg0KPiANCj4gPiAgIH07DQo+ID4NCj4gPiAgIC8qDQo+
ID4gZGlmZiAtLWdpdCBhL2ZzL2NpZnMvY2lmc3Byb3RvLmggYi9mcy9jaWZzL2NpZnNwcm90by5o
IGluZGV4DQo+ID4gMWYyN2Q4ZS4uNzkzM2M1ZiAxMDA2NDQNCj4gPiAtLS0gYS9mcy9jaWZzL2Np
ZnNwcm90by5oDQo+ID4gKysrIGIvZnMvY2lmcy9jaWZzcHJvdG8uaA0KPiA+IEBAIC01MzMsNiAr
NTMzLDggQEAgaW50IGNpZnNfYXN5bmNfd3JpdGV2KHN0cnVjdCBjaWZzX3dyaXRlZGF0YSAqd2Rh
dGEsDQo+ID4gICB2b2lkIGNpZnNfd3JpdGV2X2NvbXBsZXRlKHN0cnVjdCB3b3JrX3N0cnVjdCAq
d29yayk7DQo+ID4gICBzdHJ1Y3QgY2lmc193cml0ZWRhdGEgKmNpZnNfd3JpdGVkYXRhX2FsbG9j
KHVuc2lnbmVkIGludCBucl9wYWdlcywNCj4gPiAgIAkJCQkJCXdvcmtfZnVuY190IGNvbXBsZXRl
KTsNCj4gPiArc3RydWN0IGNpZnNfd3JpdGVkYXRhICpjaWZzX3dyaXRlZGF0YV9kaXJlY3RfYWxs
b2Moc3RydWN0IHBhZ2UgKipwYWdlcywNCj4gPiArCQkJCQkJd29ya19mdW5jX3QgY29tcGxldGUp
Ow0KPiA+ICAgdm9pZCBjaWZzX3dyaXRlZGF0YV9yZWxlYXNlKHN0cnVjdCBrcmVmICpyZWZjb3Vu
dCk7DQo+ID4gICBpbnQgY2lmc19xdWVyeV9tZl9zeW1saW5rKHVuc2lnbmVkIGludCB4aWQsIHN0
cnVjdCBjaWZzX3Rjb24gKnRjb24sDQo+ID4gICAJCQkgIHN0cnVjdCBjaWZzX3NiX2luZm8gKmNp
ZnNfc2IsDQo+ID4gZGlmZiAtLWdpdCBhL2ZzL2NpZnMvY2lmc3NtYi5jIGIvZnMvY2lmcy9jaWZz
c21iLmMgaW5kZXgNCj4gPiBjOGU0Mjc4Li41YWNhMzM2IDEwMDY0NA0KPiA+IC0tLSBhL2ZzL2Np
ZnMvY2lmc3NtYi5jDQo+ID4gKysrIGIvZnMvY2lmcy9jaWZzc21iLmMNCj4gPiBAQCAtMTk1Miw2
ICsxOTUyLDcgQEAgY2lmc193cml0ZWRhdGFfcmVsZWFzZShzdHJ1Y3Qga3JlZiAqcmVmY291bnQp
DQo+ID4gICAJaWYgKHdkYXRhLT5jZmlsZSkNCj4gPiAgIAkJY2lmc0ZpbGVJbmZvX3B1dCh3ZGF0
YS0+Y2ZpbGUpOw0KPiA+DQo+ID4gKwlrdmZyZWUod2RhdGEtPnBhZ2VzKTsNCj4gPiAgIAlrZnJl
ZSh3ZGF0YSk7DQo+ID4gICB9DQo+ID4NCj4gPiBAQCAtMjA3NSwxMiArMjA3NiwyMiBAQCBjaWZz
X3dyaXRldl9jb21wbGV0ZShzdHJ1Y3Qgd29ya19zdHJ1Y3QNCj4gKndvcmspDQo+ID4gICBzdHJ1
Y3QgY2lmc193cml0ZWRhdGEgKg0KPiA+ICAgY2lmc193cml0ZWRhdGFfYWxsb2ModW5zaWduZWQg
aW50IG5yX3BhZ2VzLCB3b3JrX2Z1bmNfdCBjb21wbGV0ZSkNCj4gPiAgIHsNCj4gPiArCXN0cnVj
dCBwYWdlICoqcGFnZXMgPQ0KPiA+ICsJCWt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBwYWdlICopICog
bnJfcGFnZXMsIEdGUF9OT0ZTKTsNCj4gDQo+IFdoeSBkbyB5b3UgZG8gYSBHRlBfTk9GUyBoZXJl
IGJ1dCBHRlBfS0VSTkVMIGluIHRoZSBlYXJsaWVyIHBhdGNoPw0KDQpUaGlzIGlzIGZvciB0aGUg
SS9PIHdyaXRlIHBhdGguIFRoZSBlYXJsaWVyIHBhdGNoIGlzIGZvciBJL08gcmVhZCBwYXRoLiBU
aGlzIGNvZGUgcHJlc2VydmVzIHRoZSBiZWhhdmlvciBmcm9tIHRoZSBidWZmZXIgSS9PIGNvZGUu
DQoNClRoZSB3cml0ZSBwYXRoIGlzIHBvc3NpYmx5IHVzZWQgd2hlbiBtZW1vcnkgaXMgdW5kZXIg
cHJlc3N1cmUsIHNvIGl0J3MgYmV0dGVyIG5vdCB0byBjYWxsIEZTIChhbmQgQ0lGUykgdGhhdCBt
YXkgcmVzdWx0IGluIGEgbG9vcC4NCg0KPiANCj4gPiArCWlmIChwYWdlcykNCj4gPiArCQlyZXR1
cm4gY2lmc193cml0ZWRhdGFfZGlyZWN0X2FsbG9jKHBhZ2VzLCBjb21wbGV0ZSk7DQo+ID4gKw0K
PiA+ICsJcmV0dXJuIE5VTEw7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0cnVjdCBjaWZzX3dyaXRl
ZGF0YSAqDQo+ID4gK2NpZnNfd3JpdGVkYXRhX2RpcmVjdF9hbGxvYyhzdHJ1Y3QgcGFnZSAqKnBh
Z2VzLCB3b3JrX2Z1bmNfdA0KPiA+ICtjb21wbGV0ZSkgew0KPiA+ICAgCXN0cnVjdCBjaWZzX3dy
aXRlZGF0YSAqd2RhdGE7DQo+ID4NCj4gPiAtCS8qIHdyaXRlZGF0YSArIG51bWJlciBvZiBwYWdl
IHBvaW50ZXJzICovDQo+ID4gLQl3ZGF0YSA9IGt6YWxsb2Moc2l6ZW9mKCp3ZGF0YSkgKw0KPiA+
IC0JCQlzaXplb2Yoc3RydWN0IHBhZ2UgKikgKiBucl9wYWdlcywgR0ZQX05PRlMpOw0KPiA+ICsJ
d2RhdGEgPSBremFsbG9jKHNpemVvZigqd2RhdGEpLCBHRlBfTk9GUyk7DQo+ID4gICAJaWYgKHdk
YXRhICE9IE5VTEwpIHsNCj4gPiArCQl3ZGF0YS0+cGFnZXMgPSBwYWdlczsNCj4gPiAgIAkJa3Jl
Zl9pbml0KCZ3ZGF0YS0+cmVmY291bnQpOw0KPiA+ICAgCQlJTklUX0xJU1RfSEVBRCgmd2RhdGEt
Pmxpc3QpOw0KPiA+ICAgCQlpbml0X2NvbXBsZXRpb24oJndkYXRhLT5kb25lKTsNCj4gPg0KPiAt
LQ0KPiBUbyB1bnN1YnNjcmliZSBmcm9tIHRoaXMgbGlzdDogc2VuZCB0aGUgbGluZSAidW5zdWJz
Y3JpYmUgbGludXgtY2lmcyIgaW4gdGhlDQo+IGJvZHkgb2YgYSBtZXNzYWdlIHRvIG1ham9yZG9t
b0B2Z2VyLmtlcm5lbC5vcmcgTW9yZSBtYWpvcmRvbW8gaW5mbyBhdA0KPiBodHRwczovL25hMDEu
c2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGdmdlci5r
ZQ0KPiBybmVsLm9yZyUyRm1ham9yZG9tby0NCj4gaW5mby5odG1sJmFtcDtkYXRhPTAyJTdDMDEl
N0Nsb25nbGklNDBtaWNyb3NvZnQuY29tJTdDMjBlMGJjYmRjY2UzDQo+IDQwMjEzM2VlMDhkNWQ5
NzY3OTc3JTdDNzJmOTg4YmY4NmYxNDFhZjkxYWIyZDdjZDAxMWRiNDclN0MxJTdDMCUNCj4gN0M2
MzY2NTQwMjUyMjk3NDk1NDkmYW1wO3NkYXRhPXA0UDlBcVM4Y25PSEVyQ0ZjMVhBTGVhWnhIdUI3
JTJCDQo+IFZPRjEwU2phYXljQUklM0QmYW1wO3Jlc2VydmVkPTANCg==
