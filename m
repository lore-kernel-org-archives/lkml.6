Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DD6C46463
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA232087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="c8ye9d8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA232087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbeJKSEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:04:50 -0400
Received: from mail-ve1eur01on0085.outbound.protection.outlook.com ([104.47.1.85]:23518
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726656AbeJKSEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNsJWaxvkFeeYyzKROSLxoNErJ4lxFYHCbJgzrLhvT4=;
 b=c8ye9d8I4uWyzBTfsJveJW2Btap2DslpF8C2L2pVm4CyastMdDj0qlr6G/Gx/hw7IcD5ZsikEYxpoMMj4tJ7gTMYfxGD5iZMuM+1eftAOGh2fB/QqMZmCIrVRN5QVpbgMzv8lXUxsdLU6UAhKnv3IqDCjm+AyyX/U0ylvpkHBZ0=
Received: from VI1PR08MB3294.eurprd08.prod.outlook.com (52.134.31.11) by
 VI1PR08MB3808.eurprd08.prod.outlook.com (20.178.14.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.18; Thu, 11 Oct 2018 10:37:25 +0000
Received: from VI1PR08MB3294.eurprd08.prod.outlook.com
 ([fe80::71c4:7004:818f:2d71]) by VI1PR08MB3294.eurprd08.prod.outlook.com
 ([fe80::71c4:7004:818f:2d71%3]) with mapi id 15.20.1207.029; Thu, 11 Oct 2018
 10:37:25 +0000
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
CC:     nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>
Subject: Re: [RFC PATCH for 4.21 01/16] rseq/selftests: Add reference counter
 to coexist with glibc
Thread-Topic: [RFC PATCH for 4.21 01/16] rseq/selftests: Add reference counter
 to coexist with glibc
Thread-Index: AQHUYM5AJL7p/dPuu0ud+WbMPMG0kKUZ2yOA
Date:   Thu, 11 Oct 2018 10:37:25 +0000
Message-ID: <38596780-30f7-0763-0c17-7517dbf0bf59@arm.com>
References: <20181010191936.7495-1-mathieu.desnoyers@efficios.com>
 <20181010191936.7495-2-mathieu.desnoyers@efficios.com>
In-Reply-To: <20181010191936.7495-2-mathieu.desnoyers@efficios.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-originating-ip: [217.140.106.49]
x-clientproxiedby: DB7PR04CA0028.eurprd04.prod.outlook.com
 (2603:10a6:10:12::41) To VI1PR08MB3294.eurprd08.prod.outlook.com
 (2603:10a6:803:3e::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB3808;6:1P+7V7qLOEZPCbsrRSdJek8NIPfz/fUOchzKaINmKE6ORRJtcWF2+0PNZDCpxyKDv9U/pDxt+6IwE1vTHwu/wxI/fFhgp4j83udf+mR1jRh3HYqeFDiJu9k9wRp+okCeQk3Kj7hEcs5vF+Old5YVGP537L/MPrn6SjGGYf8SYg1rTAF8ZQXiShVvJiu30PnV3vR1PQFWT9QDmsbaxMOWji8cbtvBxXRXrykpwQbc1sSGilyGdavqYstuMUIge9igK98LWcAHEXCt7+o1H7UeSjJH3ObV/d3JvoCwiC+6/W91LzOrpv3fm0kUbL6bD2OBCMJFiEFHw7JR8tLmlK7ztsHI55r3thKyb+rsqMFUbOX6uyzu8n9I9EkXzAV2uHxcZNCbkqlIkp6WxqMLTGeiDtXBijl9GF7YxwZGYXXGJb6GdC8sbbxx7ojEA9kxce6x3vZHxAoVJXRsCVr/5zO41g==;5:/R9wH4XXUBYIlK3dwDIRUjk63vvyxVYU+b2KuRlJn477uExvH1Q2w1s2ia19DeOuogn/MSmEWvJvXbRDNbmloXup7okmshxxTPqf6XBntU2c98mRbeqxrPCxmmS9Iiz6qY9GUIf7R98kbLBH1sJdQiaZsgMIJCM5rZb5+YPf1gw=;7:vtdk0e8IstpuqXh6U805OMjk9iSoNz0QJhGs9uUESz6cGd7aeL8qimcxix8lZJ9skzxKtrMQXCsQ6iwm5LSg4CYH1qyAKLJAn2uqxigjDDt1JYIKREXs5jGi9tgC08c4UwNatRU7WCYyDc4yCHZ5EDtcETqTplBqNjle/yyR8sSFU1HV1/dqedxoT+OFKIgyPYXLLydK/AL/kRASx2RYAaQzpWoQGDkOklJvJFHFHAfBfWVaCayHLlbrzz5e8o1D
x-ms-office365-filtering-correlation-id: 36df75cd-47cf-4e80-1bd0-08d62f658875
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3808;
x-ms-traffictypediagnostic: VI1PR08MB3808:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB3808CADE44A625C8A2A8F1E9EDE10@VI1PR08MB3808.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(278428928389397);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR08MB3808;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3808;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(396003)(39860400002)(376002)(189003)(199004)(256004)(53936002)(8676002)(71190400001)(386003)(2616005)(65826007)(102836004)(14454004)(36756003)(305945005)(65956001)(68736007)(7416002)(66066001)(7736002)(65806001)(11346002)(446003)(316002)(53546011)(217873002)(64126003)(76176011)(6512007)(97736004)(6246003)(52116002)(186003)(26005)(39060400002)(31696002)(6506007)(486006)(86362001)(72206003)(2900100001)(2906002)(478600001)(58126008)(110136005)(14444005)(8936002)(229853002)(4326008)(476003)(6436002)(31686004)(44832011)(3846002)(99286004)(6116002)(105586002)(25786009)(5250100002)(71200400001)(5660300001)(106356001)(6486002)(81156014)(54906003)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3808;H:VI1PR08MB3294.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZuqI4D/Uxqq8sc7oWFTRNSrz5F2cMR5/VuoEcp0+YnS9TWeJ+CPxIGRniz5B8LKCHr46TvkrE9eNSQWka8wKMn8DGLtqV8QXmPOptyppT3VTy7bVL7dIcQTTYR4cRnfZs/XPmWtzXBYsg2RCF3e3BdSdBZIs4pg+0wQS9dxCqjGZ2SFEsHBdPwu5VDvIgtPtq57/xZ3DgbFj6IuPUgpBZG+sXZ9D0qEul8fIbUDJQ/p7r1tw2LIiNwA8WSVGmjlKIuwoLhcbzIOP5ydGuhygUVxtCTrPQ1yYmkPLtFzjprozzb897pVJjinCQ0Pbt///W+3d/hOQD6CsXyB56G7xpIP1ZamGmDtcoInOPvNdsG0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <098D89D6A661F644B1E5C7D8D0DD5A03@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36df75cd-47cf-4e80-1bd0-08d62f658875
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 10:37:25.6438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3808
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTAvMTggMjA6MTksIE1hdGhpZXUgRGVzbm95ZXJzIHdyb3RlOg0KPiBJbiBvcmRlciB0
byBpbnRlZ3JhdGUgcnNlcSBpbnRvIHVzZXItc3BhY2UgYXBwbGljYXRpb25zLCBhZGQgYSByZWZl
cmVuY2UNCj4gY291bnRlciBmaWVsZCBhZnRlciB0aGUgc3RydWN0IHJzZXEgVExTIEFCSSBzbyBt
YW55IHJzZXEgdXNlcnMgY2FuIGJlDQo+IGxpbmtlZCBpbnRvIHRoZSBzYW1lIGFwcGxpY2F0aW9u
IChlLmcuIGxpYnJzZXEgYW5kIGdsaWJjKS4gVGhlDQo+IHJlZmVyZW5jZSBjb3VudCBlbnN1cmVz
IHRoYXQgcnNlcSBzeXNjYWxsIHJlZ2lzdHJhdGlvbi91bnJlZ2lzdHJhdGlvbg0KPiBoYXBwZW5z
IG9ubHkgZm9yIHRoZSBtb3N0IGVhcmx5L2xhdGUgdXNlciBmb3IgZWFjaCB0aHJlYWQsIHRodXMg
ZW5zdXJpbmcNCj4gdGhhdCByc2VxIGlzIHJlZ2lzdGVyZWQgYWNyb3NzIHRoZSBsaWZldGltZSBv
ZiBhbGwgcnNlcSB1c2VycyBmb3IgYQ0KPiBnaXZlbiB0aHJlYWQuDQouLi4NCj4gK19fYXR0cmli
dXRlX18oKHZpc2liaWxpdHkoImhpZGRlbiIpKSkgX190aHJlYWQNCj4gK3ZvbGF0aWxlIHN0cnVj
dCBsaWJjX3JzZXEgX19saWJfcnNlcV9hYmkgPSB7DQouLi4NCj4gK2V4dGVybiBfX2F0dHJpYnV0
ZV9fKCh3ZWFrLCBhbGlhcygiX19saWJfcnNlcV9hYmkiKSkpIF9fdGhyZWFkDQo+ICt2b2xhdGls
ZSBzdHJ1Y3QgcnNlcSBfX3JzZXFfYWJpOw0KLi4uDQo+IEBAIC03MCw3ICs4Niw3IEBAIGludCBy
c2VxX3JlZ2lzdGVyX2N1cnJlbnRfdGhyZWFkKHZvaWQpDQo+ICAJc2lnc2V0X3Qgb2xkc2V0Ow0K
PiAgDQo+ICAJc2lnbmFsX29mZl9zYXZlKCZvbGRzZXQpOw0KPiAtCWlmIChyZWZjb3VudCsrKQ0K
PiArCWlmIChfX2xpYl9yc2VxX2FiaS5yZWZjb3VudCsrKQ0KPiAgCQlnb3RvIGVuZDsNCj4gIAly
YyA9IHN5c19yc2VxKCZfX3JzZXFfYWJpLCBzaXplb2Yoc3RydWN0IHJzZXEpLCAwLCBSU0VRX1NJ
Ryk7DQoNCndoeSBkbyB5b3UgdXNlIGEgbG9jYWwgcmVmY291bnRlciBpbnN0ZWFkIG9mIHRoZSBf
X3JzZXFfYWJpIG9uZT8NCg0Kd2hhdCBwcmV2ZW50cyBjYWxsaW5nIHJzZXFfcmVnaXN0ZXJfY3Vy
cmVudF90aHJlYWQgbW9yZSB0aGFuIDRHIHRpbWVzPw0KDQp3aHkgY2FudCB0aGUga2VybmVsIHNl
ZSB0aGF0IHRoZSBzYW1lIGFkZHJlc3MgaXMgcmVnaXN0ZXJlZCBhZ2FpbiBhbmQgc3VjY2VlZD8N
Cg==
