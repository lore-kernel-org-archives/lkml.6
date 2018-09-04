Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F117C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B93C2086C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B93C2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeIDNhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 09:37:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:60994 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbeIDNhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 09:37:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 02:12:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,328,1531810800"; 
   d="scan'208";a="87447444"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga001.jf.intel.com with ESMTP; 04 Sep 2018 02:12:55 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 4 Sep 2018 02:12:55 -0700
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.240]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.143]) with mapi id 14.03.0319.002;
 Tue, 4 Sep 2018 17:12:53 +0800
From:   "Yang, Bin" <bin.yang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Gross, Mark" <mark.gross@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH v3 1/5] x86/mm: avoid redundant checking if pgprot has
 no change
Thread-Topic: [PATCH v3 1/5] x86/mm: avoid redundant checking if pgprot has
 no change
Thread-Index: AQHUOOyjY4j6eKGfo0i2H1+4H4FSu6TeqiKAgACX8wCAAA1xAIAAFyQA
Date:   Tue, 4 Sep 2018 09:12:52 +0000
Message-ID: <2db43c762164cada1b85ffd63262b5247fd2e3dc.camel@intel.com>
References: <1534814186-37067-1-git-send-email-bin.yang@intel.com>
         <1534814186-37067-2-git-send-email-bin.yang@intel.com>
         <alpine.DEB.2.21.1809032127550.1462@nanos.tec.linutronix.de>
         <76cf0aca5a2f8e9b94fd0631274a3d4ad825d077.camel@intel.com>
         <alpine.DEB.2.21.1809040947040.1462@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809040947040.1462@nanos.tec.linutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.4.160]
Content-Type: text/plain; charset="utf-8"
Content-ID: <036461DE681F0C40ADA761B9EC2D2361@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA5LTA0IGF0IDA5OjQ5ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIFR1ZSwgNCBTZXAgMjAxOCwgWWFuZywgQmluIHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAx
OC0wOS0wMyBhdCAyMzo1NyArMDIwMCwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiA+ID4gDQo+
ID4gPiBUaGUgbGFzdCBwYXRjaCB3aGljaCBkb2VzIHRoZSBvdmVybGFwIGNoZWNrIGlzIGVxdWFs
bHkgYnJva2VuOg0KPiA+IA0KPiA+IFNvcnJ5IHRoYXQgSSBkaWQgbm90IHVuZGVyc3RhbmQgdGhl
IGJyb2tlbiBvZiBsYXN0IHBhdGNoLg0KPiANCj4gSSBtZWFudCA0LzUgc29ycnkuIFRoYXQncyB0
aGUgb25lIHdoaWNoIGludHJvZHVjZXMgdGhlIG92ZXJsYXAgY2hlY2sgYW5kDQo+IGRvZXMgdGhp
czoNCj4gDQo+ID4gPiArICAgICAgIC8qDQo+ID4gPiArICAgICAgICAqIEVuc3VyZSB0aGF0IHRo
ZSByZXF1ZXN0ZWQgcGdwcm90IGRvZXMgbm90IHZpb2xhdGUgc3RhdGljIHByb3RlY3Rpb24NCj4g
PiA+ICsgICAgICAgICogcmVxdWlyZW1lbnRzLg0KPiA+ID4gKyAgICAgICAgKi8NCj4gPiA+ICsg
ICAgICAgbmV3X3Byb3QgPSBzdGF0aWNfcHJvdGVjdGlvbnMocmVxX3Byb3QsIGFkZHJlc3MsDQo+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG51bXBhZ2VzIDw8IFBB
R0VfU0hJRlQsIHBmbik7DQo+ID4gPiANCj4gPiA+IEl0IGV4cGFuZHMgbmV3X3Byb3QgdG8gdGhl
IHdob2xlIHJhbmdlIGV2ZW4gaWYgdGhlIHByb3RlY3Rpb25zIG9ubHkNCj4gPiA+IG92ZXJsYXAu
IFRoYXQgc2hvdWxkIG5vdCBoYXBwZW4gaW4gcHJhY3RpY2UsIGJ1dCB3ZSBoYXZlIG5vIGNoZWNr
cyBmb3IgdGhhdA0KPiA+ID4gYXQgYWxsLg0KPiA+IA0KPiA+IEJlbG93IGNvZGUgaW4gcGF0Y2gg
IzMgc2hvdWxkIGNvdmVyIHRoaXMgY2hlY2suIEl0IHdpbGwgZG91YmxlIGNoZWNrDQo+ID4gbmV3
X3Byb3QgaW4gd2hvbGUgbGFyZ2UgcGFnZSByYW5nZS4NCj4gDQo+IFdoaWNoIGlzIGV4YWN0bHkg
d2hhdCBpcyB3cm9uZy4gUmVhZCBhZ2FpbiB3aGF0IEkgd3JvdGUuDQo+IA0KPiBUaGFua3MsDQo+
IA0KPiAJdGdseA0K
