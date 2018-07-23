Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB6DECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B272F20875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="I7Zwq1g/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B272F20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388057AbeGWO5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:57:15 -0400
Received: from mail-eopbgr30056.outbound.protection.outlook.com ([40.107.3.56]:52267
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387801AbeGWO5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUlkN59Cz2cF6oeqBEAT8KFpm7dEjlLURR9Jtv7jiDY=;
 b=I7Zwq1g/TW5Yz4S8t2jqyAMa8dRdlrl+CK4d8EUHqsN4IOAaYJEXLdI02gRJbxtUpT4Vv9dC1ngRnUMs5FL1ND/doErMAFa6mWwTirYMEdG27SHq1tBqdDZkKxapQQx1nRY4k6J24Xi7a3r+tY+ns16CHdfJd7wmr1425gjz3TI=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB3063.eurprd04.prod.outlook.com (10.170.213.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Mon, 23 Jul 2018 13:55:47 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd%4]) with mapi id 15.20.0973.022; Mon, 23 Jul 2018
 13:55:47 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] dmaengine: imx-sdma: allocate max 20 bds for one
 transfer
Thread-Topic: [PATCH v3 3/3] dmaengine: imx-sdma: allocate max 20 bds for one
 transfer
Thread-Index: AQHUImnwBRfF8kmj8ke3SHRmSu0CG6ScoiYAgAARf8A=
Date:   Mon, 23 Jul 2018 13:55:47 +0000
Message-ID: <DB6PR04MB322323354B2184421502FC5889560@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <1532367972-29707-1-git-send-email-yibin.gong@nxp.com>
         <1532367972-29707-4-git-send-email-yibin.gong@nxp.com>
 <1532343252.3163.99.camel@pengutronix.de>
