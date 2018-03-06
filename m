Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754035AbeCFRoc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 12:44:32 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34018 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753849AbeCFRoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 12:44:30 -0500
X-Google-Smtp-Source: AG47ELuckP5H/bKNP5jsJ/KA4mbCZYi0LNWEIf0EoJ8lorBcSLuuPAcBV1Bx8lFx71KybsFxDYTp9g==
Date: Tue, 6 Mar 2018 20:44:27 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, yeohc@au1.ibm.com, jann@thejh.net
Subject: Re: [PATCH] mm: relax ptrace mode in process_vm_readv(2)
Message-ID: <20180306174427.GB2080@avx2>
References: <20180303201116.GA10031@avx2>
 <20180305160710.0ea9a6c0c4b784a457a48a2b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305160710.0ea9a6c0c4b784a457a48a2b@linux-foundation.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 04:07:10PM -0800, Andrew Morton wrote:
> On Sat, 3 Mar 2018 23:11:16 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > It is more natural to check for read-from-memory permissions in case of
> > process_vm_readv() as PTRACE_MODE_ATTACH is equivalent to write
> > permissions.
> > 
> > ...
> >
> > --- a/mm/process_vm_access.c
> > +++ b/mm/process_vm_access.c
> > @@ -204,7 +204,7 @@ static ssize_t process_vm_rw_core(pid_t pid, struct iov_iter *iter,
> >  		goto free_proc_pages;
> >  	}
> >  
> > -	mm = mm_access(task, PTRACE_MODE_ATTACH_REALCREDS);
> > +	mm = mm_access(task, vm_write ? PTRACE_MODE_ATTACH_REALCREDS : PTRACE_MODE_READ_REALCREDS);
> >  	if (!mm || IS_ERR(mm)) {
> >  		rc = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
> >  		/*
> 
> But what is the risk of breaking existing userspace?

Permissions for write/ATTACH should be more strict than for read/READ,
so loosening them should be fine.

Unless LSM does silly things of course.
