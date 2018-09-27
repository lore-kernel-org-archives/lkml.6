Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808E1C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8292168B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8292168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbeI0Wpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:45:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:37355 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727335AbeI0Wpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:45:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 09:26:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,311,1534834800"; 
   d="scan'208";a="260853968"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga005.jf.intel.com with ESMTP; 27 Sep 2018 09:23:28 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 27 Sep 2018 09:23:28 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.14]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.138]) with mapi id 14.03.0319.002;
 Thu, 27 Sep 2018 09:23:28 -0700
From:   "Schaufler, Casey" <casey.schaufler@intel.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        Paul Moore <paul@paul-moore.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
Subject: RE: [PATCH v5 3/5] SELinux: Prepare for PTRACE_MODE_SCHED
Thread-Topic: [PATCH v5 3/5] SELinux: Prepare for PTRACE_MODE_SCHED
Thread-Index: AQHUVdhjbL0Q8He2uUOeWqu62/Rqf6UEvS6A//+OGHA=
Date:   Thu, 27 Sep 2018 16:23:27 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC673214631B5@ORSMSX107.amr.corp.intel.com>
References: <20180926203446.2004-1-casey.schaufler@intel.com>
 <20180926203446.2004-4-casey.schaufler@intel.com>
 <6e21f471-ff88-c57c-8892-e0bb626bea12@tycho.nsa.gov>
