Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74876C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C8021841
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="2LjYG5aO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbeLQKOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:14:12 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:6836 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbeLQKOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:14:11 -0500
X-IronPort-AV: E=Sophos;i="5.56,365,1539673200"; 
   d="scan'208";a="24305539"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 17 Dec 2018 03:14:10 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 17 Dec 2018 03:14:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxa15U0kp5pes+7ee8TlaW4+N2dt/4B0Verv+J+tLqw=;
 b=2LjYG5aOk64GMcpPT56vz6Y1z0eNzOkirVBm97buDI9lp499TrFuB42l34n4sJ1JCaCGmSWUMWbhpMQUUJbYucRC+DUcx5icN/SrA7COfLR1CtRK8ljvZEOIJwAxipDN506svNN+HAh4o5jxJOekdf6otzGS1naKhWsAweKNqwg=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB2046.namprd11.prod.outlook.com (10.169.236.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Mon, 17 Dec 2018 10:14:06 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::d4e0:49b4:1b0a:8ae6]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::d4e0:49b4:1b0a:8ae6%5]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 10:14:06 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] net: macb: restart tx after tx used bit read
Thread-Topic: [PATCH v3] net: macb: restart tx after tx used bit read
Thread-Index: AQHUle+mtil0X1BpLkuEXebjAikpjKWCtoQA
Date:   Mon, 17 Dec 2018 10:14:06 +0000
Message-ID: <b0f326fd-bc67-56ea-3d89-bd353b1135e2@microchip.com>
References: <1545040937-6583-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1545040937-6583-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP265CA0100.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:51::16) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB2046;6:gWfGq2huYnqNk/O2kBoH7rDRoSWL10fxXZfcyHMghgyRAVWQXuFmWWyTQ2PfbP3+MkJXxgiutblV3uCURTZNmUtVHXZPKtpta7IO8N0T/MrNjoARY8A9Ald32dh/pMWMRYO6w6B5FpNordJTgFcgbWMvMwA1y+jaYTpRjwiYPvC6iUqjxkVNNSm6IwYPuAfvbzzq940DithB9nh1QsKpOOrXDdrgHkdD3ZySnfStWwPByBFAgqsl1xeme/nIkznbDnHPkG6kMv62cw4jqf2mRSLaXfUtz8mng2M25dvp4nbPieUU0FI6BgAfGZgwhfkS92RG96/+fkCzEWR2xWIa0T6VfSu8lS80499bdk3xC/GWaANURjbFpdCnk8IixqKuFbIyhihU19V9350xxsvsNALAqfH2Ka3ACn9T1E8JnzpojkM4OfFGqVslBk6egPPrVlas171rd1s6WXe1MjUNgg==;5:G5E5FB8cXoAftXKwrJCOWr0sKlXZnOxYbd6VsVC0fLWPfLCCDVs7FMlslqPT5KxFiRrOXMb1QNlpM34miyCh1OLG6clEmJvo0yCkbSupBA3WZXt6OhqlnzqhMq5RRHO9Fe442o44H/slyuV8xtiY6LsnEn1NwsHVPTqemJoQTZY=;7:DC2bk8u/gqHdjgLTh/ktpomVREXh6bagV4AqlT38XhWmkJQNluBwu/Bir+PwP4R7F9t/9Nk6JboJRJS9va/T/OS2M1Nbh3cDoKzz5zwliUe4dZ47GLFMpy6IY9kus+BIGxwb80bD7FAIJWcD5VE5KA==
x-ms-office365-filtering-correlation-id: 3fad1267-8a5e-4429-a550-08d6640860c0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB2046;
x-ms-traffictypediagnostic: MWHPR11MB2046:
x-microsoft-antispam-prvs: <MWHPR11MB20460DBD0D43151317D5DAC7E0BC0@MWHPR11MB2046.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:MWHPR11MB2046;BCL:0;PCL:0;RULEID:;SRVR:MWHPR11MB2046;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(396003)(136003)(346002)(199004)(189003)(6506007)(4326008)(97736004)(26005)(3846002)(81166006)(53936002)(31686004)(31696002)(106356001)(36756003)(66066001)(256004)(478600001)(72206003)(229853002)(6486002)(2906002)(8936002)(7736002)(54906003)(99286004)(71190400001)(14454004)(486006)(110136005)(71200400001)(6436002)(105586002)(476003)(446003)(14444005)(81156014)(25786009)(11346002)(8676002)(2616005)(2501003)(68736007)(86362001)(6116002)(316002)(386003)(186003)(305945005)(52116002)(76176011)(6512007)(53546011)(102836004)(6246003)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB2046;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tGfivCzyQrbD/gR7+1rcyQaJ0s3hfzaF0dM6WPdssaVHvp3sOSFvQGGH9OQWW1huNj9FHYy2yhXdgkxdCPN3Xd7jXc/GGwKWXQ8fD8uCkzMZYD8xcZUaXZjurtoJ3yBAx+m1Jjp7YKAfByi4Lewb8tKnTwtvpy/sAFvN5SDwrO3GucP4pvfXHTVqVBaeqmrc+EQxWDHpylMO2pzW+fzhi6IBUj41oG3xjgZbc3/+KQTIB0M7spDNKpur9LvTJ60seS8kDE2LS8uxq+w0ePf6HzkNO6G52P5MODQrqjcFzw5A8nWfsjLVzCXemJSEaTqQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7ABF633E6F0EF84E89D98A90397AED5B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fad1267-8a5e-4429-a550-08d6640860c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 10:14:06.7289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2046
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcvMTIvMjAxOCBhdCAxMTowMiwgQ2xhdWRpdSBCZXpuZWEgLSBNMTgwNjMgd3JvdGU6DQo+
IEZyb206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPiAN
Cj4gT24gc29tZSBwbGF0Zm9ybXMgKGN1cnJlbnRseSBkZXRlY3RlZCBvbmx5IG9uIFNBTUE1RDQp
IFRYIG1pZ2h0IHN0dWNrDQo+IGV2ZW4gdGhlIHBhY2hldHMgYXJlIHN0aWxsIHByZXNlbnQgaW4g
RE1BIG1lbW9yaWVzIGFuZCBUWCBzdGFydCB3YXMNCj4gaXNzdWVkIGZvciB0aGVtLiBUaGlzIGhh
cHBlbnMgZHVlIHRvIHJhY2UgY29uZGl0aW9uIGJldHdlZW4gTUFDQiBkcml2ZXINCj4gdXBkYXRp
bmcgbmV4dCBUWCBidWZmZXIgZGVzY3JpcHRvciB0byBiZSB1c2VkIGFuZCBJUCByZWFkaW5nIHRo
ZSBzYW1lDQo+IGRlc2NyaXB0b3IuIEluIHN1Y2ggYSBjYXNlLCB0aGUgIlRYIFVTRUQgQklUIFJF
QUQiIGludGVycnVwdCBpcyBhc3NlcnRlZC4NCj4gR0VNL01BQ0IgdXNlciBndWlkZSBzcGVjaWZp
ZXMgdGhhdCBpZiBhICJUWCBVU0VEIEJJVCBSRUFEIiBpbnRlcnJ1cHQNCj4gaXMgYXNzZXJ0ZWQg
VFggbXVzdCBiZSByZXN0YXJ0ZWQuIFJlc3RhcnQgVFggaWYgdXNlZCBiaXQgaXMgcmVhZCBhbmQN
Cj4gcGFja2V0cyBhcmUgcHJlc2VudCBpbiBzb2Z0d2FyZSBUWCBxdWV1ZS4gUGFja2V0cyBhcmUg
cmVtb3ZlZCBmcm9tIHNvZnR3YXJlDQo+IFRYIHF1ZXVlIGlmIFRYIHdhcyBzdWNjZXNzZnVsIGZv
ciB0aGVtIChzZWUgbWFjYl90eF9pbnRlcnJ1cHQoKSkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBD
bGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCg0KQWNrZWQtYnk6
IE5pY29sYXMgRmVycmUgPG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbT4NCg0KVGhhbmtzLiBC
ZXN0IHJlZ2FyZHMsDQogICBOaWNvbGFzDQoNCj4gLS0tDQo+IA0KPiBDaGFuZ2VzIGluIHYzOg0K
PiAtIHJlbW92ZSAiaW5saW5lIiBrZXl3b3JkDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIHVz
ZSAic3RhdGljIGlubGluZSIgaW5zdGVhZCBvZiAiaW5saW5lIHN0YXRpYyIgZm9yIG1hY2JfdHhf
cmVzdGFydCgpDQo+IA0KPiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L2NhZGVuY2UvbWFjYl9tYWlu
LmMgfCAyMSArKysrKysrKysrKysrKysrKysrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2NhZGVuY2UvbWFjYl9tYWluLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRl
bmNlL21hY2JfbWFpbi5jDQo+IGluZGV4IDFkODZiNGQ1NjQ1YS4uZjkyMDIzMDM4NmVlIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2JfbWFpbi5jDQo+ICsr
KyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2NhZGVuY2UvbWFjYl9tYWluLmMNCj4gQEAgLTYxLDcg
KzYxLDggQEANCj4gICAjZGVmaW5lIE1BQ0JfVFhfRVJSX0ZMQUdTCShNQUNCX0JJVChJU1JfVFVO
RCkJCQlcDQo+ICAgCQkJCQl8IE1BQ0JfQklUKElTUl9STEUpCQlcDQo+ICAgCQkJCQl8IE1BQ0Jf
QklUKFRYRVJSKSkNCj4gLSNkZWZpbmUgTUFDQl9UWF9JTlRfRkxBR1MJKE1BQ0JfVFhfRVJSX0ZM
QUdTIHwgTUFDQl9CSVQoVENPTVApKQ0KPiArI2RlZmluZSBNQUNCX1RYX0lOVF9GTEFHUwkoTUFD
Ql9UWF9FUlJfRkxBR1MgfCBNQUNCX0JJVChUQ09NUCkJXA0KPiArCQkJCQl8IE1BQ0JfQklUKFRY
VUJSKSkNCj4gICANCj4gICAvKiBNYXggbGVuZ3RoIG9mIHRyYW5zbWl0IGZyYW1lIG11c3QgYmUg
YSBtdWx0aXBsZSBvZiA4IGJ5dGVzICovDQo+ICAgI2RlZmluZSBNQUNCX1RYX0xFTl9BTElHTgk4
DQo+IEBAIC0xMzEyLDYgKzEzMTMsMjEgQEAgc3RhdGljIHZvaWQgbWFjYl9ocmVzcF9lcnJvcl90
YXNrKHVuc2lnbmVkIGxvbmcgZGF0YSkNCj4gICAJbmV0aWZfdHhfc3RhcnRfYWxsX3F1ZXVlcyhk
ZXYpOw0KPiAgIH0NCj4gICANCj4gK3N0YXRpYyB2b2lkIG1hY2JfdHhfcmVzdGFydChzdHJ1Y3Qg
bWFjYl9xdWV1ZSAqcXVldWUpDQo+ICt7DQo+ICsJdW5zaWduZWQgaW50IGhlYWQgPSBxdWV1ZS0+
dHhfaGVhZDsNCj4gKwl1bnNpZ25lZCBpbnQgdGFpbCA9IHF1ZXVlLT50eF90YWlsOw0KPiArCXN0
cnVjdCBtYWNiICpicCA9IHF1ZXVlLT5icDsNCj4gKw0KPiArCWlmIChicC0+Y2FwcyAmIE1BQ0Jf
Q0FQU19JU1JfQ0xFQVJfT05fV1JJVEUpDQo+ICsJCXF1ZXVlX3dyaXRlbChxdWV1ZSwgSVNSLCBN
QUNCX0JJVChUWFVCUikpOw0KPiArDQo+ICsJaWYgKGhlYWQgPT0gdGFpbCkNCj4gKwkJcmV0dXJu
Ow0KPiArDQo+ICsJbWFjYl93cml0ZWwoYnAsIE5DUiwgbWFjYl9yZWFkbChicCwgTkNSKSB8IE1B
Q0JfQklUKFRTVEFSVCkpOw0KPiArfQ0KPiArDQo+ICAgc3RhdGljIGlycXJldHVybl90IG1hY2Jf
aW50ZXJydXB0KGludCBpcnEsIHZvaWQgKmRldl9pZCkNCj4gICB7DQo+ICAgCXN0cnVjdCBtYWNi
X3F1ZXVlICpxdWV1ZSA9IGRldl9pZDsNCj4gQEAgLTEzNjksNiArMTM4NSw5IEBAIHN0YXRpYyBp
cnFyZXR1cm5fdCBtYWNiX2ludGVycnVwdChpbnQgaXJxLCB2b2lkICpkZXZfaWQpDQo+ICAgCQlp
ZiAoc3RhdHVzICYgTUFDQl9CSVQoVENPTVApKQ0KPiAgIAkJCW1hY2JfdHhfaW50ZXJydXB0KHF1
ZXVlKTsNCj4gICANCj4gKwkJaWYgKHN0YXR1cyAmIE1BQ0JfQklUKFRYVUJSKSkNCj4gKwkJCW1h
Y2JfdHhfcmVzdGFydChxdWV1ZSk7DQo+ICsNCj4gICAJCS8qIExpbmsgY2hhbmdlIGRldGVjdGlv
biBpc24ndCBwb3NzaWJsZSB3aXRoIFJNSUksIHNvIHdlJ2xsDQo+ICAgCQkgKiBhZGQgdGhhdCBp
Zi93aGVuIHdlIGdldCBvdXIgaGFuZHMgb24gYSBmdWxsLWJsb3duIE1JSSBQSFkuDQo+ICAgCQkg
Ki8NCj4gDQoNCg0KLS0gDQpOaWNvbGFzIEZlcnJlDQo=
