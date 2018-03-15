Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932570AbeCOTBK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:01:10 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:58177 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752380AbeCOTBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:01:08 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Waiman Long <longman@redhat.com>
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
Date: Thu, 15 Mar 2018 14:00:16 -0500
In-Reply-To: <047c6ed6-6581-b543-ba3d-cadc543d3d25@redhat.com> (Waiman Long's
        message of "Thu, 15 Mar 2018 13:02:12 -0400")
Message-ID: <87h8ph6u67.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ewY7c-0007cj-Ps;;;mid=<87h8ph6u67.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+NGUff25esHeW3IFQ1x0KVZs1TuZzapj0=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 T_XMDrugObfuBody_14 obfuscated drug references
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Waiman Long <longman@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 712 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.9 (0.4%), b_tie_ro: 1.94 (0.3%), parse: 1.13 (0.2%),
        extract_message_metadata: 16 (2.2%), get_uri_detail_list: 7 (0.9%),
        tests_pri_-1000: 6 (0.8%), tests_pri_-950: 1.18 (0.2%), tests_pri_-900: 1.01
        (0.1%), tests_pri_-400: 51 (7.2%), check_bayes: 50 (7.1%), b_tokenize: 22
        (3.1%), b_tok_get_all: 16 (2.2%), b_comp_prob: 4.3 (0.6%), b_tok_touch_all: 5
        (0.8%), b_finish: 0.68 (0.1%), tests_pri_0: 626 (87.9%),
        check_dkim_signature: 0.66 (0.1%), check_dkim_adsp: 2.7 (0.4%),
        tests_pri_500: 3.7 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH] ipc: Remove IPCMNI
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiman Long <longman@redhat.com> writes:

