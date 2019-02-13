Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FB2C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F083222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391334AbfBMJUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:20:44 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45920 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfBMJUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:20:43 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gtqi9-0004QL-Be; Wed, 13 Feb 2019 10:20:09 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 07/25] printk-rb: add functionality required by printk
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-8-john.ogness@linutronix.de>
        <CAHk-=whToBNHN_X_BQkO4zSyhSBaGqTH8XEtxg2_AxoBdDnEdg@mail.gmail.com>
Date:   Wed, 13 Feb 2019 10:20:07 +0100
In-Reply-To: <CAHk-=whToBNHN_X_BQkO4zSyhSBaGqTH8XEtxg2_AxoBdDnEdg@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 12 Feb 2019 09:15:36 -0800")
Message-ID: <87k1i411vc.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-12, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Tue, Feb 12, 2019 at 6:30 AM John Ogness <john.ogness@linutronix.de> wrote:
>>
>> +                       while (atomic_long_read(&rb->lost)) {
>> +                               atomic_long_dec(&rb->lost);
>> +                               rb->seq++;
>> +                       }
>
> This looks like crazy garbage. It's neither atomic nor sane.

It works because because only 1 context on a single CPU can hit that
loop. But yes, it is crazy.

> Why isn't it something like
>
>     if (atomic_long_read(&rb->lost)) {
>         long lost = atomic_xchg(&rb->lost, 0);
>         rb->seq += lost;
>     }
>
> instead?

Yes, it should be like you suggest. Thanks.

John Ogness
