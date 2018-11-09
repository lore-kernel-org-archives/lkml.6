Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E1FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6570D20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZqxRPBJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6570D20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbeKJBIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:08:19 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:52744 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbeKJBIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:08:19 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id BEEEB24E1EA5;
        Fri,  9 Nov 2018 07:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541777237; bh=y410Cf1eKtTCutYhpN/rb0e2ChrhlXj/MrA91+LIjBI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZqxRPBJecHT0yNTGPbXPq7uUdpOt6egAf22Mrp/S0BTYFBntIbYv6BAcSAVJBfRuB
         Y6RBr/Mff6BodH0IkP7A/r8a/+dQasAq+Nt2jtP3YHM8yhpuS9KQykmTvk2tkukPJh
         oURB614YBXnTaSp58ISZ4ptw3udAFBgSnTo06yzDg4nw9X0lMR1IkucRZrCIUOFFtc
         cUFDkbbebWRnobIQa6r24PBfTNfVNqIwkjqVuYdbNVCNAc+PHkkCCMfrVMw9W56Bhp
         CqzULsiJQmxVgLgFnODjCZ39YZJGWn8vcBwb2wPDqx0ltCqzSZpXeNUhcO//gX+Eg2
         eLUxJx73Me8Ig==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4590C407D;
        Fri,  9 Nov 2018 07:27:16 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 9 Nov 2018 07:27:16 -0800
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Fri,
 9 Nov 2018 16:27:14 +0100
From:   Alexey Brodkin <alexey.brodkin@synopsys.com>
To:     "luto@kernel.org" <luto@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        "vineet.gupta1@synopsys.com" <vineet.gupta1@synopsys.com>,
        "eparis@redhat.com" <eparis@redhat.com>,
        "ldv@altlinux.org" <ldv@altlinux.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "lineprinter@altlinux.org" <lineprinter@altlinux.org>
Subject: Re: [PATCH 06/13] arc: define syscall_get_arch()
Thread-Topic: [PATCH 06/13] arc: define syscall_get_arch()
Thread-Index: AQHUd9qaMCi82XFEfUiWRqvqbbOyn6VHbuEAgAAPSYCAAAK8AA==
Date:   Fri, 9 Nov 2018 15:27:13 +0000
Message-ID: <456a69c6e01a6ab5b1af6d459a249388f8b4c1f5.camel@synopsys.com>
References: <20181109031605.GF21511@altlinux.org>
         <e729da9ed78b6b62463a27d3012ac63c7b66be08.camel@synopsys.com>
         <CALCETrUzfOcLYDUW6s1Ra2xduDCQSbscKBw=vApCP2HNmfDmMw@mail.gmail.com>
