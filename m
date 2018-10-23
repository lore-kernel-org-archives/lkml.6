Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67869C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E84204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E84204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbeJXDeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:34:22 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:3043 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728385AbeJXDeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:34:22 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9NIwpgB024945;
        Tue, 23 Oct 2018 21:09:38 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2n7sg63v1j-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 23 Oct 2018 21:09:38 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 572C631;
        Tue, 23 Oct 2018 19:09:37 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 31B7D57C0;
        Tue, 23 Oct 2018 19:09:37 +0000 (GMT)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 23 Oct
 2018 21:09:36 +0200
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1347.000; Tue, 23 Oct 2018 21:09:36 +0200
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     Suman Anna <s-anna@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: RE: [PATCH v2 05/16] remoteproc: modify rproc_handle_carveout to
 support preallocated region
Thread-Topic: [PATCH v2 05/16] remoteproc: modify rproc_handle_carveout to
 support preallocated region
Thread-Index: AQHTafrgFKJWaT8i9U+6eSuoiZVPw6NCCM+AgC4XMNCBvtljAIAAOP0g
Date:   Tue, 23 Oct 2018 19:09:36 +0000
Message-ID: <717bc0509ad54c4e8a9f601b8220edc2@SFHDAG7NODE2.st.com>
References: <1512060411-729-1-git-send-email-loic.pallardy@st.com>
 <1512060411-729-6-git-send-email-loic.pallardy@st.com>
 <20171214005917.GG17344@builder>
 <0bbc0455b6ee45cdb0ebab04117b6a40@SFHDAG7NODE2.st.com>
 <9ced2a8b-916e-9447-4be7-6316385ade0a@ti.com>
