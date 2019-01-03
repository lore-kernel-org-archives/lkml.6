Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B59C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BB3217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="vqXzi80G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbfACOW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 09:22:59 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:23024 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730973AbfACOW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 09:22:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1546525377; x=1578061377;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=lDWpza8izP6JIy79ZwQhnTO5YT+PBiEqanbfTet6ikU=;
  b=vqXzi80G6gbyltGhEqi1I2IKr0bpxdNPCu7ZTq6o738QqjVF2HlPy4fh
   LUTaZ3vmHPYP8xf727HNG3eUydHAe7VYFLlEdDFywqWgJ1UwvfdyRTT7G
   Zi5UyPrB28qdEXVG5xmTMRgJ0n1lFgkzwiD6nuRkBZnoYUeUXsyT7b5r8
   A=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="711243941"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Jan 2019 14:22:55 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x03EMr0X035327
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 3 Jan 2019 14:22:54 GMT
Received: from EX13D01EUB004.ant.amazon.com (10.43.166.180) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 3 Jan 2019 14:22:53 +0000
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13D01EUB004.ant.amazon.com (10.43.166.180) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 3 Jan 2019 14:22:52 +0000
Received: from EX13D01EUB003.ant.amazon.com ([10.43.166.248]) by
 EX13D01EUB003.ant.amazon.com ([10.43.166.248]) with mapi id 15.00.1367.000;
 Thu, 3 Jan 2019 14:22:52 +0000
From:   "Raslan, KarimAllah" <karahmed@amazon.de>
To:     "jmattson@google.com" <jmattson@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v4 02/14] X86/nVMX: handle_vmptrld: Copy the VMCS12
 directly from guest memory
Thread-Topic: [PATCH v4 02/14] X86/nVMX: handle_vmptrld: Copy the VMCS12
 directly from guest memory
Thread-Index: AQHUiur4YqH4TBA7MEeCfI/G20dAJKVwyXcAgBiiCACAFF5KAA==
Date:   Thu, 3 Jan 2019 14:22:52 +0000
Message-ID: <1546525372.11779.11.camel@amazon.de>
References: <1543829467-18025-1-git-send-email-karahmed@amazon.de>
         <1543829467-18025-3-git-send-email-karahmed@amazon.de>
         <CALMp9eSX99cd3-XCCJOySVPXwxt=fx0zOczzq0ictDFNU1rqNw@mail.gmail.com>
         <8a2a3b3d-b16c-890c-e6cd-69fbfc06506a@redhat.com>
