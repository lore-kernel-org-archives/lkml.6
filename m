Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE56C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DA421480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="FS+MZAZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DA421480
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbeIYUU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:20:58 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:22967 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbeIYUU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1537884794; x=1569420794;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=WBP/7vcFtZRlNpAyHTgDgoOiHjfRdMwMPsL8MEdZcs4=;
  b=FS+MZAZJ+HHb6rMkOm8CyhmeMinkraja4FZHLHmrOubKe/pY14fyGol4
   kk9Fnz7j9ph3+IzQ1/rd2XU2MAv6pqxXWxoD+oB3PRc2E/fol9BMoqO7q
   /HDkGUWgDkNN2isVqOybb6dTUQNtc6ZAVES+svnVjf95rcDFnXmOyN5X/
   E=;
X-IronPort-AV: E=Sophos;i="5.54,302,1534809600"; 
   d="scan'208";a="755171417"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1d-98acfc19.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Sep 2018 14:13:09 +0000
Received: from EX13MTAUEB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w8PED1FM082016
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 25 Sep 2018 14:13:01 GMT
Received: from EX13D08UEB003.ant.amazon.com (10.43.60.11) by
 EX13MTAUEB001.ant.amazon.com (10.43.60.129) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 25 Sep 2018 14:12:59 +0000
Received: from EX13D02EUB004.ant.amazon.com (10.43.166.221) by
 EX13D08UEB003.ant.amazon.com (10.43.60.11) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 25 Sep 2018 14:12:59 +0000
Received: from EX13D02EUB004.ant.amazon.com ([10.43.166.221]) by
 EX13D02EUB004.ant.amazon.com ([10.43.166.221]) with mapi id 15.00.1367.000;
 Tue, 25 Sep 2018 14:12:58 +0000
From:   "Stecklina, Julian" <jsteckli@amazon.de>
To:     "jwadams@google.com" <jwadams@google.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>
CC:     "deepa.srinivasan@oracle.com" <deepa.srinivasan@oracle.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pradeep.vincent@oracle.com" <pradeep.vincent@oracle.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "khalid.aziz@oracle.com" <khalid.aziz@oracle.com>,
        "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
        "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
        "liran.alon@oracle.com" <liran.alon@oracle.com>,
        "keescook@google.com" <keescook@google.com>,
        "jsteckli@os.inf.tu-dresden.de" <jsteckli@os.inf.tu-dresden.de>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "tyhicks@canonical.com" <tyhicks@canonical.com>,
        "john.haxby@oracle.com" <john.haxby@oracle.com>,
        "jcm@redhat.com" <jcm@redhat.com>
Subject: Re: Redoing eXclusive Page Frame Ownership (XPFO) with isolated CPUs
 in mind (for KVM to isolate its guests per CPU)
Thread-Topic: Redoing eXclusive Page Frame Ownership (XPFO) with isolated CPUs
 in mind (for KVM to isolate its guests per CPU)
Thread-Index: AQHUT7SY79KNqwwvs0u9NBSNsaJp1qT3v4KAgAVso4CAA+gpgA==
Date:   Tue, 25 Sep 2018 14:12:57 +0000
Message-ID: <1537884777.23693.27.camel@amazon.de>
References: <20180820212556.GC2230@char.us.oracle.com>
         <CA+55aFxZCyVZc4ZpRyZ3uDyakRSOG_=2XvnwMo4oejpsieF9=A@mail.gmail.com>
         <1534801939.10027.24.camel@amazon.co.uk> <20180919010337.GC8537@350D>
         <CA+VK+GM6CaPnGKcPjEn7U=4ubtC-JWZ9k98BTxzRH_TthaFXDw@mail.gmail.com>
         <20180923023315.GF8537@350D>
