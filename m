Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABD9C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C950218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="UV5ruoF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfAYSBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:01:34 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:52728 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbfAYSBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1548439291; x=1579975291;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding;
  bh=095PLFhWA/Jzbjx3HRt/g3YFhw3Kkid+i06jsWqW61A=;
  b=UV5ruoF4TF6a9OxAd8D41aNLacZ6OsxlmOktu6x7jhgh6VUGGQ3GkSm4
   aFRJZBRFG3bD3oCzGEIg1s76RkqsD4FZC8BLr44jbE2YOsCpwB1vHr1fG
   J+p2tLW2p5MdH5C1w9dLeY1YIYhD5wnhaULs/pzhZeSoFgZclV0Bq1GK7
   8=;
X-IronPort-AV: E=Sophos;i="5.56,522,1539648000"; 
   d="scan'208";a="378221507"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-17c49630.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Jan 2019 18:01:30 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-17c49630.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x0PI1Svg071694
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 25 Jan 2019 18:01:30 GMT
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 25 Jan 2019 18:01:28 +0000
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 25 Jan 2019 18:01:27 +0000
Received: from EX13D01EUB003.ant.amazon.com ([10.43.166.248]) by
 EX13D01EUB003.ant.amazon.com ([10.43.166.248]) with mapi id 15.00.1367.000;
 Fri, 25 Jan 2019 18:01:27 +0000
From:   "Raslan, KarimAllah" <karahmed@amazon.de>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "david@redhat.com" <david@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>
Subject: Re: [PATCH v5 04/13] KVM: Introduce a new guest mapping API
Thread-Topic: [PATCH v5 04/13] KVM: Introduce a new guest mapping API
Thread-Index: AQHUp/+fIW2FwIMK7UGPk3GrajXzfaWoesQAgBflNwA=
Date:   Fri, 25 Jan 2019 18:01:26 +0000
Message-ID: <1548439286.17444.14.camel@amazon.de>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
         <1547026933-31226-5-git-send-email-karahmed@amazon.de>
         <4e9a23bb-bf13-33e5-8d00-1bb5a59e91bb@redhat.com>
