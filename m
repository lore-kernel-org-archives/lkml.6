Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A47C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D692089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="LBZaVSW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D692089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbeJPDRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 23:17:19 -0400
Received: from rcdn-iport-4.cisco.com ([173.37.86.75]:44564 "EHLO
        rcdn-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeJPDRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 23:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4072; q=dns/txt; s=iport;
  t=1539631841; x=1540841441;
  h=subject:cc:references:from:to:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=l+kGnYAags5I3VHdWl3Bwj/IMWLNmAJom5a7xbFz8WQ=;
  b=LBZaVSW7TbTaoIfuU7vo/jCkECITn7XcztRt6v+6ov6ZFZIoqeOWJ/gd
   +0cDvRe65Dv/BYxYPH/XYIeaRSOByRBXJfRYA/etRjbUlQ1TJO1ZJZiGx
   OQslEIXcFlrpo2Fsqw6WLlixUREvOimO1nnBItED67VhiG9zdygeP0Gjt
   c=;
X-IronPort-AV: E=Sophos;i="5.54,385,1534809600"; 
   d="scan'208";a="466630773"
Received: from alln-core-4.cisco.com ([173.36.13.137])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 19:26:09 +0000
Received: from [10.154.208.167] ([10.154.208.167])
        by alln-core-4.cisco.com (8.15.2/8.15.2) with ESMTP id w9FJQ1Dk009065;
        Mon, 15 Oct 2018 19:26:03 GMT
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
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
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Victor Kamensky (kamensky)" <kamensky@cisco.com>,
        xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Enke Chen <enkechen@cisco.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <20181015120521.GA10146@redhat.com>
 <20398328-4ee1-96b2-5723-4b7eed55f0a2@cisco.com>
From:   Enke Chen <enkechen@cisco.com>
To:     Oleg Nesterov <oleg@redhat.com>
Message-ID: <079f5939-8a74-9026-8ec9-91af0b827a69@cisco.com>
Date:   Mon, 15 Oct 2018 12:26:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20398328-4ee1-96b2-5723-4b7eed55f0a2@cisco.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.154.208.167, [10.154.208.167]
X-Outbound-Node: alln-core-4.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Olge:

>> probably ->predump_signal should be cleared on exec?

As I replied to Jann, will do.

Thanks. -- Enke

On 10/15/18 12:17 PM, Enke Chen wrote:
> Hi, Oleg:
> 
> I missed some of your comments in my previous reply.
> 
> On 10/15/18 5:05 AM, Oleg Nesterov wrote:
>> On 10/12, Enke Chen wrote:
>>>
>>> For simplicity and consistency, this patch provides an implementation
>>> for signal-based fault notification prior to the coredump of a child
>>> process. A new prctl command, PR_SET_PREDUMP_SIG, is defined that can
>>> be used by an application to express its interest and to specify the
>>> signal (SIGCHLD or SIGUSR1 or SIGUSR2) for such a notification. A new
>>> signal code (si_code), CLD_PREDUMP, is also defined for SIGCHLD.
>>
>> To be honest, I can't say I like this new feature...
>>
>>> --- a/include/linux/sched.h
>>> +++ b/include/linux/sched.h
>>> @@ -696,6 +696,10 @@ struct task_struct {
>>>  	int				exit_signal;
>>>  	/* The signal sent when the parent dies: */
>>>  	int				pdeath_signal;
>>> +
>>> +	/* The signal sent prior to a child's coredump: */
>>> +	int				predump_signal;
>>> +
>>
>> At least, I think predump_signal should live in signal_struct, not
>> task_struct.
>>
>> (pdeath_signal too, but it is too late to change (fix) this awkward API).
>>
>>> +static void do_notify_parent_predump(struct task_struct *tsk)
>>> +{
>>> +	struct sighand_struct *sighand;
>>> +	struct task_struct *parent;
>>> +	struct kernel_siginfo info;
>>> +	unsigned long flags;
>>> +	int sig;
>>> +
>>> +	parent = tsk->real_parent;
>>
>> So, debuggere won't be notified, only real_parent...
>>
>>> +	sig = parent->predump_signal;
>>
>> probably ->predump_signal should be cleared on exec?
> 
> 
> Is this not enough in "copy_process()"?
> 
> @@ -1985,6 +1985,7 @@ static __latent_entropy struct task_struct *copy_process(
>  	p->dirty_paused_when = 0;
>  
>  	p->pdeath_signal = 0;
> +	p->predump_signal = 0;
> 
>>
>>> +	/* Check again with tasklist_lock" locked by the caller */
>>> +	if (!valid_predump_signal(sig))
>>> +		return;
>>
>> I don't understand why we need valid_predump_signal() at all.
> 
> Most of the signals have well-defined semantics, and would not be appropriate
> for this purpose.  That is why it is limited to only SIGCHLD, SIGUSR1, SIGUSR2.
> 
>>
>>>  bool get_signal(struct ksignal *ksig)
>>>  {
>>>  	struct sighand_struct *sighand = current->sighand;
>>> @@ -2497,6 +2535,19 @@ bool get_signal(struct ksignal *ksig)
>>>  		current->flags |= PF_SIGNALED;
>>>  
>>>  		if (sig_kernel_coredump(signr)) {
>>> +			/*
>>> +			 * Notify the parent prior to the coredump if the
>>> +			 * parent is interested in such a notificaiton.
>>> +			 */
>>> +			int p_sig = current->real_parent->predump_signal;
>>> +
>>> +			if (valid_predump_signal(p_sig)) {
>>> +				read_lock(&tasklist_lock);
>>> +				do_notify_parent_predump(current);
>>> +				read_unlock(&tasklist_lock);
>>> +				cond_resched();
>>
>> perhaps this should be called by do_coredump() after coredump_wait() kills
>> all the sub-threads?
> 
> proc_coredump_connector(current) is located here, they should stay together.
> 
> Thanks.  -- Enke
> 
>>
>>> +static int prctl_set_predump_signal(struct task_struct *tsk, pid_t pid, int sig)
>>> +{
>>> +	struct task_struct *p;
>>> +	int error;
>>> +
>>> +	/* 0 is valid for disabling the feature */
>>> +	if (sig && !valid_predump_signal(sig))
>>> +		return -EINVAL;
>>> +
>>> +	/* For the current task, the common case */
>>> +	if (pid == 0) {
>>> +		tsk->predump_signal = sig;
>>> +		return 0;
>>> +	}
>>> +
>>> +	error = -ESRCH;
>>> +	rcu_read_lock();
>>> +	p = find_task_by_vpid(pid);
>>> +	if (p) {
>>> +		if (!set_predump_signal_perm(p))
>>> +			error = -EPERM;
>>> +		else {
>>> +			error = 0;
>>> +			p->predump_signal = sig;
>>> +		}
>>> +	}
>>> +	rcu_read_unlock();
>>> +	return error;
>>> +}
>>
>> Why? I mean, why do we really want to support the pid != 0 case?
>>
>> Oleg.
>>
