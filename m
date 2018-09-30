Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7E6C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681312075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sYkl6fiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 681312075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeI3RNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 13:13:08 -0400
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:52800
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727821AbeI3RNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 13:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YS7awU++2MBuYZP/9LH5i5ma9TlIzi3P/w2R1hgye2M=;
 b=sYkl6fiAJzDIpRdYI+t8QvTSb8HX/YowLn2m4I5zcTZ664ZmAZohEGR+OvLHALCbM44tds6ElxSsooLMhbqZeiRbJyClF6IF4RHSrqX3mSd4hk9A9AZnTkHTG00b2wm+RX8pnoScoZX2X5aPdBMzrKF39NdlIV7fXKYYLrWZiBY=
Received: from AM0PR04MB4353.eurprd04.prod.outlook.com (52.134.125.146) by
 AM0PR04MB4001.eurprd04.prod.outlook.com (52.134.90.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Sun, 30 Sep 2018 10:40:35 +0000
Received: from AM0PR04MB4353.eurprd04.prod.outlook.com
 ([fe80::a5b0:6887:b5b8:671b]) by AM0PR04MB4353.eurprd04.prod.outlook.com
 ([fe80::a5b0:6887:b5b8:671b%2]) with mapi id 15.20.1185.024; Sun, 30 Sep 2018
 10:40:35 +0000
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     Esben Haabendal <esben.haabendal@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/4] spi: spi-mem: Add the spi_set_xfer_bpw function
Thread-Topic: [PATCH v2 1/4] spi: spi-mem: Add the spi_set_xfer_bpw function
Thread-Index: AQHUWJ+Hb3OQQDlcbEOvxAqFr7DrO6UImK+AgAADsiCAAAV7cA==
Date:   Sun, 30 Sep 2018 10:40:35 +0000
Message-ID: <AM0PR04MB4353EC1BE55AF0A23E7BE3C597EE0@AM0PR04MB4353.eurprd04.prod.outlook.com>
References: <20180930092535.24544-1-chuanhua.han@nxp.com>
        <20180930120425.7715cb29@bbrezillon> <87o9cf70ht.fsf@gmail.com>
