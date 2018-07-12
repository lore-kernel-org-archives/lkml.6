Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA298C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7886120BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="h0zpuVmN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7886120BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbeGLJ5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 05:57:43 -0400
Received: from mail-co1nam03on0047.outbound.protection.outlook.com ([104.47.40.47]:38805
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725833AbeGLJ5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 05:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a39/xQFjWV8FfcLbsAxtgGFyLhn8SLIQ8cDjGqSIjhU=;
 b=h0zpuVmNIAfVz04y1YI7fYsuos6c6b9E9X6LY2qd2gTgmNfL4XutxOebk4s1KjN7pg0IOGoSUEAY13dE9M8ZPwUfcJ+8rVTzuzEI7PJApXJw7VzQU4oLcrjL2vCu1+iR4fD0y8NjcElWOQdVwh/mSR+hoYdrnfB9hKoAwnTBdJs=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5157.namprd07.prod.outlook.com (20.176.254.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Thu, 12 Jul 2018 09:47:13 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::39ca:4bef:3be8:fdf5]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::39ca:4bef:3be8:fdf5%3]) with mapi id 15.20.0952.017; Thu, 12 Jul 2018
 09:47:12 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Tyrala <ltyrala@cadence.com>,
        Alan Douglas <adouglas@cadence.com>
Subject: RE: [PATCH 05/31] usb: usbssp: Added first part of initialization
 sequence.
Thread-Topic: [PATCH 05/31] usb: usbssp: Added first part of initialization
 sequence.
Thread-Index: AQHUGaPrXhW1ftKvwUmD/Pn5NzNpOqSLH3YAgAAiAfCAAAtOAIAAB4vA
Date:   Thu, 12 Jul 2018 09:47:12 +0000
Message-ID: <BYAPR07MB470961051F180E3AC05A6A8DDD590@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
 <1531374448-26532-6-git-send-email-pawell@cadence.com>
 <20180712062714.GI20905@kroah.com>
 <BYAPR07MB47096E3B832D07F8F3017974DD590@BYAPR07MB4709.namprd07.prod.outlook.com>
 <20180712090924.GA8255@kroah.com>
