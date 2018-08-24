Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24669C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D8A2156F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D8A2156F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeHXGwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 02:52:04 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:58616 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbeHXGwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 02:52:03 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w7O3J4De027836
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 24 Aug 2018 12:19:04 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w7O3J4jT011273;
        Fri, 24 Aug 2018 12:19:04 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w7O3GDw4015036;
        Fri, 24 Aug 2018 12:19:04 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.150] [10.38.151.150]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-3059256; Fri, 24 Aug 2018 12:07:48 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC22GP.gisp.nec.co.jp ([10.38.151.150]) with mapi id 14.03.0319.002; Fri,
 24 Aug 2018 12:07:47 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 2/2] hugetlb: take PMD sharing into account when
 flushing tlb/caches
Thread-Topic: [PATCH v6 2/2] hugetlb: take PMD sharing into account when
 flushing tlb/caches
Thread-Index: AQHUOyQv6R9b9uYZwUSRXzYdhrQW+aTNohsA
Date:   Fri, 24 Aug 2018 03:07:46 +0000
Message-ID: <20180824030746.GB31674@hori1.linux.bs1.fc.nec.co.jp>
References: <20180823205917.16297-1-mike.kravetz@oracle.com>
 <20180823205917.16297-3-mike.kravetz@oracle.com>
In-Reply-To: <20180823205917.16297-3-mike.kravetz@oracle.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2903778B9322834B827AAA90D5EF011D@gisp.nec.co.jp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBBdWcgMjMsIDIwMTggYXQgMDE6NTk6MTdQTSAtMDcwMCwgTWlrZSBLcmF2ZXR6IHdy
b3RlOg0KPiBXaGVuIGZpeGluZyBhbiBpc3N1ZSB3aXRoIFBNRCBzaGFyaW5nIGFuZCBtaWdyYXRp
b24sIGl0IHdhcyBkaXNjb3ZlcmVkDQo+IHZpYSBjb2RlIGluc3BlY3Rpb24gdGhhdCBvdGhlciBj
YWxsZXJzIG9mIGh1Z2VfcG1kX3Vuc2hhcmUgcG90ZW50aWFsbHkNCj4gaGF2ZSBhbiBpc3N1ZSB3
aXRoIGNhY2hlIGFuZCB0bGIgZmx1c2hpbmcuDQo+IA0KPiBVc2UgdGhlIHJvdXRpbmUgYWRqdXN0
X3JhbmdlX2lmX3BtZF9zaGFyaW5nX3Bvc3NpYmxlKCkgdG8gY2FsY3VsYXRlDQo+IHdvcnN0IGNh
c2UgcmFuZ2VzIGZvciBtbXUgbm90aWZpZXJzLiAgRW5zdXJlIHRoYXQgdGhpcyByYW5nZSBpcyBm
bHVzaGVkDQo+IGlmIGh1Z2VfcG1kX3Vuc2hhcmUgc3VjY2VlZHMgYW5kIHVubWFwcyBhIFBVRF9T
VVpFIGFyZWEuDQoNCnMvUFVEX1NVWkUvUFVEX1NJWkUvDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IE1pa2UgS3JhdmV0eiA8bWlrZS5rcmF2ZXR6QG9yYWNsZS5jb20+DQoNCkxvb2tzIGdvb2QgdG8g
bWUuDQoNClJldmlld2VkLWJ5OiBOYW95YSBIb3JpZ3VjaGkgPG4taG9yaWd1Y2hpQGFoLmpwLm5l
Yy5jb20+DQoNCj4gLS0tDQo+ICBtbS9odWdldGxiLmMgfCA1MyArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNDQg
aW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tbS9odWdl
dGxiLmMgYi9tbS9odWdldGxiLmMNCj4gaW5kZXggYTczYzU3MjhlOTYxLi4wODJjZGRmNDZiNGYg
MTAwNjQ0DQo+IC0tLSBhL21tL2h1Z2V0bGIuYw0KPiArKysgYi9tbS9odWdldGxiLmMNCj4gQEAg
LTMzMzMsOCArMzMzMyw4IEBAIHZvaWQgX191bm1hcF9odWdlcGFnZV9yYW5nZShzdHJ1Y3QgbW11
X2dhdGhlciAqdGxiLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwNCj4gIAlzdHJ1Y3QgcGFn
ZSAqcGFnZTsNCj4gIAlzdHJ1Y3QgaHN0YXRlICpoID0gaHN0YXRlX3ZtYSh2bWEpOw0KPiAgCXVu
c2lnbmVkIGxvbmcgc3ogPSBodWdlX3BhZ2Vfc2l6ZShoKTsNCj4gLQljb25zdCB1bnNpZ25lZCBs
b25nIG1tdW5fc3RhcnQgPSBzdGFydDsJLyogRm9yIG1tdV9ub3RpZmllcnMgKi8NCj4gLQljb25z
dCB1bnNpZ25lZCBsb25nIG1tdW5fZW5kICAgPSBlbmQ7CS8qIEZvciBtbXVfbm90aWZpZXJzICov
DQo+ICsJdW5zaWduZWQgbG9uZyBtbXVuX3N0YXJ0ID0gc3RhcnQ7CS8qIEZvciBtbXVfbm90aWZp
ZXJzICovDQo+ICsJdW5zaWduZWQgbG9uZyBtbXVuX2VuZCAgID0gZW5kOwkJLyogRm9yIG1tdV9u
b3RpZmllcnMgKi8NCj4gIA0KPiAgCVdBUk5fT04oIWlzX3ZtX2h1Z2V0bGJfcGFnZSh2bWEpKTsN
Cj4gIAlCVUdfT04oc3RhcnQgJiB+aHVnZV9wYWdlX21hc2soaCkpOw0KPiBAQCAtMzM0Niw2ICsz
MzQ2LDExIEBAIHZvaWQgX191bm1hcF9odWdlcGFnZV9yYW5nZShzdHJ1Y3QgbW11X2dhdGhlciAq
dGxiLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwNCj4gIAkgKi8NCj4gIAl0bGJfcmVtb3Zl
X2NoZWNrX3BhZ2Vfc2l6ZV9jaGFuZ2UodGxiLCBzeik7DQo+ICAJdGxiX3N0YXJ0X3ZtYSh0bGIs
IHZtYSk7DQo+ICsNCj4gKwkvKg0KPiArCSAqIElmIHNoYXJpbmcgcG9zc2libGUsIGFsZXJ0IG1t
dSBub3RpZmllcnMgb2Ygd29yc3QgY2FzZS4NCj4gKwkgKi8NCj4gKwlhZGp1c3RfcmFuZ2VfaWZf
cG1kX3NoYXJpbmdfcG9zc2libGUodm1hLCAmbW11bl9zdGFydCwgJm1tdW5fZW5kKTsNCj4gIAlt
bXVfbm90aWZpZXJfaW52YWxpZGF0ZV9yYW5nZV9zdGFydChtbSwgbW11bl9zdGFydCwgbW11bl9l
bmQpOw0KPiAgCWFkZHJlc3MgPSBzdGFydDsNCj4gIAlmb3IgKDsgYWRkcmVzcyA8IGVuZDsgYWRk
cmVzcyArPSBzeikgew0KPiBAQCAtMzM1Niw2ICszMzYxLDEwIEBAIHZvaWQgX191bm1hcF9odWdl
cGFnZV9yYW5nZShzdHJ1Y3QgbW11X2dhdGhlciAqdGxiLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3Qg
KnZtYSwNCj4gIAkJcHRsID0gaHVnZV9wdGVfbG9jayhoLCBtbSwgcHRlcCk7DQo+ICAJCWlmICho
dWdlX3BtZF91bnNoYXJlKG1tLCAmYWRkcmVzcywgcHRlcCkpIHsNCj4gIAkJCXNwaW5fdW5sb2Nr
KHB0bCk7DQo+ICsJCQkvKg0KPiArCQkJICogV2UganVzdCB1bm1hcHBlZCBhIHBhZ2Ugb2YgUE1E
cyBieSBjbGVhcmluZyBhIFBVRC4NCj4gKwkJCSAqIFRoZSBjYWxsZXIncyBUTEIgZmx1c2ggcmFu
Z2Ugc2hvdWxkIGNvdmVyIHRoaXMgYXJlYS4NCj4gKwkJCSAqLw0KPiAgCQkJY29udGludWU7DQo+
ICAJCX0NCj4gIA0KPiBAQCAtMzQzOCwxMiArMzQ0NywyMyBAQCB2b2lkIHVubWFwX2h1Z2VwYWdl
X3JhbmdlKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25lZCBsb25nIHN0YXJ0LA0K
PiAgew0KPiAgCXN0cnVjdCBtbV9zdHJ1Y3QgKm1tOw0KPiAgCXN0cnVjdCBtbXVfZ2F0aGVyIHRs
YjsNCj4gKwl1bnNpZ25lZCBsb25nIHRsYl9zdGFydCA9IHN0YXJ0Ow0KPiArCXVuc2lnbmVkIGxv
bmcgdGxiX2VuZCA9IGVuZDsNCj4gKw0KPiArCS8qDQo+ICsJICogSWYgc2hhcmVkIFBNRHMgd2Vy
ZSBwb3NzaWJseSB1c2VkIHdpdGhpbiB0aGlzIHZtYSByYW5nZSwgYWRqdXN0DQo+ICsJICogc3Rh
cnQvZW5kIGZvciB3b3JzdCBjYXNlIHRsYiBmbHVzaGluZy4NCj4gKwkgKiBOb3RlIHRoYXQgd2Ug
Y2FuIG5vdCBiZSBzdXJlIGlmIFBNRHMgYXJlIHNoYXJlZCB1bnRpbCB3ZSB0cnkgdG8NCj4gKwkg
KiB1bm1hcCBwYWdlcy4gIEhvd2V2ZXIsIHdlIHdhbnQgdG8gbWFrZSBzdXJlIFRMQiBmbHVzaGlu
ZyBjb3ZlcnMNCj4gKwkgKiB0aGUgbGFyZ2VzdCBwb3NzaWJsZSByYW5nZS4NCj4gKwkgKi8NCj4g
KwlhZGp1c3RfcmFuZ2VfaWZfcG1kX3NoYXJpbmdfcG9zc2libGUodm1hLCAmdGxiX3N0YXJ0LCAm
dGxiX2VuZCk7DQo+ICANCj4gIAltbSA9IHZtYS0+dm1fbW07DQo+ICANCj4gLQl0bGJfZ2F0aGVy
X21tdSgmdGxiLCBtbSwgc3RhcnQsIGVuZCk7DQo+ICsJdGxiX2dhdGhlcl9tbXUoJnRsYiwgbW0s
IHRsYl9zdGFydCwgdGxiX2VuZCk7DQo+ICAJX191bm1hcF9odWdlcGFnZV9yYW5nZSgmdGxiLCB2
bWEsIHN0YXJ0LCBlbmQsIHJlZl9wYWdlKTsNCj4gLQl0bGJfZmluaXNoX21tdSgmdGxiLCBzdGFy
dCwgZW5kKTsNCj4gKwl0bGJfZmluaXNoX21tdSgmdGxiLCB0bGJfc3RhcnQsIHRsYl9lbmQpOw0K
PiAgfQ0KPiAgDQo+ICAvKg0KPiBAQCAtNDMwOSwxMSArNDMyOSwyMSBAQCB1bnNpZ25lZCBsb25n
IGh1Z2V0bGJfY2hhbmdlX3Byb3RlY3Rpb24oc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsDQo+
ICAJcHRlX3QgcHRlOw0KPiAgCXN0cnVjdCBoc3RhdGUgKmggPSBoc3RhdGVfdm1hKHZtYSk7DQo+
ICAJdW5zaWduZWQgbG9uZyBwYWdlcyA9IDA7DQo+ICsJdW5zaWduZWQgbG9uZyBmX3N0YXJ0ID0g
c3RhcnQ7DQo+ICsJdW5zaWduZWQgbG9uZyBmX2VuZCA9IGVuZDsNCj4gKwlib29sIHNoYXJlZF9w
bWQgPSBmYWxzZTsNCj4gKw0KPiArCS8qDQo+ICsJICogSW4gdGhlIGNhc2Ugb2Ygc2hhcmVkIFBN
RHMsIHRoZSBhcmVhIHRvIGZsdXNoIGNvdWxkIGJlIGJleW9uZA0KPiArCSAqIHN0YXJ0L2VuZC4g
IFNldCBmX3N0YXJ0L2ZfZW5kIHRvIGNvdmVyIHRoZSBtYXhpbXVtIHBvc3NpYmxlDQo+ICsJICog
cmFuZ2UgaWYgUE1EIHNoYXJpbmcgaXMgcG9zc2libGUuDQo+ICsJICovDQo+ICsJYWRqdXN0X3Jh
bmdlX2lmX3BtZF9zaGFyaW5nX3Bvc3NpYmxlKHZtYSwgJmZfc3RhcnQsICZmX2VuZCk7DQo+ICAN
Cj4gIAlCVUdfT04oYWRkcmVzcyA+PSBlbmQpOw0KPiAtCWZsdXNoX2NhY2hlX3JhbmdlKHZtYSwg
YWRkcmVzcywgZW5kKTsNCj4gKwlmbHVzaF9jYWNoZV9yYW5nZSh2bWEsIGZfc3RhcnQsIGZfZW5k
KTsNCj4gIA0KPiAtCW1tdV9ub3RpZmllcl9pbnZhbGlkYXRlX3JhbmdlX3N0YXJ0KG1tLCBzdGFy
dCwgZW5kKTsNCj4gKwltbXVfbm90aWZpZXJfaW52YWxpZGF0ZV9yYW5nZV9zdGFydChtbSwgZl9z
dGFydCwgZl9lbmQpOw0KPiAgCWlfbW1hcF9sb2NrX3dyaXRlKHZtYS0+dm1fZmlsZS0+Zl9tYXBw
aW5nKTsNCj4gIAlmb3IgKDsgYWRkcmVzcyA8IGVuZDsgYWRkcmVzcyArPSBodWdlX3BhZ2Vfc2l6
ZShoKSkgew0KPiAgCQlzcGlubG9ja190ICpwdGw7DQo+IEBAIC00MzI0LDYgKzQzNTQsNyBAQCB1
bnNpZ25lZCBsb25nIGh1Z2V0bGJfY2hhbmdlX3Byb3RlY3Rpb24oc3RydWN0IHZtX2FyZWFfc3Ry
dWN0ICp2bWEsDQo+ICAJCWlmIChodWdlX3BtZF91bnNoYXJlKG1tLCAmYWRkcmVzcywgcHRlcCkp
IHsNCj4gIAkJCXBhZ2VzKys7DQo+ICAJCQlzcGluX3VubG9jayhwdGwpOw0KPiArCQkJc2hhcmVk
X3BtZCA9IHRydWU7DQo+ICAJCQljb250aW51ZTsNCj4gIAkJfQ0KPiAgCQlwdGUgPSBodWdlX3B0
ZXBfZ2V0KHB0ZXApOw0KPiBAQCAtNDM1OSw5ICs0MzkwLDEzIEBAIHVuc2lnbmVkIGxvbmcgaHVn
ZXRsYl9jaGFuZ2VfcHJvdGVjdGlvbihzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwNCj4gIAkg
KiBNdXN0IGZsdXNoIFRMQiBiZWZvcmUgcmVsZWFzaW5nIGlfbW1hcF9yd3NlbTogeDg2J3MgaHVn
ZV9wbWRfdW5zaGFyZQ0KPiAgCSAqIG1heSBoYXZlIGNsZWFyZWQgb3VyIHB1ZCBlbnRyeSBhbmQg
ZG9uZSBwdXRfcGFnZSBvbiB0aGUgcGFnZSB0YWJsZToNCj4gIAkgKiBvbmNlIHdlIHJlbGVhc2Ug
aV9tbWFwX3J3c2VtLCBhbm90aGVyIHRhc2sgY2FuIGRvIHRoZSBmaW5hbCBwdXRfcGFnZQ0KPiAt
CSAqIGFuZCB0aGF0IHBhZ2UgdGFibGUgYmUgcmV1c2VkIGFuZCBmaWxsZWQgd2l0aCBqdW5rLg0K
PiArCSAqIGFuZCB0aGF0IHBhZ2UgdGFibGUgYmUgcmV1c2VkIGFuZCBmaWxsZWQgd2l0aCBqdW5r
LiAgSWYgd2UgYWN0dWFsbHkNCj4gKwkgKiBkaWQgdW5zaGFyZSBhIHBhZ2Ugb2YgcG1kcywgZmx1
c2ggdGhlIHJhbmdlIGNvcnJlc3BvbmRpbmcgdG8gdGhlIHB1ZC4NCj4gIAkgKi8NCj4gLQlmbHVz
aF9odWdldGxiX3RsYl9yYW5nZSh2bWEsIHN0YXJ0LCBlbmQpOw0KPiArCWlmIChzaGFyZWRfcG1k
KQ0KPiArCQlmbHVzaF9odWdldGxiX3RsYl9yYW5nZSh2bWEsIGZfc3RhcnQsIGZfZW5kKTsNCj4g
KwllbHNlDQo+ICsJCWZsdXNoX2h1Z2V0bGJfdGxiX3JhbmdlKHZtYSwgc3RhcnQsIGVuZCk7DQo+
ICAJLyoNCj4gIAkgKiBObyBuZWVkIHRvIGNhbGwgbW11X25vdGlmaWVyX2ludmFsaWRhdGVfcmFu
Z2UoKSB3ZSBhcmUgZG93bmdyYWRpbmcNCj4gIAkgKiBwYWdlIHRhYmxlIHByb3RlY3Rpb24gbm90
IGNoYW5naW5nIGl0IHRvIHBvaW50IHRvIGEgbmV3IHBhZ2UuDQo+IEBAIC00MzY5LDcgKzQ0MDQs
NyBAQCB1bnNpZ25lZCBsb25nIGh1Z2V0bGJfY2hhbmdlX3Byb3RlY3Rpb24oc3RydWN0IHZtX2Fy
ZWFfc3RydWN0ICp2bWEsDQo+ICAJICogU2VlIERvY3VtZW50YXRpb24vdm0vbW11X25vdGlmaWVy
LnJzdA0KPiAgCSAqLw0KPiAgCWlfbW1hcF91bmxvY2tfd3JpdGUodm1hLT52bV9maWxlLT5mX21h
cHBpbmcpOw0KPiAtCW1tdV9ub3RpZmllcl9pbnZhbGlkYXRlX3JhbmdlX2VuZChtbSwgc3RhcnQs
IGVuZCk7DQo+ICsJbW11X25vdGlmaWVyX2ludmFsaWRhdGVfcmFuZ2VfZW5kKG1tLCBmX3N0YXJ0
LCBmX2VuZCk7DQo+ICANCj4gIAlyZXR1cm4gcGFnZXMgPDwgaC0+b3JkZXI7DQo+ICB9DQo+IC0t
IA0KPiAyLjE3LjENCj4gDQo+IA==

