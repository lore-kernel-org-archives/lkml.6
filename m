Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33267C2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD522085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="cE0L7b7G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbfAUPhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:37:17 -0500
Received: from mail-eopbgr60095.outbound.protection.outlook.com ([40.107.6.95]:52480
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728807AbfAUPhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:37:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwpwSRIKl/gG/zFRSSKtELSdgxzjssTmBdAjqvYR7as=;
 b=cE0L7b7Gx7fhSxIqP2lAAcbavWZOzjS4kTbaBwm9Xu1Z8LU4HXWUich164hPzvmy8T2U2Mr/ZtFDZ4ePV3Dm2qh3TcGqTDn+81ymXOC4Yzgan2/uCKZU23KOA9YPHooP+at9AT901qmyxdBi9Dq0naOUWng+VEm1P3xU3ZCR+Y8=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1PR0501MB2430.eurprd05.prod.outlook.com (10.168.135.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Mon, 21 Jan 2019 15:37:12 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::edef:e9d3:e4e3:e7c3]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::edef:e9d3:e4e3:e7c3%2]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 15:37:11 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "fugang.duan@nxp.com" <fugang.duan@nxp.com>
CC:     Max Krummenacher <max.krummenacher@toradex.com>,
        "dev@pschenker.ch" <dev@pschenker.ch>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: fec: get regulator optional
