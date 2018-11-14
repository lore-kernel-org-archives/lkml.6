Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B10C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D652086B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="Vo65S796"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D652086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeKOJqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:46:52 -0500
Received: from mail-eopbgr800052.outbound.protection.outlook.com ([40.107.80.52]:37856
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725952AbeKOJqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:46:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5VJRc1x5DiE3yMNONPZhDMoTWPBsqsnTvgxwHFOZio=;
 b=Vo65S796DuS3jmcdy8UV0fwzFQdGdy8h4KjuAFt/s2ZnS3gCBg340V4oKwr1g5qZnN/6kjsDRCMR+CmfyDBD9BoDubIpBn5AfuQ9HX0+3Rz8UNPXHpThlXBsqpyq/cRSZA8r/nSDrJtmbEqu1YPx/cL9QDI97Eh2Lvmm4/jMb4M=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5494.namprd05.prod.outlook.com (20.177.186.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.12; Wed, 14 Nov 2018 23:41:16 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1339.021; Wed, 14 Nov 2018
 23:41:16 +0000
From:   Nadav Amit <namit@vmware.com>
To:     David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>, Julien Freche <jfreche@vmware.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Christian Hansen <chansen3@cisco.com>,
        Dave Young <dyoung@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Juergen Gross <jgross@suse.com>,
        Kairui Song <kasong@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Len Brown <len.brown@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Omar Sandoval <osandov@fb.com>, Pavel Machek <pavel@ucw.cz>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH RFC 0/6] mm/kdump: allow to exclude pages that are
 logically offline
Thread-Topic: [PATCH RFC 0/6] mm/kdump: allow to exclude pages that are
 logically offline
Thread-Index: AQHUfG152sM90iZf406FL+kVOqcXy6VP5EIAgAAJ8YA=
Date:   Wed, 14 Nov 2018 23:41:16 +0000
Message-ID: <63214D36-14FD-4080-8E35-CF2A392D6507@vmware.com>
References: <20181114211704.6381-1-david@redhat.com>
 <8932E1F4-A5A9-4462-9800-CAC1EF85AC5D@vmware.com>
 <63c5f4b6-828a-764e-f64d-e603dc4b104e@redhat.com>
In-Reply-To: <63c5f4b6-828a-764e-f64d-e603dc4b104e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5494;20:M26yuFgavnbLstgXYn320vIwAbl+Inreb4h788J1g4pJrja1MZJimpLTvI2tQwz3xDvpCaqjD+7WLE/rjRu18R0Nv/1gMwobVnsekhwPPYVm14e8v0l6BjOLby4JGaWq7CZ1S4LOnZsZ/tmC/RbDs/W5Dn35BJQ3o1Dm1WPZgsg=
x-ms-office365-filtering-correlation-id: 67939310-0f45-4dd5-4c61-08d64a8aaba7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5494;
x-ms-traffictypediagnostic: BYAPR05MB5494:
x-microsoft-antispam-prvs: <BYAPR05MB549415076D62CBC779ADD0E0D0C30@BYAPR05MB5494.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231415)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5494;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5494;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(82746002)(6116002)(3846002)(36756003)(305945005)(486006)(256004)(476003)(99286004)(217873002)(6512007)(25786009)(2906002)(7736002)(6636002)(53936002)(478600001)(5660300001)(39060400002)(446003)(6436002)(11346002)(2616005)(4326008)(66066001)(26005)(33656002)(229853002)(14454004)(102836004)(6246003)(316002)(81156014)(81166006)(8676002)(6486002)(7416002)(71200400001)(71190400001)(83716004)(6506007)(53546011)(8936002)(110136005)(54906003)(97736004)(7406005)(86362001)(2900100001)(106356001)(186003)(68736007)(76176011)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5494;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QSx4i5pfbKNrdaiYF/TpSSP4eyg5BAmaPhrBPQK8KpIjz9XLFLvOBD747X8XECWA8Co7sksUfj6lN+A9jbNe9LWmh9x3IRDSTUXaQy3hqRjvFhH8rGShQDhM/xQu7Z0NfUCf87GL7bAMuvel4krCz9BBiLxEgHmEkY8jO34P3ZXqFF+kE3esTQa/naHT0PlPujJSQiiqKoxEiXUXMZ7PvyrsfWePXYeLWIcJ5FDTydKmWT0hk6Zwvkl1sWageq7ASGA86KKVq33ZYrvB9m6foty9IFUQ7GF5xyf/OQEk6QDySFI+mo80E8Km6rio0igduQpX9EsnV0+cTteGOz9fvMO6oNjLMc0dj5REzoLFx6I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <45598D8ED7B9944FBB381B5CF426DFE4@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67939310-0f45-4dd5-4c61-08d64a8aaba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 23:41:16.2814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5494
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGF2aWQgSGlsZGVuYnJhbmQNClNlbnQ6IE5vdmVtYmVyIDE0LCAyMDE4IGF0IDExOjA1
OjM4IFBNIEdNVA0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFJGQyAwLzZdIG1tL2tkdW1wOiBhbGxv
dyB0byBleGNsdWRlIHBhZ2VzIHRoYXQgYXJlIGxvZ2ljYWxseSBvZmZsaW5lDQo+IA0KPiANCj4g
T24gMTQuMTEuMTggMjM6NTcsIE5hZGF2IEFtaXQgd3JvdGU6DQo+PiBGcm9tOiBEYXZpZCBIaWxk
ZW5icmFuZA0KPj4gU2VudDogTm92ZW1iZXIgMTQsIDIwMTggYXQgOToxNjo1OCBQTSBHTVQNCj4+
PiBTdWJqZWN0OiBbUEFUQ0ggUkZDIDAvNl0gbW0va2R1bXA6IGFsbG93IHRvIGV4Y2x1ZGUgcGFn
ZXMgdGhhdCBhcmUgbG9naWNhbGx5IG9mZmxpbmUNCj4+PiANCj4+PiANCj4+PiBSaWdodCBub3cs
IHBhZ2VzIGluZmxhdGVkIGFzIHBhcnQgb2YgYSBiYWxsb29uIGRyaXZlciB3aWxsIGJlIGR1bXBl
ZA0KPj4+IGJ5IGR1bXAgdG9vbHMgbGlrZSBtYWtlZHVtcGZpbGUuIFdoaWxlIFhFTiBpcyBhYmxl
IHRvIGNoZWNrIGluIHRoZQ0KPj4+IGNyYXNoIGtlcm5lbCB3aGV0aGVyIGEgY2VydGFpbiBwZm4g
aXMgYWN0dWFsbCBiYWNrZWQgYnkgbWVtb3J5IGluIHRoZQ0KPj4+IGh5cGVydmlzb3IgKHNlZSB4
ZW5fb2xkbWVtX3Bmbl9pc19yYW0pIGFuZCBvcHRpbWl6ZSB0aGlzIGNhc2UsIGR1bXBzIG9mDQo+
Pj4gdmlydGlvLWJhbGxvb24gYW5kIGh2LWJhbGxvb24gaW5mbGF0ZWQgbWVtb3J5IHdpbGwgZXNz
ZW50aWFsbHkgcmVzdWx0IGluDQo+Pj4gemVybyBwYWdlcyBnZXR0aW5nIGFsbG9jYXRlZCBieSB0
aGUgaHlwZXJ2aXNvciBhbmQgdGhlIGR1bXAgZ2V0dGluZw0KPj4+IGZpbGxlZCB3aXRoIHRoaXMg
ZGF0YS4NCj4+IA0KPj4gSXMgdGhlcmUgYW55IHJlYXNvbiB0aGF0IFZNd2FyZSBiYWxsb29uIGRy
aXZlciBpcyBub3QgbWVudGlvbmVkPw0KPiANCj4gRGVmaW5pdGVseSAuLi4NCj4gDQo+IC4uLiBu
b3QgOykgLiBJIGhhdmVuJ3QgbG9va2VkIGF0IHZtd2FyZSdzIGJhbGxvb24gZHJpdmVyIHlldCAo
SSBvbmx5IHNhdw0KPiB0aGF0IHRoZXJlIHdhcyBxdWl0ZSBzb21lIGFjdGl2aXR5IHJlY2VudGx5
KS4gSSBndWVzcyBpdCBzaG91bGQgaGF2ZQ0KPiBzaW1pbGFyIHByb2JsZW1zLiAoSSBtZWFuIHJl
YWRpbmcgYW5kIGR1bXBpbmcgZGF0YSBub2JvZHkgY2FyZXMgYWJvdXQgaXMNCj4gY2VydGFpbmx5
IG5vdCBkZXNpcmVkKQ0KPiANCj4gQ2FuIHlvdSBzaGFyZSBpZiBzb21ldGhpbmcgbGlrZSB0aGlz
IGlzIGFsc28gZGVzaXJlZCBmb3Igdm13YXJlJ3MNCj4gaW1wbGVtZW50YXRpb24/IChJIHRhZ2dl
ZCB0aGlzIGFzIFJGQyB0byBnZXQgc29tZSBtb3JlIGZlZWRiYWNrKQ0KPiANCj4gSXQgc2hvdWxk
IGluIHRoZW9yeSBiZSBhcyBzaW1wbGUgYXMgYWRkaW5nIGEgaGFuZGZ1bCBvZg0KPiBfU2V0UGFn
ZU9mZmxpbmUoKS9fQ2xlYXJQYWdlT2ZmbGluZSgpIGF0IHRoZSByaWdodCBzcG90cy4NCg0KVGhh
bmtzLCBJIHdhcyBqdXN0IHN1c3BlY3RpbmcgaXQgaXMgcGVyc29uYWwgOy0pDQoNCkFjdHVhbGx5
LCBzb21lIHBhdGNoZXMgdGhhdCBJIHNlbnQgZm9yIDQuMjAgdG8gdXNlIHRoZSBiYWxsb29uLWNv
bXBhY3Rpb24NCmluZnJhc3RydWN0dXJlIGJ5IHRoZSBWTXdhcmUgYmFsbG9vbiBmZWxsIGJldHdl
ZW4gdGhlIGNyYWNrcywgYW5kIEkgbmVlZA0KdG8gcmVzZW5kIHRoZW0uDQoNCkkgd291bGQgb2J2
aW91c2x5IHByZWZlciB0aGF0IHlvdXIgY2hhbmdlcyB3b3VsZCBiZSBkb25lIG9uIHRvcCBvZiB0
aG9zZQ0KdGhhdCB3ZXJlIHNraXBwZWQuIFRoaXMgcGF0Y2gtc2V0IHNvdW5kcyB2ZXJ5IHJlYXNv
bmFibGUgdG8gbWUsIGJ1dCBJIHByZWZlcg0KdGhhdCBKdWxpZW4gKGNj4oCZZCkgd291bGQgYWxz
byBnaXZlIGhpcyBvcGluaW9uLg0KDQpSZWdhcmRzLA0KTmFkYXY=
