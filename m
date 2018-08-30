Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6954FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1515820834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TFYh5Ima"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1515820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeHaCV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:21:59 -0400
Received: from mail-sn1nam01on0122.outbound.protection.outlook.com ([104.47.32.122]:10528
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726674AbeHaCV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3K5Y8crGWM8MuoEsHZt9bidYO7sUe0IR1FCVUJvozY=;
 b=TFYh5ImaufWhdQFVOfPqlX1pqALJRoeidpPavgsdYFjWo0TRSSE3ytYiOr5pXrhtj3nh8L34haa+EBxURHQM9l0N3OkaCJU1Eq6aYhbrcZAUedMaGo1b+2icJAHENOYc4GAVYJA0W9CsDSBsTiSOYtQrWumbUhSOZ9hGL3x37DY=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.1; Thu, 30 Aug 2018 22:17:36 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1122.009; Thu, 30 Aug 2018
 22:17:36 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@techadventures.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
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
Subject: Re: [PATCH v1 3/5] mm/memory_hotplug: check if sections are already
 online/offline
Thread-Topic: [PATCH v1 3/5] mm/memory_hotplug: check if sections are already
 online/offline
Thread-Index: AQHUQK9BwLb6Uhs5VkS37sPJPRy+cA==
Date:   Thu, 30 Aug 2018 22:17:35 +0000
Message-ID: <b294506a-9007-be11-f477-5b2a0011b2ba@microsoft.com>
References: <20180816100628.26428-1-david@redhat.com>
 <20180816100628.26428-4-david@redhat.com>
 <20180816104736.GA16861@techadventures.net>
 <62da84ee-090f-29e4-0a39-fcfd543ee81d@redhat.com>
In-Reply-To: <62da84ee-090f-29e4-0a39-fcfd543ee81d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0508;6:JV6pzLwBM0Nu/x3hiMftXASNeVA4cyEpvHWqYOmrS1TqTVpC0tVuMdVGz71Ahd3p5w4GNkp5mxx4zhyC4XVLpfotKHYZA38YRwKjLyBI5SFHt5ODekX94tVnSR1X/SJyo0bRainIdoiipgQObBW1jNt2ICdqh5LUynBAJ5rKWJ29rT3iQutTAyrKZGqXKAWqbRh3X3peLmdl71v/DC+lbzjHb4JhzcsnjJp9cE4USEn/lrpx4iC/5OU4tULqnblKtXa5+XhIptJgQ26F8OJ0gWw6Q9Uas9WxiXWBg2sSEi9cbMOjvglRY5xUNo2v10rP4tM4AajGK9x7dyBLs2Dq6GQk2qp9xtlWmoKUBhM+FPsMGz/9vrHTT0wD2cI+zVOt4b4NsV09YSsXpA/Z48ANiJlHIPljVHNCNRJEeLOPbTskgYWaoes2ew9AWDubXUrAoOOCLHVykv9f/y5LmINCKQ==;5:o5xxV0/g2RCiODk0tIfwzMhA6DCmT1te4+d3MU5TU18/I6yiv2WstV87mdTx+1GL0iBdR6VGVuOS99rUIgItIJjQyt/uV6oMm7/P4nwaB2Sb7e+xARMO2z3ENCGfbZsf5y2WtEGuzVnp5K8emjREuBy4fwXtFkfIiTRiRCKi/+I=;7:qozY69GNz0AE2kzMWgVr6PEsdG9qPq+oB9dWJi7E4/CodoiEE9NrSMwVxqPPdtO3zLzd69JokamIwlyLChWDCpdi2wi7ZrhpU1PtzYOpa74NlHQcFQukFPZYDhwbiw4Eg0Urebcs/Q401INxACSw/5VSmxGB08iqgYNwQslWuSV2kj8h5nKi4wqqF3tlkVVlyO6aVNHcrXpJhVdEyBQLvrIzKeHZRs4iLfiUGMpBbQ4mQktBJo0qHkiOP0XlEAJw
x-ms-office365-filtering-correlation-id: fec074d9-3b5c-46e8-6457-08d60ec663e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0508;
x-ms-traffictypediagnostic: DM5PR21MB0508:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB0508AE61E90D07E12856F6A29D080@DM5PR21MB0508.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0508;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0508;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(346002)(376002)(136003)(189003)(199004)(11346002)(486006)(2616005)(10090500001)(446003)(39060400002)(54906003)(110136005)(316002)(99286004)(6116002)(22452003)(53936002)(76176011)(256004)(3846002)(102836004)(26005)(186003)(7416002)(4326008)(476003)(5660300001)(53546011)(6506007)(6512007)(31696002)(68736007)(478600001)(25786009)(105586002)(6436002)(86362001)(5250100002)(93886005)(8676002)(86612001)(6486002)(2900100001)(10290500003)(97736004)(2906002)(8936002)(7736002)(31686004)(6246003)(14454004)(305945005)(229853002)(36756003)(66066001)(81166006)(81156014)(106356001)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0508;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yarCNj7ocGWZx3p52k1YtdHoe2R1v2NwrUoKJ+XwUVw257Ez5EwmrTfRupIuLv8TPysK1vBTsmI++sisCXSbzMfs+DCXY0e9O4HAsI79H+fOen1qiOrl/n9bQcdonACikRqRZ+5PjYHcflF/uDxknTeLzDXE6RII58PctqtB28skf7JHX6gDReynF1v73wXAjpS7XE2787hyp11WRPApJPRk1N6dkAtcsz0jWflP7jycPfS45KN7+EpX5Ud0nXwoFWjUldlgvQRDQKLBMfD5pmNgSihRGxhXc5fH3wh9Yu9LDVmpkQ80dPnGt5/P8QoXYn8/A99X064hrD+nNxTdLTrz32Y5Ac4T6jZ0QqvrrLw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1952BA0C898C7448A231EA724B9CAE68@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec074d9-3b5c-46e8-6457-08d60ec663e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 22:17:35.9561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0508
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8xNi8xOCA3OjAwIEFNLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToNCj4gT24gMTYuMDgu
MjAxOCAxMjo0NywgT3NjYXIgU2FsdmFkb3Igd3JvdGU6DQo+PiBPbiBUaHUsIEF1ZyAxNiwgMjAx
OCBhdCAxMjowNjoyNlBNICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToNCj4+DQo+Pj4g
Kw0KPj4+ICsvKiBjaGVjayBpZiBhbGwgbWVtIHNlY3Rpb25zIGFyZSBvZmZsaW5lICovDQo+Pj4g
K2Jvb2wgbWVtX3NlY3Rpb25zX29mZmxpbmUodW5zaWduZWQgbG9uZyBwZm4sIHVuc2lnbmVkIGxv
bmcgZW5kX3BmbikNCj4+PiArew0KPj4+ICsJZm9yICg7IHBmbiA8IGVuZF9wZm47IHBmbiArPSBQ
QUdFU19QRVJfU0VDVElPTikgew0KPj4+ICsJCXVuc2lnbmVkIGxvbmcgc2VjdGlvbl9uciA9IHBm
bl90b19zZWN0aW9uX25yKHBmbik7DQo+Pj4gKw0KPj4+ICsJCWlmIChXQVJOX09OKCF2YWxpZF9z
ZWN0aW9uX25yKHNlY3Rpb25fbnIpKSkNCj4+PiArCQkJY29udGludWU7DQo+Pj4gKwkJaWYgKG9u
bGluZV9zZWN0aW9uX25yKHNlY3Rpb25fbnIpKQ0KPj4+ICsJCQlyZXR1cm4gZmFsc2U7DQo+Pj4g
Kwl9DQo+Pj4gKwlyZXR1cm4gdHJ1ZTsNCj4+PiArfQ0KPj4NCj4+IEFGQUlDUyBwYWdlc19jb3Jy
ZWN0bHlfcHJvYmVkIHdpbGwgY2F0Y2ggdGhpcyBmaXJzdC4NCj4+IHBhZ2VzX2NvcnJlY3RseV9w
cm9iZWQgY2hlY2tzIGZvciB0aGUgc2VjdGlvbiB0byBiZToNCj4+DQo+PiAtIHByZXNlbnQNCj4+
IC0gdmFsaWQNCj4+IC0gIW9ubGluZQ0KPiANCj4gUmlnaHQsIEkgbWlzc2VkIHRoYXQgZnVuY3Rp
b24uDQo+IA0KPj4NCj4+IE1heWJlIGl0IG1ha2VzIHNlbnNlIHRvIHJlbmFtZSBpdCwgYW5kIHdy
aXRlIGFub3RoZXIgcGFnZXNfY29ycmVjdGx5X3Byb2JlZCByb3V0aW5lDQo+PiBmb3IgdGhlIG9m
ZmxpbmUgY2FzZS4NCj4+DQo+PiBTbyBhbGwgY2hlY2tzIHdvdWxkIHN0YXkgaW4gbWVtb3J5X2Js
b2NrX2FjdGlvbiBsZXZlbCwgYW5kIHdlIHdvdWxkIG5vdCBuZWVkDQo+PiB0aGUgbWVtX3NlY3Rp
b25zX29mZmxpbmUvb25saW5lIHN0dWZmLg0KDQpJIGFtIE9LIHdpdGggdGhhdCwgYnV0IHdpbGwg
d2FpdCBmb3IgYSBwYXRjaCB0byByZXZpZXcuDQoNClBhdmVs
