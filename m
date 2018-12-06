Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B002EC07E85
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9D62082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="NE9kNXLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9D62082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbeLFAGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 19:06:36 -0500
Received: from mail-eopbgr770041.outbound.protection.outlook.com ([40.107.77.41]:24704
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727762AbeLFAGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 19:06:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGLcF5U+lIJEYekF2D25WUx0lo8PWScOQJXNPvWHWZI=;
 b=NE9kNXLNUiegMoAB53+360eDYc6QV++QAIG4F2p28QKUtsTjX5XAcuqKZdLBGDEQBWYuCCpFIiRxSu4wZ8CNyCjTz6fKD9b/c29suQnE/0sl1nKN0oj/e7N+u4Ub83+7x/B6QifNFY5HFnqWFW+qMk9GzXQJrR3sFnu37cMYViA=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4934.namprd05.prod.outlook.com (52.135.235.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.14; Thu, 6 Dec 2018 00:06:30 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7%3]) with mapi id 15.20.1425.006; Thu, 6 Dec 2018
 00:06:30 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v7 08/14] x86/ftrace: Use text_poke_*() infrastructure
Thread-Topic: [PATCH v7 08/14] x86/ftrace: Use text_poke_*() infrastructure
Thread-Index: AQHUjHfOc0ECF8bvYEydiFdgoLXd4KVw1iOA
Date:   Thu, 6 Dec 2018 00:06:30 +0000
Message-ID: <25B84F01-DB4C-4957-9703-769CCC9794BB@vmware.com>
References: <20181205013408.47725-1-namit@vmware.com>
 <20181205013408.47725-9-namit@vmware.com>
