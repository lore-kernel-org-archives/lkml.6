Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756042AbeEHWjX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 18:39:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57790 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754148AbeEHWjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 18:39:22 -0400
Date: Tue, 8 May 2018 15:39:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: test /proc/*/fd a bit (+ PF_KTHREAD is ABI!)
Message-Id: <20180508153920.9e74e1ab86a8b10e8ddf09a0@linux-foundation.org>
In-Reply-To: <20180505000414.GA15090@avx2>
References: <20180505000414.GA15090@avx2>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 May 2018 03:04:14 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> * Test lookup in /proc/self/fd.
>   "map_files" lookup story showed that lookup is not that simple.
> 
> * Test that all those symlinks open the same file.
>   Check with (st_dev, st_info).
> 
> * Test that kernel threads do not have anything in their /proc/*/fd/
>   directory.
> 
> Now this is where things get interesting.
> 
> First, kernel threads aren't pinned by /proc/self or equivalent,
> thus some "atomicity" is required.
> 
> Second, ->comm can contain whitespace and ')'.
> No, they are not escaped.
> 
> Third, the only reliable way to check if process is kernel thread
> appears to be field #9 in /proc/*/stat.
> 
> This field is struct task_struct::flags in decimal!
> Check is done by testing PF_KTHREAD flags like we do in kernel.
> 
> 	PF_KTREAD value is a part of userspace ABI !!!

erk.  Well if there's a need the we could export and support some
stable interface.  I wonder how ps determines this.


> Other methods for determining kernel threadness are not reliable:
> * RSS can be 0 if everything is swapped, even while reading
>   from /proc/self.
> 
> * ->total_vm CAN BE ZERO if process is finishing
> 
> 	munmap(NULL, whole address space);
> 
> * /proc/*/maps and similar files can be empty because unmapping
>   everything works. Read returning 0 can't distinguish between
>   kernel thread and such suicide process.
> 
