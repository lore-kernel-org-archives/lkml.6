Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7907FECDE38
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467F12148D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467F12148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeJQXYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:24:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:60433 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbeJQXYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:24:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 08:28:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,392,1534834800"; 
   d="scan'208";a="98245486"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga004.fm.intel.com with ESMTP; 17 Oct 2018 08:28:31 -0700
Received: from hasmsx106.ger.corp.intel.com (10.184.198.20) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 17 Oct 2018 08:28:31 -0700
Received: from HASMSX109.ger.corp.intel.com ([169.254.3.28]) by
 HASMSX106.ger.corp.intel.com ([169.254.10.144]) with mapi id 14.03.0319.002;
 Wed, 17 Oct 2018 18:28:28 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Nayna Jain <nayna@linux.ibm.com>
CC:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: RE: [PATCH v6 03/20] tpm: factor out tpm 1.x duration calculation
 to tpm1-cmd.c
Thread-Topic: [PATCH v6 03/20] tpm: factor out tpm 1.x duration calculation
 to tpm1-cmd.c
Thread-Index: AQHUZeXEAxkAvhY2ik6aE/XYedYfeaUjIkEAgAA4YJD///19gIAANIEg
Date:   Wed, 17 Oct 2018 15:28:27 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D9F49D7@hasmsx109.ger.corp.intel.com>
References: <20181017064613.19746-1-tomas.winkler@intel.com>
 <20181017064613.19746-4-tomas.winkler@intel.com>
 <05fea3e6-91a3-b508-83c0-d8f06d6bbd5c@linux.ibm.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9F4691@hasmsx109.ger.corp.intel.com>
 <650c00b1-d53e-27e8-3e1f-94e34c2ae2e9@linux.ibm.com>
