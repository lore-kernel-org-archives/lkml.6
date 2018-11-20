Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF88C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FB0206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MMPqZGRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1FB0206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbeKUDC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:02:59 -0500
Received: from mail-eopbgr790082.outbound.protection.outlook.com ([40.107.79.82]:60784
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726499AbeKUDC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=na/mEBFDxdgnqyqmwi6rwI01z7bHypdXVMAqrUp5iZM=;
 b=MMPqZGRI64ag3Hy77iIeGeixBUUGGsb9WZPL9NSUsUzhcmX/ScjGqpQ2dd1rj3wbe/I0Vb0WEgtXYFagndcUdV9lrrGZPXUCUVXuKtGQClkxWTJ9JDvJj8mjHhpAoAtJW5Im2aU0HI0PF5cfux97BGV2XbZhF716TxOL5KHHBtQ=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1436.namprd12.prod.outlook.com (10.168.239.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Tue, 20 Nov 2018 16:32:49 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952%2]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 16:32:49 +0000
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
Subject: RE: [PATCH v8 04/13] arch/resctrl: Bring all the macros to resctrl.h
Thread-Topic: [PATCH v8 04/13] arch/resctrl: Bring all the macros to resctrl.h
Thread-Index: AQHUfe6Qs5vlQ6iqdk+YBrFobDu7S6VYbP+AgAB0OdA=
Date:   Tue, 20 Nov 2018 16:32:49 +0000
Message-ID: <DM5PR12MB2471EA1640938E33767886E395D90@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <20181116205407.10457-1-babu.moger@amd.com>
 <20181116205407.10457-5-babu.moger@amd.com> <20181120093553.GB2527@zn.tnic>
In-Reply-To: <20181120093553.GB2527@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1436;20:H5o3AGhiJE3wwWKJVTJmTWEjvt4gUvbl0/3AAca6rzRLttfAP7wVWQIHJajMpF+gnTKdWWkqUhWRDlGou61t9iOeHZLdHHg4tzD4k68gDSYnt1R0azIiXx/VaxbaBXm5rzGAP1HzXbeWvLkajgptkkCSbClS5hck9HXH7gml9t3cDfaMUkRkPtHXVzRkPf4teH5eKMn+4drqYjDlp3CwDCDRzx39i1Iq7V9J+VpZWEEcI9XVUmvn0Scn2Ipt52yk
x-ms-office365-filtering-correlation-id: 558000fe-b838-45e6-8df8-08d64f05cf82
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1436;
x-ms-traffictypediagnostic: DM5PR12MB1436:
x-microsoft-antispam-prvs: <DM5PR12MB143682518467DB6C25162E7295D90@DM5PR12MB1436.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231442)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1436;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1436;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(396003)(39860400002)(136003)(189003)(13464003)(199004)(2900100001)(97736004)(74316002)(305945005)(2906002)(7736002)(7406005)(7416002)(6916009)(256004)(66066001)(7696005)(8936002)(76176011)(5660300001)(99286004)(71200400001)(68736007)(55016002)(9686003)(71190400001)(106356001)(105586002)(33656002)(575784001)(486006)(81166006)(86362001)(476003)(54906003)(6246003)(102836004)(25786009)(26005)(4326008)(8676002)(229853002)(186003)(11346002)(14454004)(478600001)(53546011)(6436002)(446003)(81156014)(6506007)(72206003)(53936002)(316002)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1436;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: t3Sv2ppE/ZnLqO1+rDBXI6/30feVEB+I+t6vcB2abAYqL2eIx2YsmBgE8fhBAswOS6+l0kC850TMfr72Kb3S8ieHbCJsbyR/7EvKPd7dJVTWjGiafo1SVD0GIR2JRruubXYDL/ZFaOjjR2tX74oNRHy4XHQn8Dphye7dkLtBi3+HpD0bliIVtwIC/XUbHkBw7OdxhqRg2kxOu3pcMrSwynV3SJ82niAHy4q0unkW3xqz9a/PAI7/uEuj6/ZN562Iu7YlL3pAw+Gyx8Q0gwwoGvUAneGkXb/HYVXTIb7jftgV/gOhqiwtOsocFf+uYZnP6Fx3fOiAYSQfALzwJ1ZiawDAip1TlgOIiSvc36swGts=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558000fe-b838-45e6-8df8-08d64f05cf82
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 16:32:49.2030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1436
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qm9yaXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXNsYXYg
UGV0a292IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDIwLCAyMDE4
IDM6MzYgQU0NCj4gVG86IE1vZ2VyLCBCYWJ1IDxCYWJ1Lk1vZ2VyQGFtZC5jb20+DQo+IENjOiB0
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
IDA0LzEzXSBhcmNoL3Jlc2N0cmw6IEJyaW5nIGFsbCB0aGUgbWFjcm9zIHRvIHJlc2N0cmwuaA0K
PiANCj4gT24gRnJpLCBOb3YgMTYsIDIwMTggYXQgMDg6NTQ6MjhQTSArMDAwMCwgTW9nZXIsIEJh
YnUgd3JvdGU6DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybF9t
b25pdG9yLmMNCj4gYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmxfbW9uaXRvci5jDQo+ID4g
aW5kZXggNmQ2NTRmN2IwZWJhLi45ZmQ2MjI2M2RhYmQgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94
ODYva2VybmVsL2NwdS9yZXNjdHJsX21vbml0b3IuYw0KPiA+ICsrKyBiL2FyY2gveDg2L2tlcm5l
bC9jcHUvcmVzY3RybF9tb25pdG9yLmMNCj4gPiBAQCAtMjgsOSArMjgsNiBAQA0KPiA+ICAjaW5j
bHVkZSA8YXNtL2NwdV9kZXZpY2VfaWQuaD4NCj4gPiAgI2luY2x1ZGUgInJlc2N0cmwuaCINCj4g
Pg0KPiA+IC0jZGVmaW5lIE1TUl9JQTMyX1FNX0NUUgkJMHgwYzhlDQo+ID4gLSNkZWZpbmUgTVNS
X0lBMzJfUU1fRVZUU0VMCQkweDBjOGQNCj4gPiAtDQo+ID4gIHN0cnVjdCBybWlkX2VudHJ5IHsN
Cj4gPiAgCXUzMgkJCQlybWlkOw0KPiA+ICAJaW50CQkJCWJ1c3k7DQo+ID4gQEAgLTk3LDggKzk0
LDggQEAgc3RhdGljIHU2NCBfX3JtaWRfcmVhZCh1MzIgcm1pZCwgdTMyIGV2ZW50aWQpDQo+ID4g
IAkgKiBJQTMyX1FNX0NUUi5FcnJvciAoYml0IDYzKSBhbmQgSUEzMl9RTV9DVFIuVW5hdmFpbGFi
bGUgKGJpdCA2MikNCj4gPiAgCSAqIGFyZSBlcnJvciBiaXRzLg0KPiA+ICAJICovDQo+ID4gLQl3
cm1zcihNU1JfSUEzMl9RTV9FVlRTRUwsIGV2ZW50aWQsIHJtaWQpOw0KPiA+IC0JcmRtc3JsKE1T
Ul9JQTMyX1FNX0NUUiwgdmFsKTsNCj4gPiArCXdybXNyKElBMzJfUU1fRVZUU0VMLCBldmVudGlk
LCBybWlkKTsNCj4gPiArCXJkbXNybChJQTMyX1FNX0NUUiwgdmFsKTsNCj4gDQo+IFdlbGwsIGlm
IHlvdSBoYXZlIGEgbG9vayBhdCBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3ItaW5kZXguaCwgeW91
J2xsIHNlZQ0KPiB0aGF0IGFsbCBNU1IgZGVmaW5lcyBhcmUgcHJlZml4ZWQgd2l0aCAiTVNSXyIg
c28gZHJvcHBpbmcgdGhhdCBwcmVmaXgNCj4gaGVyZSBsb3NlcyBpbmZvcm1hdGlvbiBhbmQgc3Rh
cmluZyBhdCB0aGUgZGVmaW5lIGRvZXNuJ3QgdGVsbCBtZSB3aGF0IGl0DQo+IGlzLg0KDQpPay4g
U3VyZS4gV2lsbCByZXRhaW4gTVNSXy4NCg0KPiANCj4gLS0NCj4gUmVnYXJkcy9HcnVzcywNCj4g
ICAgIEJvcmlzLg0KPiANCj4gR29vZCBtYWlsaW5nIHByYWN0aWNlcyBmb3IgNDAwOiBhdm9pZCB0
b3AtcG9zdGluZyBhbmQgdHJpbSB0aGUgcmVwbHkuDQo=
