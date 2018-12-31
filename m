Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE764C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F6E21871
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="P8xZEi3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbeLaTxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 14:53:12 -0500
Received: from mail-eopbgr790040.outbound.protection.outlook.com ([40.107.79.40]:57673
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727311AbeLaTxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 14:53:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJUyZN1CR74UtnUcyjpB8dfgSg6VA2bgGo+vpx7wzFE=;
 b=P8xZEi3v/Qdz36vCCsT6cxWJBNjw/DtgZldUeXEJiiZqF43JIqJQ9DE378ilnbM/+gR6tsdpLNJpQa7IELYgLYrzyCCaHe2FcUbZkj4pIrhClTRhvG/QJUyNwtY7bt+6iSFYW6hh+DOCe7ZV8i/M+TmzkSwhGFnCDg3fS6vFcgk=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5735.namprd05.prod.outlook.com (20.178.48.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 31 Dec 2018 19:53:07 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a418:297e:ee09:5872]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a418:297e:ee09:5872%4]) with mapi id 15.20.1495.005; Mon, 31 Dec 2018
 19:53:07 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [RFC v2 0/6] x86: dynamic indirect branch promotion
Thread-Topic: [RFC v2 0/6] x86: dynamic indirect branch promotion
Thread-Index: AQHUoNlgtfPp2hP9NUWIeKr+GY9EtKWZQqAAgAAAkgA=
Date:   Mon, 31 Dec 2018 19:53:06 +0000
Message-ID: <A7D88101-837A-4FD2-B397-019D1845A418@vmware.com>
References: <20181231072112.21051-1-namit@vmware.com>
 <CALCETrW_52zEv1kHa7AdhF4PUGvyX4VyHqig1bFAJM_3VAXn=A@mail.gmail.com>
In-Reply-To: <CALCETrW_52zEv1kHa7AdhF4PUGvyX4VyHqig1bFAJM_3VAXn=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5735;20:MAylBQfOQ7RAXdJguh8k2Qq/ERj8qjUBcuzvkSwBkAVsk08xHwyb4ux3VFtWFyuUSHpe4JD2IqF9mjvtKx2eH/wUUAkY1PqT5nVcNnlbWqw/cRBx9NuHGvenrE2nWNcxuogNTCDjdT0TKQ8z406hvqFU0L4hzqWkleYzaz56tCs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1e5849ee-06e2-498b-5ee6-08d66f599583
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5735;
x-ms-traffictypediagnostic: BYAPR05MB5735:
x-microsoft-antispam-prvs: <BYAPR05MB573517BA0D23F4A2C1952800D0B20@BYAPR05MB5735.namprd05.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5735;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5735;
x-forefront-prvs: 0903DD1D85
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(39860400002)(396003)(189003)(199004)(54534003)(6436002)(102836004)(26005)(7736002)(14444005)(8676002)(14454004)(6506007)(7416002)(8936002)(86362001)(71200400001)(71190400001)(229853002)(81156014)(6486002)(81166006)(83716004)(33656002)(25786009)(316002)(256004)(4326008)(186003)(82746002)(305945005)(478600001)(105586002)(2906002)(6512007)(36756003)(53936002)(66066001)(68736007)(53546011)(6246003)(446003)(99286004)(97736004)(2616005)(486006)(76176011)(106356001)(54906003)(6916009)(476003)(5660300001)(11346002)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5735;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PJsi9/AOb3lT9R3lXv8nn0Syfns1ynJnELZePo1CYssPSi6Y8tC9dA3rgst1imkfHoJ0jn8czrthSHS/uAtNWdjNDEqnfREbXrXk8aGXjeaoz9ehES2mRayY077bRAFnHrnEtDh3kVY/6zkDgL7vphfZLX6D9Bek91hpzxJzhs5t4m6m+VYU1WcPwVYsA7KHQEDaf/mX3gls0nRtSiM1o5ao6s0CH/5Lqr+KTRJNzNn9LK1dEzyjIeNDXP44/2RIDLsa3jMzO/y5megzpE1dD4ftuCOFtrBAQGeuPAPig82DfVA1+UHrSgbIzQVRmRam
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D7ABD2516719F489258AA67B74F1552@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5849ee-06e2-498b-5ee6-08d66f599583
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2018 19:53:06.8659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5735
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBEZWMgMzEsIDIwMTgsIGF0IDExOjUxIEFNLCBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBTdW4sIERlYyAzMCwgMjAxOCBhdCAxMToyMCBQTSBO
YWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPiB3cm90ZToNCj4+IFRoaXMgaXMgYSByZXZpc2Vk
IHZlcnNpb24gb2Ygb3B0cG9saW5lcyAoZm9ybWVybHkgbmFtZWQgcmV0cG9saW5lcykgZm9yDQo+
PiBkeW5hbWljIGluZGlyZWN0IGJyYW5jaCBwcm9tb3Rpb24gaW4gb3JkZXIgdG8gcmVkdWNlIHJl
dHBvbGluZSBvdmVyaGVhZHMNCj4+IFsxXS4NCj4gDQo+IFNvbWUgb2YgeW91ciBjaGFuZ2Vsb2dz
IHN0aWxsIGNhbGwgdGhlbSAicmVscG9saW5lcyIuDQo+IA0KPiBJIGhhdmUgYSBjcmF6eSBzdWdn
ZXN0aW9uOiBtYXliZSBkb24ndCBnaXZlIHRoZW0gYSBjdXRlIG5hbWUgYXQgYWxsPw0KPiBXaGVy
ZSBpdCdzIGFjdHVhbGx5IG5lY2Vzc2FyeSB0byBuYW1lIHRoZW0gKGxpa2UgaW4gYSBjb25maWcg
b3B0aW9uKSwNCj4gdXNlIGEgZGVzY3JpcHRpb24gbGlrZSBDT05GSUdfRFlOQU1JQ19ERVZJUlRV
QUxJWkFUSU9OIG9yDQo+IENPTkZJR19QQVRDSF9JTkRJUkVDVF9DQUxMUyBvciBzb21ldGhpbmcu
DQoNCknigJltIHRvdGFsbHkgZmluZSB3aXRoIHRoYXQgKGRvbuKAmXQgdHVybiBtZSBpbnRvIGEg
Im1hcmtldGluZ+KAnSBndXkpLiBJdCB3YXMNCmp1c3QgYSB3YXkgdG8gcmVmZXIgdG8gdGhlIG1l
Y2hhbmlzbS4gSSBuZWVkIG1vcmUgZmVlZGJhY2sgYWJvdXQgdGhlIG1vcmUNCmZ1bmRhbWVudGFs
IGlzc3VlcyB0byBnbyBvbi4NCg0K
