Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753584AbeDQVbr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 17:31:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34080 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752840AbeDQVbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 17:31:45 -0400
Date: Tue, 17 Apr 2018 14:31:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yang Shi <yang.shi@linux.alibaba.com>
Cc: viro@zeniv.linux.org.uk, nyc@holomorphy.com, mike.kravetz@oracle.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: introduce ST_HUGE flag and set it to tmpfs and
 hugetlbfs
Message-Id: <20180417143144.b7ffb07fad28875bad546247@linux-foundation.org>
In-Reply-To: <1523999293-94152-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1523999293-94152-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2018 05:08:13 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:

> Since tmpfs THP was supported in 4.8, hugetlbfs is not the only
> filesystem with huge page support anymore. tmpfs can use huge page via
> THP when mounting by "huge=" mount option.
> 
> When applications use huge page on hugetlbfs, it just need check the
> filesystem magic number, but it is not enough for tmpfs. So, introduce
> ST_HUGE flag to statfs if super block has SB_HUGE set which indicates
> huge page is supported on the specific filesystem.
> 
> Some applications could benefit from this change, for example QEMU.
> When use mmap file as guest VM backend memory, QEMU typically mmap the
> file size plus one extra page. If the file is on hugetlbfs the extra
> page is huge page size (i.e. 2MB), but it is still 4KB on tmpfs even
> though THP is enabled. tmpfs THP requires VMA is huge page aligned, so
> if 4KB page is used THP will not be used at all. The below /proc/meminfo
> fragment shows the THP use of QEMU with 4K page:
> 
> ShmemHugePages:   679936 kB
> ShmemPmdMapped:        0 kB
> 
> With ST_HUGE flag, QEMU can get huge page, then /proc/meminfo looks
> like:
> 
> ShmemHugePages:    77824 kB
> ShmemPmdMapped:     6144 kB
> 
> With this flag, the applications can know if huge page is supported on
> the filesystem then optimize the behavior of the applications
> accordingly. Although the similar function can be implemented in
> applications by traversing the mount options, it looks more convenient
> if kernel can provide such flag.
> 
> Even though ST_HUGE is set, f_bsize still returns 4KB for tmpfs since
> THP could be split, and it also my fallback to 4KB page silently if
> there is not enough huge page.
> 
> And, set the flag for hugetlbfs as well to keep the consistency, and the
> applications don't have to know what filesystem is used to use huge
> page, just need to check ST_HUGE flag.
> 

Patch is simple enough, although I'm having trouble forming an opinion
about it ;)

It will call for an update to the statfs(2) manpage.  I'm not sure
which of linux-man@vger.kernel.org, mtk.manpages@gmail.com and
linux-api@vger.kernel.org is best for that, so I'd cc all three...
