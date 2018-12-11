Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B46C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818502084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="A4Tntj+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818502084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbeLKXMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:12:45 -0500
Received: from mail-eopbgr810087.outbound.protection.outlook.com ([40.107.81.87]:2290
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726158AbeLKXMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 18:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0i1KbrZqiattuFQY4R+faW61pIwLO6O6eYsfQhyO0qg=;
 b=A4Tntj+8WCjK+PJAb6c9VWAzc/dwrhfGOvEgeOx14K5k8Y2AWKeRpq2ZqlQQUriw8FSa2ZWGgfJFn8dsRIAgVFUfylSK0lKbOTRoeEJPG41lSvyZDMrSle4X1CQNJTKSKfoOenc5Z3RNC2qzbQ7QrrKLlUpnPWYsXzmu72l308Q=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB2384.namprd12.prod.outlook.com (52.132.194.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Tue, 11 Dec 2018 23:12:41 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5%6]) with mapi id 15.20.1425.016; Tue, 11 Dec 2018
 23:12:41 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>
CC:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [RFC PATCH 4/4] x86/TSC: Use RDTSCP
Thread-Topic: [RFC PATCH 4/4] x86/TSC: Use RDTSCP
Thread-Index: AQHUkaAqfD7bV8pvnUyLofBVRH7Ye6V6JxMAgAADsYA=
Date:   Tue, 11 Dec 2018 23:12:41 +0000
Message-ID: <59aad362-4a5b-dd8b-642f-0dc3f83cf7ee@amd.com>
References: <20181211222326.14581-1-bp@alien8.de>
 <20181211222326.14581-5-bp@alien8.de>
 <CALCETrVArfAAbQKJ-g_5pOy6dMVgx-FC_mjdC9xzL1jU9T07jw@mail.gmail.com>
