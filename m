Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752462AbeCTCxS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 22:53:18 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44945 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751512AbeCTCmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 22:42:42 -0400
X-ME-Sender: <xms:IXWwWuCpor4U93lyHjBUHO0zUeT9_jSL6t_eff9ZB2e_BrlUM5CrfQ>
Subject: Re: [PATCH] autofs4: Use wait_event_killable
To: David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>
References: <20180319191609.23880-1-willy@infradead.org>
 <alpine.DEB.2.20.1803191218210.114201@chino.kir.corp.google.com>
From: Ian Kent <raven@themaw.net>
Message-ID: <daecdffe-b768-9c69-8609-b899ddde720c@themaw.net>
Date: Tue, 20 Mar 2018 10:42:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1803191218210.114201@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/18 03:25, David Rientjes wrote:
> On Mon, 19 Mar 2018, Matthew Wilcox wrote:
> 
>> diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
>> index a0c57c37fa21..c160e9b3aa0f 100644
>> --- a/fs/autofs4/waitq.c
>> +++ b/fs/autofs4/waitq.c
>> @@ -19,9 +19,6 @@
>>   */
>>  static autofs_wqt_t autofs4_next_wait_queue = 1;
>>  
>> -/* These are the signals we allow interrupting a pending mount */
>> -#define SHUTDOWN_SIGS	(sigmask(SIGKILL) | sigmask(SIGINT) | sigmask(SIGQUIT))
>> -
>>  void autofs4_catatonic_mode(struct autofs_sb_info *sbi)
>>  {
>>  	struct autofs_wait_queue *wq, *nwq;
>> @@ -486,29 +483,7 @@ int autofs4_wait(struct autofs_sb_info *sbi,
>>  	 * wq->name.name is NULL iff the lock is already released
>>  	 * or the mount has been made catatonic.
>>  	 */
>> -	if (wq->name.name) {
>> -		/* Block all but "shutdown" signals while waiting */
>> -		unsigned long shutdown_sigs_mask;
>> -		unsigned long irqflags;
>> -		sigset_t oldset;
>> -
>> -		spin_lock_irqsave(&current->sighand->siglock, irqflags);
>> -		oldset = current->blocked;
>> -		shutdown_sigs_mask = SHUTDOWN_SIGS & ~oldset.sig[0];
>> -		siginitsetinv(&current->blocked, shutdown_sigs_mask);
>> -		recalc_sigpending();
>> -		spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
>> -
>> -		wait_event_interruptible(wq->queue, wq->name.name == NULL);
>> -
>> -		spin_lock_irqsave(&current->sighand->siglock, irqflags);
>> -		current->blocked = oldset;
>> -		recalc_sigpending();
>> -		spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
>> -	} else {
>> -		pr_debug("skipped sleeping\n");
>> -	}
>> -
>> +	wait_event_killable(wq->queue, wq->name.name == NULL);
>>  	status = wq->status;
>>  
>>  	/*
> 
> I understand converting the wait_event_interruptible() to 
> wait_event_killable(), but why was the above wait_event_interruptible() 
> only called when wq->name.name != NULL?  

The code pre-dates my involvement in autofs too.

I always thought it was because wq->name.name can become NULL before
the wait is reached. Such as if the user space daemon manages to invoke
autofs4_wait_release() before the wait call.

And if the autofs mount is made catatonic before the wait is reached
wq->name.name will be set to NULL and wake up called for each waiter
so that doesn't seem to require the if conditional either.

Both of these cases to fit with what Matthew has already said and I
can't think of any others.

There may have been other reasons at some point, a lot has changed
over (a long) time.

Ian
