Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82D4ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588F320864
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588F320864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbeGQHIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:08:48 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:35157 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeGQHIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:08:47 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w6H6bL3F021805
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Jul 2018 15:37:21 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6H6bLVj020713;
        Tue, 17 Jul 2018 15:37:21 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6H6Y0lH020486;
        Tue, 17 Jul 2018 15:37:21 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.151] [10.38.151.151]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-2033224; Tue, 17 Jul 2018 15:36:21 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC23GP.gisp.nec.co.jp ([10.38.151.151]) with mapi id 14.03.0319.002; Tue,
 17 Jul 2018 15:36:20 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 08/11] mm, memory_failure: Teach memory_failure()
 about dev_pagemap pages
Thread-Topic: [PATCH v5 08/11] mm, memory_failure: Teach memory_failure()
 about dev_pagemap pages
Thread-Index: AQHUE+Ec860aWMEdckiWuyQY9LqbA6SMTxSAgAEFWYCABR3hgA==
Date:   Tue, 17 Jul 2018 06:36:19 +0000
Message-ID: <20180717063619.GB1346@hori1.linux.bs1.fc.nec.co.jp>
References: <153074042316.27838.17319837331947007626.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153074046610.27838.329669845580014251.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180713085241.GA26980@hori1.linux.bs1.fc.nec.co.jp>
 <CAPcyv4jpn_NyBWjvj3s67Y8pvPDu0BODtqNJZQL81ryPeewvwA@mail.gmail.com>
