Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1853BC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D293120652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="p01wlrs5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D293120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbeJWGKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 02:10:41 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:26758 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeJWGKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 02:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1540245020; x=1571781020;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=fBXX0Q/N6bm8B7lrLJhAYJs7M5zUM0RH9TEntjAWVFo=;
  b=p01wlrs5/M2uM9AgLIA3F5FtdmTERU0kTxlmSAQTAETFX+Oki/nhcxDU
   22aykuxMSsiw4ptqIYOVLDZ70RPuIizQv30iKLDaJlhQvsTXgaqRHc4Gt
   eNc6/YSeddIxPPBwbrLRIALaKgSv/XqxL+TFdVXrrh2EXZaNfM+isnhcj
   k=;
X-IronPort-AV: E=Sophos;i="5.54,413,1534809600"; 
   d="scan'208";a="637847988"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Oct 2018 21:50:03 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9MLnu87116753
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 22 Oct 2018 21:49:59 GMT
Received: from EX13D01EUB002.ant.amazon.com (10.43.166.113) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 22 Oct 2018 21:49:58 +0000
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13D01EUB002.ant.amazon.com (10.43.166.113) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 22 Oct 2018 21:49:57 +0000
Received: from EX13D01EUB003.ant.amazon.com ([10.43.166.248]) by
 EX13D01EUB003.ant.amazon.com ([10.43.166.248]) with mapi id 15.00.1367.000;
 Mon, 22 Oct 2018 21:49:57 +0000
From:   "Raslan, KarimAllah" <karahmed@amazon.de>
To:     "jmattson@google.com" <jmattson@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH v3 06/13] KVM/nVMX: Use kvm_vcpu_map when mapping the L1
 MSR bitmap
Thread-Topic: [PATCH v3 06/13] KVM/nVMX: Use kvm_vcpu_map when mapping the L1
 MSR bitmap
Thread-Index: AQHUaMNyREW7svwJSkSPcXRGv29TZ6UrzsKAgAACDgA=
Date:   Mon, 22 Oct 2018 21:49:56 +0000
Message-ID: <1540244996.11839.46.camel@amazon.de>
References: <1540074145-31285-1-git-send-email-karahmed@amazon.de>
         <1540074145-31285-7-git-send-email-karahmed@amazon.de>
         <CALMp9eRh2syfY9KjaH9h=AA1dwRnKb+S-NXEB3Hn+tjQoSrBXg@mail.gmail.com>
