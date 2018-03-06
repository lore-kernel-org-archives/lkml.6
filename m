Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754066AbeCFVlq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 16:41:46 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49024 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753876AbeCFVll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 16:41:41 -0500
Date: Tue, 6 Mar 2018 13:41:39 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yang Shi <yang.shi@linux.alibaba.com>
Cc: mingo@kernel.org, adobriyan@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>
Subject: Re: [RFC PATCH 0/4 v2] Define killable version for
 access_remote_vm() and use it in fs/proc
Message-Id: <20180306134139.375e15abab173329962f7d5a@linux-foundation.org>
In-Reply-To: <b576e32b-9c47-ee67-a576-b5a0c05c2864@linux.alibaba.com>
References: <1519691151-101999-1-git-send-email-yang.shi@linux.alibaba.com>
        <20180306124540.d8b5f6da97ab69a49566f950@linux-foundation.org>
        <b576e32b-9c47-ee67-a576-b5a0c05c2864@linux.alibaba.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2018 13:17:37 -0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:

> 
> 
> It just mitigates the hung task warning, can't resolve the mmap_sem 
> scalability issue. Furthermore, waiting on pure uninterruptible state 
> for reading /proc sounds unnecessary. It doesn't wait for I/O completion.

OK.

> >
> > Where the heck are we holding mmap_sem for so long?  Can that be fixed?
> 
> The mmap_sem is held for unmapping a large map which has every single 
> page mapped. This is not a issue in real production code. Just found it 
> by running vm-scalability on a machine with ~600GB memory.
> 
> AFAIK, I don't see any easy fix for the mmap_sem scalability issue. I 
> saw range locking patches (https://lwn.net/Articles/723648/) were 
> floating around. But, it may not help too much on the case that a large 
> map with every single page mapped.

Well it sounds fairly simple to mitigate?  Simplistically: don't unmap
600G in a single hit; do it 1G at a time, dropping mmap_sem each time. 
A smarter version might only come up for air if there are mmap_sem
waiters and if it has already done some work.  I don't think we have
any particular atomicity requirements when unmapping?
