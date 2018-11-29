Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB681C04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E8D2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="MFnkcOk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E8D2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbeK2XHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:07:30 -0500
Received: from mail-eopbgr1410129.outbound.protection.outlook.com ([40.107.141.129]:55363
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726187AbeK2XHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:07:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqD2GVSAUARxv/FaTITfjX8Cmn9ukCMoV+ibCxJRYiY=;
 b=MFnkcOk6BeUGjE8zp4J6DrDT6aYIK1dMPop3X7blb36erbSSNr+JHzrz6IGcs9DWNN9fWa4oEmyPsbD3SIZlCmLCGzt/Cfi5sdCjpcBC+em12fuxlRq3ew9GbEg6FlC4Ifbxzvh5tR6N1zDb7FcEHlL4+onTtrJes9DF9WPQTqE=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1612.jpnprd01.prod.outlook.com (52.133.162.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Thu, 29 Nov 2018 12:02:18 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6%5]) with mapi id 15.20.1294.050; Thu, 29 Nov 2018
 12:02:18 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>
Subject: RE: [PATCH v6 3/6] m68k: coldfire: Add clk_get_optional() function
Thread-Topic: [PATCH v6 3/6] m68k: coldfire: Add clk_get_optional() function
Thread-Index: AQHUfb0dJmKg5pRg5U6S8xEgf5EdU6VmuSCAgAABcWA=
Date:   Thu, 29 Nov 2018 12:02:17 +0000
Message-ID: <TY1PR01MB1769821858C257F94E9470BAF5D20@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20181116145937.27660-1-phil.edworthy@renesas.com>
 <20181116145937.27660-4-phil.edworthy@renesas.com>
 <bcb0278b-a4f5-068b-324f-7be3ca963102@linux-m68k.org>
