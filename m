Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C67C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3922420671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="M8zNL+sw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3922420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbeJXEIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:08:17 -0400
Received: from alln-iport-4.cisco.com ([173.37.142.91]:64594 "EHLO
        alln-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeJXEIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=5223; q=dns/txt; s=iport;
  t=1540323806; x=1541533406;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=/0he3lxJbaiajGDYUV0yzKQnMyfyCNLleIITgIeKD3Y=;
  b=M8zNL+swCC7n1AdWrn1snsex3AdiPguJxc1iUjd2I10slANy8jRQ70jP
   P95DbsRMNbHf8pU81/GmbeEODBSI8jBtfmivPdUULs0XRxZ2Ub3sOe0qY
   6X0PXccYcoIGcdppjwY7dmgq7xWHDNt87BnN/e7NoRjWq4/0mta6DXJK0
   8=;
X-IronPort-AV: E=Sophos;i="5.54,417,1534809600"; 
   d="scan'208";a="190479108"
Received: from rcdn-core-12.cisco.com ([173.37.93.148])
  by alln-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 19:43:25 +0000
Received: from [10.154.208.140] ([10.154.208.140])
        by rcdn-core-12.cisco.com (8.15.2/8.15.2) with ESMTP id w9NJhKDh008280;
        Tue, 23 Oct 2018 19:43:20 GMT
Subject: Re: [PATCH v2] kernel/signal: Signal-based pre-coredump notification
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Victor Kamensky (kamensky)" <kamensky@cisco.com>,
        xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>,
        Enke Chen <enkechen@cisco.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
 <20181023092348.GA14340@redhat.com>
From:   Enke Chen <enkechen@cisco.com>
Message-ID: <1e68a3ce-32cd-b058-3d1d-36455ceca848@cisco.com>
Date:   Tue, 23 Oct 2018 12:43:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181023092348.GA14340@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.154.208.140, [10.154.208.140]
X-Outbound-Node: rcdn-core-12.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Oleg:

Thanks for your review. Please see my replies inline.

On 10/23/18 2:23 AM, Oleg Nesterov wrote:
> On 10/22, Enke Chen wrote:
>>
>> As the coredump of a process may take time, in certain time-sensitive
>> applications it is necessary for a parent process (e.g., a process
>> manager) to be notified of a child's imminent death before the coredump
>> so that the parent process can act sooner, such as re-spawning an
>> application process, or initiating a control-plane fail-over.
> 
> Personally I still do not like this feature, but I won't argue.
> 
>> --- a/fs/coredump.c
>> +++ b/fs/coredump.c
>> @@ -546,6 +546,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>>  	struct cred *cred;
>>  	int retval = 0;
>>  	int ispipe;
>> +	bool notify;
>>  	struct files_struct *displaced;
>>  	/* require nonrelative corefile path and be extra careful */
>>  	bool need_suid_safe = false;
>> @@ -590,6 +591,15 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>>  	if (retval < 0)
>>  		goto fail_creds;
>>
>> +	/*
>> +	 * Send the pre-coredump signal to the parent if requested.
>> +	 */
>> +	read_lock(&tasklist_lock);
>> +	notify = do_notify_parent_predump(current);
>> +	read_unlock(&tasklist_lock);
>> +	if (notify)
>> +		cond_resched();
> 
> Hmm. I do not understand why do we need cond_resched(). And even if we need it,
> why we can't call it unconditionally?

Remember the goal is to allow the parent (e.g., a process manager) to take early
action. The "yield" before doing coredump will help.

The yield is made conditional because the notification is conditional.
Is that ok?

> 
> I'd also suggest to move read_lock/unlock(tasklist) into do_notify_parent_predump()
> and remove the "task_struct *tsk" argument, tsk is always current.
> 
> Yes, do_notify_parent() and do_notify_parent_cldstop() are called with tasklist_lock
> held, but there are good reasons for that.

Sure I will make the suggested changes. This function is only called in one place.

> 
> 
>> +static inline int valid_predump_signal(int sig)
>> +{
>> +	return (sig == SIGCHLD) || (sig == SIGUSR1) || (sig == SIGUSR2);
>> +}
> 
> I still do not understand why do we need to restrict predump_signal.
> 
> PR_SET_PREDUMP_SIG can only change the caller's ->predump_signal, so to me
> even PR_SET_PREDUMP_SIG(SIGKILL) is fine.

I will remove it to reduce the code size and give more flexibility to the application.

> 
> And once again, SIGCHLD/SIGUSR do not queue, this means that PR_SET_PREDUMP_SIG
> is pointless if you have 2 or more children.

Hmm, could you point me to the code where SIGCHLD/SIGUSR is treated differently
w.r.t. queuing?  That does not sound right to me.

> 
>> +bool do_notify_parent_predump(struct task_struct *tsk)
>> +{
>> +	struct sighand_struct *sighand;
>> +	struct kernel_siginfo info;
>> +	struct task_struct *parent;
>> +	unsigned long flags;
>> +	pid_t pid;
>> +	int sig;
>> +
>> +	parent = tsk->parent;
>> +	sighand = parent->sighand;
>> +	pid = task_tgid_vnr(tsk);
>> +
>> +	spin_lock_irqsave(&sighand->siglock, flags);
>> +	sig = parent->signal->predump_signal;
>> +	if (!valid_predump_signal(sig)) {
>> +		spin_unlock_irqrestore(&sighand->siglock, flags);
>> +		return false;
>> +	}
> 
> Why do we need to check parent->signal->predump_signal under ->siglock?
> This complicates the code for no reason, afaics.
> 
>> +	clear_siginfo(&info);
>> +	info.si_pid = pid;
>> +	info.si_signo = sig;
>> +	if (sig == SIGCHLD)
>> +		info.si_code = CLD_PREDUMP;
>> +
>> +	__group_send_sig_info(sig, &info, parent);
>> +	__wake_up_parent(tsk, parent);
> 
> Why __wake_up_parent() ?

not needed, and will remove.

> 
> do_notify_parent() does this to wake up the parent sleeping in do_wait(), to
> report the event. But predump_signal has nothing to do with wait().
> 
> Now. This version sends the signal to ->parent, not ->real_parent. OK, but this
> means that real_parent won't be notified if its child is traced.
> > 
>> +	case PR_SET_PREDUMP_SIG:
>> +		if (arg3 || arg4 || arg5)
>> +			return -EINVAL;
>> +
>> +		/* 0 is valid for disabling the feature */
>> +		if (arg2 && !valid_predump_signal((int)arg2))
>> +			return -EINVAL;
>> +		me->signal->predump_signal = (int)arg2;
>> +		break;
> 
> Again, I do not understand why do we need valid_predump_signal(). But even
> if we need it, I don't understand why should we check it twice. IOW, why
> do_notify_parent_predump() can't simply check ->predump_signal != 0?
> 
> Whatever we do, PR_SET_PREDUMP_SIG should validate arg2 anyway. Who else can
> change ->predump_signal  after that?

Ok, will relax.

> 
>> +	case PR_GET_PREDUMP_SIG:
>> +		if (arg3 || arg4 || arg5)
>> +			return -EINVAL;
>> +		error = put_user(me->signal->predump_signal,
>> +				 (int __user *)arg2);
> 
> To me it would be better to simply return ->predump_signal, iow
> 
> 		error = me->signal->predump_signal;
> 		break;
> 
> but I won't insist, this is subjective and cosmetic.

Vast majority of system calls returns 0 or -1. So does PR_GET_PDEATHSIG.
I would like to keep them consistent.

Thanks again.

-- Enke
