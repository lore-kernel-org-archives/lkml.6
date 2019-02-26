Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B9CC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E8A2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfBZHqZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:46:25 -0500
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:46512 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfBZHqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 02:46:25 -0500
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x1Q7jmwV005697
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 26 Feb 2019 16:45:48 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x1Q7jmtT029610;
        Tue, 26 Feb 2019 16:45:48 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x1Q7ih5j000771;
        Tue, 26 Feb 2019 16:45:48 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.149] [10.38.151.149]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-2803189; Tue, 26 Feb 2019 16:44:33 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC21GP.gisp.nec.co.jp ([10.38.151.149]) with mapi id 14.03.0319.002; Tue,
 26 Feb 2019 16:44:32 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] huegtlbfs: fix races and page leaks during migration
Thread-Topic: [PATCH] huegtlbfs: fix races and page leaks during migration
Thread-Index: AQHUwyBJmVUOEJ5O6kyjIcjA4cDr6qXpOssAgADaeACABxvTAA==
Date:   Tue, 26 Feb 2019 07:44:30 +0000
Message-ID: <20190226074430.GA17606@hori.linux.bs1.fc.nec.co.jp>
References: <803d2349-8911-0b47-bc5b-4f2c6cc3f928@oracle.com>
 <20190212221400.3512-1-mike.kravetz@oracle.com>
 <20190220220910.265bff9a7695540ee4121b80@linux-foundation.org>
 <7534d322-d782-8ac6-1c8d-a8dc380eb3ab@oracle.com>
In-Reply-To: <7534d322-d782-8ac6-1c8d-a8dc380eb3ab@oracle.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.96]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <65A50E881456134CB6F21FD9C68E3C32@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Thu, Feb 21, 2019 at 11:11:06AM -0800, Mike Kravetz wrote:
> On 2/20/19 10:09 PM, Andrew Morton wrote:
> > On Tue, 12 Feb 2019 14:14:00 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> >> index a80832487981..f859e319e3eb 100644
> >> --- a/mm/hugetlb.c
> >> +++ b/mm/hugetlb.c

...

> >> @@ -3863,6 +3862,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
> >>  	}
> >>  
> >>  	spin_unlock(ptl);
> >> +
> >> +	/* May already be set if not newly allocated page */
> >> +	set_page_huge_active(page);
> >> +
> 
> This is wrong.  We need to only set_page_huge_active() for newly allocated
> pages.  Why?  We could have got the page from the pagecache, and it could
> be that the page is !page_huge_active() because it has been isolated for
> migration.  Therefore, we do not want to set it active here.
> 
> I have also found another race with migration when removing a page from
> a file.  When a huge page is removed from the pagecache, the page_mapping()
> field is cleared yet page_private continues to point to the subpool until
> the page is actually freed by free_huge_page().  free_huge_page is what
> adjusts the counts for the subpool.  A page could be migrated while in this
> state.  However, since page_mapping() is not set the hugetlbfs specific
> routine to transfer page_private is not called and we leak the page count
> in the filesystem.  To fix, check for this condition before migrating a huge
> page.  If the condition is detected, return EBUSY for the page.
> 
> Both issues are addressed in the updated patch below.
> 
> Sorry for the churn.  As I find and fix one issue I seem to discover another.
> There is still at least one more issue with private pages when COW comes into
> play.  I continue to work that.  I wanted to send this patch earlier as it
> is pretty easy to hit the bugs if you try.  If you would prefer another
> approach, let me know.
> 
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Thu, 21 Feb 2019 11:01:04 -0800
> Subject: [PATCH] huegtlbfs: fix races and page leaks during migration

Subject still contains a typo.

