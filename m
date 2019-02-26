Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCA1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C96D2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfBZPWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:22:12 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45084 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfBZPWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:22:11 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gyeYV-000366-9B; Tue, 26 Feb 2019 16:22:03 +0100
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
Date:   Tue, 26 Feb 2019 16:22:01 +0100
In-Reply-To: <20190226145837.wl54fr7rn2ii5oxc@pathway.suse.cz> (Petr Mladek's
        message of "Tue, 26 Feb 2019 15:58:37 +0100")
Message-ID: <87o96yziau.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-26, Petr Mladek <pmladek@suse.com> wrote:
>> When new consoles register, they currently print how many messages
>> they have missed. However, many (or all) of those messages may still
>> be in the ring buffer. Add functionality to print as much of the
>> history as available. This is a clean replacement of the old
>> exclusive console hack.
>> 
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index 897219f34cab..6c875abd7b17 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -1506,6 +1506,77 @@ static void format_text(struct printk_log *msg, u64 seq,
>>  	}
>>  }
>>  
>> +static void printk_write_history(struct console *con, u64 master_seq)
>> +{
>> +	struct prb_iterator iter;
>> +	bool time = printk_time;
>> +	static char *ext_text;
>> +	static char *text;
>> +	static char *buf;
>> +	u64 seq;
>> +
>> +	ext_text = kmalloc(CONSOLE_EXT_LOG_MAX, GFP_KERNEL);
>> +	text = kmalloc(PRINTK_SPRINT_MAX, GFP_KERNEL);
>> +	buf = kmalloc(PRINTK_RECORD_MAX, GFP_KERNEL);
>> +	if (!ext_text || !text || !buf)
>> +		return;
>
> We need to free buffers that were successfully allocated.

Ouch. You just found some crazy garbage. The char-pointers are
static. The bug is that it allocates each time a console is
registered. It was supposed to be lazy allocation:

   if (!ext_text)
       ext_text = kmalloc(CONSOLE_EXT_LOG_MAX, GFP_KERNEL);

>> +	if (!(con->flags & CON_ENABLED))
>> +		goto out;
>> +
>> +	if (!con->write)
>> +		goto out;
>> +
>> +	if (!cpu_online(raw_smp_processor_id()) &&
>> +	    !(con->flags & CON_ANYTIME))
>> +		goto out;
>> +
>> +	prb_iter_init(&iter, &printk_rb, NULL);
>> +
>> +	for (;;) {
>> +		struct printk_log *msg;
>> +		size_t ext_len;
>> +		size_t len;
>> +		int ret;
>> +
>> +		ret = prb_iter_next(&iter, buf, PRINTK_RECORD_MAX, &seq);
>> +		if (ret == 0) {
>> +			break;
>> +		} else if (ret < 0) {
>> +			prb_iter_init(&iter, &printk_rb, NULL);
>> +			continue;
>> +		}
>> +
>> +		if (seq > master_seq)
>> +			break;
>> +
>> +		con->printk_seq++;
>> +		if (con->printk_seq < seq) {
>> +			print_console_dropped(con, seq - con->printk_seq);
>> +			con->printk_seq = seq;
>> +		}
>> +
>> +		msg = (struct printk_log *)buf;
>> +		format_text(msg, master_seq, ext_text, &ext_len, text,
>> +			    &len, time);
>> +
>> +		if (len == 0 && ext_len == 0)
>> +			continue;
>> +
>> +		if (con->flags & CON_EXTENDED)
>> +			con->write(con, ext_text, ext_len);
>> +		else
>> +			con->write(con, text, len);
>> +
>> +		printk_delay(msg->level);
>
> Hmm, this duplicates a lot of code from call_console_drivers() and
> maybe also from printk_kthread_func(). It is error prone. People
> will forget to update this function when working on the main one.
>
> We need to put the shared parts into separate functions.

Agreed.

>> +	}
>> +out:
>> +	con->wrote_history = 1;
>> +	kfree(ext_text);
>> +	kfree(text);
>> +	kfree(buf);
>> +}
>> +
>>  /*
>>   * Call the console drivers, asking them to write out
>>   * log_buf[start] to log_buf[end - 1].
>> @@ -1524,6 +1595,10 @@ static void call_console_drivers(u64 seq, const char *ext_text, size_t ext_len,
>>  	for_each_console(con) {
>>  		if (!(con->flags & CON_ENABLED))
>>  			continue;
>> +		if (!con->wrote_history) {
>> +			printk_write_history(con, seq);
>
> This looks like an alien. The code is supposed to write one message
> from the given buffer. And some huge job is well hidden there.

This is a very simple implementation of a printk kthread. It probably
makes more sense to have a printk kthread per console. That would allow
fast consoles to not be penalized by slow consoles. Due to the
per-console seq tracking, the code would already support it.

> In addition, the code is actually recursive. It will become
> clear when it is deduplicated as suggested above. We should
> avoid it when it is not necessary. Note that recursive code
> is always more prone to mistakes and it is harder to think of.

Agreed.

> I guess that the motivation is to do everything from the printk
> kthread. Is it really necessary? register_console() takes
> console_lock(). It has to be sleepable context by definition.

It is not necessary. It is desired. Why should _any_ task be punished
with console writing? That is what the printk kthread is for.

John Ogness
