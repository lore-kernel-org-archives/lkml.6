Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31EDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BB02086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="n6Nfnwrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BB02086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbeKTF2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:28:34 -0500
Received: from mail-eopbgr790051.outbound.protection.outlook.com ([40.107.79.51]:19136
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725969AbeKTF2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRfawgeaMVA3uEvQdJNacZ6681JCerXlEUeDn+dxmtw=;
 b=n6NfnwrtofZWGflspxtoW2ncgKHcR0gU3Fd/hBMaFCiuM481JAx7dxaYa+emEwqLhss4Te5X75HK7dVailXBnB2SkRNuJbaJBKTyP3/sdg33lqZ0HqNzSkFwiN8BQtSkkoSb/vKNDh5kTvndDIx8dTFskcxGfG6I1bgId0zlRNE=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB0509.namprd12.prod.outlook.com (10.162.105.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Mon, 19 Nov 2018 19:02:55 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::c8a8:fa09:4724:f102]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::c8a8:fa09:4724:f102%10]) with mapi id 15.20.1339.026; Mon, 19 Nov
 2018 19:02:55 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH] x86/TSC: Use RDTSCP
Thread-Topic: [PATCH] x86/TSC: Use RDTSCP
Thread-Index: AQHUgDgjww2nHNM/gUioDqosgVVqMaVXdIAA
Date:   Mon, 19 Nov 2018 19:02:55 +0000
Message-ID: <dcc20346-bd54-b14a-51fa-6d9de842d5dc@amd.com>
References: <20181119184556.11479-1-bp@alien8.de>
In-Reply-To: <20181119184556.11479-1-bp@alien8.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0801CA0023.namprd08.prod.outlook.com
 (2603:10b6:803:29::33) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0509;20:XYKsXfS0zGenrhu6xwVjBdZC5hSlEbc+gHxkuqDCpkQvywB2406sdZynG+p074wiHDki8L6bEDn9rCnQcZ3Ko5fsVxJm5EXg+RiESEgByt9zeqxr52XZckmzAgqhIeg4vcdKHmLuwT7G8C4W5+EOPB/SVk6mu7vgCPFx+4igXOLTtiUkTt64TT8lufohGkgzrdXHMf/6sB6QtyAXciYq3U5mZmRtIc/Rn5gCkAa0+uFMQ71hSYlUjwOscV26k67m
