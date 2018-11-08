Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9DAECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88EA82081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="mkVYuLzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EA82081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeKIBN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:13:26 -0500
Received: from mail-ty1jpn01on0105.outbound.protection.outlook.com ([104.47.93.105]:60895
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726375AbeKIBN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aeKgfhAHv84tpKAjFMWT7qe0dNZ4tBIFmN/bSUn590=;
 b=mkVYuLzC1NJBbemOJe0tUS/LeJDkDzOhAnFDXruqAUTsPd+276/+L5jNCtANPWKHLE+5QBzVQ0IJxBtXoADRG7t4qScFJK8N7PsJlPlhfsC2srNtm+PfwxXOT8X9G7UhV5FFJQRLDBkdDTgzFmHiHAfT/+eH80xOMUYmCXKs9Z8=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1392.jpnprd01.prod.outlook.com (10.174.227.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Thu, 8 Nov 2018 15:37:19 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6%5]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 15:37:19 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] irqchip: Add support for Renesas RZ/N1 GPIO
 interrupt multiplexer
Thread-Topic: [PATCH v2 2/2] irqchip: Add support for Renesas RZ/N1 GPIO
 interrupt multiplexer
Thread-Index: AQHUcD2lJIxNUCxga0G4J4tYz/ve2aU4/58AgABgR3CAAB0GAIAAAMBggAk3nWCAA1ibYA==
Date:   Thu, 8 Nov 2018 15:37:19 +0000
Message-ID: <TY1PR01MB17691CBAA81188A9D13D0576F5C50@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20181030104438.27827-1-phil.edworthy@renesas.com>
 <20181030104438.27827-3-phil.edworthy@renesas.com>
 <86d0rq35o1.wl-marc.zyngier@arm.com>
 <TY1PR01MB176959B0CF663D0ECB298924F5CD0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <b95c7fc3-7fda-48b7-6933-b7b183b6fa67@arm.com>
 <TY1PR01MB1769D6F84F7BCD91C1018922F5CD0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <TY1PR01MB17696E2B10CA447CD3508ADAF5CB0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB17696E2B10CA447CD3508ADAF5CB0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1392;20:YgYI6VfsNxoKWiVog/7WYh4vrnHI+jWUY2kUAsT976+qKp7/B9799ZL85jczcKI+AU+32MvDTUdnImfAvVvDcz5LDVUmpGZQEabYH3xNO1u7E5QVb0Gef1rRpVdrdAoWW1HYyB2DzU5y0g40UE8Gp7IX47fAnZ2Ad7rp5vktr5k=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 63e86e39-574a-40e8-0f42-08d6459011c3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1392;
