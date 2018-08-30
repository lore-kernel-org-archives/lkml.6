Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D4BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A1120835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IyUrqvgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A1120835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeHaCfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:35:15 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:10107
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726690AbeHaCfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzQTx6WmY8Z3Rp7ggOJx8KBaM5vMfGAeTJbEjeSpt7g=;
 b=IyUrqvgPtN9bQ3V4BQklXT+Uw8RxiCRxVOjfNTf6IufhCzRHxwQvfNiTmaLIl0d0BYiGbczBRpTP+cvyy03sJbmYDRqTUS2UUjq0NNFoq8+xxNtqAnuO4juchzPcY1oIAcwgTpDQ0ajPXSybpQKEsGVOT2HZ0vIVwI/iG2wK+b0=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0633.namprd21.prod.outlook.com (10.175.111.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.1; Thu, 30 Aug 2018 22:30:49 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1122.009; Thu, 30 Aug 2018
 22:30:49 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
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
Subject: Re: [PATCH v1 4/5] mm/memory_hotplug: onlining pages can only fail
 due to notifiers
Thread-Topic: [PATCH v1 4/5] mm/memory_hotplug: onlining pages can only fail
 due to notifiers
Thread-Index: AQHUQLEZvsXwGFbgcUSovizx6nBmRQ==
Date:   Thu, 30 Aug 2018 22:30:49 +0000
Message-ID: <b558718f-d950-0890-a228-a8494c117f5f@microsoft.com>
References: <20180816100628.26428-1-david@redhat.com>
 <20180816100628.26428-5-david@redhat.com>
In-Reply-To: <20180816100628.26428-5-david@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0633;6:Z2W0v4tBvgQELtCmoagbwiThsymrA/sU6fWzZgulZ90VMa3dMVU1efQDHzNUSwzPQo5LR0bqDioWm8E80dAO35nQJI3xUnXCEF2zvMrX/WhqZstU29f/FWUZDPODHvQV1N43s3MpoDyw137ycqDJJSw+Yvyi7wx64Xx+DK3FYXpIqoF2+/1ny6aPHDenp9n54sYqVfjrhRtFo+ZWBz30xGrZaXItgk++3MHCdcvR1+sTHdHIcKhDhkPyW9A4MzIi7iDXMJWx7vhCRc+dmcLMHIXR6fXmrlQzwJjZLkk3DVkgXDvfyEfdWZfUojLLaDQPMQektEUvt8mQjVCFL/AOo1w/pfQbD6PfdR7/f7t2wc0k2WdMu0mF4v9He6o3jqCIQKcR8jOGBvKQYch6Pzck9mhvH95KYPBbSCJ3whoBWL8W+pw4UzjdX0tNX6SwOqbvr9epbQ+UefcutwSBGScjdA==;5:WF4hLMNDuVZNFZ5tBexHozE0/1k6VJ3wbJXTPiAgeJ32l/zLmj7M4c8ykCE7rvgmiSaYMwNRrtEqhSP1Mn8+32APFf9tYvBGZn83kCaD+1M6jAb2NmI42EVQN1gTWZ0BjpvQ3URTZ3meeiocuvzd0Uui17hx2BunNxE6QXDJDWY=;7:KOWJ5d+CCiYvFxjVTs5XYRhb5h7RNm0Yay6FoS8iD0CZRa567hkRkXD5tx60CY6ozKyOb45kqXNmC1I8fUOtc9iSczPajmhWd37Oz2yiSh9hFN6v9oSNDXtXvTpcqQUp+0nMRinxkjPtBTE3P7QKfV2VNs4latG/ug/lZil3MAh2l6Y2Iauc7U8XtNezFy06f07+j+sAa9hPkpeBRsdO60e3SwaRwxXpn2EVlCpGUQiSA0lxIp1DaisZPnlfPsdc
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1ae49d4d-f03b-4c64-f004-08d60ec83c98
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0633;
x-ms-traffictypediagnostic: DM5PR21MB0633:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB0633632D25DCBFBF3F100F8D9D080@DM5PR21MB0633.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231340)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0633;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0633;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(366004)(396003)(39860400002)(199004)(189003)(25786009)(68736007)(229853002)(8936002)(6246003)(54906003)(39060400002)(478600001)(14454004)(97736004)(99286004)(72206003)(110136005)(36756003)(7736002)(305945005)(6116002)(8676002)(3846002)(7416002)(5660300001)(86362001)(86612001)(22452003)(31696002)(256004)(2900100001)(76176011)(2906002)(31686004)(10090500001)(186003)(106356001)(316002)(81156014)(486006)(81166006)(105586002)(2616005)(2501003)(53546011)(476003)(102836004)(26005)(6506007)(4326008)(6436002)(66066001)(11346002)(6486002)(53936002)(446003)(6512007)(10290500003)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0633;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QZBCqghgu+mWYkA/TCNqUtOBbdPAniR+n+yBRK+9wwXnVe1KO0eIQ11tjoLKcSJ8dOFVqWoivPHJzjWHiqQCqDS3hwM3OB5hdpMo+y1cYnpI4iyQCaDJh7bpjMj+gdCiQuRllG7h3hMbkbZT5Xd6BOTHgKbCelrvJvgcFR3bG37Tn1pggJKkBtvB87/fPtwqCuQzabdeSOWy5PRYEnYNK+DVBNoSEvh/DScm21Bi1TyKOPkOsZzODonNUjIUAVG4SLaq3/6XxL0RzoZrVaDuNgW12E/GsssbOUw4XTauRGoQIhpM+NX96t/TptSlvVoX9a0FojaReU3/Ms975NX0ms5OqRZSoL0oYhOHWdqHJH8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <747BDC40E882F247AD0506982A099E18@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae49d4d-f03b-4c64-f004-08d60ec83c98
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 22:30:49.0496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0633
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TEdUTQ0KDQpSZXZpZXdlZC1ieTogUGF2ZWwgVGF0YXNoaW4gPHBhdmVsLnRhdGFzaGluQG1pY3Jv
c29mdC5jb20+DQoNCk9uIDgvMTYvMTggNjowNiBBTSwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6
DQo+IE9ubGluaW5nIHBhZ2VzIGNhbiBvbmx5IGZhaWwgaWYgYSBub3RpZmllciByZXBvcnRlZCBh
IHByb2JsZW0gKGUuZy4gLUVOT01FTSkuDQo+IG9ubGluZV9wYWdlc19yYW5nZSgpIGNhbiBuZXZl
ciBmYWlsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJl
ZGhhdC5jb20+DQo+IC0tLQ0KPiAgbW0vbWVtb3J5X2hvdHBsdWcuYyB8IDkgKystLS0tLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL21tL21lbW9yeV9ob3RwbHVnLmMgYi9tbS9tZW1vcnlfaG90cGx1Zy5jDQo+
IGluZGV4IDNkYzZkMmEzMDljMi4uYmJiZDE2ZjlkODc3IDEwMDY0NA0KPiAtLS0gYS9tbS9tZW1v
cnlfaG90cGx1Zy5jDQo+ICsrKyBiL21tL21lbW9yeV9ob3RwbHVnLmMNCj4gQEAgLTkzMywxMyAr
OTMzLDggQEAgaW50IF9fcmVmIG9ubGluZV9wYWdlcyh1bnNpZ25lZCBsb25nIHBmbiwgdW5zaWdu
ZWQgbG9uZyBucl9wYWdlcywgaW50IG9ubGluZV90eXANCj4gIAkJc2V0dXBfem9uZV9wYWdlc2V0
KHpvbmUpOw0KPiAgCX0NCj4gIA0KPiAtCXJldCA9IHdhbGtfc3lzdGVtX3JhbV9yYW5nZShwZm4s
IG5yX3BhZ2VzLCAmb25saW5lZF9wYWdlcywNCj4gLQkJb25saW5lX3BhZ2VzX3JhbmdlKTsNCj4g
LQlpZiAocmV0KSB7DQo+IC0JCWlmIChuZWVkX3pvbmVsaXN0c19yZWJ1aWxkKQ0KPiAtCQkJem9u
ZV9wY3BfcmVzZXQoem9uZSk7DQo+IC0JCWdvdG8gZmFpbGVkX2FkZGl0aW9uOw0KPiAtCX0NCj4g
Kwl3YWxrX3N5c3RlbV9yYW1fcmFuZ2UocGZuLCBucl9wYWdlcywgJm9ubGluZWRfcGFnZXMsDQo+
ICsJCQkgICAgICBvbmxpbmVfcGFnZXNfcmFuZ2UpOw0KPiAgDQo+ICAJem9uZS0+cHJlc2VudF9w
YWdlcyArPSBvbmxpbmVkX3BhZ2VzOw0KPiAgDQo+IA==