> On 03/14/2018 08:49 PM, Eric W. Biederman wrote:
>> The define IPCMNI was originally the size of a statically sized array in
>> the kernel and that has long since been removed.  Therefore there is no
>> fundamental reason for IPCMNI.
>>
>> The only remaining use IPCMNI serves is as a convoluted way to format
>> the ipc id to userspace.  It does not appear that anything except for
>> the CHECKPOINT_RESTORE code even cares about this variety of assignment
>> and the CHECKPOINT_RESTORE code only cares about this weirdness because
>> it has to restore these peculiar ids.
>>
>> Therefore make the assignment of ipc ids match the description in
>> Advanced Programming in the Unix Environment and assign the next id
>> until INT_MAX is hit then loop around to the lower ids.
>>
>> This can be implemented trivially with the current code using idr_alloc_cyclic.
>>
>> To make it possible to keep checkpoint/restore working I have renamed
>> the sysctls from xxx_next_id to xxx_nextid.  That is enough change that
>> a smart CRIU implementation can see that what is exported has changed,
>> and act accordingly.  New kernels will be able to restore the old id's.
>>
>> This code still needs some real world testing to verify my assumptions.
>> And some work with the CRIU implementations to actually add the code
>> that deals with the new for of id assignment.
>>
>> Updates: 03f595668017 ("ipc: add sysctl to specify desired next object id")
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>
>> Waiman please take a look at this and run it through some tests etc,
>> I am pretty certain something like this patch is all you need to do
>> to sort out ipc assignment.  Not messing with sysctls needed.
>>
>>  include/linux/ipc.h           |  2 --
>>  include/linux/ipc_namespace.h |  1 -
>>  ipc/ipc_sysctl.c              |  6 ++--
>>  ipc/namespace.c               | 11 ++----
>>  ipc/util.c                    | 80 ++++++++++---------------------------------
>>  ipc/util.h                    | 11 +-----
>>  6 files changed, 25 insertions(+), 86 deletions(-)
>>
>> diff --git a/include/linux/ipc.h b/include/linux/ipc.h
>> index 821b2f260992..6cc2df7f7ac9 100644
>> --- a/include/linux/ipc.h
>> +++ b/include/linux/ipc.h
>> @@ -8,8 +8,6 @@
>>  #include <uapi/linux/ipc.h>
>>  #include <linux/refcount.h>
>>  
>> -#define IPCMNI 32768  /* <= MAX_INT limit for ipc arrays (including sysctl changes) */
>> -
>>  /* used by in-kernel data structures */
>>  struct kern_ipc_perm {
>>  	spinlock_t	lock;
>> diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
>> index b5630c8eb2f3..cab33b6a8236 100644
>> --- a/include/linux/ipc_namespace.h
>> +++ b/include/linux/ipc_namespace.h
>> @@ -15,7 +15,6 @@ struct user_namespace;
>>  
>>  struct ipc_ids {
>>  	int in_use;
>> -	unsigned short seq;
>>  	bool tables_initialized;
>>  	struct rw_semaphore rwsem;
>>  	struct idr ipcs_idr;
>> diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
>> index 8ad93c29f511..a599963d58bf 100644
>> --- a/ipc/ipc_sysctl.c
>> +++ b/ipc/ipc_sysctl.c
>> @@ -176,7 +176,7 @@ static struct ctl_table ipc_kern_table[] = {
>>  	},
>>  #ifdef CONFIG_CHECKPOINT_RESTORE
>>  	{
>> -		.procname	= "sem_next_id",
>> +		.procname	= "sem_nextid",
>>  		.data		= &init_ipc_ns.ids[IPC_SEM_IDS].next_id,
>>  		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SEM_IDS].next_id),
>>  		.mode		= 0644,
>> @@ -185,7 +185,7 @@ static struct ctl_table ipc_kern_table[] = {
>>  		.extra2		= &int_max,
>>  	},
>>  	{
>> -		.procname	= "msg_next_id",
>> +		.procname	= "msg_nextid",
>>  		.data		= &init_ipc_ns.ids[IPC_MSG_IDS].next_id,
>>  		.maxlen		= sizeof(init_ipc_ns.ids[IPC_MSG_IDS].next_id),
>>  		.mode		= 0644,
>> @@ -194,7 +194,7 @@ static struct ctl_table ipc_kern_table[] = {
>>  		.extra2		= &int_max,
>>  	},
>>  	{
>> -		.procname	= "shm_next_id",
>> +		.procname	= "shm_nextid",
>>  		.data		= &init_ipc_ns.ids[IPC_SHM_IDS].next_id,
>>  		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SHM_IDS].next_id),
>>  		.mode		= 0644,
>
> So you are changing the names of existing sysctl parameters. Will it be
> better to add new sysctl to indicate that the rule has changed
> instead?

In practice I am replacing one set of sysctls with another, that work
very similarly but not quite the same.  As we can't keep the existing
semantics removing the old sysctl seems correct.  Likewise adding
a new sysctl with slightly changed semantics seems correct.

This needs an accompanying patch to CRIU to see which sysctls are
available and to change it's behavior based upon that.  The practical
question is what makes it easiest not to confuse CRIU.

Not having the sysctl should be something that CRIU detects today
and the old versions should fail gracefully.  But testing is needed.
Adding a new sysctl to say the behavior has changed and reusing the
old names won't have the same effect of disabling existing versions
of CRIU.

>> diff --git a/ipc/util.c b/ipc/util.c
>> index 4ed5a17dd06f..ce6bf18e54df 100644
>> --- a/ipc/util.c
>> +++ b/ipc/util.c
>> @@ -118,7 +118,6 @@ int ipc_init_ids(struct ipc_ids *ids)
>>  {
>>  	int err;
>>  	ids->in_use = 0;
>> -	ids->seq = 0;
>>  	init_rwsem(&ids->rwsem);
>>  	err = rhashtable_init(&ids->key_ht, &ipc_kht_params);
>>  	if (err)
>> @@ -192,46 +191,18 @@ static struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key)
>>  	return NULL;
>>  }
>>  
>> -#ifdef CONFIG_CHECKPOINT_RESTORE
>> -/*
>> - * Specify desired id for next allocated IPC object.
>> - */
>> -#define ipc_idr_alloc(ids, new)						\
>> -	idr_alloc(&(ids)->ipcs_idr, (new),				\
>> -		  (ids)->next_id < 0 ? 0 : ipcid_to_idx((ids)->next_id),\
>> -		  0, GFP_NOWAIT)
>>  
>> -static inline int ipc_buildid(int id, struct ipc_ids *ids,
>> -			      struct kern_ipc_perm *new)
>> +static int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
>>  {
>> -	if (ids->next_id < 0) { /* default, behave as !CHECKPOINT_RESTORE */
>> -		new->seq = ids->seq++;
>> -		if (ids->seq > IPCID_SEQ_MAX)
>> -			ids->seq = 0;
>> -	} else {
>> -		new->seq = ipcid_to_seqx(ids->next_id);
>> +#ifdef CONFIG_CHECKPOINT_RESTORE
>> +	if (ids->next_id >= 0) {
>> +		idr_set_cursor(&ids->ipcs_idr, ids->next_id);
>>  		ids->next_id = -1;
>>  	}
>> -
>> -	return SEQ_MULTIPLIER * new->seq + id;
>> -}
>> -
>> -#else
>> -#define ipc_idr_alloc(ids, new)					\
>> -	idr_alloc(&(ids)->ipcs_idr, (new), 0, 0, GFP_NOWAIT)
>> -
>> -static inline int ipc_buildid(int id, struct ipc_ids *ids,
>> -			      struct kern_ipc_perm *new)
>> -{
>> -	new->seq = ids->seq++;
>> -	if (ids->seq > IPCID_SEQ_MAX)
>> -		ids->seq = 0;
>> -
>> -	return SEQ_MULTIPLIER * new->seq + id;
>> +#endif
>> +	return idr_alloc_cyclic(&ids->ipcs_idr, (new), 0, 0, GFP_NOWAIT);
>>  }
>>  
>> -#endif /* CONFIG_CHECKPOINT_RESTORE */
>> -
>>  /**
>>   * ipc_addid - add an ipc identifier
>>   * @ids: ipc identifier set
>> @@ -251,9 +222,6 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
>>  	kgid_t egid;
>>  	int id, err;
>>  
>> -	if (limit > IPCMNI)
>> -		limit = IPCMNI;
>> -
>>  	if (!ids->tables_initialized || ids->in_use >= limit)
>>  		return -ENOSPC;
>>  
>> @@ -290,7 +258,7 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
>>  	if (id > ids->max_id)
>>  		ids->max_id = id;
>>  
>> -	new->id = ipc_buildid(id, ids, new);
>> +	new->id = id;
>>  
>>  	return id;
>>  }
>> @@ -430,7 +398,7 @@ static void ipc_kht_remove(struct ipc_ids *ids, struct kern_ipc_perm *ipcp)
>>   */
>>  void ipc_rmid(struct ipc_ids *ids, struct kern_ipc_perm *ipcp)
>>  {
>> -	int lid = ipcid_to_idx(ipcp->id);
>> +	int lid = ipcp->id;
>>  
>>  	idr_remove(&ids->ipcs_idr, lid);
>>  	ipc_kht_remove(ids, ipcp);
>> @@ -563,7 +531,7 @@ void ipc64_perm_to_ipc_perm(struct ipc64_perm *in, struct ipc_perm *out)
>>  struct kern_ipc_perm *ipc_obtain_object_idr(struct ipc_ids *ids, int id)
>>  {
>>  	struct kern_ipc_perm *out;
>> -	int lid = ipcid_to_idx(id);
>> +	int lid = id;
>>  
>>  	if (unlikely(!ids->tables_initialized))
>>  		return ERR_PTR(-EINVAL);
>> @@ -757,30 +725,20 @@ static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
>>  					      loff_t *new_pos)
>>  {
>>  	struct kern_ipc_perm *ipc;
>> -	int total, id;
>> -
>> -	total = 0;
>> -	for (id = 0; id < pos && total < ids->in_use; id++) {
>> -		ipc = idr_find(&ids->ipcs_idr, id);
>> -		if (ipc != NULL)
>> -			total++;
>> -	}
>> +	int id;
>
> I think you need to initialize id to pos. Right?
>
Yes.

I have not done more than compiled tested this.  It would probably
be wise to move this bit to a prepatch.  That just changes the
implementation to something more efficient, and removes a use
of IPCMNI at the same time.
>>  
>> -	if (total >= ids->in_use)
>> +	/* Out of range - return NULL to terminate iteration */
>> +	if (pos > INT_MAX)
>>  		return NULL;
>>  
>> -	for (; pos < IPCMNI; pos++) {
>> -		ipc = idr_find(&ids->ipcs_idr, pos);
>> -		if (ipc != NULL) {
>> -			*new_pos = pos + 1;
>> -			rcu_read_lock();
>> -			ipc_lock_object(ipc);
>> -			return ipc;
>> -		}
>> -	}
>> +	ipc = idr_get_next(&ids->ipcs_idr, &id);
>> +	if (!ipc)
>> +		return NULL;
>>  
>> -	/* Out of range - return NULL to terminate iteration */
>> -	return NULL;
>> +	*new_pos = id + 1;
>> +	rcu_read_lock();
>> +	ipc_lock_object(ipc);
>> +	return ipc;
>>  }
>>  
>>  static void *sysvipc_proc_next(struct seq_file *s, void *it, loff_t *pos)
>> diff --git a/ipc/util.h b/ipc/util.h
>> index 89b8ec176fc4..de8e27367f0c 100644
>> --- a/ipc/util.h
>> +++ b/ipc/util.h
>> @@ -15,8 +15,6 @@
>>  #include <linux/err.h>
>>  #include <linux/ipc_namespace.h>
>>  
>> -#define SEQ_MULTIPLIER	(IPCMNI)
>> -
>>  int sem_init(void);
>>  int msg_init(void);
>>  void shm_init(void);
>> @@ -93,10 +91,6 @@ void __init ipc_init_proc_interface(const char *path, const char *header,
>>  #define IPC_MSG_IDS	1
>>  #define IPC_SHM_IDS	2
>>  
>> -#define ipcid_to_idx(id) ((id) % SEQ_MULTIPLIER)
>> -#define ipcid_to_seqx(id) ((id) / SEQ_MULTIPLIER)
>> -#define IPCID_SEQ_MAX min_t(int, INT_MAX/SEQ_MULTIPLIER, USHRT_MAX)
>> -
>>  /* must be called with ids->rwsem acquired for writing */
>>  int ipc_addid(struct ipc_ids *, struct kern_ipc_perm *, int);
>>  
>> @@ -120,9 +114,6 @@ static inline int ipc_get_maxid(struct ipc_ids *ids)
>>  	if (ids->in_use == 0)
>>  		return -1;
>>  
>> -	if (ids->in_use == IPCMNI)
>> -		return IPCMNI - 1;
>> -
>>  	return ids->max_id;
>>  }
>>  
>> @@ -163,7 +154,7 @@ extern int store_msg(void __user *dest, struct msg_msg *msg, size_t len);
>>  
>>  static inline int ipc_checkid(struct kern_ipc_perm *ipcp, int uid)
>>  {
>> -	return uid / SEQ_MULTIPLIER != ipcp->seq;
>> +	return uid != ipcp->seq;
>>  }
>>  
>>  static inline void ipc_lock_object(struct kern_ipc_perm *perm)
>
> I don't know the history why the id management of SysV IPC was designed
> in such a convoluted way, but the patch does make sense to me.

I don't have the full history and we might wind up finding more as we
run this patch through it's paces.

The earliest history I know is what I read in Advanced Programming in
the Unix Environment (which predates linux).  It described the ipc ids
as assigned from a counter that wraps.  I thought like my patch
implements. On closer reading it has a counter that increases each time
the slot is used, and then wraps.  Exactly like Linux before my patch.
*Grrr*

The existing structure of the bifurcated is present in Linux 1.0.  At
that time SHMMNI was 256.  SHMMNI was the size of a static array of shm
segments.  The high 24 bits held a sequence number that was incremented
when a segment was removed at the time.  Presumably the upper bits were
incremented to avoid swiftly reusing the same shm ids.

Hmm.  I took a quick look at FreeBSD10 and it has the exact same split
in the id.  So userspace may actually depend upon that split.

Which comes down to the fundamental question what depends upon what.
How do other operating systems like Solaris handle this?

Does any nix flavor support more that 16bits worth of shm segments?

The API has been deprecated for the last 20 years and we are still
keeping it alive.  Sigh.

Still there is fundamentally only one thing the kernel can do if we wish
to increase the number of shm segments.

Please take my patch and test it out and see if you can find anything
that cares about the change. Except for needing id reuse to be
infrequent I can not imagine that there is anything that cares.

It could very reasonably be argued that my when shmmni is < INT_MAX
my patch implements a version of the existing algorithm.  As we go
through all of the possible ids before we reuse any of them.

Eric
