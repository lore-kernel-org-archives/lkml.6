Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C622C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4043F218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbfB0IML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:12:11 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:47999 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfB0IMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 03:12:10 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gyuJx-00031J-VZ; Wed, 27 Feb 2019 09:12:06 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk/console: Do not suppress information about dropped messages
References: <20190226124945.7078-1-pmladek@suse.com>
        <87k1hmzfam.fsf@linutronix.de> <20190227025559.GA18340@jagdpanzerIV>
Date:   Wed, 27 Feb 2019 09:12:04 +0100
In-Reply-To: <20190227025559.GA18340@jagdpanzerIV> (Sergey Senozhatsky's
        message of "Wed, 27 Feb 2019 11:55:59 +0900")
Message-ID: <87fts9fy5n.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-27, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>>>  		if (console_seq < log_first_seq) {
>>> -			len = sprintf(text,
>>> -				      "** %llu printk messages dropped **\n",
>>> -				      log_first_seq - console_seq);
>>> +			console_dropped_cnt += log_first_seq - console_seq;
>>>  
>>>  			/* messages are gone, move to first one */
>>>  			console_seq = log_first_seq;
>>>  			console_idx = log_first_idx;
>>> -		} else {
>>> -			len = 0;
>>>  		}
>>>  skip:
>>>  		if (console_seq == log_next_seq)
>>> @@ -2435,6 +2441,13 @@ void console_unlock(void)
>>>  			exclusive_console = NULL;
>>>  		}
>>>  
>>> +		if (unlikely(console_dropped_cnt)) {
>>> +			len = sprintf(text,
>>> +				      "** %llu printk messages dropped **\n",
>>> +				      console_dropped_cnt);
>>> +			console_dropped_cnt = 0;
>>> +		}
>>> +
>> 
>> My only objection to this is that the "messages dropped" only comes if a
>> non-supressed message comes. So information about dropped information
>> may never get printed unless some task prints something non-supressed.
>> 
>> Imagine a situation where I am expecting a message to come, but don't
>> see it because it was dropped. But if no more non-supressed messages
>> come, I see neither the expected message nor the dropped message.
>
> I think this is exactly the problem (and thus the patch) we discussed
> some 3 years ago.

I guess you are referring to this [0] thread.

> I had a number of rather strangely looking serial logs, which clearly
> had lost messages but no "%llu printk messages dropped" markers. So I
> added `static bool lost_messages' to console_unlock(), set it when
> printing loop would discover lost messages, then print "%llu printk
> messages dropped" attached to whatever msg was next in the logbuf,
> regardless of msg->level.  IOW, if lost_messages was set then
> suppress_message_printing(msg->level) was not even invoked. Yes, that
> would sometimes print several "debugging noise" messages, but the main
> part was that I would have "%llu printk messages dropped" markers in
> the logs; which was much more important to me.

I would agree with the proposed solution from 2016. My experience is
that the dropped messages are very important. Yes, printing them could
lead to the loss of even more messages. But still, it is important
information that needs to get out.

John Ogness

[0] https://lkml.kernel.org/r/20161224140902.1962-3-sergey.senozhatsky@gmail.com
