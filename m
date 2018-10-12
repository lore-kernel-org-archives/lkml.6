Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126A5C28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 01:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3BB2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 01:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rU0fBtCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3BB2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbeJLItw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 04:49:52 -0400
Received: from mail-eopbgr60042.outbound.protection.outlook.com ([40.107.6.42]:14416
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726108AbeJLItv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 04:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qklcMITJ0Af7XQgcdvQdM/f67yPoeha3vzzDx8Ce3c=;
 b=rU0fBtCUflAfvaOwPuDhLP0JhsOA9aKrtQE2SAcUngXWk3Tv/d08xpOOOjCKGuK/lSn9XCbewuDiqDy+/jqAQdKPEncRdst1Ved45lM6rV15uRTknkjqntrjVi/d+3j0VBOoHXzFA6H4Nq4V4wbpDpsfPAZZJoTnt1DROwOcgEY=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB1246.eurprd04.prod.outlook.com (10.162.121.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Fri, 12 Oct 2018 01:19:53 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::5c50:30f3:3805:71f9]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::5c50:30f3:3805:71f9%4]) with mapi id 15.20.1228.020; Fri, 12 Oct 2018
 01:19:53 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Frieder Schrempf <frieder.schrempf@exceet.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] usb: chipidea: Add minimal support for HSIC interface on
 i.MX6QDL
Thread-Topic: [RFC] usb: chipidea: Add minimal support for HSIC interface on
 i.MX6QDL
Thread-Index: AQHUXwsDLRUbQlbQbUi4BM689kvOEaUWHfPwgAJUEICAAmL4sA==
Date:   Fri, 12 Oct 2018 01:19:53 +0000
Message-ID: <VI1PR04MB532710F1E99B016C52FCDBAD8BE20@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <1539005352-10909-1-git-send-email-frieder.schrempf@exceet.de>
 <VI1PR04MB5327D0F4AA27C5AED5C535388BE70@VI1PR04MB5327.eurprd04.prod.outlook.com>
 <e13ac59e-6698-8ef2-685e-75cd5ed35d98@exceet.de>
