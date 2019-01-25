Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585A9C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2BF217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfAYJCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:02:47 -0500
Received: from mga02.intel.com ([134.134.136.20]:41931 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbfAYJCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:02:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 01:02:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,520,1539673200"; 
   d="scan'208";a="121220434"
Received: from irsmsx106.ger.corp.intel.com ([163.33.3.31])
  by orsmga003.jf.intel.com with ESMTP; 25 Jan 2019 01:02:44 -0800
Received: from irsmsx156.ger.corp.intel.com (10.108.20.68) by
 IRSMSX106.ger.corp.intel.com (163.33.3.31) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 25 Jan 2019 09:02:43 +0000
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.65]) by
 IRSMSX156.ger.corp.intel.com ([169.254.3.156]) with mapi id 14.03.0415.000;
 Fri, 25 Jan 2019 09:02:43 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Andrey Ryabinin" <aryabinin@virtuozzo.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] kcov: convert kcov.refcount to refcount_t
Thread-Topic: [PATCH] kcov: convert kcov.refcount to refcount_t
Thread-Index: AQHUrYYWOOwEuMXWwEOBiuSRPC5USKWx2V6AgAepqoCAADl1AIAALpmAgAEc9ACAAO+qAIADxgJg
Date:   Fri, 25 Jan 2019 09:02:42 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4B92711@IRSMSX102.ger.corp.intel.com>
References: <20190121131816.GC17749@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1901211103000.24162-100000@netrider.rowland.org>
 <20190122090456.GE13777@hirez.programming.kicks-ass.net>
 <CAGXu5jKHo4CZWAnn4Wvg=MV=xaf3j4mBvxggBHuZETTkMOxkOA@mail.gmail.com>
