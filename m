Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA61C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB0B208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB0B208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeGKKHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:07:04 -0400
Received: from smtp-out4.electric.net ([192.162.216.184]:52339 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeGKKHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:07:04 -0400
Received: from 1fdBxp-0001xm-Ut by out4b.electric.net with emc1-ok (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fdBxy-0002k6-Vl; Wed, 11 Jul 2018 03:03:22 -0700
Received: by emcmailer; Wed, 11 Jul 2018 03:03:22 -0700
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out4b.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fdBxp-0001xm-Ut; Wed, 11 Jul 2018 03:03:13 -0700
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 11 Jul 2018 11:04:52 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 11 Jul 2018 11:04:52 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Paul Burton' <paul.burton@mips.com>,
        Peter Zijlstra <peterz@infradead.org>,
        =?gb2312?B?s8K7qrLF?= <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        wuzhangjin <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] MIPS: implement smp_cond_load_acquire() for Loongson-3
Thread-Topic: [PATCH V2] MIPS: implement smp_cond_load_acquire() for
 Loongson-3
Thread-Index: AQHUGHE46BeCJJ492kKUdytd7WH/WKSJx/lw
Date:   Wed, 11 Jul 2018 10:04:52 +0000
Message-ID: <1a072b07261b46d88938f0f709f54d42@AcuMS.aculab.com>
References: <1531103198-16764-1-git-send-email-chenhc@lemote.com>
 <20180709164939.uhqsvcv4a7jlbhvp@pburton-laptop>
 <CAAhV-H7bqhz+dzgPk0_tTAN6y_k_8Ds9heF0p5uPHsHNg0v4Rg@mail.gmail.com>
 <20180710093637.GF2476@hirez.programming.kicks-ass.net>
 <20180710105437.GT2512@hirez.programming.kicks-ass.net>
 <tencent_26F8B9E004D4512B2225FCE1@qq.com>
 <20180710121727.GK2476@hirez.programming.kicks-ass.net>
 <20180710171040.f3gyyh524xlsqv4j@pburton-laptop>
In-Reply-To: <20180710171040.f3gyyh524xlsqv4j@pburton-laptop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS:  TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (s)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUGF1bCBCdXJ0b24NCj4gU2VudDogMTAgSnVseSAyMDE4IDE4OjExDQouLi4NCj4gSSdt
IG5vdCBzdXJlIHdoaWNoIGlzIHRoZSBpbnRlbnQgKEkgY2FuIGFzayBpZiBzb21lb25lJ3MgaW50
ZXJlc3RlZCksDQo+IGJ1dCB5b3UgY291bGQgZWl0aGVyOg0KPiANCj4gICAxKSBDb25zaWRlciB0
aGUgc3RvcmUgYnVmZmVyIGEgY2FjaGUsIGluIHdoaWNoIGNhc2UgbG9hZHMgbmVlZCB0bw0KPiAg
ICAgIGNoZWNrIGFsbCBzdG9yZSBidWZmZXJzIGZyb20gYWxsIENQVXMgYmVjYXVzZSBvZiB0aGUg
ImFsbCBjYWNoZXMiDQo+ICAgICAgcGFydCBvZiB0aGUgZmlyc3QgcXVvdGVkIHNlbnRlbmNlLg0K
PiANCj4gb3INCj4gDQo+ICAgMikgRGVjaWRlIHN0b3JlIGJ1ZmZlcnMgYXJlbid0IGNvdmVyZWQg
YnkgdGhlIE1JUFMgYXJjaGl0ZWN0dXJlDQo+ICAgICAgZG9jdW1lbnRhdGlvbiBhdCBhbGwgaW4g
d2hpY2ggY2FzZSB0aGUgb25seSBzYW5lIHRoaW5nIHRvIGRvIHdvdWxkDQo+ICAgICAgYmUgdG8g
bWFrZSBpdCB0cmFuc3BhcmVudCB0byBzb2Z0d2FyZSAoYW5kIGhlcmUgTG9vbmdzb24ncyBpc24n
dCkNCi4uLg0KDQpTdG9yZSBidWZmZXJzIGFyZSBjb21tb24gYW5kIGFyZSBuZXZlciB0cmFuc3Bh
cmVudCB0byBtdWx0aS10aHJlYWRlZCBjb2RlLg0KVGhleSBhcmUgbGFyZ2VseSB3aHkgeW91IG5l
ZWQgbG9ja3MuDQoNCkF0IGxlYXN0IG9uIChlYXJseSkgc3BhcmMgc3lzdGVtcyB0aGV5IHdlcmUg
YmV0d2VlbiB0aGUgZXhlY3V0aW9uIHVuaXQNCmFuZCB0aGUgZGF0YSBjYWNoZS4NCg0KSSBhbHNv
IHN1c3BlY3QgdGhhdCAnd3JpdGUgc3RhcnZhdGlvbicgaXMgYWxzbyBjb21tb24gLSBhZnRlciBh
bGwgdGhlDQpwdXJwb3NlIG9mIHRoZSBzdG9yZSBidWZmZXIgaXMgdG8gZG8gcmVhZHMgaW4gcHJl
ZmVyZW5jZSB0byB3cml0ZXMgaW4NCm9yZGVyIHRvIHJlZHVjZSB0aGUgY3B1IHN0YWxscyB3YWl0
aW5nIGZvciB0aGUgbWVtb3J5IGJ1cyAocHJvYmFibHkNCnRoZSBjcHUgdG8gY2FjaGUgaW50ZXJm
YWNlKS4NCg0KSSB0aGluayB5b3VyIGV4YW1wbGUgaXMganVzdDoNCgkqKHZvbGF0aWxlIGludCAq
KXh4eCA9IDE7DQoJd2hpbGUgKCEqKHZvbGF0aWxlIGludCAqKXl5eSkgY29udGludWU7DQpydW5u
aW5nIG9uIHR3byBjcHUgd2l0aCB4eHggYW5kIHl5eSBzd2FwcGVkPw0KDQpZb3UgbmVlZCBhIHN0
cm9uZ2VyIGJ1cyBjeWNsZSBpbiB0aGVyZSBzb21ld2hlcmUuDQoNCglEYXZpZA0KDQo=