In-Reply-To: <8a2a3b3d-b16c-890c-e6cd-69fbfc06506a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.227]
Content-Type: text/plain; charset="utf-8"
Content-ID: <695688FC0A71D349BBD596FBCF191D86@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTEyLTIxIGF0IDE2OjIwICswMTAwLCBQYW9sbyBCb256aW5pIHdyb3RlOg0K
PiBPbiAwNi8xMi8xOCAwMDoxMCwgSmltIE1hdHRzb24gd3JvdGU6DQo+ID4gDQo+ID4gT24gTW9u
LCBEZWMgMywgMjAxOCBhdCAxOjMxIEFNIEthcmltQWxsYWggQWhtZWQgPGthcmFobWVkQGFtYXpv
bi5kZT4gd3JvdGU6DQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gQ29weSB0aGUgVk1DUzEyIGRpcmVj
dGx5IGZyb20gZ3Vlc3QgbWVtb3J5IGluc3RlYWQgb2YgdGhlIG1hcC0+Y29weS0+dW5tYXANCj4g
PiA+IHNlcXVlbmNlLiBUaGlzIGFsc28gYXZvaWRzIHVzaW5nIGt2bV92Y3B1X2dwYV90b19wYWdl
KCkgYW5kIGttYXAoKSB3aGljaA0KPiA+ID4gYXNzdW1lcyB0aGF0IHRoZXJlIGlzIGEgInN0cnVj
dCBwYWdlIiBmb3IgZ3Vlc3QgbWVtb3J5Lg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBL
YXJpbUFsbGFoIEFobWVkIDxrYXJhaG1lZEBhbWF6b24uZGU+DQo+ID4gPiAtLS0NCj4gPiA+IHYz
IC0+IHY0Og0KPiA+ID4gLSBSZXR1cm4gVk1YRVJSX1ZNUFRSTERfSU5DT1JSRUNUX1ZNQ1NfUkVW
SVNJT05fSUQgb24gZmFpbHVyZSAoam1hdHRzb25AKQ0KPiA+ID4gdjEgLT4gdjI6DQo+ID4gPiAt
IE1hc3NhZ2UgY29tbWl0IG1lc3NhZ2UgYSBiaXQuDQo+ID4gPiAtLS0NCj4gPiA+ICBhcmNoL3g4
Ni9rdm0vdm14LmMgfCAyNCArKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+
IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vdm14LmMgYi9hcmNoL3g4Ni9rdm0vdm14LmMNCj4g
PiA+IGluZGV4IGI4NGYyMzAuLjc1ODE3Y2IgMTAwNjQ0DQo+ID4gPiAtLS0gYS9hcmNoL3g4Ni9r
dm0vdm14LmMNCj4gPiA+ICsrKyBiL2FyY2gveDg2L2t2bS92bXguYw0KPiA+ID4gQEAgLTkzMDEs
MjAgKzkzMDEsMjIgQEAgc3RhdGljIGludCBoYW5kbGVfdm1wdHJsZChzdHJ1Y3Qga3ZtX3ZjcHUg
KnZjcHUpDQo+ID4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIDE7DQo+ID4gPiANCj4gPiA+ICAg
ICAgICAgaWYgKHZteC0+bmVzdGVkLmN1cnJlbnRfdm1wdHIgIT0gdm1wdHIpIHsNCj4gPiA+IC0g
ICAgICAgICAgICAgICBzdHJ1Y3Qgdm1jczEyICpuZXdfdm1jczEyOw0KPiA+ID4gLSAgICAgICAg
ICAgICAgIHN0cnVjdCBwYWdlICpwYWdlOw0KPiA+ID4gLSAgICAgICAgICAgICAgIHBhZ2UgPSBr
dm1fdmNwdV9ncGFfdG9fcGFnZSh2Y3B1LCB2bXB0cik7DQo+ID4gPiAtICAgICAgICAgICAgICAg
aWYgKGlzX2Vycm9yX3BhZ2UocGFnZSkpDQo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICBy
ZXR1cm4gbmVzdGVkX3ZteF9mYWlsSW52YWxpZCh2Y3B1KTsNCj4gPiA+ICsgICAgICAgICAgICAg
ICBzdHJ1Y3Qgdm1jczEyICpuZXdfdm1jczEyID0gKHN0cnVjdCB2bWNzMTIgKilfX2dldF9mcmVl
X3BhZ2UoR0ZQX0tFUk5FTCk7DQo+ID4gPiArDQo+ID4gPiArICAgICAgICAgICAgICAgaWYgKCFu
ZXdfdm1jczEyIHx8DQo+ID4gPiArICAgICAgICAgICAgICAgICAgIGt2bV9yZWFkX2d1ZXN0KHZj
cHUtPmt2bSwgdm1wdHIsIG5ld192bWNzMTIsDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHNpemVvZigqbmV3X3ZtY3MxMikpKSB7DQo+ID4gDQo+ID4gSXNuJ3QgdGhp
cyBhIGxvdCBzbG93ZXIgdGhhbiBrbWFwKCkgd2hlbiB0aGVyZSBpcyBhIHN0cnVjdCBwYWdlPw0K
PiANCj4gSXQgd291bGRuJ3QgYmUgc2xvd2VyIGlmIGhlIHJlYWQgZGlyZWN0bHkgaW50byBjYWNo
ZWRfdm1jczEyLiAgSG93ZXZlciwNCj4gYXMgaXQgaXMgbm93LCBpdCdzIGRvaW5nIHR3byByZWFk
cyBpbnN0ZWFkIG9mIG9uZS4gIEJ5IGRvaW5nIHRoaXMsIHRoZQ0KPiBFTk9NRU0gY2FzZSBhbHNv
IGRpc2FwcGVhcnMuDQoNCkkgY2FuIG5vdCB1c2UgImNhY2hlZF92bWNzMTIiIGRpcmVjdGx5IGhl
cmUgYmVjYXVzZSBpdHMgb2xkIGNvbnRlbnRzIHdpbGwgYmXCoA0KdXNlZCBmb3IgIm5lc3RlZF9y
ZWxlYXNlX3ZtY3MxMiguLikiIGEgZmV3IGxpbmVzIGJlbG93IChpLmUuIGl0IHdpbGwgYmUgZmx1
c2hlZMKgDQppbnRvIGd1ZXN0IG1lbW9yeSkuDQoNCkkgY2FuIGp1c3Qgc3dpdGNoIHRoaXMgdG8g
dGhlIG5ldyBBUEkgaW50cm9kdWNlZCBhIGZldyBwYXRjaGVzIGxhdGVyIGFuZCB0aGF0wqANCndv
dWxkIGhhdmUgdGhlIHNhbWUgc2VtYW50aWNzIGZvciBub3JtYWwgdXNlLWNhc2VzIGFzIGJlZm9y
ZS4NCg0KPiANCj4gUGFvbG8NCgoKCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBH
bWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJlcjogQ2hyaXN0
aWFuIFNjaGxhZWdlciwgUmFsZiBIZXJicmljaApVc3QtSUQ6IERFIDI4OSAyMzcgODc5CkVpbmdl
dHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIEhSQiAxNDkxNzMgQgoK

