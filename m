Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41438C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131AD20867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131AD20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeLAE7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:59:40 -0500
Received: from mail-eopbgr780078.outbound.protection.outlook.com ([40.107.78.78]:39376
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726709AbeLAE7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 23:59:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzijCJ07/zue/DuVLhBKyZOBVKeSwTGzUNwinp0peEM=;
 b=BFTXIBmCUFuai7hSppVoPI3wdat0HLe09jXR99JwrTZkP3CC8mtReGKEiH5jwmjZLnFmIZ65RchtG19An0o084oTA/MiCqb+3gwZ142aOylQJUa3qI4DNMTqw6cJtXibrx9aU1Yxn9Wz2MZS8BYHEtpwYlSIzNRfKfotSd8ll0A=
Received: from MWHPR1201MB0061.namprd12.prod.outlook.com (10.174.98.12) by
 MWHPR1201MB2527.namprd12.prod.outlook.com (10.172.96.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 17:49:35 +0000
Received: from MWHPR1201MB0061.namprd12.prod.outlook.com
 ([fe80::4481:91d7:9564:e869]) by MWHPR1201MB0061.namprd12.prod.outlook.com
 ([fe80::4481:91d7:9564:e869%9]) with mapi id 15.20.1361.019; Fri, 30 Nov 2018
 17:49:35 +0000
From:   "StDenis, Tom" <Tom.StDenis@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 0/4] x86/mm/cpa: Fix cpa-array TLB invalidation
Thread-Topic: [PATCH 0/4] x86/mm/cpa: Fix cpa-array TLB invalidation
Thread-Index: AQHUiLXipdRkoql6EkWifNhS5aJus6VoZy0AgAAE7ICAAAE+AIAAAp2AgAACJQCAAA16AIAAGLEAgAAAZgA=
Date:   Fri, 30 Nov 2018 17:49:34 +0000
Message-ID: <5c79d914-96d3-1dcc-0a61-7f8f4db4fd06@amd.com>
References: <20181130134455.490139778@infradead.org>
 <d1e4cb48-1952-fb61-bd2b-db9efe3b5f1a@amd.com>
 <20181130150959.GA11614@hirez.programming.kicks-ass.net>
 <9b172efa-0279-0a39-0b6b-7cf3492d326d@amd.com>
 <20181130152347.GB11614@hirez.programming.kicks-ass.net>
 <20181130153128.GB11650@hirez.programming.kicks-ass.net>
 <8ee4e546-4680-e463-23ac-64489a60b946@amd.com>
 <20181130174804.GA11573@hirez.programming.kicks-ass.net>
In-Reply-To: <20181130174804.GA11573@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::38) To MWHPR1201MB0061.namprd12.prod.outlook.com
 (2603:10b6:301:54::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [69.159.71.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR1201MB2527;20:713eIAwDqgc0bbiyzF+9np4+BfXf7Lvprq2fVyw7mlXdsYY8M0jzWM/8dVaSM0d259AAg27nEJ7y1h4eLNCpE8aZfbAXdeAoTBV6T/P39NyAHlJGEw/xLzygj2nwaZO0ugFswET4v/+iKvtH87q8LSzRXASP7p2P8iLBr3e7VZejB2ZhPi0vIxUpD2m85B9VIvQi1Fd9xg6x3MlqcXhTUaJiJRf5y2vPJfSjxbtnlNjAwlPYeZFRBpmjV7ca/jlS
x-ms-office365-filtering-correlation-id: 4c7163ed-86a3-4aff-141f-08d656ec3082
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR1201MB2527;
x-ms-traffictypediagnostic: MWHPR1201MB2527:
x-microsoft-antispam-prvs: <MWHPR1201MB2527D3DCE7746C932DDC0A94F7D30@MWHPR1201MB2527.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231453)(999002)(944501410)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR1201MB2527;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB2527;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(366004)(189003)(199004)(386003)(6506007)(53546011)(52116002)(6512007)(106356001)(53936002)(4326008)(3846002)(6116002)(11346002)(446003)(316002)(6246003)(6436002)(76176011)(54906003)(186003)(229853002)(105586002)(305945005)(26005)(7736002)(99286004)(2906002)(5660300001)(6486002)(8676002)(81156014)(81166006)(66066001)(6916009)(102836004)(31686004)(36756003)(8936002)(71190400001)(31696002)(14454004)(4001150100001)(71200400001)(86362001)(25786009)(486006)(478600001)(97736004)(72206003)(14444005)(5024004)(256004)(93886005)(68736007)(476003)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB2527;H:MWHPR1201MB0061.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: A24V+Eq3yJ1MxHOP/hRKrLmzU8Zlp71stT3H9AbL6qy+rVw2hd6Mv2NSdRdptlalSPK/iTgaloDpGE6oMuw9Xu200PEM1G1mmSOyJLLydjWZxLbOGjhZ1dFuzg9xbSN+1QpXwnLQbUqFsvuTckRqL8s/8CHsZ7AltKbEO7ckYPXF3/HWnvJxSRmDMbVGPExk3nVSfgwznsWeMJ1p667InZ6QkNr5c/B8HzXjEoWTN1UMtfUJjG5H5Qh5SQgRqBSkf8zVHnJCZNbB0sRR1uWddw5LyOSGEy4BteTb3l7OFh59KEV3VsrdnvsJwKKfbg/VLYlgPZblOI8CfiLm1NkrdpJjVDBgzv7HjxnwrQj003I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1178829F65158249835D465A96CCBDA4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7163ed-86a3-4aff-141f-08d656ec3082
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 17:49:34.9508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2527
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMS0zMCAxMjo0OCBwLm0uLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gT24gRnJp
LCBOb3YgMzAsIDIwMTggYXQgMDQ6MTk6NDZQTSArMDAwMCwgU3REZW5pcywgVG9tIHdyb3RlOg0K
Pj4gT24gMjAxOC0xMS0zMCAxMDozMSBhLm0uLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gDQo+
Pj4gSSBwdXNoZWQgdGhlbSBvdXQgdG86DQo+Pj4NCj4+PiAgICAgZ2l0Oi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3BldGVyei9xdWV1ZS5naXQgeDg2L21tDQo+Pj4N
Cj4+PiBJIGhvcGUgdGhhdCB3b3JrczsgSSdtIG91dCBmb3IgYSBmZXcgaG91cnMsIGJ1dCBzaG91
bGQgY2hlY2sgb24gZW1haWwNCj4+PiBhZ2FpbiB0b25pZ2h0Lg0KPj4+DQo+Pg0KPj4gTkFLIEkg
Z2V0IGEgZmFpbHVyZSBpbiBUVE0gb24gaW5pdCB3aXRoIHlvdXIgeDg2L21tIGJyYW5jaCAoc2Vl
IGF0dGFjaGVkDQo+PiBkbWVzZykuDQo+IA0KPiAqc2lnaCosIGl0J3MgYmVlbiBvbmUgb2YgdGhv
c2UgZGF5cy4gT2ssIEknbGwgZ28gd3JpdGUgc29tZSBjcGENCj4gc2VsZnRlc3RzIG9yIHNvbWV0
aGluZyBzbyB0aGF0IEkgaGF2ZSBjb2RlIHRoYXQgdXNlcyB0aGlzIHN0dWZmLg0KPiANCg0KV2Vs
bCB0aGUgdHRtIGNyYXNoIGNvdWxkIGJlIGNvbXBsZXRlbHkgdW5yZWxhdGVkIHRoZSBwcm9ibGVt
IGlzIHlvdXIgDQp4ODYvbW0gYnJhbmNoIGlzIG5vdCB1cCB0byBkYXRlIHdpdGggbWFzdGVyIGFu
ZCBkb2Vzbid0IGluY2x1ZGUgZHJtIGZpeGVzLg0KDQpUb20NCg==
