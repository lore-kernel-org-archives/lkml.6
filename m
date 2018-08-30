Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE75C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0254820647
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Mern0D4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0254820647
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbeH3FzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 01:55:15 -0400
Received: from mail-sn1nam02on0121.outbound.protection.outlook.com ([104.47.36.121]:15712
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726169AbeH3FzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 01:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAi743Ni7lIFsx++56BMALKliF6yzls6n4xIsRmV5Uw=;
 b=Mern0D4W3bk+za2YOcNCqkFNzIv5hds4Og8tL8FllpM/HoH7bifG2i3keJWITzAy4JRA/K6kynuwtjg4VuKyKTeZmJYscfnB0yVf510zLjKDpAxsKeVqlKre9Eznr4eqO3sglrZOPhrdtBWCJz4CviMWaVtMYQlAbtSBSIbpJck=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0475.namprd21.prod.outlook.com (10.172.92.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.1; Thu, 30 Aug 2018 01:55:30 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1122.009; Thu, 30 Aug 2018
 01:55:29 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Oscar Salvador <osalvador@techadventures.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "mhocko@suse.com" <mhocko@suse.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm/page_alloc: Clean up check_for_memory
Thread-Topic: [PATCH] mm/page_alloc: Clean up check_for_memory
Thread-Index: AQHUPxJkr6MHAJjlhEm5lgIiZ1w8R6TXiugA
Date:   Thu, 30 Aug 2018 01:55:29 +0000
Message-ID: <332d9ea1-cdd0-6bb6-8e83-28af25096637@microsoft.com>
References: <20180828210158.4617-1-osalvador@techadventures.net>
In-Reply-To: <20180828210158.4617-1-osalvador@techadventures.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0475;6:EM6XUxXZAaj5UYodN1V/Ar28vScTgP1F8Hz6+NyFHPEAc9EhQDDfgfqaAjmv+Qg81CWlMLVowcf+fGE8q97LhmmhWvZ9IBcGqhf28lAF34IvXssJV+bWXp60kdqAvBGysAWWmtxgq/E2I+FifPCONFb3kBNSDWTMvD3HDjNkiGc+ecQ9YRm90dHvbuP83IPETfXhnBkH/BGwGNCdo8C8CO9kqIVgauQHNT4I15tFoxOoBM2D7XyxifGZvmqevS7pQEg5VwrLvmdLNidxpN6USAN66LT69rwLn4eVtZYmmU3WP68sMAy1j5Kwmaf/abOM3jgv32gzbxGJp2qSXJMr/LSe64hBR2pL/Vz6Pqz4CgnkNuKI7aCOyeqcCfQrh7gmbpGPdiKWTvTa0AFLOdGkXHPjmNKqKm+uTGN1JXyk3Rqdw8dmhmK4e1eR2ChgXGjUkrQCdqRwx42oAZp1u7fn+g==;5:MaOXfzKFfA1qddAcYbOTqeDJHyp2oKOvXVnP2pN+BcxouCTdQc3Qbk6sAxMzXNvt5SGYQzNehol/5MYUtsN/RKx6M9xYsVwWE6yDYrPsUSnxdNzlIjWXksEsAC3B81vsKCn/Ew/yn3QpxejqZbUphV/mdkzT2YqMERISHqPT7KI=;7:cbIOIB2WVhcravdPZ3TFRzrqpMcYboZZISlMs4NrAPl2D7vdflxUZyXBa7zh9dL1bzJzPK/b791WlnL7BTJWve296NpPde7sBrnsQvlc/RxYEaw9B4D0sPuHwJEePWtrHeh0Yp/u4Of6mci6/3hYzRd7IqTxF2oyPVJU9PTaNZCdf+ioEcCXirM+80MlACheDbsulKM3uNwSMYTQTL8GKXCOBkeoozPVERybmOcIbHw4JfgYCyUPTPxfmnmTavNQ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 895ded1c-1493-4031-80f0-08d60e1baa11
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989150)(4534165)(4627221)(201703031133081)(201702281549075)(8990150)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0475;
x-ms-traffictypediagnostic: DM5PR21MB0475:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB04754B2A0F5AB24D53AF16719D080@DM5PR21MB0475.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0475;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0475;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(136003)(346002)(366004)(51444003)(199004)(189003)(6486002)(6436002)(106356001)(105586002)(6246003)(31686004)(8936002)(14454004)(6512007)(81166006)(81156014)(229853002)(256004)(4326008)(2501003)(5250100002)(25786009)(53936002)(68736007)(2616005)(8676002)(36756003)(76176011)(2900100001)(446003)(110136005)(11346002)(486006)(476003)(10090500001)(97736004)(5660300001)(99286004)(72206003)(6506007)(316002)(54906003)(478600001)(186003)(102836004)(10290500003)(53546011)(22452003)(26005)(2906002)(66066001)(6116002)(575784001)(305945005)(31696002)(86612001)(86362001)(7736002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0475;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JNauyoHKf9jKr54Lpc4qt/qmNreEc/Wc9MJ1rFnQnrUMdMFLvBE0eHiusao/BHCfrxp0W0qYgH/2L3Ud+s2AOKKhmHBLrWbcl+WZuYYrMGsS/dEP8QAxFsqy3RDcbszqT1bP/8A24vxdG3sF0FyeDTDKo4jS0KzzW0KKv1OL3q3Ew9R0Y4WnP8YTR9JW8r5DDB0lC09KaZd15jF3AiY73hdWLrelD6Kghs2TGF0b+KbObQbh2r3Bbts5ZsUOjJy5pki/G5t9JapnvbW13bArFiaOry6XtH73PLD39QH4AyT/Dwf4oAMV6K5fdBeGTduPu7652MjhlTXrjLfDBR4noiEIMBD0NNkl7UhbHY5GgZc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6C84231AE129F45AEA20EBD69B9806E@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895ded1c-1493-4031-80f0-08d60e1baa11
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 01:55:29.8112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0475
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDgvMjgvMTggNTowMSBQTSwgT3NjYXIgU2FsdmFkb3Igd3JvdGU6DQo+IEZyb206IE9z
Y2FyIFNhbHZhZG9yIDxvc2FsdmFkb3JAc3VzZS5kZT4NCj4gDQo+IGNoZWNrX2Zvcl9tZW1vcnkg
bG9va3MgYSBiaXQgY29uZnVzaW5nLg0KPiBGaXJzdCBvZiBhbGwsIHdlIGhhdmUgdGhpczoNCj4g
DQo+IGlmIChOX01FTU9SWSA9PSBOX05PUk1BTF9NRU1PUlkpDQo+IAlyZXR1cm47DQo+IA0KPiBD
aGVja2luZyB0aGUgRU5VTSBkZWNsYXJhdGlvbiwgbG9va3MgbGlrZSBOX01FTU9SWSBjYW5vdCBi
ZSBlcXVhbCB0bw0KPiBOX05PUk1BTF9NRU1PUlkuDQo+IEkgY291bGQgbm90IGZpbmQgd2hlcmUg
Tl9NRU1PUlkgaXMgc2V0IHRvIE5fTk9STUFMX01FTU9SWSwgb3IgdGhlIG90aGVyDQo+IHdheSBh
cm91bmQgZWl0aGVyLCBzbyB1bmxlc3MgSSBhbSBtaXNzaW5nIHNvbWV0aGluZywgdGhpcyBjb25k
aXRpb24gDQo+IHdpbGwgbmV2ZXIgZXZhbHVhdGUgdG8gdHJ1ZS4NCj4gSXQgbWFrZXMgc2Vuc2Ug
dG8gZ2V0IHJpZCBvZiBpdC4NCj4gDQo+IE1vdmluZyBmb3J3YXJkLCB0aGUgb3BlcmF0aW9ucyB3
aGl0aGluIHRoZSBsb29wIGxvb2sgYSBiaXQgY29uZnVzaW5nDQo+IGFzIHdlbGwuDQo+IA0KPiBX
ZSBzZXQgTl9ISUdIX01FTU9SWSB1bmNvbmRpdGlvbmFsbHksIGFuZCB0aGVuIHdlIHNldCBOX05P
Uk1BTF9NRU1PUlkNCj4gaW4gY2FzZSB3ZSBoYXZlIENPTkZJR19ISUdITUVNIChOX05PUk1BTF9N
RU1PUlkgIT0gTl9ISUdIX01FTU9SWSkNCj4gYW5kIHpvbmUgPD0gWk9ORV9OT1JNQUwuDQo+IChO
X0hJR0hfTUVNT1JZIGZhbGxzIGJhY2sgdG8gTl9OT1JNQUxfTUVNT1JZIG9uICFDT05GSUdfSElH
SE1FTSBzeXN0ZW1zLA0KPiBhbmQgdGhhdCBpcyB3aHkgd2UgY2FuIGp1c3QgZ28gYWhlYWQgYW5k
IHNldCBOX0hJR0hfTUVNT1JZIHVuY29uZGl0aW9uYWxseSkNCj4gDQo+IEFsdGhvdWdoIHRoaXMg
d29ya3MsIGl0IGlzIGEgYml0IHN1YnRsZS4NCj4gDQo+IEkgdGhpbmsgdGhhdCB0aGlzIGNvdWxk
IGJlIGVhc2llciB0byBmb2xsb3c6DQo+IA0KPiBGaXJzdCwgd2Ugc2hvdWxkIG9ubHkgc2V0IE5f
SElHSF9NRU1PUlkgaW4gY2FzZSB3ZSBoYXZlDQo+IENPTkZJR19ISUdITUVNLg0KPiBBbmQgdGhl
biB3ZSBzaG91bGQgc2V0IE5fTk9STUFMX01FTU9SWSBpbiBjYXNlIHpvbmUgPD0gWk9ORV9OT1JN
QUwsDQo+IHdpdGhvdXQgZnVydGhlciBjaGVja2luZyB3aGV0aGVyIHdlIGhhdmUgQ09ORklHX0hJ
R0hNRU0gb3Igbm90Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogT3NjYXIgU2FsdmFkb3IgPG9zYWx2
YWRvckBzdXNlLmRlPg0KPiAtLS0NCj4gIG1tL3BhZ2VfYWxsb2MuYyB8IDkgKysrLS0tLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL21tL3BhZ2VfYWxsb2MuYyBiL21tL3BhZ2VfYWxsb2MuYw0KPiBpbmRleCA4
MzllMGNjMTdmMmMuLjZhYTk0N2Y5ZTYxNCAxMDA2NDQNCj4gLS0tIGEvbW0vcGFnZV9hbGxvYy5j
DQo+ICsrKyBiL21tL3BhZ2VfYWxsb2MuYw0KPiBAQCAtNjgxOSwxNSArNjgxOSwxMiBAQCBzdGF0
aWMgdm9pZCBjaGVja19mb3JfbWVtb3J5KHBnX2RhdGFfdCAqcGdkYXQsIGludCBuaWQpDQo+ICB7
DQo+ICAJZW51bSB6b25lX3R5cGUgem9uZV90eXBlOw0KPiAgDQo+IC0JaWYgKE5fTUVNT1JZID09
IE5fTk9STUFMX01FTU9SWSkNCj4gLQkJcmV0dXJuOw0KPiAtDQo+ICAJZm9yICh6b25lX3R5cGUg
PSAwOyB6b25lX3R5cGUgPD0gWk9ORV9NT1ZBQkxFIC0gMTsgem9uZV90eXBlKyspIHsNCj4gIAkJ
c3RydWN0IHpvbmUgKnpvbmUgPSAmcGdkYXQtPm5vZGVfem9uZXNbem9uZV90eXBlXTsNCj4gIAkJ
aWYgKHBvcHVsYXRlZF96b25lKHpvbmUpKSB7DQo+IC0JCQlub2RlX3NldF9zdGF0ZShuaWQsIE5f
SElHSF9NRU1PUlkpOw0KPiAtCQkJaWYgKE5fTk9STUFMX01FTU9SWSAhPSBOX0hJR0hfTUVNT1JZ
ICYmDQo+IC0JCQkgICAgem9uZV90eXBlIDw9IFpPTkVfTk9STUFMKQ0KPiArCQkJaWYgKElTX0VO
QUJMRUQoQ09ORklHX0hJR0hNRU0pKQ0KPiArCQkJCW5vZGVfc2V0X3N0YXRlKG5pZCwgTl9ISUdI
X01FTU9SWSk7DQo+ICsJCQlpZiAoem9uZV90eXBlIDw9IFpPTkVfTk9STUFMKQ0KPiAgCQkJCW5v
ZGVfc2V0X3N0YXRlKG5pZCwgTl9OT1JNQUxfTUVNT1JZKTsNCj4gIAkJCWJyZWFrOw0KPiAgCQl9
DQo+IA0KDQpJIHdvdWxkIHJlLXdyaXRlIHRoZSBhYm92ZSBmdW5jdGlvbiBsaWtlIHRoaXM6DQpz
dGF0aWMgdm9pZCBjaGVja19mb3JfbWVtb3J5KHBnX2RhdGFfdCAqcGdkYXQsIGludCBuaWQpDQp7
DQogICAgICAgIGVudW0gem9uZV90eXBlIHpvbmVfdHlwZTsNCg0KICAgICAgICBmb3IgKHpvbmVf
dHlwZSA9IDA7IHpvbmVfdHlwZSA8IFpPTkVfTU9WQUJMRTsgem9uZV90eXBlKyspIHsNCiAgICAg
ICAgICAgICAgICBpZiAocG9wdWxhdGVkX3pvbmUoJnBnZGF0LT5ub2RlX3pvbmVzW3pvbmVfdHlw
ZV0pKSB7IA0KICAgICAgICAgICAgICAgICAgICAgICAgbm9kZV9zZXRfc3RhdGUobmlkLCB6b25l
X3R5cGUgPD0gWk9ORV9OT1JNQUwgPw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgTl9OT1JNQUxfTUVNT1JZOiBOX0hJR0hfTUVNT1JZKTsNCiAgICAgICAgICAgICAgICAg
ICAgICAgIGJyZWFrOw0KICAgICAgICAgICAgICAgIH0NCiAgICAgICAgfQ0KfQ0KDQp6b25lX3R5
cGUgPD0gWk9ORV9NT1ZBQkxFIC0gMQ0KaXMgdGhlIHNhbWUgYXM6DQp6b25lX3R5cGUgPCBaT05F
X01PVkFCTEUNCg0KSWYgem9uZSA+IFpPTkVfTk9STUFMLCBpdCBtZWFucyB0aGF0IENPTkZJR19I
SUdITUVNIGlzIGVuYWJsZWQsIG5vIG5lZWQgdG8gY2hlY2sgZm9yIGl0Lg0KDQpQYXZlbA==
