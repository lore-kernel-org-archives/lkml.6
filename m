Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6413FC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2906E2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2906E2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeJDUjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:39:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:54179 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbeJDUjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:39:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2018 06:46:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,340,1534834800"; 
   d="scan'208";a="79851510"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga006.jf.intel.com with ESMTP; 04 Oct 2018 06:46:03 -0700
Received: from lcsmsx153.ger.corp.intel.com (10.186.165.228) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 4 Oct 2018 06:46:03 -0700
Received: from HASMSX109.ger.corp.intel.com ([169.254.3.28]) by
 LCSMSX153.ger.corp.intel.com ([169.254.8.212]) with mapi id 14.03.0319.002;
 Thu, 4 Oct 2018 16:46:00 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 12/21] tpm: move pcr extend code to tpm2-cmd.c
Thread-Topic: [PATCH v5 12/21] tpm: move pcr extend code to tpm2-cmd.c
Thread-Index: AQHUWeozFz0QOr+BiUiSikU4mA0ywaULXotQgAHdBoCAAN6dYIAArEYAgAAyobD//9ohAIAASYdw
Date:   Thu, 4 Oct 2018 13:46:00 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D9E6E47@hasmsx109.ger.corp.intel.com>
References: <20180928223035.14471-1-tomas.winkler@intel.com>
 <20180928223035.14471-13-tomas.winkler@intel.com>
 <20181002005208.GH23753@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9DFAA5@hasmsx109.ger.corp.intel.com>
 <20181003120141.GA7969@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9E5343@hasmsx109.ger.corp.intel.com>
 <20181004113502.GA12498@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D9E6D00@hasmsx109.ger.corp.intel.com>
 <19c26db0-cde9-da70-1b02-7e37ca188b45@huawei.com>