In-Reply-To: <87o9cf70ht.fsf@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4001;6:OtfepUJNC3sLoCW8PMXWazh204DKCcO/PsKzasUDLUyQeTSOqyeGdJ/1rLlFv1EJEVZe0NcyN88ghqMdwTt/IFH4sf1MPXRdvoM+FJIMXb3WOHRHYj8vXB+1bqBliPqX/ALOgbJ9KeQRHK4ECkLmq4SL76QnEkwDEtESylzV6GiyMLEmtpLqX8KB92qzUAJkF1DFwdRBEv8ofcPhErSzDz5hTbkLo154udP/GtjRSUanj3MIZ8aroo69uXxB6ejY1I8esJdl0dJYEkMgCv7FZ4e04uPlvVa4qnLReuz8KNMIiKkAMxXqC7TnlHv4nNpIVQws3GM6qG6+lTFt2QlZtBhfPOUTZLKgUAKx6wTA+awrqtiDeHIyuXcjf1pqOIbhwajE/ijkDTu6HMejv/ifU9dB0TvNcFMg2/KIDKaEQwoIvt6rWmDv9i8CwY4echHrs0K4D3JD+hZ0cUTQDdVTfg==;5:itmZr4E2dcpZ80yeDTRBdb9GWtdjau6oVr3aPmvHgCe+Je5Ukp9upNZUHQ8KSKzWC01HfoeuoiXh3nk+FsyG7f2E5Q9ShcKudo5UWnQXyK7TaiCTDxn48ivxqKuWrRBA0g4mKjy4cTAPZAL28exFCbbi5YDQwXA879QXGuRRNDw=;7:UuY9RWFntp6Pld5srPUkgxG4ee/t7/2nWIDQR5nXc4lny1d4M1kr8Zo5vp/IZXeqH0lmSJVa9e8qRF4hXOUyt9Pe73ukYRTXwOSETdbLIBHu2uawTCy1yusTLZgy/6qFMUmdmgr9L/+KOC0s+n8N6Vl+kMQZk9MgNe6HZhov5VbmTQCLvMp2p5AoAw44zzGz8jAHj6qEgGsnouu8DYzovWznnkrkExEAf34i+wxdhEd+T3ObCSaTFCMZzu1RDzO3
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f014f61e-5d0f-4bec-162d-08d626c1276d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4001;
x-ms-traffictypediagnostic: AM0PR04MB4001:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chuanhua.han@nxp.com; 
x-microsoft-antispam-prvs: <AM0PR04MB400189F097A0BB7F31F49B6B97EE0@AM0PR04MB4001.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:AM0PR04MB4001;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4001;
x-forefront-prvs: 08118EFC2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(346002)(376002)(136003)(199004)(13464003)(189003)(51444003)(14444005)(3846002)(33656002)(53936002)(14454004)(54906003)(110136005)(53546011)(6506007)(68736007)(186003)(4326008)(478600001)(316002)(99286004)(5660300001)(26005)(2906002)(102836004)(44832011)(305945005)(2900100001)(81156014)(7736002)(8676002)(486006)(76176011)(229853002)(39060400002)(81166006)(74316002)(71190400001)(71200400001)(345774005)(66066001)(256004)(25786009)(7696005)(8936002)(5250100002)(105586002)(6436002)(11346002)(106356001)(446003)(9686003)(97736004)(6246003)(86362001)(55016002)(34290500001)(6116002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4001;H:AM0PR04MB4353.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FjPaNEokgFeGi6mL6iPxwQkB15D/mHWj4Ge7sA/7gtNoT09P9IVOeiFWVuDZLUhqLF9nu0bT7mio1g4zhOh8hdsCEA0I/ROtH+ivbhTGHtIuKVRsizONRek8c5893+eqIp95224Oofh2UwbbFyPsU9j7680VDXo9K2VxsfhNUVFs4HQYajsGu/ui8o5AoEA8YsMaddAbwthW+KUXImEyPPUC00TH6xglFP4MyJOsy7KoPY/KZaLa6cPydfdinR2KL+lWPZqg28QwTS0Dh8YQ/aptV11AW5KtqNug8tcMXd/DKoyJDKYkKigtbdVXbE1WbbxcN6HjCU7f8mmV+Mhf+U+j7gKVEFS1Ya3SIV4NIwA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f014f61e-5d0f-4bec-162d-08d626c1276d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2018 10:40:35.0726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXNiZW4gSGFhYmVuZGFs
IDxlc2JlbmhhYWJlbmRhbEBnbWFpbC5jb20+IE9uIEJlaGFsZiBPZiBFc2Jlbg0KPiBIYWFiZW5k
YWwNCj4gU2VudDogMjAxOMTqOdTCMzDI1SAxODoxOA0KPiBUbzogQm9yaXMgQnJlemlsbG9uIDxi
b3Jpcy5icmV6aWxsb25AYm9vdGxpbi5jb20+DQo+IENjOiBDaHVhbmh1YSBIYW4gPGNodWFuaHVh
LmhhbkBueHAuY29tPjsgYnJvb25pZUBrZXJuZWwub3JnOw0KPiBsaW51eC1zcGlAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjIgMS80XSBzcGk6IHNwaS1tZW06IEFkZCB0aGUgc3BpX3NldF94ZmVyX2JwdyBmdW5jdGlv
bg0KPiANCj4gQm9yaXMgQnJlemlsbG9uIDxib3Jpcy5icmV6aWxsb25AYm9vdGxpbi5jb20+IHdy
aXRlczoNCj4gDQo+ID4gSGkgQ2h1YW5odWEsDQo+ID4NCj4gPiBPbiBTdW4sIDMwIFNlcCAyMDE4
IDE3OjI1OjMyICswODAwDQo+ID4gQ2h1YW5odWEgSGFuIDxjaHVhbmh1YS5oYW5AbnhwLmNvbT4g
d3JvdGU6DQo+ID4NCj4gPj4gQmVmb3JlIHdlIGFkZCB0aGlzIHNwaV90cmFuc2ZlciB0byB0aGUg
c3BpX21lc3NhZ2UgY2hhaW4gdGFibGUsIHdlDQo+ID4+IG5lZWQgYml0c19wZXJfd29yZF9tYXNr
IGJhc2VkIG9uIHNwaV9jb250cm9sIHRvIHNldCB0aGUgYml0c19wZXJfd29yZA0KPiA+PiBvZiB0
aGlzIHNwaV90cmFuc2Zlci4NCj4gPg0KPiA+IExldCdzIG1ha2UgaXQgY2xlYXJlcjogdGhpcyBp
cyB3cm9uZy4gVGhlIHNwaS1tZW0gcHJvdG9jb2wgaXMganVzdA0KPiA+IHVzaW5nIGJ5dGVzLCBu
b3QgY3VzdG9tIHNpemUgd29yZHMuIEZpeCB0aGUgZnNsLWRzcGkgZHJpdmVyIGlmIG5lZWRlZCwN
Cj4gPiBidXQgZG9uJ3QgdHJ5IHRvIGFkanVzdCB4ZmVyLT5iaXRzX3Blcl93b3JkIGluIHNwaS1t
ZW0uYywgYmVjYXVzZSB0aGlzDQo+ID4gaXMgaW5hcHByb3ByaWF0ZS4NCj4gDQo+IEkgZG9uJ3Qg
dGhpbmsgdGhlcmUgaXMgYSAiZml4IiBuZWVkZWQgaW4gZnNsLWRzcGkgZHJpdmVyIGZvciB0aGlz
Lg0KPiANCj4gSSBhbSBub3Qgc3VyZSwgYnV0IEkgdGhpbmsgdGhhdCB3aGF0IEhhbiBpcyB0cnlp
bmcgdG8gYWNoaWV2ZSBoZXJlIGlzIGJldHRlcg0KPiBwZXJmb3JtYW5jZS4NCj4gQW5kIHdpbGUg
dGhlIFhTUEkgbW9kZSBkb2VzIHByb3ZpZGUgYmV0dGVyIHBlcmZvcm1hbmNlIGZvciBzZW5kaW5n
IG9uZQ0KPiAzMiBiaXQgd29yZCwgdGhhbiBub3JtYWwgbW9kZSBwcm92aWRlZXMgZm9yIHNlbmRp
bmcgNCB4IDggYml0IHdvcmRzLg0KPiBCdXQgYXMgeW91IHNheSwgdGhpcyBpcyB3cm9uZy4NCj4g
DQo+IFRvIGltcHJvdmUgcGVyZm9ybWFuY2UsIHRoZSBmc2wtZHNwaSBkcml2ZXIgc2hvdWxkIGJl
IGZpeGVkIHRvIHdvcmsgaW4gRE1BDQo+IG1vZGUuICBJbXBsZW1lbnRhdGlvbiBvZiBlcnJhdHVt
IEEtMDExMjE4IGlzIG5lY2Vzc2FyeSBpbiBvcmRlciB0byB1c2UNCj4gRFNQSSBETUEgbW9kZSBv
biBMUzEwMjFBLg0KPiBJIHdhcyBwbGFubmluZyB0byB3b3JrIG9uIHRoYXQsIGJ1dCBoYXZlbid0
IGhhZCB0aGUgdGltZSBmb3IgaXQuDQo+IFNvIGlmIHlvdSB3YW50IGJldHRlciBwZXJmb3JtYW5j
ZSBmb3Igc3BpLW1lbSBvbiBMUzEwMjFBIERTUEksIHBsZWFzZSB3b3JrDQo+IG9uIHRoaXMuDQo+
IA0KPiAvRXNiZW4NCkhpo6wNCkFub3RoZXIgY29sbGVhZ3VlIGlzIHJlc3BvbnNpYmxlIGZvciB0
aGUgRE1BIHRyYW5zbWlzc2lvbiBvZiBkc3BpLg0KSSBhbSBub3QgY2xlYXIgYWJvdXQgaXQuIEkg
anVzdCBmaXggdGhlIHRyYW5zbWlzc2lvbiBvZiBYU1BJIG1vZGUgd2l0aCBzZXZlcmFsIHBhdGNo
ZXMuIA0KVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnRzLg0K