In-Reply-To: <20181205013408.47725-9-namit@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4934;20:IZRlEzv+VtirWtqKgUnBxcge4yietqwyfswZXQU6kDNBrFW6bf1U9Vq1HuIQcfXDNmGhlNZouJTOnzVwe6WY+vGm8AS7rM5V524CItuCgWabo3RQum/gKR6piwRxNnsdkGQIhZxNezlGkEbo/Sb7Gs5bWIzrAHZCwrbGvIysSkE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 67335493-aa57-4ce3-d2aa-08d65b0eacbc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4934;
x-ms-traffictypediagnostic: BYAPR05MB4934:
x-microsoft-antispam-prvs: <BYAPR05MB493444F5C216D102B7FD5FE3D0A90@BYAPR05MB4934.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4934;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(376002)(136003)(366004)(199004)(189003)(71190400001)(71200400001)(82746002)(7520500002)(8676002)(486006)(2906002)(316002)(186003)(478600001)(6486002)(229853002)(81166006)(81156014)(8936002)(105586002)(76176011)(54906003)(7736002)(110136005)(102836004)(66066001)(305945005)(53546011)(11346002)(446003)(26005)(68736007)(476003)(14454004)(2616005)(4326008)(86362001)(53936002)(6506007)(6116002)(3846002)(36756003)(256004)(97736004)(39060400002)(5660300001)(33656002)(6436002)(83716004)(99286004)(106356001)(6246003)(6512007)(7416002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4934;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 67EdZ/0L3BVo06v3wophJ42oAjYoms//uqy3UbsiCqyBoGBMhwbE5sY+PLy4e01F63zHFx0MT7jdxUbOWIxn8LzvdHbLcJBJsUUBlxMfHR6jBotPwQ6IP3uhU3J06DDv8cw2u5Semxjppm68dxwx0XsFTy8sMNNLQPq06JDH4SIUIb3yt6bLBpy5AtzA4BTQC49pAgwY5rGjlBMCrhMuBm4mXvsp8CsKlpa+ogxBX6gx9SWu5ey1Fo+MDTEksHgMWTFEIfAIXUcOq8pP//edTsQNRK0y2vpo2l94gajEwA4wrM+HTJdmr8hDFn0zP5KdazisNLzQpBbAN+8uhfL2jJ7S9Uh3SnS3Zbvq1Gd+v9E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FED0091588BEB44A14EC09BA2519E95@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67335493-aa57-4ce3-d2aa-08d65b0eacbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 00:06:30.2104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4934
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBEZWMgNCwgMjAxOCwgYXQgNTozNCBQTSwgTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNv
bT4gd3JvdGU6DQo+IA0KPiBBIGZvbGxvd2luZyBwYXRjaCBpcyBnb2luZyB0byBtYWtlIG1vZHVs
ZSBhbGxvY2F0ZWQgbWVtb3J5DQo+IG5vbi1leGVjdXRhYmxlLiBUaGlzIHJlcXVpcmVzIHRvIG1v
ZGlmeSBmdHJhY2UgYW5kIG1ha2UgdGhlIG1lbW9yeQ0KPiBleGVjdXRhYmxlIGFnYWluIGFmdGVy
IGl0IGlzIGNvbmZpZ3VyZWQuDQo+IA0KPiBJbiBhZGRpdGlvbiwgdGhpcyBwYXRjaCBtYWtlcyBm
dHJhY2UgdXNlIHRoZSBnZW5lcmFsIHRleHQgcG9raW5nDQo+IGluZnJhc3RydWN0dXJlIGluc3Rl
YWQgZnRyYWNlJ3MgaG9tZWdyb3duIHRleHQgcGF0Y2hpbmcuIFRoaXMgcHJvdmlkZXMNCj4gdGhl
IGFkdmFudGFnZXMgb2YgaGF2aW5nIHNsaWdodGx5ICJzYWZlciIgY29kZSBwYXRjaGluZyBhbmQg
YXZvaWRpbmcNCj4gcmFjZXMgd2l0aCBtb2R1bGUgcmVtb3ZhbCBvciBvdGhlciBtZWNoYW5pc21z
IHRoYXQgcGF0Y2ggdGhlIGtlcm5lbA0KPiBjb2RlLg0KPiANCj4gQ2M6IFN0ZXZlbiBSb3N0ZWR0
IDxyb3N0ZWR0QGdvb2RtaXMub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBOYWRhdiBBbWl0IDxuYW1p
dEB2bXdhcmUuY29tPg0KPiAtLS0NCj4gYXJjaC94ODYva2VybmVsL2Z0cmFjZS5jIHwgNzQgKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAxIGZpbGUgY2hhbmdlZCwg
MjMgaW5zZXJ0aW9ucygrKSwgNTEgZGVsZXRpb25zKC0pDQoNClN0ZXZlbiBSb3N0ZWR0IHBvaW50
ZWQgdGhhdCB1c2luZyB0ZXh0X3Bva2UoKSBpbnN0ZWFkIG9mDQpwcm9iZV9rZXJuZWxfd3JpdGUo
KSB3b3VsZCBpbnRyb2R1Y2UgY29uc2lkZXJhYmxlIG92ZXJoZWFkcy4gUnVubmluZzoNCg0KICAj
IHRpbWUgeyBlY2hvIGZ1bmN0aW9uID4gY3VycmVudF90cmFjZXI7IH0gDQoNCnRha2VzIDAuMjRz
IHdpdGhvdXQgdGhpcyBwYXRjaCBhbmQgMC43cyB3aXRoLiBJIGRvbuKAmXQga25vdyB3aGV0aGVy
IHRvDQpjb25zaWRlciBpdCDigJxzbyBiYWTigJ0uIE9idmlvdXNseSB3ZSBjYW4gaW50cm9kdWNl
IGEgYmF0Y2hpbmcgbWVjaGFuaXNtIGFuZC9vcg0KZG8gc29tZSBtaWNyby1vcHRpbWl6YXRpb24g
KHRoZSBsYXR0ZXIgd2lsbCBub3QgYnV5IHVzIG11Y2ggdGhvdWdoKS4NCg0KQW55aG93LCBpbiB0
aGUgbWVhbndoaWxlIFN0ZXZlbiBhc2tlZCB0aGF0IHdl4oCZbGwgbGVhdmUgb3V0IHRoZSBjaGFu
Z2VzIGluDQp0aGlzIHBhdGNoLXNldCwgZXhjbHVkaW5nIHRoZSBzZXRfbWVtb3J5X3goKSB0aGF0
IHdlIG5lZWQgYWZ0ZXIgY2FsbGluZw0KbW9kdWxlX2FsbG9jKCksIGFuZCBjb25zaWRlciB0aGVt
IGxhdGVyLg0KDQo=
