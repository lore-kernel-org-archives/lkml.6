Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26484C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E302085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E302085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeKFKVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 05:21:15 -0500
Received: from mga14.intel.com ([192.55.52.115]:16753 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbeKFKVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 05:21:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 16:58:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,469,1534834800"; 
   d="scan'208";a="88831271"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga006.jf.intel.com with ESMTP; 05 Nov 2018 16:58:42 -0800
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 5 Nov 2018 16:58:32 -0800
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 5 Nov 2018 16:58:32 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.117]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.161]) with mapi id 14.03.0415.000;
 Tue, 6 Nov 2018 08:58:30 +0800
From:   "He, Bo" <bo.he@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "Singh, Guneshwor O" <guneshwor.o.singh@intel.com>,
        "Periyasamy, SriramX" <sriramx.periyasamy@intel.com>,
        "Kale, Sanyog R" <sanyog.r.kale@intel.com>,
        "Kesapragada, Pardha Saradhi" <pardha.saradhi.kesapragada@intel.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>,
        "Prakash, Divya1" <divya1.prakash@intel.com>,
        "Diwakar, Praveen" <praveen.diwakar@intel.com>,
        "Zhang, Yanmin" <yanmin.zhang@intel.com>
Subject: RE: [alsa-devel] [PATCH] fix the kernel panic due to wrong use the
 dev memory API
Thread-Topic: [alsa-devel] [PATCH] fix the kernel panic due to wrong use the
 dev memory API
Thread-Index: AdR02etIVOQjufWdR9C3OioDFWN13wADD24AACFeYoA=
Date:   Tue, 6 Nov 2018 00:58:30 +0000
Message-ID: <CD6925E8781EFD4D8E11882D20FC406D529FE5A9@SHSMSX104.ccr.corp.intel.com>
References: <CD6925E8781EFD4D8E11882D20FC406D529FE3B6@SHSMSX104.ccr.corp.intel.com>
 <f2e3ffeb-12bd-d60e-e96a-8fa00a17844f@linux.intel.com>
