Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E3FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4316020645
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a1SNNVnf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4316020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbeK1HRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:17:54 -0500
Received: from mail-eopbgr680083.outbound.protection.outlook.com ([40.107.68.83]:7040
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725764AbeK1HRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 02:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fc1CnOEYvfgUW8hip9N8g5aPP+uqHZrV7dnBg/4ICoU=;
 b=a1SNNVnf7x6TU0rd3gdiEj+bkcBgU9Aj1cmNE4J6FM0VRfpiiuEqQtYcngaTe1p/Ju4jSbxAArKka3QohDBsbdU5fGp3F3xOYQGuhAWgaVzV+XKUvr/gDjh4u8z6qi0W8QFVHhk6DemIBR6bGPvC0J1aHNyTmX0797Du4qyQZ6I=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB0654.namprd12.prod.outlook.com (10.163.208.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Tue, 27 Nov 2018 20:18:45 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5%6]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 20:18:44 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch V2 24/28] x86/speculation: Prepare arch_smt_update() for
 PRCTL mode
Thread-Topic: [patch V2 24/28] x86/speculation: Prepare arch_smt_update() for
 PRCTL mode
Thread-Index: AQHUhPC/1qVyRKMepkGTWuigitwSWKVkEuWA
Date:   Tue, 27 Nov 2018 20:18:44 +0000
Message-ID: <070bd6a5-fd27-2b6d-efea-6d883ba1f8ec@amd.com>
References: <20181125183328.318175777@linutronix.de>
 <20181125185005.759457117@linutronix.de>
In-Reply-To: <20181125185005.759457117@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0041.namprd02.prod.outlook.com
 (2603:10b6:803:2e::27) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0654;20:WRqj09E3Tg1aQlK6y8Ah+NNc60zHwfFVqzY7AdUyVwyd/VT9CVtpvHStVfY9TI8v7wVzEdRflxQUO8zW7HW+S5cw7il+mI9ba7zHbeAp7LwZ2FnZ5imooGLl/LqfhvCGvTDlU49jeFjlrFyjTLLF+sD1LCKiMKOJPRVgf/iug3RFMqP9gZlbKf2e6Jen3Qtp3isSCnyQja7s/3XtX5er0c2mdLIf2fQcb86nxefmtFSetJ57TDRP3BRR0krhswsS
