Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276D1C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCBB20882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LZnunpxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBCBB20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932651AbeGIOau (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:30:50 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:51449 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754437AbeGIOar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:30:47 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id E336510C1AE6;
        Mon,  9 Jul 2018 07:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531146647; bh=V1HvQ0zPWQ4Bhoeb5vaANUVffwB0ADFiET6C4zlW53A=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=LZnunpxKgQC1CRVHpSrTncq7SSO7wG/kpi5/votwWaQ/1CDF0NYl8FdTtmLMViLN1
         7rZGY++Y9uSTH4gUCREmITPDZwKCLS19He+yEsbrFzeyceiLvsL50zYyJyG2ZM8ojd
         pnSCcYUB/Lr8t9WcoJo9yl65AqnyU6J0v4JP+ZtvwZFLTiAZ2acsOheY88NY5gBq+z
         DtsniskpsdaslfeNgPOq8qBmIExFsO3RG77ddme2yUBPnrZCBLow/n2w14sy80A8Z8
         y0vzAVwS5WVzrrKiJCfBQtAU8zhzFXV2DS8GJ78LDTlWaG5fNrPgkVRbxpvqGNI/1k
         CSh23ug6Q3q5Q==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id 0540337D2;
        Mon,  9 Jul 2018 07:30:44 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 9 Jul 2018 07:30:44 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon,
 9 Jul 2018 16:30:42 +0200
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] atomic{64}_t: Explicitly specify data storage length
 and alignment
Thread-Topic: [PATCH] atomic{64}_t: Explicitly specify data storage length
 and alignment
Thread-Index: AQHUF4MQjYKW/xm0bkmxj3lEZHptjaSGwukAgAAPWwA=
Date:   Mon, 9 Jul 2018 14:30:41 +0000
Message-ID: <6762443004f96d279cba77b7c412163769c930fe.camel@synopsys.com>
References: <20180709124741.21037-1-abrodkin@synopsys.com>
         <20180709133542.GP2476@hirez.programming.kicks-ass.net>
