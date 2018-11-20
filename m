Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90374C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365FD206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YPKWxAgb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365FD206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbeKUDCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:02:02 -0500
Received: from mail-eopbgr790040.outbound.protection.outlook.com ([40.107.79.40]:37312
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbeKUDCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHuSQYsf4jiYeQRs++Vm+uowfVNK51//utYwiwYGuEE=;
 b=YPKWxAgbz3vmxQCLdKvQB2zvP6QbeGjboA07WmUNPTf3KnPkdbW9z05L5ulLwkh79KdP5qkXzRHY8HmH+s+4KmRi0MKpOyK8E7Ka2ZtoDlXylnZ00Kf6G/A4l8r6Fm+W3ZCoWbEnjVNIKjjWofVmHtwqpjUKctq7xAecyEmpTu4=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1612.namprd12.prod.outlook.com (10.172.40.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.25; Tue, 20 Nov 2018 16:31:42 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952%2]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 16:31:42 +0000
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
Subject: RE: [PATCH v8 03/13] arch/resctrl: Re-arrange RDT init code
Thread-Topic: [PATCH v8 03/13] arch/resctrl: Re-arrange RDT init code
Thread-Index: AQHUfe6PY68KWCX7TUy3HUgk7ikpIKVYarMAgAB0AvA=
Date:   Tue, 20 Nov 2018 16:31:41 +0000
Message-ID: <DM5PR12MB2471D68B6B05FE8245DCEC9895D90@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <20181116205407.10457-1-babu.moger@amd.com>
 <20181116205407.10457-4-babu.moger@amd.com> <20181120092740.GA2527@zn.tnic>
In-Reply-To: <20181120092740.GA2527@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1612;20:CzEg61dcoeAoP08Bl4wPUeCrn+WzDp4r0xcqbju3Y53Y6Lmd+3yxpdyvZTfUo5lKhc9QGstUdxlmk/mxEaXKXJgWW+U4AD7GvpAGY2gYdgMBzt+dyI7+p/FjKxN4UXB76eH1abOY5vH/zomT3rZreSmrja5KS45ltI7E01P9Sx1RWT+F7jUkgNvAr2dackcs3w7hRL9C6rriFSM/U8RfbDq2VO61piiefj9CF27RMkRwCOzN/RhCHocJkKmjwbrG
x-ms-office365-filtering-correlation-id: 6a4fda24-1014-4bf3-c8ac-08d64f05a765
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1612;
x-ms-traffictypediagnostic: DM5PR12MB1612:
x-microsoft-antispam-prvs: <DM5PR12MB1612B030BAA641D1CB039C1795D90@DM5PR12MB1612.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231442)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1612;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1612;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39860400002)(199004)(43544003)(13464003)(189003)(105586002)(53546011)(316002)(33656002)(7696005)(478600001)(256004)(53936002)(74316002)(25786009)(106356001)(6436002)(4326008)(71190400001)(6506007)(6246003)(71200400001)(66066001)(446003)(68736007)(186003)(5660300001)(99286004)(97736004)(26005)(7736002)(102836004)(476003)(6916009)(305945005)(229853002)(2906002)(7416002)(55016002)(72206003)(486006)(2900100001)(81156014)(81166006)(86362001)(6116002)(9686003)(8936002)(3846002)(11346002)(7406005)(54906003)(8676002)(14454004)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1612;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ViY49TSiJOqClUKuC4OJXj904xKm1ZAnkiEVfDRqGNRveS/8rLNifOe0Kuiq+wkpTHlKuK6nbU4+GdnZBxNlpXjgkVKj10Epso40YRxH4HavDOQvXQChc4khPXc9N+c+zfcSlsKP/4lKXT8Q1KqdhtLEGLxB+QA51VGC+pjBoaJgbSUNqu6rLnpXDSYkIyMcX4jsV60wE3GfB6b2zHZh7TCIYA+wQcuU7KEYAh+vwuKTJ53hoazYB7JmZl466fSZ8IFH6NH9J2adY0hCllzwSMYQlslpiwBpGMZZIZKGiwLvtBOhBBMY1QKc6WQcYo45XqqWmJvdv5mg31yTqmt0rpCRJdn5s8ABiFOQ1Ze+zm4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4fda24-1014-4bf3-c8ac-08d64f05a765
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 16:31:41.8587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1612
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qm9yaXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXNsYXYg
UGV0a292IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDIwLCAyMDE4
IDM6MjggQU0NCj4gVG86IE1vZ2VyLCBCYWJ1IDxCYWJ1Lk1vZ2VyQGFtZC5jb20+DQo+IENjOiB0
Z2x4QGxpbnV0cm9uaXguZGU7IG1pbmdvQHJlZGhhdC5jb207IGNvcmJldEBsd24ubmV0Ow0KPiBm
ZW5naHVhLnl1QGludGVsLmNvbTsgcmVpbmV0dGUuY2hhdHJlQGludGVsLmNvbTsgcGV0ZXJ6QGlu
ZnJhZGVhZC5vcmc7DQo+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBkYXZlbUBkYXZlbWxv
ZnQubmV0OyBha3BtQGxpbnV4LQ0KPiBmb3VuZGF0aW9uLm9yZzsgaHBhQHp5dG9yLmNvbTsgeDg2
QGtlcm5lbC5vcmc7DQo+IG1jaGVoYWIrc2Ftc3VuZ0BrZXJuZWwub3JnOyBhcm5kQGFybmRiLmRl
Ow0KPiBrc3Rld2FydEBsaW51eGZvdW5kYXRpb24ub3JnOyBwb21icmVkYW5uZUBuZXhiLmNvbTsN
Cj4gcmFmYWVsQGtlcm5lbC5vcmc7IGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb207IHRv
bnkubHVja0BpbnRlbC5jb207DQo+IHFpYW55dWUuempAYWxpYmFiYS1pbmMuY29tOyB4aWFvY2hl
bi5zaGVuQGludGVsLmNvbTsNCj4gcGJvbnppbmlAcmVkaGF0LmNvbTsgU2luZ2gsIEJyaWplc2gg
PGJyaWplc2guc2luZ2hAYW1kLmNvbT47IEh1cndpdHosDQo+IFNoZXJyeSA8c2hlcnJ5Lmh1cndp
dHpAYW1kLmNvbT47IGR3bXcyQGluZnJhZGVhZC5vcmc7IExlbmRhY2t5LA0KPiBUaG9tYXMgPFRo
b21hcy5MZW5kYWNreUBhbWQuY29tPjsgbHV0b0BrZXJuZWwub3JnOyBqb3JvQDhieXRlcy5vcmc7
DQo+IGphbm5oQGdvb2dsZS5jb207IHZrdXpuZXRzQHJlZGhhdC5jb207IHJpYW5AYWx1bS5taXQu
ZWR1Ow0KPiBqcG9pbWJvZUByZWRoYXQuY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC0NCj4gZG9jQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4
IDAzLzEzXSBhcmNoL3Jlc2N0cmw6IFJlLWFycmFuZ2UgUkRUIGluaXQgY29kZQ0KPiANCj4gT24g
RnJpLCBOb3YgMTYsIDIwMTggYXQgMDg6NTQ6MjZQTSArMDAwMCwgTW9nZXIsIEJhYnUgd3JvdGU6
DQo+ID4gU2VwYXJhdGUgdGhlIGNhbGwgc2VxdWVuY2UgZm9yIHJkdF9xdWlya3MgYW5kIE1CQSBm
ZWF0dXJlLg0KPiA+IFRoaXMgaXMgaW4gcHJlcGFyYXRpb24gdG8gaGFuZGxlIHZlbmRvciBkaWZm
ZXJlbmNlcyBpbiB0aGVzZQ0KPiA+IGNhbGwgc2VxdWVuY2VzLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogQmFidSBNb2dlciA8YmFidS5tb2dlckBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNo
L3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwuYyB8IDI3ICsrKysrKysrKysrKysrKysrKysrKy0tLS0t
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwuYyBiL2Fy
Y2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC5jDQo+ID4gaW5kZXggNWQ1MjZkYzQ1NzUxLi40Y2Vh
Mjc1YzdjNTcgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsLmMN
Cj4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwuYw0KPiA+IEBAIC03OTQsNiAr
Nzk0LDE0IEBAIHN0YXRpYyBib29sIF9faW5pdCByZHRfY3B1X2hhcyhpbnQgZmxhZykNCj4gPiAg
CXJldHVybiByZXQ7DQo+ID4gIH0NCj4gDQo+IEp1c3Qgbml0cGlja3M6DQo+IA0KPiA+ICtzdGF0
aWMgX19pbml0IGJvb2wgcmR0X21iYV9jb25maWcodm9pZCkNCj4gDQo+IFRoYXQgZnVuY3Rpb24g
ZG9lc24ndCBoYXZlIGEgdmVyYiBpbiBpdHMgbmFtZSBidXQgaXQgbmVlZHMgdG8gaGF2ZSBvbmUN
Cj4gc3RhdGluZyB3aGF0IGl0IGRvZXMuIFlvdSBjb3VsZCBkbw0KPiANCj4gbXYgcmR0X2dldF9t
ZW1fY29uZmlnKCkgLT4gX19yZHRfZ2V0X21lbV9jb25maWcoKQ0KPiBtdiByZHRfbWJhX2NvbmZp
ZygpIC0+IHJkdF9nZXRfbWVtX2NvbmZpZygpDQo+IA0KPiB0byBoYXZlIHRoZSBoaWVyYXJjaHkg
b2Ygd2hhdCBjYWxscyB3aGF0LiBBbmQgdGhlbiB0aGUgQU1EIHZhcmlhbnQgd2lsbA0KPiBiZSBj
YWxsZWQgX19yZHRfZ2V0X21lbV9jb25maWdfYW1kKCkuDQo+IA0KPiBBbHNvLCB0aG9zZSBhcmUg
YWxsIHN0YXRpYyBmdW5jdGlvbnMgc28geW91IGNhbiBqdXN0IGFzIHdlbGwgZHJvcCB0aGUNCj4g
InJkdCIgcHJlZml4LCBJJ2Qgc2F5Lg0KDQpPay4gU3VyZS4gV2lsbCB0YWtlIGNhcmUgb2YgdGhl
c2UuDQoNCj4gDQo+ID4gK3sNCj4gPiArCWlmIChyZHRfY3B1X2hhcyhYODZfRkVBVFVSRV9NQkEp
KQ0KPiA+ICsJCXJldHVybg0KPiByZHRfZ2V0X21lbV9jb25maWcoJnJkdF9yZXNvdXJjZXNfYWxs
W1JEVF9SRVNPVVJDRV9NQkFdKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gZmFsc2U7DQo+ID4gK30N
Cj4gPiArDQo+ID4gIHN0YXRpYyBfX2luaXQgYm9vbCBnZXRfcmR0X2FsbG9jX3Jlc291cmNlcyh2
b2lkKQ0KPiA+ICB7DQo+ID4gIAlib29sIHJldCA9IGZhbHNlOw0KPiA+IEBAIC04MTgsMTAgKzgy
Niw5IEBAIHN0YXRpYyBfX2luaXQgYm9vbCBnZXRfcmR0X2FsbG9jX3Jlc291cmNlcyh2b2lkKQ0K
PiA+ICAJCXJldCA9IHRydWU7DQo+ID4gIAl9DQo+ID4NCj4gPiAtCWlmIChyZHRfY3B1X2hhcyhY
ODZfRkVBVFVSRV9NQkEpKSB7DQo+ID4gLQkJaWYNCj4gKHJkdF9nZXRfbWVtX2NvbmZpZygmcmR0
X3Jlc291cmNlc19hbGxbUkRUX1JFU09VUkNFX01CQV0pKQ0KPiA+IC0JCQlyZXQgPSB0cnVlOw0K
PiA+IC0JfQ0KPiA+ICsJaWYgKHJkdF9tYmFfY29uZmlnKCkpDQo+ID4gKwkJcmV0ID0gdHJ1ZTsN
Cj4gPiArDQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4NCj4gPiBAQCAtODQwLDcgKzg0
Nyw3IEBAIHN0YXRpYyBfX2luaXQgYm9vbCBnZXRfcmR0X21vbl9yZXNvdXJjZXModm9pZCkNCj4g
PiAgCXJldHVybg0KPiAhcmR0X2dldF9tb25fbDNfY29uZmlnKCZyZHRfcmVzb3VyY2VzX2FsbFtS
RFRfUkVTT1VSQ0VfTDNdKTsNCj4gPiAgfQ0KPiA+DQo+ID4gLXN0YXRpYyBfX2luaXQgdm9pZCBy
ZHRfcXVpcmtzKHZvaWQpDQo+ID4gK3N0YXRpYyBfX2luaXQgdm9pZCByZHRfcXVpcmtzX2ludGVs
KHZvaWQpDQo+ID4gIHsNCj4gPiAgCXN3aXRjaCAoYm9vdF9jcHVfZGF0YS54ODZfbW9kZWwpIHsN
Cj4gPiAgCWNhc2UgSU5URUxfRkFNNl9IQVNXRUxMX1g6DQo+ID4gQEAgLTg1NSw5ICs4NjIsMTQg
QEAgc3RhdGljIF9faW5pdCB2b2lkIHJkdF9xdWlya3Modm9pZCkNCj4gPiAgCX0NCj4gPiAgfQ0K
PiA+DQo+ID4gK3N0YXRpYyBfX2luaXQgdm9pZCByZHRfcXVpcmtzKHZvaWQpDQo+IA0KPiBUaG9z
ZSBmdW5jdGlvbnMgYWxzbyBuZWVkIHRvIGhhdmUgYSB2ZXJiIGluIHRoZSBuYW1lIHN0YXRpbmcg
d2hhdCB0aGV5DQo+IGRvLg0KDQpPay4gV2lsbCBjaGFuZ2UgaXQgdG8gcmR0X2NoZWNrX3F1aXJr
cy4NCg0KPiANCj4gPiArew0KPiA+ICsJaWYgKGJvb3RfY3B1X2RhdGEueDg2X3ZlbmRvciA9PSBY
ODZfVkVORE9SX0lOVEVMKQ0KPiA+ICsJCXJkdF9xdWlya3NfaW50ZWwoKTsNCj4gPiArfQ0KPiA+
ICsNCj4gPiAgc3RhdGljIF9faW5pdCBib29sIGdldF9yZHRfcmVzb3VyY2VzKHZvaWQpDQo+ID4g
IHsNCj4gPiAtCXJkdF9xdWlya3MoKTsNCj4gPiAgCXJkdF9hbGxvY19jYXBhYmxlID0gZ2V0X3Jk
dF9hbGxvY19yZXNvdXJjZXMoKTsNCj4gPiAgCXJkdF9tb25fY2FwYWJsZSA9IGdldF9yZHRfbW9u
X3Jlc291cmNlcygpOw0KPiA+DQo+ID4gQEAgLTg3MSw2ICs4ODMsOSBAQCBzdGF0aWMgaW50IF9f
aW5pdCByZXNjdHJsX2xhdGVfaW5pdCh2b2lkKQ0KPiA+ICAJc3RydWN0IHJkdF9yZXNvdXJjZSAq
cjsNCj4gPiAgCWludCBzdGF0ZSwgcmV0Ow0KPiA+DQo+ID4gKwkvKiBSdW4gcXVpcmtzIGZpcnN0
ICovDQo+ID4gKwlyZHRfcXVpcmtzKCk7DQo+IA0KPiBJZiB0aGUgY29tbWVudCB3YXNuJ3QgdGhl
cmUsIHNlZWluZyAicmR0X3F1aXJrcygpOyIgZG9lc24ndCBzYXkgbXVjaCBhbmQNCj4gbWFrZXMg
bWUgZ28gbG9vayBhdCB3aGF0IHRoYXQgZnVuY3Rpb24gZG9lcy4NCg0KV2lsbCByZW1vdmUgdGhl
IGNvbW1lbnQgYW5kIHJlbmFtZSB0aGUgZnVuY3Rpb24gdG8gcmR0X2NoZWNrX3F1aXJrcygpLg0K
DQo+IA0KPiA+ICsNCj4gPiAgCWlmICghZ2V0X3JkdF9yZXNvdXJjZXMoKSkNCj4gDQo+IFVubGlr
ZSBoZXJlLCB3aGVyZSBpdCBpcyBjbGVhciB0aGF0IHRoaXMgZ2V0cyB0aGUgcmR0IHJlc291cmNl
cy4NCj4gDQo+IFRoeC4NCj4gDQo+IC0tDQo+IFJlZ2FyZHMvR3J1c3MsDQo+ICAgICBCb3Jpcy4N
Cj4gDQo+IEdvb2QgbWFpbGluZyBwcmFjdGljZXMgZm9yIDQwMDogYXZvaWQgdG9wLXBvc3Rpbmcg
YW5kIHRyaW0gdGhlIHJlcGx5Lg0K
