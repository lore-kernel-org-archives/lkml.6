Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EAAC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10832054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="xuhttDiR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10832054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeH3Nhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 09:37:37 -0400
Received: from mail-eopbgr700081.outbound.protection.outlook.com ([40.107.70.81]:28592
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727796AbeH3Nhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 09:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/yyTmvfdezZ2533kmK0iuLh0hZQDvVQjD5f4u1RGnQ=;
 b=xuhttDiRHBLV+/hjNWDTa/lpBXRuh9lGPnqeNs+Pq0gYF+lx3BkcAOUCky/vayXzzXJVqw+0eHdSpHgaAer7Gp5945KM/0HvIDEtB0KJMjtRNCL/aTcGu9RA/CWm2AYCi6VNuznQq7KtfztTAX6lUt2ZKXlODiiHaICLRWS1bh0=
Received: from MWHPR0201MB3628.namprd02.prod.outlook.com (10.167.162.139) by
 MWHPR0201MB3564.namprd02.prod.outlook.com (10.167.162.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.14; Thu, 30 Aug 2018 09:32:15 +0000
Received: from MWHPR0201MB3628.namprd02.prod.outlook.com
 ([fe80::fd25:7ec:f442:f9b5]) by MWHPR0201MB3628.namprd02.prod.outlook.com
 ([fe80::fd25:7ec:f442:f9b5%4]) with mapi id 15.20.1080.015; Thu, 30 Aug 2018
 09:32:15 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, Vinod <vkoul@kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: RE: [PATCH] dmaengine: Add metadata_ops for dma_async_tx_descriptor
Thread-Topic: [PATCH] dmaengine: Add metadata_ops for dma_async_tx_descriptor
Thread-Index: AQHUOuJGBvlKdSdsj0aGkQHLgmKh+qTW6rsAgAAGNACAAAIiAIABFjkAgAAHFxA=
Date:   Thu, 30 Aug 2018 09:32:15 +0000
Message-ID: <MWHPR0201MB3628F1B65ECC5CD366B89370C7080@MWHPR0201MB3628.namprd02.prod.outlook.com>
References: <20180823130728.20506-1-peter.ujfalusi@ti.com>
 <20180829155212.GG2388@vkoul-mobl>
 <ae790f49-40f6-8b89-6ec5-c3f3aeb09067@ti.com>
 <20180829162202.GI2388@vkoul-mobl>
 <2575b93d-f236-1c52-1633-ed51e29141b5@ti.com>
In-Reply-To: <2575b93d-f236-1c52-1633-ed51e29141b5@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0201MB3564;6:TdQDiOW/HXFO2vo9VXU2/ZnVomuPLAc0bp6do3aDPlR2+M6mjFL5410tGlhk1+mnud2WqL6kBTl9Ig7igrorocig4lbQMxjD2/hCiS0/jqRpeXPkxsvzhwgdQJCHPxzK3Q2W49J6pU8S84s1MSXouA0dnZhASVbK/jIs/9wr8b6EcpuA3nkpCxn6KQ03sNHMvroP8dc+dpzPe47BXWgGu20yGkPSh5jPp7lbBjW8hVspn5+BhzfPg9I/nQSm0nkDgi/aNvx2Kj14L2X9kQM0TM+DALZFzsRqt4jHp0SDltPvPZd1OSgegoqfIr1E6jtpq3AqsWpsBhDgHUch9pboqL2/qjtGLU4R7q5BsLt0rt0LeJ8pmF2gPOd9jO9BLCPfIMvBKonkwCwzTWrXS4AA/yqYR0vHocerD4t2wL1QvViiM63H710avJ/MfRbbo9SkvvPOUMewM8+ZrXng9TwauA==;5:SoWXAl1/vnFkF5gc9F2Stkj+s3yUVs1GrrS+/mYlSFgL5B7Dr5o/VlUj0SDuRVhmP9p6UGljBq/w+/K2OeJvDfcS/Wr0AeoaJMS+1TmUGNiByjJ/qpA04v6VCzAmzurxmVJLlYhAJIopNXJuQceQr94lbVqh+dQOvJhH80OSMp0=;7:99CCLkBNiKAlHeLjysQvzyCJnq5L9bxTs9Mrzyf1zQlbCRE7kJHLkwv9Bk0CPD2nG8Lf4eO5pKffetDY6JYnF9HI4IT8CxDFHYYd1EMQvFHYeqjymwtnul26Og+DVjfwZAXQZnCXFjZZD1/9zlbcSVNP35F0TM7RGexOwfXd34LKOJnospRqsLdmJoHa/ZVZi2eRsveJZ9cQpKN+zZNarohEHeqnpUFs+EceIi2V+KiwjJCM7KRhoCHL1fu/maUj
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 71ae3265-f339-4e6d-db98-08d60e5b7940
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR0201MB3564;
x-ms-traffictypediagnostic: MWHPR0201MB3564:
x-microsoft-antispam-prvs: <MWHPR0201MB35648E585AD018FFD17A17EAC7080@MWHPR0201MB3564.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:MWHPR0201MB3564;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3564;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(376002)(346002)(396003)(136003)(366004)(199004)(189003)(2900100001)(966005)(14454004)(76176011)(478600001)(68736007)(7736002)(97736004)(74316002)(8676002)(81166006)(3846002)(6116002)(81156014)(8936002)(305945005)(106356001)(5250100002)(105586002)(256004)(53546011)(316002)(4326008)(6246003)(6436002)(25786009)(102836004)(54906003)(229853002)(55016002)(99286004)(5660300001)(446003)(14444005)(11346002)(2906002)(33656002)(7696005)(86362001)(5024004)(53936002)(486006)(6306002)(26005)(9686003)(110136005)(476003)(93886005)(66066001)(6506007)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3564;H:MWHPR0201MB3628.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GNQF/tGSQGuHuLxjYJ/lltdzZ4Cuxi0SbGZVMkc02x+6SLrDx68z7/akHvnt37Bx//M14ZNdo7yN0YBB2tRI9PC9f0azo34FsiCStMzXf89AVv1TA6/MJvCHYNGNuTkHtzvi0r9fFflU57igF89j6o+f0J05x43wO7+0pIcdPfXpXs5tDaK95w5cdwGr8SZz2gUd+lI4F7kBcN9q4o5kY91tRsGhWNYhY2qJEag/dRMH5sitSvjub2vL64PIJO5JDVI3w6zn3K2ewi8aJntzMVltl+0n16P/gAeiix0NrZX2yEFLBKjMayHs1dKrYT/dUO4wj9xHCeCXZaeYlprB2Oq870+gIcxZ9VV4MLNB0sw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ae3265-f339-4e6d-db98-08d60e5b7940
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 09:32:15.7549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3564
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PHNuaXA+DQo+IFZpbm9kLA0KPiANCj4gT24gMjAxOC0wOC0yOSAxOToyMiwgVmlub2Qgd3JvdGU6
DQo+ID4+Pj4gKyAqICAgMi4gdXNlIGRtYWVuZ2luZV9kZXNjX2F0dGFjaF9tZXRhZGF0YSgpIHRv
IGF0dGFjaCB0aGUgYnVmZmVyIHRvDQo+IHRoZQ0KPiA+Pj4+ICsgKglkZXNjcmlwdG9yDQo+ID4+
Pj4gKyAqICAgMy4gc3VibWl0IHRoZSB0cmFuc2Zlcg0KPiA+Pj4+ICsgKiAtIERNQV9ERVZfVE9f
TUVNOg0KPiA+Pj4+ICsgKiAgIDEuIHByZXBhcmUgdGhlIGRlc2NyaXB0b3IgKGRtYWVuZ2luZV9w
cmVwXyopDQo+ID4+Pj4gKyAqICAgMi4gdXNlIGRtYWVuZ2luZV9kZXNjX2F0dGFjaF9tZXRhZGF0
YSgpIHRvIGF0dGFjaCB0aGUgYnVmZmVyIHRvDQo+IHRoZQ0KPiA+Pj4+ICsgKglkZXNjcmlwdG9y
DQo+ID4+Pj4gKyAqICAgMy4gc3VibWl0IHRoZSB0cmFuc2Zlcg0KPiA+Pj4+ICsgKiAgIDQuIHdo
ZW4gdGhlIHRyYW5zZmVyIGlzIGNvbXBsZXRlZCwgdGhlIG1ldGFkYXRhIHNob3VsZCBiZSBhdmFp
bGFibGUNCj4gaW4gdGhlDQo+ID4+Pj4gKyAqCWF0dGFjaGVkIGJ1ZmZlcg0KPiA+Pj4NCj4gPj4+
IEkgZ3Vlc3MgdGhpcyBpcyBnb29kIHRvIGJlIG1vdmVkIGludG8gRG9jdW1lbnRhdGlvbg0KPiA+
Pg0KPiA+PiBTaG91bGQgSSBjcmVhdGUgYSBuZXcgZmlsZSBmb3IgbWV0YWRhdGE/IEkgZ3Vlc3Mg
aXQgd291bGQgbWFrZSBzZW5zZSBhcyB0aGUNCj4gPj4gaW5mb3JtYXRpb24gaXMgZm9yIGJvdGgg
Y2xpZW50cyBhbmQgZW5naW5lcy4NCj4gPg0KPiA+IEhtbSBub3Qgc3VyZSwgbGV0cyBzZWUgaG93
IGl0IGxvb2tzIGFzIGVudHJpZXMgaW4gdGhlc2UgZmlsZXMsIGRldGFpbGluZw0KPiA+IHJvbGVz
IG9mIGNsaWVudHMgYW5kIHByb3ZpZGVycw0KPiANCj4gVXBkYXRlIGJvdGggY2xpZW50IGFuZCBw
cm92aWRlciBkb2N1bWVudGF0aW9uIHdpdGggdGFpbG9yaW5nIHRoZSBjb250ZW50DQo+IGZvciB0
aGUgYXVkaWVuY2U/DQo+IA0KPiA+Pj4gYWxzbyB3ZSBkb250IGFsbG93IHRoaXMgZm9yIG1lbWNw
eSB0eG4/DQo+ID4+DQo+ID4+IEkgaGF2ZSBub3QgdGhvdWdodCBhYm91dCB0aGF0LCBidXQgaWYg
SSB0aGluayBhYm91dCBpdCBpdCBzaG91bGQgYmUgYWxvbmcgdGhlDQo+ID4+IHNhbWUgbGluZXMg
YXMgTUVNX1RPX0RFVi4NCj4gPj4gSSdsbCBhZGQgdGhlIE1FTV9UT19NRU0gYXMgd2VsbCB0byB0
aGUgZG9jdW1lbnRhdGlvbi4NCj4gPg0KPiA+IE9rYXkgYW5kIGxldHMgbm90IGltcGxlbWVudCBp
dCB0aGVuLi4NCj4gDQo+IEknbSBub3QgZ29pbmcgdG8gaW1wbGVtZW50IGl0LCBidXQgdGhlIGRv
Y3VtZW50YXRpb24gY291bGQgYWRkIHRoYXQgaWYNCj4gbWV0YWRhdGEgaXMgdXNlZCBmb3IgTUVN
X1RPX01FTSB0aGVuIGl0IGlzIHRoZSBzYW1lIHVzZSBjYXNlIGFzIHdpdGgNCj4gTUVNX1RPX0RF
Vi4NCj4gDQo+ID4NCj4gPj4NCj4gPj4+PiArICoNCj4gPj4+PiArICogQERFU0NfTUVUQURBVEFf
RU5HSU5FIC0gdGhlIG1ldGFkYXRhIGJ1ZmZlciBpcw0KPiBhbGxvY2F0ZWQvbWFuYWdlZCBieSB0
aGUgRE1BDQo+ID4+Pj4gKyAqICBkcml2ZXIuIFRoZSBjbGllbnQgZHJpdmVyIGNhbiBhc2sgZm9y
IHRoZSBwb2ludGVyLCBtYXhpbXVtIHNpemUgYW5kDQo+IHRoZQ0KPiA+Pj4+ICsgKiAgY3VycmVu
dGx5IHVzZWQgc2l6ZSBvZiB0aGUgbWV0YWRhdGEgYW5kIGNhbiBkaXJlY3RseSB1cGRhdGUgb3Ig
cmVhZCBpdC4NCj4gPj4+PiArICogIGRtYWVuZ2luZV9kZXNjX2dldF9tZXRhZGF0YV9wdHIoKSBh
bmQNCj4gZG1hZW5naW5lX2Rlc2Nfc2V0X21ldGFkYXRhX2xlbigpIGlzDQo+ID4+Pj4gKyAqICBw
cm92aWRlZCBhcyBoZWxwZXIgZnVuY3Rpb25zLg0KPiA+Pj4+ICsgKg0KPiA+Pj4+ICsgKiBDbGll
bnQgZHJpdmVycyBpbnRlcmVzdGVkIHRvIHVzZSB0aGlzIG1vZGUgY2FuIGZvbGxvdzoNCj4gPj4+
PiArICogLSBETUFfTUVNX1RPX0RFVjoNCj4gDQo+IEhlcmUsIGFkZCBETUFfTUVNX1RPX01FTQ0K
PiANCj4gPj4+PiArICogICAxLiBwcmVwYXJlIHRoZSBkZXNjcmlwdG9yIChkbWFlbmdpbmVfcHJl
cF8qKQ0KPiA+Pj4+ICsgKiAgIDIuIHVzZSBkbWFlbmdpbmVfZGVzY19nZXRfbWV0YWRhdGFfcHRy
KCkgdG8gZ2V0IHRoZSBwb2ludGVyIHRvIHRoZQ0KPiBlbmdpbmUncw0KPiA+Pj4+ICsgKgltZXRh
ZGF0YSBhcmVhDQo+ID4+Pj4gKyAqICAgMy4gdXBkYXRlIHRoZSBtZXRhZGF0YSBhdCB0aGUgcG9p
bnRlcg0KPiA+Pj4+ICsgKiAgIDQuIHVzZSBkbWFlbmdpbmVfZGVzY19zZXRfbWV0YWRhdGFfbGVu
KCkgIHRvIHRlbGwgdGhlIERNQSBlbmdpbmUNCj4gdGhlIGFtb3VudA0KPiA+Pj4+ICsgKglvZiBk
YXRhIHRoZSBjbGllbnQgaGFzIHBsYWNlZCBpbnRvIHRoZSBtZXRhZGF0YSBidWZmZXINCj4gPj4+
PiArICogICA1LiBzdWJtaXQgdGhlIHRyYW5zZmVyDQo+ID4+Pj4gKyAqIC0gRE1BX0RFVl9UT19N
RU06DQo+ID4+Pj4gKyAqICAgMS4gcHJlcGFyZSB0aGUgZGVzY3JpcHRvciAoZG1hZW5naW5lX3By
ZXBfKikNCj4gPj4+PiArICogICAyLiBzdWJtaXQgdGhlIHRyYW5zZmVyDQo+ID4+Pj4gKyAqICAg
My4gb24gdHJhbnNmZXIgY29tcGxldGlvbiwgdXNlIGRtYWVuZ2luZV9kZXNjX2dldF9tZXRhZGF0
YV9wdHIoKQ0KPiB0byBnZXQgdGhlDQo+ID4+Pj4gKyAqCXBvaW50ZXIgdG8gdGhlIGVuZ2luZSdz
IG1ldGFkYXRhIGFyZQ0KPiA+Pj4+ICsgKiAgIDQuIFJlYWQgb3V0IHRoZSBtZXRhZGF0ZSBmcm9t
IHRoZSBwb2ludGVyDQo+ID4+Pj4gKyAqDQo+ID4+Pj4gKyAqIE5vdGU6IHRoZSB0d28gbW9kZSBp
cyBub3QgY29tcGF0aWJsZSBhbmQgY2xpZW50cyBtdXN0IHVzZSBvbmUgbW9kZQ0KPiBmb3IgYQ0K
PiA+Pj4+ICsgKiBkZXNjcmlwdG9yLg0KPiA+Pj4+ICsgKi8NCj4gPj4+PiArZW51bSBkbWFfZGVz
Y19tZXRhZGF0YV9tb2RlIHsNCj4gPj4+PiArCURFU0NfTUVUQURBVEFfQ0xJRU5UID0gKDEgPDwg
MCksDQo+ID4+Pj4gKwlERVNDX01FVEFEQVRBX0VOR0lORSA9ICgxIDw8IDEpLA0KPiA+Pj4NCj4g
Pj4+IEJJVCh4KQ0KPiA+Pg0KPiA+PiBPSywgSSBmb2xsb3dlZCB3aGF0IHdlIGhhdmUgaW4gdGhl
IGhlYWRlciB0byBub3QgbWl4ICgxIDw8IHgpIGFuZCBCSVQoeCkNCj4gPg0KPiA+IHllYWggbGV0
cyB1cGRhdGUgOikNCj4gDQo+IE9LLg0KPiANCj4gPj4+PiArc3RhdGljIGlubGluZSBpbnQgX2Rl
c2NfY2hlY2tfYW5kX3NldF9tZXRhZGF0YV9tb2RlKA0KPiA+Pj4NCj4gPj4+IHdoeSBkb2VzIHRo
aXMgbmVlZCB0byBzdGFydCB3aXRoIF8gPw0KPiA+Pg0KPiA+PiBUbyBzY2FyZSBwZW9wbGUgdG8g
dXNlIGluIGNsaWVudCBjb2RlIDspDQo+ID4NCj4gPiBMZXRzIG5vdCBleHBvc2UgdG8gdGhlbSA6
RA0KPiANCj4gU3VyZSwgaWYgdGhlIGNvZGUgbW92ZXMgdG8gZG1hZW5naW5lLmMgaXQgaXMgZ3Jh
bnRlZC4NCj4gDQo+ID4+PiBBbHNvIEkgd291bGQgbGlrZSB0byBzZWUgYSB1c2UgOi0pIGJlZm9y
ZSBmdXJ0aGVyIGNvbW1lbnRzLg0KPiA+Pg0KPiA+PiBZb3UgbWVhbiB0aGUgRE1BIGRyaXZlciBh
bmQgYXQgbGVhc3Qgb25lIGNsaWVudD8NCj4gPg0KPiA+IERNQSBkcml2ZXIgdG8gX2F0X2xlYXN0
XyBzdGFydCB3aXRoLiBDbGllbnQgZXZlbiBiZXR0ZXINCj4gDQo+IEhybSwgSSBjYW4gc2VuZCB0
aGUgRE1BIGRyaXZlciBhcyBSRkMgKG5vdCB0byBtZXJnZSwgd2lsbCBub3QgY29tcGlsZSkNCj4g
YnV0IEkgbmVlZCB0byBkbyBzb21lIGV4Y2VzcyBjb3ZlciBsZXR0ZXIgYW5kIGRvY3VtZW50YXRp
b24gc2luY2UgdGhlDQo+IFVETUEgaXMgJ2p1c3QnIGEgcGllY2UgaW4gdGhlIGRhdGEgbW92ZW1l
bnQgYXJjaGl0ZWN0dXJlIGFuZCBuZWVkIHRvDQo+IGV4cGxhaW4gY291cGxlIG9mIHRoaW5ncyBh
cm91bmQgaXQuDQo+IA0KPiBJIHdpbGwgbmVlZCBjb3VwbGUgb2YgZGF5cyBmb3IgdGhhdCBmb3Ig
c3VyZS4NCj4gDQo+ID4+IEkgaGF2ZSB0aGUgRE1BIGRyaXZlciBpbiBteSBwdWJsaWMgZmFjaW5n
IGJyYW5jaCBbMV0sIGJ1dCBpdCBpcyBub3QgYW4gZWFzeQ0KPiA+PiByZWFkIHdpdGggaXQncyBj
bG9zZSB0byA0ayBsb2MuDQo+ID4NCj4gPiBJdCBkb2VzbnQgZXhpc3QgOlANCj4gDQo+IEluIHRo
aXMgc2Vuc2UgaXQgZG9lcyBub3QsIGFncmVlLg0KPiANCj4gPj4gVGhlIGNsaWVudCBpcyBub3Qg
aW4gbXkgYnJhbmNoIGFuZCBpdCBpcyBhY3R1YWxseSB1c2luZyBhbiBvbGRlciB2ZXJzaW9uIG9m
DQo+ID4+IHRoZSBtZXRhZGF0YSBzdXBwb3J0Lg0KPiA+Pg0KPiA+PiBUaGUgcHJvYmxlbSBpcyB0
aGF0IEkgZG9uJ3Qga25vdyB3aGVuIEkgd2lsbCBiZSBhYmxlIHRvIHNlbmQgdGhlIGRyaXZlciBm
b3INCj4gPj4gcmV2aWV3IGFzIGFsbCBvZiB0aGlzIGlzIHRhcmdldGluZyBhIGJyYW5kIG5ldyBT
b0MgKEFNNjU0KSB3aXRoIGNvbXBsZXRlbHkNCj4gbmV3DQo+ID4+IGRhdGEgbW92ZW1lbnQgYXJj
aGl0ZWN0dXJlLiBUaGVyZSBhcmUgbG90cyBvZiBkZXBlbmRlbmNpZXMgc3RpbGwgbmVlZCB0byBi
ZQ0KPiA+PiB1cHN0cmVhbWVkIGJlZm9yZSBJIGNhbiBzZW5kIHNvbWV0aGluZyB3aGljaCBhdCBs
ZWFzdCBjb21waWxlcy4NCj4gPj4NCj4gPj4gSSBjYW4gb2ZmZXIgc25pcHBldHMgZnJvbSB0aGUg
Y2xpZW50IGRyaXZlciwgaWYgdGhhdCBpcyBnb29kIGVub3VnaCBvciBhIGxpbmsNCj4gPj4gdG8g
dGhlIHB1YmxpYyB0cmVlIHdoZXJlIGl0IGNhbiBiZSBhY2Nlc3NlZCwgYnV0IGl0IGlzIG5vdCBn
b2luZyB0byBnbw0KPiA+PiB1cHN0cmVhbSBiZWZvcmUgdGhlIERNQSBkcml2ZXIuDQo+ID4NCj4g
PiBUQkggdGhhdCdzIG5vdCBnb2luZyB0byBoZWxwIG11Y2gsIGxldHMgY29tZSBiYWNrIHRvIGl0
IHdoZW4geW91IG5lZWQNCj4gPiB0aGlzIHVwc3RyZWFtLg0KPiANCj4gT25lIG9mIHRoZSByZWFz
b24gSSBoYXZlIHNlbnQgdGhlIG1ldGFkYXRhIHN1cHBvcnQgZWFybHkgaXMgYmVjYXVzZQ0KPiBS
YWRoZXkgd2FzIGxvb2tpbmcgZm9yIHNpbWlsYXIgdGhpbmcgZm9yIHhpbGlueF9kbWEgYW5kIEkg
YWxyZWFkeSBoYWQNCj4gdGhlIGdlbmVyaWMgaW1wbGVtZW50YXRpb24gb2YgaXQgd2hpY2ggc3Vp
dHMgaGlzIGNhc2UuDQo+IA0KPiBJIHdhcyBwbGFubmluZyB0byBzZW5kIHRoZSBtZXRhZGF0YSBz
dXBwb3J0IGFsb25nIHdpdGggdGhlIERNQSBkcml2ZXINCj4gKGFuZCBvdGhlciBjb3JlIGNoYW5n
ZXMsIG5ldyBmZWF0dXJlcykuDQo+IA0KPiBJZiBub3QgZm9yIG1lLCB0aGVuIGZvciBSYWRoZXkn
cyBzdGFrZSBjYW4gdGhlIG1ldGFkYXRhIHN1cHBvcnQgYmUNCj4gY29uc2lkZXJlZCBhcyBzdGFu
ZCBhbG9uZSBmb3Igbm93Pw0KDQpUaGFua3MsIFBldGVyLiBJIHdhcyB0aGlua2luZyB0byBwdXQg
dGhlIHNhbWUgcmVxdWVzdC4gQmFzZWQgb24gbWV0YWRhdGFfb3BzDQpSRkMsIEkgY2FuIHNlbmQg
djIgb2YgbXkgZWFybGllciBwYXRjaHNldFsxXS4gT25jZSBpdCBpcyBhY2tlZCwgSSB3aWxsIG5l
eHQNCnNlbmQgY2xpZW50IGF4aWV0aGVybmV0IGRyaXZlclsyXSBSRkMgdG8gbmV0d29ya2luZyBt
YWlsaW5nIGxpc3QuDQoNCkxldCdzIHdhaXQgZm9yIFZpbm9kJ3MgaW5wdXRzLg0KDQpbMV0gaHR0
cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvZG1hZW5naW5lL21zZzE1MjA4Lmh0bWwNClsyXSBo
dHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQveGlsaW54L3hpbGlueF9heGllbmV0X21haW4uYw0KDQo+IA0KPiBJIHdpbGwgc2Vu
ZCB2MiBhcyBzb29uIGFzIEkgaGF2ZSBpdCByZWFkeSBhbmQgSSB3aWxsIHNlbmQgZWl0aGVyIHYz
IHdpdGgNCj4gdGhlIGszLXVkbWEgRE1BIGRyaXZlciAoVURNQSBkcml2ZXJzIGFzIG5vdCBmb3Ig
bWVyZ2UpIG9yIHN0YW5kYWxvbmUNCj4gVURNQSBkcml2ZXIgYXMgUkZDIGFuZCBmb3IgcmVmZXJl
bmNlLg0KPiANCj4gLSBQw6l0ZXINCj4gDQo+IFRleGFzIEluc3RydW1lbnRzIEZpbmxhbmQgT3ks
IFBvcmtrYWxhbmthdHUgMjIsIDAwMTgwIEhlbHNpbmtpLg0KPiBZLXR1bm51cy9CdXNpbmVzcyBJ
RDogMDYxNTUyMS00LiBLb3RpcGFpa2thL0RvbWljaWxlOiBIZWxzaW5raQ0K
