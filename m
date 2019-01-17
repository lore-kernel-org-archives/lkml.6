Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C19EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A5620657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aCg83dLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfAQGo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:44:29 -0500
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]:38912
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727348AbfAQGo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:44:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcXJtoW5CteNoBS2Xbau+jBhTTuTZQotkD9G3ai0nKg=;
 b=aCg83dLiRFvBoiLUy12kq2mmRt8znXhTylXR0XziLW6rDZlR67OBna2sLqZx/gBcp5foMIvalOLiy2KUZNpCvR6AEuxK7NQg/F+q4qx7ZfnArY+QYHvkT8lzvQ2yVEgTp3/5rp8eqsLGNpVP9K2tM+Z48k/S4Wo1KLdmetafNcg=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB4477.eurprd04.prod.outlook.com (20.177.53.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Thu, 17 Jan 2019 06:44:24 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::482:b606:281d:ebf5]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::482:b606:281d:ebf5%4]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 06:44:24 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] usb: chipidea: Grab the (legacy) USB PHY by phandle first
Thread-Topic: [PATCH] usb: chipidea: Grab the (legacy) USB PHY by phandle
 first
Thread-Index: AQHUrYPo518BHyRfCUSvmK4xVZBUOKWxuH4AgAArxACAAAPqgIAACqsAgADD+UA=
Date:   Thu, 17 Jan 2019 06:44:24 +0000
Message-ID: <VI1PR04MB5327030D855A1FEBC9BC9E638B830@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <20190116101051.21202-1-paul.kocialkowski@bootlin.com>
         <20190116115350.3daa9b4f@windsurf>
         <554a5b4f463df6551846cfdc3b043d3f1d99381f.camel@bootlin.com>
         <20190116144429.7df1d0c5@windsurf>
 <b42e37ab06ae3efa244a35df801e2126fd692bb7.camel@bootlin.com>
