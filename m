Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BCCC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DDE2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hZO0NhZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DDE2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbeHaSMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:12:41 -0400
Received: from mail-bn3nam01on0128.outbound.protection.outlook.com ([104.47.33.128]:2443
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727404AbeHaSMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5091Qxj0lJkvlNfYqZr6i6V62xg6MO0KmBbcLu8njzU=;
 b=hZO0NhZoIsUuiNQMzIUEuNCGJtwcsnE1M5lb7Lu/rDvM4zZ3dM7C05n6vNq3mEWNz/jTj5/o0RbwSgvap7PK24JHsL0lai9HqnRADmxDwSiFlqRsn6bidFN8JZduTDPNaXAuFoaZit0TqnjM0sBmBQnkpBLbiUXGATC+Vy/OYaw=
Received: from MWHPR21MB0510.namprd21.prod.outlook.com (10.172.95.140) by
 MWHPR21MB0832.namprd21.prod.outlook.com (10.173.51.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.1; Fri, 31 Aug 2018 14:04:59 +0000
Received: from MWHPR21MB0510.namprd21.prod.outlook.com
 ([fe80::a9a4:7c1a:2713:ad83]) by MWHPR21MB0510.namprd21.prod.outlook.com
 ([fe80::a9a4:7c1a:2713:ad83%7]) with mapi id 15.20.1122.009; Fri, 31 Aug 2018
 14:04:59 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Oscar Salvador <osalvador@techadventures.net>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm/page_alloc: Clean up check_for_memory
Thread-Topic: [PATCH] mm/page_alloc: Clean up check_for_memory
Thread-Index: AQHUPxJkr6MHAJjlhEm5lgIiZ1w8R6TXiugAgAJB8oCAABwzgA==
Date:   Fri, 31 Aug 2018 14:04:59 +0000
Message-ID: <b2fea9ef-84e9-84dc-c847-5b944a8d832f@microsoft.com>
References: <20180828210158.4617-1-osalvador@techadventures.net>
 <332d9ea1-cdd0-6bb6-8e83-28af25096637@microsoft.com>
 <20180831122401.GA2123@techadventures.net>
In-Reply-To: <20180831122401.GA2123@techadventures.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0832;6:6tQTDSQtH3aoY5R8QJjvcM7McoQq9hFuELLZmp0XA/4lWtjQUnISJHVtC45zc9F+DQR2k/WV3jwM6SrddQxH1TnlrDVbz3dZ9SDOekdotOz1wLVE5szSjm84IeHSeK1Vxw8j04MzjwdaquccDXQlFNWJfAMXG0RRrpMEPKvEbRQeTHcJ/J6kOPpfFtXKMuMwX1zk3C4009yDboQoAYDJU+3lndBhFOxArZLE9OuYlIHYhrxN/5XMnYyyewz/YIOvUgMtrRwIRE5g6ga/9HC8kTpisWU78k2PtHvhBvGZWKCcXP6w/2AVZwWcv19zUCxQHKN/haFNwgmZTVy/X1JYSOoMZEi7f533tZfR8l9dh3fploXzqQn/vV8mQwzzYPE8agiP6L4RVymw7QROVL51TtXw2OAowtvSAfok9HAIrFox7ugigAZ16Yoqh5c6WHSJoiKcCA4JrRWdZf+2ZTISWg==;5:+msgBjAWtTcwrtjH2Cg4kmj2XDET63Ww1+J4kqfbIbzDGbOnPVArMK/VZaAoc6sg5R5S9CUEj/e6Yv7zlulbxhTIOcwd14fLnsnIeZUUQj6JLISqnUM+1mKLMEIwzX5cpt1VcQA4QuxS2fLgDrGwXViKIDF5lkQyVpaCJ3hvuFU=;7:vUzbY4VtnM8g35zFNl7JfxRP3NVoKkLZZV3mfDf3J4L72xRLdPKuoiqb0zEzRiTHVRdR0wDDrRZOxb1GA/ErYiu30ktoYLZHllxK60ZfCnUqv+hxKcT8gKK6ZMbVQT2E3L4fxC/j6uhK9jypKfplZFb0NFAlAaqOFrbcbjwo9xXmU37eJt0wWD4nbVMQVXZM0mVTZ5Q0QndK26MFrTbyGZYPQenkeIfyFaOah6KGMkeHJL7mTsqmElYuSBj06ZnQ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f7ac53ad-50e9-4c07-f6f6-08d60f4abd11
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MWHPR21MB0832;
x-ms-traffictypediagnostic: MWHPR21MB0832:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-prvs: <MWHPR21MB0832CEC1D17CAB9355A46A9C9D0F0@MWHPR21MB0832.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:MWHPR21MB0832;BCL:0;PCL:0;RULEID:;SRVR:MWHPR21MB0832;
x-forefront-prvs: 07817FCC2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(366004)(346002)(39860400002)(199004)(189003)(2616005)(5250100002)(11346002)(54906003)(8936002)(476003)(446003)(10090500001)(305945005)(7736002)(22452003)(53546011)(6506007)(6916009)(6436002)(8676002)(68736007)(486006)(316002)(102836004)(10290500003)(99286004)(186003)(72206003)(478600001)(25786009)(2906002)(53936002)(86362001)(106356001)(26005)(81166006)(81156014)(6486002)(5660300001)(4326008)(86612001)(97736004)(2900100001)(36756003)(31686004)(256004)(6246003)(66066001)(3846002)(6116002)(105586002)(31696002)(229853002)(76176011)(6512007)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0832;H:MWHPR21MB0510.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: //DiwVwhulM/spRbTU44IdJDXRJCkiVqXfYUZr5tuVjiZOlJC5fQcFXcIoF6ToAawAeU3lxRWaBIRvs5DsPdxKU6u+3ZhG4cRSB/5QwMlj5qu2cQOekUhxIFb0chVUAk8lqcncKGVgGabiypU39mjgn/7JUHGNwm7IeD1tFE1lxpBpK6KzD3asnHdCqPMpFW/2Fx5hoX7qMOUIYcX02W75AAmvf8e7dUjhMKuMfV3dQQCHWlXkFC1cCuSBE/QdNMMKZ94w0ZEyTwPkd/H4tF20MS2RoU724XpW4s5jM6lHK5PI8DZ3HO3Rmzd7o1gtVE6j/P8Ce4cXJ/6XCmV6M0EK3o9Cj1Tkv6rIOH/iYOZ98=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <18361ACBE0182B419F357C275908FB63@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ac53ad-50e9-4c07-f6f6-08d60f4abd11
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2018 14:04:59.2477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0832
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDgvMzEvMTggODoyNCBBTSwgT3NjYXIgU2FsdmFkb3Igd3JvdGU6DQo+IE9uIFRodSwg
QXVnIDMwLCAyMDE4IGF0IDAxOjU1OjI5QU0gKzAwMDAsIFBhc2hhIFRhdGFzaGluIHdyb3RlOg0K
Pj4gSSB3b3VsZCByZS13cml0ZSB0aGUgYWJvdmUgZnVuY3Rpb24gbGlrZSB0aGlzOg0KPj4gc3Rh
dGljIHZvaWQgY2hlY2tfZm9yX21lbW9yeShwZ19kYXRhX3QgKnBnZGF0LCBpbnQgbmlkKQ0KPj4g
ew0KPj4gICAgICAgICBlbnVtIHpvbmVfdHlwZSB6b25lX3R5cGU7DQo+Pg0KPj4gICAgICAgICBm
b3IgKHpvbmVfdHlwZSA9IDA7IHpvbmVfdHlwZSA8IFpPTkVfTU9WQUJMRTsgem9uZV90eXBlKysp
IHsNCj4+ICAgICAgICAgICAgICAgICBpZiAocG9wdWxhdGVkX3pvbmUoJnBnZGF0LT5ub2RlX3pv
bmVzW3pvbmVfdHlwZV0pKSB7IA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgbm9kZV9zZXRf
c3RhdGUobmlkLCB6b25lX3R5cGUgPD0gWk9ORV9OT1JNQUwgPw0KPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgTl9OT1JNQUxfTUVNT1JZOiBOX0hJR0hfTUVNT1JZKTsN
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPj4gICAgICAgICAgICAgICAgIH0N
Cj4+ICAgICAgICAgfQ0KPj4gfQ0KPiANCj4gSGkgUGF2ZWwsDQo+IA0KPiB0aGUgYWJvdmUgd291
bGQgbm90IHdvcmsgZmluZS4NCj4gWW91IHNldCBlaXRoZXIgTl9OT1JNQUxfTUVNT1JZIG9yIE5f
SElHSF9NRU1PUlksIGJ1dCBhIG5vZGUgY2FuIGhhdmUgYm90aA0KPiB0eXBlcyBvZiBtZW1vcnkg
YXQgdGhlIHNhbWUgdGltZSAob24gQ09ORklHX0hJR0hNRU0gc3lzdGVtcykuDQo+IA0KPiBOX0hJ
R0hfTUVNT1JZIHN0YW5kcyBmb3IgcmVndWxhciBvciBoaWdoIG1lbW9yeQ0KPiB3aGlsZSBOX05P
Uk1BTF9NRU1PUlkgc3RhbmRzIG9ubHkgZm9yIHJlZ3VsYXIgbWVtb3J5LA0KPiB0aGF0IGlzIHdo
eSB3ZSBzZXQgaXQgb25seSBpbiBjYXNlIHRoZSB6b25lIGlzIDw9IFpPTkVfTk9STUFMLg0KDQpI
aSBPc2NhciwNCg0KQXJlIHlvdSBzYXlpbmcgdGhlIGNvZGUgdGhhdCBpcyBpbiBtYWlubGluZSBp
cyBicm9rZW4/IEJlY2F1c2Ugd2Ugc2V0DQpub2RlX3NldF9zdGF0ZShuaWQsIE5fTk9STUFMX01F
TU9SWSk7IGV2ZW4gb24gbm9kZSB3aXRoIE5fSElHSF9NRU1PUlk6DQoNCjY4MjYJCQlpZiAoTl9O
T1JNQUxfTUVNT1JZICE9IE5fSElHSF9NRU1PUlkgJiYNCjY4MjcJCQkgICAgem9uZV90eXBlIDw9
IFpPTkVfTk9STUFMKQ0KNjgyOAkJCQlub2RlX3NldF9zdGF0ZShuaWQsIE5fTk9STUFMX01FTU9S
WSk7DQoNClRoYW5rIHlvdSwNClBhdmVs
