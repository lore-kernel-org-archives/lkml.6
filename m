Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DB6C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBD920657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Kpt2cVKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBD920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbeKAWne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:43:34 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:6972 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbeKAWne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1541079633; x=1572615633;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=KeCd6o/Ju2Y1QKho1lyW6drPDc/sWWg1jEFbUo9SzMI=;
  b=Kpt2cVKY+ZwWPr2nBCLfj2dBVgdfZQzTAMpIp4h/8bfR4sHm7ch8THKV
   BOXXF6O4zmwCwdSdeGfBGq2Zj9b0pWk3f3GPbLbom5U5erl+eJdtCuh++
   tk+uWYTXBT4PXpwgJoav4LJlA2mXSf0z2yVDPEs9JitSIwxNPJZVZbiSx
   s=;
X-IronPort-AV: E=Sophos;i="5.54,452,1534809600"; 
   d="scan'208";a="702529784"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Nov 2018 13:40:32 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id wA1DeSxJ003600
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 1 Nov 2018 13:40:31 GMT
Received: from EX13D02EUB004.ant.amazon.com (10.43.166.221) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 1 Nov 2018 13:40:30 +0000
Received: from EX13D02EUB004.ant.amazon.com (10.43.166.221) by
 EX13D02EUB004.ant.amazon.com (10.43.166.221) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 1 Nov 2018 13:40:29 +0000
Received: from EX13D02EUB004.ant.amazon.com ([10.43.166.221]) by
 EX13D02EUB004.ant.amazon.com ([10.43.166.221]) with mapi id 15.00.1367.000;
 Thu, 1 Nov 2018 13:40:29 +0000
From:   "Stecklina, Julian" <jsteckli@amazon.de>
To:     "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "js@alien8.de" <js@alien8.de>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/3] kvm, vmx: move register clearing out of assembly
 path
Thread-Topic: [PATCH v2 2/3] kvm, vmx: move register clearing out of assembly
 path
Thread-Index: AQHUb53WOBPhh7i/m0C/9MDRKTcm1aU2ebkAgAR38oA=
Date:   Thu, 1 Nov 2018 13:40:29 +0000
Message-ID: <1541079629.1777.9.camel@amazon.de>
References: <74fa3809ea293cc05d37b1449b16e08480c4ddbd.1540822350.git.jsteckli@amazon.de>
         <33085f6c98496ed8094ce68855b49851abb86406.1540822350.git.jsteckli@amazon.de>
         <20181029172608.GB27762@linux.intel.com>
In-Reply-To: <20181029172608.GB27762@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.116]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D825498576DA74698656C57BA50716B@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTEwLTI5IGF0IDEwOjI2IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBJIHRoaW5rIGl0J3MgYSBnb29kIGlkZWEgdG8gZXhwbGljaXRseSBjYWxsIG91dCB0
aGF0IGNsZWFyaW5nIHRoZQ0KPiBHUFJzDQo+IGlzIGRvbmUgdG8gcHJldmVudCBzcGVjdWxhdGl2
ZSB1c2UuwqAgU2ltcGx5IHN0YXRpbmcgdGhhdCB3ZSBkb24ndA0KPiB3YW50DQo+IHRvIGxldCBn
dWVzdCByZWdpc3RlciB2YWx1ZXMgc3Vydml2ZSBkb2Vzbid0IGV4cGxhaW4gKndoeSouDQo+IA0K
PiBXaGF0IGFib3V0Og0KPiANCj4gwqDCoMKgwqDCoMKgwqDCoC8qDQo+IMKgwqDCoMKgwqDCoMKg
wqAgKiBFeHBsaWNpdGx5IGNsZWFyIChpbiBhZGRpdGlvbiB0byBtYXJraW5nIHRoZW0gYXMNCj4g
Y2xvYmJlcmVkKSBhbGwgR1BScw0KPiDCoMKgwqDCoMKgwqDCoMKgICogdGhhdCBoYXZlIG5vdCBi
ZWVuIGxvYWRlZCB3aXRoIGhvc3Qgc3RhdGUgdG8gcHJldmVudA0KPiBzcGVjdWxhdGl2ZWx5DQo+
IMKgwqDCoMKgwqDCoMKgwqAgKiB1c2luZyB0aGUgZ3Vlc3QncyB2YWx1ZXMuDQo+IMKgwqDCoMKg
wqDCoMKgwqAgKi8NCg0KU291bmRzIGdvb2QuIEkndmUgYWxzbyB1cGRhdGVkIHRoZSBjb21taXQg
bWVzc2FnZSBmb3IgdGhlIHJlZ2lzdGVyDQpjbGVhcmluZyBjb21taXQuIEknbGwgcmVwb3N0IHRo
ZSBwYXRjaGVzLg0KDQpKdWxpYW4KCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55
IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocmVyOiBDaHJp
c3RpYW4gU2NobGFlZ2VyLCBSYWxmIEhlcmJyaWNoClVzdC1JRDogREUgMjg5IDIzNyA4NzkKRWlu
Z2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgSFJCIDE0OTE3MyBCCgo=