In-Reply-To: <f2e3ffeb-12bd-d60e-e96a-8fa00a17844f@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWVjNzAwZmMtNDg0MS00ZjU0LWE5MmItZjc3NjlkZWM2NTNjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUnFkUGZyMnU0SUxLd1hNNjhwVjVaZkZzRVNSZk1CN25uRzJJUlVoaWhIamE4QVcyWU1sbENSS2hwaVVpYmR3TSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIA0KCUkgc3VibWl0IHRoZSBwYXRjaCBiYXNlZCBvbiB0YWcgdjQuMTkuDQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBQaWVycmUtTG91aXMgQm9zc2FydCA8cGllcnJlLWxv
dWlzLmJvc3NhcnRAbGludXguaW50ZWwuY29tPiANClNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDYs
IDIwMTggMTowMiBBTQ0KVG86IEhlLCBCbyA8Ym8uaGVAaW50ZWwuY29tPjsgYWxzYS1kZXZlbEBh
bHNhLXByb2plY3Qub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpDYzogbGlhbS5y
LmdpcmR3b29kQGxpbnV4LmludGVsLmNvbTsgcGVyZXhAcGVyZXguY3o7IHRpd2FpQHN1c2UuY29t
OyBTaW5naCwgR3VuZXNod29yIE8gPGd1bmVzaHdvci5vLnNpbmdoQGludGVsLmNvbT47IFBlcml5
YXNhbXksIFNyaXJhbVggPHNyaXJhbXgucGVyaXlhc2FteUBpbnRlbC5jb20+OyBLYWxlLCBTYW55
b2cgUiA8c2FueW9nLnIua2FsZUBpbnRlbC5jb20+OyBLZXNhcHJhZ2FkYSwgUGFyZGhhIFNhcmFk
aGkgPHBhcmRoYS5zYXJhZGhpLmtlc2FwcmFnYWRhQGludGVsLmNvbT47IGt1bmlub3JpLm1vcmlt
b3RvLmd4QHJlbmVzYXMuY29tOyBndXJ1cHJhc2FkeC5wYXdzZUBpbnRlbC5jb207IFVnaHJlamEs
IFJha2VzaCBBIDxyYWtlc2guYS51Z2hyZWphQGludGVsLmNvbT47IFByYWthc2gsIERpdnlhMSA8
ZGl2eWExLnByYWthc2hAaW50ZWwuY29tPjsgRGl3YWthciwgUHJhdmVlbiA8cHJhdmVlbi5kaXdh
a2FyQGludGVsLmNvbT47IFpoYW5nLCBZYW5taW4gPHlhbm1pbi56aGFuZ0BpbnRlbC5jb20+DQpT
dWJqZWN0OiBSZTogW2Fsc2EtZGV2ZWxdIFtQQVRDSF0gZml4IHRoZSBrZXJuZWwgcGFuaWMgZHVl
IHRvIHdyb25nIHVzZSB0aGUgZGV2IG1lbW9yeSBBUEkNCg0KDQpPbiAxMS81LzE4IDI6MjkgQU0s
IEhlLCBCbyB3cm90ZToNCj4gc2tsLT5kYWlzIGlzIGFsbG9jYXRlZCB3aXRoIGRldm1fa2NhbGxv
YywgY2FuJ3QgZnJlZSB3aXRoDQo+IHRoZSBrcmVhbGxvYy4gTWVtb3J5IGFsbG9jYXRlZCB3aXRo
IGRldm0gQVBJIGlzIGF1dG9tYXRpY2FsbHkgZnJlZWQgb24gDQo+IGRyaXZlciBkZXRhY2gsIExp
a2UgYWxsIG90aGVyIGRldnJlcyByZXNvdXJjZXMuDQo+DQo+IFJlZmVyIHRvIGRyaXZlcnMvYmFz
ZS9kZXZyZXMuYyBkZXZtX2ttYWxsb2MgZm9yIG1vcmUgZGV0YWlscy4NCg0KV2hhdCBjb2RlIGFy
ZSB5b3UgbG9va2luZyBhdD8NCg0KSSBzZWUgdGhpcyBpbiB0aGUgTWFyaydzIHRyZWUNCg0KaW50
IHNrbF9wbGF0Zm9ybV9yZWdpc3RlcihzdHJ1Y3QgZGV2aWNlICpkZXYpIHsNCiDCoMKgwqAgaW50
IHJldDsNCiDCoMKgwqAgc3RydWN0IHNuZF9zb2NfZGFpX2RyaXZlciAqZGFpczsNCiDCoMKgwqAg
aW50IG51bV9kYWlzID0gQVJSQVlfU0laRShza2xfcGxhdGZvcm1fZGFpKTsNCiDCoMKgwqAgc3Ry
dWN0IGhkYWNfYnVzICpidXMgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCiDCoMKgwqAgc3RydWN0
IHNrbCAqc2tsID0gYnVzX3RvX3NrbChidXMpOw0KDQogwqDCoMKgIElOSVRfTElTVF9IRUFEKCZz
a2wtPnBwbF9saXN0KTsNCiDCoMKgwqAgSU5JVF9MSVNUX0hFQUQoJnNrbC0+YmluZF9saXN0KTsN
Cg0KIMKgwqDCoCBza2wtPmRhaXMgPSBrbWVtZHVwKHNrbF9wbGF0Zm9ybV9kYWksIHNpemVvZihz
a2xfcGxhdGZvcm1fZGFpKSwNCiDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgR0ZQX0tFUk5F
TCk7DQogwqDCoMKgIGlmICghc2tsLT5kYWlzKSB7DQogwqDCoMKgIMKgwqDCoCByZXQgPSAtRU5P
TUVNOw0KIMKgwqDCoCDCoMKgwqAgZ290byBlcnI7DQogwqDCoMKgIH0NCg0KIMKgwqDCoCBpZiAo
IXNrbC0+dXNlX3RwbGdfcGNtKSB7DQogwqDCoMKgIMKgwqDCoCBkYWlzID0ga3JlYWxsb2Moc2ts
LT5kYWlzLCBzaXplb2Yoc2tsX2ZlX2RhaSkgKw0KIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDC
oCBzaXplb2Yoc2tsX3BsYXRmb3JtX2RhaSksIEdGUF9LRVJORUwpOw0KDQoNCk5vIHRyYWNlIG9m
IGRldm0gYXMgeW91IG1lbnRpb24gaXQ/IEkgY2hlY2tlZCB0aGUgQ2hyb21lIHRyZWUgYXMgd2Vs
bCBhbmQgaXQncyBub3QgdGhlcmUuDQoNCldoYXQgYW0gSSBtaXNzaW5nPw0KDQoNCj4NCj4gU2ln
bmVkLW9mZi1ieTogaGUsIGJvIDxiby5oZUBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgIHNvdW5kL3Nv
Yy9pbnRlbC9za3lsYWtlL3NrbC1wY20uYyB8IDUgKystLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvc291bmQv
c29jL2ludGVsL3NreWxha2Uvc2tsLXBjbS5jIA0KPiBiL3NvdW5kL3NvYy9pbnRlbC9za3lsYWtl
L3NrbC1wY20uYw0KPiBpbmRleCA4MjNlMzkxLi45MjhkMzE0IDEwMDY0NA0KPiAtLS0gYS9zb3Vu
ZC9zb2MvaW50ZWwvc2t5bGFrZS9za2wtcGNtLmMNCj4gKysrIGIvc291bmQvc29jL2ludGVsL3Nr
eWxha2Uvc2tsLXBjbS5jDQo+IEBAIC0xNDM4LDcgKzE0MzgsOCBAQCBpbnQgc2tsX3BsYXRmb3Jt
X3JlZ2lzdGVyKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gICAJfQ0KPiAgIA0KPiAgIAlpZiAoIXNr
bC0+dXNlX3RwbGdfcGNtKSB7DQo+IC0JCWRhaXMgPSBrcmVhbGxvYyhza2wtPmRhaXMsIHNpemVv
Zihza2xfZmVfZGFpKSArDQo+ICsJCWRldm1fa2ZyZWUoZGV2LCBza2wtPmRhaXMpOw0KPiArCQlk
YWlzID0gZGV2bV9rY2FsbG9jKGRldiwgc2tsLT5kYWlzLCBzaXplb2Yoc2tsX2ZlX2RhaSkgKw0K
PiAgIAkJCQlzaXplb2Yoc2tsX3BsYXRmb3JtX2RhaSksIEdGUF9LRVJORUwpOw0KPiAgIAkJaWYg
KCFkYWlzKSB7DQo+ICAgCQkJcmV0ID0gLUVOT01FTTsNCj4gQEAgLTE0NzIsNyArMTQ3Myw1IEBA
IGludCBza2xfcGxhdGZvcm1fdW5yZWdpc3RlcihzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAgCQl9
DQo+ICAgCX0NCj4gICANCj4gLQlrZnJlZShza2wtPmRhaXMpOw0KPiAtDQo+ICAgCXJldHVybiAw
Ow0KPiAgIH0NCg==
