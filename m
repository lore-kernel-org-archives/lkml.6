Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63935C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B6B2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B6B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbeIFWKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:10:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:34442 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727750AbeIFWKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:10:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 10:34:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,339,1531810800"; 
   d="scan'208";a="89565730"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga002.jf.intel.com with ESMTP; 06 Sep 2018 10:34:19 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.8]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.41]) with mapi id 14.03.0319.002;
 Thu, 6 Sep 2018 10:34:19 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Al Stone <astone@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>
Subject: RE: [PATCH V3 3/5] x86/efi: Permanently save the EFI_MEMORY_MAP
 passed by the firmware
Thread-Topic: [PATCH V3 3/5] x86/efi: Permanently save the EFI_MEMORY_MAP
 passed by the firmware
Thread-Index: AQHURJyf1WeGTnU9cEeZIow9NYkj4KTiE9aAgAAIFYCAAAH+AIAAAJ8A///NBfCAAcKRAP//0++Q
Date:   Thu, 6 Sep 2018 17:34:18 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F485B9F59@ORSMSX114.amr.corp.intel.com>
References: <1536099149-12564-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1536099149-12564-4-git-send-email-sai.praneeth.prakhya@intel.com>
 <CAKv+Gu9mfWYww49OmBETutSsaTDfE6VFJjbf+LWAoXF=mNmDBA@mail.gmail.com>
 <20180905125645.GX24082@hirez.programming.kicks-ass.net>
 <CAKv+Gu_DC=+7_YmDGGJ9fYJkGSNbUK-eXOAGMuZ2B7XXPWvZ9g@mail.gmail.com>
 <alpine.DEB.2.21.1809051505030.1416@nanos.tec.linutronix.de>
 <FFF73D592F13FD46B8700F0A279B802F485B9A69@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu91Dh3VN2VBhjX0UjpP2uSaprobeSCPvYA_GxxaKe2K4Q@mail.gmail.com>