In-Reply-To: <650c00b1-d53e-27e8-3e1f-94e34c2ae2e9@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWRhOWVmNTQtYmJjOC00NWUyLWEyMDItMDJkOTcwMjJmYmZjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTGh4VkZEWkNuYVdXaTBxU2VmYmlRTGJySnRhV0lCa2IrWER0Qzk2ZE1qcTlLeGpcL21BVklNN3JuVVZvZU9oZVIifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.12.116.154]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IA0KPiANCj4gT24gMTAvMTcvMjAxOCAwNTo1NCBQTSwgV2lua2xlciwgVG9tYXMgd3JvdGU6
DQo+ID4+DQo+ID4+PiAgICAJb3JkaW5hbCA9IGJlMzJfdG9fY3B1KCooKF9fYmUzMiAqKSAoYnVm
ICsgNikpKTsNCj4gPj4+IC0JcmMgPSBpMmNfbnV2b3Rvbl93YWl0X2Zvcl9kYXRhX2F2YWlsKGNo
aXAsDQo+ID4+PiAtCQkJCQkgICAgIHRwbV9jYWxjX29yZGluYWxfZHVyYXRpb24oY2hpcCwNCj4g
Pj4+IC0JCQkJCQkJCSAgICAgICBvcmRpbmFsKSwNCj4gPj4+IC0JCQkJCSAgICAgJnByaXYtPnJl
YWRfcXVldWUpOw0KPiA+Pj4gKwlkdXJhdGlvbiA9IHRwbTFfY2FsY19vcmRpbmFsX2R1cmF0aW9u
KGNoaXAsIG9yZGluYWwpOw0KPiA+Pg0KPiA+PiBUaGlzIHZlcnNpb24gb2YgdGhlIHBhdGNoIGRp
ZG4ndCBhZGRyZXNzIG15IHByZXZpb3VzIGNvbW1lbnQgLSAiVGhlDQo+ID4+IG9yaWdpbmFsIGNv
ZGUgaW4gdGhlIG51dm90b24gZHJpdmVyIGRvZXMgbm90IGRpZmZlcmVudGlhdGUgYmV0d2Vlbg0K
PiA+PiBUUE0gMS4yIGFuZCBUUE0NCj4gPj4gMi4wIGFzIGl0IGRvZXMgaW4gdHBtX3Rpc19jb3Jl
LmMuDQo+ID4+IEJlZm9yZSBtYWtpbmcgYW55IGNoYW5nZXMsIEkgd291bGQgZmlyc3QgZml4IGl0
LCBzbyB0aGF0IGl0IGNvdWxkDQo+ID4+IGVhc2lseSBiZSBiYWNrcG9ydGVkLiBPbmx5IHRoZW4g
ZG8gdGhlIHJlZmFjdG9yaW5nLiINCj4gPiBUaGlzIHBhdGNoIGRvZXNuJ3QgY2hhbmdlIHRoZSBv
cmlnaW5hbCBiZWhhdmlvciwganVzdCBjaGFuZ2UgdGhlIG5hbWUgb2YNCj4gdGhlIGZ1bmN0aW9u
LCAgc28gdGhlcmUgaXMgbm8gcmVncmVzc2lvbi4NCj4gPiBJIHdvdWxkIHN1Z2dlc3QgdGhlcmUg
aXMgYW5vdGhlciBidWcgaW4gdGhvc2UgZHJpdmVycy9kZXZpY2VzIHRoYXQgaXMNCj4gb3J0aG9n
b25hbCB0byB0aGlzIHJlZmFjdG9yaW5nIGFuZCBzaG91bGQgbm90IGJsb2NrIHRoaXMgZnJvbSBt
ZXJnaW5nLg0KPiANCj4gVGhlIHByb2JsZW0gaXMgdGhhdCB5b3UgYXJlIGluYWR2ZXJ0ZW50bHkg
Zml4aW5nIGEgYnVnIHdpdGhvdXQgcmVhbGl6aW5nIGl0IC0NCj4gW1BhdGNoIDA0LzIwXS4gQnVn
IGZpeGVzIHNob3VsZCBiZSBhZGRyZXNzZWQgaW5kZXBlbmRlbnRseSBvZiB0aGlzIGNoYW5nZSwN
Cj4gc28gdGhhdCB0aGV5IGNhbiBiZSBiYWNrcG9ydGVkIHByb3Blcmx5Lg0KPg0KVGhpcyB3b3Vs
ZCBiZSBpZGVhbCwgIGJ1dCB0aGF0J3MgaGFwcGVuIG1vcmUgdGhhbiBvZnRlbiB0aGF0IHRoZSBm
aXggY2Fubm90IGJlIGFwcGxpZWQgdy9vIGNoYW5nZXMgdG8gb2xkZXIga2VybmVscy4NCkkgY2Fu
IHNlbmQgdGhhdCBwYXRjaCwgYXJlIHlvdSBhYmxlIHRvIHRlc3QgaXQ/IEZyYW5rbHkgbm9ib2R5
IGNvbXBsYWluZWQgYWJvdXQgaXQgc28gSSdtIG5vdCBzdXJlIHdoYXQgdG8gZG8uDQogDQo+ID4g
QWNjb3JkaW5nIHRvIHdoYXQgeW91IHNheSAgaXQgY2FuIGNhbGwganVzdA0KPiA+IHRwbV9jYWxj
X29yaWRuYWxfZHVyYXRpb24oKSBpbnN0ZWFkIG9mIHRwbTFfY2FsY19vcmRpbmFsX2R1cmF0aW9u
KGNoaXAsDQo+IG9yZGluYWwpLCBidXQgSSBwcmVmZXIgdGhhdCBzb21lb25lIHRoYXQgaGFzIHRo
b3NlIGRldmljZXMgd2lsbCBkbyB0aGF0DQo+IGNoYW5nZSBvbiB0b3Agb2YgdGhpcyBzZXJpZXMg
YXMgIEkgY2Fubm90IHRlc3QgaXQuDQo+IA0KPiBUaGUgcHJvYmxlbSBpczoNCj4gDQo+IDEuIFRo
aXMgcGF0Y2ggY2FsbHMgdHBtMV9jYWxjX29yZGluYWxfZHVyYXRpb24gZm9yIGJvdGggdGhlIFRQ
TSAxLjIgYW5kDQo+IFRQTSAyLjAuDQpUaGF0J3MgY29ycmVjdCANCj4gMi4gSW4gdGhlIG5leHQg
cGF0Y2gsIGl0IGFkZHMgYSBuZXcgZnVuY3Rpb24gdHBtX2NhbGNfb3JkaW5hbF9kdXJhdGlvbiBh
cyBhDQo+IHdyYXBwZXIgZm9yIGJvdGggdGhlIFRQTSAxLjIgYW5kIFRQTSAyLjAuIEFmdGVyIHRo
aXMgY2hhbmdlIHdoZW4gaXQgY2FsbHMNCj4gdHBtX2NhbGNfb3JkaW5hbF9kdXJhdGlvbigpLCBp
dCBub3cgY2FsbHMgZGlmZmVyZW50IGZ1bmN0aW9ucyBmb3IgVFBNIDEuMiBhbmQNCj4gVFBNIDIu
MC4gVGhpcyBpcyBhIGNoYW5nZSBpbiBiZWhhdmlvci4NClRoYXQncyBub3QgY29ycmVjdCwgICBJ
IG1pc3NlZCB0aGF0LiAgRWl0aGVyIHNvbWVvbmUgY2FuIHRlc3QgdGhlIFRQTSAyLjAgZGV2aWNl
ICBvciBJIG5lZWQgdG8gcmV2ZXJ0IGl0IGZvciBudXZvdG9uLCBpbiB0aGUgbmV4dCBwYXRjaC4g
IA0KDQpUaGFua3MNClRvbWFzDQoNCg==
