Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18752C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5652C26155
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="S88YBNvF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5652C26155
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933846AbeFYVLS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:11:18 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:37170 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933206AbeFYVLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:11:15 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id AE0D724E09C8;
        Mon, 25 Jun 2018 14:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1529961074; bh=HYlZ8aUKMPP3jarlLW1r5gYo587o3q37zRuHtCY0P9E=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=S88YBNvFYT6b4GZjxIxvKzK4RzgNE07KB40MMxD6P2xBn6LYC+0l4YXyq+CKjZECt
         17I81JCshLsRqfk6qI7S1XTCjnx6efBbMKsvQ83umBE4HkdRexwgEZ9vOTZDytkIN0
         HTazrCkMfIUDDIsS7RdFwUNZBaR5qagMcAT3lj0hjuyRETFG4wpXYn0vYjkHcCP3+o
         6wJvIoGyIZeySXR9zE8FOQdaVtmwN+d0R8IwZP6St3hQ6EIN6Ivp7R9ZwNBws1BW/j
         8/QhMgIElHE2scEVzzKqvwYfVgDLhksJaeX73qNp4SYmapcA2PjWvWi+0qXM+LiVi5
         1oWHSbpCQAq2A==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 92E7058BE;
        Mon, 25 Jun 2018 14:11:14 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 25 Jun 2018 14:11:14 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon,
 25 Jun 2018 23:11:11 +0200
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH v2] ARC: Improve cmpxchg syscall implementation
Thread-Topic: [PATCH v2] ARC: Improve cmpxchg syscall implementation
Thread-Index: AQHUB9jq8dMsc+6bBU+GChFTS7/pLaRxThIAgAASyIA=
Date:   Mon, 25 Jun 2018 21:11:10 +0000
Message-ID: <6fb4e79964418dec9f1216dabaacfb59a8937134.camel@synopsys.com>
References: <20180619142205.20493-1-abrodkin@synopsys.com>
         <bc488b10-cd54-2ef8-46d6-d6c8dc20f799@synopsys.com>
