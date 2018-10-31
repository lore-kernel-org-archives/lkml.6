Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EF3ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A3220823
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fLLLjxrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A3220823
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbeKABE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:04:59 -0400
Received: from mail-eopbgr690111.outbound.protection.outlook.com ([40.107.69.111]:1183
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728048AbeKABE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gineLNi+S8u8+ujRYxar8TEa2cupWQnZI8zi/3XoHS4=;
 b=fLLLjxrhmgIa2km0z2cir1NKycVRUgV39HK21U+TSZMcXyRiiIESUTa0/jWJd1rTvyfTuiOMghFLQeNyC4XE2bwqDN8eXvu1+PNAZcsZofoHRVJwngcDDn9/Iz6BvMBGVbHIwP2YFr6Dle6uE33i2+opn0UvZhZniL7yIOrMMec=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0283.namprd21.prod.outlook.com (10.173.174.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.9; Wed, 31 Oct 2018 16:06:18 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::909e:78d3:5637:c4fe]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::909e:78d3:5637:c4fe%6]) with mapi id 15.20.1294.014; Wed, 31 Oct 2018
 16:06:18 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "mhocko@suse.com" <mhocko@suse.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "yi.z.zhang@linux.intel.com" <yi.z.zhang@linux.intel.com>,
        "khalid.aziz@oracle.com" <khalid.aziz@oracle.com>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "ldufour@linux.vnet.ibm.com" <ldufour@linux.vnet.ibm.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Subject: Re: [mm PATCH v4 3/6] mm: Use memblock/zone specific iterator for
 handling deferred page init
Thread-Topic: [mm PATCH v4 3/6] mm: Use memblock/zone specific iterator for
 handling deferred page init
Thread-Index: AQHUZnS64EfZUXoWUkmxUsXxcYCLGqU5kw0AgAAHAQCAAABXgA==
Date:   Wed, 31 Oct 2018 16:06:17 +0000
Message-ID: <0201b67f-e6a7-623c-77e1-f080d5bf30b5@microsoft.com>
References: <20181017235043.17213.92459.stgit@localhost.localdomain>
 <20181017235419.17213.68425.stgit@localhost.localdomain>
 <5b937f29-a6e1-6622-b035-246229021d3e@microsoft.com>
 <a7c1bc0ed1e68cbc32c4dd6753fa9f8ff7f1421f.camel@linux.intel.com>
