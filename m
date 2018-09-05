Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D033C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024A12073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Lw1nFLch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024A12073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeIFCKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:10:43 -0400
Received: from mail-dm3nam03on0114.outbound.protection.outlook.com ([104.47.41.114]:63040
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727069AbeIFCKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xb8cPF2Fk8kmuf6n+Sr4R1TkS5Dqx85PlOUUFmmeZCE=;
 b=Lw1nFLchPglP1yodY5+Kzzb8PxqGFzQtgbbhBCg/G383Ik623KjesKb1sr6a8nUz3tMOjWe8EJwe7jg83olvaIVgN3q6NZwpk+BW07VTMrk1r6vr9Mq9lcZdCv7oBTklJL713MejdMRVjK51H2BeMc56ysJ3TRKQeONJYnXkXtE=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Wed, 5 Sep 2018 21:38:19 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1143.000; Wed, 5 Sep 2018
 21:38:19 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
CC:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 1/2] mm: Move page struct poisoning to
 CONFIG_DEBUG_VM_PAGE_INIT_POISON
Thread-Topic: [PATCH v2 1/2] mm: Move page struct poisoning to
 CONFIG_DEBUG_VM_PAGE_INIT_POISON
Thread-Index: AQHURV1NzbtPIVbq00mlNM0Zm0ByOKTiMk6AgAAB64CAAAKPgA==
Date:   Wed, 5 Sep 2018 21:38:19 +0000
Message-ID: <985fe87b-b8f4-de58-ea2a-970cbe51b72d@microsoft.com>
References: <20180905211041.3286.19083.stgit@localhost.localdomain>
 <20180905211328.3286.71674.stgit@localhost.localdomain>
 <cd1fc4c6-cc86-8bf7-6aa0-b722c56057e3@microsoft.com>
 <CAKgT0UcC2=Nrk+TDkidxjidnJzvhUPyYRD1uZ09BBWLcmcaOug@mail.gmail.com>