In-Reply-To: <1532343252.3163.99.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [101.86.20.170]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB3063;6:MdqMbidAm+lCaUXTScwD2PiPFJLOgWCYiTQZqFJ3m98b1PiGU6ngvVr8CNSL71BzkBHNIG00j8WMTffjmGB8R91M+EWYABRk3YsXS43A+HPUnS04v63CRYpWo3wQOtlH5pYnYq5AlzZz56Kw5/ALg4/GURrRrOC6bB8B23F3IwHU7cU9BGlYYjeJrPxguW969Qk5be1YOu8cQQ+XEzX73TeVCxZWW1M1cxcTcbyM2OvINeKBpSknmmAelo+lJYhFdsTsXwYeGquV/Ewnb6aGZ2CytK5Etolquu7va/gwtNeV5nUn+jfUco9E/fyEnAxZtBHv8xAAlRhgqtkjGIcqyzL+zfpxAnihNagaWaxzJ6GNwNHOC1P3mSKAoItDboN3hu2XKVp0DAV5xZUJCFOq4UVfxpt2MbUXED4QgakeVH7zGGOTwilrwwT4wPxn0jN5kwb6gF4nFtjn5m8udgIy+Q==;5:it5+zsiZHJ1fbSfA+IezK5YSu6chW/huc1e37gv5i1+J9b3jA3v84dBJ3BhMTx/eiO3yp3Q9PN+y9Ut43HcJZnJi2MTxb0HaLh24FIA3Z61Sj16t4YsgCG5ZEx85WIbCmFMwMCczYEs1Jxm0feDHWhFmDUspWguSxSTLrmQYFd4=;7:5yK2wDPxCkO8KbD5COry+9llGAeXCNZvSxVQg/88YMPWzYrGDIRxG3F4q4+E9gmi7Z03x2lIBFkHVD3qW4Ivuma04Cex3Y0x4FdVbMzZX/n0NIwlOXTLvTxAAriR4yK0qOG+YQMuQhp3o82R8DnU55Ee2pEg7eC2TK6HBszpiA7lwDl097KzRhaTlay1VU9bP906ZGjddR/YR5FbL3wXs/0GzaXs6ElfQu9lfcnekqmZsE/Iygnuqi4bjmGaYS+9
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9a6b8ae4-baee-4cf7-5435-08d5f0a3fe35
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3063;
x-ms-traffictypediagnostic: DB6PR04MB3063:
x-microsoft-antispam-prvs: <DB6PR04MB3063549750F1FCA17D06530A89560@DB6PR04MB3063.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(258649278758335)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3063;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3063;
x-forefront-prvs: 0742443479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(366004)(136003)(396003)(13464003)(189003)(199004)(305945005)(74316002)(7696005)(2900100001)(66066001)(2501003)(76176011)(5250100002)(5660300001)(229853002)(7736002)(99286004)(6506007)(53546011)(6436002)(102836004)(8936002)(26005)(256004)(14444005)(4326008)(55016002)(81166006)(81156014)(8676002)(54906003)(2906002)(110136005)(476003)(186003)(316002)(9686003)(478600001)(446003)(105586002)(2201001)(106356001)(3846002)(11346002)(6116002)(6246003)(86362001)(97736004)(486006)(25786009)(33656002)(53936002)(68736007)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3063;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ngR+yiezBseRs84UYhQ2GNGwUduElerR9u0Ws/BZdBmRk/UeqPniQFwdCE3pLut9olyc7YiGjgiY7HNyD5JxCXHCGTGhdhAUOCw3c6z3S8zsvnJEC65Lr8kj3eYd8U0Q7Q7Zo1kDBSNWLcMzq0Bh11aeRi2r58BWvmaV9azRMu0+wQ3jGPOOwg8DxGKJBYS8Ezv+2Oq7mYO2rFWwDNWSOMtmj3Vk78+5wIy1knxJrycD4EUcnxjMFktKqmKQhWswNzTCofL+06kgZBQtuwpgDTe55xvSqfLHx7ugFw0mSsKDi7e3n63srIt4EKVaw/58+3Ojdi36foReFw9aXYlSaus7pzFef2p82FtK8YnoAv8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6b8ae4-baee-4cf7-5435-08d5f0a3fe35
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2018 13:55:47.7165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCBbbWFpbHRv
Omwuc3RhY2hAcGVuZ3V0cm9uaXguZGVdDQo+IFNlbnQ6IDIwMTjlubQ35pyIMjPml6UgMTg6NTQN
Cj4gVG86IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT47IHZrb3VsQGtlcm5lbC5vcmc7
DQo+IGRhbi5qLndpbGxpYW1zQGludGVsLmNvbTsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsgbGlu
dXhAYXJtbGludXgub3JnLnVrDQo+IENjOiBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOyBkbC1s
aW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAzLzNdIGRtYWVuZ2luZTogaW14
LXNkbWE6IGFsbG9jYXRlIG1heCAyMCBiZHMgZm9yIG9uZQ0KPiB0cmFuc2Zlcg0KPiANCj4gQW0g
RGllbnN0YWcsIGRlbiAyNC4wNy4yMDE4LCAwMTo0NiArMDgwMCBzY2hyaWViIFJvYmluIEdvbmc6
DQo+ID4gSWYgbXVsdGktYmRzIHVzZWQgaW4gb25lIHRyYW5zZmVyLCBhbGwgYmRzIHNob3VsZCBi
ZSBjb25zaXN0ZW4NCj4gPiBtZW1vcnkuVG8gZWFzaWx5IGZvbGxvdyBpdCwgZW5sYXJnZSB0aGUg
ZG1hIHBvb2wgc2l6ZSBpbnRvIDIwIGJkcywgYW5kDQo+ID4gaXQgd2lsbCByZXBvcnQgZXJyb3Ig
aWYgdGhlIG51bWJlciBvZiBiZHMgaXMgb3ZlciB0aGFuIDIwLiBGb3INCj4gPiBkbWF0ZXN0LCB0
aGUgbWF4IGNvdW50IGZvciBzaW5nbGUgdHJhbnNmZXIgaXMgTlVNX0JEICoNCj4gU0RNQV9CRF9N
QVhfQ05UDQo+ID4gPSAyMCAqIDY1NTM1ID0gfjEuMjhNQi4NCj4gDQo+IEJvdGggdGhlIGNvbW1p
dCBtZXNzYWdlIGFuZCB0aGUgY29tbWVudCBuZWVkIGEgbG90IG1vcmUgY2FyZSB0byBhY3R1YWxs
eQ0KPiB0ZWxsIHdoYXQgdGhpcyBjb21taXQgaXMgdHJ5aW5nIHRvIGFjaGlldmUuIEN1cnJlbnRs
eSBJIGRvbid0IGZvbGxvdyBhdCBhbGwuIFdoYXQNCj4gZG9lcyAiY29uc2lzdGVuIiBtZWFuPyBE
byB5b3UgbWVhbiBCRHMgc2hvdWxkIGJlIGNvbnRpZ3VvdXMgaW4gbWVtb3J5Pw0KWWVzLCBCRHMg
c2hvdWxkIGJlIGNvbnRpZ3VvdXMgIG9uZSBieSBvbmUgaW4gbWVtb3J5Lg0KPiANCj4gV2hhdCBk
byB5b3UgZ2FpbiBieSBvdmVyLWFsbG9jYXRpbmcgZWFjaCBCRCBieSBhIGZhY3RvciBvZiAyMD8N
CkkgZ3Vlc3MgZG1hX3Bvb2xfYWxsb2Mgd2lsbCByZXR1cm4gZXJyb3IgaW4gc3VjaCBjYXNlLCBh
bmQgdGhlbiBjYXVzZSBkbWEgc2V0dXANCnRyYW5zZmVyIGZhaWx1cmUuDQo+IA0KPiBSZWdhcmRz
LA0KPiBMdWNhcw0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBSb2JpbiBHb25nIDx5aWJpbi5nb25n
QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gwqBkcml2ZXJzL2RtYS9pbXgtc2RtYS5jIHwgMTcgKysr
KysrKysrKysrKysrKy0NCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvaW14LXNkbWEu
YyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMgaW5kZXgNCj4gPiBiNGVjMmQyLi41OTczNDg5IDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCj4gPiArKysgYi9kcml2ZXJz
L2RtYS9pbXgtc2RtYS5jDQo+ID4gQEAgLTI5OCw2ICsyOTgsMTUgQEAgc3RydWN0IHNkbWFfY29u
dGV4dF9kYXRhIHsNCj4gPiA+IMKgCXUzMsKgwqBzY3JhdGNoNzsNCj4gPiDCoH0gX19hdHRyaWJ1
dGVfXyAoKHBhY2tlZCkpOw0KPiA+DQo+ID4gKy8qDQo+ID4gKyAqIEFsbCBiZHMgaW4gb25lIHRy
YW5zZmVyIHNob3VsZCBiZSBjb25zaXRlbnQgb24gU0RNQS4gVG8gZWFzaWx5DQo+ID4gK2ZvbGxv
dyBpdCxqdXN0DQo+ID4gKyAqIHNldCB0aGUgZG1hIHBvb2wgc2l6ZSBhcyB0aGUgZW5vdWdoIGJk
cy4gRm9yIGV4YW1wbGUsIGluIGRtYXRlc3QNCj4gPiArY2FzZSwgdGhlDQo+ID4gKyAqIG1heCAy
MCBiZHMgbWVhbnMgdGhlIG1heCBmb3Igc2luZ2xlIHRyYW5zZmVyIGlzIE5VTV9CRCAqDQo+ID4g
K1NETUFfQkRfTUFYX0NOVCA9IDIwDQo+ID4gKyAqICogNjU1MzUgPSB+MS4yOE1CLiAyMCBiZHMg
c3VwcG9zZWQgdG8gYmUgZW5vdWdoIGJhc2ljYWxseS5JZiBpdCdzDQo+ID4gK3N0aWxsIG5vdA0K
PiA+ICsgKiBlbm91Z2ggaW4gc29tZSBzcGVjaWZpYyBjYXNlcywgZW5sYXJnZSBpdCBoZXJlLldh
cm5pbmcgbWVzc2FnZQ0KPiA+ICt3b3VsZCBhbHNvDQo+ID4gKyAqIGFwcGVhciBpZiB0aGUgYmQg
bnVtYmVycyBpcyBvdmVyIHRoYW4gMjAuDQo+ID4gKyAqLw0KPiA+ICsjZGVmaW5lIE5VTV9CRCAy
MA0KPiA+DQo+ID4gwqBzdHJ1Y3Qgc2RtYV9lbmdpbmU7DQo+ID4NCj4gPiBAQCAtMTI3Myw3ICsx
MjgyLDcgQEAgc3RhdGljIGludCBzZG1hX2FsbG9jX2NoYW5fcmVzb3VyY2VzKHN0cnVjdA0KPiA+
IGRtYV9jaGFuICpjaGFuKQ0KPiA+ID4gwqAJCWdvdG8gZGlzYWJsZV9jbGtfYWhiOw0KPiA+DQo+
ID4gPiDCoAlzZG1hYy0+YmRfcG9vbCA9IGRtYV9wb29sX2NyZWF0ZSgiYmRfcG9vbCIsIGNoYW4t
PmRldmljZS0+ZGV2LA0KPiA+ID4gLQkJCQlzaXplb2Yoc3RydWN0IHNkbWFfYnVmZmVyX2Rlc2Ny
aXB0b3IpLA0KPiA+ID4gKwkJCQlOVU1fQkQgKiBzaXplb2Yoc3RydWN0IHNkbWFfYnVmZmVyX2Rl
c2NyaXB0b3IpLA0KPiA+ID4gwqAJCQkJMzIsIDApOw0KPiA+DQo+ID4gPiDCoAlyZXR1cm4gMDsN
Cj4gPiBAQCAtMTMxNCw2ICsxMzIzLDEyIEBAIHN0YXRpYyBzdHJ1Y3Qgc2RtYV9kZXNjDQo+ID4g
KnNkbWFfdHJhbnNmZXJfaW5pdChzdHJ1Y3Qgc2RtYV9jaGFubmVsICpzZG1hYywNCj4gPiDCoHsN
Cj4gPiA+IMKgCXN0cnVjdCBzZG1hX2Rlc2MgKmRlc2M7DQo+ID4NCj4gPiA+ICsJaWYgKGJkcyA+
IE5VTV9CRCkgew0KPiA+ID4gKwkJZGV2X2VycihzZG1hYy0+c2RtYS0+ZGV2LCAiJWQgYmRzIGV4
Y2VlZCB0aGUgbWF4ICVkXG4iLA0KPiA+ID4gKwkJCWJkcywgTlVNX0JEKTsNCj4gPiA+ICsJCWdv
dG8gZXJyX291dDsNCj4gPiA+ICsJfQ0KPiA+ICsNCj4gPiA+IMKgCWRlc2MgPSBremFsbG9jKChz
aXplb2YoKmRlc2MpKSwgR0ZQX05PV0FJVCk7DQo+ID4gPiDCoAlpZiAoIWRlc2MpDQo+ID4gPiDC
oAkJZ290byBlcnJfb3V0Ow0K
