Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEE1C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2752C217D9
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uF+YzqOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfABVo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 16:44:59 -0500
Received: from mail-eopbgr790080.outbound.protection.outlook.com ([40.107.79.80]:63969
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727214AbfABVo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 16:44:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Psal9kGmrCNGRSBjSXNLqJ9i5JTe7xDGWG73+fc4PvI=;
 b=uF+YzqOSexxrWBFnknni9owhr+2hO0AnH76rArxOxoqvlRQGffeVcwD32+dGlaaG2ltBq4f0bdty6nUxc6gwkdy7Nl7NQjYULSUoO6N2OIKtO3UW6pQnffzJCAufu8yht1fSulHRf8Jc6q/tvjpL2QYhRnyMx5Wc036Q4J/gQgI=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB3370.namprd12.prod.outlook.com (20.178.198.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Wed, 2 Jan 2019 21:44:55 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::3d05:1cc3:dc6e:da17]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::3d05:1cc3:dc6e:da17%2]) with mapi id 15.20.1471.019; Wed, 2 Jan 2019
 21:44:55 +0000
From:   "Singh, Brijesh" <brijesh.singh@amd.com>
To:     David Rientjes <rientjes@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
CC:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] kvm: sev: Fail KVM_SEV_INIT if already initialized
Thread-Topic: [patch] kvm: sev: Fail KVM_SEV_INIT if already initialized
Thread-Index: AQHUot2n4yJpVksGV02RfOhjvw2ZV6Wcgw0A
Date:   Wed, 2 Jan 2019 21:44:55 +0000
Message-ID: <e595736e-ba95-ad72-5e8a-12e10759d40f@amd.com>
References: <alpine.DEB.2.21.1901021255410.62182@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1901021255410.62182@chino.kir.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR0102CA0009.prod.exchangelabs.com (2603:10b6:805:1::22)
 To DM6PR12MB2682.namprd12.prod.outlook.com (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3370;20:xPpXDRm3el5DEVi3CDzpy+MqcTZaObUi9/kN5ykHXe4pdj6MkVXvUz9Dxh6EC7zrBVu8ZhT9LzFJ6NDOtVPAlWRI37RKmV+vLIXQFPgnHd3PHlpGM4lszZRBK9b7a+GpKNS3C6r0uRaJiEoU7K9ZEYWwgjym3IuLgZlzB+gZNmyGktE1ccXumK1RDP114F40zekkKMFPg6xry+3T6aHH3ww+7qDgK4DF7P1UJpCy13H+zkhoSuxsIUGJvJ41urSW
x-ms-office365-filtering-correlation-id: ada21463-4ca7-4a53-e7bb-08d670fb88c1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3370;
x-ms-traffictypediagnostic: DM6PR12MB3370:
x-microsoft-antispam-prvs: <DM6PR12MB3370FA00853120A338BB879FE58C0@DM6PR12MB3370.namprd12.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM6PR12MB3370;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB3370;
x-forefront-prvs: 0905A6B2C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(346002)(136003)(376002)(189003)(199004)(51914003)(36756003)(53936002)(26005)(256004)(106356001)(97736004)(14444005)(6486002)(6436002)(486006)(76176011)(476003)(6506007)(68736007)(52116002)(102836004)(186003)(386003)(53546011)(6512007)(229853002)(14454004)(5660300001)(2906002)(6246003)(54906003)(3846002)(71190400001)(7416002)(316002)(71200400001)(11346002)(446003)(25786009)(4326008)(66066001)(105586002)(81166006)(99286004)(8676002)(81156014)(7736002)(31686004)(110136005)(478600001)(31696002)(2616005)(305945005)(86362001)(6116002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3370;H:DM6PR12MB2682.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qkAzis88KagcFoNg4hzqg+TDvQGpczXi7nesX+OR1YSdbBcGXS468On0Su6yYVxvQ/2BrpA636V3PsvIs5zSrxoSayGzS/U+crcKE4ZrdZ10RvzQSDnsUS+GD9aepqao021rbwLRkt5HCAouYtF73JX2PHWCnJV3LCbEuPR1Wk1rYqFZLYbY7F+l26kQU0KuQ6yPCM+qGOVGH/CLWpiIGSzmAcg9sUCkocI103nvCCj9QNQM7okhPq8dlDDch+1d9KYdNXTPBAfiysuCtJ9uYHmgTpNHETjvMwiP6vWOiP8FvHYWEXpH6d1UN8KbP0aU
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <67094974373C2F4C93A2D94F61CFD0B4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada21463-4ca7-4a53-e7bb-08d670fb88c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2019 21:44:55.5466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3370
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEvMi8xOSAyOjU2IFBNLCBEYXZpZCBSaWVudGplcyB3cm90ZToNCj4gQnkgY29kZSBp
bnNwZWN0aW9uLCBpdCB3YXMgZm91bmQgdGhhdCBtdWx0aXBsZSBjYWxscyB0byBLVk1fU0VWX0lO
SVQNCj4gY291bGQgZGVwbGV0ZSBhc2lkIGJpdHMgYW5kIG92ZXJ3cml0ZSBrdm1fc2V2X2luZm8n
cyByZWdpb25zX2xpc3QuDQo+IA0KPiBNdWx0aXBsZSBjYWxscyB0byBLVk1fU1ZNX0lOSVQgaXMg
bm90IGxpa2VseSB0byBvY2N1ciB3aXRoIFFFTVUsIGJ1dCB0aGlzDQo+IHNob3VsZCBsaWtlbHkg
YmUgZml4ZWQgYW55d2F5Lg0KPiANCj4gVGhpcyBjb2RlIGlzIHNlcmlhbGl6ZWQgYnkga3ZtLT5s
b2NrLg0KPiANCj4gRml4ZXM6IDE2NTRlZmNiYzQzMSAoIktWTTogU1ZNOiBBZGQgS1ZNX1NFVl9J
TklUIGNvbW1hbmQiKQ0KPiBSZXBvcnRlZC1ieTogQ2ZpciBDb2hlbiA8Y2ZpckBnb29nbGUuY29t
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBSaWVudGplcyA8cmllbnRqZXNAZ29vZ2xlLmNvbT4N
Cg0KVGhhbmtzIGZvciB0aGUgcGF0Y2guIExvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBCcmlq
ZXNoIFNpbmdoIDxicmlqZXNoLnNpbmdoQGFtZC5jb20+DQoNCg==
