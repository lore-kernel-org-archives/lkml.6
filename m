Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D91C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5CA42086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="f9BbQl9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5CA42086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbeLLOSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:18:22 -0500
Received: from mail-eopbgr780050.outbound.protection.outlook.com ([40.107.78.50]:11712
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726249AbeLLOSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XgW3jIXWmzzzoZZPLg2CuM/sIjES0DJDlbuVXLD1NU=;
 b=f9BbQl9pjw1fIAKECt2lmFJHJYbqWPT36D5OTn5Xm7+zk7a1+tk6JV28PTCw8HSCf2Uo6919/TN/ux2fCpyOGAixqvTbkfQJ65YywUlOaOx7SAqalDPZ9Q7wozHpQ8i632THWyHgjw/l4wgtq9SKZt2Gm5eqL1+oi+vPMXPenb8=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB0830.namprd12.prod.outlook.com (10.164.26.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Wed, 12 Dec 2018 14:18:17 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5%6]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 14:18:16 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>
CC:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [RFC PATCH 4/4] x86/TSC: Use RDTSCP
Thread-Topic: [RFC PATCH 4/4] x86/TSC: Use RDTSCP
Thread-Index: AQHUkaAqfD7bV8pvnUyLofBVRH7Ye6V6JxMA//+fHICAAGvzgIAALk0AgABiIACAAGU6AA==
Date:   Wed, 12 Dec 2018 14:18:16 +0000
Message-ID: <5aae6048-8938-de73-bf36-741631a882dc@amd.com>
References: <20181211222326.14581-1-bp@alien8.de>
 <20181211222326.14581-5-bp@alien8.de>
 <CALCETrVArfAAbQKJ-g_5pOy6dMVgx-FC_mjdC9xzL1jU9T07jw@mail.gmail.com>
 <59aad362-4a5b-dd8b-642f-0dc3f83cf7ee@amd.com>
 <20181211233901.GV27375@zn.tnic>
 <CALCETrXvZ4avdUh2bTLVTTz3Jxogo3zK5akWTsJ=rkJpf1XiDg@mail.gmail.com>
 <4ddd7ecf-6f90-a25b-e8b7-1459cc312dba@amd.com>
In-Reply-To: <4ddd7ecf-6f90-a25b-e8b7-1459cc312dba@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0601CA0017.namprd06.prod.outlook.com
 (2603:10b6:803:2f::27) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0830;20:6sYq+/wlaxNkKuUVVRv1GOAkDbCPxezKehoVK+etNK55CA9z6vW3N405ALxxliLe1+308PUGE/RoF7eSTlkMx+tuIEQpCpkhm1oKLH51Dpe02oNVQ5TT3vvX/yK1teXbPaIbSzU41GKh736Na/CfruaxsXUk9yevEXGaGHpyoZKf1ZYTvT2MrPF5G+NQ6nHMNvJ0iafzJ9BnVI7igpUvB46KknHtraLN1MYFd2W25+ziE7Nh+NRsx7nBfYlJHzIz
x-ms-office365-filtering-correlation-id: 6c9797a6-60d4-4dda-1166-08d6603ca8bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0830;
x-ms-traffictypediagnostic: SN1PR12MB0830:
x-microsoft-antispam-prvs: <SN1PR12MB083064178D1E3984C0A27934ECA70@SN1PR12MB0830.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB0830;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0830;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(366004)(39860400002)(189003)(199004)(8936002)(72206003)(86362001)(71190400001)(4326008)(6116002)(97736004)(31696002)(3846002)(71200400001)(6246003)(76176011)(6306002)(6506007)(52116002)(53936002)(53546011)(102836004)(6512007)(386003)(217873002)(186003)(26005)(6486002)(106356001)(256004)(14454004)(7736002)(99286004)(5660300001)(229853002)(66066001)(105586002)(2906002)(486006)(2616005)(11346002)(446003)(478600001)(6436002)(31686004)(68736007)(966005)(93886005)(36756003)(110136005)(81156014)(25786009)(316002)(81166006)(305945005)(54906003)(476003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0830;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: s7FxPR8yqjGEJGOK9Cuk15qQv6d0ayb+ePo8HKm+8gPJrAgiBI2lR3XJ3wuWiVOE0RhJ588xd4c9V2NugNmQFENAz0kHi7I5351cYbs06XZ1UD3R7Vi3sPn4mOpbAEOKy9sa9b39x+Rk7SGDp68Fg4Hmxl9C8OCBJuMW9Vzw0eF6NGIDi5p5p6q3PpfHkEQbrc9w8QCnC5iyQakKqL1GNEu0je2jLJKqYYMI5rOrQxUywg1qgNiWYfmBi3JynSGCYbJ3Why+PwqzR/x3jXKStE2yJ8cDtJjIyLKT5xmnijfD+J1UDChHkNjXR5EMApuq
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D38364A834E1B342B1E22ADE0F113A72@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9797a6-60d4-4dda-1166-08d6603ca8bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 14:18:16.8313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0830
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMTIvMjAxOCAwODoxNSBBTSwgVG9tIExlbmRhY2t5IHdyb3RlOg0KPiBPbiAxMi8xMS8y
MDE4IDA4OjI0IFBNLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6DQo+Pj4gT24gRGVjIDExLCAyMDE4
LCBhdCAzOjM5IFBNLCBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4gd3JvdGU6DQo+Pj4N
Cj4+Pj4gT24gVHVlLCBEZWMgMTEsIDIwMTggYXQgMTE6MTI6NDFQTSArMDAwMCwgTGVuZGFja3ks
IFRob21hcyB3cm90ZToNCj4+Pj4gSXQgZG9lcyBzZWVtIG92ZXJsb2FkZWQgaW4gdGhhdCBzZW5z
ZSwgYnV0IHRoZSBmZWF0dXJlIG1lYW5zIHRoYXQgTEZFTkNFDQo+Pj4+IGlzIHNlcmlhbGl6aW5n
IGFuZCBzbyBjYW4gYmUgdXNlZCBpbiByZHRzY19vcmRlcmVkLiBJbiB0aGUgc2FtZSBzZW5zZSwN
Cj4+Pj4gYmFycmllcl9ub3NwZWMgaXMgbG9va2luZyBmb3Igd2hldGhlciBMRkVOQ0UgaXMgc2Vy
aWFsaXppbmcgYW5kIHByZWZlcnJpbmcNCj4+Pj4gdGhhdCBvdmVyIE1GRU5DRSBzaW5jZSBpdCBp
cyBsaWdodGVyIHdlaWdodC4NCj4+Pj4NCj4+Pj4gSW4gbGlnaHQgb2YgaG93IHRoZXkncmUgYmVp
bmcgdXNlZCBub3csIHRoZXkgY291bGQgcHJvYmFibHkgc3RhbmQgdG8gYmUNCj4+Pj4gcmVuYW1l
ZCBpbiBzb21lIHdheS4NCj4+Pg0KPj4+IEFjdHVhbGx5LCBjb21lIHRvIHRoaW5rIG9mIGl0LCB3
aGF0IHJlYWxseSBtYXR0ZXJzIGhlcmUgaXMgd2hldGhlcg0KPj4+IExGRU5DRSBpcyBzZXJpYWxp
emluZyBvciBub3QuIEJlY2F1c2UgaWYgc28sIHlvdSB3YW5uYSByZXBsYWNlIHdpdGggTEZFTkNF
DQo+Pj4gYXMgaXQgaXMgbGlnaHRlci4gQW5kIGluIHRoYXQgY2FzZSBhIHNpbmdsZSBhbHRlcm5h
dGl2ZSgpIC0gbm90IF8yKCkgLQ0KPj4+IHNob3VsZCBzdWZmaWNlLg0KPj4+DQo+Pj4gQlVUKCEp
LCB0aGF0IHN0aWxsIGlzIG5vdCBnb29kIGVub3VnaCBpZiB5b3UgZG8gc29tZSBxZW11IENQVSBt
b2RlbHMNCj4+PiBsaWtlIHBlbnRpdW0gb3Igc28gd2hpY2ggZG9uJ3QgZXZlbiBoYXZlIE1GRU5D
RSBhbmQgY2F1c2Ugc3R1ZmYgbGlrZQ0KPj4+IHRoaXM6DQo+Pj4NCj4+PiBodHRwczovL2xrbWwu
a2VybmVsLm9yZy9yLzIwMTgxMTIzMjAwMzA3LkdBNjIyM0Byb2Vjay11cy5uZXQNCj4+Pg0KPj4+
IFdoaWNoIG1lYW5zLCB0aGF0IHlvdSAqZG8qIGhhdmUgdG8gYWx0ZXJuYXRlIGJldHdlZW4NCj4+
Pg0KPj4+ICogbm8gaW5zbiBhdCBhbGwNCj4+PiAqIE1GRU5DRQ0KPj4+ICogTEZFTkNFLCBpZiBp
dCBpcyBzZXJpYWxpemluZw0KPj4+DQo+Pj4gc28gYmFycmllcl9ub3NwZWMoKSBkb2VzIHRoZSBy
aWdodCB0aGluZywgQUZBSUNTLiBBbmQgdGhpcyBpcyB3aHkgd2UNCj4+PiBuZWVkIGFuIEFMVEVS
TkFUSVZFXzMoKSB0byBhZGQgUkRUU0NQIGludG8gdGhlIG1peCB0b28uDQo+Pj4NCj4+PiBXUlQg
cmVuYW1pbmcsIEkgZ3Vlc3Mgd2UgY2FuIGRvIHNvbWV0aGluZyBsaWtlOg0KPj4+DQo+Pj4gKiBY
ODZfRkVBVFVSRV9NRkVOQ0VfUkRUU0MgLT4gWDg2X0ZFQVRVUkVfTUZFTkNFIC0gdG8gbWVhbiB0
aGF0IENQVSBoYXMNCj4+PiBNRkVOQ0Ugc3VwcG9ydC4NCj4+Pg0KPj4+IGFuZA0KPj4+DQo+Pj4g
KiBYODZfRkVBVFVSRV9MRkVOQ0VfUkRUU0MgLT4gWDg2X0ZFQVRVUkVfTEZFTkNFX1NFUklBTEla
SU5HDQo+Pj4NCj4+PiBPciBzb21ldGhpbmcgdG8gdGhhdCBlZmZlY3QuDQo+Pg0KPj4gVGhpcyBt
YWtlcyBtZSBuZXJ2b3VzLCBzaW5jZSBubyBvbmUga25vd3Mgd2hhdCDigJxzZXJpYWxpemluZ+KA
nSBtZWFucy4NCj4+IElJUkMgQU1EIHNwZWNpZmljYWxseSBkb2N1bWVudHMgdGhhdCBNRkVOQ0Ug
aXMgcmVxdWlyZWQgYmVmb3JlIFJEVFNDDQo+PiB0byBnZXQgc2Vuc2libGUgb3JkZXJpbmcuICBT
byBpdOKAmXMgZW50aXJlbHkgcGxhdXNpYmxlIHRvIG1lIHRoYXQNCj4+IExGRU5DRSBpcyBva2F5
IGZvciBTcGVjdHJlIG1pdGlnYXRpb24gYnV0IE1GRU5DRSBpcyBuZWVkZWQgZm9yIFJEVFNDDQo+
PiBvbiBzb21lIENQVS4NCj4gDQo+IEFzIGxvbmcgYXMgTVNSIDB4YzAwMTEwMjlbMV0gaXMgc2V0
IChNU1JfRjEwSF9ERUNGR19MRkVOQ0VfU0VSSUFMSVpFX0JJVCksDQo+IHRoZW4gTEZFTkNFIGlz
IGEgcHJvcGVyLCBsaWdodGVyIHdlaWdodCBzb2x1dGlvbiBmb3Igb3JkZXJpbmcgUkRUU0MuIFNv
DQo+IHdlJ3JlIGdvb2QgdGhlcmUuDQoNCkkgc2hvdWxkIGFkZCB0aGF0IEknbGwgc2VlIGFib3V0
IGdldHRpbmcgZG9jdW1lbnRhdGlvbiB1cGRhdGVkIHdpdGggdGhpcw0KaW5mb3JtYXRpb24uDQoN
ClRoYW5rcywNClRvbQ0KDQo+IA0KPiBUaGFua3MsDQo+IFRvbQ0KPiANCj4+DQo=
