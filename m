Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeCHUCH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:02:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750926AbeCHUCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 15:02:05 -0500
Subject: Re: [PATCH v3 6/6] ipc: Clamp semmni to the real IPCMNI limit
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
References: <1519926220-7453-1-git-send-email-longman@redhat.com>
 <1519926220-7453-7-git-send-email-longman@redhat.com>
 <20180308181529.GG4449@wotan.suse.de>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <a5167232-3450-d180-4f34-80993f307f4f@redhat.com>
Date: Thu, 8 Mar 2018 15:02:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180308181529.GG4449@wotan.suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2018 01:15 PM, Luis R. Rodriguez wrote:
> On Thu, Mar 01, 2018 at 12:43:40PM -0500, Waiman Long wrote:
>> This patch clamps the semmni value (fourth element of sem_ctls[]
>> array) to within the [0, IPCMNI] range and prints a warning message
>> once when an out-of-range value is being written.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  ipc/ipc_sysctl.c | 13 ++++++++++++-
>>  ipc/sem.c        | 28 ++++++++++++++++++++++++++++
>>  ipc/util.h       |  4 ++++
>>  3 files changed, 44 insertions(+), 1 deletion(-)
>>
>> diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
>> index 8eb7268..2c03f57 100644
>> --- a/ipc/ipc_sysctl.c
>> +++ b/ipc/ipc_sysctl.c
>> @@ -97,12 +97,22 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
>>  	return proc_dointvec_minmax(&ipc_table, write, buffer, lenp, ppos);
>>  }
>>  
>> +static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
>> +	void __user *buffer, size_t *lenp, loff_t *ppos)
>> +{
>> +	int ret = proc_ipc_dointvec(table, write, buffer, lenp, ppos);
>> +
>> +	sem_check_semmni(table, current->nsproxy->ipc_ns);
>> +	return ret;
>> +}
>> +
>>  #else
>>  #define proc_ipc_doulongvec_minmax NULL
>>  #define proc_ipc_dointvec	   NULL
>>  #define proc_ipc_dointvec_minmax   NULL
>>  #define proc_ipc_dointvec_minmax_orphans   NULL
>>  #define proc_ipc_auto_msgmni	   NULL
>> +#define proc_ipc_sem_dointvec	   NULL
>>  #endif
>>  
>>  static int zero;
>> @@ -186,7 +196,8 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
>>  		.data		= &init_ipc_ns.sem_ctls,
>>  		.maxlen		= 4*sizeof(int),
>>  		.mode		= 0644,
>> -		.proc_handler	= proc_ipc_dointvec,
>> +		.proc_handler	= proc_ipc_sem_dointvec,
>> +		.flags		= CTL_FLAGS_CLAMP_RANGE,
>>  	},
>>  #ifdef CONFIG_CHECKPOINT_RESTORE
>>  	{
>> diff --git a/ipc/sem.c b/ipc/sem.c
>> index a4af049..739dfca 100644
>> --- a/ipc/sem.c
>> +++ b/ipc/sem.c
>> @@ -2337,3 +2337,31 @@ static int sysvipc_sem_proc_show(struct seq_file *s, void *it)
>>  	return 0;
>>  }
>>  #endif
>> +
>> +#ifdef CONFIG_PROC_SYSCTL
>> +/*
>> + * Check to see if semmni is out of range and clamp it if necessary.
>> + */
>> +void sem_check_semmni(struct ctl_table *table, struct ipc_namespace *ns)
>> +{
>> +	bool clamped = false;
>> +
>> +	if (!(table->flags & CTL_FLAGS_CLAMP_RANGE))
>> +		return;
>> +
>> +	/*
>> +	 * Clamp semmni to the range [0, IPCMNI].
>> +	 */
>> +	if (ns->sc_semmni < 0) {
>> +		ns->sc_semmni = 0;
>> +		clamped = true;
>> +	}
>> +	if (ns->sc_semmni > IPCMNI) {
>> +		ns->sc_semmni = IPCMNI;
>> +		clamped = true;
>> +	}
>> +	if (clamped)
>> +		pr_warn_once("Kernel parameter \"sem[3]\" was set out of range [%d, %d], clamped to %d.\n",
>> +			     0, IPCMNI, ns->sc_semmni);
> Why are the users issuing a warning, wouldn't the API do the warning
> on its own, specially since we're adding a warn flag?
>
>   Luis

This is a special case as the semmni parameter is actually embedded in
the sem sysctl paramter as the last argument of the 4. So the previous
sysctl patches won't have any effect on this one. I did this patch to
make all the IPC *mni parameters have the same behavior for consistency
purpose.

Cheers,
Longman
