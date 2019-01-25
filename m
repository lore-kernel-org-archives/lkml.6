Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B464C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C5E218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="DQp+acS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbfAYSP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:15:27 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:35231 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAYSP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1548440126; x=1579976126;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=vGjKOQI5/ob+hqK1OsxIZTixzODznyMub5Jpts98BdY=;
  b=DQp+acS2VGb1CpUo2Is6mncXwFVGqzCtaVIPNNN8fCfyGsSF29vfmcil
   K3I1HgMj/+k3/4uEIttpwTshmBUW10mntBWBqbgFI1cD4gwTQM+Ht014a
   IJIBULwTiUEwMjl0elaSmmS1Y06TRZeTmeyHRiSGriGpGvFEqi7VNK4uN
   g=;
X-IronPort-AV: E=Sophos;i="5.56,522,1539648000"; 
   d="scan'208";a="655612772"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 25 Jan 2019 18:15:23 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id 825D7A2104;
        Fri, 25 Jan 2019 18:15:22 +0000 (UTC)
Received: from EX13D01EUB002.ant.amazon.com (10.43.166.113) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 25 Jan 2019 18:15:21 +0000
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13D01EUB002.ant.amazon.com (10.43.166.113) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 25 Jan 2019 18:15:20 +0000
Received: from EX13D01EUB003.ant.amazon.com ([10.43.166.248]) by
 EX13D01EUB003.ant.amazon.com ([10.43.166.248]) with mapi id 15.00.1367.000;
 Fri, 25 Jan 2019 18:15:20 +0000
From:   "Raslan, KarimAllah" <karahmed@amazon.de>
To:     "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH v5 08/13] KVM/nVMX: Use kvm_vcpu_map when mapping the
 posted interrupt descriptor table
Thread-Topic: [PATCH v5 08/13] KVM/nVMX: Use kvm_vcpu_map when mapping the
 posted interrupt descriptor table
Thread-Index: AQHUp/+gt9LV+gtAbUCeOhZ2udvwFaW9O9WAgAMoB4A=
Date:   Fri, 25 Jan 2019 18:15:20 +0000
Message-ID: <1548440119.17444.22.camel@amazon.de>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
         <1547026933-31226-9-git-send-email-karahmed@amazon.de>
         <20190123180314.GM19289@Konrads-MacBook-Pro.local>
In-Reply-To: <20190123180314.GM19289@Konrads-MacBook-Pro.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.122]
Content-Type: text/plain; charset="utf-8"
Content-ID: <032C8D38147FEC4CB7DE812E5883C618@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTAxLTIzIGF0IDEzOjAzIC0wNTAwLCBLb25yYWQgUnplc3p1dGVrIFdpbGsg
d3JvdGU6DQo+IE9uIFdlZCwgSmFuIDA5LCAyMDE5IGF0IDEwOjQyOjA4QU0gKzAxMDAsIEthcmlt
QWxsYWggQWhtZWQgd3JvdGU6DQo+ID4gDQo+ID4gVXNlIGt2bV92Y3B1X21hcCB3aGVuIG1hcHBp
bmcgdGhlIHBvc3RlZCBpbnRlcnJ1cHQgZGVzY3JpcHRvciB0YWJsZSBzaW5jZQ0KPiA+IHVzaW5n
IGt2bV92Y3B1X2dwYV90b19wYWdlKCkgYW5kIGttYXAoKSB3aWxsIG9ubHkgd29yayBmb3IgZ3Vl
c3QgbWVtb3J5DQo+ID4gdGhhdCBoYXMgYSAic3RydWN0IHBhZ2UiLg0KPiA+IA0KPiA+IE9uZSBh
ZGRpdGlvbmFsIHNlbWFudGljIGNoYW5nZSBpcyB0aGF0IHRoZSB2aXJ0dWFsIGhvc3QgbWFwcGlu
ZyBsaWZlY3ljbGUNCj4gPiBoYXMgY2hhbmdlZCBhIGJpdC4gSXQgbm93IGhhcyB0aGUgc2FtZSBs
aWZldGltZSBvZiB0aGUgcGlubmluZyBvZiB0aGUNCj4gPiBpbnRlcnJ1cHQgZGVzY3JpcHRvciB0
YWJsZSBwYWdlIG9uIHRoZSBob3N0IHNpZGUuDQo+IA0KPiBJcyB0aGUgZGVzY3JpcHRpb24gc3Rh
bGU/IEkgYW0gbm90IHNlZWluZyBob3cgeW91IGFyZSBjaGFuZ2luZyB0aGUNCj4gc2VtYW50aWNz
IGhlcmUuIFlvdSBmb2xsb3cgdGhlIHNhbWUgcGF0aCAtIG1hcC91bm1hcC4NCj4gDQo+IENvdWxk
IHlvdSBleHBhbmQgcGxlYXNlPw0KDQpUaGlzIGlzIHByZXR0eSBtdWNoIHRoZSBzYW1lIGNhc2Ug
YXMgaW4gNy8xMywgaXQncyBqdXN0IHR3byBkaWZmZXJlbnQNCmxpZmUtY3ljbGUgY2hhbmdlcyBh
bmQgSSBkcm9wcGVkIG9uZSBvZiB0aGVtIGFuZCB0aGUgb3RoZXIgb25lIGlzIHN0aWxsIHRoZXJl
IDpEDQoNCj4gDQo+ID4gDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogS2FyaW1BbGxhaCBBaG1l
ZCA8a2FyYWhtZWRAYW1hem9uLmRlPg0KPiA+IC0tLQ0KPiA+IHY0IC0+IHY1Og0KPiA+IC0gdW5t
YXAgd2l0aCBkaXJ0eSBmbGFnDQo+ID4gDQo+ID4gdjEgLT4gdjI6DQo+ID4gLSBEbyBub3QgY2hh
bmdlIHRoZSBsaWZlY3ljbGUgb2YgdGhlIG1hcHBpbmcgKHBib256aW5pKQ0KCgoKQW1hem9uIERl
dmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGlu
Ckdlc2NoYWVmdHNmdWVocmVyOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBSYWxmIEhlcmJyaWNoClVz
dC1JRDogREUgMjg5IDIzNyA4NzkKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRl
bmJ1cmcgSFJCIDE0OTE3MyBCCgo=

