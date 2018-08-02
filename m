Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59646C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AB420C0C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CjJhe9k5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6AB420C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbeHBJhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:37:21 -0400
Received: from mail-eopbgr30074.outbound.protection.outlook.com ([40.107.3.74]:9376
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726192AbeHBJhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GR2Nap97XLA9BUajpvYtwHoya04s6qur6W47OWvSMSA=;
 b=CjJhe9k5Nk4KGeV4tcl6zKIV7pT8hmZH09SMSDdmhTBdIdAZ/2KVxnRSl0yG0NUat4kKPuMRNPnnv+7rZzfDnlbCLjEKMpbKDZRzQnokSvFC0SUN4E0SZb6deQSqBBf3mHI4TneyWFFPSFOCBZJRVxBmZUqUxzzBRQSIU6st1/s=
Received: from AM4PR0401MB2260.eurprd04.prod.outlook.com (10.165.45.7) by
 AM4PR0401MB2180.eurprd04.prod.outlook.com (10.167.89.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.21; Thu, 2 Aug 2018 07:47:23 +0000
Received: from AM4PR0401MB2260.eurprd04.prod.outlook.com
 ([fe80::cdbd:a535:32b1:255c]) by AM4PR0401MB2260.eurprd04.prod.outlook.com
 ([fe80::cdbd:a535:32b1:255c%7]) with mapi id 15.20.1017.010; Thu, 2 Aug 2018
 07:47:23 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Stefan Agner <stefan@agner.ch>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: fec: check DMA addressing limitations
Thread-Topic: [PATCH] net: fec: check DMA addressing limitations
Thread-Index: AQHUKY0SPs9eOpnX9kGVrCAsh50anaSrs7CwgABaeICAAARtEA==
Date:   Thu, 2 Aug 2018 07:47:23 +0000
Message-ID: <AM4PR0401MB226079C9A7B818229955744CFF2C0@AM4PR0401MB2260.eurprd04.prod.outlook.com>
References: <20180801114449.21208-1-stefan@agner.ch>
 <AM4PR0401MB22608258EB2B045E708A3779FF2C0@AM4PR0401MB2260.eurprd04.prod.outlook.com>
 <7d692e8aaefcfec15877a8cd340ee646@agner.ch>
In-Reply-To: <7d692e8aaefcfec15877a8cd340ee646@agner.ch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR0401MB2180;6:/1mb/8rDteFI+UTyb6/S+Kbt+sjOatSyx0oD9ykVCAjosWmHqe2WlKx8yMuozo48la148rkhngAKMnTUtx7leIEdVyGIVWdjOjRPLs2RpS9PVVk1/k7i6DFT3YCgDcdAscQDk/Pcd7EQ0GF7EKH4dTH3bDqWphpXlqy8O7cWfolzv/tXj57MAKkxtmrE9FwZ6O4MIHMADYQo8t5erKLnVXBwhHbPkPCPBlWY7F1CyROsPV8h0T8bEUsH/AXMxyMY8lTYwDaV8mOVBrxG9MY+UYcMFGZBieP0Gyfvq5zZyXgfCaa8wBhGOEjL+L34+AZ47V0S52FJc02DIPYSic3N6aVyME2gM43FX5prTuI7nzWf5kUqz1U6wYbgBUUQhGkasw/DiYxFd732+WJ71nwOWa4TOu9VHBKMoHfsa4mz+bgFswYudSCnJfjoML5tW/nu4GQW9noNjcJKGPxEFiS2Iw==;5:ayayOVOMeT2PaQXERI6htZg+Ho+AbR9q3ntvMGGrb9qKh31UXmKoUDwcNV0a/SQBLaNGeM2udbER6UuSCP7owKLKvnD7Ir/0gDdYLIKGRWP+62arfJ00o/ySq6D1M5FnlSPdF95y/nXXdaRainWX0eHQxGjHNg3MgS8/EUAlwGg=;7:oEax/ixoDANk2YXVgzA+b+ZOh0j0Qtuh89xP7ogCcEhw+FwW746dGFizUob70cRUZ3M9nmp93NUdNiSe7m15X81wczTLsuZxpHfUbRzabUjw6OMVmIRPqmkune58z31osXXwDeaXueF2NgZBmgGv+X8MGljND3j9L9wUQ0hbCgjF65o9NfqW/oPTh8/w+pbScTMNGU0rgDwRfyG0UoyJ1n5VcLag/rr8JpS5DJzBrBKkRTDhJlDmz7FXeftkf8UP
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 503f19e3-88e4-405d-e81f-08d5f84c2f21
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB2180;
x-ms-traffictypediagnostic: AM4PR0401MB2180:
x-microsoft-antispam-prvs: <AM4PR0401MB21803ABF564CFD6BFA56FC3FFF2C0@AM4PR0401MB2180.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(189930954265078)(45079756050767);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM4PR0401MB2180;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB2180;
x-forefront-prvs: 07521929C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(189003)(52314003)(199004)(6506007)(2906002)(45080400002)(6436002)(55016002)(66066001)(966005)(76176011)(33656002)(575784001)(186003)(54906003)(14454004)(86362001)(6306002)(26005)(9686003)(68736007)(316002)(106356001)(7696005)(478600001)(486006)(4326008)(8676002)(229853002)(11346002)(105586002)(102836004)(5660300001)(446003)(3846002)(81166006)(99286004)(5250100002)(6116002)(256004)(6246003)(25786009)(97736004)(8936002)(2900100001)(53936002)(53546011)(476003)(6916009)(305945005)(74316002)(7736002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB2180;H:AM4PR0401MB2260.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /yGJs9ols7fEMCWGzVnPIL7inBMs0pz27qMIG/apiQfDtPgOC30Nsyl7uPGbzSZ/+d0KZEI0RfIj2Z/W1tyRcBtmPHboKxFOs1FFcIotITBwxnOldL8rSJsMPXtRysJ9xjvKW5pDht+6CXdYlBx9oI8r5sAXbSVMt8KvCcQOJsmrLsJwybZmp17apruZm3H9b22+33FHNLxBDnaN5YBkUScZQhDh9A6h4Fj/KukD+giF2CfDJLfR63FKrW5RM7r1O87RrraGPTBwem7+Q1aYsVlzxtjbUTbteIrEpUt9hFf9in74zZAPrGNzxkF4JZ9DFO8L7XIV+QXkd+rbRFHf1MyxZc9XD7hmueQ72+XGAFc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 503f19e3-88e4-405d-e81f-08d5f84c2f21
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2018 07:47:23.4287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU3RlZmFuIEFnbmVyIDxzdGVmYW5AYWduZXIuY2g+IFNlbnQ6IDIwMTjlubQ45pyIMuaX
pSAxNToxNg0KPiBPbiAwMi4wOC4yMDE4IDA0OjAwLCBBbmR5IER1YW4gd3JvdGU6DQo+ID4gRnJv
bTogU3RlZmFuIEFnbmVyIDxzdGVmYW5AYWduZXIuY2g+IFNlbnQ6IDIwMTjlubQ45pyIMeaXpSAx
OTo0NQ0KPiA+PiBDaGVjayBETUEgYWRkcmVzc2luZyBsaW1pdGF0aW9ucyBhcyBzdWdnZXN0ZWQg
YnkgdGhlIERNQSBBUEkgaG93LXRvLg0KPiA+PiBUaGlzIGRvZXMgbm90IGZpeCBhIHBhcnRpY3Vs
YXIgaXNzdWUgc2VlbiBidXQgaXMgY29uc2lkZXJlZCBnb29kIHN0eWxlLg0KPiA+Pg0KPiA+PiBT
aWduZWQtb2ZmLWJ5OiBTdGVmYW4gQWduZXIgPHN0ZWZhbkBhZ25lci5jaD4NCj4gPj4gLS0tDQo+
ID4+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYyB8IDYgKysrKysr
DQo+ID4+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4+DQo+ID4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiA+PiBi
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+ID4+IGluZGV4IGM3
Mjk2NjUxMDdmNS4uYWYwZmIyMDBlOTM2IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiA+PiArKysgYi9kcml2ZXJzL25ldC9ldGhl
cm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiA+PiBAQCAtMzE0Niw2ICszMTQ2LDEyIEBAIHN0
YXRpYyBpbnQgZmVjX2VuZXRfaW5pdChzdHJ1Y3QgbmV0X2RldmljZQ0KPiA+PiAqbmRldikNCj4g
Pj4gIAlmZXAtPnR4X2FsaWduID0gMHgzOw0KPiA+PiAgI2VuZGlmDQo+ID4+DQo+ID4+ICsJLyog
Q2hlY2sgbWFzayBvZiB0aGUgc3RyZWFtaW5nIGFuZCBjb2hlcmVudCBBUEkgKi8NCj4gPj4gKwlp
ZiAoZG1hX3NldF9tYXNrX2FuZF9jb2hlcmVudCgmZmVwLT5wZGV2LT5kZXYsDQo+ID4+IERNQV9C
SVRfTUFTSygzMikpKSB7DQo+ID4+ICsJCWRldl93YXJuKCZmZXAtPnBkZXYtPmRldiwgIk5vIHN1
aXRhYmxlIERNQQ0KPiBhdmFpbGFibGVcbiIpOw0KPiA+PiArCQlyZXR1cm4gLUVOT0RFVjsNCj4g
PiBJdCBpcyBiZXR0ZXI6DQo+ID4NCj4gPiByZXQgPSBkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50
KCZmZXAtPnBkZXYtPmRldiwNCj4gRE1BX0JJVF9NQVNLKDMyKSk7IGlmDQo+ID4gKHJldCA8IDAp
IHsNCj4gPiAJZGV2X3dhcm4oJmZlcC0+cGRldi0+ZGV2LCAiTm8gc3VpdGFibGUgRE1BIGF2YWls
YWJsZVxuIik7DQo+ID4gCXJldHVybiByZXQ7DQo+ID4gfQ0KPiANCj4gVGhlIGNvZGUgY29tZXMg
ZnJvbSB0aGUgZXhhbXBsZSBpbg0KPiBEb2N1bWVudGF0aW9uL0RNQS1BUEktSE9XVE8udHh0Lg0K
PiANCj4gSSBjYW4gcmVhcnJhbmdlIGlmIHlvdSBwcmVmZXIuDQo+IA0KSXQgaXMgYmV0dGVyIHRv
IHJldHVybiB0aGUgcmVhbCBlcnJvciBjb2RlIGxpa2UgLUVJTyBpZiBkbWFfbWFzayBpcyBub3Qg
aW5pdGlhbGl6ZWQuIA0KDQo+ID4NCj4gPg0KPiA+IElmIHRoZSBwYXRjaCBhaW0gdG8gIk9GOiBE
b24ndCBzZXQgZGVmYXVsdCBjb2hlcmVudCBETUEgbWFzayIsIEkgdGhpbmsNCj4gPiBub3Qgb25s
eSB0aGlzIGRyaXZlciBuZWVkIHRvIGFkZCB0aGUgRE1BIG1hc2sgbGltaXRhdGlvbnMsICBtYW55
IG90aGVyDQo+ID4gZHJpdmVycyBhbHNvIG5lZWQuDQo+IA0KPiBJdCBkb2Vzbid0IGV4YWN0bHkg
YWRkcmVzcyB0aGUgaXNzdWUgc2luY2Ugd2l0aCB0aGF0IHBhdGNoIERNQSBtYXNrIHdhc24ndA0K
PiBzZXQgYXQgYWxsLiBUaGlzIGNvZGUgd291bGQganVzdCBtYWtlIHRoZSBkcml2ZXIgZmFpbCB3
aXRoIC1FTk9ERVYgaW5zdGVhZCBvZg0KPiAtRU5PTUVNLg0KPiANClllcywgSSBhZ3JlZS4gSXQg
ZG9lc24ndCBhZGRyZXNzIHRoZSBpc3N1ZSBpZiBubyBwYXRjaCAib2YvcGxhdGZvcm06IEluaXRp
YWxpc2UgZGVmYXVsdCBETUEgbWFza3MiLg0KDQpGb3Igbm9uLURULCBpdCBzZWVtcyBkbWFfY29l
cmNlX21hc2tfYW5kX2NvaGVyZW50KCkgbXVjaCBiZXR0ZXIuDQoNCj4gVG8gZm9yY2UgYSBETUEg
bWFzayBJIHdvdWxkIGhhdmUgdG8gc2V0IHRoZSBETUEgbWFzayB1c2luZw0KPiBkbWFfY29lcmNl
X21hc2tfYW5kX2NvaGVyZW50KCkuIEJ1dCBhcyBkaXNjdXNzZWQgd2l0aCBSb2JpbiBpdCBpcyBz
YWZlDQo+IHRvIGFzc3VtZSB0aGF0IGFuIGluaXRpYWwgbWFzayBpcyBzZXQgYnkgdGhlIGJ1cyBj
b2RlOg0KPiBodHRwczovL2VtZWEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/
dXJsPWh0dHAlM0ElMkYlMkZsaw0KPiBtbC5rZXJuZWwub3JnJTJGciUyRjg5MmY5ZDE0LWU2ZmQt
N2IxYi1kMDdiLWFmMGJlNmU2MjNmYSU0MGFybS5jDQo+IG9tJmFtcDtkYXRhPTAyJTdDMDElN0Nm
dWdhbmcuZHVhbiU0MG54cC5jb20lN0M2MTg1NDNmYjliNGUNCj4gNGY5ZmE0OTkwOGQ1Zjg0N2M0
N2YlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlDQo+IDdDMCU3QzYzNjY4
NzkwOTQ4NzM4MTg3NiZhbXA7c2RhdGE9aHllZWgwS1NDM0Z1N1ZEbDRBOEpiY0NPDQo+ICUyRndv
Y1VwVEVNdlR2MWhqYmEwRSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiANCj4gU2V0dGluZyB0aGUgRE1B
IG1hc2sgb24gRFQgYnVzZXMgaGFzIGJlZW4gYWRkcmVzc2VkIGJ5IFJvYmluIHdpdGgNCj4gIm9m
L3BsYXRmb3JtOiBJbml0aWFsaXNlIGRlZmF1bHQgRE1BIG1hc2tzIi4gU28gZXZlcnl0aGluZyBz
aG91bGQgYmUgZmluZQ0KPiBhZ2Fpbi4NCj4gDQpBbnl3YXksIEkgYW0gZmluZSB3aXRoIHRoZSBw
YXRjaCBleGNlcHQgdGhlIHJldHVybiBjb2RlLg0KVGhhbmtzLg0KDQo+IEkgYWdyZWUsIG90aGVy
IGRyaXZlcnMgbmVlZCBmaXhpbmcgdG9vLg0KPiANCj4gLS0NCj4gU3RlZmFuDQo+IA0KPiA+DQo+
ID4NCj4gPj4gKwl9DQo+ID4+ICsNCj4gPj4gIAlmZWNfZW5ldF9hbGxvY19xdWV1ZShuZGV2KTsN
Cj4gPj4NCj4gPj4gIAliZF9zaXplID0gKGZlcC0+dG90YWxfdHhfcmluZ19zaXplICsgZmVwLT50
b3RhbF9yeF9yaW5nX3NpemUpICoNCj4gPj4gZHNpemU7DQo+ID4+IC0tDQo+ID4+IDIuMTguMA0K
