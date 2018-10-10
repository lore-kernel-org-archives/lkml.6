Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A4AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AF721479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62AF721479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbeJJOGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:06:11 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:47402 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726562AbeJJOGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:06:11 -0400
X-UUID: 49f09ff746db4fd0acd07144aa17668f-20181010
X-UUID: 49f09ff746db4fd0acd07144aa17668f-20181010
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <chunhui.li@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 882748398; Wed, 10 Oct 2018 14:45:19 +0800
Received: from MTKMBS32N1.mediatek.inc (172.27.4.71) by
 MTKMBS32N1.mediatek.inc (172.27.4.71) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 10 Oct 2018 14:45:17 +0800
Received: from MTKMBS32N1.mediatek.inc ([fe80::693d:d64d:d0b8:6f3e]) by
 MTKMBS32N1.mediatek.inc ([fe80::693d:d64d:d0b8:6f3e%23]) with mapi id
 15.00.1395.000; Wed, 10 Oct 2018 14:45:17 +0800
From:   =?gb2312?B?Q2h1bmh1aSBMaSAowO60urvUKQ==?= <chunhui.li@mediatek.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Marc Zyngier" <marc.zyngier@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        =?gb2312?B?TWlsZXMgQ2hlbiAo6pDD8ZjlKQ==?= <Miles.Chen@mediatek.com>,
        =?gb2312?B?V2FsdGVyLVpIIFd1ICiFx9fm5b4p?= 
        <Walter-ZH.Wu@mediatek.com>,
        =?gb2312?B?WXUgTGlhbmcgKMG60+4p?= <Yu.Liang@mediatek.com>,
        =?gb2312?B?TmljaG9sYXMgVGFuZyAo4I3H2N14KQ==?= 
        <nicholas.tang@mediatek.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBrYXNhbjogYXZvaWQgb3V0LW9mLWJvdW5kcyBpbiB1?=
 =?gb2312?Q?nwind=5Fframe?=
Thread-Topic: [PATCH] kasan: avoid out-of-bounds in unwind_frame
Thread-Index: AQHUX7hlcl/5Uvjz3E+Pcy5y9duGWqUWMuaAgAHVINA=
Date:   Wed, 10 Oct 2018 06:45:17 +0000
Message-ID: <193a2b2efdaf41f39cb35a72feb3b39e@MTKMBS32N1.mediatek.inc>
References: <1539079863-19645-1-git-send-email-chunhui.li@mediatek.com>
 <20181009103833.sk2jyhl77f5fb64r@lakrids.cambridge.arm.com>
