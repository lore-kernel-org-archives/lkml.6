Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB01EC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C4B222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392319AbfBMOnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:43:23 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46691 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728867AbfBMOnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:43:22 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gtvkk-0003ln-CI; Wed, 13 Feb 2019 15:43:10 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
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
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190213025520.GA5803@jagdpanzerIV>
Date:   Wed, 13 Feb 2019 15:43:08 +0100
In-Reply-To: <20190213025520.GA5803@jagdpanzerIV> (Sergey Senozhatsky's
        message of "Wed, 13 Feb 2019 11:55:20 +0900")
Message-ID: <874l9721hf.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-13, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>> - A dedicated kernel thread is created for printing to all consoles in
>>   a fully preemptible context.
>
> How do you handle sysrq-<foo> printouts on systems which can't
> schedule printk-kthread?

If those sysrq printouts are at the emergency loglevel (which most are),
then they are printed immediately to the emergency consoles. This has
already proved useful for our own kernel debugging work. For example,
currently sysrq-z for very large traces result in messages being dropped
because of printk buffer overflows. But with the emergency console we
always see the full trace buffer.

Because you have already done so much work and experimentation with
printk-kthreads, I feel like many of your comments are related to your
kthread work in this area. Really the big design change I make with my
printk-kthread is that it is only for non-critical messages. For
anything critical, users should rely on an emergency console.

John Ogness
