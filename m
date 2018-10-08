Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006C8C6787D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 01:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF432086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 01:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2PCb6/N/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF432086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeJHIew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 04:34:52 -0400
Received: from mail-eopbgr690062.outbound.protection.outlook.com ([40.107.69.62]:62136
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726445AbeJHIew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 04:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qidqsxXjWEX+bnO1M0AmfSm45D3QEoe24gqh4qHiibE=;
 b=2PCb6/N/QSYLn8QtmBNHSpbQRBtoPRSwHF5JGMCkqqIDZw2aTU77uN6hCD2NzJeLW6Xb1COlsgZBx79S4vAOJoAGMr1hVTPxQHqOjMa+cUhqiK5YmvD4UOZNvEjA7eHvnlCRUwtCq/sh57Effdh0RNSBh0Izxcsv+GuI0hRceRo=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1178.namprd12.prod.outlook.com (10.168.236.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.23; Mon, 8 Oct 2018 01:25:36 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%2]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 01:25:36 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "luto@kernel.org" <luto@kernel.org>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "jannh@google.com" <jannh@google.com>,
        "dima@arista.com" <dima@arista.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 10/11] arch/x86: Add AMD feature bit X86_FEATURE_MBA in
 cpuid bits array
Thread-Topic: [PATCH v2 10/11] arch/x86: Add AMD feature bit X86_FEATURE_MBA
 in cpuid bits array
Thread-Index: AQHUXO3XVg8FNh2kP0quKwJeL3SsAqURK50AgANl/VA=
Date:   Mon, 8 Oct 2018 01:25:36 +0000
Message-ID: <DM5PR12MB247180925D3E9D4C2A8E04D795E60@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <20181005205512.29545-1-babu.moger@amd.com>
 <20181005205512.29545-11-babu.moger@amd.com> <20181005213112.GG10285@zn.tnic>