In-Reply-To: <6e21f471-ff88-c57c-8892-e0bb626bea12@tycho.nsa.gov>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDAwNWUzMjEtNTE2Ni00MmJiLTk1OTctZDkzNmQyZWIwMTU0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaW9JS3ZSQUU1dkw3bEtpallxQkZ6UEJzb2EwM2hFU1MwcWdnYWc3eUZlUGxrYURmeXN4TzlhMHh0K0R2WlVBaCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVwaGVuIFNtYWxsZXkgW21h
aWx0bzpzZHNAdHljaG8ubnNhLmdvdl0NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAyNywg
MjAxOCA4OjUwIEFNDQo+IFRvOiBTY2hhdWZsZXIsIENhc2V5IDxjYXNleS5zY2hhdWZsZXJAaW50
ZWwuY29tPjsga2VybmVsLQ0KPiBoYXJkZW5pbmdAbGlzdHMub3BlbndhbGwuY29tOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1zZWN1cml0eS0NCj4gbW9kdWxlQHZnZXIua2Vy
bmVsLm9yZzsgc2VsaW51eEB0eWNoby5uc2EuZ292OyBIYW5zZW4sIERhdmUNCj4gPGRhdmUuaGFu
c2VuQGludGVsLmNvbT47IERvY2ssIERlbmVlbiBUIDxkZW5lZW4udC5kb2NrQGludGVsLmNvbT47
DQo+IGtyaXN0ZW5AbGludXguaW50ZWwuY29tOyBhcmphbkBsaW51eC5pbnRlbC5jb207IFBhdWwg
TW9vcmUgPHBhdWxAcGF1bC0NCj4gbW9vcmUuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1
IDMvNV0gU0VMaW51eDogUHJlcGFyZSBmb3IgUFRSQUNFX01PREVfU0NIRUQNCj4gDQo+IE9uIDA5
LzI2LzIwMTggMDQ6MzQgUE0sIENhc2V5IFNjaGF1ZmxlciB3cm90ZToNCj4gPiBGcm9tOiBDYXNl
eSBTY2hhdWZsZXIgPGNhc2V5QHNjaGF1Zmxlci1jYS5jb20+DQo+ID4NCj4gPiBBIHB0cmFjZSBh
Y2Nlc3MgY2hlY2sgd2l0aCBtb2RlIFBUUkFDRV9NT0RFX1NDSEVEIGdldHMgY2FsbGVkDQo+ID4g
ZnJvbSBwcm9jZXNzIHN3aXRjaGluZyBjb2RlLiBUaGlzIHByZWNsdWRlcyB0aGUgdXNlIG9mIGF1
ZGl0IG9yIGF2YywNCj4gPiBhcyB0aGUgbG9ja2luZyBpcyBpbmNvbXBhdGlibGUuIFRoZSBvbmx5
IGF2YWlsYWJsZSBjaGVjayB0aGF0DQo+ID4gY2FuIGJlIG1hZGUgd2l0aG91dCB1c2luZyBhdmMg
aXMgYSBjb21wYXJpc29uIG9mIHRoZSBzZWNpZHMuDQo+ID4gVGhpcyBpcyBub3QgdmVyeSBzYXRp
c2ZhY3RvcnkgYXMgaXQgd2lsbCBpbmRpY2F0ZSBwb3NzaWJsZQ0KPiA+IHZ1bG5lcmFiaWxpZXMg
bXVjaCB0b28gYWdncmVzc2l2ZWx5Lg0KPiBDYW4geW91IGRvY3VtZW50IChpbiB0aGUgcGF0Y2gg
ZGVzY3JpcHRpb24gYW5kL29yIGluIHRoZSBpbmxpbmUNCj4gZG9jdW1lbnRhdGlvbiBpbiBsc21f
aG9va3MuaCkgd2hhdCBsb2NrcyBjYW4gYmUgc2FmZWx5IHVzZWQgd2hlbiB0aGlzDQo+IGhvb2sg
aXMgY2FsbGVkIHdpdGggUFRSQUNFX01PREVfU0NIRUQ/ICByY3VfcmVhZF9sb2NrKCkgc2VlbWlu
Z2x5IG11c3QNCj4gYmUgc2FmZSBzaW5jZSBpdCBpcyBiZWluZyBjYWxsZWQgYnkgdGFza19zaWQo
KSBiZWxvdy4gQXJlIGFueSBvdGhlcg0KPiBsb2NraW5nIHByaW1pdGl2ZXMgc2FmZT8NCg0KUGV0
ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPiBoYWQgdGhpcyBjb21tZW50IG9uDQps
b2NraW5nIGluIHRoZSBTRUxpbnV4IHB0cmFjZSBwYXRoLiANCg0KIAlhdmNfaGFzX3Blcm1fbm9h
dWRpdCgpDQoJICBzZWN1cml0eV9jb21wdXRlX2F2KCkNCgkgICAgcmVhZF9sb2NrKCZzdGF0ZS0+
c3MtPnBvbGljeV9yd2xvY2spOw0KCSAgYXZjX2luc2VydCgpDQoJICAgIHNwaW5fbG9ja19pcnFz
YXZlKCk7DQoJICBhdmNfZGVuaWVkKCkNCgkgICAgYXZjX3VwZGF0ZV9ub2RlKCkNCgkgICAgICBz
cGluX2xvY2tfaXJxc2F2ZSgpOw0KDQp1bmRlciB0aGUgc2NoZWR1bGVyJ3MgcmF3X3NwaW5sb2Nr
X3QsIHdoaWNoIGFyZSBpbnZhbGlkIGxvY2sgbmVzdGluZ3MuDQoNCkkgZG9uJ3Qga25vdyB0aGF0
IGl0IHdvdWxkIGJlIGltcG9zc2libGUgdG8gYWRkcmVzcyB0aGVzZSBpc3N1ZXMsDQpidXQgYXMg
bWFueSBwZW9wbGUgaGF2ZSBub3RlZCBvdmVyIHRoZSB5ZWFycyBJIGFtIG5vdCBub3cNCm5vciBo
YXZlIGV2ZXIgYmVlbiBhbiBleHBlcnQgb24gbG9ja2luZy4NCg0KPiANCj4gRG9lcyB0aGUgUFRS
QUNFX01PREVfU0NIRUQgY2hlY2sgaGF2ZSB0byBvY2N1ciB3aGlsZSBob2xkaW5nIHRoZQ0KPiBz
Y2hlZHVsZXIgbG9jaywgb3IgY291bGQgaXQgYmUgcGVyZm9ybWVkIGJlZm9yZSB0YWtpbmcgdGhl
IGxvY2s/DQoNCk15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB0aGUgbG9jayBpcyByZXF1aXJlZC4N
Cg0KIA0KPiBDYW4geW91IGNpdGUgdGhlIGNvbW1pdCBvciBwYXRjaCBwb3N0aW5nIChlLmcuIGZy
b20gbG9yZSBvciBwYXRjaHdvcmspDQo+IHRoYXQgZGVmaW5lcyBQVFJBQ0VfTU9ERV9TQ0hFRCBh
bmQgaXRzIHVzYWdlIGFzIHBhcnQgb2YgdGhlIHBhdGNoDQo+IGRlc2NyaXB0aW9uIGZvciBjb250
ZXh0PyAgSXMgdGhpcyBiYXNlZCBvbiB0aGUgdjcgcGF0Y2hzZXQsIGUuZy4NCj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGttbC9ueWN2YXIuWUZILjcuNzYuMTgwOTI1MTQzNzM0MC4xNTg4MEBj
Ym9iay5maGYNCj4gci5wbS8NCg0KWWVzLCB0aGF0J3MgdGhlIG9uZS4gU29ycnksIEkgc2hvdWxk
IGhhdmUgaWRlbnRpZmllZCB0aGF0Lg0KDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2Fz
ZXkgU2NoYXVmbGVyIDxjYXNleS5zY2hhdWZsZXJAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAg
c2VjdXJpdHkvc2VsaW51eC9ob29rcy5jIHwgMiArKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L3NlbGludXgvaG9v
a3MuYyBiL3NlY3VyaXR5L3NlbGludXgvaG9va3MuYw0KPiA+IGluZGV4IGFkOWE5YjhlOTk3OS4u
MTYwMjM5NzkxMDA3IDEwMDY0NA0KPiA+IC0tLSBhL3NlY3VyaXR5L3NlbGludXgvaG9va3MuYw0K
PiA+ICsrKyBiL3NlY3VyaXR5L3NlbGludXgvaG9va3MuYw0KPiA+IEBAIC0yMjY3LDYgKzIyNjcs
OCBAQCBzdGF0aWMgaW50IHNlbGludXhfcHRyYWNlX2FjY2Vzc19jaGVjayhzdHJ1Y3QNCj4gdGFz
a19zdHJ1Y3QgKmNoaWxkLA0KPiA+ICAgCXUzMiBzaWQgPSBjdXJyZW50X3NpZCgpOw0KPiA+ICAg
CXUzMiBjc2lkID0gdGFza19zaWQoY2hpbGQpOw0KPiA+DQo+ID4gKwlpZiAobW9kZSAmIFBUUkFD
RV9NT0RFX1NDSEVEKQ0KPiA+ICsJCXJldHVybiBzaWQgPT0gY3NpZCA/IDAgOiAtRUFDQ0VTOw0K
PiBJSVVDLCB0aGlzIGxvZ2ljIGlzIGVzc2VudGlhbGx5IHRoZSBzYW1lIGFzIHRoZSB1aWQtYmFz
ZWQgY2hlY2ssDQo+IGluY2x1ZGluZyB0aGUgZmFjdCB0aGF0IGV2ZW4gYSAicHJpdmlsZWdlZCIg
cHJvY2VzcyBpcyBub3QgZ2l2ZW4gYW55DQo+IHNwZWNpYWwgaGFuZGxpbmcgc2luY2UgdGhleSBh
bHdheXMgcmV0dXJuIGZhbHNlIGZyb20gcHRyYWNlX2hhc19jYXAoKQ0KPiBmb3IgUFRSQUNFX01P
REVfU0NIRUQuIElmIHRoZXkgYXJlIG9rIHdpdGggYXBwbHlpbmcgSUJQQiB3aGVuZXZlciB1aWRz
DQo+IGRpZmZlciwgdGhlbiBkb2luZyBzbyB3aGVuZXZlciBzaWRzL2NvbnRleHRzIGRpZmZlciBk
b2VzIG5vdCBzZWVtIGxpa2UNCj4gYW4gb25lcm91cyB0aGluZy4NCj4gDQo+IA0KPiA+ICAgCWlm
IChtb2RlICYgUFRSQUNFX01PREVfUkVBRCkNCj4gPiAgIAkJcmV0dXJuIGF2Y19oYXNfcGVybSgm
c2VsaW51eF9zdGF0ZSwNCj4gPiAgIAkJCQkgICAgc2lkLCBjc2lkLCBTRUNDTEFTU19GSUxFLCBG
SUxFX19SRUFELA0KPiBOVUxMKTsNCj4gPg0KDQo=
