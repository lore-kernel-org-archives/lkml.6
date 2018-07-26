Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844B2C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362B4205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362B4205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbeGZJEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:04:43 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:56328 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728770AbeGZJEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:04:41 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6Q7hbO5002326;
        Thu, 26 Jul 2018 09:49:01 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2kf9v403t3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 26 Jul 2018 09:49:01 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CE6ED34;
        Thu, 26 Jul 2018 07:48:59 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A97682903;
        Thu, 26 Jul 2018 07:48:59 +0000 (GMT)
Received: from SFHDAG7NODE2.st.com (10.75.127.20) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 26 Jul
 2018 09:48:59 +0200
Received: from SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090]) by
 SFHDAG7NODE2.st.com ([fe80::d548:6a8f:2ca4:2090%20]) with mapi id
 15.00.1347.000; Thu, 26 Jul 2018 09:48:59 +0200
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
Thread-Index: AQHUFP2jqyvznuLIQEOFVequ6yz8w6SgfKYAgAC5gfA=
Date:   Thu, 26 Jul 2018 07:48:59 +0000
Message-ID: <8e943f4d2a1b4e10a8a0756c737d53a8@SFHDAG7NODE2.st.com>
References: <1530863212-16584-1-git-send-email-loic.pallardy@st.com>
 <ee64ddf7-e9c6-0b77-8a4e-44f77d264fe0@ti.com>
