Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D041C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CF82086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36CF82086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbeLLVF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:05:56 -0500
Received: from mga17.intel.com ([192.55.52.151]:18502 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbeLLVFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:05:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 13:05:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,346,1539673200"; 
   d="scan'208";a="129428295"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga001.fm.intel.com with ESMTP; 12 Dec 2018 13:05:54 -0800
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 12 Dec 2018 13:05:53 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.201]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.59]) with mapi id 14.03.0415.000;
 Wed, 12 Dec 2018 13:05:54 -0800
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "namit@vmware.com" <namit@vmware.com>
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
        "luto@kernel.org" <luto@kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH v2 4/4] x86/vmalloc: Add TLB efficient x86 arch_vunmap
Thread-Topic: [PATCH v2 4/4] x86/vmalloc: Add TLB efficient x86 arch_vunmap
Thread-Index: AQHUka9VmI2GbxLPYkikWk5dmdm9D6V7KzcAgAD0YQA=
Date:   Wed, 12 Dec 2018 21:05:52 +0000
Message-ID: <2604df8fb817d8f0c38f572f4fb184db36554bed.camel@intel.com>
References: <20181212000354.31955-1-rick.p.edgecombe@intel.com>
         <20181212000354.31955-5-rick.p.edgecombe@intel.com>
         <90B10050-0CF1-48B2-B671-508FB092C2FE@vmware.com>
In-Reply-To: <90B10050-0CF1-48B2-B671-508FB092C2FE@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.141]
Content-Type: text/plain; charset="utf-8"
Content-ID: <792665CDB5A0EF4E8075F61D4024023D@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTEyLTEyIGF0IDA2OjMwICswMDAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPiA+
IE9uIERlYyAxMSwgMjAxOCwgYXQgNDowMyBQTSwgUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdl
Y29tYmVAaW50ZWwuY29tPg0KPiA+IHdyb3RlOg0KPiA+IA0KPiA+IFRoaXMgYWRkcyBhIG1vcmUg
ZWZmaWNpZW50IHg4NiBhcmNoaXRlY3R1cmUgc3BlY2lmaWMgaW1wbGVtZW50YXRpb24gb2YNCj4g
PiBhcmNoX3Z1bm1hcCwgdGhhdCBjYW4gZnJlZSBhbnkgdHlwZSBvZiBzcGVjaWFsIHBlcm1pc3Np
b24gbWVtb3J5IHdpdGggb25seSAxDQo+ID4gVExCDQo+ID4gZmx1c2guDQo+ID4gDQo+ID4gSW4g
b3JkZXIgdG8gZW5hYmxlIHRoaXMsIF9zZXRfcGFnZXNfcCBhbmQgX3NldF9wYWdlc19ucCBhcmUg
bWFkZSBub24tc3RhdGljDQo+ID4gYW5kDQo+ID4gcmVuYW1lZCBzZXRfcGFnZXNfcF9ub2ZsdXNo
IGFuZCBzZXRfcGFnZXNfbnBfbm9mbHVzaCB0byBiZXR0ZXIgY29tbXVuaWNhdGUNCj4gPiB0aGVp
ciBkaWZmZXJlbnQgKG5vbi1mbHVzaGluZykgYmVoYXZpb3IgZnJvbSB0aGUgcmVzdCBvZiB0aGUg
c2V0X3BhZ2VzXyoNCj4gPiBmdW5jdGlvbnMuDQo+ID4gDQo+ID4gVGhlIG1ldGhvZCBmb3IgZG9p
bmcgdGhpcyB3aXRoIG9ubHkgMSBUTEIgZmx1c2ggd2FzIHN1Z2dlc3RlZCBieSBBbmR5DQo+ID4g
THV0b21pcnNraS4NCj4gPiANCj4gDQo+IFtzbmlwXQ0KPiANCj4gPiArCS8qDQo+ID4gKwkgKiBJ
ZiB0aGUgdm0gYmVpbmcgZnJlZWQgaGFzIHNlY3VyaXR5IHNlbnNpdGl2ZSBjYXBhYmlsaXRpZXMg
c3VjaCBhcw0KPiA+ICsJICogZXhlY3V0YWJsZSB3ZSBuZWVkIHRvIG1ha2Ugc3VyZSB0aGVyZSBp
cyBubyBXIHdpbmRvdyBvbiB0aGUgZGlyZWN0bWFwDQo+ID4gKwkgKiBiZWZvcmUgcmVtb3Zpbmcg
dGhlIFggaW4gdGhlIFRMQi4gU28gd2Ugc2V0IG5vdCBwcmVzZW50IGZpcnN0IHNvIHdlDQo+ID4g
KwkgKiBjYW4gZmx1c2ggd2l0aG91dCBhbnkgb3RoZXIgQ1BVIHBpY2tpbmcgdXAgdGhlIG1hcHBp
bmcuIFRoZW4gd2UgcmVzZXQNCj4gPiArCSAqIFJXK1Agd2l0aG91dCBhIGZsdXNoLCBzaW5jZSBO
UCBwcmV2ZW50ZWQgaXQgZnJvbSBiZWluZyBjYWNoZWQgYnkNCj4gPiArCSAqIG90aGVyIGNwdXMu
DQo+ID4gKwkgKi8NCj4gPiArCXNldF9hcmVhX2RpcmVjdF9ucChhcmVhKTsNCj4gPiArCXZtX3Vu
bWFwX2FsaWFzZXMoKTsNCj4gDQo+IERvZXMgdm1fdW5tYXBfYWxpYXNlcygpIGZsdXNoIGluIHRo
ZSBUTEIgdGhlIGRpcmVjdCBtYXBwaW5nIHJhbmdlIGFzIHdlbGw/IEkNCj4gY2FuIG9ubHkgZmlu
ZCB0aGUgZmx1c2ggb2YgdGhlIHZtYWxsb2MgcmFuZ2UuDQpIbW1tLiBJdCBzaG91bGQgdXN1YWxs
eSAoSSB0ZXN0ZWQpLCBidXQgbm93IEkgd29uZGVyIGlmIHRoZXJlIGFyZSBjYXNlcyB3aGVyZSBp
dA0KZG9lc24ndCBhbmQgaXQgY291bGQgZGVwZW5kIG9uIGFyY2hpdGVjdHVyZSBhcyB3ZWxsLiBJ
J2xsIGhhdmUgdG8gdHJhY2UgdGhyb3VnaA0KdGhpcyB0byB2ZXJpZnksIHRoYW5rcy4NCg0KUmlj
aw0K
