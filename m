Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA457C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6C12081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="A4LO7asG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6C12081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeJaDSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:18:06 -0400
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:45819 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727565AbeJaDSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1540923813; x=1572459813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dVppbuVId50VK5VRVawj/6PNrfwsaNb/+hLEJfHUg/A=;
  b=A4LO7asGemAz4k1O+KP4bM3cNX/1q7A1aj0+VB8sUQhzBM30fYN9gZq3
   4pZjszuewDuL66iRQ2orXS4wD8g9AQzqzVKZ316K5iRnmlabrDyJGAPzC
   3Gd4ztpnXOF/MgQpBtms9c3GeXTJrTrQX7nJkE3sua5GowQ6vIh6/DifC
   M=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FRAACzoNhbhyeV50NjHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUQcBAQsBg2koCoNsiBhfjUeBeIFIk2AUgWYLAQGEbAIXgw4iNA0NAQM?=
 =?us-ascii?q?BAQIBAQIBAQIQAQEBCgsJCCkvgjYigmMBAQEBAgESEQQNMxIFCwIBCBgCAiY?=
 =?us-ascii?q?CAgJFEAIEAQ0FCBqCf4F6CJ1uAoEQiVgBAQFtezOKK4ELilyCF4ERghR+hGc?=
 =?us-ascii?q?ugm2CVwKBKgGHSIVxgUSOaAYBApB/IJBILJZTAgQCBAUCFIFDgg5wgW6BToI?=
 =?us-ascii?q?mDgmOGm+JKymBBYEfAQE?=
X-IPAS-Result: =?us-ascii?q?A2FRAACzoNhbhyeV50NjHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?2koCoNsiBhfjUeBeIFIk2AUgWYLAQGEbAIXgw4iNA0NAQMBAQIBAQIBAQIQA?=
 =?us-ascii?q?QEBCgsJCCkvgjYigmMBAQEBAgESEQQNMxIFCwIBCBgCAiYCAgJFEAIEAQ0FC?=
 =?us-ascii?q?BqCf4F6CJ1uAoEQiVgBAQFtezOKK4ELilyCF4ERghR+hGcugm2CVwKBKgGHS?=
 =?us-ascii?q?IVxgUSOaAYBApB/IJBILJZTAgQCBAUCFIFDgg5wgW6BToImDgmOGm+JKymBB?=
 =?us-ascii?q?YEfAQE?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa2.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Oct 2018 13:23:32 -0500
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9UIMk5s043373;
        Tue, 30 Oct 2018 14:23:32 -0400
Received: from esa1.dell-outbound2.iphmx.com (esa1.dell-outbound2.iphmx.com [68.232.153.201])
        by mx0a-00154901.pphosted.com with ESMTP id 2neskpgvwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Oct 2018 14:23:31 -0400
From:   <Justin.Lee1@Dell.com>
Received: from ausc60pc101.us.dell.com ([143.166.85.206])
  by esa1.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 31 Oct 2018 00:23:19 +0600
X-LoopCount0: from 10.166.135.94
X-IronPort-AV: E=Sophos;i="5.54,445,1534827600"; 
   d="scan'208";a="1319632979"
To:     <sam@mendozajonas.com>, <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
Subject: RE: [PATCH net-next v2 5/6] net/ncsi: Reset channel state in
 ncsi_start_dev()
Thread-Topic: [PATCH net-next v2 5/6] net/ncsi: Reset channel state in
 ncsi_start_dev()
Thread-Index: AQHUaxq5zixhV1A3m0GL9JnkLZs93aUxueYwgAWRLwCAANjoYA==
Date:   Tue, 30 Oct 2018 18:23:28 +0000
Message-ID: <2be6038ad8cb43559495e6f84e97b8a6@AUSX13MPS306.AMER.DELL.COM>
References: <20181023215201.27315-1-sam@mendozajonas.com>
         <20181023215201.27315-6-sam@mendozajonas.com>
         <d6172566ffe94dec83c1026108e24c98@AUSX13MPS306.AMER.DELL.COM>
 <b0fd357b1fc4b9aed6300019557dc8a391ecf52d.camel@mendozajonas.com>
