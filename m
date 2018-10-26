Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FDEC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47CF20848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="npJyyVed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47CF20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbeJZTIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:08:07 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:11523 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeJZTIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1540549894; x=1572085894;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=PaPzrc3gL6WBNX3f2i2jLNaxg1/fSZejRqXSKogjyHo=;
  b=npJyyVed4lqJBLSwHaVPoK5XjzX+SXviIkLxbmplKGvXu4apXIL3Gu7U
   G8VBoKCTC47Kdr3oooSkexI269NFjt0oOPS1nbhuP5D6sl6Ibjswcxo1u
   dtTHnJBo0zdDfXwyHh9W/BDeim65uz2DMqO8OVYK6EbRJAoJwvEojAcYy
   I=;
X-IronPort-AV: E=Sophos;i="5.54,427,1534809600"; 
   d="scan'208";a="761423110"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Oct 2018 10:31:30 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w9QAVRU0008353
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 26 Oct 2018 10:31:28 GMT
Received: from EX13D02EUB002.ant.amazon.com (10.43.166.170) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 26 Oct 2018 10:31:28 +0000
Received: from EX13D02EUB004.ant.amazon.com (10.43.166.221) by
 EX13D02EUB002.ant.amazon.com (10.43.166.170) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 26 Oct 2018 10:31:27 +0000
Received: from EX13D02EUB004.ant.amazon.com ([10.43.166.221]) by
 EX13D02EUB004.ant.amazon.com ([10.43.166.221]) with mapi id 15.00.1367.000;
 Fri, 26 Oct 2018 10:31:27 +0000
From:   "Stecklina, Julian" <jsteckli@amazon.de>
To:     "jmattson@google.com" <jmattson@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "js@alien8.de" <js@alien8.de>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH 2/4] kvm, vmx: move register clearing out of assembly path
Thread-Topic: [PATCH 2/4] kvm, vmx: move register clearing out of assembly
 path
Thread-Index: AQHUa3O1cLtfMUrYb0CeweNt8u7kDqUwMBoAgAEnFwA=
Date:   Fri, 26 Oct 2018 10:31:26 +0000
Message-ID: <1540549886.30273.54.camel@amazon.de>
References: <09986c98c9655f1542768ecfda644ac821e67a57.1540369608.git.jsteckli@amazon.de>
         <558fea0b4df498eefcaea5ae07a089ad9706c1a2.1540369608.git.jsteckli@amazon.de>
         <CALMp9eQBhz1fzN4z=oMy5X9OKN3JxNyiD4GBYbH+fhen_aP6Ww@mail.gmail.com>
In-Reply-To: <CALMp9eQBhz1fzN4z=oMy5X9OKN3JxNyiD4GBYbH+fhen_aP6Ww@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.116]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAC48DCDFD4DD54EA409258BC8A08209@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTEwLTI1IGF0IDA5OjU1IC0wNzAwLCBKaW0gTWF0dHNvbiB3cm90ZToNCj4g
TG9va2luZyBhdCB0aGUgc2Vjb25kIGFzbSBzdGF0ZW1lbnQgYW5kIHRoZSBjb21tZW50IHRoYXQg
cHJlY2VkZXMgaXQsDQo+IG15IGZpcnN0IHF1ZXN0aW9uIHdvdWxkIGJlLCAiV2hhdCBhYm91dCB0
aGUgcmVnaXN0ZXJzIG5vdCBjb3ZlcmVkDQo+IGhlcmU/Ig0KDQpHb29kIHBvaW50LiBJJ2xsIG1h
a2UgdGhlIGNvbW1lbnQgYSBiaXQgY2xlYXJlci4NCg0KPiAgSSdtIGFsc28gbm90IGNvbnZpbmNl
ZCB0aGF0IHRoZSByZWdpc3Rlci1jbGVhcmluZyBhc20gc3RhdGVtZW50DQo+IGlzIGFjdHVhbGx5
ICJjbGVhcmVyIiB3aXRoIHNvbWUgcmVnaXN0ZXJzIGNsZWFyZWQgYXMgaW5wdXQgYXJndW1lbnRz
DQo+IGFuZCBvdGhlcnMgY2xlYXJlZCBleHBsaWNpdGx5LCBidXQgb3RoZXJ3aXNlLCB0aGUgY2hh
bmdlIGxvb2tzIGZpbmUNCj4gdG8NCj4gbWUuDQoNClRoZSBpbmxpbmUgYXNzZW1ibHkgaXRzZWxm
IG1heSBub3QgYmUgY2xlYXJlciwgYnV0IGl0IGhhcyBhIHNpbmdsZQ0KcHVycG9zZSBub3cuIFlv
dSBhcmUgZnJlZSB0byBpZ25vcmUgaXQgaWYgeW91IHdhbnQgdG8gY2hhbmdlIGFzcGVjdHMgb2YN
CnRoZSBWTSBlbnRyeSBwYXRoLiBJdCBhbG1vc3QgZml0cyBvbiBhIHNpbmdsZSBzY3JlZW4gbm93
LiA7KQ0KDQo+IA0KPiBSZXZpZXdlZC1ieTogSmltIE1hdHRzb24gPGptYXR0c29uQGdvb2dsZS5j
b20+DQoNClRoYW5rcyENCkp1bGlhbgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkg
R21iSApCZXJsaW4gLSBEcmVzZGVuIC0gQWFjaGVuCm1haW4gb2ZmaWNlOiBLcmF1c2Vuc3RyLiAz
OCwgMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocmVyOiBEci4gUmFsZiBIZXJicmljaCwgQ2hy
aXN0aWFuIFNjaGxhZWdlcgpVc3QtSUQ6IERFMjg5MjM3ODc5CkVpbmdldHJhZ2VuIGFtIEFtdHNn
ZXJpY2h0IENoYXJsb3R0ZW5idXJnIEhSQiAxNDkxNzMgQgo=

