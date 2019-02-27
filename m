Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2DFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BD6205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfB0KDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:03:09 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48298 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfB0KDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:03:08 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gyw3F-0008NF-13; Wed, 27 Feb 2019 11:02:57 +0100
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
Subject: Re: [RFC PATCH v1 15/25] printk: print history for new consoles
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-16-john.ogness@linutronix.de>
        <20190226145837.wl54fr7rn2ii5oxc@pathway.suse.cz>
        <87o96yziau.fsf@linutronix.de>
        <20190227090249.fzigc7r237emlg6k@pathway.suse.cz>
Date:   Wed, 27 Feb 2019 11:02:53 +0100
In-Reply-To: <20190227090249.fzigc7r237emlg6k@pathway.suse.cz> (Petr Mladek's
        message of "Wed, 27 Feb 2019 10:02:49 +0100")
Message-ID: <874l8pft0y.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-27, Petr Mladek <pmladek@suse.com> wrote:
> I mean that your patch does the reply on a very hidden location.

Right. I understand that and I agree.

> Regarding the per-console kthread. It would make sense if
> we stop handling all consoles synchronously. For example,
> when we push messages to fast consoles immediately and
> offload the work for slow consoles.

My per-console kthread suggestion relating to fast consoles is so that
some consoles (such as netconsole, which is quite fast) could drop less
messages than a slow console (such as uart).

> Anyway, we first need to make the offload reliable enough.
> It is not acceptable to always offload all messages.
> We have been there last few years. We must keep a high
> chance to see the messages. Any warning might be important
> when it causes the system to die. Nobody knows what message
> is such an important.

You seem to be missing the point of the series. It _is_ acceptable to
offload all messages because they are being offloaded to non-emergency
consoles. If messages are lost, it sucks (and the appropriate "dropped"
messages are sent), but it isn't critical. Once we can agree to this
point, printk becomes so much easier to work with.

Emergency consoles exist for handling important messages. They will not
drop messages. They are synchronous and immediate.

>> It is not necessary. It is desired. Why should _any_ task be punished
>> with console writing? That is what the printk kthread is for.
>
> I do not know about any acceptable solution without punishing
> the tasks. But we might find a better compromise between the
> punishment and reliability.

I do not want printk to compromise. That compromise is part of the
problem. Let's partition printk to important and non-important so that
we can optimize both. _That_ is the heart of this series.

John Ogness
