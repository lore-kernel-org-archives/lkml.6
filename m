Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752615AbeENVAr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:00:47 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:33948 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeENVAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:00:45 -0400
Date: Mon, 14 May 2018 22:34:14 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, dave.martin@arm.com, james.morse@arm.com,
        linux-fsdevel@vger.kernel.org, marc.zyngier@arm.com,
        viro@zeniv.linux.org.uk, will.deacon@arm.com
Subject: Re: [PATCH 13/18] kernel: add kcompat_sys_{f,}statfs64()
Message-ID: <20180514203414.GB26773@light.dominikbrodowski.net>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-14-mark.rutland@arm.com>
 <20180514171427.qyietn3fhilwokb2@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514171427.qyietn3fhilwokb2@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 06:14:28PM +0100, Mark Rutland wrote:
> On Mon, May 14, 2018 at 10:46:35AM +0100, Mark Rutland wrote:
> > Using this helper allows us to avoid the in-kernel calls to the
> > compat_sys_{f,}statfs64() sycalls, as are necessary for parameter
> > mangling in arm64's compat handling.
> > 
> > Following the example of ksys_* functions, kcompat_sys_* functions are
> > intended to be a drop-in replacement for their compat_sys_*
> > counterparts, with the same calling convention.
> > 
> > This is necessary to enable conversion of arm64's syscall handling to
> > use pt_regs wrappers.
> 
> > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > index 6723ea51ec99..e0bf3e4bb897 100644
> > --- a/include/linux/syscalls.h
> > +++ b/include/linux/syscalls.h
> > @@ -59,6 +59,7 @@ struct tms;
> >  struct utimbuf;
> >  struct mq_attr;
> >  struct compat_stat;
> > +struct compat_statfs64;
> >  struct compat_timeval;
> >  struct robust_list_head;
> >  struct getcpu_cache;
> > @@ -1150,6 +1151,13 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
> >  ssize_t ksys_readahead(int fd, loff_t offset, size_t count);
> >  unsigned int ksys_personality(unsigned int personality);
> >  
> > +#ifdef CONFIG_COMPAT
> > +int kcompat_sys_statfs64(const char __user * pathname, compat_size_t sz,
> > +		     struct compat_statfs64 __user * buf);
> > +int kcompat_sys_fstatfs64(unsigned int fd, compat_size_t sz,
> > +			  struct compat_statfs64 __user * buf);
> > +#endif
> 
> I've moved these to <linux/compat.h>, so that they live with the rest of
> the compat syscall stuff. That should avoid build failures the kbuild
> test robot picked up where compat_size_t wasn't dfined.

Please add a comment there, similar to what is in syscalls.h:

	/*
	 * Kernel code should not call syscalls (i.e., sys_xyzyyz()) directly.
	 * Instead, use one of the functions which work equivalently, such as
	 * the ksys_xyzyyz() functions prototyped below.
	 */

Once you have done so, feel free to add my

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

tag to this patch.

Thanks,
	Dominik
