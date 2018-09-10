Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692BEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD0A20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD0A20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbeIJSo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:44:29 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:48074 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728174AbeIJSo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:44:29 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-169-9L54WFFCOlO7I9psQ73vIQ-1; Mon, 10 Sep 2018 14:50:14 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 10 Sep 2018 14:52:24 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 10 Sep 2018 14:52:24 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: RE: [PATCH] x86/mce: Fix set_mce_nospec() to avoid #GP fault
Thread-Topic: [PATCH] x86/mce: Fix set_mce_nospec() to avoid #GP fault
Thread-Index: AQHUQOLbJZKdT6aCk0K6fMWYHKQ8V6Tpl4tA
Date:   Mon, 10 Sep 2018 13:52:24 +0000
Message-ID: <74a1ec83d9f44875b86d84f52d65a32c@AcuMS.aculab.com>
References: <20180830214517.29372-1-tony.luck@intel.com>
 <CA+55aFxVQqnFVQaCYHbnWnt3kBfVkLWgNvKFkf6qgDWCSDNpEg@mail.gmail.com>
 <CA+8MBbLKWj0RVM5astYB7_htJZ0203cQ65BWJO_o4=WDWn2kAw@mail.gmail.com>
 <CA+55aFy+R8pw1aX84cGNBNbtDgOMANXqX3+-MxAbLZRnUj=0vg@mail.gmail.com>
In-Reply-To: <CA+55aFy+R8pw1aX84cGNBNbtDgOMANXqX3+-MxAbLZRnUj=0vg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 9L54WFFCOlO7I9psQ73vIQ-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gLi4uDQo+IFlvdSBjb3VsZCBsaXRlcmFsbHkgZG8gc29t
ZXRoaW5nIGxpa2UNCj4gDQo+ICAgICAvKiBNYWtlIGl0IGNhbm9uaWNhbCBpbiBjYXNlIHdlIGZs
aXBwZWQgdGhlIGhpZ2ggYml0ICovDQo+ICAgICBhZGRyID0gKGxvbmcpKGFkZHI8PDEpPj4xOw0K
DQpJc24ndCBpdCBzYWZlciB0byB1c2UgYSBtYXNrIGFuZCBsZXQgdGhlIGNvbXBpbGVyIGRlY2lk
ZSBpZiB0d28NCnNoaWZ0cyBhcmUgYSBnb29kIGltcGxlbWVudGF0aW9uPw0KDQoJYWRkciAmPSB+
SElHSF9NQUdJQ19CSVQ7DQoNCklTVFIgZml4aW5nIGEgYnVnIGluIGdsZCB3aGVyZSBpdCBoYWQg
KGZvbyA8PCAxNikgPj4gMTYgaW5zdGVhZA0Kb2YgZm9vICYgMHhmZmZmLiBEaWRuJ3Qgd29yayB3
ZWxsIG9uIDY0Yml0Lg0KDQooSSBtYXkgbmVlZCB0byByZWNvbXBpbGUgdGhhdCBvbGQgZ2NjL2ds
ZCBhZ2Fpbi4NCkZhaWxlZCBtaXNlcmFibHkgbGFzdCB0aW1lIEkgdHJpZWQuKQ0KDQoJRGF2aWQN
Cg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZh
cm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYg
KFdhbGVzKQ0K