In-Reply-To: <20180712090924.GA8255@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctOTRjYmQ3MjQtODViOC0xMWU4LTg3MTAtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDk0Y2JkNzI1LTg1YjgtMTFlOC04NzEwLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjU0MSIgdD0iMTMxNzU4NjI0NDYxODk1NDMwIiBoPSJObEF3M3RPQjQwWDR3b25saGlVdXYyZnZTdnM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pawell@cadence.com; 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5157;7:cpr43pfU5+yU/ZyIQLERzSH5b/ZJ1kQdHX4bpXRjZgDHW4C/ZTigWVguOFSeDWVG0WtbVgMu2YOHSEnNrt6496yBEhEAv8gV5hGhMB05G06Ea8OFJNOavZNm9VSBvPysXdp76mjVklCwOUtbU9a0dmejykF3HW4b9BOFWnLJDIpEgdTw6BPfV9NhP+r9mPLKpx+IOBusOwmLijgy74Svk1Ml02Hx4rciCy5CZ6LGemj98MAlh+f6/6T8EOpujPEg;20:UT7mIne6ayj6asKzD9Op53Qf7pxUhegmBxDccVQzA/x+SYsJ9hFq8jrgUeN9FMiKyN7LtnO3qLkl0KVY8Bhc6R/i2EcfTNOzZP25kFs6Rl/xBFNSNjZOd7ca61gfZGauuD7gYjN2WMpf61BU1bgMcC6IDZ8BsqWLHAsdtIhuyd/qyNXDrs+gnBQKRoxFCowzyhfJ1uqHm0rKscQ5gyEmIlIHeOYs+Jv9ivl70u5jOuYZrQeTE7wDGHyebQ97S30a
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(396003)(136003)(39860400002)(36092001)(199004)(189003)(6246003)(66066001)(81166006)(81156014)(86362001)(478600001)(2900100001)(14454004)(8676002)(74316002)(4326008)(3846002)(305945005)(6116002)(2906002)(25786009)(7736002)(107886003)(106356001)(6916009)(316002)(229853002)(55016002)(6436002)(33656002)(68736007)(105586002)(486006)(9686003)(93886005)(5660300001)(476003)(7696005)(102836004)(8936002)(186003)(53936002)(26005)(256004)(14444005)(99286004)(5250100002)(54906003)(11346002)(97736004)(76176011)(6506007)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5157;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: f6229b3f-225a-4b19-2452-08d5e7dc7185
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5157;
x-ms-traffictypediagnostic: BYAPR07MB5157:
x-microsoft-antispam-prvs: <BYAPR07MB5157B090CCD977698F61E7AADD590@BYAPR07MB5157.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB5157;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5157;
x-forefront-prvs: 0731AA2DE6
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: E41E3+73fuL2/092HenGtOSEqjrNyebwCz6ZXtwQ1Wtr7fm69aJvAionVwgNF/diEfYq23XQqni6HN9BU22egJ40UL6BShhgPlpZ+BL7STBtzo1tG9321Et2w9D566gN9Ea9kEFkeB2R3QDSt7+ZDbxs3ZRMxgn6Uu5wro2irBM/CoclUIbzTHdpgwxZO1DFUN5FYM/mZ7NEg/+nQjQ2iKLJQeoUC5nzZpJgmk/FDMce0PKGmzY0RJlGnrN4qc+D7lwz5UIGg5V809jpnuFUYYfZ4Gk0+XQek2rZw1EXXf++N47xzRuGi61lbpC5JGMgNxbC/J4sWudTjqz4xmkvRB8Al/d2MDc0+BGbXCjok08=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6229b3f-225a-4b19-2452-08d5e7dc7185
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2018 09:47:12.4784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gPiArLyogVVNCIDIuMCBoYXJkd2FyZSBMTVAgY2FwYWJpbGl0eSovDQo+ID4gPiA+ICsj
ZGVmaW5lIFVTQlNTUF9ITEMJCQkoMSA8PCAxOSkNCj4gPiA+ID4gKyNkZWZpbmUgVVNCU1NQX0JM
QwkJCSgxIDw8IDIwKQ0KPiA+ID4NCj4gPiA+IEFnYWluLCBCSVQoKSBwbGVhc2UuDQo+ID4gPg0K
PiA+ID4gPiAraW50IHVzYnNzcF9oYW5kc2hha2Uodm9pZCBfX2lvbWVtICpwdHIsIHUzMiBtYXNr
LCB1MzIgZG9uZSwgaW50DQo+ID4gPiA+ICt1c2VjKSB7DQo+ID4gPiA+ICsJdTMyCXJlc3VsdDsN
Cj4gPiA+DQo+ID4gPiBTb21lIHBsYWNlcyB5b3UgdXNlIHRhYnMgZm9yIHRoZSB2YXJpYWJsZSBk
ZWNsYXJhdGlvbnMsIGFuZCBzb21lIHlvdQ0KPiA+ID4gZG8gbm90LiAgUGljayBhIHNpbmdsZSBz
dHlsZSBhbmQgc3RpY2sgdG8gaXQgcGxlYXNlLg0KPiA+ID4NCj4gPiA+ID4gKw0KPiA+ID4gPiAr
CWRvIHsNCj4gPiA+ID4gKwkJcmVzdWx0ID0gcmVhZGwocHRyKTsNCj4gPiA+ID4gKwkJaWYgKHJl
c3VsdCA9PSB+KHUzMikwKQkvKiBjYXJkIHJlbW92ZWQgKi8NCj4gPiA+ID4gKwkJCXJldHVybiAt
RU5PREVWOw0KPiA+ID4gPiArCQlyZXN1bHQgJj0gbWFzazsNCj4gPiA+ID4gKwkJaWYgKHJlc3Vs
dCA9PSBkb25lKQ0KPiA+ID4gPiArCQkJcmV0dXJuIDA7DQo+ID4gPiA+ICsJCXVkZWxheSgxKTsN
Cj4gPiA+ID4gKwkJdXNlYy0tOw0KPiA+ID4gPiArCX0gd2hpbGUgKHVzZWMgPiAwKTsNCj4gPiA+
ID4gKwlyZXR1cm4gLUVUSU1FRE9VVDsNCj4gPiA+DQo+ID4gPiBXZSBkb24ndCBoYXZlIGEgYnVp
bHQtaW4ga2VybmVsIGZ1bmN0aW9uIHRvIGRvIHRoaXMgdHlwZSBvZiB0aGluZyBhbHJlYWR5Pw0K
PiA+ID4gVGhhdCdzIHNhZC4gIE9oIHdlbGwuLi4NCj4gPiA+DQo+ID4gPiA+ICtpbnQgdXNic3Nw
X2luaXQoc3RydWN0IHVzYnNzcF91ZGMgKnVzYnNzcF9kYXRhKSB7DQo+ID4gPiA+ICsJaW50IHJl
dHZhbCA9IDA7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwl1c2Jzc3BfZGJnX3RyYWNlKHVzYnNzcF9k
YXRhLCB0cmFjZV91c2Jzc3BfZGJnX2luaXQsDQo+ID4gPiAidXNic3NwX2luaXQiKTsNCj4gPiA+
ID4gKw0KPiA+ID4gPiArCXNwaW5fbG9ja19pbml0KCZ1c2Jzc3BfZGF0YS0+bG9jayk7DQo+ID4g
PiA+ICsJc3Bpbl9sb2NrX2luaXQoJnVzYnNzcF9kYXRhLT5pcnFfdGhyZWFkX2xvY2spOw0KPiA+
ID4gPiArDQo+ID4gPiA+ICsJLy9UT0RPOiBtZW1vcnkgaW5pdGlhbGl6YXRpb24NCj4gPiA+ID4g
KwkvL3JldHZhbCA9IHVzYnNzcF9tZW1faW5pdCh1c2Jzc3BfZGF0YSwgR0ZQX0tFUk5FTCk7DQo+
ID4gPiA+ICsNCj4gPiA+ID4gKwl1c2Jzc3BfZGJnX3RyYWNlKHVzYnNzcF9kYXRhLCB0cmFjZV91
c2Jzc3BfZGJnX2luaXQsDQo+ID4gPiA+ICsJCQkiRmluaXNoZWQgdXNic3NwX2luaXQiKTsNCj4g
PiA+DQo+ID4gPiBXaGVuIHlvdXIgdHJhY2UgZnVuY3Rpb25zIGRvIG5vdGhpbmcgYnV0IHNheSAi
ZW50ZXJlZCBhIGZ1bmN0aW9uIiwNCj4gPiA+IGFuZCAiZXhpdGVkIGEgZnVuY3Rpb24iLCB3aHkg
ZXZlbiBoYXZlIHRoZW0/ICBmdHJhY2UgY2FuIHByb3ZpZGUNCj4gPiA+IHRoYXQgZm9yIHlvdSBh
bHJlYWR5LCBubyBuZWVkIHRvIG92ZXJsb2FkIHRoYXQgb24gdGhlIHRyYWNpbmcgZnJhbWV3b3Jr
LA0KPiByaWdodD8NCj4gPg0KPiA+IERvIHlvdSBzdWdnZXN0IHRvIHVzZSBvbmx5Og0KPiA+IAl0
cmFjZV91c2Jzc3BfZGJnX2luaXQoIkZpbmlzaGVkIHVzYnNzcF9pbml0Iik7DQo+ID4gaW5zdGVh
ZDoNCj4gPiAJdXNic3NwX2RiZyh1c2Jzc3BfZGF0YSwgIiVwVlxuIiwgIkZpbmlzaGVkIHVzYnNz
cF9pbml0Iik7DQo+ID4gCXRyYWNlX3VzYnNzcF9kYmdfaW5pdCgiRmluaXNoZWQgdXNic3NwX2lu
aXQiKTsgPw0KPiA+DQo+ID4gSSdtIHNpbXBsZSByZS11c2VkIHRoZSBjb2RlIGZyb20gWEhDSSBk
cml2ZXIuIEl0J3MgcmVhbGx5IHJlZHVuZGFudCwNCj4gPiBidXQgSSBkb24ndCBrbm93IHRoZSBp
bnRlbnRpb24gb2YgYXV0aG9yIPCfmIouDQo+IA0KPiBXaHkgYXJlIGFueSBvZiB0aG9zZSBsaW5l
cyBuZWVkZWQ/ICBEb2Vzbid0IGZ0cmFjZSB3b3JrIHByb3Blcmx5IGZvciB5b3U/DQo+IA0KPiBB
bmQgeWVhaCwgaWYgeGhjaSBoYXMgdGhpcyBpdCBzaG91bGQgYmUgcmVtb3ZlZCBmcm9tIHRoZXJl
IGFzIHdlbGwuDQoNCk9rLCBJIGFscmVhZHkgdW5kZXJzdGFuZCB3aGF0J3MgZ29pbmcgb24uIA0K
DQpJIGRpZG4ndCB1c2UgZnRyYWNlLiBEdXJpbmcgZGV2ZWxvcGluZyBkcml2ZXIgaXQgaXMgZmFz
dGVyIGFuZCBzaW1wbGVyIGZvciBtZSB0byBhZGQgc2ltcGxlIGRlYnVnIG1lc3NhZ2UgDQp0aGVu
IHVzZSBmdHJhY2UuDQoNCkkgYWdyZWUgdGhhdCBpdCBpcyBub3QgbmVlZGVkIGhlcmUuICBJdCB3
aWxsIGJlIHJlbW92ZWQuDQoNCnRoYW5rcywNClBhd2VsIExhc3pjemFrDQo=