In-Reply-To: <4e9a23bb-bf13-33e5-8d00-1bb5a59e91bb@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.122]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF2A780882EC3E41B101BEA58A442636@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTAxLTEwIGF0IDE0OjA3ICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gT24gMDkuMDEuMTkgMTA6NDIsIEthcmltQWxsYWggQWhtZWQgd3JvdGU6DQo+ID4gDQo+
ID4gSW4gS1ZNLCBzcGVjaWFsbHkgZm9yIG5lc3RlZCBndWVzdHMsIHRoZXJlIGlzIGEgZG9taW5h
bnQgcGF0dGVybiBvZjoNCj4gPiANCj4gPiAJPT4gbWFwIGd1ZXN0IG1lbW9yeSAtPiBkb19zb21l
dGhpbmcgLT4gdW5tYXAgZ3Vlc3QgbWVtb3J5DQo+ID4gDQo+ID4gSW4gYWRkaXRpb24gdG8gYWxs
IHRoaXMgdW5uZWNlc3NhcmlseSBub2lzZSBpbiB0aGUgY29kZSBkdWUgdG8gYm9pbGVyIHBsYXRl
DQo+ID4gY29kZSwgbW9zdCBvZiB0aGUgdGltZSB0aGUgbWFwcGluZyBmdW5jdGlvbiBkb2VzIG5v
dCBwcm9wZXJseSBoYW5kbGUgbWVtb3J5DQo+ID4gdGhhdCBpcyBub3QgYmFja2VkIGJ5ICJzdHJ1
Y3QgcGFnZSIuIFRoaXMgbmV3IGd1ZXN0IG1hcHBpbmcgQVBJIGVuY2Fwc3VsYXRlDQo+ID4gbW9z
dCBvZiB0aGlzIGJvaWxlciBwbGF0ZSBjb2RlIGFuZCBhbHNvIGhhbmRsZXMgZ3Vlc3QgbWVtb3J5
IHRoYXQgaXMgbm90DQo+ID4gYmFja2VkIGJ5ICJzdHJ1Y3QgcGFnZSIuDQo+ID4gDQo+ID4gVGhl
IGN1cnJlbnQgaW1wbGVtZW50YXRpb24gb2YgdGhpcyBBUEkgaXMgdXNpbmcgbWVtcmVtYXAgZm9y
IG1lbW9yeSB0aGF0IGlzDQo+ID4gbm90IGJhY2tlZCBieSBhICJzdHJ1Y3QgcGFnZSIgd2hpY2gg
d291bGQgbGVhZCB0byBhIGh1Z2Ugc2xvdy1kb3duIGlmIGl0DQo+ID4gd2FzIHVzZWQgZm9yIGhp
Z2gtZnJlcXVlbmN5IG1hcHBpbmcgb3BlcmF0aW9ucy4gVGhlIEFQSSBkb2VzIG5vdCBoYXZlIGFu
eQ0KPiA+IGVmZmVjdCBvbiBjdXJyZW50IHNldHVwcyB3aGVyZSBndWVzdCBtZW1vcnkgaXMgYmFj
a2VkIGJ5IGEgInN0cnVjdCBwYWdlIi4NCj4gPiBGdXJ0aGVyIHBhdGNoZXMgYXJlIGdvaW5nIHRv
IGFsc28gaW50cm9kdWNlIGEgcGZuLWNhY2hlIHdoaWNoIHdvdWxkDQo+ID4gc2lnbmlmaWNhbnRs
eSBpbXByb3ZlIHRoZSBwZXJmb3JtYW5jZSBvZiB0aGUgbWVtcmVtYXAgY2FzZS4NCj4gPiANCj4g
PiBTaWduZWQtb2ZmLWJ5OiBLYXJpbUFsbGFoIEFobWVkIDxrYXJhaG1lZEBhbWF6b24uZGU+DQo+
ID4gLS0tDQo+ID4gdjMgLT4gdjQ6DQo+ID4gLSBVcGRhdGUgdGhlIGNvbW1pdCBtZXNzYWdlLg0K
PiA+IHYxIC0+IHYyOg0KPiA+IC0gRHJvcCB0aGUgY2FjaGluZyBvcHRpbWl6YXRpb24gKHBib256
aW5pKQ0KPiA+IC0gVXNlICdodmEnIGluc3RlYWQgb2YgJ2thZGRyJyAocGJvbnppbmkpDQo+ID4g
LSBSZXR1cm4gMC8tRUlOVkFMLy1FRkFVTFQgaW5zdGVhZCBvZiB0cnVlL2ZhbHNlLiAtRUZBVUxU
IHdpbGwgYmUgdXNlZCBmb3INCj4gPiAgIEFNRCBwYXRjaCAocGJvbnppbmkpDQo+ID4gLSBJbnRy
b2R1Y2UgX19rdm1fbWFwX2dmbiB3aGljaCBhY2NlcHRzIGEgbWVtb3J5IHNsb3QgYW5kIHVzZSBp
dCAocGJvbnppbmkpDQo+ID4gLSBPbmx5IGNsZWFyIG1hcC0+aHZhIGluc3RlYWQgb2YgbWVtc2V0
dGluZyB0aGUgd2hvbGUgc3RydWN0dXJlLg0KPiA+IC0gRHJvcCBrdm1fdmNwdV9tYXBfdmFsaWQg
c2luY2UgaXQgaXMgbm8gbG9uZ2VyIHVzZWQuDQo+ID4gLSBGaXggRVhQT1JUX01PRFVMRSBuYW1p
bmcuDQo+ID4gLS0tDQo+ID4gIGluY2x1ZGUvbGludXgva3ZtX2hvc3QuaCB8ICA5ICsrKysrKysr
DQo+ID4gIHZpcnQva3ZtL2t2bV9tYWluLmMgICAgICB8IDUzICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDYyIGlu
c2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9rdm1faG9z
dC5oIGIvaW5jbHVkZS9saW51eC9rdm1faG9zdC5oDQo+ID4gaW5kZXggYzM4Y2M1ZS4uOGEyZjVm
YSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2t2bV9ob3N0LmgNCj4gPiArKysgYi9p
bmNsdWRlL2xpbnV4L2t2bV9ob3N0LmgNCj4gPiBAQCAtMjA1LDYgKzIwNSwxMyBAQCBlbnVtIHsN
Cj4gPiAgCVJFQURJTkdfU0hBRE9XX1BBR0VfVEFCTEVTLA0KPiA+ICB9Ow0KPiA+ICANCj4gPiAr
c3RydWN0IGt2bV9ob3N0X21hcCB7DQo+ID4gKwlzdHJ1Y3QgcGFnZSAqcGFnZTsNCj4gDQo+IENh
biB5b3UgYWRkIHNvbW1lIGNvbW1lbnRzIHRvIHdoYXQgaXQgbWVhbnMgd2hlbiB0aGVyZSBpcyBh
IHBhZ2UgdnMuDQo+IHdoZW4gdGhlcmUgaXMgbm9uZT8NCj4gDQo+ID4gDQo+ID4gKwl2b2lkICpo
dmE7DQo+ID4gKwlrdm1fcGZuX3QgcGZuOw0KPiA+ICsJa3ZtX3Bmbl90IGdmbjsNCj4gPiArfTsN
Cj4gPiArDQo+ID4gIC8qDQo+ID4gICAqIFNvbWV0aW1lcyBhIGxhcmdlIG9yIGNyb3NzLXBhZ2Ug
bW1pbyBuZWVkcyB0byBiZSBicm9rZW4gdXAgaW50byBzZXBhcmF0ZQ0KPiA+ICAgKiBleGl0cyBm
b3IgdXNlcnNwYWNlIHNlcnZpY2luZy4NCj4gPiBAQCAtNzEwLDcgKzcxNyw5IEBAIHN0cnVjdCBr
dm1fbWVtc2xvdHMgKmt2bV92Y3B1X21lbXNsb3RzKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSk7DQo+
ID4gIHN0cnVjdCBrdm1fbWVtb3J5X3Nsb3QgKmt2bV92Y3B1X2dmbl90b19tZW1zbG90KHN0cnVj
dCBrdm1fdmNwdSAqdmNwdSwgZ2ZuX3QgZ2ZuKTsNCj4gPiAga3ZtX3Bmbl90IGt2bV92Y3B1X2dm
bl90b19wZm5fYXRvbWljKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgZ2ZuX3QgZ2ZuKTsNCj4gPiAg
a3ZtX3Bmbl90IGt2bV92Y3B1X2dmbl90b19wZm4oc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBnZm5f
dCBnZm4pOw0KPiA+ICtpbnQga3ZtX3ZjcHVfbWFwKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgZ3Bh
X3QgZ3BhLCBzdHJ1Y3Qga3ZtX2hvc3RfbWFwICptYXApOw0KPiA+ICBzdHJ1Y3QgcGFnZSAqa3Zt
X3ZjcHVfZ2ZuX3RvX3BhZ2Uoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBnZm5fdCBnZm4pOw0KPiA+
ICt2b2lkIGt2bV92Y3B1X3VubWFwKHN0cnVjdCBrdm1faG9zdF9tYXAgKm1hcCwgYm9vbCBkaXJ0
eSk7DQo+ID4gIHVuc2lnbmVkIGxvbmcga3ZtX3ZjcHVfZ2ZuX3RvX2h2YShzdHJ1Y3Qga3ZtX3Zj
cHUgKnZjcHUsIGdmbl90IGdmbik7DQo+ID4gIHVuc2lnbmVkIGxvbmcga3ZtX3ZjcHVfZ2ZuX3Rv
X2h2YV9wcm90KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgZ2ZuX3QgZ2ZuLCBib29sICp3cml0YWJs
ZSk7DQo+ID4gIGludCBrdm1fdmNwdV9yZWFkX2d1ZXN0X3BhZ2Uoc3RydWN0IGt2bV92Y3B1ICp2
Y3B1LCBnZm5fdCBnZm4sIHZvaWQgKmRhdGEsIGludCBvZmZzZXQsDQo+ID4gZGlmZiAtLWdpdCBh
L3ZpcnQva3ZtL2t2bV9tYWluLmMgYi92aXJ0L2t2bS9rdm1fbWFpbi5jDQo+ID4gaW5kZXggMWY4
ODhhMS4uNGQ4ZjJlMyAxMDA2NDQNCj4gPiAtLS0gYS92aXJ0L2t2bS9rdm1fbWFpbi5jDQo+ID4g
KysrIGIvdmlydC9rdm0va3ZtX21haW4uYw0KPiA+IEBAIC0xNzMzLDYgKzE3MzMsNTkgQEAgc3Ry
dWN0IHBhZ2UgKmdmbl90b19wYWdlKHN0cnVjdCBrdm0gKmt2bSwgZ2ZuX3QgZ2ZuKQ0KPiA+ICB9
DQo+ID4gIEVYUE9SVF9TWU1CT0xfR1BMKGdmbl90b19wYWdlKTsNCj4gPiAgDQo+ID4gK3N0YXRp
YyBpbnQgX19rdm1fbWFwX2dmbihzdHJ1Y3Qga3ZtX21lbW9yeV9zbG90ICpzbG90LCBnZm5fdCBn
Zm4sDQo+ID4gKwkJCSBzdHJ1Y3Qga3ZtX2hvc3RfbWFwICptYXApDQo+ID4gK3sNCj4gPiArCWt2
bV9wZm5fdCBwZm47DQo+ID4gKwl2b2lkICpodmEgPSBOVUxMOw0KPiA+ICsJc3RydWN0IHBhZ2Ug
KnBhZ2UgPSBOVUxMOw0KPiANCj4gbml0OiBJIHByZWZlciB0aGVzZSBpbiBhIGdyb3dpbmcgbGlu
ZS1sZW5ndGggZmFzaGlvbi4NCj4gDQo+ID4gDQo+ID4gKw0KPiA+ICsJcGZuID0gZ2ZuX3RvX3Bm
bl9tZW1zbG90KHNsb3QsIGdmbik7DQo+ID4gKwlpZiAoaXNfZXJyb3Jfbm9zbG90X3BmbihwZm4p
KQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiArCWlmIChwZm5fdmFsaWQocGZu
KSkgew0KPiA+ICsJCXBhZ2UgPSBwZm5fdG9fcGFnZShwZm4pOw0KPiA+ICsJCWh2YSA9IGttYXAo
cGFnZSk7DQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJCWh2YSA9IG1lbXJlbWFwKHBmbl90b19ocGEo
cGZuKSwgUEFHRV9TSVpFLCBNRU1SRU1BUF9XQik7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYg
KCFodmEpDQo+ID4gKwkJcmV0dXJuIC1FRkFVTFQ7DQo+ID4gKw0KPiA+ICsJbWFwLT5wYWdlID0g
cGFnZTsNCj4gPiArCW1hcC0+aHZhID0gaHZhOw0KPiA+ICsJbWFwLT5wZm4gPSBwZm47DQo+ID4g
KwltYXAtPmdmbiA9IGdmbjsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsN
Cj4gPiAraW50IGt2bV92Y3B1X21hcChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGdmbl90IGdmbiwg
c3RydWN0IGt2bV9ob3N0X21hcCAqbWFwKQ0KPiA+ICt7DQo+ID4gKwlyZXR1cm4gX19rdm1fbWFw
X2dmbihrdm1fdmNwdV9nZm5fdG9fbWVtc2xvdCh2Y3B1LCBnZm4pLCBnZm4sIG1hcCk7DQo+ID4g
K30NCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwoa3ZtX3ZjcHVfbWFwKTsNCj4gPiArDQo+ID4gK3Zv
aWQga3ZtX3ZjcHVfdW5tYXAoc3RydWN0IGt2bV9ob3N0X21hcCAqbWFwLCBib29sIGRpcnR5KQ0K
PiA+ICt7DQo+ID4gKwlpZiAoIW1hcC0+aHZhKQ0KPiA+ICsJCXJldHVybjsNCj4gPiArDQo+ID4g
KwlpZiAobWFwLT5wYWdlKQ0KPiA+ICsJCWt1bm1hcChtYXAtPnBhZ2UpOw0KPiA+ICsJZWxzZQ0K
PiA+ICsJCW1lbXVubWFwKG1hcC0+aHZhKTsNCj4gPiArDQo+ID4gKwlpZiAoZGlydHkpDQo+IA0K
PiANCj4gSSBhbSB3b25kZXJpbmcgaWYgdGhpcyB3b3VsZCBhbHNvIGJlIHRoZSByaWdodCBwbGFj
ZSBmb3INCj4gDQo+IGt2bV92Y3B1X21hcmtfcGFnZV9kaXJ0eSgpIHRvIG1hcmsgdGhlIHBhZ2Ug
ZGlydHkgZm9yIG1pZ3JhdGlvbi4NCg0KSSBpbmRlZWQgY29uc2lkZXJlZCB0aGlzLCBob3dldmVy
LCBlaXRoZXIgSSBhbSBtaXNzaW5nIHNvbWV0aGluZyBvciB0aGlzwqANCm1hcmtfcGFnZV9kaXJ0
eSBpcyBtaXNzaW5nIGFjY2lkZW50YWxseSBpbiBhIGNvdXBsZSBvZiBwbGFjZXMhIEZvciBleGFt
cGxlOg0KDQoxKSBXaGVuIHVubWFwcGluZyB0aGUgRVZNQ1MgcGFnZSAoaW4gbmVzdGVkX3JlbGVh
c2VfZXZtY3MpIHdoZXJlIGlzIGl0IG1hcmtlZCBhcw0KwqAgwqBkaXJ0eT8NCjIpIFRoZSBtYXBw
aW5nIGNoYW5nZXMgaW4gc3ZtLmMsIHdoZXJlIGlzIG1hcmtpbmcgaXQgZGlydHk/DQoNCkhvd2V2
ZXIsIGl0IGlzIGhhbmRsZWQgcHJvcGVybHkgaW4gdGhlIHJlc3Q6DQoNCjMpIEZvcsKgZW11bGF0
b3JfY21weGNoZ19lbXVsYXRlZCBpdCBpcyBkb25lLCBzbyBubyBwcm9ibGVtIGhlcmUuDQo0KSBU
aGUgcG9zdGVkIGludGVycnVwdHMgZm9yIEwxMiBpcyBkb25lLCBzbyBubyBwcm9ibGVtIGhlcmUu
DQo1KSBUaGUgdmlydHVhbCBhcGljIHBhZ2UgaXMgZG9uZSwgc28gbm8gcHJvYmxlbSBoZXJlLsKg
DQoNCklzIHRoZXJlIGFueSByZWFzb24gd2h5IGl0IHdvdWxkIG5vdCBiZSBuZWVkZWQgaW4gMSBh
bmQgMiBhYm92ZSBvdGhlciB0aGFuDQpiZWluZyBhIGJ1Zz8NCg0KVGhhdCBiZWluZyBzYWlkLCBn
b29kIHBvaW50LiBJIHdpbGwgbWVyZ2UgeW91ciBzdWdnZXN0aW9uIGluIHY2IHdoZW4gSSByZWJh
c2XCoA0KYWdhaW4gOikNCg0KPiANCj4gPiANCj4gPiArCQlrdm1fcmVsZWFzZV9wZm5fZGlydHko
bWFwLT5wZm4pOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCWt2bV9yZWxlYXNlX3Bmbl9jbGVhbihtYXAt
PnBmbik7DQo+ID4gKwltYXAtPmh2YSA9IE5VTEw7DQo+IA0KPiA+IA0KPiA+ICt9DQo+ID4gK0VY
UE9SVF9TWU1CT0xfR1BMKGt2bV92Y3B1X3VubWFwKTsNCj4gPiArDQo+ID4gIHN0cnVjdCBwYWdl
ICprdm1fdmNwdV9nZm5fdG9fcGFnZShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGdmbl90IGdmbikN
Cj4gPiAgew0KPiA+ICAJa3ZtX3Bmbl90IHBmbjsNCj4gPiANCj4gDQo+IA0KCgoKQW1hem9uIERl
dmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGlu
Ckdlc2NoYWVmdHNmdWVocmVyOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBSYWxmIEhlcmJyaWNoClVz
dC1JRDogREUgMjg5IDIzNyA4NzkKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRl
bmJ1cmcgSFJCIDE0OTE3MyBCCgo=

