Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD13C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90661206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90661206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeILS3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:29:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726642AbeILS3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:29:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D225140241C0;
        Wed, 12 Sep 2018 13:24:43 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B59E32166BA3;
        Wed, 12 Sep 2018 13:24:40 +0000 (UTC)
Date:   Wed, 12 Sep 2018 09:24:39 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Henry Willard <henry.willard@oracle.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Zi Yan <zi.yan@cs.rutgers.edu>, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: mprotect: check page dirty when change ptes
Message-ID: <20180912132438.GB4009@redhat.com>
References: <20180912064921.31015-1-peterx@redhat.com>
 <20180912130355.GA4009@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180912130355.GA4009@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 12 Sep 2018 13:24:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 12 Sep 2018 13:24:43 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 09:03:55AM -0400, Jerome Glisse wrote:
> On Wed, Sep 12, 2018 at 02:49:21PM +0800, Peter Xu wrote:
> > Add an extra check on page dirty bit in change_pte_range() since there
> > might be case where PTE dirty bit is unset but it's actually dirtied.
> > One example is when a huge PMD is splitted after written: the dirty bit
> > will be set on the compound page however we won't have the dirty bit set
> > on each of the small page PTEs.
> > 
> > I noticed this when debugging with a customized kernel that implemented
> > userfaultfd write-protect.  In that case, the dirty bit will be critical
> > since that's required for userspace to handle the write protect page
> > fault (otherwise it'll get a SIGBUS with a loop of page faults).
> > However it should still be good even for upstream Linux to cover more
> > scenarios where we shouldn't need to do extra page faults on the small
> > pages if the previous huge page is already written, so the dirty bit
> > optimization path underneath can cover more.
> > 
> 
> So as said by Kirill NAK you are not looking at the right place for
> your bug please first apply the below patch and read my analysis in
> my last reply.

Just to be clear you are trying to fix a userspace bug that is hidden
for non THP pages by a kernel space bug inside userfaultfd by making
the kernel space bug of userfaultfd buggy for THP too.


> 
> Below patch fix userfaultfd bug. I am not posting it as it is on a
> branch and i am not sure when Andrea plan to post. Andrea feel free
> to squash that fix.
> 
> 
> From 35cdb30afa86424c2b9f23c0982afa6731be961c Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
> Date: Wed, 12 Sep 2018 08:58:33 -0400
> Subject: [PATCH] userfaultfd: do not set dirty accountable when changing
>  protection
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> mwriteprotect_range() has nothing to do with the dirty accountable
> optimization so do not set it as it opens a door for userspace to
> unwrite protect pages in a range that is write protected ie the vma
> !(vm_flags & VM_WRITE).
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> ---
>  mm/userfaultfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index a0379c5ffa7c..59db1ce48fa0 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -632,7 +632,7 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
>  		newprot = vm_get_page_prot(dst_vma->vm_flags);
>  
>  	change_protection(dst_vma, start, start + len, newprot,
> -				!enable_wp, 0);
> +				false, 0);
>  
>  	err = 0;
>  out_unlock:
> -- 
> 2.17.1
> 
