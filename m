Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BFDC46462
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DAB20685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="FugIJ/YK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DAB20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbeKUFRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 00:17:52 -0500
Received: from mail-eopbgr780045.outbound.protection.outlook.com ([40.107.78.45]:39088
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725939AbeKUFRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 00:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2SrvTExLlZyBjICEAZQuE8TkysLVQ7lMcDWLixw1oE=;
 b=FugIJ/YKJAXAUGBJX+ujOxiLI1JLiz9C4XPpKL3M9v8+wwv8FAUeaczVqA5aT7BPScSGRRlrSSnn1+b7t/baG+hLGwKjMcttpoZVDK+VpSfPaLVnTj3O0O3/pa/hKpBC4ZmpZJIl5IF5oZ6L46OUrBEE9t9OH1IZaCgLxZdGTX0=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5205.namprd05.prod.outlook.com (20.177.231.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.13; Tue, 20 Nov 2018 18:47:11 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1361.013; Tue, 20 Nov 2018
 18:47:11 +0000
From:   Nadav Amit <namit@vmware.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v5 02/10] x86/jump_label: Use text_poke_early() during
 early init
Thread-Topic: [PATCH v5 02/10] x86/jump_label: Use text_poke_early() during
 early init
Thread-Index: AQHUe48MxjiZflJfKECfKk33d4cmYaVZAXMAgAACTwCAAAFDgIAABr8A
Date:   Tue, 20 Nov 2018 18:47:11 +0000
Message-ID: <B1CCA937-6595-4430-B1CB-7833CD303BDB@vmware.com>
References: <20181113130730.44844-1-namit@vmware.com>
 <20181113130730.44844-3-namit@vmware.com>
 <76c41854-b12d-5c4e-cfa4-f448e102860b@zytor.com>
 <20181120181830.GB2131@hirez.programming.kicks-ass.net>
 <34f7e083-218e-dbdf-73ca-47dd11e750cc@zytor.com>
In-Reply-To: <34f7e083-218e-dbdf-73ca-47dd11e750cc@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5205;20:xxtn0QmhTfMWhU15RwIVtkViQm8qi2SqTJtirthFWdUL5/Iu3drIy0jUpivSNeF9CYNRsijsN5m8goAafVcmPrbauvpzBtFRZZnFdHV/5LdifD2FIMUDfEhyoQ7HRSoevyh7q08qAbiPxSIHoSV6YTe9B2yhI+GrjbzOltGsbVQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b7977299-bf8a-4226-e72a-08d64f1894d1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5205;
x-ms-traffictypediagnostic: BYAPR05MB5205:
x-microsoft-antispam-prvs: <BYAPR05MB5205B9670B5C335B7BFA6135D0D90@BYAPR05MB5205.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5205;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5205;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(366004)(396003)(199004)(189003)(81156014)(305945005)(2900100001)(6486002)(2906002)(6436002)(8676002)(82746002)(76176011)(99286004)(25786009)(36756003)(7416002)(8936002)(33656002)(81166006)(97736004)(7736002)(71200400001)(5660300001)(256004)(86362001)(83716004)(71190400001)(26005)(186003)(11346002)(102836004)(53546011)(6506007)(446003)(66066001)(486006)(68736007)(6116002)(3846002)(2616005)(14454004)(6916009)(476003)(316002)(53936002)(39060400002)(229853002)(4326008)(478600001)(6246003)(105586002)(54906003)(6512007)(93886005)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5205;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9bgJt1dka1Id2q+VdxHkl96H3wC09lMe1HFgqQpY+3nuPjdMPxDQ0nc7iW5jLFy0UW196Wd7NwpuETe7IcUPF1iYfDbMws18jxTkwm34KNfM9mYb1cwI0r2ATXcCDvqXMOniQNAJqcmobNVyGFioytqfx+ucTN3mx095uPc07nYB/OP+86wQUMxNUI9fMceedi6AMIV5cbPewBgG8BKs4vEwz4a1d75KACrluvRQrJHH/qsK9IVq13CsY0NKqZ0nUtOlsRGnvwrJ53zVBul3tKV4SEm4XS6WVgHjyBVTQDm/HmAtlJrCKYjcTO3NxYOOfCRLRZeTjye8pg5vfGzwgZ/v2IRMbwPMKVJSaSsWd3M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <352C4A23978D9C4594C275585477B6FF@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7977299-bf8a-4226-e72a-08d64f1894d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 18:47:11.3126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBOb3YgMjAsIDIwMTgsIGF0IDEwOjIzIEFNLCBILiBQZXRlciBBbnZpbiA8aHBhQHp5dG9y
LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAxMS8yMC8xOCAxMDoxOCBBTSwgUGV0ZXIgWmlqbHN0cmEg
d3JvdGU6DQo+Pj4gQ2FuJ3Qgd2UgbWFrZSB0aGlzIHRlc3QgaW4gdGV4dF9wb2tlKCkgZGlyZWN0
bHksIHBsZWFzZT8NCj4+IA0KPj4gSGUgZG9lcyB0aGF0IGluIDkvMTAgaWlyYy4NCj4gDQo+IE5v
LCBpbiA5LzEwIGhlIGRvZXMgdGhhdCBjaGFuZ2UgbG9jYWxseSBmb3IgdGhlIGp1bXBfbGFiZWws
IGJ1dCB0aGVyZSBpcw0KPiBhYnNvbHV0ZWx5IG5vIHJlYXNvbiBub3QgdG8gZG8gdGhhdCB0ZXN0
IGluIHRleHRfcG9rZSgpIHByb3BlciwgYW5kDQo+IHNpbXBseSB1c2UgdGV4dF9wb2tlKCkgZXZl
cnl3aGVyZSBpbiB0aGUga2VybmVsLg0KDQpUaGUgZGVjaXNpb24gaW4gX19qdW1wX2xhYmVsX3Ry
YW5zZm9ybSgpIGlzIGJldHdlZW4gdGV4dF9wb2tlX2Vhcmx5KCkgYW5kDQp0ZXh0X3Bva2VfYnAo
KSAoIGFuZCBub3QgdGV4dF9wb2tlKCkgKS4NCg0KTW92ZW92ZXIsIHRleHRfcG9rZV9lYXJseSgp
IGlzIGFsc28gdXNlZCB3aGVuIGEgbW9kdWxlIGlzIGxvYWRlZCAtIGENCmRlY2lzaW9uIHdoaWNo
IGJhc2VkIG9uIHRoZSDigJxpbml0IiBhcmd1bWVudC4NCg0KRm9yIHRoZXNlIHR3byByZWFzb25z
LCBJIGRvbuKAmXQgc2VlIGhvdyB0aGUgY2hhbmdlIHlvdSBwcm9wb3NlZCBjYW4gYmUNCnBlcmZv
cm1lZC4NCg0K
