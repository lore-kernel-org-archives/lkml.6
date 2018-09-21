Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F06ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76D221550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Fc7fmy39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76D221550
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391343AbeIVBkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:40:45 -0400
Received: from mail-eopbgr720102.outbound.protection.outlook.com ([40.107.72.102]:42679
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390726AbeIVBko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nivHmXV0nqP6hvF0DUTzRoK8TUi0o/nLxmKQ+a8f7ps=;
 b=Fc7fmy39E6Lmi3bPSd+EdyckAuRe/JN3slZ0fgtDOvrIuLzEJ+rZYGLIx8ORGLaqgU5LVpLI4SSKTpfJcVCF+fHdGMvVZ1GpH9O1fgeH9k48gaHNq9O33acb5VERsUnl2gZibnxb5X2Nk2MIwP1Bfdv0RqjCEcItKvu2tm9MkEw=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0123.namprd21.prod.outlook.com (10.173.173.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.9; Fri, 21 Sep 2018 19:50:18 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1185.010; Fri, 21 Sep 2018
 19:50:18 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC:     "mhocko@suse.com" <mhocko@suse.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 3/5] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
Thread-Topic: [PATCH v4 3/5] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
Thread-Index: AQHUUTFwJuKfr51oTUOI402VMkePkKT7JkGA
Date:   Fri, 21 Sep 2018 19:50:18 +0000
Message-ID: <2254cfe1-5cd3-eedc-1f24-8e011dcf3575@microsoft.com>
References: <20180920215824.19464.8884.stgit@localhost.localdomain>
 <20180920222758.19464.83992.stgit@localhost.localdomain>
In-Reply-To: <20180920222758.19464.83992.stgit@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0123;6:QEhU5G42EB8oIcyVCGowTkg6hmJGGOooc00KHnjReOMZNX8OG0G5vKWXaIdSuDmoP6vvhk5ka9dsZtSPaHi0lNzjvqWWTfpG+am+o3X+lxIzGbjXpyRKc/Dp+LkuFbherJaaw6+nrFyfa4QV1UZLDEAR/8NDqBE67RUlKS5EQDvP6af64j00z2+Wlvt4rNPKmbGLBQTnuonDpHfjSv321R5x6jazndMwlxk+a/RDYzRD+gkHQtBeuoXQUn22mdiLlFzx4rZQ48Auia7DubQulBh+NltjVmKDbjhNLTGU8kntOcPtTsB/xxBTM6AQ3WyZzoN4LEEJpRyuhPQSoCT26Qmd/VbOE+VdtyvhqXZwphsD144ObjpuhGY9dgSqKxphyxMy3q5KXs6at0Biwh4/JWMnl/N3ZXqgyryMnvfmfkyfP4lVHA5M58zKL36/n4yQG1jRmvONG6CzhoQY0OT1bw==;5:kxnz1iLwep+4Fl7T0zAm2NLwSD9D081oHJCgU1jQQ1RZLx5+1Cz2awr73vN14TkGLZtZZwOgKPQlHaAIipNm5ty3JiV1U1sSp3Cfsm/E3RsrPiPINmnpsa109jalZFQOxYSyu1vvnS0oRXoSktkFD67W1oPL02HKveEKRpcs0D0=;7:GX5uq3H4flIS6VLjNFmUGAmDU2ZcVW2WQrVcGRIpKmnWwZMN5/9NucmGW0/rjDmqEC6L2nBmeTkTvqBvpVJrsEJpB3lMttE3d2/EZs24EqgJfiEsV+9atN5EvVpWF6NVsemfZ22Mu8ghMzhnYOQ83jewyftOm3rqDwqgoVc27oahLpwmqDQ5vrSBTUl3t+ib2KupzHHxa1fnzcQ+UPu4ufveD3MW19WDxfwylr2yPRYgfSPqbCdLJBP7Ch5kMyOy
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fd6f5376-b1ca-49ee-d6e6-08d61ffb7579
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0123;
x-ms-traffictypediagnostic: DM5PR21MB0123:
x-microsoft-antispam-prvs: <DM5PR21MB0123D2A649F94FB00AAC87E39D120@DM5PR21MB0123.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149051)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:DM5PR21MB0123;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0123;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(136003)(366004)(396003)(199004)(189003)(25786009)(36756003)(305945005)(6436002)(7736002)(2201001)(81166006)(81156014)(8676002)(4326008)(53936002)(8936002)(110136005)(2906002)(54906003)(5250100002)(22452003)(71200400001)(68736007)(86612001)(2501003)(5660300001)(71190400001)(31696002)(6512007)(66066001)(6246003)(6486002)(7416002)(316002)(229853002)(10090500001)(72206003)(478600001)(31686004)(6346003)(186003)(486006)(14454004)(86362001)(26005)(11346002)(476003)(2616005)(2900100001)(102836004)(106356001)(105586002)(10290500003)(446003)(14444005)(97736004)(256004)(6506007)(99286004)(76176011)(3846002)(53546011)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0123;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: gA7CF8mWYSYXr2U4q47E+ByuFaXa+oetRp4kOatGjIQZSLf+vPPM7QZr19kMsy9RewicoByOBOvSO/O/B2+J0trXXabL5V56UJwwN97rQKqLnbfWyV4/h6oZSsUtzaeatC1YyYk26nn/JnRr21ZmxDXek/fSv2buKisMw+kzRnLhr8Jz1ggnqbaAJ3Gq3zjcp1ptH6iLlpPMW+tnt6wh0bQKByp4eiq+4ZraCP2AXiNkGrLWmi9joLf4weUK0efjssTbK/pOSYTvMraGhXSZr07pMwHr8adm+6SGjfQ8ssuvzlv8AVdMgFs3tNYHQ4dswinrQ4zm3FrsNvlkrm80uESrGnSulVsx10OB+ZSdxKg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F32675E3C009940AEFBAB1DADA60897@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6f5376-b1ca-49ee-d6e6-08d61ffb7579
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 19:50:18.7194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDkvMjAvMTggNjoyOSBQTSwgQWxleGFuZGVyIER1eWNrIHdyb3RlOg0KPiBUaGUgWk9O
RV9ERVZJQ0UgcGFnZXMgd2VyZSBiZWluZyBpbml0aWFsaXplZCBpbiB0d28gbG9jYXRpb25zLiBP
bmUgd2FzIHdpdGgNCj4gdGhlIG1lbW9yeV9ob3RwbHVnIGxvY2sgaGVsZCBhbmQgYW5vdGhlciB3
YXMgb3V0c2lkZSBvZiB0aGF0IGxvY2suIFRoZQ0KPiBwcm9ibGVtIHdpdGggdGhpcyBpcyB0aGF0
IGl0IHdhcyBuZWFybHkgZG91YmxpbmcgdGhlIG1lbW9yeSBpbml0aWFsaXphdGlvbg0KPiB0aW1l
LiBJbnN0ZWFkIG9mIGRvaW5nIHRoaXMgdHdpY2UsIG9uY2Ugd2hpbGUgaG9sZGluZyBhIGdsb2Jh
bCBsb2NrIGFuZA0KPiBvbmNlIHdpdGhvdXQsIEkgYW0gb3B0aW5nIHRvIGRlZmVyIHRoZSBpbml0
aWFsaXphdGlvbiB0byB0aGUgb25lIG91dHNpZGUgb2YNCj4gdGhlIGxvY2suIFRoaXMgYWxsb3dz
IHVzIHRvIGF2b2lkIHNlcmlhbGl6aW5nIHRoZSBvdmVyaGVhZCBmb3IgbWVtb3J5IGluaXQNCj4g
YW5kIHdlIGNhbiBpbnN0ZWFkIGZvY3VzIG9uIHBlci1ub2RlIGluaXQgdGltZXMuDQo+IA0KPiBP
bmUgaXNzdWUgSSBlbmNvdW50ZXJlZCBpcyB0aGF0IGRldm1fbWVtcmVtYXBfcGFnZXMgYW5kDQo+
IGhtbV9kZXZtbWVtX3BhZ2VzX2NyZWF0ZSB3ZXJlIGluaXRpYWxpemluZyBvbmx5IHRoZSBwZ21h
cCBmaWVsZCB0aGUgc2FtZQ0KPiB3YXkuIE9uZSB3YXNuJ3QgaW5pdGlhbGl6aW5nIGhtbV9kYXRh
LCBhbmQgdGhlIG90aGVyIHdhcyBpbml0aWFsaXppbmcgaXQgdG8NCj4gYSBwb2lzb24gdmFsdWUu
IFNpbmNlIHRoaXMgaXMgc29tZXRoaW5nIHRoYXQgaXMgZXhwb3NlZCB0byB0aGUgZHJpdmVyIGlu
DQo+IHRoZSBjYXNlIG9mIGhtbSBJIGFtIG9wdGluZyBmb3IgYSB0aGlyZCBvcHRpb24gYW5kIGp1
c3QgaW5pdGlhbGl6aW5nDQo+IGhtbV9kYXRhIHRvIDAgc2luY2UgdGhpcyBpcyBnb2luZyB0byBi
ZSBleHBvc2VkIHRvIHVua25vd24gdGhpcmQgcGFydHkNCj4gZHJpdmVycy4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEFsZXhhbmRlciBEdXljayA8YWxleGFuZGVyLmguZHV5Y2tAbGludXguaW50ZWwu
Y29tPg0KDQo+ICt2b2lkIF9fcmVmIG1lbW1hcF9pbml0X3pvbmVfZGV2aWNlKHN0cnVjdCB6b25l
ICp6b25lLA0KPiArCQkJCSAgIHVuc2lnbmVkIGxvbmcgc3RhcnRfcGZuLA0KPiArCQkJCSAgIHVu
c2lnbmVkIGxvbmcgc2l6ZSwNCj4gKwkJCQkgICBzdHJ1Y3QgZGV2X3BhZ2VtYXAgKnBnbWFwKQ0K
PiArew0KPiArCXVuc2lnbmVkIGxvbmcgcGZuLCBlbmRfcGZuID0gc3RhcnRfcGZuICsgc2l6ZTsN
Cj4gKwlzdHJ1Y3QgcGdsaXN0X2RhdGEgKnBnZGF0ID0gem9uZS0+em9uZV9wZ2RhdDsNCj4gKwl1
bnNpZ25lZCBsb25nIHpvbmVfaWR4ID0gem9uZV9pZHgoem9uZSk7DQo+ICsJdW5zaWduZWQgbG9u
ZyBzdGFydCA9IGppZmZpZXM7DQo+ICsJaW50IG5pZCA9IHBnZGF0LT5ub2RlX2lkOw0KPiArDQo+
ICsJaWYgKFdBUk5fT05fT05DRSghcGdtYXAgfHwgIWlzX2Rldl96b25lKHpvbmUpKSkNCj4gKwkJ
cmV0dXJuOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBUaGUgY2FsbCB0byBtZW1tYXBfaW5pdF96b25l
IHNob3VsZCBoYXZlIGFscmVhZHkgdGFrZW4gY2FyZQ0KPiArCSAqIG9mIHRoZSBwYWdlcyByZXNl
cnZlZCBmb3IgdGhlIG1lbW1hcCwgc28gd2UgY2FuIGp1c3QganVtcCB0bw0KPiArCSAqIHRoZSBl
bmQgb2YgdGhhdCByZWdpb24gYW5kIHN0YXJ0IHByb2Nlc3NpbmcgdGhlIGRldmljZSBwYWdlcy4N
Cj4gKwkgKi8NCj4gKwlpZiAocGdtYXAtPmFsdG1hcF92YWxpZCkgew0KPiArCQlzdHJ1Y3Qgdm1l
bV9hbHRtYXAgKmFsdG1hcCA9ICZwZ21hcC0+YWx0bWFwOw0KPiArDQo+ICsJCXN0YXJ0X3BmbiA9
IGFsdG1hcC0+YmFzZV9wZm4gKyB2bWVtX2FsdG1hcF9vZmZzZXQoYWx0bWFwKTsNCj4gKwkJc2l6
ZSA9IGVuZF9wZm4gLSBzdGFydF9wZm47DQo+ICsJfQ0KPiArDQo+ICsJZm9yIChwZm4gPSBzdGFy
dF9wZm47IHBmbiA8IGVuZF9wZm47IHBmbisrKSB7DQo+ICsJCXN0cnVjdCBwYWdlICpwYWdlID0g
cGZuX3RvX3BhZ2UocGZuKTsNCj4gKw0KPiArCQlfX2luaXRfc2luZ2xlX3BhZ2UocGFnZSwgcGZu
LCB6b25lX2lkeCwgbmlkKTsNCj4gKw0KPiArCQkvKg0KPiArCQkgKiBNYXJrIHBhZ2UgcmVzZXJ2
ZWQgYXMgaXQgd2lsbCBuZWVkIHRvIHdhaXQgZm9yIG9ubGluaW5nDQo+ICsJCSAqIHBoYXNlIGZv
ciBpdCB0byBiZSBmdWxseSBhc3NvY2lhdGVkIHdpdGggYSB6b25lLg0KPiArCQkgKg0KPiArCQkg
KiBXZSBjYW4gdXNlIHRoZSBub24tYXRvbWljIF9fc2V0X2JpdCBvcGVyYXRpb24gZm9yIHNldHRp
bmcNCj4gKwkJICogdGhlIGZsYWcgYXMgd2UgYXJlIHN0aWxsIGluaXRpYWxpemluZyB0aGUgcGFn
ZXMuDQo+ICsJCSAqLw0KPiArCQlfX1NldFBhZ2VSZXNlcnZlZChwYWdlKTsNCj4gKw0KPiArCQkv
Kg0KPiArCQkgKiBaT05FX0RFVklDRSBwYWdlcyB1bmlvbiAtPmxydSB3aXRoIGEgLT5wZ21hcCBi
YWNrDQo+ICsJCSAqIHBvaW50ZXIgYW5kIGhtbV9kYXRhLiAgSXQgaXMgYSBidWcgaWYgYSBaT05F
X0RFVklDRQ0KPiArCQkgKiBwYWdlIGlzIGV2ZXIgZnJlZWQgb3IgcGxhY2VkIG9uIGEgZHJpdmVy
LXByaXZhdGUgbGlzdC4NCj4gKwkJICovDQo+ICsJCXBhZ2UtPnBnbWFwID0gcGdtYXA7DQo+ICsJ
CXBhZ2UtPmhtbV9kYXRhID0gMDsNCg0KX19pbml0X3NpbmdsZV9wYWdlKCkNCiAgbW1femVyb19z
dHJ1Y3RfcGFnZSgpDQoNClRha2VzIGNhcmUgb2YgemVyb2luZywgbm8gbmVlZCB0byBkbyBhbm90
aGVyIHN0b3JlIGhlcmUuDQoNCg0KTG9va3MgZ29vZCBvdGhlcndpc2UuDQoNClJldmlld2VkLWJ5
OiBQYXZlbCBUYXRhc2hpbiA8cGF2ZWwudGF0YXNoaW5AbWljcm9zb2Z0LmNvbT4NCg==
