Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF490C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C13E216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CdIRfrBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C13E216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeI0Tf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:35:26 -0400
Received: from mail-eopbgr700047.outbound.protection.outlook.com ([40.107.70.47]:27280
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727588AbeI0Tf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPVd0y2Y0kM8E898e738U+DtEkAvPKzICoJ/0LVrJGc=;
 b=CdIRfrBAX4MO+jr8dv9rn0gr78wgksmzMNyHQRwoMRC5yATP2rkfwzz1qiyE6SVx8zcJREDXphXa0EXNSwObEJ48711jN828JmI98yKjunR4Sv4UA0XCuvPy6MsZ2Yslc1m64sdedOZQtNU66hSxeudOa1G1iHmARqGQPtB1xXo=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB0846.namprd12.prod.outlook.com (10.164.26.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Thu, 27 Sep 2018 13:16:57 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::2d1b:5638:5680:80e7]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::2d1b:5638:5680:80e7%5]) with mapi id 15.20.1143.022; Thu, 27 Sep 2018
 13:16:57 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Kairui Song <kasong@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "bp@suse.de" <bp@suse.de>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "ghook@redhat.com" <ghook@redhat.com>
Subject: Re: [PATCH] x86/boot: Fix kexec booting failure after SEV early boot
 support
Thread-Topic: [PATCH] x86/boot: Fix kexec booting failure after SEV early boot
 support
Thread-Index: AQHUVl8Rtwdw6f8kjkKzFlRKU1S5BaUEG/aA
Date:   Thu, 27 Sep 2018 13:16:57 +0000
Message-ID: <1a9e75fa-5105-f17d-e8f8-a3d2314c9680@amd.com>
References: <20180927123845.32052-1-kasong@redhat.com>
In-Reply-To: <20180927123845.32052-1-kasong@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0111.namprd15.prod.outlook.com
 (2603:10b6:101:21::31) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0846;20:1v0yMaohpzePwFvDa2eh6N9ll8GTkSjfwanDleErBC4WMRqIhFRmrFrCg6ZBXbJ20HO9hVu3w4MoI1+uZqjUNNXayxoE6ngZSjrjhOSrK6agIB0n8rBYx8NjZ8FtestOeRTf/OQaGKihKOKcMUbry6RpWSy7xFqKlWrt0V+1jzMQ4j9qCkZ02LrkchJLFQ24GiTshF69oBHWz3jMEItjGxKHq04xxLatF+iwcZ0uaqk5FsXRObh/G16tmUuWZ1ou
