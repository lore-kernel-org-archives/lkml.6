Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30019C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 07:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE3720671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 07:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE3720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbeJWQFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 12:05:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:51946 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727023AbeJWQFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 12:05:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 58396AD88;
        Tue, 23 Oct 2018 07:43:41 +0000 (UTC)
Date:   Tue, 23 Oct 2018 09:43:40 +0200
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
Message-ID: <20181023074340.GO18839@dhcp22.suse.cz>
References: <20181018041022.4529-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018041022.4529-1-mike.kravetz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-10-18 21:10:22, Mike Kravetz wrote:
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
> In addition, it makes little sense to even try to drop hugetlbfs
> pagecache pages, so disable calls to these filesystems in drop_caches
> code.
> 
> Fixes: 70c3547e36f5 ("hugetlbfs: add hugetlbfs_fallocate()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

I do agree with others that HUGETLBFS_MAGIC check in drop_pagecache_sb
is wrong in principal. I am not even sure we want to special case memory
backed filesystems. What if we ever implement MADV_FREE on fs? Should
those pages be dropped? My first idea take would be yes.

Acked-by: Michal Hocko <mhocko@suse.com> to the set_page_dirty dirty
part.

Although I am wondering why you haven't covered only the fallocate path
wrt Fixes tag. In other words, do we need the same treatment for the
page fault path? We do not set dirty bit on page there as well. We rely
on the dirty bit in pte and only for writable mappings. I have hard time
to see why we have been safe there as well. So maybe it is your Fixes:
tag which is not entirely correct, or I am simply missing the fault
path.
-- 
Michal Hocko
SUSE Labs
