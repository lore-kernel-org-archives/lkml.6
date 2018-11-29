Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3A8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB752081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB752081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbeK2RSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:18:35 -0500
Received: from mga07.intel.com ([134.134.136.100]:3687 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbeK2RSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:18:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 22:14:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,293,1539673200"; 
   d="scan'208";a="93835002"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga007.jf.intel.com with ESMTP; 28 Nov 2018 22:14:21 -0800
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 28 Nov 2018 22:14:21 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.8]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.128]) with mapi id 14.03.0415.000;
 Wed, 28 Nov 2018 22:14:20 -0800
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "luto@kernel.org" <luto@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jannh@google.com" <jannh@google.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH 2/2] x86/modules: Make x86 allocs to flush when free
Thread-Topic: [PATCH 2/2] x86/modules: Make x86 allocs to flush when free
Thread-Index: AQHUhrIVy+5FSQqQvkm6Ovse+HnrpaVmgdmAgABMZYA=
Date:   Thu, 29 Nov 2018 06:14:20 +0000
Message-ID: <c600ff319e37c74cf2c55b06a68e5ab041e12095.camel@intel.com>
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
         <20181128000754.18056-3-rick.p.edgecombe@intel.com>
         <CALCETrU+skBS0r6WtkwwMZJvb3s2vWB-JmDeZtVWV8pOkxKojQ@mail.gmail.com>
