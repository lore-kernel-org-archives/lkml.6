Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABA4C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF652084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zrOd3ksr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF652084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeLJKoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:44:46 -0500
Received: from mail-eopbgr740055.outbound.protection.outlook.com ([40.107.74.55]:17561
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726209AbeLJKop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cH1hBHHqhBgVhUcBoOZFHqmssIPNFOqhm0Lv0nuPy/Y=;
 b=zrOd3ksrlMK5TAGiE4tqnuAAUhlhUwe3dTIzD2K2KMtdAdFmkVqbXgWbnBzxooyDgmSpo16jrAOAuFQ0wtjM7libReYaIEldJzPO6q8HiyMPLYl6o7PEOyv4/UKkugQTOgHUa0DY+ShJ9r5NmoPisXFt+fMwoRZ7EehNY6bCcn4=
Received: from BN6PR12MB1714.namprd12.prod.outlook.com (10.175.101.11) by
 BN6PR12MB1330.namprd12.prod.outlook.com (10.168.228.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Mon, 10 Dec 2018 10:44:38 +0000
Received: from BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::f8a7:157:6224:34ee]) by BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::f8a7:157:6224:34ee%2]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 10:44:38 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>
CC:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 1/4] mm: Check if mmu notifier callbacks are allowed to
 fail
Thread-Topic: [PATCH 1/4] mm: Check if mmu notifier callbacks are allowed to
 fail
Thread-Index: AQHUkHRD7/4vaiZsvE+73389JcU/F6V3ycGA
Date:   Mon, 10 Dec 2018 10:44:38 +0000
Message-ID: <36496bd3-1568-ee6e-e0a2-159a1315d767@amd.com>
References: <20181210103641.31259-1-daniel.vetter@ffwll.ch>
 <20181210103641.31259-2-daniel.vetter@ffwll.ch>
