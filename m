Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D556FC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88AA32085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZoSrohTT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfAUKJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:09:05 -0500
Received: from mail-eopbgr50076.outbound.protection.outlook.com ([40.107.5.76]:35920
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726003AbfAUKJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVuYRP+HREINqv8Vxt8ZzM49a1j7q89r4tV8YK6Lc1w=;
 b=ZoSrohTTxLN8ib3ggOGd/We6UNXvo6cLvltA5T7+jdlFrwxH7D/9gi7XR57c4v71IvkAjWZ8t9LuQjOirzDUxO6iUAdAKnSSiTuPMFTpNzjxxCRFicGYmtNx7xQ5mrhtWo6Kb+2OmHj2pOWBEY3Ep5y7JOsOokr44drX+P71C7o=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB6077.eurprd04.prod.outlook.com (20.179.25.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.25; Mon, 21 Jan 2019 10:08:58 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4%2]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 10:08:58 +0000
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     Xiaobo Xie <xiaobo.xie@nxp.com>, Jerry Huang <jerry.huang@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Suresh Gupta <suresh.gupta@freescale.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 3/6] usb: host: Stops USB controller init if PLL fails
 to lock
Thread-Topic: [PATCH v1 3/6] usb: host: Stops USB controller init if PLL fails
 to lock
Thread-Index: AQHUsTgCQlW5U2kb70exmKFwX/yrT6W5YOMAgAAcD3A=
Date:   Mon, 21 Jan 2019 10:08:58 +0000
Message-ID: <VI1PR04MB4158465CB9A6D321E8B26A2AE99F0@VI1PR04MB4158.eurprd04.prod.outlook.com>
References: <20190121031304.31161-1-yinbo.zhu@nxp.com>
 <20190121031304.31161-3-yinbo.zhu@nxp.com>
 <47b5e88e-2886-d8ed-5700-fad31c58f9bd@cogentembedded.com>
