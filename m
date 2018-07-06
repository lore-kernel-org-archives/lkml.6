Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B422DC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657772075C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="V0guVO1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657772075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933677AbeGFQ2h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:28:37 -0400
Received: from esa8.dell-outbound.iphmx.com ([68.232.149.218]:65264 "EHLO
        esa8.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932730AbeGFQ2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1530894515; x=1562430515;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7mGV5y5GtRixdyRzy33j4Esb1wv5f9pTBAvrWmrVQDA=;
  b=V0guVO1Pbi/R6tdkAYZmTlW7Rkbzax2rYbT/GF5vHCsvFqZs4zPKn6Od
   FjDWtnZpC5I14iuXayxFO+wswOhKfUf2vYlND5Keu5fxEXAMmIsOMHQ0B
   1Q9tbBUrvfUpxZMFk2hKJ5PwK5KS+aHGvadNgIq+M4cIzNqz7fIH5xn9R
   c=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HvAwDM+T5bmGOa6ERcGgEBAQEBAgEBA?=
 =?us-ascii?q?QEIAQEBAYMbgQKBDSgKg3CUOYIHgXKBRoR+jHoUgWYLhGwCF4IXITUXAQIBAQI?=
 =?us-ascii?q?BAQIBAQIQAQEBAQEICwsGKS+CNSKCYQEBAQECASMEDUUMBAIBCBEEAQEDAiMDA?=
 =?us-ascii?q?gICHyUBCAgCBAENBQiDGIFoAw0IqSSBaTOHFA2BLoE6gQuHYoIVgQ+DD4JWggy?=
 =?us-ascii?q?DGYJVApkkKwcCjBeDA4FIjBgrh1CDCYcHgUIBgglwgzmCJA4JjhdvAY43gRoBA?=
 =?us-ascii?q?Q?=
X-IPAS-Result: =?us-ascii?q?A2HvAwDM+T5bmGOa6ERcGgEBAQEBAgEBAQEIAQEBAYMbgQK?=
 =?us-ascii?q?BDSgKg3CUOYIHgXKBRoR+jHoUgWYLhGwCF4IXITUXAQIBAQIBAQIBAQIQAQEBA?=
 =?us-ascii?q?QEICwsGKS+CNSKCYQEBAQECASMEDUUMBAIBCBEEAQEDAiMDAgICHyUBCAgCBAE?=
 =?us-ascii?q?NBQiDGIFoAw0IqSSBaTOHFA2BLoE6gQuHYoIVgQ+DD4JWggyDGYJVApkkKwcCj?=
 =?us-ascii?q?BeDA4FIjBgrh1CDCYcHgUIBgglwgzmCJA4JjhdvAY43gRoBAQ?=
Received: from esa6.dell-outbound2.iphmx.com ([68.232.154.99])
  by esa8.dell-outbound.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 11:28:34 -0500
From:   <Mario.Limonciello@dell.com>
To:     <stuart.w.hayes@gmail.com>, <linux-kernel@vger.kernel.org>,
        <Stuart.Hayes@dell.com>
Received: from ausxipps306.us.dell.com ([143.166.148.156])
  by esa6.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 22:28:34 +0600
X-LoopCount0: from 10.166.132.190
X-IronPort-AV: E=Sophos;i="5.51,316,1526360400"; 
   d="scan'208";a="223056635"
X-DLP:  DLP_GlobalPCIDSS
CC:     <tiwai@suse.de>, <andy.shevchenko@gmail.com>,
        <dvhart@infradead.org>, <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH resend v4] dell_rbu: make firmware payload memory
 uncachable
Thread-Topic: [PATCH resend v4] dell_rbu: make firmware payload memory
 uncachable
Thread-Index: AQHUFUUEx+lZRQ9VxEeo+V/NxWBAE6SCX/Bw
Date:   Fri, 6 Jul 2018 16:28:32 +0000
Message-ID: <eca11a9c20d14480ae02b2912b7a6447@ausx13mpc120.AMER.DELL.COM>
References: <eb0db565-5f8a-ab1e-2bf3-2def3ec3eddc@gmail.com>
 <5318cc53-31b4-5c83-abb7-c3ff5d892af2@gmail.com>
