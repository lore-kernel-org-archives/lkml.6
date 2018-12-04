Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDBBC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C5D208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J/pYG2IN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C5D208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeLDIMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:12:15 -0500
Received: from mail-eopbgr140051.outbound.protection.outlook.com ([40.107.14.51]:17327
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725983AbeLDIMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wb115UItrfdyh6KiaJhP4MLSc8MTfhqtTPomlACNDik=;
 b=J/pYG2INV6+iWd85FnXkAiTzPW1byjQYS9FhqRXF9jsxJrFiTj1l5wCBQhNuXH98ztRCpy2DSSXjkBCwK7P4lK6EQDhGktN/wBlt+PlfG5+8JDQTg7Q7jhMxENmREXhLgutLvwiwdgogKV+dJHHj4IIH1M1ysSJv2bURV+/8FF0=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB1341.eurprd04.prod.outlook.com (10.163.165.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Tue, 4 Dec 2018 08:11:11 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::4800:ebc9:8bc5:f314]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::4800:ebc9:8bc5:f314%5]) with mapi id 15.20.1382.023; Tue, 4 Dec 2018
 08:11:10 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v3 0/4] Correct dma pool for imx-sdma
Thread-Topic: [PATCH v3 0/4] Correct dma pool for imx-sdma
Thread-Index: AQHUdYJucz7zxVN5U02w+5UfDam2OKVMVYKAgAwe5sCAFfBm0A==
Date:   Tue, 4 Dec 2018 08:11:10 +0000
Message-ID: <VI1PR04MB454305C5D69C34C90C6D228789AF0@VI1PR04MB4543.eurprd04.prod.outlook.com>
References: <1541504525-25720-1-git-send-email-yibin.gong@nxp.com>
 <1542038185.4011.5.camel@pengutronix.de>
 <DB7PR04MB45382D679D013CD594F02AD689D90@DB7PR04MB4538.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB45382D679D013CD594F02AD689D90@DB7PR04MB4538.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1341;6:X9Y9896G0p5qRnN55+ffYFdRimLDdOaGbmXUAdkKLzSo7pCDlRWykLd2xZk6Tg5+qZet9toxYG4OrpwHHmAMoA24KINrZAFyvV+PEKUeviLRYXD11PRvSNxhgZvUYubaq85FGDinB6r1wvh13dzsfiFsZUtCGjtyAlLGFm1TQfwJGbLLKWPbFbneEay4DFsZF6Mdcb91K5Li90AJfktkMlQtciNufejLy+h/vwGvYYC1e6ZKkFVsl1NRdmSbXuwpMaNcdHh5QXzWxVHUyObsFVzsfXJZQky7IUhApYks/Z0tmPtk5Bfxta/+ECPgdzorY0lua0JIhoU4zw1n8Z+Bvg+shUADZEHRljPrzAiKZmuaQy9ZGeYdAy0mFR4fubQhKKMUJUhN55uz5wnBQl1pK8F2TIeGlyvZbSXV02NfB6QASyIHVfvkitnmCBEDzxtaxBR5vvuY4ZkhH1z3gwu3SQ==;5:rAwhxpm+qlS3wxBbp3zshjXenWDa83iawo0n1P0Znfu0XfkQxvFjApphhKVNhrtFFbcl9fIpy9bU8pgSEITgouLNM4/XTeBlhX+hW22D0Bf90dhuOCrAT5WR5BcSgCADNNg/T1QgO1K76dFx0k7TBDN0SoViKj15p23D9D6Bgbw=;7:YNbwwt+48rbNi6LW6rO6hI+4qoy57sN88O8jXtydakSLQAmfH0NBkLvmhgMgvTfxHcjgvFAQTqmalo4atA4G9+/WMSC06rTbEqPtfneX2hpUrMcMOU4VjrA0CQ6BxWbTK9P/FCSAi+fxYCJQPP772Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e80cf7e1-b73a-408e-8849-08d659c00d2f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1341;
