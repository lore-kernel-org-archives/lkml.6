Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36876C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1C220827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="uJrz7o0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1C220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbeKFTRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:17:08 -0500
Received: from mail-eopbgr40107.outbound.protection.outlook.com ([40.107.4.107]:43840
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729241AbeKFTRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 14:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77u+2ExwM5bmUrtJ68cIId2Ne3E1MpwM8eMzBBvrCq4=;
 b=uJrz7o0zLYUfDkcdHYmIDWlsLKJuPBqMfy1UtEZ30QMuf8UH+zQ9hsfxhy6lm6ZzykNIFYobfaN3TN1+tP8qAFaCS2fpC7B3iHBHzJkbLjgSGngSPzozYEIWB7COfyj9BbW26fujl6qiSRtYMZhGZ3cISvAn0NBKo+aLmDWlG2k=
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com (10.168.137.14) by
 VI1SPR00MB253.eurprd05.prod.outlook.com (10.175.186.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Tue, 6 Nov 2018 09:52:37 +0000
Received: from VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::acd8:cd0c:4b28:84bd]) by VI1PR0501MB2590.eurprd05.prod.outlook.com
 ([fe80::acd8:cd0c:4b28:84bd%7]) with mapi id 15.20.1294.034; Tue, 6 Nov 2018
 09:52:37 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "sashal@kernel.org" <sashal@kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 4.14 069/143] ARM: tegra: Fix ULPI regression on Tegra20
Thread-Topic: [PATCH 4.14 069/143] ARM: tegra: Fix ULPI regression on Tegra20
Thread-Index: AQHUct0lyDGDgl0BVkimwQnHWBD3DKU85rGAgABmGwCAA+7GgIABE3EAgAA4JYA=
Date:   Tue, 6 Nov 2018 09:52:37 +0000
Message-ID: <1541497955.11252.2.camel@toradex.com>
References: <20181102182857.064326086@linuxfoundation.org>
         <20181102182902.797148907@linuxfoundation.org>
         <CADVatmOX9FfVGZhFgAZ1sVvnigucFD9DuUu+K8444mTN=Qr+6w@mail.gmail.com>
         <20181103020224.GK194472@sasha-vm> <1541426747.7086.15.camel@toradex.com>
         <20181106063138.GB151445@sasha-vm>
