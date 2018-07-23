Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD698ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EE320846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63EE320846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387859AbeGWHNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:13:41 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:35192 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbeGWHNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:13:41 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w6N6DrT5006427
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 23 Jul 2018 15:13:53 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6N6DrTq009060;
        Mon, 23 Jul 2018 15:13:53 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6N6DriM032667;
        Mon, 23 Jul 2018 15:13:53 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.149] [10.38.151.149]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-2206790; Mon, 23 Jul 2018 15:11:16 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC21GP.gisp.nec.co.jp ([10.38.151.149]) with mapi id 14.03.0319.002; Mon,
 23 Jul 2018 15:11:15 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     "Zhangfei (Tyler)" <tyler.zhang@huawei.com>
CC:     Xiexiuqi <xiexiuqi@huawei.com>,
        =?utf-8?B?6KOY56iA55+zKOeogOefsyk=?= 
        <xishi.qiuxishi@alibaba-inc.com>, linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "zy.zhengyi" <zy.zhengyi@alibaba-inc.com>,
        lvzhipeng <lvzhipeng@huawei.com>,
        meinanjing <meinanjing@huawei.com>,
        zhongjiang <zhongjiang@huawei.com>,
        Dukaitian <dukaitian@huawei.com>,
        Chenglongfei <chenglongfei@huawei.com>
Subject: Re: [RFC] a question about reuse hwpoison page in
 soft_offline_page()
Thread-Topic: [RFC] a question about reuse hwpoison page in
 soft_offline_page()
Thread-Index: AQHUFNq0gQJXx38HukimJ6uYcXUta6SBQ1eAgBX4twCAABC/AIAEiokA
Date:   Mon, 23 Jul 2018 06:11:14 +0000
Message-ID: <20180723061114.GB26102@hori1.linux.bs1.fc.nec.co.jp>
References: <99235479-716d-4c40-8f61-8e44c242abf8.xishi.qiuxishi@alibaba-inc.com>
 <20180706081847.GA5144@hori1.linux.bs1.fc.nec.co.jp>
 <7f0ff90d-578b-2096-92c0-542a490b06a1@huawei.com>
 <E690DE8F4F207D4EB356CAC7B78E15467E402966@DGGEMA503-MBX.china.huawei.com>
