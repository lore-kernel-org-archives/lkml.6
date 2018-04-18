Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753680AbeDRK1w (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 06:27:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52766 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751980AbeDRK1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 06:27:51 -0400
Date: Wed, 18 Apr 2018 03:27:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yang Shi <yang.shi@linux.alibaba.com>
Cc: viro@zeniv.linux.org.uk, nyc@holomorphy.com, mike.kravetz@oracle.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: introduce ST_HUGE flag and set it to tmpfs and
 hugetlbfs
Message-ID: <20180418102744.GA10397@infradead.org>
References: <1523999293-94152-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523999293-94152-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 05:08:13AM +0800, Yang Shi wrote:
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

Seems like your should report it through the st_blksize field of struct
stat then, instead of introducing a not very useful binary field then.
