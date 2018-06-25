Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4952C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE7226035
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE7226035
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965023AbeFYSup (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 14:50:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:30329 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964944AbeFYSum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 14:50:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 11:50:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,271,1526367600"; 
   d="scan'208";a="211047509"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga004.jf.intel.com with ESMTP; 25 Jun 2018 11:50:42 -0700
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 25 Jun 2018 11:50:42 -0700
Received: from hasmsx107.ger.corp.intel.com (10.184.198.27) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 25 Jun 2018 11:50:41 -0700
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.94]) by
 hasmsx107.ger.corp.intel.com ([169.254.2.79]) with mapi id 14.03.0319.002;
 Mon, 25 Jun 2018 21:50:38 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v7] tpm: separate cmd_ready/go_idle from runtime_pm
Thread-Topic: [PATCH v7] tpm: separate cmd_ready/go_idle from runtime_pm
Thread-Index: AQHUC/10xIwob4M80Eit0g6kz8euiKRw97kAgABZtJA=
Date:   Mon, 25 Jun 2018 18:50:38 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D953997@hasmsx108.ger.corp.intel.com>
References: <20180624205202.6597-1-tomas.winkler@intel.com>
 <19b4282d625e04bb391f497419283a191bca610d.camel@linux.intel.com>
In-Reply-To: <19b4282d625e04bb391f497419283a191bca610d.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzI5N2FjMjAtNDZmMy00ZWUyLTk5ZTItYTJlYmU4NWNlNjE0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidGlBTFhhRHpoWVluYzRRSU4yS1wvVXozOUZVXC9GdjVmeVdaY0gwUzEwZUI3dlAzVWhBZkZRdFpiRlJYWnlvUFR3In0=
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.252.28.198]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gT24gU3VuLCAyMDE4LTA2LTI0IGF0IDIzOjUyICswMzAwLCBUb21hcyBXaW5rbGVyIHdy
b3RlOg0KPiA+IEZpeCB0cG0gcHR0IGluaXRpYWxpemF0aW9uIGVycm9yOg0KPiA+IHRwbSB0cG0w
OiBBIFRQTSBlcnJvciAoMzc4KSBvY2N1cnJlZCBnZXQgdHBtIHBjciBhbGxvY2F0aW9uLg0KPiA+
DQo+ID4gV2UgY2Fubm90IHVzZSBnb19pZGxlIGNtZF9yZWFkeSBjb21tYW5kcyB2aWEgcnVudGlt
ZV9wbSBoYW5kbGVzIGFzDQo+ID4gd2l0aCB0aGUgaW50cm9kdWN0aW9uIG9mIGxvY2FsaXRpZXMg
dGhpcyBpcyBubyBsb25nZXIgYW4gb3B0aW9uYWwNCj4gPiBmZWF0dXJlLCB3aGlsZSBydW50aW1l
IHBtIGNhbiBiZSBub3QgZW5hYmxlZC4NCj4gPiBUaG91Z2ggY21kX3JlYWR5L2dvX2lkbGUgcHJv
dmlkZXMgYSBwb3dlciBzYXZpbmcsIGl0J3MgYWxzbyBhIHBhcnQgb2YNCj4gPiBUUE0yIHByb3Rv
Y29sIGFuZCBzaG91bGQgYmUgY2FsbGVkIGV4cGxpY2l0bHkuDQo+ID4gVGhpcyBwYXRjaCBleHBv
c2VzIGNtZF9yZWFkL2dvX2lkbGUgdmlhIHRwbSBjbGFzcyBvcHMgYW5kIHJlbW92ZXMNCj4gPiBy
dW50aW1lIHBtIHN1cHBvcnQgYXMgaXQgaXMgbm90IHVzZWQgYnkgYW55IGRyaXZlci4NCj4gPg0K
PiA+IEEgbmV3IHRwbSB0cmFuc21pdCBmbGFnIGlzIGFkZGVkIFRQTV9UUkFOU01JVF9ORVNURUQs
IHdoaWNoIGltcGxpZXMNCj4gPiBUUE1fVFJBTlNNSVRfVU5MT0NLRUQgYW5kIFRQTV9UUkFOU01J
VF9SQVcuIEJvdGggYXJlIG5lZWRlZA0KPiB0byByZXNvbHZlDQo+ID4gdHBtIHNwYWNlcyBhbmQg
bG9jYWxpdHkgcmVxdWVzdCByZWN1cnNpdmUgY2FsbHMgdG8gdHBtX3RyYW5zbWl0KCkuDQo+ID4N
Cj4gPiBOZXcgd3JhcHBlcnMgYXJlIGFkZGVkIHRwbV9jbWRfcmVhZHkoKSBhbmQgdHBtX2dvX2lk
bGUoKSB0bw0KPiBzdHJlYW1saW5lDQo+ID4gdHBtX3RyeV90cmFuc21pdCBjb2RlLg0KPiA+DQo+
ID4gdHBtX2NyYiBubyBsb25nZXIgbmVlZHMgb3duIHBvd2VyIHNhdmluZyBmdW5jdGlvbnMgYW5k
IGNhbiBkcm9wIHVzaW5nDQo+ID4gdHBtX3BtX3N1c3BlbmQvcmVzdW1lLg0KPiA+DQo+ID4gVGhp
cyBwYXRjaCBjYW5ub3QgYmUgcmVhbGx5IHNlcGFyYXRlZCBmcm9tIHRoZSBsb2NhbGl0eSBmaXgu
DQo+ID4gRml4ZXM6IDg4OGQ4NjdkZjQ0MSAodHBtOiBjbWRfcmVhZHkgY29tbWFuZCBjYW4gYmUg
aXNzdWVkIG9ubHkgYWZ0ZXINCj4gPiBncmFudGluZw0KPiA+IGxvY2FsaXR5KQ0KPiA+DQo+ID4g
Q2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBGaXhlczogODg4ZDg2N2RmNDQxICh0cG06
IGNtZF9yZWFkeSBjb21tYW5kIGNhbiBiZSBpc3N1ZWQgb25seSBhZnRlcg0KPiA+IGdyYW50aW5n
DQo+ID4gbG9jYWxpdHkpDQo+ID4gU2lnbmVkLW9mZi1ieTogVG9tYXMgV2lua2xlciA8dG9tYXMu
d2lua2xlckBpbnRlbC5jb20+DQo+IA0KPiBQbGVhc2U6DQo+IA0KPiAxLiBSZW1vdmUgTkVTVEVE
Lg0KPiAyLiBXaGVyZSB5b3UgbmVlZCBjYWxsIFJBVyB8IFVOTE9DS0VELg0KPiAzLiBEbyBub3Qg
YWRkIF9fIHByZWZpeC4NCj4gDQo+IFNob3VsZCBiZSBzaW1wbGUgY2hhbmdlcyB0byBkby4NCg0K
SXQgc2ltcGxlIHRvIGNoYW5nZSwgYnV0IGZpcnN0IHlvdSd2ZSBhbHJlYWR5IGFncmVlZCBvbiBO
RVNURUQsIHNlY29uZCBJIHdvdWxkIGFwcHJlY2lhdGUgc29tZSByZWFzb25pbmcgYmVoaW5kIHlv
dXIgcmVxdWVzdHMuDQpUaGVyZSBpcyBhIGxvZ2ljIGJlaGluZCB0aGlzIHdoeSBSQVcgaXMgaGlk
ZGVuLCBpdCdzIGJlY2F1c2UgaXQgYWx3YXlzIGhhc3QgYmUgY291cGxlZCB3aXRoIFVOTE9DS0VE
LCBhbmQgaGVuY2UgTkVTVEVEIGNvbnZlcnMgYm90aCwgaXQgZ2l2ZXMgY2xlYW5lciBBUEkuDQoN
ClRoYW5rcw0KVG9tYXMNCg0K