In-Reply-To: <e13ac59e-6698-8ef2-685e-75cd5ed35d98@exceet.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1246;6:ewc2bllFEi7MqloIPq69aMZduxF8FC0ZjypRWg5oPXmF1McJbgMOX7gtYnvOg/ZJwKy4g/F6ocGpVMdWOkndOpsFslmxy5ixPvY2V2HnQjxHLF8XlCy1Scho+oEgnyiFrNyW4uROtmDMYjPeV1ysbYnwG9FB53e73P8wDte1lzkJbBTh/kxt8eyRyjWRw4FxNN1sONjbJxbZkZ0BAoTKYTvCKQA2Niw92KdUjn3EoAHj55+1tL6mfuOPYltS8g+gGRQLCr5n6Y6eKmV6JkLSG0qDzujjl38PtkbPSWWrXnK8aGsMtu0znpT71uB4x2urUzns4ZrJO+L2t8cUX+ahY03wJnQk8m/Dj/iwBQb+5215it0B8bfuguTwZ+A0C7/+vTHUp7NHw93zTN79Cf8WuHpTyjTN/G4LFXrUvo67R6pp+xM6jdRYPQvnN5Wn+2TC5zVX0wCLkKbMr4rUorQe6g==;5:KcpFjEVR1IshuR5Xl0R8mw4XuhCdZI6eeMLWv07b3MVZ6VcF9H6YrqHLHZvaAu93tBA1OUZ5TNUDbG8c8hjhCZUffaTmTJMbI/H5B46Z+ddiKTmaBKC7iRlp9+ls8ZZ7fYQwSDynVKC3+2IYbl3rxRBBTp3ip2VLm7dsmfbZ1DE=;7:z1yRtSzd4Bo7Gqohsjy6w8pDrJUECcJjtR0waMTsVGJxk+1Lq9rITDmTnqcG19rvbAhFwxlysPgXcyh1s14Mp4CMhHXpPzNYmbaVN28ufklHbjf0ZE0t8mGHP2kp4em9+Z4ngKqwpzhBRwE+iP7ACZD66ev3EarKp3w8lwKr8Xk0jkqeKVlQt0neCI3uDCySKzPlI2vE41OHF+9MEFT7DJ6QwBxjaP9o1Llv2loEXDZhEyYs+lqM4G5+DKgZQwQ5
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 54c9c126-cd96-49d6-b9fa-08d62fe0d09a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1246;
x-ms-traffictypediagnostic: VI1PR04MB1246:
x-microsoft-antispam-prvs: <VI1PR04MB12468650882DE6002A1308628BE20@VI1PR04MB1246.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:VI1PR04MB1246;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1246;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(366004)(136003)(189003)(199004)(71200400001)(71190400001)(14454004)(478600001)(9686003)(2900100001)(6916009)(2906002)(55016002)(256004)(14444005)(53936002)(68736007)(4326008)(3846002)(6116002)(6246003)(25786009)(8936002)(316002)(81156014)(81166006)(105586002)(11346002)(446003)(476003)(7736002)(5250100002)(486006)(5660300001)(106356001)(6506007)(8676002)(33656002)(76176011)(102836004)(229853002)(99286004)(186003)(26005)(74316002)(97736004)(7696005)(305945005)(6436002)(86362001)(54906003)(44832011)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1246;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gB5CixJmWdurnXSOp/mqeflmQQX9hY9RFK4+/lRcGw9G+I0lPqep5EfEZ7yVGnEKS+zojAQ7OMWXU/5gzCZOq0nRWvACXHSYxGXUABSS4af08K62Li8Yw2ebzcNGjp4S3wGDyWkNFtUmRBH0j86YdDkB50UEHkWCC1QTRK4cZ253Idajg+cXn5KtkmPeeUQ40pBIRQO2dB9Mp3OZs9zV82dKtmyQitZuDZS1zFSXuwyMvSPENV5hfUw5pKPSVHuvgd6KzSfQ1Q8WGINN1u2h8uZ+pQLmFAo6F+sape7+0YQ+rzt3zdkhHRrgvv0JM3YGuzbZr1rSbU5ZA4aqeWEzFoc1Q6Wby2MTlEp10e82aXM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c9c126-cd96-49d6-b9fa-08d62fe0d09a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 01:19:53.7273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1246
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiA+IFRoYW5rcywgSSBzaG91bGQgZG8gaXQgZWFybGllciwgSSBjb3VsZCBub3QgZmluZCBh
IHN1aXRhYmxlIGJvYXJkIHdpdGggSFNJQyBzdXBwb3J0DQo+IGF0IG1haW5saW5lIGtlcm5lbC4N
Cj4gPiBJdCBpcyB2ZXJ5IGtpbmQgdGhhdCB5b3UgY291bGQgaGVscCBvbiBpdCBhbmQgdGVzdCBm
dW5jdGlvbiBhdCByZWFsDQo+ID4gYm9hcmQuIE15IHN1Z2dlc3Rpb24gaXMgZm9sbG93IGFsbCBm
bG93cyBpbiBMaW5rIFsyXSBzaW5jZSB3ZSBuZWVkIHRvIGNvdmVyDQo+IHN1c3BlbmQvcmVzdW1l
IGFuZCByZW1vdGUgd2FrZXVwLg0KPiANCj4gSXQgc2VlbXMgbGlrZSBwb3dlciBtYW5hZ2VtZW50
IGFuZCBvdGhlciB0aGluZ3MgaW4gdGhlIGxpbnV4LWlteCBrZXJuZWwgYXJlIG5vdA0KPiBmdWxs
eSBpbXBsZW1lbnRlZCBpbiBtYWlubGluZSBzbyB0aGVyZSBhcmUgcXVpdGUgYSBmZXcgZGlmZmVy
ZW5jZXMuDQo+IA0KPiBNeSBrbm93bGVkZ2Ugb2YgVVNCLCBldGMuIGlzIHZlcnkgbGltaXRlZCwg
c28gSSBndWVzcyB0aGlzIGlzIGN1cnJlbnRseSBiZXlvbmQgbXkNCj4gc2tpbGxzLiBDYW4geW91
IG9yIHNvbWVvbmUgZWxzZSBwcm92aWRlIGEgcGF0Y2ggdG8gZ2V0IHN0YXJ0ZWQ/IEkgY291bGQg
aGVscCB3aXRoDQo+IHRlc3RpbmcsIHJldmlld2luZywgZXRjLg0KPiANCiANCk9rLCBJIHdpbGwg
c3VwcGx5IHRoZSBwYXRjaCwgYW5kIHlvdSBjb3VsZCBhZGQgeW91ciBkdHMgY2hhbmdlcyBhcyB3
ZWxsIGFzIHRlc3RpbmcuDQpUaGFua3MuDQoNClBldGVyDQo=