In-Reply-To: <5318cc53-31b4-5c83-abb7-c3ff5d892af2@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogcGxhdGZvcm0tZHJpdmVy
LXg4Ni1vd25lckB2Z2VyLmtlcm5lbC5vcmcgW21haWx0bzpwbGF0Zm9ybS1kcml2ZXIteDg2LQ0K
PiBvd25lckB2Z2VyLmtlcm5lbC5vcmddIE9uIEJlaGFsZiBPZiBTdHVhcnQgSGF5ZXMNCj4gU2Vu
dDogRnJpZGF5LCBKdWx5IDYsIDIwMTggMTE6MTkgQU0NCj4gVG86IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gQ2M6IFRha2FzaGkgSXdhaTsgQW5keSBTaGV2Y2hlbmtvOyBkdmhhcnRA
aW5mcmFkZWFkLm9yZzsgUGxhdGZvcm0gRHJpdmVyDQo+IFN1YmplY3Q6IFtQQVRDSCByZXNlbmQg
djRdIGRlbGxfcmJ1OiBtYWtlIGZpcm13YXJlIHBheWxvYWQgbWVtb3J5IHVuY2FjaGFibGUNCj4g
DQo+IFRoZSBkZWxsX3JidSBkcml2ZXIgdGFrZXMgZmlybXdhcmUgdXBkYXRlIHBheWxvYWRzIGFu
ZCBwdXRzIHRoZW0gaW4gbWVtb3J5IHNvDQo+IHRoZSBzeXN0ZW0gQklPUyBjYW4gZmluZCB0aGVt
IGFmdGVyIGEgcmVib290LiAgVGhpcyBzb21ldGltZXMgZmFpbHMgKHRob3VnaA0KPiByYXJlbHkp
LCBiZWNhdXNlIHRoZSBtZW1vcnkgY29udGFpbmluZyB0aGUgcGF5bG9hZCBpcyBpbiB0aGUgQ1BV
IGNhY2hlIGJ1dA0KPiBuZXZlciBnZXRzIHdyaXR0ZW4gYmFjayB0byBtYWluIG1lbW9yeSBiZWZv
cmUgdGhlIHN5c3RlbSBpcyByZWJvb3RlZCAoQ1BVDQo+IGNhY2hlIGNvbnRlbnRzIGFyZSBsb3N0
IG9uIHJlYm9vdCkuDQo+IA0KPiBXaXRoIHRoaXMgcGF0Y2gsIHRoZSBwYXlsb2FkIG1lbW9yeSB3
aWxsIGJlIGNoYW5nZWQgdG8gdW5jYWNoYWJsZSB0byBlbnN1cmUNCj4gdGhhdCB0aGUgcGF5bG9h
ZCBpcyBhY3R1YWxseSBpbiBtYWluIG1lbW9yeSBiZWZvcmUgdGhlIHN5c3RlbSBpcyByZWJvb3Rl
ZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFN0dWFydCBIYXllcyA8c3R1YXJ0LncuaGF5ZXNAZ21h
aWwuY29tPg0KPiBSZXZpZXdlZC1ieTogVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPg0KPiBT
aWduZWQtb2ZmLWJ5OiBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+DQoNClJldmlld2VkLWJ5
OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AZGVsbC5jb20+DQoNCj4gLS0t
DQo+IHYyIEFkZGVkIGluY2x1ZGUsIHJlbW92ZWQgZXh0cmEgcGFyZW50aGVzZXMNCj4gdjMgQ29y
cmVjdGVkIGZvcm1hdHRpbmcgYW5kIGluY2x1ZGUgbGluZQ0KPiB2NCBNb3ZlZCBzZXRfbWVtb3J5
X3VjKCkgb3V0c2lkZSB0aGUgd2hpbGUgbG9vcCBzbyB0aGF0IHRoZSBtZW1vcnkgaXMNCj4gICAg
ZGVmaW5pdGVseSBhbGxvY2F0ZWQgYmVmb3JlIGl0IGlzIHNldCB0byB1bmNhY2hhYmxlDQo+IA0K
PiBUaGlzIGRyaXZlciBoYXMgbm8gbWFpbnRhaW5lci4NCg0KU3R1YXJ0LA0KDQpPdXRzaWRlIG9m
IHRoaXMgcGF0Y2gsIEkgdGhpbmsgaXQgd291bGQgbWFrZSBzZW5zZSB0byBzZW5kIHNvbWUgZm9s
bG93IHVwIHBhdGNoDQpzZXJpZXMgdGhhdCBkbyB0aGUgZm9sbG93aW5nOg0KDQoxKSBMZXQgeW91
IHRha2Ugb3ZlciBhcyBtYWludGFpbmVyIChVcGRhdGUgTUFJTlRBSU5FUlMpDQoyKSBNb3ZlIHRo
aXMgZHJpdmVyIHRvIHBsYXRmb3JtLXg4Ng0KMykgVXBkYXRlIGRlbGxfcmJ1LnR4dCB3aXRoIHRo
ZSBjb3JyZWN0IFVSTHMgYW5kIG1lbnRpb24gdGhhdCBpdCdzIG9ubHkgZm9yIGVudGVycHJpc2UN
CmhhcmR3YXJlLiAgICBDbGllbnQgaGFyZHdhcmUgaGFzIGluc3RlYWQgb3B0ZWQgdG8gc3VwcG9y
dCBVRUZJIGNhcHN1bGVzIGZvciB1cGRhdGVzDQpmcm9tIExpbnV4Lg0KDQpTaW5jZSBpdCdzIHJl
YWxseSBhIHBsYXRmb3JtIGZlYXR1cmUgYW5kIHNwZWNpZmljIHRvIG9ubHkgRGVsbCBlbnRlcnBy
aXNlIGhhcmR3YXJlDQpJIHRoaW5rIGl0IG1ha2VzIHNlbnNlIHRvIG1vdmUgb3ZlciB0byBhbiBh
cmVhIHdpdGggc3Vic3lzdGVtIG1haW50YWluZXJzIHRoYXQNCmNhbiBoZWxwIHRvIHJldmlldyBw
YXRjaGVzIGFzIG5lZWRlZC4NCg0KPiANCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13
YXJlL2RlbGxfcmJ1LmMgYi9kcml2ZXJzL2Zpcm13YXJlL2RlbGxfcmJ1LmMNCj4gaW5kZXggMmY0
NTJmMWY3YzhhLi41M2YyN2E2ZTJkNzYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUv
ZGVsbF9yYnUuYw0KPiArKysgYi9kcml2ZXJzL2Zpcm13YXJlL2RlbGxfcmJ1LmMNCj4gQEAgLTQ1
LDYgKzQ1LDcgQEANCj4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGVwYXJhbS5oPg0KPiAgI2luY2x1
ZGUgPGxpbnV4L2Zpcm13YXJlLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvZG1hLW1hcHBpbmcuaD4N
Cj4gKyNpbmNsdWRlIDxhc20vc2V0X21lbW9yeS5oPg0KPiANCj4gIE1PRFVMRV9BVVRIT1IoIkFi
aGF5IFNhbHVua2UgPGFiaGF5X3NhbHVua2VAZGVsbC5jb20+Iik7DQo+ICBNT0RVTEVfREVTQ1JJ
UFRJT04oIkRyaXZlciBmb3IgdXBkYXRpbmcgQklPUyBpbWFnZSBvbiBERUxMIHN5c3RlbXMiKTsN
Cj4gQEAgLTE4MSw2ICsxODIsMTEgQEAgc3RhdGljIGludCBjcmVhdGVfcGFja2V0KHZvaWQgKmRh
dGEsIHNpemVfdCBsZW5ndGgpDQo+ICAJCQlwYWNrZXRfZGF0YV90ZW1wX2J1ZiA9IE5VTEw7DQo+
ICAJCX0NCj4gIAl9DQo+ICsJLyoNCj4gKwkgKiBzZXQgdG8gdW5jYWNoYWJsZSBvciBpdCBtYXkg
bmV2ZXIgZ2V0IHdyaXR0ZW4gYmFjayBiZWZvcmUgcmVib290DQo+ICsJICovDQo+ICsJc2V0X21l
bW9yeV91YygodW5zaWduZWQgbG9uZylwYWNrZXRfZGF0YV90ZW1wX2J1ZiwgMSA8PCBvcmRlcm51
bSk7DQo+ICsNCj4gIAlzcGluX2xvY2soJnJidV9kYXRhLmxvY2spOw0KPiANCj4gIAluZXdwYWNr
ZXQtPmRhdGEgPSBwYWNrZXRfZGF0YV90ZW1wX2J1ZjsNCj4gQEAgLTM0OSw2ICszNTUsOCBAQCBz
dGF0aWMgdm9pZCBwYWNrZXRfZW1wdHlfbGlzdCh2b2lkKQ0KPiAgCQkgKiB0byBtYWtlIHN1cmUg
dGhlcmUgYXJlIG5vIHN0YWxlIFJCVSBwYWNrZXRzIGxlZnQgaW4gbWVtb3J5DQo+ICAJCSAqLw0K
PiAgCQltZW1zZXQobmV3cGFja2V0LT5kYXRhLCAwLCByYnVfZGF0YS5wYWNrZXRzaXplKTsNCj4g
KwkJc2V0X21lbW9yeV93YigodW5zaWduZWQgbG9uZyluZXdwYWNrZXQtPmRhdGEsDQo+ICsJCQkx
IDw8IG5ld3BhY2tldC0+b3JkZXJudW0pOw0KPiAgCQlmcmVlX3BhZ2VzKCh1bnNpZ25lZCBsb25n
KSBuZXdwYWNrZXQtPmRhdGEsDQo+ICAJCQluZXdwYWNrZXQtPm9yZGVybnVtKTsNCj4gIAkJa2Zy
ZWUobmV3cGFja2V0KTsNCg==
