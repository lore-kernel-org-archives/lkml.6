Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2D3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2AB820661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FSVHN8k8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2AB820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeH3XlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:41:24 -0400
Received: from mail-dm3nam03on0123.outbound.protection.outlook.com ([104.47.41.123]:27184
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbeH3XlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIRKMUSLUGOkRT+6EMBbFvCiiyNosebJ4/N+BHFup1I=;
 b=FSVHN8k8XIyeqbuZ6WJytK2vSiSRr3yUlX8bgVdzBOSAFf5n1XXbhrr4gxltbE/sXdwOd/xFPYW0Ptuw3FBr3XBhKpGI+onSNO7Czi3VnWLz6qNFHvWWxv/xii9FWgSgPSggK8/B/A+dyvJY6F3533Go4ikzlCaEMAXLf2dCXYY=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0506.namprd21.prod.outlook.com (10.172.91.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.1; Thu, 30 Aug 2018 19:37:35 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1122.009; Thu, 30 Aug 2018
 19:37:35 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     David Hildenbrand <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Michael Neuling <mikey@neuling.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH RFCv2 3/6] mm/memory_hotplug: fix online/offline_pages
 called w.o. mem_hotplug_lock
Thread-Topic: [PATCH RFCv2 3/6] mm/memory_hotplug: fix online/offline_pages
 called w.o. mem_hotplug_lock
Thread-Index: AQHUQJjmAiMyK74aP0K/NBbsPnZS2g==
Date:   Thu, 30 Aug 2018 19:37:34 +0000
Message-ID: <a34ab7ac-e33b-47aa-0ee2-94d83de8c367@microsoft.com>
References: <20180821104418.12710-1-david@redhat.com>
 <20180821104418.12710-4-david@redhat.com>
In-Reply-To: <20180821104418.12710-4-david@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0506;6:v6uVRxT3AE6o48z+CI6EjEQYpK/7pwn3RwsATHsfDLN3ph2Z4NNTnHou4LAZwOU0iqt+tHQgF/tzAZO0k0lvqd9uxKOT+b9FSTnUfxBD+L8zIYgzekC+XQ6h8JH+5HF/m9H195Dr+N3T+AKzb22Iy4MgcMHXdL1Fqn0ogrL8rVATy3Bug36MAcN3xzzK1S9or8Ug1HV4xvYh0T1U5QnN2djoH/2XbcaCLBrSYG13AYeARnAFZFZA2jbkkt0WcWNT/kAkdwQkyBV82p6wop3CCpKHqYB2Z2mI7GF2BpJsUFh6LBe5Mf3J1Ez73L/5xzA45Fm2+ewGcL0RNQMFFu5MLpMRf+6PnxxPO1SZQPNSnvKR/eKzLgfhdic85XyrXK6HKugTR7uKhTplYNka9IRaAq5YL5KGIggMo4h/sstplrFtdq+vcpZjbfXHrAe1GQdbZAYV3fCqNT2tQmiPqnGtZQ==;5:FfBYkkLAbhVI/+ImSZUoGBhHv8hJWGw9zDasICHeLwLtHdz31gVSFmBDVCpFXBFTbugOCkOI4+Sji2JcIWzQmAiGBVnK9rlgFxEnxl+W7GQoD91akjbYig0v9zXpy+XJmvM6+A3SFyjmw1y3XHAnRhULu+F2aZDUjiEy3FpYzN0=;7:kodWNammCyD2J2/bRUVweQLBSyhzUfPLQIXhYiwaKdbDMY4iUF8gs3FQXt2XGJE1SHscCsbrIQnAW7Yr3hI5HiJmMYmYLbONahQfmflFkLkOZjoFc9ybeVRL1KEVM8t4l+2vDSkavWf+37Fuw3ymnug16ZklsayOozfUdeYNi+lpqmIkCNz6w3kXCZyCQsEYKc6iPTBOl3YQxLL61TUC9eBNRMprGOECcOkJC3owg/MExwYezkOcOXOl42o5awWf
x-ms-office365-filtering-correlation-id: 3bd4a794-1acd-4932-5f8f-08d60eb0093a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0506;
x-ms-traffictypediagnostic: DM5PR21MB0506:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB0506A7302E464F66EF3B99DC9D080@DM5PR21MB0506.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0506;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0506;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(136003)(396003)(366004)(346002)(189003)(199004)(43544003)(316002)(6486002)(54906003)(53546011)(99286004)(102836004)(22452003)(110136005)(486006)(4326008)(2616005)(6436002)(476003)(229853002)(11346002)(14444005)(256004)(6512007)(6306002)(53936002)(6506007)(36756003)(186003)(97736004)(2501003)(2900100001)(5250100002)(26005)(446003)(76176011)(6246003)(2906002)(6116002)(3846002)(72206003)(7406005)(14454004)(7416002)(966005)(86612001)(31696002)(39060400002)(106356001)(10290500003)(86362001)(575784001)(5660300001)(31686004)(8936002)(8676002)(7736002)(305945005)(105586002)(10090500001)(81156014)(81166006)(68736007)(66066001)(25786009)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0506;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eH1VTPK84ct0kBZ8PUn0M/mdw2hc1401qXr5f4xkJ0NIz3fdm0LP7jZsQlV59JwAtyXpPnMlzPJ7T5OMp49DSVhMana2V27q0Xg+vfkNumJqQr2UWWpDrDvs1dPEe1A+3senWocfrXx5PDx9zIrFPHvd+qB2ISgm7Zjk1Ba+I/H61WUnWdn37C86BO7FX5UJqmaBwbvD3JBgAmRqyrO3fVbw+YeEyIRaSVW9ztUrOFtUbBpWRrFnAoIoCYILXmPSjBOdQcKghSmWjmbGO00lVv84tCJLQoS8aWYz80XamEkL92SjBVTJ6zUYQuLrqEZuLuWgAfrAc26KtqTENx89456ejf53uFu+RKDlsHnSpvE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3469F0C8B8592041A0C8C2C69E240BB0@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd4a794-1acd-4932-5f8f-08d60eb0093a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 19:37:34.9115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0506
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8yMS8xOCA2OjQ0IEFNLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToNCj4gVGhlcmUgc2Vl
bSB0byBiZSBzb21lIHByb2JsZW1zIGFzIHJlc3VsdCBvZiAzMDQ2N2UwYjNiZSAoIm1tLCBob3Rw
bHVnOg0KPiBmaXggY29uY3VycmVudCBtZW1vcnkgaG90LWFkZCBkZWFkbG9jayIpLCB3aGljaCB0
cmllZCB0byBmaXggYSBwb3NzaWJsZQ0KPiBsb2NrIGludmVyc2lvbiByZXBvcnRlZCBhbmQgZGlz
Y3Vzc2VkIGluIFsxXSBkdWUgdG8gdGhlIHR3byBsb2Nrcw0KPiAJYSkgZGV2aWNlX2xvY2soKQ0K
PiAJYikgbWVtX2hvdHBsdWdfbG9jaw0KPiANCj4gV2hpbGUgYWRkX21lbW9yeSgpIGZpcnN0IHRh
a2VzIGIpLCBmb2xsb3dlZCBieSBhKSBkdXJpbmcNCj4gYnVzX3Byb2JlX2RldmljZSgpLCBvbmxp
bmluZyBvZiBtZW1vcnkgZnJvbSB1c2VyIHNwYWNlIGZpcnN0IHRvb2sgYiksDQo+IGZvbGxvd2Vk
IGJ5IGEpLCBleHBvc2luZyBhIHBvc3NpYmxlIGRlYWRsb2NrLg0KPiANCj4gSW4gWzFdLCBhbmQg
aXQgd2FzIGRlY2lkZWQgdG8gbm90IG1ha2UgdXNlIG9mIGRldmljZV9ob3RwbHVnX2xvY2ssIGJ1
dA0KPiByYXRoZXIgdG8gZW5mb3JjZSBhIGxvY2tpbmcgb3JkZXIuDQo+IA0KPiBUaGUgcHJvYmxl
bXMgSSBzcG90dGVkIHJlbGF0ZWQgdG8gdGhpczoNCj4gDQo+IDEuIE1lbW9yeSBibG9jayBkZXZp
Y2UgYXR0cmlidXRlczogV2hpbGUgLnN0YXRlIGZpcnN0IGNhbGxzDQo+ICAgIG1lbV9ob3RwbHVn
X2JlZ2luKCkgYW5kIHRoZSBjYWxscyBkZXZpY2Vfb25saW5lKCkgLSB3aGljaCB0YWtlcw0KPiAg
ICBkZXZpY2VfbG9jaygpIC0gLm9ubGluZSBkb2VzIG5vIGxvbmdlciBjYWxsIG1lbV9ob3RwbHVn
X2JlZ2luKCksIHNvDQo+ICAgIGVmZmVjdGl2ZWx5IGNhbGxzIG9ubGluZV9wYWdlcygpIHdpdGhv
dXQgbWVtX2hvdHBsdWdfbG9jay4NCj4gDQo+IDIuIGRldmljZV9vbmxpbmUoKSBzaG91bGQgYmUg
Y2FsbGVkIHVuZGVyIGRldmljZV9ob3RwbHVnX2xvY2ssIGhvd2V2ZXINCj4gICAgb25saW5pbmcg
bWVtb3J5IGR1cmluZyBhZGRfbWVtb3J5KCkgZG9lcyBub3QgdGFrZSBjYXJlIG9mIHRoYXQuDQo+
IA0KPiBJbiBhZGRpdGlvbiwgSSB0aGluayB0aGVyZSBpcyBhbHNvIHNvbWV0aGluZyB3cm9uZyBh
Ym91dCB0aGUgbG9ja2luZyBpbg0KPiANCj4gMy4gYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dl
cm52L21lbXRyYWNlLmMgY2FsbHMgb2ZmbGluZV9wYWdlcygpDQo+ICAgIHdpdGhvdXQgbG9ja3Mu
IFRoaXMgd2FzIGludHJvZHVjZWQgYWZ0ZXIgMzA0NjdlMGIzYmUuIEFuZCBza2ltbWluZyBvdmVy
DQo+ICAgIHRoZSBjb2RlLCBJIGFzc3VtZSBpdCBjb3VsZCBuZWVkIHNvbWUgbW9yZSBjYXJlIGlu
IHJlZ2FyZHMgdG8gbG9ja2luZw0KPiAgICAoZS5nLiBkZXZpY2Vfb25saW5lKCkgY2FsbGVkIHdp
dGhvdXQgZGV2aWNlX2hvdHBsdWdfbG9jayAtIGJ1dCBJJ2xsDQo+ICAgIG5vdCB0b3VjaCB0aGF0
IGZvciBub3cpLg0KPiANCj4gTm93IHRoYXQgd2UgaG9sZCB0aGUgZGV2aWNlX2hvdHBsdWdfbG9j
ayB3aGVuDQo+IC0gYWRkaW5nIG1lbW9yeSAoZS5nLiB2aWEgYWRkX21lbW9yeSgpL2FkZF9tZW1v
cnlfcmVzb3VyY2UoKSkNCj4gLSByZW1vdmluZyBtZW1vcnkgKGUuZy4gdmlhIHJlbW92ZV9tZW1v
cnkoKSkNCj4gLSBkZXZpY2Vfb25saW5lKCkvZGV2aWNlX29mZmxpbmUoKQ0KPiANCj4gV2UgY2Fu
IG1vdmUgbWVtX2hvdHBsdWdfbG9jayB1c2FnZSBiYWNrIGludG8NCj4gb25saW5lX3BhZ2VzKCkv
b2ZmbGluZV9wYWdlcygpLg0KPiANCj4gV2h5IGlzIG1lbV9ob3RwbHVnX2xvY2sgc3RpbGwgbmVl
ZGVkPyBFc3NlbnRpYWxseSB0byBtYWtlDQo+IGdldF9vbmxpbmVfbWVtcygpL3B1dF9vbmxpbmVf
bWVtcygpIGJlIHZlcnkgZmFzdCAocmVseWluZyBvbg0KPiBkZXZpY2VfaG90cGx1Z19sb2NrIHdv
dWxkIGJlIHZlcnkgc2xvdyksIGFuZCB0byBzZXJpYWxpemUgYWdhaW5zdA0KPiBhZGRpdGlvbiBv
ZiBtZW1vcnkgdGhhdCBkb2VzIG5vdCBjcmVhdGUgbWVtb3J5IGJsb2NrIGRldmljZXMgKGhtbSku
DQo+IA0KPiBbMV0gaHR0cDovL2RyaXZlcmRldi5saW51eGRyaXZlcnByb2plY3Qub3JnL3BpcGVy
bWFpbC8gZHJpdmVyZGV2LWRldmVsLw0KPiAgICAgMjAxNS1GZWJydWFyeS8wNjUzMjQuaHRtbA0K
PiANCj4gVGhpcyBwYXRjaCBpcyBwYXJ0bHkgYmFzZWQgb24gYSBwYXRjaCBieSBWaXRhbHkgS3V6
bmV0c292Lg0KDQpSZXZpZXdlZC1ieTogUGF2ZWwgVGF0YXNoaW4gPHBhdmVsLnRhdGFzaGluQG1p
Y3Jvc29mdC5jb20+
