Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2292FC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCEC20672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="26IFtrgM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCEC20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbeLKWpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:45:52 -0500
Received: from mail-eopbgr740043.outbound.protection.outlook.com ([40.107.74.43]:23040
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbeLKWpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5m2hSVSQnR3VJggy2lHJCJw48zUFXNBLAPU7R2Y1ZU=;
 b=26IFtrgMkQgzvEe5S1RfxPRIgbK17Wevj2hdoz3q1gVdUD6zxbGi1Ik886nRoqXQPMXu2I1ZzfQ3/3UH5XP+qrxMrj5YpEu1CEg8sU8sAc+R8pn/1GRxeJyY+XXF7mUKwW+wr7Sf3T8XVGRc0S744HHzLrjH/ob48tEW1oSpvVg=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB2446.namprd12.prod.outlook.com (52.132.195.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Tue, 11 Dec 2018 22:45:41 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5%6]) with mapi id 15.20.1425.016; Tue, 11 Dec 2018
 22:45:41 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH] x86/speculation: Add support for STIBP always-on
 preferred mode
Thread-Topic: [PATCH] x86/speculation: Add support for STIBP always-on
 preferred mode
Thread-Index: AQHUkYUdUUqHSw55jUaGOaWlduXUMaV5hSQAgACGSgD//6uNgIAAZh+AgAAGVYA=
Date:   Tue, 11 Dec 2018 22:45:41 +0000
Message-ID: <eebb189a-1e39-92a3-d2be-7ee67ac1845c@amd.com>
References: <20181211190959.28321.56433.stgit@tlendack-t1.amdoffice.net>
 <3308b5d2-0c59-fa33-472b-f56633d39575@amd.com>
 <20181211211944.GT27375@zn.tnic>
 <d054e17f-87e4-a8cc-425c-f56b9c6d4588@amd.com>
 <20181211222259.GU27375@zn.tnic>