In-Reply-To: <CALCETrU+skBS0r6WtkwwMZJvb3s2vWB-JmDeZtVWV8pOkxKojQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.1 (3.30.1-1.fc29) 
x-originating-ip: [10.251.13.193]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B63C153BF433EA41A45FE67461271450@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTExLTI4IGF0IDE3OjQwIC0wODAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6
DQo+ID4gT24gTm92IDI3LCAyMDE4LCBhdCA0OjA3IFBNLCBSaWNrIEVkZ2Vjb21iZSA8DQo+ID4g
cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IENoYW5nZSB0aGUg
bW9kdWxlIGFsbG9jYXRpb25zIHRvIGZsdXNoIGJlZm9yZSBmcmVlaW5nIHRoZSBwYWdlcy4NCj4g
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBp
bnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gYXJjaC94ODYva2VybmVsL21vZHVsZS5jIHwgNCArKy0t
DQo+ID4gMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL21vZHVsZS5jIGIvYXJjaC94ODYv
a2VybmVsL21vZHVsZS5jDQo+ID4gaW5kZXggYjA1MmU4ODNkZDhjLi4xNjk0ZGFmMjU2YjMgMTAw
NjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYva2VybmVsL21vZHVsZS5jDQo+ID4gKysrIGIvYXJjaC94
ODYva2VybmVsL21vZHVsZS5jDQo+ID4gQEAgLTg3LDggKzg3LDggQEAgdm9pZCAqbW9kdWxlX2Fs
bG9jKHVuc2lnbmVkIGxvbmcgc2l6ZSkNCj4gPiAgICBwID0gX192bWFsbG9jX25vZGVfcmFuZ2Uo
c2l6ZSwgTU9EVUxFX0FMSUdOLA0KPiA+ICAgICAgICAgICAgICAgICAgICBNT0RVTEVTX1ZBRERS
ICsgZ2V0X21vZHVsZV9sb2FkX29mZnNldCgpLA0KPiA+ICAgICAgICAgICAgICAgICAgICBNT0RV
TEVTX0VORCwgR0ZQX0tFUk5FTCwNCj4gPiAtICAgICAgICAgICAgICAgICAgICBQQUdFX0tFUk5F
TF9FWEVDLCAwLCBOVU1BX05PX05PREUsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgX19idWls
dGluX3JldHVybl9hZGRyZXNzKDApKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICBQQUdFX0tF
Uk5FTF9FWEVDLCBWTV9JTU1FRElBVEVfVU5NQVAsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
TlVNQV9OT19OT0RFLCBfX2J1aWx0aW5fcmV0dXJuX2FkZHJlc3MoMCkpOw0KPiANCj4gSG1tLiBI
b3cgYXdmdWwgaXMgdGhlIHJlc3VsdGluZyBwZXJmb3JtYW5jZSBmb3IgaGVhdnkgZUJQRg0KPiB1
c2Vycz8gIEnigJltDQo+IHdvbmRlcmluZyBpZiB0aGUgSklUIHdpbGwgbmVlZCBzb21lIGtpbmQg
b2YgY2FjaGUgdG8gcmV1c2UNCj4gYWxsb2NhdGlvbnMuDQpJIHRoaW5rIGl0IHNob3VsZCBoYXZl
IG5vIGVmZmVjdCBmb3IgeDg2IGF0IGxlYXN0LiBPbiBhbGxvY2F0aW9uIHRoZXJlDQppcyBvbmx5
IHRoZSBzZXR0aW5nIG9mIHRoZSBmbGFnLiBGb3IgZnJlZS1pbmcgdGhlcmUgaXMgb2YgY291cnNl
IGEgbmV3DQpUTEIgZmx1c2gsIGJ1dCBpdCBoYXBwZW5zIGluIHdheSB0aGF0IHNob3VsZCByZW1v
dmUgb25lIGVsc2V3aGVyZSBmb3INCkJQRi4NCg0KT24geDg2IHRvZGF5IHRoZXJlIGFyZSBhY3R1
YWxseSBhbHJlYWR5IDMgZmx1c2hlcyBmb3IgdGhlIG9wZXJhdGlvbg0KYXJvdW5kIGEgbW9kdWxl
X2FsbG9jIEpJVCBmcmVlLiBXaGF0J3MgaGFwcGVuaW5nIGlzIHRoZXJlIGFyZSB0d28NCmFsbG9j
YXRpb25zIHRoYXQgYXJlIFJPOiB0aGUgSklUIGFuZCBzb21lIGRhdGEuIFdoZW4gZnJlZWluZywg
Zmlyc3QgdGhlDQpKSVQgaXMgc2V0IFJXLCB0aGVuIHZmcmVlZC4gU28gdGhpcyBjYXVzZXMgMSBU
TEIgZmx1c2ggZnJvbSB0aGUNCnNldF9tZW1vcnlfcncsIGFuZCB0aGVyZSBpcyBub3cgYSBsYXp5
IHZtYXAgYXJlYSBmcm9tIHRoZSB2ZnJlZS4gV2hlbg0KdGhlIGRhdGEgYWxsb2NhdGlvbiBpcyBz
ZXQgdG8gUlcsIHZtX3VubWFwX2FsaWFzZXMoKSBpcyBjYWxsZWQgaW4NCnBhZ2VhdHRyLmM6Y2hh
bmdlX3BhZ2VfYXR0cl9zZXRfY2xyLCBzbyBpdCB3aWxsIGNhdXNlIGEgZmx1c2ggZnJvbQ0KY2xl
YXJpbmcgdGhlIGxhenkgYXJlYSwgdGhlbiB0aGVyZSBpcyB0aGUgdGhpcmQgZmx1c2ggYXMgcGFy
dCBvZiB0aGUNCnBlcm1pc3Npb25zIGNoYW5nZSBsaWtlIHVzdWFsLg0KDQpTaW5jZSBub3cgdGhl
IEpJVCB2ZnJlZSB3aWxsIGNhbGwgdm1fdW5tYXBfYWxpYXNlcygpLCBpdCBzaG91bGQgbm90DQp0
cmlnZ2VyIGEgVExCIGZsdXNoIGluIHRoZSBzZWNvbmQgcGVybWlzc2lvbiBjaGFuZ2UsIHNvIHJl
bWFpbiBhdCAzLg0KPiA+ICAgIGlmIChwICYmIChrYXNhbl9tb2R1bGVfYWxsb2MocCwgc2l6ZSkg
PCAwKSkgew0KPiA+ICAgICAgICB2ZnJlZShwKTsNCj4gPiAgICAgICAgcmV0dXJuIE5VTEw7DQo+
ID4gLS0NCj4gPiAyLjE3LjENCj4gPiANCg==