In-Reply-To: <20181009103833.sk2jyhl77f5fb64r@lakrids.cambridge.arm.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.27.4.250]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyaywNCg0Ka2FzYW4gZGV0ZWN0IG91dC1vZi1ib3VuZHMgaW4gc3RhY2t0cmFjZS5jIGxp
bmUgNzAsIGl0J3MgYWxyZWFkeSBvdmVyIFJFQURfT05DRV9OT0NIRUNLLCBidXQgc3RpbGwgY3Jh
c2gNCmtlcm5lbC00LjkvYXJjaC9hcm02NC9rZXJuZWwvc3RhY2t0cmFjZS5jDQo2OQlmcmFtZS0+
c3AgPSBmcCArIDB4MTA7DQo3MAlmcmFtZS0+ZnAgPSBSRUFEX09OQ0VfTk9DSEVDSygqKHVuc2ln
bmVkIGxvbmcgKikoZnApKTsNCg0Kd2UgdGVzdCBvbiBBbmRyb2lkIHBsYXRmb3JtLCBrZXJuZWwt
NC45IGJ1aWxkIHdpdGggY2xhbmcgNi4wLjIsIHdlIHdpbGwgZG8gZXhwZXJpbWVudCB0byBjbGFy
aWZ5IHdoZXRoZXIgY29tcGlsZXIgcmVsYXRlZCBpc3N1ZS4NCg0KUkVBRF9PTkNFX05PQ0hFQ0st
Pl9fcmVhZF9vbmNlX3NpemVfbm9jaGVjayB3aXRoIF9fbm9fc2FuaXRpemVfYWRkcmVzcyBpZiBl
bmFibGUgQ09ORklHX0tBU0FODQoNCmtlcm5lbC00LjkvaW5jbHVkZS9saW51eC9jb21waWxlci1n
Y2MuaA0KI2RlZmluZSBfX25vX3Nhbml0aXplX2FkZHJlc3MgX19hdHRyaWJ1dGVfXygobm9fc2Fu
aXRpemVfYWRkcmVzcykpDQoNCmtlcm5lbC00LjkvaW5jbHVkZS9saW51eC9jb21waWxlci1jbGFu
Zy5oDQojZGVmaW5lIF9fbm9fc2FuaXRpemVfYWRkcmVzcyBfX2F0dHJpYnV0ZV9fKChub19zYW5p
dGl6ZSgiYWRkcmVzcyIpKSkNCg0KdGhlcmUgaXMgcGF0Y2ggZnJvbSBpbnRlcm5ldCwgYXZvaWQg
a2FzYW4gYnkgd3JhcHBpbmcgd2l0aCBrYXNhbl9kaXNhYmxlX2N1cnJlbnQsIGl0IHNlZW1zIGJl
dHRlci4NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC82NDQ0NjMNCnN1
Y2ggYXM6DQorCWthc2FuX2Rpc2FibGVfY3VycmVudCgpOw0KICAvLyBhY2Nlc3MgZnANCisJa2Fz
YW5fZW5hYmxlX2N1cnJlbnQoKTsNCg0KVGhhbmtzDQpDaHVuaHVpIExpDQoNCi0tLS0t08q8/tSt
vP4tLS0tLQ0Kt6K8/sjLOiBNYXJrIFJ1dGxhbmQgW21haWx0bzptYXJrLnJ1dGxhbmRAYXJtLmNv
bV0gDQq3osvNyrG85DogMjAxOMTqMTDUwjnI1SAxODozOQ0KytW8/sjLOiBDaHVuaHVpIExpICjA
7rS6u9QpDQqzrcvNOiBDYXRhbGluIE1hcmluYXM7IFdpbGwgRGVhY29uOyBNYXR0aGlhcyBCcnVn
Z2VyOyBNYXJjIFp5bmdpZXI7IEFyZCBCaWVzaGV1dmVsOyBKYW1lcyBNb3JzZTsgTWFzYWhpcm8g
WWFtYWRhOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmc7IHdz
ZF91cHN0cmVhbQ0K1vfM4jogUmU6IFtQQVRDSF0ga2FzYW46IGF2b2lkIG91dC1vZi1ib3VuZHMg
aW4gdW53aW5kX2ZyYW1lDQoNCk9uIFR1ZSwgT2N0IDA5LCAyMDE4IGF0IDA2OjExOjAzUE0gKzA4
MDAsIENodW5odWkgTGkgd3JvdGU6DQo+IEZyb206ICJjaHVuaHVpLmxpIiA8Y2h1bmh1aS5saUBt
ZWRpYXRlay5jb20+DQo+IA0KPiAgICBrYXNhbiBkZXRlY3QgdW53aW5kX2ZyYW1lIG91dC1vZi1i
b3VuZHMgZXJyb3Igd2hlbiBvbmUgdGFzayBkdW1wIA0KPiBhbm90aGVyLCBsb2cgYXMgYmVsb3cN
Cj4gQlVHOiBLQVNBTjogb3V0LW9mLWJvdW5kcyBpbiB1bndpbmRfZnJhbWUrMHgxNDAvMHgyMGMg
UmVhZCBvZiBzaXplIDggDQo+IGF0IGFkZHIgZmZmZmZmZWExZTIzNzhlMCBieSB0YXNrIEFuck1v
bml0b3JUaHJlYS8xMTExIGF2b2lkIGthc2FuIA0KPiBvdXQtb2YtYm91bmRzIGVycm9yIGJ5IGRp
c2FibGUga2FzYW4gZm9yIHN0YWNrdHJhY2UuYw0KDQpUaGlzIGRvZXNuJ3QgbG9vayByaWdodC4g
U2luY2UgdW53aW5kX2ZyYW1lIHVzZXMgUkVBRF9PTkNFX05PQ0hFQ0soKSwgd2Ugc2hvdWxkIG5l
dmVyIHBlcmZvcm0gYW4gYWNjZXNzIHRoYXQgS0FTQU4gY29tcGxhaW5zIGFib3V0Lg0KDQpJIGRv
bid0IHRoaW5rIHRoYXQgd2Ugc2hvdWxkIGNvbXBsZXRlbHkgZGlzYWJsZSBpbnN0cnVtZW50YXRp
b24gb2Ygc3RhY2t0cmFjZS5jLg0KDQpDYW4geW91IHBsZWFzZSBmaWd1cmUgb3V0IHByZWNpc2Vs
eSB3aGljaCBsaW5lIEtBU0FOIGlzIGNvbXBsYWluaW5nIGFib3V0PyBpLmUuIHVzZSBzY3JpcHRz
L2ZhZGRyMmxpbmUuDQoNClRoYW5rcywNCk1hcmsuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IGNo
dW5odWkubGkgPGNodW5odWkubGlAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGFyY2gvYXJtNjQv
a2VybmVsL01ha2VmaWxlIHwgMiArKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQva2VybmVsL01ha2VmaWxlIGIvYXJjaC9h
cm02NC9rZXJuZWwvTWFrZWZpbGUgDQo+IGluZGV4IDk1YWM3MzcuLjYwNmQwZTIgMTAwNjQ0DQo+
IC0tLSBhL2FyY2gvYXJtNjQva2VybmVsL01ha2VmaWxlDQo+ICsrKyBiL2FyY2gvYXJtNjQva2Vy
bmVsL01ha2VmaWxlDQo+IEBAIC01Nyw2ICs1Nyw4IEBAIGFybTY0LW9iai0kKENPTkZJR19DUkFT
SF9EVU1QKQkJKz0gY3Jhc2hfZHVtcC5vDQo+ICBhcm02NC1vYmotJChDT05GSUdfQVJNX1NERV9J
TlRFUkZBQ0UpCSs9IHNkZWkubw0KPiAgYXJtNjQtb2JqLSQoQ09ORklHX0FSTTY0X1NTQkQpCQkr
PSBzc2JkLm8NCj4gIA0KPiArS0FTQU5fU0FOSVRJWkVfc3RhY2t0cmFjZS5vIDo9IG4NCj4gKw0K
PiAgb2JqLXkJCQkJCSs9ICQoYXJtNjQtb2JqLXkpIHZkc28vIHByb2Jlcy8NCj4gIG9iai1tCQkJ
CQkrPSAkKGFybTY0LW9iai1tKQ0KPiAgaGVhZC15CQkJCQk6PSBoZWFkLm8NCj4gLS0NCj4gMS45
LjENCj4gDQo=