x-ms-office365-filtering-correlation-id: 109e46dd-f189-41e7-578b-08d64e519cda
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0509;
x-ms-traffictypediagnostic: SN1PR12MB0509:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-microsoft-antispam-prvs: <SN1PR12MB0509F01AD645BBF0EC62D30AECD80@SN1PR12MB0509.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231434)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB0509;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0509;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(346002)(376002)(136003)(199004)(189003)(102836004)(53546011)(52116002)(6246003)(99286004)(386003)(6506007)(26005)(446003)(53936002)(76176011)(11346002)(6512007)(105586002)(72206003)(6436002)(2906002)(478600001)(186003)(106356001)(229853002)(6486002)(86362001)(68736007)(54906003)(81156014)(14454004)(8936002)(81166006)(31686004)(2900100001)(25786009)(8676002)(31696002)(486006)(110136005)(6116002)(3846002)(2616005)(14444005)(71200400001)(476003)(256004)(71190400001)(66066001)(7736002)(4326008)(5660300001)(36756003)(97736004)(316002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0509;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bhkWayi0/ONk0635mk2id32HnUr1hl1NnWziH/Tm0jkspLa0+ZWqEejZpuEtaMZyz5ScjisCNPdVmc6ZhgTfIfK8d1vhkdVnRhRiGTd8nW+P6oIy3stjnsGz39VPFVw0MEfiR+Ws9uTe8n7y8VyrrOsVxOFm6/VGWiWz2KULzciaPwYLdI7LEtPH2LwebzvWvXAqSaRBjen4NG94wFMoncSfhVNmH/nguvnKBzBbuV6snGIV/y3GZaJ1JtdniqPeNsKDK3YlfIlYwZ76WxNMZMnxSoGrhvYQnLl+7lpFjHMTq3cZus32g8qlZ1J+WTP7DCl9UzCGLoXzRt9ULZBeLaS1QHMfqzQ082nH7eSIXRs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <411CEF78609A524CBDF438B6544B4816@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 109e46dd-f189-41e7-578b-08d64e519cda
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 19:02:55.5845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0509
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMTkvMjAxOCAxMjo0NSBQTSwgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiBGcm9tOiBC
b3Jpc2xhdiBQZXRrb3YgPGJwQHN1c2UuZGU+DQo+IA0KPiBDdXJyZW50bHksIHRoZSBrZXJuZWwg
dXNlcw0KPiANCj4gICBbTE1dRkVOQ0U7IFJEVFNDDQo+IA0KPiBpbiB0aGUgdGltZWtlZXBpbmcg
Y29kZSwgdG8gZ3VhcmFudGVlIG1vbm90b25pY2l0eSBvZiB0aW1lIHdoZXJlIHRoZQ0KPiAqRkVO
Q0UgaXMgc2VsZWN0ZWQgYmFzZWQgb24gdmVuZG9yLg0KPiANCj4gUmVwbGFjZSB0aGF0IHNlcXVl
bmNlIHdpdGggUkRUU0NQIHdoaWNoIGlzIGZhc3RlciBvciBvbi1wYXIgYW5kIGdpdmVzDQo+IHRo
ZSBzYW1lIGd1YXJhbnRlZXMuDQo+IA0KPiBBIG1pY3JvYmVuY2htYXJrIG9uIEludGVsIHNob3dz
IHRoYXQgdGhlIGNoYW5nZSBpcyBvbi1wYXIuDQo+IA0KPiBPbiBBTUQsIHRoZSBjaGFuZ2UgaXMg
ZWl0aGVyIG9uLXBhciB3aXRoIHRoZSBjdXJyZW50IExGRU5DRS1wcmVmaXhlZA0KPiBSRFRTQyBh
bmQgc29tZSBhcmUgc2xpZ2h0bHkgYmV0dGVyIHdpdGggUkRUU0NQLg0KPiANCj4gVGhlIGNvbXBh
cmlzb24gaXMgZG9uZSB3aXRoIHRoZSBMRkVOQ0UtcHJlZml4ZWQgUkRUU0MgKGFuZCBub3Qgd2l0
aCB0aGUNCj4gTUZFTkNFLXByZWZpeGVkIG9uZSwgYXMgb25lIHdvdWxkIG5vcm1hbGx5IGV4cGVj
dCkgYmVjYXVzZSBhbGwgbW9kZXJuDQo+IEFNRCBmYW1pbGllcyBtYWtlIExGRU5DRSBzZXJpYWxp
emluZyBhbmQgdGh1cyBhdm9pZCB0aGUgaGVhdnkgTUZFTkNFIGJ5DQo+IGVmZmVjdGl2ZWx5IGVu
YWJsaW5nIFg4Nl9GRUFUVVJFX0xGRU5DRV9SRFRTQy4NCg0KVGhhbmtzIGZvciB0aGlzLiBJIGhh
ZCBiZWVuIHdhbnRpbmcgdG8gZG8gc29tZXRoaW5nIHNpbWlsYXIgc2luY2UsIG9uIEFNRCwNCmEg
Z3Vlc3QgbWF5IG5vdCBzZWUgdGhlIExGRU5DRS1zZXJpYWxpemluZyBiaXQgaWYgdGhlIGh5cGVy
dmlzb3IgZG9lc24ndA0KZXhwb3NlIGl0LCBhbmQgaGF2ZSB0byBmYWxsIGJhY2sgdG8gTUZFTkNF
Lg0KDQpSZXZpZXdlZC1ieTogVG9tIExlbmRhY2t5IDx0aG9tYXMubGVuZGFja3lAYW1kLmNvbT4N
Cg0KPiANCj4gQ28tZGV2ZWxvcGVkLWJ5OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25p
eC5kZT4NCj4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXgu
ZGU+DQo+IFNpZ25lZC1vZmYtYnk6IEJvcmlzbGF2IFBldGtvdiA8YnBAc3VzZS5kZT4NCj4gQ2M6
IEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJuZWwub3JnPg0KPiBDYzogIkguIFBldGVyIEFudmlu
IiA8aHBhQHp5dG9yLmNvbT4NCj4gQ2M6IEpvaG4gU3R1bHR6IDxqb2huLnN0dWx0ekBsaW5hcm8u
b3JnPg0KPiBDYzogVGhvbWFzIExlbmRhY2t5IDxUaG9tYXMuTGVuZGFja3lAYW1kLmNvbT4NCj4g
Q2M6IHg4NkBrZXJuZWwub3JnDQo+IC0tLQ0KPiAgYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLmgg
fCAxNSArKysrKysrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNt
L21zci5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLmgNCj4gaW5kZXggOTFlNGNmMTg5OTE0
Li5mMDBmMmI2MWQzMjYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL21zci5o
DQo+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL21zci5oDQo+IEBAIC0yMTcsNiArMjE3LDgg
QEAgc3RhdGljIF9fYWx3YXlzX2lubGluZSB1bnNpZ25lZCBsb25nIGxvbmcgcmR0c2Modm9pZCkN
Cj4gICAqLw0KPiAgc3RhdGljIF9fYWx3YXlzX2lubGluZSB1bnNpZ25lZCBsb25nIGxvbmcgcmR0
c2Nfb3JkZXJlZCh2b2lkKQ0KPiAgew0KPiArCURFQ0xBUkVfQVJHUyh2YWwsIGxvdywgaGlnaCk7
DQo+ICsNCj4gIAkvKg0KPiAgCSAqIFRoZSBSRFRTQyBpbnN0cnVjdGlvbiBpcyBub3Qgb3JkZXJl
ZCByZWxhdGl2ZSB0byBtZW1vcnkNCj4gIAkgKiBhY2Nlc3MuICBUaGUgSW50ZWwgU0RNIGFuZCB0
aGUgQU1EIEFQTSBhcmUgYm90aCB2YWd1ZSBvbiB0aGlzDQo+IEBAIC0yMjcsOSArMjI5LDE4IEBA
IHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdW5zaWduZWQgbG9uZyBsb25nIHJkdHNjX29yZGVyZWQo
dm9pZCkNCj4gIAkgKiBvcmRlcmluZyBndWFyYW50ZWVzIGFzIHJlYWRpbmcgZnJvbSBhIGdsb2Jh
bCBtZW1vcnkgbG9jYXRpb24NCj4gIAkgKiB0aGF0IHNvbWUgb3RoZXIgaW1hZ2luYXJ5IENQVSBp
cyB1cGRhdGluZyBjb250aW51b3VzbHkgd2l0aCBhDQo+ICAJICogdGltZSBzdGFtcC4NCj4gKwkg
Kg0KPiArCSAqIFRodXMsIHVzZSB0aGUgcHJlZmVycmVkIGJhcnJpZXIgb24gdGhlIHJlc3BlY3Rp
dmUgQ1BVLCBhaW1pbmcgZm9yDQo+ICsJICogUkRUU0NQIGFzIHRoZSBkZWZhdWx0Lg0KPiAgCSAq
Lw0KPiAtCWJhcnJpZXJfbm9zcGVjKCk7DQo+IC0JcmV0dXJuIHJkdHNjKCk7DQo+ICsJYXNtIHZv
bGF0aWxlKEFMVEVSTkFUSVZFXzIoIm1mZW5jZTsgcmR0c2MiLA0KPiArCQkJCSAgICJsZmVuY2U7
IHJkdHNjIiwgWDg2X0ZFQVRVUkVfTEZFTkNFX1JEVFNDLA0KPiArCQkJCSAgICJyZHRzY3AiLCBY
ODZfRkVBVFVSRV9SRFRTQ1ApDQo+ICsJCQk6IEVBWF9FRFhfUkVUKHZhbCwgbG93LCBoaWdoKQ0K
PiArCQkJLyogUkRUU0NQIGNsb2JiZXJzIEVDWCB3aXRoIE1TUl9UU0NfQVVYLiAqLw0KPiArCQkJ
OjogImVjeCIpOw0KPiArDQo+ICsJcmV0dXJuIEVBWF9FRFhfVkFMKHZhbCwgbG93LCBoaWdoKTsN
Cj4gIH0NCj4gIA0KPiAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIGxvbmcgbmF0aXZlX3Jl
YWRfcG1jKGludCBjb3VudGVyKQ0KPiANCg==