In-Reply-To: <9ced2a8b-916e-9447-4be7-6316385ade0a@ti.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-23_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3VtYW4gQW5uYSA8cy1h
bm5hQHRpLmNvbT4NCj4gU2VudDogbWFyZGkgMjMgb2N0b2JyZSAyMDE4IDE5OjQwDQo+IFRvOiBM
b2ljIFBBTExBUkRZIDxsb2ljLnBhbGxhcmR5QHN0LmNvbT47IEJqb3JuIEFuZGVyc3Nvbg0KPiA8
Ympvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc+DQo+IENjOiBvaGFkQHdpemVyeS5jb207IGxpbnV4
LXJlbW90ZXByb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgQXJuYXVkIFBPVUxJUVVFTiA8YXJuYXVkLnBvdWxpcXVlbkBzdC5jb20+Ow0KPiBiZW5q
YW1pbi5nYWlnbmFyZEBsaW5hcm8ub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDUvMTZd
IHJlbW90ZXByb2M6IG1vZGlmeSBycHJvY19oYW5kbGVfY2FydmVvdXQgdG8NCj4gc3VwcG9ydCBw
cmVhbGxvY2F0ZWQgcmVnaW9uDQo+IA0KPiA+Pg0KPiA+PiBPbiBUaHUgMzAgTm92IDA4OjQ2IFBT
VCAyMDE3LCBMb2ljIFBhbGxhcmR5IHdyb3RlOg0KPiA+Pg0KPiA+Pj4gSW4gY3VycmVudCB2ZXJz
aW9uIHJwcm9jX2hhbmRsZV9jYXJ2ZW91dCBmdW5jdGlvbiBzdXBwb3J0IG9ubHkgZHluYW1pYw0K
PiA+Pj4gcmVnaW9uIGFsbG9jYXRpb24uDQo+ID4+PiBUaGlzIHBhdGNoIGV4dGVuZHMgcnByb2Nf
aGFuZGxlX2NhcnZlb3V0IGZ1bmN0aW9uIHRvIHN1cHBvcnQgZGlmZmVyZW50DQo+ID4+IGNhcnZl
b3V0DQo+ID4+PiBjb25maWd1cmF0aW9uczoNCj4gPj4+IC0gZml4ZWQgREEgYW5kIGZpeGVkIFBB
OiBjaGVjayBpZiBhbHJlYWR5IHBhcnQgb2YgcHJlLXJlZ2lzdGVyZWQgY2FydmVvdXRzDQo+ID4+
PiAocGxhdGZvcm0gZHJpdmVyKS4gSWYgbm8sIHJldHVybiBlcnJvci4NCj4gPj4+IC0gZml4ZWQg
REEgYW5kIGFueSBQQTogY2hlY2sgaWYgYWxyZWFkeSBwYXJ0IG9mIHByZS1hbGxvY2F0ZWQgY2Fy
dmVvdXRzDQo+ID4+PiAocGxhdGZvcm0gZHJpdmVyKS4gSWYgbm90IGZvdW5kIGFuZCBycHJvYyBz
dXBwb3J0cyBpb21tdSwgY29udGludWUgd2l0aA0KPiA+Pj4gZHluYW1pYyBhbGxvY2F0aW9uIChE
QSB3aWxsIGJlIHVzZWQgZm9yIGlvbW11IHByb2dyYW1taW5nKSwgZWxzZQ0KPiByZXR1cm4NCj4g
Pj4+IGVycm9yIGFzIG5vIHdheSB0byBmb3JjZSBEQS4NCj4gPj4+IC0gYW55IERBIGFuZCBhbnkg
UEE6IHVzZSBvcmlnaW5hbCBkeW5hbWljIGFsbG9jYXRpb24NCj4gPj4+DQo+ID4+PiBTaWduZWQt
b2ZmLWJ5OiBMb2ljIFBhbGxhcmR5IDxsb2ljLnBhbGxhcmR5QHN0LmNvbT4NCj4gPj4+IC0tLQ0K
PiA+Pj4gIGRyaXZlcnMvcmVtb3RlcHJvYy9yZW1vdGVwcm9jX2NvcmUuYyB8IDQwDQo+ID4+ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+Pj4gIDEgZmlsZSBjaGFuZ2Vk
LCA0MCBpbnNlcnRpb25zKCspDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVt
b3RlcHJvYy9yZW1vdGVwcm9jX2NvcmUuYw0KPiA+PiBiL2RyaXZlcnMvcmVtb3RlcHJvYy9yZW1v
dGVwcm9jX2NvcmUuYw0KPiA+Pj4gaW5kZXggNzg1MjVkMS4uNTE1YTE3YSAxMDA2NDQNCj4gPj4+
IC0tLSBhL2RyaXZlcnMvcmVtb3RlcHJvYy9yZW1vdGVwcm9jX2NvcmUuYw0KPiA+Pj4gKysrIGIv
ZHJpdmVycy9yZW1vdGVwcm9jL3JlbW90ZXByb2NfY29yZS5jDQo+ID4+PiBAQCAtMTg0LDYgKzE4
NCwxMCBAQCB2b2lkICpycHJvY19kYV90b192YShzdHJ1Y3QgcnByb2MgKnJwcm9jLCB1NjQNCj4g
ZGEsDQo+ID4+IGludCBsZW4pDQo+ID4+PiAgCXN0cnVjdCBycHJvY19tZW1fZW50cnkgKmNhcnZl
b3V0Ow0KPiA+Pj4gIAl2b2lkICpwdHIgPSBOVUxMOw0KPiA+Pj4NCj4gPj4+ICsJLyoNCj4gPj4+
ICsJICogZGFfdG9fdmEgcGxhdGZvcm0gZHJpdmVyIGlzIGRlcHJlY2F0ZWQuIERyaXZlciBzaG91
bGQgcmVnaXN0ZXINCj4gPj4+ICsJICogY2FydmVvdXQgdGhhbmtzIHRvIHJwcm9jX2FkZF9jYXJ2
ZW91dCBmdW5jdGlvbg0KPiA+Pj4gKwkgKi8NCj4gPj4NCj4gPj4gSSB0aGluayB0aGlzIGNvbW1l
bnQgaXMgdW5yZWxhdGVkIHRvIHRoZSByZXN0IG9mIHRoaXMgcGF0Y2guIEkgYWxzbw0KPiA+PiB0
aGluayB0aGF0IGF0IHRoZSBlbmQgb2YgdGhlIGNhcnZlb3V0LXJld29yayB3ZSBzaG91bGQgaGF2
ZSBhIHBhdGNoDQo+ID4+IHJlbW92aW5nIHRoaXMgb3BzLg0KPiA+DQo+ID4gSSdsbCByZW1vdmUg
dGhpcyBjb21tZW50IGFuZCBhZGQgYSBkYV90b192YSBjbGVhbi11cCBwYXRjaCBhdCB0aGUgZW5k
IG9mDQo+IHRoZSBzZXJpZXMNCj4gDQo+IGRhX3RvX3ZhIHBsYXRmb3JtIG9wcyBpcyBhY3R1YWxs
eSB1c2VkIHRvIHByb3ZpZGUgdGhlIHJlbW90ZXByb2MNCj4gaW50ZXJuYWwgbWVtb3J5IHRyYW5z
bGF0aW9ucyBmb3IgdGhlIG1vc3QgcGFydCwgbm90IHJlc3RyaWN0ZWQganVzdCB0bw0KPiBmaXhl
ZCBjYXJ2ZW91dHMuIEFsc28sIHR5cGljYWxseSB0aGVzZSBkbyBoYXZlIG11bHRpcGxlIGFkZHJl
c3Mtdmlld3MgLQ0KPiBvbmUgdGhlIHJlZ3VsYXIgYnVzLWFkZHJlc3MgdmlldywgYW5kIGFub3Ro
ZXIgYSByZW1vdGUgcHJvY2Vzc29yIGFkZHJlc3MNCj4gdmlldy4NCg0KZGFfdG9fdmEgb3Agc2lz
IHN0aWxsIHRoZXJlLiBJIHdhcyBwcm9wb3NpbmcgdG8gcmVtb3ZlIHRoaXMgb3BzIGFzIHdlIHdl
cmUgZGlzY3Vzc2luZyB0byByZWdpc3RlciBhbGwgY2FydmVvdXRzIGFjY2Vzc2VkIGJ5IGNvcHJv
Y2Vzc29yIGluIHJwcm9jIGNvcmUgY2FydmVvdXQgbGlzdC4NClRoaXMgd2lsbCBhbGxvdyB0byBj
ZW50cmFsaXplIGFsbCBjYXJ2ZW91dCBkZWZpbml0aW9ucyBhbmQgdG8gc2VlIGFsbCBtZW1vcnkg
cmVzb3VyY2VzIHZpZXdlZCBieSBjb3Byb2Nlc3NvciAodmEsIHBhIGFuZCBkYSkgdmlhIGRlYnVn
ZnMuLi4NCg0KUmVnYXJkcywNCkxvaWMNCj4gDQo+IHJlZ2FyZHMNCj4gU3VtYW4NCj4gDQo+ID4N
Cj4gPj4NCj4gPj4+ICAJaWYgKHJwcm9jLT5vcHMtPmRhX3RvX3ZhKSB7DQo+ID4+PiAgCQlwdHIg
PSBycHJvYy0+b3BzLT5kYV90b192YShycHJvYywgZGEsIGxlbik7DQo+ID4+PiAgCQlpZiAocHRy
KQ0KPiA+Pj4gQEAgLTY3Nyw2ICs2ODEsNyBAQCBzdGF0aWMgaW50IHJwcm9jX2hhbmRsZV9jYXJ2
ZW91dChzdHJ1Y3QgcnByb2MNCj4gPj4gKnJwcm9jLA0KPiA+Pj4gIAlzdHJ1Y3QgcnByb2NfbWVt
X2VudHJ5ICpjYXJ2ZW91dCwgKm1hcHBpbmc7DQo+ID4+PiAgCXN0cnVjdCBkZXZpY2UgKmRldiA9
ICZycHJvYy0+ZGV2Ow0KPiA+Pj4gIAlkbWFfYWRkcl90IGRtYTsNCj4gPj4+ICsJcGh5c19hZGRy
X3QgcGE7DQo+ID4+PiAgCXZvaWQgKnZhOw0KPiA+Pj4gIAlpbnQgcmV0Ow0KPiA+Pj4NCj4gPj4+
IEBAIC02OTgsNiArNzAzLDQxIEBAIHN0YXRpYyBpbnQgcnByb2NfaGFuZGxlX2NhcnZlb3V0KHN0
cnVjdCBycHJvYw0KPiA+PiAqcnByb2MsDQo+ID4+PiAgCWlmICghY2FydmVvdXQpDQo+ID4+PiAg
CQlyZXR1cm4gLUVOT01FTTsNCj4gPj4+DQo+ID4+PiArCS8qIENoZWNrIGNhcnZlb3V0IHJzYyBh
bHJlYWR5IHBhcnQgb2YgYSByZWdpc3RlcmVkIGNhcnZlb3V0ICovDQo+ID4+PiArCWlmIChyc2Mt
PmRhICE9IEZXX1JTQ19BRERSX0FOWSkgew0KPiA+Pg0KPiA+PiBBcyBtZW50aW9uZWQgYmVmb3Jl
LCBJIGNvbnNpZGVyIGl0IHBlcmZlY3RseSB2aWFibGUgZm9yIHJzYy0+ZGEgdG8gYmUNCj4gPj4g
QU5ZIGFuZCB0aGUgZHJpdmVyIHByb3ZpZGluZyBhIGZpeGVkIGNhcnZlb3V0Lg0KPiA+DQo+ID4g
WWVzIEknbGwgY2hhbmdlIHNlcXVlbmNlIHRvIGxvb2t1cCBieSBuYW1lIGZpcnN0IGFuZCB0aGVu
IHZlcmlmeSBleGFjdA0KPiBwYXJhbWV0ZXJzIG1hdGNoaW5nICwgbm90IG9ubHkgZGEgZGVmaW5p
dGlvbi4NCj4gPg0KPiA+Pg0KPiA+Pj4gKwkJdmEgPSBycHJvY19maW5kX2NhcnZlb3V0X2J5X2Rh
KHJwcm9jLCByc2MtPmRhLCByc2MtPmxlbik7DQo+ID4+PiArDQo+ID4+PiArCQlpZiAodmEpIHsN
Cj4gPj4NCj4gPj4gSW4gYSBzeXN0ZW0gd2l0aCBhbiBpb21tdSBpdCdzIHBvc3NpYmxlIHRoYXQg
cnNjLT5sZW4gaXMgbGFyZ2VyIHRoYW4NCj4gPj4gc29tZSBjYXJ2ZW91dC0+bGVuIGFuZCB2YSBp
cyBOVUxMIGhlcmUgc28gd2UgZmFsbCB0aHJvdWdoLCBhbGxvY2F0ZSBzb21lDQo+ID4+IG1lbW9y
eSBhbmQgcmVtYXAgYSBzZWdtZW50IG9mIHRoZSBjYXJ2ZW91dC4gKE9yIGhvcGVmdWxseSBmYWls
cw0KPiA+PiBhdHRlbXB0aW5nKS4NCj4gPj4NCj4gPj4+ICsJCQkvKiBSZWdpc3RlcmVkIHJlZ2lv
biBmb3VuZCAqLw0KPiA+Pj4gKwkJCXBhID0gcnByb2NfdmFfdG9fcGEodmEpOw0KPiA+Pj4gKwkJ
CWlmIChyc2MtPnBhICE9IEZXX1JTQ19BRERSX0FOWSAmJiByc2MtPnBhICE9DQo+ID4+ICh1MzIp
cGEpIHsNCj4gPj4+ICsJCQkJLyogQ2FydmVvdXQgZG9lc24ndCBtYXRjaCByZXF1ZXN0ICovDQo+
ID4+PiArCQkJCWRldl9lcnIoZGV2LT5wYXJlbnQsDQo+ID4+PiArCQkJCQkiRmFpbGVkIHRvIGZp
bmQgY2FydmVvdXQgZml0dGluZyBkYSBhbmQNCj4gPj4gcGFcbiIpOw0KPiA+Pj4gKwkJCQlyZXR1
cm4gLUVOT01FTTsNCj4gPj4+ICsJCQl9DQo+ID4+PiArDQo+ID4+PiArCQkJLyogVXBkYXRlIHJz
YyB0YWJsZSB3aXRoIHBoeXNpY2FsIGFkZHJlc3MgKi8NCj4gPj4+ICsJCQlyc2MtPnBhID0gKHUz
MilwYTsNCj4gPj4+ICsNCj4gPj4+ICsJCQkvKiBVcGRhdGUgY2FydmVvdXRzIGxpc3QgKi8NCj4g
Pj4+ICsJCQljYXJ2ZW91dC0+dmEgPSB2YTsNCj4gPj4+ICsJCQljYXJ2ZW91dC0+bGVuID0gcnNj
LT5sZW47DQo+ID4+PiArCQkJY2FydmVvdXQtPmRhID0gcnNjLT5kYTsNCj4gPj4+ICsJCQljYXJ2
ZW91dC0+cHJpdiA9ICh2b2lkICopQ0FSVkVPVVRfUlNDOw0KPiA+Pj4gKw0KPiA+Pj4gKwkJCWxp
c3RfYWRkX3RhaWwoJmNhcnZlb3V0LT5ub2RlLCAmcnByb2MtPmNhcnZlb3V0cyk7DQo+ID4+DQo+
ID4+IHJwcm9jX2ZpbmRfY2FydmVvdXRfYnlfZGEoKSB3aWxsIHJldHVybiBhIHJlZmVyZW5jZSBp
bnRvIGEgY2FydmVvdXQsIG5vdw0KPiA+PiB3ZSBhZGQgYW5vdGhlciBvdmVybGFwcGluZyBjYXJ2
ZW91dCBpbnRvIHRoZSBzYW1lIGxpc3QuDQo+ID4+DQo+ID4+DQo+ID4+IEkgdGhpbmsgaXQgd291
bGQgYmUgc2FuZXIgdG8gbm90IGFsbG93IHRoZSByZXNvdXJjZSB0YWJsZSB0byBkZXNjcmliZQ0K
PiA+PiBzdWJzZXRzIG9mIGNhcnZlb3V0cyByZWdpc3RlcmVkIGJ5IHRoZSBkcml2ZXIuDQo+ID4+
DQo+ID4+IEluIHdoaWNoIGNhc2UgdGhpcyB3b3VsZCBiZXR0ZXIgZmluZCBhIGNhcnZlb3V0IGJ5
IG5hbWUgb3IgZXhhY3QgZGEsDQo+ID4+IHRoZW4gY2hlY2sgdGhhdCB0aGUgcGEsIGRhLCBsZW4g
YW5kIHJzYy0+ZmxhZ3MgYXJlIGFkZXF1YXRlLg0KPiA+DQo+ID4gQWdyZWUNCj4gPiAvTG9pYw0K
PiA+Pg0KPiA+Pj4gKw0KPiA+Pj4gKwkJCXJldHVybiAwOw0KPiA+Pj4gKwkJfQ0KPiA+Pj4gKw0K
PiA+Pj4gKwkJaWYgKCFycHJvYy0+ZG9tYWluKSB7DQo+ID4+DQo+ID4+IEN1cnJlbnRseSB0aGlz
IGZ1bmN0aW9uIGlnbm9yZSBpbnZhbGlkIHZhbHVlcyBvZiBkYSB3aGVuICFkb21haW4sIHNvIEkN
Cj4gPj4gdGhpbmsgaXQgd291bGQgYmUgZ29vZCB5b3UgY2FuIHN1Ym1pdCB0aGlzIHNhbml0eSBj
aGVjayBpbiBpdCdzIG93bg0KPiA+PiBwYXRjaCBzbyB0aGF0IGFueW9uZSBiaXNlY3RpbmcgdGhp
cyB3b3VsZCBrbm93IHdoeSB0aGVpciBicm9rZW4NCj4gZmlybXdhcmUNCj4gPj4gc3VkZGVubHkg
aXNuJ3QgbG9hZGFibGUuDQo+ID4+DQo+ID4+PiArCQkJZGV2X2VycihkZXYtPnBhcmVudCwNCj4g
Pj4+ICsJCQkJIkJhZCBjYXJ2ZW91dCByc2MgY29uZmlndXJhdGlvblxuIik7DQo+ID4+PiArCQkJ
cmV0dXJuIC1FTk9NRU07DQo+ID4+PiArCQl9DQo+ID4+PiArCX0NCj4gPj4+ICsNCj4gPj4NCj4g
Pj4gUmVnYXJkcywNCj4gPj4gQmpvcm4NCj4gPiAtLQ0KPiA+IFRvIHVuc3Vic2NyaWJlIGZyb20g
dGhpcyBsaXN0OiBzZW5kIHRoZSBsaW5lICJ1bnN1YnNjcmliZSBsaW51eC1yZW1vdGVwcm9jIg0K
PiBpbg0KPiA+IHRoZSBib2R5IG9mIGEgbWVzc2FnZSB0byBtYWpvcmRvbW9Admdlci5rZXJuZWwu
b3JnDQo+ID4gTW9yZSBtYWpvcmRvbW8gaW5mbyBhdCAgaHR0cDovL3ZnZXIua2VybmVsLm9yZy9t
YWpvcmRvbW8taW5mby5odG1sDQo+ID4NCg0K