In-Reply-To: <CAPcyv4jpn_NyBWjvj3s67Y8pvPDu0BODtqNJZQL81ryPeewvwA@mail.gmail.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="utf-8"
Content-ID: <143C38EA678153419A92FA737435C1AF@gisp.nec.co.jp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBKdWwgMTMsIDIwMTggYXQgMDU6Mjg6MDVQTSAtMDcwMCwgRGFuIFdpbGxpYW1zIHdy
b3RlOg0KPiBPbiBGcmksIEp1bCAxMywgMjAxOCBhdCAxOjUyIEFNLCBOYW95YSBIb3JpZ3VjaGkN
Cj4gPG4taG9yaWd1Y2hpQGFoLmpwLm5lYy5jb20+IHdyb3RlOg0KPiA+IE9uIFdlZCwgSnVsIDA0
LCAyMDE4IGF0IDAyOjQxOjA2UE0gLTA3MDAsIERhbiBXaWxsaWFtcyB3cm90ZToNCi4uLg0KPiA+
PiArDQo+ID4+ICsgICAgIC8qDQo+ID4+ICsgICAgICAqIFVzZSB0aGlzIGZsYWcgYXMgYW4gaW5k
aWNhdGlvbiB0aGF0IHRoZSBkYXggcGFnZSBoYXMgYmVlbg0KPiA+PiArICAgICAgKiByZW1hcHBl
ZCBVQyB0byBwcmV2ZW50IHNwZWN1bGF0aXZlIGNvbnN1bXB0aW9uIG9mIHBvaXNvbi4NCj4gPj4g
KyAgICAgICovDQo+ID4+ICsgICAgIFNldFBhZ2VIV1BvaXNvbihwYWdlKTsNCj4gPg0KPiA+IFRo
ZSBudW1iZXIgb2YgaHdwb2lzb24gcGFnZXMgaXMgbWFpbnRhaW5lZCBieSBudW1fcG9pc29uZWRf
cGFnZXMsDQo+ID4gc28geW91IGNhbiBjYWxsIG51bV9wb2lzb25lZF9wYWdlc19pbmMoKT8NCj4g
DQo+IEkgZG9uJ3QgdGhpbmsgd2Ugd2FudCB0aGVzZSBwYWdlcyBhY2NvdW50ZWQgaW4gbnVtX3Bv
aXNvbmVkX3BhZ2VzKCkuDQo+IFdlIGhhdmUgdGhlIGJhZGJsb2NrcyBpbmZyYXN0cnVjdHVyZSBp
biBsaWJudmRpbW0gdG8gdHJhY2sgaG93IG1hbnkNCj4gZXJyb3JzIGFuZCB3aGVyZSB0aGV5IGFy
ZSBsb2NhdGVkLCBhbmQgc2luY2UgdGhleSBjYW4gYmUgcmVwYWlyZWQgdmlhDQo+IGRyaXZlciBh
Y3Rpb25zIEkgdGhpbmsgd2Ugc2hvdWxkIHRyYWNrIHRoZW0gc2VwYXJhdGVseS4NCg0KT0suDQoN
Cj4gPiBSZWxhdGVkIHRvIHRoaXMsIEknbSBpbnRlcmVzdGVkIGluIHdoZXRoZXIvaG93IHVucG9p
c29uX3BhZ2UoKSB3b3Jrcw0KPiA+IG9uIGEgaHdwb2lzb25lZCBkZXZfcGFnZW1hcCBwYWdlLg0K
PiANCj4gdW5wb2lzb25fcGFnZSgpIGlzIG9ubHkgdHJpZ2dlcmVkIHZpYSBmcmVlaW5nIHBhZ2Vz
IHRvIHRoZSBwYWdlDQo+IGFsbG9jYXRvciwgYW5kIHRoYXQgbmV2ZXIgaGFwcGVucyBmb3IgZGV2
X3BhZ2VtYXAgLyBaT05FX0RFVklDRSBwYWdlcy4NCg0Kc29ycnksIG15IGJhZCBjb21tZW50Lg0K
SSBtZWFudCB1bnBvaXNvbl9tZW1vcnkoKSBpbiBtbS9tZW1vcnktZmFpbHVyZS5jLCB3aGljaCBp
cyB0cmlnZ2VyZWQNCnZpYSBkZWJ1Z2ZzOmh3cG9pc29uL3VucG9pc29uLXBmbi4gVGhpcyBpbnRl
cmZhY2UgbG9va3MgbGlrZSBiZWxvdw0KDQogIGludCB1bnBvaXNvbl9tZW1vcnkodW5zaWduZWQg
bG9uZyBwZm4pDQogIHsNCiAgICAgICAgICBzdHJ1Y3QgcGFnZSAqcGFnZTsNCiAgICAgICAgICBz
dHJ1Y3QgcGFnZSAqcDsNCiAgICAgICAgICBpbnQgZnJlZWl0ID0gMDsNCiAgICAgICAgICBzdGF0
aWMgREVGSU5FX1JBVEVMSU1JVF9TVEFURSh1bnBvaXNvbl9ycywgREVGQVVMVF9SQVRFTElNSVRf
SU5URVJWQUwsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBERUZB
VUxUX1JBVEVMSU1JVF9CVVJTVCk7DQoNCiAgICAgICAgICBpZiAoIXBmbl92YWxpZChwZm4pKQ0K
ICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTlhJTzsNCg0KICAgICAgICAgIHAgPSBwZm5fdG9f
cGFnZShwZm4pOw0KICAgICAgICAgIHBhZ2UgPSBjb21wb3VuZF9oZWFkKHApOw0KDQogICAgICAg
ICAgaWYgKCFQYWdlSFdQb2lzb24ocCkpIHsNCiAgICAgICAgICAgICAgICAgIHVucG9pc29uX3By
X2luZm8oIlVucG9pc29uOiBQYWdlIHdhcyBhbHJlYWR5IHVucG9pc29uZWQgJSNseFxuIiwNCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGZuLCAmdW5wb2lzb25fcnMpOw0KICAg
ICAgICAgICAgICAgICAgcmV0dXJuIDA7DQogICAgICAgICAgfQ0KICAuLi4NCg0Kc28gSSB0aGlu
ayB0aGF0IHdlIGNhbiBhZGQgaXNfem9uZV9kZXZpY2VfcGFnZSgpIGNoZWNrIGF0IHRoZSBiZWdp
bm5pbmcNCm9mIHRoaXMgZnVuY3Rpb24gdG8gY2FsbCBod3BvaXNvbl9jbGVhcigpIGludHJvZHVj
ZWQgaW4gcGF0Y2ggMTMvMTM/DQpPdGhlcndpc2UgbWF5YmUgY29tcG91bmRfaGVhZCgpIHdpbGwg
Y2F1c2Ugc29tZSBjcml0aWNhbCBpc3N1ZSBsaWtlDQpnZW5lcmFsIHByb3RlY3Rpb24gZmF1bHQu
DQoNClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ==

