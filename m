Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD3BC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132A621907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ehPZDUo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfBGXuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 18:50:46 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:2823 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGXuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 18:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1549583443; x=1581119443;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ejLmcIlfLO0Ssh23QOb4ogmjBngZo6L2DAcjdrS9wDQ=;
  b=ehPZDUo03tuXqrYDWdx6l6Rxkk+XfADjj5LNBgNcBT836NllwlaZTm9X
   pHdun9tkAkIqqKmQ6aJ37nbH4EPdM+YGPOEjiFUAWk2MC3k6K76zX7XC1
   8TZA5w+6PYVpKaXl1VA/CjLMNaaaudohs4KgjOHFbwLigrahOorzPlj4Q
   Y=;
X-IronPort-AV: E=Sophos;i="5.58,345,1544486400"; 
   d="scan'208";a="658326734"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 07 Feb 2019 23:50:39 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS id DF3D2A20B6;
        Thu,  7 Feb 2019 23:50:35 +0000 (UTC)
Received: from EX13D07UWA003.ant.amazon.com (10.43.160.35) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 7 Feb 2019 23:50:35 +0000
Received: from EX13D07UWA001.ant.amazon.com (10.43.160.145) by
 EX13D07UWA003.ant.amazon.com (10.43.160.35) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 7 Feb 2019 23:50:34 +0000
Received: from EX13D07UWA001.ant.amazon.com ([10.43.160.145]) by
 EX13D07UWA001.ant.amazon.com ([10.43.160.145]) with mapi id 15.00.1367.000;
 Thu, 7 Feb 2019 23:50:34 +0000
From:   "Sobon, Przemyslaw" <psobon@amazon.com>
To:     "ikegami_to@yahoo.co.jp" <ikegami_to@yahoo.co.jp>,
        Boris Brezillon <boris.brezillon@collabora.com>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "joakim.tjernlund@infinera.com" <joakim.tjernlund@infinera.com>,
        "ikegami@allied-telesis.co.jp" <ikegami@allied-telesis.co.jp>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        Liu Jian <liujian56@huawei.com>
Subject: RE: Re: [PATCH] cfi: fix deadloop in cfi_cmdset_0002.c
 do_write_buffer
Thread-Topic: Re: [PATCH] cfi: fix deadloop in cfi_cmdset_0002.c
 do_write_buffer
Thread-Index: AQHUu5pgPuG2fN5WMEykck2gQhFtIaXNv4mAgAQNLxCAAkIwgIAA64iAgAALp4A=
Date:   Thu, 7 Feb 2019 23:50:34 +0000
Message-ID: <632ed76bd3844ceab75066d1f30a7115@EX13D07UWA001.ant.amazon.com>
References: <1548977439-318904-1-git-send-email-liujian56@huawei.com>
 <20190203092645.18d1495b@bbrezillon> <20190203093509.269bf1e1@bbrezillon>
 <acd16b85676e4d1d89f3acfbeda30107@EX13D07UWA001.ant.amazon.com>
 <20190207095635.0fc3b411@kernel.org>
 <193621849.44066.1549580387922.JavaMail.yahoo@mail.yahoo.co.jp>
