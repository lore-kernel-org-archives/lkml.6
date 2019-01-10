Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45B3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B863206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="e0eaSSwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfAJSvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:51:40 -0500
Received: from mail-eopbgr150130.outbound.protection.outlook.com ([40.107.15.130]:46208
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727000AbfAJSvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:51:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eRcYr0zfyS/t91uH/JUWF0T+8RavFfKOOdOGvqb9bU=;
 b=e0eaSSwRfOeRR4/js1wtLOprdk0p37wxV2OHPFfSqCoSL19/rM9FOLl3hN9U0iwj5dkAd/v3u1MVYlnyHhkRHKSLTBmGLap1mlXIPcYH2nXR7LOS8BOPWqC5+poqjkqlEK62w3zf9OPo36sYZRLW8m6tyYuSPAP0XLykeMUJhiI=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB4485.eurprd02.prod.outlook.com (20.177.196.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Thu, 10 Jan 2019 18:51:22 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.016; Thu, 10 Jan 2019
 18:51:22 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Boris Brezillon <bbrezillon@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 4/4] drm/atmel-hlcdc: do not immediately disable planes,
 wait for next frame
Thread-Topic: [PATCH 4/4] drm/atmel-hlcdc: do not immediately disable planes,
 wait for next frame
Thread-Index: AQHUqParKHXTvsIK8EaTrDTiqxp7vKWowhmAgAAW64A=
Date:   Thu, 10 Jan 2019 18:51:21 +0000
Message-ID: <a31e6514-1643-9e47-cbb4-3323183fd370@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
 <20190110151020.30468-5-peda@axentia.se> <20190110182904.5efd08f2@bbrezillon>
In-Reply-To: <20190110182904.5efd08f2@bbrezillon>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0901CA0051.eurprd09.prod.outlook.com
 (2603:10a6:3:45::19) To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR02MB4485;6:piBcS54mCxeoYQlnkYoRzMCiI5YBeMZk0CruVzn85NUonAuhwPtEu3fm15nJLksnsR0ImcrgOsIbq232IhbeaQEPA50BhZrtdfiJV7Dpiqneq5DXUe37BXvfk2R3Lbxvl++BGpeO1n6ey6cBzjRG0m7jSG/vFBTxuXBfSA+atGwfCIeBdkP4pvyMZ/9XIyjvRxmnCI4hs91JHSdwdO0sqTWQvVRDdh/lfTL45nvKmxrIa9BTtSefFIPyPRiCobdzhOutvfRXD5XM4XTy6n0mEdwjlK85bPrY6rgBbHKnRoFMWcg6MxrnsgdO3t5VfmwIBZYbScdKtF/c56S8OVvnO/ljNQ4eR5rfVddC49RLMhD5HcUtNv8l9dtK0jSEAKY+dSdcxWskkU8H5i/CCgoxfZdhTj+bIcr4snbvsi+jSDsgRMS4rcwTdukTzAm8Z8JXdimTrSorFvqA6Qy+4v7Xrw==;5:CWyuIRmM1zqg0v0A8mPfBCdVsnezTr2D21QifmNnyt1yGQvdv1KamFZV/1t/ZmxcbOjltCxtUJbMdq4YTNgnOr6/kmfljVbu8T5Rm0ibPakG15q5s939Foi3FgTJYamzO+3PuFoWDxFNgZAqe1hChZDwULNw/mTW6wKhuBRYL7YXNcyq+Fa0h7n8fVhOdgGr/gsO1LnnQpRO5yQf2jegsQ==;7:8kokNrpOymnBgiiwfCJXBsVcBSPycSHw5CGlGgRdjKzg1r8AyjQRLMZq1U95BdL55kv9w64+ARh9yFoi1+9qE5iQu421S4SBqNAZv6BgO6uHRdhb/Qoxg/7CWVuFP0Y5mYUVHTByWTG5jezi49bIQA==
x-ms-office365-filtering-correlation-id: ebd4ae03-4e34-4dac-441c-08d6772c9cf0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR02MB4485;
x-ms-traffictypediagnostic: AM6PR02MB4485:
x-microsoft-antispam-prvs: <AM6PR02MB4485FA8901ED0258E5B15048BC840@AM6PR02MB4485.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(6041310)(20161123560045)(20161123558120)(20161123564045)(2016111802025)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM6PR02MB4485;BCL:0;PCL:0;RULEID:;SRVR:AM6PR02MB4485;
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39830400003)(136003)(376002)(366004)(346002)(189003)(199004)(229853002)(5660300001)(14454004)(8676002)(36756003)(76176011)(8936002)(386003)(6916009)(53546011)(6436002)(102836004)(65826007)(6506007)(86362001)(31696002)(6486002)(81166006)(31686004)(81156014)(99286004)(52116002)(316002)(508600001)(3846002)(6116002)(106356001)(97736004)(25786009)(54906003)(7736002)(305945005)(58126008)(105586002)(2906002)(486006)(74482002)(71200400001)(2616005)(6246003)(476003)(14444005)(6512007)(66066001)(256004)(64126003)(65806001)(11346002)(65956001)(53936002)(71190400001)(446003)(26005)(68736007)(4326008)(186003)(14773001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB4485;H:AM6PR02MB4470.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Do9W+swun3Jod8AJYlpwRkNn09y8q7bAT6M6pMnzxjZf7liMn/eU6zhK+OlGS/5f32LbV9KgBZfIRJ/cSFIq0Xt7nyCVusFjmDAaXqLwaiJMGVxTiICs9aW2xE2JXaALifi3fHOfUuxQV/nV9c0bM6FZ2NmcrN1rEWEazSfQ+GhnulKTE/kQIT8/71beFkOUX3JKFAsH9su5jYpGHb9ydoTFDsZbVJEWEuv3Irtjf/gQm9b39C+Z6b7lRAAiO78mLOw5gq4szMqD5lpqiUaYXFJRv+bm/dSig/jYahH/7erbe10xCe9mFEGdVaoKfKdU
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8D1CE5D5B041B4CA9B8EB38E274A41E@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd4ae03-4e34-4dac-441c-08d6772c9cf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 18:51:20.7206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4485
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMS0xMCAxODoyOSwgQm9yaXMgQnJlemlsbG9uIHdyb3RlOg0KPiBPbiBUaHUsIDEw
IEphbiAyMDE5IDE1OjEwOjQ4ICswMDAwDQo+IFBldGVyIFJvc2luIDxwZWRhQGF4ZW50aWEuc2U+
IHdyb3RlOg0KPiANCj4+IFRoZSBBMlEgYW5kIFVQREFURSBiaXRzIGhhdmUgbm8gZWZmZWN0IGlu
IHRoZSBjaGFubmVsIGRpc2FibGUgcmVnaXN0ZXJzLg0KPj4gSG93ZXZlciwgc2luY2UgdGhleSBh
cmUgcHJlc2VudCwgYXNzdW1lIHRoYXQgdGhlIGludGVudGlvbiBpcyB0byBkaXNhYmxlDQo+PiBw
bGFuZXMsIG5vdCBpbW1lZGlhdGVseSBhcyBpbmRpY2F0ZWQgYnkgdGhlIFJTVCBiaXQsIGJ1dCBv
biB0aGUgbmV4dA0KPj4gZnJhbWUgc2hpZnQgc2luY2UgdGhhdCBpcyB3aGF0IEEyUSBhbmQgVVBE
QVRFIG1lYW5zIGluIHRoZSBjaGFubmVsIGVuYWJsZQ0KPj4gcmVnaXN0ZXJzLg0KPj4NCj4+IERp
c2FibGluZyB0aGUgcGxhbmUgb24gdGhlIG5leHQgZnJhbWUgc2hpZnQgaXMgZG9uZSB3aXRoIHRo
ZSBFTiBiaXQsDQo+PiBzbyB1c2UgdGhhdC4NCj4gDQo+IEl0J3MgYmVlbiBhIGxvbmcgdGltZSwg
YnV0IEkgdGhpbmsgSSBoYWQgYSBnb29kIHJlYXNvbiBmb3IgZm9yY2luZyBhDQo+IHJlc2V0LiBJ
SVJDLCB3aGVuIHlvdSBkb24ndCBkbyB0aGF0IGFuZCB0aGUgQ1JUQyBpcyBkaXNhYmxlZCBiZWZv
cmUgdGhlDQo+IHBsYW5lLCB0aGUgRU4gYml0IHN0YXlzIGFyb3VuZCwgYW5kIG5leHQgdGltZSB5
b3UgcXVldWUgYSBwbGFuZSB1cGRhdGUsDQo+IHlvdSdsbCBzdGFydCB3aXRoIGFuIGludmFsaWQg
YnVmIHBvaW50ZXIuDQoNCkl0IG1pZ2h0IGJlIHBvc3NpYmxlIHRvIGNsZWFyIHRoZSBFTiBiaXQg
aW4gLi4uQ0hEUiBiZWZvcmUgZW5hYmxpbmcgdGhlDQpwbGFuZSBpbiAuLi5DSEVSLiBPciBpcyB0
aGF0IHRvbyBsYXRlPyBCdXQgdGhpcyBwYXRjaCBpcyBub3Qgb3Zlcmx5DQppbXBvcnRhbnQsIEkg
anVzdCB3YW50ZWQgdG8gYXZvaWQgdGhlIHJlc3VsdGluZyAiYmxhY2sgaG9sZSIgd2hlbiB0aGUN
CnBsYW5lIERNQSBpcyBkaXNhYmxlZCBtaWQtZnJhbWUuIEJ1dCBkaXNhYmxpbmcgcGxhbmVzIGlz
IHByb2JhYmx5IG5vdA0Kc29tZXRoaW5nIHRoYXQgaGFwcGVucyBmcmVxdWVudGx5IGFuZCB3aWxs
IHBlcmhhcHMgbm90IGJlIG5vdGljZWQgYXQNCmFsbC4uLg0KDQpDaGVlcnMsDQpQZXRlcg0KDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgUm9zaW4gPHBlZGFAYXhlbnRpYS5zZT4NCj4+IC0t
LQ0KPj4gIGRyaXZlcnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19wbGFuZS5jIHwg
NCArLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygt
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxf
aGxjZGNfcGxhbmUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19w
bGFuZS5jDQo+PiBpbmRleCAwNTUxOWU4YzY1ODYuLmYyZjU3MDY0MmY4NCAxMDA2NDQNCj4+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19wbGFuZS5jDQo+PiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfcGxhbmUuYw0KPj4g
QEAgLTcyOCw5ICs3MjgsNyBAQCBzdGF0aWMgdm9pZCBhdG1lbF9obGNkY19wbGFuZV9hdG9taWNf
ZGlzYWJsZShzdHJ1Y3QgZHJtX3BsYW5lICpwLA0KPj4gIA0KPj4gIAkvKiBEaXNhYmxlIHRoZSBs
YXllciAqLw0KPj4gIAlhdG1lbF9obGNkY19sYXllcl93cml0ZV9yZWcoJnBsYW5lLT5sYXllciwg
QVRNRUxfSExDRENfTEFZRVJfQ0hEUiwNCj4+IC0JCQkJICAgIEFUTUVMX0hMQ0RDX0xBWUVSX1JT
VCB8DQo+PiAtCQkJCSAgICBBVE1FTF9ITENEQ19MQVlFUl9BMlEgfA0KPj4gLQkJCQkgICAgQVRN
RUxfSExDRENfTEFZRVJfVVBEQVRFKTsNCj4+ICsJCQkJICAgIEFUTUVMX0hMQ0RDX0xBWUVSX0VO
KTsNCj4+ICANCj4+ICAJLyogQ2xlYXIgYWxsIHBlbmRpbmcgaW50ZXJydXB0cyAqLw0KPj4gIAlh
dG1lbF9obGNkY19sYXllcl9yZWFkX3JlZygmcGxhbmUtPmxheWVyLCBBVE1FTF9ITENEQ19MQVlF
Ul9JU1IpOw0KPiANCg0K
