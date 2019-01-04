Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E904C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F59A20874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfADKXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 05:23:40 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:55256 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfADKXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 05:23:39 -0500
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x04ANDj1066335;
        Fri, 4 Jan 2019 19:23:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Fri, 04 Jan 2019 19:23:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x04ANDCq066328
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 4 Jan 2019 19:23:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] tty/n_hdlc: fix sleep in !TASK_RUNNING state warning
To:     Paul Fulghum <paulkf@microgate.com>
Cc:     Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
References: <000000000000449587057e1e6f8b@google.com>
 <49b3b189-a51f-6a97-0e1f-bc3f2c305299@I-love.SAKURA.ne.jp>
 <FEBFE826-8D27-4A0B-86A5-BA559921CADC@microgate.com>
 <cf9b7323-da1c-20cd-4d50-1080fbe52467@i-love.sakura.ne.jp>
 <ba6de468-d36d-cd33-9a13-520102b676c6@suse.cz>
 <98eec651-d1ab-48e5-309b-7e748981cfdd@i-love.sakura.ne.jp>
 <434841F9-C2DF-4D73-9AFB-3BFADF325086@microgate.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <0a70193b-488a-7607-4ad5-05ec6018587e@i-love.sakura.ne.jp>
Date:   Fri, 4 Jan 2019 19:23:14 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <434841F9-C2DF-4D73-9AFB-3BFADF325086@microgate.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/04 0:57, Paul Fulghum wrote:
>> On Jan 3, 2019, at 3:32 AM, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> On 2019/01/03 18:09, Jiri Slaby wrote:
>>> On 02. 01. 19, 16:04, Tetsuo Handa wrote:
>>>> +	if (wait_event_interruptible(tty->read_wait,
>>>> +	     (ret = -EIO, test_bit(TTY_OTHER_CLOSED, &tty->flags)) ||
>>>> +	     (ret = 0, tty_hung_up_p(file)) ||
>>>> +	     (rbuf = n_hdlc_buf_get(&n_hdlc->rx_buf_list)) != NULL ||
>>>> +	     (ret = -EAGAIN, tty_io_nonblock(tty, file))))
>>>> +		return -EINTR;
>>>
>>> Oh, that looks really ugly. Could you move all this to a function
>>> returning a bool and taking &ret and &rbuf as parameters?
>>>
>>
>> OK. Something like this?
> 
> 
> I agree with Jiri that placing all the conditional logic in a single expression is difficult to read.
> 
> But exchanging that many locals with a separate function defeats the original purpose of
> simplifying code and this implementation changes the logic (write no
> longer checks for line discipline changing under it during wait).

Not only defeating the original purpose but also increasing object size.

> 
> Converting to wait_event_interruptible where possible is a good goal but this instance
> may be better left alone. The current structure mirrors the existing n_tty line discipline.

But why not to clarify what are appropriate sanity checks?

Currently, read side does not check "n_hdlc->magic != HDLC_MAGIC" case
while write side does. If it is intended for catching memory corruption
etc. then both sides should do the same thing.

Currently, write side does not check "tty != n_hdlc->tty" case before
schedule() while does after schedule(). If "tty != n_hdlc->tty" case
can ever happen, what prevents n_hdlc_tty_write() from being called again
after n_hdlc_tty_write() once returned with -EIO due to "tty != n_hdlc->tty"
case? If it is intended for catching memory corruption etc. then both
sides should check "tty != n_hdlc->tty" case.

Current logic is unclear, in addition to want a cleanup for scripts/checkpatch.pl .

  total: 158 errors, 95 warnings, 994 lines checked

