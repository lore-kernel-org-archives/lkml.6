Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323D9C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7336204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="APf+1Jac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7336204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388537AbeGXTLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:11:50 -0400
Received: from mail-eopbgr710085.outbound.protection.outlook.com ([40.107.71.85]:10848
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388469AbeGXTLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58CjCD+a75sqUMeFj7SwNsky03GaTg9EoWQ4nRmKv/o=;
 b=APf+1Jacf20cCZ5YvYcULF7wNWDY0qxu39MvpXPLN+LqSrzaD1VUFKvMmwW67QvQb8XVSXOljCsPcMROwFYl5omVc49hkS0Z6Ae810kgsHvcOKEQxaqy3Y6ALb0nxWWaEQ/sM+SyUSQjjsqiaS1i96KMAJe9Sm3ZQTDFISo0NCE=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4599.namprd05.prod.outlook.com (52.135.233.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.10; Tue, 24 Jul 2018 18:04:06 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::7c5f:4dd5:fff8:3333]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::7c5f:4dd5:fff8:3333%6]) with mapi id 15.20.0973.022; Tue, 24 Jul 2018
 18:04:06 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
Subject: Re: [PATCH v6 1/9] Makefile: Prepare for using macros for inline asm
Thread-Topic: [PATCH v6 1/9] Makefile: Prepare for using macros for inline asm
Thread-Index: AQHUCk2iIcKnEA2RIkeNyBkA+zWX3KSUXYwAgAoM5oCAAHJcAA==
Date:   Tue, 24 Jul 2018 18:04:06 +0000
Message-ID: <A1E263C1-C1DA-4B23-8232-8CF87DDD7A3F@vmware.com>
References: <20180622172212.199633-1-namit@vmware.com>
 <20180622172212.199633-2-namit@vmware.com>
 <CAK7LNASaZd9fupgu4vxc6+tnCnNMdrCi7LTwS56K1LaKODoCtA@mail.gmail.com>
 <20180724111445.GB14212@gmail.com>
