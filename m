Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2CAC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C0A20676
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eadXCeYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C0A20676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbeIYUlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:41:40 -0400
Received: from mail-eopbgr720082.outbound.protection.outlook.com ([40.107.72.82]:15869
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729188AbeIYUlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6saDCFAJkDNxTDan2fAo1xWlx8HmvSZFXz8t7qXmh0=;
 b=eadXCeYh81q5CZH9IyL7Bzocy4+oJIBBahhv8XkRO8GiO2cDRAPhabKNm9GntfnHoDCCjTWNy/rde0xt0tT0xvJwHTgmVxtOUQWzAoVdbWfrv0zASzgbFmmcGA0FhB82KjrfzuR2VbS7PlJLWH1uIg4j6hdchaaFY4JVBG5SKqk=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB0205.namprd12.prod.outlook.com (10.162.3.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.20; Tue, 25 Sep 2018 14:33:48 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::2d1b:5638:5680:80e7]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::2d1b:5638:5680:80e7%5]) with mapi id 15.20.1143.022; Tue, 25 Sep 2018
 14:33:48 +0000
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
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] x86/boot: Fix kexec booting failure after SEV early boot
 support
Thread-Topic: [PATCH] x86/boot: Fix kexec booting failure after SEV early boot
 support
Thread-Index: AQHUVMCt5d5bmoFMGEWPE1C0OEtwMKUBEAQA
Date:   Tue, 25 Sep 2018 14:33:48 +0000
Message-ID: <6e15796e-31e9-2dc6-4a31-5c1b01554b45@amd.com>
References: <20180925111020.23834-1-kasong@redhat.com>
In-Reply-To: <20180925111020.23834-1-kasong@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR04CA0076.namprd04.prod.outlook.com
 (2603:10b6:910:4f::41) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0205;20:DDcpT28A3nMMTyONDW5RklduoHSoYYLd+sDWw7sH0IPiHAUXmIJYrUv8TeZHA+fpGknlL3d3mYN0Ava/REtMtDciE8wyq8H0QV7Y8GbWwrUmNftfIyxmtb41qz/lPuZUAOIhqUnSIVS54AL2aFhwiESa3PHAhPqX0CdS3J/36lfEIg96UXwk/A4g/wLsJuNwhU2m6IUijoYP6zkNMdOApXmTucRKREc7RxoY+WDmJbMhuOR24OWoe5xIbQTlDGuP