In-Reply-To: <20181211222259.GU27375@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR0102CA0034.prod.exchangelabs.com (2603:10b6:805:1::47)
 To SN1PR12MB0175.namprd12.prod.outlook.com (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB2446;20:+LyQeyWJiL8WuF6cLmE4ZjpJMhOktdeAykecaUZh7+n3k6B5JfPhN3+kdy3sH+3uIa885LElOOcNuOgcTvNF3sPEkjQsL+ThhfhajW6jnqmsK11bqVQHGPzTT/3ffHhmDfhtbidbuhcfYtCL1CNLHNQ6M0rft9udQI8F1BKQ3STiycaz80aqkhF9+/ysh3Rzga7hVvgsaykIOtCCVEesHAk8siJNdB8ntYqXzSDaMm9Q6lwpXfYRjk6T2/G2pusi
x-ms-office365-filtering-correlation-id: 37dbd8e1-962d-4f8c-9481-08d65fba6097
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2446;
x-ms-traffictypediagnostic: SN1PR12MB2446:
x-microsoft-antispam-prvs: <SN1PR12MB24463B312381F15042F29D8CECA60@SN1PR12MB2446.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB2446;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2446;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(189003)(11346002)(31696002)(6246003)(26005)(102836004)(2616005)(186003)(446003)(476003)(6506007)(93886005)(76176011)(14444005)(52116002)(86362001)(97736004)(71200400001)(36756003)(8676002)(66066001)(4326008)(486006)(256004)(105586002)(81166006)(8936002)(386003)(53546011)(71190400001)(81156014)(6512007)(14454004)(53936002)(6916009)(5660300001)(25786009)(72206003)(3846002)(54906003)(6116002)(316002)(2906002)(6436002)(7736002)(106356001)(305945005)(6486002)(68736007)(31686004)(99286004)(7416002)(478600001)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2446;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SmH9oJynMWGlKdZMM84luf6T5RODXyoG84cCgNBFqewzIDbTbwLGcl6yrk9sr80foZxxudQ65IeUWgv0hEH2KOJv9FDvmDZVsx8U3Lasau+xzjPXsxJRAevXUgEgeKlpNk0n/Eoy4hOZXZ1jkSibIH02vmIH6mrj/0qzHzUsFVb7MPJ9XX2eH2bnGldLzIr/aTbPiXuGVGuZV+zmV+5pOP5B3OHtf1qrLsuIaK72aZt56BMaIHPEeppWmSXekDF/kRXUfMOHevfnY0tjbDANusLq6rY00FA02bnqBfrTeviShFcVFYjW/X1lBH4LFlDT
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE462B900960D04983703124FCB49B9F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37dbd8e1-962d-4f8c-9481-08d65fba6097
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 22:45:41.2709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2446
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMTEvMjAxOCAwNDoyMiBQTSwgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiBPbiBUdWUs
IERlYyAxMSwgMjAxOCBhdCAxMDoxNzozMFBNICswMDAwLCBMZW5kYWNreSwgVGhvbWFzIHdyb3Rl
Og0KPj4gSWYgdXNpbmcganVzdCBTUEVDVFJFX1YyX1VTRVJfU1RSSUNUIHRoZW4gdGhlIGNvZGUg
aW4gc3RpYnBfc3RhdGUoKSB3b3VsZA0KPj4gaGF2ZSB0byBiZSBhYmxlIGRpZmZlcmVudGlhdGUg
YmV0d2VlbiB0aGUgY2FzZSB3aGVyZSB0aGUgbW9kZSB3YXMgc3dpdGNoZWQNCj4+IGJlY2F1c2Ug
b2YgWDg2X0ZFQVRVUkVfQU1EX1NUSUJQX0FMV0FZU19PTiB2cyBhIGtlcm5lbCBjb21tYW5kIGxp
bmUgd2l0aA0KPj4gInNwZWN0cmVfdjJfdXNlcj1vbiIuIEkgY291bGQgYWx3YXlzIHNldCBhbmQg
dXNlIGEgc3RhdGljIHZhcmlhYmxlIGluIHRoZQ0KPj4gZmlsZSBqdXN0IGZvciB0aGUgc3RpYnBf
c3RhdGUoKSBjYXNlLg0KPiANCj4gRG9lcyBpdCBtYXR0ZXIgb24gWDg2X0ZFQVRVUkVfQU1EX1NU
SUJQX0FMV0FZU19PTiBDUFVzPw0KPiANCj4gSSBtZWFuLCB3ZSB3YW50IFNUSUJQIHRvIGJlIGFs
d2F5cyBvbiB0aGVyZSBzbyB5b3UgY2FuIGRvOg0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2tlcm5lbC9jcHUvYnVncy5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMNCj4gaW5kZXgg
MjVlOTE0Zjc3YmI4Li5kMTQ4NjBkMWNmOWMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5l
bC9jcHUvYnVncy5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvYnVncy5jDQo+IEBAIC0x
MDg5LDcgKzEwODksMTAgQEAgc3RhdGljIGNoYXIgKnN0aWJwX3N0YXRlKHZvaWQpDQo+ICAJY2Fz
ZSBTUEVDVFJFX1YyX1VTRVJfTk9ORToNCj4gIAkJcmV0dXJuICIsIFNUSUJQOiBkaXNhYmxlZCI7
DQo+ICAJY2FzZSBTUEVDVFJFX1YyX1VTRVJfU1RSSUNUOg0KPiAtCQlyZXR1cm4gIiwgU1RJQlA6
IGZvcmNlZCI7DQo+ICsJCWlmIChib290X2NwdV9oYXMoWDg2X0ZFQVRVUkVfQU1EX1NUSUJQX0FM
V0FZU19PTikpDQo+ICsJCQlyZXR1cm4gIiwgU1RJQlA6IGFsd2F5cyBvbiI7DQo+ICsJCWVsc2UN
Cj4gKwkJCXJldHVybiAiLCBTVElCUDogZm9yY2VkIjsNCj4gIAljYXNlIFNQRUNUUkVfVjJfVVNF
Ul9QUkNUTDoNCj4gIAljYXNlIFNQRUNUUkVfVjJfVVNFUl9TRUNDT01QOg0KPiAgCQlpZiAoc3Rh
dGljX2tleV9lbmFibGVkKCZzd2l0Y2hfdG9fY29uZF9zdGlicCkpDQo+IA0KPiBzbyBpZiB1c2Vy
IGhhcyBib290ZWQgd2l0aCBzcGVjdHJlX3YyX3VzZXI9b24sIHdlIHNheSwgIm9oIHdlbGwsIGl0
IGlzIGFsd2F5cw0KPiBlbmFibGVkIGFueXdheSIuLi4gb3I/DQoNCkknbSBvayB3aXRoIHRoYXQu
IEhhdmluZyBzYWlkIHRoYXQsIHdlIGNhbiBwcm9iYWJseSBqdXN0IGxlYXZlIGl0IGFzIGlzDQph
bmQgcmV0dXJuICJmb3JjZWQiIGV2ZW4gZm9yIHRoZSBBTFdBWVNfT04gY2FzZSwgdGhlbi4NCg0K
QnV0IGlmIHdlIHdhbnQgdG8gZGlmZmVyZW50aWF0ZSwgdGhvdWdoLCBhIHNpbXBsZSBzdGF0aWMg
Ym9vbCB0aGF0IGlzIHNldA0Kd2hlbiB0aGUgbW9kZSBpcyBzd2l0Y2hlZCB3b3JrcyBqdXN0IGFz
IHdlbGwuDQoNCj4gDQo+PiBJJ2xsIGdpdmUgaXQgYSBiaXQgb2YgdGltZSBhbmQgc2VlIGlmIHRo
ZXJlJ3MgYW55IG90aGVyIGRpc2N1c3Npb24gYW5kDQo+PiByZS1zdWJtaXQgd2l0aG91dCB0aGUg
bmV3IFNQRUNUUkVfVjJfVVNFUl9TVFJJQ1RfUFJFRkVSUkVEIHZhbHVlLg0KPiANCj4gU3VyZS4N
Cg0KRWgsIEknbGwganVzdCBzdWJtaXQgdjIgd2l0aCB0aGUgY2hhbmdlcyBub3cgYW5kIHdlIGNh
biBkZWNpZGUgYmV0d2VlbiB0aGUNCmFib3ZlIG9yIHRoZSBib29sLg0KDQpUaGFua3MsDQpUb20N
Cg0KPiANCg==