In-Reply-To: <CALMp9eRh2syfY9KjaH9h=AA1dwRnKb+S-NXEB3Hn+tjQoSrBXg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.129]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5664AC4BD06864593F1277D468018B1@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTEwLTIyIGF0IDE0OjQyIC0wNzAwLCBKaW0gTWF0dHNvbiB3cm90ZToNCj4g
T24gU2F0LCBPY3QgMjAsIDIwMTggYXQgMzoyMiBQTSwgS2FyaW1BbGxhaCBBaG1lZCA8a2FyYWht
ZWRAYW1hem9uLmRlPiB3cm90ZToNCj4gPiANCj4gPiBVc2Uga3ZtX3ZjcHVfbWFwIHdoZW4gbWFw
cGluZyB0aGUgTDEgTVNSIGJpdG1hcCBzaW5jZSB1c2luZw0KPiA+IGt2bV92Y3B1X2dwYV90b19w
YWdlKCkgYW5kIGttYXAoKSB3aWxsIG9ubHkgd29yayBmb3IgZ3Vlc3QgbWVtb3J5IHRoYXQgaGFz
DQo+ID4gYSAic3RydWN0IHBhZ2UiLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEthcmltQWxs
YWggQWhtZWQgPGthcmFobWVkQGFtYXpvbi5kZT4NCj4gPiAtLS0NCj4gPiB2MSAtPiB2MjoNCj4g
PiAtIERvIG5vdCBjaGFuZ2UgdGhlIGxpZmVjeWNsZSBvZiB0aGUgbWFwcGluZyAocGJvbnppbmkp
DQo+ID4gLS0tDQo+ID4gIGFyY2gveDg2L2t2bS92bXguYyB8IDE0ICsrKysrKysrLS0tLS0tDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92bXguYyBiL2FyY2gveDg2L2t2bS92bXgu
Yw0KPiA+IGluZGV4IGQ4NTc0MDEuLjViMTVjYTIgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYv
a3ZtL3ZteC5jDQo+ID4gKysrIGIvYXJjaC94ODYva3ZtL3ZteC5jDQo+ID4gQEAgLTg0Nyw2ICs4
NDcsOSBAQCBzdHJ1Y3QgbmVzdGVkX3ZteCB7DQo+ID4gICAgICAgICBzdHJ1Y3QgcGFnZSAqYXBp
Y19hY2Nlc3NfcGFnZTsNCj4gPiAgICAgICAgIHN0cnVjdCBwYWdlICp2aXJ0dWFsX2FwaWNfcGFn
ZTsNCj4gPiAgICAgICAgIHN0cnVjdCBwYWdlICpwaV9kZXNjX3BhZ2U7DQo+ID4gKw0KPiA+ICsg
ICAgICAgc3RydWN0IGt2bV9ob3N0X21hcCBtc3JfYml0bWFwX21hcDsNCj4gPiArDQo+ID4gICAg
ICAgICBzdHJ1Y3QgcGlfZGVzYyAqcGlfZGVzYzsNCj4gPiAgICAgICAgIGJvb2wgcGlfcGVuZGlu
ZzsNCj4gPiAgICAgICAgIHUxNiBwb3N0ZWRfaW50cl9udjsNCj4gPiBAQCAtMTE1NDYsOSArMTE1
NDksMTAgQEAgc3RhdGljIGlubGluZSBib29sIG5lc3RlZF92bXhfcHJlcGFyZV9tc3JfYml0bWFw
KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZtY3MxMiAqdm1jczEyKQ0KPiA+ICB7DQo+ID4g
ICAgICAgICBpbnQgbXNyOw0KPiA+IC0gICAgICAgc3RydWN0IHBhZ2UgKnBhZ2U7DQo+ID4gICAg
ICAgICB1bnNpZ25lZCBsb25nICptc3JfYml0bWFwX2wxOw0KPiA+ICAgICAgICAgdW5zaWduZWQg
bG9uZyAqbXNyX2JpdG1hcF9sMCA9IHRvX3ZteCh2Y3B1KS0+bmVzdGVkLnZtY3MwMi5tc3JfYml0
bWFwOw0KPiA+ICsgICAgICAgc3RydWN0IGt2bV9ob3N0X21hcCAqbWFwID0gJnRvX3ZteCh2Y3B1
KS0+bmVzdGVkLm1zcl9iaXRtYXBfbWFwOw0KPiA+ICsNCj4gPiAgICAgICAgIC8qDQo+ID4gICAg
ICAgICAgKiBwcmVkX2NtZCAmIHNwZWNfY3RybCBhcmUgdHJ5aW5nIHRvIHZlcmlmeSB0d28gdGhp
bmdzOg0KPiA+ICAgICAgICAgICoNCj4gPiBAQCAtMTE1NzQsMTEgKzExNTc4LDEwIEBAIHN0YXRp
YyBpbmxpbmUgYm9vbCBuZXN0ZWRfdm14X3ByZXBhcmVfbXNyX2JpdG1hcChzdHJ1Y3Qga3ZtX3Zj
cHUgKnZjcHUsDQo+ID4gICAgICAgICAgICAgIXByZWRfY21kICYmICFzcGVjX2N0cmwpDQo+ID4g
ICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiANCj4gPiAtICAgICAgIHBhZ2UgPSBr
dm1fdmNwdV9ncGFfdG9fcGFnZSh2Y3B1LCB2bWNzMTItPm1zcl9iaXRtYXApOw0KPiA+IC0gICAg
ICAgaWYgKGlzX2Vycm9yX3BhZ2UocGFnZSkpDQo+ID4gKyAgICAgICBpZiAoa3ZtX3ZjcHVfbWFw
KHZjcHUsIGdwYV90b19nZm4odm1jczEyLT5tc3JfYml0bWFwKSwgbWFwKSkNCj4gDQo+IElzbid0
IHRoaXMgdGhlIHNvcnQgb2YgaGlnaCBmcmVxdWVuY3kgb3BlcmF0aW9uIHRoYXQgc2hvdWxkIG5v
dCB1c2UgdGhlIG5ldyBBUEk/DQoNCldpdGggdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gb2Yg
dGhlIEFQSSwgeWVzLiBUaGUgcGVyZm9ybWFuY2Ugd2lsbCBiZcKgDQpob3JyaWJsZS4gVGhpcyBk
b2VzIG5vdCBhZmZlY3QgdGhlIGN1cnJlbnQgdXNlcnMgdGhvdWdoIChpLmUuIHdoZW4gZ3Vlc3Qg
bWVtb3J5wqANCmlzIGJhY2tlZCBieSAic3RydWN0IHBhZ2UiKS4NCg0KSSBoYXZlIGEgZmV3IHBh
dGNoZXMgdGhhdCBpbXBsZW1lbnRzIGEgcGZuX2NhY2hlIG9uIHRvcCBvZiB0aGlzIGFzIHN1Z2dl
c3RlZCBiecKgDQpQYW9sby4gVGhpcyB3b3VsZCBhbGxvdyB0aGlzIEFQSSB0byBiZSB1c2VkIGZv
ciB0aGlzIHR5cGUgb2YgaGlnaC1mcmVxdWVuY3nCoA0KbWFwcGluZ3MuDQoNCkZvciBleGFtcGxl
IHdpdGggdGhpcyBwZm5fY2FjaGUsIGJvb3RpbmcgYW4gVWJ1bnR1IHdhcyAxMHggZmFzdGVyIChm
cm9tIH4gMsKgDQptaW51dGVzIHRvIDEzIHNlY29uZHMpLg0KDQo+IA0KPiA+IA0KPiA+ICAgICAg
ICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gDQo+ID4gLSAgICAgICBtc3JfYml0bWFwX2wx
ID0gKHVuc2lnbmVkIGxvbmcgKilrbWFwKHBhZ2UpOw0KPiA+ICsgICAgICAgbXNyX2JpdG1hcF9s
MSA9ICh1bnNpZ25lZCBsb25nICopbWFwLT5odmE7DQo+ID4gICAgICAgICBpZiAobmVzdGVkX2Nw
dV9oYXNfYXBpY19yZWdfdmlydCh2bWNzMTIpKSB7DQo+ID4gICAgICAgICAgICAgICAgIC8qDQo+
ID4gICAgICAgICAgICAgICAgICAqIEwwIG5lZWQgbm90IGludGVyY2VwdCByZWFkcyBmb3IgTVNS
cyBiZXR3ZWVuIDB4ODAwIGFuZCAweDhmZiwgaXQNCj4gPiBAQCAtMTE2MjYsOCArMTE2MjksNyBA
QCBzdGF0aWMgaW5saW5lIGJvb2wgbmVzdGVkX3ZteF9wcmVwYXJlX21zcl9iaXRtYXAoc3RydWN0
IGt2bV92Y3B1ICp2Y3B1LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBNU1JfSUEzMl9QUkVEX0NNRCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgTVNSX1RZUEVfVyk7DQo+ID4gDQo+ID4gLSAgICAgICBrdW5tYXAocGFnZSk7
DQo+ID4gLSAgICAgICBrdm1fcmVsZWFzZV9wYWdlX2NsZWFuKHBhZ2UpOw0KPiA+ICsgICAgICAg
a3ZtX3ZjcHVfdW5tYXAoJnRvX3ZteCh2Y3B1KS0+bmVzdGVkLm1zcl9iaXRtYXBfbWFwKTsNCj4g
PiANCj4gPiAgICAgICAgIHJldHVybiB0cnVlOw0KPiA+ICB9DQo+ID4gLS0NCj4gPiAyLjcuNA0K
PiA+IA0KPiANCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICkJlcmxpbiAt
IERyZXNkZW4gLSBBYWNoZW4KbWFpbiBvZmZpY2U6IEtyYXVzZW5zdHIuIDM4LCAxMDExNyBCZXJs
aW4KR2VzY2hhZWZ0c2Z1ZWhyZXI6IERyLiBSYWxmIEhlcmJyaWNoLCBDaHJpc3RpYW4gU2NobGFl
Z2VyClVzdC1JRDogREUyODkyMzc4NzkKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxv
dHRlbmJ1cmcgSFJCIDE0OTE3MyBCCg==

