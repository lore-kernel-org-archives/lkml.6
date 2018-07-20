Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8EBECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AC420652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="WPLIUcjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02AC420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbeGTMyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 08:54:52 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:50867 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727518AbeGTMyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 08:54:51 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie2.idc.renesas.com with ESMTP; 20 Jul 2018 21:06:53 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id 1593080B04;
        Fri, 20 Jul 2018 21:06:53 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,378,1526310000"; 
   d="scan'208";a="285919332"
Received: from mail-ty1jpn01lp0177.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.177])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2018 21:06:52 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAPpZfFUjmK1plZk/Mmow/6bk+C/OfW00pvepcPTfgU=;
 b=WPLIUcjyqGhV/+CViHTVSCph6JIotLf3ar7+EvoOS/FIQyM54wg1HyHpiCvMDK7J0qDVsnklZX3Jo3/Vt2farZpxk9aY9GJYJ6Yn/sHiqG6ZsYaEF++aX+Igmpm4z36AqbrrqAjnetlTP0VwfJCyjmczKVmKX4ogEhYmn6M3seA=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1561.jpnprd01.prod.outlook.com (52.133.162.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.20; Fri, 20 Jul 2018 12:06:49 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::3133:4289:d2fa:48f8]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::3133:4289:d2fa:48f8%3]) with mapi id 15.20.0973.018; Fri, 20 Jul 2018
 12:06:49 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Simon Horman <horms@verge.net.au>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] clk: renesas: r9a06g032: Avoid needless probe deferring
Thread-Topic: [PATCH] clk: renesas: r9a06g032: Avoid needless probe deferring
Thread-Index: AQHUHqR4ngr277zL6E6HaJ4wGORD/aSX+jGAgAABQRA=
Date:   Fri, 20 Jul 2018 12:06:48 +0000
Message-ID: <TY1PR01MB1769588F9C53755C0FD56D98F5510@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1531924476-23261-1-git-send-email-phil.edworthy@renesas.com>
 <CAMuHMdVEgj7kJFxNuR8w468FoGRaP_mEDv6JqB_7deuQjsed_Q@mail.gmail.com>
