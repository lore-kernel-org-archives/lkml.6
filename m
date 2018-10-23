Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E27C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DDA207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DDA207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbeJXCGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 22:06:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:50508 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726865AbeJXCGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 22:06:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 341FDB086;
        Tue, 23 Oct 2018 17:41:50 +0000 (UTC)
Date:   Tue, 23 Oct 2018 19:41:48 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        stable@vger.kernel.org
Subject: Re: [PATCH] hugetlbfs: dirty pages as they are added to pagecache
Message-ID: <20181023174148.GX18839@dhcp22.suse.cz>
References: <20181018041022.4529-1-mike.kravetz@oracle.com>
 <20181023074340.GO18839@dhcp22.suse.cz>
 <b5be45b8-5afe-56cd-9482-28384699a049@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5be45b8-5afe-56cd-9482-28384699a049@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23-10-18 10:30:44, Mike Kravetz wrote:
> On 10/23/18 12:43 AM, Michal Hocko wrote:
> > On Wed 17-10-18 21:10:22, Mike Kravetz wrote:
> >> Some test systems were experiencing negative huge page reserve
> >> counts and incorrect file block counts.  This was traced to
> >> /proc/sys/vm/drop_caches removing clean pages from hugetlbfs
> >> file pagecaches.  When non-hugetlbfs explicit code removes the
> >> pages, the appropriate accounting is not performed.
> >>
> >> This can be recreated as follows:
> >>  fallocate -l 2M /dev/hugepages/foo
> >>  echo 1 > /proc/sys/vm/drop_caches
> >>  fallocate -l 2M /dev/hugepages/foo
> >>  grep -i huge /proc/meminfo
> >>    AnonHugePages:         0 kB
> >>    ShmemHugePages:        0 kB
> >>    HugePages_Total:    2048
> >>    HugePages_Free:     2047
> >>    HugePages_Rsvd:    18446744073709551615
> >>    HugePages_Surp:        0
> >>    Hugepagesize:       2048 kB
> >>    Hugetlb:         4194304 kB
> >>  ls -lsh /dev/hugepages/foo
> >>    4.0M -rw-r--r--. 1 root root 2.0M Oct 17 20:05 /dev/hugepages/foo
> >>
> >> To address this issue, dirty pages as they are added to pagecache.
> >> This can easily be reproduced with fallocate as shown above. Read
> >> faulted pages will eventually end up being marked dirty.  But there
> >> is a window where they are clean and could be impacted by code such
> >> as drop_caches.  So, just dirty them all as they are added to the
> >> pagecache.
> >>
> >> In addition, it makes little sense to even try to drop hugetlbfs
> >> pagecache pages, so disable calls to these filesystems in drop_caches
> >> code.
> >>
> >> Fixes: 70c3547e36f5 ("hugetlbfs: add hugetlbfs_fallocate()")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > 
> > I do agree with others that HUGETLBFS_MAGIC check in drop_pagecache_sb
> > is wrong in principal. I am not even sure we want to special case memory
> > backed filesystems. What if we ever implement MADV_FREE on fs? Should
> > those pages be dropped? My first idea take would be yes.
> 
> Ok, I have removed that hard coded check.  Implementing MADV_FREE on
> hugetlbfs would take some work, but it could be done.
> 
> > Acked-by: Michal Hocko <mhocko@suse.com> to the set_page_dirty dirty
> > part.
> > 
> > Although I am wondering why you haven't covered only the fallocate path
> > wrt Fixes tag. In other words, do we need the same treatment for the
> > page fault path? We do not set dirty bit on page there as well. We rely
> > on the dirty bit in pte and only for writable mappings. I have hard time
> > to see why we have been safe there as well. So maybe it is your Fixes:
> > tag which is not entirely correct, or I am simply missing the fault
> > path.
> 
> No, you are not missing anything.  In the commit log I mentioned that this
> also does apply to the fault path.  The change takes care of them both.
> 
> I was struggling with what to put in the fixes tag.  As mentioned, this
> problem also exists in the fault path.  Since 3.16 is the oldest stable
> release, I went back and used the commit next to the add_to_page_cache code
> there.  However, that seems kind of random.  Is there a better way to say
> the patch applies to all stable releases?

OK, good, I was afraid I was missing something, well except for not
reading the changelog properly. I would go with

Cc: stable # all kernels with hugetlb

> Here is updated patch without the drop_caches change and updated fixes tag.
> 
> From: Mike Kravetz <mike.kravetz@oracle.com>
> 
> hugetlbfs: dirty pages as they are added to pagecache
> 
> Some test systems were experiencing negative huge page reserve
> counts and incorrect file block counts.  This was traced to
> /proc/sys/vm/drop_caches removing clean pages from hugetlbfs
> file pagecaches.  When non-hugetlbfs explicit code removes the
> pages, the appropriate accounting is not performed.
> 
> This can be recreated as follows:
>  fallocate -l 2M /dev/hugepages/foo
>  echo 1 > /proc/sys/vm/drop_caches
>  fallocate -l 2M /dev/hugepages/foo
>  grep -i huge /proc/meminfo
>    AnonHugePages:         0 kB
>    ShmemHugePages:        0 kB
>    HugePages_Total:    2048
>    HugePages_Free:     2047
>    HugePages_Rsvd:    18446744073709551615
>    HugePages_Surp:        0
>    Hugepagesize:       2048 kB
>    Hugetlb:         4194304 kB
>  ls -lsh /dev/hugepages/foo
>    4.0M -rw-r--r--. 1 root root 2.0M Oct 17 20:05 /dev/hugepages/foo
> 
> To address this issue, dirty pages as they are added to pagecache.
> This can easily be reproduced with fallocate as shown above. Read
> faulted pages will eventually end up being marked dirty.  But there
> is a window where they are clean and could be impacted by code such
> as drop_caches.  So, just dirty them all as they are added to the
> pagecache.
> 
> Fixes: 6bda666a03f0 ("hugepages: fold find_or_alloc_pages into huge_no_page()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Mihcla Hocko <mhocko@suse.com>

> ---
>  mm/hugetlb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 5c390f5a5207..7b5c0ad9a6bd 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3690,6 +3690,12 @@ int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
>  		return err;
>  	ClearPagePrivate(page);
>  
> +	/*
> +	 * set page dirty so that it will not be removed from cache/file
> +	 * by non-hugetlbfs specific code paths.
> +	 */
> +	set_page_dirty(page);
> +
>  	spin_lock(&inode->i_lock);
>  	inode->i_blocks += blocks_per_huge_page(h);
>  	spin_unlock(&inode->i_lock);
> -- 
> 2.17.2

-- 
Michal Hocko
SUSE Labs
