Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA33C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95712086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gqXj1lh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95712086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbeK1Iwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 03:52:36 -0500
Received: from mail-eopbgr700068.outbound.protection.outlook.com ([40.107.70.68]:20112
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726277AbeK1Iwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 03:52:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T8OxDTO52TU5+WLRG8YSCWbzbW8ObuJ0mCBT8Vx6BA=;
 b=gqXj1lh9qedBg6mt1BDYb2I2Xnawj2fpO4eKZ27A3RbqGtP6C8i2XkJaN+N3XMEd0hEBuY2wDuSyfL7si/u1uCHzXYw8uNGoGcgC8acyFeBmnJ9rsMQv5yy9kX09wk5OZ3o9qosGFoWX4Mg6gpARdUqWA0SnLR2mFjCJX2rxIKQ=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB0384.namprd12.prod.outlook.com (10.162.4.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Tue, 27 Nov 2018 21:52:34 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5%6]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 21:52:34 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
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
Subject: Re: [patch V2 18/28] x86/speculation: Prepare for per task indirect
 branch speculation control
Thread-Topic: [patch V2 18/28] x86/speculation: Prepare for per task indirect
 branch speculation control
Thread-Index: AQHUhPC7rHYdSONo60ydeUeoiJQu3qVjfc+AgACa9wCAAADlAIAAE3GA
Date:   Tue, 27 Nov 2018 21:52:33 +0000
Message-ID: <0921f310-3c53-f001-50bd-bd70c1f38121@amd.com>
References: <20181125183328.318175777@linutronix.de>
 <20181125185005.176917199@linutronix.de>
 <7ec59a1a-4caf-24f6-3466-ee1d01594861@amd.com>
 <alpine.DEB.2.21.1811272138290.1875@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1811272142000.1875@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1811272142000.1875@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0046.namprd02.prod.outlook.com
 (2603:10b6:803:2e::32) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0384;20:Swpt6VWhdMTlWKbpRSBf/LtZRi1xjVYcvB0NdWJxOlgl/gk1vbBQ3A35OtskddqLQ3ZoDsOoH/bWcNovd+uYobM+mMSXRFUdaGkcoPkim2NSCOdanqqN8UhUgNHYfOhxuVkBXPfIHEA8STkxrDT6/x9wpLqGsF0fPAnT2Ig/Qksn5aNmrRy6y0CUWvVsTu1jD+TA688XxFR0w90Bj/bzrVMyx2ARuJEiaElcBKQY/WQrdmeW6UXDjvwKk0BFPu+e
x-ms-office365-filtering-correlation-id: 3020465b-daa3-42bd-93ce-08d654b2a2e7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0384;
x-ms-traffictypediagnostic: SN1PR12MB0384:
x-microsoft-antispam-prvs: <SN1PR12MB0384C1D4458C4EB374966062ECD00@SN1PR12MB0384.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231443)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB0384;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0384;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(136003)(376002)(396003)(199004)(189003)(478600001)(386003)(6506007)(305945005)(6116002)(3846002)(53546011)(72206003)(26005)(106356001)(7736002)(6486002)(105586002)(6436002)(25786009)(316002)(54906003)(68736007)(31686004)(186003)(102836004)(2906002)(6916009)(7416002)(6246003)(6512007)(446003)(93886005)(36756003)(76176011)(8676002)(11346002)(81166006)(14454004)(99286004)(4326008)(71200400001)(229853002)(31696002)(8936002)(53936002)(86362001)(486006)(476003)(71190400001)(5660300001)(39060400002)(52116002)(256004)(97736004)(2616005)(14444005)(66066001)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0384;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: B3TIfOK0r1keR2LJsIuHmhGe7iAWm1nUKUtUNXmq1D7V4Pf/KQ96XPPzd8GF5ing+jOnqhtdAZ4qAKnnFqatyqGID3e4IsrML9okdw1gbS+OEEPhfEaBVXrONwZ+1ySCIVkcR3gMin/OFuEe9+d40QToSEe8eJAWvBFCjBDwFjU/Hm/7uPS9Ea4mdcP14VWfojh9fhyq3Vd84rW5RVLzqUhtkmUTf1jgk32Hg4Qg+MVHUMk+9N2V2NNpjttZIqcrJNQI1C6sWkZwv5EqVIrznZAsv2Jd0Dmzn1+l8+HMJWcZ2icDvuW+2L1bmWIA+9pHGWn2feF5HLUQWKiT63v1PMi2+Cq2i1k9KD5TOtFHsQ4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <699A97FCDBBDE54D9AF651EB282599A5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3020465b-daa3-42bd-93ce-08d654b2a2e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 21:52:33.8813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0384
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjcvMjAxOCAwMjo0MiBQTSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiBPbiBUdWUs
IDI3IE5vdiAyMDE4LCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+PiBPbiBUdWUsIDI3IE5vdiAy
MDE4LCBMZW5kYWNreSwgVGhvbWFzIHdyb3RlOg0KPj4+IE9uIDExLzI1LzIwMTggMTI6MzMgUE0s
IFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4+Pj4gLS0tIGEvYXJjaC94ODYva2VybmVsL3Byb2Nl
c3MuYw0KPj4+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jDQo+Pj4+IEBAIC00MDYs
NiArNDA2LDExIEBAIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9pZCBzcGVjX2N0cmxfdXANCj4+
Pj4gIAlpZiAoc3RhdGljX2NwdV9oYXMoWDg2X0ZFQVRVUkVfU1NCRCkpDQo+Pj4+ICAJCW1zciB8
PSBzc2JkX3RpZl90b19zcGVjX2N0cmwodGlmbik7DQo+Pj4NCj4+PiBJIGRpZCBzb21lIHF1aWNr
IHRlc3RpbmcgYW5kIGZvdW5kIG15IG9yaWdpbmFsIGxvZ2ljIHdhcyBmbGF3ZWQuIFNpbmNlDQo+
Pj4gc3BlY19jdHJsX3VwZGF0ZV9tc3IoKSBjYW4gbm93IGJlIGNhbGxlZCBmb3IgU1RJQlAsIGFu
IGFkZGl0aW9uYWwgY2hlY2sNCj4+PiBpcyBuZWVkZWQgdG8gc2V0IHRoZSBTU0JEIE1TUiBiaXQu
DQo+Pj4NCj4+PiBCb3RoIFg4Nl9GRUFUVVJFX1ZJUlRfU1NCRCBhbmQgWDg2X0ZFQVRVUkVfTFNf
Q0ZHX1NTQkQgY2F1c2UNCj4+PiBYODZfRkVBVFVSRV9TU0JEIHRvIGJlIHNldC4gQmVmb3JlIHRo
aXMgcGF0Y2gsIHNwZWNfY3RybF91cGRhdGVfbXNyKCkgd2FzDQo+Pj4gb25seSBjYWxsZWQgaWYg
WDg2X0ZFQVRVUkVfU1NCRCB3YXMgc2V0IGFuZCBvbmUgb2YgdGhlIG90aGVyIFNTQkQgZmVhdHVy
ZXMNCj4+PiB3YXNuJ3Qgc2V0LiBCdXQgbm93LCBTVElCUCBjYW4gY2F1c2Ugc3BlY19jdHJsX3Vw
ZGF0ZV9tc3IoKSB0byBnZXQgY2FsbGVkDQo+Pj4gYW5kIGNhdXNlIHRoZSBTU0JEIE1TUiBiaXQg
dG8gYmUgc2V0IHdoZW4gaXQgc2hvdWxkbid0IChjb3VsZCByZXN1bHQgaW4NCj4+PiBhIEdQIGZh
dWx0KS4NCj4+DQo+PiBUaGUgYmVsb3cgc2hvdWxkIGZpeCB0aGF0LiBXZSBoYXZlIHRoZSBzYW1l
IGxvZ2ljIGluIHg4Nl92aXJ0X3NwZWNfY3RybCgpDQo+IA0KPiBBY3R1YWxseSBpdCdzIGluY29t
cGxldGUuIEZ1bGwgdmVyc2lvbiBiZWxvdy4NCg0KSnVzdCBvbmUgbGl0dGxlIG5pdCBvbiB0aGUg
Y29tbWVudCBiZWxvdywgb3RoZXJ3aXNlIHdvcmtzIG5pY2VseS4NCg0KVGhhbmtzLA0KVG9tDQoN
Cj4gDQo+IFRoYW5rcywNCj4gDQo+IAl0Z2x4DQo+IA0KPiA4PC0tLS0tLS0tLS0tLS0tLS0tDQo+
IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNzLmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVs
L3Byb2Nlc3MuYw0KPiBAQCAtNDAzLDEwICs0MDMsMTEgQEAgc3RhdGljIF9fYWx3YXlzX2lubGlu
ZSB2b2lkIHNwZWNfY3RybF91cA0KPiAgCXU2NCBtc3IgPSB4ODZfc3BlY19jdHJsX2Jhc2U7DQo+
ICANCj4gIAkvKg0KPiAtCSAqIElmIFg4Nl9GRUFUVVJFX1NTQkQgaXMgbm90IHNldCwgdGhlIFNT
QkQgYml0IGlzIG5vdCB0byBiZQ0KPiAtCSAqIHRvdWNoZWQuDQo+ICsJICogSWYgU1NCRCBpcyBu
b3QgY29udHJvbGxlZCBpbiBNU1JfU1BFQ19DVFJMLCB0aGUgU1NCRCBiaXQgaGFzIG5vdA0KDQpz
L2hhcyBub3QvaXMgbm90Lw0KDQo+ICsJICogdG8gYmUgdG91Y2hlZC4NCj4gIAkgKi8NCj4gLQlp
ZiAoc3RhdGljX2NwdV9oYXMoWDg2X0ZFQVRVUkVfU1NCRCkpDQo+ICsJaWYgKHN0YXRpY19jcHVf
aGFzKFg4Nl9GRUFUVVJFX1NQRUNfQ1RSTF9TU0JEKSB8fA0KPiArCSAgICBzdGF0aWNfY3B1X2hh
cyhYODZfRkVBVFVSRV9BTURfU1NCRCkpDQo+ICAJCW1zciB8PSBzc2JkX3RpZl90b19zcGVjX2N0
cmwodGlmbik7DQo+ICANCj4gIAkvKiBPbmx5IGV2YWx1YXRlIGlmIGNvbmRpdGlvbmFsIFNUSUJQ
IGlzIGVuYWJsZWQgKi8NCj4gQEAgLTQ0MCw3ICs0NDEsOCBAQCBzdGF0aWMgX19hbHdheXNfaW5s
aW5lIHZvaWQgX19zcGVjdWxhdGlvDQo+ICAJCQlhbWRfc2V0X3NzYl92aXJ0X3N0YXRlKHRpZm4p
Ow0KPiAgCQllbHNlIGlmIChzdGF0aWNfY3B1X2hhcyhYODZfRkVBVFVSRV9MU19DRkdfU1NCRCkp
DQo+ICAJCQlhbWRfc2V0X2NvcmVfc3NiX3N0YXRlKHRpZm4pOw0KPiAtCQllbHNlIGlmIChzdGF0
aWNfY3B1X2hhcyhYODZfRkVBVFVSRV9TU0JEKSkNCj4gKwkJZWxzZSBpZiAoc3RhdGljX2NwdV9o
YXMoWDg2X0ZFQVRVUkVfU1BFQ19DVFJMX1NTQkQpIHx8DQo+ICsJCQkgc3RhdGljX2NwdV9oYXMo
WDg2X0ZFQVRVUkVfQU1EX1NTQkQpKQ0KPiAgCQkJdXBkbXNyICA9IHRydWU7DQo+ICAJfQ0KPiAg
DQo+IA0K
