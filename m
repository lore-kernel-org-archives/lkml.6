Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1FAC282DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE1A218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="bglA+m2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbfBAPC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:02:57 -0500
Received: from mail-eopbgr1410124.outbound.protection.outlook.com ([40.107.141.124]:61904
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726446AbfBAPC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVkEVZgzMCi6v7s17iyhH2kuQ9ix5EccPaX8cuLmf3g=;
 b=bglA+m2ebpcn7YPMr2madjBA9/uN4g/zxMhtm/fX0hQapG2kwRnHJric//hRH/YZif/jAakpHudd1HVRfap1IsnDrLkrDIjq1xOqEo9G1WdfxfH7lN620KHts6NroOmLOJt99crsl7VYfksAD1Uydk5+EfdUtd6u/km5d6JheUY=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.241.22) by
 OSBPR01MB3432.jpnprd01.prod.outlook.com (20.178.96.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Fri, 1 Feb 2019 15:02:49 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::9cb9:6c95:2d20:7852]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::9cb9:6c95:2d20:7852%2]) with mapi id 15.20.1558.026; Fri, 1 Feb 2019
 15:02:49 +0000
From:   Biju Das <biju.das@bp.renesas.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
CC:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3] PM-runtime: fix deadlock with ktime
Thread-Topic: [PATCH v3] PM-runtime: fix deadlock with ktime
Thread-Index: AQHUuMDySMSMVQqbW0iMWyMv4OqrSKXIWtMAgAKwb6A=
Date:   Fri, 1 Feb 2019 15:02:49 +0000
Message-ID: <OSBPR01MB210387DEC42870D8E5688CE9B8920@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <CAJZ5v0gunbCHp_9mDTmtwW1i-_GcXPcjTP48NdV2zv-B6UrD4g@mail.gmail.com>
 <1548869162-6223-1-git-send-email-vincent.guittot@linaro.org>
 <CAJZ5v0gnJ5DKvOO9OcJoMrGYpHfeQBt2Ec0pMW6=2q5aMoFpww@mail.gmail.com>
