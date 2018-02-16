Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758683AbeBPQ4l (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:56:41 -0500
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:42472 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758667AbeBPQ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:56:40 -0500
Subject: Re: [PATCH v2 1/2] jump_label: Explicitly disable jump labels in
 __init code
To: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@suse.de>
References: <cover.1518798288.git.jpoimboe@redhat.com>
 <eccf3cf668635c9b46acd6a4e3f57c05dbd8aa93.1518798288.git.jpoimboe@redhat.com>
From: Jason Baron <jbaron@akamai.com>
Message-ID: <cabcf423-2214-f175-a3fc-a9756eabd247@akamai.com>
Date: Fri, 16 Feb 2018 11:55:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <eccf3cf668635c9b46acd6a4e3f57c05dbd8aa93.1518798288.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802160202
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-16_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802160202
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/16/2018 11:31 AM, Josh Poimboeuf wrote:
> After initmem has been freed, any jump label entries in __init code are
> prevented from being written to by the kernel_text_address() check in
> __jump_label_update().  However, this check is quite broad.  If
> kernel_text_address() were to return false for any other reason, the
> jump label write would fail silently with no warning.
> 
> For jump label entrieds in module init code, entry->code is set to zero
> to indicate that the entry is disabled.  Do the same thing for core
> kernel init code.  This makes the behavior more consistent, and will
> also make it more straightforward to detect non-init jump label write
> failures in the next patch.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  include/linux/jump_label.h |  3 +++
>  init/main.c                |  2 ++
>  kernel/jump_label.c        | 18 ++++++++++++++++--
>  3 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
> index b6a29c126cc4..2168cc6b8b30 100644
> --- a/include/linux/jump_label.h
> +++ b/include/linux/jump_label.h
> @@ -151,6 +151,7 @@ extern struct jump_entry __start___jump_table[];
>  extern struct jump_entry __stop___jump_table[];
>  
>  extern void jump_label_init(void);
> +extern void jump_label_invalidate_init(void);
>  extern void jump_label_lock(void);
>  extern void jump_label_unlock(void);
>  extern void arch_jump_label_transform(struct jump_entry *entry,
> @@ -198,6 +199,8 @@ static __always_inline void jump_label_init(void)
>  	static_key_initialized = true;
>  }
>  
> +static inline void jump_label_invalidate_init(void) {}
> +
>  static __always_inline bool static_key_false(struct static_key *key)
>  {
>  	if (unlikely(static_key_count(key) > 0))
> diff --git a/init/main.c b/init/main.c
> index a8100b954839..969eaf140ef0 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -89,6 +89,7 @@
>  #include <linux/io.h>
>  #include <linux/cache.h>
>  #include <linux/rodata_test.h>
> +#include <linux/jump_label.h>
>  
>  #include <asm/io.h>
>  #include <asm/bugs.h>
> @@ -1000,6 +1001,7 @@ static int __ref kernel_init(void *unused)
>  	/* need to finish all async __init code before freeing the memory */
>  	async_synchronize_full();
>  	ftrace_free_init_mem();
> +	jump_label_invalidate_init();
>  	free_initmem();
>  	mark_readonly();
>  	system_state = SYSTEM_RUNNING;
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index b4517095db6a..96274c6d3511 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -16,6 +16,7 @@
>  #include <linux/jump_label_ratelimit.h>
>  #include <linux/bug.h>
>  #include <linux/cpu.h>
> +#include <asm/sections.h>
>  
>  #ifdef HAVE_JUMP_LABEL
>  
> @@ -633,16 +634,29 @@ static void jump_label_del_module(struct module *mod)
>  	}
>  }
>  
> +/* Disable any jump label entries in __init code */
> +void __init jump_label_invalidate_init(void)
> +{
> +	struct jump_entry *iter_start = __start___jump_table;
> +	struct jump_entry *iter_stop = __stop___jump_table;
> +	struct jump_entry *iter;
> +
> +	for (iter = iter_start; iter < iter_stop; iter++)
> +		if (iter->code >= (unsigned long)_sinittext &&
> +		    iter->code < (unsigned long)_einittext)
> +			iter->code = 0;
> +}

Seems like this wants to use init_kernel_text() but i see its marked
'static', perhaps it can be moved to a header?

Thanks,

-Jason

> +
> +/* Disable any jump label entries in module init code */
>  static void jump_label_invalidate_module_init(struct module *mod)
>  {
>  	struct jump_entry *iter_start = mod->jump_entries;
>  	struct jump_entry *iter_stop = iter_start + mod->num_jump_entries;
>  	struct jump_entry *iter;
>  
> -	for (iter = iter_start; iter < iter_stop; iter++) {
> +	for (iter = iter_start; iter < iter_stop; iter++)
>  		if (within_module_init(iter->code, mod))
>  			iter->code = 0;
> -	}
>  }
>  
>  static int
> 