In-Reply-To: <CAKgT0UcC2=Nrk+TDkidxjidnJzvhUPyYRD1uZ09BBWLcmcaOug@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0780;6:re54nVU1A+udVYuK6/dmSiCtbVBGn6yQQEoVO6lLU/n4hJEDio6xlFtGPLfFbvYpHhcU1oT6BU3URG2bNXCfXlCxyuXwovoMOyzWXqxWcewueoDM1Dc275SU+pxH7KJO5CDzF4k+ezWKmLCf3DjeUSspDpAMs3/yLjJSBrMrd6qY4ph4aNLKLtB569WGy9T2fWOtHngw/svu20k58yFhMba5HLpxcWJ/Zk3GLPJs5/r2NYuenX62s6aOTCwZ2J1xI16Q7LbpLedbC5BDPf1B5WOMcEiJZ9nx5vPLSpUvXVMTLkGS+gFViwXtO2JiP0EYk4s4pXVWTpL/68pbLLr8HgLM55V+GdhoO4ff2NhVPTm6cRYeP09PuTf09wKMn5D2db40XdkXRz5V2eXRoG1b5yGrtZc4rTmBLJX++9v/2LoCyN8jyOO/thzQ6/z+eQ/95OumiUV7PxAjLMWUDgp36A==;5:MOGjDFLPOru/WpJIKoqHon6LKd5L4GwUhHrTsNNiWKmGmgKhmSy3rWicC28VdoYsGb7Sr618XVJxAeJ0wFYIjVsDVl3fK7lMr4mhaIDzwGaKMSvQ7dRFtKk1eF3LE7K/DJQh23h4hTphUY099Gqcniyl8FNuKyVerLA5+sOcTJ4=;7:AY5CVZ/uDVsf60B5zgyFFCBtKsUvwH9KVFPk8D0bDPoQjmHJEB5ctfdb7aRKQSx4m2U0JrfE5Mupnpw2t0HBWWvEHefEHINkta96OHbGE3TFR/WHjHaqBamfLhuQ606gtwlKQxNaKjYu+U7VYFPQsn3KoxhiuaYGJA6QuXmlC2ujuXCgzrfQms85zGZ6hzgDOJ7BEz37uSfPsJCTzGG3BF4ybwzB8bpgipUY0mJEz7LnFfkvNXboYKeutqajzwen
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 682af679-ffed-428b-489e-08d61377e57e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0780;
x-ms-traffictypediagnostic: DM5PR21MB0780:
x-microsoft-antispam-prvs: <DM5PR21MB078069EC0165D79BF9CF7E029D020@DM5PR21MB0780.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0780;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0780;
x-forefront-prvs: 078693968A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(376002)(39860400002)(136003)(189003)(199004)(6346003)(66066001)(86612001)(31696002)(14444005)(76176011)(86362001)(5250100002)(6506007)(54906003)(53546011)(6436002)(81166006)(81156014)(72206003)(97736004)(6916009)(8936002)(478600001)(36756003)(14454004)(486006)(256004)(10290500003)(99286004)(8676002)(10090500001)(2906002)(6512007)(4326008)(53936002)(6246003)(446003)(2900100001)(2616005)(476003)(68736007)(6116002)(11346002)(3846002)(186003)(102836004)(6486002)(26005)(305945005)(7736002)(229853002)(106356001)(31686004)(25786009)(22452003)(39060400002)(93886005)(5660300001)(105586002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0780;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: 5yTgNMGnsjL9DG5fWsAo42b0hcJSeUtPzYeRvgjbKCP2ntMfsCiyzFGa5Y1wILXb4B1KCmikwA4Px7hAqSAbBT+rnWEpRsPoPPk3go7295lGArf4lb0cf+OTQdxF/U4qOIM95L883yixET8sI57D1vlanBjF2riZWHkK524aEwPh+GB0voZK1qTrO+4Eh3732E0+Pxvx9AV7emalfEWIJ03NL+qk8OsfJF/CI3q8jgivBtuag02aK5b2qLn5WmbpriVCIH8nrUhAxyoeuOjYhqMHdNYN7V8MgkA0aD8hxR5aRbYSOmkyaMNkztw7xaKe28n0PRyreciHL0SldJ85PNHQaAwpmHkFyfkiLz9ASkA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BDB1FB44F3B424CBF10481CF01F3207@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 682af679-ffed-428b-489e-08d61377e57e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2018 21:38:19.0548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0780
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDkvNS8xOCA1OjI5IFBNLCBBbGV4YW5kZXIgRHV5Y2sgd3JvdGU6DQo+IE9uIFdlZCwg
U2VwIDUsIDIwMTggYXQgMjoyMiBQTSBQYXNoYSBUYXRhc2hpbg0KPiA8UGF2ZWwuVGF0YXNoaW5A
bWljcm9zb2Z0LmNvbT4gd3JvdGU6DQo+Pg0KPj4NCj4+DQo+PiBPbiA5LzUvMTggNToxMyBQTSwg
QWxleGFuZGVyIER1eWNrIHdyb3RlOg0KPj4+IEZyb206IEFsZXhhbmRlciBEdXljayA8YWxleGFu
ZGVyLmguZHV5Y2tAaW50ZWwuY29tPg0KPj4+DQo+Pj4gT24gc3lzdGVtcyB3aXRoIGEgbGFyZ2Ug
YW1vdW50IG9mIG1lbW9yeSBpdCBjYW4gdGFrZSBhIHNpZ25pZmljYW50IGFtb3VudA0KPj4+IG9m
IHRpbWUgdG8gaW5pdGlhbGl6ZSBhbGwgb2YgdGhlIHBhZ2Ugc3RydWN0cyB3aXRoIHRoZSBQQUdF
X1BPSVNPTl9QQVRURVJODQo+Pj4gdmFsdWUuIEkgaGF2ZSBzZWVuIGl0IHRha2Ugb3ZlciAyIG1p
bnV0ZXMgdG8gaW5pdGlhbGl6ZSBhIHN5c3RlbSB3aXRoDQo+Pj4gb3ZlciAxMkdCIG9mIFJBTS4N
Cj4+Pg0KPj4+IEluIG9yZGVyIHRvIHdvcmsgYXJvdW5kIHRoZSBpc3N1ZSBJIGhhZCB0byBkaXNh
YmxlIENPTkZJR19ERUJVR19WTSBhbmQgdGhlbg0KPj4+IHRoZSBib290IHRpbWUgcmV0dXJuZWQg
dG8gc29tZXRoaW5nIG11Y2ggbW9yZSByZWFzb25hYmxlIGFzIHRoZQ0KPj4+IGFyY2hfYWRkX21l
bW9yeSBjYWxsIGNvbXBsZXRlZCBpbiBtaWxsaXNlY29uZHMgdmVyc3VzIHNlY29uZHMuIEhvd2V2
ZXIgaW4NCj4+PiBkb2luZyB0aGF0IEkgaGFkIHRvIGRpc2FibGUgYWxsIG9mIHRoZSBvdGhlciBW
TSBkZWJ1Z2dpbmcgb24gdGhlIHN5c3RlbS4NCj4+Pg0KPj4+IEluc3RlYWQgb2Yga2VlcGluZyB0
aGUgdmFsdWUgaW4gQ09ORklHX0RFQlVHX1ZNIEkgYW0gYWRkaW5nIGEgbmV3IENPTkZJRw0KPj4+
IHZhbHVlIGNhbGxlZCBDT05GSUdfREVCVUdfVk1fUEFHRV9JTklUX1BPSVNPTiB0aGF0IHdpbGwg
Y29udHJvbCB0aGUgcGFnZQ0KPj4+IHBvaXNvbmluZyBpbmRlcGVuZGVudCBvZiB0aGUgQ09ORklH
X0RFQlVHX1ZNIG9wdGlvbi4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBEdXlj
ayA8YWxleGFuZGVyLmguZHV5Y2tAaW50ZWwuY29tPg0KPj4+IC0tLQ0KPj4+ICBpbmNsdWRlL2xp
bnV4L3BhZ2UtZmxhZ3MuaCB8ICAgIDggKysrKysrKysNCj4+PiAgbGliL0tjb25maWcuZGVidWcg
ICAgICAgICAgfCAgIDE0ICsrKysrKysrKysrKysrDQo+Pj4gIG1tL21lbWJsb2NrLmMgICAgICAg
ICAgICAgIHwgICAgNSArKy0tLQ0KPj4+ICBtbS9zcGFyc2UuYyAgICAgICAgICAgICAgICB8ICAg
IDQgKy0tLQ0KPj4+ICA0IGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDYgZGVsZXRp
b25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wYWdlLWZsYWdzLmgg
Yi9pbmNsdWRlL2xpbnV4L3BhZ2UtZmxhZ3MuaA0KPj4+IGluZGV4IDc0YmVlOGNlY2Y0Yy4uMGU5
NWNhNjMzNzVhIDEwMDY0NA0KPj4+IC0tLSBhL2luY2x1ZGUvbGludXgvcGFnZS1mbGFncy5oDQo+
Pj4gKysrIGIvaW5jbHVkZS9saW51eC9wYWdlLWZsYWdzLmgNCj4+PiBAQCAtMTMsNiArMTMsNyBA
QA0KPj4+ICAjaW5jbHVkZSA8bGludXgvbW1fdHlwZXMuaD4NCj4+PiAgI2luY2x1ZGUgPGdlbmVy
YXRlZC9ib3VuZHMuaD4NCj4+PiAgI2VuZGlmIC8qICFfX0dFTkVSQVRJTkdfQk9VTkRTX0ggKi8N
Cj4+PiArI2luY2x1ZGUgPGxpbnV4L3N0cmluZy5oPg0KPj4+DQo+Pj4gIC8qDQo+Pj4gICAqIFZh
cmlvdXMgcGFnZS0+ZmxhZ3MgYml0czoNCj4+PiBAQCAtMTYyLDYgKzE2MywxMyBAQCBzdGF0aWMg
aW5saW5lIGludCBQYWdlUG9pc29uZWQoY29uc3Qgc3RydWN0IHBhZ2UgKnBhZ2UpDQo+Pj4gICAg
ICAgcmV0dXJuIHBhZ2UtPmZsYWdzID09IFBBR0VfUE9JU09OX1BBVFRFUk47DQo+Pj4gIH0NCj4+
Pg0KPj4+ICtzdGF0aWMgaW5saW5lIHZvaWQgcGFnZV9pbml0X3BvaXNvbihzdHJ1Y3QgcGFnZSAq
cGFnZSwgc2l6ZV90IHNpemUpDQo+Pj4gK3sNCj4+PiArI2lmZGVmIENPTkZJR19ERUJVR19WTV9Q
QUdFX0lOSVRfUE9JU09ODQo+Pj4gKyAgICAgbWVtc2V0KHBhZ2UsIFBBR0VfUE9JU09OX1BBVFRF
Uk4sIHNpemUpOw0KPj4+ICsjZW5kaWYNCj4+PiArfQ0KPj4+ICsNCj4+PiAgLyoNCj4+PiAgICog
UGFnZSBmbGFncyBwb2xpY2llcyB3cnQgY29tcG91bmQgcGFnZXMNCj4+PiAgICoNCj4+PiBkaWZm
IC0tZ2l0IGEvbGliL0tjb25maWcuZGVidWcgYi9saWIvS2NvbmZpZy5kZWJ1Zw0KPj4+IGluZGV4
IDYxMzMxNjcyNGM2YS4uM2IxMjc3YzUyZmVkIDEwMDY0NA0KPj4+IC0tLSBhL2xpYi9LY29uZmln
LmRlYnVnDQo+Pj4gKysrIGIvbGliL0tjb25maWcuZGVidWcNCj4+PiBAQCAtNjM3LDYgKzYzNywy
MCBAQCBjb25maWcgREVCVUdfVk1fUEdGTEFHUw0KPj4+DQo+Pj4gICAgICAgICBJZiB1bnN1cmUs
IHNheSBOLg0KPj4+DQo+Pj4gK2NvbmZpZyBERUJVR19WTV9QQUdFX0lOSVRfUE9JU09ODQo+Pj4g
KyAgICAgYm9vbCAiRW5hYmxlIGVhcmx5IHBhZ2UgbWV0YWRhdGEgcG9pc29uaW5nIg0KPj4+ICsg
ICAgIGRlZmF1bHQgeQ0KPj4+ICsgICAgIGRlcGVuZHMgb24gREVCVUdfVk0NCj4+PiArICAgICBo
ZWxwDQo+Pj4gKyAgICAgICBTZWVkIHRoZSBwYWdlIG1ldGFkYXRhIHdpdGggYSBwb2lzb24gcGF0
dGVybiB0byBpbXByb3ZlIHRoZQ0KPj4+ICsgICAgICAgbGlrZWxpaG9vZCBvZiBkZXRlY3Rpbmcg
YXR0ZW1wdHMgdG8gYWNjZXNzIHRoZSBwYWdlIHByaW9yIHRvDQo+Pj4gKyAgICAgICBpbml0aWFs
aXphdGlvbiBieSB0aGUgbWVtb3J5IHN1YnN5c3RlbS4NCj4+PiArDQo+Pj4gKyAgICAgICBUaGlz
IGluaXRpYWxpemF0aW9uIGNhbiByZXN1bHQgaW4gYSBsb25nZXIgYm9vdCB0aW1lIGZvciBzeXN0
ZW1zDQo+Pj4gKyAgICAgICB3aXRoIGEgbGFyZ2UgYW1vdW50IG9mIG1lbW9yeS4NCj4+DQo+PiBX
aGF0IGhhcHBlbnMgd2hlbiBERUJVR19WTV9QR0ZMQUdTID0geSBhbmQNCj4+IERFQlVHX1ZNX1BB
R0VfSU5JVF9QT0lTT04gPSBuID8NCj4+DQo+PiBXZSBhcmUgdGVzdGluZyBmb3IgcGF0dGVybiB0
aGF0IHdhcyBub3Qgc2V0Pw0KPj4NCj4+IEkgdGhpbmsgREVCVUdfVk1fUEFHRV9JTklUX1BPSVNP
TiBtdXN0IGRlcGVuZCBvbiBERUJVR19WTV9QR0ZMQUdTIGluc3RlYWQuDQo+Pg0KPj4gTG9va3Mg
Z29vZCBvdGhlcndpc2UuDQo+Pg0KPj4gVGhhbmsgeW91LA0KPj4gUGF2ZWwNCj4gDQo+IFRoZSBw
cm9ibGVtIGlzIHRoYXQgSSB0aGVuIGVuZCB1cCBpbiB0aGUgc2FtZSBzaXR1YXRpb24gSSBoYWQg
aW4gdGhlDQo+IGxhc3QgcGF0Y2ggd2hlcmUgeW91IGhhdmUgdG8gaGF2ZSBERUJVR19WTV9QR0ZM
QUdTIG9uIGluIG9yZGVyIHRvIGRvDQo+IHRoZSBzZWVkaW5nIHdpdGggcG9pc29uLg0KDQpPSw0K
DQo+IA0KPiBJIGNhbiB3cmFwIHRoZSBiaXQgb2YgY29kZSBpbiBQYWdlUG9pc29uZWQgdG8ganVz
dCBhbHdheXMgcmV0dXJuIGZhbHNlDQo+IGlmIHdlIGRpZG4ndCBzZXQgdGhlIHBhdHRlcm4uIEkg
ZmlndXJlIHRoZXJlIGlzIHZhbHVlIHRvIGJlIGhhZCBmb3INCj4gcnVubmluZyBERUJVR19WTV9Q
R0ZMQUdTIHJlZ2FyZGxlc3Mgb2YgdGhlIHBvaXNvbiBjaGVjaywgb3INCj4gREVCVUdfVk1fUEFH
RV9JTklUX1BPSVNPTiB3aXRob3V0IHRoZSBQR0ZMQUdTIGNoZWNrLiBUaGF0IGlzIHdoeSBJDQo+
IHdhbnRlZCB0byBsZWF2ZSB0aGVtIGluZGVwZW5kZW50Lg0KDQpIb3cgYWJvdXQ6DQoNClJlbW92
ZSAiZGVwZW5kcyBvbiBERUJVR19WTSIsIGJ1dCBtYWtlIERFQlVHX1ZNX1BHRkxBR1MgdG8gZGVw
ZW5kIG9uDQpib3RoIERFQlVHX1ZNIGFuZCBERUJVR19WTV9QQUdFX0lOSVRfUE9JU09OPw0KDQpE
RUJVR19WTV9QR0ZMQUdTIGlzIGFscmVhZHkgZXh0cmVtZWx5IHNsb3csIHNvIGhhdmluZyB0aGlz
IGV4dHJhDQpkZXBlbmRlbmN5IGlzIE9LLg0KDQpUaGFuayB5b3UsDQpQYXZlbA0KDQo+IA0KPiAt
IEFsZXgNCj4g
