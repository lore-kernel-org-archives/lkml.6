Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E28ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA7A206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="pU2t+RaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA7A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731792AbeGTNOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:14:05 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:31336 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731745AbeGTNOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:14:04 -0400
Received: from unknown (HELO relmlir2.idc.renesas.com) ([10.200.68.152])
  by relmlie3.idc.renesas.com with ESMTP; 20 Jul 2018 21:26:02 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir2.idc.renesas.com (Postfix) with ESMTP id 85C518E3A6;
        Fri, 20 Jul 2018 21:26:02 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,378,1526310000"; 
   d="scan'208";a="287430039"
Received: from mail-ty1jpn01lp0183.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.183])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2018 21:26:02 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdcITDNq9ENaSLvVN8G4/0vrP1cW1l0Sn744gXv5qfI=;
 b=pU2t+RaMvhaSEanFlW+OzV8GzBCHRlanMfVcpLFVxnDlVkr7gq6V8K6KkNUyq3CuWC4n+oWgeWmLV+Z+ZRJTK/lNwiv+HH8QtN7ee/DkNAGeFU1YYuGvLwdDhPK3qnJ9qI5Z0g2Zx5VqVi3Fgi4PwONpB0glp8zUT6saJUodMaQ=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1753.jpnprd01.prod.outlook.com (52.133.163.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Fri, 20 Jul 2018 12:26:00 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::3133:4289:d2fa:48f8]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::3133:4289:d2fa:48f8%3]) with mapi id 15.20.0973.018; Fri, 20 Jul 2018
 12:26:00 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Simon Horman <horms@verge.net.au>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] clk: renesas: r9a06g032: Avoid needless probe deferring
Thread-Topic: [PATCH] clk: renesas: r9a06g032: Avoid needless probe deferring
Thread-Index: AQHUHqR4ngr277zL6E6HaJ4wGORD/aSX+jGAgAABQRCAAA0ggIAAAshQ
Date:   Fri, 20 Jul 2018 12:26:00 +0000
Message-ID: <TY1PR01MB17697FBCBDC6296E7B2589C9F5510@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1531924476-23261-1-git-send-email-phil.edworthy@renesas.com>
 <CAMuHMdVEgj7kJFxNuR8w468FoGRaP_mEDv6JqB_7deuQjsed_Q@mail.gmail.com>
 <TY1PR01MB1769588F9C53755C0FD56D98F5510@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <CAMuHMdWqdg9KV4h_U-VZGVdOL6upUpDgqO7kwQh8tFQjDFh-Ug@mail.gmail.com>