In-Reply-To: <193621849.44066.1549580387922.JavaMail.yahoo@mail.yahoo.co.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.164]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSWtlZ2FtaSwNCg0KSSBoYXZlIHNlZW4gYSBjYXNlIG15c2VsZiB3aGVyZSBhIHZhbHVlIHdh
cyB3cml0dGVuLCBjaGlwIGNoYW5nZWQNCnN0YXRlIHRvICJyZWFkeSIgYnV0IHdoZW4gSSB3YXMg
cmVhZGluZyB0aGUgdmFsdWUgd2FzIGluY29ycmVjdC4NClRoaXMgY2FuIGhhcHBlbiBhcyByZXN1
bHQgb2YgaW50ZXJtaXR0ZW50IGlzc3VlIHdpdGggZmxhc2guIEl0IGlzDQpoYXJkIHRvIGZhbGwg
aW50byBzY2VuYXJpbyB3aGVuIHRlc3Rpbmcgb24gbGltaXRlZCBudW1iZXIgb2YgZGV2aWNlcw0K
YnV0IHdpdGggbGFyZ2UgZW5vdWdoIHBvcHVsYXRpb24geW91IGNhbiBzZWUgdGhhdC4gQW5vdGhl
ciBzaXR1YXRpb24NCmlzIHdoZW4gYSBmbGFzaCBjaGlwIHJlYWNoZXMgaXRzIG1heGltdW0gbnVt
YmVyIG9mIHdyaXRlcy4gU28gZm9yDQpleGFtcGxlIGEgY2hpcCBpcyBkZXNpZ25lZCBmb3IgMTAw
ayB3cml0ZXMgdG8gYSBwYWdlLiBPbmNlIHlvdSANCnJlYWNoIHRoYXQgbnVtYmVyIG9mIHdyaXRl
cyB5b3UgY2FuIGhhdmUgaW52YWxpZCBkYXRhIHdyaXR0ZW4gdG8NCmZsYXNoIGJ1dCBjaGlwIGl0
c2VsZiByZXBvcnRzIGV2ZXJ5dGhpbmcgd2FzIGdvb2QgYW5kIHN3aXRjaGVzIHRvDQoicmVhZHki
IHN0YXRlLg0KDQpIb3BlIHRoaXMgZXhwbGFuYXRpb24gaXMgY2xlYXIuIFBsZWFzZSBsZXQgbWUg
a25vdy4NCg0KUmVnYXJkcywNClByemVtZWsNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiBpa2VnYW1pX3RvQHlhaG9vLmNvLmpwIDxpa2VnYW1pX3RvQHlhaG9vLmNvLmpw
PiANCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDcsIDIwMTkgMzowMCBQTQ0KPiANCj4gSGkg
UHJ6ZW1lay1zYW4sDQo+IA0KPiBDb3VsZCB5b3UgcGxlYXNlIGV4cGxhaW4gdGhlIGNhc2UgZGV0
YWlsIHRoYXQgdGhlIHZhbHVlIGlzIHdyaXR0ZW4gaW5jb3JyZWN0bHk/DQo+IEkgdGhpbmsgdGhh
dCB0aGUgdmFsdWUgaXMgb25seSB3cml0dGVuIGNvcnJlY3RseSBleGNlcHQgYSBidWcuDQo+IA0K
PiBSZWdhcmRzLA0KPiBJa2VnYW1pDQo+IA0KPiAtLS0gYm9yaXMuYnJlemlsbG9uQGNvbGxhYm9y
YS5jb20gd3JvdGUgLS0tIDoNCj4gPiBIaSBTb2JvbiwNCj4gPiANCj4gPiBPbiBUdWUsIDUgRmVi
IDIwMTkgMjI6Mjg6NDQgKzAwMDANCj4gPiAiU29ib24sIFByemVteXNsYXciIDxwc29ib25AYW1h
em9uLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gPiA+IEZyb206IEJvcmlzIEJyZXppbGxvbiA8YmJy
ZXppbGxvbkBrZXJuZWwub3JnPg0KPiA+ID4gPiBTZW50OiBTdW5kYXksIEZlYnJ1YXJ5IDMsIDIw
MTkgMTI6MzUgQU0NCj4gPiA+ID4gPiArUHJ6ZW15c2xhdw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+
IE9uIEZyaSwgMSBGZWIgMjAxOSAwNzozMDozOSArMDgwMCBMaXUgSmlhbiANCj4gPiA+ID4gPiA8
bGl1amlhbjU2QGh1YXdlaS5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ICAgDQo+ID4gPiA+ID4gPiBJ
biBmdW5jdGlvbiBkb193cml0ZV9idWZmZXIoKSwgaW4gdGhlIGZvciBsb29wLCB0aGVyZSBpcyBh
IA0KPiA+ID4gPiA+ID4gY2FzZQ0KPiA+ID4gPiA+ID4gY2hpcF9yZWFkeSgpIHJldHVybnMgMSB3
aGlsZSBjaGlwX2dvb2QoKSByZXR1cm5zIDAsIHNvIGl0IA0KPiA+ID4gPiA+ID4gbmV2ZXIgYnJl
YWsgdGhlIGxvb3AuDQo+ID4gPiA+ID4gPiBUbyBmaXggdGhpcywgY2hpcF9nb29kKCkgaXMgZW5v
dWdoIGFuZCBpdCBzaG91bGQgdGltZW91dCBpZiBpdCANCj4gPiA+ID4gPiA+IHN0YXkgYmFkIGZv
ciBhIHdoaWxlLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IExvb2tzIGxpa2UgUHJ6ZW15c2xhdyBy
ZXBvcnRlZCBhbmQgZml4ZWQgdGhlIHNhbWUgcHJvYmxlbS4NCj4gPiA+ID4gPiAgIA0KPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiBGaXhlczogZGZlYWUxMDczNTgzKG10ZDogY2ZpX2NtZHNldF8w
MDAyOiBDaGFuZ2Ugd3JpdGUgYnVmZmVyIA0KPiA+ID4gPiA+ID4gdG8gY2hlY2sgY29ycmVjdCB2
YWx1ZSkNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBDYW4geW91IHB1dCB0aGUgRml4ZXMgdGFnIG9u
IGEgc2luZ2xlLCBhbmQgdGhlIGZvcm1hdCBpcw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEZpeGVz
OiA8aGFzaD4gKCJtZXNzYWdlIikNCj4gPiA+ID4gPiAgIA0KPiA+ID4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogWWkgSHVhaWppZSA8eWlodWFpamllQGh1YXdlaS5jb20+DQo+ID4gPiA+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBMaXUgSmlhbiA8bGl1amlhbjU2QGh1YXdlaS5jb20+DQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gWzFdaHR0cDovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLzEwMjU1NjYvDQo+
ID4gPiA+ID4gICANCj4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gIGRyaXZlcnMvbXRkL2No
aXBzL2NmaV9jbWRzZXRfMDAwMi5jIHwgNiArKystLS0NCj4gPiA+ID4gPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvY2hpcHMvY2ZpX2NtZHNldF8wMDAyLmMN
Cj4gPiA+ID4gPiA+IGIvZHJpdmVycy9tdGQvY2hpcHMvY2ZpX2NtZHNldF8wMDAyLmMNCj4gPiA+
ID4gPiA+IGluZGV4IDcyNDI4YjYuLjgxOGU5NGIgMTAwNjQ0DQo+ID4gPiA+ID4gPiAtLS0gYS9k
cml2ZXJzL210ZC9jaGlwcy9jZmlfY21kc2V0XzAwMDIuYw0KPiA+ID4gPiA+ID4gKysrIGIvZHJp
dmVycy9tdGQvY2hpcHMvY2ZpX2NtZHNldF8wMDAyLmMNCj4gPiA+ID4gPiA+IEBAIC0xODc2LDE0
ICsxODc2LDE0IEBAIHN0YXRpYyBpbnQgX194aXByYW0gZG9fd3JpdGVfYnVmZmVyKHN0cnVjdCBt
YXBfaW5mbyAqbWFwLCBzdHJ1Y3QgZmxjaGlwICpjaGlwLA0KPiA+ID4gPiA+ID4gICAgICAgICAg
ICAgIGNvbnRpbnVlOw0KPiA+ID4gPiA+ID4gICAgICAgICAgfQ0KPiA+ID4gPiA+ID4gIA0KPiA+
ID4gPiA+ID4gLSAgICAgICAgaWYgKHRpbWVfYWZ0ZXIoamlmZmllcywgdGltZW8pICYmICFjaGlw
X3JlYWR5KG1hcCwgYWRyKSkNCj4gPiA+ID4gPiA+IC0gICAgICAgICAgICBicmVhazsNCj4gPiA+
ID4gPiA+IC0NCj4gPiA+ID4gPiA+ICAgICAgICAgIGlmIChjaGlwX2dvb2QobWFwLCBhZHIsIGRh
dHVtKSkgew0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgIHhpcF9lbmFibGUobWFwLCBjaGlwLCBh
ZHIpOw0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgIGdvdG8gb3BfZG9uZTsNCj4gPiA+ID4gPiA+
ICAgICAgICAgIH0NCj4gPiA+ID4gPiA+ICANCj4gPiA+ID4gPiA+ICsgICAgICAgIGlmICh0aW1l
X2FmdGVyKGppZmZpZXMsIHRpbWVvKSkNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICBicmVhazsN
Cj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICAgICAgICAgIC8qIExhdGVuY3kgaXNzdWVzLiBE
cm9wIHRoZSBsb2NrLCB3YWl0IGEgd2hpbGUgYW5kIHJldHJ5ICovDQo+ID4gPiA+ID4gPiAgICAg
ICAgICBVREVMQVkobWFwLCBjaGlwLCBhZHIsIDEpOw0KPiA+ID4gPiA+ID4gICAgICB9DQo+ID4g
PiA+ID4gICANCj4gPiA+ID4gDQo+ID4gPiA+IEJUVywgdGhlIHBhdGNoIGl0c2VsZiBsb29rcyBn
b29kIHRvIG1lLiBJa2VnYW1pLCBjYW4geW91IGNvbmZpcm0gaXQgZG9lcyB0aGUgcmlnaHQgdGhp
bmc/DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGFua3MsDQo+ID4gPiA+IA0KPiA+ID4gPiBCb3Jpcw0K
PiA+ID4gPiAgIA0KPiA+ID4gDQo+ID4gPiBPbmUgY29tbWVudCB0byB0aGlzIHBhdGNoLiBJZiB2
YWx1ZSBpcyB3cml0dGVuIGluY29ycmVjdGx5IHF1aWNrbHkgDQo+ID4gPiB3ZSB3aWxsIGJlIHN0
dWNrIGluIHRoZSBsb29wIGV2ZW4gdGhvdWdoIG5vdGhpbmcgaXMgZ29pbmcgdG8gY2hhbmdlLiAN
Cj4gPiA+IEZvciBleGFtcGxlIGEgdmFsdWUgd2FzIHdyaXR0ZW4gaW5jb3JyZWN0bHkgYWZ0ZXIg
MXVzLCB0aGUgbG9vcCB3YXMgDQo+ID4gPiBzZXQgdG8gMW1zLCBmdW5jdGlvbiB3aWxsIHJldHVy
biBhZnRlciAxbXMsIHRoaXMgc29sdXRpb24gaXMgbm90IA0KPiA+ID4gb3B0aW1pemVkIGZvciBw
ZXJmb3JtYW5jZS4gSSBjb25zaWRlcmVkIHNhbWUgd2hlbiB3b3JraW5nIG9uIHRoaXMgY2hhbmdl
IGFuZCBkZWNpZGVkIHRvIGRvIGl0IGRpZmZlcmVudCB3YXkuDQo+ID4gDQo+ID4gU2VlbXMgbGlr
ZSB5b3UncmUgcmlnaHQgaWYgd2UgYXNzdW1lIHRoYXQgY2hlY2tpbmcgZm9yIEdPT0Qgc3RhdGUg
ZG9lcyANCj4gPiBub3QgcmVxdWlyZSBhIGRlbGF5IGFmdGVyIHRoZSBSRUFEWSBjaGVjaywgYnV0
IGlmIHRoYXQncyBub3QgdGhlIGNhc2UgDQo+ID4gYW5kIGFuIGV4dHJhIGRlbGF5IGlzIGFjdHVh
bGx5IHJlcXVpcmVkLCB5b3UgbWlnaHQgZW5kIHVwIHdpdGggYSBCQUQgDQo+ID4gc3RhdHVzIHdo
aWxlIGl0IGNvdWxkIGhhdmUgdHVybmVkIEdPT0QgYXQgc29tZSBwb2ludCB3aXRoIHRoZSAnY2hl
Y2sgDQo+ID4gb25seSBmb3IgR09PRCBzdGF0ZSB1bnRpbCB3ZSB0aW1lb3V0JyBhcHByb2FjaC4N
Cj4gPiANCj4gPiBUQkgsIEkgZG9uJ3Qga25vdyBob3cgQ0ZJIGZsYXNoZXMgd29yaywgc28gSSds
bCBsZXQgeW91IGd1eXMgc29ydCB0aGlzIA0KPiA+IG91dC4NCj4gPiANCj4gPiBSZWdhcmRzLA0K
PiA+IA0KPiA+IEJvcmlzDQo+ID4gDQo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fDQo+ID4gTGludXggTVREIGRpc2N1c3Npb24gbWFpbGlu
ZyBsaXN0DQo+ID4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1tdGQvDQo+ID4gDQo+IA0KPg0K
