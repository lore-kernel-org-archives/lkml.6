Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063E5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE20F20823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FEbbIzH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE20F20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbeKSVyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:54:07 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:37602 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbeKSVyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:54:07 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id E4D6010C157C;
        Mon, 19 Nov 2018 03:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542627046; bh=ZfSNFTMhXq7rMFHsVK+5upk6zDW+uXul6PpyKYHI0KI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=FEbbIzH8kyT0RyFw+xOtDqvRZVKxzEQbdFXeuDd/RxVxmL5erelzqBvbuuAo7H8uB
         dr9gLCwr5tI4kvTcOkNwehGY3coFrqosYf9dRJMFK0aP7PSWogY/gatHzmD7xfOFQo
         ssKWbzQ6XlFiLx2hiwXJ6vNosfRj8Fr9+do1JuSrOvqxDAqsdb7gRGY2v2SaqMOUvd
         aa07DcvH2ES5SLKcccQph0dAd+5BovboQDXOtPE/kjvzxvpepZI81pQPHasSn1H5W2
         9Bwwj45gGxVOtM5uIsMR/UBxPZZn0v+CazY+oRWCHRpgacSYhqTQD7pTyZfCfs7uyr
         nhOfRPsZ1+OuQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id D378248E6;
        Mon, 19 Nov 2018 03:30:46 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 19 Nov 2018 03:30:31 -0800
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon,
 19 Nov 2018 12:30:30 +0100
From:   Alexey Brodkin <alexey.brodkin@synopsys.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vineet.gupta1@synopsys.com" <vineet.gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH v2] clocksource/drivers/arc_timer: Utilize generic
 sched_clock
Thread-Topic: [PATCH v2] clocksource/drivers/arc_timer: Utilize generic
 sched_clock
Thread-Index: AQHUZgzUjKESBok63Em0jiA3zZIBcaVBTesAgBOe34CAAguUgIAAA0kAgAADeoCAAADlgIAAGacA
Date:   Mon, 19 Nov 2018 11:30:29 +0000
Message-ID: <550d684014e46c9f93f249dd61702cfb0e7efdda.camel@synopsys.com>
References: <20181017113020.7551-1-abrodkin@synopsys.com>
         <C2D7FE5348E1B147BCA15975FBA23075012B0B1A07@US01WEMBX2.internal.synopsys.com>
         <78ccbb4c-56d0-594b-4032-3eb19202847b@linaro.org>
         <2c46ab6e-f0a9-4857-9772-f3c714284e98@linaro.org>
         <dab866a50e66e73f6010de1487b06019887930c8.camel@synopsys.com>
         <40ada5b3-5824-51fd-501f-ef363f162047@linaro.org>
         <e31a11c42c21353963bd75c88493e8158316d469.camel@synopsys.com>
         <6bb98a9c-899e-ee9c-d630-da07382c1c16@linaro.org>
In-Reply-To: <6bb98a9c-899e-ee9c-d630-da07382c1c16@linaro.org>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.2 (3.30.2-2.fc29) 
x-originating-ip: [10.121.8.88]
Content-Type: text/plain; charset="utf-8"
Content-ID: <33D6BC3959126147B95BFD750D6C2DC0@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuaWVsLA0KDQpPbiBNb24sIDIwMTgtMTEtMTkgYXQgMTA6NTggKzAxMDAsIERhbmllbCBM
ZXpjYW5vIHdyb3RlOg0KPiBIaSBBbGV4ZXksDQo+IA0KPiBPbiAxOS8xMS8yMDE4IDEwOjU1LCBB
bGV4ZXkgQnJvZGtpbiB3cm90ZToNCj4gPiBIaSBEYW5pZWwsDQo+IA0KPiBbIC4uLiBdDQo+IA0K
PiA+ID4gPiBJbiB0aGF0IGNhc2UgZG8gSSB1bmRlcnN0YW5kIGNvcnJlY3RseSB0aGF0IHdlIG1h
eSBlbmFibGUgR0VORVJJQ19TQ0hFRF9DTE9DSw0KPiA+ID4gPiBmb3IgQVJDIGV2ZW4gYmVmb3Jl
IHByb3Bvc2VkIGNoYW5nZSBmb3IgYXJjX3RpbWVyLmMgZ2V0cyBtZXJnZWQgLSBpLmUuIHdpdGgg
bm8NCj4gPiA+ID4gc3BlY2lhbCBHRU5FUklDX1NDSEVEX0NMT0NLIGRyaXZlciB3ZSdsbCBzYWZl
bHkgZmFsbC1iYWNrIHRvIGppZmZpZS1iYXNlZA0KPiA+ID4gPiBzY2hlZCBjbG9jayB3aGljaCB3
ZSBhbnl3YXlzIHVzZSBub3cgd2hlbiBHRU5FUklDX1NDSEVEX0NMT0NLIGlzIGRpc2FibGVkLCBy
aWdodD8NCj4gPiA+IA0KPiA+ID4gVGhlIEFSQydzIEtjb25maWcgcGFydCBkb2VzIG5vdCBhcHBs
eSBvbiB0aXAvdGltZXJzL2NvcmUuDQo+ID4gDQo+ID4gTWF5IEkgaGF2ZSBhIHJlZmVyZW5jZSB0
byB0aGF0IHRyZWUgc28gSSBtYXkgY2hlY2sgd2hhdCBnZXRzIGluIHRoZSB3YXkgdGhlcmUNCj4g
PiBhbmQgdGhlbiBJJ2xsIGp1c3QgbW92ZSAic2VsZWN0IEdFTkVSSUNfU0NIRURfQ0xPQ0siIGEg
Yml0IGJlbG93IHNvIHRoZXJlJ3JlIG5vDQo+ID4gY2xhc2hlcyBhbnkgbG9uZ2VyLg0KPiANCj4g
c3VyZSwgaGVyZSBpdCBpczoNCj4gDQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNv
bS92Mi91cmw/dT1odHRwcy0zQV9fZ2l0Lmtlcm5lbC5vcmdfcHViX3NjbV9saW51eF9rZXJuZWxf
Z2l0X3RpcF90aXAuZ2l0X2xvZ18tM0ZoLTNEdGltZXJzX2NvcmUmZD1Ed0lEYVEmYz1EUEw2X1hf
NkprWEZ4N0FYV3FCMHRnJnI9bHFkZWVTU0VlczBHRkREbDY1NmVWaVhPN2JyZVM1NXl0V2tocGs1
UjgxSSZtPXIyaEp0ZGpwUGkyWTF5RG83d2dvN25LdTdNVjhNVThnUlBnM0REMW1jeUkmcz1OT1Ra
WkJkMjVWbGs4LWptTVVIeHRwRWhmeGxrYW5YZHZLTjMtSFFTYzl3JmU9DQoNCldlbGwgSSBkaWQg
aGF2ZSBpdCBiYXNlZCBvbiA0LjE4IGZvciBzb21lIHJlYXNvbiB0aHVzIHdlcmUgdGhvc2UgY2xh
c2hlcy4NClJlYmFzZWQgb24gdG9wIG9mIExpbnVzJyB1cC10by1kYXRlIHRyZWUgYW5kIHJlLXNl
bnQgdjMuDQoNCi1BbGV4ZXkNCg==