In-Reply-To: <a7c1bc0ed1e68cbc32c4dd6753fa9f8ff7f1421f.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [73.69.118.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0283;6:3tymiLfFjL+FNsvwQVQ5drzamDGa0G26o8mREDadIrnJjWM8Xd2X3QKpyu7RJLqueqSViLfMMIuYAegdF3/n2+tJWTAP9rknIay//an5zrcgs/ZuUaDBvA6zdXRKNOhk4vKl1gUViFihm4tr3KTkHrPA4OKxvwnmMqbJbxu+CwaXxYexKXbkluF3l9r9Gki87RA1uZ9rJxYvkIBh3vFdwuShApCzXXSplUqqh2KR9JGDjtl6AlhR44SsxVoTKzQ8UodoKyhBcLA0q011IlL3BTx3FslpgN7Xh1Y+LGBlqjAh+73SEV/KZ3FDwjnOmIrRQIYYAB2el/YDD0m9keg35yv8LSZ39/MxwmaIFKuiJ4AtP7MKEmyjtsy6oRi2ElDS8PaouuWLOgAFwTAueNeAAtY66/eNSOU2EujsX5Jf7h4RcpKg2N1lNU/X2Fi6HkdkijX3qclzwxZhFA4zj8ebaA==;5:1brsyexlu/IR0H4eUk1LaeIoeL2FxE170w2OPiksFWayd7CthiWyzpOFWNdi9Y/b9Kq+W5NebFPAYYLg231x+lnzoWk14nO0tHpvjdrSE/PxMsaflqrRN7tYe3thOL+OsX5TStT2nhs72M0f8Tcoz6oNCilC4OltyAMvAVpPxhE=;7:f6C/1p+5VewHz1yKByPz/a933J/wL5R+tYb5qCqHyXS4fcsEBekZkzSca1wgKnZ+FVAO3Mx+iC1osCz+BEMe1Fv2sb4XmTo4CE4s7DXAXSFaC3eHabsmLDKjwI7+I7uFLWR9AzReUzFJEQ0+l0LGpw==
x-ms-office365-filtering-correlation-id: c31b9c91-99fb-47e4-3234-08d63f4acabe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0283;
x-ms-traffictypediagnostic: DM5PR21MB0283:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB0283D64D6C7967E5A7E002F99DCD0@DM5PR21MB0283.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM5PR21MB0283;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0283;
x-forefront-prvs: 084285FC5C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(376002)(346002)(396003)(189003)(199004)(43544003)(86612001)(102836004)(476003)(2900100001)(86362001)(8936002)(6436002)(81166006)(81156014)(31686004)(305945005)(6116002)(6506007)(3846002)(478600001)(2501003)(106356001)(105586002)(66066001)(186003)(31696002)(446003)(2616005)(486006)(6486002)(22452003)(11346002)(54906003)(110136005)(26005)(10290500003)(2201001)(7416002)(53546011)(99286004)(76176011)(53936002)(72206003)(14454004)(6512007)(68736007)(1511001)(97736004)(7736002)(25786009)(4001150100001)(316002)(71190400001)(4326008)(5250100002)(229853002)(71200400001)(6246003)(93886005)(14444005)(256004)(36756003)(10090500001)(2906002)(5660300001)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0283;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: j4nYFteFF7x+2V9onM2fxvkD+k1fGl4naZ6ExoMUH0lCyjfqVBqwh7GWOJWgKM4y53GIADCPKmUI2xeN6wZDfcx0zAOvQJHJbJFAmlrggzGDmWtC4J/1qAENCmWdFBTK1VxJXxak8TkF1T6T4VmsVgJVu/couqH3xwS/IQtFKpK8DxCVp2ghHOsRENTvbUhKlKn5WOBhrbkCsRjDjH8q90ayCk6CQz2f1px6euv4/kUviUGJESkriEUVrkznCnqO04pdHGEOYKKyAp/3qYmdwR3r1E3ppr3jJnBLiP3YKlpfQ1w94JFzFlW5IJJ0frpkJHMVvgVOTTQB+s+MQX3EBrVyXm5otGOEOV95IgVGvXo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C47298D11152E4AB0857451CF9D6A85@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31b9c91-99fb-47e4-3234-08d63f4acabe
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2018 16:06:17.9084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0283
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzMxLzE4IDEyOjA1IFBNLCBBbGV4YW5kZXIgRHV5Y2sgd3JvdGU6DQo+IE9uIFdl
ZCwgMjAxOC0xMC0zMSBhdCAxNTo0MCArMDAwMCwgUGFzaGEgVGF0YXNoaW4gd3JvdGU6DQo+Pg0K
Pj4gT24gMTAvMTcvMTggNzo1NCBQTSwgQWxleGFuZGVyIER1eWNrIHdyb3RlOg0KPj4+IFRoaXMg
cGF0Y2ggaW50cm9kdWNlcyBhIG5ldyBpdGVyYXRvciBmb3JfZWFjaF9mcmVlX21lbV9wZm5fcmFu
Z2VfaW5fem9uZS4NCj4+Pg0KPj4+IFRoaXMgaXRlcmF0b3Igd2lsbCB0YWtlIGNhcmUgb2YgbWFr
aW5nIHN1cmUgYSBnaXZlbiBtZW1vcnkgcmFuZ2UgcHJvdmlkZWQNCj4+PiBpcyBpbiBmYWN0IGNv
bnRhaW5lZCB3aXRoaW4gYSB6b25lLiBJdCB0YWtlcyBhcmUgb2YgYWxsIHRoZSBib3VuZHMgY2hl
Y2tpbmcNCj4+PiB3ZSB3ZXJlIGRvaW5nIGluIGRlZmVycmVkX2dyb3dfem9uZSwgYW5kIGRlZmVy
cmVkX2luaXRfbWVtbWFwLiBJbiBhZGRpdGlvbg0KPj4+IGl0IHNob3VsZCBoZWxwIHRvIHNwZWVk
IHVwIHRoZSBzZWFyY2ggYSBiaXQgYnkgaXRlcmF0aW5nIHVudGlsIHRoZSBlbmQgb2YgYQ0KPj4+
IHJhbmdlIGlzIGdyZWF0ZXIgdGhhbiB0aGUgc3RhcnQgb2YgdGhlIHpvbmUgcGZuIHJhbmdlLCBh
bmQgd2lsbCBleGl0DQo+Pj4gY29tcGxldGVseSBpZiB0aGUgc3RhcnQgaXMgYmV5b25kIHRoZSBl
bmQgb2YgdGhlIHpvbmUuDQo+Pj4NCj4+PiBUaGlzIHBhdGNoIGFkZHMgeWV0IGFub3RoZXIgaXRl
cmF0b3IgY2FsbGVkDQo+Pj4gZm9yX2VhY2hfZnJlZV9tZW1fcmFuZ2VfaW5fem9uZV9mcm9tIGFu
ZCB0aGVuIHVzZXMgaXQgdG8gc3VwcG9ydA0KPj4+IGluaXRpYWxpemluZyBhbmQgZnJlZWluZyBw
YWdlcyBpbiBncm91cHMgbm8gbGFyZ2VyIHRoYW4gTUFYX09SREVSX05SX1BBR0VTLg0KPj4+IEJ5
IGRvaW5nIHRoaXMgd2UgY2FuIGdyZWF0bHkgaW1wcm92ZSB0aGUgY2FjaGUgbG9jYWxpdHkgb2Yg
dGhlIHBhZ2VzIHdoaWxlDQo+Pj4gd2UgZG8gc2V2ZXJhbCBsb29wcyBvdmVyIHRoZW0gaW4gdGhl
IGluaXQgYW5kIGZyZWVpbmcgcHJvY2Vzcy4NCj4+Pg0KPj4+IFdlIGFyZSBhYmxlIHRvIHRpZ2h0
ZW4gdGhlIGxvb3BzIGFzIGEgcmVzdWx0IHNpbmNlIHdlIG9ubHkgcmVhbGx5IG5lZWQgdGhlDQo+
Pj4gY2hlY2tzIGZvciBmaXJzdF9pbml0X3BmbiBpbiBvdXIgZmlyc3QgaXRlcmF0aW9uIGFuZCBh
ZnRlciB0aGF0IHdlIGNhbg0KPj4+IGFzc3VtZSB0aGF0IGFsbCBmdXR1cmUgdmFsdWVzIHdpbGwg
YmUgZ3JlYXRlciB0aGFuIHRoaXMuIFNvIEkgaGF2ZSBhZGRlZCBhDQo+Pj4gZnVuY3Rpb24gY2Fs
bGVkIGRlZmVycmVkX2luaXRfbWVtX3Bmbl9yYW5nZV9pbl96b25lIHRoYXQgcHJpbWVzIHRoZQ0K
Pj4+IGl0ZXJhdG9ycyBhbmQgaWYgaXQgZmFpbHMgd2UgY2FuIGp1c3QgZXhpdC4NCj4+Pg0KPj4+
IE9uIG15IHg4Nl82NCB0ZXN0IHN5c3RlbSB3aXRoIDM4NEdCIG9mIG1lbW9yeSBwZXIgbm9kZSBJ
IHNhdyBhIHJlZHVjdGlvbiBpbg0KPj4+IGluaXRpYWxpemF0aW9uIHRpbWUgZnJvbSAxLjg1cyB0
byAxLjM4cyBhcyBhIHJlc3VsdCBvZiB0aGlzIHBhdGNoLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1i
eTogQWxleGFuZGVyIER1eWNrIDxhbGV4YW5kZXIuaC5kdXlja0BsaW51eC5pbnRlbC5jb20+DQo+
Pg0KPj4gSGkgQWxleCwNCj4+DQo+PiBDb3VsZCB5b3UgcGxlYXNlIHNwbGl0IHRoaXMgcGF0Y2gg
aW50byB0d28gcGFydHM6DQo+Pg0KPj4gMS4gQWRkIGRlZmVycmVkX2luaXRfbWF4b3JkZXIoKQ0K
Pj4gMi4gQWRkIG1lbWJsb2NrIGl0ZXJhdG9yPw0KPj4NCj4+IFRoaXMgd291bGQgYWxsb3cgYSBi
ZXR0ZXIgYmlzZWN0aW5nIGluIGNhc2Ugb2YgcHJvYmxlbXMuIENoYW5pbmcgdHdvDQo+PiBsb29w
cyBpbnRvIGRlZmVycmVkX2luaXRfbWF4b3JkZXIoKSB3aGlsZSBhIGdvb2QgaWRlYSwgaXMgc3Rp
bGwNCj4+IG5vbi10cml2aWFsIGFuZCBtaWdodCBsZWFkIHRvIGJ1Z3MuDQo+Pg0KPj4gVGhhbmsg
eW91LA0KPj4gUGF2ZWwNCj4gDQo+IEkgY2FuIGRvIHRoYXQsIGJ1dCBJIHdpbGwgbmVlZCB0byBm
bGlwIHRoZSBvcmRlci4gSSB3aWxsIGFkZCB0aGUgbmV3DQo+IGl0ZXJhdG9yIGZpcnN0IGFuZCB0
aGVuIGRlZmVycmVkX2luaXRfbWF4b3JkZXIuIE90aGVyd2lzZSB0aGUNCj4gaW50ZXJtZWRpYXRl
IHN0ZXAgZW5kcyB1cCBiZWluZyB0b28gbXVjaCB0aHJvdy1hd2F5IGNvZGUuDQoNClRoYXQgc291
bmRzIGdvb2QuDQoNClRoYW5rIHlvdSwNClBhdmVsDQoNCj4gDQo+IC0gQWxleA0KPiA=
