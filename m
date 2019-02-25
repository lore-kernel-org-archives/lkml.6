Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753EDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD2920842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbfBYQmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:42:01 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41066 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbfBYQmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:42:00 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gyJKD-0002V2-33; Mon, 25 Feb 2019 17:41:53 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 10/25] printk: redirect emit/store to new ringbuffer
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-11-john.ogness@linutronix.de>
        <20190220090112.xbnauwt2w7gwtebo@pathway.suse.cz>
        <8736oijgpf.fsf@linutronix.de>
        <20190225121106.oig7s6odqikcn4xw@pathway.suse.cz>
Date:   Mon, 25 Feb 2019 17:41:50 +0100
In-Reply-To: <20190225121106.oig7s6odqikcn4xw@pathway.suse.cz> (Petr Mladek's
        message of "Mon, 25 Feb 2019 13:11:07 +0100")
Message-ID: <875zt7bz1t.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-25, Petr Mladek <pmladek@suse.com> wrote:
>> >> vprintk_emit and vprintk_store are the main functions that all printk
>> >> variants eventually go through. Change these to store the message in
>> >> the new printk ring buffer that the printk kthread is reading.
>> >
>> > Please, are there any candidates or plans to reuse the new ring
>> > buffer implementation?
>> 
>> As you pointed out below, this patch already uses the ring buffer
>> implementation for a totally different purpose: NMI safe dynamic memory
>> allocation.
>
> I have found an alternative solution. We could calculate the length
> of the formatted string without any buffer:
>
> 	va_list args_copy;
>
> 	va_copy(args_copy, args);
> 	len = vscprintf(NULL, fmt, args_copy);
> 	va_end(args_copy);
>
> This vsprintf() mode was implemented for exactly this purpose.

For vprintk_emit() that would work. As you will see in later (patch 23),
the sprint_rb ringbuffer is used for dynamic memory allocation for
kmsg_dump functions as well.

The current printk implementation allows readers to read directly from
the ringbuffer. The proposed ringbuffer requires the reader (printk) to
have its own buffers.

We may be able to find an alternate solution here as well if that is
desired.

John Ogness