In-Reply-To: <CALCETrUzfOcLYDUW6s1Ra2xduDCQSbscKBw=vApCP2HNmfDmMw@mail.gmail.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.2 (3.30.2-2.fc29) 
x-originating-ip: [10.225.15.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5A7DE2211F6184FBD8DAF2069FB1387@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keSwNCg0KT24gRnJpLCAyMDE4LTExLTA5IGF0IDA3OjE3IC0wODAwLCBBbmR5IEx1dG9t
aXJza2kgd3JvdGU6DQo+IE9uIEZyaSwgTm92IDksIDIwMTggYXQgNjoyMiBBTSBBbGV4ZXkgQnJv
ZGtpbg0KPiA8YWxleGV5LmJyb2RraW5Ac3lub3BzeXMuY29tPiB3cm90ZToNCj4gPiBIaSBEbWl0
cnksDQo+ID4gDQo+ID4gT24gRnJpLCAyMDE4LTExLTA5IGF0IDA2OjE2ICswMzAwLCBEbWl0cnkg
Vi4gTGV2aW4gd3JvdGU6DQo+ID4gPiBzeXNjYWxsX2dldF9hcmNoKCkgaXMgcmVxdWlyZWQgdG8g
YmUgaW1wbGVtZW50ZWQgb24gYWxsIGFyY2hpdGVjdHVyZXMNCj4gPiA+IHRoYXQgdXNlIHRyYWNl
aG9va19yZXBvcnRfc3lzY2FsbF9lbnRyeSgpIGluIG9yZGVyIHRvIGV4dGVuZA0KPiA+ID4gdGhl
IGdlbmVyaWMgcHRyYWNlIEFQSSB3aXRoIFBUUkFDRV9HRVRfU1lTQ0FMTF9JTkZPIHJlcXVlc3Qu
DQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IERtaXRyeSBWLiBMZXZpbiA8bGR2QGFsdGxp
bnV4Lm9yZz4NCj4gPiA+IC0tLQ0KPiA+ID4gIGFyY2gvYXJjL2luY2x1ZGUvYXNtL3N5c2NhbGwu
aCB8IDYgKysrKysrDQo+ID4gPiAgaW5jbHVkZS91YXBpL2xpbnV4L2F1ZGl0LmggICAgIHwgMSAr
DQo+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBbc25p
cF0NCj4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvYXVkaXQuaCBi
L2luY2x1ZGUvdWFwaS9saW51eC9hdWRpdC5oDQo+ID4gPiBpbmRleCA4MThhZTY5MGFiNzkuLmE3
MTQ5Y2ViNWI5OCAxMDA2NDQNCj4gPiA+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC9hdWRpdC5o
DQo+ID4gPiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvYXVkaXQuaA0KPiA+ID4gQEAgLTM3NSw2
ICszNzUsNyBAQCBlbnVtIHsNCj4gPiA+IA0KPiA+ID4gICNkZWZpbmUgQVVESVRfQVJDSF9BQVJD
SDY0ICAgKEVNX0FBUkNINjR8X19BVURJVF9BUkNIXzY0QklUfF9fQVVESVRfQVJDSF9MRSkNCj4g
PiA+ICAjZGVmaW5lIEFVRElUX0FSQ0hfQUxQSEEgICAgIChFTV9BTFBIQXxfX0FVRElUX0FSQ0hf
NjRCSVR8X19BVURJVF9BUkNIX0xFKQ0KPiA+ID4gKyNkZWZpbmUgQVVESVRfQVJDSF9BUkMgICAg
ICAgICAgICAgICAoRU1fQVJDKQ0KPiA+IA0KPiA+IFNpbWlsYXJseSBoZXJlIHdlIG5lZWQgdG8g
aGF2ZToNCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPjgtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiA+ICsjZGVmaW5lIEFVRElUX0FSQ0hfQVJDICAgICAgICAgKEVNX0FS
Q3xFTV9BUkNWMikNCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPjgtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IA0KPiANCj4gSHVoPyAgSG93IGRvZXMgdGhlIGJpdHdp
c2Ugb3Igb2YgdHdvIEVMRiBtYWNoaW5lIGNvZGVzIG1ha2UgYW55IHNlbnNlPw0KDQpPb3BzLi4u
IEkgZGlkbid0IHJlYWQgZXhhbXBsZXMgb2YgQVVESVRfQVJDSF9BTFBIQSBhYm92ZSA6KA0KSW5k
ZWVkIHRoYXQgd2FzIHN0dXBpZC4NCg0KQnV0IHdoYXQgd291bGQgYmUgYSBwcm9wZXIgZml4IHRo
ZW4/DQoNClNvbWV0aGluZyBsaWtlIHRoYXQ/DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
PjgtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KI2RlZmluZSBBVURJVF9BUkNIX0FSQyAg
ICAgICAgICAgICAgIChFTV9BUkMpDQojZGVmaW5lIEFVRElUX0FSQ0hfQVJDVjIgICAgICAgICAg
ICAgKEVNX0FSQ1YyKQ0KDQoNCnN0YXRpYyBpbmxpbmUgaW50IHN5c2NhbGxfZ2V0X2FyY2godm9p
ZCkNCnsNCiNpZmRlZiBfX0FSQzcwMF9fDQogICAgICAgcmV0dXJuIEFVRElUX0FSQ0hfQVJDOw0K
I2Vsc2UNCiAgICAgICByZXR1cm4gQVVESVRfQVJDSF9BUkNWMjsNCiNlbmRpZg0KfQ0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0K
LUFsZXhleQ0K
