Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8C6C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BFF2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BFF2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baidu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeK3VaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:30:12 -0500
Received: from mx20.baidu.com ([111.202.115.85]:49414 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726469AbeK3VaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:30:12 -0500
X-Greylist: delayed 2815 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Nov 2018 16:30:08 EST
Received: from M1-MAIL-EX14.internal.baidu.com (unknown [10.44.89.54])
        by Forcepoint Email with ESMTPS id CC91BB3E9FEB2;
        Fri, 30 Nov 2018 17:34:18 +0800 (CST)
Received: from BC-Mail-EX02.internal.baidu.com (172.31.40.16) by
 M1-MAIL-EX14.internal.baidu.com (10.44.89.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1531.3; Fri, 30 Nov 2018 17:34:20 +0800
Received: from BC-Mail-Ex09.internal.baidu.com (172.31.40.19) by
 BC-Mail-EX02.internal.baidu.com (172.31.40.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1531.3; Fri, 30 Nov 2018 17:34:19 +0800
Received: from BC-Mail-Ex09.internal.baidu.com ([169.254.157.238]) by
 BC-Mail-Ex09.internal.baidu.com ([172.31.40.19]) with mapi id 15.01.1531.007;
 Fri, 30 Nov 2018 17:34:20 +0800
From:   "Liu,Qi(ACU-T1)" <liuqi16@baidu.com>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>
CC:     Will Deacon <will.deacon@arm.com>, Yongji Xie <elohimes@gmail.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xie,Yongji" <xieyongji@baidu.com>,
        "Zhang,Yu(ACU-T1)" <zhangyu31@baidu.com>,
        "Yuan,Linsi" <yuanlinsi01@baidu.com>, "Ni,Xun" <nixun@baidu.com>,
        "Li,Lin(ACU-T1)" <lilin24@baidu.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: =?gb2312?B?tPC4tDogW1JGQ10gbG9ja2luZy9yd3NlbTogQXZvaWQgaXNzdWluZyB3YWtl?=
 =?gb2312?Q?up_before_setting_the_reader_waiter_to_nil?=
Thread-Topic: [RFC] locking/rwsem: Avoid issuing wakeup before setting the
 reader waiter to nil
Thread-Index: AQHUh+I/IzQW+DeqbkO+lYev54G5OKVmNH4AgAAkKgCAAAxugIAAD5yAgAAG5QCAAAuWAIAABQ8AgAABQICAAADZgIAAOyMAgAFEwZA=
Date:   Fri, 30 Nov 2018 09:34:19 +0000
Message-ID: <c1c9d6b30d7745ea9ac5b752f9a506c3@baidu.com>
References: <1543495830-2644-1-git-send-email-xieyongji@baidu.com>
 <20181129131232.GN2131@hirez.programming.kicks-ass.net>
 <5598cd71-c3c8-d6ef-eb30-777cf901a2ef@redhat.com>
 <20181129160627.GU2131@hirez.programming.kicks-ass.net>
 <8cc45695-b325-a219-8b46-d5da6ddfdd63@redhat.com>
 <20181129172700.GA11632@hirez.programming.kicks-ass.net>
 <20181129180828.GA11650@hirez.programming.kicks-ass.net>
 <729ceddb-dd9a-ec2a-f74e-03fa4d7e65e8@redhat.com>
 <20181129183103.GA4952@arm.com>
 <f991af45-2131-ad75-94cd-2c8548266a9e@redhat.com>
 <20181129220544.GE11632@hirez.programming.kicks-ass.net>
In-Reply-To: <20181129220544.GE11632@hirez.programming.kicks-ass.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.24.154.236]
x-baidu-bdmsfe-datecheck: 1_BC-Mail-EX02_2018-11-30 17:34:20:210
x-baidu-bdmsfe-viruscheck: BC-Mail-EX02_GRAY_Inside_WithoutAtta_2018-11-30
 17:34:20:179
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Baidu-BdMsfe-DateCheck: 1_M1-MAIL-EX14_2018-11-30 17:34:20:435
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SXMgdGhlcmUgYSBzZW1hbnRpYyBkaXZlcmdlbmNlIGJldHdlZW4geDg2IGluc3RydWN0aW9uICJM
T0NLIGNtcHhjaGciIGFuZCB0aGUgbWFjcm8gY21weGNoZyBkZWZpbmVkIGluIGxpbnV4IGtlcm5l
bD8gVGhlIGZvcm1lciBndWFyYW50ZWUgZnVsbCBiYXJyaWVyIGluIGFueSBjYXNlLCBhbmQgdGhl
IGxhdHRlciBvbmx5IGltcGx5IGJhcnJpZXIgaW4gY2FzZSBvZiBzdWNjZXNzPw0KU28sIHdlIHVz
ZSAJDQogICAgc21wX21iX19iZWZvcmVfYXRvbWljKCkNCgljbXB4Y2hnX3JlbGF4ZWQoKSAgLy8g
bm8gYmFycmllcg0KdG8gZ2V0IHJpZCBvZiB0aGUgcmVkdW5kYW50IGJhcnJpZXINCiAgIHNtcF9t
Yl9fYmVmb3JlX2F0b21pYygpDQogICBjbXB4Y2hnKCkgICAgICAgICAgLy8gaW1wbHkgYSByZWR1
bmRhbnQgYmFycmllciB3aGVuIHN1Y2Nlc3NpbmcgIA0KICAgIA0KLS0tLS3Tyrz+1K28/i0tLS0t
DQq3orz+yMs6IFBldGVyIFppamxzdHJhIFttYWlsdG86cGV0ZXJ6QGluZnJhZGVhZC5vcmddIA0K
t6LLzcqxvOQ6IDIwMTjE6jEx1MIzMMjVIDY6MDYNCsrVvP7IyzogV2FpbWFuIExvbmcgPGxvbmdt
YW5AcmVkaGF0LmNvbT4NCrOty806IFdpbGwgRGVhY29uIDx3aWxsLmRlYWNvbkBhcm0uY29tPjsg
WW9uZ2ppIFhpZSA8ZWxvaGltZXNAZ21haWwuY29tPjsgbWluZ29AcmVkaGF0LmNvbTsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgWGllLFlvbmdqaSA8eGlleW9uZ2ppQGJhaWR1LmNvbT47
IFpoYW5nLFl1KEFDVS1UMSkgPHpoYW5neXUzMUBiYWlkdS5jb20+OyBMaXUsUWkoQUNVLVQxKSA8
bGl1cWkxNkBiYWlkdS5jb20+OyBZdWFuLExpbnNpIDx5dWFubGluc2kwMUBiYWlkdS5jb20+OyBO
aSxYdW4gPG5peHVuQGJhaWR1LmNvbT47IExpLExpbihBQ1UtVDEpIDxsaWxpbjI0QGJhaWR1LmNv
bT47IERhdmlkbG9ociBCdWVzbyA8ZGF2ZUBzdGdvbGFicy5uZXQ+DQrW98ziOiBSZTogW1JGQ10g
bG9ja2luZy9yd3NlbTogQXZvaWQgaXNzdWluZyB3YWtldXAgYmVmb3JlIHNldHRpbmcgdGhlIHJl
YWRlciB3YWl0ZXIgdG8gbmlsDQoNCk9uIFRodSwgTm92IDI5LCAyMDE4IGF0IDAxOjM0OjA1UE0g
LTA1MDAsIFdhaW1hbiBMb25nIHdyb3RlOg0KDQo+IFRoYXQgd2lsbCBjZXJ0YWlubHkgd29yayBm
b3IgeDg2LiBIb3dldmVyLCBJIGFtIG5vdCBzdXJlIGlmIHRoYXQgd2lsbCANCj4gYmUgb3B0aW1h
bCBmb3IgYXJtIGFuZCBwb3dlcnBjLg0KDQoJc21wX21iX19iZWZvcmVfYXRvbWljKCkNCgljbXB4
Y2hnX3JlbGF4ZWQoKQ0KDQp3b3Jrcy4gQWxzbyBzZWUgcHZfa2lja19ub2RlKCkncyBjb21taXQ6
DQoNCiAgMzRkNTRmM2Q2OTE3ICgibG9ja2luZy9wdnFzcGlubG9jazogUmVsYXggY21weGNoZydz
IHRvIGltcHJvdmUgcGVyZm9ybWFuY2Ugb24gc29tZSBhcmNoaXRlY3R1cmVzIikNCg0KeW91IG1p
Z2h0IGtub3cgdGhlIGF1dGhvciBvZiB0aGF0IDotKQ0K
