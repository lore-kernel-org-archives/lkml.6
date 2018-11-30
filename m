Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1DCC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB59F2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xxlxBeCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB59F2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbeLACUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:20:32 -0500
Received: from mail-eopbgr680074.outbound.protection.outlook.com ([40.107.68.74]:29079
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726127AbeLACUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLs3LGLE19POC371WxcKbqitt3Aex4m8AWHlBQYPBy4=;
 b=xxlxBeCeO6V6x3T18ozLW/Nu+rWjBrXDQ6QcDBUiTXcXwBO4yz1ksrfBTbPYOs7AX8XGMZtJCXMOF10HLmurYjuZCRvBfnzCTk4SSGV28D3SLoRcTsp7lpDtATsvijr11GSOIxg/uQn6DSIEkGVecSRg2P+YluG1Bp1JR5HRkQE=
Received: from MWHPR1201MB0061.namprd12.prod.outlook.com (10.174.98.12) by
 MWHPR1201MB0173.namprd12.prod.outlook.com (10.174.99.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.21; Fri, 30 Nov 2018 15:10:50 +0000
Received: from MWHPR1201MB0061.namprd12.prod.outlook.com
 ([fe80::4481:91d7:9564:e869]) by MWHPR1201MB0061.namprd12.prod.outlook.com
 ([fe80::4481:91d7:9564:e869%9]) with mapi id 15.20.1361.019; Fri, 30 Nov 2018
 15:10:50 +0000
From:   "StDenis, Tom" <Tom.StDenis@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 0/4] x86/mm/cpa: Fix cpa-array TLB invalidation
Thread-Topic: [PATCH 0/4] x86/mm/cpa: Fix cpa-array TLB invalidation
Thread-Index: AQHUiLXipdRkoql6EkWifNhS5aJus6VoZy0AgAAE7ICAAAA5gA==
Date:   Fri, 30 Nov 2018 15:10:50 +0000
Message-ID: <bd9d71c8-c4ab-577b-3d31-96d93339cc73@amd.com>
References: <20181130134455.490139778@infradead.org>
 <d1e4cb48-1952-fb61-bd2b-db9efe3b5f1a@amd.com>
 <20181130150959.GA11614@hirez.programming.kicks-ass.net>
In-Reply-To: <20181130150959.GA11614@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0024.prod.exchangelabs.com
 (2603:10b6:207:18::37) To MWHPR1201MB0061.namprd12.prod.outlook.com
 (2603:10b6:301:54::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR1201MB0173;20:P9XhG7BWEnzAzW3F/vhV+V290jTrdQsbeFr9s7ygSShHMGIwMw6ikv94HIR9xtgYLoOTTPcE31eW7/9eOf23HKztap/To+bSrQzcRiZFehsPOW/TQlPf/cKw7VUjtdrM1wsjV/wq4fgtjQNGUpSDsz4DFu+iKhcd0Iogi8xqLFvcYTtkkIoLAyJcqwgfkRqKjNjD53g02rKlAAlEgmdzXUNyx9F5FbrZc/iAoTBmYqUIP1RAy/yTbpSHyuLCucnB
x-ms-office365-filtering-correlation-id: 374021dc-5675-4665-389b-08d656d60397
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR1201MB0173;
x-ms-traffictypediagnostic: MWHPR1201MB0173:
x-microsoft-antispam-prvs: <MWHPR1201MB017354075792309DA69A7637F7D30@MWHPR1201MB0173.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231453)(999002)(944501466)(52105112)(10201501046)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR1201MB0173;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB0173;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(396003)(136003)(39860400002)(189003)(199004)(68736007)(229853002)(316002)(31686004)(102836004)(53546011)(6506007)(386003)(66066001)(4326008)(486006)(11346002)(478600001)(14454004)(25786009)(4001150100001)(256004)(72206003)(476003)(54906003)(6486002)(446003)(6246003)(6916009)(71200400001)(7736002)(305945005)(3846002)(2616005)(97736004)(6116002)(106356001)(6512007)(71190400001)(105586002)(99286004)(31696002)(52116002)(36756003)(6436002)(76176011)(26005)(186003)(8676002)(5660300001)(8936002)(81166006)(81156014)(2906002)(86362001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0173;H:MWHPR1201MB0061.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PJdZhHLO0/BHOdwCbSsJbwv6WI9Ao40lq0VfDSmgsHqOWIqQCW2Ksd8tZguVSWeSJteuiq+4yl4tiZXH1Z0FWml0s8rsyBcTn9AWZdxnsNxqoGgHozhTC6mGqwDZWC2JH2wwKL2TPdaBpyvCu90x0W2/kqalXyaHTa5MSscKxr/X1VCH+C98VNPQE+bmeaDkPFhPdMgrOb7IEafGkCQUBplk0LihJRzkEc22V3QVqEtDgx4IG7wyrZ+H3b3LzMOLacsndXdx3ysgHJe2AVNP0TwtTLs5yTFS44+Z2ubdxZYD2ngVfcAasVhID05GHZj6aM7bGaPSaL4TamNXl76nGaGaj+Uj7RFquSXzSfnWzqg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB3DE040CA268647BBED57087400ED8F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 374021dc-5675-4665-389b-08d656d60397
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 15:10:50.6078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMS0zMCAxMDowOSBhLm0uLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gT24gRnJp
LCBOb3YgMzAsIDIwMTggYXQgMDI6NTI6MjZQTSArMDAwMCwgU3REZW5pcywgVG9tIHdyb3RlOg0K
Pj4gSGkgUGV0ZXIsDQo+Pg0KPj4gVW5mb3J0dW5hdGVseSBJIGNhbid0IGFwcGx5IHRoaXMgb24g
dG9wIG9mIG91ciBkcm0tbmV4dCB0aGUgZmlyc3QgcGF0Y2gNCj4+IGZhaWxzLg0KPiANCj4gQWdh
aW5zdCB3aGF0IHRyZWUgd291bGQgeW91IGxpa2UgdGhlIHBhdGNoZXM/IHJlYmFzaW5nIHNob3Vs
ZCBub3QgYmUNCj4gaGFyZCBJIHRoaW5rLg0KPiANCg0KQWN0dWFsbHkgbmV2ZXIgbWluZCB0aGUg
QU1ER1BVIHBhdGNoZXMgSSBuZWVkIGFyZSBhY3R1YWxseSB1cHN0cmVhbSBJIA0Kd2FzIG1pc3Rh
a2VuIDotKQ0KDQpJJ2xsIHRyeSBpdCBvdXQgc2hvcnRseS4NCg0KVG9tDQo=