In-Reply-To: <b42e37ab06ae3efa244a35df801e2126fd692bb7.camel@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4477;6:OsoSdhRXK1GFhdtMu7QnULu1VTK6Sfbl04grQPcXmxcF4I2zCqemv9VZujElKpZFpM4xbipaKmwFzsCU1I+0IXUSzyHOiYeA3xGWLPWmI/buAGl8ZcjXM71s7/iHLsLs+7620jxzDZgw1CMKBrtrRXL1IZryeyr4IxY4IT2as5y9yHKKUvx9hHwBExz/hYbzp9SkYRCZInpHLXbTZG6HcM9SsHCYsMqEKsxSMgEzyd+V2A6fK7fV/QbE4naBZBnZi5VckAxuE+ejh4W9b5ynDKNIsi20SsFtzvea8SGeYQMqp19Ph5QgPq9VDWu5zoWNjuiul1eMEpa3YNFoaKsuiE4Ap6Jne2FzRVFpdLRPhqNqisBO/KhS16fTRm/gNsR3FgyZEghiVfmy7wE4/5ft1oEaEXlmeJsECZV90OqXwpjadvDSSIcUBbbd2QxjM+kkQjK8UobHb8kX5xIUi9A2pw==;5:WvVb7A2XXrWQg+cLMU5EsSy/Z10cmebXFdezqUPKWAkaz5A0N/YinzkD+uiyEArc1CXqIKMXbvSwMNLPDElfdkq0IJ5n9R0af8/j8aDIaFFa6nAefln1vQ3i5D0b9568vlK7AsSSgS+s4HzxqkmduKM2HpMEZfG2keXzKxT2xLTBa8zaGGuXIom4xoxqCOV/zvisaK+qWxuCkZc+FTnGNg==;7:PXp4NnsQWwHsCkP+0gxgZ/OzTkhyt8dCQgbcSCfX+MjUVK3izmRxb3pVu5N+3cGOCXdYXiU9deSLUglZ+/oU9fISAFXBFYamrgr752OUvk/OtOF8A2NUKLZoLIzy4RsRWvlAY1ECweDBlDv8lSNh2w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a525571e-7b04-4fe6-a956-08d67c473841
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4477;
x-ms-traffictypediagnostic: VI1PR04MB4477:
x-microsoft-antispam-prvs: <VI1PR04MB4477D961A733AEFC81FD03488B830@VI1PR04MB4477.eurprd04.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(39860400002)(366004)(376002)(199004)(189003)(71200400001)(229853002)(71190400001)(106356001)(102836004)(105586002)(8936002)(25786009)(486006)(4326008)(55016002)(26005)(186003)(6246003)(81156014)(305945005)(476003)(7736002)(66066001)(81166006)(8676002)(11346002)(110136005)(316002)(54906003)(99286004)(446003)(14454004)(478600001)(74316002)(93886005)(217873002)(2906002)(68736007)(5660300001)(256004)(6506007)(76176011)(7696005)(86362001)(33656002)(3846002)(53936002)(9686003)(6436002)(44832011)(6116002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4477;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QdZ+FX9teEOHv8MJYEiHaBv5t9ECCp5UZWsDH4BUir6KWX77uuU+/R6TcjH9+AqyGAWt1xnhRVJIj14ZK8P8Aavps4l/wniwUA73sQCbqZOHpoQJ22jcZcIMblZEnP3ikYz5zCHyhbkRai8hU3NuT5gmSsUF9dtX3vhy3pSNb30sLv/Exip/wCIms4jC31trF3A7sWqoXPvl1cuIxvCUcsxafiOfn5ZwrdR8pmb1M6OSnjghkF7bpO5+OlPy6p6N7Ae9w2+jw+6Tni6h+SprMgL5pCMaVxK5C0jaayOUj0i3Je3U15+Rg9cwj1qaPogfhtRd2Reu0TTBAFUPp7EwLNrDed+ZeVZ5WLQBg35L6PtqoNCyBJseTfwqLvA8fP2RyWdtfMUE9WuB+P883O/gqd/Opx2+aHfm8kE0qy0j9vo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a525571e-7b04-4fe6-a956-08d67c473841
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 06:44:24.7062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4477
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiANCj4gT24gV2VkLCAyMDE5LTAxLTE2IGF0IDE0OjQ0ICswMTAwLCBUaG9tYXMgUGV0YXp6
b25pIHdyb3RlOg0KPiA+IFdlbGwgcHJpb3IgdG8geW91ciBjb2RlLCB0aGVyZSB3YXMgYWxyZWFk
eSBhIHBvc3NpYmlsaXR5IGZvciBib3RoDQo+ID4gY2ktPnBoeSBhbmQgY2ktPnVzYl9waHkgdG8g
YmUgdmFsaWQuIEkgZG9uJ3QgdGhpbmsgaXQncyByZWFsbHkgdXNlZnVsDQo+ID4gdG8gYXZvaWQg
dGhlIGZhbGxiYWNrIHdoZW4gYSBnZW5lcmljIFBIWSBoYXMgYWxyZWFkeSBiZWVuIGZvdW5kLCBp
dCdzDQo+ID4gY29uZnVzaW5nLiBJZiByZWFsbHkgeW91IHdhbnQgdG8gY2xhcmlmeSB0aGF0LCBp
dCBzaG91bGQgYmU6DQo+ID4NCj4gPiAJLyogTGV0J3MgZmlyc3QgdHJ5IHRvIGZpbmQgYSBnZW5l
cmljIFBIWSAqLw0KPiA+IAljaS0+cGh5ID0gZGV2bV9waHlfZ2V0KGRldi0+cGFyZW50LCAidXNi
LXBoeSIpOw0KPiA+IAlpZiAoSVNfRVJSKGNpLT5waHkpKSB7DQoNClBsZWFzZSBjb25zaWRlciAt
RVBST0JFX0RFRkVSIGNhc2UNCg0KPiA+IAkJLyogRmFsbCBiYWNrIHRvIGxlZ2FjeSBVU0IgUEhZ
ICovDQo+ID4gCQljaS0+dXNiX3BoeSA9IGRldm1fdXNiX2dldF9waHlfYnlfcGhhbmRsZShkZXYt
PnBhcmVudCwgInBoeXMiLA0KPiAwKTsNCg0KUGxlYXNlIGNvbnNpZGVyIC1FUFJPQkVfREVGRVIg
Y2FzZQ0KDQo+ID4gCQlpZiAoSVNfRVJSKGNpLT51c2JfcGh5KSkNCj4gPiAJCQljaS0+dXNiX3Bo
eSA9IGRldm1fdXNiX2dldF9waHkoZGV2LT5wYXJlbnQsDQo+IFVTQl9QSFlfVFlQRV9VU0IyKTsN
Cj4gPiAJfQ0KPiA+DQoNCkJlbG93IGNvZGUgDQogICAgICAgICAgICAgICAgaWYgKElTX0VSUihj
aS0+cGh5KSAmJiBJU19FUlIoY2ktPnVzYl9waHkpKSB7DQogICAgICAgICAgICAgICAgICAgICAg
ICByZXQgPSAtRVBST0JFX0RFRkVSOw0KICAgICAgICAgICAgICAgICAgICAgICAgZ290byB1bHBp
X2V4aXQ7DQogICAgICAgICAgICAgICAgfSAgICANCg0KbmVlZHMgdG8gY2hhbmdlIGFzOg0KDQog
ICAgICAgICAgICAgICAgaWYgKFBUUl9FUlIoY2ktPnBoeSkgPT0tRVBST0JFX0RFRkVSICB8fCAg
UFRSX0VSUihjaS0+dXNiX3BoeSkgPT0gLUVQUk9CRV9ERUZFUikgew0KICAgICAgICAgICAgICAg
ICAgICAgICAgcmV0ID0gLUVQUk9CRV9ERUZFUjsNCiAgICAgICAgICAgICAgICAgICAgICAgIGdv
dG8gdWxwaV9leGl0Ow0KICAgICAgICAgICAgICAgIH0gICAgDQoNClBldGVyDQoNCj4gPiBXaXRo
IHRoYXQsIHlvdSB3b3VsZCBvbmx5IGhhdmUgZWl0aGVyIGNpLT5waHkgb3IgY2ktPnVzYl9waHkg
YmUgdmFsaWQsDQo+ID4gYW5kIG5ldmVyIGJvdGguIFdpdGggIHlvdXIgY2hhbmdlLCB5b3UgY2Fu
IGhhdmUgY2ktPnBoeSBhbmQNCj4gPiBjaS0+dXNiX3BoeSBib3RoIGJlIHZhbGlkIGlmIHRoZSBs
ZWdhY3kgVVNCIFBIWSB3YXMgZm91bmQgdXNpbmcNCj4gPiBkZXZtX3VzYl9nZXRfcGh5X2J5X3Bo
YW5kbGUoKSwgYnV0IG5vdCBpZiB3ZSBmZWxsIGJhY2sgdG8NCj4gPiBkZXZtX3VzYl9nZXRfcGh5
KCkuDQo+IA0KPiBPa2F5IHRoYXQgbWFrZXMgc2Vuc2UsIHlvdXIgc3VnZ2VzdGlvbiBpcyBpbmRl
ZWQgbW9yZSBjb25zaXN0ZW50IHdpdGggdGhlIGV4aXN0aW5nDQo+IGJlaGF2aW9yLiBJJ2xsIGdv
IHdpdGggdGhhdCBpbiB0aGUgbmV4dCByZXZpc2lvbiENCj4gDQoNCg0K
