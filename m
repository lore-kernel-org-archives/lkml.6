Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E146ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A172075B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A172075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732677AbeGMU4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:56:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59840 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731895AbeGMU4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:56:19 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A28EACF7;
        Fri, 13 Jul 2018 20:40:04 +0000 (UTC)
Date:   Fri, 13 Jul 2018 13:40:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        xishi.qiuxishi@alibaba-inc.com, zy.zhengyi@alibaba-inc.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mm: soft-offline: close the race against page
 allocation
Message-Id: <20180713134002.a365049a79d41be3c28916cc@linux-foundation.org>
In-Reply-To: <1531452366-11661-3-git-send-email-n-horiguchi@ah.jp.nec.com>
References: <1531452366-11661-1-git-send-email-n-horiguchi@ah.jp.nec.com>
        <1531452366-11661-3-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jul 2018 12:26:06 +0900 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com> wrote:

> A process can be killed with SIGBUS(BUS_MCEERR_AR) when it tries to
> allocate a page that was just freed on the way of soft-offline.
> This is undesirable because soft-offline (which is about corrected error)
> is less aggressive than hard-offline (which is about uncorrected error),
> and we can make soft-offline fail and keep using the page for good reason
> like "system is busy."
> 
> Two main changes of this patch are:
> 
> - setting migrate type of the target page to MIGRATE_ISOLATE. As done
>   in free_unref_page_commit(), this makes kernel bypass pcplist when
>   freeing the page. So we can assume that the page is in freelist just
>   after put_page() returns,
> 
> - setting PG_hwpoison on free page under zone->lock which protects
>   freelists, so this allows us to avoid setting PG_hwpoison on a page
>   that is decided to be allocated soon.
> 
>
> ...
>
> +
> +#ifdef CONFIG_MEMORY_FAILURE
> +/*
> + * Set PG_hwpoison flag if a given page is confirmed to be a free page
> + * within zone lock, which prevents the race against page allocation.
> + */

I think this is clearer?

--- a/mm/page_alloc.c~mm-soft-offline-close-the-race-against-page-allocation-fix
+++ a/mm/page_alloc.c
@@ -8039,8 +8039,9 @@ bool is_free_buddy_page(struct page *pag
 
 #ifdef CONFIG_MEMORY_FAILURE
 /*
- * Set PG_hwpoison flag if a given page is confirmed to be a free page
- * within zone lock, which prevents the race against page allocation.
+ * Set PG_hwpoison flag if a given page is confirmed to be a free page.  This
+ * test is performed under the zone lock to prevent a race against page
+ * allocation.
  */
 bool set_hwpoison_free_buddy_page(struct page *page)
 {

> +bool set_hwpoison_free_buddy_page(struct page *page)
> +{
> +	struct zone *zone = page_zone(page);
> +	unsigned long pfn = page_to_pfn(page);
> +	unsigned long flags;
> +	unsigned int order;
> +	bool hwpoisoned = false;
> +
> +	spin_lock_irqsave(&zone->lock, flags);
> +	for (order = 0; order < MAX_ORDER; order++) {
> +		struct page *page_head = page - (pfn & ((1 << order) - 1));
> +
> +		if (PageBuddy(page_head) && page_order(page_head) >= order) {
> +			if (!TestSetPageHWPoison(page))
> +				hwpoisoned = true;
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&zone->lock, flags);
> +
> +	return hwpoisoned;
> +}
> +#endif

