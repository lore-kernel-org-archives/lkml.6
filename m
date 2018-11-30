Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35C1C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD44020867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="d9Sb+60S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD44020867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbeLACYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:24:12 -0500
Received: from mail-eopbgr770088.outbound.protection.outlook.com ([40.107.77.88]:16640
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbeLACYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0ssXufnPjuVaVuqQL+I2817Lh1KJ54A2GOm4Bn1w8I=;
 b=d9Sb+60SRMzST/M5Y5GyWBw14BocH2WlVaMO87u8+m3+TteAt8hDJR7HCBb8yOBA8BhcUwwtKRs6jextXxSp865TpcNPPppZDjWmWvjgB2uac7eZV9kfaV8MGlBpsqQbmyTOGv3C3Y+uf3YH3YFy/tNcpQLLbk/mbV7LtC7chMk=
Received: from MWHPR1201MB0061.namprd12.prod.outlook.com (10.174.98.12) by
 MWHPR1201MB2556.namprd12.prod.outlook.com (10.172.97.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 15:14:30 +0000
Received: from MWHPR1201MB0061.namprd12.prod.outlook.com
 ([fe80::4481:91d7:9564:e869]) by MWHPR1201MB0061.namprd12.prod.outlook.com
 ([fe80::4481:91d7:9564:e869%9]) with mapi id 15.20.1361.019; Fri, 30 Nov 2018
 15:14:30 +0000
From:   "StDenis, Tom" <Tom.StDenis@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 0/4] x86/mm/cpa: Fix cpa-array TLB invalidation
Thread-Topic: [PATCH 0/4] x86/mm/cpa: Fix cpa-array TLB invalidation
Thread-Index: AQHUiLXipdRkoql6EkWifNhS5aJus6VoZy0AgAAE7ICAAAE+AA==
Date:   Fri, 30 Nov 2018 15:14:30 +0000
Message-ID: <9b172efa-0279-0a39-0b6b-7cf3492d326d@amd.com>
References: <20181130134455.490139778@infradead.org>
 <d1e4cb48-1952-fb61-bd2b-db9efe3b5f1a@amd.com>
 <20181130150959.GA11614@hirez.programming.kicks-ass.net>
In-Reply-To: <20181130150959.GA11614@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::36) To MWHPR1201MB0061.namprd12.prod.outlook.com
 (2603:10b6:301:54::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR1201MB2556;20:ORtRqNU7ev8b8I8w7ZEnM+A03qdQzvLps8jqgVLpvoMJfjg4zmSmzQM1Q8sJk574XTkGZb01ljL6JR5VQDAd14qGRl/w4LLMhamtEkyi26Ky0MWY4UzjkutgapuiNvOQ4UIoCnRjAJTm+RcPOfB+gIyGRIVS0JRasbYwVT6uvvvj0Pkv2HvldWAVez0m8DLD8+qPZI+5q+ZAsiNQW0J2ACkQ32S15Gjdoyngj8P/YkSrBo4jgVel9yvJE+fcNDVZ
x-ms-office365-filtering-correlation-id: 69fc4c9b-69bf-4e2a-b8fa-08d656d686a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR1201MB2556;
x-ms-traffictypediagnostic: MWHPR1201MB2556:
x-microsoft-antispam-prvs: <MWHPR1201MB25568084E82BE578D40A3282F7D30@MWHPR1201MB2556.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231453)(999002)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR1201MB2556;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB2556;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(39860400002)(136003)(189003)(199004)(11346002)(6506007)(386003)(316002)(97736004)(14454004)(25786009)(36756003)(68736007)(6436002)(81156014)(81166006)(4001150100001)(8676002)(186003)(6916009)(54906003)(6486002)(8936002)(229853002)(66066001)(105586002)(102836004)(106356001)(53546011)(71200400001)(71190400001)(2906002)(26005)(99286004)(31686004)(52116002)(72206003)(256004)(6116002)(3846002)(476003)(6246003)(486006)(446003)(4326008)(86362001)(31696002)(53936002)(2616005)(305945005)(76176011)(7736002)(6512007)(478600001)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB2556;H:MWHPR1201MB0061.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: F8UEnsNgh4xLsVsBbmLwszk/SLZNr/ORT8rbJcHKdb2EsSqhRv6wKX/V6wo3VxAxCm8Fzw+Jg7nKiZ0FJsS/tcxeIyC+fekb2HSS9W/cQ7cFbl76IxIVZXAPyW1QIpQBsOiYSSswwFojyh7Ec9fGzxPydeFmwUxTukK7vnPYkMB+f/LsFP7hnoBpzMA10aGGeun6+7K9PMhQwCiYFYJrhy0tL7afiLrY/dr5QDmA1uSXYlynXryfHf7lCLW2O8piHsz3ckVebLQ/wglxGW0YVtDAa0cmOmwWP8QZ7vfxq+NZV2mAqjynhjhaqr5qIOWEeg15+v0ZNsPQkx955Sev62TEmj8c9yJZmtTraKqzUvY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0496EC3EEBB7AA40816AB8F8FA56EE26@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fc4c9b-69bf-4e2a-b8fa-08d656d686a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 15:14:30.6412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2556
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMS0zMCAxMDowOSBhLm0uLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gT24gRnJp
LCBOb3YgMzAsIDIwMTggYXQgMDI6NTI6MjZQTSArMDAwMCwgU3REZW5pcywgVG9tIHdyb3RlOg0K
Pj4gSGkgUGV0ZXIsDQo+Pg0KPj4gVW5mb3J0dW5hdGVseSBJIGNhbid0IGFwcGx5IHRoaXMgb24g
dG9wIG9mIG91ciBkcm0tbmV4dCB0aGUgZmlyc3QgcGF0Y2gNCj4+IGZhaWxzLg0KPiANCj4gQWdh
aW5zdCB3aGF0IHRyZWUgd291bGQgeW91IGxpa2UgdGhlIHBhdGNoZXM/IHJlYmFzaW5nIHNob3Vs
ZCBub3QgYmUNCj4gaGFyZCBJIHRoaW5rLg0KPiANCg0KQWN0dWFsbHkgSSBqdXN0IHRyaWVkIGFw
cGx5aW5nIGFnYWluc3QgdGhlIHRpcCBvZiBtYXN0ZXIgYW5kIGdvdCB0aGUgDQpzYW1lIGVycm9y
cy4uLg0KDQpbcm9vdEBjYXJyaXpvIGxpbnV4XSMgZ2l0IGFwcGx5IFxbUEFUQ0hcIDFfNFxdXCB4
ODZfbW1fY3BhXDpcIEFkZFwgDQpfX2NwYV9hZGRyXChcKVwgaGVscGVyXCAtXCBQZXRlclwgWmlq
bHN0cmFcIFw8cGV0ZXJ6QGluZnJhZGVhZC5vcmdcPlwgLVwgDQoyMDE4LTExLTMwXCAwODQ0LmVt
bA0KZXJyb3I6IHBhdGNoIGZhaWxlZDogYXJjaC94ODYvbW0vcGFnZWF0dHIuYzoyMjgNCmVycm9y
OiBhcmNoL3g4Ni9tbS9wYWdlYXR0ci5jOiBwYXRjaCBkb2VzIG5vdCBhcHBseQ0KDQoNCkFueSBp
ZGVhcz8NCg0KVG9tDQo=