In-Reply-To: <20180709133542.GP2476@hirez.programming.kicks-ass.net>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A0CA5FBDF6FF647A7458FE3DA151A96@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGV0ZXIsDQoNCk9uIE1vbiwgMjAxOC0wNy0wOSBhdCAxNTozNSArMDIwMCwgUGV0ZXIgWmlq
bHN0cmEgd3JvdGU6DQo+IE9uIE1vbiwgSnVsIDA5LCAyMDE4IGF0IDAzOjQ3OjQxUE0gKzAzMDAs
IEFsZXhleSBCcm9ka2luIHdyb3RlOg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2FzbS1nZW5l
cmljL2F0b21pYzY0LmggYi9pbmNsdWRlL2FzbS1nZW5lcmljL2F0b21pYzY0LmgNCj4gPiBpbmRl
eCA4ZDI4ZWIwMTBkMGQuLmI5NGI3NDliNTk1MiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2Fz
bS1nZW5lcmljL2F0b21pYzY0LmgNCj4gPiArKysgYi9pbmNsdWRlL2FzbS1nZW5lcmljL2F0b21p
YzY0LmgNCj4gPiBAQCAtMTMsNyArMTMsNyBAQA0KPiA+ICAjZGVmaW5lIF9BU01fR0VORVJJQ19B
VE9NSUM2NF9IDQo+ID4gIA0KPiA+ICB0eXBlZGVmIHN0cnVjdCB7DQo+ID4gLQlsb25nIGxvbmcg
Y291bnRlcjsNCj4gPiArCXU2NCBfX2FsaWduZWQoOCkgY291bnRlcjsNCj4gPiAgfSBhdG9taWM2
NF90Ow0KPiANCj4gVGhlIHR5cGUgaXMgd3JvbmcsIGF0b21pYyBpcyBzaWduZWQsIHRoZSBhbGln
bm1lbnQgYWxzbyByZWFsbHkgZG9lc24ndA0KPiBtYXR0ZXIsIGdlbmVyaWMgYXRvbWljNjQgaXMg
dXR0ZXIgY3JhcC4NCg0KSG0sIGFueSB0aG91Z2h0cyBvbiB3aHkgaXQncyAidTY0IiBmb3IgMzIt
Yml0IHg4Nj8NClNlZSBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291
cmNlL2FyY2gveDg2L2luY2x1ZGUvYXNtL2F0b21pYzY0XzMyLmgjTDEyDQotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tPjgtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KLyogQW4gNjRiaXQgYXRvbWlj
IHR5cGUgKi8NCg0KdHlwZWRlZiBzdHJ1Y3Qgew0KCXU2NCBfX2FsaWduZWQoOCkgY291bnRlcjsN
Cn0gYXRvbWljNjRfdDsNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQoNCj4gPiAgI2RlZmluZSBBVE9NSUM2NF9JTklUKGkpCXsgKGkpIH0NCj4gPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC90eXBlcy5oIGIvaW5jbHVkZS9saW51eC90eXBlcy5o
DQo+ID4gaW5kZXggOTgzNGU5MGFhMDEwLi5lMmY2MzE3ODI2MjEgMTAwNjQ0DQo+ID4gLS0tIGEv
aW5jbHVkZS9saW51eC90eXBlcy5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC90eXBlcy5oDQo+
ID4gQEAgLTE3NCwxMiArMTc0LDEyIEBAIHR5cGVkZWYgcGh5c19hZGRyX3QgcmVzb3VyY2Vfc2l6
ZV90Ow0KPiA+ICB0eXBlZGVmIHVuc2lnbmVkIGxvbmcgaXJxX2h3X251bWJlcl90Ow0KPiA+ICAN
Cj4gPiAgdHlwZWRlZiBzdHJ1Y3Qgew0KPiA+IC0JaW50IGNvdW50ZXI7DQo+ID4gKwl1MzIgX19h
bGlnbmVkKDQpIGNvdW50ZXI7DQo+ID4gIH0gYXRvbWljX3Q7DQo+IA0KPiB1MzIgaXMgd3Jvbmcs
IHRoZSBhdG9taWMgdHlwZSBpcyBzaWduZWQuDQo+IA0KPiBBbHNvLCBpZiBhbiBhcmNoaXRlY3R1
cmUgZG9lc24ndCBwcm9wZXJseSBhbGlnbiBpdHMgbmF0aXZlIG1hY2hpbmUgd29yZA0KPiBzaXpl
IGJ1dCByZXF1aXJlcyBhbGlnbm1lbnQgZm9yIGF0b21pY3MgaXQncyBhIGJyb2tlbiBhcmNoaXRl
Y3R1cmUuDQoNCk9rIHdlIG1heSBub3QgdG91Y2ggMzItYml0IGF0b21pY3MgYXMgdGhlcmUncyBh
IGhvcGUgbW9zdCBvZiBhcmNoZXMNCnByb3Blcmx5IGFsaWduIG5hdGl2ZSBtYWNoaW5lIHdvcmRz
Lg0KDQo+ID4gIA0KPiA+ICAjaWZkZWYgQ09ORklHXzY0QklUDQo+ID4gIHR5cGVkZWYgc3RydWN0
IHsNCj4gPiAtCWxvbmcgY291bnRlcjsNCj4gPiArCXU2NCBfX2FsaWduZWQoOCkgY291bnRlcjsN
Cj4gPiAgfSBhdG9taWM2NF90Ow0KPiA+ICAjZW5kaWYNCj4gPiAgDQo+IA0KPiBTaW1pbGFyIGZv
ciB0aGlzIG9uZSwgb24gNjRiaXQgYXJjaHMgdGhhdCBzdXBwb3J0IGF0b21pY3MgdGhlIG5hdGl2
ZQ0KPiA2NGJpdCB0eXBlcyAobG9uZyBpbmNsdWRlZCkgaGFkIGJldHRlciBhbHJlYWR5IGltcGx5
IHRoaXMgYWxpZ25tZW50Lg0KDQpPayBhZ3JlZS4NCg0KLUFsZXhleQ==
