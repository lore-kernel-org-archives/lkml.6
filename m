Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF28C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7563720657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="uEQG3MmB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7563720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeJ2WgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 18:36:10 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:50559 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbeJ2WgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 18:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1540820845; x=1572356845;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=FkJjE6x2eM7uxy0HzCkJVRtFQz9rw+PxzavUsRGqAF0=;
  b=uEQG3MmB6PAhyuEyFYP3etQPTDl7wV09YVjVQvayvURIe57SbEIJR5W9
   I9cCoNWTRXe7FAKWt4AgqV2maBa8zkiuqg+CQDqkAM/GaU/yOQgN4mX6J
   O1cILQFBRNEBKdyJ0Sj6MhVoakC6S28E7kuCTUHUWwhxMlZEnawNLl1gU
   E=;
X-IronPort-AV: E=Sophos;i="5.54,440,1534809600"; 
   d="scan'208";a="701909052"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Oct 2018 13:47:23 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9TDlKdx042511
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 29 Oct 2018 13:47:21 GMT
Received: from EX13D02EUB004.ant.amazon.com (10.43.166.221) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 29 Oct 2018 13:47:21 +0000
Received: from EX13D02EUB004.ant.amazon.com (10.43.166.221) by
 EX13D02EUB004.ant.amazon.com (10.43.166.221) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 29 Oct 2018 13:47:20 +0000
Received: from EX13D02EUB004.ant.amazon.com ([10.43.166.221]) by
 EX13D02EUB004.ant.amazon.com ([10.43.166.221]) with mapi id 15.00.1367.000;
 Mon, 29 Oct 2018 13:47:20 +0000
From:   "Stecklina, Julian" <jsteckli@amazon.de>
To:     "jmattson@google.com" <jmattson@google.com>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "js@alien8.de" <js@alien8.de>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH 2/4] kvm, vmx: move register clearing out of assembly path
Thread-Topic: [PATCH 2/4] kvm, vmx: move register clearing out of assembly
 path
Thread-Index: AQHUa3O1cLtfMUrYb0CeweNt8u7kDqUxrymAgAAMS4CABIl2gA==
Date:   Mon, 29 Oct 2018 13:47:19 +0000
Message-ID: <1540820839.10039.9.camel@amazon.de>
References: <09986c98c9655f1542768ecfda644ac821e67a57.1540369608.git.jsteckli@amazon.de>
         <558fea0b4df498eefcaea5ae07a089ad9706c1a2.1540369608.git.jsteckli@amazon.de>
         <20181026154617.GA23663@linux.intel.com>
         <CALMp9eTtB1te3kyHxZjm244BwdVKrVrjOTgiLufQFwD8Y2g_LQ@mail.gmail.com>
In-Reply-To: <CALMp9eTtB1te3kyHxZjm244BwdVKrVrjOTgiLufQFwD8Y2g_LQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.116]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4CB3CB39932AD4BA49150825154ADBE@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTEwLTI2IGF0IDA5OjMwIC0wNzAwLCBKaW0gTWF0dHNvbiB3cm90ZToNCj4g
T24gRnJpLCBPY3QgMjYsIDIwMTggYXQgODo0NiBBTSwgU2VhbiBDaHJpc3RvcGhlcnNvbg0KPiA8
c2Vhbi5qLmNocmlzdG9waGVyc29uQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiA+IEFuZCBGV0lX
LCBJIGZpbmQgdGhlIG9yaWdpbmFsIGNvZGUgdG8gYmUgbW9yZSByZWFkYWJsZSBzaW5jZSBhbGwN
Cj4gPiBHUlBzDQo+ID4gYXJlIHplcm9lZCB3aXRoIHRoZSBzYW1lIG1ldGhvZC4NCj4gSSBjb25j
dXIuIEkgcmVhbGx5IGRvIHByZWZlciB0aGUgZXhwbGljaXQgeG9ycyB0byB0aGUgaW5wdXQNCj4g
YXJndW1lbnRzLg0KDQpBQ0suIFdpbGwgcmUtcG9zdCB3aXRoIHhvciBmb3IgZXZlcnl0aGluZy4N
Cg0KSnVsaWFuCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICkJlcmxpbiAt
IERyZXNkZW4gLSBBYWNoZW4KbWFpbiBvZmZpY2U6IEtyYXVzZW5zdHIuIDM4LCAxMDExNyBCZXJs
aW4KR2VzY2hhZWZ0c2Z1ZWhyZXI6IERyLiBSYWxmIEhlcmJyaWNoLCBDaHJpc3RpYW4gU2NobGFl
Z2VyClVzdC1JRDogREUyODkyMzc4NzkKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxv
dHRlbmJ1cmcgSFJCIDE0OTE3MyBCCg==

