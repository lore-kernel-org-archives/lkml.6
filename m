Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD722ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5542C20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ekbpqxiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5542C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbeGTK2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 06:28:22 -0400
Received: from mail-db5eur01on0055.outbound.protection.outlook.com ([104.47.2.55]:28930
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727681AbeGTK2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 06:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOw22dgBAnR3lOryhM+xwaoGj9Da2fbNh6NgOHLqukw=;
 b=ekbpqxiOyx/AxLvW612jeyd6b0M1X3l75bAdVpFcNwlfx7AQsJnDWpe4CrHLCYVBUrtn3vpnPp7ESVv506ULgqpki64N6KhhZn3qmTW8JJlDCKB+zx3BL9IhKNGV28FT1bL1LNtxsqj8DDYjKIzv7Uq3n2yCM5Di0kZ+WvfqObQ=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB3208.eurprd04.prod.outlook.com (10.170.211.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Fri, 20 Jul 2018 09:40:51 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd%4]) with mapi id 15.20.0973.018; Fri, 20 Jul 2018
 09:40:51 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v2 2/3] dmaengine: imx-sdma: add memcpy interface
Thread-Topic: [PATCH v2 2/3] dmaengine: imx-sdma: add memcpy interface
Thread-Index: AQHUGmfJDc6o9E9nO0yuRMn+ZSmJraSMrSUAgAs2QAA=
Date:   Fri, 20 Jul 2018 09:40:51 +0000
Message-ID: <DB6PR04MB3223F5A07E59F173D5BD0B6D89510@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <1531487327-21879-1-git-send-email-yibin.gong@nxp.com>
 <1531487327-21879-3-git-send-email-yibin.gong@nxp.com>
 <20180713061604.tza3udckmyaoq5wh@pengutronix.de>