In-Reply-To: <20180724111445.GB14212@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.3.26]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4599;20:n4GGa+ZOqV4agsToyEytRHux5NE5jSjlKVJWILH8UwmeYidCX6I96oaHTj0OZF98G1l+S17imEmiOAqi/LEqsOnjuB/0NPb3Kg01VnbSaZv2NiQQFwvM01Us8MRHlSgVaZo5SsendLsItflh2HchZigRiEfVLHNpoXJFr3CdmhQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 16b60613-382c-4aac-8756-08d5f18fd8d4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4599;
x-ms-traffictypediagnostic: BYAPR05MB4599:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB4599F5D0E10EB61C6F38FF2DD0550@BYAPR05MB4599.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BYAPR05MB4599;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4599;
x-forefront-prvs: 0743E8D0A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(376002)(136003)(396003)(189003)(199004)(25786009)(53936002)(2900100001)(6246003)(5660300001)(5250100002)(6116002)(3846002)(83716003)(66066001)(478600001)(86362001)(256004)(14444005)(97736004)(106356001)(105586002)(14454004)(4326008)(486006)(2616005)(6506007)(11346002)(446003)(476003)(76176011)(33656002)(7736002)(102836004)(316002)(6486002)(229853002)(8676002)(2906002)(81156014)(305945005)(6512007)(7416002)(81166006)(68736007)(8936002)(26005)(36756003)(186003)(82746002)(99286004)(6436002)(93886005)(110136005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4599;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: klNvjDo3/uP53nH5yHez3CgGbScX2JLCDA6t9Z5/bOoSSyuc5/wESIP9T7O1LtzuBfhpVz8LASbk45fJQgOIVP+fL7MpvIdOqhVN/6TtGexy3B+o5erqnwh8XobcMWXmobzvkulp/YOeifDfP3PBkPzTl6OHYkOEMRkWuMYdr+VeXT2NFoWbE2isQz0/BaisHqxz1PMLgpjeukzjywOfRmEXwxfMN/kIEaFMB+vAgUsUsUAYWUld4o8NM1pxJ2jnGyP/fnlyIB7j21jARSTjI77nj2Nl/mVsX5j6VaVCOkP/q6xHPHHc1tgXZrtX0HGjig5dTT4q4EHUxl8llmO+1g4kKzq07l6P0S038oAf7Vs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE2CB2B0164B394E90AFE56AE56FB9D0@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b60613-382c-4aac-8756-08d5f18fd8d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2018 18:04:06.1646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4599
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgNDoxNCBBTSwgSW5nbyBNb2xuYXIgPG1pbmdvQGtlcm5lbC5vcmc+IHdyb3RlOg0KDQo+IA0K
PiAqIE1hc2FoaXJvIFlhbWFkYSA8eWFtYWRhLm1hc2FoaXJvQHNvY2lvbmV4dC5jb20+IHdyb3Rl
Og0KPiANCj4+IDIwMTgtMDYtMjMgMjoyMiBHTVQrMDk6MDAgTmFkYXYgQW1pdCA8bmFtaXRAdm13
YXJlLmNvbT46DQo+Pj4gVXNpbmcgbWFjcm9zIGZvciBpbmxpbmUgYXNzZW1ibHkgaW1wcm92ZXMg
Ym90aCByZWFkYWJpbGl0eSBhbmQNCj4+PiBjb21waWxhdGlvbiBkZWNpc2lvbnMgdGhhdCBhcmUg
ZGlzdG9ydGVkIGJ5IGJpZyBhc3NlbWJseSBibG9ja3MgdGhhdCB1c2UNCj4+PiBhbHRlcm5hdGl2
ZSBzZWN0aW9ucy4gQ29tcGlsZSBtYWNyb3MuUyBhbmQgdXNlIGl0IHRvIGFzc2VtYmxlIGFsbCBD
DQo+Pj4gZmlsZXMuIEN1cnJlbnRseSwgb25seSB4ODYgd2lsbCB1c2UgaXQuDQo+Pj4gDQo+Pj4g
Q2M6IFNhbSBSYXZuYm9yZyA8c2FtQHJhdm5ib3JnLm9yZz4NCj4+PiBDYzogTWFzYWhpcm8gWWFt
YWRhIDx5YW1hZGEubWFzYWhpcm9Ac29jaW9uZXh0LmNvbT4NCj4+PiBDYzogTWljaGFsIE1hcmVr
IDxtaWNoYWwubGttbEBtYXJrb3ZpLm5ldD4NCj4+PiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4
QGxpbnV0cm9uaXguZGU+DQo+Pj4gQ2M6IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPg0K
Pj4+IENjOiAiSC4gUGV0ZXIgQW52aW4iIDxocGFAenl0b3IuY29tPg0KPj4+IENjOiB4ODZAa2Vy
bmVsLm9yZw0KPj4+IENjOiBsaW51eC1rYnVpbGRAdmdlci5rZXJuZWwub3JnDQo+Pj4gQWNrZWQt
Ynk6IFBldGVyIFppamxzdHJhIChJbnRlbCkgPHBldGVyekBpbmZyYWRlYWQub3JnPg0KPj4+IFNp
Z25lZC1vZmYtYnk6IE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+DQo+Pj4gLS0tDQo+PiAN
Cj4+IA0KPj4gDQo+PiBBY2tlZC1ieTogTWFzYWhpcm8gWWFtYWRhIDx5YW1hZGEubWFzYWhpcm9A
c29jaW9uZXh0LmNvbT4NCj4+IA0KPj4gDQo+PiANCj4+IA0KPj4+IE1ha2VmaWxlICAgICAgICAg
ICAgICAgICB8ICA5ICsrKysrKystLQ0KPj4+IGFyY2gveDg2L01ha2VmaWxlICAgICAgICB8IDEx
ICsrKysrKysrKy0tDQo+Pj4gYXJjaC94ODYva2VybmVsL21hY3Jvcy5TIHwgIDcgKysrKysrKw0K
Pj4+IHNjcmlwdHMvS2J1aWxkLmluY2x1ZGUgICB8ICA0ICsrKy0NCj4+PiBzY3JpcHRzL21vZC9N
YWtlZmlsZSAgICAgfCAgMiArKw0KPj4+IDUgZmlsZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkNCj4+PiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC94ODYva2VybmVs
L21hY3Jvcy5TDQo+IA0KPiBTbyB0aGlzIHBhdGNoIGFwcGVhcnMgdG8gYnJlYWsgdGhlIHh0ZW5z
YSBjcm9zcy1idWlsZCBvbiBteSBzeXN0ZW0sIHdpdGggYW4gb2xkZXIgDQo+IHZlcnNpb24gb2Yg
Y3Jvc3N0b29sczoNCj4gDQo+ICBNT0RQT1NUIHZtbGludXgubw0KPiAvaG9tZS9taW5nby9jcm9z
c3Rvb2wta29yZy9iaW4vL2djYy00LjkuMC1ub2xpYmMveHRlbnNhLWxpbnV4L2Jpbi94dGVuc2Et
bGludXgtbGQ6Li9hcmNoL3h0ZW5zYS9rZXJuZWwvdm1saW51eC5sZHM6NDMwOiANCj4gc3ludGF4
IGVycm9yDQo+IC9ob21lL21pbmdvL3RpcC9NYWtlZmlsZToxMDEwOiByZWNpcGUgZm9yIHRhcmdl
dCAndm1saW51eCcgZmFpbGVkDQo+IG1ha2VbMV06ICoqKiBbdm1saW51eF0gRXJyb3IgMQ0KPiBt
YWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSAnL2Rldi9zaG0vdGlwL2J1aWxkJw0KPiBNYWtlZmls
ZToxNDY6IHJlY2lwZSBmb3IgdGFyZ2V0ICdzdWItbWFrZeKAmSBmYWlsZWQNCg0KVGhpcyBvbmUg
aXMgZHVlIHRvIGEgbWlzc2luZyAtRExJTktFUl9TQ1JJUFQgaW4gdGhlIE1ha2VmaWxlIG9mIHh0
ZW5zYS4gSeKAmWxsDQpzZW5kIHRoZSBwYXRjaCB0byBmaXggaXQgYWZ0ZXIgSSBkZWFsIHdpdGgg
dGhlIGJvb3QgZmFpbHVyZSAoZm9yIHdoaWNoIEkNCndhaXQgZm9yIHlvdXIgY29uZmlnIGZpbGUp
Lg0KDQpUaGFua3MsDQpOYWRhdg==