In-Reply-To: <CAJZ5v0gnJ5DKvOO9OcJoMrGYpHfeQBt2Ec0pMW6=2q5aMoFpww@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB3432;20:Aip9NjyVoU7OCxqPVXV4F3fQ1XbsG0tJyeIHAtQuGo6eVVIv5hRVCrNCowgV4U73V+ilhAWN8QrGRcR9P2TebT6XT7LZzbrJiOulk0PyKMB0VoeudWWmuwH/n4/lYBtrDic54k5r09ILPoqAg+vuZpjWMNvjypy3NFIx7gMMzNA=
x-ms-office365-filtering-correlation-id: cd513be2-c8ee-47e5-ff08-08d688565530
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB3432;
x-ms-traffictypediagnostic: OSBPR01MB3432:
x-microsoft-antispam-prvs: <OSBPR01MB34329074942CF9282E18D584B8920@OSBPR01MB3432.jpnprd01.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(366004)(136003)(199004)(189003)(13464003)(9686003)(110136005)(476003)(3846002)(54906003)(4326008)(305945005)(7736002)(316002)(44832011)(86362001)(25786009)(6116002)(6246003)(446003)(55016002)(11346002)(478600001)(8676002)(66066001)(53936002)(33656002)(81156014)(14454004)(81166006)(8936002)(2906002)(68736007)(26005)(229853002)(186003)(99286004)(102836004)(71200400001)(74316002)(71190400001)(97736004)(486006)(76176011)(7696005)(256004)(14444005)(6506007)(53546011)(6436002)(105586002)(106356001)(7416002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB3432;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qhjp/YfuiNia9F3oF1D9WqFyU1HZZGQAatIyygT7HkpvR4P9Xm5xrS9Ddrf6LFNgqxISzBfxs3CTblq1g1L+UZUTDv1Kg58ohi0JbG27jYxzYqaqc6a9KviCe4ytfxY8UuAQMSOfJJjbgTpT4saPuQ5iYdbEJ+8BGRrQPlUkF1MtWOl98dbe8JtyLF1vijfIpsDK47VbHK447cDOA8WJJIYMMIMRdzLxzVeI2byYl1aUutbBZcu133eIyn6MYI4RtYOZAKy8Bh6ejTSN9nrPMpotODY8sV1EWfN8RHEE76r0LM9Os4jMV5kJPTAdVSEeVZCkewUSrps8L1lkUJovYX3xTiYO6iYZU10JxfrX5XAGrZf7AZsTK6Dg+nXBd1o7gzzAhEPfNtKgiSCUcf1h4Hj0dQhlovPRwYKvvz4xi2E=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd513be2-c8ee-47e5-ff08-08d688565530
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 15:02:49.5311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3432
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmluY2VudCwNCg0KSSBoYXZlIHJlYmFzZWQgbXkga2VybmVsIHRvICJuZXh0LTIwMTkwMjAx
Ii4gIFN0aWxsIEkgYW0gc2VlaW5nIGRlYWQgbG9jay4NCg0KQW0gSSBtaXNzaW5nIGFueSBwYXRj
aD8NCg0Kcm9vdEBlazg3NDovIyBlY2hvIGU2MWUwMDAwLnRpbWVyID4gL3N5cy9kZXZpY2VzL3N5
c3RlbS9jbG9ja3NvdXJjZS9jbG9ja3NvdXJjZTAvY3VycmVudF9jbG9ja3NvdXJjZQ0KWyAgMTkz
Ljg2OTQyM10NClsgIDE5My44NzA5NjNdID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09DQpbICAxOTMuODc2MjkyXSBXQVJOSU5HOiBwb3NzaWJsZSByZWN1cnNpdmUg
bG9ja2luZyBkZXRlY3RlZA0KWyAgMTkzLjg4MTYyNV0gNS4wLjAtcmM0LW5leHQtMjAxOTAyMDEt
MDAwMDctZzczMTM0NmYgIzMgTm90IHRhaW50ZWQNClsgIDE5My44ODc3MzddIC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpbICAxOTMuODkzMDY2XSBtaWdyYXRp
b24vMC8xMSBpcyB0cnlpbmcgdG8gYWNxdWlyZSBsb2NrOg0KWyAgMTkzLjg5ODEzNl0gKF9fX19w
dHJ2YWxfX19fKSAodGtfY29yZS5zZXEpey0tLS19LCBhdDogdXBkYXRlX3BtX3J1bnRpbWVfYWNj
b3VudGluZysweDE0LzB4NjgNClsgIDE5My45MDY2MzJdDQpbICAxOTMuOTA2NjMyXSBidXQgdGFz
ayBpcyBhbHJlYWR5IGhvbGRpbmcgbG9jazoNClsgIDE5My45MTI0ODNdIChfX19fcHRydmFsX19f
XykgKHRrX2NvcmUuc2VxKXstLS0tfSwgYXQ6IG11bHRpX2NwdV9zdG9wKzB4OGMvMHgxNDANClsg
IDE5My45MTk4MjhdDQpbICAxOTMuOTE5ODI4XSBvdGhlciBpbmZvIHRoYXQgbWlnaHQgaGVscCB1
cyBkZWJ1ZyB0aGlzOg0KWyAgMTkzLjkyNjM3N10gIFBvc3NpYmxlIHVuc2FmZSBsb2NraW5nIHNj
ZW5hcmlvOg0KWyAgMTkzLjkyNjM3N10NClsgIDE5My45MzIzMTRdICAgICAgICBDUFUwDQpbICAx
OTMuOTM0NzY1XSAgICAgICAgLS0tLQ0KWyAgMTkzLjkzNzIxNl0gICBsb2NrKHRrX2NvcmUuc2Vx
KTsNClsgIDE5My45NDA0NTNdICAgbG9jayh0a19jb3JlLnNlcSk7DQpbICAxOTMuOTQzNjkxXQ0K
WyAgMTkzLjk0MzY5MV0gICoqKiBERUFETE9DSyAqKioNClsgIDE5My45NDM2OTFdDQpbICAxOTMu
OTQ5NjM0XSAgTWF5IGJlIGR1ZSB0byBtaXNzaW5nIGxvY2sgbmVzdGluZyBub3RhdGlvbg0KWyAg
MTkzLjk0OTYzNF0NClsgIDE5My45NTY0NDZdIDMgbG9ja3MgaGVsZCBieSBtaWdyYXRpb24vMC8x
MToNClsgIDE5My45NjA2NDJdICAjMDogKF9fX19wdHJ2YWxfX19fKSAodGltZWtlZXBlcl9sb2Nr
KXstLi0ufSwgYXQ6IGNoYW5nZV9jbG9ja3NvdXJjZSsweDJjLzB4MTE4DQpbICAxOTMuOTY5MTI1
XSAgIzE6IChfX19fcHRydmFsX19fXykgKHRrX2NvcmUuc2VxKXstLS0tfSwgYXQ6IG11bHRpX2Nw
dV9zdG9wKzB4OGMvMHgxNDANClsgIDE5My45NzY5MDNdICAjMjogKF9fX19wdHJ2YWxfX19fKSAo
JigmZGV2LT5wb3dlci5sb2NrKS0+cmxvY2spey4uLi59LCBhdDogX19wbV9ydW50aW1lX3Jlc3Vt
ZSsweDQwLzB4OTgNClsgIDE5My45ODYzMzldDQpbICAxOTMuOTg2MzM5XSBzdGFjayBiYWNrdHJh
Y2U6DQpbICAxOTMuOTkwNzE1XSBDUFU6IDAgUElEOiAxMSBDb21tOiBtaWdyYXRpb24vMCBOb3Qg
dGFpbnRlZCA1LjAuMC1yYzQtbmV4dC0yMDE5MDIwMS0wMDAwNy1nNzMxMzQ2ZiAjMw0KWyAgMTkz
Ljk5OTcwN10gSGFyZHdhcmUgbmFtZTogU2lsaWNvbiBMaW51eCBSWi9HMkUgZXZhbHVhdGlvbiBr
aXQgRUs4NzQgKENBVDg3NCArIENBVDg3NSkgKERUKQ0KWyAgMTk0LjAwODA4OV0gQ2FsbCB0cmFj
ZToNClsgIDE5NC4wMTA1NTNdICBkdW1wX2JhY2t0cmFjZSsweDAvMHgxNzgNClsgIDE5NC4wMTQy
MjddICBzaG93X3N0YWNrKzB4MTQvMHgyMA0KWyAgMTk0LjAxNzU2Ml0gIGR1bXBfc3RhY2srMHhi
MC8weGVjDQpbICAxOTQuMDIwODk1XSAgX19sb2NrX2FjcXVpcmUrMHhmYjQvMHgxYzA4DQpbICAx
OTQuMDI0ODMyXSAgbG9ja19hY3F1aXJlKzB4ZDAvMHgyNjgNClsgIDE5NC4wMjg0MjBdICBrdGlt
ZV9nZXQrMHg1Yy8weDEwOA0KWyAgMTk0LjAzMTc0N10gIHVwZGF0ZV9wbV9ydW50aW1lX2FjY291
bnRpbmcrMHgxNC8weDY4DQpbICAxOTQuMDM2NjQzXSAgcnBtX3Jlc3VtZSsweDRlYy8weDY5OA0K
WyAgMTk0LjA0MDE0NF0gIF9fcG1fcnVudGltZV9yZXN1bWUrMHg1MC8weDk4DQpbICAxOTQuMDQ0
MjY0XSAgc2hfdG11X2VuYWJsZS5wYXJ0LjErMHgyNC8weDUwDQpbICAxOTQuMDQ4NDYyXSAgc2hf
dG11X2Nsb2Nrc291cmNlX2VuYWJsZSsweDQ4LzB4NzANClsgIDE5NC4wNTMwOTddICBjaGFuZ2Vf
Y2xvY2tzb3VyY2UrMHg4NC8weDExOA0KWyAgMTk0LjA1NzIwOF0gIG11bHRpX2NwdV9zdG9wKzB4
OGMvMHgxNDANClsgIDE5NC4wNjA5NzBdICBjcHVfc3RvcHBlcl90aHJlYWQrMHhhYy8weDEyMA0K
WyAgMTk0LjA2NTA4N10gIHNtcGJvb3RfdGhyZWFkX2ZuKzB4MWFjLzB4MmM4DQpbICAxOTQuMDY5
MTk4XSAga3RocmVhZCsweDEyOC8weDEzMA0KWyAgMTk0LjA3MjQzOV0gIHJldF9mcm9tX2Zvcmsr
MHgxMC8weDE4DQoNCg0KUmVnYXJkcywNCkJpanUNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+IFNl
bnQ6IDMwIEphbnVhcnkgMjAxOSAyMTo1Mw0KPiBUbzogVmluY2VudCBHdWl0dG90IDx2aW5jZW50
Lmd1aXR0b3RAbGluYXJvLm9yZz4NCj4gQ2M6IExpbnV4IFBNIDxsaW51eC1wbUB2Z2VyLmtlcm5l
bC5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC0NCj4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZz47IExpbnV4IEFSTSA8bGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZz47IExpbnV4IE9NQVAgTWFpbGluZyBMaXN0IDxsaW51eC0NCj4gb21hcEB2Z2VyLmtl
cm5lbC5vcmc+OyBSYWZhZWwgSi4gV3lzb2NraSA8cmp3QHJqd3lzb2NraS5uZXQ+OyBVbGYNCj4g
SGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz47IEJpanUgRGFzIDxiaWp1LmRhc0BicC5y
ZW5lc2FzLmNvbT47DQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+
OyBMaW51eC1SZW5lc2FzIDxsaW51eC0NCj4gcmVuZXNhcy1zb2NAdmdlci5rZXJuZWwub3JnPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzXSBQTS1ydW50aW1lOiBmaXggZGVhZGxvY2sgd2l0aCBr
dGltZQ0KPg0KPiBPbiBXZWQsIEphbiAzMCwgMjAxOSBhdCA2OjI2IFBNIFZpbmNlbnQgR3VpdHRv
dA0KPiA8dmluY2VudC5ndWl0dG90QGxpbmFyby5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gQSBkZWFk
bG9jayBoYXMgYmVlbiBzZWVuIHdoZW4gc3dpY3RoaW5nIGNsb2Nrc291cmNlcyB3aGljaCB1c2Ug
UE0NCj4gcnVudGltZS4NCj4gPiBUaGUgY2FsbCBwYXRoIGlzOg0KPiA+IGNoYW5nZV9jbG9ja3Nv
dXJjZQ0KPiA+ICAgICAuLi4NCj4gPiAgICAgd3JpdGVfc2VxY291bnRfYmVnaW4NCj4gPiAgICAg
Li4uDQo+ID4gICAgIHRpbWVrZWVwaW5nX3VwZGF0ZQ0KPiA+ICAgICAgICAgLi4uDQo+ID4gICAg
ICAgICBzaF9jbXRfY2xvY2tzb3VyY2VfZW5hYmxlDQo+ID4gICAgICAgICAgICAgLi4uDQo+ID4g
ICAgICAgICAgICAgcnBtX3Jlc3VtZQ0KPiA+ICAgICAgICAgICAgICAgICBwbV9ydW50aW1lX21h
cmtfbGFzdF9idXN5DQo+ID4gICAgICAgICAgICAgICAgICAgICBrdGltZV9nZXQNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICBkbw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBy
ZWFkX3NlcWNvdW50X2JlZ2luDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgd2hpbGUgcmVh
ZF9zZXFjb3VudF9yZXRyeQ0KPiA+ICAgICAuLi4uDQo+ID4gICAgIHdyaXRlX3NlcWNvdW50X2Vu
ZA0KPiA+DQo+ID4gQWx0aG91Z2ggd2Ugc2hvdWxkIGJlIHNhZmUgYmVjYXVzZSB3ZSBoYXZlbid0
IHlldCBjaGFuZ2VkIHRoZQ0KPiA+IGNsb2Nrc291cmNlIGF0IHRoYXQgdGltZSwgd2UgY2FuJ3Qg
YmVjYXVzZSBvZiBzZXFjb3VudCBwcm90ZWN0aW9uLg0KPiA+DQo+ID4gVXNlIGt0aW1lX2dldF9t
b25vX2Zhc3RfbnMoKSBpbnN0ZWFkIHdoaWNoIGlzIGxvY2sgc2FmZSBmb3Igc3VjaCBjYXNlDQo+
ID4NCj4gPiBXaXRoIGt0aW1lX2dldF9tb25vX2Zhc3RfbnMsIHRoZSB0aW1lc3RhbXAgaXMgbm90
IGd1YXJhbnRlZWQgdG8gYmUNCj4gPiBtb25vdG9uaWMgYWNyb3NzIGFuIHVwZGF0ZSBhbmQgYXMg
YSByZXN1bHQgY2FuIGdvZXMgYmFja3dhcmQuDQo+ID4gQWNjb3JkaW5nIHRvDQo+ID4gdXBkYXRl
X2Zhc3RfdGltZWtlZXBlcigpIGRlc2NyaXB0aW9uOiAiSW4gdGhlIHdvcnN0IGNhc2UsIHRoaXMg
Y2FuDQo+ID4gcmVzdWx0IGlzIGEgc2xpZ2h0bHkgd3JvbmcgdGltZXN0YW1wIChhIGZldyBuYW5v
c2Vjb25kcykiLiBGb3IgUE0NCj4gPiBydW50aW1lIGF1dG9zdXNwZW5kLCB0aGlzIG1lYW5zIG9u
bHkgdGhhdCB0aGUgc3VzcGVuZCBkZWNpc2lvbiBjYW4gYmUNCj4gPiBzbGlnaHRseSBzdWIgb3B0
aW1hbC4NCj4gPg0KPiA+IEZpeGVzOiA4MjM0ZjY3MzRjNWQgKCJQTS1ydW50aW1lOiBTd2l0Y2gg
YXV0b3N1c3BlbmQgb3ZlciB0byB1c2luZw0KPiA+IGhydGltZXJzIikNCj4gPiBSZXBvcnRlZC1i
eTogQmlqdSBEYXMgPGJpanUuZGFzQGJwLnJlbmVzYXMuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFZpbmNlbnQgR3VpdHRvdCA8dmluY2VudC5ndWl0dG90QGxpbmFyby5vcmc+DQo+ID4gLS0tDQo+
ID4NCj4gPiBIaSBSYWZhZWwsDQo+ID4NCj4gPiBTb3JyeSwgSSBzZW50IHRoZSB2ZXJzaW9uIHdp
dGggdGhlIHR5cG8gbWlzdGFrZSB0aGF0IGdlbmVyYXRlZCB0aGUNCj4gPiBjb21waWxhdGlvbiBl
cnJvciByZXBvcnRlZCBieSBrYnVpbGQtdGVzdC1yb2JvdA0KPiA+DQo+ID4gVGhpcyB2ZXJzaW9u
IGRvZXNuJ3QgaGF2ZSB0aGUgdHlwby4NCj4NCj4gT0ssIEkndmUgYXBwbGllZCB0aGlzIG9uZSwg
dGhhbmtzIQ0KDQoNCg0KUmVuZXNhcyBFbGVjdHJvbmljcyBFdXJvcGUgTHRkLCBEdWtlcyBNZWFk
b3csIE1pbGxib2FyZCBSb2FkLCBCb3VybmUgRW5kLCBCdWNraW5naGFtc2hpcmUsIFNMOCA1Rkgs
IFVLLiBSZWdpc3RlcmVkIGluIEVuZ2xhbmQgJiBXYWxlcyB1bmRlciBSZWdpc3RlcmVkIE5vLiAw
NDU4NjcwOS4NCg==