In-Reply-To: <20180923023315.GF8537@350D>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.20]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4BF4A3594F63541B0C088C51CAE7501@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDE4LTA5LTIzIGF0IDEyOjMzICsxMDAwLCBCYWxiaXIgU2luZ2ggd3JvdGU6DQo+
ID4gQW5kIGluIHNvIGRvaW5nLCBzaWduaWZpY2FudGx5IHJlZHVjZXMgdGhlIGFtb3VudCBvZiBu
b24ta2VybmVsDQo+IGRhdGENCj4gPiB2dWxuZXJhYmxlIHRvIHNwZWN1bGF0aXZlIGV4ZWN1dGlv
biBhdHRhY2tzIGFnYWluc3QgdGhlIGtlcm5lbC4NCj4gPiAoYW5kIHJlZHVjZXMgd2hhdCBkYXRh
IGNhbiBiZSBsb2FkZWQgaW50byB0aGUgTDEgZGF0YSBjYWNoZSB3aGlsZQ0KPiA+IGluIGtlcm5l
bCBtb2RlLCB0byBiZSBwZWVrZWQgYXQgYnkgdGhlIHJlY2VudCBMMSBUZXJtaW5hbCBGYXVsdA0K
PiA+IHZ1bG5lcmFiaWxpdHkpLg0KPiANCj4gSSBzZWUgYW5kIHRoZXJlIGlzIG5vIHdheSBmb3Ig
Z2FkZ2V0cyB0byBpbnZva2UgdGhpcyBwYXRoIGZyb20NCj4gdXNlciBzcGFjZSB0byBtYWtlIHRo
ZWlyIHNwZWN1bGF0aW9uIHN1Y2Nlc3NmdWw/IFdlIHN0aWxsIGhhdmUgdG8NCj4gZmx1c2ggTDEs
IGluZGVwZW5lZGVudCBvZiB3aGV0aGVyIFhQRk8gaXMgZW5hYmxlZCBvciBub3QgcmlnaHQ/DQoN
Clllcy4gQW5kIGV2ZW4gd2l0aCBYUEZPIGFuZCBMMSBjYWNoZSBmbHVzaGluZyBlbmFibGVkLCB0
aGVyZSBhcmUgbW9yZQ0Kc3RlcHMgdGhhdCBuZWVkIHRvIGJlIHRha2VuIHRvIHJlbGlhYmx5IGd1
YXJkIGFnYWluc3QgaW5mb3JtYXRpb24gbGVha3MNCnVzaW5nIHNwZWN1bGF0aXZlIGV4ZWN1dGlv
bi4NCg0KU3BlY2lmaWNhbGx5LCBJJ20gbG9va2luZyBpbnRvIG1ha2luZyBjZXJ0YWluIGFsbG9j
YXRpb25zIGluIHRoZSBMaW51eA0Ka2VybmVsIHByb2Nlc3MtbG9jYWwgdG8gaGlkZSBldmVuIG1v
cmUgbWVtb3J5IGZyb20gcHJlZmV0Y2hpbmcuDQoNCkFub3RoZXIgcHV6emxlIHBpZWNlIGlzIGNv
LXNjaGVkdWxpbmcgc3VwcG9ydCB0aGF0IGlzIHJlbGV2YW50IGZvcg0Kc3lzdGVtcyB3aXRoIGVu
YWJsZWQgaHlwZXJ0aHJlYWRpbmc6wqBodHRwczovL2x3bi5uZXQvQXJ0aWNsZXMvNzY0NDYxLw0K
DQpKdWxpYW4KQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKQmVybGluIC0g
RHJlc2RlbiAtIEFhY2hlbgptYWluIG9mZmljZTogS3JhdXNlbnN0ci4gMzgsIDEwMTE3IEJlcmxp
bgpHZXNjaGFlZnRzZnVlaHJlcjogRHIuIFJhbGYgSGVyYnJpY2gsIENocmlzdGlhbiBTY2hsYWVn
ZXIKVXN0LUlEOiBERTI4OTIzNzg3OQpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90
dGVuYnVyZyBIUkIgMTQ5MTczIEIK

