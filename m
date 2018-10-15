Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C142DC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0F120881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0F120881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbeJOVOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:14:55 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:47839 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726400AbeJOVOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:14:55 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-102-AacqesiJN_enSY7JE16yMw-1; Mon, 15 Oct 2018 14:29:32 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 15 Oct 2018 14:29:34 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 15 Oct 2018 14:29:34 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jan Kiszka' <jan.kiszka@siemens.com>,
        Andy Lutomirski <luto@kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Juergen Gross" <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Borislav Petkov" <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>
Subject: RE: [PATCH] x86/entry/32: Fix setup of CS high bits
Thread-Topic: [PATCH] x86/entry/32: Fix setup of CS high bits
Thread-Index: AQHUZIg/yQ6B+q0q+U+ZSylJUAi8AKUgSDAg///xBwCAABNHwA==
Date:   Mon, 15 Oct 2018 13:29:34 +0000
Message-ID: <b3e6472fba2f4c5494dddc3ac48aba9b@AcuMS.aculab.com>
References: <1531906876-13451-1-git-send-email-joro@8bytes.org>
 <1531906876-13451-11-git-send-email-joro@8bytes.org>
 <97421241-2bc4-c3f1-4128-95b3e8a230d1@siemens.com>
 <35a24feb-5970-aa03-acbf-53428a159ace@web.de>
 <CALCETrWveao7jthnfKr5F=UyEpyowP0VA20eZi5OxizgT05EDA@mail.gmail.com>
 <406a08c7-6199-a32d-d385-c032fb4c34d6@siemens.com>
 <a16919d7e6504ad59a0fad828690bcb9@AcuMS.aculab.com>
 <1246b176-02bf-3c04-5470-69333951263b@siemens.com>
In-Reply-To: <1246b176-02bf-3c04-5470-69333951263b@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: AacqesiJN_enSY7JE16yMw-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSmFuIEtpc3prYQ0KPiBPbiAxNS4xMC4xOCAxNToxNCwgRGF2aWQgTGFpZ2h0IHdyb3Rl
Og0KPiA+IEZyb206IEphbiBLaXN6a2ENCj4gPj4gU2VudDogMTUgT2N0b2JlciAyMDE4IDE0OjA5
DQo+ID4gLi4uDQo+ID4+PiBUaG9zZSBmaWVsZHMgYXJlIGdlbnVpbmVseSAxNiBiaXQuICBTbyB0
aGUgY29tbWVudCBzaG91bGQgc2F5DQo+ID4+PiBzb21ldGhpbmcgbGlrZSAiVGhvc2UgaGlnaCBi
aXRzIGFyZSB1c2VkIGZvciBDU19GUk9NX0VOVFJZX1NUQUNLIGFuZA0KPiA+Pj4gQ1NfRlJPTV9V
U0VSX0NSMyIuDQo+ID4+DQo+ID4+IC8qDQo+ID4+ICAgICogVGhlIGhpZ2ggYml0cyBvZiB0aGUg
Q1MgZHdvcmQgKF9fY3NoKSBhcmUgdXNlZCBmb3INCj4gPj4gICAgKiBDU19GUk9NX0VOVFJZX1NU
QUNLIGFuZCBDU19GUk9NX1VTRVJfQ1IzLiBDbGVhciB0aGVtIGluIGNhc2UNCj4gPj4gICAgKiBo
YXJkd2FyZSBkaWRuJ3QgZG8gdGhpcyBmb3IgdXMuDQo+ID4+ICAgICovDQo+ID4NCj4gPiBXaGF0
J3MgYSAnZHdvcmQnID8gOi0pDQo+ID4NCj4gPiBPbiBhIDMyYml0IHByb2Nlc3NvciBhICd3b3Jk
JyB3aWxsIGJlIDMyIGJpdHMgdG8gYSAnZG91YmxlLXdvcmQnDQo+ID4gd291bGQgYmUgNjQgYml0
cy4NCj4gPiBPbmUgb2YgdGhlIHdvcnN0IG5hbWVzIHRvIHVzZS4NCj4gDQo+IFRoYXQncyBpYTMy
IG5vbWVuY2xhdHVyZTogYSBkb3VibGV3b3JkIChkd29yZCkgaXMgYSAzMi1iaXQgdmFsdWUuDQoN
CkkgdGhpbmsgeW91IG1pc3NlZCB0aGUgOi0pDQpJIGRvbid0IHRoaW5rIGxpbnV4IHVzZXMgdGhh
dCB0ZXJtIHZlcnkgb2Z0ZW4uDQoNCkFueSBndWVzc2VzIGFzIHRvIHdoYXQgdHlwZSBEV09SRF9Q
VFIgaXM/DQooaW4gYSB3ZWxsIGtub3cgNjRiaXQgZW52aXJvbm1lbnQgdGhhdCB1c2VzIFVQUEVS
X0NBU0UgZm9yIHR5cGVzKS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

