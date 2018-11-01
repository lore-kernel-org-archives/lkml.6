Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0A8C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D0220657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="FKpQCR9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D0220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeKARF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 13:05:28 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:26936 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeKARF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 13:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1541059412; x=1572595412;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=eqaB+Q0mJR+3MBSUh6poXoGqYhoHGOdz3ljPNRBa2QU=;
  b=FKpQCR9OIVbMvuP523y0Oysl/uykg2YP+HNLOwxiO1ksM6zjimj/Sd04
   LyGCrVEtNVok4k/7s/lsNxON0JUbbwQHAtHURTHw09UsqjXgEBPQjhKWV
   o1dwYMX+H5EJV1wLHWep1CdtvwkpqlwOQIjxuZKxee4NqxgCqrW90yoac
   k=;
X-IronPort-AV: E=Sophos;i="5.54,451,1534809600"; 
   d="scan'208";a="743756187"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Nov 2018 08:03:31 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id wA183UGo016449
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 1 Nov 2018 08:03:30 GMT
Received: from EX13D08EUC004.ant.amazon.com (10.43.164.176) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 1 Nov 2018 08:03:29 +0000
Received: from [10.28.86.8] (10.43.161.195) by EX13D08EUC004.ant.amazon.com
 (10.43.164.176) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 1 Nov
 2018 08:03:24 +0000
Subject: Re: [PATCH] fs: fix lost error code in dio_complete
To:     "Shah, Amit" <aams@amazon.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>, "hch@lst.de" <hch@lst.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Dannowski, Uwe" <uwed@amazon.de>,
        "Mehlan, Torsten" <tomeh@amazon.de>
References: <20181030215739.4557-1-mheyne@amazon.de>
 <1540977883.6429.74.camel@amazon.com>
From:   Maximilian Heyne <mheyne@amazon.de>
Message-ID: <38013dfb-f0af-bdc1-3547-c53ff6ecd58e@amazon.de>
Date:   Thu, 1 Nov 2018 09:03:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540977883.6429.74.camel@amazon.com>
Content-Language: en-US
X-Originating-IP: [10.43.161.195]
X-ClientProxiedBy: EX13D03UWA002.ant.amazon.com (10.43.160.144) To
 EX13D08EUC004.ant.amazon.com (10.43.164.176)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMzEvMTggMTA6MjQgQU0sIFNoYWgsIEFtaXQgd3JvdGU6Cj4gT24gRGksIDIwMTgtMTAt
MzAgYXQgMjE6NTcgKzAwMDAsIE1heGltaWxpYW4gSGV5bmUgd3JvdGU6Cj4+IFsuLi5dCj4+Cj4+
IGRpZmYgLS1naXQgYS9mcy9kaXJlY3QtaW8uYyBiL2ZzL2RpcmVjdC1pby5jCj4+IGluZGV4IDA5
M2ZiNTRjZDMxNi4uMTk5MTQ2MDM2MDkzIDEwMDY0NAo+PiAtLS0gYS9mcy9kaXJlY3QtaW8uYwo+
PiArKysgYi9mcy9kaXJlY3QtaW8uYwo+PiBAQCAtMzI1LDggKzMyNSw4IEBAIHN0YXRpYyBzc2l6
ZV90IGRpb19jb21wbGV0ZShzdHJ1Y3QgZGlvICpkaW8sIHNzaXplX3QgcmV0LCB1bnNpZ25lZCBp
bnQgZmxhZ3MpCj4+ICDCoAkJwqAqLwo+PiAgwqAJCWRpby0+aW9jYi0+a2lfcG9zICs9IHRyYW5z
ZmVycmVkOwo+PiAgIAo+PiAtCQlpZiAoZGlvLT5vcCA9PSBSRVFfT1BfV1JJVEUpCj4+IC0JCQly
ZXQgPSBnZW5lcmljX3dyaXRlX3N5bmMoZGlvLT5pb2NiLMKgwqB0cmFuc2ZlcnJlZCk7Cj4+ICsJ
CWlmIChyZXQgPiAwICYmIGRpby0+b3AgPT0gUkVRX09QX1dSSVRFKQo+PiArCQkJcmV0ID0gZ2Vu
ZXJpY193cml0ZV9zeW5jKGRpby0+aW9jYiwgcmV0KTsKPiBJcyB0aGUgcy90cmFuc2ZlcnJlZC9y
ZXQvIGNoYW5nZSBuZWNlc3Nhcnk/IMKgTmVlZHMgZXhwbGFpbmluZywgYXQgbGVhc3QuCgpJbiBh
biBhYm92ZSBjb2RlIGxpbmUgYHJldGAgaXMgc2V0IHRvIGB0cmFuc2ZlcnJlZGAuIFNvIHRoZSBj
aGFuZ2UgaXMKYSBubyBvcC4gSG93ZXZlciwgaW4gbXkgb3BpbmlvbiB0aGUgY29uc3RydWN0IHRo
ZW4gbG9va3MgY2xlYW5lci4KCj4+ICDCoAkJZGlvLT5pb2NiLT5raV9jb21wbGV0ZShkaW8tPmlv
Y2IsIHJldCwgMCk7Cj4+ICDCoAl9Cj4+ICAgCj4gVGhhbmtzLAo+Cj4KPgo+IAkJCQlBbWl0CgoK
CkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEw
MTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJlcjogQ2hyaXN0aWFuIFNjaGxhZWdlciwgUmFsZiBI
ZXJicmljaApVc3QtSUQ6IERFIDI4OSAyMzcgODc5CkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0
IENoYXJsb3R0ZW5idXJnIEhSQiAxNDkxNzMgQgoK

