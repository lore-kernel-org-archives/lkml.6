Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA81CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE4920661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EDPmRCp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE4920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeH3Xlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:41:52 -0400
Received: from mail-eopbgr680115.outbound.protection.outlook.com ([40.107.68.115]:14000
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbeH3Xlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEc80Beg5oBLLEQws3nTM8CzP0euA1IlHsmY8oPfxTs=;
 b=EDPmRCp6+mzXzncwn/QZysfoqy5FlU7qU/ySiZqTDmmPHSGdSJ1puc0PQf2I7YPnTSLFxfGkHKw9wGV2g4Lbjdniy4/AYTAyB6WqOnVAsispFMQOxUYEtL0G/BUrCOruOm+bhAPAglEDPNABfg4ZVqsXX7N+zicNcXJGTCrEv5k=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0698.namprd21.prod.outlook.com (10.175.112.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Thu, 30 Aug 2018 19:38:04 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1122.009; Thu, 30 Aug 2018
 19:38:04 +0000
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
        Rashmica Gupta <rashmica.g@gmail.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH RFCv2 4/6] powerpc/powernv: hold device_hotplug_lock when
 calling device_online()
Thread-Topic: [PATCH RFCv2 4/6] powerpc/powernv: hold device_hotplug_lock when
 calling device_online()
Thread-Index: AQHUQJj4ApM7cZ/Ezk+Lz+y1i3C8wA==
Date:   Thu, 30 Aug 2018 19:38:04 +0000
Message-ID: <7e9d1b8f-1637-5f24-3f64-c6e9927f6909@microsoft.com>
References: <20180821104418.12710-1-david@redhat.com>
 <20180821104418.12710-5-david@redhat.com>
In-Reply-To: <20180821104418.12710-5-david@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0698;6:PzENUfmKfsvoIef6oMYKb1IxHtMyjjYubnuAGhJEu1yw8OEFm1cMbhBhlBr4gGsxpBhKzESuOEGbLqBup9vYxCwjFJJUNq6KMrxozT6XJuoHVu4sELVIlJ/hiUOfxz5pObkjlq1rmmRlGlWYX9+UQLeTxBUTBFjIUVqCqHhyo9LdhGxkanzdGu4W3lXDnes7bD15u6evvgykB0nshgPPHtEIbNAgQXXkb0cQ+6tbyNfuohKVDgKg4ltq/lAY4gPrXfoegoG/rID4U+ORZaAdx5aAaUGpz1/b5wLpd8aD/Qy9fOUvr0Jy/ItxM6reFWpAq4gc4XEQC/B8JIkIFuSeu3SbwvOvUYgAAUGvkxYlgNFRwNWADNGvqJ5WOxlDu2NB4nxqSVFzTV85Trfn/WKankq2jbSmrcinYQjUFj6ALhgLq/UMKtoINC5FSOYBI/wJlRATN+ho6Mcptdj9rhSY5g==;5:y9QdwTZn+A0qKMd41gFD04ov4Y0n0e+amXcrBzn598NR//d9LjX/A7kMENhjmF7dFg8EtE95aIwfJQYs64jE/mcDqXJdP+H02HMoU/d3ECmP/2dUD7QYiCQ+Y11Ysmlrup4dYcq/lSEpLFPUHMg4g8qvcNN911gUMOtAUGmyrQE=;7:1b/fPZwfQrDb13YiZhiVCwatBtWZsFZeLSLLonlCVKvOZ1C/pfTozjHJd9FO0WxL36h+yqooQSjRKiKqv8LbO3k3M4sXcjmJDCscf1rE8hENy4ldl0KRUSsCj5K5x2rSfiSdMBdH8cnVtWiz9VaijbGmMiPwX7R/2oFRctutoe9Q0uv68gcac0+eygiW770NrixawFjXg+8/aICuWI2oLvWc5hlIV+0CqzY7LGb8jQPydgo8KGWwRmWvh4d+3FN9
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fc4d59b5-c458-4d47-cc45-08d60eb01a96
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0698;
x-ms-traffictypediagnostic: DM5PR21MB0698:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB0698EB15676A958B1C5D115E9D080@DM5PR21MB0698.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0698;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0698;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(136003)(366004)(189003)(199004)(22452003)(110136005)(54906003)(7416002)(31686004)(6116002)(316002)(10090500001)(3846002)(6486002)(97736004)(36756003)(105586002)(229853002)(106356001)(68736007)(2906002)(66066001)(14454004)(8936002)(186003)(14444005)(11346002)(26005)(486006)(2616005)(256004)(5660300001)(476003)(10290500003)(102836004)(72206003)(53546011)(478600001)(6506007)(31696002)(7736002)(81166006)(446003)(81156014)(25786009)(76176011)(2900100001)(8676002)(86362001)(5250100002)(39060400002)(99286004)(305945005)(6512007)(53936002)(86612001)(6246003)(6436002)(4326008)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0698;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DR5FHgVs43/x/L0WJtOfICMgQV9DqT17kdST2jwBmYI7egZCbwb7i6P4vawa7lLCCNmO1JPVIvZd421JiSbMmzr2CF2nGjMKJaxDfUcGEhsW05R+NpdHaSwMK8YJOBt92+bOaA8RdJEZ2vyB8zeS8+S0kLNIA8U3t00C4hLb8fp/Sa7DGIwXoCtUJut4V9VZ1A5B8Lu5I7x+7b/KrTU+FI4SF7PdUE7pyh/H++dIh2KWz1ST6m2GU3+1NfrDkmVKY05QYbMuDmeZuk6TUWpeGQFQxwvrFG/Urkz3GXEzpVf8qXRoirb9AezgYxLcAjWI53+74nigipEaauflfUj4H+yrpvWG1icNfIxZ/j7gUN0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <04EA064F5EB9CF409A2AC76D0D341A0D@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4d59b5-c458-4d47-cc45-08d60eb01a96
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 19:38:04.1256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0698
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZWQtYnk6IFBhdmVsIFRhdGFzaGluIDxwYXZlbC50YXRhc2hpbkBtaWNyb3NvZnQuY29t
Pg0KDQpPbiA4LzIxLzE4IDY6NDQgQU0sIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOg0KPiBkZXZp
Y2Vfb25saW5lKCkgc2hvdWxkIGJlIGNhbGxlZCB3aXRoIGRldmljZV9ob3RwbHVnX2xvY2soKSBo
ZWxkLg0KPiANCj4gQ2M6IEJlbmphbWluIEhlcnJlbnNjaG1pZHQgPGJlbmhAa2VybmVsLmNyYXNo
aW5nLm9yZz4NCj4gQ2M6IFBhdWwgTWFja2VycmFzIDxwYXVsdXNAc2FtYmEub3JnPg0KPiBDYzog
TWljaGFlbCBFbGxlcm1hbiA8bXBlQGVsbGVybWFuLmlkLmF1Pg0KPiBDYzogUmFzaG1pY2EgR3Vw
dGEgPHJhc2htaWNhLmdAZ21haWwuY29tPg0KPiBDYzogQmFsYmlyIFNpbmdoIDxic2luZ2hhcm9y
YUBnbWFpbC5jb20+DQo+IENjOiBNaWNoYWVsIE5ldWxpbmcgPG1pa2V5QG5ldWxpbmcub3JnPg0K
PiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4g
LS0tDQo+ICBhcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bvd2VybnYvbWVtdHJhY2UuYyB8IDIgKysN
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9h
cmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bvd2VybnYvbWVtdHJhY2UuYyBiL2FyY2gvcG93ZXJwYy9w
bGF0Zm9ybXMvcG93ZXJudi9tZW10cmFjZS5jDQo+IGluZGV4IDhmMWNkNGYzYmZkNS4uZWY3MTgx
ZDRmZTY4IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bvd2VybnYvbWVt
dHJhY2UuYw0KPiArKysgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bvd2VybnYvbWVtdHJhY2Uu
Yw0KPiBAQCAtMjI5LDkgKzIyOSwxMSBAQCBzdGF0aWMgaW50IG1lbXRyYWNlX29ubGluZSh2b2lk
KQ0KPiAgCQkgKiB3ZSBuZWVkIHRvIG9ubGluZSB0aGUgbWVtb3J5IG91cnNlbHZlcy4NCj4gIAkJ
ICovDQo+ICAJCWlmICghbWVtaHBfYXV0b19vbmxpbmUpIHsNCj4gKwkJCWxvY2tfZGV2aWNlX2hv
dHBsdWcoKTsNCj4gIAkJCXdhbGtfbWVtb3J5X3JhbmdlKFBGTl9ET1dOKGVudC0+c3RhcnQpLA0K
PiAgCQkJCQkgIFBGTl9VUChlbnQtPnN0YXJ0ICsgZW50LT5zaXplIC0gMSksDQo+ICAJCQkJCSAg
TlVMTCwgb25saW5lX21lbV9ibG9jayk7DQo+ICsJCQl1bmxvY2tfZGV2aWNlX2hvdHBsdWcoKTsN
Cj4gIAkJfQ0KPiAgDQo+ICAJCS8qDQo+IA==
