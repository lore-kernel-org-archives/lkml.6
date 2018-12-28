Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5DAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 14:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D3920869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 14:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GW+80/+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbeL1OpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 09:45:11 -0500
Received: from mail-eopbgr140093.outbound.protection.outlook.com ([40.107.14.93]:37833
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727328AbeL1OpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 09:45:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wolpsfW0y00w0on7proM1+H1VWy+fAyTUisJOqXJJvM=;
 b=GW+80/+P/TthGr0D6wNIMsNUp5cxlzLfx1u9R7NPGZlvh8UBhZ7kx0U1iAjD9dZ2lIUqNH24D/KyFaaUBRTK3GCvJfau3wDY4i57GiuY5r5E1ymO/y44GBJELXc+URNlVNx1WqH1UnY3JdMybcofF/2+3uwEMPun1nDpX7boOes=
Received: from VI1PR08MB3117.eurprd08.prod.outlook.com (52.133.15.22) by
 VI1PR08MB2861.eurprd08.prod.outlook.com (10.170.236.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Fri, 28 Dec 2018 14:45:04 +0000
Received: from VI1PR08MB3117.eurprd08.prod.outlook.com
 ([fe80::40c5:8008:1ab4:4067]) by VI1PR08MB3117.eurprd08.prod.outlook.com
 ([fe80::40c5:8008:1ab4:4067%4]) with mapi id 15.20.1446.027; Fri, 28 Dec 2018
 14:45:04 +0000
From:   Konstantin Khorenko <khorenko@virtuozzo.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/1] mm/page_alloc: add a warning about high order
 allocations
Thread-Topic: [PATCH 1/1] mm/page_alloc: add a warning about high order
 allocations
Thread-Index: AQHUnGgIyodB/Y8cUEqX+oBj8nW9U6WQtJmAgAIOgYCAAAzAgIABbyqA
Date:   Fri, 28 Dec 2018 14:45:04 +0000
Message-ID: <5de0f8bb-8c3c-88e6-5f3f-0c59ce9554ce@virtuozzo.com>
References: <20181225153927.2873-1-khorenko@virtuozzo.com>
 <20181225153927.2873-2-khorenko@virtuozzo.com>
 <20181226084051.GH16738@dhcp22.suse.cz>
 <12c71c7a-7896-df73-7ab4-eab5b6fc1fb0@virtuozzo.com>
 <20181227165055.GN16738@dhcp22.suse.cz>
In-Reply-To: <20181227165055.GN16738@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::33) To VI1PR08MB3117.eurprd08.prod.outlook.com
 (2603:10a6:803:46::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=khorenko@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB2861;20:sACW5M870G9YpChKPVblgYNLpf/eCuVaqUipObELSVevx/mNMIzt4Wr5yYGVJacFJqwBtcAm+tKt4JjDqV94xXm0vyLrtcRbVj2czFWGuvE7SUtx0KBC9cDtTsprwtTMpjWqCjZGin+QX9yp0zXi6A6UMLajv/57KpbRHTP2cdk=
x-ms-office365-filtering-correlation-id: 3d2ceada-29be-45d6-cd50-08d66cd30daf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB2861;
x-ms-traffictypediagnostic: VI1PR08MB2861:
x-microsoft-antispam-prvs: <VI1PR08MB28612622C26EC2106D337125C8B70@VI1PR08MB2861.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB2861;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB2861;
x-forefront-prvs: 09007040D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(39850400004)(136003)(376002)(199004)(189003)(54534003)(6436002)(71190400001)(6512007)(71200400001)(68736007)(386003)(97736004)(6116002)(6506007)(53546011)(52116002)(26005)(76176011)(3846002)(102836004)(186003)(31686004)(2906002)(229853002)(53936002)(6246003)(6486002)(106356001)(105586002)(14454004)(86362001)(5660300001)(36756003)(476003)(4326008)(478600001)(305945005)(31696002)(256004)(14444005)(7736002)(99286004)(81166006)(8936002)(81156014)(66066001)(8676002)(54906003)(316002)(6916009)(93886005)(11346002)(25786009)(2616005)(486006)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB2861;H:VI1PR08MB3117.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p01UxefmyKquMZ/coEaD4a+vcsu3l7KSzBVM2NjiVamu5CZ3Lf1t/K8cefAUhDiTZBTgJwh9hfmCnYXmw1hn4aYycUrIXgxT3hZg6g5Ro4wDAyIyOcJDx6taiyHAZ3lZ066O+V0J8DO1l0vkaPGKgzEm3Qs4/xhhJIG+MbTmYJ7J0TfCQC8O/dmo3B0F9MR2htYMOzZ1YYgg8IajVxPdDMrX0cKuz3lApzvkUKpArNyoRG0Fxl0eghZNDrRiPz+/h1LMfJhoB1j1eAZhmGbz+pIm7LHOqwrl0zWwsxEsiVNaKrZVkM4QJ7p+p/aQICvB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F25C7CEAC03CAE4FA3C9B4A6EFEB4E8C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2ceada-29be-45d6-cd50-08d66cd30daf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2018 14:45:04.7247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2861
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMjcvMjAxOCAwNzo1MCBQTSwgTWljaGFsIEhvY2tvIHdyb3RlOg0KPiBPbiBUaHUgMjct
MTItMTggMTY6MDU6MTgsIEtvbnN0YW50aW4gS2hvcmVua28gd3JvdGU6DQo+PiBPbiAxMi8yNi8y
MDE4IDExOjQwIEFNLCBNaWNoYWwgSG9ja28gd3JvdGU6DQo+Pj4gQXBwYXJ0IGZyb20gZ2VuZXJh
bCBjb21tZW50cyBhcyBhIHJlcGx5IHRvIHRoZSBjb3ZlciAoYnR3LiB0aGlzIGFsbA0KPj4+IHNo
b3VsZCBiZSBpbiB0aGUgY2hhbmdlbG9nIGJlY2F1c2UgdGhpcyBpcyB0aGUgX3doeV8gcGFydCBv
ZiB0aGUNCj4+PiBqdXN0aWZpY2F0aW9uIHdoaWNoIHNob3VsZCBiZSBfYWx3YXlzXyBwYXJ0IG9m
IHRoZSBjaGFuZ2Vsb2cpLg0KPj4NCj4+IFRoYW5rIHlvdSwgd2lsbCBhZGQgaW4gdGhlIG5leHQg
dmVyc2lvbiBvZiB0aGUgcGF0Y2ggYWxsdG9nZXRoZXINCj4+IHdpdGggb3RoZXIgY2hhbmdlcyBp
ZiBhbnkuDQo+Pg0KPj4+IE9uIFR1ZSAyNS0xMi0xOCAxODozOToyNywgS29uc3RhbnRpbiBLaG9y
ZW5rbyB3cm90ZToNCj4+PiBbLi4uXQ0KPj4+PiArY29uZmlnIFdBUk5fSElHSF9PUkRFUg0KPj4+
PiArCWJvb2wgIkVuYWJsZSBjb21wbGFpbnMgYWJvdXQgaGlnaCBvcmRlciBtZW1vcnkgYWxsb2Nh
dGlvbnMiDQo+Pj4+ICsJZGVwZW5kcyBvbiAhTE9DS0RFUA0KPj4+DQo+Pj4gV2h5Pw0KPj4NCj4+
IExPQ0tERVAgbWFrZXMgc3RydWN0dXJlcyBiaWcsIHNvIGlmIHdlIHNlZSBhIGhpZ2ggb3JkZXIg
YWxsb2NhdGlvbiB3YXJuaW5nDQo+PiBvbiBhIGRlYnVnIGtlcm5lbCB3aXRoIGxvY2tkZXAsIGl0
IGRvZXMgbm90IGdpdmUgdXMgYSBsb3QgLSBsb2NrZGVwIGVuYWJsZWQNCj4+IGtlcm5lbCBwZXJm
b3JtYW5jZSBpcyBub3Qgb3VyIHRhcmdldC4NCj4+IGkgY2FuIHJlbW92ZSAhTE9DS0RFUCBkZXBl
bmRlbmNlIGhlcmUsIGJ1dCB0aGVuIG5lZWQgdG8gYWRqdXN0IGRlZmF1bHQNCj4+IHdhcm5pbmcg
bGV2ZWwgaSB0aGluaywgb3IgbG9ncyB3aWxsIGJlIHNwYW1tZWQuDQo+DQo+IE9LLCBJIHNlZSBi
dXQgdGhpcyBqdXN0IHBvaW50cyB0byBob3cgdGhpcyBpcyBub3QgcmVhbGx5IGEgc3VpdGFibGUN
Cj4gc29sdXRpb24gZm9yIHRoZSBwcm9ibGVtIHlvdSBhcmUgbG9va2luZyBmb3IuDQoNCmkgaGF2
ZSB0byBhZG1pdCwgeWVzLCBpdCBpcyBpbmNvbnZlbmllbnQgdG8gaGF2ZSBzdWNoIGEgZGVwZW5k
ZW5jeS4NCmkgd291bGQgYmUgcmVhbGx5IGdsYWQgdG8gaGVhciBhbHRlcm5hdGl2ZXMuLi4NCg0K
SnVzdCB0byBtZW50aW9uOiB0cmFjZXBvaW50cyBhcmUgZm9yIGlzc3VlcyBpbnZlc3RpZ2F0aW9u
ICh3aGVuIHdlIGFscmVhZHkgaGF2ZSBhbnkpLA0KYW5kIGknbSB0aGlua2luZyBhYm91dCBpc3N1
ZXMgcHJldmVudGlvbi4gR2F0aGVyaW5nIHBsYWNlcyB3aGljaCBtaWdodA0KbGVhZCB0byBwcm9i
bGVtIGFuZCByZXdvcmsgdG8gcHJldmVudCBwb3NzaWJsZSBpc3N1ZXMuDQoNCj4+Pj4gK3N0YXRp
YyBfX2Fsd2F5c19pbmxpbmUgdm9pZCB3YXJuX2hpZ2hfb3JkZXIoaW50IG9yZGVyLCBnZnBfdCBn
ZnBfbWFzaykNCj4+Pj4gK3sNCj4+Pj4gKwlzdGF0aWMgYXRvbWljX3Qgd2Fybl9jb3VudCA9IEFU
T01JQ19JTklUKDMyKTsNCj4+Pj4gKw0KPj4+PiArCWlmIChvcmRlciA+PSB3YXJuX29yZGVyICYm
ICEoZ2ZwX21hc2sgJiBfX0dGUF9OT1dBUk4pKQ0KPj4+PiArCQlXQVJOKGF0b21pY19kZWNfaWZf
cG9zaXRpdmUoJndhcm5fY291bnQpID49IDAsDQo+Pj4+ICsJCSAgICAgIm9yZGVyICVkID49ICVk
LCBnZnAgMHgleFxuIiwNCj4+Pj4gKwkJICAgICBvcmRlciwgd2Fybl9vcmRlciwgZ2ZwX21hc2sp
Ow0KPj4+PiArfQ0KPj4+DQo+Pj4gV2UgZG8gaGF2ZSByYXRlbGltaXQgZnVuY3Rpb25hbGl0eSwg
c28gd2h5IGNhbm5vdCB5b3UgdXNlIGl0Pw0KPj4NCj4+IFdlbGwsIG15IGlkZWEgd2FzIHRvIHJl
YWxseSBzaHV0IHVwIHRoZSB3YXJuaW5nIGFmdGVyIHNvbWUgbnVtYmVyIG9mIG1lc3NhZ2VzDQo+
PiAoaWYgYSBub2RlIGlzIGluIHByb2R1Y3Rpb24gYW5kIGl0cyB1cHRpbWUsIHNheSwgYSB5ZWFy
LCBpIGRvbid0IHdhbnQgdG8gc2VlDQo+PiBtYW55IHdhcm5pbmdzIGluIGxvZ3MsIGZpcnN0IHNl
dmVyYWwgaXMgZW5vdWdoIC0gbGV0J3MgZml4IHRoZW0gZmlyc3QpLg0KPg0KPiBPSywgYnV0IGl0
IGlzIHF1aXRlIGxpa2VseSB0aGF0IHRoZSBzeXN0ZW0gaXMgcGVyZmVjdGx5IGhlYWx0aHkgYW5k
DQo+IHVuZnJhZ21lbnRlZCBhZnRlciBmcmVzaCBib290IHdoZW4gZG9pbmcgYSBsYXJnZSBvcmRl
ciBhbGxvY2F0aW9ucyBpcw0KPiBwZXJmZWN0bHkgZmluZS4NCg0KWW91IGFyZSByaWdodCBhZ2Fp
biwgTWljaGFsLiBUaHVzIGp1c3Qgc3dpdGNoIHRob3NlIGVhcmx5IGFsbG9jYXRpb25zIHRvDQpr
dm1hbGxvYygpIGFuZCBvbiBib290IG9uIGFuIHVuZnJhZ21lbnRlZCBzeXN0ZW0gc2FtZSBrbWFs
bG9jKCkgd2lsbCBiZSB1c2VkLg0KQW5kIG5vIG5ldyB3YXJuaW5nIGZvciB0aGF0IHBsYWNlLiBB
bmQgbm8gYW55IGNoYW5jZSB0aGlzIHBsYWNlIGV2ZXIgdHJpZ2dlcg0KY29tcGFjdGlvbiAoaW4g
Y2FzZSB3ZSBkaWQgbm90IG5vdGljZSBzb21lIHdheSB0aGlzIGFsbG9jYXRpb24gbWlnaHQgYWxz
bw0KaGFwcGVuIGxhdGVyLCBub3Qgb24gYSBmcmVzaCBub2RlKS4NCg0KID4gTm90ZSB0aGF0IGl0
IGlzIHNtYWxsZXIgb3JkZXIgYWxsb2NhdGlvbnMgdGhhdCBnZW5lcmF0ZQ0KID4gZnJhZ21lbnRh
dGlvbiBpbiBnZW5lcmFsLg0KDQpBbmQgYWdhaW4gLSB5ZXMsIHRoYXQncyB0cnVlLiBTdGlsbCBp
IGRvbid0IGtub3cgaG93IHRvIGF2b2lkIG1lbW9yeSBmcmFnbWVudGF0aW9uLA0KYnV0IGNhbiBh
dm9pZCAob2ssIHNpZ25pZmljYW50bHkgZGVjcmVhc2UgdGhlIG51bWJlciBvZikgYmlnIGFsbG9j
YXRpb25zIHdoaWNoDQptaWdodCB0cmlnZ2VyIGNvbXBhY3Rpb24gYmVjYXVzZSBvZiB0aGF0IGZy
YWdtZW50YXRpb24uDQoNCg0KLS0NCkJlc3QgcmVnYXJkcywNCg0KS29uc3RhbnRpbiBLaG9yZW5r
bywNClZpcnR1b3p6byBMaW51eCBLZXJuZWwgVGVhbQ0K
