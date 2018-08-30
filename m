Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56136C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0027520835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="N5jiEJ4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0027520835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeHaAXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 20:23:11 -0400
Received: from mail-eopbgr710125.outbound.protection.outlook.com ([40.107.71.125]:15104
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726674AbeHaAXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 20:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwEROtd/r4DBkLltIyDMXn8jfzAYArNdGDp9gifL9Lk=;
 b=N5jiEJ4/n0ul8FYtsOFN3lf9Bdpbums3QToKIAYijJ7/33hDejdJABV7LzFYEMwr6xLKnJBf4p6ZzYVwzpK15YJPJ1HSW3jBo3WC7Dfn1NoFS3zvD6b8PkPpoyR91fMwBKkTfpMp4vOIb2xZmEf1TSXbTHBf5rNYy7SQ+VhmAl0=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0793.namprd21.prod.outlook.com (10.175.112.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.1; Thu, 30 Aug 2018 20:17:35 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1122.009; Thu, 30 Aug 2018
 20:17:35 +0000
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
Thread-Index: AQHUQJ59Fv4pzCSRAUqx3U7CPs7fog==
Date:   Thu, 30 Aug 2018 20:17:34 +0000
Message-ID: <8be94e97-b59a-b66d-f703-3a39510a831b@microsoft.com>
References: <20180816100628.26428-1-david@redhat.com>
 <20180816100628.26428-2-david@redhat.com>
In-Reply-To: <20180816100628.26428-2-david@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0793;6:QrHGyPj9CEYeH98nAi4F07TrX+0wTlCa3HcdaJG8DzUy7pyL/R+tlVUikBq6FPI1X/jdIo+GGxK6c9Vj/IPYIJlm510ZAH4xULVI8rGzR1xsND5HQrt2VPlCdE+2N28/GjFNtqmfg+ZZgJlmu2MdRCfiBazgOSfw/SfO4Z2lZRY8yWUDbeNol5blTI5Q9y2+g9DJYat8F5CKIO+l9JKMf1b1e5DshQeACGHmjm43+45FTHTynACMHUb8IAwsdTfdFPuyishRS3y6/0kOFJo8gjW+MA+48Oi1Inc7KgBWOKXAtK23b77jp0Y9PfQM7hCyX2dPhxjx6lT9d64Is/m+skisf7NLZbWwa+dbZHhRnd8NY25LVbAhhR+9SGh6Noz/V/SnWZ103q0LJvCmQMFZOGIbMINj/LBczI39O/1ZLv5URIbtPoQczUTtSJ2Hk2Qr1X2EhAOFO4DC8dhc2xty9w==;5:xVETgpCBIAsZBxkTNP3VFAoIWtwENfLnpfO8sHbgYCheThvfM+LJprwzBHSxBy2dtYpbW7OUAxVe4gs4kG0NsNNdnrokajSsndsK5K3pt1am9FFKLdhgYdqNYEsp6npe596fTkJQMhiXPb/0yvdosjzeS+eMxlTQwEvQBKJohHM=;7:5czERc+3FIOFKYY7lqLtyj+3Yu+fwN8gnQT2RBU07kaQjV2peUjyJ2kJFEJsu1RNjr+MKwgYFzxRYAWehIUzEbSwHNLp+FCaSj0vG4Ou+1A8l29bnAlZV+5r34/GWTqDSz8T0xeKs31ugPGG1cPrmaqi5dWuM++o6vXsP8NZQL41joGszbHJ4Bq8QmPxNf9M67Ur9vGIuwSu07/aZPkamSv4u2lGBUOzyei2xpLP1UKgHbx4ECppjVLZ1TpJDz1b
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e776b048-9bdd-4ac2-06c2-08d60eb59fba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0793;
x-ms-traffictypediagnostic: DM5PR21MB0793:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB07938768B00AB6E604BCB7159D080@DM5PR21MB0793.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0793;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0793;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(2900100001)(186003)(36756003)(14454004)(76176011)(54906003)(26005)(8676002)(256004)(81156014)(81166006)(14444005)(305945005)(106356001)(5250100002)(5660300001)(86612001)(31696002)(110136005)(105586002)(6506007)(53546011)(102836004)(7416002)(86362001)(229853002)(7736002)(10090500001)(2501003)(11346002)(6246003)(72206003)(25786009)(6512007)(446003)(39060400002)(6116002)(2906002)(316002)(68736007)(478600001)(4326008)(3846002)(8936002)(97736004)(31686004)(6486002)(99286004)(22452003)(6436002)(53936002)(66066001)(476003)(10290500003)(2616005)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0793;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fE1+MkuNBvFkDxeXtdlJK1/HiIwQd44+FIpX6ihGC9BXJgziTdJlVKAi6YcXe0Jy4NTFF5M7Xyl6yvFKMNZt0srLLrivDrCblIUIbJBhQJdgE8CzLJdglkhkEkEJNqY510lRa7cYqAQYZ/r6mBUIKMaJhmtRT2vZBm+BT3SLPqvLVIzZPy+WehuWeci9VwQMX3BRBHmQRvSX074MbPI9/l0i3wrfNJsN/qb+lDG7opvjXL6+MwPHv9q78iKCjAnYeJLXs2mEcz1fnK6m5faz1L5XZJeoDSHkl+DGhPp2yB2G9knLkyDSLHC0bhsGKO6fakuBL5ePBRvduTaqbQYY6W19DVk2NWcEMqMIlloYtso=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D389E49CDC8BF418FAFB9C27991DE93@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e776b048-9bdd-4ac2-06c2-08d60eb59fba
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 20:17:34.9590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0793
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSBndWVzcyB0aGUgd3JhcCB3YXMgZG9uZSBiZWNhdXNlIG9mIF9fcmVmLCBidXQgbm8gcmVhc29u
IHRvIGhhdmUgdGhpcw0Kd3JhcC4gU28gbG9va3MgZ29vZCB0byBtZS4NCg0KUmV2aWV3ZWQtYnk6
IFBhdmVsIFRhdGFzaGluIDxwYXZlbC50YXRhc2hpbkBtaWNyb3NvZnQuY29tPg0KDQpPbiA4LzE2
LzE4IDY6MDYgQU0sIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOg0KPiBMZXQncyBhdm9pZCB0aGlz
IGluZGlyZWN0aW9uIGFuZCBqdXN0IGNhbGwgdGhlIGZ1bmN0aW9uIG9mZmxpbmVfcGFnZXMoKS4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29t
Pg0KPiAtLS0NCj4gIG1tL21lbW9yeV9ob3RwbHVnLmMgfCAxMyArKystLS0tLS0tLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9tbS9tZW1vcnlfaG90cGx1Zy5jIGIvbW0vbWVtb3J5X2hvdHBsdWcuYw0KPiBp
bmRleCA2YTI3MjY5MjBlZDIuLjA5MGNmNDc0ZGU4NyAxMDA2NDQNCj4gLS0tIGEvbW0vbWVtb3J5
X2hvdHBsdWcuYw0KPiArKysgYi9tbS9tZW1vcnlfaG90cGx1Zy5jDQo+IEBAIC0xNTg5LDEwICsx
NTg5LDEwIEBAIHN0YXRpYyB2b2lkIG5vZGVfc3RhdGVzX2NsZWFyX25vZGUoaW50IG5vZGUsIHN0
cnVjdCBtZW1vcnlfbm90aWZ5ICphcmcpDQo+ICAJCW5vZGVfY2xlYXJfc3RhdGUobm9kZSwgTl9N
RU1PUlkpOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgaW50IF9fcmVmIF9fb2ZmbGluZV9wYWdlcyh1
bnNpZ25lZCBsb25nIHN0YXJ0X3BmbiwNCj4gLQkJICB1bnNpZ25lZCBsb25nIGVuZF9wZm4pDQo+
ICsvKiBNdXN0IGJlIHByb3RlY3RlZCBieSBtZW1faG90cGx1Z19iZWdpbigpIG9yIGEgZGV2aWNl
X2xvY2sgKi8NCj4gK2ludCBvZmZsaW5lX3BhZ2VzKHVuc2lnbmVkIGxvbmcgc3RhcnRfcGZuLCB1
bnNpZ25lZCBsb25nIG5yX3BhZ2VzKQ0KPiAgew0KPiAtCXVuc2lnbmVkIGxvbmcgcGZuLCBucl9w
YWdlczsNCj4gKwl1bnNpZ25lZCBsb25nIHBmbiwgZW5kX3BmbiA9IHN0YXJ0X3BmbiArIG5yX3Bh
Z2VzOw0KPiAgCWxvbmcgb2ZmbGluZWRfcGFnZXM7DQo+ICAJaW50IHJldCwgbm9kZTsNCj4gIAl1
bnNpZ25lZCBsb25nIGZsYWdzOw0KPiBAQCAtMTYxMiw3ICsxNjEyLDYgQEAgc3RhdGljIGludCBf
X3JlZiBfX29mZmxpbmVfcGFnZXModW5zaWduZWQgbG9uZyBzdGFydF9wZm4sDQo+ICANCj4gIAl6
b25lID0gcGFnZV96b25lKHBmbl90b19wYWdlKHZhbGlkX3N0YXJ0KSk7DQo+ICAJbm9kZSA9IHpv
bmVfdG9fbmlkKHpvbmUpOw0KPiAtCW5yX3BhZ2VzID0gZW5kX3BmbiAtIHN0YXJ0X3BmbjsNCj4g
IA0KPiAgCS8qIHNldCBhYm92ZSByYW5nZSBhcyBpc29sYXRlZCAqLw0KPiAgCXJldCA9IHN0YXJ0
X2lzb2xhdGVfcGFnZV9yYW5nZShzdGFydF9wZm4sIGVuZF9wZm4sDQo+IEBAIC0xNzAwLDEyICsx
Njk5LDYgQEAgc3RhdGljIGludCBfX3JlZiBfX29mZmxpbmVfcGFnZXModW5zaWduZWQgbG9uZyBz
dGFydF9wZm4sDQo+ICAJdW5kb19pc29sYXRlX3BhZ2VfcmFuZ2Uoc3RhcnRfcGZuLCBlbmRfcGZu
LCBNSUdSQVRFX01PVkFCTEUpOw0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+IC0NCj4gLS8qIE11
c3QgYmUgcHJvdGVjdGVkIGJ5IG1lbV9ob3RwbHVnX2JlZ2luKCkgb3IgYSBkZXZpY2VfbG9jayAq
Lw0KPiAtaW50IG9mZmxpbmVfcGFnZXModW5zaWduZWQgbG9uZyBzdGFydF9wZm4sIHVuc2lnbmVk
IGxvbmcgbnJfcGFnZXMpDQo+IC17DQo+IC0JcmV0dXJuIF9fb2ZmbGluZV9wYWdlcyhzdGFydF9w
Zm4sIHN0YXJ0X3BmbiArIG5yX3BhZ2VzKTsNCj4gLX0NCj4gICNlbmRpZiAvKiBDT05GSUdfTUVN
T1JZX0hPVFJFTU9WRSAqLw0KPiAgDQo+ICAvKioNCj4g