In-Reply-To: <bc488b10-cd54-2ef8-46d6-d6c8dc20f799@synopsys.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.9.128.69]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6E2ADFD2516454B9C3CA5582DAAB9C1@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmluZWV0LA0KDQpPbiBNb24sIDIwMTgtMDYtMjUgYXQgMTM6MDMgLTA3MDAsIFZpbmVldCBH
dXB0YSB3cm90ZToNCj4gT24gMDYvMTkvMjAxOCAwNzoyMiBBTSwgQWxleGV5IEJyb2RraW4gd3Jv
dGU6DQo+ID4gRnJvbTogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPg0KPiA+
IA0KPiA+IGFyY191c3JfY21weGNoZyBzeXNjYWxsIGlzIHN1cHBvc2VkIHRvIGJlIHVzZWQgb24g
cGxhdGZvcm1zDQo+ID4gdGhhdCBsYWNrIHN1cHBvcnQgb2YgTG9hZC1Mb2NrZWQvU3RvcmUtQ29u
ZGl0aW9uYWwgaW5zdHJ1Y3Rpb25zDQo+ID4gaW4gaGFyZHdhcmUuIEFuZCBpbiB0aGF0IGNhc2Ug
d2UgbWltaWMgbWlzc2luZyBoYXJkd2FyZSBmZWF0dXJlcw0KPiA+IHdpdGggaGVscCBvZiBrZXJu
ZWwncyBzeWNhbGwgdGhhdCAiYXRvbWljYWxseSIgY2hlY2tzIGN1cnJlbnQNCj4gPiB2YWx1ZSBp
biBtZW1vcnkgYW5kIHRoZW4gaWYgaXQgbWF0Y2hlcyBjYWxsZXIgZXhwZWN0YXRpb24gbmV3DQo+
ID4gdmFsdWUgaXMgd3JpdHRlbiB0byB0aGF0IHNhbWUgbG9jYXRpb24uDQo+ID4gDQo+ID4gV2hh
dCdzIGltcG9ydGFudCBpbiB0aGUgZGVzY3JpcHRpb24gYWJvdmU6DQo+ID4gIC0gQ2hlY2stYW5k
LWV4Y2hhbmdlIG11c3QgYmUgImF0b21pY2FsIiB3aGljaCBtZWFucw0KPiA+ICAgIHByZWVtcHRp
b24gbXVzdCBiZSBkaXNhYmxlZCBkdXJpbmcgZW50aXJlICJ0cmFuc2FjdGlvbiINCj4gPiAgLSBE
YXRhIGFjY2Vzc2VkIGlzIGZyb20gdXNlci1zcGFjZSwgaS5lLiB3ZSdyZSBkZWFsaW5nDQo+ID4g
ICAgd2l0aCB2aXJ0dWFsIGFkZHJlc3Nlcw0KPiA+IA0KPiA+IEFuZCBpbiBjdXJyZW50IGltcGxl
bWVudGF0aW9uIHdlIGhhdmUgYSBjb3VwbGUgb2YgcHJvYmxlbXM6DQo+ID4gDQo+ID4gMS4gV2Ug
ZG8gZGlzYWJsZSBwcmVlbXByaW9uIGFyb3VuZCBfX2dldF91c2VyKCkgJiBfX3B1dF91c2VyKCkN
Cj4gPiAgICBidXQgdGhhdCBpbiBpdHMgdHVybiBkaXNhYmxlcyBwYWdlIGZhdWx0IGhhbmRsZXIu
DQo+ID4gICAgVGhhdCBtZWFucyBpZiBhIHBvaW50ZXIgdG8gdXNlcidzIGRhdGEgaGFzIG5vIG1h
cHBpbmcgaW4NCj4gPiAgICB0aGUgVExCIHdlIHdvbid0IGJlIGFibGUgdG8gYWNjZXNzIHJlcXVp
cmVkIGRhdGEuDQo+ID4gICAgSW5zdGVhZCBzb2Z0d2FyZSAiZXhjZXB0aW9uIGhhbmRsaW5nIiBj
b2RlIGZyb20gX19nZXRfdXNlcl9mbigpDQo+ID4gICAgd2lsbCByZXR1cm4gLUVGQVVMVC4NCj4g
PiANCj4gPiAyLiBXaGF0J3Mgd29yc2UgaWYgd2UncmUgZGVhbGluZyB3aXRoIGRhdGEgZnJvbSBu
b3QgeWV0IGFsbG9jYXRlZA0KPiA+ICAgIHBhZ2UgKHRoaW5rIG9mIHByZS1jb3B5LW9uLXdyaXRl
IHN0YXRlKSB3ZSdsbCBzdWNjZXNzZnVsbHkNCj4gPiAgICByZWFkIGRhdGEgYnV0IG9uIHdyaXRl
IHdlJ2xsIHNpbGVudGx5IHJldHVybiB0byB1c2VyLXNwYWNlDQo+ID4gICAgd2l0aCBjb3JyZWN0
IHJlc3VsdCAod2hpY2ggd2UgcmVhbGx5IHJlYWQganVzdCBiZWZvcmUpLiBUaGF0IGxlYWRzDQo+
ID4gICAgdG8gdmVyeSBzdHJhbmdlIHByb2JsZW1zIGluIHVzZXItc3BhY2UgYXBwIGZ1cnRoZXIg
ZG93biB0aGUgbGluZQ0KPiA+ICAgIGJlY2F1c2UgbmV3IHZhbHVlIHdhcyBuZXZlciB3cml0dGVu
IHRvIHRoZSBkZXN0aW5hdGlvbi4NCj4gPiANCj4gPiAzLiBSZWdhcmRsZXNzIG9mIHdoYXQgd2Vu
dCB3cm9uZyB3ZSdsbCByZXR1cm4gZnJvbSBzeXNjYWxsDQo+ID4gICAgYW5kIHVzZXItc3BhY2Ug
YXBwbGljYXRpb24gd2lsbCBjb250aW51ZSB0byBleGVjdXRlLg0KPiA+ICAgIEV2ZW4gaWYgdXNl
cidzIHBvaW50ZXIgd2FzIGNvbXBsZXRlbHkgYm9ndXMuDQo+ID4gICAgSW4gY2FzZSBvZiBoYXJk
d2FyZSBMTC9TQyB0aGF0IGFwcCB3b3VsZCBoYXZlIGJlZW4ga2lsbGVkDQo+ID4gICAgYnkgdGhl
IGtlcm5lbC4NCj4gPiANCj4gPiBXaXRoIHRoYXQgY2hhbmdlIHdlIGF0dGVtcHQgdG8gaW1yb3Zl
IG9uIGFsbCAzIGl0ZW1zIGFib3ZlOg0KPiA+IA0KPiA+IDEuIFdlIHN0aWxsIGRpc2FibGUgcHJl
ZW1wdGlvbiBhcm91bmQgd3JpdGUgb2YgdXNlcidzIGRhdGEgYnV0DQo+ID4gICAgaWYgd2UgaGFw
cGVuIHRvIGZhaWwgd2l0aCB3cml0ZSB3ZSdyZSBlbmFibGluZyBwcmVlbXB0aW9uDQo+ID4gICAg
YW5kIHRyeSB0byBmaXgtdXAgcGFnZSBmYXVsdCBzbyB0aGF0IHdlIGhhdmUgYSBjb3JyZWN0IHBl
cm1pc3Npb24NCj4gPiAgICBmb3Igd3JpdGluZyB1c2VyJ3MgZGF0YS4gVGhlbiByZS10cnkgYWdh
aW4gaW4gImF0b21pYyIgY29udGV4dC4NCj4gPiANCj4gPiAyLiBJZiByZWFsIHBhZ2UgZmF1bHQg
ZmFpbHMgb3IgZXZlbiBhY2Nlc3Nfb2soKSByZXR1cm5zIGZhbHNlDQo+ID4gICAgd2Ugc2VuZCBT
SUdTRUdWIHRvIHRoZSB1c2VyLXNwYWNlIHByb2Nlc3Mgc28gaWYgc29tZXRoaW5nIGdvZXMNCj4g
PiAgICBzZXJpb3VzbHkgd3Jvbmcgd2UnbGwga25vdyBhYm91dCBpdCBtdWNoIGVhcmxpZXIuDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQu
b3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXhleSBCcm9ka2luIDxhYnJvZGtpbkBzeW5vcHN5
cy5jb20+DQo+ID4gQ2M6IFZpbmVldCBHdXB0YSA8dmd1cHRhQHN5bm9wc3lzLmNvbT4NCj4gPiBD
YzogTWF4IEZpbGlwcG92IDxqY212YmtiY0BnbWFpbC5jb20+DQo+ID4gQ2M6IGxpbnV4LWFyY2hA
dmdlci5rZXJuZWwub3JnDQo+ID4gLS0tDQo+ID4gDQo+ID4gQ2hhbmdlcyB2MSAtPiB2MjoNCj4g
PiANCj4gPiAgKiBQZXRlcidzIGFsbW9zdCBjbGVhbi1yb29tIHJlaW1wbG1lbnRhdGlvbiB3aXRo
IGxlc3MgcGFyYW5vaWQgY2hlY2tzDQo+ID4gICAgYW5kIGRpcmVjdCBpbnZvY2F0aW9uIG9mIGZp
eHVwX3VzZXJfZmF1bHQoKSBmb3IgaW4tcGxhY2UgdXBkYXRlIG9mDQo+ID4gICAgd3JpdGUgcGVy
bWlzc2lvbnMuDQo+ID4gDQo+IA0KPiBJIGRvbid0IGxpa2UgdGhlIGNoYW5nZWxvZyAtIGl0IGlz
IHdheSB0b28gdmVyYm9zZSBhbmQgZG9lc24ndCBzYXkgdGhlIGV4YWN0DQo+IHByb2JsZW0gd2Ug
YXJlIHRyeWluZyB0byBzb2x2ZS4gSG93IGFib3V0IHNvbWV0aGluZyBsaWtlIGJlbG93ID8NCj4g
DQo+IC0tLS0tPg0KPiANCj4gICAgIEFSQzogSW1wcm92ZSBjbXB4Y2hnIHN5c2NhbGwgaW1wbGVt
ZW50YXRpb24NCj4gICAgDQo+ICAgICBUaGlzIGlzIHVzZWQgaW4gY29uZmlncyBsYWNraW5nIGhh
cmR3YXJlIGF0b21pY3MgdG8gZW11bGF0ZSBhdG9taWMgci1tLXcNCj4gICAgIGZvciB1c2VyIHNw
YWNlLCBpbXBsZW1lbnRlZCBieSBkaXNhYmxpbmcgcHJlZW1wdGlvbiBpbiBrZXJuZWwuDQo+ICAg
IA0KPiAgICAgSG93ZXZlciB0aGVyZSBhcmUgaXNzdWVzIGluIGN1cnJlbnQgaW1wbGVtZW50YXRp
b246DQo+ICAgIA0KPiAgICAgMS4gUHJvY2VzcyBub3QgdGVybWluYXRlZCBpZiBpbnZhbGlkIHVz
ZXIgcG9pbnRlciBwYXNzZWQ6DQo+ICAgICAgICBpLmUuIF9fZ2V0X3VzZXIoKSBmYWlsZWQuDQo+
ICAgIA0KPiAgICAgMi4gVGhlIHJlYXNvbiBmb3IgdGhpcyBwYXRjaCB3YXMgX19wdXRfdXNlcigp
IGZhaWx1cmUgbm90IGJlaW5nIGhhbmRsZWQsDQo+ICAgICAgICBmb3IgQ09XIGJyZWFrIHNjZW5h
cmlvLiBUaGUgemVybyBwYWdlIGlzIGluaXRpYWxseSB3aXJlZCB1cCBhbmQNCj4gICAgICAgIHJl
YWQgYnkgX19nZXRfdXNlcigpIHN1Y2NlZWRzLiBIb3dldmVyIGEgd3JpdGUgYnkgX19wdXRfdXNl
cigpDQo+ICAgICAgICBkb2Vzbid0IGNvbXBsZXRlIHRoZSBwYWdlIGZhdWx0IGhhbmRsaW5nIGR1
ZSB0byB0aGUgcGFnZSBmYXVsdA0KPiAgICAgICAgZGlzYWJsaW5nIGZyb20gcHJlZW1wdCBkaXNh
YmxlLiBBbmQgd2hhdCdzIHdvcnNlIGlzIHdlIHNpbGVudGx5IHJldHVybg0KPiAgICAgICAgdGhl
IHN0YWxlIHplcm8gdmFsdWUgZnJvbSBfX2dldF91c2VyKCkgdG8gdXNlciBzcGFjZS4gU28gdGhl
IGZpeA0KPiAgICAgICAgaGFuZGxlcyB0aGUgc3BlY2lmaWMgY2FzZSBieSByZS1lbmFibGluZyBw
cmVlbXB0aW9uIGFuZCBleHBsaWNpdGx5DQo+ICAgICAgICBmaXhpbmcgdXAgdGhlIGZhdWx0IGFu
ZCByZXRyeWluZyB0aGUgd2hvbGUgc2VxdWVuY2Ugb3Zlci4NCj4gDQo+IE9LID8NCg0KU3VyZSwg
Y2FyZSB0byB1cGRhdGUgdGhlIGNvbW1pdCBsb2cgb3Igd2FudCBtZSB0byByZXNlbmQ/DQoNCi1B
bGV4ZXk=
