Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tQ/fMcUZGVstXwAAmS7hNA
	; Thu, 07 Jun 2018 11:41:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A46DE6089E; Thu,  7 Jun 2018 11:41:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 38DBF60115;
	Thu,  7 Jun 2018 11:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 38DBF60115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753612AbeFGLlX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 07:41:23 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53642 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753103AbeFGLlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 07:41:22 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w57Bf3BA049809;
        Thu, 7 Jun 2018 20:41:03 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Thu, 07 Jun 2018 20:41:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w57BeugH049789
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 7 Jun 2018 20:41:03 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: possible deadlock in console_unlock
To: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, syzkaller-bugs@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <00000000000087008b056df8fbb3@google.com>
 <20180607051019.GA10406@jagdpanzerIV>
 <20180607110034.qrkencwsr4stv6xp@pathway.suse.cz>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <6cc6d5c1-fc01-efab-86b8-eb072607680c@I-love.SAKURA.ne.jp>
Date: Thu, 7 Jun 2018 20:40:54 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607110034.qrkencwsr4stv6xp@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/07 20:00, Petr Mladek wrote:
>> ---
>>
>>  drivers/tty/tty_buffer.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
>> index c996b6859c5e..71958ef6a831 100644
>> --- a/drivers/tty/tty_buffer.c
>> +++ b/drivers/tty/tty_buffer.c
>> @@ -167,7 +167,8 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
>>  	   have queued and recycle that ? */
>>  	if (atomic_read(&port->buf.mem_used) > port->buf.mem_limit)
>>  		return NULL;
>> -	p = kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
>> +	p = kmalloc(sizeof(struct tty_buffer) + 2 * size,
>> +			GFP_ATOMIC | __GFP_NOWARN);
>>  	if (p == NULL)
>>  		return NULL;
>>
>> ---
> 
> This looks like the most simple solution for this particular problem.
> I am just afraid that there are many other locations like this.
> 
I haven't tried the reproducer with that change. But isn't __GFP_NOWARN
ignored by fail_dump() (and thus printk() from fault injection still occurs)?

By the way, this reproducer is tricky. It needs to run like ./a.out
followed by "while :; do fg; done" because it always stops by a signal.
