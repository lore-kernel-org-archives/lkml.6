Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB6AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB342084C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB342084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeKPIjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:39:43 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42602 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeKPIjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:39:43 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 821A1949;
        Thu, 15 Nov 2018 22:30:00 +0000 (UTC)
Date:   Thu, 15 Nov 2018 14:29:59 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: cleancache: fix corruption on missed inode
 invalidation
Message-Id: <20181115142959.89ecdb6b4f24a1427062d861@linux-foundation.org>
In-Reply-To: <20181112113153.GC7175@quack2.suse.cz>
References: <20181112095734.17979-1-ptikhomirov@virtuozzo.com>
        <20181112113153.GC7175@quack2.suse.cz>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018 12:31:53 +0100 Jan Kara <jack@suse.cz> wrote:

> >  mm/truncate.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> The patch looks good but can you add a short comment before the
> truncate_inode_pages() call explaining why it needs to be called always?
> Something like:
> 
> 	 /*
> 	  * Cleancache needs notification even if there are no pages or
> 	  * shadow entries...
> 	  */

--- a/mm/truncate.c~mm-cleancache-fix-corruption-on-missed-inode-invalidation-fix
+++ a/mm/truncate.c
@@ -519,6 +519,10 @@ void truncate_inode_pages_final(struct a
 		xa_unlock_irq(&mapping->i_pages);
 	}
 
+	/*
+	 * Cleancache needs notification even if there are no pages or shadow
+	 * entries.
+	 */
 	truncate_inode_pages(mapping, 0);
 }
 EXPORT_SYMBOL(truncate_inode_pages_final);
_

