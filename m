Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbeCOVqZ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 17:46:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751466AbeCOVqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 17:46:24 -0400
Subject: Re: [RFC][PATCH] ipc: Remove IPCMNI
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Stanislav Kinsbursky <skinsbursky@parallels.com>,
        Linux Containers <containers@lists.linux-foundation.org>
References: <1520885744-1546-1-git-send-email-longman@redhat.com>
 <1520885744-1546-5-git-send-email-longman@redhat.com>
 <87woyfyh57.fsf@xmission.com>
 <5d4a858a-3136-5ef4-76fe-a61e7f2aed56@redhat.com>
 <87o9jru3bf.fsf@xmission.com>
 <935a7c50-50cc-2dc0-33bb-92c000d039bc@redhat.com>
 <87woyego2u.fsf_-_@xmission.com>
 <047c6ed6-6581-b543-ba3d-cadc543d3d25@redhat.com>
 <87h8ph6u67.fsf@xmission.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <7d3a1f93-f8e5-5325-f9a7-0079f7777b6f@redhat.com>
Date: Thu, 15 Mar 2018 17:46:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <87h8ph6u67.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15/2018 03:00 PM, Eric W. Biederman wrote:
> Waiman Long <longman@redhat.com> writes:
>
>> On 03/14/2018 08:49 PM, Eric W. Biederman wrote:
>>> The define IPCMNI was originally the size of a statically sized array in
>>> the kernel and that has long since been removed.  Therefore there is no
>>> fundamental reason for IPCMNI.
>>>
>>> The only remaining use IPCMNI serves is as a convoluted way to format
>>> the ipc id to userspace.  It does not appear that anything except for
>>> the CHECKPOINT_RESTORE code even cares about this variety of assignment
>>> and the CHECKPOINT_RESTORE code only cares about this weirdness because
>>> it has to restore these peculiar ids.
>>>
>>> Therefore make the assignment of ipc ids match the description in
>>> Advanced Programming in the Unix Environment and assign the next id
>>> until INT_MAX is hit then loop around to the lower ids.
>>>
>>> This can be implemented trivially with the current code using idr_alloc_cyclic.
>>>
>>> To make it possible to keep checkpoint/restore working I have renamed
>>> the sysctls from xxx_next_id to xxx_nextid.  That is enough change that
>>> a smart CRIU implementation can see that what is exported has changed,
>>> and act accordingly.  New kernels will be able to restore the old id's.
>>>
>>> This code still needs some real world testing to verify my assumptions.
>>> And some work with the CRIU implementations to actually add the code
>>> that deals with the new for of id assignment.
>>>
>>> Updates: 03f595668017 ("ipc: add sysctl to specify desired next object id")
>>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>> ---
>>>
>>> Waiman please take a look at this and run it through some tests etc,
>>> I am pretty certain something like this patch is all you need to do
>>> to sort out ipc assignment.  Not messing with sysctls needed.
>>>
>>>  include/linux/ipc.h           |  2 --
>>>  include/linux/ipc_namespace.h |  1 -
>>>  ipc/ipc_sysctl.c              |  6 ++--
>>>  ipc/namespace.c               | 11 ++----
>>>  ipc/util.c                    | 80 ++++++++++---------------------------------
>>>  ipc/util.h                    | 11 +-----
>>>  6 files changed, 25 insertions(+), 86 deletions(-)
>>>
>>> diff --git a/include/linux/ipc.h b/include/linux/ipc.h
>>> index 821b2f260992..6cc2df7f7ac9 100644
>>> --- a/include/linux/ipc.h
>>> +++ b/include/linux/ipc.h
>>> @@ -8,8 +8,6 @@
>>>  #include <uapi/linux/ipc.h>
>>>  #include <linux/refcount.h>
>>>  
>>> -#define IPCMNI 32768  /* <= MAX_INT limit for ipc arrays (including sysctl changes) */
>>> -
>>>  /* used by in-kernel data structures */
>>>  struct kern_ipc_perm {
>>>  	spinlock_t	lock;
>>> diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
>>> index b5630c8eb2f3..cab33b6a8236 100644
>>> --- a/include/linux/ipc_namespace.h
>>> +++ b/include/linux/ipc_namespace.h
>>> @@ -15,7 +15,6 @@ struct user_namespace;
>>>  
>>>  struct ipc_ids {
>>>  	int in_use;
>>> -	unsigned short seq;
>>>  	bool tables_initialized;
>>>  	struct rw_semaphore rwsem;
>>>  	struct idr ipcs_idr;
>>> diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
>>> index 8ad93c29f511..a599963d58bf 100644
>>> --- a/ipc/ipc_sysctl.c
>>> +++ b/ipc/ipc_sysctl.c
>>> @@ -176,7 +176,7 @@ static struct ctl_table ipc_kern_table[] = {
>>>  	},
>>>  #ifdef CONFIG_CHECKPOINT_RESTORE
>>>  	{
>>> -		.procname	= "sem_next_id",
>>> +		.procname	= "sem_nextid",
>>>  		.data		= &init_ipc_ns.ids[IPC_SEM_IDS].next_id,
>>>  		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SEM_IDS].next_id),
>>>  		.mode		= 0644,
>>> @@ -185,7 +185,7 @@ static struct ctl_table ipc_kern_table[] = {
>>>  		.extra2		= &int_max,
>>>  	},
>>>  	{
>>> -		.procname	= "msg_next_id",
>>> +		.procname	= "msg_nextid",
>>>  		.data		= &init_ipc_ns.ids[IPC_MSG_IDS].next_id,
>>>  		.maxlen		= sizeof(init_ipc_ns.ids[IPC_MSG_IDS].next_id),
>>>  		.mode		= 0644,
>>> @@ -194,7 +194,7 @@ static struct ctl_table ipc_kern_table[] = {
>>>  		.extra2		= &int_max,
>>>  	},
>>>  	{
>>> -		.procname	= "shm_next_id",
>>> +		.procname	= "shm_nextid",
>>>  		.data		= &init_ipc_ns.ids[IPC_SHM_IDS].next_id,
>>>  		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SHM_IDS].next_id),
>>>  		.mode		= 0644,
>> So you are changing the names of existing sysctl parameters. Will it be
>> better to add new sysctl to indicate that the rule has changed
>> instead?
> In practice I am replacing one set of sysctls with another, that work
> very similarly but not quite the same.  As we can't keep the existing
> semantics removing the old sysctl seems correct.  Likewise adding
> a new sysctl with slightly changed semantics seems correct.
>
> This needs an accompanying patch to CRIU to see which sysctls are
> available and to change it's behavior based upon that.  The practical
> question is what makes it easiest not to confuse CRIU.
>
> Not having the sysctl should be something that CRIU detects today
> and the old versions should fail gracefully.  But testing is needed.
> Adding a new sysctl to say the behavior has changed and reusing the
> old names won't have the same effect of disabling existing versions
> of CRIU.

That is fine as long as CRIU is the only user.

>
>> I don't know the history why the id management of SysV IPC was designed
>> in such a convoluted way, but the patch does make sense to me.
> I don't have the full history and we might wind up finding more as we
> run this patch through it's paces.
>
> The earliest history I know is what I read in Advanced Programming in
> the Unix Environment (which predates linux).  It described the ipc ids
> as assigned from a counter that wraps.  I thought like my patch
> implements. On closer reading it has a counter that increases each time
> the slot is used, and then wraps.  Exactly like Linux before my patch.
> *Grrr*
>
> The existing structure of the bifurcated is present in Linux 1.0.  At
> that time SHMMNI was 256.  SHMMNI was the size of a static array of shm
> segments.  The high 24 bits held a sequence number that was incremented
> when a segment was removed at the time.  Presumably the upper bits were
> incremented to avoid swiftly reusing the same shm ids.
>
> Hmm.  I took a quick look at FreeBSD10 and it has the exact same split
> in the id.  So userspace may actually depend upon that split.

Backward compatibility is the part that I am most worry about this
patch. That is also the reason I asked why the ID is generated in such a
way.

My original thinking was to have an extended mode where the IPCMNI
becomes 8M from 32k. That will reduce the sequence number from 16 bits
to 8 bits. The extended mode is enabled by adding, for example, a boot
option. So this will be an opt-in feature instead of as a default.

>
> Which comes down to the fundamental question what depends upon what.
> How do other operating systems like Solaris handle this?

I don't know how Solaris handle this, but I know they support up to 2^24
shm segments.

>
> Does any nix flavor support more that 16bits worth of shm segments?
>
> The API has been deprecated for the last 20 years and we are still
> keeping it alive.  Sigh.
>
> Still there is fundamentally only one thing the kernel can do if we wish
> to increase the number of shm segments.
>
> Please take my patch and test it out and see if you can find anything
> that cares about the change. Except for needing id reuse to be
> infrequent I can not imagine that there is anything that cares.
>
> It could very reasonably be argued that my when shmmni is < INT_MAX
> my patch implements a version of the existing algorithm.  As we go
> through all of the possible ids before we reuse any of them.
>
> Eric
>
Thanks for the patch, I am still thinking about what is the best way to
handle this.

Cheers,
Longman
