Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAEAECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 19:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C567214FA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 19:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C567214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbeIRBDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 21:03:36 -0400
Received: from mail-eopbgr40078.outbound.protection.outlook.com ([40.107.4.78]:12928
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727329AbeIRBDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 21:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22kDRg6omrir+k4yoKZz7qlCMbOtBoHBWcnZBfkZFyg=;
 b=bnmpGlX3Fy75VHS13zuKw8rh+GaXOGTNeNgyF6PrLpuiI07f+XGzr8nSW4b4hDjIvwJyvWRwRrFKPARN5bMrKuKivRxbrrXZ59orQzMgZsXOd1z+SBgvBS/LiBgxw+zAE5Jkbfyu19LKNBq5Zm+uYjNZf2XA01rtB2Xl1a9Pn3s=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4241.eurprd04.prod.outlook.com (52.134.126.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 17 Sep 2018 19:34:48 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c5f:d09d:bdc1:fe03]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c5f:d09d:bdc1:fe03%2]) with mapi id 15.20.1143.017; Mon, 17 Sep 2018
 19:34:48 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "marex@denx.de" <marex@denx.de>,
        "sean@poorly.run" <sean@poorly.run>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "stefan@agner.ch" <stefan@agner.ch>,
        Robert Chiras <robert.chiras@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [RESEND 0/5] drm/mxsfb: Fix runtime PM for unpowering lcdif block
Thread-Topic: [RESEND 0/5] drm/mxsfb: Fix runtime PM for unpowering lcdif
 block
Thread-Index: AQHUToxYC5nA0ZROGECLHk7Ehnp4vqT02KYAgAAFNwA=
Date:   Mon, 17 Sep 2018 19:34:48 +0000
Message-ID: <4a9eae61c79abd844c9077edb039be348b77224f.camel@nxp.com>
References: <cover.1537191359.git.leonard.crestez@nxp.com>
         <20180917191602.GP188300@art_vandelay>
