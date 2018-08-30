Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C791C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B079820834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nLHMUlEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B079820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbeHaAZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 20:25:45 -0400
Received: from mail-sn1nam01on0108.outbound.protection.outlook.com ([104.47.32.108]:26432
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726674AbeHaAZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 20:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNZIt1FlAz2glSp8vj50TIgSwt+hJgHh6nIAM2XGA1o=;
 b=nLHMUlEaVfw+sqdiRNJdFsJXnf5hRUi54HJ0nOo1gX5Fca/9F9qU9FDHgJoHEJdnRhsOFX3l4Omwh1GSJ0tnG6eZddeYmSxM5ltaxLTv0Fch66V3ejcaJCFN4rr9CO0fFAGzg5b9sp/C/q04+VDECbuJGJ4cbbUycCgfu1GA+GE=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0633.namprd21.prod.outlook.com (10.175.111.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.1; Thu, 30 Aug 2018 20:20:08 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1122.009; Thu, 30 Aug 2018
 20:20:08 +0000
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
Subject: Re: [PATCH v1 1/5] mm/memory_hotplug: drop intermediate
 __offline_pages
Thread-Topic: [PATCH v1 1/5] mm/memory_hotplug: drop intermediate
 __offline_pages
Thread-Index: AQHUQJ59Fv4pzCSRAUqx3U7CPs7foqTYvHEA
Date:   Thu, 30 Aug 2018 20:20:08 +0000
Message-ID: <95018407-0c7a-b3b8-8c09-109337f91929@microsoft.com>
References: <20180816100628.26428-1-david@redhat.com>
 <20180816100628.26428-2-david@redhat.com>
 <8be94e97-b59a-b66d-f703-3a39510a831b@microsoft.com>
In-Reply-To: <8be94e97-b59a-b66d-f703-3a39510a831b@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0633;6:yrdBWjag5Imy4XqturPMyE2GVj7J7G8O9bkSa1A5HEh1hEgYcdY9+vPTL3Js39iJVlifATO/TU0CziSeFutDrmqe//oWPS/DyHh5/0OMrqnH8J2arSOw6F4GbtuGLbHprMW3pIWDDI03EpjPsQW8Y0k0EcG7cd5snk1HAbZDx38tVjvXQ0ehqyAzURCNRS2JgjrqbMzOHWNp82GAud6SVjq3ZBGadKzZglP0EtmufHHYETPwUMqrTTukkWXXLeoY8QTmdI/z09379vlNoYDjrcfKdvMpduqFAf3zlFc7vsIhHJpYdCaHeFsisodKAkRItnBP986+uLG8aMbGc6kr0S+XJcFa87EItJjK3lSg3/La9CdYu/oJ+8Mse7jN/IHexhQcPfpoFeqP5ug7Bw/rMQY9Q8X8JJX38JvMKTjfGpGK62WiyhS0EfKyX226S1JFyWprw8AfegVJC8Fm+fpTvQ==;5:V2B2/koyVt1dwVePEPe+TiPqVj5OiEq+IonGwz+wKTzaPOujHENBAardkDWDg6lV/y5zv0oyrKhYyqmPDMGXiiLyKU7wQLkAG3NimUV8SAbxX6N0F5Mh2ekGtCkQsdApynR4ElzJ3abdWj48lBZwxeKqlKZiplNKXG8XiWpSdfk=;7:jxwv7a13/IZ1AmEMmBwGSSnrfSBCJe7nfXVamQsipQEK8eUr1JMprkuJxqbgbJ6jqyOaMxAU6aOFio/xbeyDpaeIbFfUwHr0545FVpX4zvJkdY8V7VsdkT4GJbe9nHSBOpAEv7VRyRUl5X5hXkE9iyw2MCCxVQVPReB94UzMgR+voJNqPHCg/qKALtjnsAytfhC2ASfaIO6S0ScO3bDaNyxPZHtVdcwzLIVBQhnE2FhWNdLzjxAHlR36imeWBqUp
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a483b1dd-882e-46a2-3ac5-08d60eb5fb1a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0633;
x-ms-traffictypediagnostic: DM5PR21MB0633:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB063312980B10EFBB25BFDB019D080@DM5PR21MB0633.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231340)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0633;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0633;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(136003)(39860400002)(376002)(199004)(189003)(25786009)(478600001)(68736007)(8936002)(229853002)(6246003)(54906003)(39060400002)(14454004)(97736004)(72206003)(110136005)(99286004)(36756003)(7736002)(305945005)(8676002)(6116002)(3846002)(7416002)(86362001)(5660300001)(86612001)(14444005)(22452003)(31696002)(256004)(2900100001)(31686004)(76176011)(2906002)(316002)(10090500001)(186003)(106356001)(81156014)(486006)(81166006)(105586002)(2616005)(2501003)(53546011)(476003)(102836004)(26005)(6506007)(4326008)(6436002)(11346002)(66066001)(6486002)(6512007)(53936002)(446003)(5250100002)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0633;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OrYBo2QMalTAO3aUUWGq72pCMNPDnV8JoxaIG20P06gSmnkzY4xx/vuLAZfWEx0rB/E7q43BG/rpit8yOGoFNOMK6ytgjQOC4A08//uCTaD/ZsI/+190lIleXM2Pqd5jpY+UCKqm//qxw268RwWXzGkEWXpVWnZCsm6h+WJAzlZid/um7jY8bdveBKhfzTYw46KGMTh/YWiZRpTZAy2j+u28/uXv0NI4rXH4xNLgp/5uFYcB2vpNQzLg0rp2myEWiOTTwjb0NVDa06zQlnF93cRZB0TseUXPcJL8XL/5ZsM+VoR5uUcPXO2Tv2s01t0ItNW768xJaM4e4OPMTlEWw2RSW70Xc8ebLbyj570725k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F14FC2AD6A6E3543B94507DADA5BC8D7@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a483b1dd-882e-46a2-3ac5-08d60eb5fb1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 20:20:08.2662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0633
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDgvMzAvMTggNDoxNyBQTSwgUGFzaGEgVGF0YXNoaW4gd3JvdGU6DQo+IEkgZ3Vlc3Mg
dGhlIHdyYXAgd2FzIGRvbmUgYmVjYXVzZSBvZiBfX3JlZiwgYnV0IG5vIHJlYXNvbiB0byBoYXZl
IHRoaXMNCj4gd3JhcC4gU28gbG9va3MgZ29vZCB0byBtZS4NCj4gDQo+IFJldmlld2VkLWJ5OiBQ
YXZlbCBUYXRhc2hpbiA8cGF2ZWwudGF0YXNoaW5AbWljcm9zb2Z0LmNvbT4+DQo+IE9uIDgvMTYv
MTggNjowNiBBTSwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+PiBMZXQncyBhdm9pZCB0aGlz
IGluZGlyZWN0aW9uIGFuZCBqdXN0IGNhbGwgdGhlIGZ1bmN0aW9uIG9mZmxpbmVfcGFnZXMoKS4N
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNv
bT4NCj4+IC0tLQ0KPj4gIG1tL21lbW9yeV9ob3RwbHVnLmMgfCAxMyArKystLS0tLS0tLS0tDQo+
PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL21tL21lbW9yeV9ob3RwbHVnLmMgYi9tbS9tZW1vcnlfaG90cGx1Zy5j
DQo+PiBpbmRleCA2YTI3MjY5MjBlZDIuLjA5MGNmNDc0ZGU4NyAxMDA2NDQNCj4+IC0tLSBhL21t
L21lbW9yeV9ob3RwbHVnLmMNCj4+ICsrKyBiL21tL21lbW9yeV9ob3RwbHVnLmMNCj4+IEBAIC0x
NTg5LDEwICsxNTg5LDEwIEBAIHN0YXRpYyB2b2lkIG5vZGVfc3RhdGVzX2NsZWFyX25vZGUoaW50
IG5vZGUsIHN0cnVjdCBtZW1vcnlfbm90aWZ5ICphcmcpDQo+PiAgCQlub2RlX2NsZWFyX3N0YXRl
KG5vZGUsIE5fTUVNT1JZKTsNCj4+ICB9DQo+PiAgDQo+PiAtc3RhdGljIGludCBfX3JlZiBfX29m
ZmxpbmVfcGFnZXModW5zaWduZWQgbG9uZyBzdGFydF9wZm4sDQo+PiAtCQkgIHVuc2lnbmVkIGxv
bmcgZW5kX3BmbikNCj4+ICsvKiBNdXN0IGJlIHByb3RlY3RlZCBieSBtZW1faG90cGx1Z19iZWdp
bigpIG9yIGEgZGV2aWNlX2xvY2sgKi8NCj4+ICtpbnQgb2ZmbGluZV9wYWdlcyh1bnNpZ25lZCBs
b25nIHN0YXJ0X3BmbiwgdW5zaWduZWQgbG9uZyBucl9wYWdlcykNCiAgICAgIF5eXg0KSSBtZWFu
dCB0byBzYXkga2VlcCB0aGUgX19yZWYsIG90aGVyd2lzZSBsb29rcyBnb29kLg0KDQpUaGFuayB5
b3UsDQpQYXZlbA==