In-Reply-To: <20181210103641.31259-2-daniel.vetter@ffwll.ch>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:125b:9a00:a142:2be6:b7be:5a3a]
x-clientproxiedby: AM6P193CA0030.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::43) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1330;20:oUD/1nIXq/ChsYx7hBIZD5EeSCqLAudq5qz/Z38k9PpdoYxahqqUn7DhIAU+23DsLxUYCRB/1IVu7uKs+k9BMVwCr057DMQ+7hE0vwDH+2CCTeRLT5qkoOE1UpPjtV9127QVr6nOATn4e//twp5DZxyyADi0hCGn8zD4ymlZoLgI8eXIPE5QsS2SXvDJSA1uIDUGIYoFTPXtc2vgLkKQeqhXxNsb0fvlrtk/I5X0iLfTBA2bnAL/AjIAN1jd8K7p
x-ms-office365-filtering-correlation-id: f05cbce6-ffdb-4b4c-91e8-08d65e8c7b74
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1330;
x-ms-traffictypediagnostic: BN6PR12MB1330:
x-microsoft-antispam-prvs: <BN6PR12MB133060E45DDAD5CB6C23156B83A50@BN6PR12MB1330.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231472)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BN6PR12MB1330;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1330;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(396003)(376002)(39860400002)(199004)(189003)(102836004)(14454004)(478600001)(25786009)(72206003)(46003)(6116002)(76176011)(186003)(6506007)(386003)(66574011)(6436002)(71190400001)(71200400001)(68736007)(256004)(6512007)(14444005)(105586002)(106356001)(229853002)(6246003)(53936002)(36756003)(31686004)(316002)(110136005)(54906003)(58126008)(97736004)(7736002)(305945005)(65806001)(64126003)(99286004)(7416002)(2906002)(4326008)(8936002)(81156014)(81166006)(6486002)(52116002)(8676002)(11346002)(446003)(86362001)(31696002)(2616005)(476003)(486006)(65826007)(5660300001)(65956001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1330;H:BN6PR12MB1714.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Q0Ml/q5Zd3VxWSa8m1Q9Ss8i8iYOFI0DhykCb2ajx1LoB2R1YlIhc25pMn2vjPTO9U0J0MLtyuFr8qVY2nJuCmFoYSjUMSZ8jvFyZ9aN22TNSOOBHedMuDkCxf53FYemNsA6XDu9T6fjXSd2/+t6igvND1r04FN/Rj9lOPCgh1biJzEudtucZCDSQCm9xhSm4GJWWSJFe5yS/h6BTCkws+dRNA5UIpMvW1Z3EaUX5QLvfnW/C6WecgDV0Ssh9KkJF2pGWZTxjPPiIalhzMgUL+n2pcc6fWGLCaQ72FtfVtBRS3JakK5BkSaasGi8oiBm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <54D819CB7E41C14EBD4B6A84065B1BE3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f05cbce6-ffdb-4b4c-91e8-08d65e8c7b74
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 10:44:38.2195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1330
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGF0Y2hlcyAjMSBhbmQgIzMgYXJlIFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIA0KPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCg0KUGF0Y2ggIzIgaXMgQWNrZWQtYnk6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gYmVjYXVzZSANCkkgY2FuJ3QganVk
Z2UgaWYgYWRkaW5nIHRoZSBjb3VudGVyIGluIHRoZSB0aHJlYWQgc3RydWN0dXJlIGlzIGFjdHVh
bGx5IA0KYSBnb29kIGlkZWEuDQoNCkluIHBhdGNoICM0IEkgaG9uZXN0bHkgZG9uJ3QgdW5kZXJz
dGFuZCBhdCBhbGwgaG93IHRoaXMgc3R1ZmYgd29ya3MsIHNvIA0Kbm8tY29tbWVudCBmcm9tIG15
IHNpZGUgb24gdGhpcy4NCg0KQ2hyaXN0aWFuLg0KDQpBbSAxMC4xMi4xOCB1bSAxMTozNiBzY2hy
aWViIERhbmllbCBWZXR0ZXI6DQo+IEp1c3QgYSBiaXQgb2YgcGFyYW5vaWEsIHNpbmNlIGlmIHdl
IHN0YXJ0IHB1c2hpbmcgdGhpcyBkZWVwIGludG8NCj4gY2FsbGNoYWlucyBpdCdzIGhhcmQgdG8g
c3BvdCBhbGwgcGxhY2VzIHdoZXJlIGFuIG1tdSBub3RpZmllcg0KPiBpbXBsZW1lbnRhdGlvbiBt
aWdodCBmYWlsIHdoZW4gaXQncyBub3QgYWxsb3dlZCB0by4NCj4NCj4gSW5zcGlyZWQgYnkgc29t
ZSBjb25mdXNpb24gd2UgaGFkIGRpc2N1c3NpbmcgaTkxNSBtbXUgbm90aWZpZXJzIGFuZA0KPiB3
aGV0aGVyIHdlIGNvdWxkIHVzZSB0aGUgbmV3bHktaW50cm9kdWNlZCByZXR1cm4gdmFsdWUgdG8g
aGFuZGxlIHNvbWUNCj4gY29ybmVyIGNhc2VzLiBVbnRpbCB3ZSByZWFsaXplZCB0aGF0IHRoZXNl
IGFyZSBvbmx5IGZvciB3aGVuIGEgdGFzaw0KPiBoYXMgYmVlbiBraWxsZWQgYnkgdGhlIG9vbSBy
ZWFwZXIuDQo+DQo+IEFuIGFsdGVybmF0aXZlIGFwcHJvYWNoIHdvdWxkIGJlIHRvIHNwbGl0IHRo
ZSBjYWxsYmFjayBpbnRvIHR3bw0KPiB2ZXJzaW9ucywgb25lIHdpdGggdGhlIGludCByZXR1cm4g
dmFsdWUsIGFuZCB0aGUgb3RoZXIgd2l0aCB2b2lkDQo+IHJldHVybiB2YWx1ZSBsaWtlIGluIG9s
ZGVyIGtlcm5lbHMuIEJ1dCB0aGF0J3MgYSBsb3QgbW9yZSBjaHVybiBmb3INCj4gZmFpcmx5IGxp
dHRsZSBnYWluIEkgdGhpbmsuDQo+DQo+IFN1bW1hcnkgZnJvbSB0aGUgbS1sIGRpc2N1c3Npb24g
b24gd2h5IHdlIHdhbnQgc29tZXRoaW5nIGF0IHdhcm5pbmcNCj4gbGV2ZWw6IFRoaXMgYWxsb3dz
IGF1dG9tYXRlZCB0b29saW5nIGluIENJIHRvIGNhdGNoIGJ1Z3Mgd2l0aG91dA0KPiBodW1hbnMg
aGF2aW5nIHRvIGxvb2sgYXQgZXZlcnl0aGluZy4gSWYgd2UganVzdCB1cGdyYWRlIHRoZSBleGlz
dGluZw0KPiBwcl9pbmZvIHRvIGEgcHJfd2FybiwgdGhlbiB3ZSdsbCBoYXZlIGZhbHNlIHBvc2l0
aXZlcy4gQW5kIGFzLWlzLCBubw0KPiBvbmUgd2lsbCBldmVyIHNwb3QgdGhlIHByb2JsZW0gc2lu
Y2UgaXQncyBsb3N0IGluIHRoZSBtYXNzaXZlIGFtb3VudHMNCj4gb2Ygb3ZlcmFsbCBkbWVzZyBu
b2lzZS4NCj4NCj4gdjI6IERyb3AgdGhlIGZ1bGwgV0FSTl9PTiBiYWNrdHJhY2UgaW4gZmF2b3Vy
IG9mIGp1c3QgYSBwcl93YXJuIGZvcg0KPiB0aGUgcHJvYmxlbWF0aWMgY2FzZSAoTWljaGFsIEhv
Y2tvKS4NCj4NCj4gQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+
DQo+IENjOiBNaWNoYWwgSG9ja28gPG1ob2Nrb0BzdXNlLmNvbT4NCj4gQ2M6ICJDaHJpc3RpYW4g
S8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiBDYzogRGF2aWQgUmllbnRqZXMg
PHJpZW50amVzQGdvb2dsZS5jb20+DQo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWwudmV0dGVy
QGZmd2xsLmNoPg0KPiBDYzogIkrDqXLDtG1lIEdsaXNzZSIgPGpnbGlzc2VAcmVkaGF0LmNvbT4N
Cj4gQ2M6IGxpbnV4LW1tQGt2YWNrLm9yZw0KPiBDYzogUGFvbG8gQm9uemluaSA8cGJvbnppbmlA
cmVkaGF0LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZldHRl
ckBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgIG1tL21tdV9ub3RpZmllci5jIHwgMyArKysNCj4gICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9tbS9tbXVf
bm90aWZpZXIuYyBiL21tL21tdV9ub3RpZmllci5jDQo+IGluZGV4IDUxMTlmZjg0Njc2OS4uY2Nj
MjJmMjFiNzM1IDEwMDY0NA0KPiAtLS0gYS9tbS9tbXVfbm90aWZpZXIuYw0KPiArKysgYi9tbS9t
bXVfbm90aWZpZXIuYw0KPiBAQCAtMTkwLDYgKzE5MCw5IEBAIGludCBfX21tdV9ub3RpZmllcl9p
bnZhbGlkYXRlX3JhbmdlX3N0YXJ0KHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLA0KPiAgIAkJCQlwcl9p
bmZvKCIlcFMgY2FsbGJhY2sgZmFpbGVkIHdpdGggJWQgaW4gJXNibG9ja2FibGUgY29udGV4dC5c
biIsDQo+ICAgCQkJCQkJbW4tPm9wcy0+aW52YWxpZGF0ZV9yYW5nZV9zdGFydCwgX3JldCwNCj4g
ICAJCQkJCQkhYmxvY2thYmxlID8gIm5vbi0iIDogIiIpOw0KPiArCQkJCWlmIChibG9ja2FibGUp
DQo+ICsJCQkJCXByX3dhcm4oIiVwUyBjYWxsYmFjayBmYWlsdXJlIG5vdCBhbGxvd2VkXG4iLA0K
PiArCQkJCQkJbW4tPm9wcy0+aW52YWxpZGF0ZV9yYW5nZV9zdGFydCk7DQo+ICAgCQkJCXJldCA9
IF9yZXQ7DQo+ICAgCQkJfQ0KPiAgIAkJfQ0KDQo=
