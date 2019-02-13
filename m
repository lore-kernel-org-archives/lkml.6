Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA58C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D69222CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404245AbfBMWUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:20:24 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:47925 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404179AbfBMWUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:20:24 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gu2t0-0006xq-Ft; Wed, 13 Feb 2019 23:20:10 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        "linux-serial\@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <6f965383270d45d6ac26529fec5ad470@AcuMS.aculab.com>
Date:   Wed, 13 Feb 2019 23:20:08 +0100
In-Reply-To: <6f965383270d45d6ac26529fec5ad470@AcuMS.aculab.com> (David
        Laight's message of "Wed, 13 Feb 2019 16:54:15 +0000")
Message-ID: <87lg2js547.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-13, David Laight <David.Laight@ACULAB.COM> wrote:
> ...
>> - A dedicated kernel thread is created for printing to all consoles in
>>   a fully preemptible context.
>> 
>> - A new (optional) console operation "write_atomic" is introduced that
>>   console drivers may implement. This function must be NMI-safe. An
>>   implementation for the 8250 UART driver is provided.
>> 
>> - The concept of "emergency messages" is introduced that allows
>>   important messages (based on a new emergency loglevel threshold) to
>>   be immediately written to any consoles supporting write_atomic,
>>   regardless of the context.
> ...
>
> Does this address my usual 'gripe' that the output is written to the
> console by syslogd and not by the kernel itself?

If I understand it correctly, your usual 'gripe' is aimed at
distributions that are turning off the kernel writing directly to the
console. I don't see how that is a kernel issue.

> When you are trying to find out where the system is completely
> deadlocking you need the 'old fashioned' completely synchronous kernel
> printf().

Emergency messages will give you that. They differ from the current
implementation by changing printk to have the caller print only _their_
message directly without concern for past unseen non-emergency messages
or which context they are in.

John Ogness
