Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ADAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FAD82075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FAD82075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbeIGNGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:06:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:38585 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbeIGNGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:06:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 01:26:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,341,1531810800"; 
   d="scan'208";a="69085231"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga008.fm.intel.com with ESMTP; 07 Sep 2018 01:26:34 -0700
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 7 Sep 2018 01:26:34 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 7 Sep 2018 01:26:33 -0700
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.240]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.205]) with mapi id 14.03.0319.002;
 Fri, 7 Sep 2018 16:26:31 +0800
From:   "Yang, Bin" <bin.yang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Gross, Mark" <mark.gross@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH v3 4/5] x86/mm: optimize static_protection() by using
 overlap()
Thread-Topic: [PATCH v3 4/5] x86/mm: optimize static_protection() by using
 overlap()
Thread-Index: AQHUOOyiLUEwozeDmEmpKrJdpg0FR6Tfm9CAgAP8LwCAAG7LgIAAA7IAgAAFPACAAAD5gA==
Date:   Fri, 7 Sep 2018 08:26:31 +0000
Message-ID: <9c5031cb0dfeb6083e65e3b33f4e73b96c66699f.camel@intel.com>
References: <1534814186-37067-1-git-send-email-bin.yang@intel.com>
          <1534814186-37067-5-git-send-email-bin.yang@intel.com>
          <alpine.DEB.2.21.1809041413070.3395@nanos.tec.linutronix.de>
          <82fc8d80749f920c4a5107469924205d92037785.camel@intel.com>
          <alpine.DEB.2.21.1809070943490.1402@nanos.tec.linutronix.de>
         <cd73f43a15f06c720bb4907d2c424dfb3f0c8683.camel@intel.com>
         <alpine.DEB.2.21.1809071019020.1402@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809071019020.1402@nanos.tec.linutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.0 
x-originating-ip: [10.239.4.100]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E34213BF415524CACEC3D19BB65EEED@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA5LTA3IGF0IDEwOjIxICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIEZyaSwgNyBTZXAgMjAxOCwgWWFuZywgQmluIHdyb3RlOg0KPiA+IE9uIEZyaSwgMjAx
OC0wOS0wNyBhdCAwOTo0OSArMDIwMCwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiA+ID4gT24g
RnJpLCA3IFNlcCAyMDE4LCBZYW5nLCBCaW4gd3JvdGU6DQo+ID4gPiA+IE9uIFR1ZSwgMjAxOC0w
OS0wNCBhdCAxNDoyMiArMDIwMCwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiA+ID4gPiANCj4g
PiA+ID4gSSBqdXN0IHdyaXRlIGEgdGVzdC5jIHRvIGNvbXBhcmUgdGhlIHJlc3VsdCBiZXR3ZWVu
IG92ZXJsYXAoKSBhbmQNCj4gPiA+ID4gb3JpZ2luYWwgd2l0aGluKCkuDQo+ID4gPiANCj4gPiA+
IFlvdSBhcmUgcmlnaHQuIFlvdXIgdmVyc2lvbiBvZiBkb2luZyB0aGUgb3ZlcmxhcCBleGNsdXNp
dmUgd29ya3MuIEkgbWlzcmVhZA0KPiA+ID4gdGhlIGNvbmRpdGlvbnMuIEkgc3RpbGwgcHJlZmVy
IGRvaW5nIGluY2x1c2l2ZSBjaGVja3MgYmVjYXVzZSB0aGV5IGFyZSB3YXkNCj4gPiA+IG1vcmUg
b2J2aW91cy4NCj4gPiANCj4gPiBJIGFtIHNvcnJ5IGZvciBteSBwb29yIGVuZ2xpc2guIFdoYXQg
aXMgImluY2x1c2l2ZSBjaGVja3MiPw0KPiANCj4gRXhsdXNpdmU6ICAgIHZhbCA+PSBzdGFydCAm
JiB2YWwgPCBlbmQNCj4gDQo+IEluY2x1c2l2ZTogICB2YWwgPj0gc3RhcnQgJiYgdmFsIDw9IGVu
ZA0KPiANCj4gU28gdGhlIGRpZmZlcmVuY2UgaXMgdGhhdCB5b3UgZmVlZCBleGNsdXNpdmUgd2l0
aDoNCj4gDQo+ICAgIGVuZCA9IHN0YXJ0ICsgc2l6ZQ0KPiANCj4gYW5kIGluY2x1c2l2ZSB3aXRo
DQo+IA0KPiAgIGVuZCA9IHN0YXJ0ICsgc2l6ZSAtIDENCj4gDQoNClRoYW5rcy4gSSB3aWxsIGNo
YW5nZSBpdCB0byBpbmNsdXNpdmUgY2hlY2suDQoNCj4gVGhhbmtzLA0KPiANCj4gCXRnbHgNCj4g
DQo+IA0K