In-Reply-To: <20181005213112.GG10285@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-originating-ip: [::]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1178;20:1wwn7NLpHdTkxeQtIkRs6MGvigRiYRcvkteYWErQM5chTDKiJHlKTuwmfkvOf137Lb+0oUjR8j0ia2nBjRghVjOoiyFYwilusoyS5LyYpgdydVbYS2UUqdJGVTECxHcdybE/oQvL5uTx+hh09hVnlK3hGf0zFN4ccEfUKPURXJe7B7IVMu1lbUs5cFM1x0aPC1Aj1tNUTmNyPkWNTv5r6j9sE5epfs1o5QDKPI4NFTBX8exdI1S2RfA5qSr/c4g8
x-ms-office365-filtering-correlation-id: 0d806908-935f-4164-eba9-08d62cbcf31d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1178;
x-ms-traffictypediagnostic: DM5PR12MB1178:
x-microsoft-antispam-prvs: <DM5PR12MB1178169C4EE9388F7AA54AC795E60@DM5PR12MB1178.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(180628864354917)(198206253151910)(146755900322472)(211936372134217)(9452136761055)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051);SRVR:DM5PR12MB1178;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1178;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(366004)(346002)(39860400002)(13464003)(199004)(189003)(74316002)(316002)(53936002)(81166006)(81156014)(8676002)(76176011)(2906002)(55016002)(33656002)(106356001)(105586002)(7736002)(305945005)(9686003)(478600001)(6116002)(72206003)(7696005)(7416002)(6246003)(71190400001)(14444005)(71200400001)(256004)(14454004)(229853002)(476003)(25786009)(5250100002)(2900100001)(186003)(6916009)(53546011)(11346002)(446003)(6506007)(99286004)(4326008)(54906003)(102836004)(97736004)(6436002)(8936002)(5660300001)(486006)(68736007)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1178;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bKOqumc09dOeepbnXkEiOIVxtjVtEiste5GrRKN4T66k4SZ4PN6YQuoYMYRKRQWmGVvkWSiqlgK6zbjIL/s8iP2Os2M6D0hUzncJEB3+ghybM/ocEV4c2TP6UVMryBIv1zUcrxzgwM4l/roxUVhunMZUcOZaUPCmnneKjc65WxSJ6FZhEwlwPWeFvWFZu6f8okIRiClW/ThVTTMMJY7oBqWjXuQ0HmHEmR6XXUn6yZo3CU9K0jBWn8H+NF2aaD35ux6G18DYFV6ER+to88fTxS36Y+TRfvHm0Lozye9Q5w7MBxJ6tG99l5w1+e/kw4tMIkS+Xvaxo7AYcD640OUL46NyIkRyF4WJoH5wWcBYdfI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d806908-935f-4164-eba9-08d62cbcf31d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 01:25:36.2708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXNsYXYgUGV0a292
IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciA1LCAyMDE4IDQ6MzEgUE0N
Cj4gVG86IE1vZ2VyLCBCYWJ1IDxCYWJ1Lk1vZ2VyQGFtZC5jb20+DQo+IENjOiB0Z2x4QGxpbnV0
cm9uaXguZGU7IG1pbmdvQHJlZGhhdC5jb207IGhwYUB6eXRvci5jb207DQo+IHJlaW5ldHRlLmNo
YXRyZUBpbnRlbC5jb207IGZlbmdodWEueXVAaW50ZWwuY29tOyBqYW1lcy5tb3JzZUBhcm0uY29t
Ow0KPiB2aWthcy5zaGl2YXBwYUBsaW51eC5pbnRlbC5jb207IHRvbnkubHVja0BpbnRlbC5jb207
IHg4NkBrZXJuZWwub3JnOw0KPiBwZXRlcnpAaW5mcmFkZWFkLm9yZzsgcG9tYnJlZGFubmVAbmV4
Yi5jb207DQo+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBrc3Rld2FydEBsaW51eGZvdW5k
YXRpb24ub3JnOw0KPiByYWZhZWwuai53eXNvY2tpQGludGVsLmNvbTsgYWtAbGludXguaW50ZWwu
Y29tOw0KPiBraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tOyB4aWFvY2hlbi5zaGVuQGlu
dGVsLmNvbTsNCj4gY29saW4ua2luZ0BjYW5vbmljYWwuY29tOyBIdXJ3aXR6LCBTaGVycnkgPHNo
ZXJyeS5odXJ3aXR6QGFtZC5jb20+Ow0KPiBMZW5kYWNreSwgVGhvbWFzIDxUaG9tYXMuTGVuZGFj
a3lAYW1kLmNvbT47IHBib256aW5pQHJlZGhhdC5jb207DQo+IGR3bXdAYW1hem9uLmNvLnVrOyBs
dXRvQGtlcm5lbC5vcmc7IGpyb2VkZWxAc3VzZS5kZTsNCj4gamFubmhAZ29vZ2xlLmNvbTsgZGlt
YUBhcmlzdGEuY29tOyBqcG9pbWJvZUByZWRoYXQuY29tOw0KPiB2a3V6bmV0c0ByZWRoYXQuY29t
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIg
MTAvMTFdIGFyY2gveDg2OiBBZGQgQU1EIGZlYXR1cmUgYml0DQo+IFg4Nl9GRUFUVVJFX01CQSBp
biBjcHVpZCBiaXRzIGFycmF5DQo+IA0KPiBPbiBGcmksIE9jdCAwNSwgMjAxOCBhdCAwODo1Njow
OVBNICswMDAwLCBNb2dlciwgQmFidSB3cm90ZToNCj4gPiBGcm9tOiBTaGVycnkgSHVyd2l0eiA8
c2hlcnJ5Lmh1cndpdHpAYW1kLmNvbT4NCj4gPg0KPiA+IFRoZSBmZWF0dXJlIGJpdCBYODZfRkVB
VFVSRV9NQkEgaXMgZGV0ZWN0ZWQgdmlhIENQVUlEIGxlYWYgMHg4MDAwMDAwOA0KPiA+IEVCWCBC
aXQgMDYuIFRoaXMgYml0IGluZGljYXRlcyB0aGUgc3VwcG9ydCBvZiBBTUQncyBNQkEgZmVhdHVy
ZS4NCj4gPg0KPiA+IFRoaXMgZmVhdHVyZSBpcyBzdXBwb3J0ZWQgYnkgYm90aCBJbnRlbCBhbmQg
QU1ELiBCdXQgdGhleSBhcmUgZGV0ZWN0ZWQNCj4gPiBkaWZmZXJlbnQgQ1BVSUQgbGVhdmVzLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmFidSBNb2dlciA8YmFidS5tb2dlckBhbWQuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFNoZXJyeSBIdXJ3aXR6IDxzaGVycnkuaHVyd2l0ekBhbWQuY29t
Pg0KPiANCj4gVGhpcyBTT0IgY2hhaW4gc2hvdWxkIGJlIHRoZSBvdGhlciB3YXkgYXJvdW5kIC0g
Zmlyc3QgU2hlcnJ5LCB0aGVuIHlvdS4NCg0KU3VyZS4gV2lsbCBjaGFuZ2UgaXQuDQo+IA0KPiA+
IC0tLQ0KPiA+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1L3NjYXR0ZXJlZC5jIHwgNyArKysrKystDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NjYXR0ZXJlZC5jDQo+IGIvYXJj
aC94ODYva2VybmVsL2NwdS9zY2F0dGVyZWQuYw0KPiA+IGluZGV4IDc3MmMyMTliNjg4OS4uYmQ3
ODUzMzM0YjI3IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvc2NhdHRlcmVk
LmMNCj4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3NjYXR0ZXJlZC5jDQo+ID4gQEAgLTE3
LDcgKzE3LDExIEBAIHN0cnVjdCBjcHVpZF9iaXQgew0KPiA+ICAJdTMyIHN1Yl9sZWFmOw0KPiA+
ICB9Ow0KPiA+DQo+ID4gLS8qIFBsZWFzZSBrZWVwIHRoZSBsZWFmIHNvcnRlZCBieSBjcHVpZF9i
aXQubGV2ZWwgZm9yIGZhc3RlciBzZWFyY2guICovDQo+ID4gKy8qDQo+ID4gKyAqIFBsZWFzZSBr
ZWVwIHRoZSBsZWFmIHNvcnRlZCBieSBjcHVpZF9iaXQubGV2ZWwgZm9yIGZhc3RlciBzZWFyY2gu
DQo+ID4gKyAqIFg4Nl9GRUFUVVJFX01CQSBzdXBwb3J0ZWQgYnkgYm90aCBJbnRlbCBhbmQgQU1E
LiBCdXQgdGhlIGNwdWlkDQo+ID4gKyAqIGxldmVscyBhcmUgZGlmZmVyZW50LiBBZGQgYSBzZXBh
cmF0ZSBlbnR5IGZvciBlYWNoLg0KPiA+ICsgKi8NCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBj
cHVpZF9iaXQgY3B1aWRfYml0c1tdID0gew0KPiA+ICAJeyBYODZfRkVBVFVSRV9BUEVSRk1QRVJG
LCAgICAgICBDUFVJRF9FQ1gsICAwLCAweDAwMDAwMDA2LCAwIH0sDQo+ID4gIAl7IFg4Nl9GRUFU
VVJFX0VQQiwJCUNQVUlEX0VDWCwgIDMsIDB4MDAwMDAwMDYsIDAgfSwNCj4gPiBAQCAtMjksNiAr
MzMsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGNwdWlkX2JpdCBjcHVpZF9iaXRzW10gPSB7DQo+
ID4gIAl7IFg4Nl9GRUFUVVJFX0hXX1BTVEFURSwJQ1BVSURfRURYLCAgNywgMHg4MDAwMDAwNywg
MCB9LA0KPiA+ICAJeyBYODZfRkVBVFVSRV9DUEIsCQlDUFVJRF9FRFgsICA5LCAweDgwMDAwMDA3
LCAwIH0sDQo+ID4gIAl7IFg4Nl9GRUFUVVJFX1BST0NfRkVFREJBQ0ssICAgIENQVUlEX0VEWCwg
MTEsIDB4ODAwMDAwMDcsIDAgfSwNCj4gPiArCXsgWDg2X0ZFQVRVUkVfTUJBLAkJQ1BVSURfRUJY
LCAgNiwgMHg4MDAwMDAwOCwgMCB9LA0KPiA+ICAJeyBYODZfRkVBVFVSRV9TTUUsCQlDUFVJRF9F
QVgsICAwLCAweDgwMDAwMDFmLCAwIH0sDQo+ID4gIAl7IFg4Nl9GRUFUVVJFX1NFViwJCUNQVUlE
X0VBWCwgIDEsIDB4ODAwMDAwMWYsIDAgfSwNCj4gPiAgCXsgMCwgMCwgMCwgMCwgMCB9DQo+ID4g
LS0NCj4gDQo+IFdpdGggdGhhdCBmaXhlZDoNCj4gDQo+IFJldmlld2VkLWJ5OiBCb3Jpc2xhdiBQ
ZXRrb3YgPGJwQHN1c2UuZGU+DQo+IA0KDQpUaGFua3MNCg0KPiAtLQ0KPiBSZWdhcmRzL0dydXNz
LA0KPiAgICAgQm9yaXMuDQo+IA0KPiBHb29kIG1haWxpbmcgcHJhY3RpY2VzIGZvciA0MDA6IGF2
b2lkIHRvcC1wb3N0aW5nIGFuZCB0cmltIHRoZSByZXBseS4NCg==