x-ms-office365-filtering-correlation-id: 70e7ba1d-6416-4203-1b51-08d6247b800c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0846;
x-ms-traffictypediagnostic: SN1PR12MB0846:
x-microsoft-antispam-prvs: <SN1PR12MB0846DCEE0C85535F45A4B542EC140@SN1PR12MB0846.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051);SRVR:SN1PR12MB0846;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0846;
x-forefront-prvs: 0808323E97
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(366004)(39860400002)(199004)(189003)(6436002)(54906003)(5250100002)(256004)(102836004)(2501003)(106356001)(97736004)(7736002)(105586002)(6486002)(5660300001)(229853002)(36756003)(2900100001)(7416002)(305945005)(34290500001)(81166006)(81156014)(486006)(2616005)(11346002)(446003)(14444005)(186003)(476003)(68736007)(71200400001)(71190400001)(26005)(8936002)(6506007)(66066001)(386003)(31686004)(53546011)(6512007)(14454004)(3846002)(6116002)(53936002)(99286004)(478600001)(72206003)(25786009)(8676002)(4326008)(2906002)(110136005)(575784001)(316002)(6246003)(31696002)(86362001)(76176011)(52116002)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0846;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bL4gz0HVSTfcyxqIgWbqJpBI55Kj55vGikJ+SflS3/H84l0EjKsZ/qLjvWJ3FGOJCncFIdu0/5l23jyTVFFJ3l4niNLC5dy1haGvjBM1qHKrsZPhiba0sfGzL+ALYKl7RpoaZC5Epm3Nuvy4mUTTzwvDMQ3n0zMiJeyndXWVzQ/QW79DnPh/n7hEJSI562i9PUJvPhfMDUwjd3nHeaQk3t4/OSWRiBR3PUc5Egh1BlXjnUvOpQ37bPIcHQTk1tUhhKFKIPYmGrO0HNKVtdQOYwBR0OIKftKMzg9ci9XeZgb9hN4PwEr94PZHySDJgAEu+DR2sDKEVj1STFO0T29HeSSVgbjCOLjVjVJ2E5lbrJI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <41260C7D53A8124F84B47302815E6E84@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e7ba1d-6416-4203-1b51-08d6247b800c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 13:16:57.3608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0846
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMjcvMjAxOCAwNzozOCBBTSwgS2FpcnVpIFNvbmcgd3JvdGU6DQo+IENvbW1pdCAxOTU4
YjVmYzQwMTAgKCJ4ODYvYm9vdDogQWRkIGVhcmx5IGJvb3Qgc3VwcG9ydCB3aGVuIHJ1bm5pbmcN
Cj4gd2l0aCBTRVYgYWN0aXZlIikgaXMgY2F1c2luZyBrZXhlYyBiZWNvbWVzIHNvbWV0aW1lcyB1
bnN0YWJsZSBldmVuIGlmDQo+IFNFViBpcyBub3QgYWN0aXZlLiBrZXhlYyByZWJvb3Qgd29uJ3Qg
c3RhcnQgYSBzZWNvbmQga2VybmVsIGJ5cGFzc2luZw0KPiBCSU9TIGJvb3QgcHJvY2VzcywgaW5z
dGVhZCwgdGhlIHN5c3RlbSBnb3QgcmVzZXQuDQo+IA0KPiBUaGF0J3MgYmVjYXVzZSwgaW4gZ2V0
X3Nldl9lbmNyeXB0aW9uX2JpdCBmdW5jdGlvbiwgd2UgYXJlIHVzaW5nDQo+IDMyLWJpdCBSSVAt
cmVsYXRpdmUgYWRkcmVzc2luZyB0byByZWFkIHRoZSB2YWx1ZSBvZiBlbmNfYml0LCBidXQNCj4g
a2V4ZWMgbWF5IGFsbG9jIHRoZSBlYXJseSBib290IHVwIGNvZGUgdG8gYSBoaWdoZXIgbG9jYXRp
b24sIHdoaWNoDQo+IGlzIGJleW9uZCAzMi1iaXQgYWRkcmVzc2luZyBsaW1pdC4gU29tZSBnYXJi
YWdlIHdpbGwgYmUgcmVhZCBhbmQNCj4gZ2V0X3Nldl9lbmNyeXB0aW9uX2JpdCB3aWxsIHJldHVy
biB0aGUgd3JvbmcgdmFsdWUsIHdoaWNoIGxlYWRzIHRvDQo+IHdyb25nIG1lbW9yeSBwYWdlIGZs
YWcuDQo+IA0KPiBUaGlzIHBhdGNoIHJlbW92ZXMgdGhlIHVzZSBvZiBlbmNfYml0LCBhcyBjdXJy
ZW50bHksIGVuY19iaXQncyBvbmx5DQo+IHB1cnBvc2UgaXMgdG8gYXZvaWQgZHVwbGljYXRlZCBl
bmNyeXB0aW9uIGJpdCByZWFkaW5nLCBidXQgdGhlIG92ZXJoZWFkDQo+IG9mIHJlYWRpbmcgZW5j
cnlwdGlvbiBiaXQgaXMgc28gdGlueSwgc28gbm8gbmVlZCB0byBjYWNoZSB0aGF0Lg0KPiANCj4g
Rml4ZXM6IDE5NThiNWZjNDAxMCAoIng4Ni9ib290OiBBZGQgZWFybHkgYm9vdCBzdXBwb3J0IHdo
ZW4gcnVubmluZyB3aXRoIFNFViBhY3RpdmUiKQ0KPiBTdWdnZXN0ZWQtYnk6IEJvcmlzbGF2IFBl
dGtvdiA8YnBAc3VzZS5kZT4NCj4gU2lnbmVkLW9mZi1ieTogS2FpcnVpIFNvbmcgPGthc29uZ0By
ZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogVG9tIExlbmRhY2t5IDx0aG9tYXMubGVuZGFja3lA
YW1kLmNvbT4NCg0KPiAtLS0NCj4gIGFyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9tZW1fZW5jcnlw
dC5TIHwgMTkgLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE5IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9tZW1f
ZW5jcnlwdC5TIGIvYXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL21lbV9lbmNyeXB0LlMNCj4gaW5k
ZXggZWFhODQzYTUyOTA3Li5hNDgwMzU2ZTBlZDggMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2Jv
b3QvY29tcHJlc3NlZC9tZW1fZW5jcnlwdC5TDQo+ICsrKyBiL2FyY2gveDg2L2Jvb3QvY29tcHJl
c3NlZC9tZW1fZW5jcnlwdC5TDQo+IEBAIC0yNSwyMCArMjUsNiBAQCBFTlRSWShnZXRfc2V2X2Vu
Y3J5cHRpb25fYml0KQ0KPiAgCXB1c2gJJWVieA0KPiAgCXB1c2gJJWVjeA0KPiAgCXB1c2gJJWVk
eA0KPiAtCXB1c2gJJWVkaQ0KPiAtDQo+IC0JLyoNCj4gLQkgKiBSSVAtcmVsYXRpdmUgYWRkcmVz
c2luZyBpcyBuZWVkZWQgdG8gYWNjZXNzIHRoZSBlbmNyeXB0aW9uIGJpdA0KPiAtCSAqIHZhcmlh
YmxlLiBTaW5jZSB3ZSBhcmUgcnVubmluZyBpbiAzMi1iaXQgbW9kZSB3ZSBuZWVkIHRoaXMgY2Fs
bC9wb3ANCj4gLQkgKiBzZXF1ZW5jZSB0byBnZXQgdGhlIHByb3BlciByZWxhdGl2ZSBhZGRyZXNz
aW5nLg0KPiAtCSAqLw0KPiAtCWNhbGwJMWYNCj4gLTE6CXBvcGwJJWVkaQ0KPiAtCXN1YmwJJDFi
LCAlZWRpDQo+IC0NCj4gLQltb3ZsCWVuY19iaXQoJWVkaSksICVlYXgNCj4gLQljbXBsCSQwLCAl
ZWF4DQo+IC0JamdlCS5Mc2V2X2V4aXQNCj4gIA0KPiAgCS8qIENoZWNrIGlmIHJ1bm5pbmcgdW5k
ZXIgYSBoeXBlcnZpc29yICovDQo+ICAJbW92bAkkMSwgJWVheA0KPiBAQCAtNjksMTUgKzU1LDEy
IEBAIEVOVFJZKGdldF9zZXZfZW5jcnlwdGlvbl9iaXQpDQo+ICANCj4gIAltb3ZsCSVlYngsICVl
YXgNCj4gIAlhbmRsCSQweDNmLCAlZWF4CQkvKiBSZXR1cm4gdGhlIGVuY3J5cHRpb24gYml0IGxv
Y2F0aW9uICovDQo+IC0JbW92bAklZWF4LCBlbmNfYml0KCVlZGkpDQo+ICAJam1wCS5Mc2V2X2V4
aXQNCj4gIA0KPiAgLkxub19zZXY6DQo+ICAJeG9yCSVlYXgsICVlYXgNCj4gLQltb3ZsCSVlYXgs
IGVuY19iaXQoJWVkaSkNCj4gIA0KPiAgLkxzZXZfZXhpdDoNCj4gLQlwb3AJJWVkaQ0KPiAgCXBv
cAklZWR4DQo+ICAJcG9wCSVlY3gNCj4gIAlwb3AJJWVieA0KPiBAQCAtMTEzLDggKzk2LDYgQEAg
RU5UUlkoc2V0X3Nldl9lbmNyeXB0aW9uX21hc2spDQo+ICBFTkRQUk9DKHNldF9zZXZfZW5jcnlw
dGlvbl9tYXNrKQ0KPiAgDQo+ICAJLmRhdGENCj4gLWVuY19iaXQ6DQo+IC0JLmludAkweGZmZmZm
ZmZmDQo+ICANCj4gICNpZmRlZiBDT05GSUdfQU1EX01FTV9FTkNSWVBUDQo+ICAJLmJhbGlnbgk4
DQo+IA0K
