Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08689C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A4920834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="OEV408cX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A4920834
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbeK3LfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 06:35:12 -0500
Received: from alln-iport-2.cisco.com ([173.37.142.89]:8369 "EHLO
        alln-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeK3LfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 06:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=8040; q=dns/txt; s=iport;
  t=1543537667; x=1544747267;
  h=from:subject:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=zAUoc1alI1jElF1lNzEfqKrkXoeuFhr63ENrhZqGeF4=;
  b=OEV408cXjAo7JMFCCvQxfR09Vh8sUUsMiQQ1r39kAJvrxXDSsfINOFGn
   MVZIWGgfhl4uv45EJ8RUzD9TO4zJcFS+L3JY3DpqF96Av0D9osph0P7qG
   JcVlL4J7OeDZ+s0gnQ+EMDL9hprdyNigWey/25xbGVQzIMoW0Y3ec5QCZ
   M=;
X-IronPort-AV: E=Sophos;i="5.56,296,1539648000"; 
   d="scan'208";a="206380669"
Received: from alln-core-8.cisco.com ([173.36.13.141])
  by alln-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 00:27:47 +0000
Received: from [10.156.165.82] ([10.156.165.82])
        by alln-core-8.cisco.com (8.15.2/8.15.2) with ESMTP id wAU0RjIE000767;
        Fri, 30 Nov 2018 00:27:45 GMT
From:   Enke Chen <enkechen@cisco.com>
Subject: Re: [PATCH v5 1/2] kernel/signal: Signal-based pre-coredump
 notification
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Victor Kamensky (kamensky)" <kamensky@cisco.com>,
        "xe-linux-external@cisco.com" <xe-linux-external@cisco.com>,
        Stefan Strogin <sstrogin@cisco.com>,
        Enke Chen <enkechen@cisco.com>
References: <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
 <7741efa7-a3f8-62a1-ba52-613883164643@cisco.com>
 <84460a77-a111-404e-4bad-88104a6e246e@cisco.com>
 <20181026082812.GA10581@redhat.com>
 <21f678a8-4001-df36-c26e-e96cf203b1b1@cisco.com>
 <20181029111804.GA24820@redhat.com>
 <0c197608-3b7e-ffd1-8943-801a60beb917@cisco.com>
 <80e96710-f424-9b39-72ee-9cc7cbe7a5f7@cisco.com>
 <20181128151911.GN3505@e103592.cambridge.arm.com>
 <ad461da7-f0a6-7912-3201-e440dc372f89@cisco.com>
 <20181129115520.GO3505@e103592.cambridge.arm.com>
Message-ID: <d57e9aad-0f03-11c8-92cf-c942410ef4a4@cisco.com>
Date:   Thu, 29 Nov 2018 16:27:44 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181129115520.GO3505@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.156.165.82, [10.156.165.82]
X-Outbound-Node: alln-core-8.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dave:

On 11/29/18 3:55 AM, Dave Martin wrote:
>> Indeed, I defined the signal code CLD_PREDUMP for SIGCHLD initially, but it
>> was removed after discussion:
>>
>> v3 --> v4:
>>
>> Addressed review comments from Oleg Nesterov, and Eric W. Biederman,
>> including:
>> o remove the definition CLD_PREDUMP.
>> ---
>>
>> You can look at the discussions in the email thread, in particular several
>> issues pointed out by Eric Biederman, and my reply to Eric.
> 
> Ah, right.
> 
>> There are two models 1:1 (one process manager with one child process), and 1:N
>> (one process manager with many child processes). A legacy signal like SIGCHLD
>> would not work in the 1:N model due to compression/loss of legacy signals. One
>> need to use a RT signal in that case. 
> 
> SIGCHLD can be redirected to an RT signal via clone().  Are you saying
> the signal is still not queued in that case?  I had assumed that things
> like pthreads rely on this working.
> 
> However, one detail I had missed is that only child exits are reported
> via the exit signal set by clone().  Other child status changes are
> seem to be reported via SIGCHLD always.
> 
> Making your supervised processes into clone-children might interact
> badly with pthreads if it uses wait(__WCLONE) internally.  I've not
> looked into that.

As Oleg commented before:

   And once again, SIGCHLD/SIGUSR do not queue, this means that PR_SET_PREDUMP_SIG
   is pointless if you have 2 or more children.
In addition, there is really no need to introduce a new semantics to SIGCHLD.
There are enough signals available for one to be designated in the parent process
for the pre-coredump notification.

> 
>> One more point in my reply:
>>
>> When an application chooses a signal for pre-coredump notification, it is much
>> simpler and robust for the signal to be dedicated for that purpose (in the parent)
>> and not be mixed with other semantics. The "signo + pid" should be sufficient for
>> the parent process in both 1:1 and 1:N models.
> 
> What if the signal queue overflows?  sigqueue() returns EAGAIN, but I
> think that signals queued by the kernel would simply be lost.  This
> probably won't happen in any non-pathological scenario, but the process
> manager may just silently go wrong instead of failing cleanly when/if
> this happens.

As pointed out by Oleg: 

   see the legacy_queue() check. Any signal < SIGRTMIN do not queue. IOW, if SIGCHLD
   is already pending, then next SIGCHLD is simply ignored.

I went though the code and confirm it.

> 
> SIGCHLD + wait() is immune to this problem for other child status
> notifications (albeit with higher overhead).
> 
> Unless I've missed something fundamental, signals simply aren't a
> reliable data transport: if you need 100% reliability, you need to be
> using another mechanism, either in combination with a signal, or by
> itself.

Given the right signo, e.g., a RT signal for both models, or SIGUSR1/SIGUSR2
for 1:1 model, the pre-coredump signal notification is 100% reliable, and
it is the simplest solution.

When there are many child processes for the 1:N model, if needed, there is an
API for enlarging queue limit:

    setrlimit(RLIMIT_SIGPENDING, xxx);

> 
>>>>
>>>> Signed-off-by: Enke Chen <enkechen@cisco.com>
>>>> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
>>>> ---
>>>> v4 -> v5:
>>>> Addressed review comments from Oleg Nesterov:
>>>> o use rcu_read_lock instead.
>>>> o revert back to notify the real_parent.
>>>>
>>>>  fs/coredump.c                | 23 +++++++++++++++++++++++
>>>>  fs/exec.c                    |  3 +++
>>>>  include/linux/sched/signal.h |  3 +++
>>>>  include/uapi/linux/prctl.h   |  4 ++++
>>>>  kernel/sys.c                 | 13 +++++++++++++
>>>>  5 files changed, 46 insertions(+)
>>>>
>>>> diff --git a/fs/coredump.c b/fs/coredump.c
>>>> index e42e17e..740b1bb 100644
>>>> --- a/fs/coredump.c
>>>> +++ b/fs/coredump.c
>>>> @@ -536,6 +536,24 @@ static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
>>>>  	return err;
>>>>  }
>>>>  
>>>> +/*
>>>> + * While do_notify_parent() notifies the parent of a child's death post
>>>> + * its coredump, this function lets the parent (if so desired) know about
>>>> + * the imminent death of a child just prior to its coredump.
>>>> + */
>>>> +static void do_notify_parent_predump(void)
>>>> +{
>>>> +	struct task_struct *parent;
>>>> +	int sig;
>>>> +
>>>> +	rcu_read_lock();
>>>> +	parent = rcu_dereference(current->real_parent);
>>>> +	sig = parent->signal->predump_signal;
>>>> +	if (sig != 0)
>>>> +		do_send_sig_info(sig, SEND_SIG_NOINFO, parent, PIDTYPE_TGID);
>>>
>>> Doesn't this send si_code == SI_USER.  That seems wrong: the receiving
>>> process wouldn't not be able to distinguish a real pre-coredump
>>> notification from a bogus one sent by kill(2) et
>> The receiving process (i.e., the process manager) knows the PID of all
>> its child processes. Thus it can easily tell whether the signal is from
>> a child or not.
> 
> But it can't tell whether the child sent the signal via kill(2) etc., or
> whether the child started dumping core.

Once a signal is chosen and designated for this special purpose, a child
process would not send the signal to its parent via kill(2), right?

> 
> It's cleaner to be able to filter reliably on si_code, especially if the
> process you're supervising isn't fully under your control.  For example,
> even if the supervised process is considered trustworthy, it could still
> be exploited by an attacker (or simply go wrong) in a way that causes
> it do to a bogus kill().
> 
> (If you treat any incoming signal as anything more than a hint, failure
> to check si_code is usually a bug in general.)
> 

There is one signal that the application has designated for this special
purpose. The application should take the appropriate action once the signal
is received from its child.  If it does not, that is a bug in the application
and not in the kernel.

>>>
>>> SEND_SIG_PRIV also looks wrong, because it assumes that the sender is
>>> "the kernel" so there is no si_pid.
>>
>> That is why SEND_SIG_NOINFO is chosen here for carrying the "pid". What
>> matters to the parent process is the "signo + pid" for identifying the
>> child process for the pre-coredump notification.
> 
> I think that si_code should at least be SI_KERNEL, but how that is
> achieved doesn't really matter.
> 

Again, it is the "signo + pid" that matter to the parent process. There is
no need to over-specify.


>>>> diff --git a/kernel/sys.c b/kernel/sys.c
>>>> index 123bd73..39aa3b8 100644
>>>> --- a/kernel/sys.c
>>>> +++ b/kernel/sys.c
>>>> @@ -2476,6 +2476,19 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
>>>>  			return -EINVAL;
>>>>  		error = arch_prctl_spec_ctrl_set(me, arg2, arg3);
>>>>  		break;
>>>> +	case PR_SET_PREDUMP_SIG:
>>>> +		if (arg3 || arg4 || arg5)
>>>
>>> glibc has
>>>
>>> 	int prctl(int option, ...);
>>>
>>> Some prctls() police extra arguments for zeros, but this means that
>>> the userspace caller also has to supply pointless 0 arguments.
>>>
>>> It's debatable which is the preferred approach.  Did you have any
>>> particular rationale for your choice here?
>>>
>>
>> The initial version did not check the values of these unused arguments.
>> But Jann Horn pointed out the new convention is to enforce the 0 values
>> so I followed ...
> 
> Hmmm, I wasn't aware of this convention when I added PR_SVE_SET_VL etc.,
> and there is no clear pattern in sys.c, and nobody commented at the
> time.
> 
> Of course, it works either way.

Here is Jann's comment:

--
New prctl() calls should check that the unused arguments are zero, in
order to make it possible to safely add more flags in the future.
--

I can do it either way, but we do need to decide on a convention going forward.

Thanks.  -- Enke