x-ms-office365-filtering-correlation-id: 56d58e1b-806b-42f1-c654-08d654a58735
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0654;
x-ms-traffictypediagnostic: SN1PR12MB0654:
x-microsoft-antispam-prvs: <SN1PR12MB0654F841D83451EB4D8E438DECD00@SN1PR12MB0654.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231443)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB0654;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0654;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(366004)(136003)(189003)(199004)(105586002)(54906003)(31686004)(110136005)(8936002)(97736004)(2906002)(6486002)(256004)(14444005)(6436002)(36756003)(68736007)(86362001)(11346002)(446003)(476003)(2616005)(31696002)(229853002)(316002)(71190400001)(486006)(71200400001)(7416002)(5660300001)(14454004)(102836004)(6246003)(66066001)(6512007)(99286004)(52116002)(81166006)(81156014)(25786009)(478600001)(6116002)(106356001)(3846002)(72206003)(8676002)(4326008)(39060400002)(186003)(76176011)(53936002)(7736002)(53546011)(386003)(305945005)(6506007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0654;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dRVBwZABpgeqf7vlzhaxOi823ZxBkob0ATUgobx8Rr+Jl+gkPWk2oK9xrrd4bmcCMqrWGEEH8iPJ+Q285Bgo9J55QKBkqNnpJMJ+pGHmBG1GKzpfLX0IbdS5F/Ao4ffJqHPfwDQy/9zsIqEfuvUiGAyCyZUyC+YdwUu+/DeQKp2M592UjzL3vmkZAIWh9U1dWgyu5QRWy+EcwDAbw6b0uhh0CoCFriAq5ScWGlnAVeO6t0VGqL6fqO0kSl37aszFXDl3iN4up2eD5s6OJDSBfarwKRlMvZAkiiEACCQQ5e2A6Zz/71WxArD1vaA7TH4EBN+d7Z/vo3/rg8ZniiFSgjYy2Cy3qkXnE0Gkyqf6I0M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <00F4BC0E7B8047419821353E99217D9C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d58e1b-806b-42f1-c654-08d654a58735
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 20:18:44.6945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0654
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjUvMjAxOCAxMjozMyBQTSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiBUaGUgdXBj
b21pbmcgZmluZSBncmFpbmVkIHBlciB0YXNrIFNUSUJQIGNvbnRyb2wgbmVlZHMgdG8gYmUgdXBk
YXRlZCBvbiBDUFUNCj4gaG90cGx1ZyBhcyB3ZWxsLg0KPiANCj4gU3BsaXQgb3V0IHRoZSBjb2Rl
IHdoaWNoIGNvbnRyb2xzIHRoZSBzdHJpY3QgbW9kZSBzbyB0aGUgcHJjdGwgY29udHJvbCBjb2Rl
DQo+IGNhbiBiZSBhZGRlZCBsYXRlci4gTWFyayB0aGUgU01QIGZ1bmN0aW9uIGNhbGwgYXJndW1l
bnQgX191bnVzZWQgd2hpbGUgYXQgaXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgR2xl
aXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gDQo+IC0tLQ0KPiANCj4gdjEgLT4gdjI6IHMv
YXBwMmFwcC91c2VyLy4gTWFyayBzbXAgZnVuY3Rpb24gYXJndW1lbnQgX191bnVzZWQNCj4gDQo+
IC0tLQ0KPiAgYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMgfCAgIDQ2ICsrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDI1IGlu
c2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKQ0KPiANCj4gLS0tIGEvYXJjaC94ODYva2VybmVs
L2NwdS9idWdzLmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMNCj4gQEAgLTUz
MCw0MCArNTMwLDQ0IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBzcGVjdHJlX3YyX3NlbGVjdF9taXQN
Cj4gIAlhcmNoX3NtdF91cGRhdGUoKTsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIGJvb2wgc3RpYnBf
bmVlZGVkKHZvaWQpDQo+ICtzdGF0aWMgdm9pZCB1cGRhdGVfc3RpYnBfbXNyKHZvaWQgKiBfX3Vu
dXNlZCkNCj4gIHsNCj4gLQkvKiBFbmhhbmNlZCBJQlJTIG1ha2VzIHVzaW5nIFNUSUJQIHVubmVj
ZXNzYXJ5LiAqLw0KPiAtCWlmIChzcGVjdHJlX3YyX2VuYWJsZWQgPT0gU1BFQ1RSRV9WMl9JQlJT
X0VOSEFOQ0VEKQ0KPiAtCQlyZXR1cm4gZmFsc2U7DQo+IC0NCj4gLQkvKiBDaGVjayBmb3Igc3Ry
aWN0IHVzZXIgbWl0aWdhdGlvbiBtb2RlICovDQo+IC0JcmV0dXJuIHNwZWN0cmVfdjJfdXNlciA9
PSBTUEVDVFJFX1YyX1VTRVJfU1RSSUNUOw0KPiArCXdybXNybChNU1JfSUEzMl9TUEVDX0NUUkws
IHg4Nl9zcGVjX2N0cmxfYmFzZSk7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyB2b2lkIHVwZGF0ZV9z
dGlicF9tc3Iodm9pZCAqaW5mbykNCj4gKy8qIFVwZGF0ZSB4ODZfc3BlY19jdHJsX2Jhc2UgaW4g
Y2FzZSBTTVQgc3RhdGUgY2hhbmdlZC4gKi8NCj4gK3N0YXRpYyB2b2lkIHVwZGF0ZV9zdGlicF9z
dHJpY3Qodm9pZCkNCj4gIHsNCj4gLQl3cm1zcmwoTVNSX0lBMzJfU1BFQ19DVFJMLCB4ODZfc3Bl
Y19jdHJsX2Jhc2UpOw0KPiArCXU2NCBtYXNrID0geDg2X3NwZWNfY3RybF9iYXNlICYgflNQRUNf
Q1RSTF9TVElCUDsNCj4gKw0KPiArCWlmIChzY2hlZF9zbXRfYWN0aXZlKCkpDQo+ICsJCW1hc2sg
fD0gU1BFQ19DVFJMX1NUSUJQOw0KPiArDQo+ICsJaWYgKG1hc2sgPT0geDg2X3NwZWNfY3RybF9i
YXNlKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwlwcl9pbmZvKCJTcGVjdHJlIHYyIHVzZXIgc3Bh
Y2UgU01UIG1pdGlnYXRpb246IFNUSUJQICVzXG4iLA0KPiArCQltYXNrICYgU1BFQ19DVFJMX1NU
SUJQID8gImFsd2F5cy1vbiIgOiAib2ZmIik7DQo+ICsJeDg2X3NwZWNfY3RybF9iYXNlID0gbWFz
azsNCj4gKwlvbl9lYWNoX2NwdSh1cGRhdGVfc3RpYnBfbXNyLCBOVUxMLCAxKTsNCg0KU29tZSBt
b3JlIHRlc3RpbmcgdXNpbmcgc3BlY3RyZV92Ml91c2VyPW9uIGFuZCBJJ3ZlIGZvdW5kIHRoYXQg
ZHVyaW5nIGJvb3QNCnVwLCBvbmNlIHRoZSBmaXJzdCBTTVQgdGhyZWFkIGlzIGVuY291bnRlcmVk
IG5vIG1vcmUgdXBkYXRlcyB0byBNU1JzIGZvcg0KU1RJQlAgYXJlIGRvbmUgZm9yIGFueSBDUFVz
IGJyb3VnaHQgdXAgYWZ0ZXIgdGhhdC4gVGhlIGZpcnN0IFNNVCB0aHJlYWQNCndpbGwgY2F1c2Ug
bWFzayAhPSB4ODZfc3BlY19jdHJsX2Jhc2UsIGJ1dCB0aGVuIHg4Nl9zcGVjX2N0cmxfYmFzZSBp
cyBzZXQNCnRvIG1hc2sgYW5kIHRoZSBjaGVjayBhbHdheXMgY2F1c2VzIGEgcmV0dXJuIGZvciBz
dWJzZXF1ZW50IENQVXMgdGhhdCBhcmUNCmJyb3VnaHQgdXAuDQoNClRhbGtpbmcgdG8gb3VyIEhX
IGZvbGtzLCB0aGV5IHJlY29tbWVuZCB0aGF0IGl0IGJlIHNldCBvbiBhbGwgdGhyZWFkcywgc28N
CkknbSBub3Qgc3VyZSB3aGF0IHRoZSByaWdodCBhcHByb2FjaCB3b3VsZCBiZSBmb3IgdGhpcy4N
Cg0KQWxzbywgSSd2ZSBzZWVuIHNvbWUgQklPU2VzIHNldCB1cCB0aGUgY29yZXMvdGhyZWFkcyB3
aGVyZSB0aGUgY29yZSBhbmQNCml0cyB0aHJlYWQgYXJlIGVudW1lcmF0ZWQgYmVmb3JlIHRoZSBu
ZXh0IGNvcmUgYW5kIGl0cyB0aHJlYWQsIGV0Yy4gSWYNCnRoYXQgd2VyZSB0aGUgY2FzZSwgSSB0
aGluayB0aGlzIHdvdWxkIHJlc3VsdCBpbiBvbmx5IHRoZSBmaXJzdCBjb3JlDQphbmQgaXRzIHRo
cmVhZCBoYXZpbmcgU1RJQlAgc2V0LCByaWdodD8NCg0KVGhhbmtzLA0KVG9tDQoNCj4gIH0NCj4g
IA0KPiAgdm9pZCBhcmNoX3NtdF91cGRhdGUodm9pZCkNCj4gIHsNCj4gLQl1NjQgbWFzazsNCj4g
LQ0KPiAtCWlmICghc3RpYnBfbmVlZGVkKCkpDQo+ICsJLyogRW5oYW5jZWQgSUJSUyBpbXBsaWVz
IFNUSUJQLiBObyB1cGRhdGUgcmVxdWlyZWQuICovDQo+ICsJaWYgKHNwZWN0cmVfdjJfZW5hYmxl
ZCA9PSBTUEVDVFJFX1YyX0lCUlNfRU5IQU5DRUQpDQo+ICAJCXJldHVybjsNCj4gIA0KPiAgCW11
dGV4X2xvY2soJnNwZWNfY3RybF9tdXRleCk7DQo+ICANCj4gLQltYXNrID0geDg2X3NwZWNfY3Ry
bF9iYXNlICYgflNQRUNfQ1RSTF9TVElCUDsNCj4gLQlpZiAoc2NoZWRfc210X2FjdGl2ZSgpKQ0K
PiAtCQltYXNrIHw9IFNQRUNfQ1RSTF9TVElCUDsNCj4gLQ0KPiAtCWlmIChtYXNrICE9IHg4Nl9z
cGVjX2N0cmxfYmFzZSkgew0KPiAtCQlwcl9pbmZvKCJTcGVjdHJlIHYyIGNyb3NzLXByb2Nlc3Mg
U01UIG1pdGlnYXRpb246ICVzIFNUSUJQXG4iLA0KPiAtCQkJbWFzayAmIFNQRUNfQ1RSTF9TVElC
UCA/ICJFbmFibGluZyIgOiAiRGlzYWJsaW5nIik7DQo+IC0JCXg4Nl9zcGVjX2N0cmxfYmFzZSA9
IG1hc2s7DQo+IC0JCW9uX2VhY2hfY3B1KHVwZGF0ZV9zdGlicF9tc3IsIE5VTEwsIDEpOw0KPiAr
CXN3aXRjaCAoc3BlY3RyZV92Ml91c2VyKSB7DQo+ICsJY2FzZSBTUEVDVFJFX1YyX1VTRVJfTk9O
RToNCj4gKwkJYnJlYWs7DQo+ICsJY2FzZSBTUEVDVFJFX1YyX1VTRVJfU1RSSUNUOg0KPiArCQl1
cGRhdGVfc3RpYnBfc3RyaWN0KCk7DQo+ICsJCWJyZWFrOw0KPiAgCX0NCj4gKw0KPiAgCW11dGV4
X3VubG9jaygmc3BlY19jdHJsX211dGV4KTsNCj4gIH0NCj4gIA0KPiANCj4gDQo=
