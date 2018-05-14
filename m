Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbeENLIN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:08:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40204 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752028AbeENLIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:08:11 -0400
Date: Mon, 14 May 2018 12:08:06 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        james.morse@arm.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/18] kernel: add ksys_personality()
Message-ID: <20180514110805.GH7753@e103592.cambridge.arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-13-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514094640.27569-13-mark.rutland@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:46:34AM +0100, Mark Rutland wrote:
> Using this helper allows us to avoid the in-kernel call to the
> sys_personality() syscall. The ksys_ prefix denotes that this function
> is meant as a drop-in replacement for the syscall. In particular, it
> uses the same calling convention as sys_personality().
> 
> This is necessary to enable conversion of arm64's syscall handling to
> use pt_regs wrappers.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  include/linux/syscalls.h | 1 +
>  kernel/exec_domain.c     | 7 ++++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 70fcda1a9049..6723ea51ec99 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1148,6 +1148,7 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
>  			      unsigned long prot, unsigned long flags,
>  			      unsigned long fd, unsigned long pgoff);
>  ssize_t ksys_readahead(int fd, loff_t offset, size_t count);
> +unsigned int ksys_personality(unsigned int personality);
>  
>  /*
>   * The following kernel syscall equivalents are just wrappers to fs-internal
> diff --git a/kernel/exec_domain.c b/kernel/exec_domain.c
> index a5697119290e..4ba2b404cba2 100644
> --- a/kernel/exec_domain.c
> +++ b/kernel/exec_domain.c
> @@ -47,7 +47,7 @@ static int __init proc_execdomains_init(void)
>  module_init(proc_execdomains_init);
>  #endif
>  
> -SYSCALL_DEFINE1(personality, unsigned int, personality)
> +unsigned int ksys_personality(unsigned int personality)
>  {
>  	unsigned int old = current->personality;
>  
> @@ -56,3 +56,8 @@ SYSCALL_DEFINE1(personality, unsigned int, personality)
>  
>  	return old;
>  }
> +
> +SYSCALL_DEFINE1(personality, unsigned int, personality)
> +{
> +	return ksys_personality(personality);
> +}
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
