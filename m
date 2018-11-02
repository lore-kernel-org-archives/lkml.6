Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB823C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995012081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995012081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeKBWiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:38:52 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:46051 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeKBWiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:38:52 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wA2DVe9X084573;
        Fri, 2 Nov 2018 22:31:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Fri, 02 Nov 2018 22:31:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157065137.bbtec.net [60.157.65.137])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wA2DVYS2084535
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 2 Nov 2018 22:31:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v5] printk: Add line-buffered printk() API.
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1540375870-6235-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181101141342.t65mqwxdpqs3mu5i@pathway.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c1f21a72-6eb3-8e16-06fe-262cb427f100@i-love.sakura.ne.jp>
Date:   Fri, 2 Nov 2018 22:31:35 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181101141342.t65mqwxdpqs3mu5i@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/01 23:13, Petr Mladek wrote:
> On Wed 2018-10-24 19:11:10, Tetsuo Handa wrote:
>> After this patch, we will consider how we can add context identifier to
>> each line of printk() output (so that we can group multiple lines into
>> one block when parsing). Therefore, if converting to this API does not
>> fit for some reason, you might be able to consider converting to multiple
>> printk() calls which end with '\n'.
> 
> The buffered printk API is for continuous lines. It is more
> complicated than a simple printk. You need to get, use, and put
> the buffer. It might be acceptable for continuous lines that
> should be rare and the related calls typically located in a single
> function.
> 
> I prefer to solve the related lines on another level, for example,
> by storing/showing PID+context_mask for each printed line. This
> way it would work transparently even for normal printk().

Yes. I'm expecting that identifier part is added by printk()
rather than by this line buffering API.



>> +	/*
>> +	 * Skip KERN_CONT here based on an assumption that KERN_CONT will be
>> +	 * given via "fmt" argument when KERN_CONT is given.
>> +	 */
>> +	fmt_offset = (printk_get_level(fmt) == 'c') ? 2 : 0;
>> + retry:
>> +	va_copy(tmp_args, args);
>> +	r = vsnprintf(ptr->buf + ptr->used, sizeof(ptr->buf) - ptr->used,
>> +		      fmt + fmt_offset, tmp_args);
>> +	va_end(tmp_args);
>> +	if (r + ptr->used < sizeof(ptr->buf)) {
>> +		ptr->used += r;
>> +		/* Flush already completed lines if any. */
>> +		for (r = ptr->used - 1; r >= 0; r--) {
>> +			if (ptr->buf[r] != '\n')
>> +				continue;
> 
> I thought about using strrchr(). But this is more effective
> because we know the length of the string. It might deserve
> a comment though.

At first, I tried to use memrchr().

>> +			break;
>> +		}
>> +		return r;
> 
> We need to use another variable in the for-cycle. Otherwise, we would
> not return the number of printed characters here.

But since memrchr() is not available, I forgot to introduce another
variable when rewriting this loop...



>> +bool flush_printk_buffer(struct printk_buffer *ptr)
>> +{
>> +	if (!ptr || !ptr->used)
>> +		return false;
>> +	/* vprintk_buffered() keeps 0 <= ptr->used < sizeof(ptr->buf) true. */
>> +	ptr->buf[ptr->used] = '\0';
> 
> We do not need this when there is always the trailing '\0' in
> non-empty buffer. It looks more sane to me.

We need this when called from vprintk_buffered(), for vsnprintf()
has overwritten ptr->buf[ptr->used] with non-'\0' byte.

>> +	printk("%s", ptr->buf);
>> +	ptr->used = 0;
>> +	return true;
>> +}
>> +EXPORT_SYMBOL(flush_printk_buffer);



> We are getting close. Please, split the debugging stuff into separate
> patch.

Too many comments on debugging stuff. I will for now drop debugging stuff
 from next version. We can add debugging stuff after core patch is merged.

> 
> Also it would be great to do add a sample conversion from pr_cont() to
> this API in another separate patch.

OK. I will add two example users in next version.

