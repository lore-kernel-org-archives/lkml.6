Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEE7C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F67214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="btR7fhpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F67214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732364AbeHBNaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:30:04 -0400
Received: from mail-eopbgr40064.outbound.protection.outlook.com ([40.107.4.64]:37319
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732153AbeHBNaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSyUDzV+wXC/qBo3dnSOgRgTNTKroIk8gxUQDDpZAaE=;
 b=btR7fhpgCuSljeyuGCymfd7vz/g045YctWcv2R+BYFjeXFIlrneom7+naUrmx4la+kK3FPKTFisFzc0vzVDcNAhypKABv2FAoQuozC6U0GXiZ1KQm++WgOaHhUA6VotDSn0/gqO//+MsLDtw6mBIoYGxLRtN8bjhFXWd/b/dGUI=
Received: from VI1PR04MB4301.eurprd04.prod.outlook.com (52.134.31.156) by
 VI1PR04MB3181.eurprd04.prod.outlook.com (10.170.229.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Thu, 2 Aug 2018 11:39:14 +0000
Received: from VI1PR04MB4301.eurprd04.prod.outlook.com
 ([fe80::cdf2:26be:4600:9939]) by VI1PR04MB4301.eurprd04.prod.outlook.com
 ([fe80::cdf2:26be:4600:9939%4]) with mapi id 15.20.0995.020; Thu, 2 Aug 2018
 11:39:14 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>,
        Robert Chiras <robert.chiras@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v2] drm/mxsfb: Fix runtime PM for unpowering lcdif block
Thread-Topic: [PATCH v2] drm/mxsfb: Fix runtime PM for unpowering lcdif block
Thread-Index: AQHUHbvBVHNun0c9gE+Re4WTXuPxrqSpTyKAgAAGPQCAAwNOgIAADaQAgAAJFoA=
Date:   Thu, 2 Aug 2018 11:39:14 +0000
Message-ID: <b5877aaefd8b1a2b440988bfc69779fa45c29256.camel@nxp.com>
References: <f873c5592e9907beba905ce68358d5ae2f63a4d7.1531824173.git.leonard.crestez@nxp.com>
         <1533038097.3444.13.camel@pengutronix.de>
         <c5e9f521edbca4b1b168e4ee6c8fbd41b1ca2261.camel@nxp.com>
         <1533205073.3516.17.camel@pengutronix.de>
         <0f22023bf42fc7ba458b285d60e3b866@agner.ch>
In-Reply-To: <0f22023bf42fc7ba458b285d60e3b866@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3181;6:WDc28jHP8vAIS1J66QiaHdwQyTcTbVUCMk+ai0QPeTPzCOGgLLiHEP2EiDXgZl1u2rOSCtdDWSBlWZULa5DY21yG3MyutBc+KDXwcmQrQJVHir3/5EUlvmZPh2j8/jbU9uI4dKcYYpdScXQJv+cnFZo6cxje5/B4cNa9V22kjIMgS2Ey+DUDrKPmpWw8ARAymuefxP+JO1dfuzfiyK76ZM7clea+jHdwXisy4bkUoRvyuBChUcxaYHAvNOWm99LR9ygDn+2ELMHBOPSLzqP4J7otF+VQGJpMVAaLNH9DUU52dxhHF5QtAd45oDm4Hy2NNI6h+v//eiuNHEbMLalV/ncXoM/rg1VqWpXflH7wixtOe+E5+AmwL8ABXwWuB1y0b4xirUYk6PEo5u7cTHCDo9lgeO3DNCzrap2SbPq+fLTnG4JtmPDebCcAAXVw5WBkeG5iQ8hIawlDhjyfIlqoMA==;5:O0KhrXNrE9JRjUY01kZGAUB7RyR7WmtGiBhRt8moOsGSiFZf3884XCrb+OTiMIQjJoLIz5Dj0vUFOP9EoskLY1y48qQnImP7Mc8pawEQleZFWeJ85Gj83dP7JBvWGoiSODXnX9JGGjNJurKg9txrB4oLBn1K7EyuCJOXrq3dW60=;7:y40VbSJ49Di6yAtHsaRnXLlNt5z8KN+cylYtGwM6vsWsy/xbb7OKa/lmWcUL9EwrCpJjf1ftBcVuremXBjxwJ8NpgbvgyqvUi1K0j+c7Bbd2LAQjfHhG/1wc+wlYaeJkijeZVUK2mwfTFn+iqjue126FBoz8CEw3gRG4XhBDUOUXRtt/O16i1cop/Q0gFAxgGm6GF3WiVVfc9GytknJmDPB4zrhGQGeR0fJfiEuOsfNvVk/xq3H9ErqYvUGf1Uhk
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fea7e1e5-de53-4eda-69e0-08d5f86c92c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3181;
x-ms-traffictypediagnostic: VI1PR04MB3181:
x-microsoft-antispam-prvs: <VI1PR04MB31819ECF3943F8D18C74094DEE2C0@VI1PR04MB3181.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB3181;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3181;
x-forefront-prvs: 07521929C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(396003)(346002)(39860400002)(199004)(189003)(6486002)(2900100001)(256004)(486006)(6116002)(478600001)(14444005)(2906002)(99286004)(25786009)(3846002)(316002)(5250100002)(2501003)(66066001)(446003)(8936002)(5660300001)(81166006)(186003)(8676002)(81156014)(44832011)(11346002)(76176011)(6436002)(86362001)(2616005)(97736004)(93886005)(26005)(50226002)(6506007)(53546011)(102836004)(14454004)(53936002)(54906003)(105586002)(110136005)(68736007)(229853002)(6246003)(476003)(6512007)(118296001)(4326008)(106356001)(305945005)(36756003)(7736002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3181;H:VI1PR04MB4301.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WW540M2sOw5g0o9VOItB14N9ILOMsLJhgqQYWE5lw2Kxkc3HZDRvWdTZJCEhUQA1zT3oD/UG4gaNXAxEKf/0c76SuELDM6UeEExnePTR6si2As9B2H8Fx8WlDPsGQc2hr2L2tsMZiWCsUxqC/igc0GFGVu55WESVgzIsFJHopnxSxlP0vmaq2/+hLIoFM3+1GlyUGXxqEmUMlboenHBTpAVaHjdsddRax8WTqHAQMRFPD6+0FeCMSEcJiJ5ZtKUc7YY7JMDOv1ie7jH4UdgRyXmIxL2KQxDVTWKVSHox/0hnokUcSeBchexjevvfdP5anNulz5A6ThdzBvODTniBspgMMwB/c5YAr8UBFxkfQzA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABEBC1AC08CAE946814259E76AC80847@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea7e1e5-de53-4eda-69e0-08d5f86c92c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2018 11:39:14.4506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA4LTAyIGF0IDEzOjA2ICswMjAwLCBTdGVmYW4gQWduZXIgd3JvdGU6DQo+
IE9uIDAyLjA4LjIwMTggMTI6MTcsIFBoaWxpcHAgWmFiZWwgd3JvdGU6DQo+ID4gT24gVHVlLCAy
MDE4LTA3LTMxIGF0IDEyOjE3ICswMDAwLCBMZW9uYXJkIENyZXN0ZXogd3JvdGU6DQo+ID4gPiBP
biBUdWUsIDIwMTgtMDctMzEgYXQgMTM6NTQgKzAyMDAsIFBoaWxpcHAgWmFiZWwgd3JvdGU6DQo+
ID4gPiA+IE9uIFR1ZSwgMjAxOC0wNy0xNyBhdCAxMzo0OCArMDMwMCwgTGVvbmFyZCBDcmVzdGV6
IHdyb3RlOg0KPiA+ID4gPiA+IEFkZGluZyBsY2RpZiBub2RlcyB0byBhIHBvd2VyIGRvbWFpbiBj
dXJyZW50bHkgZG9lcyB3b3JrLCBpdCByZXN1bHRzIGluDQo+ID4gPiA+ID4gYmxhY2svY29ycnVw
dGVkIHNjcmVlbnMgb3IgaGFuZ3MuIFdoaWxlIHRoZSBkcml2ZXIgZG9lcyBlbmFibGUgcnVudGlt
ZQ0KPiA+ID4gPiA+IHBtIGl0IGRvZXMgbm90IGRlYWwgY29ycmVjdGx5IHdpdGggdGhlIGJsb2Nr
IGJlaW5nIHVucG93ZXJlZC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBFbnN1cmUgcG93ZXIgaXMg
b24gd2hlbiByZXF1aXJlZCBieSBhZGRpbmcgcG1fcnVudGltZV9nZXQvcHV0X3N5bmMgdG8NCj4g
PiA+ID4gPiBteHNmYl9waXBlX2VuYWJsZS9kaXNhYmxlLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+
IFNpbmNlIHBvd2VyIGlzIGxvc3Qgb24gc3VzcGVuZCBpbXBsZW1lbnQgUE1fU0xFRVBfT1BTIHVz
aW5nDQo+ID4gPiA+ID4gZHJtX21vZGVfY29uZmlnX2hlbHBlcl9zdXNwZW5kL3Jlc3VtZS4NCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBUaGUgbXhzZmJfcGxhbmVfYXRvbWljX3VwZGF0ZSBmdW5jdGlv
biBjYW4gZ2V0IGNhbGxlZCBiZWZvcmUNCj4gPiA+ID4gPiBteHNmYl9waXBlX2VuYWJsZSB3aGls
ZSB0aGUgYmxvY2sgaXMgbm90IHlldCBwb3dlcmVkLiBXaGVuIHRoaXMgaGFwcGVucw0KPiA+ID4g
PiA+IHRoZSB3cml0ZSB0byBMQ0RJRl9ORVhUX0JVRiBpcyBsb3N0IGNhdXNpbmcgY29ycnVwdCBk
aXNwbGF5IG9uIHVuYmxhbmsNCj4gPiA+ID4gPiB1bnRpbCBhIHJlZnJlc2guDQo+ID4gPiA+IA0K
PiA+ID4gPiBXaHkgZG9lcyB0aGlzIGhhcHBlbj8NCj4gPiA+IA0KPiA+ID4gSSdtIG5vdCBzdXJl
IHdoYXQgeW91J3JlIGFza2luZyBidXQgcmVnaXN0ZXIgd3JpdGVzIHRvIHVucG93ZXJlZCBvcg0K
PiA+ID4gdW5jbG9ja2VkIGJsb2NrcyBhcmUgbm90IGV4cGVjdGVkIHRvICJqdXN0IHdvcmsiLiBI
ZXJlIHRoZSB3cml0ZSBpcw0KPiA+ID4gaWdub3JlZC9sb3N0IGJ1dCBJIHRoaW5rIG9uIGlteDgg
aXQgY2FuIGV2ZW4gY2F1c2UgYSBidXMgZXJyb3IuDQo+ID4gPiANCj4gPiA+IFRoZSBhcHByb2Fj
aCBoZXJlIGlzIHRvIG9ubHkgc2V0IHRoZSBmcmFtZWJ1ZmZlciBhZGRyZXNzIGFzIHBhcnQgb2YN
Cj4gPiA+IGFjdGl2YXRpbmcgdGhlIGRpc3BsYXkuDQo+ID4gDQo+ID4gSSB3b25kZXIgd2h5IGF0
b21pYyB1cGRhdGUgaXMgY2FsbGVkIGF0IGFsbCB3aGlsZSB0aGUgcGlwZSBpcyBub3QNCj4gPiBl
bmFibGVkLg0KPiANCj4gSXQgY2FuIGJlIG1hZGUgdG8gYmVoYXZlIGRpZmZlcmVudGx5IChzZWUg
YWxzbyBteSByZXZpZXcpLg0KDQpTZXR0aW5nIHRoZSBmcmFtZWJ1ZmZlciBiZWZvcmUgZW5hYmxp
bmcgdGhlIGNydGMgbWFrZXMgc2Vuc2UgdG8gbWUsDQpvdGhlcndpc2UgYW4gaW5pdGlhbCBjb3Jy
dXB0IGZyYW1lIHdvdWxkIGJlIGltcG9zc2libGUgdG8gYXZvaWQuDQoNCkl0J3MganVzdCB0aGF0
IGl0IHNsaWdodGx5IGNvbXBsaWNhdGVzIFBNIGZvciBzaW1wbGUgZGV2aWNlcy4gTWF5YmUNCmRy
bV9zaW1wbGVfZGlzcGxheV9waXBlIGNvdWxkIGhhdmUgcHJlcGFyZS91bnByZXBhcmUgY2FsbGJh
Y2tzIGZvcg0KUE0rbW9kZXNldCBzZXBhcmF0ZSBmcm9tIGp1c3QgY3J0YyBlbmFibGUvZGlzYWJs
ZT8=
