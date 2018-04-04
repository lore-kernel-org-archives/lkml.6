Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbeDDVQx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 17:16:53 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:47144 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752240AbeDDVQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 17:16:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0T-gSTc._1522876593;
Subject: Re: [PATCH] prctl: Deprecate non PR_SET_MM_MAP operations
To: Cyrill Gorcunov <gorcunov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Michal Hocko <mhocko@kernel.org>
References: <20180404185523.GG15783@uranus.lan>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <ca6a276b-d986-c977-9448-6cfc3ebef0f8@linux.alibaba.com>
Date: Wed, 4 Apr 2018 14:16:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180404185523.GG15783@uranus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/4/18 11:55 AM, Cyrill Gorcunov wrote:
> An ability to manipulate mm_struct fields was introduced in
> sake of CRIU in first place. Later we provide more suitable
> and safe operation PR_SET_MM_MAP where all fields to be modifed
> are passed in one structure which allows us to make more detailed
> verification.
>
> Still old interface remains present for compatibility reason
> though CRIU itself already switched to PR_SET_MM_MAP on its
> own long ago.
>
> Googling didn't reveal some other users of this operation
> so I think it should be safe to remove this interface.
>
> CC: Andrey Vagin <avagin@openvz.org>
> CC: Andrew Morton <akpm@linuxfoundation.org>
> CC: Pavel Emelyanov <xemul@virtuozzo.com>
> CC: Michael Kerrisk <mtk.manpages@gmail.com>
> CC: Yang Shi <yang.shi@linux.alibaba.com>
> CC: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
> ---
>   kernel/sys.c |  146 -----------------------------------------------------------
>   1 file changed, 2 insertions(+), 144 deletions(-)
>
> Index: linux-ml.git/kernel/sys.c
> ===================================================================
> --- linux-ml.git.orig/kernel/sys.c
> +++ linux-ml.git/kernel/sys.c
> @@ -2001,44 +2001,9 @@ static int prctl_set_mm_map(int opt, con
>   }
>   #endif /* CONFIG_CHECKPOINT_RESTORE */
>   
> -static int prctl_set_auxv(struct mm_struct *mm, unsigned long addr,
> -			  unsigned long len)
> -{
> -	/*
> -	 * This doesn't move the auxiliary vector itself since it's pinned to
> -	 * mm_struct, but it permits filling the vector with new values.  It's
> -	 * up to the caller to provide sane values here, otherwise userspace
> -	 * tools which use this vector might be unhappy.
> -	 */
> -	unsigned long user_auxv[AT_VECTOR_SIZE];
> -
> -	if (len > sizeof(user_auxv))
> -		return -EINVAL;
> -
> -	if (copy_from_user(user_auxv, (const void __user *)addr, len))
> -		return -EFAULT;
> -
> -	/* Make sure the last entry is always AT_NULL */
> -	user_auxv[AT_VECTOR_SIZE - 2] = 0;
> -	user_auxv[AT_VECTOR_SIZE - 1] = 0;
> -
> -	BUILD_BUG_ON(sizeof(user_auxv) != sizeof(mm->saved_auxv));
> -
> -	task_lock(current);
> -	memcpy(mm->saved_auxv, user_auxv, len);
> -	task_unlock(current);
> -
> -	return 0;
> -}
> -
>   static int prctl_set_mm(int opt, unsigned long addr,
>   			unsigned long arg4, unsigned long arg5)
>   {
> -	struct mm_struct *mm = current->mm;
> -	struct prctl_mm_map prctl_map;
> -	struct vm_area_struct *vma;
> -	int error;
> -
>   	if (arg5 || (arg4 && (opt != PR_SET_MM_AUXV &&

This PR_SET_MM_AUXV should be removed too? There is not callsite to 
prctl_set_auxv() anymore.

Thanks,
Yang

>   			      opt != PR_SET_MM_MAP &&
>   			      opt != PR_SET_MM_MAP_SIZE)))
> @@ -2049,115 +2014,8 @@ static int prctl_set_mm(int opt, unsigne
>   		return prctl_set_mm_map(opt, (const void __user *)addr, arg4);
>   #endif
>   
> -	if (!capable(CAP_SYS_RESOURCE))
> -		return -EPERM;
> -
> -	if (opt == PR_SET_MM_EXE_FILE)
> -		return prctl_set_mm_exe_file(mm, (unsigned int)addr);
> -
> -	if (opt == PR_SET_MM_AUXV)
> -		return prctl_set_auxv(mm, addr, arg4);
> -
> -	if (addr >= TASK_SIZE || addr < mmap_min_addr)
> -		return -EINVAL;
> -
> -	error = -EINVAL;
> -
> -	down_write(&mm->mmap_sem);
> -	vma = find_vma(mm, addr);
> -
> -	prctl_map.start_code	= mm->start_code;
> -	prctl_map.end_code	= mm->end_code;
> -	prctl_map.start_data	= mm->start_data;
> -	prctl_map.end_data	= mm->end_data;
> -	prctl_map.start_brk	= mm->start_brk;
> -	prctl_map.brk		= mm->brk;
> -	prctl_map.start_stack	= mm->start_stack;
> -	prctl_map.arg_start	= mm->arg_start;
> -	prctl_map.arg_end	= mm->arg_end;
> -	prctl_map.env_start	= mm->env_start;
> -	prctl_map.env_end	= mm->env_end;
> -	prctl_map.auxv		= NULL;
> -	prctl_map.auxv_size	= 0;
> -	prctl_map.exe_fd	= -1;
> -
> -	switch (opt) {
> -	case PR_SET_MM_START_CODE:
> -		prctl_map.start_code = addr;
> -		break;
> -	case PR_SET_MM_END_CODE:
> -		prctl_map.end_code = addr;
> -		break;
> -	case PR_SET_MM_START_DATA:
> -		prctl_map.start_data = addr;
> -		break;
> -	case PR_SET_MM_END_DATA:
> -		prctl_map.end_data = addr;
> -		break;
> -	case PR_SET_MM_START_STACK:
> -		prctl_map.start_stack = addr;
> -		break;
> -	case PR_SET_MM_START_BRK:
> -		prctl_map.start_brk = addr;
> -		break;
> -	case PR_SET_MM_BRK:
> -		prctl_map.brk = addr;
> -		break;
> -	case PR_SET_MM_ARG_START:
> -		prctl_map.arg_start = addr;
> -		break;
> -	case PR_SET_MM_ARG_END:
> -		prctl_map.arg_end = addr;
> -		break;
> -	case PR_SET_MM_ENV_START:
> -		prctl_map.env_start = addr;
> -		break;
> -	case PR_SET_MM_ENV_END:
> -		prctl_map.env_end = addr;
> -		break;
> -	default:
> -		goto out;
> -	}
> -
> -	error = validate_prctl_map(&prctl_map);
> -	if (error)
> -		goto out;
> -
> -	switch (opt) {
> -	/*
> -	 * If command line arguments and environment
> -	 * are placed somewhere else on stack, we can
> -	 * set them up here, ARG_START/END to setup
> -	 * command line argumets and ENV_START/END
> -	 * for environment.
> -	 */
> -	case PR_SET_MM_START_STACK:
> -	case PR_SET_MM_ARG_START:
> -	case PR_SET_MM_ARG_END:
> -	case PR_SET_MM_ENV_START:
> -	case PR_SET_MM_ENV_END:
> -		if (!vma) {
> -			error = -EFAULT;
> -			goto out;
> -		}
> -	}
> -
> -	mm->start_code	= prctl_map.start_code;
> -	mm->end_code	= prctl_map.end_code;
> -	mm->start_data	= prctl_map.start_data;
> -	mm->end_data	= prctl_map.end_data;
> -	mm->start_brk	= prctl_map.start_brk;
> -	mm->brk		= prctl_map.brk;
> -	mm->start_stack	= prctl_map.start_stack;
> -	mm->arg_start	= prctl_map.arg_start;
> -	mm->arg_end	= prctl_map.arg_end;
> -	mm->env_start	= prctl_map.env_start;
> -	mm->env_end	= prctl_map.env_end;
> -
> -	error = 0;
> -out:
> -	up_write(&mm->mmap_sem);
> -	return error;
> +	pr_warn_once("Non PR_SET_MM_MAP operations are deprecated\n");
> +	return -EINVAL;
>   }
>   
>   #ifdef CONFIG_CHECKPOINT_RESTORE
