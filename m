Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E23C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666ED206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666ED206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeIGMoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:44:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:48109 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbeIGMoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:44:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 01:04:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,341,1531810800"; 
   d="scan'208";a="81623065"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2018 01:04:22 -0700
Received: from fmsmsx117.amr.corp.intel.com (10.18.116.17) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 7 Sep 2018 01:04:21 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx117.amr.corp.intel.com (10.18.116.17) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 7 Sep 2018 01:04:21 -0700
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.240]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.226]) with mapi id 14.03.0319.002;
 Fri, 7 Sep 2018 16:04:18 +0800
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
Thread-Index: AQHUOOyiLUEwozeDmEmpKrJdpg0FR6Tfm9CAgAP8LwCAAG7LgIAAA7IA
Date:   Fri, 7 Sep 2018 08:04:18 +0000
Message-ID: <cd73f43a15f06c720bb4907d2c424dfb3f0c8683.camel@intel.com>
References: <1534814186-37067-1-git-send-email-bin.yang@intel.com>
         <1534814186-37067-5-git-send-email-bin.yang@intel.com>
         <alpine.DEB.2.21.1809041413070.3395@nanos.tec.linutronix.de>
         <82fc8d80749f920c4a5107469924205d92037785.camel@intel.com>
         <alpine.DEB.2.21.1809070943490.1402@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809070943490.1402@nanos.tec.linutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.0 
x-originating-ip: [10.239.4.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <67AD40BF26831E4D99F00B3025426471@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA5LTA3IGF0IDA5OjQ5ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIEZyaSwgNyBTZXAgMjAxOCwgWWFuZywgQmluIHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAx
OC0wOS0wNCBhdCAxNDoyMiArMDIwMCwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiA+IA0KPiA+
IEkganVzdCB3cml0ZSBhIHRlc3QuYyB0byBjb21wYXJlIHRoZSByZXN1bHQgYmV0d2VlbiBvdmVy
bGFwKCkgYW5kDQo+ID4gb3JpZ2luYWwgd2l0aGluKCkuDQo+IA0KPiBZb3UgYXJlIHJpZ2h0LiBZ
b3VyIHZlcnNpb24gb2YgZG9pbmcgdGhlIG92ZXJsYXAgZXhjbHVzaXZlIHdvcmtzLiBJIG1pc3Jl
YWQNCj4gdGhlIGNvbmRpdGlvbnMuIEkgc3RpbGwgcHJlZmVyIGRvaW5nIGluY2x1c2l2ZSBjaGVj
a3MgYmVjYXVzZSB0aGV5IGFyZSB3YXkNCj4gbW9yZSBvYnZpb3VzLg0KDQpJIGFtIHNvcnJ5IGZv
ciBteSBwb29yIGVuZ2xpc2guIFdoYXQgaXMgImluY2x1c2l2ZSBjaGVja3MiPw0KDQoNCj4gDQo+
IFRoYW5rcywNCj4gDQo+IAl0Z2x4DQo=
