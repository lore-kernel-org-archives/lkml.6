Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966E7C46469
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 18:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54184217B7
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 18:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XQFr64s6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54184217B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbeHCUEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 16:04:36 -0400
Received: from mail-eopbgr50045.outbound.protection.outlook.com ([40.107.5.45]:14368
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727356AbeHCUEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 16:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1IhrzxkrGr8VlALkA+DRG8erJ2i7p/uTAR55z6l3EQ=;
 b=XQFr64s6AdSJcvaSSNh9fGYmPp6dmrv+VA7adeTy+i+OzpGmu7dfMqQJMYYAvJeUeWhJzd461tDsoqovqwqmTIeJvm6KeVPjNmH9I7sOvowy1OW171KX4ot/KJHRZTMiXkFkHrxTRoPcDXn9E/XwqjbiX7UEh60vHoIgxIojLnA=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4337.eurprd04.prod.outlook.com (52.134.126.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Fri, 3 Aug 2018 18:07:09 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273%5]) with mapi id 15.20.1017.010; Fri, 3 Aug 2018
 18:07:09 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     Richard Zhu <hongxing.zhu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC] PCI: imx: Add multi-pd support
Thread-Topic: [RFC] PCI: imx: Add multi-pd support
Thread-Index: AQHUI3qj7YIZZjz5Gkie2VtYh1QPdaSpCxaAgAVXigA=
Date:   Fri, 3 Aug 2018 18:07:09 +0000
Message-ID: <53f9f939dbce11e1c96986ff41f29dd6e41b9220.camel@nxp.com>
References: <8018069bc772376caef29e76280e4d0facffdb68.1532455922.git.leonard.crestez@nxp.com>
         <CAPDyKFpN99iDYf1mcG-G1=AAkiw8OjoynvK+5cBV8GvCs6WtKg@mail.gmail.com>
