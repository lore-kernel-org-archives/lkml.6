Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55935ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 08:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E1020843
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 08:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="g1fPm8K3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E1020843
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbeJUQWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 12:22:55 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:45780 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbeJUQWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 12:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1540109363; x=1571645363;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding;
  bh=rbIJ2KKgvtjzYaSEBGXnZP2MN97GAk+PCGi5D1nLAtY=;
  b=g1fPm8K3PEJSnW6f5CFTKNfB5PZtnuiyzrNG0MWWfKLBBCdBbTbiBWtg
   BrTwnj4ihVml16yHrYfmaoRoLtpo1FfWpxYjhsic83buxSSw4MwqnaVto
   i1GA+T4KRR9Gu6HQPx0SzcVDjJeeBw8HWKh3DGvSxBuhjvtVmaPTvOkmF
   o=;
X-IronPort-AV: E=Sophos;i="5.54,407,1534809600"; 
   d="scan'208";a="369625106"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Oct 2018 08:09:22 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9L89KR1025045
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 21 Oct 2018 08:09:21 GMT
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 21 Oct 2018 08:09:21 +0000
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13D01EUB003.ant.amazon.com (10.43.166.248) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 21 Oct 2018 08:09:20 +0000
Received: from EX13D01EUB003.ant.amazon.com ([10.43.166.248]) by
 EX13D01EUB003.ant.amazon.com ([10.43.166.248]) with mapi id 15.00.1367.000;
 Sun, 21 Oct 2018 08:09:20 +0000
From:   "Raslan, KarimAllah" <karahmed@amazon.de>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH v3 07/13] KVM/nVMX: Use kvm_vcpu_map when mapping the
 virtual APIC page
Thread-Topic: [PATCH v3 07/13] KVM/nVMX: Use kvm_vcpu_map when mapping the
 virtual APIC page
Thread-Index: AQHUaMN0/2qz6bA7fkGmnZuuqPTVl6UpWTSA
Date:   Sun, 21 Oct 2018 08:09:19 +0000
Message-ID: <1540109359.11839.30.camel@amazon.de>
References: <1540074145-31285-1-git-send-email-karahmed@amazon.de>
         <1540074145-31285-8-git-send-email-karahmed@amazon.de>
