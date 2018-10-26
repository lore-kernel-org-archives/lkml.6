Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C93C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D3420856
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Wb8Yy+ex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D3420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeJZTXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:23:07 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:26278 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeJZTXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1540550792; x=1572086792;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=ORp/XVASi2AcCv+XbeRYAYwAHQoPkODZjv4SOpZ56JE=;
  b=Wb8Yy+exH3tv8nvz8Af8SmivqJd53SFoUkP09cZ7NbuULHy5Q1RhA1/g
   GdgZ8ZHMsXv8ZxCq5GyAMCgpluArXd2PsNxlLDvx4nqrsyhlhIV7a5iJx
   J71ZICLL5kBkOtdMiH1A1FHtqIBcwC6lN7Ev5o/DxOV4WMNA46NMZZBB7
   Y=;
X-IronPort-AV: E=Sophos;i="5.54,427,1534809600"; 
   d="scan'208";a="365265880"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-5f221cf9.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Oct 2018 10:46:30 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-5f221cf9.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9QAkPqi108394
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 26 Oct 2018 10:46:29 GMT
Received: from EX13D02EUB003.ant.amazon.com (10.43.166.172) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 26 Oct 2018 10:46:28 +0000
Received: from EX13D02EUB004.ant.amazon.com (10.43.166.221) by
 EX13D02EUB003.ant.amazon.com (10.43.166.172) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 26 Oct 2018 10:46:27 +0000
Received: from EX13D02EUB004.ant.amazon.com ([10.43.166.221]) by
 EX13D02EUB004.ant.amazon.com ([10.43.166.221]) with mapi id 15.00.1367.000;
 Fri, 26 Oct 2018 10:46:27 +0000
From:   "Stecklina, Julian" <jsteckli@amazon.de>
To:     "digitaleric@google.com" <digitaleric@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "js@alien8.de" <js@alien8.de>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH 4/4] kvm, vmx: remove manually coded vmx instructions
Thread-Topic: [PATCH 4/4] kvm, vmx: remove manually coded vmx instructions
Thread-Index: AQHUa3O3GA+Z/mnhIUqSgNiYqJzNRKUuq6mAgAKvuQA=
Date:   Fri, 26 Oct 2018 10:46:27 +0000
Message-ID: <1540550786.30273.55.camel@amazon.de>
References: <09986c98c9655f1542768ecfda644ac821e67a57.1540369608.git.jsteckli@amazon.de>
         <ba8f4a02e90f1dc95a900f6a34caddce40a358d4.1540369608.git.jsteckli@amazon.de>
         <CAG7+5M39QBY1dkBjkJ9N4_9f1b1B6Hfqzg1Oh1mMp8N=dk7ZgQ@mail.gmail.com>
In-Reply-To: <CAG7+5M39QBY1dkBjkJ9N4_9f1b1B6Hfqzg1Oh1mMp8N=dk7ZgQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.116]
Content-Type: text/plain; charset="utf-8"
Content-ID: <187C0CFCC7302548871A853D71B95752@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTEwLTI0IGF0IDEwOjQ0IC0wNzAwLCBFcmljIE5vcnRodXAgd3JvdGU6DQo+
IFRoaXMgbG9zZXMgdGhlIGV4Y2VwdGlvbiBoYW5kbGluZyBmcm9tIF9fZXgqIC0+DQo+IF9fX19r
dm1faGFuZGxlX2ZhdWx0X29uX3JlYm9vdC4NCj4gDQo+IElmIGRlbGliZXJhdGUsIHRoaXMgc2hv
dWxkIGJlIGNhbGxlZCBvdXQgaW4gY2hhbmdlbG9nLsKgIEhhcyB0aGUgcmFjZQ0KPiB3aGljaCBj
b21taXQgNGVjYWMzZmQgZml4ZWQgYmVlbiBtaXRpZ2F0ZWQgb3RoZXJ3aXNlPw0KDQpObywgdGhp
cyB3YXMgbm90IGRlbGliZXJhdGUuIFdpbGwgZml4Lg0KDQpUaGFua3MhDQpKdWxpYW4KQW1hem9u
IERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKQmVybGluIC0gRHJlc2RlbiAtIEFhY2hl
bgptYWluIG9mZmljZTogS3JhdXNlbnN0ci4gMzgsIDEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVl
aHJlcjogRHIuIFJhbGYgSGVyYnJpY2gsIENocmlzdGlhbiBTY2hsYWVnZXIKVXN0LUlEOiBERTI4
OTIzNzg3OQpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyBIUkIgMTQ5
MTczIEIK