In-Reply-To: <20180713061604.tza3udckmyaoq5wh@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB3208;6:57eJx7eAI2CIJSD6OzapuaC32THDyMYe2TsjGEgqjBP0Gwflywy/UJZufqQczIH7TqOpQHzzOt0BDmgKLn/sN07a/59Hn5M36N5vnDp9YMmIimipKAAfMxWcbBLhSmIXGGvXy6SsnNZltrNCm7jGgo7iGpZtPFHNkSTBCM8aoGjPiwp6BYL/TLRRkESZETz0RjXWpc0+35VQw/HXgN4fXbZyGyfE9p0Nouf/A9+OAgzYpkJucCmZTO9HZa2GxE/3sZO66v87Z1t8BRUqmxrdLGjBnbTy7PbfxgBZi4B08lNEDUag6tC7x1P3ct4HCloxZIv/jltq3D92vrAgVW4UwRT6I5VsrrKBYwver0m5SKhYH5ab4b8RE7ArYQ76Iihv4IexWemUw1WaziNPOm3dtFOY4J/j/OPXyLKkx46DKzUGDwmI8Nd/JZbfKxC80FSWj/2ocLWnOe/RZNtcZdoCKw==;5:dRYTmKMlUu+OmQasKHIdKQ7S1MF+/zicl/uSzzwjSe/FSM7Dk271QgJFz+7i+ZLQoo9h1pEOBqOH/VnTaMPjNtIY6VCHIQcDb1Qjr5mVu5GPrz/GFBELvXsF6oXBlycXgTAZs8gFDmO+jxpTuls6FfVQJKUrXcjU8uruWB1/bpI=;7:+LJFt9peutny79qB1I+Gibig27ZDkDUQtPyNDpzKVv2291jqFWrmNc2N5QTQjr/OSVj8cJ/Jmnuw/h1zFr5WEnXv9c49mLvrMgySiMf1rs1KLDiehx0z55CVUxYyh2QYxtlXoROiDDkZTTVcLCRPoKYlJ9FD7roac4WBwZ/wWIs7KRKTyugkJ/vgjbRYyykPeW1tp+y3oczaRHu04HKb5h7JSK27nE5d/PNNgtV6mI0ilHReEdpwxVfs//Kdh/yb
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 09cfebda-5bb1-4558-0772-08d5ee24e1bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3208;
x-ms-traffictypediagnostic: DB6PR04MB3208:
x-microsoft-antispam-prvs: <DB6PR04MB3208DB37FFB5E39964E85F8789510@DB6PR04MB3208.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(189930954265078)(185117386973197)(258649278758335)(45079756050767)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3208;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3208;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(376002)(396003)(346002)(199004)(189003)(13464003)(54906003)(316002)(9686003)(105586002)(7736002)(25786009)(6916009)(5250100002)(6306002)(55016002)(74316002)(26005)(97736004)(186003)(5660300001)(256004)(6436002)(305945005)(3846002)(6116002)(229853002)(45080400002)(99286004)(33656002)(486006)(2906002)(6246003)(966005)(7696005)(2900100001)(53936002)(76176011)(478600001)(446003)(14454004)(11346002)(8936002)(4326008)(106356001)(476003)(86362001)(53546011)(68736007)(6506007)(81166006)(66066001)(81156014)(8676002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3208;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NyeVgiul3jWQ039+mE9NK6otIVYoPLS3ntcGcAdKbtOxc1ca1T3o1HioDVh+NTpcjoOofupc6V+2bnivaYsSmVBbMjK2AZqXr2O+KDDtTLM8TeVkWCD8nX2hI74N8EpeEIX2ctbnH+/plK+M3XQC+VDDxrL8Gur469FuSTgoxPxEWfxCTm63LD24AiA77GisWUu6s3Uj1AY4Y2crM30z3QVCfvhfYgS6ne3sI5IR0h5k/ZqA6K+3dXrqnT17xWLzuncQ/6BQ/9DC/HHmZD5ujBeU8OQsvwhQ0t+5Homoid/HJIwn0/agrKmF9MO+nCXk/batSWfeUVdo82gPhoQas61QwWol8Zu7MpjuRvb3T2E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cfebda-5bb1-4558-0772-08d5ee24e1bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 09:40:51.5436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTYXNjaGEgSGF1ZXIgW21haWx0
bzpzLmhhdWVyQHBlbmd1dHJvbml4LmRlXQ0KPiBTZW50OiAyMDE4xOo31MIxM8jVIDE0OjE2DQo+
IFRvOiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+DQo+IENjOiB2a291bEBrZXJuZWwu
b3JnOyBkYW4uai53aWxsaWFtc0BpbnRlbC5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7IEZhYmlv
DQo+IEVzdGV2YW0gPGZhYmlvLmVzdGV2YW1AbnhwLmNvbT47IGxpbnV4QGFybWxpbnV4Lm9yZy51
azsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7DQo+IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjIgMi8zXSBkbWFlbmdpbmU6IGlteC1zZG1hOiBhZGQgbWVtY3B5IGlu
dGVyZmFjZQ0KPiANCj4gT24gRnJpLCBKdWwgMTMsIDIwMTggYXQgMDk6MDg6NDZQTSArMDgwMCwg
Um9iaW4gR29uZyB3cm90ZToNCj4gPiBBZGQgTUVNQ1BZIGNhcGFiaWxpdHkgZm9yIGlteC1zZG1h
IGRyaXZlci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmluLmdvbmdA
bnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9kbWEvaW14LXNkbWEuYyB8IDk1DQo+ID4g
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDkyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBAQCAtMTMxOCw2ICsxMzQ3LDYzIEBAIHN0YXRpYyBzdHJ1Y3Qgc2RtYV9kZXNjDQo+ICpzZG1h
X3RyYW5zZmVyX2luaXQoc3RydWN0IHNkbWFfY2hhbm5lbCAqc2RtYWMsDQo+ID4gIAlyZXR1cm4g
TlVMTDsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBzdHJ1Y3QgZG1hX2FzeW5jX3R4X2Rlc2Ny
aXB0b3IgKnNkbWFfcHJlcF9tZW1jcHkoDQo+ID4gKwkJc3RydWN0IGRtYV9jaGFuICpjaGFuLCBk
bWFfYWRkcl90IGRtYV9kc3QsDQo+ID4gKwkJZG1hX2FkZHJfdCBkbWFfc3JjLCBzaXplX3QgbGVu
LCB1bnNpZ25lZCBsb25nIGZsYWdzKSB7DQo+ID4gKwlzdHJ1Y3Qgc2RtYV9jaGFubmVsICpzZG1h
YyA9IHRvX3NkbWFfY2hhbihjaGFuKTsNCj4gPiArCXN0cnVjdCBzZG1hX2VuZ2luZSAqc2RtYSA9
IHNkbWFjLT5zZG1hOw0KPiA+ICsJaW50IGNoYW5uZWwgPSBzZG1hYy0+Y2hhbm5lbDsNCj4gPiAr
CXNpemVfdCBjb3VudDsNCj4gPiArCWludCBpID0gMCwgcGFyYW07DQo+ID4gKwlzdHJ1Y3Qgc2Rt
YV9idWZmZXJfZGVzY3JpcHRvciAqYmQ7DQo+ID4gKwlzdHJ1Y3Qgc2RtYV9kZXNjICpkZXNjOw0K
PiA+ICsNCj4gPiArCWlmICghY2hhbiB8fCAhbGVuKQ0KPiA+ICsJCXJldHVybiBOVUxMOw0KPiA+
ICsNCj4gPiArCWRldl9kYmcoc2RtYS0+ZGV2LCAibWVtY3B5OiAlcGFkLT4lcGFkLCBsZW49JXp1
LCBjaGFubmVsPSVkLlxuIiwNCj4gPiArCQkmZG1hX3NyYywgJmRtYV9kc3QsIGxlbiwgY2hhbm5l
bCk7DQo+ID4gKw0KPiA+ICsJZGVzYyA9IHNkbWFfdHJhbnNmZXJfaW5pdChzZG1hYywgRE1BX01F
TV9UT19NRU0sDQo+ID4gKwkJCQkJbGVuIC8gU0RNQV9CRF9NQVhfQ05UICsgMSk7DQo+ID4gKwlp
ZiAoIWRlc2MpDQo+ID4gKwkJcmV0dXJuIE5VTEw7DQo+ID4gKw0KPiA+ICsJZG8gew0KPiA+ICsJ
CWNvdW50ID0gbWluX3Qoc2l6ZV90LCBsZW4sIFNETUFfQkRfTUFYX0NOVCk7DQo+ID4gKwkJYmQg
PSAmZGVzYy0+YmRbaV07DQo+ID4gKwkJYmQtPmJ1ZmZlcl9hZGRyID0gZG1hX3NyYzsNCj4gPiAr
CQliZC0+ZXh0X2J1ZmZlcl9hZGRyID0gZG1hX2RzdDsNCj4gPiArCQliZC0+bW9kZS5jb3VudCA9
IGNvdW50Ow0KPiA+ICsJCWRlc2MtPmNobl9jb3VudCArPSBjb3VudDsNCj4gPiArCQkvKiBhbGln
biB3aXRoIHNkbWEtPmRtYV9kZXZpY2UuY29weV9hbGlnbjogNGJ5dGVzICovDQo+ID4gKwkJYmQt
Pm1vZGUuY29tbWFuZCA9IDA7DQo+ID4gKw0KPiA+ICsJCWRtYV9zcmMgKz0gY291bnQ7DQo+ID4g
KwkJZG1hX2RzdCArPSBjb3VudDsNCj4gPiArCQlsZW4gLT0gY291bnQ7DQo+ID4gKwkJaSsrOw0K
PiANCj4gTkFDSy4NCj4gDQo+IFBsZWFzZSBhY3R1YWxseSBsb29rIGF0IHlvdXIgY29kZSBhbmQg
ZmluZCBvdXQgd2hlcmUgeW91IGRvIHVuYWxpZ25lZCBETUENCj4gYWNjZXNzZXMuIEhpbnQ6IFdo
YXQgaGFwcGVucyB3aGVuIHRoaXMgbG9vcCBib2R5IGlzIGV4ZWN1dGVkIG1vcmUgdGhhbg0KPiBv
bmNlPw0KPiANCj4gU2FzY2hhDQpBY3R1YWxseSBpbnRlcm5hbCBzZG1hIHNjcmlwdCBoYXMgYWxy
ZWFkeSB0YWtlIHN1Y2ggJ2FsaWduJyBtYXR0ZXIgbGlrZSBiZWxvdzoNCkJ1cnN0IHdpdGggd29y
ZHMgaWYgc291cmNlL2Rlc3QgYWRkcmVzcyBhbmQgZGF0YSBsZW5ndGggYXJlIGFsbCBhbGlnbmVk
IHdpdGggd29yZHMsIGJ1cnN0IHdpdGgNCkJ5dGUgaWYgbm90LiBTbyBJIHdpbGwgcmVtb3ZlIHRo
ZSBjb21tZW50ICcvKiBhbGlnbiB3aXRoIHNkbWEtPmRtYV9kZXZpY2UuY29weV9hbGlnbjogNGJ5
dGVzICovJw0KSW4gdjMuIEJlc2lkZXMsIEkgaGF2ZSBmb3VuZCBhbm90aGVyIGJ1ZyB3aGljaCBp
bnRyb2R1Y2VkIGJ5IG15IHZpcnQtZG1hIHBhdGNoLiBXaWxsIHNlbmQNClYzIGxhdGVyLg0KPiAN
Cj4gPiArDQo+ID4gKwkJcGFyYW0gPSBCRF9ET05FIHwgQkRfRVhURCB8IEJEX0NPTlQ7DQo+ID4g
KwkJLyogbGFzdCBiZCAqLw0KPiA+ICsJCWlmICghbGVuKSB7DQo+ID4gKwkJCXBhcmFtIHw9IEJE
X0lOVFI7DQo+ID4gKwkJCXBhcmFtIHw9IEJEX0xBU1Q7DQo+ID4gKwkJCXBhcmFtICY9IH5CRF9D
T05UOw0KPiA+ICsJCX0NCj4gPiArDQo+ID4gKwkJZGV2X2RiZyhzZG1hLT5kZXYsICJlbnRyeSAl
ZDogY291bnQ6ICV6ZCBkbWE6IDB4JXggJXMlc1xuIiwNCj4gPiArCQkJCWksIGNvdW50LCBiZC0+
YnVmZmVyX2FkZHIsDQo+ID4gKwkJCQlwYXJhbSAmIEJEX1dSQVAgPyAid3JhcCIgOiAiIiwNCj4g
PiArCQkJCXBhcmFtICYgQkRfSU5UUiA/ICIgaW50ciIgOiAiIik7DQo+ID4gKw0KPiA+ICsJCWJk
LT5tb2RlLnN0YXR1cyA9IHBhcmFtOw0KPiA+ICsJfSB3aGlsZSAobGVuKTsNCj4gPiArDQo+IA0K
PiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiB8
DQo+IEluZHVzdHJpYWwgTGludXggU29sdXRpb25zICAgICAgICAgICAgICAgICB8DQo+IGh0dHBz
Oi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUy
RiUyRnd3dy4NCj4gcGVuZ3V0cm9uaXguZGUlMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q3lpYmluLmdv
bmclNDBueHAuY29tJTdDZjc4ZjkNCj4gOTEwMjhlNjRiNDVjZjc1MDhkNWU4ODgzMTBkJTdDNjg2
ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlNw0KPiBDMCU3QzAlN0M2MzY2NzA1OTQwMDMw
MzA3MzImYW1wO3NkYXRhPXp5RGtMSFZsNFZuZUQwNWY0VnZhWTgybQ0KPiBaSVRreWJld3JYeUNq
MllSdSUyRkklM0QmYW1wO3Jlc2VydmVkPTAgIHwNCj4gUGVpbmVyIFN0ci4gNi04LCAzMTEzNyBI
aWxkZXNoZWltLCBHZXJtYW55IHwgUGhvbmU6ICs0OS01MTIxLTIwNjkxNy0wICAgIHwNCj4gQW10
c2dlcmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2ODYgICAgICAgICAgIHwgRmF4Og0KPiArNDktNTEy
MS0yMDY5MTctNTU1NSB8DQo=