In-Reply-To: <1540074145-31285-8-git-send-email-karahmed@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.127]
Content-Type: text/plain; charset="utf-8"
Content-ID: <894908295FCA2746A21DF7872EE57492@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkhIHBsZWFzZSBpZ25vcmUgdGhpcyBwYXRjaCBpbiBmYXZvciBvZiBpdHMgUkVTRU5ELiBJ
IHJlYWxpemVkIHRoYXQgYSBmZXfCoA0KbGluZXMgZnJvbSBpdCBsZWFrZWQgaW50byBhbm90aGVy
IHBhdGNoIHNlcmllcy4gVGhlICJSRVNFTkQiIHNob3VsZCBoYXZlIHRoaXPCoA0KZml4ZWQuDQoN
Ck9uIFN1biwgMjAxOC0xMC0yMSBhdCAwMDoyMiArMDIwMCwgS2FyaW1BbGxhaCBBaG1lZCB3cm90
ZToNCj4gVXNlIGt2bV92Y3B1X21hcCB3aGVuIG1hcHBpbmcgdGhlIHZpcnR1YWwgQVBJQyBwYWdl
IHNpbmNlIHVzaW5nDQo+IGt2bV92Y3B1X2dwYV90b19wYWdlKCkgYW5kIGttYXAoKSB3aWxsIG9u
bHkgd29yayBmb3IgZ3Vlc3QgbWVtb3J5IHRoYXQgaGFzDQo+IGEgInN0cnVjdCBwYWdlIi4NCj4g
DQo+IE9uZSBhZGRpdGlvbmFsIHNlbWFudGljIGNoYW5nZSBpcyB0aGF0IHRoZSB2aXJ0dWFsIGhv
c3QgbWFwcGluZyBsaWZlY3ljbGUNCj4gaGFzIGNoYW5nZWQgYSBiaXQuIEl0IG5vdyBoYXMgdGhl
IHNhbWUgbGlmZXRpbWUgb2YgdGhlIHBpbm5pbmcgb2YgdGhlDQo+IHZpcnR1YWwgQVBJQyBwYWdl
IG9uIHRoZSBob3N0IHNpZGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLYXJpbUFsbGFoIEFobWVk
IDxrYXJhaG1lZEBhbWF6b24uZGU+DQo+IC0tLQ0KPiB2MSAtPiB2MjoNCj4gLSBEbyBub3QgY2hh
bmdlIHRoZSBsaWZlY3ljbGUgb2YgdGhlIG1hcHBpbmcgKHBib256aW5pKQ0KPiAtIFVzZSBwZm5f
dG9faHBhIGluc3RlYWQgb2YgZ2ZuX3RvX2dwYQ0KPiAtLS0NCj4gIGFyY2gveDg2L2t2bS92bXgu
YyB8IDM0ICsrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxMSBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9rdm0vdm14LmMgYi9hcmNoL3g4Ni9rdm0vdm14LmMNCj4gaW5kZXggNWIxNWNh
Mi4uODNhNWU5NSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva3ZtL3ZteC5jDQo+ICsrKyBiL2Fy
Y2gveDg2L2t2bS92bXguYw0KPiBAQCAtODQ1LDkgKzg0NSw4IEBAIHN0cnVjdCBuZXN0ZWRfdm14
IHsNCj4gIAkgKiBwb2ludGVycywgc28gd2UgbXVzdCBrZWVwIHRoZW0gcGlubmVkIHdoaWxlIEwy
IHJ1bnMuDQo+ICAJICovDQo+ICAJc3RydWN0IHBhZ2UgKmFwaWNfYWNjZXNzX3BhZ2U7DQo+IC0J
c3RydWN0IHBhZ2UgKnZpcnR1YWxfYXBpY19wYWdlOw0KPiArCXN0cnVjdCBrdm1faG9zdF9tYXAg
dmlydHVhbF9hcGljX21hcDsNCj4gIAlzdHJ1Y3QgcGFnZSAqcGlfZGVzY19wYWdlOw0KPiAtDQo+
ICAJc3RydWN0IGt2bV9ob3N0X21hcCBtc3JfYml0bWFwX21hcDsNCj4gIA0KPiAgCXN0cnVjdCBw
aV9kZXNjICpwaV9kZXNjOw0KPiBAQCAtNjE1MiwxMSArNjE1MSwxMiBAQCBzdGF0aWMgdm9pZCB2
bXhfY29tcGxldGVfbmVzdGVkX3Bvc3RlZF9pbnRlcnJ1cHQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1
KQ0KPiAgDQo+ICAJbWF4X2lyciA9IGZpbmRfbGFzdF9iaXQoKHVuc2lnbmVkIGxvbmcgKil2bXgt
Pm5lc3RlZC5waV9kZXNjLT5waXIsIDI1Nik7DQo+ICAJaWYgKG1heF9pcnIgIT0gMjU2KSB7DQo+
IC0JCXZhcGljX3BhZ2UgPSBrbWFwKHZteC0+bmVzdGVkLnZpcnR1YWxfYXBpY19wYWdlKTsNCj4g
KwkJdmFwaWNfcGFnZSA9IHZteC0+bmVzdGVkLnZpcnR1YWxfYXBpY19tYXAuaHZhOw0KPiArCQlp
ZiAoIXZhcGljX3BhZ2UpDQo+ICsJCQlyZXR1cm47DQo+ICsNCj4gIAkJX19rdm1fYXBpY191cGRh
dGVfaXJyKHZteC0+bmVzdGVkLnBpX2Rlc2MtPnBpciwNCj4gIAkJCXZhcGljX3BhZ2UsICZtYXhf
aXJyKTsNCj4gLQkJa3VubWFwKHZteC0+bmVzdGVkLnZpcnR1YWxfYXBpY19wYWdlKTsNCj4gLQ0K
PiAgCQlzdGF0dXMgPSB2bWNzX3JlYWQxNihHVUVTVF9JTlRSX1NUQVRVUyk7DQo+ICAJCWlmICgo
dTgpbWF4X2lyciA+ICgodTgpc3RhdHVzICYgMHhmZikpIHsNCj4gIAkJCXN0YXR1cyAmPSB+MHhm
ZjsNCj4gQEAgLTg0NjgsMTAgKzg0NjgsNyBAQCBzdGF0aWMgdm9pZCBmcmVlX25lc3RlZChzdHJ1
Y3QgdmNwdV92bXggKnZteCkNCj4gIAkJa3ZtX3JlbGVhc2VfcGFnZV9kaXJ0eSh2bXgtPm5lc3Rl
ZC5hcGljX2FjY2Vzc19wYWdlKTsNCj4gIAkJdm14LT5uZXN0ZWQuYXBpY19hY2Nlc3NfcGFnZSA9
IE5VTEw7DQo+ICAJfQ0KPiAtCWlmICh2bXgtPm5lc3RlZC52aXJ0dWFsX2FwaWNfcGFnZSkgew0K
PiAtCQlrdm1fcmVsZWFzZV9wYWdlX2RpcnR5KHZteC0+bmVzdGVkLnZpcnR1YWxfYXBpY19wYWdl
KTsNCj4gLQkJdm14LT5uZXN0ZWQudmlydHVhbF9hcGljX3BhZ2UgPSBOVUxMOw0KPiAtCX0NCj4g
Kwlrdm1fdmNwdV91bm1hcCgmdm14LT5uZXN0ZWQudmlydHVhbF9hcGljX21hcCk7DQo+ICAJaWYg
KHZteC0+bmVzdGVkLnBpX2Rlc2NfcGFnZSkgew0KPiAgCQlrdW5tYXAodm14LT5uZXN0ZWQucGlf
ZGVzY19wYWdlKTsNCj4gIAkJa3ZtX3JlbGVhc2VfcGFnZV9kaXJ0eSh2bXgtPm5lc3RlZC5waV9k
ZXNjX3BhZ2UpOw0KPiBAQCAtMTEzOTQsNiArMTEzOTEsNyBAQCBzdGF0aWMgdm9pZCBuZXN0ZWRf
Z2V0X3ZtY3MxMl9wYWdlcyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpDQo+ICB7DQo+ICAJc3RydWN0
IHZtY3MxMiAqdm1jczEyID0gZ2V0X3ZtY3MxMih2Y3B1KTsNCj4gIAlzdHJ1Y3QgdmNwdV92bXgg
KnZteCA9IHRvX3ZteCh2Y3B1KTsNCj4gKwlzdHJ1Y3Qga3ZtX2hvc3RfbWFwICptYXA7DQo+ICAJ
c3RydWN0IHBhZ2UgKnBhZ2U7DQo+ICAJdTY0IGhwYTsNCj4gIA0KPiBAQCAtMTE0MjYsMTEgKzEx
NDI0LDcgQEAgc3RhdGljIHZvaWQgbmVzdGVkX2dldF92bWNzMTJfcGFnZXMoc3RydWN0IGt2bV92
Y3B1ICp2Y3B1KQ0KPiAgCX0NCj4gIA0KPiAgCWlmIChuZXN0ZWRfY3B1X2hhcyh2bWNzMTIsIENQ
VV9CQVNFRF9UUFJfU0hBRE9XKSkgew0KPiAtCQlpZiAodm14LT5uZXN0ZWQudmlydHVhbF9hcGlj
X3BhZ2UpIHsgLyogc2hvdWxkbid0IGhhcHBlbiAqLw0KPiAtCQkJa3ZtX3JlbGVhc2VfcGFnZV9k
aXJ0eSh2bXgtPm5lc3RlZC52aXJ0dWFsX2FwaWNfcGFnZSk7DQo+IC0JCQl2bXgtPm5lc3RlZC52
aXJ0dWFsX2FwaWNfcGFnZSA9IE5VTEw7DQo+IC0JCX0NCj4gLQkJcGFnZSA9IGt2bV92Y3B1X2dw
YV90b19wYWdlKHZjcHUsIHZtY3MxMi0+dmlydHVhbF9hcGljX3BhZ2VfYWRkcik7DQo+ICsJCW1h
cCA9ICZ2bXgtPm5lc3RlZC52aXJ0dWFsX2FwaWNfbWFwOw0KPiAgDQo+ICAJCS8qDQo+ICAJCSAq
IElmIHRyYW5zbGF0aW9uIGZhaWxlZCwgVk0gZW50cnkgd2lsbCBmYWlsIGJlY2F1c2UNCj4gQEAg
LTExNDQ1LDExICsxMTQzOSw4IEBAIHN0YXRpYyB2b2lkIG5lc3RlZF9nZXRfdm1jczEyX3BhZ2Vz
KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCj4gIAkJICogY29udHJvbC4gIEJ1dCBzdWNoIGEgY29u
ZmlndXJhdGlvbiBpcyB1c2VsZXNzLCBzbw0KPiAgCQkgKiBsZXQncyBrZWVwIHRoZSBjb2RlIHNp
bXBsZS4NCj4gIAkJICovDQo+IC0JCWlmICghaXNfZXJyb3JfcGFnZShwYWdlKSkgew0KPiAtCQkJ
dm14LT5uZXN0ZWQudmlydHVhbF9hcGljX3BhZ2UgPSBwYWdlOw0KPiAtCQkJaHBhID0gcGFnZV90
b19waHlzKHZteC0+bmVzdGVkLnZpcnR1YWxfYXBpY19wYWdlKTsNCj4gLQkJCXZtY3Nfd3JpdGU2
NChWSVJUVUFMX0FQSUNfUEFHRV9BRERSLCBocGEpOw0KPiAtCQl9DQo+ICsJCWlmICgha3ZtX3Zj
cHVfbWFwKHZjcHUsIGdwYV90b19nZm4odm1jczEyLT52aXJ0dWFsX2FwaWNfcGFnZV9hZGRyKSwg
bWFwKSkNCj4gKwkJCXZtY3Nfd3JpdGU2NChWSVJUVUFMX0FQSUNfUEFHRV9BRERSLCBwZm5fdG9f
aHBhKG1hcC0+cGZuKSk7DQo+ICAJfQ0KPiAgDQo+ICAJaWYgKG5lc3RlZF9jcHVfaGFzX3Bvc3Rl
ZF9pbnRyKHZtY3MxMikpIHsNCj4gQEAgLTEzMzUzLDEwICsxMzM0NCw3IEBAIHN0YXRpYyB2b2lk
IG5lc3RlZF92bXhfdm1leGl0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgdTMyIGV4aXRfcmVhc29u
LA0KPiAgCQlrdm1fcmVsZWFzZV9wYWdlX2RpcnR5KHZteC0+bmVzdGVkLmFwaWNfYWNjZXNzX3Bh
Z2UpOw0KPiAgCQl2bXgtPm5lc3RlZC5hcGljX2FjY2Vzc19wYWdlID0gTlVMTDsNCj4gIAl9DQo+
IC0JaWYgKHZteC0+bmVzdGVkLnZpcnR1YWxfYXBpY19wYWdlKSB7DQo+IC0JCWt2bV9yZWxlYXNl
X3BhZ2VfZGlydHkodm14LT5uZXN0ZWQudmlydHVhbF9hcGljX3BhZ2UpOw0KPiAtCQl2bXgtPm5l
c3RlZC52aXJ0dWFsX2FwaWNfcGFnZSA9IE5VTEw7DQo+IC0JfQ0KPiArCWt2bV92Y3B1X3VubWFw
KCZ2bXgtPm5lc3RlZC52aXJ0dWFsX2FwaWNfbWFwKTsNCj4gIAlpZiAodm14LT5uZXN0ZWQucGlf
ZGVzY19wYWdlKSB7DQo+ICAJCWt1bm1hcCh2bXgtPm5lc3RlZC5waV9kZXNjX3BhZ2UpOw0KPiAg
CQlrdm1fcmVsZWFzZV9wYWdlX2RpcnR5KHZteC0+bmVzdGVkLnBpX2Rlc2NfcGFnZSk7DQpBbWF6
b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApCZXJsaW4gLSBEcmVzZGVuIC0gQWFj
aGVuCm1haW4gb2ZmaWNlOiBLcmF1c2Vuc3RyLiAzOCwgMTAxMTcgQmVybGluCkdlc2NoYWVmdHNm
dWVocmVyOiBEci4gUmFsZiBIZXJicmljaCwgQ2hyaXN0aWFuIFNjaGxhZWdlcgpVc3QtSUQ6IERF
Mjg5MjM3ODc5CkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIEhSQiAx
NDkxNzMgQgo=

