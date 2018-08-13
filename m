Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE575C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DC821761
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uCHFrUbS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DC821761
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbeHMQB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:01:26 -0400
Received: from mail-db5eur01on0056.outbound.protection.outlook.com ([104.47.2.56]:5920
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728547AbeHMQB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtbWsJGXFW5/fcTB6vOS9R2wXSAlljYfHcLScgm7YCE=;
 b=uCHFrUbSQJbsLnFYIEUxAZB14OglBC6H+qsCkxQkS0fQarOASkcnAsz5Ln601UVupPWK2cM7uzfomAu1OFF8Uc+ElFDUcKta7suiJ9f/f3vnF9NAFIOXQ0J9WZSmlPkdH9nRCXpt3FsD8fu64GG3ak1stLMAfZWncO8tdfGnsVA=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4131.eurprd04.prod.outlook.com (52.134.125.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.23; Mon, 13 Aug 2018 13:19:06 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273%5]) with mapi id 15.20.1038.019; Mon, 13 Aug 2018
 13:19:06 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        "marex@denx.de" <marex@denx.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v4 1/5] drm/mxsfb: Move axi clk enable/disable to crtc
 enable/disable
Thread-Topic: [PATCH v4 1/5] drm/mxsfb: Move axi clk enable/disable to crtc
 enable/disable
Thread-Index: AQHULzIwn7JBQwBum0OgRJQS/fkvMaS2NQmAgAd8/YA=
Date:   Mon, 13 Aug 2018 13:19:06 +0000
Message-ID: <9924032f27426ec6cc36f645deb70014a674006c.camel@nxp.com>
References: <cover.1533743954.git.leonard.crestez@nxp.com>
         <f0d719af219a7f922bcc0746e9f840c471c56c5d.1533743954.git.leonard.crestez@nxp.com>
         <19cefc44fb2888fa0de4c54f1e8c9bd9@agner.ch>
