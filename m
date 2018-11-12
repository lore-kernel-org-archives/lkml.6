Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5989DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68BC22419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DXspFMcf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68BC22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbeKMGqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 01:46:45 -0500
Received: from mail-eopbgr690071.outbound.protection.outlook.com ([40.107.69.71]:9002
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725861AbeKMGqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 01:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DthPW8SXIR/DvDXVNS1LKFpoECboW1BLgvoPSMTYSxg=;
 b=DXspFMcfZ1UGrwHt4YKo4+hGd6CD07dr7PjWcExg6QlX1182ifCKpbE71QuAIWlmpGUV8Xf7Kro6DFziV0fK/EU37bzjg8OAMMUT8pO/hKOYqZli0HS1PVvHZrc6kSQ02porEoYchulBRfEBF7dlD+ddMf5+dpgTPxGZwLEpI8M=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1612.namprd12.prod.outlook.com (10.172.40.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Mon, 12 Nov 2018 20:51:45 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.045; Mon, 12 Nov 2018
 20:51:45 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jannh@google.com" <jannh@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rian@alum.mit.edu" <rian@alum.mit.edu>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7 02/13] arch/x86: Rename the RDT functions and
 definitions
Thread-Topic: [PATCH v7 02/13] arch/x86: Rename the RDT functions and
 definitions
Thread-Index: AQHUeG4fqjo7t998rUWNtgkgxfyZ6KVMcSAA//+0O4CAAGp1AIAAElsA
Date:   Mon, 12 Nov 2018 20:51:45 +0000
Message-ID: <8085e1cc-484a-ff75-38ef-7f4da9fb847d@amd.com>
References: <20181109205153.14811-1-babu.moger@amd.com>
 <20181109205153.14811-3-babu.moger@amd.com> <20181112175610.GI8167@zn.tnic>
 <539bf8ea-b13f-186a-f1c7-71b1eaa63aa7@amd.com>
 <20181112194600.GJ8167@zn.tnic>
In-Reply-To: <20181112194600.GJ8167@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0034.namprd05.prod.outlook.com
 (2603:10b6:803:40::47) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1612;20:a6XvyX/13bRSsbkpkKC1giYsEokozADJRTKbe7jR5kaA7usX43kfG8ITI8pfLuJ5Rrz5hTjIQvfAwojauW4ExwN1vErycdHTMxDNUyCV5jXxONRSRXENvZTZKGnIjfTzkXgC+PBsgf9U65mSUkW2l3NlcMJBlDc2M5CBIOc0auQ7ykvMdlOjghkZBJnSgtLpLgo71Hpr9FHkpzl2jzy7pqpoS5a0S97Atl0NuPJ33mMSVT3/quO3kFAiLNmgU7Sf
x-ms-office365-filtering-correlation-id: 85bcb831-8979-4393-7725-08d648e0a834
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1612;
x-ms-traffictypediagnostic: DM5PR12MB1612:
x-microsoft-antispam-prvs: <DM5PR12MB16123C154D1ACF608DAE94B595C10@DM5PR12MB1612.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1612;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1612;
x-forefront-prvs: 0854128AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(376002)(396003)(366004)(199004)(189003)(68736007)(99286004)(36756003)(72206003)(5660300001)(76176011)(97736004)(52116002)(31686004)(2616005)(476003)(486006)(86362001)(25786009)(7736002)(305945005)(11346002)(93886005)(256004)(8936002)(105586002)(7416002)(7406005)(31696002)(66066001)(446003)(186003)(106356001)(8676002)(316002)(71200400001)(26005)(71190400001)(4326008)(2906002)(229853002)(3846002)(6916009)(54906003)(53936002)(6436002)(6512007)(6506007)(53546011)(102836004)(386003)(478600001)(2900100001)(6486002)(6116002)(6246003)(14454004)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1612;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dlUZ6xv9fYZ9WWn85QiA/aV3p/N0pjSyyvrJhMD8/t6AmL4vz1Jms4AGlWdkLmSP5kL++9cmpf1zy/DOyx01WlU95I3bTQltqWUBQ/7qJxQwynnABXSWYf+4yaznGIt1UkcxJ5pfC3SFeLzSaZ5JiofjpLF4hmkJ9mFQmAVNceWDTvHX7/UanKX4IkZccWYYZSSmtWSHpJyUzclqn8AW3LC2GgUZRNEqHOv7Osbr7aCD94MbHvqYXedL4tg83jJGAg3uQ4uEnvs0GCxOggSPm+tumgunJXSEWuknhH8aIaCsOOdWZC7+IfzAhCLYYtki7mHtnUoblGBIa0r6HX1L4lqv+edExR9mXYX1Cbuheao=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <92E7B0DD40253648896E286986E0B574@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85bcb831-8979-4393-7725-08d648e0a834
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2018 20:51:45.5301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1612
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLzEyLzE4IDE6NDYgUE0sIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gTW9u
LCBOb3YgMTIsIDIwMTggYXQgMDc6MjU6MDJQTSArMDAwMCwgTW9nZXIsIEJhYnUgd3JvdGU6DQo+
Pj4+IEBAIC02MzcsMTAgKzYzNywxMSBAQCBpbnQgcmR0X2dldF9tb25fbDNfY29uZmlnKHN0cnVj
dCByZHRfcmVzb3VyY2UgKnIpDQo+Pj4+ICAJICoNCj4+Pj4gIAkgKiBGb3IgYSAzNU1CIExMQyBh
bmQgNTYgUk1JRHMsIHRoaXMgaXMgfjEuOCUgb2YgdGhlIExMQy4NCj4+Pj4gIAkgKi8NCj4+Pj4g
LQlpbnRlbF9jcW1fdGhyZXNob2xkID0gYm9vdF9jcHVfZGF0YS54ODZfY2FjaGVfc2l6ZSAqIDEw
MjQgLyByLT5udW1fcm1pZDsNCj4+Pj4gKwlyZXNjdHJsX2NxbV90aHJlc2hvbGQgPSBib290X2Nw
dV9kYXRhLng4Nl9jYWNoZV9zaXplICogMTAyNCAvDQo+Pj4+ICsJCQkJci0+bnVtX3JtaWQ7DQo+
Pj4NCj4+PiBObyBuZWVkIHRvIGJyZWFrIHRoYXQgbGluZSBoZXJlLg0KPj4NCj4+IFdpdGhvdXQg
dGhlIGxpbmUgYnJlYWssIGNoZWNrcGF0Y2ggY29tcGxhaW5zIGZvciAibGluZSBvdmVyIDgwDQo+
PiBjaGFyYWN0ZXJzIi4gIERvIHlvdSB0aGluayB3ZSBjYW4gaWdub3JlIHRob3NlPw0KPiANCj4g
VG8gcXVvdGUgZnJvbSB0aGUgdGlwIGhhbmRib29rIHdoaWNoIGlzIGluIHByZXBhcmF0aW9uIHJp
Z2h0IG5vdzoNCj4gDQo+ICIrVGhlIDgwIGNoYXJhY3RlciBydWxlIGlzIG5vdCBhIHN0cmljdCBy
dWxlLCBzbyBwbGVhc2UgdXNlIGNvbW1vbiBzZW5zZSB3aGVuDQo+ICArYnJlYWtpbmcgbGluZXMu
Ig0KPiANCj4gSW4gdGhpcyBwYXJ0aWN1bGFyIGNhc2UsIGl0IGlzIG1vcmUgcmVhZGFibGUgSU1P
IHRvIGxlYXZlIHRoZSBsaW5lIHVuYnJva2VuOg0KPiANCj4gCXJlc2N0cmxfY3FtX3RocmVzaG9s
ZCA9IGJvb3RfY3B1X2RhdGEueDg2X2NhY2hlX3NpemUgKiAxMDI0IC8gci0+bnVtX3JtaWQ7DQo+
IA0KPiBXaGF0IGlzIGV2ZW4gbW9yZSByZWFkYWJsZSB0aG91Z2ggaXM6DQo+IA0KPiAJdW5zaWdu
ZWQgaW50IGNsX3NpemUgPSBib290X2NwdV9kYXRhLng4Nl9jYWNoZV9zaXplOw0KPiANCj4gCS4u
Lg0KPiANCj4gCXJlc2N0cmxfY3FtX3RocmVzaG9sZCA9IGNsX3NpemUgKiAxMDI0IC8gci0+bnVt
X3JtaWQ7DQo+IA0KPiBhbmQgbm93IHlvdSBoYXZlIGEgd2luLXdpbiBzaXR1YXRpb24uIDopDQoN
Clllcy4gTWFrZXMgc2Vuc2UuIFRoYW5rcw0KDQo+IA0KPiBUaHguDQo+IA0K