In-Reply-To: <bcb0278b-a4f5-068b-324f-7be3ca963102@linux-m68k.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1612;20:BoKOkTDGpP7ns64w05Q6cJzR0OTE+hvGC7rHbroGeS6dvy3ZMX1OPBAwZRc9BGHiXb1Yx987hHiTtM1cJmUWcf3q/SKzCQTzp7RtBicxpQGcEDIoTvSpiQXo3cWxa6y5gOTZdoggX4Ilr14WFcaiqKAY7H51DJsmD2tGaQyGEq0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bc844c20-f554-439e-229e-08d655f28294
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1612;
x-ms-traffictypediagnostic: TY1PR01MB1612:
x-microsoft-antispam-prvs: <TY1PR01MB161248F8AB016CD9FBA16B23F5D20@TY1PR01MB1612.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231453)(999002)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1612;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1612;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(396003)(39860400002)(136003)(189003)(199004)(26005)(44832011)(486006)(71190400001)(74316002)(68736007)(11346002)(186003)(476003)(14454004)(102836004)(305945005)(966005)(7736002)(71200400001)(55016002)(9686003)(76176011)(6306002)(256004)(446003)(53546011)(7696005)(6246003)(86362001)(99286004)(53936002)(4326008)(110136005)(54906003)(8676002)(81156014)(316002)(105586002)(81166006)(106356001)(6506007)(66066001)(25786009)(5660300001)(8936002)(478600001)(229853002)(97736004)(2906002)(6436002)(3846002)(6116002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1612;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: argXzbqaVousVhGXLJmE+wmw8Q3gi+o5BE/JM5JUP4IInYBOv0EG7fT71ybQLMN76jDXxwM1GArcDQpnI/u8A00XJKxlS0oZehv+/J1OC/Q0m7zcIEvVVpAQg9ED/uvFOJAjcP609b8BhoQe3MRFF7zgL5nKlJIUpONDO2l9Jww+acD9mU2nclDJ9zpffi51SezwPzPuuBy9orDBNfCjytrpDpKYHTndHJAnoeDRO9dlpMx75bYg5Idhr8NIKI8fu2r61Nw0BfqO8kFONnVjhOQYNyfv/mdK5T8RuJnMyKv9o7bXir2V5Jm/AKnkRU1wn4O6Kzqbn+IaVavW6i6Fp+LN/w9d1y8i7EWGgDv90zc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc844c20-f554-439e-229e-08d655f28294
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 12:02:17.8034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1612
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlcSwNCg0KT24gMjkgTm92ZW1iZXIgMjAxOCAxMTo1NSwgR3JlZyBVbmdlcmVyIHdyb3Rl
Og0KPiBPbiAxNy8xMS8xOCAxMjo1OSBhbSwgUGhpbCBFZHdvcnRoeSB3cm90ZToNCj4gPiBjbGtf
Z2V0X29wdGlvbmFsKCkgcmV0dXJucyBOVUxMIGlmIG5vdCBmb3VuZCBpbnN0ZWFkIG9mIC1FTk9F
TlQsDQo+ID4gb3RoZXJ3aXNlIHRoZSBiZWhhdmlvdXIgaXMgdGhlIHNhbWUgYXMgY2xrX2dldCgp
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGhpbCBFZHdvcnRoeSA8cGhpbC5lZHdvcnRoeUBy
ZW5lc2FzLmNvbT4NCj4gDQo+IEFja2VkLWJ5OiBHcmVnIFVuZ2VyZXIgPGdlcmdAQGxpbnV4LW02
OGsub3JnPg0KPiANCj4gTG9va3MgZ29vZC4gRG8geW91IHdhbnQgbWUgdG8gdGFrZSB0aGlzIGlu
IHRoZSBtNjhrbm9tbXUgZ2l0IHRyZWU/DQo+IE9yIGlzIHRoZSB3aG9sZSBzZXJpZXMgZ29pbmcg
dGhyb3VnaCBzb21lIG90aGVyIHRyZWU/DQpUaGlzIHBhdGNoIGlzIG5vIGxvbmdlciBuZWVkZWQg
YXMgSSBmb3VuZCBhIGJldHRlciB3YXkgdG8gaW1wbGVtZW50IHRoaXM6DQpbUEFUQ0ggdjhdIGNs
azogQWRkIChkZXZtXyljbGtfZ2V0X29wdGlvbmFsKCkgZnVuY3Rpb25zDQpodHRwczovL3BhdGNo
d29yay5rZXJuZWwub3JnL3BhdGNoLzEwNjkwNDM3Lw0KDQpBcG9sb2dpZXMgZm9yIGFueSBjb25m
dXNpb24sDQpQaGlsDQoNCj4gUmVnYXJkcw0KPiBHcmVnDQo+IA0KPiANCj4gDQo+ID4gLS0tDQo+
ID4gICBhcmNoL202OGsvY29sZGZpcmUvY2xrLmMgfCAxMSArKysrKysrKysrKw0KPiA+ICAgMSBm
aWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNo
L202OGsvY29sZGZpcmUvY2xrLmMgYi9hcmNoL202OGsvY29sZGZpcmUvY2xrLmMgaW5kZXgNCj4g
PiA3YmM2NjZlNDgyZWIuLmIyMjFjYWJjN2Y1NCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL202OGsv
Y29sZGZpcmUvY2xrLmMNCj4gPiArKysgYi9hcmNoL202OGsvY29sZGZpcmUvY2xrLmMNCj4gPiBA
QCAtODcsNiArODcsMTcgQEAgc3RydWN0IGNsayAqY2xrX2dldChzdHJ1Y3QgZGV2aWNlICpkZXYs
IGNvbnN0IGNoYXIgKmlkKQ0KPiA+ICAgfQ0KPiA+ICAgRVhQT1JUX1NZTUJPTChjbGtfZ2V0KTsN
Cj4gPg0KPiA+ICtzdHJ1Y3QgY2xrICpjbGtfZ2V0X29wdGlvbmFsKHN0cnVjdCBkZXZpY2UgKmRl
diwgY29uc3QgY2hhciAqaWQpIHsNCj4gPiArCXN0cnVjdCBjbGsgKmNsayA9IGNsa19nZXQoZGV2
LCBpZCk7DQo+ID4gKw0KPiA+ICsJaWYgKGNsayA9PSBFUlJfUFRSKC1FTk9FTlQpKQ0KPiA+ICsJ
CWNsayA9IE5VTEw7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIGNsazsNCj4gPiArfQ0KPiA+ICtFWFBP
UlRfU1lNQk9MKGNsa19nZXRfb3B0aW9uYWwpOw0KPiA+ICsNCj4gPiAgIGludCBjbGtfZW5hYmxl
KHN0cnVjdCBjbGsgKmNsaykNCj4gPiAgIHsNCj4gPiAgIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0K
PiA+DQo=