In-Reply-To: <47b5e88e-2886-d8ed-5700-fad31c58f9bd@cogentembedded.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB6077;6:LRBhlOiwtl04f3jatne4u6cJizkwKWDL5thMuwSh/inPsrOIPGN4v7GdgVaCZ3+x2NA8MdlD04vebPMB8E86Y9gbw7kakdZmeAbn1Sy/6UKLKAy5ufDj+JGwdFhtG11VbZqfL1mgWTvUEokA5YJTyyCarkboBpM3INAQBppAwUpM/KWrH/k+UM2X0fuik7XJgzE/0qAQ9QeRU2gUTwKiNkMvZ/lXpS87HP1ZCa8/W+fr7le/pFF7LVOK16ioGfzpyGXWyuAcoQWmyxCaQFhT6rj5o/w0yIAA3bsw70wMqHhOGc+pbITV6+TTCzWk7r6Hv8nr6+Ra7V841fsYYDvmlxJ7Wxt0c8vTUooAvKJzEjlKmItaCsuLxDxW3Kt01v6giUmfv66q/lcBDQugsbL9gIGenw55T4sKx6xg6ht6eGlX8ijm1IcVtm387xedmgSs1jjYDUI+ymkvHma+d379Ug==;5:neFzgzhIyHJk331cdcoOzxw34DghJo1n9B2DvFJbqiBYo/tlOTEEn7ezHAcMFtPQTW6EqltmMX7wsbMXSTYXx1yuem5z3YRkgwKwZLnNnUUsYmngDJJM7lvEuiVxMoYwha0AxPixSnkEP2HZoBcusniGp/yF+Rvt0/aXdkei70PVCOme8lxXOJFLSQkOk6M6Jq8o488xU93JVg34p4beBw==;7:3ITmbCxM3cG54a42ZMLByIxPMoquhIXXJZl3VVJVfMrR9+rX7M1EDGckD53TSD2hEIBPk+W3NXcJWrClC5rtuB/fnikM5Kf934q+Zltg8I3yZwp1U4aEVWTo4I5oDwMcJzin1shZwg76YVbTOBufpw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: dd96810a-5caf-4cab-1ef5-08d67f88758b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB6077;
x-ms-traffictypediagnostic: VI1PR04MB6077:
x-microsoft-antispam-prvs: <VI1PR04MB60775D326491CACF3C2260DCE99F0@VI1PR04MB6077.eurprd04.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(396003)(346002)(376002)(13464003)(199004)(189003)(9686003)(66066001)(6246003)(97736004)(71200400001)(2906002)(106356001)(7696005)(76176011)(2171002)(71190400001)(74316002)(53936002)(6436002)(8676002)(81166006)(55016002)(25786009)(305945005)(81156014)(68736007)(4326008)(8936002)(7736002)(110136005)(54906003)(44832011)(86362001)(486006)(14454004)(316002)(478600001)(229853002)(53546011)(26005)(6506007)(102836004)(6116002)(33656002)(99286004)(11346002)(446003)(476003)(256004)(186003)(3846002)(105586002)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6077;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xtr+f6v0P1BWjTSzXly9jFuMA8+N4QFWbdsoY1mbbpXd7YtIL6rsjECn08eh7ePj0kdxyyVFpgWPC5Fw2YOOioHcIn2OXc9JKyot2rqlKTvnc7f5C9kzQdkDbvEtYCRnqcJMJByuxqrDxaSCI2o0nDfzfplnDFsA7O3bf2WS7OGNvSNP+HaEKIC4lXXxw/orMppTeGViovbJqVIZV62dErdAD85LkAvPfP1GxIudgMa2IKaAyMfJqGqvzgPhdCitbvnaRbJb1VDwwSMZ9sVExjKXczcQRv0ydfgI09tWv92G93gI5XZPsyveuNix6g7ghe4Z4nMV+vO7Me7tvjNBSuNyEF89dGnKHpewYF/I2M1CRh6z+gBmqIMcBagKIZkp/aj8PpZzC3L1CEu6r6GPvPudwYmdac1xDniw8SQbNhQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd96810a-5caf-4cab-1ef5-08d67f88758b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 10:08:58.2272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTZXJnZWkgU2h0eWx5b3YgW21h
aWx0bzpzZXJnZWkuc2h0eWx5b3ZAY29nZW50ZW1iZWRkZWQuY29tXSANClNlbnQ6IDIwMTnlubQx
5pyIMjHml6UgMTY6MTcNClRvOiBZaW5ibyBaaHUgPHlpbmJvLnpodUBueHAuY29tPjsgQWxhbiBT
dGVybiA8c3Rlcm5Acm93bGFuZC5oYXJ2YXJkLmVkdT4NCkNjOiBYaWFvYm8gWGllIDx4aWFvYm8u
eGllQG54cC5jb20+OyBKZXJyeSBIdWFuZyA8amVycnkuaHVhbmdAbnhwLmNvbT47IFJhbiBXYW5n
IDxyYW4ud2FuZ18xQG54cC5jb20+OyBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZv
dW5kYXRpb24ub3JnPjsgUmFtbmVlayBNZWhyZXNoIDxyYW1uZWVrLm1laHJlc2hAZnJlZXNjYWxl
LmNvbT47IE5pa2hpbCBCYWRvbGEgPG5pa2hpbC5iYWRvbGFAZnJlZXNjYWxlLmNvbT47IFN1cmVz
aCBHdXB0YSA8c3VyZXNoLmd1cHRhQGZyZWVzY2FsZS5jb20+OyBsaW51eC11c2JAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENI
IHYxIDMvNl0gdXNiOiBob3N0OiBTdG9wcyBVU0IgY29udHJvbGxlciBpbml0IGlmIFBMTCBmYWls
cyB0byBsb2NrDQoNCj5IZWxsbyENCg0KPiBPbiAyMS4wMS4yMDE5IDY6MTMsIFlpbmJvIFpodSB3
cm90ZToNCg0KPiBGcm9tOiB5aW5iby56aHUgPHlpbmJvLnpodUBueHAuY29tPg0KPiANCj4gVVNC
IGVycmF0dW0tQTAwNjkxOCB3b3JrYXJvdW5kIHRyaWVzIHRvIHN0YXJ0IGludGVybmFsIFBIWSBp
bnNpZGUgDQo+IHVib290ICh3aGVuIFBMTCBmYWlscyB0byBsb2NrKS4gSG93ZXZlciwgaWYgdGhl
IHdvcmthcm91bmQgYWxzbyBmYWlscywgDQo+IHRoZW4gVVNCIGluaXRpYWxpemF0aW9uIGlzIGFs
c28gc3RvcHBlZCBpbnNpZGUgTGludXguDQo+IEVycmF0dW0tQTAwNjkxOCB3b3JrYXJvdW5kIGZh
aWx1cmUgY3JlYXRlcyAiZnNsLGVycmF0dW1fYTAwNjkxOCINCj4gbm9kZSBpbiBkZXZpY2UtdHJl
ZS4gUHJlc2VuY2Ugb2YgdGhpcyBub2RlIGluIGRldmljZS10cmVlIGlzIHVzZWQgdG8gDQo+IHN0
b3AgVVNCIGNvbnRyb2xsZXIgaW5pdGlhbGl6YXRpb24gaW4gTGludXgNCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFJhbW5lZWsgTWVocmVzaCA8cmFtbmVlay5tZWhyZXNoQGZyZWVzY2FsZS5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IFN1cmVzaCBHdXB0YSA8c3VyZXNoLmd1cHRhQGZyZWVzY2FsZS5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IHlpbmJvLnpodSA8eWluYm8uemh1QG54cC5jb20+DQo+IC0tLQ0K
PiAgIGRyaXZlcnMvdXNiL2hvc3QvZWhjaS1mc2wuYyAgICAgIHwgICAgNSArKysrKw0KPiAgIGRy
aXZlcnMvdXNiL2hvc3QvZnNsLW1waC1kci1vZi5jIHwgICAgNSArKysrKw0KPiAgIDIgZmlsZXMg
Y2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktZnNsLmMgYi9kcml2ZXJzL3VzYi9ob3N0L2VoY2kt
ZnNsLmMgDQo+IGluZGV4IGEyOGVjMWUuLjY4ODQxMzAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
dXNiL2hvc3QvZWhjaS1mc2wuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktZnNsLmMN
Cj4gQEAgLTIyNCw2ICsyMjQsMTEgQEAgc3RhdGljIGludCBlaGNpX2ZzbF9zZXR1cF9waHkoc3Ry
dWN0IHVzYl9oY2QgKmhjZCwNCj4gICAJCXBvcnRzYyB8PSBQT1JUX1BUU19QVFc7DQo+ICAgCQkv
KiBmYWxsIHRocm91Z2ggKi8NCj4gICAJY2FzZSBGU0xfVVNCMl9QSFlfVVRNSToNCj4gKwkJaWYg
KHBkYXRhLT5oYXNfZnNsX2VycmF0dW1fYTAwNjkxOCkgew0KPiArCQkJcHJfd2FybigiZnNsLWVo
Y2k6IFVTQiBQSFkgY2xvY2sgaW52YWxpZFxuIik7DQo+ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4g
KwkJfQ0KPiArDQo+ICAgCWNhc2UgRlNMX1VTQjJfUEhZX1VUTUlfRFVBTDoNCj4gICAJCS8qIFBI
WV9DTEtfVkFMSUQgYml0IGlzIGRlLWZlYXR1cmVkIGZyb20gYWxsIGNvbnRyb2xsZXINCj4gICAJ
CSAqIHZlcnNpb25zIGJlbG93IDIuNCBhbmQgaXMgdG8gYmUgY2hlY2tlZCBvbmx5IGZvciBkaWZm
IC0tZ2l0IA0KPiBhL2RyaXZlcnMvdXNiL2hvc3QvZnNsLW1waC1kci1vZi5jIGIvZHJpdmVycy91
c2IvaG9zdC9mc2wtbXBoLWRyLW9mLmMNCj4gaW5kZXggNjc3ZjlkNS4uN2UwNzcwMSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy91c2IvaG9zdC9mc2wtbXBoLWRyLW9mLmMNCj4gKysrIGIvZHJpdmVy
cy91c2IvaG9zdC9mc2wtbXBoLWRyLW9mLmMNCj4gQEAgLTIyNSw2ICsyMjUsMTEgQEAgc3RhdGlj
IGludCBmc2xfdXNiMl9tcGhfZHJfb2ZfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqb2Zk
ZXYpDQo+ICAgCXBkYXRhLT5oYXNfZnNsX2VycmF0dW1fYTAwNTY5NyA9DQo+ICAgCQlvZl9wcm9w
ZXJ0eV9yZWFkX2Jvb2wobnAsICJmc2wsdXNiX2VycmF0dW0tYTAwNTY5NyIpOw0KPiAgIA0KPiAr
CWlmIChvZl9nZXRfcHJvcGVydHkobnAsICJmc2wsZXJyYXR1bV9hMDA2OTE4IiwgTlVMTCkpDQoN
Cj4gICAgb2ZfcHJvcGVydHlfcmVhZF9ib29sKCkgcGVyaGFwcz8NCg0KSGkgU2VyZ2VpLA0KDQpb
UEFUQ0ggdjEgNi82XSBoYWQgbW9kaWZpZWQgaXQgYXMgdGhpcyBzdHJpbmcgZm9ybWF0LA0KUGxl
YXNlIHlvdSBub3RlLg0KDQpNQlIsIFlpbmJvDQo+ICsJCXBkYXRhLT5oYXNfZnNsX2VycmF0dW1f
YTAwNjkxOCA9IDE7DQo+ICsJZWxzZQ0KPiArCQlwZGF0YS0+aGFzX2ZzbF9lcnJhdHVtX2EwMDY5
MTggPSAwOw0KPiArDQo+ICAgCS8qDQo+ICAgCSAqIERldGVybWluZSB3aGV0aGVyIHBoeV9jbGtf
dmFsaWQgbmVlZHMgdG8gYmUgY2hlY2tlZA0KPiAgIAkgKiBieSByZWFkaW5nIHByb3BlcnR5IGlu
IGRldmljZSB0cmVlDQoNCj4gTUJSLCBTZXJnZWkNCg==