In-Reply-To: <20181106063138.GB151445@sasha-vm>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1SPR00MB253;6:2UcVpK44JT46B+G9iuIuc5RtlKZwkssaGW8Czyj7h/hTsln2p13C1m+wDNTBE2HuNXvZ0E3S+zZ++rd57UWTh3FihzxxwSiSE7VVzwGFnLz2zEAXBNUcwiolokwDGnecp/171Vty9BdEUCdYMmd10oTAd1iNPFRyySLAsFmNQLCBCh2RkU66b8LqgJOhxGJNFgI3Ms2VFQESyNNRFVdMTvL7Mg9KpOt+JE7AKXPP3LQpttp6pXyKUkDt7LJTtRtUjCBFYmH+bQcEZUAjyMVHmC7PBkiudvy9NRkVOUK5Ra/xs7cC1FJdux3yZIBIuzWpc+YW0/IKNNlMkORO1TboBkU3QSetzhZiXumDzxO7t2KnfVMmOx8ReC1wgJiHdT2O5FvXKrwBvZrSmS+1dhr9LPNIFDxEelU/AsBsNh1wnZ72P/YL5zaWPVl48tNVpOf5J/r6S+QffOMBkhYjnj7TiA==;5:3n9qx08i1wgmZnPp6nBNAGP+r5iFhOOzw6KCm4UzI8fOls5gCpTSFhRZD0f+XBcGnNU5EDRpixS1XWBBfUxvUWWhq7kosTAFG20dryJj+EoMgmimYD8H4L5GngHRRK1jESBldSextwYt9ys67DbnUJ7K0y14/Af0DnmVsGBYdoM=;7:Ut6WrElT4UUdernl5MlmwL8uoF987MlrWO7AXbCqH/nhDaTd1wuFw+iT7rHixV8swpKaFfoPT5tR54totUBcGEn5uLZ28xxoeyX2jBIxoFrquNlpVj6atbUGwGahlWK5DBtrsdDPepJy2rzU9BhAlQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3c8f1568-e471-49d2-9daf-08d643cd9593
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1SPR00MB253;
x-ms-traffictypediagnostic: VI1SPR00MB253:
x-microsoft-antispam-prvs: <VI1SPR00MB253FEFAE684172030B6A837FBCB0@VI1SPR00MB253.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(2016111802025)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1SPR00MB253;BCL:0;PCL:0;RULEID:;SRVR:VI1SPR00MB253;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39840400004)(376002)(346002)(396003)(366004)(199004)(189003)(36756003)(99286004)(486006)(316002)(6436002)(93886005)(7736002)(54906003)(305945005)(53546011)(6506007)(39060400002)(476003)(8936002)(508600001)(5660300001)(2616005)(44832011)(6246003)(76176011)(26005)(71190400001)(1730700003)(4326008)(186003)(102836004)(81156014)(71200400001)(86362001)(81166006)(8676002)(6486002)(5640700003)(68736007)(2501003)(105586002)(14454004)(256004)(229853002)(66066001)(6916009)(446003)(25786009)(11346002)(97736004)(106356001)(53936002)(103116003)(3846002)(14444005)(6512007)(6116002)(2351001)(2906002)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1SPR00MB253;H:VI1PR0501MB2590.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mgbObHjunauWRKlCSAnk17u+aOAdynk47J2FLp/Fqk5iLRSDil2c+kXvuMIX9A3atCy5AA5QPJmVeGit+2pVJaZVmoi5kC1mwy4kO6dlfo+b8RDkdAlq/Dy7kfbCPBBTqn93nBZpN5YpWfzGJyv26OD0MzfJN+5HwbOTPFzLhBknnfDJlqsFbkwIw/J/nxoFbFRacWSzKQznXzX3Fc0TdqzLKT4zS9FUVva2T2+qXCfiy5OlCBxPQkq3FcHyGE0sCcbqzAomXR8MGlSlgnTqG84gGmbLUafL2Z/rf+bNufOD7da8IKtDGHUwS9TWWTcfRbndzQSs8vWY6PsE1Gx0iLstvWtMOJaoySEiJaNZJQw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF8CFEF190A0ED48A17EA13FDA9E6529@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8f1568-e471-49d2-9daf-08d643cd9593
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 09:52:37.4418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1SPR00MB253
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTExLTA2IGF0IDAxOjMxIC0wNTAwLCBTYXNoYSBMZXZpbiB3cm90ZToNCj4g
T24gTW9uLCBOb3YgMDUsIDIwMTggYXQgMDI6MDU6NDlQTSArMDAwMCwgTWFyY2VsIFppc3dpbGVy
IHdyb3RlOg0KPiA+IE9uIEZyaSwgMjAxOC0xMS0wMiBhdCAyMjowMiAtMDQwMCwgU2FzaGEgTGV2
aW4gd3JvdGU6DQo+ID4gPiBPbiBGcmksIE5vdiAwMiwgMjAxOCBhdCAwNzo1Njo1N1BNICswMDAw
LCBTdWRpcCBNdWtoZXJqZWUgd3JvdGU6DQo+ID4gPiA+IEhpIEdyZWcsDQo+ID4gPiA+IA0KPiA+
ID4gPiBPbiBGcmksIE5vdiAyLCAyMDE4IGF0IDY6NTMgUE0gR3JlZyBLcm9haC1IYXJ0bWFuDQo+
ID4gPiA+IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gNC4xNC1zdGFibGUgcmV2aWV3IHBhdGNoLiAgSWYgYW55b25lIGhhcyBhbnkgb2Jq
ZWN0aW9ucywNCj4gPiA+ID4gPiBwbGVhc2UNCj4gPiA+ID4gPiBsZXQgbWUga25vdy4NCj4gPiA+
ID4gDQo+ID4gPiA+IEl0IHNlZW1zIHRoaXMgaGFzIGFscmVhZHkgYmVlbiByZXZlcnRlZCB1cHN0
cmVhbToNCj4gPiA+ID4gOWJmNGUzNzAwNDhkICgiQVJNOiBkdHM6IHRlZ3JhMjA6IFJldmVydCAi
Rml4IFVMUEkgcmVncmVzc2lvbg0KPiA+ID4gPiBvbg0KPiA+ID4gPiBUZWdyYTIwIiIpDQo+ID4g
PiANCj4gPiA+IFRoZSBjb21taXQgbG9nIG9mIDliZjRlMzcwMDQ4ZCBzdWdnZXN0cyB0aGF0IHRo
aXMgaXNzdWUgd2FzIGZpeGVkDQo+ID4gPiBzb21ld2hlcmUgZWxzZSB3aGljaCBtYWRlIDliZjRl
MzcwMDQ4ZCB1bm5lY2Vzc2FyeS4gQ2FuIHNvbWVvbmUNCj4gPiA+IHBvaW50DQo+ID4gPiB0bw0K
PiA+ID4gdGhhdCBmaXg/DQo+ID4gDQo+ID4gWWVzLCBzb3JyeS4gVGhhdCBnb3QgZml4ZWQgcHJv
cGVybHkgYnkgRG1pdHJ5IGluIDVkNzk3MTExYWZlMQ0KPiA+ICgiY2xrOg0KPiA+IHRlZ3JhOiBB
ZGQgcXVpcmsgZm9yIGdldHRpbmcgQ0RFVjEvMiBjbG9ja3Mgb24gVGVncmEyMCIpLg0KPiANCj4g
VGhhbmsgeW91LiBJJ3ZlIHJlcGxhY2VkIGl0IGZvciA0LjE0LCBidXQgZm9yIDQuOSBpdCBzZWVt
cyB0aGVyZSBhcmUNCj4gcXVpdGUgYSBmZXcgZGVwZW5kZW5jaWVzIHRvIHBpY2sgNWQ3OTcxMTFh
ZmUxIHNvIEkgb25seSByZW1vdmVkDQo+IDRjOWEyN2E2YzY2ZC4gSWYgeW91IGhhdmUgYSBiYWNr
cG9ydCBmb3IgNC45IEknbGwgYmUgaGFwcHkgdG8gdGFrZQ0KPiBpdC4NCg0KSSBiZWxpZXZlIHRo
ZSBwYXJ0aWN1bGFyIHByb2JsZW0gSSB3YXMgc2VlaW5nIGRpZCBub3QgZXhoaWJpdCBpdHNlbGYN
CmJlZm9yZSBtdWNoIGxhdGVyIHRoYW4gNC45IG9yIDQuMTQgYW5kIHdhcyBjYXVzZWQgYnkgc29t
ZSByZS13b3JrIG9mDQp0aGUgY2xvY2tpbmcgc3R1ZmYgd2hpY2ggc2xpZ2h0bHkgY2hhbmdlZCBv
cmRlciBvZiB0aGluZ3MgYmVpbmcNCmluaXRpYWxpc2VkLg0KDQo+IC0tDQo+IFRoYW5rcywNCj4g
U2FzaGE=
