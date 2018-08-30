Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D81C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043662082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Hvd/Lt5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043662082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeHaCS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:18:26 -0400
Received: from mail-sn1nam02on0124.outbound.protection.outlook.com ([104.47.36.124]:24708
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbeHaCSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwiuGXsfEsHg2RaHHPFrfU59mK6oF8AGVLi8el31aNc=;
 b=Hvd/Lt5q3L5geDusAaFSCbO555DkHsRruKiDhab/iZw9mahZ1QQIlT+z3zRLfgO1C+z0KtjitRF4WZQvShyh1fadLpO9o1+F1XELVeafhcLOhEyzB4/X2svNKcMgj8JCE+3HOIoQW+x93R5SapOIOOddLrjmwfdf6KEdOYy8DtY=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0281.namprd21.prod.outlook.com (10.173.174.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Thu, 30 Aug 2018 22:14:02 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1122.009; Thu, 30 Aug 2018
 22:14:02 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Kemi Wang <kemi.wang@intel.com>,
        David Rientjes <rientjes@google.com>,
        Jia He <jia.he@hxt-semitech.com>,
        Oscar Salvador <osalvador@suse.de>,
        Petr Tesarik <ptesarik@suse.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mathieu Malaterre <malat@debian.org>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Ross Zwisler <zwisler@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v1 2/5] mm/memory_hotplug: enforce section alignment when
 onlining/offlining
Thread-Topic: [PATCH v1 2/5] mm/memory_hotplug: enforce section alignment when
 onlining/offlining
Thread-Index: AQHUQK7BnPNkBWxNqk+GGH2a75UbYA==
Date:   Thu, 30 Aug 2018 22:14:01 +0000
Message-ID: <772774b8-77d8-c09b-f933-5ce29be58fa9@microsoft.com>
References: <20180816100628.26428-1-david@redhat.com>
 <20180816100628.26428-3-david@redhat.com>
In-Reply-To: <20180816100628.26428-3-david@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0281;6:z1m+srgQgyeXXz6B5woY8+vm8v7jYyXC1yDOtNn4tK3aYqy7UzqoYV0p9S2Vqbugoev2f86NqEen7bbt0yIh9cHKw3aM3deA8jvgr08wusT39Ab4840hiOukpn1u17qHgefKeFofMle1qbQ9T4Cko3orZhtFfNl0GWJ3wwDj3k5KFmr5etQA+mMLDQDMRDRkj/EhKz3VIcZFJoi95hoqjbndqrta5bFyjeSBa9NZekCLDR51EayA9hskkXyi2t5RiZJDRQjJXehZENstrUeuCGy0Vb6XjPxjcNDzLTEIeT+p4yFMFih5XdXi7nDnHDVjjDF+9hORMT6l82qCAdEnGZbfUETl5urL1bAchTJ2Yaz+wYof0L4umF4XgvwKhlbhs6bbVudfoF1zDQLmU4Ep4qHrcRjyci1agAL53+AIdt67jRRKtYOszFi6U1rEjtOeiQd8pb+vIdkryzFj+EIAzg==;5:wTXSILyQpdBmHks34XgVdnsuAWCMHy6i9LVdAq74Qcdd18F5I0s01NMSMyfbOhzGP53ii0VD9ErmoxGanJhhUxeowXvvwDpRcaL67l3eMJtv2VtrsGnNl+GkDUoim8XYTPgKtwE3MlA5GFOoMwiNJ93dS1iFRbzLchUBcvk0ThM=;7:axm3TjYq62tMarNto2aqAhmqcOuxt2geKuN5FaCTVkQ93Ro4RvT4gIwVZ+fIEGaZwxSEhmHe5k/5SgW0/VZXQxxJE8nCBg7DPzYm6zEsdE7Hk/2kcO6UmjYbAPyp45qev4Bl73z30WiZP39n8NWWGi7ku99VCenD4JDSrDtzMkw/Asi4cmz7hkaWNgTTlddyEV0btIT+4tk+PPVoCiZQbDYQl4TB8Ds0bc05shMsMBGLFzWY/wGobCUkA0LnQElW
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8f0f94f0-948f-4a39-f4ad-08d60ec5e451
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0281;
x-ms-traffictypediagnostic: DM5PR21MB0281:
x-microsoft-antispam-prvs: <DM5PR21MB0281D9307277178673990C5E9D080@DM5PR21MB0281.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0281;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0281;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(366004)(39860400002)(346002)(396003)(136003)(189003)(199004)(6506007)(99286004)(102836004)(31696002)(86612001)(68736007)(2501003)(86362001)(66066001)(5250100002)(575784001)(53546011)(26005)(186003)(6346003)(2900100001)(53936002)(97736004)(2906002)(256004)(8936002)(105586002)(10090500001)(106356001)(36756003)(31686004)(14444005)(5660300001)(2616005)(478600001)(486006)(54906003)(110136005)(10290500003)(316002)(476003)(72206003)(6116002)(7416002)(446003)(22452003)(14454004)(11346002)(229853002)(25786009)(7736002)(305945005)(81156014)(6486002)(3846002)(76176011)(6436002)(4326008)(39060400002)(8676002)(6246003)(81166006)(6512007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0281;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: Xl2nrFoQFWc5OSl6p5QDZZL/lgtNq0pTFv/E3eVhAsYD9gnOMx/adaaeekf2CvPzAybGrC4YYX/hlE1JLkEZoNJztAW3/iYA3ZyXVSeskQv32KBgTkU1wEd025Y6ZJ0Fkxz975kdDPIdss8MGQNlQlXqxYlAj7a8nkBDrHwEcHiN/XPVYKABClR4nr3RTOufX4hI0rEmZiLJsFS4FP+e7zvv7DPJEaM+mMpkjuCBDTVYsiRGiU0en+SPcVwN1+MWLlXzSm5wmC0R4LIq+Es0dULHOeBOGpLMvTDf4QRh7mqaCGu0wjOTKN3Y/y8k89273npsEM/3hjkvKBcDsAl/pcMI+MzNzXAs71S3dXBWoHs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4E350E2BB14124E99AA86C091331C71@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0f94f0-948f-4a39-f4ad-08d60ec5e451
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 22:14:02.0025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0281
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGF2aWQsDQoNCkkgYW0gbm90IHN1cmUgdGhpcyBpcyBuZWVkZWQsIGJlY2F1c2Ugd2UgYWxy
ZWFkeSBoYXZlIGEgc3RyaWN0ZXIgY2hlY2tlcjoNCg0KY2hlY2tfaG90cGx1Z19tZW1vcnlfcmFu
Z2UoKQ0KDQpZb3UgY291bGQgY2FsbCBpdCBmcm9tIG9ubGluZV9wYWdlcygpLCBpZiB5b3UgdGhp
bmsgdGhlcmUgaXMgYSByZWFzb24gdG8NCmRvIGl0LCBidXQgb3RoZXIgdGhhbiB0aGF0IGl0IGlz
IGRvbmUgZnJvbSBhZGRfbWVtb3J5X3Jlc291cmNlKCkgYW5kDQpmcm9tIHJlbW92ZV9tZW1vcnko
KS4NCg0KVGhhbmsgeW91LA0KUGF2ZWwNCg0KT24gOC8xNi8xOCA2OjA2IEFNLCBEYXZpZCBIaWxk
ZW5icmFuZCB3cm90ZToNCj4gb25saW5pbmcvb2ZmbGluaW5nIGNvZGUgd29ya3Mgb24gd2hvbGUg
c2VjdGlvbnMsIHNvIGxldCdzIGVuZm9yY2UgdGhhdC4NCj4gRXhpc3RpbmcgY29kZSBvbmx5IGFs
bG93cyB0byBhZGQgbWVtb3J5IGluIG1lbW9yeSBibG9jayBzaXplLiBBbmQgb25seQ0KPiB3aG9s
ZSBtZW1vcnkgYmxvY2tzIGNhbiBiZSBvbmxpbmVkL29mZmxpbmVkLiBNZW1vcnkgYmxvY2tzIGFy
ZSBhbHdheXMNCj4gYWxpZ25lZCB0byBzZWN0aW9ucywgc28gdGhpcyBzaG91bGQgbm90IGJyZWFr
IGFueXRoaW5nLg0KPiANCj4gb25saW5lX3BhZ2VzL29mZmxpbmVfcGFnZXMgd2lsbCBpbXBsaWNp
dGx5IG1hcmsgd2hvbGUgc2VjdGlvbnMNCj4gb25saW5lL29mZmxpbmUsIHNvIHRoZSBjb2RlIHJl
YWxseSBjYW4gb25seSBoYW5kbGUgc3VjaCBncmFudWxhcml0aWVzLg0KPiANCj4gKGVzcGVjaWFs
bHkgb2ZmbGluaW5nIGNvZGUgY2Fubm90IGRlYWwgd2l0aCBwYWdlYmxvY2tfbnJfcGFnZXMgYnV0
DQo+ICB0aGVvcmV0aWNhbGx5IG9ubHkgTUFYX09SREVSLTEpDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICBtbS9tZW1v
cnlfaG90cGx1Zy5jIHwgMTAgKysrKysrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tbS9tZW1vcnlfaG90
cGx1Zy5jIGIvbW0vbWVtb3J5X2hvdHBsdWcuYw0KPiBpbmRleCAwOTBjZjQ3NGRlODcuLjMwZDJm
YTQyYjBiYiAxMDA2NDQNCj4gLS0tIGEvbW0vbWVtb3J5X2hvdHBsdWcuYw0KPiArKysgYi9tbS9t
ZW1vcnlfaG90cGx1Zy5jDQo+IEBAIC04OTcsNiArODk3LDExIEBAIGludCBfX3JlZiBvbmxpbmVf
cGFnZXModW5zaWduZWQgbG9uZyBwZm4sIHVuc2lnbmVkIGxvbmcgbnJfcGFnZXMsIGludCBvbmxp
bmVfdHlwDQo+ICAJc3RydWN0IG1lbW9yeV9ub3RpZnkgYXJnOw0KPiAgCXN0cnVjdCBtZW1vcnlf
YmxvY2sgKm1lbTsNCj4gIA0KPiArCWlmICghSVNfQUxJR05FRChwZm4sIFBBR0VTX1BFUl9TRUNU
SU9OKSkNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJaWYgKCFJU19BTElHTkVEKG5yX3BhZ2Vz
LCBQQUdFU19QRVJfU0VDVElPTikpDQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArDQo+ICAJLyoN
Cj4gIAkgKiBXZSBjYW4ndCB1c2UgcGZuX3RvX25pZCgpIGJlY2F1c2UgbmlkIG1pZ2h0IGJlIHN0
b3JlZCBpbiBzdHJ1Y3QgcGFnZQ0KPiAgCSAqIHdoaWNoIGlzIG5vdCB5ZXQgaW5pdGlhbGl6ZWQu
IEluc3RlYWQsIHdlIGZpbmQgbmlkIGZyb20gbWVtb3J5IGJsb2NrLg0KPiBAQCAtMTYwMCwxMCAr
MTYwNSw5IEBAIGludCBvZmZsaW5lX3BhZ2VzKHVuc2lnbmVkIGxvbmcgc3RhcnRfcGZuLCB1bnNp
Z25lZCBsb25nIG5yX3BhZ2VzKQ0KPiAgCXN0cnVjdCB6b25lICp6b25lOw0KPiAgCXN0cnVjdCBt
ZW1vcnlfbm90aWZ5IGFyZzsNCj4gIA0KPiAtCS8qIGF0IGxlYXN0LCBhbGlnbm1lbnQgYWdhaW5z
dCBwYWdlYmxvY2sgaXMgbmVjZXNzYXJ5ICovDQo+IC0JaWYgKCFJU19BTElHTkVEKHN0YXJ0X3Bm
biwgcGFnZWJsb2NrX25yX3BhZ2VzKSkNCj4gKwlpZiAoIUlTX0FMSUdORUQoc3RhcnRfcGZuLCBQ
QUdFU19QRVJfU0VDVElPTikpDQo+ICAJCXJldHVybiAtRUlOVkFMOw0KPiAtCWlmICghSVNfQUxJ
R05FRChlbmRfcGZuLCBwYWdlYmxvY2tfbnJfcGFnZXMpKQ0KPiArCWlmICghSVNfQUxJR05FRChu
cl9wYWdlcywgUEFHRVNfUEVSX1NFQ1RJT04pKQ0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gIAkv
KiBUaGlzIG1ha2VzIGhvdHBsdWcgbXVjaCBlYXNpZXIuLi5hbmQgcmVhZGFibGUuDQo+ICAJICAg
d2UgYXNzdW1lIHRoaXMgZm9yIG5vdy4gLiovDQo+IA==