In-Reply-To: <20180917191602.GP188300@art_vandelay>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4241;6:0fJ+/gNipWabeTHMD4vynd4/YTSs1EEVWYysuZ588ZsRQ12UOWnlRb9yYSRZOgNI/3SoJr+FtlGkHGBuWj4AZBv22uvKN2C7ycuhLtG/cr/aZpMCU+37k84kKVrFK1VizRB9GZl4rGasaoty3qKpCZwz0QSxN0U7HK9zfNv4KUSrCUuCW/AN8Rhn/GOdXvU990ROt+HE2TDgt+H/BCNHsYTq/7S14y6oRPYQGR6vklmzvM7qeH1bn9azIBhSlX/jZOrxIqc/efMP0DB07AIrkVtbs0HMeGAkyMVGR950PYhPpj3OXU7B0ioXkO8Q5FvjXscSEJhcObwSPRMfj1zlSY2PSY9yUkE5sWDVsG8SjybImtAHBOPTny7jHeNYnqkwQOtMwkU/qJ0MXFfjs3KqSTAmlZDDHxDykFnLUaA1n+37uhiQuHzJf4XP1a95TfNRV3sX1FATku3Xlx5uKSpqYQ==;5:qsX2CZjvZAzwrTfrnJuaTBVm33eYnC8O9Pdk49GzAnm+iwmMuJnVwb6ljjpolTC6Yu1BfOqOBIAO38cQRCE3aderJgxTE4RvrEvnYPOrCoNG7CiKNTmzt9Cft77iVNWfqMrvyD6dZtivQtVog2Go/x4rT5G35N17Ce+9uJV8W0M=;7:qWoYmY2Rfr5mHKY019wjMVNThxsXaOKN8+pJI5S+Jx2ZhOgIf/3Z8xLDlwgIPAUwRjSruYdrxG7bqlDnPJKMmsuyF/PDnV1t9nJCBcWlSRKR1UHt9t5zq0BGPMvtRl7+ewlLx2eb0VAs6+2AagS0ytcA60GZXNt8C4SGQY1/QB4qxdeu9RsUuqUfjiPD2eWiTMFA6R5Q6U5Ia+WnV7keYxHnIKz+bLbKrgsMAJejRTUr83GpflIL8d6fl61z+SMm
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 941e2f48-c79f-4829-4696-08d61cd4a196
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4241;
x-ms-traffictypediagnostic: AM0PR04MB4241:
x-microsoft-antispam-prvs: <AM0PR04MB42412C7C120F9BAD7BEB949BEE1E0@AM0PR04MB4241.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:AM0PR04MB4241;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4241;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(39860400002)(376002)(346002)(199004)(189003)(102836004)(8676002)(36756003)(478600001)(86362001)(7736002)(97736004)(6512007)(66066001)(305945005)(106356001)(105586002)(4326008)(6436002)(8936002)(2501003)(53936002)(186003)(5250100002)(50226002)(486006)(81166006)(81156014)(2906002)(110136005)(2201001)(14454004)(6506007)(5660300001)(76176011)(2900100001)(68736007)(256004)(14444005)(44832011)(3846002)(6116002)(118296001)(54906003)(11346002)(2616005)(6246003)(446003)(316002)(7416002)(6486002)(25786009)(99286004)(476003)(26005)(229853002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4241;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4r0FXcruqZiRNBZ37boXZ2PogHPx3CSud63TRR63w4kkY0JSoaRAWZHmLwA4sosNN5yN3hO7wGu3T0W7kv7Tu0ySzJRK3waLRm0lpEnUlR9Ehye4flEkfYodSYSf5i6UdSRJQ2IxLF84w4atYELdtxHfJhhyx21XOE5qfEYmFV3Fh0sMu4FV+sO5NyxNnCYRHW4yQ8WrZ0nxWSiMTl+71VknDFjSmhKCNa9CYhYVE8W0XzryT/RdM16s2sv6cxsvJavZFUs1c9vUyVMv6nt368HnsEJyHk5lr7Iv6qsvoqrpU7nsaiUV9aoPlZPqkjvpTQMlOFSXXFduNTee8ImUKQcyZZRKsmcYX6ZKR/yhGd4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0741C46552AAE4199C8664C16948F29@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941e2f48-c79f-4829-4696-08d61cd4a196
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 19:34:48.8328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4241
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA5LTE3IGF0IDE1OjE2IC0wNDAwLCBTZWFuIFBhdWwgd3JvdGU6DQo+IE9u
IE1vbiwgU2VwIDE3LCAyMDE4IGF0IDA0OjQyOjEwUE0gKzAzMDAsIExlb25hcmQgQ3Jlc3RleiB3
cm90ZToNCj4gPiBBZGRpbmcgbGNkaWYgbm9kZXMgdG8gYSBwb3dlciBkb21haW4gY3VycmVudGx5
IGRvZXNuJ3Qgd29yaywgaXQgcmVzdWx0cw0KPiA+IGluIGJsYWNrL2NvcnJ1cHRlZCBzY3JlZW5z
IG9yIGhhbmdzLiBXaGlsZSB0aGUgZHJpdmVyIGRvZXMgZW5hYmxlDQo+ID4gcnVudGltZSBwbSBp
dCBkb2VzIG5vdCBkZWFsIGNvcnJlY3RseSB3aXRoIHRoZSBibG9jayBiZWluZyB1bnBvd2VyZWQu
DQo+ID4gDQo+ID4gVGhpcyBzZXJpZXMgc3RhbGxlZCBzbyBJIHJlYWNoZWQgb3V0IHRvIE1hcmVr
IG9uIElSQyBhbmQgaGUgd2FzDQo+ID4gc3VycHJpc2VkIHRvIGJlIGxpc3RlZCBhcyBtYWludGFp
bmVyIA0KPiANCj4gSG9wZWZ1bGx5IG5vdCB0b28gc3VycHJpc2VkIHNpbmNlIE1hcmVrIGFkZGVk
IHRoZW1zZWxmIHRvIE1BSU5UQUlORVJTIHdoZW4NCj4gYWRkaW5nIHRoZSBkcml2ZXIgOi0pDQo+
IA0KPiBJIHN1cHBvc2Ugd2Ugc2hvdWxkIHByb2JhYmx5IG1vdmUgdGhpcyB0byBkcm0tbWlzYyBz
aW5jZSBpdCBxdWFsaWZpZXMgYXMgYQ0KPiAic21hbGwgZHJpdmVyIiBhbmQgbmVlZHMgYSBob21l
LiBMb29raW5nIHRocm91Z2ggZ2l0IGhpc3Rvcnkgc2hvd3MgdGhlIGxhc3QNCj4gbXhzZmItc3Bl
Y2lmaWMgY2hhbmdlIHdhcyBiYWNrIGluIDAyLzE3LiBFdmVyeXRoaW5nIGVsc2UgaGFzIGJlZW4g
ZHJtLXdpZGUNCj4gcmVmYWN0b3JzLiBUaG91Z2h0cz8NCj4gDQo+IE1hcmVrL0xlb25hcmQ6IENh
cmUgdG8gc2lnbiB1cCB0byBiZSBsaXN0ZWQgYXMgYSByZXZpZXdlcnM/DQoNClNpbmNlIG15IGtu
b3dsZWRnZSBvZiBkcm0gaXMgdmVyeSBiYXNpYzogbm8gdGhhbmtzLg0KDQpTaW5jZSB0aGlzIGlz
IGFuIGlteCBkcml2ZXIgaXQgd291bGQgbWFrZSBhIGxvdCBvZiBzZW5zZSB0byBncm91cCB0aGlz
DQp0b2dldGhlciB3aXRoIHRoZSByZXN0IG9mIGRybS9pbXggc29tZWhvdy4NCg0KLS0NClJlZ2Fy
ZHMsDQpMZW9uYXJk
