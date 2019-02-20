Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C93C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787EC20880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfBTVZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 16:25:11 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41875 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfBTVZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 16:25:11 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gwZMT-0001MJ-VU; Wed, 20 Feb 2019 22:25:02 +0100
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
Date:   Wed, 20 Feb 2019 22:25:00 +0100
In-Reply-To: <20190220090112.xbnauwt2w7gwtebo@pathway.suse.cz> (Petr Mladek's
        message of "Wed, 20 Feb 2019 10:01:12 +0100")
Message-ID: <8736oijgpf.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-20, Petr Mladek <pmladek@suse.com> wrote:
>> vprintk_emit and vprintk_store are the main functions that all printk
>> variants eventually go through. Change these to store the message in
>> the new printk ring buffer that the printk kthread is reading.
>
> We need to switch the two buffers in a single commit
> without disabling important functionality.
>
> By other words, we need to change vprintk_emit(), vprintk_store(),
> console_unlock(), syslog(), devkmsg(), and syslog in one patch.

Agreed. But for the review process I expect it makes things much easier
to change them one at a time. Patch-squashing is not a problem once all
the individuals have been ack'd.

>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index 5a5a685bb128..b6a6f1002741 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -584,54 +500,36 @@ static int log_store(int facility, int level,
>>  		     const char *text, u16 text_len)
>
>>  	memcpy(log_dict(msg), dict, dict_len);
>>  	msg->dict_len = dict_len;
>>  	msg->facility = facility;
>>  	msg->level = level & 7;
>>  	msg->flags = flags & 0x1f;
>
> The existing struct printk_log is stored into the data field
> of struct prb_entry. It is because printk_ring_buffer is supposed
> to be a generic ring buffer.

Yes.

> It makes the code more complicated. Also it needs more space for
> the size and seq items from struct prb_entry.
>
> printk() is already very complicated code. We should not make
> it unnecessarily worse.

In my opinion it makes things considerably easier. My experience with
printk-code is that it is so complicated because it is mixing
printk-features with ring buffer handling code. By providing a strict
API (and hiding the details) of the ring buffer, the implementation of
the printk-features became pretty straight forward.

Now I will admit that the ring buffer API I proposed is not easy to
digest. Mostly because I leave a lot of work up to the readers and have
lots of arguments. Your proposed changes of passing a struct and moving
loops under the ring buffer API should provide some major
simplification.

> Please, are there any candidates or plans to reuse the new ring
> buffer implementation?

As you pointed out below, this patch already uses the ring buffer
implementation for a totally different purpose: NMI safe dynamic memory
allocation.

> For example, would it be usable for ftrace? Steven?
>
> If not, I would prefer to make it printk-specific
> and hopefully simplify the code a bit.
>
>
>> -	if (ts_nsec > 0)
>> -		msg->ts_nsec = ts_nsec;
>> -	else
>> -		msg->ts_nsec = local_clock();
>> -	memset(log_dict(msg) + dict_len, 0, pad_len);
>> +	msg->ts_nsec = ts_nsec;
>>  	msg->len = size;
>>  
>>  	/* insert message */
>> -	log_next_idx += msg->len;
>> -	log_next_seq++;
>> +	prb_commit(&h);
>>  
>>  	return msg->text_len;
>>  }
>
> [...]
>
>>  int vprintk_store(int facility, int level,
>>  		  const char *dict, size_t dictlen,
>>  		  const char *fmt, va_list args)
>>  {
>> -	static char textbuf[LOG_LINE_MAX];
>> -	char *text = textbuf;
>> -	size_t text_len;
>> +	return vprintk_emit(facility, level, dict, dictlen, fmt, args);
>> +}
>> +
>> +/* ring buffer used as memory allocator for temporary sprint buffers */
>> +DECLARE_STATIC_PRINTKRB(sprint_rb,
>> +			ilog2(PRINTK_RECORD_MAX + sizeof(struct prb_entry) +
>> +			      sizeof(long)) + 2, &printk_cpulock);
>> +
>> +asmlinkage int vprintk_emit(int facility, int level,
>> +			    const char *dict, size_t dictlen,
>> +			    const char *fmt, va_list args)
>
> [...]
>
>> +	rbuf = prb_reserve(&h, &sprint_rb, PRINTK_SPRINT_MAX);
>
> The second ring buffer for temporary buffers is really interesting
> idea.
>
> Well, it brings some questions. For example, how many users might
> need a reservation in parallel. Or if the nested use might cause
> some problems when we decide to use printk-specific ring buffer
> implementation. I still have to think about it.

Keep in mind that it is only used by the writers, which have the
prb_cpulock. Typically there would only be 2 max users: a non-NMI writer
that was interrupted during the reserve/commit window and the
interrupting NMI that does printk. The only exception would be if the
printk-code code itself triggers a BUG_ON or WARN_ON within the
reserve/commit window. Then you will have an additional user per
recursion level.

John Ogness
