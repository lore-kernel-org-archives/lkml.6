Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283ECC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81CD2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="S9UgYfoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81CD2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbeIXUs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:48:29 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:15528 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeIXUs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1537800359; x=1569336359;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=0DI+O59Dhkb0SPwEqcPUpxX1y8iSLvfYTy+WDtv+TlU=;
  b=S9UgYfoV4+XSrqhPggKs58Ijjb95HOofJCJcf2UymZLMmY14V+Ki+EXH
   1bNIX5dhjoxLkFW/iqvwDkfVeUStDrT71pKYSEAegHB4+k2W+suQLaPbY
   16KWvYRf2qyrmgYYmEojtvpahfcp2JNnJYgVXKN1eG/q7VNCT09LsIniL
   M=;
X-IronPort-AV: E=Sophos;i="5.54,298,1534809600"; 
   d="scan'208";a="760017054"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 24 Sep 2018 14:45:45 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w8OEje7B058834
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 24 Sep 2018 14:45:43 GMT
Received: from EX13D08UEE001.ant.amazon.com (10.43.62.126) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 24 Sep 2018 14:45:42 +0000
Received: from EX13D02EUB004.ant.amazon.com (10.43.166.221) by
 EX13D08UEE001.ant.amazon.com (10.43.62.126) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 24 Sep 2018 14:45:42 +0000
Received: from EX13D02EUB004.ant.amazon.com ([10.43.166.221]) by
 EX13D02EUB004.ant.amazon.com ([10.43.166.221]) with mapi id 15.00.1367.000;
 Mon, 24 Sep 2018 14:45:41 +0000
From:   "Stecklina, Julian" <jsteckli@amazon.de>
To:     "khalid.aziz@oracle.com" <khalid.aziz@oracle.com>
CC:     "juerg.haefliger@hpe.com" <juerg.haefliger@hpe.com>,
        "deepa.srinivasan@oracle.com" <deepa.srinivasan@oracle.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "pradeep.vincent@oracle.com" <pradeep.vincent@oracle.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
        "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
        "liran.alon@oracle.com" <liran.alon@oracle.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "keescook@google.com" <keescook@google.com>,
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
Thread-Index: AQHUTmwG79KNqwwvs0u9NBSNsaJp1qT2qd0AgAjj0oA=
Date:   Mon, 24 Sep 2018 14:45:41 +0000
Message-ID: <1537800341.9745.20.camel@amazon.de>
References: <CA+55aFxyUdhYjnQdnmWAt8tTwn4HQ1xz3SAMZJiawkLpMiJ_+w@mail.gmail.com>
         <ciirm8a7p3alos.fsf@u54ee758033e858cfa736.ant.amazon.com>
         <CA+55aFzHj_GNZWG4K2oDu4DPP9sZdTZ9PY7sBxGB6WoN9g8d=A@mail.gmail.com>
         <ciirm8zhwyiqh4.fsf@u54ee758033e858cfa736.ant.amazon.com>
         <ciirm8efdy916l.fsf@u54ee758033e858cfa736.ant.amazon.com>
         <5efc291c-b0ed-577e-02d1-285d080c293d@oracle.com>
         <ciirm8va743105.fsf@u54ee758033e858cfa736.ant.amazon.com>
         <7221975d-6b67-effa-2747-06c22c041e78@oracle.com>
In-Reply-To: <7221975d-6b67-effa-2747-06c22c041e78@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.20]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5DA42683F56B14396B5512A9BB52777@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA5LTE4IGF0IDE3OjAwIC0wNjAwLCBLaGFsaWQgQXppeiB3cm90ZToNCj4g
SSB0ZXN0ZWQgdGhlIGtlcm5lbCB3aXRoIHRoaXMgbmV3IGNvZGUuIFdoZW4gYm9vdGVkIHdpdGhv
dXQNCj4gInhwZm90bGJmbHVzaCIswqANCj4gdGhlcmUgaXMgbm8gbWVhbmluZ2Z1bCBjaGFuZ2Ug
aW4gc3lzdGVtIHRpbWUgd2l0aCBrZXJuZWwgY29tcGlsZS4gDQoNClRoYXQncyBnb29kIG5ld3Mh
IFNvIHRoZSBsb2NrIG9wdGltaXphdGlvbnMgc2VlbSB0byBoZWxwLg0KDQo+IEtlcm5lbMKgDQo+
IGxvY2tzIHVwIGR1cmluZyBib290dXAgd2hlbiBib290ZWQgd2l0aCB4cGZvdGxiZmx1c2g6DQoN
CkkgZGlkbid0IHRlc3QgdGhlIHZlcnNpb24gd2l0aCBUTEIgZmx1c2hlcywgYmVjYXVzZSBpdCdz
IGNsZWFyIHRoYXQgdGhlDQpvdmVyaGVhZCBpcyBzbyBiYWQgdGhhdCBubyBvbmUgd2FudHMgdG8g
dXNlIHRoaXMuDQoNCkl0IHNob3VsZG4ndCBsb2NrIHVwIHRob3VnaCwgc28gbWF5YmUgdGhlcmUg
aXMgc3RpbGwgYSByYWNlIGNvbmRpdGlvbg0Kc29tZXdoZXJlLiBJJ2xsIGdpdmUgdGhpcyBhIHNw
aW4gb24gbXkgZW5kIGxhdGVyIHRoaXMgd2Vlay4NCg0KVGhhbmtzIGZvciB0cnlpbmcgdGhpcyBv
dXQhDQoNCkp1bGlhbg0KQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKQmVy
bGluIC0gRHJlc2RlbiAtIEFhY2hlbgptYWluIG9mZmljZTogS3JhdXNlbnN0ci4gMzgsIDEwMTE3
IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJlcjogRHIuIFJhbGYgSGVyYnJpY2gsIENocmlzdGlhbiBT
Y2hsYWVnZXIKVXN0LUlEOiBERTI4OTIzNzg3OQpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBD
aGFybG90dGVuYnVyZyBIUkIgMTQ5MTczIEIK

