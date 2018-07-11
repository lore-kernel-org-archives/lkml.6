Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D56C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DDA2083D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DDA2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbeGKLst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:48:49 -0400
Received: from smtp-out6.electric.net ([192.162.217.182]:63732 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbeGKLss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:48:48 -0400
Received: from 1fdDY2-0009EC-TF by out6d.electric.net with emc1-ok (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fdDY6-0009qO-U6; Wed, 11 Jul 2018 04:44:46 -0700
Received: by emcmailer; Wed, 11 Jul 2018 04:44:46 -0700
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out6d.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fdDY2-0009EC-TF; Wed, 11 Jul 2018 04:44:42 -0700
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 11 Jul 2018 12:46:21 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 11 Jul 2018 12:46:21 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
CC:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James Hogan" <jhogan@kernel.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        wuzhangjin <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
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
Thread-Index: AQHUGQew6BeCJJ492kKUdytd7WH/WKSJ5EIQ
Date:   Wed, 11 Jul 2018 11:46:21 +0000
Message-ID: <d8a11208170d4fb09564413356ff940c@AcuMS.aculab.com>
References: <1531103198-16764-1-git-send-email-chenhc@lemote.com>
 <tencent_26F8B9E004D4512B2225FCE1@qq.com>
 <20180710121727.GK2476@hirez.programming.kicks-ass.net>
 <5471216.FKXZRxKFUI@flygoat-ry> <20180711102106.GG13963@arm.com>
 <20180711110952.GC2476@hirez.programming.kicks-ass.net>
In-Reply-To: <20180711110952.GC2476@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
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

RnJvbTogUGV0ZXIgWmlqbHN0cmENCj4gU2VudDogMTEgSnVseSAyMDE4IDEyOjEwDQouLg0KPiBB
ZGRpbmcgU1lOQyB0byBXUklURV9PTkNFKCkvYXRvbWljKiB3aWxsIGh1cnQgcGVyZm9ybWFuY2Ug
bG90cyBhbmQgd2lsbA0KPiB1bHRpbWF0ZWx5IG5vdCBndWFyYW50ZWUgYW55dGhpbmcgbW9yZTsg
YW5kIGFzIFdpbGwgc2FpZCwga2VlcCB5b3UNCj4gY2hhc2luZyBkcmFnb25zIHdoZXJlIHBlb3Bs
ZSBmb3Jnb3QgdG8gdXNlIFdSSVRFX09OQ0UoKSB3aGVyZSB0aGV5IG1heWJlDQo+IHNob3VsZCd2
ZS4NCg0KQWxzbyBXUklURV9PTkNFKCkgaXMgdGhlcmUgdG8gc29sdmUgYW4gZW50aXJlbHkgZGlm
ZmVyZW50IHByb2JsZW0uDQpJZiB5b3UgaGF2ZSBhIGZ1bmN0aW9uIHRoYXQgZG9lczoNCgk8bG90
cyBvZiBjb2RlIHdpdGhvdXQgYW55IGZ1bmN0aW9uIGNhbGxzPg0KCWZvby0+YmFyID0gMTsNCnRo
ZSBjb21waWxlciBpcyBhbGxvd2VkIHRvIHdyaXRlIG90aGVyICh1bnJlbGF0ZWQpIHZhbHVlcw0K
dG8gZm9vLT5iYXIgaW4gdGhlIGdlbmVyYXRlZCBjb2RlIGZvciA8bG90cyBvZiBjb2RlPi4NCg0K
QSBsb25nIHRpbWUgYWdvIEkgdXNlZCBhIGNvbXBpbGVyIHRoYXQgbWFuYWdlZCB0byBjb252ZXJ0
Og0KCWlmIChmb28tPmJhciA9PSAyKQ0KCQlmb28tPmJhciA9IDM7DQppbnRvOg0KCWlmIChmb28t
PmJhciA9PSAyKSB7DQoJCWZvby0+YmFyID0gMDsNCgkJZm9vLT5iYXIgPSAzOw0KCX0NCldoZW4g
YW4gaW50ZXJydXB0IHJlYWQgdGhlIHZhbHVlIDAgYSBsb3Qgb2YgbGlua2VkIGxpc3QgZ290IHNj
cmV3ZWQgdXAuDQpXUklURV9PTkNFKCkgaXMgdGhlcmUgdG8gZW5zdXJlIHRoYXQgZG9lc24ndCBo
YXBwZW4uDQooSW4gbXkgY2FzZSAnZm9vJyB3YXMgYSAyLWJpdCB3aWRlIGJpdGZpZWxkLCBhbmQg
SSBzdXNwZWN0IHlvdQ0KY2FuJ3QgdXNlIFdSSVRFX09OQ0UoKSBvbiBiaXRmaWVsZHMuKQ0KDQoJ
RGF2aWQNCg0K
