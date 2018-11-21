Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67808C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F322087E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fqrsuorA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F322087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeKUPlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 10:41:32 -0500
Received: from mail-eopbgr130079.outbound.protection.outlook.com ([40.107.13.79]:6905
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725939AbeKUPlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 10:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDo5P4XsPG7y88C52Rr8PZZu4CCehGIQrrQY3T1qjdQ=;
 b=fqrsuorAdkftb4mbyXGGjB2+6ToVdIHBw42/d7/mqLknyrEokkX9Zbv5zdQ062UR40hiKLERUFlVai8OKMHx8oFcdJVXFwXjSFBCcbQk+YAgkFMd55f+HoYsLeMQxxS42CzamIuAG1E8g8I1DdOoi3sMam65scr8B5MHPz6bQ/Q=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3705.eurprd04.prod.outlook.com (52.134.70.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Wed, 21 Nov 2018 05:08:35 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.048; Wed, 21 Nov 2018
 05:08:35 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3] thermal: imx: fix for dependency on cpu-freq
Thread-Topic: [PATCH V3] thermal: imx: fix for dependency on cpu-freq
Thread-Index: AQHUgUOOUNfbKOmxbEi5Wn+3w8jwqKVZmTkAgAAUplA=
Date:   Wed, 21 Nov 2018 05:08:35 +0000
Message-ID: <DB3PR0402MB39168AB875C41ACD185F7CA0F5DA0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1542767703-1984-1-git-send-email-Anson.Huang@nxp.com>
 <CAOh2x==PecS4OzoX3UagBE0RjQL-0BBC=r=MAaO3cA2MczrA=A@mail.gmail.com>
In-Reply-To: <CAOh2x==PecS4OzoX3UagBE0RjQL-0BBC=r=MAaO3cA2MczrA=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3705;6:aNYZXOrOns933w97YoAiebo4Sqh8Wz2Y+z+RNgNMeP7jFPB+IYmzlFgd02EVF2olGC2figAa5Uow0i8Ead3rbHf0OHtdiXoXx+vwA3JQq85ca1ZQ8SDvqWtig0HXWFYPhxUwxvIgN7TI16cN4oyAG3ZjaFKpgjM5oPGr3dvZ83Ff0SvMsCYlPU4QpNKL2shnnitbkMZtToVgZWPRcdpJ5dDYgjv48w2T4s8kyahnjc1IkZ0QxOiqJVTOMxgvj/9W/GMaIxJTfg92zenfTFEbNlspOEdOHdkoLdmi2t2KtmfMNe0Wh1eAZ/cFxBSMc0rYhZ5ZSLZeywPc4VM8fErSySO/YRLBe+SI1qTVwRKmUfseRq5m8244G9192YkQPSwyAZ0ZrG7W/FX0mCif4MfOhLje6y778srP32fPyZZBlWGf/Z0mb1SP9e6pgXuKRY8Z+FXZb3uv2E/9sM/ZOH+G9g==;5:YNV4QXFhmsusByDD0zExYm2ON9FaLvoe0MBPRfnOK5QREnEIg1mT8BM6uyY1rI+1YSMQ6iTDY2xXvkWDCVFoNCrXXRAWE++7JaNkZUo+jEGxw0oEjNhLTKlsT1JZfjL9UIdcJKLfsf8xau4rGA7WPiwEyfzCUxDzNTC0gmhl8qU=;7:yTsMyYnWc6HLEHU3a+RTL5kkFBiFrM/SzU3W9P4tTYrjMFWWZ3IBvmE8FomSmJ/RB5YBshwyyNs6HfPP5DPSxKzu1Sv02AZv2AFAnhjvaXoFkATUmoMtSL7ZTLmCw1eXxztWJ/n3pbcH44aqRzbYrQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: dfb99c82-3a80-47f7-c48d-08d64f6f6427
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3705;
x-ms-traffictypediagnostic: DB3PR0402MB3705:
x-microsoft-antispam-prvs: <DB3PR0402MB3705F75FD1A1C6821E3BD296F5DA0@DB3PR0402MB3705.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231442)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3705;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3705;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(366004)(376002)(13464003)(189003)(199004)(478600001)(39060400002)(486006)(14454004)(106356001)(476003)(105586002)(68736007)(33656002)(2900100001)(11346002)(446003)(4326008)(6116002)(3846002)(5660300001)(44832011)(2906002)(53936002)(6436002)(6246003)(6916009)(55016002)(9686003)(54906003)(316002)(71190400001)(25786009)(99286004)(305945005)(7736002)(186003)(26005)(97736004)(76176011)(81156014)(53546011)(81166006)(66066001)(102836004)(6506007)(8936002)(7696005)(74316002)(86362001)(256004)(71200400001)(8676002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3705;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6zJ8Gsb5HJZmrWHJkv5+TehnuqslvWyUusHy0U4ToP91mTOzHg8PwhI1nigBzJtLGy5/5i3/HwOQnPsAkeFZUGzr6oasFh/thsOkpXaiyKgPSo1pgiK6E081PMJLEnBAEWFNGq/PWIlkypM0R4xmUjcYnP57oCQLol5TO3Qzm5DmlNm4ByrK/Gub+3M1x6gF5ARkXLxeCNNDkzJZJdP0m3gbARuUJRzwP7uAMYnjkuO7e9sVwMF44QzjNTa/1Ml9plXnNIK9MFjDzfaYqnpcfCbIG6PMbwWVJYbVUq2mKoA76PUXKnRntzOXFPq9gIW8fUHyQdbWMIeOWFxf4uU4SxlYkE2B87jAk6upq4K4WyI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb99c82-3a80-47f7-c48d-08d64f6f6427
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 05:08:35.9235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3705
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogVmlyZXNoIEt1bWFyIFttYWlsdG86dmlyZXNoLmt1bWFyQGxpbmFyby5v
cmddDQo+IFNlbnQ6IDIwMTjlubQxMeaciDIx5pelIDExOjU0DQo+IFRvOiBBbnNvbiBIdWFuZyA8
YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gQ2M6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNv
bT47IEVkdWFyZG8gVmFsZW50aW4NCj4gPGVkdWJlenZhbEBnbWFpbC5jb20+OyBEYW5pZWwgTGV6
Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz47IExpbnV4DQo+IFBNIGxpc3QgPGxpbnV4
LXBtQHZnZXIua2VybmVsLm9yZz47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QNCj4gPGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOyBkbC1saW51
eC1pbXgNCj4gPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYzXSB0
aGVybWFsOiBpbXg6IGZpeCBmb3IgZGVwZW5kZW5jeSBvbiBjcHUtZnJlcQ0KPiANCj4gT24gV2Vk
LCBOb3YgMjEsIDIwMTggYXQgODoxMSBBTSBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNv
bT4NCj4gd3JvdGU6DQo+IA0KPiA+IEBAIC04MzAsOCArODUxLDcgQEAgc3RhdGljIGludCBpbXhf
dGhlcm1hbF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiA+ICBjbGtf
ZGlzYWJsZToNCj4gPiAgICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShkYXRhLT50aGVybWFs
X2Nsayk7DQo+ID4gIGNwdWZyZXFfcHV0Og0KPiANCj4gV2hpbGUgYXQgaXQsIHJlbmFtZSB0aGlz
IGxhYmVsIGFzIHdlbGwgdG8gc29tZXRoaW5nIGxpa2UgbGVnYWN5X2NsZWFudXAuDQoNCkRvbmUg
d2l0aCBWNCBwYXRjaCwgdGhhbmtzLg0KDQpBbnNvbi4NCg0KPiANCj4gPiAtICAgICAgIGNwdWZy
ZXFfY29vbGluZ191bnJlZ2lzdGVyKGRhdGEtPmNkZXYpOw0KPiA+IC0gICAgICAgY3B1ZnJlcV9j
cHVfcHV0KGRhdGEtPnBvbGljeSk7DQo+ID4gKyAgICAgICBpbXhfdGhlcm1hbF91bnJlZ2lzdGVy
X2xlZ2FjeV9jb29saW5nKGRhdGEpOw0KPiA+DQo+ID4gICAgICAgICByZXR1cm4gcmV0Ow0KPiA+
ICB9DQo=
