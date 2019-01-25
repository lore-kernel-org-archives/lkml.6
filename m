Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B573C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9E6218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ZpBf3Yp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfAYS2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:28:18 -0500
Received: from mail-eopbgr730069.outbound.protection.outlook.com ([40.107.73.69]:31616
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726604AbfAYS2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIxjOtEjuG2D2m+9rIi/IKN04MBhzhwT0LdROfxWZoI=;
 b=ZpBf3Yp7eF8BbXH3dtSLfGCax0+FlzGLozGIxyK4VZ3fH8IrsZm79ZZg3wuvPMAIdirfhxk7oR7oTMxP00zaGv8pxFyGFC9I5a1mLT5XtLmswHzUh//OMU2KoDpvZNUHZiX8enffDl4Qr+q4GYigvPhm44kJ2cD8z+Scgtqj3o8=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5224.namprd05.prod.outlook.com (20.177.231.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.10; Fri, 25 Jan 2019 18:28:04 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::99ab:18fb:f393:df31]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::99ab:18fb:f393:df31%3]) with mapi id 15.20.1580.004; Fri, 25 Jan 2019
 18:28:04 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "deneen.t.dock@intel.com" <deneen.t.dock@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 01/17] Fix "x86/alternatives: Lockdep-enforce text_mutex
 in text_poke*()"
Thread-Topic: [PATCH 01/17] Fix "x86/alternatives: Lockdep-enforce text_mutex
 in text_poke*()"
Thread-Index: AQHUrfxOhBIE3CgBbEWQpABmYJlN26W/xVsAgACWFQA=
Date:   Fri, 25 Jan 2019 18:28:04 +0000
Message-ID: <BEFCBDFB-F08F-441D-8BCC-07E5F448D9D2@vmware.com>
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
 <20190117003259.23141-2-rick.p.edgecombe@intel.com>
 <20190125093052.GA27998@zn.tnic>