> 
> hugetlb pages should only be migrated if they are 'active'.  The routines
> set/clear_page_huge_active() modify the active state of hugetlb pages.
> When a new hugetlb page is allocated at fault time, set_page_huge_active
> is called before the page is locked.  Therefore, another thread could
> race and migrate the page while it is being added to page table by the
> fault code.  This race is somewhat hard to trigger, but can be seen by
> strategically adding udelay to simulate worst case scheduling behavior.
> Depending on 'how' the code races, various BUG()s could be triggered.
> 
> To address this issue, simply delay the set_page_huge_active call until
> after the page is successfully added to the page table.
> 
> Hugetlb pages can also be leaked at migration time if the pages are
> associated with a file in an explicitly mounted hugetlbfs filesystem.
> For example, consider a two node system with 4GB worth of huge pages
> available.  A program mmaps a 2G file in a hugetlbfs filesystem.  It
> then migrates the pages associated with the file from one node to
> another.  When the program exits, huge page counts are as follows:
> 
> node0
> 1024    free_hugepages
> 1024    nr_hugepages
> 
> node1
> 0       free_hugepages
> 1024    nr_hugepages
> 
> Filesystem                         Size  Used Avail Use% Mounted on
> nodev                              4.0G  2.0G  2.0G  50% /var/opt/hugepool
> 
> That is as expected.  2G of huge pages are taken from the free_hugepages
> counts, and 2G is the size of the file in the explicitly mounted filesystem.
> If the file is then removed, the counts become:
> 
> node0
> 1024    free_hugepages
> 1024    nr_hugepages
> 
> node1
> 1024    free_hugepages
> 1024    nr_hugepages
> 
> Filesystem                         Size  Used Avail Use% Mounted on
> nodev                              4.0G  2.0G  2.0G  50% /var/opt/hugepool
> 
> Note that the filesystem still shows 2G of pages used, while there
> actually are no huge pages in use.  The only way to 'fix' the
> filesystem accounting is to unmount the filesystem
> 
> If a hugetlb page is associated with an explicitly mounted filesystem,
> this information in contained in the page_private field.  At migration
> time, this information is not preserved.  To fix, simply transfer
> page_private from old to new page at migration time if necessary.
> 
> There is a related race with removing a huge page from a file migration.
> When a huge page is removed from the pagecache, the page_mapping() field
> is cleared yet page_private remains set until the page is actually freed
> by free_huge_page().  A page could be migrated while in this state.
> However, since page_mapping() is not set the hugetlbfs specific routine
> to transfer page_private is not called and we leak the page count in the
> filesystem.  To fix, check for this condition before migrating a huge
> page.  If the condition is detected, return EBUSY for the page.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: bcc54222309c ("mm: hugetlb: introduce page_huge_active")
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  fs/hugetlbfs/inode.c | 12 ++++++++++++
>  mm/hugetlb.c         | 12 +++++++++---
>  mm/migrate.c         | 11 +++++++++++
>  3 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 32920a10100e..a7fa037b876b 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -859,6 +859,18 @@ static int hugetlbfs_migrate_page(struct address_space
> *mapping,
>  	rc = migrate_huge_page_move_mapping(mapping, newpage, page);
>  	if (rc != MIGRATEPAGE_SUCCESS)
>  		return rc;
> +
> +	/*
> +	 * page_private is subpool pointer in hugetlb pages.  Transfer to
> +	 * new page.  PagePrivate is not associated with page_private for
> +	 * hugetlb pages and can not be set here as only page_huge_active
> +	 * pages can be migrated.
> +	 */
> +	if (page_private(page)) {
> +		set_page_private(newpage, page_private(page));
> +		set_page_private(page, 0);
> +	}
> +
>  	if (mode != MIGRATE_SYNC_NO_COPY)
>  		migrate_page_copy(newpage, page);
>  	else
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a80832487981..e9c92e925b7e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
...
> @@ -3863,6 +3864,11 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  	}
> 
>  	spin_unlock(ptl);
> +
> +	/* Make newly allocated pages active */

You already have a perfect explanation about why we need this "if",

  > ... We could have got the page from the pagecache, and it could
  > be that the page is !page_huge_active() because it has been isolated for
  > migration.

so you could improve this comment with it.

Anyway, I agree to what/how you try to fix.

Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

Thanks,
Naoya Horiguchi
