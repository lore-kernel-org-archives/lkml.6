Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AEBC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050872088E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Y9ZKa8wS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050872088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeILSga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:36:30 -0400
Received: from mail-pu1apc01on0113.outbound.protection.outlook.com ([104.47.126.113]:5400
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727746AbeILSg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNKET3JFaYOKiTc0BxIV+BIjKkgf9Uq14rJ/VRtGrHg=;
 b=Y9ZKa8wSLWiWMYN380Wd28Tbfrq9a1GrDurM0AUqxeu2tX0WJzZS2yNgdt9Y2I92l9De3N+gdai/ts0LnnIJNg3I5d5xNnY5Ye91GNCN0Ky4wn2JyW8979+ORSKJuuyYOp1n7OU727gJPkB4zCnls3lTUkalHKOmD8WxHJU39G0=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0147.APCP153.PROD.OUTLOOK.COM (52.133.156.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Wed, 12 Sep 2018 13:31:48 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890%5]) with mapi id 15.20.1143.010; Wed, 12 Sep 2018
 13:31:47 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
To:     "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Subject: Re: [PATCH 10/13] x86/hyper-v: Add HvFlushGuestAddressList hypercall
 support
Thread-Topic: [PATCH 10/13] x86/hyper-v: Add HvFlushGuestAddressList hypercall
 support
Thread-Index: AQHUSOHJLOBE0OrXvE+2gnpjgG3+taTry5cAgADcRwA=
Date:   Wed, 12 Sep 2018 13:31:47 +0000
Message-ID: <037e5cba-c549-01b3-5473-ccfe112f8b63@microsoft.com>
References: <20180910083806.65177-1-Tianyu.Lan@microsoft.com>
 <20180910083806.65177-11-Tianyu.Lan@microsoft.com>
 <CY4PR21MB077329ED0E195CDF557A09DEDC1B0@CY4PR21MB0773.namprd21.prod.outlook.com>