In-Reply-To: <CAPDyKFpN99iDYf1mcG-G1=AAkiw8OjoynvK+5cBV8GvCs6WtKg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4337;6:70UKBFfFpiC2JnutMzJQBi6hYwP95tfvU/jj+j2k9mDAufmpgmgwAVwi1CVpHGSy14whAbbrKDsaVOWiXFrb+V8JFbjO2w9hTaR1J5tJT/cNDpjkuqk1CD3rLyAVxbFwc/K5Mj7RDhaqUEqTI6fpSbeDsflwIg+ee0Gr1rIbNhzRriFUsPfSwJuCnsV+LEjZ/t4Zhu+TCoZOBsA5dKoYacvVfTJYyIoSJDy/rNB01gyJBwA7J7Dv2brKXWePzKd2wLwVgeZocfub9jB7m95RLFj+Ah4IXFxLQ5+4e8RBhrqU72zwt3LrIQK7p+viJHECKSESmYAj15Taw/0Qx4dy1iF1Ehy9H9hbSizYvOGEJmUl9Tu+wD2rRxv2tSxov6cseFXKu3hppoEcQ1goWNc0yaQsbZEVIh/TaUeyulm/y+18R8OK2xEHgzxWUGYF6/37b+lyp1bdXjVwpnmqVHm0gg==;5:busYd5fv8RhCzlsCxVcy1oGMSfj0tLe+TZOjOqy46qv99SI5cRKreTapZONYkVwrqJ5tOi6gzTdiWjeYniNszsqK2SJPehW/STZ83Xj8LHqIpUPj3wf6dBHDWmnt4/IBX8FnfgQjYG/0VUw61jBWizNB6FVkNIpDuNQaLAxepvs=;7:moQGN/TmHXUQ7ZNIO/tGVj/QxFGC0frXiro9R5glnfGaY7fiSo1DcSxYPT1QIXjzLVVS19Zihs3KDnOveD96GKvks6HcRsZrU06tw44NqvG5XvbmXnXz4Mf9f2R5V7ZukXWjCopTBEr9tv1LXoFs4T4XW0VM2egVAIbvG7v28r+fkh1jYBS71LM3w/4Y2hmfCm6Ud1VilgOUWNVsz1fs5QkdrPANLv1HZ/B1Fz79BjGylNrBpdM9QmgXHUpsuMXh
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d8724a92-60d3-4a37-0e41-08d5f96bee0b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4337;
x-ms-traffictypediagnostic: AM0PR04MB4337:
x-microsoft-antispam-prvs: <AM0PR04MB4337181D913F883777876A4CEE230@AM0PR04MB4337.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4337;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4337;
x-forefront-prvs: 0753EA505A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(396003)(366004)(189003)(199004)(229853002)(14454004)(66066001)(305945005)(106356001)(3846002)(5640700003)(6486002)(2351001)(6116002)(105586002)(2906002)(6436002)(5250100002)(2501003)(7736002)(478600001)(39060400002)(5660300001)(36756003)(25786009)(44832011)(99286004)(186003)(26005)(8936002)(76176011)(81156014)(6916009)(7416002)(446003)(476003)(2616005)(50226002)(54906003)(316002)(68736007)(2900100001)(86362001)(8676002)(6506007)(53936002)(81166006)(4326008)(6246003)(11346002)(102836004)(14444005)(5024004)(53546011)(118296001)(97736004)(6512007)(256004)(486006)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4337;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: F9lBvNuxGLB/0YYl1hf3mEqV0tz30CbR2Juh7jDYJB2ekjOZqkGel7wsO4GWmI/CcH+9jVO/bKw+qbcn56Bi9Y1qzqwimZvl8M4R2WFMMrNhRYFugqvU+LXXYGD2pChfTG0J+H1u34IdkdfCOE8dgCSESa/Ccq0LIC4EEiQDqQbcvEDn5+lzBiNQHN7McUhEYd+wqsPAw7AUQagUfwJa1Pjesnn7dVHyt4eJxHFLfnnkp6XvCU/iTNjURhXU0uHNdtWwo7ktByXydRLkqOK/gV1A0QycFmlII///9PwzpB+RTGAAqb9sU3at6/twNT20CrfyrL8XQbknIW6d7+fCgidR0bsBqqSIvZP2XkHGJrk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B04ACE21F8C2A04CB2EE9769B597C5F6@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8724a92-60d3-4a37-0e41-08d5f96bee0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2018 18:07:09.1630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4337
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA3LTMxIGF0IDEwOjMyICswMjAwLCBVbGYgSGFuc3NvbiB3cm90ZToNCj4g
T24gMjQgSnVseSAyMDE4IGF0IDIwOjE3LCBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3Rl
ekBueHAuY29tPiB3cm90ZToNCj4gPiBPbiBzb21lIGNoaXBzIHRoZSBQQ0lFIGFuZCBQQ0lFX1BI
WSBibG9ja3MgYXJlIGluIHNlcGFyYXRlIHBvd2VyIGRvbWFpbnMNCj4gPiB3aGljaCBjYW4gYmUg
cG93ZXItZ2F0ZWQgaW5kZXBlbmRlbnRseS4gVGhlIGRyaXZlciBuZWVkcyB0byBoYW5kbGUgdGhp
cw0KPiA+IGJ5IGtlZXBpbmcgYm90aCBkb21haW4gYWN0aXZlLg0KPiA+IA0KPiA+IFRoaXMgaXMg
aW50ZW5kZWQgZm9yIGlteDZzeCB3aGVyZSBQQ0lFIGlzIGluIERJU1BNSVggYW5kIFBDSUVfUEhZ
IGluDQo+ID4gaXQncyBvd24gZG9tYWluLiBEZWZpbmluZyB0aGUgRElTUE1JWCBkb21haW4gcmVx
dWlyZXMgYSB3YXkgZm9yIHBjaWUgdG8NCj4gPiBrZWVwIGl0IGFjdGl2ZSBvciBpdCB3aWxsIGJy
ZWFrIHdoZW4gZGlzcGxheXMgYXJlIG9mZi4NCj4gPiANCj4gPiBUaGUgcG93ZXItZG9tYWlucyBv
biBpbXg2c3ggYXJlIG1lYW50IHRvIGxvb2sgbGlrZSB0aGlzOg0KPiA+ICAgICAgICAgcG93ZXIt
ZG9tYWlucyA9IDwmcGRfZGlzcD4sIDwmcGRfcGNpPjsNCj4gPiAgICAgICAgIHBvd2VyLWRvbWFp
bi1uYW1lcyA9ICJwY2llIiwgInBjaWVfcGh5IjsNCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBM
ZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPg0KPiBSZXZpZXdlZC1ieTog
VWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQoNClRoYW5rcyBmb3IgdGFraW5n
IHRoZSB0aW1lIHRvIGxvb2sgYXQgdGhpcywgSSB3aWxsIGxpa2VseSByZXBvc3QgdGhpcw0KYXMg
UEFUQ0ggaW4gYSBzZXJpZXMgbGF0ZXIuDQoNCj4gPiBSaWdodCBub3cgaWYgYSBkZXZpY2UgaGFz
IGEgc2luZ2xlIHBvd2VyIGRvbWFpbiBpdCB3aWxsIGJlIGFjdGl2YXRlZA0KPiA+IGJlZm9yZSBw
cm9iZSBidXQgaWYgaXQgaGFzIG11bHRpcGxlIGRvbWFpbnMgdGhleSBuZWVkIHRvIGJlIGV4cGxp
Y2l0bHkNCj4gPiAiYXR0YWNoZWQiIHRvIGFuZCBjb250cm9sbGVkLiBTdXBwb3J0aW5nIGJvdGgg
aXMgYSBiaXQgYXdrd2FyZCwgdGhpcw0KPiA+IHBhdGNoIG1ha2VzIHRoZSBkaXN0aW5jdGlvbiBi
YXNlZCBvbiAoZGV2LT5wbV9kb21haW4gIT0gTlVMTCkuDQo+ID4gDQo+ID4gTWF5YmUgdGhlIFBN
IGNvcmUgc2hvdWxkIG1ha2UgdGhpcyBkaXN0aW5jdGlvbiBiYXNlZCBvbiBhIGZsYWcgaW4gc3Ry
dWN0DQo+ID4gZGV2aWNlX2RyaXZlciBpbnN0ZWFkIG9mIG51bWJlciBvZiBwb3dlci1kb21haW5z
PyBTbyBieSBkZWZhdWx0IHdoZW4gYQ0KPiA+IGRldmljZSBoYXMgbXVsdGlwbGUgcG93ZXIgZG9t
YWlucyB0aGV5IHdvdWxkIHdvdWxkIGJlIGFjdGl2YXRlZA0KPiA+IHRvZ2V0aGVyIGFuZCB0aGlz
IHBhdGNoIHdvdWxkIGJlIHVubmVjZXNzYXJ5Lg0KPiANCj4gQWN0aXZhdGlvbiBpcyBkZWxpYmVy
YXRlbHkgbGVmdCB0byBiZSBtYW5nZWQgYnkgZWFjaCB1c2VyLCBhcyB0aGUgUE0NCj4gY29yZS9n
ZW5wZCBjYW4ndCBrbm93IHdoZW4gcG93ZXJpbmcgb24gdGhlIFBNIGRvbWFpbnMgbWFrZSBzZW5z
ZS4NCg0KQnkgZGVmYXVsdCB0aGUgUE0gY29yZSBjb3VsZCB0cmVhdCBhIGxpc3Qgb2YgcG0gZG9t
YWlucyBqdXN0IGxpa2UgaXQNCnRyZWF0cyBhIGRvbWFpbiBub3cuIE15IHBhdGNoIGRvZXNuJ3Qg
ZG8gYW55dGhpbmcgcGNpLXNwZWNpZmljLCBpdCBqdXN0DQphdHRhY2hlcyBhbGwgZG9tYWlucyBh
bmQgY3JlYXRlcyBkZXZpY2UgbGlua3MuIENvdWxkbid0IHRoZSBjb3JlIGRvDQp0aGlzPw0KDQo+
IFRoZSBtYWluIHJlYXNvbiB0byB3aHkgZ2VucGQgcG93ZXJzIG9uIHRoZSBQTSBkb21haW4gZm9y
IHRoZSBzaW5nbGUgUE0NCj4gZG9tYWluIGNhc2UsIGlzIGJlY2F1c2Ugb2YgbGVnYWN5IGJlaGF2
aW9ycyBpbiBkcml2ZXJzLg0KDQpXb3VsZG4ndCBpdCBiZSBuaWNlciB0byBvdXQtb3V0IG9mIHN1
Y2ggbGVnYWN5IGJlaGF2aW9ycyB3aXRoIGEgZmxhZyBpbg0Kc3RydWN0IGRyaXZlciBpbnN0ZWFk
IG9mIHNpbmdsZS12ZXJzdXMtbXVsdGlwbGUgZG9tYWlucz8NCg0KPiA+IFRoZSBkZXZpY2VfbGlu
ayBpcyBtYXJrZWQgYXMgIlNUQVRFTEVTUyIgYmVjYXVzZSBvdGhlcndpc2UgYSB3YXJuaW5nIGlz
DQo+ID4gdHJpZ2dlcmVkIGluIGRldmljZV9saW5rc19kcml2ZXJfYm91bmQuIFRoaXMgc2VlbXMg
dG8gaGFwcGVuIGJlY2F1c2UgdGhlDQo+ID4gcGQgZGV2aWNlcyBhcmUgYWx3YXlzIG1hcmtlZCBh
cyAiRExfREVWX05PX0RSSVZFUiIuIE1heWJlIHRoZXkgc2hvdWxkIGJlDQo+ID4gaW5zdGVhZCBh
bHdheXMgYmUgbWFya2VkIGFzIERMX0RFVl9EUklWRVJfQk9VTkQ/DQo+IA0KPiBVc2luZyBTVEFU
RUxFU1MgaXMgY29ycmVjdCwgYmVjYXVzZSB0aGUgc3VwcGxpZXIgZGV2aWNlcywgd2hpY2ggYXJl
DQo+IG1hbmFnZWQgYnkgZ2VucGQgZG9uJ3QgaGF2ZSBhbnkgZHJpdmVyIGF0dGFjaGVkIHRvIHRo
ZW0uDQoNCkFzIGZhciBhcyBJIGNhbiB0ZWxsIHRoZXNlIGdlbnBkX2RldiBkZXZpY2VzIG5lZWQg
dG8gYmUgbWFudWFsbHkNCnVucmVnaXN0ZXJlZCBpbiB0aGUgY29uc3VtZXIncyByZW1vdmUgZnVu
Y3Rpb24sIHJpZ2h0PyBJZiB0aGV5IHdlcmUNCm1hcmtlZCB3aXRoIERMX0RFVl9EUklWRVJfQk9V
TkQgdGhlbiB5b3UgY291bGQgdXNlDQpETF9GTEFHX0FVVE9SRU1PVkVfU1VQUExJRVIgb24gdGhl
bS4NCg0KQXMgZmFyIGFzIEkgY2FuIHRlbGwgdGhlIERMX0RFVl8qIHN0YXRlcyBhcmUgdXNlZCB0
byBkZWFsIHdpdGggcHJvYmluZw0Kb3JkZXIgYnV0IHNpbmNlIG5vIGRyaXZlciB3aWxsIGV2ZXIg
YmluZCB0byB0aGVzZSBzdXBwbGllcnMgd2UgY291bGQNCnRyZWF0IHRoZW0gYXMgZWZmZWN0aXZl
bHkgYWx3YXlzIGJvdW5kcy4NCg0KDQpQZXJoYXBzIHRoaXMgY2FuIGJlIHJldmlzaXRlZCBsYXRl
ciwgaW14LXBjaSBpcyBub3QgYSB2ZXJ5IGdvb2QgdXNlY2FzZQ0KZm9yIHRoaXMgYmVjYXVzZSBp
dCBkb2Vzbid0IGV2ZW4gc3VwcG9ydCByZW1vdmUu
