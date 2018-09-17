Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B53ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B702146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B702146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732646AbeIREmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:42:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50808 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbeIREmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:42:18 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B50F1707;
        Mon, 17 Sep 2018 23:12:46 +0000 (UTC)
Date:   Mon, 17 Sep 2018 16:12:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mm: Randomize free memory
Message-Id: <20180917161245.c4bb8546d2c6069b0506c5dd@linux-foundation.org>
In-Reply-To: <153702858249.1603922.12913911825267831671.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153702858249.1603922.12913911825267831671.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Sep 2018 09:23:02 -0700 Dan Williams <dan.j.williams@intel.com> wrote:

> Data exfiltration attacks via speculative execution and
> return-oriented-programming attacks rely on the ability to infer the
> location of sensitive data objects. The kernel page allocator, has
> predictable first-in-first-out behavior for physical pages. Pages are
> freed in physical address order when first onlined. There are also
> mechanisms like CMA that can free large contiguous areas at once
> increasing the predictability of allocations in physical memory.
> 
> In addition to the security implications this randomization also
> stabilizes the average performance of direct-mapped memory-side caches.
> This includes memory-side caches like the one on the Knights Landing
> processor and those generally described by the ACPI HMAT (Heterogeneous
> Memory Attributes Table [1]). Cache conflicts are spread over a random
> distribution rather than localized.
> 
> Given the performance sensitivity of the page allocator this
> randomization is only performed for MAX_ORDER (4MB by default) pages. A
> kernel parameter, page_alloc.shuffle_page_order, is included to change
> the page size where randomization occurs.
> 
> [1]: See ACPI 6.2 Section 5.2.27.5 Memory Side Cache Information Structure 

I'm struggling to understand the justification of all of this.  Are
such attacks known to exist?  Or reasonably expected to exist in the
future?  What is the likelihood and what is their cost?  Or is this all
academic and speculative and possibly pointless?

ie, something must have motivated you to do this work rather than
<something-else>.  Please spell out that motivation.


The new module parameter should be documented, please.  Let's try to
help people understand why they might ever want to alter the default
and if so, what settings they should be trying.


How come we aren't also shuffling at memory hot-add time?