In-Reply-To: <ee64ddf7-e9c6-0b77-8a4e-44f77d264fe0@ti.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-26_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3VtYW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3VtYW4g
QW5uYSA8cy1hbm5hQHRpLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEp1bHkgMjYsIDIwMTggMTI6
MDkgQU0NCj4gVG86IExvaWMgUEFMTEFSRFkgPGxvaWMucGFsbGFyZHlAc3QuY29tPjsgYmpvcm4u
YW5kZXJzc29uQGxpbmFyby5vcmc7DQo+IG9oYWRAd2l6ZXJ5LmNvbQ0KPiBDYzogbGludXgtcmVt
b3RlcHJvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+
IEFybmF1ZCBQT1VMSVFVRU4gPGFybmF1ZC5wb3VsaXF1ZW5Ac3QuY29tPjsNCj4gYmVuamFtaW4u
Z2FpZ25hcmRAbGluYXJvLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMV0gcmVtb3Rl
cHJvYzogY29ycmVjdCBycHJvY19mcmVlX3ZyaW5nKCkgdG8gYXZvaWQNCj4gaW52YWxpZCBrZXJu
ZWwgcGFnaW5nDQo+IA0KPiBIaSBMb2ljLA0KPiANCj4gT24gMDcvMDYvMjAxOCAwMjo0NiBBTSwg
TG9pYyBQYWxsYXJkeSB3cm90ZToNCj4gPiBJZiBycHJvY19zdGFydCgpIGZhaWxlZCwgcnByb2Nf
cmVzb3VyY2VfY2xlYW51cCgpIGlzIGNhbGxlZCB0byBjbGVhbg0KPiA+IGRlYnVnZnMgZW50cmll
cywgdGhlbiBhc3NvY2lhdGVkIGlvbW11IG1hcHBpbmdzLCBjYXJ2ZW91dHMgYW5kIHZkZXYuDQo+
ID4gSXNzdWUgb2NjdXJzIHdoZW4gcnByb2NfZnJlZV92cmluZygpIGlzIHRyeWluZyB0byByZXNl
dCB2cmluZyByZXNvdXJjZQ0KPiA+IHRhYmxlIGVudHJ5Lg0KPiA+IEF0IHRoaXMgdGltZSwgdGFi
bGVfcHRyIGlzIHBvaW50aW5nIG9uIGxvYWRlZCByZXNvdXJjZSB0YWJsZSBhbmQgY2FydmVvdXRz
DQo+ID4gYWxyZWFkeSByZWxlYXNlZCwgc28gYWNjZXNzIHRvIGxvYWRlZCByZXNvdXJjZSB0YWJs
ZSBpcyBnZW5lcmF0aW5nIGEga2VybmVsDQo+ID4gcGFnaW5nIGVycm9yOg0KPiANCj4gQXJlIHlv
dSB1c2luZyBhIGRldmljZSBzcGVjaWZpYyBDTUEgcG9vbCBvciBjYXJ2ZW91dCwgYW5kIGlmIHNv
LCB3aGVyZQ0KPiB0aGUgcG9vbCBpcz8gSWYgbm90LCB3aGVyZSBpcyB0aGUgZGVmYXVsdCBDTUEg
cG9vbD8gSSBhbSB0cnlpbmcgdG8NCj4gcmVwcm9kdWNlIHRoZSBpc3N1ZSBvbiBteSBwbGF0Zm9y
bSB3aXRoIHRoZSBzdGFydCBmYWlsdXJlIGFzIHlvdQ0KPiBzdWdnZXN0ZWQsIGJ1dCBoYXZlbid0
IHNlZW4gaXQgc28gZmFyLiBUaGF0IHNhaWQsIEkgaGF2ZSBzZWVuIHRoZSBleGFjdA0KPiBzYW1l
IGNyYXNoIHdoZW4gdXNpbmcgSGlnaE1FTSBDTUEgcG9vbHMgb24gbXkgZG93bnN0cmVhbSBrZXJu
ZWwNCj4gd2hlbg0KPiBzdG9wcGluZyB0aGUgcHJvY2Vzc29yLCBhbmQgdGhlIHJvb3QgY2F1c2Ug
aXMgZXNzZW50aWFsbHkgdGhlIHNhbWUgYXMNCj4gd2hhdCB5b3Ugc3VtbWFyaXplZCBoZXJlLiBU
aGUgaXNzdWUgd2FzIHByZXNlbnQgd2l0aCBMb3dNZW0gcG9vbHMgYXMNCj4gd2VsbCwgYnV0IGdv
dCBtYXNrZWQgYmVjYXVzZSBvZiB0aGUga2VybmVsIGxpbmVhciBtYXBwaW5nLg0KDQpJIGhhdmUg
YSBjYXJ2ZW91dCBkZWNsYXJlZCBpbiBmaXJtd2FyZSByZXNvdXJjZSB0YWJsZSBmb3IgY28tcHJv
Y2Vzc29yIGNvZGUgYW5kIGRhdGEsIGFuZCBzdCBkcml2ZXIgaGFzIGEgc3BlY2lmaWMgDQpyZXNl
cnZlZCBtZW1vcnkgcmVnaW9uIHRvIGZpdCBmaXggYWRkcmVzcyBzcGFjZSByZXF1ZXN0ZWQgYnkg
Y28tcHJvY2Vzc29yLg0KU28gQ1BVIGFjY2VzcyB0byBjb2RlIGFuZCBsb2FkZWQgcmVzb3VyY2Ug
dGFibGUgYXJlYSBpcyBncmFudGVkIHRoYW5rcyB0byBhbGxvY2F0aW9uIGRvbmUgYnkgcnByb2Nf
aGFuZGxlX2NhcnZlb3V0KCkuDQoNCj4gDQo+ID4NCj4gPiBbICAgMTIuNjk2NTM1XSBVbmFibGUg
dG8gaGFuZGxlIGtlcm5lbCBwYWdpbmcgcmVxdWVzdCBhdCB2aXJ0dWFsIGFkZHJlc3MNCj4gZjBm
MzU3Y2MNCj4gPiBbICAgMTIuNjk2NTQwXSBwZ2QgPSAocHRydmFsKQ0KPiA+IFsgICAxMi42OTY1
NDJdIFtmMGYzNTdjY10gKnBnZD02ZDJkMDgxMSwgKnB0ZT0wMDAwMDAwMCwgKnBwdGU9MDAwMDAw
MDANCj4gPiBbICAgMTIuNjk2NTU4XSBJbnRlcm5hbCBlcnJvcjogT29wczogODA3IFsjMV0gU01Q
IEFSTQ0KPiA+IFsgICAxMi42OTY1NjNdIE1vZHVsZXMgbGlua2VkIGluOiBycG1zZ19jb3JlIHY0
bDJfbWVtMm1lbQ0KPiB2aWRlb2J1ZjJfZG1hX2NvbnRpZyBzdGlfZHJtIHY0bDJfY29tbW9uIHZp
ZGENCj4gPiBbICAgMTIuNjk2NTk4XSBDUFU6IDEgUElEOiA0OCBDb21tOiBrd29ya2VyLzE6MSBU
YWludGVkOiBHICAgICAgICBXDQo+IDQuMTguMC1yYzItMDAwMTgtZzMxNzBmZGQtOA0KPiA+IFsg
ICAxMi42OTY2MDJdIEhhcmR3YXJlIG5hbWU6IFNUaSBTb0Mgd2l0aCBGbGF0dGVuZWQgRGV2aWNl
IFRyZWUNCj4gPiBbICAgMTIuNjk2NjI1XSBXb3JrcXVldWU6IGV2ZW50cyByZXF1ZXN0X2Zpcm13
YXJlX3dvcmtfZnVuYw0KPiA+IFsgICAxMi42OTY2NTldIFBDIGlzIGF0IHJwcm9jX2ZyZWVfdnJp
bmcrMHg4NC8weGJjIFtyZW1vdGVwcm9jXQ0KPiA+IFsgICAxMi42OTY2NjddIExSIGlzIGF0IHJw
cm9jX2ZyZWVfdnJpbmcrMHg3MC8weGJjIFtyZW1vdGVwcm9jXQ0KPiA+DQo+ID4gVGhpcyBwYXRj
aCBwcm9wb3NlcyB0byBzaW1wbHkgcmVtb3ZlIHJlc2V0IG9mIHJlc291cmNlIHRhYmxlIHZyaW5n
IGVudHJpZXMsDQo+ID4gYXMgZmlybXdhcmUgYW5kIHJlc291cmNlIHRhYmxlIGFyZSByZWxvYWRl
ZCBhdCBlYWNoIHJwcm9jIGJvb3QuDQo+ID4gcnByb2NfdHJpZ2dlcl9yZWNvdmVyeSgpIG5vdCBp
bXBhY3RlZCBhcyByZXNvdXJjZXMgbm90IHRvdWNoZWQgZHVyaW5nDQo+IHJlY292ZXJ5DQo+ID4g
cHJvY2VkdXJlLg0KPiANCj4gQW5kIGVycm9yIHJlY292ZXJ5IGRvZXNuJ3Qgd29yayBmb3IgbWUg
YWZ0ZXIgdGhlIHJwcm9jX3N0YXJ0LCBzdG9wIGdvdA0KPiBpbnRyb2R1Y2VkLg0KUmVjb3Zlcnkg
bm8gYXZhaWxhYmxlIG9uIEIyMjYwLCBidXQgSSdsbCB0ZXN0IGl0IG9uIGFub3RoZXIgcGxhdGZv
cm0gdGhpcyB3ZWVrDQoNClJlZ2FyZHMsDQpMb2ljDQo+IA0KPiByZWdhcmRzDQo+IFN1bWFuDQo+
IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTG9pYyBQYWxsYXJkeSA8bG9pYy5wYWxsYXJkeUBz
dC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBmcm9tIFYxOiB0eXBvIGZpeGVzIGluIGNvbW1p
dCBtZXNzYWdlDQo+ID4NCj4gPiAgZHJpdmVycy9yZW1vdGVwcm9jL3JlbW90ZXByb2NfY29yZS5j
IHwgNiAtLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9yZW1vdGVwcm9jL3JlbW90ZXByb2NfY29yZS5jDQo+IGIv
ZHJpdmVycy9yZW1vdGVwcm9jL3JlbW90ZXByb2NfY29yZS5jDQo+ID4gaW5kZXggYTk2MDlkOS4u
OWE4YjQ3YyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3JlbW90ZXByb2MvcmVtb3RlcHJvY19j
b3JlLmMNCj4gPiArKysgYi9kcml2ZXJzL3JlbW90ZXByb2MvcmVtb3RlcHJvY19jb3JlLmMNCj4g
PiBAQCAtMjg5LDE2ICsyODksMTAgQEAgdm9pZCBycHJvY19mcmVlX3ZyaW5nKHN0cnVjdCBycHJv
Y192cmluZyAqcnZyaW5nKQ0KPiA+ICB7DQo+ID4gIAlpbnQgc2l6ZSA9IFBBR0VfQUxJR04odnJp
bmdfc2l6ZShydnJpbmctPmxlbiwgcnZyaW5nLT5hbGlnbikpOw0KPiA+ICAJc3RydWN0IHJwcm9j
ICpycHJvYyA9IHJ2cmluZy0+cnZkZXYtPnJwcm9jOw0KPiA+IC0JaW50IGlkeCA9IHJ2cmluZy0+
cnZkZXYtPnZyaW5nIC0gcnZyaW5nOw0KPiA+IC0Jc3RydWN0IGZ3X3JzY192ZGV2ICpyc2M7DQo+
ID4NCj4gPiAgCWRtYV9mcmVlX2NvaGVyZW50KHJwcm9jLT5kZXYucGFyZW50LCBzaXplLCBydnJp
bmctPnZhLCBydnJpbmctDQo+ID5kbWEpOw0KPiA+ICAJaWRyX3JlbW92ZSgmcnByb2MtPm5vdGlm
eWlkcywgcnZyaW5nLT5ub3RpZnlpZCk7DQo+ID4NCj4gPiAtCS8qIHJlc2V0IHJlc291cmNlIGVu
dHJ5IGluZm8gKi8NCj4gPiAtCXJzYyA9ICh2b2lkICopcnByb2MtPnRhYmxlX3B0ciArIHJ2cmlu
Zy0+cnZkZXYtPnJzY19vZmZzZXQ7DQo+ID4gLQlyc2MtPnZyaW5nW2lkeF0uZGEgPSAwOw0KPiA+
IC0JcnNjLT52cmluZ1tpZHhdLm5vdGlmeWlkID0gLTE7DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0
aWMgaW50IHJwcm9jX3ZkZXZfZG9fcHJvYmUoc3RydWN0IHJwcm9jX3N1YmRldiAqc3ViZGV2KQ0K
PiA+DQoNCg==