Thread-Topic: [PATCH] net: fec: get regulator optional
Thread-Index: AQHUsZnW7v1WwT/wsUWY6dCbzJ2PcaW52yQA
Date:   Mon, 21 Jan 2019 15:37:11 +0000
Message-ID: <d1e9d19d78fb41480b21aadc7f273dca12f7472a.camel@toradex.com>
References: <20190121145847.30223-1-stefan@agner.ch>
In-Reply-To: <20190121145847.30223-1-stefan@agner.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2430;6:CTLGeqG+iXtAtxk2axBvSitdLaVgK+z1UN2PT0nwzwBRQ12LMrcKZ6/sPthHJ3QQtOBzxCfs5Xf/4H3KijCHJfFyEanUcjQEyNvjPz8HDaTMPK5Bw7HdPHBkurLUMcQekWxCLs0nNOztJlpibrwnCHCP7ITNi6RQvjwJT48tAvVcSy8z4ofuE2mGt+nzS68d7Qwv/rvHcZXsW5iiqTpQW4yx+UtY2mUORPGSwSuI0mJUTbJUDHqCOMqwF4ZbkLtTYZNZi1zkY8jvEntRdtiCTALLiPbt9iqzpK+K/v6R/7TuGN/idGoCc8odnIyB+3g+43ZmpIb+3fDk2KylSz7ptMpc5pFNPCpt4CvvR9dcL+fEyn30K8fmKU54hPTavXUhlVz5VXcTUKs6av5h9I4o+OeTdS5lDGurkoVGl603YW/gpKL840F8Z1ah3TJaXxzXYJmnhuasHz3kOG4EnVfAOA==;5:zA4Irh+AwVvwkhx1Zpx8Gk4znxEz37iaZU/4Ob5PuQIugqEs9UfFwAer2AxPdhMdlOzm29mrIfiE7YpFz9HzQkiO9e3hrl1wuaKDgMPCGOKxkpazqtyKP7+yeULMOWmAgyIenolX1vNIG9hL6BmhRHXyPKT6vWr5O7e40Wq5J+HXvEk03WN7KV6Pg+obSLu9jU/YUn9dspnb+Z4ejFLKiA==;7:9utkILjcqeguCbyfQJLam1qP9FpLqV+v+oYahSgRiNUymonOuumfOFyo7lOTAUXHfkgQrl3FQ2gCewuWOomhVtz8lhvb2P/JIpiV+PXuCQ4z0Uaf8FztGrXw2LJDwdYhg3eBywS5hYCq5SJiVHdfcQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39850400004)(396003)(136003)(199004)(189003)(26005)(229853002)(186003)(6506007)(25786009)(11346002)(110136005)(54906003)(102836004)(86362001)(6116002)(2201001)(446003)(76176011)(53936002)(3846002)(99286004)(6512007)(6246003)(6486002)(6436002)(316002)(68736007)(4326008)(2616005)(476003)(2501003)(44832011)(97736004)(486006)(256004)(36756003)(71190400001)(14444005)(81166006)(14454004)(2906002)(71200400001)(305945005)(106356001)(81156014)(8676002)(478600001)(118296001)(8936002)(105586002)(66066001)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0501MB2430;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 6379497d-e60c-439e-0ab7-08d67fb64fb8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2430;
x-ms-traffictypediagnostic: VI1PR0501MB2430:
x-microsoft-antispam-prvs: <VI1PR0501MB24305909CD3E25830EDA0208FB9F0@VI1PR0501MB2430.eurprd05.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /NmtqBhXJrcYP6VrtMIvKbbbUIUBBbiRqTDapDDPbHfF2f1bIRYHfaGfCaa8R4a54Rntme54OgPpYtuFD5qWsrWCuxXsgKlbzoZVrSQjn6xWPCS/SJ8SXrQZlVMlnuvVESUHx679mXatFh1h7+3zcOynSEo7R4ovsrRWVC7/fsZMgnr26lCLPTo18hplNtTZibzVlcS2NgNBiiXMybuDD69Mhy5Lm9cWm6ahbJiyiQDx29QuGy2A6wi19tk4Ee4y03PDE3xt4TK4ODIec7jqFp7tXwBNeZaR6Y7/IFGqu4OaCOUU0N2NtST77Wl0NfcuW4zMzPtGPVKXz3/6DT0i2T3bvNbSsoupUV2sbwAPoxeWjeEtNbt4K3HzxuxsPxUCdStcRCEcnInpzWLzmIx+WDvvTXy4VDBRS9rt55z8ed0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1DB8CFA9089B1488B7008B086DFD823@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6379497d-e60c-439e-0ab7-08d67fb64fb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 15:37:11.6479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2430
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTAxLTIxIGF0IDE1OjU4ICswMTAwLCBTdGVmYW4gQWduZXIgd3JvdGU6DQo+
IEFjY29yZGluZyB0byB0aGUgZGV2aWNlIHRyZWUgYmluZGluZyB0aGUgcGh5LXN1cHBseSBwcm9w
ZXJ0eSBpcw0KPiBvcHRpb25hbC4gVXNlIHRoZSByZWd1bGF0b3JfZ2V0X29wdGlvbmFsIEFQSSBh
Y2NvcmRpbmdseS4gVGhlDQo+IGNvZGUgYWxyZWFkeSBoYW5kbGVzIE5VTEwganVzdCBmaW5lLg0K
PiANCj4gVGhpcyBnZXRzIHJpZCBvZiB0aGUgZm9sbG93aW5nIHdhcm5pbmc6DQo+ICAgZmVjIDIx
ODgwMDAuZXRoZXJuZXQ6IDIxODgwMDAuZXRoZXJuZXQgc3VwcGx5IHBoeSBub3QgZm91bmQsIHVz
aW5nDQo+IGR1bW15IHJlZ3VsYXRvcg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU3RlZmFuIEFnbmVy
IDxzdGVmYW5AYWduZXIuY2g+DQoNClJldmlld2VkLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNl
bC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0
L2ZyZWVzY2FsZS9mZWNfbWFpbi5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVl
c2NhbGUvZmVjX21haW4uYw0KPiBpbmRleCA2ZGI2OWJhMzBkY2QuLmM4MzE1ZDg4MGM4YyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4g
KysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gQEAgLTM0
NzksNyArMzQ3OSw3IEBAIGZlY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
PiAgCWlmIChyZXQpDQo+ICAJCWdvdG8gZmFpbGVkX2Nsa19pcGc7DQo+ICANCj4gLQlmZXAtPnJl
Z19waHkgPSBkZXZtX3JlZ3VsYXRvcl9nZXQoJnBkZXYtPmRldiwgInBoeSIpOw0KPiArCWZlcC0+
cmVnX3BoeSA9IGRldm1fcmVndWxhdG9yX2dldF9vcHRpb25hbCgmcGRldi0+ZGV2LCAicGh5Iik7
DQo+ICAJaWYgKCFJU19FUlIoZmVwLT5yZWdfcGh5KSkgew0KPiAgCQlyZXQgPSByZWd1bGF0b3Jf
ZW5hYmxlKGZlcC0+cmVnX3BoeSk7DQo+ICAJCWlmIChyZXQpIHsNCg==