In-Reply-To: <b0fd357b1fc4b9aed6300019557dc8a391ecf52d.camel@mendozajonas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-30_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810300155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gRnJpLCAyMDE4LTEwLTI2IGF0IDE3OjI1ICswMDAwLCBKdXN0aW4uTGVlMUBEZWxs
LmNvbSB3cm90ZToNCj4gPiBIaSBTYW11ZWwsDQo+ID4gDQo+ID4gSSBub3RpY2VkIGEgZmV3IGlz
c3VlcyBhbmQgY29tbWVudGVkIGJlbG93Lg0KPiA+IA0KPiA+IFRoYW5rcywNCj4gPiBKdXN0aW4N
Cj4gPiANCj4gPiANCj4gPiA+ICAvKiBSZXNvdXJjZXMgKi8NCj4gPiA+ICtpbnQgbmNzaV9yZXNl
dF9kZXYoc3RydWN0IG5jc2lfZGV2ICpuZCk7DQo+ID4gPiAgdm9pZCBuY3NpX3N0YXJ0X2NoYW5u
ZWxfbW9uaXRvcihzdHJ1Y3QgbmNzaV9jaGFubmVsICpuYyk7DQo+ID4gPiAgdm9pZCBuY3NpX3N0
b3BfY2hhbm5lbF9tb25pdG9yKHN0cnVjdCBuY3NpX2NoYW5uZWwgKm5jKTsNCj4gPiA+ICBzdHJ1
Y3QgbmNzaV9jaGFubmVsICpuY3NpX2ZpbmRfY2hhbm5lbChzdHJ1Y3QgbmNzaV9wYWNrYWdlICpu
cCwNCj4gPiA+IGRpZmYgLS1naXQgYS9uZXQvbmNzaS9uY3NpLW1hbmFnZS5jIGIvbmV0L25jc2kv
bmNzaS1tYW5hZ2UuYw0KPiA+ID4gaW5kZXggMDE0MzIxYWQzMWQzLi45YmFkMDNlM2ZhNWUgMTAw
NjQ0DQo+ID4gPiAtLS0gYS9uZXQvbmNzaS9uY3NpLW1hbmFnZS5jDQo+ID4gPiArKysgYi9uZXQv
bmNzaS9uY3NpLW1hbmFnZS5jDQo+ID4gPiBAQCAtNTUwLDggKzU1MCwxMCBAQCBzdGF0aWMgdm9p
ZCBuY3NpX3N1c3BlbmRfY2hhbm5lbChzdHJ1Y3QgbmNzaV9kZXZfcHJpdiAqbmRwKQ0KPiA+ID4g
IAkJc3Bpbl9sb2NrX2lycXNhdmUoJm5jLT5sb2NrLCBmbGFncyk7DQo+ID4gPiAgCQluYy0+c3Rh
dGUgPSBOQ1NJX0NIQU5ORUxfSU5BQ1RJVkU7DQo+ID4gPiAgCQlzcGluX3VubG9ja19pcnFyZXN0
b3JlKCZuYy0+bG9jaywgZmxhZ3MpOw0KPiA+ID4gLQkJbmNzaV9wcm9jZXNzX25leHRfY2hhbm5l
bChuZHApOw0KPiA+ID4gLQ0KPiA+ID4gKwkJaWYgKG5kcC0+ZmxhZ3MgJiBOQ1NJX0RFVl9SRVNF
VCkNCj4gPiA+ICsJCQluY3NpX3Jlc2V0X2RldihuZCk7DQo+ID4gPiArCQllbHNlDQo+ID4gPiAr
CQkJbmNzaV9wcm9jZXNzX25leHRfY2hhbm5lbChuZHApOw0KPiA+ID4gIAkJYnJlYWs7DQo+ID4g
PiAgCWRlZmF1bHQ6DQo+ID4gPiAgCQluZXRkZXZfd2FybihuZC0+ZGV2LCAiV3JvbmcgTkNTSSBz
dGF0ZSAweCV4IGluIHN1c3BlbmRcbiIsDQo+ID4gPiBAQCAtMTU1NCw3ICsxNTU2LDcgQEAgaW50
IG5jc2lfc3RhcnRfZGV2KHN0cnVjdCBuY3NpX2RldiAqbmQpDQo+ID4gPiAgCQlyZXR1cm4gMDsN
Cj4gPiA+ICAJfQ0KPiA+ID4gIA0KPiA+ID4gLQlyZXR1cm4gbmNzaV9jaG9vc2VfYWN0aXZlX2No
YW5uZWwobmQpOw0KPiA+ID4gKwlyZXR1cm4gbmNzaV9yZXNldF9kZXYobmQpOw0KPiA+IA0KPiA+
IElmIHRoZXJlIGlzIG5vIGF2YWlsYWJsZSBjaGFubmVsIGR1ZSB0byB0aGUgd2hpdGVsaXN0LCBu
Y3NpX3N0YXJ0X2RldigpIGZ1bmN0aW9uIHdpbGwgcmV0dXJuIGZhaWxlZA0KPiA+IFN0YXR1cyBh
bmQgdGhlIG5ldHdvcmsgaW50ZXJmYWNlIG1heSBmYWlsIHRvIGJyaW5nIHVwIHRvby4gSXQgaXMg
cG9zc2libGUgZm9yIHVzZXIgdG8gZGlzYWJsZSBhbGwgDQo+ID4gY2hhbm5lbHMgYW5kIGxlYXZl
IHRoZSBpbnRlcmZhY2UgdXAgZm9yIGNoZWNraW5nIHRoZSBMT00gc3RhdHVzLg0KPiA+IA0KPiAN
Cj4gSSdtIG5vdCBzdXJlIHRoYXQgdGhhdCBpcyBhIGJ1Zywgb3IgYXQgbGVhc3Qgbm90IGluIHRo
ZSBzY29wZSBvZiB0aGlzDQo+IHNlcmllcy4gSWYgdGhlIHdoaXRlbGlzdCBpcyBzZXQgc3VjaCB0
aGF0IG5vIGNoYW5uZWxzIGFyZSB2YWxpZCB0aGVuDQo+IHRoZXJlJ3Mgbm90aGluZyBmb3IgTkNT
SSB0byBkby4gSWYgd2Ugd2FudCB0byBkbyBzb21ldGhpbmcgbGlrZSBhbHdheXMNCj4gbW9uaXRv
ciBhbGwgY2hhbm5lbHMgdGhlbiB0aGF0IHdvdWxkIGJlIGJlc3QgdG8gZG8gaW4gYW5vdGhlciBw
YXRjaC4NCj4gDQo+ID4gPiAgfQ0KPiA+ID4gIEVYUE9SVF9TWU1CT0xfR1BMKG5jc2lfc3RhcnRf
ZGV2KTsNCj4gPiANCj4gPiBBbHNvLCBpZiBJIHNlbmQgc2V0X3BhY2thZ2VfbWFzayBhbmQgc2V0
X2NoYW5uZWxfbWFzayBjb21tYW5kcyBiYWNrIHRvIGJhY2sgaW4gYSBwcm9ncmFtLA0KPiA+IHRo
ZSBzdGF0ZSBtYWNoaW5lIGRvZXNuJ3Qgd29yayB3ZWxsLiBJZiBJIHVzZSBjb21tYW5kIGxpbmUg
YW5kIHdhaXQgZm9yIGl0IHRvIGNvbXBsZXRlIGZvciANCj4gPiBlYWNoIHN0ZXAsIHRoZW4gaXQg
aXMgZmluZS4NCj4gDQo+IFllYWggdGhhdCdzIG5vdCBncmVhdDsgcHJvYmFibHkgaGl0dGluZyBz
b21lIGNvcm5lciBjYXNlcyBpbiB0aGUgTkNTSQ0KPiBsb2NraW5nLiBJJ2xsIGxvb2sgaW50byB0
aGUgbXVsdGktY2hhbm5lbCByZWxhdGVkIHN0dWZmIGJ1dCBJIGhhdmUgYQ0KPiBmZWVsaW5nIHRo
YXQgaWYgeW91IHRyaWVkIHRoaXMgd2l0aCB0aGUgZXhpc3Rpbmcgc2V0L2NsZWFyIGNvbW1hbmRz
IHlvdQ0KPiB3b3VsZCBwcm9iYWJseSBoaXQgc29tZXRoaW5nIHNpbWlsYXIsIGVzcGVjaWFsbHkg
b24geW91ciBkdWFsIGNvcmUNCj4gcGxhdGZvcm0uIElmIHNvIHRoaXMgaXMgcHJvYmFibHkgc29t
ZXRoaW5nIHRvIGZpeCBzZXBhcmF0ZWx5Lg0KPiANCg0KSXQgaXMgcG9zc2libGUgdGhhdCBpdCBp
cyBjYXVzaW5nIGJ5IHRoZSBmb2xsb3dpbmcgY29kZSBpbiBuY3NpX3Jlc2V0X2RldigpIGZ1bmN0
aW9uLg0KVGhlIHN0YXRlIG1pZ2h0IGJlIG92ZXJ3cml0dGVuIGFuZCB0aGUgcHJldmlvdXMgb3Bl
cmF0aW9uIGlzIGludGVycnVwdGVkLg0KDQoJc3Bpbl9sb2NrX2lycXNhdmUoJm5kcC0+bG9jaywg
ZmxhZ3MpOw0KCW5kcC0+ZmxhZ3MgfD0gTkNTSV9ERVZfUkVTRVQ7DQoJbmRwLT5hY3RpdmVfY2hh
bm5lbCA9IGFjdGl2ZTsNCgluZHAtPmFjdGl2ZV9wYWNrYWdlID0gYWN0aXZlLT5wYWNrYWdlOw0K
CXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJm5kcC0+bG9jaywgZmxhZ3MpOw0KDQoJbmQtPnN0YXRl
ID0gbmNzaV9kZXZfc3RhdGVfc3VzcGVuZDsNCg0KPiA+IA0KPiA+IG5wY203eHgtZW1jIGYwODI1
MDAwLmV0aCBldGgyOiBOQ1NJOiBNdWx0aS1wYWNrYWdlIGVuYWJsZWQgb24gaWZpbmRleCAyLCBt
YXNrIDB4MDAwMDAwMDENCj4gPiBucGNtN3h4LWVtYyBmMDgyNTAwMC5ldGggZXRoMjogTkNTSTog
bmNzaV9zdG9wX2NoYW5uZWxfbW9uaXRvcigpIC0gcGtnIDAgY2ggMA0KPiA+IG5wY203eHgtZW1j
IGYwODI1MDAwLmV0aCBldGgyOiBOQ1NJOiBuY3NpX2Rldl93b3JrKCkNCj4gPiBucGNtN3h4LWVt
YyBmMDgyNTAwMC5ldGggZXRoMjogTkNTSTogbmNzaV9zdXNwZW5kX2NoYW5uZWwoKSAtIHBrZyAw
IGNoIDAgc3RhdGUgMDQwMA0KPiA+IG5wY203eHgtZW1jIGYwODI1MDAwLmV0aCBldGgyOiBOQ1NJ
OiBwa2cgMCBjaCAwIHNldCBhcyBwcmVmZXJyZWQgY2hhbm5lbA0KPiA+IG5wY203eHgtZW1jIGYw
ODI1MDAwLmV0aCBldGgyOiBOQ1NJOiBNdWx0aS1jaGFubmVsIGVuYWJsZWQgb24gaWZpbmRleCAy
LCBtYXNrIDB4MDAwMDAwMDMNCj4gPiBucGNtN3h4LWVtYyBmMDgyNTAwMC5ldGggZXRoMjogTkNT
STogbmNzaV9zdG9wX2NoYW5uZWxfbW9uaXRvcigpIC0gcGtnIDAgY2ggMQ0KPiA+IG5wY203eHgt
ZW1jIGYwODI1MDAwLmV0aCBldGgyOiBOQ1NJOiBuY3NpX2Rldl93b3JrKCkNCj4gPiBucGNtN3h4
LWVtYyBmMDgyNTAwMC5ldGggZXRoMjogTkNTSTogbmNzaV9zdXNwZW5kX2NoYW5uZWwoKSAtIHBr
ZyAwIGNoIDEgc3RhdGUgMDQwMA0KPiA+IG5wY203eHgtZW1jIGYwODI1MDAwLmV0aCBldGgyOiBO
Q1NJOiBQYWNrYWdlIDEgc2V0IHRvIGFsbCBjaGFubmVscyBkaXNhYmxlZA0KPiA+IG5wY203eHgt
ZW1jIGYwODI1MDAwLmV0aCBldGgyOiBOQ1NJOiBNdWx0aS1jaGFubmVsIGVuYWJsZWQgb24gaWZp
bmRleCAyLCBtYXNrIDB4MDAwMDAwMDANCj4gPiBucGNtN3h4LWVtYyBmMDgyNTAwMC5ldGggZXRo
MjogTkNTSTogbmNzaV9jaG9vc2VfYWN0aXZlX2NoYW5uZWwoKQ0KPiA+IG5wY203eHgtZW1jIGYw
ODI1MDAwLmV0aCBldGgyOiBOQ1NJOiBuY3NpX2Nob29zZV9hY3RpdmVfY2hhbm5lbCgpIC0gcGtn
IDANCj4gPiBucGNtN3h4LWVtYyBmMDgyNTAwMC5ldGggZXRoMjogTkNTSTogbmNzaV9jaG9vc2Vf
YWN0aXZlX2NoYW5uZWwoKSAtIHBhc3MgcGtnIHdoaXRlbGlzdA0KPiA+IG5wY203eHgtZW1jIGYw
ODI1MDAwLmV0aCBldGgyOiBOQ1NJOiBuY3NpX2Nob29zZV9hY3RpdmVfY2hhbm5lbCgpIC0gY2gg
MA0KPiA+IG5wY203eHgtZW1jIGYwODI1MDAwLmV0aCBldGgyOiBOQ1NJOiBuY3NpX2Nob29zZV9h
Y3RpdmVfY2hhbm5lbCgpIC0gcGFzcyBjaCB3aGl0ZWxpc3QNCj4gPiBucGNtN3h4LWVtYyBmMDgy
NTAwMC5ldGggZXRoMjogTkNTSTogbmNzaV9jaG9vc2VfYWN0aXZlX2NoYW5uZWwoKSAtIHNraXAN
Cj4gPiBucGNtN3h4LWVtYyBmMDgyNTAwMC5ldGggZXRoMjogTkNTSTogbmNzaV9jaG9vc2VfYWN0
aXZlX2NoYW5uZWwoKSAtIGNoIDENCj4gPiBucGNtN3h4LWVtYyBmMDgyNTAwMC5ldGggZXRoMjog
TkNTSTogbmNzaV9jaG9vc2VfYWN0aXZlX2NoYW5uZWwoKSAtIHBhc3MgY2ggd2hpdGVsaXN0DQo+
ID4gbnBjbTd4eC1lbWMgZjA4MjUwMDAuZXRoIGV0aDI6IE5DU0k6IG5jc2lfY2hvb3NlX2FjdGl2
ZV9jaGFubmVsKCkgLSBza2lwDQo+ID4gbnBjbTd4eC1lbWMgZjA4MjUwMDAuZXRoIGV0aDI6IE5D
U0k6IG5jc2lfY2hvb3NlX2FjdGl2ZV9jaGFubmVsKCkgLSBuZXh0IHBrZw0KPiA+IG5wY203eHgt
ZW1jIGYwODI1MDAwLmV0aCBldGgyOiBOQ1NJOiBuY3NpX2Nob29zZV9hY3RpdmVfY2hhbm5lbCgp
IC0gcGtnIDENCj4gPiBucGNtN3h4LWVtYyBmMDgyNTAwMC5ldGggZXRoMjogTkNTSTogTm8gY2hh
bm5lbCBmb3VuZCB0byBjb25maWd1cmUhDQo+ID4gbnBjbTd4eC1lbWMgZjA4MjUwMDAuZXRoIGV0
aDI6IE5DU0kgaW50ZXJmYWNlIGRvd24NCj4gPiBucGNtN3h4LWVtYyBmMDgyNTAwMC5ldGggZXRo
MjogTkNTSTogbmNzaV9kZXZfd29yaygpDQo+ID4gbnBjbTd4eC1lbWMgZjA4MjUwMDAuZXRoIGV0
aDI6IFdyb25nIE5DU0kgc3RhdGUgMHgxMDAgaW4gd29ya3F1ZXVlDQo+ID4gDQo+ID4gQWxsIG1h
c2tzIGFyZSBzZXQgY29ycmVjdGx5LCBidXQgeW91IGNhbiBzZWUgdGhlIFBTIGNvbHVtbiBpcyBu
b3QgcmlnaHQgYW5kIGNoYW5uZWwgZG9lc24ndA0KPiA+IGNvbmZpZ3VyZSBjb3JyZWN0bHkuDQo+
ID4gDQo+ID4gL3N5cy9rZXJuZWwvZGVidWcvbmNzaV9wcm90b2NvbCMgY2F0IG5jc2lfZGV2aWNl
X3N0YXR1cw0KPiA+IElGSURYIElGTkFNRSBOQU1FICAgUElEIENJRCBSWCBUWCBNUCBNQyBXUCBX
QyBQQyBQUyBMUyBSVSBDUiBOUSBIQQ0KPiA+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPiAgIDIgICBldGgyICAg
bmNzaTAgIDAwMCAwMDAgMSAgMSAgMSAgMSAgMSAgMSAgMSAgMCAgMSAgMSAgMSAgMCAgMQ0KPiA+
ICAgMiAgIGV0aDIgICBuY3NpMSAgMDAwIDAwMSAxICAwICAxICAxICAxICAxICAwICAwICAxICAx
ICAxICAwICAxDQo+ID4gICAyICAgZXRoMiAgIG5jc2kyICAwMDEgMDAwIDAgIDAgIDEgIDEgIDAg
IDAgIDAgIDAgIDEgIDEgIDEgIDAgIDENCj4gPiAgIDIgICBldGgyICAgbmNzaTMgIDAwMSAwMDEg
MCAgMCAgMSAgMSAgMCAgMCAgMCAgMCAgMSAgMSAgMSAgMCAgMQ0KPiA+ID09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4g
PiBNUDogTXVsdGktbW9kZSBQYWNrYWdlICAgICBXUDogV2hpdGVsaXN0IFBhY2thZ2UNCj4gPiBN
QzogTXVsdGktbW9kZSBDaGFubmVsICAgICBXQzogV2hpdGVsaXN0IENoYW5uZWwNCj4gPiBQQzog
UHJpbWFyeSBDaGFubmVsDQo+ID4gUFM6IFBvbGwgU3RhdHVzDQo+ID4gTFM6IExpbmsgU3RhdHVz
DQo+ID4gUlU6IFJ1bm5pbmcNCj4gPiBDUjogQ2FycmllciBPSw0KPiA+IE5ROiBRdWV1ZSBTdG9w
cGVkDQo+ID4gSEE6IEhhcmR3YXJlIEFyYml0cmF0aW9uDQo+ID4gDQo+ID4gUFMgY29sdW1uIGlz
IGdldHRpbmcgZnJvbSAoaW50KW5jLT5tb25pdG9yLmVuYWJsZWQuDQoNCg0K