In-Reply-To: <CAMuHMdVEgj7kJFxNuR8w468FoGRaP_mEDv6JqB_7deuQjsed_Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1561;7:012sQnFVca7KB0W7SjwYzsvC6TyetuJds/8/INuaNcTAcizERIgIHj22PeSGyTctDiMN44HlnYapy6+8M56+jNo2Elpqsi/ruJsnyPG5k2i8Woi2dxtjZEKp1dI67Cpq99dc+T953j92cmjTLF92+IqsQTjWnoU5tTHnp8X+vT+ErcTBhMFI3aEOrSnPGuMhVyKc6SGrmI5tVxbv6MYt7fPU84TtoqcysnXZ29HMsCy4zaEP7+rYsofeZ5W2vDzR;20:WyqH5dzdpSjypb+kgTJgii1BJWDXTKU9r/gK/49pY+rcP9M23QBSzdaePZUoswPd1YtHOZ7WEbvYKy7dA/ym0UtWzRjvQ5WuTKDY7jJhy89CRLpmp20FPVpFokAFhmklaSxBM1qL7rtKvo6JDR2k6J5anIPysWDHEyAN4Wsgq6c=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1587805c-390e-42a0-2e7b-08d5ee394597
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1561;
x-ms-traffictypediagnostic: TY1PR01MB1561:
x-microsoft-antispam-prvs: <TY1PR01MB156169699101E5C902EF5419F5510@TY1PR01MB1561.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB1561;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1561;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(376002)(136003)(39860400002)(199004)(189003)(7736002)(53936002)(105586002)(6246003)(316002)(3846002)(14454004)(106356001)(6116002)(8676002)(25786009)(4326008)(81166006)(81156014)(8936002)(97736004)(68736007)(305945005)(102836004)(26005)(256004)(6506007)(7696005)(76176011)(53546011)(74316002)(186003)(86362001)(14444005)(33656002)(9686003)(44832011)(229853002)(55016002)(476003)(2906002)(5660300001)(5250100002)(66066001)(478600001)(6916009)(99286004)(54906003)(2900100001)(486006)(6436002)(446003)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1561;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oPhnw9m3iklahJB3l/iRua1iOkTjUFioefMrMmvqu7H0qM/YOxnYR86tjADr7ts18VDrp7XtGATW9iA1ETIvXtvKIBFuZWy/Fj3sDG018saAEr9fSG9yCYub6ywW4HQoChJl2t6QYwZywjP1RwE/LyNwas8sB5N43Qr6mDUjH1q+PjyPG0irVVJBXZkIiDqdkwackdWzsEnsSWbJxBFQxXq5Xuhodyofv0uwhQLB4oEEabrRw8CEfOq7WF2K2R+ZG89OZgZcZlB/xkfH4Tl+V0aN8SW4hf5Mej9QGKmAfSTZmB8dBNMFC/bKjzbCCNvYpqYsDv4sk6dBr/1/oY2vvqWZAK95Q0pUFZE7kqMH6RU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1587805c-390e-42a0-2e7b-08d5ee394597
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 12:06:48.8375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1561
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIDIwIEp1bHkgMjAxOCAxMjoyMSwgR2VlcnQgVXl0dGVyaG9ldmVuIHdy
b3RlOg0KPiBPbiBXZWQsIEp1bCAxOCwgMjAxOCBhdCA0OjM0IFBNIFBoaWwgRWR3b3J0aHkgd3Jv
dGU6DQo+ID4gVG8gYXZvaWQgYWxsIFNvQyBwZXJpcGhlcmFsIGRyaXZlcnMgZGVmZXJyaW5nIHRo
ZWlyIHByb2JlcywgYm90aCBjbG9jaw0KPiA+IGFuZCBwaW5jdHJsIGRyaXZlcnMgc2hvdWxkIGFs
cmVhZHkgYmUgcHJvYmVkLiBTaW5jZSB0aGUgcGluY3RybCBkcml2ZXINCj4gPiByZXF1aXJlcyBh
IGNsb2NrIHRvIGFjY2VzcyB0aGUgcmVnaXN0ZXJzLCB0aGUgY2xvY2sgZHJpdmVyIHNob3VsZCBi
ZQ0KPiA+IHByb2JlZCBiZWZvcmUgdGhlIHBpbmN0cmwgZHJpdmVyLg0KPiA+DQo+ID4gVGhlcmVm
b3JlLCBtb3ZlIHRoZSBjbG9jayBkcml2ZXIgZnJvbSBzdWJzeXNfaW5pdGNhbGwgdG8gY29yZV9p
bml0Y2FsbC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBoaWwgRWR3b3J0aHkgPHBoaWwuZWR3
b3J0aHlAcmVuZXNhcy5jb20+DQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQpUaGFua3Mg
Zm9yIHlvdXIgcmV2aWV3IQ0KDQo+IFRoZSAobm90IHlldCB1cHN0cmVhbWVkKSBwaW5jdHJsIGRy
aXZlciB1c2VzIHBvc3Rjb3JlX2luaXRjYWxsKCksIHJpZ2h0Pw0KTm8sIHRoZSBwaW5jdHJsIGRy
aXZlciB1c2VzIHN1YnN5c19pbml0Y2FsbCwgYnV0IHBvc3Rjb3JlX2luaXRjYWxsIG9yIA0KYXJj
aF9pbml0Y2FsbCBtYXkgYmUgYmV0dGVyIHRvIG1ha2UgaXQgY2xlYXIgYWJvdXQgdGhlIGRlcGVu
ZGVuY2llcy4NCg0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL3JlbmVzYXMvcjlhMDZnMDMyLWNsb2Nr
cy5jDQo+ID4gKysrIGIvZHJpdmVycy9jbGsvcmVuZXNhcy9yOWEwNmcwMzItY2xvY2tzLmMNCj4g
PiBAQCAtODc3LDE3ICs4NzcsMTggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQN
Cj4gcjlhMDZnMDMyX21hdGNoW10gPSB7DQo+ID4gICAgICAgICB7IH0NCj4gPiAgfTsNCj4gPg0K
PiA+IC1zdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciByOWEwNmcwMzJfY2xvY2tfZHJpdmVy
ID0gew0KPiA+ICtzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciByOWEwNmcwMzJfY2xvY2tf
ZHJpdmVyIF9fcmVmZGF0YSA9IHsNCj4gPiAgICAgICAgIC5kcml2ZXIgICAgICAgICA9IHsNCj4g
PiAgICAgICAgICAgICAgICAgLm5hbWUgICA9ICJyZW5lc2FzLHI5YTA2ZzAzMi1zeXNjdHJsIiwN
Cj4gPiAgICAgICAgICAgICAgICAgLm9mX21hdGNoX3RhYmxlID0gcjlhMDZnMDMyX21hdGNoLA0K
PiA+ICAgICAgICAgfSwNCj4gPiArICAgICAgIC5wcm9iZSA9IHI5YTA2ZzAzMl9jbG9ja3NfcHJv
YmUsDQo+ID4gIH07DQo+ID4NCj4gPiAgc3RhdGljIGludCBfX2luaXQgcjlhMDZnMDMyX2Nsb2Nr
c19pbml0KHZvaWQpICB7DQo+ID4gLSAgICAgICByZXR1cm4gcGxhdGZvcm1fZHJpdmVyX3Byb2Jl
KCZyOWEwNmcwMzJfY2xvY2tfZHJpdmVyLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHI5
YTA2ZzAzMl9jbG9ja3NfcHJvYmUpOw0KPiA+ICsgICAgICAgcGxhdGZvcm1fZHJpdmVyX3JlZ2lz
dGVyKCZyOWEwNmcwMzJfY2xvY2tfZHJpdmVyKTsNCj4gPiArICAgICAgIHJldHVybiAwOw0KVGhh
dCBzaG91bGQgYmU6DQorICAgICAgIHJldHVybiBwbGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIoJnI5
YTA2ZzAzMl9jbG9ja19kcml2ZXIpOw0KDQo+ID4gIH0NCj4gDQo+IFdoeSBhcmUgYWxsIG9mIHRo
ZSBhYm92ZSBjaGFuZ2VzIG5lZWRlZD8NCj4gU2hvdWxkbid0IHRoZSBwbGF0Zm9ybV9kcml2ZXJf
cHJvYmUoKSBrZWVwIG9uIHdvcmtpbmc/DQo+IElmIGl0IGRvZXMgbm90LCBpdCBtZWFucyB0aGUg
Y2xvY2sgZHJpdmVyIGhhcyBzb21lIG90aGVyIGRlcGVuZGVuY3ksIGFuZA0KPiBjYW5ub3QgYmUg
Ym91bmQgaW1tZWRpYXRlbHkuICBUaGlzIGlzIHBvdGVudGlhbGx5IGEgZGFuZ2Vyb3VzIHNpdHVh
dGlvbiwgYXMNCj4gcjlhMDZnMDMyX2Nsb2Nrc19wcm9iZSgpIGlzIF9faW5pdCwgYnV0IGNhbiBz
dGlsbCBiZSBjYWxsZWQgYXQgYW55IHRpbWUgbGF0ZXIuDQo+IEhlbmNlIHVzaW5nIHBsYXRmb3Jt
X2RyaXZlcl9wcm9iZSgpIGlzIHRoZSBzYWZlIHRoaW5nIHRvIGRvLCBwb3NzaWJseSB3aXRoIGEN
Cj4gZGlmZmVyZW50IHJlc2h1ZmZsaW5nIG9mIHRoZSBjbG9jayBhbmQgcGluY3RybCBpbml0Y2Fs
bCBwcmlvcml0aWVzLg0KTm8sIHlvdSBjYW5ub3QgY2FsbCBwbGF0Zm9ybV9kcml2ZXJfcHJvYmUo
KSBmcm9tIGNvcmVfaW5pdGNhbGwuDQpBbGwgZHJpdmVycyB0aGF0IGFyZSBpbiBjb3JlX2luaXRj
YWxsIGNhbGwgcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCkuDQoNClRoYW5rcw0KUGhpbA0KDQo+
ID4gLXN1YnN5c19pbml0Y2FsbChyOWEwNmcwMzJfY2xvY2tzX2luaXQpOw0KPiA+ICtjb3JlX2lu
aXRjYWxsKHI5YTA2ZzAzMl9jbG9ja3NfaW5pdCk7DQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywN
Cj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBV
eXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0
QGxpbnV4LQ0KPiBtNjhrLm9yZw0KPiANCj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRo
IHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dA0KPiB3aGVuIEkn
bSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0
aGluZyBsaWtlIHRoYXQuDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGlu
dXMgVG9ydmFsZHMNCg==