In-Reply-To: <CAKv+Gu91Dh3VN2VBhjX0UjpP2uSaprobeSCPvYA_GxxaKe2K4Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjVkNDc2NzAtMTk4Ny00N2Y4LTlhZWItNDljZGIxZTE1N2VjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiXC9hUGVSVnpJY0x3NStiYkVGSUdTenNSS2NEN1wvS1hycHhmREdMdFBNVzZDM2dOY056RGxYNVVVZTZZNVBabzAxIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+PiBJIGFncmVlLiBLZWVwIGl0IHNpbXBsZS4gSWYgdGhlIEVGSSBjcmFwIGZhaWxzLCB0aGVu
IGFzc2lzdCB3aXRoIHRoZQ0KPiA+PiByZWJvb3QgYW5kIG90aGVyd2lzZSBqdXN0IGtpbGwgaXQu
DQo+ID4NCj4gPiBUaGUgcmVhc29ucyBmb3Igc2F2aW5nIG9sZCBtZW1vcnkgbWFwIGFyZSAoaW4g
bXkgdmlldywgdGhlc2UgYXJlIHRoZQ0KPiA+IGxlc3MgaW1wb3J0YW50IG9uZXMgYmVjYXVzZSB0
aGV5IGFyZSB2ZXJ5IHVubGlrZWx5IHRvIGhhcHBlbikNCj4gPg0KPiA+IDEuIE1ha2Ugc3VyZSB0
aGF0IGEgbWVtb3J5IGRlc2NyaXB0b3IgZXhpc3RzIGZvciB0aGUgcGh5c2ljYWwgYWRkcmVzcw0K
PiA+IHRoYXQgd2FzIGZhdWx0ZWQgb24gKEVGSSBNZW1vcnkgTWFwIGNvdWxkIHNvbWV0aW1lIGhh
dmUgaG9sZXMpLg0KPiA+IEFzc3VtaW5nIGEgY2FzZSB0aGF0IHRoZSBwaHlzaWNhbCBhZGRyZXNz
IHRoYXQgY2F1c2VkIHBhZ2UgZmF1bHQNCj4gPiBkb2Vzbid0IGhhdmUgYSB2YWxpZCBlZmkgbWVt
b3J5IGRlc2NyaXB0b3IsIHRoZSBlZmkgcGFnZSBmYXVsdCBoYW5kbGVyIHNob3VsZG4ndA0KPiB0
YWtlIGFueSBhY3Rpb24gYmVjYXVzZSBpdCBoYXNuJ3QgdHJpYWdlZCB0aGUgcHJvYmxlbSB5ZXQu
DQo+ID4NCj4gPiAyLiBNYWtlIHN1cmUgdGhhdCB0aGUgZmF1bHRlZCBwaHlzaWNhbCBhZGRyZXNz
IGlzIF9ub3RfIGVmaSBydW50aW1lIHNlcnZpY2UNCj4gY29kZS9kYXRhIHJlZ2lvbi4NCj4gPiBF
ZmkgcnVudGltZSBzZXJ2aWNlIGNvZGUvZGF0YSByZWdpb25zIGFyZSBhbHdheXMgbWFwcGVkIGJ5
IGtlcm5lbCBpbg0KPiA+IGVmaV9wZ2QgYW5kIGFjY2Vzc2VzIHRvIHRoZXNlIHJlZ2lvbnMgc2hv
dWxkIF9uZXZlcl8gcGFnZSBmYXVsdC4NCj4gPiBBc3N1bWluZyB0aGF0IHNvbWV0aGluZyBsaWtl
IHRoaXMgaGFwcGVucywgZWZpIHBhZ2UgZmF1bHQgaGFuZGxlcg0KPiA+IHNob3VsZG4ndCB0YWtl
IGFueSBhY3Rpb24gYmVjYXVzZSBpdCdzIG5vdCBhbnkgaWxsZWdhbCBhY2Nlc3MgYnkgZmlybXdh
cmUgYnV0IGl0J3MNCj4gYSBrZXJuZWwgYnVnLg0KPiA+DQo+IA0KPiBXaGF0IGFib3V0IGF0dGVt
cHRzIHRvIG1vZGlmeSBjb2RlIHJlZ2lvbnMgb3IgYXR0ZW1wdHMgdG8gZXhlY3V0ZSBkYXRhDQo+
IHJlZ2lvbnM/IFdoYXQga2luZCBvZiBmYXVsdCB3aWxsIHRoYXQgdHJpZ2dlciwgYW5kIGFyZSB0
aGV5IGJlaW5nIGhhbmRsZWQgYXQgdGhlDQo+IG1vbWVudD8NCg0KQUZBSUssIGF0IGxlYXN0IGlu
IHRoZSB4ODYgd29ybGQsIGF0dGVtcHRzIHRvIHdyaXRlIHRvIHJlYWQgb25seSByZWdpb25zIG9y
IGF0dGVtcHRzIA0KdG8gZXhlY3V0ZSBYUCAoZXhlY3V0ZSBwcm90ZWN0ZWQpIHBhZ2VzIHdpbGwg
cmVzdWx0IGluIHBhZ2UgZmF1bHQgYW5kIEkgZG9uJ3QgdGhpbmsgDQp3ZSBhcmUgaGFuZGxpbmcg
dGhlbS4NCg0KPiANCj4gQXMgSSBwb2ludGVkIG91dCwgRUZJIHJ1bnRpbWUgc2VydmljZXMgY29k
ZSBtYXkgbGVnYWxseSBhY2Nlc3MgdGhlIHN0YWNrIG9yDQo+IGRlcmVmZXJlbmNlIHBvaW50ZXIg
YXJndW1lbnRzLCBidXQgY291bGQgc3RpbGwgY29udGFpbiBidWdzIHRoYXQgcmVzdWx0IGluIG91
dCBvZg0KPiBib3VuZHMgYWNjZXNzZXMgb3Igd3JpdGVzIHRvIHJlYWQtb25seSByZWdpb25zLg0K
DQpZZXMsIGFncmVlZC4gSW4gZmFjdCwgSSBkaWQgc2VlIHRoZXNlIGJ1Z3MuDQoNCj4gU28gSSBk
b24ndCByZWFsbHkgY2FyZSBhYm91dCB0aGUgYWRkcmVzcyBvZiB0aGUgaWxsZWdhbCBhY2Nlc3Ms
IGFueSBmYXVsdCB0aGF0DQo+IG9jY3VycyB3aGlsZSBydW5uaW5nIGluIHRoZSBmaXJtd2FyZSBz
aG91bGQgYmUgdHJlYXRlZCB0aGUgc2FtZS4NCg0KT2suLiBtYWtlcyBzZW5zZS4NCg0KPiBJbiBm
YWN0LCBjcm9zcw0KPiByZWZlcmVuY2luZyB0aGUgdmFsdWUgb2YgSVAgd2l0aCBSdW50aW1lU2Vy
dmljZXNDb2RlIHJlZ2lvbnMgbWF5IGJlIG1vcmUNCj4gdXNlZnVsDQoNClRoaXMgaXMgdG8gdmVy
aWZ5IHRoYXQgZmlybXdhcmUgaXMgaW5kZWVkIGV4ZWN1dGluZyBjb2RlIGZyb20gUnVudGltZVNl
cnZpY2VzQ29kZQ0KcmVnaW9ucyB3aGVuIGl0IGZhdWx0ZWQuIElzIHRoYXQgY29ycmVjdD8gT3Ig
ZGlkIHlvdSBtZWFuIHNvbWV0aGluZyBlbHNlPw0KDQo+ID4gVGhhdCBzYWlkLCBhIG1vcmUgaW1w
b3J0YW50IHJlYXNvbiAoaW4gbXkgdmlldykgaXMgdG8gcHJpbnQgb3V0IHRoZQ0KPiA+IG1lbW9y
eSBkZXNjcmlwdG9yIHRoYXQgd2UgZmF1bHRlZCBvbi4gVGhpcyBpcyBhICpwcm9vZiogc2hvd2lu
ZyB0aGF0DQo+ID4gaXQncyBidWdneSBmaXJtd2FyZSB0aGF0IGNhdXNlZCBwYWdlIGZhdWx0IGFu
ZCBoZW5jZSBpcyBub3QgYSBrZXJuZWwNCj4gPiBidWcuIFRoaXMgcHJvb2YgaXMgaW1wb3J0YW50
IGJlY2F1c2Ugd2hlbmV2ZXIgYSBzdGFjayB0cmFjZSBpcyBwcmludGVkDQo+ID4gd2l0aCBzb21l
IGVmaSBmdW5jdGlvbiwga2VybmVsIGlzIHRoZSB1c3VhbCBzdXNwZWN0IGFuZCBoZW5jZSB3ZSBu
ZWVkIHRvIHNob3cNCj4gdGhhdCBpdCdzIG5vdCBrZXJuZWwgZmF1bHQuIEl0IGNvdWxkIGFsc28g
aGVscCBmaXJtd2FyZSBlbmdpbmVlcnMgdG8gZml4IHRoZSBidWcNCj4gZWFzaWx5Lg0KPiA+DQo+
ID4gZG1lc2cgd291bGQgc2hvdyBzb21ldGhpbmcgbGlrZSB0aGlzIHdoZW4gYnVnZ3kgZWZpX3Jl
c2V0X3N5c3RlbSgpDQo+IGFjY2Vzc2VzIHJlc2VydmVkIHJlZ2lvbjoNCj4gPg0KPiA+IFsgIDI5
Ni4xNDE1MTFdIGVmaTogRUZJIE1lbW9yeSBEZXNjcmlwdG9yIGZvciBvZmZlbmRpbmcgUEEgaXM6
DQo+ID4gWyAgMjk2LjE0MTg0NF0gZWZpOiBbUmVzZXJ2ZWQgICAgICAgICAgIHwgICB8ICB8ICB8
ICB8ICB8ICB8ICB8ICAgfFdCfFdUfFdDfFVDXQ0KPiByYW5nZT1bMHgwMDAwMDAwMDdlOTE1MDAw
LTB4MDAwMDAwMDA3ZTkzM2ZmZl0gKDBNQikNCj4gPiBbICAyOTYuMTQyNTIyXSBlZmk6IGVmaV9y
ZXNldF9zeXN0ZW0oKSBidWdneSEgUmVib290IHRocm91Z2ggQklPUw0KPiA+DQo+ID4gU28sIEkg
d291bGQgYmUgY29uY2VybmVkIGlmIHdlIG1pc3MgdGhpcyBwcm9vZi4NCj4gPg0KPiANCj4gWW91
IGNhbiBkdW1wIHRoZSBlbnRpcmUgbWVtb3J5IG1hcCBieSBwdXR0aW5nIGVmaT1kZWJ1ZyBvbiB0
aGUga2VybmVsDQo+IGNvbW1hbmQgbGluZSwgc28gYWxsIHdlIG5lZWQgdG8gZG8gaXMgcmVwb3J0
IHRoZSBwaHlzaWNhbCBhZGRyZXNzLCBhbmQgeW91IGNhbg0KPiBlYXNpbHkgZmlndXJlIG91dCBm
b3IgeW91cnNlbGYgd2hpY2ggbWVtb3J5IG1hcCBlbnRyeSBjb3ZlcnMgaXQuDQoNClRoYXQncyB0
cnVlLiBJbiBmYWN0LCB0aGF0J3MgaG93IEkgZGVidWdnZWQgdGhpcyBpc3N1ZSBhbmQgaGVuY2Ug
dGhvdWdodCB0aGF0IGl0IG1pZ2h0IGJlIA0KdXNlZnVsIHRvIGhhdmUgYWxsIHRoYXQgaW5mbyBh
dCBvbmUgcGxhY2UgKGkuZS4gaW4gZWZpIHBhZ2UgZmF1bHQgaGFuZGxlcikuDQpCdXQsIGFzIHlv
dSBzYWlkLCB0byBtYWtlIHRoZSBjb2RlIGxvb2sgc2ltcGxlciwgSSB3aWxsIHJvbGwgb3V0IGEg
VjQgd2l0aG91dCBzYXZpbmcgDQpvcmlnaW5hbCBtZW1vcnkgbWFwLg0KDQpSZWdhcmRzLA0KU2Fp
DQo=
