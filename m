Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4871FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B2820660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B2820660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeK2Abf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:31:35 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:23600 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727982AbeK2Abe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:31:34 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-185-7gT-X27jM6O-UE-mcTAibA-1; Wed, 28 Nov 2018 13:29:43 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 28 Nov 2018 13:29:52 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 28 Nov 2018 13:29:52 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
CC:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: RE: [PATCH 3/3] lockdep: Use line-buffered printk() for lockdep
 messages.
Thread-Topic: [PATCH 3/3] lockdep: Use line-buffered printk() for lockdep
 messages.
Thread-Index: AQHUg0UlCAjoqkcY10WwAvBZzORuiaVlNSag
Date:   Wed, 28 Nov 2018 13:29:52 +0000
Message-ID: <d630011ed50140b082e15ddc05d0c640@AcuMS.aculab.com>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
        <1541165517-3557-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
        <20181107151900.gxmdvx42qeanpoah@pathway.suse.cz>
        <20181108044510.GC2343@jagdpanzerIV>
        <9648a384-853c-942e-6a8d-80432d943aae@i-love.sakura.ne.jp>
        <20181109061204.GC599@jagdpanzerIV>
        <07dcbcb8-c5a7-8188-b641-c110ade1c5da@i-love.sakura.ne.jp>
        <20181109154326.apqkbsojmbg26o3b@pathway.suse.cz>
        <deb8d78b-0593-2b8e-1c7a-9203aa77005f@i-love.sakura.ne.jp>
        <20181123124647.jmewvgrqdpra7wbm@pathway.suse.cz>
 <20181123105634.4956c255@vmware.local.home>
In-Reply-To: <20181123105634.4956c255@vmware.local.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 7gT-X27jM6O-UE-mcTAibA-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt
> > Steven told me on Plumbers conference that even few initial
> > characters saved him a day few times.
> 
> Yes, and that has happened more than once. I would reboot and retest
> code that is crashing, and due to a triple fault, the machine would
> reboot because of some race, and the little output I get from the
> console would help tremendously.
> 
> Remember, debugging the kernel is a lot like forensics, especially when
> it's from a customer's site. You look at all the evidence that you can
> get, and sometimes it's just 10 characters in the output that gives you
> an idea of where things went wrong. I'm really not liking the buffering
> idea because of this.

Yep, it is a real PITA that syslogd (or linux equiv) stops messages being
written to the console by the kernel (which used to be synchronous) and
instead writes them out from userspace.
By that time it has all died.

Sometimes you want a printk() that writes the data to the serial port
before returning.

I also spent a week trying to work out why a customer kernel was
locking up - only to finally find out that the distro they were
using set 'panic on opps' - making it almost impossible to find
out what was happening.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