In-Reply-To: <CAMuHMdWqdg9KV4h_U-VZGVdOL6upUpDgqO7kwQh8tFQjDFh-Ug@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1753;20:h25WYw2ksRbudCfuXf4pE1QeWEfPAjCPjGvfQKPz6vOlN+5KD4mz4QqhmZEZtaVOblAnuXwLw+w979nL4CVwLKYyPmZDOdUboDYJDZzkwnjVCSnFOC0w9/52STibXZ8Dq8hKTPkug/djnlwWg+uI4qGk7rE3d1wvJigctU5U1mg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d277fa55-e77d-4211-3842-08d5ee3bf3e8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1753;
x-ms-traffictypediagnostic: TY1PR01MB1753:
x-microsoft-antispam-prvs: <TY1PR01MB1753748014C1ABD1DA9E39CCF5510@TY1PR01MB1753.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB1753;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1753;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39860400002)(136003)(199004)(189003)(2906002)(26005)(5660300001)(186003)(7696005)(305945005)(105586002)(53936002)(6916009)(68736007)(106356001)(44832011)(93886005)(66066001)(86362001)(102836004)(6436002)(229853002)(316002)(14444005)(486006)(256004)(5250100002)(54906003)(53546011)(6506007)(76176011)(11346002)(9686003)(3846002)(2900100001)(14454004)(6116002)(99286004)(55016002)(446003)(476003)(4326008)(25786009)(97736004)(33656002)(7736002)(6246003)(8676002)(8936002)(81156014)(81166006)(478600001)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1753;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: obpyETKDTnDDi8rYhms0YzbsiLPG3ItYd1unBOjcZJ5pGgylvPqoCpmjt77EmKFsPaA/cjg6MKqd5zYAeM+D7n7yksh8qeLhBgQlZm0rcVdBtdhgSI7mToyJ0L0SZ5TSx4yk49M39shB+qA/dNoiWsuLp7nlyEoZe3TgcIJyHykcBKvy/vECLID1sfMR8+lTWnNpAkhfQlukXktMGp0hp7GyqmtqzePd5D9+mFuKYJWHSDjwGZpREurqDBciyFYU7lxyc4tNgwybaCV+L5/rjr5j4EuLlEXk+7zyJZ+IRYf87o9zPAET2WGDoqKJoeGtJR20I7ku3+fSQ9p7RT0dYf2pDVBBNblBqi5XHmOWnHQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d277fa55-e77d-4211-3842-08d5ee3bf3e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 12:26:00.3481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1753
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCk9uIDIwIEp1bHkgMjAxOCAxMzoxMiwgR2VlcnQgVXl0dGVyaG9ldmVuIHdy
b3RlOg0KPiBPbiBGcmksIEp1bCAyMCwgMjAxOCBhdCAyOjA2IFBNIFBoaWwgRWR3b3J0aHkgIHdy
b3RlOg0KPiA+IE9uIDIwIEp1bHkgMjAxOCAxMjoyMSwgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3Rl
Og0KPiA+ID4gT24gV2VkLCBKdWwgMTgsIDIwMTggYXQgNDozNCBQTSBQaGlsIEVkd29ydGh5IHdy
b3RlOg0KPiA+ID4gPiBUbyBhdm9pZCBhbGwgU29DIHBlcmlwaGVyYWwgZHJpdmVycyBkZWZlcnJp
bmcgdGhlaXIgcHJvYmVzLCBib3RoDQo+ID4gPiA+IGNsb2NrIGFuZCBwaW5jdHJsIGRyaXZlcnMg
c2hvdWxkIGFscmVhZHkgYmUgcHJvYmVkLiBTaW5jZSB0aGUNCj4gPiA+ID4gcGluY3RybCBkcml2
ZXIgcmVxdWlyZXMgYSBjbG9jayB0byBhY2Nlc3MgdGhlIHJlZ2lzdGVycywgdGhlIGNsb2NrDQo+
ID4gPiA+IGRyaXZlciBzaG91bGQgYmUgcHJvYmVkIGJlZm9yZSB0aGUgcGluY3RybCBkcml2ZXIu
DQo+ID4gPiA+DQo+ID4gPiA+IFRoZXJlZm9yZSwgbW92ZSB0aGUgY2xvY2sgZHJpdmVyIGZyb20g
c3Vic3lzX2luaXRjYWxsIHRvIGNvcmVfaW5pdGNhbGwuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25l
ZC1vZmYtYnk6IFBoaWwgRWR3b3J0aHkgPHBoaWwuZWR3b3J0aHlAcmVuZXNhcy5jb20+DQo+ID4g
Pg0KPiA+ID4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiA+IFRoYW5rcyBmb3IgeW91ciByZXZp
ZXchDQo+ID4NCj4gPiA+IFRoZSAobm90IHlldCB1cHN0cmVhbWVkKSBwaW5jdHJsIGRyaXZlciB1
c2VzIHBvc3Rjb3JlX2luaXRjYWxsKCksIHJpZ2h0Pw0KPiA+IE5vLCB0aGUgcGluY3RybCBkcml2
ZXIgdXNlcyBzdWJzeXNfaW5pdGNhbGwsIGJ1dCBwb3N0Y29yZV9pbml0Y2FsbCBvcg0KPiA+IGFy
Y2hfaW5pdGNhbGwgbWF5IGJlIGJldHRlciB0byBtYWtlIGl0IGNsZWFyIGFib3V0IHRoZSBkZXBl
bmRlbmNpZXMuDQo+IA0KPiBpZiB0aGUgcGluY3RybCBkcml2ZXIgdXNlcyBzdWJzeXNfaW5pdGNh
bGwoKSwgLi4uDQo+IA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2Nsay9yZW5lc2FzL3I5YTA2ZzAz
Mi1jbG9ja3MuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL2Nsay9yZW5lc2FzL3I5YTA2ZzAzMi1j
bG9ja3MuYw0KPiA+ID4gPiBAQCAtODc3LDE3ICs4NzcsMTggQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBvZl9kZXZpY2VfaWQNCj4gPiA+IHI5YTA2ZzAzMl9tYXRjaFtdID0gew0KPiA+ID4gPiAgICAg
ICAgIHsgfQ0KPiA+ID4gPiAgfTsNCj4gPiA+ID4NCj4gPiA+ID4gLXN0YXRpYyBzdHJ1Y3QgcGxh
dGZvcm1fZHJpdmVyIHI5YTA2ZzAzMl9jbG9ja19kcml2ZXIgPSB7DQo+ID4gPiA+ICtzdGF0aWMg
c3RydWN0IHBsYXRmb3JtX2RyaXZlciByOWEwNmcwMzJfY2xvY2tfZHJpdmVyIF9fcmVmZGF0YSA9
DQo+ID4gPiA+ICt7DQo+ID4gPiA+ICAgICAgICAgLmRyaXZlciAgICAgICAgID0gew0KPiA+ID4g
PiAgICAgICAgICAgICAgICAgLm5hbWUgICA9ICJyZW5lc2FzLHI5YTA2ZzAzMi1zeXNjdHJsIiwN
Cj4gPiA+ID4gICAgICAgICAgICAgICAgIC5vZl9tYXRjaF90YWJsZSA9IHI5YTA2ZzAzMl9tYXRj
aCwNCj4gPiA+ID4gICAgICAgICB9LA0KPiA+ID4gPiArICAgICAgIC5wcm9iZSA9IHI5YTA2ZzAz
Ml9jbG9ja3NfcHJvYmUsDQo+ID4gPiA+ICB9Ow0KPiA+ID4gPg0KPiA+ID4gPiAgc3RhdGljIGlu
dCBfX2luaXQgcjlhMDZnMDMyX2Nsb2Nrc19pbml0KHZvaWQpICB7DQo+ID4gPiA+IC0gICAgICAg
cmV0dXJuIHBsYXRmb3JtX2RyaXZlcl9wcm9iZSgmcjlhMDZnMDMyX2Nsb2NrX2RyaXZlciwNCj4g
PiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgcjlhMDZnMDMyX2Nsb2Nrc19wcm9iZSk7DQo+
ID4gPiA+ICsgICAgICAgcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZyOWEwNmcwMzJfY2xvY2tf
ZHJpdmVyKTsNCj4gPiA+ID4gKyAgICAgICByZXR1cm4gMDsNCj4gPiBUaGF0IHNob3VsZCBiZToN
Cj4gPiArICAgICAgIHJldHVybiBwbGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIoJnI5YTA2ZzAzMl9j
bG9ja19kcml2ZXIpOw0KPiA+DQo+ID4gPiA+ICB9DQo+ID4gPg0KPiA+ID4gV2h5IGFyZSBhbGwg
b2YgdGhlIGFib3ZlIGNoYW5nZXMgbmVlZGVkPw0KPiA+ID4gU2hvdWxkbid0IHRoZSBwbGF0Zm9y
bV9kcml2ZXJfcHJvYmUoKSBrZWVwIG9uIHdvcmtpbmc/DQo+ID4gPiBJZiBpdCBkb2VzIG5vdCwg
aXQgbWVhbnMgdGhlIGNsb2NrIGRyaXZlciBoYXMgc29tZSBvdGhlciBkZXBlbmRlbmN5LA0KPiA+
ID4gYW5kIGNhbm5vdCBiZSBib3VuZCBpbW1lZGlhdGVseS4gIFRoaXMgaXMgcG90ZW50aWFsbHkg
YSBkYW5nZXJvdXMNCj4gPiA+IHNpdHVhdGlvbiwgYXMNCj4gPiA+IHI5YTA2ZzAzMl9jbG9ja3Nf
cHJvYmUoKSBpcyBfX2luaXQsIGJ1dCBjYW4gc3RpbGwgYmUgY2FsbGVkIGF0IGFueSB0aW1lIGxh
dGVyLg0KPiA+ID4gSGVuY2UgdXNpbmcgcGxhdGZvcm1fZHJpdmVyX3Byb2JlKCkgaXMgdGhlIHNh
ZmUgdGhpbmcgdG8gZG8sDQo+ID4gPiBwb3NzaWJseSB3aXRoIGEgZGlmZmVyZW50IHJlc2h1ZmZs
aW5nIG9mIHRoZSBjbG9jayBhbmQgcGluY3RybCBpbml0Y2FsbA0KPiBwcmlvcml0aWVzLg0KPiA+
IE5vLCB5b3UgY2Fubm90IGNhbGwgcGxhdGZvcm1fZHJpdmVyX3Byb2JlKCkgZnJvbSBjb3JlX2lu
aXRjYWxsLg0KPiA+IEFsbCBkcml2ZXJzIHRoYXQgYXJlIGluIGNvcmVfaW5pdGNhbGwgY2FsbCBw
bGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIoKS4NCj4gDQo+IEhlbmNlIHRoZXkgY2Fubm90IGhhdmUg
dGhlaXIgcHJvYmUgZnVuY3Rpb24gX19pbml0Lg0KPiANCj4gPg0KPiA+IFRoYW5rcw0KPiA+IFBo
aWwNCj4gPg0KPiA+ID4gPiAtc3Vic3lzX2luaXRjYWxsKHI5YTA2ZzAzMl9jbG9ja3NfaW5pdCk7
DQo+ID4gPiA+ICtjb3JlX2luaXRjYWxsKHI5YTA2ZzAzMl9jbG9ja3NfaW5pdCk7DQo+IA0KPiAu
Li4gdXNpbmcgcG9zdGNvcmVfaW5pdGNhbGwoKSBvciBhcmNoX2luaXRjYWxsKCkgaGVyZSwgc2hv
dWxkIHdvcmsgd2l0aA0KPiBwbGF0Zm9ybV9kcml2ZXJfcHJvYmUoKT8NCk5vcGUsIHlvdSBoYXZl
IHRvIHVzZSBwbGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIoKSBmb3IgRFQgYmFzZWQgZHJpdmVycy4N
CnN1YnN5c19pbml0Y2FsbCBpcyB0aGUgZWFybGllc3QgeW91IGNhbiB1c2UgcGxhdGZvcm1fZHJp
dmVyX3Byb2JlKCkuDQoNClRoYW5rcw0KUGhpbA0KDQo+IEdye29ldGplLGVldGluZ31zLA0KPiAN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0IFV5dHRl
cmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGlu
dXgtDQo+IG02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVj
aG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0DQo+IHdoZW4gSSdtIHRh
bGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5n
IGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBU
b3J2YWxkcw0K