In-Reply-To: <CALCETrVArfAAbQKJ-g_5pOy6dMVgx-FC_mjdC9xzL1jU9T07jw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:805:3e::36) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB2384;20:K33qwu+sTLRrCjxxC1zDb9tku7Q49PSDGq4DKv6To4H+M+10bROfXiCDQ1PHpqMxfmJYfWQwMm307CwIH8g+smuXmvi+7AB0hFrfDNFYm6+WnbMVz3su76j8St5bLIArMwu4Yb3slNFgcbVlPiOkIjb7MF8wZB7x91tlNIkUNvXxdO3qFFOoVb1suXqvuGq8CTSW/glLSMJWOHlteQ6KoHIC8LvcvrNqAiwsn6AL9FLPFcsS8M7qB97bIf/PglhT
x-ms-office365-filtering-correlation-id: 2a90dcfc-92a3-452e-cd1c-08d65fbe2655
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2384;
x-ms-traffictypediagnostic: SN1PR12MB2384:
x-microsoft-antispam-prvs: <SN1PR12MB23846363A9DC6F8627CA8A20ECA60@SN1PR12MB2384.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231472)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB2384;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2384;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(366004)(396003)(136003)(199004)(189003)(8936002)(99286004)(7736002)(229853002)(81166006)(305945005)(86362001)(25786009)(31696002)(6512007)(81156014)(6306002)(316002)(53936002)(8676002)(54906003)(6486002)(6436002)(110136005)(6246003)(71190400001)(36756003)(4326008)(14454004)(31686004)(76176011)(52116002)(386003)(53546011)(6506007)(2906002)(68736007)(5660300001)(478600001)(476003)(11346002)(105586002)(486006)(2616005)(256004)(446003)(102836004)(71200400001)(14444005)(97736004)(26005)(966005)(66066001)(3846002)(6116002)(106356001)(186003)(72206003)(217873002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2384;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: y9M15Wbn3K1UDDz7iqFbjgigJA4AhOgOcBCRgplguWBVfYUzBoq0HMMUub8RX8mGt4FsWMv0G6AtZvzipZBhIDcd0PDP/qF8E6By2E5g4LAiq84SeWMgfDjSvOxOcJsPXIK7fDgREaIYt6X4ELfXJH/5VkpzaW8qW27O3+clOYpQmG4LsHJdbavvaldyX+Rpw0GCMy4QHg0v0+we13d6Zg/Eoj9nNIJ4VlgxqgRe+0sElUOMApBcNeONdv4K3tnUu+h80Qac5N5qImyq8MHEA0dOCIjprV/jwx3n6x1IV+tDQQno35CpMJsUELpRrigI
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E4085E9D0F76847B2B8109AB6F6DCC5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a90dcfc-92a3-452e-cd1c-08d65fbe2655
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 23:12:41.4648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2384
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMTEvMjAxOCAwNDo1OSBQTSwgQW5keSBMdXRvbWlyc2tpIHdyb3RlOg0KPiBPbiBUdWUs
IERlYyAxMSwgMjAxOCBhdCAyOjIzIFBNIEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPiB3
cm90ZToNCj4+DQo+PiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQHN1c2UuZGU+DQo+Pg0KPj4g
Q3VycmVudGx5LCB0aGUga2VybmVsIHVzZXMNCj4+DQo+PiAgIFtMTV1GRU5DRTsgUkRUU0MNCj4+
DQo+PiBpbiB0aGUgdGltZWtlZXBpbmcgY29kZSwgdG8gZ3VhcmFudGVlIG1vbm90b25pY2l0eSBv
ZiB0aW1lIHdoZXJlIHRoZQ0KPj4gKkZFTkNFIGlzIHNlbGVjdGVkIGJhc2VkIG9uIHZlbmRvci4N
Cj4+DQo+PiBSZXBsYWNlIHRoYXQgc2VxdWVuY2Ugd2l0aCBSRFRTQ1Agd2hpY2ggaXMgZmFzdGVy
IG9yIG9uLXBhciBhbmQgZ2l2ZXMNCj4+IHRoZSBzYW1lIGd1YXJhbnRlZXMuDQo+Pg0KPj4gQSBt
aWNyb2JlbmNobWFyayBvbiBJbnRlbCBzaG93cyB0aGF0IHRoZSBjaGFuZ2UgaXMgb24tcGFyLg0K
Pj4NCj4+IE9uIEFNRCwgdGhlIGNoYW5nZSBpcyBlaXRoZXIgb24tcGFyIHdpdGggdGhlIGN1cnJl
bnQgTEZFTkNFLXByZWZpeGVkDQo+PiBSRFRTQyBhbmQgc29tZSBhcmUgc2xpZ2h0bHkgYmV0dGVy
IHdpdGggUkRUU0NQLg0KPj4NCj4+IFRoZSBjb21wYXJpc29uIGlzIGRvbmUgd2l0aCB0aGUgTEZF
TkNFLXByZWZpeGVkIFJEVFNDIChhbmQgbm90IHdpdGggdGhlDQo+PiBNRkVOQ0UtcHJlZml4ZWQg
b25lLCBhcyBvbmUgd291bGQgbm9ybWFsbHkgZXhwZWN0KSBiZWNhdXNlIGFsbCBtb2Rlcm4NCj4+
IEFNRCBmYW1pbGllcyBtYWtlIExGRU5DRSBzZXJpYWxpemluZyBhbmQgdGh1cyBhdm9pZCB0aGUg
aGVhdnkgTUZFTkNFIGJ5DQo+PiBlZmZlY3RpdmVseSBlbmFibGluZyBYODZfRkVBVFVSRV9MRkVO
Q0VfUkRUU0MuDQo+Pg0KPj4gQ28tZGV2ZWxvcGVkLWJ5OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhA
bGludXRyb25peC5kZT4NCj4+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBHbGVpeG5lciA8dGdseEBs
aW51dHJvbml4LmRlPg0KPj4gU2lnbmVkLW9mZi1ieTogQm9yaXNsYXYgUGV0a292IDxicEBzdXNl
LmRlPg0KPj4gQ2M6IFRvbSBMZW5kYWNreSA8dGhvbWFzLmxlbmRhY2t5QGFtZC5jb20+DQo+PiBD
YzogQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtlcm5lbC5vcmc+DQo+PiBDYzogIkguIFBldGVyIEFu
dmluIiA8aHBhQHp5dG9yLmNvbT4NCj4+IENjOiBKb2huIFN0dWx0eiA8am9obi5zdHVsdHpAbGlu
YXJvLm9yZz4NCj4+IENjOiB4ODZAa2VybmVsLm9yZw0KPj4gTGluazogaHR0cHM6Ly9sa21sLmtl
cm5lbC5vcmcvci8yMDE4MTExOTE4NDU1Ni4xMTQ3OS0xLWJwQGFsaWVuOC5kZQ0KPj4gLS0tDQo+
PiAgYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLmggfCAxNiArKysrKysrKysrKysrKy0tDQo+PiAg
MSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL21zci5oIGIvYXJjaC94ODYvaW5jbHVk
ZS9hc20vbXNyLmgNCj4+IGluZGV4IDkxZTRjZjE4OTkxNC4uNWNjMzkzMGNiNDY1IDEwMDY0NA0K
Pj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLmgNCj4+ICsrKyBiL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL21zci5oDQo+PiBAQCAtMjE3LDYgKzIxNyw4IEBAIHN0YXRpYyBfX2Fsd2F5c19p
bmxpbmUgdW5zaWduZWQgbG9uZyBsb25nIHJkdHNjKHZvaWQpDQo+PiAgICovDQo+PiAgc3RhdGlj
IF9fYWx3YXlzX2lubGluZSB1bnNpZ25lZCBsb25nIGxvbmcgcmR0c2Nfb3JkZXJlZCh2b2lkKQ0K
Pj4gIHsNCj4+ICsgICAgICAgREVDTEFSRV9BUkdTKHZhbCwgbG93LCBoaWdoKTsNCj4+ICsNCj4+
ICAgICAgICAgLyoNCj4+ICAgICAgICAgICogVGhlIFJEVFNDIGluc3RydWN0aW9uIGlzIG5vdCBv
cmRlcmVkIHJlbGF0aXZlIHRvIG1lbW9yeQ0KPj4gICAgICAgICAgKiBhY2Nlc3MuICBUaGUgSW50
ZWwgU0RNIGFuZCB0aGUgQU1EIEFQTSBhcmUgYm90aCB2YWd1ZSBvbiB0aGlzDQo+PiBAQCAtMjI3
LDkgKzIyOSwxOSBAQCBzdGF0aWMgX19hbHdheXNfaW5saW5lIHVuc2lnbmVkIGxvbmcgbG9uZyBy
ZHRzY19vcmRlcmVkKHZvaWQpDQo+PiAgICAgICAgICAqIG9yZGVyaW5nIGd1YXJhbnRlZXMgYXMg
cmVhZGluZyBmcm9tIGEgZ2xvYmFsIG1lbW9yeSBsb2NhdGlvbg0KPj4gICAgICAgICAgKiB0aGF0
IHNvbWUgb3RoZXIgaW1hZ2luYXJ5IENQVSBpcyB1cGRhdGluZyBjb250aW51b3VzbHkgd2l0aCBh
DQo+PiAgICAgICAgICAqIHRpbWUgc3RhbXAuDQo+PiArICAgICAgICAqDQo+PiArICAgICAgICAq
IFRodXMsIHVzZSB0aGUgcHJlZmVycmVkIGJhcnJpZXIgb24gdGhlIHJlc3BlY3RpdmUgQ1BVLCBh
aW1pbmcgZm9yDQo+PiArICAgICAgICAqIFJEVFNDUCBhcyB0aGUgZGVmYXVsdC4NCj4+ICAgICAg
ICAgICovDQo+PiAtICAgICAgIGJhcnJpZXJfbm9zcGVjKCk7DQo+PiAtICAgICAgIHJldHVybiBy
ZHRzYygpOw0KPj4gKyAgICAgICBhc20gdm9sYXRpbGUoQUxURVJOQVRJVkVfMygicmR0c2MiLA0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAibWZlbmNlOyByZHRzYyIsIFg4
Nl9GRUFUVVJFX01GRU5DRV9SRFRTQywNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgImxmZW5jZTsgcmR0c2MiLCBYODZfRkVBVFVSRV9MRkVOQ0VfUkRUU0MsDQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJyZHRzY3AiLCBYODZfRkVBVFVSRV9SRFRT
Q1ApDQo+PiArICAgICAgICAgICAgICAgICAgICAgICA6IEVBWF9FRFhfUkVUKHZhbCwgbG93LCBo
aWdoKQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgLyogUkRUU0NQIGNsb2JiZXJzIEVDWCB3
aXRoIE1TUl9UU0NfQVVYLiAqLw0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgOjogImVjeCIp
Ow0KPj4gKw0KPj4gKyAgICAgICByZXR1cm4gRUFYX0VEWF9WQUwodmFsLCBsb3csIGhpZ2gpOw0K
Pj4gIH0NCj4gDQo+IFRoaXMgd2hvbGUgc2VyaWVzIHNlZW1zIHJlYXNvbmFibGUsIGV4Y2VwdCB0
aGF0IGl0IGNhdXNlZCBtZSB0byBsb29rDQo+IGF0IGJhcnJpZXJfbm9zcGVjKCkuICBBbmQgSSBo
YWQgYSBiaXQgb2YgYSBXVEYgbW9tZW50LCBhcyBpbiAiV1RGIGRvZXMNCj4gUkRUU0MgaGF2ZSB0
byBkbyB3aXRoIGEgc3BlY3VsYXRpb24gcHJvdGVjdGlvbiBiYXJyaWVyIi4gIERvZXMgaXQNCj4g
YWN0dWFsbHkgbWFrZSBzZW5zZT8NCg0KSXQgZG9lcyBzZWVtIG92ZXJsb2FkZWQgaW4gdGhhdCBz
ZW5zZSwgYnV0IHRoZSBmZWF0dXJlIG1lYW5zIHRoYXQgTEZFTkNFDQppcyBzZXJpYWxpemluZyBh
bmQgc28gY2FuIGJlIHVzZWQgaW4gcmR0c2Nfb3JkZXJlZC4gSW4gdGhlIHNhbWUgc2Vuc2UsDQpi
YXJyaWVyX25vc3BlYyBpcyBsb29raW5nIGZvciB3aGV0aGVyIExGRU5DRSBpcyBzZXJpYWxpemlu
ZyBhbmQgcHJlZmVycmluZw0KdGhhdCBvdmVyIE1GRU5DRSBzaW5jZSBpdCBpcyBsaWdodGVyIHdl
aWdodC4NCg0KSW4gbGlnaHQgb2YgaG93IHRoZXkncmUgYmVpbmcgdXNlZCBub3csIHRoZXkgY291
bGQgcHJvYmFibHkgc3RhbmQgdG8gYmUNCnJlbmFtZWQgaW4gc29tZSB3YXkuDQoNClRoYW5rcywN
ClRvbQ0KDQo+IA0K
