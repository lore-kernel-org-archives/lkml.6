Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AC0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9284E21A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405977AbfBOK4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:56:25 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52312 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfBOK4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:56:25 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gubAH-0000xP-7K; Fri, 15 Feb 2019 11:56:17 +0100
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
Subject: Re: [RFC PATCH v1 02/25] printk-rb: add prb locking functions
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-3-john.ogness@linutronix.de>
        <20190213154541.wvft64nf352vghou@pathway.suse.cz>
        <87pnrvs707.fsf@linutronix.de>
        <20190214103324.viexpifsyons5qya@pathway.suse.cz>
        <87y36ih8p7.fsf@linutronix.de>
        <20190215102635.kdo4yxifh5dt2yj7@pathway.suse.cz>
Date:   Fri, 15 Feb 2019 11:56:15 +0100
In-Reply-To: <20190215102635.kdo4yxifh5dt2yj7@pathway.suse.cz> (Petr Mladek's
        message of "Fri, 15 Feb 2019 11:26:35 +0100")
Message-ID: <87y36hials.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-15, Petr Mladek <pmladek@suse.com> wrote:
>>> void prb_lock(struct prb_cpulock *cpu_lock)
>>> {
>>> 	unsigned int flags;
>>> 	int cpu;
>> 
>> I added an explicit preempt_disable here:
>> 
>>         cpu = get_cpu();
>
> It is superfluous. Preemption is not possible when interrupts
> are disabled.

Interrupts are not necessarily disabled here. They get disabled later if
the lock needs to be taken (i.e. we are not nested).

John Ogness
