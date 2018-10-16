Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7A3C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CAAF21470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CAAF21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeJQGUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:20:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44078 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbeJQGUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:20:20 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7A8172936;
        Tue, 16 Oct 2018 22:27:49 +0000 (UTC)
Date:   Tue, 16 Oct 2018 15:27:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/4] mm: workingset: add vmstat counter for shadow nodes
Message-Id: <20181016152748.28b6df15a0410447c3abdc2a@linux-foundation.org>
In-Reply-To: <20181016084923.GH5819@techsingularity.net>
References: <20181009184732.762-1-hannes@cmpxchg.org>
        <20181009184732.762-4-hannes@cmpxchg.org>
        <20181009150845.8656eb8ede045ca5f4cc4b21@linux-foundation.org>
        <20181016084923.GH5819@techsingularity.net>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 09:49:23 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:

> > Can we do this?
> > 
> > --- a/mm/workingset.c~mm-workingset-add-vmstat-counter-for-shadow-nodes-fix
> > +++ a/mm/workingset.c
> > @@ -377,6 +377,8 @@ void workingset_update_node(struct radix
> >  	 * already where they should be. The list_empty() test is safe
> >  	 * as node->private_list is protected by the i_pages lock.
> >  	 */
> > +	WARN_ON_ONCE(!irqs_disabled());	/* For __inc_lruvec_page_state */
> > +
> >  	if (node->count && node->count == node->exceptional) {
> >  		if (list_empty(&node->private_list)) {
> >  			list_lru_add(&shadow_nodes, &node->private_list);
> 
> Note that for whatever reason, I've observed that irqs_disabled() is
> actually quite an expensive call. I'm not saying the warning is a bad
> idea but it should not be sprinkled around unnecessary and may be more
> suitable as a debug option.

Yup, it is now VM_WARN_ON_ONCE().
