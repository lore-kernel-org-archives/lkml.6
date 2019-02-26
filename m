Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAB6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D4D217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfBZIpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:45:15 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43848 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfBZIpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:45:13 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gyYMK-0002Ky-CT; Tue, 26 Feb 2019 09:45:04 +0100
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
Subject: Re: [RFC PATCH v1 13/25] printk: track seq per console
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-14-john.ogness@linutronix.de>
        <20190225145954.62zl3tndmo2t372h@pathway.suse.cz>
Date:   Tue, 26 Feb 2019 09:45:02 +0100
In-Reply-To: <20190225145954.62zl3tndmo2t372h@pathway.suse.cz> (Petr Mladek's
        message of "Mon, 25 Feb 2019 15:59:54 +0100")
Message-ID: <87lg230whd.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-25, Petr Mladek <pmladek@suse.com> wrote:
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index ece54c24ea0d..ebd9aac06323 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -1504,6 +1514,19 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
>>  		if (!cpu_online(raw_smp_processor_id()) &&
>>  		    !(con->flags & CON_ANYTIME))
>>  			continue;
>> +		if (con->printk_seq >= seq)
>> +			continue;
>> +
>> +		con->printk_seq++;
>> +		if (con->printk_seq < seq) {
>> +			print_console_dropped(con, seq - con->printk_seq);
>> +			con->printk_seq = seq;
>
> It would be great to print this message only when the real one
> is not superseded.

You mean if there was some function to check if "seq" is the newest
entry. And only in that situation would any dropped information be
presented?

> The suppressed messages can be proceed quickly. They allow consoles
> to catch up with the message producers. But if the spend time
> with printing the warning, we just risk loosing more messages
> again and again.

So instead of:

message A
message B
3 messages dropped
message F
message G
2 messages dropped
message J
message K

you would prefer to see:

message A
message B
message F
message G
message J
message K
5 messages dropped

... with the hope that maybe we are able to print messages H and/or I by
not spending time on the first dropped message?

If there are a lof printk's coming (sysrq-z) then probably there will be
many dropped during output. With your proposal, it wouldn't be seen that
so many intermediate messages are dropped. Only at the end of the output
the user is presented with some huge dropped number.

With my implementation if you see 2 printk lines together you can be
sure that nothing was dropped between those two lines. I think that is
more valuable than having the possibility of maybe losing a few less
messages in a flood situation.

John Ogness