In-Reply-To: <E690DE8F4F207D4EB356CAC7B78E15467E402966@DGGEMA503-MBX.china.huawei.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2755DAE82F59324FA4C63B8967DC17D3@gisp.nec.co.jp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBKdWwgMjAsIDIwMTggYXQgMDg6NTA6MjJBTSArMDAwMCwgWmhhbmdmZWkgKFR5bGVy
KSB3cm90ZToNCj4gSGkgTmFveWEmeGlzaGnvvJoNCj4gCVdlIGhhdmUgYSBzaW1pbGFyIHByb2Js
ZW0sIHRoZSBkaWZmZXJlbmNlIGlzIHRoYXQgd2UgZGlkIG5vdCBFbmFibGUgaHVnZXBhZ2UsIHRo
ZSBzb2Z0LW9mZmxpbmUgd2FzIGV4ZWN1dGVkIGluIHRoZSBjYXNlIG9mIG5vcm1hbCA0SyBwYWdl
cywgYW5kIGZpbmFsbHkgdGhlIE1DRSBraWxsIHdhcyB0cmlnZ2VyZWTvvIhmaW5kIGh3cG9pc29u
IGZsYWcgaXMgYWxyZWFkeSBzZXQtLT5yZXQgPSBWTV9GQVVMVF9IV1BPSVNPTi0tPm1tX2ZhdWx0
X2Vycm9yIC0tPmRvX3NpZ2J1cyAtLT4gbWNlIGtpbGzvvIkuIFdlIG5vdGljZWQgdGhhdCB0aGUg
bmV3IHBhdGNoIG1hZGUgc29tZSBtb2RpZmljYXRpb25zIHRvIHRoZSBjYXNlIG9mIGh1Z2UgcGFn
ZSBvZmZsaW5lLCBCdXQgaG93IGNhbiB3ZSBhdm9pZCB0aGlzIHJhY2UgY29uZGl0aW9uIGZvciB0
aGUgY2FzZSBvZiBub3JtYWwgcGFnZT8NCg0KSGkgVHlsZXIsDQoNCkxhdGVzdCB2ZXJzaW9uIG9m
IHRoZSBmaXggaXMgYXZhaWxhYmxlIG9uIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE4LzcvMTcv
NjAuDQpJJ20gc3RpbGwgZGlzY3Vzc2luZyB3aXRoIE1pY2hhbCBhYm91dCBiZXR0ZXIgZGVzaWdu
IG9mIHRoaXMgYXJlYSwgYnV0DQpJIHRoaW5rIHdlJ2xsIGdvIHdpdGggdGhpcyBmb3Igc2hvcnQg
dGVybSBmaXguDQoNClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ0KDQo+IA0KPiAtLS0tLemCruS7
tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogWGlleGl1cWkgDQo+IOWPkemAgeaXtumXtDogMjAx
OOW5tDfmnIgyMOaXpSAxNTo1MA0KPiDmlLbku7bkuro6IE5hb3lhIEhvcmlndWNoaSA8bi1ob3Jp
Z3VjaGlAYWguanAubmVjLmNvbT47IOijmOeogOefsyjnqIDnn7MpIDx4aXNoaS5xaXV4aXNoaUBh
bGliYWJhLWluYy5jb20+DQo+IOaKhOmAgTogbGludXgtbW0gPGxpbnV4LW1tQGt2YWNrLm9yZz47
IGxpbnV4LWtlcm5lbCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IHp5LnpoZW5neWkg
PHp5LnpoZW5neWlAYWxpYmFiYS1pbmMuY29tPjsgWmhhbmdmZWkgKFR5bGVyKSA8dHlsZXIuemhh
bmdAaHVhd2VpLmNvbT47IGx2emhpcGVuZyA8bHZ6aGlwZW5nQGh1YXdlaS5jb20+OyBtZWluYW5q
aW5nIDxtZWluYW5qaW5nQGh1YXdlaS5jb20+OyB6aG9uZ2ppYW5nIDx6aG9uZ2ppYW5nQGh1YXdl
aS5jb20+DQo+IOS4u+mimDogUmU6IFtSRkNdIGEgcXVlc3Rpb24gYWJvdXQgcmV1c2UgaHdwb2lz
b24gcGFnZSBpbiBzb2Z0X29mZmxpbmVfcGFnZSgpDQo+IA0KPiBIaSBOYW95YSwgWGlzaGksDQo+
IA0KPiBXZSBoYXZlIGEgc2ltaWxhciBwcm9ibGVtLg0KPiBAemhhbmdmZWksIGNvdWxkIHlvdSBw
bGVhc2UgZGVzY3JpYmUgeW91ciBwcm9ibGVtIGhlcmUuDQo+IA0KPiBPbiAyMDE4LzcvNiAxNjox
OCwgTmFveWEgSG9yaWd1Y2hpIHdyb3RlOg0KPiA+IE9uIEZyaSwgSnVsIDA2LCAyMDE4IGF0IDEx
OjM3OjQxQU0gKzA4MDAsIOijmOeogOefsyjnqIDnn7MpIHdyb3RlOg0KPiA+PiBUaGlzIHBhdGNo
IGFkZDA1Y2VjDQo+ID4+IChtbTogc29mdC1vZmZsaW5lOiBkb24ndCBmcmVlIHRhcmdldCBwYWdl
IGluIHN1Y2Nlc3NmdWwgcGFnZSANCj4gPj4gbWlncmF0aW9uKSByZW1vdmVzDQo+ID4+IHNldF9t
aWdyYXRldHlwZV9pc29sYXRlKCkgYW5kIHVuc2V0X21pZ3JhdGV0eXBlX2lzb2xhdGUoKSBpbiAN
Cj4gPj4gc29mdF9vZmZsaW5lX3BhZ2UgKCkuDQo+ID4+DQo+ID4+IEFuZCB0aGlzIHBhdGNoIDI0
M2FiZDViDQo+ID4+IChtbTogaHVnZXRsYjogcHJldmVudCByZXVzZSBvZiBod3BvaXNvbmVkIGZy
ZWUgaHVnZXBhZ2VzKSBjaGFuZ2VzIGlmIA0KPiA+PiAoIWlzX21pZ3JhdGVfaXNvbGF0ZV9wYWdl
KHBhZ2UpKSB0byBpZiAoIVBhZ2VIV1BvaXNvbihwYWdlKSksIHNvIGl0IA0KPiA+PiBjb3VsZCBw
cmV2ZW50IHNvbWVvbmUgcmV1c2UgdGhlIGZyZWUgaHVnZXRsYiBhZ2FpbiBhZnRlciBzZXQgdGhl
IA0KPiA+PiBod3BvaXNvbiBmbGFnIGluIHNvZnRfb2ZmbGluZV9mcmVlX3BhZ2UoKQ0KPiA+Pg0K
PiA+PiBNeSBxdWVzdGlvbiBpcyB0aGF0IGlmIHNvbWVvbmUgcmV1c2UgdGhlIGZyZWUgaHVnZXRs
YiBhZ2FpbiBiZWZvcmUNCj4gPj4gc29mdF9vZmZsaW5lX2ZyZWVfcGFnZSgpIGFuZA0KPiA+PiBh
ZnRlciBnZXRfYW55X3BhZ2UoKSwgdGhlbiBpdCB1c2VzIHRoZSBob3BvaXNvbiBwYWdlLCBhbmQg
dGhpcyBtYXkgDQo+ID4+IHRyaWdnZXIgbWNlIGtpbGwgbGF0ZXIsIHJpZ2h0Pw0KPiA+IA0KPiA+
IEhpIFhpc2hpLA0KPiA+IA0KPiA+IFRoYW5rIHlvdSBmb3IgcG9pbnRpbmcgb3V0IHRoZSBpc3N1
ZS4gVGhhdCdzIG5pY2UgY2F0Y2guDQo+ID4gDQo+ID4gSSB0aGluayB0aGF0IHRoZSByYWNlIGNv
bmRpdGlvbiBpdHNlbGYgY291bGQgaGFwcGVuLCBidXQgaXQgZG9lc24ndCANCj4gPiBsZWFkIHRv
IE1DRSBraWxsIGJlY2F1c2UgUGFnZUhXUG9pc29uIGlzIG5vdCB2aXNpYmxlIHRvIEhXIHdoaWNo
IHRyaWdnZXJzIE1DRS4NCj4gPiBQYWdlSFdQb2lzb24gZmxhZyBpcyBqdXN0IGEgZmxhZyBpbiBz
dHJ1Y3QgcGFnZSB0byByZXBvcnQgdGhlIG1lbW9yeSANCj4gPiBlcnJvciBmcm9tIGtlcm5lbCB0
byB1c2Vyc3BhY2UuIFNvIGV2ZW4gaWYgYSBDUFUgaXMgYWNjZXNzaW5nIHRvIHRoZSANCj4gPiBw
YWdlIHdob3NlIHN0cnVjdCBwYWdlIGhhcyBQYWdlSFdQb2lzb24gc2V0LCB0aGF0IGRvZXNuJ3Qg
Y2F1c2UgYSBNQ0UgDQo+ID4gdW5sZXNzIHRoZSBwYWdlIGlzIHBoeXNpY2FsbHkgYnJva2VuLg0K
PiA+IFRoZSB0eXBlIG9mIG1lbW9yeSBlcnJvciB0aGF0IHNvZnQgb2ZmbGluZSB0cmllcyB0byBo
YW5kbGUgaXMgDQo+ID4gY29ycmVjdGVkIG9uZSB3aGljaCBpcyBub3QgYSBmYWlsdXJlIHlldCBh
bHRob3VnaCBpdCdzIHN0YXJ0aW5nIHRvIHdlYXIuDQo+ID4gU28gc3VjaCBQYWdlSFdQb2lzb24g
cGFnZSBjYW4gYmUgcmV1c2VkLCBidXQgdGhhdCdzIG5vdCBjcml0aWNhbCANCj4gPiBiZWNhdXNl
IHRoZSBwYWdlIGlzIGZyZWVkIGF0IHNvbWUgcG9pbnQgYWZ0ZXJ3b3JkIGFuZCBlcnJvciBjb250
YWlubWVudCBjb21wbGV0ZXMuDQo+ID4gDQo+ID4gSG93ZXZlciwgSSBub3RpY2VkIHRoYXQgdGhl
cmUncyBhIHNtYWxsIHBhaW4gaW4gZnJlZSBodWdldGxiIGNhc2UuDQo+ID4gV2UgY2FsbCBkaXNz
b2x2ZV9mcmVlX2h1Z2VfcGFnZSgpIGluIHNvZnRfb2ZmbGluZV9mcmVlX3BhZ2UoKSB3aGljaCAN
Cj4gPiBtb3ZlcyB0aGUgUGFnZUhXUG9pc29uIGZsYWcgZnJvbSB0aGUgaGVhZCBwYWdlIHRvIHRo
ZSByYXcgZXJyb3IgcGFnZS4NCj4gPiBJZiB0aGUgcmVwb3J0ZWQgcmFjZSBoYXBwZW5zLCBkaXNz
b2x2ZV9mcmVlX2h1Z2VfcGFnZSgpIGp1c3QgcmV0dXJuIA0KPiA+IHdpdGhvdXQgZG9pbmcgYW55
IGRpc3NvbHZlIHdvcmsgYmVjYXVzZSAiaWYgKFBhZ2VIdWdlKHBhZ2UpICYmICFwYWdlX2NvdW50
KHBhZ2UpKSINCj4gPiBibG9jayBpcyBza2lwcGVkLg0KPiA+IFRoZSBodWdlcGFnZSBpcyBhbGxv
Y2F0ZWQgYW5kIHVzZWQgYXMgdXN1YWwsIGJ1dCB0aGUgY29udGFpbWVudCANCj4gPiBkb2Vzbid0
IGNvbXBsZXRlIGFzIGV4cGVjdGVkIGluIHRoZSBub3JtYWwgcGFnZSwgYmVjYXVzZSANCj4gPiBm
cmVlX2h1Z2VfcGFnZXMoKSBkb2Vzbid0IGNhbGwgZGlzc29sdmVfZnJlZV9odWdlX3BhZ2UoKSBm
b3IgaHdwb2lzb24gDQo+ID4gaHVnZXBhZ2UuIFRoaXMgaXMgbm90IGNyaXRpY2FsIGJlY2F1c2Ug
c3VjaCBlcnJvciBodWdlcGFnZSBqdXN0IHJlc2lkZSANCj4gPiBpbiBmcmVlIGh1Z2VwYWdlIGxp
c3QuIEJ1dCB0aGlzIG1pZ2h0IGxvb2tzIGxpa2UgYSBraW5kIG9mIG1lbW9yeSANCj4gPiBsZWFr
LiBBbmQgZXZlbiB3b3JzZSB3aGVuIGh1Z2VwYWdlIHBvb2wgaXMgc2hyaW5rZWQgYW5kIHRoZSBo
d3BvaXNvbiANCj4gPiBodWdlcGFnZSBpcyBmcmVlZCwgdGhlIFBhZ2VIV1BvaXNvbiBmbGFnIGlz
IHN0aWxsIG9uIHRoZSBoZWFkIHBhZ2Ugd2hpY2ggaXMgdW5saWtlbHkgdG8gYmUgYW4gYWN0dWFs
IGVycm9yIHBhZ2UuDQo+ID4gDQo+ID4gU28gSSB0aGluayB3ZSBuZWVkIGltcHJvdmVtZW50IGhl
cmUsIGhvdyBhYm91dCB0aGUgZml4IGxpa2UgYmVsb3c/DQo+ID4gDQo+ID4gICAobm90IHRlc3Rl
ZCB5ZXQsIHNvcnJ5KQ0KPiA+IA0KPiA+ICAgZGlmZiAtLWdpdCBhL21tL21lbW9yeS1mYWlsdXJl
LmMgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+ID4gICAtLS0gYS9tbS9tZW1vcnktZmFpbHVyZS5j
DQo+ID4gICArKysgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+ID4gICBAQCAtMTg4Myw2ICsxODgz
LDExIEBAIHN0YXRpYyB2b2lkIHNvZnRfb2ZmbGluZV9mcmVlX3BhZ2Uoc3RydWN0IHBhZ2UgKnBh
Z2UpDQo+ID4gICAgICAgICAgIHN0cnVjdCBwYWdlICpoZWFkID0gY29tcG91bmRfaGVhZChwYWdl
KTsNCj4gPiAgIA0KPiA+ICAgICAgICAgICBpZiAoIVRlc3RTZXRQYWdlSFdQb2lzb24oaGVhZCkp
IHsNCj4gPiAgICsgICAgICAgICAgICAgICBpZiAocGFnZV9jb3VudChoZWFkKSkgew0KPiA+ICAg
KyAgICAgICAgICAgICAgICAgICAgICAgQ2xlYXJQYWdlSFdQb2lzb24oaGVhZCk7DQo+ID4gICAr
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm47DQo+ID4gICArICAgICAgICAgICAgICAgfQ0K
PiA+ICAgKw0KPiA+ICAgICAgICAgICAgICAgICAgIG51bV9wb2lzb25lZF9wYWdlc19pbmMoKTsN
Cj4gPiAgICAgICAgICAgICAgICAgICBpZiAoUGFnZUh1Z2UoaGVhZCkpDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICBkaXNzb2x2ZV9mcmVlX2h1Z2VfcGFnZShwYWdlKTsNCj4gPiANCj4g
PiBUaGFua3MsDQo+ID4gTmFveWEgSG9yaWd1Y2hpDQo+ID4gDQo+ID4gLg0KPiA+IA0KPiANCj4g
LS0NCj4gVGhhbmtzLA0KPiBYaWUgWGl1UWkNCj4g