In-Reply-To: <20190125093052.GA27998@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5224;20:Pje6rlC6Kt02/zcptylGM0QtQoXzVKL6+Tpcn28Bw6m8bsB6QsxS5/iaYP+Otyceh8FBzUIp028BaptEZu5Ipgu9r8OurWg5pfvpYrFWXhtxJoKb6ePgQzx7ju/zKVvzXbN7/lEc/x2hK1mWXcUAxFbAwad95vfaj21RPCO1Mhg=
x-ms-office365-filtering-correlation-id: 5cf9e50c-ff6e-4bf2-c88d-08d682f2d86d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5224;
x-ms-traffictypediagnostic: BYAPR05MB5224:
x-microsoft-antispam-prvs: <BYAPR05MB52248BA540DF518DCF649E66D09B0@BYAPR05MB5224.namprd05.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(396003)(376002)(366004)(189003)(199004)(4326008)(68736007)(83716004)(82746002)(7416002)(102836004)(53936002)(256004)(14444005)(6512007)(39060400002)(71200400001)(6486002)(97736004)(53546011)(71190400001)(6246003)(6436002)(6506007)(33656002)(6116002)(3846002)(186003)(99286004)(14454004)(7736002)(305945005)(8936002)(478600001)(36756003)(2906002)(2616005)(476003)(81166006)(446003)(81156014)(26005)(6916009)(86362001)(11346002)(8676002)(54906003)(25786009)(316002)(105586002)(66066001)(229853002)(486006)(106356001)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5224;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r/JxOACK6cl+DYjXzDfbf4sVKKgIGSI/uY/MTunAKwlBLoRSp6lUQot4yxqEzsf8bd8hx9cOelzA7Quy5AtS+bVS+Q/Y3tsbXOstFfPpK6UHCf15ILKd9nDnnFG6rFKFd0CnHELrm8B2EnZbEK3x6N7pHD6C51mTNq/kyZJqkBiYrH4mEJkpcp1PXOqbgcLKnsO1ftE3yQvCZP1VGTCDopCGSx5pvLW/QpjBS5YKNYOmUScrc3Q9hvBvnTBf7WXISIYonp4uN9v/l0N+62n2hKlp2WQKab9NJxv7Afe8KjoEMHYBFlazlFmh3WIxYjv5D6rTm4gGawj4nmBDnXF6h28s3C46hreEMLAVLiJulCrxHF+qNjTAX+gCxZf8lcMU9+W9Tyt/6yF8w0T7ItVW/eWdqaHDlMvsPsjkv4wSEBY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40B2A33442F0754AA96DF64BE91FBD02@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf9e50c-ff6e-4bf2-c88d-08d682f2d86d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 18:28:04.0871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5224
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gMjUsIDIwMTksIGF0IDE6MzAgQU0sIEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44
LmRlPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgSmFuIDE2LCAyMDE5IGF0IDA0OjMyOjQzUE0gLTA4
MDAsIFJpY2sgRWRnZWNvbWJlIHdyb3RlOg0KPj4gRnJvbTogTmFkYXYgQW1pdCA8bmFtaXRAdm13
YXJlLmNvbT4NCj4+IA0KPj4gdGV4dF9tdXRleCBpcyBjdXJyZW50bHkgZXhwZWN0ZWQgdG8gYmUg
aGVsZCBiZWZvcmUgdGV4dF9wb2tlKCkgaXMNCj4+IGNhbGxlZCwgYnV0IHdlIGtnZGIgZG9lcyBu
b3QgdGFrZSB0aGUgbXV0ZXgsIGFuZCBpbnN0ZWFkICpzdXBwb3NlZGx5Kg0KPj4gZW5zdXJlcyB0
aGUgbG9jayBpcyBub3QgdGFrZW4gYW5kIHdpbGwgbm90IGJlIGFjcXVpcmVkIGJ5IGFueSBvdGhl
ciBjb3JlDQo+PiB3aGlsZSB0ZXh0X3Bva2UoKSBpcyBydW5uaW5nLg0KPj4gDQo+PiBUaGUgcmVh
c29uIGZvciB0aGUgInN1cHBvc2VkbHkiIGNvbW1lbnQgaXMgdGhhdCBpdCBpcyBub3QgZW50aXJl
bHkgY2xlYXINCj4+IHRoYXQgdGhpcyB3b3VsZCBiZSB0aGUgY2FzZSBpZiBnZGJfZG9fcm91bmR1
cCBpcyB6ZXJvLg0KPiANCj4gSSBndWVzcyB0aGF0IHZhcmlhYmxlIG5hbWUgaXMgImtnZGJfZG9f
cm91bmR1cOKAnSA/DQoNClllcy4gV2lsbCBmaXguDQoNCj4gDQo+PiBUaGlzIHBhdGNoIGNyZWF0
ZXMgdHdvIHdyYXBwZXIgZnVuY3Rpb25zLCB0ZXh0X3Bva2UoKSBhbmQNCj4gDQo+IEF2b2lkIGhh
dmluZyAiVGhpcyBwYXRjaCIgb3IgIlRoaXMgY29tbWl0IiBpbiB0aGUgY29tbWl0IG1lc3NhZ2Uu
IEl0IGlzDQo+IHRhdXRvbG9naWNhbGx5IHVzZWxlc3MuDQo+IA0KPiBBbHNvLCBkbw0KPiANCj4g
JCBnaXQgZ3JlcCAnVGhpcyBwYXRjaCcgRG9jdW1lbnRhdGlvbi9wcm9jZXNzDQo+IA0KPiBmb3Ig
bW9yZSBkZXRhaWxzLg0KDQpPay4NCg0KPj4gDQo+PiArdm9pZCAqdGV4dF9wb2tlX2tnZGIodm9p
ZCAqYWRkciwgY29uc3Qgdm9pZCAqb3Bjb2RlLCBzaXplX3QgbGVuKQ0KPiANCj4gdGV4dF9wb2tl
X3VubG9ja2VkKCkgSSBndWVzcy4gSSBkb24ndCB0aGluayBrZ2RiIGlzIHRoYXQgc3BlY2lhbCB0
aGF0IGl0DQo+IG5lZWRzIGl0cyBvd24gZnVuY3Rpb24gZmxhdm9yLg0KDQpUZ2x4IHN1Z2dlc3Rl
ZCB0aGlzIG5hbWluZyB0byBwcmV2ZW50IGFueW9uZSBmcm9tIG1pc3VzaW5nIHRleHRfcG9rZV9r
ZGdiKCkuDQpUaGlzIGlzIGEgdmVyeSBzcGVjaWZpYyB1c2UtY2FzZSB0aGF0IG5vYm9keSBlbHNl
IHNob3VsZCBuZWVkLg0KDQpSZWdhcmRzLA0KTmFkYXY=
