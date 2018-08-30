Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6864EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0842054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iWtl4tUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0842054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbeH3SiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:38:08 -0400
Received: from mail-eopbgr690102.outbound.protection.outlook.com ([40.107.69.102]:61303
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729075AbeH3SiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUw7jkqtP9rNbgBPl86r1yCIPRF6cxjWTVM5oEw6VcE=;
 b=iWtl4tUWX+m/x1m4t2MVoSsYljCFn4lLE6FBiM9J5VjNh6qo4ZqJxB19DC3NzdfzKKy4XMIUkb8EwSledD/5ZwWGRB5KA4nZKBcUuz+0E5xVHy2JCAe5SgERJprUeIe/SI/GGtiprttBv0E2V68lldCCgzQdDk09Q9AZra9fXAw=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0762.namprd21.prod.outlook.com (10.173.172.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1122.1; Thu, 30 Aug 2018 14:35:38 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1122.009; Thu, 30 Aug 2018
 14:35:38 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Jiri Slaby <jslaby@suse.cz>
CC:     "mhocko@kernel.org" <mhocko@kernel.org>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Reza Arbab <arbab@linux.vnet.ibm.com>,
        "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>
Subject: Re: [PATCH v1] mm: relax deferred struct page requirements
Thread-Topic: [PATCH v1] mm: relax deferred struct page requirements
Thread-Index: AQHUO35THenIpiCqSkCG824R6tGAM6TYZnEA
Date:   Thu, 30 Aug 2018 14:35:37 +0000
Message-ID: <7aee9274-9e8e-4a40-a9e5-3c9ef28511b7@microsoft.com>
References: <20171117014601.31606-1-pasha.tatashin@oracle.com>
 <20171121072416.v77vu4osm2s4o5sq@dhcp22.suse.cz>
 <b16029f0-ada0-df25-071b-cd5dba0ab756@suse.cz>
 <CAGM2rea=_VJJ26tohWQWgfwcFVkp0gb6j1edH1kVLjtxfugf5Q@mail.gmail.com>
 <CAGM2reYcwyOcKrO=WhB3Cf0FNL3ZearC=KvxmTNUU6rkWviQOg@mail.gmail.com>
 <83d035f1-40b4-bed8-6113-f4c5a0c4d22f@suse.cz>
 <c4d46b63-5237-d002-faf5-4e0749d825d7@suse.cz>
In-Reply-To: <c4d46b63-5237-d002-faf5-4e0749d825d7@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0762;6:+KptGBKmNTStQE3p0Hb0LGrCKikzU52SINfVpu+3n5Qkv8/YNGQk4VGs4JEtPFAuGgVlL3cQ5MaQsujqhafub8gI7hVF/gbm7ktOOg8QIQ11zV4LrKcMcgqYlb4XlYZTDeAHgmfhfqvxa33lW4jQ8HQTxSzEBE+/L48uZf+z3W4TYyz5a3w6f88y24YSXwzWPQI19Uu/wta6iE/ym5dei08/NoOMFno1YC0nMyAH8mo8fg/EELcnYcdK4d/SJM29kZuhIdrRKCtzbL/+OFiZSRh5zyFDcbV19kEoGDr6v4iXKLXo60l8lfwLfbj+Y4nc7RL/pv0eV5GQzTiNwtCiEaLKmzF2/nEbmF+Xtum01aQH1uNLs6U+dZlG9YlWjP1beeg9UpYERQaYx44UMJq4UWjW8yKngvmkqepxumkY161hTgDh+EWI5NcqhnW6eMkGf1xS08U0EBVqVSfmuc4k9w==;5:KrMftiB6TPhsSxsaSCbxs/YbOLeScry0x16l4Z/wVIgCCzZALMR5qmBa0QqkD+YtBpOMvbgD/EGc6FJqqTFTyDJeNvE06yWR79G7mWkHYNSk9SGS99B3xaCAWNX6aSzDVQmNwuJrPcz1+riGm3vGM4/E/rPZyIwCQFlEPFRPzjw=;7:SeBURKuPDP35w/4goAa3ChDHqomUCaUM6v4gWMB5+VIiZFAVGIzFA77tnxRWyC160UES+HjZmp9H8ScCtvYa+zpMb62onFtFQ/fPrT3DHIJz89mw5gycvUsu3TCK0FmtDeLFfx8qBN+tcJChSoFs0rIKFPWs3OewahOlLrvPEDFEMejC/WXh5yooVaXDbgDFYQ6JKmpGxorjt0yknxlLUSZbkBz76zfezdrifLqdDGcjXSIdqP5dp+hN50B2fHY3
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7724e9bd-cd2c-43ac-382d-08d60e85daab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0762;
x-ms-traffictypediagnostic: DM5PR21MB0762:
x-microsoft-antispam-prvs: <DM5PR21MB076212EC873D1A4A12918D589D080@DM5PR21MB0762.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(211171220733660)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231340)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0762;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0762;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(136003)(39860400002)(376002)(189003)(199004)(22452003)(446003)(99286004)(105586002)(106356001)(5250100002)(8676002)(25786009)(4326008)(6486002)(6246003)(6512007)(3846002)(86612001)(6116002)(72206003)(31696002)(229853002)(486006)(476003)(10290500003)(478600001)(11346002)(53936002)(86362001)(31686004)(36756003)(2616005)(14454004)(81156014)(76176011)(6436002)(6916009)(81166006)(26005)(102836004)(7416002)(6506007)(5660300001)(53546011)(66066001)(316002)(93886005)(6346003)(5024004)(8936002)(345774005)(2900100001)(256004)(68736007)(2906002)(97736004)(186003)(305945005)(7736002)(14444005)(54906003)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0762;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: +Sc2/CsGqV0EKw05NJCZ5bCn5j+wtJ19a/GUl9fuWiYSfyuncTgw1OVyhIklrFtagGZlk900Wvg6HKSu5uSYnY7v+Cm5P2FeWSYd5StEX6zYQZCDq+bIHMgPQJuVJGKJ3BWu/zMEjI1etSrF0YF6V6jnIEV+cczlSOgbae1WOI35F+9u+OoPdk3jZfKUU0WLGUjeVjLx5mwXGYjbCtL0XQN31hVzgKZ20oN7EKr6g7KlPsTSHCqX2wh3/qWp7jZkrJRU+7EbW5jUFkj9QNmOqOrLJX/M8vm8HuYnqfbyp4VzXeU+CF/uKz67LiF0JoFJOAJp8rn3z0FNFmGyHlLF5RjyqZUjZuAzGq+0PYDyfLM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C800F9BE9F8864E8B6BE0DD1B2842EE@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7724e9bd-cd2c-43ac-382d-08d60e85daab
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 14:35:38.0336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0762
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91IEppcmksIEkgYW0gc3R1ZHlpbmcgaXQuDQoNClBhdmVsDQoNCk9uIDgvMjQvMTgg
Mzo0NCBBTSwgSmlyaSBTbGFieSB3cm90ZToNCj4gcGFzaGEudGF0YXNoaW5Ab3JhY2xlLmNvbSAt
PiBwYXZlbC50YXRhc2hpbkBtaWNyb3NvZnQuY29tDQo+IA0KPiBkdWUgdG8NCj4gIDU1MCA1LjEu
MSBVbmtub3duIHJlY2lwaWVudCBhZGRyZXNzLg0KPiANCj4gDQo+IE9uIDA4LzI0LzIwMTgsIDA5
OjMyIEFNLCBKaXJpIFNsYWJ5IHdyb3RlOg0KPj4gT24gMDYvMTkvMjAxOCwgMDk6NTYgUE0sIFBh
dmVsIFRhdGFzaGluIHdyb3RlOg0KPj4+IE9uIFR1ZSwgSnVuIDE5LCAyMDE4IGF0IDk6NTAgQU0g
UGF2ZWwgVGF0YXNoaW4NCj4+PiA8cGFzaGEudGF0YXNoaW5Ab3JhY2xlLmNvbT4gd3JvdGU6DQo+
Pj4+DQo+Pj4+IE9uIFNhdCwgSnVuIDE2LCAyMDE4IGF0IDQ6MDQgQU0gSmlyaSBTbGFieSA8anNs
YWJ5QHN1c2UuY3o+IHdyb3RlOg0KPj4+Pj4NCj4+Pj4+IE9uIDExLzIxLzIwMTcsIDA4OjI0IEFN
LCBNaWNoYWwgSG9ja28gd3JvdGU6DQo+Pj4+Pj4gT24gVGh1IDE2LTExLTE3IDIwOjQ2OjAxLCBQ
YXZlbCBUYXRhc2hpbiB3cm90ZToNCj4+Pj4+Pj4gVGhlcmUgaXMgbm8gbmVlZCB0byBoYXZlIEFS
Q0hfU1VQUE9SVFNfREVGRVJSRURfU1RSVUNUX1BBR0VfSU5JVCwNCj4+Pj4+Pj4gYXMgYWxsIHRo
ZSBwYWdlIGluaXRpYWxpemF0aW9uIGNvZGUgaXMgaW4gY29tbW9uIGNvZGUuDQo+Pj4+Pj4+DQo+
Pj4+Pj4+IEFsc28sIHRoZXJlIGlzIG5vIG5lZWQgdG8gZGVwZW5kIG9uIE1FTU9SWV9IT1RQTFVH
LCBhcyBpbml0aWFsaXphdGlvbiBjb2RlDQo+Pj4+Pj4+IGRvZXMgbm90IHJlYWxseSB1c2UgaG90
cGx1ZyBtZW1vcnkgZnVuY3Rpb25hbGl0eS4gU28sIHdlIGNhbiByZW1vdmUgdGhpcw0KPj4+Pj4+
PiByZXF1aXJlbWVudCBhcyB3ZWxsLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBUaGlzIHBhdGNoIGFsbG93
cyB0byB1c2UgZGVmZXJyZWQgc3RydWN0IHBhZ2UgaW5pdGlhbGl6YXRpb24gb24gYWxsDQo+Pj4+
Pj4+IHBsYXRmb3JtcyB3aXRoIG1lbWJsb2NrIGFsbG9jYXRvci4NCj4+Pj4+Pj4NCj4+Pj4+Pj4g
VGVzdGVkIG9uIHg4NiwgYXJtNjQsIGFuZCBzcGFyYy4gQWxzbywgdmVyaWZpZWQgdGhhdCBjb2Rl
IGNvbXBpbGVzIG9uDQo+Pj4+Pj4+IFBQQyB3aXRoIENPTkZJR19NRU1PUllfSE9UUExVRyBkaXNh
YmxlZC4NCj4+Pj4+Pg0KPj4+Pj4+IFRoZXJlIGlzIHNsaWdodCByaXNrIHRoYXQgd2Ugd2lsbCBl
bmNvdW50ZXIgY29ybmVyIGNhc2VzIG9uIHNvbWUNCj4+Pj4+PiBhcmNoaXRlY3R1cmVzIHdpdGgg
d2VpcmQgbWVtb3J5IGxheW91dC90b3BvbG9neQ0KPj4+Pj4NCj4+Pj4+IFdoaWNoIHg4Nl8zMi1w
YWUgc2VlbXMgdG8gYmUuIE1hbnkgYmFkIHBhZ2Ugc3RhdGUgZXJyb3JzIGFyZSBlbWl0dGVkDQo+
Pj4+PiBkdXJpbmcgYm9vdCB3aGVuIHRoaXMgcGF0Y2ggaXMgYXBwbGllZDoNCj4+Pj4NCj4+Pj4g
SGkgSmlyaSwNCj4+Pj4NCj4+Pj4gVGhhbmsgeW91IGZvciByZXBvcnRpbmcgdGhpcyBidWcuDQo+
Pj4+DQo+Pj4+IEJlY2F1c2UgMzItYml0IHN5c3RlbXMgYXJlIGxpbWl0ZWQgaW4gdGhlIG1heGlt
dW0gYW1vdW50IG9mIHBoeXNpY2FsDQo+Pj4+IG1lbW9yeSwgdGhleSBkb24ndCBuZWVkIGRlZmVy
cmVkIHN0cnVjdCBwYWdlcy4gU28sIHdlIGNhbiBhZGQgZGVwZW5kcw0KPj4+PiBvbiA2NEJJVCB0
byBERUZFUlJFRF9TVFJVQ1RfUEFHRV9JTklUIGluIG1tL0tjb25maWcuDQo+Pj4+DQo+Pj4+IEhv
d2V2ZXIsIGJlZm9yZSB3ZSBkbyB0aGlzLCBJIHdhbnQgdG8gdHJ5IHJlcHJvZHVjaW5nIHRoaXMg
cHJvYmxlbSBhbmQNCj4+Pj4gcm9vdCBjYXVzZSBpdCwgYXMgaXQgbWlnaHQgZXhwb3NlIGEgZ2Vu
ZXJhbCBwcm9ibGVtIHRoYXQgaXMgbm90IDMyLWJpdA0KPj4+PiBzcGVjaWZpYy4NCj4+Pg0KPj4+
IEhpIEppcmksDQo+Pj4NCj4+PiBDb3VsZCB5b3UgcGxlYXNlIGF0dGFjaCB5b3VyIGNvbmZpZyBh
bmQgZnVsbCBxZW11IGFyZ3VtZW50cyB0aGF0IHlvdQ0KPj4+IHVzZWQgdG8gcmVwcm9kdWNlIHRo
aXMgYnVnLg0KPj4NCj4+IEhpLA0KPj4NCj4+IEkgc2VlbSBJIG5ldmVyIHJlcGxpZWQuIEF0dGFj
aGluZyAuY29uZmlnIGFuZCB0aGUgcWVtdSBjbWRsaW5lOg0KPj4gJCBxZW11LWt2bSAtbSAyMDAw
IC1oZGEgL2Rldi9udWxsIC1rZXJuZWwgYnpJbWFnZQ0KPj4NCj4+ICItbSAyMDAwIiBpcyBpbXBv
cnRhbnQgdG8gcmVwcm9kdWNlLg0KPj4NCj4+IElmIEkgZGlzYWJsZSBDT05GSUdfREVGRVJSRURf
U1RSVUNUX1BBR0VfSU5JVCAod2hpY2ggdGhlIHBhdGNoIGFsbG93ZWQNCj4+IHRvIGVuYWJsZSks
IHRoZSBlcnJvciBnb2VzIGF3YXksIG9mIGNvdXJzZS4NCj4+DQo+PiB0aGFua3MsDQo+Pg0KPiAN
Cj4g
