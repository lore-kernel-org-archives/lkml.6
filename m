Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752896AbeENROe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 13:14:34 -0400
Received: from foss.arm.com ([217.140.101.70]:46836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751498AbeENROd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 13:14:33 -0400
Date: Mon, 14 May 2018 18:14:28 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        dave.martin@arm.com, james.morse@arm.com, linux@dominikbrodowski.net,
        linux-fsdevel@vger.kernel.org, marc.zyngier@arm.com,
        viro@zeniv.linux.org.uk, will.deacon@arm.com
Subject: Re: [PATCH 13/18] kernel: add kcompat_sys_{f,}statfs64()
Message-ID: <20180514171427.qyietn3fhilwokb2@lakrids.cambridge.arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-14-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514094640.27569-14-mark.rutland@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:46:35AM +0100, Mark Rutland wrote:
> Using this helper allows us to avoid the in-kernel calls to the
> compat_sys_{f,}statfs64() sycalls, as are necessary for parameter
> mangling in arm64's compat handling.
> 
> Following the example of ksys_* functions, kcompat_sys_* functions are
> intended to be a drop-in replacement for their compat_sys_*
> counterparts, with the same calling convention.
> 
> This is necessary to enable conversion of arm64's syscall handling to
> use pt_regs wrappers.

> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 6723ea51ec99..e0bf3e4bb897 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -59,6 +59,7 @@ struct tms;
>  struct utimbuf;
>  struct mq_attr;
>  struct compat_stat;
> +struct compat_statfs64;
>  struct compat_timeval;
>  struct robust_list_head;
>  struct getcpu_cache;
> @@ -1150,6 +1151,13 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
>  ssize_t ksys_readahead(int fd, loff_t offset, size_t count);
>  unsigned int ksys_personality(unsigned int personality);
>  
> +#ifdef CONFIG_COMPAT
> +int kcompat_sys_statfs64(const char __user * pathname, compat_size_t sz,
> +		     struct compat_statfs64 __user * buf);
> +int kcompat_sys_fstatfs64(unsigned int fd, compat_size_t sz,
> +			  struct compat_statfs64 __user * buf);
> +#endif

I've moved these to <linux/compat.h>, so that they live with the rest of
the compat syscall stuff. That should avoid build failures the kbuild
test robot picked up where compat_size_t wasn't dfined.

Thanks,
Mark.