In-Reply-To: <CAGXu5jKHo4CZWAnn4Wvg=MV=xaf3j4mBvxggBHuZETTkMOxkOA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjRmNzZmODYtNmE5YS00MzZkLThjODgtNTcwMjMzNDJjNTA4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTXlCcGtOQmQzV3NHaVRnNWtHQW9WUXNVbjFmOW9tcU5oOEwrSEJVcDkxVldON3I2OXJVUjB2Q1FqRzhIUmgxSCJ9
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IEkgc3VwcG9zZSB3ZSBjYW4gYWRkIHNtcF9hY3F1aXJlX19hZnRlcl9jdHJsX2RlcCgpIG9u
IHRoZSB0cnVlIGJyYW5jaC4NCj4gPiBUaGVuIGl0IHJlYWxsIGRvZXMgYmVjb21lIHJlbF9hY3Eu
DQo+ID4NCj4gPiBBIHdlZSBzb21ldGhpbmcgbGlrZSBzbyAoSSBjb3VsZG4ndCBmaW5kIGFuIGFy
bTY0IHJlZmNvdW50LCBldmVuIHRob3VnaA0KPiA+IEkgaGF2ZSBkaXN0aW5jdCBtZW1vcmllcyBv
ZiB0YWxrIGFib3V0IGl0KS4NCj4gDQo+IEluIHRoZSBlbmQsIGFybSBhbmQgYXJtNjQgY2hvc2Ug
dG8gdXNlIFJFRkNPVU5UX0ZVTEwgdW5jb25kaXRpb25hbGx5LA0KPiBzbyB0aGVyZSdzIG5vIGFy
Y2gtc3BlY2lmaWMgaW1wbGVtZW50YXRpb24uDQo+IA0KPiA+IFRoaXMgaXNuJ3QgY29tcGlsZWQs
IGFuZCBvYnZpb3VzbHkgbmVlZHMgY29tbWVudC9kb2N1bWVudGF0aW9uIHVwZGF0ZXMNCj4gPiB0
byBnbyBhbG9uZyB3aXRoIGl0Lg0KPiANCj4gRWxlbmEsIGNhbiB5b3UgZG8gdGhlIGRvYyB1cGRh
dGVzPw0KDQpXZWxsLCBkb2MgdXBkYXRlcyBzaG91bGQgZ28gd2l0aCBiZWxvdyBwYXRjaCArIGFu
ZCBhZGRpdGlvbmFsIHRlc3RpbmcuLi4NCg0KUGV0ZXIsIHNob3VsZCBJIGNyZWF0ZSBhIGZ1bGwg
dmVyc2lvbiBmcm9tIGJlbG93IHdpdGggZG9jL2NvbW1lbnRzDQp1cGRhdGVzLCBydW4gdGhlIHdo
b2xlIHRoaW5nIHZpYSB6ZXJvIGRheSBhbmQgc2VuZCB0byB5b3UgaWYgaXQgYWxsIGxvb2tzIG9r
Pw0KDQpCZXN0IFJlZ2FyZHMsDQpFbGVuYS4NCg0KPiA+DQo+ID4gLS0tDQo+ID4gIGFyY2gveDg2
L2luY2x1ZGUvYXNtL3JlZmNvdW50LmggfCA5ICsrKysrKysrLQ0KPiA+ICBsaWIvcmVmY291bnQu
YyAgICAgICAgICAgICAgICAgIHwgNyArKysrKystDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTQg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9yZWZjb3VudC5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vcmVmY291
bnQuaA0KPiA+IGluZGV4IGRiYWVkNTVjMWMyNC4uNmY3YTFlYjM0NWI0IDEwMDY0NA0KPiA+IC0t
LSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3JlZmNvdW50LmgNCj4gPiArKysgYi9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9yZWZjb3VudC5oDQo+ID4gQEAgLTc0LDkgKzc0LDE2IEBAIGJvb2wgcmVmY291
bnRfc3ViX2FuZF90ZXN0KHVuc2lnbmVkIGludCBpLCByZWZjb3VudF90ICpyKQ0KPiA+DQo+ID4g
IHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgX19tdXN0X2NoZWNrIGJvb2wgcmVmY291bnRfZGVjX2Fu
ZF90ZXN0KHJlZmNvdW50X3QgKnIpDQo+ID4gIHsNCj4gPiAtICAgICAgIHJldHVybiBHRU5fVU5B
UllfU1VGRklYRURfUk1XY2MoTE9DS19QUkVGSVggImRlY2wiLA0KPiA+ICsgICAgICAgYm9vbCBy
ZXQgPSBHRU5fVU5BUllfU1VGRklYRURfUk1XY2MoTE9DS19QUkVGSVggImRlY2wiLA0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSRUZDT1VOVF9DSEVDS19MVF9a
RVJPLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByLT5yZWZz
LmNvdW50ZXIsIGUsICJjeCIpOw0KPiA+ICsNCj4gPiArICAgICAgIGlmIChyZXQpIHsNCj4gPiAr
ICAgICAgICAgICAgICAgc21wX2FjcXVpcmVfX2FmdGVyX2N0cmxfZGVwKCk7DQo+ID4gKyAgICAg
ICAgICAgICAgIHJldHVybiB0cnVlOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAg
IHJldHVybiBmYWxzZTsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUg
X19tdXN0X2NoZWNrDQo+ID4gZGlmZiAtLWdpdCBhL2xpYi9yZWZjb3VudC5jIGIvbGliL3JlZmNv
dW50LmMNCj4gPiBpbmRleCBlYmNmOGNkNDllMDUuLjgyNzZhZDM0OWQ0OCAxMDA2NDQNCj4gPiAt
LS0gYS9saWIvcmVmY291bnQuYw0KPiA+ICsrKyBiL2xpYi9yZWZjb3VudC5jDQo+ID4gQEAgLTE5
MCw3ICsxOTAsMTIgQEAgYm9vbCByZWZjb3VudF9zdWJfYW5kX3Rlc3RfY2hlY2tlZCh1bnNpZ25l
ZCBpbnQgaSwNCj4gcmVmY291bnRfdCAqcikNCj4gPg0KPiA+ICAgICAgICAgfSB3aGlsZSAoIWF0
b21pY190cnlfY21weGNoZ19yZWxlYXNlKCZyLT5yZWZzLCAmdmFsLCBuZXcpKTsNCj4gPg0KPiA+
IC0gICAgICAgcmV0dXJuICFuZXc7DQo+ID4gKyAgICAgICBpZiAoIW5ldykgew0KPiA+ICsgICAg
ICAgICAgICAgICBzbXBfYWNxdWlyZV9fYWZ0ZXJfY3RybF9kZXAoKTsNCj4gPiArICAgICAgICAg
ICAgICAgcmV0dXJuIHRydWU7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0
dXJuIGZhbHNlOw0KPiA+ICB9DQo+ID4gIEVYUE9SVF9TWU1CT0wocmVmY291bnRfc3ViX2FuZF90
ZXN0X2NoZWNrZWQpOw0KPiA+DQo+IA0KPiBUaGFua3MgZm9yIHRoaXMhDQo+IA0KPiAtLQ0KPiBL
ZWVzIENvb2sNCg==
