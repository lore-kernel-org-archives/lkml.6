Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5270FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4923208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="veuCGMnI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4923208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeK1IUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 03:20:05 -0500
Received: from mail-eopbgr810072.outbound.protection.outlook.com ([40.107.81.72]:15302
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbeK1IUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 03:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgMb+x9X6reey3mH0H98YnW4xhvJZgn7N34j3e0E9+E=;
 b=veuCGMnIZWpwpx5NfzQ2QO+yZs2/tOem7pmC3DmmuqCKKDt6Kfq7kAaTOZBsez+8MljfIunOmzqp8RMXNjlK+0kCoiSp/VPa0hUN4HsJuVoKg+zbzj/AwigBmTbcfVWeXOx/HvPanpb+Sq1STWvHyuTu3W10cBUV9iRcnX5dzHI=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB2461.namprd12.prod.outlook.com (52.132.195.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Tue, 27 Nov 2018 21:20:48 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5%6]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 21:20:48 +0000
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
Subject: Re: [patch V2 24/28] x86/speculation: Prepare arch_smt_update() for
 PRCTL mode
Thread-Topic: [patch V2 24/28] x86/speculation: Prepare arch_smt_update() for
 PRCTL mode
Thread-Index: AQHUhPC/1qVyRKMepkGTWuigitwSWKVjrk+AgABn4oCAAA4LgA==
Date:   Tue, 27 Nov 2018 21:20:48 +0000
Message-ID: <c883e673-0175-2d3f-5703-eab4c3a792be@amd.com>
References: <20181125183328.318175777@linutronix.de>
 <20181125185005.759457117@linutronix.de>
 <070bd6a5-fd27-2b6d-efea-6d883ba1f8ec@amd.com>
 <alpine.DEB.2.21.1811272125160.1875@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1811272125160.1875@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR08CA0031.namprd08.prod.outlook.com
 (2603:10b6:805:66::44) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB2461;20:0AaNZG8VVrgv2CqhSR09dh7esSnSjWerE7ZpTt2dVHR0afzmqvj9uN9TKafGtnqPzK+4DySnZb6ZOwUNVbNVb1NQMJI7cXHW6OX5HABRZXTxbS6RPh40vSl4JrvE5e4R2zuO0veUTJBKL4TEceEJm13rlunxSYY6kvHmX0z1k+w2hCxadQIlu9TQPU5s3rFunkIZFgJOalXBo/NFDVr1UFqQehanDRrNRO/ysjp2kXGixUmPfyxpxQsMTr0+26JQ
x-ms-office365-filtering-correlation-id: 27319616-5b60-4638-3c1d-08d654ae331d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2461;
x-ms-traffictypediagnostic: SN1PR12MB2461:
x-microsoft-antispam-prvs: <SN1PR12MB24616F1BA71916E46C5F02FAECD00@SN1PR12MB2461.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231443)(944501410)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB2461;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2461;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(366004)(376002)(136003)(189003)(199004)(7736002)(305945005)(54906003)(25786009)(66066001)(316002)(6246003)(6512007)(478600001)(14454004)(2906002)(93886005)(53936002)(4326008)(99286004)(39060400002)(68736007)(72206003)(229853002)(6436002)(76176011)(105586002)(52116002)(36756003)(106356001)(6486002)(186003)(71190400001)(11346002)(446003)(2616005)(486006)(476003)(26005)(71200400001)(6506007)(386003)(53546011)(31686004)(102836004)(14444005)(256004)(3846002)(6116002)(31696002)(86362001)(6916009)(81166006)(97736004)(81156014)(7416002)(5660300001)(8936002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2461;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XrYZqDfNb9xG7l/qDRUTaQ9AxioLnn7jcmjUP+CWdl58Y1YLa/z4JdthhFlNwdckYn4xArum95PUZGJOWspJGfazHa0VDgNEBPZYDlb/oX9a6Q530R6DZc0lrS+vTm9djz5Vs1YByzCpMpAHZFXTnsoNXYnYhZxW6jJtLQ0SXs7ZEzxdsXfX0Y4MV0gAXM5Bib2WCYrMxtvbDGSv2PLJ1TlAftX+IxYJAHj6VY+kQePJsrerhWf7dVRjFDm8vsReHogKdv3cnE3Hz62QPuEy+oryzI/SR8jyWnNe1XeJwSUmN4vSkdqJCZx9Tjx8/gN7JD6saHidJA5h2OlnlQ/MuyJE42Wq0139zjZffpu4aSU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <85CD6135B3C8594994C4F1F048D53458@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27319616-5b60-4638-3c1d-08d654ae331d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 21:20:48.4194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjcvMjAxOCAwMjozMCBQTSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiBPbiBUdWUs
IDI3IE5vdiAyMDE4LCBMZW5kYWNreSwgVGhvbWFzIHdyb3RlOg0KPj4gT24gMTEvMjUvMjAxOCAx
MjozMyBQTSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPj4+ICsvKiBVcGRhdGUgeDg2X3NwZWNf
Y3RybF9iYXNlIGluIGNhc2UgU01UIHN0YXRlIGNoYW5nZWQuICovDQo+Pj4gK3N0YXRpYyB2b2lk
IHVwZGF0ZV9zdGlicF9zdHJpY3Qodm9pZCkNCj4+PiAgew0KPj4+IC0Jd3Jtc3JsKE1TUl9JQTMy
X1NQRUNfQ1RSTCwgeDg2X3NwZWNfY3RybF9iYXNlKTsNCj4+PiArCXU2NCBtYXNrID0geDg2X3Nw
ZWNfY3RybF9iYXNlICYgflNQRUNfQ1RSTF9TVElCUDsNCj4+PiArDQo+Pj4gKwlpZiAoc2NoZWRf
c210X2FjdGl2ZSgpKQ0KPj4+ICsJCW1hc2sgfD0gU1BFQ19DVFJMX1NUSUJQOw0KPj4+ICsNCj4+
PiArCWlmIChtYXNrID09IHg4Nl9zcGVjX2N0cmxfYmFzZSkNCj4+PiArCQlyZXR1cm47DQo+Pj4g
Kw0KPj4+ICsJcHJfaW5mbygiU3BlY3RyZSB2MiB1c2VyIHNwYWNlIFNNVCBtaXRpZ2F0aW9uOiBT
VElCUCAlc1xuIiwNCj4+PiArCQltYXNrICYgU1BFQ19DVFJMX1NUSUJQID8gImFsd2F5cy1vbiIg
OiAib2ZmIik7DQo+Pj4gKwl4ODZfc3BlY19jdHJsX2Jhc2UgPSBtYXNrOw0KPj4+ICsJb25fZWFj
aF9jcHUodXBkYXRlX3N0aWJwX21zciwgTlVMTCwgMSk7DQo+Pg0KPj4gU29tZSBtb3JlIHRlc3Rp
bmcgdXNpbmcgc3BlY3RyZV92Ml91c2VyPW9uIGFuZCBJJ3ZlIGZvdW5kIHRoYXQgZHVyaW5nIGJv
b3QNCj4+IHVwLCBvbmNlIHRoZSBmaXJzdCBTTVQgdGhyZWFkIGlzIGVuY291bnRlcmVkIG5vIG1v
cmUgdXBkYXRlcyB0byBNU1JzIGZvcg0KPj4gU1RJQlAgYXJlIGRvbmUgZm9yIGFueSBDUFVzIGJy
b3VnaHQgdXAgYWZ0ZXIgdGhhdC4gVGhlIGZpcnN0IFNNVCB0aHJlYWQNCj4+IHdpbGwgY2F1c2Ug
bWFzayAhPSB4ODZfc3BlY19jdHJsX2Jhc2UsIGJ1dCB0aGVuIHg4Nl9zcGVjX2N0cmxfYmFzZSBp
cyBzZXQNCj4+IHRvIG1hc2sgYW5kIHRoZSBjaGVjayBhbHdheXMgY2F1c2VzIGEgcmV0dXJuIGZv
ciBzdWJzZXF1ZW50IENQVXMgdGhhdCBhcmUNCj4+IGJyb3VnaHQgdXAuDQo+IA0KPiBUaGUgYWJv
dmUgY29kZSBtZXJpbHkgaGFuZGxlcyB0aGUgc3dpdGNoIGJldHdlZW4gU01UIGFuZCBub24tU01U
IG1vZGUsDQo+IGJlY2F1c2UgdGhlcmUgYWxsIG90aGVyIG9ubGluZSBDUFVzIG5lZWQgdG8gYmUg
dXBkYXRlZCwgYnV0IGFmdGVyIHRoYXQgZWFjaA0KPiB1cGNvbWluZyBDUFUgY2FsbHMgeDg2X3Nw
ZWNfY3RybF9zZXR1cF9hcCgpIHdoaWNoIHdpbGwgd3JpdGUgdGhlIE1TUi4gU28NCj4gaXQncyBh
bGwgZ29vZC4NCg0KWXVwLCBzb3JyeSBmb3IgdGhlIG5vaXNlLiBUcnlpbmcgdG8gdGVzdCBkaWZm
ZXJlbnQgc2NlbmFyaW9zIHVzaW5nIHNvbWUNCmNvZGUgaGFja3MgYW5kIHB1dCB0aGVtIGluIHRo
ZSB3cm9uZyBwbGFjZSwgc28gd2Fzbid0IHRyaWdnZXJpbmcgdGhlDQpXUk1TUiBpbiB4ODZfc3Bl
Y19jdHJsX3NldHVwX2FwKCkuDQoNClRoYW5rcywNClRvbQ0KDQo+IA0KPiBUaGFua3MsDQo+IA0K
PiAJdGdseA0KPiANCg==
