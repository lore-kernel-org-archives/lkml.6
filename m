Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933F4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E53206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfBVNil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 08:38:41 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:54987 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBVNil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 08:38:41 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gxB27-0007xe-4M; Fri, 22 Feb 2019 14:38:31 +0100
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
Subject: Re: [RFC PATCH v1 11/25] printk_safe: remove printk safe code
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-12-john.ogness@linutronix.de>
        <20190222103732.zkcvjijtdcfu4vbt@pathway.suse.cz>
Date:   Fri, 22 Feb 2019 14:38:28 +0100
In-Reply-To: <20190222103732.zkcvjijtdcfu4vbt@pathway.suse.cz> (Petr Mladek's
        message of "Fri, 22 Feb 2019 11:37:32 +0100")
Message-ID: <87h8cwymcr.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-22, Petr Mladek <pmladek@suse.com> wrote:
>> diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
>> index 15ca78e1c7d4..77bf84987cda 100644
>> --- a/lib/nmi_backtrace.c
>> +++ b/lib/nmi_backtrace.c
>> @@ -75,12 +75,6 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
>>  		touch_softlockup_watchdog();
>>  	}
>>  
>> -	/*
>> -	 * Force flush any remote buffers that might be stuck in IRQ context
>> -	 * and therefore could not run their irq_work.
>> -	 */
>> -	printk_safe_flush();
>> -
>>  	clear_bit_unlock(0, &backtrace_flag);
>>  	put_cpu();
>>  }
>
> This reminds me that we need to add back the locking that was
> removed in the commit 03fc7f9c99c1e7ae2925d45 ("printk/nmi:
> Prevent deadlock when accessing the main log buffer in NMI").

No, that commit is needed. You cannot have NMIs waiting on other CPUs.

> Otherwise, backtraces from different CPUs would get mixed.

A later patch (#17) adds CPU IDs to the printk messages so that this
isn't a problem. (That patch is actually obsolete now because Sergey has
already merged work for linux-next that includes this information.)

John Ogness
