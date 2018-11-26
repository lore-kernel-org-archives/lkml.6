Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB028C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8408A205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OVZZWvTx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8408A205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeK0Ht0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:49:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59546 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbeK0HtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:49:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5LUyd42dpNT/5gZY8vCC36Z8cyNS6CzPcoPkp7P6+Oo=; b=OVZZWvTxYlGCiRyVKKTEETTUM
        pKzanPotdwVPsXSrsR7IJVSgNWQQ3gW3DFt5pWa24yUBM31eX63QGetL0dogskMCCw+MYFY75KeUO
        oymnYj5DHnGAaCZFlWUd4HQJQ/Sozeq5JQ1+jBB+HFp9oX0fXov245/R2pqaHTxeiAHrHrv0zNmdP
        XPxdWQRZH/IzNUNSVyg1Gkpfsl6PLD0XZF/qinY6zqFAK+X3MB85vSMreHgRoJJZqF+gBMO8bqApG
        IbjyR4uPoYh6SPnJ2Q06LQh4Ae/+fAsO0dZtqQupEOee5s8U5qdvC95/fL6HZhwlZRU2QOJu1OxmS
        LuZuh4Ymw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRNt9-0005a1-U5; Mon, 26 Nov 2018 20:53:51 +0000
Date:   Mon, 26 Nov 2018 12:53:51 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Herrmann <dh.herrmann@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Nick Piggin <npiggin@gmail.com>, pifang@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHi v2] mm: put_and_wait_on_page_locked() while page is
 migrated
Message-ID: <20181126205351.GM3065@bombadil.infradead.org>
References: <alpine.LSU.2.11.1811241858540.4415@eggly.anvils>
 <CAHk-=wjeqKYevxGnfCM4UkxX8k8xfArzM6gKkG3BZg1jBYThVQ@mail.gmail.com>
 <alpine.LSU.2.11.1811251900300.1278@eggly.anvils>
 <alpine.LSU.2.11.1811261121330.1116@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1811261121330.1116@eggly.anvils>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 11:27:07AM -0800, Hugh Dickins wrote:
> Waiting on a page migration entry has used wait_on_page_locked() all
> along since 2006: but you cannot safely wait_on_page_locked() without
> holding a reference to the page, and that extra reference is enough to
> make migrate_page_move_mapping() fail with -EAGAIN, when a racing task
> faults on the entry before migrate_page_move_mapping() gets there.
> 
> And that failure is retried nine times, amplifying the pain when
> trying to migrate a popular page.  With a single persistent faulter,
> migration sometimes succeeds; with two or three concurrent faulters,
> success becomes much less likely (and the more the page was mapped,
> the worse the overhead of unmapping and remapping it on each try).
> 
> This is especially a problem for memory offlining, where the outer
> level retries forever (or until terminated from userspace), because
> a heavy refault workload can trigger an endless loop of migration
> failures.  wait_on_page_locked() is the wrong tool for the job.
> 
> David Herrmann (but was he the first?) noticed this issue in 2014:
> https://marc.info/?l=linux-mm&m=140110465608116&w=2
> 
> Tim Chen started a thread in August 2017 which appears relevant:
> https://marc.info/?l=linux-mm&m=150275941014915&w=2
> where Kan Liang went on to implicate __migration_entry_wait():
> https://marc.info/?l=linux-mm&m=150300268411980&w=2
> and the thread ended up with the v4.14 commits:
> 2554db916586 ("sched/wait: Break up long wake list walk")
> 11a19c7b099f ("sched/wait: Introduce wakeup boomark in wake_up_page_bit")
> 
> Baoquan He reported "Memory hotplug softlock issue" 14 November 2018:
> https://marc.info/?l=linux-mm&m=154217936431300&w=2
> 
> We have all assumed that it is essential to hold a page reference while
> waiting on a page lock: partly to guarantee that there is still a struct
> page when MEMORY_HOTREMOVE is configured, but also to protect against
> reuse of the struct page going to someone who then holds the page locked
> indefinitely, when the waiter can reasonably expect timely unlocking.
> 
> But in fact, so long as wait_on_page_bit_common() does the put_page(),
> and is careful not to rely on struct page contents thereafter, there is
> no need to hold a reference to the page while waiting on it.  That does
> mean that this case cannot go back through the loop: but that's fine for
> the page migration case, and even if used more widely, is limited by the
> "Stop walking if it's locked" optimization in wake_page_function().
> 
> Add interface put_and_wait_on_page_locked() to do this, using "behavior"
> enum in place of "lock" arg to wait_on_page_bit_common() to implement it.
> No interruptible or killable variant needed yet, but they might follow:
> I have a vague notion that reporting -EINTR should take precedence over
> return from wait_on_page_bit_common() without knowing the page state,
> so arrange it accordingly - but that may be nothing but pedantic.
> 
> __migration_entry_wait() still has to take a brief reference to the
> page, prior to calling put_and_wait_on_page_locked(): but now that it
> is dropped before waiting, the chance of impeding page migration is
> very much reduced.  Should we perhaps disable preemption across this?
> 
> shrink_page_list()'s __ClearPageLocked(): that was a surprise!  This
> survived a lot of testing before that showed up.  PageWaiters may have
> been set by wait_on_page_bit_common(), and the reference dropped, just
> before shrink_page_list() succeeds in freezing its last page reference:
> in such a case, unlock_page() must be used.  Follow the suggestion from
> Michal Hocko, just revert a978d6f52106 ("mm: unlockless reclaim") now:
> that optimization predates PageWaiters, and won't buy much these days;
> but we can reinstate it for the !PageWaiters case if anyone notices.
> 
> It does raise the question: should vmscan.c's is_page_cache_freeable()
> and __remove_mapping() now treat a PageWaiters page as if an extra
> reference were held?  Perhaps, but I don't think it matters much, since
> shrink_page_list() already had to win its trylock_page(), so waiters are
> not very common there: I noticed no difference when trying the bigger
> change, and it's surely not needed while put_and_wait_on_page_locked()
> is only used for page migration.
> 
> Reported-and-tested-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
> ---
>  include/linux/pagemap.h |  2 ++
>  mm/filemap.c            | 77 ++++++++++++++++++++++++++++++++++-------
>  mm/huge_memory.c        |  6 ++--
>  mm/migrate.c            | 12 +++----
>  mm/vmscan.c             | 10 ++----
>  5 files changed, 74 insertions(+), 33 deletions(-)
> 

/**
 * put_and_wait_on_page_locked - Drop a reference and wait for it to be unlocked
 * @page: The page to wait for.
 *
 * The caller should hold a reference on @page.  They expect the page to
 * become unlocked relatively soon, but do not wish to hold up migration
 * (for example) by holding the reference while waiting for the page to
 * come unlocked.  After this function returns, the caller should not
 * dereference @page.
 */

(improvements gratefully received)

> +void put_and_wait_on_page_locked(struct page *page)
> +{
> +	wait_queue_head_t *q;
> +
> +	page = compound_head(page);
> +	q = page_waitqueue(page);
> +	wait_on_page_bit_common(q, page, PG_locked, TASK_UNINTERRUPTIBLE, DROP);
> +}
> +
>  /**
>   * add_page_wait_queue - Add an arbitrary waiter to a page's wait queue
>   * @page: Page defining the wait queue of interest