In-Reply-To: <CY4PR21MB077329ED0E195CDF557A09DEDC1B0@CY4PR21MB0773.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0P153MB0147;6:FZFZYNooeVgOk3NHrnLg0Vj1Nutv02nmV28IgGLSlmYJ/83K2yrG+8ZfNHmQYkpR1SCgLeyY2tJXCaNYOngpH13Rh35bGOTQis7fuldah1cAqkChFHhqha9Ez355EQYiCBycIyQevj4NHgJJ6+wkwlsHIrELs0GwNr1AIupprZImvTDCX5mnqITQMqLOPRY91wehb9bq3B5GnbhKzJ6RbtKBlPisqSYC9nEPVRIJ+1Ig8Mf9Nr0LyIeayXpDaR71nI13s7bIaajt08svrC7zZL7iDfTgIlRgVpovYLvCik9evoA4SvbgQUUkKTb4MxeR+1s4dPm6UPp+r6N2N3HDpIcVsJkhPkchZtm/VVWCb+XLVPuSE+npf3IdRsJJNqrBuMOsTMi4NaVjn4qTJPVXG+zuOmUTkrK/ajjODTeKuZp0NaGLhZ+YSSdLqzOsS7aLzpdY/s4tG3pMFCJJW0xsaQ==;5:bdj0Bkgyge64QiWXglUStqF4kPBUvWVVnuvRVZW2XK4zpibLus3ZVuwvqIJCk+7HIJSihGPIQkAq/CM8a/bZZUJQqfWyI6q8MFg1vPUMTug4POwre/M0nLxNEL+bRdZmvX8J7RzilErXg1KSbZ2vG38k0CWM59Ihs49LriryKvs=;7:lODodLF3VsNLf7ZQEosvZ0xyoLY9t4m0mBAFOQC9iI9SaHkEocl+V6+DpO1mEfckGcMoHw6QchZc4o+QbwohdsHxeqlV2t8F+J+WJ0mziUiItiGQRRG4Trula8/jNCAotota/utSMSyGheyFKvKwD20qW/K/bpzthy7s4KuADVMf9IJ1jgkToObRMpR+sEBGTkUAE//m0SmsepHvxyzClexRBs5HBLr9KyBHT9y3p9QPJBntr5R3IwP6LarmsKFE
x-ms-office365-filtering-correlation-id: 19712ede-ae85-4b49-d2c0-08d618b416fb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0147;
x-ms-traffictypediagnostic: HK0P153MB0147:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0147666F3C0DCFBD92EDC72A921B0@HK0P153MB0147.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231344)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:HK0P153MB0147;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0147;
x-forefront-prvs: 07935ACF08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(376002)(39860400002)(346002)(366004)(396003)(136003)(189003)(199004)(14444005)(6436002)(316002)(476003)(3846002)(6116002)(106356001)(486006)(446003)(11346002)(105586002)(10290500003)(31686004)(2616005)(36756003)(478600001)(76176011)(85306007)(99286004)(5660300001)(66066001)(1511001)(305945005)(54906003)(72206003)(110136005)(14454004)(6346003)(86362001)(86612001)(102836004)(26005)(31696002)(2906002)(68736007)(22452003)(6506007)(53546011)(6486002)(7416002)(7736002)(107886003)(25786009)(8676002)(81166006)(6246003)(8936002)(81156014)(4326008)(6512007)(256004)(2900100001)(5250100002)(53936002)(10090500001)(229853002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0147;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-microsoft-antispam-message-info: jk8T4ytu1PYXKRk6D5GIKVrw9Jjv/9CQpZiuc66rdUUMS9gsn/i1dg+fHkkbeVfrtuu6eGB8giUntQdqlnt+KtEGd5Ha7wutL2Yg/1BgY/K1gXCxDOIxx39iADoopM99f/shQCZnoorXUzAkqAsl1qovQRq2cEGflJGgbuxFsrJ6aFJjkGW2py5dIoWkhWi3L8ngQYIM/NisvMk8rIbk6tYH6wL7zHTuMD3Mnf+k0uwNixqFnJKykKtfJayRPzsEu3JDbHU0eIXjNrEveEI6sc9bwbc7aq8uyCMCEFGygitlTxyxomLPlH8QRH3D3R0QB/QP7K1gSvft9uayxgNxFdS7HljeZGYAD3JB6yf4z6Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A810E6B52DE1D4A87094E790FE483A9@APCP153.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19712ede-ae85-4b49-d2c0-08d618b416fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2018 13:31:47.3912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWljaGFlbDoNCglUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KDQpPbiA5LzEyLzIwMTggODoy
MiBBTSwgTWljaGFlbCBLZWxsZXkgKEVPU0cpIHdyb3RlOg0KPiBGcm9tOiBUaWFueXUgTGFuICBT
ZW50OiBNb25kYXksIFNlcHRlbWJlciAxMCwgMjAxOCAxOjM5IEFNDQo+PiArDQo+PiAraW50IGh5
cGVydl9mbHVzaF9ndWVzdF9tYXBwaW5nX3JhbmdlKHU2NCBhcywgc3RydWN0IGt2bV90bGJfcmFu
Z2UgKnJhbmdlKQ0KPiANCj4gSSdtIHJlYWxseSBjb25jZXJuZWQgYWJvdXQgZGVmaW5pbmcgdGhl
IEh5cGVyLVYgZnVuY3Rpb24gdG8gZmx1c2gNCj4gZ3Vlc3QgbWFwcGluZ3MgaW4gdGVybXMgb2Yg
YSBLVk0gc3RydWN0IGRlZmluaXRpb24uICBZb3VyIHBhdGNoIHB1dHMNCj4gdGhpcyBmdW5jdGlv
biBpbiBhcmNoL3g4Ni9oeXBlcnYvbmVzdGVkLmMuICBJIGhhdmVuJ3QgaW52ZXN0aWdhdGVkIGFs
bA0KPiB0aGUgZGV0YWlscywgYnV0IG9uIGl0cyBmYWNlIHRoaXMgYXBwcm9hY2ggc2VlbXMgbGlr
ZSBpdCB3b3VsZCBjYXVzZQ0KPiB0cm91YmxlIGluIHRoZSBsb25nIHJ1biwgYW5kIGl0IGRvZXNu
J3Qgc3VwcG9ydCB0aGUgY2FzZSBvZiBhDQo+IGh5cGVydmlzb3Igb3RoZXIgdGhhbiBLVk0gcnVu
bmluZyBhdCBMMS4NCj4gDQo+IEkga25vdyB0aGF0IEtWTSBjb2RlIGhhcyB0YWtlbiBhIGRlcGVu
ZGVuY3kgb24gSHlwZXItViB0eXBlcyBhbmQNCj4gY29kZSwgYnV0IHRoYXQncyBiZWNhdXNlIEtW
TSBpcyBlbXVsYXRpbmcgYSBsb3Qgb2YgSHlwZXItViBmdW5jdGlvbmFsaXR5DQo+IGFuZCBpdCdz
IHRha2luZyBhZHZhbnRhZ2Ugb2YgSHlwZXItViBlbmxpZ2h0ZW5tZW50cy4gIElzIHRoZXJlIGEg
dG9wDQo+IGxldmVsIHJlYXNvbiBJIGhhdmVuJ3QgdGhvdWdodCBvZiBmb3IgSHlwZXItViBjb2Rl
IHRvIHRha2UgYQ0KPiBkZXBlbmRlbmN5IG9uIEtWTSBkZWZpbml0aW9ucz8gIEkgd291bGQgdGhp
bmsgd2Ugd2FudCBIeXBlci1WDQo+IGNvZGUgdG8gYmUgZ2VuZXJpYywgdXNpbmcgSHlwZXItViBk
YXRhIHN0cnVjdHVyZSBkZWZpbml0aW9ucy4gIFRoZW4gaW4NCj4ga2VlcGluZyB3aXRoIHdoYXQn
cyBhbHJlYWR5IGJlZW4gZG9uZSwgS1ZNIGNvZGUgd291bGQgdXNlIHRob3NlDQo+IGRlZmluaXRp
b25zIHdoZXJlIGl0IG5lZWRzIHRvIG1ha2UgY2FsbHMgdG8gSHlwZXItViBjb2RlLg0KPg0KDQpJ
IHRoaW5rIEtWTSBpcyBvbmx5IG9uZSBrZXJuZWwtYmFzZWQgaHlwZXJ2aXNvciBhbmQgaXMgb25s
eSBjYWxsZXIgb2YgDQpuZXN0ZWQgaHlwZXJjYWxscy4gU28gSSByZXVzZWQgS1ZNIGRhdGEgc3Ry
dWN0dXJlIGluIHRoZSBuZXcgZnVuY3Rpb24uDQpJIHdpbGwgbWFrZSBpdCBtb3JlIGdlbmVyYWwg
aW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KPj4gK3sNCj4+ICsJc3RydWN0IGt2bV9tbXVfcGFnZSAq
c3A7DQo+PiArCXN0cnVjdCBodl9ndWVzdF9tYXBwaW5nX2ZsdXNoX2xpc3QgKipmbHVzaF9wY3B1
Ow0KPj4gKwlzdHJ1Y3QgaHZfZ3Vlc3RfbWFwcGluZ19mbHVzaF9saXN0ICpmbHVzaDsNCj4+ICsJ
dTY0IHN0YXR1cyA9IDA7DQo+PiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+PiArCWludCByZXQg
PSAtRU5PVFNVUFA7DQo+PiArCWludCBncGFfbiA9IDA7DQo+PiArDQo+PiArCWlmICghaHZfaHlw
ZXJjYWxsX3BnKQ0KPj4gKwkJZ290byBmYXVsdDsNCj4+ICsNCj4+ICsJbG9jYWxfaXJxX3NhdmUo
ZmxhZ3MpOw0KPj4gKw0KPj4gKwlmbHVzaF9wY3B1ID0gKHN0cnVjdCBodl9ndWVzdF9tYXBwaW5n
X2ZsdXNoX2xpc3QgKiopDQo+PiArCQl0aGlzX2NwdV9wdHIoaHlwZXJ2X3BjcHVfaW5wdXRfYXJn
KTsNCj4+ICsNCj4+ICsJZmx1c2ggPSAqZmx1c2hfcGNwdTsNCj4+ICsJaWYgKHVubGlrZWx5KCFm
bHVzaCkpIHsNCj4+ICsJCWxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsNCj4+ICsJCWdvdG8gZmF1
bHQ7DQo+PiArCX0NCj4+ICsNCj4+ICsJZmx1c2gtPmFkZHJlc3Nfc3BhY2UgPSBhczsNCj4+ICsJ
Zmx1c2gtPmZsYWdzID0gMDsNCj4+ICsNCj4+ICsJaWYgKCFyYW5nZS0+Zmx1c2hfbGlzdCkgew0K
Pj4gKwkJZ3BhX24gPSBmaWxsX2ZsdXNoX2xpc3QoZmx1c2gtPmdwYV9saXN0LCBncGFfbiwNCj4+
ICsJCQkJcmFuZ2UtPnN0YXJ0X2dmbiwgcmFuZ2UtPmVuZF9nZm4pOw0KPj4gKwl9IGVsc2Ugew0K
Pj4gKwkJbGlzdF9mb3JfZWFjaF9lbnRyeShzcCwgcmFuZ2UtPmZsdXNoX2xpc3QsDQo+PiArCQkJ
CWZsdXNoX2xpbmspIHsNCj4+ICsJCQl1NjQgZW5kX2dmbiA9IHNwLT5nZm4gKw0KPj4gKwkJCQlL
Vk1fUEFHRVNfUEVSX0hQQUdFKHNwLT5yb2xlLmxldmVsKSAtIDE7DQo+PiArCQkJZ3BhX24gPSBm
aWxsX2ZsdXNoX2xpc3QoZmx1c2gtPmdwYV9saXN0LCBncGFfbiwNCj4+ICsJCQkJCXNwLT5nZm4s
IGVuZF9nZm4pOw0KPj4gKwkJfQ0KPiANCj4gUGVyIHRoZSBwcmV2aW91cyBjb21tZW50LCBpZiB0
aGlzIGxvb3AgcmVhbGx5IG5lZWRzIHRvIHdhbGsgYSBLVk0NCj4gZGF0YSBzdHJ1Y3R1cmUsIGxv
b2sgZm9yIGEgZGlmZmVyZW50IHdheSB0byBvcmdhbml6ZSB0aGluZ3Mgc28gdGhhdA0KPiB0aGUg
aGFuZGxpbmcgb2YgS1ZNLXNwZWNpZmljIGRhdGEgc3RydWN0dXJlcyBpcyBpbiBjb2RlIHRoYXTi
gJlzIHBhcnQNCj4gb2YgS1ZNLCByYXRoZXIgdGhhbiBpbiBIeXBlci1WIGNvZGUuDQo+IA0KPiBN
aWNoYWVsDQo+IA==
