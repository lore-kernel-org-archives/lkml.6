Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F22CC4321E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3871520869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3871520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeIDK4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 06:56:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:43172 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727482AbeIDK4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 06:56:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 23:33:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,328,1531810800"; 
   d="scan'208";a="68184990"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga008.fm.intel.com with ESMTP; 03 Sep 2018 23:33:02 -0700
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 3 Sep 2018 23:33:02 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 FMSMSX157.amr.corp.intel.com (10.18.116.73) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 3 Sep 2018 23:33:01 -0700
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.240]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.226]) with mapi id 14.03.0319.002;
 Tue, 4 Sep 2018 14:32:59 +0800
From:   "Yang, Bin" <bin.yang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Gross, Mark" <mark.gross@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH v3 5/5] x86/mm: add WARN_ON_ONCE() for wrong large page
 mapping
Thread-Topic: [PATCH v3 5/5] x86/mm: add WARN_ON_ONCE() for wrong large page
 mapping
Thread-Index: AQHUOOymJE+K7YyITE+hh9OuBQRM4qTesq4AgACHUgA=
Date:   Tue, 4 Sep 2018 06:32:59 +0000
Message-ID: <2ad0ff43ea406005890ad4fcbb7a42da747289d9.camel@intel.com>
References: <1534814186-37067-1-git-send-email-bin.yang@intel.com>
         <1534814186-37067-6-git-send-email-bin.yang@intel.com>
         <alpine.DEB.2.21.1809040023450.1462@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809040023450.1462@nanos.tec.linutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.4.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D2B5881F1038A4995C0EA2DC81149B9@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA5LTA0IGF0IDAwOjI3ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIFR1ZSwgMjEgQXVnIDIwMTgsIEJpbiBZYW5nIHdyb3RlOg0KPiA+IEBAIC02MjUsNiAr
NjI1LDcgQEAgdHJ5X3ByZXNlcnZlX2xhcmdlX3BhZ2UocHRlX3QgKmtwdGUsIHVuc2lnbmVkIGxv
bmcgYWRkcmVzcywNCj4gPiAgDQo+ID4gIAlwc2l6ZSA9IHBhZ2VfbGV2ZWxfc2l6ZShsZXZlbCk7
DQo+ID4gIAlwbWFzayA9IHBhZ2VfbGV2ZWxfbWFzayhsZXZlbCk7DQo+ID4gKwlhZGRyID0gYWRk
cmVzcyAmIHBtYXNrOw0KPiA+ICANCj4gPiAgCS8qDQo+ID4gIAkgKiBDYWxjdWxhdGUgdGhlIG51
bWJlciBvZiBwYWdlcywgd2hpY2ggZml0IGludG8gdGhpcyBsYXJnZQ0KPiA+IEBAIC02MzYsNiAr
NjM3LDEyIEBAIHRyeV9wcmVzZXJ2ZV9sYXJnZV9wYWdlKHB0ZV90ICprcHRlLCB1bnNpZ25lZCBs
b25nIGFkZHJlc3MsDQo+ID4gIAkJY3BhLT5udW1wYWdlcyA9IG51bXBhZ2VzOw0KPiA+ICANCj4g
PiAgCS8qDQo+ID4gKwkgKiBUaGUgb2xkIHBncHJvdCBzaG91bGQgbm90IGhhdmUgYW55IHByb3Rl
Y3Rpb24gYml0LiBPdGhlcndpc2UsDQo+ID4gKwkgKiB0aGUgZXhpc3RpbmcgbWFwcGluZyBpcyB3
cm9uZyBhbHJlYWR5Lg0KPiA+ICsJICovDQo+ID4gKwlXQVJOX09OX09OQ0UobmVlZHNfc3RhdGlj
X3Byb3RlY3Rpb25zKG9sZF9wcm90LCBhZGRyLCBwc2l6ZSwgb2xkX3BmbikpOw0KPiANCj4gVGhl
IGNoZWNrIGl0c2VsZiBpcyBmaW5lLCBidXQgaXQganVzdCBlbWl0cyBhIHdhcm5pbmcgYW5kIGdv
ZXMgb24gYXMgaWYNCj4gbm90aGluZyBoYXBwZW5lZC4NCj4gDQo+IFdlIHJlYWxseSB3YW50IHRv
IHRoaW5rIGFib3V0IGEgcHJvcGVyIHdheSB0byBmaXggdGhhdCB1cCB3aXRob3V0IG92ZXJoZWFk
DQo+IGZvciB0aGUgc2FuZSBjYXNlLg0KDQpjb3VsZCB3ZSBjaGFuZ2UgaXQgYXMgYmVsb3c/IEkg
dGhpbmsgaXQgc2hvdWxkIGJlIHNhZmUgdG8gc3BsaXQgbGFyZ2UNCnBhZ2UgaWYgY3VycmVudCBt
YXBwaW5nIGlzIHdyb25nIGFscmVhZHkuDQoNCiAgICAgICAgaWYgKG5lZWRzX3N0YXRpY19wcm90
ZWN0aW9ucyhvbGRfcHJvdCwgYWRkciwgcHNpemUsIG9sZF9wZm4pKSB7DQogICAgICAgICAgICAg
ICAgV0FSTl9PTl9PTkNFKDEpOw0KICAgICAgICAgICAgICAgIGdvdG8gb3V0X3VubG9jazsNCiAg
ICAgICAgfQ0KDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+IAl0Z2x4DQo=