x-ms-office365-filtering-correlation-id: 119637ae-8156-4d54-cbb0-08d622f3e76e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0205;
x-ms-traffictypediagnostic: SN1PR12MB0205:
x-microsoft-antispam-prvs: <SN1PR12MB0205A0B65E333583CAD8DDCDEC160@SN1PR12MB0205.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:SN1PR12MB0205;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0205;
x-forefront-prvs: 08062C429B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(376002)(136003)(199004)(189003)(5250100002)(52116002)(5660300001)(97736004)(2501003)(3846002)(6116002)(53546011)(110136005)(6506007)(2900100001)(14444005)(14454004)(256004)(386003)(76176011)(54906003)(6436002)(305945005)(71190400001)(71200400001)(34290500001)(7736002)(36756003)(229853002)(2906002)(72206003)(99286004)(68736007)(11346002)(8676002)(2616005)(81166006)(81156014)(31686004)(446003)(53936002)(486006)(106356001)(6486002)(86362001)(186003)(478600001)(31696002)(476003)(26005)(6512007)(8936002)(25786009)(105586002)(4326008)(316002)(66066001)(6246003)(102836004)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0205;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6yCZLRZNjf+YqPNK5acVbzEEXvyTyv4WRyofj04E7qkF8/iR4Na1YkxaeGuvh8amj9rPtlNBEnL+4BUvG1gjGP69NgsTK4938flR8tMgyAoZ9Duh2QC63xtp401jd2u360/I/Cs3Irs6Lsfr0r9zWavLSEdiCEOHXjXtcQPbGUAq+328F6qk7cRmApKD9oYsS3TlFpyB+GMJeSBBsQ4FcQpLBHE5qrKKuwuAr0I6iUP86/jq6gR8bQqmO8qfIdPpvxWUg40Hmy2xTkwGyoK9xrpeUucvzpHxmUJN4/5NqVInRzTvvBEGaBzkT7bN7D1MPb/VeIET3mHCM9akJO+gPSVsJVikNEZHGttfJMCCZaA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF965B29EA876340B16CB7BC6D31989D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 119637ae-8156-4d54-cbb0-08d622f3e76e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2018 14:33:48.1574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMjUvMjAxOCAwNjoxMCBBTSwgS2FpcnVpIFNvbmcgd3JvdGU6DQo+IENvbW1pdCAxOTU4
YjVmYzQwMTAgKCJ4ODYvYm9vdDogQWRkIGVhcmx5IGJvb3Qgc3VwcG9ydCB3aGVuIHJ1bm5pbmcN
Cj4gd2l0aCBTRVYgYWN0aXZlIikgaXMgY2F1c2luZyBrZXhlYyBiZWNvbWVzIHNvbWV0aW1lcyB1
bnN0YWJsZSwga2V4ZWMNCj4gcmVib290IHdvbid0IHN0YXJ0IGEgc2Vjb25kIGtlcm5lbCBieXBh
c3NpbmcgQklPUyBib290IHByb2Nlc3MsIGluc3RlYWQsDQo+IHRoZSBzeXN0ZW0gZ290IHJlc2V0
Lg0KPiANCj4gVGhhdCdzIGJlY2F1c2UsIGluIGdldF9zZXZfZW5jcnlwdGlvbl9iaXQgZnVuY3Rp
b24sIHdlIGFyZSB1c2luZw0KPiAzMi1iaXQgUklQLXJlbGF0aXZlIGFkZHJlc3NpbmcgdG8gcmVh
ZCB0aGUgdmFsdWUgb2YgZW5jX2JpdCwgYnV0DQo+IGtleGVjIG1heSBhbGxvYyB0aGUgZWFybHkg
Ym9vdCB1cCBjb2RlIHRvIGEgaGlnaGVyIGxvY2F0aW9uLCB3aGljaA0KPiBpcyBiZXlvbmQgMzIt
Yml0IGFkZHJlc3NpbmcgbGltaXQuIFNvbWUgZ2FyYmFnZSB3aWxsIGJlIHJlYWQgYW5kDQo+IGdl
dF9zZXZfZW5jcnlwdGlvbl9iaXQgd2lsbCByZXR1cm4gdGhlIHdyb25nIHZhbHVlLCB3aGljaCBs
ZWFkIHRvDQo+IHdyb25nIG1lbW9yeSBwYWdlIGZsYWcuDQo+IA0KPiBUaGlzIHBhdGNoIGFkZHMg
YSBnZXRfc2V2X2VuY3J5cHRpb25fYml0XzY0IGZ1bmN0aW9uIHRvIGF2b2lkIHRoaXMNCj4gcHJv
YmxlbS4gNjQtYml0IGVhcmx5IGJvb3QgY29kZSB3aWxsIHVzZSB0aGlzIGZ1bmN0aW9uIGluc3Rl
YWQsIGl0DQo+IHVzZXMgbmF0aXZlIFJJUCBhZGRyZXNzaW5nIHRvIHJlYWQgdGhlIGVuY19iaXQg
d2hpY2ggaGF2ZSBubyBwcm9ibGVtDQo+IHdpdGggYW55IGxvY2F0aW9uLg0KPiANCj4gRml4ZXM6
IDE5NThiNWZjNDAxMCAoIng4Ni9ib290OiBBZGQgZWFybHkgYm9vdCBzdXBwb3J0IHdoZW4gcnVu
bmluZyB3aXRoIFNFViBhY3RpdmUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBLYWlydWkgU29uZyA8a2Fz
b25nQHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBUb20gTGVuZGFja3kgPHRob21hcy5sZW5k
YWNreUBhbWQuY29tPg0KDQo+IC0tLQ0KPiAgYXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL21lbV9l
bmNyeXB0LlMgfCA2NCArKysrKysrKysrKysrKysrKystLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDQ1IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9tZW1fZW5jcnlwdC5TIGIvYXJjaC94ODYvYm9vdC9j
b21wcmVzc2VkL21lbV9lbmNyeXB0LlMNCj4gaW5kZXggZWFhODQzYTUyOTA3Li40MTkzMzU1MDQ0
OWEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9tZW1fZW5jcnlwdC5T
DQo+ICsrKyBiL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9tZW1fZW5jcnlwdC5TDQo+IEBAIC0x
OCwyNyArMTgsMTMgQEANCj4gIA0KPiAgCS50ZXh0DQo+ICAJLmNvZGUzMg0KPiAtRU5UUlkoZ2V0
X3Nldl9lbmNyeXB0aW9uX2JpdCkNCj4gK2RvX2dldF9zZXZfZW5jcnlwdGlvbl9iaXQ6DQo+ICAJ
eG9yCSVlYXgsICVlYXgNCj4gIA0KPiAgI2lmZGVmIENPTkZJR19BTURfTUVNX0VOQ1JZUFQNCj4g
IAlwdXNoCSVlYngNCj4gIAlwdXNoCSVlY3gNCj4gIAlwdXNoCSVlZHgNCj4gLQlwdXNoCSVlZGkN
Cj4gLQ0KPiAtCS8qDQo+IC0JICogUklQLXJlbGF0aXZlIGFkZHJlc3NpbmcgaXMgbmVlZGVkIHRv
IGFjY2VzcyB0aGUgZW5jcnlwdGlvbiBiaXQNCj4gLQkgKiB2YXJpYWJsZS4gU2luY2Ugd2UgYXJl
IHJ1bm5pbmcgaW4gMzItYml0IG1vZGUgd2UgbmVlZCB0aGlzIGNhbGwvcG9wDQo+IC0JICogc2Vx
dWVuY2UgdG8gZ2V0IHRoZSBwcm9wZXIgcmVsYXRpdmUgYWRkcmVzc2luZy4NCj4gLQkgKi8NCj4g
LQljYWxsCTFmDQo+IC0xOglwb3BsCSVlZGkNCj4gLQlzdWJsCSQxYiwgJWVkaQ0KPiAtDQo+IC0J
bW92bAllbmNfYml0KCVlZGkpLCAlZWF4DQo+IC0JY21wbAkkMCwgJWVheA0KPiAtCWpnZQkuTHNl
dl9leGl0DQo+ICANCj4gIAkvKiBDaGVjayBpZiBydW5uaW5nIHVuZGVyIGEgaHlwZXJ2aXNvciAq
Lw0KPiAgCW1vdmwJJDEsICVlYXgNCj4gQEAgLTY5LDI1ICs1NSw2NSBAQCBFTlRSWShnZXRfc2V2
X2VuY3J5cHRpb25fYml0KQ0KPiAgDQo+ICAJbW92bAklZWJ4LCAlZWF4DQo+ICAJYW5kbAkkMHgz
ZiwgJWVheAkJLyogUmV0dXJuIHRoZSBlbmNyeXB0aW9uIGJpdCBsb2NhdGlvbiAqLw0KPiAtCW1v
dmwJJWVheCwgZW5jX2JpdCglZWRpKQ0KPiAgCWptcAkuTHNldl9leGl0DQo+ICANCj4gIC5Mbm9f
c2V2Og0KPiAgCXhvcgklZWF4LCAlZWF4DQo+IC0JbW92bAklZWF4LCBlbmNfYml0KCVlZGkpDQo+
ICANCj4gIC5Mc2V2X2V4aXQ6DQo+IC0JcG9wCSVlZGkNCj4gIAlwb3AJJWVkeA0KPiAgCXBvcAkl
ZWN4DQo+ICAJcG9wCSVlYngNCj4gIA0KPiArI2VuZGlmCS8qIENPTkZJR19BTURfTUVNX0VOQ1JZ
UFQgKi8NCj4gKw0KPiArCXJldA0KPiArDQo+ICtFTlRSWShnZXRfc2V2X2VuY3J5cHRpb25fYml0
KQ0KPiArCXhvcgklZWF4LCAlZWF4DQo+ICsNCj4gKyNpZmRlZiBDT05GSUdfQU1EX01FTV9FTkNS
WVBUDQo+ICsJcHVzaAklZWRpDQo+ICsNCj4gKwkvKg0KPiArCSAqIFJJUC1yZWxhdGl2ZSBhZGRy
ZXNzaW5nIGlzIG5lZWRlZCB0byBhY2Nlc3MgdGhlIGVuY3J5cHRpb24gYml0DQo+ICsJICogdmFy
aWFibGUuIFNpbmNlIHdlIGFyZSBydW5uaW5nIGluIDMyLWJpdCBtb2RlIHdlIG5lZWQgdGhpcyBj
YWxsL3BvcA0KPiArCSAqIHNlcXVlbmNlIHRvIGdldCB0aGUgcHJvcGVyIHJlbGF0aXZlIGFkZHJl
c3NpbmcuDQo+ICsJICovDQo+ICsJY2FsbAkxZg0KPiArMToJcG9wbAklZWRpDQo+ICsJc3VibAkk
MWIsICVlZGkNCj4gKw0KPiArCW1vdmwJZW5jX2JpdCglZWRpKSwgJWVheA0KPiArCWNtcGwJJDAs
ICVlYXgNCj4gKwlqZ2UgMmYNCj4gKw0KPiArCWNhbGwgICAgZG9fZ2V0X3Nldl9lbmNyeXB0aW9u
X2JpdA0KPiArCW1vdmwJJWVheCwgZW5jX2JpdCglZWRpKQ0KPiArMjoNCj4gKwlwb3AJJWVkaQ0K
PiAgI2VuZGlmCS8qIENPTkZJR19BTURfTUVNX0VOQ1JZUFQgKi8NCj4gIA0KPiAgCXJldA0KPiAg
RU5EUFJPQyhnZXRfc2V2X2VuY3J5cHRpb25fYml0KQ0KPiAgDQo+ICAJLmNvZGU2NA0KPiArRU5U
UlkoZ2V0X3Nldl9lbmNyeXB0aW9uX2JpdF82NCkNCj4gKwl4b3IJJXJheCwgJXJheA0KPiArDQo+
ICsjaWZkZWYgQ09ORklHX0FNRF9NRU1fRU5DUllQVA0KPiArCW1vdmwJZW5jX2JpdCglcmlwKSwg
JWVheA0KPiArCWNtcGwJJDAsICVlYXgNCj4gKwlqZ2UgMWYNCj4gKw0KPiArCWNhbGwgICAgZG9f
Z2V0X3Nldl9lbmNyeXB0aW9uX2JpdA0KPiArCW1vdmwJJWVheCwgZW5jX2JpdCglcmlwKQ0KPiAr
MToNCj4gKyNlbmRpZgkvKiBDT05GSUdfQU1EX01FTV9FTkNSWVBUICovDQo+ICsNCj4gKwlyZXQN
Cj4gK0VORFBST0MoZ2V0X3Nldl9lbmNyeXB0aW9uX2JpdF82NCkNCj4gKw0KPiAgRU5UUlkoc2V0
X3Nldl9lbmNyeXB0aW9uX21hc2spDQo+ICAjaWZkZWYgQ09ORklHX0FNRF9NRU1fRU5DUllQVA0K
PiAgCXB1c2gJJXJicA0KPiBAQCAtOTUsNyArMTIxLDcgQEAgRU5UUlkoc2V0X3Nldl9lbmNyeXB0
aW9uX21hc2spDQo+ICANCj4gIAltb3ZxCSVyc3AsICVyYnAJCS8qIFNhdmUgY3VycmVudCBzdGFj
ayBwb2ludGVyICovDQo+ICANCj4gLQljYWxsCWdldF9zZXZfZW5jcnlwdGlvbl9iaXQJLyogR2V0
IHRoZSBlbmNyeXB0aW9uIGJpdCBwb3NpdGlvbiAqLw0KPiArCWNhbGwJZ2V0X3Nldl9lbmNyeXB0
aW9uX2JpdF82NAkvKiBHZXQgdGhlIGVuY3J5cHRpb24gYml0IHBvc2l0aW9uICovDQo+ICAJdGVz
dGwJJWVheCwgJWVheA0KPiAgCWp6CS5Mbm9fc2V2X21hc2sNCj4gIA0KPiANCg==