In-Reply-To: <19c26db0-cde9-da70-1b02-7e37ca188b45@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTY5Y2RiMTktZTAwYS00NDI4LThjMzUtOGU1ZDhhNzFkYjNjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiME12WlFjQnJqc0NQQnZtS2dUUEQrSGRsdnJKXC94OXI2Z1d4T2k0bVEzcXQ3MERUZ1p1NHRzbmxuUmlWWDNVMzgifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.249.82.222]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gT24gMTAvNC8yMDE4IDE6NDUgUE0sIFdpbmtsZXIsIFRvbWFzIHdyb3RlOg0KPiA+DQo+
ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogSmFya2tvIFNh
a2tpbmVuIFttYWlsdG86amFya2tvLnNha2tpbmVuQGxpbnV4LmludGVsLmNvbV0NCj4gPj4gU2Vu
dDogVGh1cnNkYXksIE9jdG9iZXIgMDQsIDIwMTggMTQ6MzUNCj4gPj4gVG86IFdpbmtsZXIsIFRv
bWFzIDx0b21hcy53aW5rbGVyQGludGVsLmNvbT4NCj4gPj4gQ2M6IEphc29uIEd1bnRob3JwZSA8
amdnQHppZXBlLmNhPjsgTmF5bmEgSmFpbg0KPiA+PiA8bmF5bmFAbGludXgudm5ldC5pYm0uY29t
PjsgVXN5c2tpbiwgQWxleGFuZGVyDQo+ID4+IDxhbGV4YW5kZXIudXN5c2tpbkBpbnRlbC5jb20+
OyBTdHJ1aywgVGFkZXVzeg0KPiA+PiA8dGFkZXVzei5zdHJ1a0BpbnRlbC5jb20+OyBsaW51eC1p
bnRlZ3JpdHlAdmdlci5rZXJuZWwub3JnOw0KPiA+PiBsaW51eC1zZWN1cml0eS1tb2R1bGVAdmdl
ci5rZXJuZWwub3JnOw0KPiA+PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyByb2JlcnRv
LnNhc3N1QGh1YXdlaS5jb20NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAxMi8yMV0gdHBt
OiBtb3ZlIHBjciBleHRlbmQgY29kZSB0byB0cG0yLWNtZC5jDQo+ID4+DQo+ID4+IE9uIFdlZCwg
T2N0IDAzLCAyMDE4IGF0IDEwOjI0OjA5UE0gKzAwMDAsIFdpbmtsZXIsIFRvbWFzIHdyb3RlOg0K
PiA+Pj4NCj4gPj4+DQo+ID4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+PiBG
cm9tOiBKYXJra28gU2Fra2luZW4gW21haWx0bzpqYXJra28uc2Fra2luZW5AbGludXguaW50ZWwu
Y29tXQ0KPiA+Pj4+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAwMywgMjAxOCAxNTowMg0KPiA+
Pj4+IFRvOiBXaW5rbGVyLCBUb21hcyA8dG9tYXMud2lua2xlckBpbnRlbC5jb20+DQo+ID4+Pj4g
Q2M6IEphc29uIEd1bnRob3JwZSA8amdnQHppZXBlLmNhPjsgTmF5bmEgSmFpbg0KPiA+Pj4+IDxu
YXluYUBsaW51eC52bmV0LmlibS5jb20+OyBVc3lza2luLCBBbGV4YW5kZXINCj4gPj4+PiA8YWxl
eGFuZGVyLnVzeXNraW5AaW50ZWwuY29tPjsgU3RydWssIFRhZGV1c3oNCj4gPj4+PiA8dGFkZXVz
ei5zdHJ1a0BpbnRlbC5jb20+OyBsaW51eC1pbnRlZ3JpdHlAdmdlci5rZXJuZWwub3JnOw0KPiA+
Pj4+IGxpbnV4LXNlY3VyaXR5LW1vZHVsZUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+Pj4gbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgcm9iZXJ0by5zYXNzdUBodWF3ZWkuY29tDQo+ID4+Pj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2NSAxMi8yMV0gdHBtOiBtb3ZlIHBjciBleHRlbmQgY29kZSB0
bw0KPiA+Pj4+IHRwbTItY21kLmMNCj4gPj4+Pg0KPiA+Pj4+IE9uIFR1ZSwgT2N0IDAyLCAyMDE4
IGF0IDA0OjU4OjI1QU0gKzAwMDAsIFdpbmtsZXIsIFRvbWFzIHdyb3RlOg0KPiA+Pj4+Pg0KPiA+
Pj4+Pg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IE9uIFNhdCwgU2VwIDI5LCAyMDE4IGF0IDAxOjMwOjI2
QU0gKzAzMDAsIFRvbWFzIFdpbmtsZXIgd3JvdGU6DQo+ID4+Pj4+Pj4gQWRkIHRwbTJfcGNyX2V4
dGVuZCgpIGZ1bmN0aW9uIHRvIHRwbTItY21kLmMgd2l0aCBzaWduYXR1cmUNCj4gPj4+Pj4+PiBy
ZXF1aXJlZCBieSB0cG0taW50ZXJmYWNlLmMuIEl0IHdyYXBzIHRoZSBvcmlnaW5hbCBvcGVuIGNv
ZGUNCj4gPj4+PiBpbXBsZW1lbnRhdGlvbi4NCj4gPj4+Pj4+PiBUaGUgb3JpZ2luYWwgb3JpZ2lu
YWwgdHBtMl9wY3JfZXh0ZW5kKCkgZnVuY3Rpb24gaXMgcmVuYW1lZCB0bw0KPiA+Pj4+Pj4+IF9f
dHBtMl9wY3JfZXh0ZW5kKCkgYW5kIG1hZGUgc3RhdGljLCBpdCBpcyBjYWxsZWQgb25seSBmcm9t
IG5ldw0KPiA+Pj4+Pj4+IHRwbTJfcGNyX2V4dGVuZCgpLg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4g
Rml4IHdhcm5pbmdzIGluIF9fdHBtMl9wY3JfZXh0ZW5kKCkNCj4gPj4+Pj4+PiB0cG0yLWNtZC5j
OjI1MToxNjogd2FybmluZzogY29tcGFyaXNvbiBiZXR3ZWVuIHNpZ25lZCBhbmQNCj4gPj4+Pj4+
PiB1bnNpZ25lZCBpbnRlZ2VyIGV4cHJlc3Npb25zIFstV3NpZ24tY29tcGFyZV0NCj4gPj4+Pj4+
PiB0cG0yLWNtZC5jOjI1MjoxNzogd2FybmluZzogY29tcGFyaXNvbiBiZXR3ZWVuIHNpZ25lZCBh
bmQNCj4gPj4+Pj4+PiB1bnNpZ25lZCBpbnRlZ2VyIGV4cHJlc3Npb25zIFstV3NpZ24tY29tcGFy
ZV0NCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFRvbWFzIFdpbmtsZXIgPHRv
bWFzLndpbmtsZXJAaW50ZWwuY29tPg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IFdlIGRvIG5vdCB3YW50
IHRoZSBzaWduYXR1cmUgY2hhbmdlLCBlc3BlY2lhbGx5IGJlY2F1c2UgYXMgd2UgYXJlDQo+ID4+
Pj4+PiB3b3JraW5nIG9uIGdldHRpbmcgUm9iZXJ0bydzIGNoYW5nZXMgaW4gYW5kIGFsc28gYmVj
YXVzZSBpdCBoYXMNCj4gPj4+Pj4+IGFic29sdXRlbHkgYSB6ZXJvIGdhaW4uIFdobyBjYXJlcyBp
ZiB0aG9zZSBmdW5jdGlvbnMgdGFrZQ0KPiA+Pj4+Pj4gZGlmZmVyZW50DQo+ID4+Pj4gcGFyYW1l
dGVycz8gSSBkb24ndC4NCj4gPj4+Pj4NCj4gPj4+Pj4gWWVzLCB3ZSBkbyBjYXJlIHRoaXMgc2Vy
aWVzIHRyaWVzIHRvIGhhdmUgYSBjbGVhbiBjdXQgYmV0d2VlbiAxLngNCj4gPj4+Pj4gYW5kIDIu
eA0KPiA+Pj4+IHNwZWNzLiBQbGVhc2UsIGxldCdzIGZpbmlzaCBvbmUgdHJhbnNmb3JtYXRpb24g
YW5kIHRoZW4gbW92ZSB0bw0KPiBhbm90aGVyLg0KPiA+Pj4+PiBJIHVuZGVyc3RhbmQgdGhhdCBS
b2JlcnRvIHdpbGwgaGF2ZSB0byByZWJhc2UgYW55aG93LCBpZiB0aGlzDQo+ID4+Pj4+IHNlcmll
cyBnb2VzIGluDQo+ID4+Pj4gZmlyc3QsIGlmIHRoaXMgaXMgaGFyZCBJIGNhbiBkbyBpdCBteXNl
bGYsIGl0J3MgdHJpdmlhbC4NCj4gPj4+Pj4NCj4gPj4+Pj4gVG9tYXMNCj4gPj4+Pg0KPiA+Pj4+
IEknbSBoYXBweSB0byB0dW5lIHRoaXMgbWlub3Igc3R1ZmYuDQo+ID4+PiBXaGF0IG1pbm9yIHN0
dWZmPyAgVGhpcyBwYXRjaCBpcyBqdXN0IG9rYXksIGxldCdzIGNoYW5nZSB0aGUgQVBJIGluDQo+
ID4+PiBuZXh0DQo+ID4+IHJvdW5kLg0KPiA+Pg0KPiA+PiBUaGUgcGF0Y2ggaXMgbm90IG9rYXkg
YmVjYXVzZSBpdCBkb2VzIGEgY29tcGxldGVseSB1bm5lY2Vzc2FyeSBBUEkNCj4gY2hhbmdlLg0K
PiA+DQo+ID4gVGhlcmUgaXMgbm8gQVBJIGNoYW5nZSwgaW4gdGhhdCBzZW5zZS4NCj4gPiBUaGUg
ZXhwb3J0ZWQgQVBJIGlzIGluIHRwbS1pbnRlcmZhY2UuYyBpbnQgdHBtX3Bjcl9leHRlbmQoc3Ry
dWN0DQo+ID4gdHBtX2NoaXAgKmNoaXAsIGludCBwY3JfaWR4LCBjb25zdCB1OCAqaGFzaCkgdGhh
dCBpcyB1c2VkIGlzIG91dHNpZGUNCj4gPiBvZiB0aGUgdHBtIHJlbWluZHMgdGhlIHNhbWUsIG9u
bHkgdGhlIG9wZW4gY29kZWQgaW1wbGVtZW50YXRpb24gb2YNCj4gdHBtMl9wY3JfZXh0bmVkIGhh
cyBtb3ZlZCB0byB0cG0yLWNtZC5jLCBUaGlzIGNvZGUgaXMgbm90IGNhbGxlZCBvdXQgb2YNCj4g
dHBtIG1vZHVsZS4NCj4gPiBQbGVhc2UgcmV2aWV3IHRoZSBjb2RlIGFnYWluLg0KPiANCj4gSGkg
VG9tYXMNCj4gDQo+IEkgd2lsbCB1cGRhdGUgdHBtX3Bjcl9leHRlbmQoKSBieSByZXBsYWNpbmcg
dGhlIGFycmF5IG9mIHU4IHdpdGggYW4gYXJyYXkgb2YNCj4gdHBtMl9kaWdlc3Qgc3RydWN0dXJl
cywgc28gdGhhdCB0aGUgY2FsbGVyIGNhbiBwcm92aWRlIG11bHRpcGxlIGRpZ2VzdHMgd2l0aA0K
PiBvbmUgY2FsbC4gVGhlIGFycmF5IG9mIHRwbTJfZGlnZXN0IHN0cnVjdHVyZXMgd2lsbCBiZSBw
YXNzZWQgdG8NCj4gdHBtMl9wY3JfZXh0ZW5kKCkuIFBsZWFzZSwgZG9uJ3QgbW9kaWZ5IHRoZSBw
YXJhbWV0ZXJzIG9mDQo+IHRwbTJfcGNyX2V4dGVuZCgpLg0KDQpXaGF0IGFib3V0IHRwbTFfcGNy
X2V4dGVuZC9yZWFkKCk/IA0KDQpUaGFua3MNClRvbWFzIA0KIA0K
