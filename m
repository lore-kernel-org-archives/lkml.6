Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69028C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138F620857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138F620857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbeG0Ias (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 04:30:48 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:61237 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729442AbeG0Ias (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 04:30:48 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6R79NWN004746;
        Fri, 27 Jul 2018 09:10:13 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2kf8sq5jw6-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 09:10:13 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D030031;
        Fri, 27 Jul 2018 07:10:11 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A82922643;
        Fri, 27 Jul 2018 07:10:11 +0000 (GMT)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 27 Jul
 2018 09:10:11 +0200
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1347.000; Fri, 27 Jul 2018 09:10:11 +0200
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     Suman Anna <s-anna@ti.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arnaud POULIQUEN" <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: RE: [PATCH v2 1/1] remoteproc: correct rproc_free_vring() to avoid
 invalid kernel paging
Thread-Topic: [PATCH v2 1/1] remoteproc: correct rproc_free_vring() to avoid
 invalid kernel paging
Thread-Index: AQHUFP2jqyvznuLIQEOFVequ6yz8w6SgfKYAgAC5gfCAAPWQgIAAm4ZQ
Date:   Fri, 27 Jul 2018 07:10:11 +0000
Message-ID: <786f20f507924db2a9b3aa3cdc18e6cd@SFHDAG7NODE2.st.com>
References: <1530863212-16584-1-git-send-email-loic.pallardy@st.com>
 <ee64ddf7-e9c6-0b77-8a4e-44f77d264fe0@ti.com>
 <8e943f4d2a1b4e10a8a0756c737d53a8@SFHDAG7NODE2.st.com>
 <56aeb569-cd4d-3769-fdad-ee3d4dbdc19b@ti.com>
In-Reply-To: <56aeb569-cd4d-3769-fdad-ee3d4dbdc19b@ti.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3VtYW4sIA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN1bWFu
IEFubmEgPHMtYW5uYUB0aS5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSnVseSAyNywgMjAxOCAxOjUy
IEFNDQo+IFRvOiBMb2ljIFBBTExBUkRZIDxsb2ljLnBhbGxhcmR5QHN0LmNvbT47IGJqb3JuLmFu
ZGVyc3NvbkBsaW5hcm8ub3JnOw0KPiBvaGFkQHdpemVyeS5jb20NCj4gQ2M6IGxpbnV4LXJlbW90
ZXByb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBB
cm5hdWQgUE9VTElRVUVOIDxhcm5hdWQucG91bGlxdWVuQHN0LmNvbT47DQo+IGJlbmphbWluLmdh
aWduYXJkQGxpbmFyby5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzFdIHJlbW90ZXBy
b2M6IGNvcnJlY3QgcnByb2NfZnJlZV92cmluZygpIHRvIGF2b2lkDQo+IGludmFsaWQga2VybmVs
IHBhZ2luZw0KPiANCj4gSGkgTG9pYywNCj4gDQo+IE9uIDA3LzI2LzIwMTggMDI6NDggQU0sIExv
aWMgUEFMTEFSRFkgd3JvdGU6DQo+ID4gSGkgU3VtYW4sDQo+ID4+DQo+ID4+IEhpIExvaWMsDQo+
ID4+DQo+ID4+IE9uIDA3LzA2LzIwMTggMDI6NDYgQU0sIExvaWMgUGFsbGFyZHkgd3JvdGU6DQo+
ID4+PiBJZiBycHJvY19zdGFydCgpIGZhaWxlZCwgcnByb2NfcmVzb3VyY2VfY2xlYW51cCgpIGlz
IGNhbGxlZCB0byBjbGVhbg0KPiA+Pj4gZGVidWdmcyBlbnRyaWVzLCB0aGVuIGFzc29jaWF0ZWQg
aW9tbXUgbWFwcGluZ3MsIGNhcnZlb3V0cyBhbmQgdmRldi4NCj4gPj4+IElzc3VlIG9jY3VycyB3
aGVuIHJwcm9jX2ZyZWVfdnJpbmcoKSBpcyB0cnlpbmcgdG8gcmVzZXQgdnJpbmcgcmVzb3VyY2UN
Cj4gPj4+IHRhYmxlIGVudHJ5Lg0KPiA+Pj4gQXQgdGhpcyB0aW1lLCB0YWJsZV9wdHIgaXMgcG9p
bnRpbmcgb24gbG9hZGVkIHJlc291cmNlIHRhYmxlIGFuZCBjYXJ2ZW91dHMNCj4gPj4+IGFscmVh
ZHkgcmVsZWFzZWQsIHNvIGFjY2VzcyB0byBsb2FkZWQgcmVzb3VyY2UgdGFibGUgaXMgZ2VuZXJh
dGluZyBhDQo+IGtlcm5lbA0KPiA+Pj4gcGFnaW5nIGVycm9yOg0KPiA+Pg0KPiA+PiBBcmUgeW91
IHVzaW5nIGEgZGV2aWNlIHNwZWNpZmljIENNQSBwb29sIG9yIGNhcnZlb3V0LCBhbmQgaWYgc28s
IHdoZXJlDQo+ID4+IHRoZSBwb29sIGlzPyBJZiBub3QsIHdoZXJlIGlzIHRoZSBkZWZhdWx0IENN
QSBwb29sPyBJIGFtIHRyeWluZyB0bw0KPiA+PiByZXByb2R1Y2UgdGhlIGlzc3VlIG9uIG15IHBs
YXRmb3JtIHdpdGggdGhlIHN0YXJ0IGZhaWx1cmUgYXMgeW91DQo+ID4+IHN1Z2dlc3RlZCwgYnV0
IGhhdmVuJ3Qgc2VlbiBpdCBzbyBmYXIuIFRoYXQgc2FpZCwgSSBoYXZlIHNlZW4gdGhlIGV4YWN0
DQo+ID4+IHNhbWUgY3Jhc2ggd2hlbiB1c2luZyBIaWdoTUVNIENNQSBwb29scyBvbiBteSBkb3du
c3RyZWFtIGtlcm5lbA0KPiA+PiB3aGVuDQo+ID4+IHN0b3BwaW5nIHRoZSBwcm9jZXNzb3IsIGFu
ZCB0aGUgcm9vdCBjYXVzZSBpcyBlc3NlbnRpYWxseSB0aGUgc2FtZSBhcw0KPiA+PiB3aGF0IHlv
dSBzdW1tYXJpemVkIGhlcmUuIFRoZSBpc3N1ZSB3YXMgcHJlc2VudCB3aXRoIExvd01lbSBwb29s
cw0KPiBhcw0KPiA+PiB3ZWxsLCBidXQgZ290IG1hc2tlZCBiZWNhdXNlIG9mIHRoZSBrZXJuZWwg
bGluZWFyIG1hcHBpbmcuDQo+ID4NCj4gPiBJIGhhdmUgYSBjYXJ2ZW91dCBkZWNsYXJlZCBpbiBm
aXJtd2FyZSByZXNvdXJjZSB0YWJsZSBmb3IgY28tcHJvY2Vzc29yDQo+IGNvZGUgYW5kIGRhdGEs
IGFuZCBzdCBkcml2ZXIgaGFzIGEgc3BlY2lmaWMNCj4gPiByZXNlcnZlZCBtZW1vcnkgcmVnaW9u
IHRvIGZpdCBmaXggYWRkcmVzcyBzcGFjZSByZXF1ZXN0ZWQgYnkgY28tDQo+IHByb2Nlc3Nvci4N
Cj4gPiBTbyBDUFUgYWNjZXNzIHRvIGNvZGUgYW5kIGxvYWRlZCByZXNvdXJjZSB0YWJsZSBhcmVh
IGlzIGdyYW50ZWQgdGhhbmtzIHRvDQo+IGFsbG9jYXRpb24gZG9uZSBieSBycHJvY19oYW5kbGVf
Y2FydmVvdXQoKS4NCj4gDQo+IFdoZXJlIGFyZSB0aGUgdnJpbmdzIGdldHRpbmcgYWxsb2NhdGVk
IGZyb20/DQoNClZyaW5ncyBhcmUgYWxsb2NhdGVkIGZyb20gc2FtZSByZXNlcnZlZCBtZW1vcnkg
cmVnaW9uIGFzc2lnbmVkIHRvIFNUIHBsYXRmb3JtIGRyaXZlci4NCj4gDQo+IEluIGFueWNhc2Us
IEkgcHJlZmVyIHRoYXQgd2Ugc2hvdWxkIGFjdHVhbGx5IHJlc2V0IHRoZSB0YWJsZV9wdHIgaW4N
Cj4gcnByb2Nfc3RhcnQoKSBpbiBmYWlsdXJlIGNhc2VzICh1bmRvIHRoZSBvcGVyYXRpb24gZXNz
ZW50aWFsbHkpIGFzIHdlDQo+IGRvbid0IGNhbGwgcnByb2Nfc3RvcCgpIGluIHRob3NlIGNhc2Vz
LiBUaGlzIHdpbGwgcmVzdWx0IGluIHN5bW1ldHJpYw0KPiBjb2RlLiBXZSBhbHJlYWR5IGhhdmUg
dGhlIHJlc2V0IGhhbmRsZWQgaW4gcnByb2Nfc3RvcCgpIGFkZGVkIHJlY2VudGx5DQo+IGluIGNv
bW1pdCAwYThiODFjYjJlNDEgKCJyZW1vdGVwcm9jOiBSZXNldCB0YWJsZV9wdHIgb24gc3RvcCIp
LiBMZXQgbWUNCj4ga25vdyB3aGF0IHlvdSB0aGluaywgSSBjYW4gc2VuZCBhIHF1aWNrIHBhdGNo
Lg0KDQpBZ3JlZSBiZXR0ZXIgdG8gaGF2ZSBzeW1tZXRyaWMgY29kZS4gU2hvdWxkIGJlIE9LLiBJ
J2xsIHRlc3RlZCAuDQoNClJlZ2FyZHMsDQpMb2ljDQo+IA0KPiByZWdhcmRzDQo+IFN1bWFuDQo+
IA0KPiA+DQo+ID4+DQo+ID4+Pg0KPiA+Pj4gWyAgIDEyLjY5NjUzNV0gVW5hYmxlIHRvIGhhbmRs
ZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQgdmlydHVhbCBhZGRyZXNzDQo+ID4+IGYwZjM1N2Nj
DQo+ID4+PiBbICAgMTIuNjk2NTQwXSBwZ2QgPSAocHRydmFsKQ0KPiA+Pj4gWyAgIDEyLjY5NjU0
Ml0gW2YwZjM1N2NjXSAqcGdkPTZkMmQwODExLCAqcHRlPTAwMDAwMDAwLA0KPiAqcHB0ZT0wMDAw
MDAwMA0KPiA+Pj4gWyAgIDEyLjY5NjU1OF0gSW50ZXJuYWwgZXJyb3I6IE9vcHM6IDgwNyBbIzFd
IFNNUCBBUk0NCj4gPj4+IFsgICAxMi42OTY1NjNdIE1vZHVsZXMgbGlua2VkIGluOiBycG1zZ19j
b3JlIHY0bDJfbWVtMm1lbQ0KPiA+PiB2aWRlb2J1ZjJfZG1hX2NvbnRpZyBzdGlfZHJtIHY0bDJf
Y29tbW9uIHZpZGENCj4gPj4+IFsgICAxMi42OTY1OThdIENQVTogMSBQSUQ6IDQ4IENvbW06IGt3
b3JrZXIvMToxIFRhaW50ZWQ6IEcgICAgICAgIFcNCj4gPj4gNC4xOC4wLXJjMi0wMDAxOC1nMzE3
MGZkZC04DQo+ID4+PiBbICAgMTIuNjk2NjAyXSBIYXJkd2FyZSBuYW1lOiBTVGkgU29DIHdpdGgg
RmxhdHRlbmVkIERldmljZSBUcmVlDQo+ID4+PiBbICAgMTIuNjk2NjI1XSBXb3JrcXVldWU6IGV2
ZW50cyByZXF1ZXN0X2Zpcm13YXJlX3dvcmtfZnVuYw0KPiA+Pj4gWyAgIDEyLjY5NjY1OV0gUEMg
aXMgYXQgcnByb2NfZnJlZV92cmluZysweDg0LzB4YmMgW3JlbW90ZXByb2NdDQo+ID4+PiBbICAg
MTIuNjk2NjY3XSBMUiBpcyBhdCBycHJvY19mcmVlX3ZyaW5nKzB4NzAvMHhiYyBbcmVtb3RlcHJv
Y10NCj4gPj4+DQo+ID4+PiBUaGlzIHBhdGNoIHByb3Bvc2VzIHRvIHNpbXBseSByZW1vdmUgcmVz
ZXQgb2YgcmVzb3VyY2UgdGFibGUgdnJpbmcNCj4gZW50cmllcywNCj4gPj4+IGFzIGZpcm13YXJl
IGFuZCByZXNvdXJjZSB0YWJsZSBhcmUgcmVsb2FkZWQgYXQgZWFjaCBycHJvYyBib290Lg0KPiA+
Pj4gcnByb2NfdHJpZ2dlcl9yZWNvdmVyeSgpIG5vdCBpbXBhY3RlZCBhcyByZXNvdXJjZXMgbm90
IHRvdWNoZWQgZHVyaW5nDQo+ID4+IHJlY292ZXJ5DQo+ID4+PiBwcm9jZWR1cmUuDQo+ID4+DQo+
ID4+IEFuZCBlcnJvciByZWNvdmVyeSBkb2Vzbid0IHdvcmsgZm9yIG1lIGFmdGVyIHRoZSBycHJv
Y19zdGFydCwgc3RvcCBnb3QNCj4gPj4gaW50cm9kdWNlZC4NCj4gPiBSZWNvdmVyeSBubyBhdmFp
bGFibGUgb24gQjIyNjAsIGJ1dCBJJ2xsIHRlc3QgaXQgb24gYW5vdGhlciBwbGF0Zm9ybSB0aGlz
DQo+IHdlZWsNCj4gPg0KPiA+IFJlZ2FyZHMsDQo+ID4gTG9pYw0KPiA+Pg0KPiA+PiByZWdhcmRz
DQo+ID4+IFN1bWFuDQo+ID4+DQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogTG9pYyBQYWxs
YXJkeSA8bG9pYy5wYWxsYXJkeUBzdC5jb20+DQo+ID4+PiAtLS0NCj4gPj4+IENoYW5nZXMgZnJv
bSBWMTogdHlwbyBmaXhlcyBpbiBjb21taXQgbWVzc2FnZQ0KPiA+Pj4NCj4gPj4+ICBkcml2ZXJz
L3JlbW90ZXByb2MvcmVtb3RlcHJvY19jb3JlLmMgfCA2IC0tLS0tLQ0KPiA+Pj4gIDEgZmlsZSBj
aGFuZ2VkLCA2IGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3JlbW90ZXByb2MvcmVtb3RlcHJvY19jb3JlLmMNCj4gPj4gYi9kcml2ZXJzL3JlbW90ZXByb2Mv
cmVtb3RlcHJvY19jb3JlLmMNCj4gPj4+IGluZGV4IGE5NjA5ZDkuLjlhOGI0N2MgMTAwNjQ0DQo+
ID4+PiAtLS0gYS9kcml2ZXJzL3JlbW90ZXByb2MvcmVtb3RlcHJvY19jb3JlLmMNCj4gPj4+ICsr
KyBiL2RyaXZlcnMvcmVtb3RlcHJvYy9yZW1vdGVwcm9jX2NvcmUuYw0KPiA+Pj4gQEAgLTI4OSwx
NiArMjg5LDEwIEBAIHZvaWQgcnByb2NfZnJlZV92cmluZyhzdHJ1Y3QgcnByb2NfdnJpbmcNCj4g
KnJ2cmluZykNCj4gPj4+ICB7DQo+ID4+PiAgCWludCBzaXplID0gUEFHRV9BTElHTih2cmluZ19z
aXplKHJ2cmluZy0+bGVuLCBydnJpbmctPmFsaWduKSk7DQo+ID4+PiAgCXN0cnVjdCBycHJvYyAq
cnByb2MgPSBydnJpbmctPnJ2ZGV2LT5ycHJvYzsNCj4gPj4+IC0JaW50IGlkeCA9IHJ2cmluZy0+
cnZkZXYtPnZyaW5nIC0gcnZyaW5nOw0KPiA+Pj4gLQlzdHJ1Y3QgZndfcnNjX3ZkZXYgKnJzYzsN
Cj4gPj4+DQo+ID4+PiAgCWRtYV9mcmVlX2NvaGVyZW50KHJwcm9jLT5kZXYucGFyZW50LCBzaXpl
LCBydnJpbmctPnZhLCBydnJpbmctDQo+ID4+PiBkbWEpOw0KPiA+Pj4gIAlpZHJfcmVtb3ZlKCZy
cHJvYy0+bm90aWZ5aWRzLCBydnJpbmctPm5vdGlmeWlkKTsNCj4gPj4+DQo+ID4+PiAtCS8qIHJl
c2V0IHJlc291cmNlIGVudHJ5IGluZm8gKi8NCj4gPj4+IC0JcnNjID0gKHZvaWQgKilycHJvYy0+
dGFibGVfcHRyICsgcnZyaW5nLT5ydmRldi0+cnNjX29mZnNldDsNCj4gPj4+IC0JcnNjLT52cmlu
Z1tpZHhdLmRhID0gMDsNCj4gPj4+IC0JcnNjLT52cmluZ1tpZHhdLm5vdGlmeWlkID0gLTE7DQo+
ID4+PiAgfQ0KPiA+Pj4NCj4gPj4+ICBzdGF0aWMgaW50IHJwcm9jX3ZkZXZfZG9fcHJvYmUoc3Ry
dWN0IHJwcm9jX3N1YmRldiAqc3ViZGV2KQ0KPiA+Pj4NCj4gPg0KDQo=
