Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFC0C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600C920645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600C920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=live.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbeH3L5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 07:57:51 -0400
Received: from mail-oln040092254039.outbound.protection.outlook.com ([40.92.254.39]:48832
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727588AbeH3L5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 07:57:50 -0400
Received: from SG2APC01FT049.eop-APC01.prod.protection.outlook.com
 (10.152.250.57) by SG2APC01HT122.eop-APC01.prod.protection.outlook.com
 (10.152.251.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.1101.10; Thu, 30
 Aug 2018 07:55:09 +0000
Received: from HK0PR06MB2561.apcprd06.prod.outlook.com (10.152.250.51) by
 SG2APC01FT049.mail.protection.outlook.com (10.152.251.207) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.20.1101.10 via
 Frontend Transport; Thu, 30 Aug 2018 07:55:09 +0000
Received: from HK0PR06MB2561.apcprd06.prod.outlook.com
 ([fe80::5902:da9:e907:fe7d]) by HK0PR06MB2561.apcprd06.prod.outlook.com
 ([fe80::5902:da9:e907:fe7d%5]) with mapi id 15.20.1080.015; Thu, 30 Aug 2018
 07:55:09 +0000
From:   Changwei Ge <gechangwei@live.cn>
To:     Larry Chen <lchen@suse.com>, "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Ocfs2-devel] [PATCH V5] ocfs2: fix crash on
 ocfs2_duplicate_clusters_by_page
Thread-Topic: [Ocfs2-devel] [PATCH V5] ocfs2: fix crash on
 ocfs2_duplicate_clusters_by_page
Thread-Index: AQHUQDbFgI42OcwbuUq/7nYCBI7BqA==
Date:   Thu, 30 Aug 2018 07:55:09 +0000
Message-ID: <HK0PR06MB2561D0833D04520633C125ABD5080@HK0PR06MB2561.apcprd06.prod.outlook.com>
References: <20180830075041.14879-1-lchen@suse.com>
In-Reply-To: <20180830075041.14879-1-lchen@suse.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:203:36::22) To HK0PR06MB2561.apcprd06.prod.outlook.com
 (2603:1096:203:6f::10)
x-incomingtopheadermarker: OriginalChecksum:D92331A8D78FE655C0572EDA6965474317D8CC65E16B00D83A56E063953F834F;UpperCasedChecksum:B8AE61855FCF1A238AD5CC8FFE5ED3B95EF39CCFE16F87BC85C52BED30127383;SizeAsReceived:7694;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [G8VrGltk34boNYAUirINMwtMQCAF+XNAKLPHuY5eS9I=]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2APC01HT122;6:e12KymIeMgGr6yZ9rgrBHcE20HIvPapQazxoglAZaWSTCkdBXexLntaQQctRdgrQnYB/t+VK5gA+U5n2EAHUXF27Ag/tMw2FCmcfsh/o2lMLUuLfGyPa0jx9G8+gXzX6zyR6lgvrYB+d9ouP0nIWVrb/fcfcv9WIXmTJ9bRDT/Cr9y4Zb3tnDIADKCUU3zYPTtFaynSp4u0ehhMDIxl9MqQSa+f0P0tjhg8XCsU+yhywJ5m3cX1/p6qf2eJ4p7lf2JZdaO4Si4GNbxbKiCNjIGTDCuwUm6ndxkPGdN/NXvYQtJQqMr/9/limIJXkf1vGDp9WaXkBh7xC+x7D9j10l/9hYyo7F0Edvb8GwzqBC/+QJV17vE4Os0OJrUAg+k7kNW2/olVl/0lVN0+L1J29dSRP01z6qAiJp3+1Gu9XfcWgn6Bjt+Zuqfn+rtnGSyXeoux4Xo360DoRxYfqxCwv0Q==;5:KC+Vf1ygbuTQ5H06vzQ/jZ5v6ytcW3NI1tWzZIUtBLC/kwQgM5U0YEh3aBgFTehyw/ZDXDG/Wl1reB85gHNuSFa9WtmNrEe1C6D4tPOj4D6CiS62WEBBuQh8wHpwPiPFU01B20Qpooisr8EFsyfWyPD60Bgy4MNqDCDcDpQ2KqU=;7:p1g3/LzdKGoswSixgW4hxQHzXRL6b0OGwWwjUlUDHSy7pC/WftOjXev1Qpy+FAAzBqo/sXsmf2QeTbK+aude50zKmzksrESMlN3Icl779Vk+lQV3HxG6aMryWcXO4bxsViRp9bWPT/IMvxcPP0fcdRJpx7bZYc/MIwKyLVUDZCGUEcW66xt5tAokwDZ0DO85zwVDhaSAuB1jkXKY5HKSw0O7HBoK6rYcKBthex2fRgCtEd7x7RjSz/GKmYYnLUcX
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1603101475)(1601125500)(1701031045);SRVR:SG2APC01HT122;
x-ms-traffictypediagnostic: SG2APC01HT122:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:SG2APC01HT122;BCL:0;PCL:0;RULEID:;SRVR:SG2APC01HT122;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(7070007)(199004)(189003)(99286004)(2900100001)(476003)(106356001)(486006)(105586002)(5250100002)(4326008)(68736007)(7696005)(76176011)(6246003)(229853002)(74482002)(54906003)(55016002)(74316002)(81612004)(110136005)(8936002)(2201001)(446003)(5660300001)(82202002)(81156014)(11346002)(256004)(14454004)(25786009)(56003)(97736004)(6506007)(386003)(2501003)(86362001)(102836004)(15760500003)(104016004)(9686003)(6346003)(8676002)(26005)(6436002)(305945005)(33656002)(53546011);DIR:OUT;SFP:1901;SCL:1;SRVR:SG2APC01HT122;H:HK0PR06MB2561.apcprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: live.cn does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gechangwei@live.cn; 
x-microsoft-antispam-message-info: NxB+uZkihpUiLJqYaYgjFrL5aM/U7N4K3azNIv0BjO8xI8zUwaawWGt8DwBcYAOsOBQ5Oi1M0bzGTQXwhw4Uh9lIe8sDIONSEBktqVnvrVoaH1ZLd/i8g3PIZLoAz0z9UFIhMublUubsLYH4QqgoAVq1NDU8ZXFPhlD5r5DdJvv+ilQx7T0iDNM2yKFOvKeckXS7YN2LpIcHb3Prvw4AWOrioniQ8KC7nxkGFX1wPfw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <214C661FD9E1F34BB7D48484B3E24B19@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c54f6f-1075-43e0-2db8-08d60e4de7fb
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 07:55:09.1005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TG9va3MgZ29vZCB0byBtZS4NCg0KDQpPbiAyMDE4LzgvMzAgMTU6NTAsIExhcnJ5IENoZW4gd3Jv
dGU6DQo+IG9jZnMyX2R1cGxpY2F0ZV9jbHVzdGVyc19ieV9wYWdlIG1heSBjcmFzaCBpZiBvbmUg
b2YgZXh0ZW50J3MgcGFnZXMgaXMgZGlydHkuDQo+IFdoZW4gYSBwYWdlIGhhcyBub3QgYmVlbiB3
cml0dGVuIGJhY2ssIGl0IGlzIHN0aWxsIGluIGRpcnR5IHN0YXRlLiBJZg0KPiBvY2ZzMl9kdXBs
aWNhdGVfY2x1c3RlcnNfYnlfcGFnZSBpcyBjYWxsZWQgYWdhaW5zdCB0aGUNCj4gZGlydHkgcGFn
ZSwgdGhlIGNyYXNoIGhhcHBlbnMuDQo+DQo+IFRvIGZpeCB0aGlzIGJ1Zywgd2UgY2FuIHdyaXRl
IGJhY2sgdGhlIHBhZ2UgcmF0aGVyIHRoYW4ganVzdCB3YWl0Lg0KPg0KPiBUaGUgZm9sbG93aW5n
IGlzIHRoZSBiYWNrIHRyYWNlIGR1bXA6DQo+DQo+IGtlcm5lbCBCVUcgYXQgL3Jvb3QvY29kZS9v
Y2ZzMi9yZWZjb3VudHRyZWUuYzoyOTYxIQ0KPiAJQlVHX09OKFBhZ2VEaXJ0eShwYWdlKSk7DQo+
IFtleGNlcHRpb24gUklQOiBvY2ZzMl9kdXBsaWNhdGVfY2x1c3RlcnNfYnlfcGFnZSs4MjJdDQo+
IF9fb2NmczJfbW92ZV9leHRlbnQrMHg4MC8weDQ1MCBbb2NmczJdDQo+ID8gX19vY2ZzMl9jbGFp
bV9jbHVzdGVycysweDEzMC8weDI1MCBbb2NmczJdDQo+IG9jZnMyX2RlZnJhZ19leHRlbnQrMHg1
YjgvMHg1ZTAgW29jZnMyXQ0KPiBfX29jZnMyX21vdmVfZXh0ZW50c19yYW5nZSsweDJhNC8weDQ3
MCBbb2NmczJdDQo+IG9jZnMyX21vdmVfZXh0ZW50cysweDE4MC8weDNiMCBbb2NmczJdDQo+ID8g
b2NmczJfd2FpdF9mb3JfcmVjb3ZlcnkrMHgxMy8weDcwIFtvY2ZzMl0NCj4gb2NmczJfaW9jdGxf
bW92ZV9leHRlbnRzKzB4MTMzLzB4MmQwIFtvY2ZzMl0NCj4gb2NmczJfaW9jdGwrMHgyNTMvMHg2
NDAgW29jZnMyXQ0KPiBkb192ZnNfaW9jdGwrMHg5MC8weDVmMA0KPiBTeVNfaW9jdGwrMHg3NC8w
eDgwDQo+IGRvX3N5c2NhbGxfNjQrMHg3NC8weDE0MA0KPiBlbnRyeV9TWVNDQUxMXzY0X2FmdGVy
X2h3ZnJhbWUrMHgzZC8weGEyDQo+DQo+DQo+IENoYW5nZS1sb2c6DQo+IDEuIE9uY2Ugd2UgZmlu
ZCB0aGUgcGFnZSBpcyBkaXJ0eSwgd2UgZG8gbm90IHdhaXQgdW50aWwgaXQncyBjbGVhbiwNCj4g
ICAgIGJ1dCByYXRoZXIgd2UgdXNlIHdyaXRlX29uZV9wYWdlIHRvIHdyaXRlIGl0IGJhY2sNCj4N
Cj4gMi4gd3JpdGVfb25lX3BhZ2UgYXJndW1lbnRzIGxpc3QgY2hhbmdlZCwgYWRqdXN0IGFuZCBy
ZXRlc3QgdGhpcyBwYXRjaC4NCj4NCj4gMy4gQ29tbWVudHMgaGFzIGJlZW4gY2hhbmdlZA0KPg0K
PiA0LiBTb3JyeSwgbWlzcyAib2NmczIiIHByZWZpeCBpbiBwYXRjaCB0aXRsZQ0KPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBMYXJyeSBDaGVuIDxsY2hlbkBzdXNlLmNvbT4NCkFja2VkLWJ5OiBDaGFuZ3dl
aSBHZSA8Z2UuY2hhbmd3ZWlAaDNjLmNvbT4NCg0KPiAtLS0NCj4gICBmcy9vY2ZzMi9yZWZjb3Vu
dHRyZWUuYyB8IDE2ICsrKysrKysrKysrKy0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2ZzL29jZnMyL3Jl
ZmNvdW50dHJlZS5jIGIvZnMvb2NmczIvcmVmY291bnR0cmVlLmMNCj4gaW5kZXggNzg2OTYyMmFm
MjJhLi5lZDg0ZDA1YzdkMDAgMTAwNjQ0DQo+IC0tLSBhL2ZzL29jZnMyL3JlZmNvdW50dHJlZS5j
DQo+ICsrKyBiL2ZzL29jZnMyL3JlZmNvdW50dHJlZS5jDQo+IEBAIC0yOTQ2LDYgKzI5NDYsNyBA
QCBpbnQgb2NmczJfZHVwbGljYXRlX2NsdXN0ZXJzX2J5X3BhZ2UoaGFuZGxlX3QgKmhhbmRsZSwN
Cj4gICAJCWlmIChtYXBfZW5kICYgKFBBR0VfU0laRSAtIDEpKQ0KPiAgIAkJCXRvID0gbWFwX2Vu
ZCAmIChQQUdFX1NJWkUgLSAxKTsNCj4gICANCj4gK3JldHJ5Og0KPiAgIAkJcGFnZSA9IGZpbmRf
b3JfY3JlYXRlX3BhZ2UobWFwcGluZywgcGFnZV9pbmRleCwgR0ZQX05PRlMpOw0KPiAgIAkJaWYg
KCFwYWdlKSB7DQo+ICAgCQkJcmV0ID0gLUVOT01FTTsNCj4gQEAgLTI5NTQsMTEgKzI5NTUsMTgg
QEAgaW50IG9jZnMyX2R1cGxpY2F0ZV9jbHVzdGVyc19ieV9wYWdlKGhhbmRsZV90ICpoYW5kbGUs
DQo+ICAgCQl9DQo+ICAgDQo+ICAgCQkvKg0KPiAtCQkgKiBJbiBjYXNlIFBBR0VfU0laRSA8PSBD
TFVTVEVSX1NJWkUsIFRoaXMgcGFnZQ0KPiAtCQkgKiBjYW4ndCBiZSBkaXJ0aWVkIGJlZm9yZSB3
ZSBDb1cgaXQgb3V0Lg0KPiArCQkgKiBJbiBjYXNlIFBBR0VfU0laRSA8PSBDTFVTVEVSX1NJWkUs
IHdlIGRvIG5vdCBleHBlY3QgYSBkaXJ0eSBwYWdlLA0KPiArCQkgKiBzbyB3cml0ZSBpdCBiYWNr
Lg0KPiAgIAkJICovDQo+IC0JCWlmIChQQUdFX1NJWkUgPD0gT0NGUzJfU0Ioc2IpLT5zX2NsdXN0
ZXJzaXplKQ0KPiAtCQkJQlVHX09OKFBhZ2VEaXJ0eShwYWdlKSk7DQo+ICsJCWlmIChQQUdFX1NJ
WkUgPD0gT0NGUzJfU0Ioc2IpLT5zX2NsdXN0ZXJzaXplKSB7DQo+ICsJCQlpZiAoUGFnZURpcnR5
KHBhZ2UpKSB7DQo+ICsJCQkJLyoNCj4gKwkJCQkgKiB3cml0ZV9vbl9wYWdlIHdpbGwgdW5sb2Nr
IHRoZSBwYWdlIG9uIHJldHVybg0KPiArCQkJCSAqLw0KPiArCQkJCXJldCA9IHdyaXRlX29uZV9w
YWdlKHBhZ2UpOw0KPiArCQkJCWdvdG8gcmV0cnk7DQo+ICsJCQl9DQo+ICsJCX0NCj4gICANCj4g
ICAJCWlmICghUGFnZVVwdG9kYXRlKHBhZ2UpKSB7DQo+ICAgCQkJcmV0ID0gYmxvY2tfcmVhZF9m
dWxsX3BhZ2UocGFnZSwgb2NmczJfZ2V0X2Jsb2NrKTsNCg0K
