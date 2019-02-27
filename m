Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A44C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C38F20830
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbfB0KcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:32:16 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48404 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfB0KcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:32:16 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gywVT-0000sI-Ii; Wed, 27 Feb 2019 11:32:07 +0100
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
Subject: Re: [RFC PATCH v1 20/25] serial: 8250: implement write_atomic
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-21-john.ogness@linutronix.de>
        <20190227094655.ecdwhsc2bf5spkqx@pathway.suse.cz>
Date:   Wed, 27 Feb 2019 11:32:05 +0100
In-Reply-To: <20190227094655.ecdwhsc2bf5spkqx@pathway.suse.cz> (Petr Mladek's
        message of "Wed, 27 Feb 2019 10:46:55 +0100")
Message-ID: <87zhqhed3u.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-27, Petr Mladek <pmladek@suse.com> wrote:
>> Implement a non-sleeping NMI-safe write_atomic console function in
>> order to support emergency printk messages.
>
> It uses console_atomic_lock() added in 18th patch. That one uses
> prb_lock() added by 2nd patch.
>
> Now, prb_lock() allows recursion on the same CPU. But it still needs
> to wait until it is released on another CPU.
>
> [...]
>
> OK, it would be safe when prb_lock() is the only lock taken
> in the NMI handler.

Which is the case. As I wrote to you already [0], NMI contexts are
_never_ allowed to do things that rely on waiting forever for other
CPUs. I could not find any instances where that is the
case. nmi_cpu_backtrace() used to do this, but it does not anymore.

> But printk() should not make such limitation
> to the rest of the system.

That is something we have to decide. It is the one factor that makes
prb_lock() feel a hell of a lot like BKL.

> Not to say, that we would most
> likely need to add a lock back into nmi_cpu_backtrace()
> to keep the output sane.

No. That is why CPU-IDs were added to the output. It is quite sane and
easy to read.

> Peter Zijlstra several times talked about fully lockless
> consoles. He is using the early console for debugging, see
> the patchset
> https://lkml.kernel.org/r/20170928121823.430053219@infradead.org

That is an interesting thread to quote. In that thread Peter actually
wrote the exact implementation of prb_lock() as the method to
synchronize access to the serial console.

> I am not sure if it is always possible. I personally see
> the following way:
>
>    1. Make the printk ring buffer fully lockless. Then we reduce
>       the problem only to console locking. And we could
>       have a per-console-driver lock (no the big lock like
>       prb_lock()).

A fully lockless ring buffer is an option. But as you said, it only
reduces the window, which is why I decided it is not so important (at
least for now). Creating a per-console-driver lock would probably be a
good idea anyway as long as we can guarantee the ordering (which
shouldn't be a problem as long as emergency console ordering remains
fixed and emergency writers always follow that ordering).

>    2. I am afraid that we need to add some locking between CPUs
>       to avoid mixing characters from directly printed messages.

That is exactly what console_atomic_lock() (actually prb_lock) is!

John Ogness

[0] https://lkml.kernel.org/r/87pnrvs707.fsf@linutronix.de