x-ms-traffictypediagnostic: TY1PR01MB1392:
x-microsoft-antispam-prvs: <TY1PR01MB13929CC957E8C6587AAA2134F5C50@TY1PR01MB1392.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1392;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1392;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(39860400002)(366004)(396003)(199004)(189003)(25786009)(8676002)(71190400001)(81156014)(8936002)(81166006)(6246003)(44832011)(229853002)(256004)(486006)(53936002)(71200400001)(6116002)(55016002)(66066001)(3846002)(11346002)(86362001)(446003)(68736007)(4326008)(2906002)(186003)(6436002)(9686003)(5660300001)(97736004)(110136005)(54906003)(33656002)(93886005)(478600001)(476003)(316002)(305945005)(74316002)(7736002)(2900100001)(106356001)(102836004)(76176011)(105586002)(7696005)(99286004)(14454004)(53546011)(26005)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1392;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: W0pVHHn/uIsWkN4klyjZz2GAz6xZs9nB2S5dC7axr5XURJasQA5Z00/8BlP50hAOXVbXp4YJQx9oO1lcqF7T6UfkL7qJSE6FvzZ9VTFy0NV/uHAINssb8wiRATg7NY8qcmlYfM8fGluqjwGQZBURwfFtX+DvPQcPnfyX8B5u2FfiH27LVtd1/7dLsxY9ywfmdOs+5ee5trtq6duyvqcTRCaMSCWzAE7FizLNLE08g6n1DM9EpnCkg/emtTaZ6rz/ovEf2V+F7QWMIEdYAq/aGgCQHB0ZVPPVitwqTFLqJpZSM488ALBnd/tyoLkUfnj0VyXkb9EBeT5U7p/sXqwq5ifQDK3VwzjNRLCQDobxJ5Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e86e39-574a-40e8-0f42-08d6459011c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 15:37:19.0864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1392
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTWFyYywNCg0KT24gMDYgTm92ZW1iZXIgMjAxOCAxMzoxNiBQaGlsIEVkd29ydGh5IHdy
b3RlOg0KPiBPbiAzMSBPY3RvYmVyIDIwMTggMTU6MzksIFBoaWwgRWR3b3J0aHkgd3JvdGUNCj4g
PiBPbiAzMSBPY3RvYmVyIDIwMTggMTU6MzEsIE1hcmMgWnluZ2llciB3cm90ZToNCj4gPiA+IE9u
IDMxLzEwLzE4IDE1OjA5LCBQaGlsIEVkd29ydGh5IHdyb3RlOg0KPiA+ID4gPiBPbiAzMSBPY3Rv
YmVyIDIwMTggMDg6MDIsIE1hcmMgWnluZ2llciB3b3RlOg0KPiA+ID4gPj4gT24gVHVlLCAzMCBP
Y3QgMjAxOCAxMDo0NDozOCArMDAwMCwgUGhpbCBFZHdvcnRoeSB3cm90ZToNCj4gPiA+ID4+Pg0K
PiA+ID4gPj4+IE9uIFJaL04xIGRldmljZXMsIHRoZXJlIGFyZSAzIFN5bm9wc3lzIERlc2lnbldh
cmUgR1BJTyBibG9ja3MNCj4gPiA+ID4+PiBlYWNoIGNvbmZpZ3VyZWQgdG8gaGF2ZSAzMiBpbnRl
cnJ1cHQgb3V0cHV0cywgc28gd2UgaGF2ZSBhIHRvdGFsDQo+ID4gPiA+Pj4gb2YgOTYgR1BJTyBp
bnRlcnJ1cHRzLiBBbGwgb2YgdGhlc2UgYXJlIHBhc3NlZCB0byB0aGUgR1BJTyBJUlENCj4gPiA+
ID4+PiBNdXhlciwgd2hpY2ggc2VsZWN0cw0KPiA+ID4gPj4+IDggb2YgdGhlIEdQSU8gaW50ZXJy
dXB0cyB0byBwYXNzIG9udG8gdGhlIEdJQy4gVGhlIGludGVycnVwdA0KPiA+ID4gPj4+IHNpZ25h
bHMgYXJlbid0IGxhdGNoZWQsIHNvIHRoZXJlIGlzIG5vdGhpbmcgdG8gZG8gaW4gdGhpcyBkcml2
ZXINCj4gPiA+ID4+PiB3aGVuIGFuIGludGVycnVwdCBpcyByZWNlaXZlZCwgb3RoZXIgdGhhbiB0
ZWxsIHRoZSBjb3JyZXNwb25kaW5nDQo+ID4gPiA+Pj4gR1BJTw0KPiA+IGJsb2NrLg0KPiA8c25p
cD4NCj4gDQo+ID4gPiBUaGVyZSBhcmUgdHdvIGNhc2VzOg0KPiA+ID4gMSkgdGhlcmUgaXMgMTox
IG1hcHBpbmcgYmV0d2VlbiBhIHVzZWQgaW5wdXQgYW5kIGFuIG91dHB1dCwgbGVhdmluZw0KPiA+
ID4gc29tZSBpbnB1dCB1bnVzZWQNCj4gPiA+IDIpIHRoZXJlIGlzIGFuIG46MSBtYXBwaW5nIGJl
dHdlZW4gaW5wdXQgYW5kIG91dHB1dCwgYW5kIGFsbCB0aGUNCj4gPiA+IGlucHV0IGNhbiBiZSB1
c2VkIGF0IGFueSBnaXZlbiB0aW1lDQo+ID4gPg0KPiA+ID4gSWYgd2hhdCB5b3UgaGF2ZSBpcyAo
MSksIHlvdSBuZWVkIHRvIGltcGxlbWVudCBhbiBoaWVyYXJjaHkuDQo+ID4gPiBJZiB3aGF0IHlv
dSBoYXZlIGlzICgyKSwgeW91IG5lZWQgdG8gaW1wbGVtZW50IGEgY2hhaW5lZCBjb250cm9sbGVy
Lg0KPiA+ID4NCj4gPiA+ICgxKSByZXF1aXJlcyB5b3UgdG8gcmV2aXNpdCB0aGlzIGRyaXZlciwg
bWFraW5nIGl0IGEgbG90IG1vcmUgbGlrZQ0KPiA+ID4gdGkncyBpcnEtY3Jvc3NiYXINCj4gPiA+
ICgyKSByZXF1aXJlcyB5b3UgdG8gYWN0dWFsbHkgZG8gc29tZSBkZWNvZGluZyBpbiB0aGUgY2hh
aW5lZCBoYW5kbGVyDQo+ID4gPg0KPiA+ID4gSSBiZWxpZXZlIHlvdSdyZSBpbiBjb25maWd1cmF0
aW9uICgxKS4gQW0gSSByaWdodD8NCj4gPiBSaWdodCwgaXQncyBhIDE6MSBtYXBwaW5nLiBUaGUg
aW5mb3JtYXRpb24gYWJvdXQgd2hpY2ggaW5wdXQgdG8gYmUNCj4gPiB1c2VkIG5lZWRzIHRvIGJl
IHNwZWNpZmllZCBpbiBkdC4NCj4gPiBJIGRpZG7igJl0IHRoaW5rIEkgY291bGQgaW1wbGVtZW50
IGEgaGllcmFyY2h5IHRoYXQgZGlkbuKAmXQgbWFzayB0aGUNCj4gPiBpbnRlcnJ1cHRzLCBzbyBJ
IG5lZWQgdG8gZ28gYmFjayBvdmVyIHRoYXQgYW5kIGxvb2sgYWdhaW4uLi4NCj4gDQo+IE9rLCBJ
IGhhdmUgY2hhbmdlZCB0aGUgZHJpdmVyIHRvIGltcGxlbWVudCBhIGhpZXJhcmNoeSwgaS5lLg0K
PiBjYWxsIGlycV9kb21haW5fY3JlYXRlX2hpZXJhcmNoeSgpIGluIHByb2JlLCBjYWxsDQo+IGly
cV9kb21haW5fc2V0X2h3aXJxX2FuZF9jaGlwKCkgYW5kIGlycV9kb21haW5fYWxsb2NfaXJxc19w
YXJlbnQoKSBpbg0KPiB0aGUgaXJxX2RvbWFpbl9vcHMuYWxsb2MgZnVuY3Rpb24uDQoNCkkgc3Vz
cGVjdCB0aGF0IEkgd2VudCBpbiB0aGUgd3JvbmcgZGlyZWN0aW9uIHlldCBhZ2Fpbi4uLg0KQWZ0
ZXIgbG9va2luZyBhdCBSb2IgSCdzIGVtYWlsIGFnYWluLCBJIGFtIG5vdyBvZiB0aGUgb3Bpbmlv
biB0aGF0IHRoaXMNCmhhcmR3YXJlLCBhbmQgdGhlIHdheSB0byBoYW5kbGUgaXQsIGlzIHZlcnkg
c2ltaWxhciB0byBQQ0llIE1TSS4NCg0KQSBjdXRkb3duIERUIGxvb2tzIGxpa2UgdGhpczoNCglp
bnRlcnJ1cHRzID0NCgkJPEdJQ19TUEkgMTAzIElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KCQk8R0lD
X1NQSSAxMDQgSVJRX1RZUEVfTEVWRUxfSElHSD47DQoJI2ludGVycnVwdC1jZWxscyA9IDwxPjsN
CgkjYWRkcmVzcy1jZWxscyA9IDwwPjsNCglpbnRlcnJ1cHQtbWFwLW1hc2sgPSA8MTI3PjsNCglp
bnRlcnJ1cHQtbWFwID0NCgkJLyogZ3BpbzJhIDI0LCBwaW4gMTQ2OiBFVEggUG9ydCAxIElSUSAq
Lw0KCQk8ODggJmdpYyBHSUNfU1BJIDEwMyBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCgkJLyogZ3Bp
bzJhIDI2LCBwaW4gMTQ4OiBUb3VjaHNjcmVlbl9JUlEgKi8NCgkJPDkwICZnaWMgR0lDX1NQSSAx
MDQgSVJRX1RZUEVfTEVWRUxfSElHSD47DQoNClRoZSBvbmx5IGlzc3VlIGlzIHRoYXQgSSBjYW4n
dCBzZWUgaG93IHRvIGdldCB0aGUgZmlyc3QgZWxlbWVudCBvZiBlYWNoDQppbnRlcnJ1cHQtbWFw
IGVudHJ5IGluIHRoZSBkcml2ZXIuIFRoZSBkcml2ZXIgbmVlZHMgdG8ga25vdyB0aGF0IGlucHV0
DQppbnRlcnJ1cHQgaHdpcnEgODggY29ycmVzcG9uZHMgdG8gR0lDX1NQSSAxMDMsIGFuZCA5MCB0
byBHSUNfU1BJIDEwNC4NCg0KVGhhbmtzIGZvciB5b3VyIHRpbWUgJiBwYXRpZW5jZSwNClBoaWwN
Cg==