x-ms-traffictypediagnostic: VI1PR04MB1341:
x-microsoft-antispam-prvs: <VI1PR04MB1341CF24B8045B6F83F3DA9989AF0@VI1PR04MB1341.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB1341;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1341;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(366004)(39860400002)(199004)(189003)(13464003)(97736004)(86362001)(8676002)(8936002)(99286004)(6436002)(11346002)(446003)(105586002)(486006)(106356001)(76176011)(229853002)(33656002)(476003)(53546011)(2906002)(6506007)(6116002)(3846002)(102836004)(316002)(45080400002)(26005)(81156014)(81166006)(478600001)(186003)(54906003)(110136005)(25786009)(7736002)(305945005)(74316002)(2501003)(66066001)(966005)(4326008)(14454004)(5660300001)(68736007)(6246003)(55016002)(7696005)(6306002)(9686003)(71190400001)(71200400001)(53936002)(14444005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1341;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: icJJbvls6+9XXPopCX0PLfikRtEVimnAR+hp17cIZLuCUBE5OtpUbBqVUXWqYOD5yHfTY//0pmJggAEutQ7RwKGIwfCkIIJ9CxSN3WWgX+dqnJz/TBgdmaQCl8XqtrUprTymUH2Je9mogz2lO0kcJQinrVjaYSLcsrwG3oT01ez7EYOS013EWDuH8sDPov1icaCP7tqpxGjEtGJuiCC+xXZLEhNimDV1ea9ZoZJdwenxfmEEJVvB3Vxcr9M6QHmMNnU5HBNkDEaH73HkV+9weVxNQ9HlZh2iaHMSjksff2o4cK6tJBQinmIVbIjpoowAmuXpwKMfaypZLgNRX6wR+sjZ4hz0g925LLrNBj30Gco=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80cf7e1-b73a-408e-8849-08d659c00d2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 08:11:10.8214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1341
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gVmlub2QsDQoJIFRoaXMgcGF0Y2ggc2V0IHRlc3QgYnkgTHVjYXMgYW5kIG5vIGFueSBv
dGhlciBjb21tZW50IHJlY2VpdmVkIHlldCwgZG8geW91IGhhdmUNCmNvbW1lbnRzIGFuZCBoZWxw
IHRvIHB1c2ggaXQgb24gNC4xOSBzdGFibGUgdHJlZT8NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogUm9iaW4gR29uZw0KPiBTZW50OiAyMDE45bm0MTHmnIgyMOaXpSAxNzow
OQ0KPiBUbzogJ0x1Y2FzIFN0YWNoJyA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT47IHZrb3VsQGtl
cm5lbC5vcmcNCj4gQ2M6IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+DQo+IFN1
YmplY3Q6IFJFOiBbUEFUQ0ggdjMgMC80XSBDb3JyZWN0IGRtYSBwb29sIGZvciBpbXgtc2RtYQ0K
PiANCj4gDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogTHVj
YXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+DQo+ID4gU2VudDogMjAxOOW5tDEx5pyI
MTLml6UgMjM6NTYNCj4gPiBUbzogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPjsgdmtv
dWxAa2VybmVsLm9yZw0KPiA+IENjOiBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5j
b20+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwLzRdIENvcnJlY3QgZG1hIHBvb2wgZm9y
IGlteC1zZG1hDQo+ID4NCj4gPiBIaSBSb2JpbiwNCj4gPg0KPiA+IEFtIERpZW5zdGFnLCBkZW4g
MDYuMTEuMjAxOCwgMDM6NDAgKzAwMDAgc2NocmllYiBSb2JpbiBHb25nOg0KPiA+ID4gVGhpcyBw
YXRjaCBzZXQgdG8gY29ycmVjdCBkbWEgcG9vbCB1c2VkIGluIHRoZSBjb21taXQgZmU1Yjg1YzY1
NmJjDQo+ID4gPiAoImRtYWVuZ2luZTogaW14LXNkbWE6IGFsbG9jbGF0ZSBiZCBtZW1vcnkgZnJv
bSBkbWEgcG9vbCIpIGJlY2F1c2UNCj4gPiA+IGFsbCBiZHMgc2hvdWxkIGJlIGNvbnRpZ3VvdXMg
aW4gbWVtb3J5IGluIG11bHRpIGJkcyBjYXNlIGZvciBzZG1hLA0KPiA+ID4gYnV0IGRtYSBwb29s
IGNhbid0IHN0YXRpZnkgaXQgYW5kIGNhdXNlIHRyYW5zZmVyIGZhaWx1cmUgdGhlbi5UaGFuaw0K
PiA+ID4gTHVjYXMgZm9yIHRoZSBtYWtpbmcgdGhpbmdzIG9uIHRoZSByaWdodCB3YXkuDQo+ID4g
Pg0KPiA+ID4gVGhpcyBwYXRjaCBzZXQgaXMgdjMgYmFzZWQgb24gTHVjYXMncyBWMS9WMiwgdGhl
IG1haW4gcmVmaW5lOg0KPiA+ID4gwqAgLS1maXggdGhlIGlzc3VlIEkgcmVwb3J0ZWQgaW4gVjEg
YnV0IEx1Y2FzIHdvcmthcm91bmQgaXQgYnkNCj4gPiA+IGltcHJvcGVyDQo+ID4gPiDCoMKgwqDC
oHdheSBpbiBWMi4NCj4gPiA+IMKgIC0tYWRkIHZjaGFuX3N5bmNocm9uaXplKCkgdG8ga2lsbCB0
YXNrbGV0IGluIHZpcnQtZG1hIGludGVybmFsLg0KPiA+ID4gwqAgLS1yZWZpbmUgbmFtZTogdXNl
IHNkbWFfZGlzYWJsZV9jaGFubmVsX2FzeW5jIGluc3RlYWQgb2YNCj4gPiA+IMKgwqDCoMKgc2Rt
YV9kaXNhYmxlX2NoYW5uZWxfd2l0aF9kZWxheSBzaW5jZSBubyBkZWxheSBpbmRlZWQgZm9yDQo+
ID4gPiDCoMKgwqDCoGRldmljZV90ZXJtaW5hdGVfYWxsLg0KPiA+ID4gUGxlYXNlIHJlZmVyIHRv
IGJlbG93IGxpbmsgZm9yIG1vcmUgaW5mb3JtYXRpb246DQo+ID4gPiBodHRwczovL2VtZWEwMS5z
YWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGcA0KPiA+
ID4gYXQNCj4gPiA+DQo+ID4NCj4gY2h3b3JrLmtlcm5lbC5vcmclMkZwYXRjaCUyRjEwNjAxMTEx
JmFtcDtkYXRhPTAyJTdDMDElN0N5aWJpbi5nb25nDQo+ID4gJTQwbg0KPiA+ID4NCj4gPg0KPiB4
cC5jb20lN0NlOGZhZWE5ODRkYjI0NTEzYmNhMjA4ZDY0OGI3NjZmYyU3QzY4NmVhMWQzYmMyYjRj
NmZhOTJjZA0KPiA+IDk5YzVjDQo+ID4gPg0KPiA+DQo+IDMwMTYzNSU3QzAlN0MwJTdDNjM2Nzc2
MzQ5ODczOTQwMDc3JmFtcDtzZGF0YT1VNnkzQ01VbU1maUl6QmMNCj4gPiBabTdqWm1YVGYNCj4g
PiA+IDRKQmdPbkJFaUhoa1k2ZWp6bDglM0QmYW1wO3Jlc2VydmVkPTANCj4gPg0KPiA+IFRoYW5r
cyBmb3IgdGFraW5nIGNhcmUgb2YgdGhvc2UuIEkndmUgdGVzdGVkIHRoZW0gb24gbXkgYm9hcmQg
YW5kDQo+ID4gdGhpbmdzIHNlZW0gdG8gd29yayBmaW5lIGZvciBhbGwgbXkgdXNlLWNhc2VzLg0K
PiA+DQo+ID4gSSB0aGluayB0aG9zZSBwYXRjaGVzIHNob3VsZCBnZXQgYSBDQyB0byBzdGFibGUg
NC4xOS4gSSBndWVzcyBWaW5vZA0KPiA+IGNhbiBhZGQgdGhpcyB3aGVuIGFwcGx5aW5nIHRoZSBw
YXRjaHNldC4NCj4gWWVzLCB3ZSdkIGJldHRlciBmaXggb24gNC4xOS4gSG9wZSBWaW5vZCBjb3Vs
ZCBoZWxwIHVzLg0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiBMdWNhcw0K