In-Reply-To: <19cefc44fb2888fa0de4c54f1e8c9bd9@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4131;6:AadzHs0nIMhLSRjHmMV0BKGir510hvIakQndkwhkVIwgZz+rRVP7C8I39G+aDDnZJqk4s5JWe+zEfHlWKyeBVz7nOcPjmhS9okMW8TkZgGO9MBdfqi2cfUuYtChu5XMO4YNLcwvJwjTFJiYEkdmBo1owq8y0vmnxns2PEnbDPm65IGiXCYuhex+6UgfXqQ/v4k4E6V2MVpxRSNkXKTKE8umc57KELQs21TUawN3le04lz5ucZn4ARL4QdX9Tb9Vz7lqG55Ry9xI5F9styWdMQGKnWg2nr+VMx6h4MnZ4FNRXhKBkhrIxh6rzD3qHpMuZG5V1NlLije8jn4xU7VbOrkqkILcXI402sz6ERip7GPAJetFUoA76+MD7wdeUT5cUB7AhSCK6JAmYEQ4fk/1FcOAugxIf8gfQdImlfFFmwWO0co8Vp6rA4sFR9TpSRix+faOusv26ChyefT7gLfQC0Q==;5:+ilVZNvjAY6pYSuAEcXsY/RgMGZoosD815lazSYEy/kn0Ug41hqT43tmW3nB/HmpHuLhUC6g7tOCWlFqFpIUQdxqm9t/szozu5uKjgekQCkzPNLrILt6L7Kw+EAlq/Keb78lkurrC5bHLEDVr96yrvbJDTsMB6N+1Cw/RSi7/nE=;7:oak6o056kDgAwix894ZV0POO8Qph+c440pvMmmozCraIowJFbI3BdMK7lJJDGvtnywMAIH4muQkYaLaxaqTBk3s3xBI9bno52FsFGNxOCrZA7G5uXIQARHVM+lbF8GiUGa34NoL2jm19Wj57m539cuvWsf8dIv0pnbpfVMRLGVKwGihqPgJLAqhBw4PMOvFjyJnkyrNR7pyrhoEv9hIlcRdrys6I4SCMq2ZGJNn8WoZHzYTFjd9ZqRHc0uoeq2GC
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f29a01c9-8691-4194-1375-08d6011f5906
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4131;
x-ms-traffictypediagnostic: AM0PR04MB4131:
x-microsoft-antispam-prvs: <AM0PR04MB4131964E4842903102D379FBEE390@AM0PR04MB4131.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4131;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4131;
x-forefront-prvs: 07630F72AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(39860400002)(136003)(346002)(199004)(189003)(478600001)(966005)(14454004)(476003)(486006)(44832011)(229853002)(256004)(2616005)(4326008)(7736002)(25786009)(76176011)(6486002)(50226002)(14444005)(102836004)(26005)(6116002)(3846002)(186003)(66066001)(11346002)(316002)(53546011)(8936002)(6506007)(446003)(2906002)(8676002)(118296001)(81156014)(81166006)(6246003)(36756003)(99286004)(5660300001)(53936002)(86362001)(54906003)(106356001)(2501003)(2900100001)(110136005)(305945005)(6512007)(6306002)(5250100002)(105586002)(6436002)(97736004)(68736007)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4131;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FkTC8VtAzroCRghBH1gaZH4axvTR5eaY0k1ArwcbNaVslkR0YgNtOncBMieoTzb5CxkYu/5+MkpT9RMtyApSwC3Kr8bXL1ogmZX5J43nAbXMf++1StODa9hCmeTf06Onu4RTf4ATQAnXgdy6i3poyKdCI9LLVBRX554BuemJdhCr3SHjllwn36eYKStiq6OeVhp7veEnlR5gEDhgnfPooJHuyUpAxcqAYqwutxZp8qbHBYFOEeRyZWPHS/w3vuN2WjZ9EoJR/lEjsEqEHNRaElf7+wYYTPWSz65bkrAWtFCCS+QK6gW5yuboHXuH8NeYlmnhE2qxMIpN+ZWkSyloDgvg/s9vlknQXlYkfm3/vhM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB7875B1316B3243A9AE0277B710D4DB@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29a01c9-8691-4194-1375-08d6011f5906
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2018 13:19:06.7107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA4LTA4IGF0IDIwOjU3ICswMjAwLCBTdGVmYW4gQWduZXIgd3JvdGU6DQo+
IE9uIDA4LjA4LjIwMTggMTg6MDgsIExlb25hcmQgQ3Jlc3RleiB3cm90ZToNCj4gPiBUaGUgbWFp
biBheGkgY2xrIGlzIGRpc2FibGVkIGF0IHRoZSBlbmQgb2YgbXhzZmJfY3J0Y19tb2RlX3NldF9u
b2ZiIGFuZA0KPiA+IGltbWVkaWF0ZWx5IHJlZW5hYmxlZCBpbiBteHNmYl9lbmFibGVfY29udHJv
bGxlci4NCj4gPiANCj4gPiBBdm9pZCB0aGlzIGJ5IG1vdmluZyB0aGUgaGFuZGxpbmcgb2YgYXhp
IGNsayBvbmUgbGV2ZWwgdXAgdG8NCj4gPiBteHNmYl9jcnRjX2VuYWJsZS4gRG8gdGhlIHNhbWUg
Zm9yIG14c2ZiX2NydGNfZGlzYWJsZSBmb3Igc2ltbWV0cnkNCj4gPiANCj4gPiBUaGlzIHNob3Vs
ZG4ndCBoYXZlIGFueSBmdW5jdGlvbmFsIGVmZmVjdC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPg0KPiANCj4gVGhhbmtz
LCBsb29rcyBnb29kIQ0KPiANCj4gUmV2aWV3ZWQtYnk6IFN0ZWZhbiBBZ25lciA8c3RlZmFuQGFn
bmVyLmNoPg0KDQpTbyB3aGF0IGlzIG5leHQgbm93IHRoYXQgdGhpcyBlbnRpcmUgc2VyaWVzIHdh
cyByZXZpZXdlZD8gTXkgZ3Vlc3MgaXMNCnRoYXQgc29tZWJvZHkgbmVlZHMgdG8gcHVzaCBpdCB0
byBkcm0tbWlzYy1uZXh0Lg0KDQpIb3dldmVyIDQuMTggd2FzIGp1c3QgcmVsZWFzZWQgYW5kIEkn
bSBub3Qgc3VyZSBob3cgdGhpcyBpbnRlcmFjdHMgd2l0aA0KZHJtLiBBcyBmYXIgYXMgSSBjYW4g
dGVsbCBkcm0tbWlzYy1uZXh0IGlzIGFsd2F5cyBvcGVuIGFuZCBhIHBhdGNoDQphY2NlcHRlZCBu
b3cgd2lsbCBtYWtlIGl0IGludG8gNC4yMCwgYmFzZWQgb24gdGhpcyBncmFwaDoNCg0KaHR0cHM6
Ly8wMS5vcmcvbGludXhncmFwaGljcy9nZngtZG9jcy9tYWludGFpbmVyLXRvb2xzL2RybS1taXNj
Lmh0bWwjbWVyZ2UtdGltZWxpbmUNCg0KLS0NClJlZ2FyZHMsDQpMZW9uYXJk
