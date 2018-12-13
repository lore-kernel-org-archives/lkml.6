Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B591C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA8F20879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Tb2J4WkE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA8F20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbeLMNgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:36:35 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:45728 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729281AbeLMNgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1544708194; x=1576244194;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding;
  bh=Lbe2paPaMLnxHpwk06gIyn2RUOgS33/6z6Ym9wl5b1Q=;
  b=Tb2J4WkELMJbOtTk3vhKSFt0V4VtnaaLwoIkVzphGnhPQMgNqX7+fu5C
   LPiYXwJct97b8M8WHIFzcpx9/N7dJOXh3l3S/WBHkLkfdrtdSXFYXjTPT
   iFJpz4l+QJ869F3uw1QIgb78Ypiy8975t1RQAUKCXVxVmG5BIqblDv4Nf
   o=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="372224611"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-3714e498.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Dec 2018 13:36:32 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-3714e498.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id wBDDaQZh020950
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 13 Dec 2018 13:36:30 GMT
Received: from EX13D02EUB002.ant.amazon.com (10.43.166.170) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 13 Dec 2018 13:36:29 +0000
Received: from EX13D02EUB004.ant.amazon.com (10.43.166.221) by
 EX13D02EUB002.ant.amazon.com (10.43.166.170) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 13 Dec 2018 13:36:28 +0000
Received: from EX13D02EUB004.ant.amazon.com ([10.43.166.221]) by
 EX13D02EUB004.ant.amazon.com ([10.43.166.221]) with mapi id 15.00.1367.000;
 Thu, 13 Dec 2018 13:36:28 +0000
From:   "Stecklina, Julian" <jsteckli@amazon.de>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ahmedsoliman0x666@gmail.com" <ahmedsoliman0x666@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "ovich00@gmail.com" <ovich00@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "igor.stoppa@gmail.com" <igor.stoppa@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "nigel.edwards@hpe.com" <nigel.edwards@hpe.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "ahmedsoliman@mena.vt.edu" <ahmedsoliman@mena.vt.edu>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "blukashev@sempervictus.com" <blukashev@sempervictus.com>
Subject: Re: [PATCH V7 0/10] KVM: X86: Introducing ROE Protection Kernel
 Hardening
Thread-Topic: [PATCH V7 0/10] KVM: X86: Introducing ROE Protection Kernel
 Hardening
Thread-Index: AQHUjixIsnZ4VYbyrkW3BFrTaBk7l6V8tVmA
Date:   Thu, 13 Dec 2018 13:36:27 +0000
Message-ID: <1544708187.5826.1.camel@amazon.de>
References: <20181207124803.10828-1-ahmedsoliman@mena.vt.edu>
In-Reply-To: <20181207124803.10828-1-ahmedsoliman@mena.vt.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.129]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5996DEAF3FAC094393A048101A131781@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWhtZWQsDQoNCk9uIEZyaSwgMjAxOC0xMi0wNyBhdCAxNDo0NyArMDIwMCwgQWhtZWQgQWJkIEVs
IE1hd2dvb2Qgd3JvdGU6DQo+IFRoZSByZWFzb24gd2h5IGl0IHdvdWxkIGJlIGJldHRlciB0byBp
bXBsZW1lbnQgdGhpcyBmcm9tIGluc2lkZSBrdm06IGluc3RlYWQNCj4gb2YNCj4gKGhvc3QpIHVz
ZXIgc3BhY2UgaXMgdGhlIG5lZWQgdG8gYWNjZXNzIFNQVEVzIHRvIG1vZGlmeSB0aGUgcGVybWlz
c2lvbnMsIHdoaWxlDQo+IG1wcm90ZWN0KCkgZnJvbSB1c2VyIHNwYWNlIGNhbiB3b3JrIGluIHRo
ZW9yeS4gSXQgd2lsbCBiZWNvbWUgYSBiaWcNCj4gcGVyZm9ybWFuY2UNCj4gaGl0IHRvIHZtZXhp
dCBhbmQgc3dpdGNoIHRvIHVzZXIgc3BhY2UgbW9kZSBvbiBlYWNoIGZhdWx0LCBvbiB0aGUgb3Ro
ZXIgaGFuZCwNCj4gaGF2aW5nIHRoZSBwZXJtaXNzaW9uIGhhbmRsZWQgYnkgRVBUIHNob3VsZCBt
YWtlIHNvbWUgcmVtYXJrYWJsZSBwZXJmb3JtYW5jZQ0KPiBnYWluLg0KDQpHaXZlbiB0aGF0IHdy
aXRlcyB0byB0aGVzZSBhcmVhcyBzaG91bGQgYmUgZXhjZXB0aW9uYWwgb2NjdXJyZW5jZXMsIEkg
ZG9uJ3QNCnVuZGVyc3RhbmQgd2h5IHRoaXMgcGF0aCBuZWVkcyB0byBiZSBvcHRpbWl6ZWQuIFRv
IG1lIGl0IHNlZW1zLCBhIHN0cmFpZ2h0LQ0KZm9yd2FyZCB1c2Vyc3BhY2UgaW1wbGVtZW50YXRp
b24gd2l0aCBubyBhZGRpdGlvbmFsIGNvZGUgaW4gdGhlIGtlcm5lbCBhY2hpZXZlcw0KdGhlIHNh
bWUgZmVhdHVyZS4gQ2FuIHlvdSBlbGFib3JhdGU/DQoNCkp1bGlhbgoKCgpBbWF6b24gRGV2ZWxv
cG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2Vz
Y2hhZWZ0c2Z1ZWhyZXI6IENocmlzdGlhbiBTY2hsYWVnZXIsIFJhbGYgSGVyYnJpY2gKVXN0LUlE
OiBERSAyODkgMjM3IDg3OQpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVy
ZyBIUkIgMTQ5MTczIEIKCg==

