Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E918DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A448B2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="rFli1suu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbfAJAQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:16:41 -0500
Received: from mail-eopbgr820050.outbound.protection.outlook.com ([40.107.82.50]:36736
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726286AbfAJAQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 19:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Spnsqgp5awlncUGTQG0PqZdoYLb5/cGOxIGpj25TZAo=;
 b=rFli1suunC3zN7Xu32ifdtv2WC5xrnV7/wH6kkiBeuOfr55pn8TXcwEp1ww/Cg1Nof17XpdkeoIZ4KxIR/4e1s40N0jv49ohan39oFzyJDMG9WITTFbgCVPzUSZrIVYf1wSMYdkrRqLUQ35nBMZTf60XzLnH6E0F7wzqZ2zDZL8=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5479.namprd05.prod.outlook.com (20.177.185.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.4; Thu, 10 Jan 2019 00:16:34 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732%2]) with mapi id 15.20.1516.010; Thu, 10 Jan 2019
 00:16:34 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 3/6] x86/static_call: Add out-of-line static call
 implementation
Thread-Topic: [PATCH v3 3/6] x86/static_call: Add out-of-line static call
 implementation
Thread-Index: AQHUqG8PCfZFBn3lmUis/8VJvjDrbaWnop2A
Date:   Thu, 10 Jan 2019 00:16:34 +0000
Message-ID: <B4C5F8DE-5337-47F1-AD59-93B375A323C2@vmware.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <30f0713894a415f13e0f0ea3d40595416db2f6d7.1547073843.git.jpoimboe@redhat.com>
In-Reply-To: <30f0713894a415f13e0f0ea3d40595416db2f6d7.1547073843.git.jpoimboe@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5479;20:/apfOkBQzbxLNrG+j+jNY4vSegy7u2H3RsjQhUiyJ8FUxJPwrDf7XAtHKVp8qYPZLy7L2Di8cBapkojWFffL+S5GhwJBq1j5xFwnQM5+CcRzPsQPMZGPRqYPl3TPJT00U6fse1ECvOzse6Jw5HXNkhJmYTJn/BevnoVYYker9Nk=
x-ms-office365-filtering-correlation-id: c9e8f975-c06e-4118-b197-08d67690e134
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5479;
x-ms-traffictypediagnostic: BYAPR05MB5479:
x-microsoft-antispam-prvs: <BYAPR05MB54796C4DAFC1549D6CFDA299D0840@BYAPR05MB5479.namprd05.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39860400002)(136003)(376002)(189003)(199004)(446003)(7736002)(106356001)(11346002)(6306002)(2906002)(53546011)(102836004)(476003)(6506007)(97736004)(76176011)(2616005)(26005)(36756003)(33656002)(305945005)(6346003)(6436002)(68736007)(53936002)(82746002)(66066001)(186003)(99286004)(229853002)(71190400001)(6246003)(966005)(8936002)(83716004)(71200400001)(6486002)(478600001)(4326008)(14454004)(8676002)(7416002)(316002)(54906003)(486006)(5660300001)(105586002)(14444005)(81156014)(6116002)(86362001)(81166006)(256004)(6512007)(3846002)(6916009)(25786009)(567974002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5479;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Li9oxfkd5mQueyw9nIYmCVF9OhOpgfmPmuS67O9MIfgvOjVA9cGQLFd0lMuTCIMrnV8FnYt2LAT1h2ZdSsdSCQiD9Pl7VcGLwo30j1XUvgqZv02Qix3gB+EQXCgkUHwWeB1tIurUF256NRaZempHcASEQTQ2uU50Nw77UzMxIennYHVn+JCK50xnJgHmYLaJzuDvnzedu6SjNTd/qMrkSipCcY4IVQIqnvOxqiN0rYrnDmJb34dAMKkHQaSEHpBROwZOi/9e7v7EjIeqOxIg56YHDR9q4le1Ajz20njzBymbTksVoTgPPTz+T+lFo9Qb
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <78DEC2595438E443B97F13ED9845B9BE@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e8f975-c06e-4118-b197-08d67690e134
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 00:16:34.1918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5479
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gOSwgMjAxOSwgYXQgMjo1OSBQTSwgSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQHJl
ZGhhdC5jb20+IHdyb3RlOg0KPiANCg0KPHNuaXA+DQoNCj4gKw0KPiArdm9pZCBfX3JlZiBhcmNo
X3N0YXRpY19jYWxsX3RyYW5zZm9ybSh2b2lkICpzaXRlLCB2b2lkICp0cmFtcCwgdm9pZCAqZnVu
YykNCj4gK3sNCj4gKwlzMzIgZGVzdF9yZWxhdGl2ZTsNCj4gKwl1bnNpZ25lZCBjaGFyIG9wY29k
ZTsNCj4gKwl2b2lkICooKnBva2VyKSh2b2lkICosIGNvbnN0IHZvaWQgKiwgc2l6ZV90KTsNCj4g
Kwl2b2lkICppbnNuID0gdHJhbXA7DQo+ICsNCj4gKwltdXRleF9sb2NrKCZ0ZXh0X211dGV4KTsN
Cj4gKw0KPiArCS8qDQo+ICsJICogRm9yIHg4Ni02NCwgYSAzMi1iaXQgY3Jvc3MtbW9kaWZ5aW5n
IHdyaXRlIHRvIGEgY2FsbCBkZXN0aW5hdGlvbiBpcw0KPiArCSAqIHNhZmUgYXMgbG9uZyBhcyBp
dCdzIHdpdGhpbiBhIGNhY2hlIGxpbmUuDQo+ICsJICovDQo+ICsJb3Bjb2RlID0gKih1bnNpZ25l
ZCBjaGFyICopaW5zbjsNCj4gKwlpZiAob3Bjb2RlICE9IDB4ZTggJiYgb3Bjb2RlICE9IDB4ZTkp
IHsNCj4gKwkJV0FSTl9PTkNFKDEsICJ1bmV4cGVjdGVkIHN0YXRpYyBjYWxsIGluc24gb3Bjb2Rl
IDB4JXggYXQgJXBTIiwNCj4gKwkJCSAgb3Bjb2RlLCBpbnNuKTsNCj4gKwkJZ290byBkb25lOw0K
PiArCX0NCj4gKw0KPiArCWRlc3RfcmVsYXRpdmUgPSAobG9uZykoZnVuYykgLSAobG9uZykoaW5z
biArIENBTExfSU5TTl9TSVpFKTsNCj4gKw0KPiArCXBva2VyID0gZWFybHlfYm9vdF9pcnFzX2Rp
c2FibGVkID8gdGV4dF9wb2tlX2Vhcmx5IDogdGV4dF9wb2tlOw0KPiArCXBva2VyKGluc24gKyAx
LCAmZGVzdF9yZWxhdGl2ZSwgc2l6ZW9mKGRlc3RfcmVsYXRpdmUpKTsNCj4gKw0KPiArZG9uZToN
Cj4gKwltdXRleF91bmxvY2soJnRleHRfbXV0ZXgpOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTF9H
UEwoYXJjaF9zdGF0aWNfY2FsbF90cmFuc2Zvcm0pOw0KDQpFcnLigKYgSSB3YXMgcmV3cml0aW5n
IF9fanVtcF9sYWJlbF90cmFuc2Zvcm0oKSwgc28gaWYgdGhpcyBjb2RlIGR1cGxpY2F0aW9uIGNh
bg0KYmUgYXZvaWRlZCwgdGhpcyB3b3VsZCBiZSBncmVhdC4NCg0KKFNlZSBodHRwczovL2xrbWwu
b3JnL2xrbWwvMjAxOC8xMS8xNC83MiAp
