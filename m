Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9958C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783992146D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="H8uXHdfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783992146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbeKUFpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 00:45:54 -0500
Received: from mail-eopbgr820078.outbound.protection.outlook.com ([40.107.82.78]:33760
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726105AbeKUFpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 00:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9eOj6p9znh/0s9lu/VRRmZHRwL+HbXNOfmECl/RRFU=;
 b=H8uXHdfKsF8V1dsfds2ASwhqGcL+oaqdRXnUC6qAMbRokYA095yGHmrGeje1cU6sZP6mGk9ZHtGEB4O4bIAlcR82j2UaLaJNiSL9sQ6p/GzZGqzjmhJxTc+NBq0Lndy5gc1slESBgGqqLMxb5stBADLo8Vo6iHzTbElqfHPS4IM=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1324.namprd12.prod.outlook.com (10.168.238.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Tue, 20 Nov 2018 19:15:07 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952%2]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 19:15:07 +0000
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
Subject: RE: [PATCH v8 05/13] arch/resctrl: Rename config parameter INTEL_RDT
 to RESCTRL
Thread-Topic: [PATCH v8 05/13] arch/resctrl: Rename config parameter INTEL_RDT
 to RESCTRL
Thread-Index: AQHUfe6S6lG2NdRHyEiL+FwaPftriaVYbrqAgACfA7A=
Date:   Tue, 20 Nov 2018 19:15:07 +0000
Message-ID: <DM5PR12MB2471B115025AA0354CAE516E95D90@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <20181116205407.10457-1-babu.moger@amd.com>
 <20181116205407.10457-6-babu.moger@amd.com> <20181120094205.GC2527@zn.tnic>
In-Reply-To: <20181120094205.GC2527@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1324;20:vv9FCOO+NSK6Hpqx7dzsVna/mE/oPYm5Ji7XmmuXkCbYGwIhucQWK/rjPlyM+UmhHxkeOrbBzjQKau252aBlFpeQKBT4ow8mxcSU0ZFuWRCEt6W2xxLPXqkrgLwlXud7Rg/FC6A7Lfwpr0/OxW6Cr+LEQT9qHf8YU/YFYd6vDxyiRGKilV2sRDZNhYxtx+Ebh6iMgisgLMok0l5lQT5kDL7XtAqvbH3wPGl4QLq+anO/gXm9Gw4gHDkN+V5WfYFY
x-ms-office365-filtering-correlation-id: 06fd1b5b-15f1-4109-a032-08d64f1c7bc7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1324;
x-ms-traffictypediagnostic: DM5PR12MB1324:
x-microsoft-antispam-prvs: <DM5PR12MB13245FB5FC72DDDF73FB8A1295D90@DM5PR12MB1324.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231442)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1324;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1324;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(366004)(346002)(376002)(13464003)(199004)(189003)(256004)(6506007)(53546011)(186003)(102836004)(26005)(316002)(25786009)(446003)(476003)(11346002)(72206003)(486006)(478600001)(68736007)(8676002)(55016002)(6246003)(9686003)(53936002)(81156014)(81166006)(8936002)(66066001)(3846002)(6116002)(74316002)(5660300001)(2906002)(7416002)(305945005)(7406005)(7696005)(99286004)(76176011)(54906003)(7736002)(2900100001)(86362001)(575784001)(71200400001)(71190400001)(105586002)(6916009)(14454004)(4326008)(6436002)(229853002)(97736004)(106356001)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1324;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: O1BBp2+hsNy8CnuoLuTIk8MBWFDNvZlCREf2pWby+3y/WgrSvDWBLjjj9b+lLZCQOMKWlcg45DCv6xIE99FUS6PbOd/mpoGEuZ4P4izgOn95tqIdsd9iBaO53g6yri5286CYyiT8QQDEU/xNuggwZTPr4iBLFwaXqFLrc4nLNjDkIo8m2+3jqwiRphQNHuHmOwQpDPZYuwV9G726USLu2/mgvzFIPOJJMNWtkDmZ1JZbwJpxFiqIMbtlSizLKWeQnS2QnI+ulRvY27PyVKEEKMU0ffRuQV4OivrvnW9sX426lkOYJoCxEJeubNkWaw9zNbCpmiR3wH1tJe2+LiQeczpGPsXXiOp7AfhriOjDhUQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fd1b5b-15f1-4109-a032-08d64f1c7bc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 19:15:07.1206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1324
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qm9yaXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXNsYXYg
UGV0a292IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDIwLCAyMDE4
IDM6NDIgQU0NCj4gVG86IE1vZ2VyLCBCYWJ1IDxCYWJ1Lk1vZ2VyQGFtZC5jb20+DQo+IENjOiB0
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
IDA1LzEzXSBhcmNoL3Jlc2N0cmw6IFJlbmFtZSBjb25maWcgcGFyYW1ldGVyDQo+IElOVEVMX1JE
VCB0byBSRVNDVFJMDQo+IA0KPiBPbiBGcmksIE5vdiAxNiwgMjAxOCBhdCAwODo1NDozMFBNICsw
MDAwLCBNb2dlciwgQmFidSB3cm90ZToNCj4gPiBOb3cgUmVzb3VyY2UgY29udHJvbCBmZWF0dXJl
IGlzIHN1cHBvcnRlZCBieSBib3RoIEludGVsIGFuZCBBTUQuDQo+ID4gUmVuYW1lIHRoZSBJTlRF
TF9SRFQgdG8gdmVuZG9yIG5ldXRyYWwgUkVTQ1RSTC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEJhYnUgTW9nZXIgPGJhYnUubW9nZXJAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC94ODYv
S2NvbmZpZyAgICAgICAgICAgICAgICAgICAgIHwgNCArKy0tDQo+ID4gIGFyY2gveDg2L2luY2x1
ZGUvYXNtL3Jlc2N0cmxfc2NoZWQuaCB8IDQgKystLQ0KPiA+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1
L01ha2VmaWxlICAgICAgICAgfCA0ICsrLS0NCj4gPiAgaW5jbHVkZS9saW51eC9zY2hlZC5oICAg
ICAgICAgICAgICAgIHwgMiArLQ0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygr
KSwgNyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9LY29uZmln
IGIvYXJjaC94ODYvS2NvbmZpZw0KPiA+IGluZGV4IDFhMGJlMDIyZjkxZC4uNGFhZTdhYmE0ZDYx
IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L0tjb25maWcNCj4gPiArKysgYi9hcmNoL3g4Ni9L
Y29uZmlnDQo+ID4gQEAgLTQ0NSw4ICs0NDUsOCBAQCBjb25maWcgUkVUUE9MSU5FDQo+ID4gIAkg
IGNvZGUgYXJlIGVsaW1pbmF0ZWQuIFNpbmNlIHRoaXMgaW5jbHVkZXMgdGhlIHN5c2NhbGwgZW50
cnkgcGF0aCwNCj4gPiAgCSAgaXQgaXMgbm90IGVudGlyZWx5IHBvaW50bGVzcy4NCj4gPg0KPiA+
IC1jb25maWcgSU5URUxfUkRUDQo+ID4gLQlib29sICJJbnRlbCBSZXNvdXJjZSBEaXJlY3RvciBU
ZWNobm9sb2d5IHN1cHBvcnQiDQo+ID4gK2NvbmZpZyBSRVNDVFJMDQo+ID4gKwlib29sICJSZXNv
dXJjZSBDb250cm9sIGZlYXR1cmUgc3VwcG9ydCINCj4gDQo+IHMvZmVhdHVyZSAvLyAtIHRoZXkn
cmUgYWxsIGZlYXR1cmVzLiA6KQ0KDQpPayBzdXJlDQo+IA0KPiA+ICAJZGVmYXVsdCBuDQo+ID4g
IAlkZXBlbmRzIG9uIFg4NiAmJiBDUFVfU1VQX0lOVEVMDQo+IA0KPiBQYXRjaCA5LzEzIGlzIGJl
Z2dpbmcgdG8gYmUgbWVyZ2VkIHdpdGggdGhpcyBvbmUuDQoNCk9rLiBJIHdpbGwgbWVyZ2UgdGhl
c2UgY2hhbmdlcyBpbiBwYXRjaCA5LzEzLg0KDQo+IA0KPiAtLQ0KPiBSZWdhcmRzL0dydXNzLA0K
PiAgICAgQm9yaXMuDQo+IA0KPiBHb29kIG1haWxpbmcgcHJhY3RpY2VzIGZvciA0MDA6IGF2b2lk
IHRvcC1wb3N0aW5nIGFuZCB0cmltIHRoZSByZXBseS4NCg==
