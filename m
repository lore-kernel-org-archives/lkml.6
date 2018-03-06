Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932921AbeCFAHN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 19:07:13 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45426 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932243AbeCFAHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 19:07:12 -0500
Date: Mon, 5 Mar 2018 16:07:10 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, yeohc@au1.ibm.com, jann@thejh.net
Subject: Re: [PATCH] mm: relax ptrace mode in process_vm_readv(2)
Message-Id: <20180305160710.0ea9a6c0c4b784a457a48a2b@linux-foundation.org>
In-Reply-To: <20180303201116.GA10031@avx2>
References: <20180303201116.GA10031@avx2>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Mar 2018 23:11:16 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> It is more natural to check for read-from-memory permissions in case of
> process_vm_readv() as PTRACE_MODE_ATTACH is equivalent to write
> permissions.
> 
> ...
>
> --- a/mm/process_vm_access.c
> +++ b/mm/process_vm_access.c
> @@ -204,7 +204,7 @@ static ssize_t process_vm_rw_core(pid_t pid, struct iov_iter *iter,
>  		goto free_proc_pages;
>  	}
>  
> -	mm = mm_access(task, PTRACE_MODE_ATTACH_REALCREDS);
> +	mm = mm_access(task, vm_write ? PTRACE_MODE_ATTACH_REALCREDS : PTRACE_MODE_READ_REALCREDS);
>  	if (!mm || IS_ERR(mm)) {
>  		rc = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
>  		/*

But what is the risk of breaking existing userspace?
