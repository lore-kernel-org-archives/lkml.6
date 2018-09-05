Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40575C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCCC2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JykFxXPP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BCCC2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeIFByf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 21:54:35 -0400
Received: from mail-by2nam01on0096.outbound.protection.outlook.com ([104.47.34.96]:59072
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727257AbeIFByf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 21:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zCRpF9s8VbQe24ITUZLJmhLJ7WCusDng4Hl5js2w6c=;
 b=JykFxXPPN3lJcmoZKokoqa56w41IVYlLISDBL3b6mcN83/ewnKPAR0FCnJo8gT5jf7v+pr36uwLNZ7RbMhn4b0ooSxAh/RmFoNZNEp77mtd3t2Gzw30okabf92tgvU5XFUN5OglBP8w0sSp4UG7AblfdqofK/TOzkjhG89ZfbzM=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0140.namprd21.prod.outlook.com (10.173.173.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Wed, 5 Sep 2018 21:22:16 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1143.000; Wed, 5 Sep 2018
 21:22:16 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 1/2] mm: Move page struct poisoning to
 CONFIG_DEBUG_VM_PAGE_INIT_POISON
Thread-Topic: [PATCH v2 1/2] mm: Move page struct poisoning to
 CONFIG_DEBUG_VM_PAGE_INIT_POISON
Thread-Index: AQHURV1NzbtPIVbq00mlNM0Zm0ByOKTiMk6A
Date:   Wed, 5 Sep 2018 21:22:16 +0000
Message-ID: <cd1fc4c6-cc86-8bf7-6aa0-b722c56057e3@microsoft.com>
References: <20180905211041.3286.19083.stgit@localhost.localdomain>
 <20180905211328.3286.71674.stgit@localhost.localdomain>
In-Reply-To: <20180905211328.3286.71674.stgit@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0140;6:XdT26DAzrT5qen53mbAs4g8CTmz1SUUxT8A6KGtNa1PrQyG8Sa8PsRIq1hhnZAB6Kr8J/MU9+18jxrweDPl/B6RCYddSeZVizwoTmPTA9itocfN56I5N20ZHSFjlna+TLIZjJ/Pu8T5ispbKyTD/+ua6Fw0qG2WzbODJTozUxGAmjiNcQbrCSJg3rOe6yr0kzTsf9hMGBE46wQbNwdiimgYeC89gH48ny8Aj3tDszu8SfMAs22xj9681Fxg++OY+/8H/YsqXRfk77oisTJhMFHUp2uexaeMRH1arjLokAG2+7Ll28rVwIPWcd6lwDqjWzb+Qub5I1ucwOLHSglWbWvPlNGRtMD+wO2LWRcedbBkqCCUz2O90ss8YzXQgJit4R+0zRX0EGWnJIKaaaykC0CcNdkr4qHHCFfTTCBVZBjN1Z5upm2o4epeGhy3bsM6p5WFip9+X6IET7S9PMJiyZQ==;5:fj6mloX3PW7NMiU+9nv1nXwh2l6kGQbRVmn53uFEhHV40tbQ+1x9B76og/WGAHOibNADf2aa1X2DP7yQ+CxciIGGIQeTCmSV1ZesiS/geyvlkOtt5gqGxfD+naOM/j6BBTXd1LJ207U7boOZHJP3BdyOh02UX9fF41xcYD8NcXo=;7:BPa8zpZ0KVPb6Ecgrixxp9zz5Y3obDE1xG3eMq64avJWv90WgbVGxzEpYzFHenZftANdQQeli8gLKzjGFtOcFLbVHEkUj68ajK294UVmvzX05WTBOLQAnZxgwvz4B9uD5+TwVXtU/7Rh83jvKRRsmLl7C/8cZi5b9fUlWLHU1VkucySfqiPKZcnbv+u0wE70N/d+3H+Btrbu1x9L/MtXY/+AdsQauxkDztY+bUXTQcJ+PAMCGirluQLRqTZ4Iu02
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1b669ca1-19e4-424a-a975-08d61375a7bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0140;
x-ms-traffictypediagnostic: DM5PR21MB0140:
x-microsoft-antispam-prvs: <DM5PR21MB01403536102AA8339F0607A29D020@DM5PR21MB0140.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0140;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0140;
x-forefront-prvs: 078693968A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(376002)(346002)(39860400002)(189003)(199004)(2906002)(68736007)(36756003)(229853002)(76176011)(14454004)(105586002)(5660300001)(106356001)(31686004)(102836004)(7736002)(305945005)(53546011)(6436002)(6506007)(97736004)(6486002)(22452003)(6246003)(186003)(39060400002)(4326008)(2900100001)(72206003)(26005)(6346003)(2616005)(476003)(3846002)(6116002)(25786009)(11346002)(446003)(66066001)(478600001)(486006)(10290500003)(86612001)(10090500001)(54906003)(110136005)(31696002)(53936002)(81166006)(81156014)(99286004)(8676002)(86362001)(2201001)(5250100002)(6512007)(316002)(14444005)(8936002)(256004)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0140;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: LyEK2k/j0tKPeCL/GU29KUy94OR2pmU6dQy5T7XTmpiPtj3QOo7ONMorOkx4IDL9mKBDhCCibYReRzKb2wuwfm3vvGhPCaCJd6Fqt01SWvmli21NqKw53RJtwUTLClWS018vArYdTAnZ1KJkbOqMsKM9f1wDrLei8lZStMxNgE+rsNxJs3tdJKlUKIkp3rLq262oQVdTVd9csyHNYH62DKzqntxU77zWHjfqIT6rEhOSeKAiJc8HzN7KUWPd9GyvLnL3hcZoWHz3+N3tC3AD8qyP5aY+Bkm6RqQxd/wluSZLcT9Uco97VEKnbDrOAJ7sQBN4P9Iune86xy5ZnwfQQj/5am+4+33D7ifN+I+nOGw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <123193DEE291BE4DA55BBBB41E557B2F@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b669ca1-19e4-424a-a975-08d61375a7bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2018 21:22:16.4579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDkvNS8xOCA1OjEzIFBNLCBBbGV4YW5kZXIgRHV5Y2sgd3JvdGU6DQo+IEZyb206IEFs
ZXhhbmRlciBEdXljayA8YWxleGFuZGVyLmguZHV5Y2tAaW50ZWwuY29tPg0KPiANCj4gT24gc3lz
dGVtcyB3aXRoIGEgbGFyZ2UgYW1vdW50IG9mIG1lbW9yeSBpdCBjYW4gdGFrZSBhIHNpZ25pZmlj
YW50IGFtb3VudA0KPiBvZiB0aW1lIHRvIGluaXRpYWxpemUgYWxsIG9mIHRoZSBwYWdlIHN0cnVj
dHMgd2l0aCB0aGUgUEFHRV9QT0lTT05fUEFUVEVSTg0KPiB2YWx1ZS4gSSBoYXZlIHNlZW4gaXQg
dGFrZSBvdmVyIDIgbWludXRlcyB0byBpbml0aWFsaXplIGEgc3lzdGVtIHdpdGgNCj4gb3ZlciAx
MkdCIG9mIFJBTS4NCj4gDQo+IEluIG9yZGVyIHRvIHdvcmsgYXJvdW5kIHRoZSBpc3N1ZSBJIGhh
ZCB0byBkaXNhYmxlIENPTkZJR19ERUJVR19WTSBhbmQgdGhlbg0KPiB0aGUgYm9vdCB0aW1lIHJl
dHVybmVkIHRvIHNvbWV0aGluZyBtdWNoIG1vcmUgcmVhc29uYWJsZSBhcyB0aGUNCj4gYXJjaF9h
ZGRfbWVtb3J5IGNhbGwgY29tcGxldGVkIGluIG1pbGxpc2Vjb25kcyB2ZXJzdXMgc2Vjb25kcy4g
SG93ZXZlciBpbg0KPiBkb2luZyB0aGF0IEkgaGFkIHRvIGRpc2FibGUgYWxsIG9mIHRoZSBvdGhl
ciBWTSBkZWJ1Z2dpbmcgb24gdGhlIHN5c3RlbS4NCj4gDQo+IEluc3RlYWQgb2Yga2VlcGluZyB0
aGUgdmFsdWUgaW4gQ09ORklHX0RFQlVHX1ZNIEkgYW0gYWRkaW5nIGEgbmV3IENPTkZJRw0KPiB2
YWx1ZSBjYWxsZWQgQ09ORklHX0RFQlVHX1ZNX1BBR0VfSU5JVF9QT0lTT04gdGhhdCB3aWxsIGNv
bnRyb2wgdGhlIHBhZ2UNCj4gcG9pc29uaW5nIGluZGVwZW5kZW50IG9mIHRoZSBDT05GSUdfREVC
VUdfVk0gb3B0aW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIER1eWNrIDxhbGV4
YW5kZXIuaC5kdXlja0BpbnRlbC5jb20+DQo+IC0tLQ0KPiAgaW5jbHVkZS9saW51eC9wYWdlLWZs
YWdzLmggfCAgICA4ICsrKysrKysrDQo+ICBsaWIvS2NvbmZpZy5kZWJ1ZyAgICAgICAgICB8ICAg
MTQgKysrKysrKysrKysrKysNCj4gIG1tL21lbWJsb2NrLmMgICAgICAgICAgICAgIHwgICAgNSAr
Ky0tLQ0KPiAgbW0vc3BhcnNlLmMgICAgICAgICAgICAgICAgfCAgICA0ICstLS0NCj4gIDQgZmls
ZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L3BhZ2UtZmxhZ3MuaCBiL2luY2x1ZGUvbGludXgvcGFnZS1m
bGFncy5oDQo+IGluZGV4IDc0YmVlOGNlY2Y0Yy4uMGU5NWNhNjMzNzVhIDEwMDY0NA0KPiAtLS0g
YS9pbmNsdWRlL2xpbnV4L3BhZ2UtZmxhZ3MuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L3BhZ2Ut
ZmxhZ3MuaA0KPiBAQCAtMTMsNiArMTMsNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L21tX3R5cGVz
Lmg+DQo+ICAjaW5jbHVkZSA8Z2VuZXJhdGVkL2JvdW5kcy5oPg0KPiAgI2VuZGlmIC8qICFfX0dF
TkVSQVRJTkdfQk9VTkRTX0ggKi8NCj4gKyNpbmNsdWRlIDxsaW51eC9zdHJpbmcuaD4NCj4gIA0K
PiAgLyoNCj4gICAqIFZhcmlvdXMgcGFnZS0+ZmxhZ3MgYml0czoNCj4gQEAgLTE2Miw2ICsxNjMs
MTMgQEAgc3RhdGljIGlubGluZSBpbnQgUGFnZVBvaXNvbmVkKGNvbnN0IHN0cnVjdCBwYWdlICpw
YWdlKQ0KPiAgCXJldHVybiBwYWdlLT5mbGFncyA9PSBQQUdFX1BPSVNPTl9QQVRURVJOOw0KPiAg
fQ0KPiAgDQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgcGFnZV9pbml0X3BvaXNvbihzdHJ1Y3QgcGFn
ZSAqcGFnZSwgc2l6ZV90IHNpemUpDQo+ICt7DQo+ICsjaWZkZWYgQ09ORklHX0RFQlVHX1ZNX1BB
R0VfSU5JVF9QT0lTT04NCj4gKwltZW1zZXQocGFnZSwgUEFHRV9QT0lTT05fUEFUVEVSTiwgc2l6
ZSk7DQo+ICsjZW5kaWYNCj4gK30NCj4gKw0KPiAgLyoNCj4gICAqIFBhZ2UgZmxhZ3MgcG9saWNp
ZXMgd3J0IGNvbXBvdW5kIHBhZ2VzDQo+ICAgKg0KPiBkaWZmIC0tZ2l0IGEvbGliL0tjb25maWcu
ZGVidWcgYi9saWIvS2NvbmZpZy5kZWJ1Zw0KPiBpbmRleCA2MTMzMTY3MjRjNmEuLjNiMTI3N2M1
MmZlZCAxMDA2NDQNCj4gLS0tIGEvbGliL0tjb25maWcuZGVidWcNCj4gKysrIGIvbGliL0tjb25m
aWcuZGVidWcNCj4gQEAgLTYzNyw2ICs2MzcsMjAgQEAgY29uZmlnIERFQlVHX1ZNX1BHRkxBR1MN
Cj4gIA0KPiAgCSAgSWYgdW5zdXJlLCBzYXkgTi4NCj4gIA0KPiArY29uZmlnIERFQlVHX1ZNX1BB
R0VfSU5JVF9QT0lTT04NCj4gKwlib29sICJFbmFibGUgZWFybHkgcGFnZSBtZXRhZGF0YSBwb2lz
b25pbmciDQo+ICsJZGVmYXVsdCB5DQo+ICsJZGVwZW5kcyBvbiBERUJVR19WTQ0KPiArCWhlbHAN
Cj4gKwkgIFNlZWQgdGhlIHBhZ2UgbWV0YWRhdGEgd2l0aCBhIHBvaXNvbiBwYXR0ZXJuIHRvIGlt
cHJvdmUgdGhlDQo+ICsJICBsaWtlbGlob29kIG9mIGRldGVjdGluZyBhdHRlbXB0cyB0byBhY2Nl
c3MgdGhlIHBhZ2UgcHJpb3IgdG8NCj4gKwkgIGluaXRpYWxpemF0aW9uIGJ5IHRoZSBtZW1vcnkg
c3Vic3lzdGVtLg0KPiArDQo+ICsJICBUaGlzIGluaXRpYWxpemF0aW9uIGNhbiByZXN1bHQgaW4g
YSBsb25nZXIgYm9vdCB0aW1lIGZvciBzeXN0ZW1zDQo+ICsJICB3aXRoIGEgbGFyZ2UgYW1vdW50
IG9mIG1lbW9yeS4NCg0KV2hhdCBoYXBwZW5zIHdoZW4gREVCVUdfVk1fUEdGTEFHUyA9IHkgYW5k
DQpERUJVR19WTV9QQUdFX0lOSVRfUE9JU09OID0gbiA/DQoNCldlIGFyZSB0ZXN0aW5nIGZvciBw
YXR0ZXJuIHRoYXQgd2FzIG5vdCBzZXQ/DQoNCkkgdGhpbmsgREVCVUdfVk1fUEFHRV9JTklUX1BP
SVNPTiBtdXN0IGRlcGVuZCBvbiBERUJVR19WTV9QR0ZMQUdTIGluc3RlYWQuDQoNCkxvb2tzIGdv
b2Qgb3RoZXJ3aXNlLg0KDQpUaGFuayB5b3UsDQpQYXZlbA0KDQo+ICsNCj4gKwkgIElmIHVuc3Vy
ZSwgc2F5IFkuDQo+ICsNCj4gIGNvbmZpZyBBUkNIX0hBU19ERUJVR19WSVJUVUFMDQo+ICAJYm9v
bA0KPiAgDQo+IGRpZmYgLS1naXQgYS9tbS9tZW1ibG9jay5jIGIvbW0vbWVtYmxvY2suYw0KPiBp
bmRleCAyMzc5NDQ0NzlkMjUuLmE4NTMxNTA4M2I1YSAxMDA2NDQNCj4gLS0tIGEvbW0vbWVtYmxv
Y2suYw0KPiArKysgYi9tbS9tZW1ibG9jay5jDQo+IEBAIC0xNDQ0LDEwICsxNDQ0LDkgQEAgdm9p
ZCAqIF9faW5pdCBtZW1ibG9ja192aXJ0X2FsbG9jX3RyeV9uaWRfcmF3KA0KPiAgDQo+ICAJcHRy
ID0gbWVtYmxvY2tfdmlydF9hbGxvY19pbnRlcm5hbChzaXplLCBhbGlnbiwNCj4gIAkJCQkJICAg
bWluX2FkZHIsIG1heF9hZGRyLCBuaWQpOw0KPiAtI2lmZGVmIENPTkZJR19ERUJVR19WTQ0KPiAg
CWlmIChwdHIgJiYgc2l6ZSA+IDApDQo+IC0JCW1lbXNldChwdHIsIFBBR0VfUE9JU09OX1BBVFRF
Uk4sIHNpemUpOw0KPiAtI2VuZGlmDQo+ICsJCXBhZ2VfaW5pdF9wb2lzb24ocHRyLCBzaXplKTsN
Cj4gKw0KPiAgCXJldHVybiBwdHI7DQo+ICB9DQo+ICANCj4gZGlmZiAtLWdpdCBhL21tL3NwYXJz
ZS5jIGIvbW0vc3BhcnNlLmMNCj4gaW5kZXggMTBiMDdlZWE5YTZlLi42N2FkMDYxZjdmYjggMTAw
NjQ0DQo+IC0tLSBhL21tL3NwYXJzZS5jDQo+ICsrKyBiL21tL3NwYXJzZS5jDQo+IEBAIC02OTYs
MTMgKzY5NiwxMSBAQCBpbnQgX19tZW1pbml0IHNwYXJzZV9hZGRfb25lX3NlY3Rpb24oc3RydWN0
IHBnbGlzdF9kYXRhICpwZ2RhdCwNCj4gIAkJZ290byBvdXQ7DQo+ICAJfQ0KPiAgDQo+IC0jaWZk
ZWYgQ09ORklHX0RFQlVHX1ZNDQo+ICAJLyoNCj4gIAkgKiBQb2lzb24gdW5pbml0aWFsaXplZCBz
dHJ1Y3QgcGFnZXMgaW4gb3JkZXIgdG8gY2F0Y2ggaW52YWxpZCBmbGFncw0KPiAgCSAqIGNvbWJp
bmF0aW9ucy4NCj4gIAkgKi8NCj4gLQltZW1zZXQobWVtbWFwLCBQQUdFX1BPSVNPTl9QQVRURVJO
LCBzaXplb2Yoc3RydWN0IHBhZ2UpICogUEFHRVNfUEVSX1NFQ1RJT04pOw0KPiAtI2VuZGlmDQo+
ICsJcGFnZV9pbml0X3BvaXNvbihtZW1tYXAsIHNpemVvZihzdHJ1Y3QgcGFnZSkgKiBQQUdFU19Q
RVJfU0VDVElPTik7DQo+ICANCj4gIAlzZWN0aW9uX21hcmtfcHJlc2VudChtcyk7DQo+ICAJc3Bh
cnNlX2luaXRfb25lX3NlY3Rpb24obXMsIHNlY3Rpb25fbnIsIG1lbW1hcCwgdXNlbWFwKTsNCj4g
