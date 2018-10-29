Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7221C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF6D20657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="GHGxluZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF6D20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbeJ3ATp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:19:45 -0400
Received: from mail-ve1eur01on0137.outbound.protection.outlook.com ([104.47.1.137]:27888
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727041AbeJ3ATo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U99Lp6ftonhZ1GGhWtc2lmYjxDq6E/1M7HXps04gpFA=;
 b=GHGxluZ48WFNwokuhq94tx6S6eVhQHZfhfbNKxynhnVk6ha9W1Z7Xvfo3C6UMufVwRGbq7aTxMBvVp/AgucNq2kNv0j6sshgEJZ1LBojewzZYcwZEcC5bi2YN4HRIyH4/PpAdmWye3g40pPLe6XmF+N5p3dc5M5QKIQtCnoWlYU=
Received: from HE1PR0702MB3756.eurprd07.prod.outlook.com (52.133.7.10) by
 HE1PR0702MB3801.eurprd07.prod.outlook.com (52.133.7.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.15; Mon, 29 Oct 2018 15:30:33 +0000
Received: from HE1PR0702MB3756.eurprd07.prod.outlook.com
 ([fe80::4c9:7fe3:973e:77ed]) by HE1PR0702MB3756.eurprd07.prod.outlook.com
 ([fe80::4c9:7fe3:973e:77ed%4]) with mapi id 15.20.1294.018; Mon, 29 Oct 2018
 15:30:33 +0000
From:   "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "tony@atomide.com" <tony@atomide.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "jrdr.linux@gmail.com" <jrdr.linux@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm: mm: fault: check ADFSR in case of abort
Thread-Topic: [PATCH] arm: mm: fault: check ADFSR in case of abort
Thread-Index: AdRvkeVP3Te0gsIRSvm4gC5lSIqMigABQ1+AAAA0WTA=
Date:   Mon, 29 Oct 2018 15:30:33 +0000
Message-ID: <HE1PR0702MB3756B5B38F45A354717B2F45FAF30@HE1PR0702MB3756.eurprd07.prod.outlook.com>
References: <HE1PR0702MB37567D530C1C1D45949C164BFAF30@HE1PR0702MB3756.eurprd07.prod.outlook.com>
 <d9195ffb-f766-363e-21f3-e3737526c7de@arm.com>
In-Reply-To: <d9195ffb-f766-363e-21f3-e3737526c7de@arm.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.32.178]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0702MB3801;6:PHdsZNlU1Fepr7GQh0aQVoa38l0lVA1vxMvEZmSEqs4hYa28sk1btJXSjlRDFHqBWtq3Vl3HO92b0CssAr71QuWZuGYBEwRXpBSeZbtkWAMY2eRvPhTnsM5EfzfeaOH3/X6pKyVcuaQnACnbh+8Ow+CRes16utATY1R80O/zWMB6WF1ck3mTMvm9wMM6Kqf48aTcvGPnqgESXzX9rOvdmz9eUNiMCRz9hGfUlfexTmjfVgiAA7SSz9gXtFiX2XB3q/Fpc/p0F1xxEwmrJHd6iFZyEH8kDVzlcOTts1buMxPWj35FgQPqGvFLjMgPilWRG9j12j6G5LAHHFkRg2eXrkIpoEO8OrkWvMOkyp9Jro1UPcxDT2m6397cMFLag7Cp7cab2QIgaawEQ//paQ5m+5k/qwpsvvA8mdOOOw5DdJmqvIwP9z3lNfaByLF8zkVml318FUweKES/vBKMGLq5Mw==;5:LSFOcRzXSbS8+OulH18G9dkRNglE1OspBvvVTdfVosb6ETRVvW71bjGCVR//C/E6+indUrJCWmqt0MBQFqzdJPNxWnAtPxSggqVjxxfBvbY6kPofWJJ5QnzzAdVFjobJ/eqs6hk4irRlvz+sYPKTez/pyxopyXyeNFUZgD019E4=;7:MuZYaT3AVo2vQg7TsH+N1tDHMcKSNT5sv0Y3EpdPi9JVqBOXyCA+D9xeoFj6DMnCzTxwFrzscy7RAh3+wA36EJvQBxVGo7CjOl+J2nZtES+pIhL6qgnDd0XNwck90kPaaDDsLPZry7RrNuNND84tqw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 12591f98-448f-415a-5eb2-08d63db3777f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HE1PR0702MB3801;
x-ms-traffictypediagnostic: HE1PR0702MB3801:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wladislav.wiebe@nokia.com; 
x-microsoft-antispam-prvs: <HE1PR0702MB3801BA5D282E92C796FCFCB0FAF30@HE1PR0702MB3801.eurprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(195916259791689)(109105607167333)(82608151540597);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231382)(11241501184)(806099)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:HE1PR0702MB3801;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0702MB3801;
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(396003)(376002)(366004)(189003)(13464003)(199004)(186003)(74316002)(7736002)(305945005)(86362001)(8676002)(25786009)(26005)(81156014)(81166006)(102836004)(2900100001)(6506007)(106356001)(4326008)(110136005)(256004)(68736007)(229853002)(316002)(8936002)(105586002)(486006)(11346002)(446003)(476003)(478600001)(53546011)(9686003)(66066001)(33656002)(55016002)(14454004)(53936002)(76176011)(7696005)(39060400002)(6436002)(5250100002)(2501003)(71190400001)(71200400001)(3846002)(6116002)(99286004)(5660300001)(2201001)(97736004)(6246003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3801;H:HE1PR0702MB3756.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gJlyARmAhc47T6VQWCi2JnZQpqibJ5dhZ+2/MtyoPASSAEHukHTB7bKJ0IQnPJ2lIoZ+ehY+e5JQSol9xlj7dfDmwC79qxDMCrZb1w+QVdsgN2gaaekmz4QZPLc1XaPHZCtYYHT+Fa9P+faE8fMTPrsMYVA2zDlyFn/Af5ojrcCM5wlgm7jAYQh7iLMeYPpBE8Ny7x3QVXIEhP+FnapUZI5Iq3mJ0/k6LbFFTwT5ahiRWORHpTjrrSQhjgABzj5lgJrUbHPt4thHl/2BGRC9ZqZh5ZViMjSBnNfjsvLKMT7Vd4O1XIJHGmcOwfgxbXzAQb7SSEijQC2nOZEU02QtSr956v4/yqjJa27Sthi2Wh5qqHVJNnBch9ZfhODRa0vsCBO7kp7M1GDARujqK3CHRA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12591f98-448f-415a-5eb2-08d63db3777f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 15:30:33.1217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3801
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iaW4sIFJ1c3NlbCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiBTZW50OiBNb25kYXksIE9j
dG9iZXIgMjksIDIwMTggMzo1MiBQTQ0KWy4uXQ0KPiBPbiAyOS8xMC8yMDE4IDE0OjIwLCBXaWVi
ZSwgV2xhZGlzbGF2IChOb2tpYSAtIERFL1VsbSkgd3JvdGU6DQo+ID4gV2hlbiBydW5uaW5nIGlu
dG8gc2l0dWF0aW9ucyBsaWtlOg0KPiA+ICJVbmhhbmRsZWQgZmF1bHQ6IHN5bmNocm9ub3VzIGV4
dGVybmFsIGFib3J0ICgweDIxMCkgYXQgMHhYWFgiDQo+ID4gb3INCj4gPiAiVW5oYW5kbGVkIHBy
ZWZldGNoIGFib3J0OiBzeW5jaHJvbm91cyBleHRlcm5hbCBhYm9ydCAoMHgyMTApIGF0IDB4WFhY
Ig0KPiA+IGl0IGlzIHVzZWZ1bCB0byBrbm93IHRoZSBjb250ZW50IG9mIEFERlNSIChBdXhpbGlh
cnkgRGF0YSBGYXVsdCBTdGF0dXMNCj4gPiBSZWdpc3RlcikgdG8gaW5kaWNhdGUgYW4gRUNDIGRv
dWJsZS1iaXQgZXJyb3IgaW4gTDEgb3IgTDIgY2FjaGUuDQo+ID4NCj4gPiBSZWZlciB0bzoNCj4g
PiBDb3J0ZXgtQTE1IFRlY2huaWNhbCBSZWZlcmVuY2UgTWFudWFsLCBSZXZpc2lvbjogcjJwMSBb
Ni40LjguIEVycm9yDQo+ID4gQ29ycmVjdGlvbiBDb2RlXQ0KPiANCj4gVGhlIGNvbnRlbnRzIG9m
IEFERlNSIGFyZSBpbXBsZW1lbnRhdGlvbi1kZWZpbmVkLCB0aG91Z2gsIHNvIHRoaXMNCj4gaW50
ZXJwcmV0YXRpb24gaXMgKm9ubHkqIHZhbGlkIG9uIENvcnRleC1BMTUuIE90aGVyIHByb2Nlc3Nv
cnMgbWF5IHVzZSB0aG9zZQ0KPiBiaXQgcG9zaXRpb25zIHRvIHJlcG9ydCBzb21ldGhpbmcgZWxz
ZSwgYXQgd2hpY2ggcG9pbnQgcHJpbnRpbmcgYSBtZXNzYWdlDQo+IGFib3V0IEVDQyBlcnJvcnMg
d291bGQgYmUgdG90YWxseSBtaXNsZWFkaW5nLg0KDQpHb29kIHBvaW50LCBJIHRob3VnaHQgaW5p
dGlhbGx5IGl0IGlzIHZhbGlkIGZvciBvdGhlcnMgYXMgd2VsbC4NCg0KRG8geW91IHRoaW5rIHdl
IGNhbiBnbyB3aXRoIHRoaXMgYXBwcm9hY2g6DQoJaWYgKHJlYWRfY3B1aWRfcGFydCgpID09IEFS
TV9DUFVfUEFSVF9DT1JURVhfQTE1KSB7DQoJCWFzbSgibXJjIHAxNSwgMCwgJTAsIGM1LCBjMSwg
MCIgOiAiPXIiIChhZGZzcikpOw0KCQl4eHh4DQoJfQ0KDQo/DQpUaGFua3MgYSBsb3QgZm9yIHRo
ZSBmYXN0IGZlZWRiYWNrIQ0KDQotIFdsYWRpc2xhdg0KDQo+IA0KPiBSb2Jpbi4NCj4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogV2xhZGlzbGF2IFdpZWJlIDx3bGFkaXNsYXYud2llYmVAbm9raWEuY29t
Pg0KPiA+IC0tLQ0KPiA+ICAgYXJjaC9hcm0vbW0vZmF1bHQuYyB8IDE4ICsrKysrKysrKysrKysr
KysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybS9tbS9mYXVsdC5jIGIvYXJjaC9hcm0vbW0vZmF1bHQuYyBpbmRl
eA0KPiA+IDMyMzJhZmI2ZmRjMC4uNWUyNDBkZWI2ZWQ2IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gv
YXJtL21tL2ZhdWx0LmMNCj4gPiArKysgYi9hcmNoL2FybS9tbS9mYXVsdC5jDQo+ID4gQEAgLTU0
Nyw2ICs1NDcsMjIgQEAgaG9va19mYXVsdF9jb2RlKGludCBuciwgaW50ICgqZm4pKHVuc2lnbmVk
IGxvbmcsDQo+IHVuc2lnbmVkIGludCwgc3RydWN0IHB0X3JlZ3MgKikNCj4gPiAgIAlmc3JfaW5m
b1tucl0ubmFtZSA9IG5hbWU7DQo+ID4gICB9DQo+ID4NCj4gPiArLyoNCj4gPiArICogQ2hlY2sg
Zm9yIEVDQyBkb3VibGUtYml0IGVycm9ycyBpbiBBdXhpbGlhcnkgRGF0YSBGYXVsdCBTdGF0dXMN
Cj4gPiArUmVnaXN0ZXIgICovIHN0YXRpYyB2b2lkIGNoZWNrX2FkZnNyX2Zvcl9lY2Modm9pZCkg
ew0KPiA+ICsJdTMyIGFkZnNyID0gMDsNCj4gPiArDQo+ID4gKwlhc20oIm1yYyBwMTUsIDAsICUw
LCBjNSwgYzEsIDAiIDogIj1yIiAoYWRmc3IpKTsNCj4gPiArDQo+ID4gKwlpZiAoYWRmc3IgJiAo
QklUKDMxKSB8IEJJVCgyMykpKSB7DQo+ID4gKwkJcHJfYWxlcnQoIkFERlNSIHN0YXR1cyAweCV4
IGluZGljYXRlcyB0aGF0IGFuIEwxIG9yIEwyDQo+IGNhY2hlXG4iDQo+ID4gKwkJCSAiRUNDIGRv
dWJsZS1iaXQgZXJyb3Igb2NjdXJyZWQgYXQgc29tZSB0aW1lLlxuIiwNCj4gPiArCQkJICBhZGZz
cik7DQo+ID4gKwl9DQo+ID4gK30NCj4gPiArDQo+ID4gICAvKg0KPiA+ICAgICogRGlzcGF0Y2gg
YSBkYXRhIGFib3J0IHRvIHRoZSByZWxldmFudCBoYW5kbGVyLg0KPiA+ICAgICovDQo+ID4gQEAg
LTU1OSw2ICs1NzUsNyBAQCBkb19EYXRhQWJvcnQodW5zaWduZWQgbG9uZyBhZGRyLCB1bnNpZ25l
ZCBpbnQgZnNyLA0KPiBzdHJ1Y3QgcHRfcmVncyAqcmVncykNCj4gPiAgIAlpZiAoIWluZi0+Zm4o
YWRkciwgZnNyICYgfkZTUl9MTlhfUEYsIHJlZ3MpKQ0KPiA+ICAgCQlyZXR1cm47DQo+ID4NCj4g
PiArCWNoZWNrX2FkZnNyX2Zvcl9lY2MoKTsNCj4gPiAgIAlwcl9hbGVydCgiVW5oYW5kbGVkIGZh
dWx0OiAlcyAoMHglMDN4KSBhdCAweCUwOGx4XG4iLA0KPiA+ICAgCQlpbmYtPm5hbWUsIGZzciwg
YWRkcik7DQo+ID4gICAJc2hvd19wdGUoY3VycmVudC0+bW0sIGFkZHIpOw0KPiA+IEBAIC01OTMs
NiArNjEwLDcgQEAgZG9fUHJlZmV0Y2hBYm9ydCh1bnNpZ25lZCBsb25nIGFkZHIsIHVuc2lnbmVk
IGludA0KPiBpZnNyLCBzdHJ1Y3QgcHRfcmVncyAqcmVncykNCj4gPiAgIAlpZiAoIWluZi0+Zm4o
YWRkciwgaWZzciB8IEZTUl9MTlhfUEYsIHJlZ3MpKQ0KPiA+ICAgCQlyZXR1cm47DQo+ID4NCj4g
PiArCWNoZWNrX2FkZnNyX2Zvcl9lY2MoKTsNCj4gPiAgIAlwcl9hbGVydCgiVW5oYW5kbGVkIHBy
ZWZldGNoIGFib3J0OiAlcyAoMHglMDN4KSBhdCAweCUwOGx4XG4iLA0KPiA+ICAgCQlpbmYtPm5h
bWUsIGlmc3IsIGFkZHIpOw0KPiA+DQo+ID4NCg==
