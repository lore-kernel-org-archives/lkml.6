Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9EEC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5263420652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5263420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbeJBVOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:14:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:58326 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726118AbeJBVOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:14:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DA2DFAF68;
        Tue,  2 Oct 2018 14:30:19 +0000 (UTC)
Date:   Tue, 2 Oct 2018 16:30:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mm: Randomize free memory
Message-ID: <20181002143015.GX18290@dhcp22.suse.cz>
References: <153702858249.1603922.12913911825267831671.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153702858249.1603922.12913911825267831671.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 15-09-18 09:23:02, Dan Williams wrote:
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

I have only glanced through the implementation. The boot allocator part
seems unexpectedly too large but I haven't tried to actually think about
simplification.

It is the more general idea that I am not really sure about. First of
all. Does it make _any_ sense to randomize 4MB blocks by default? Why
cannot we simply have it disabled? Then and more concerning question is,
does it even make sense to have this randomization applied to higher
orders than 0? Attacker might fragment the memory and keep recycling the
lowest order and get the predictable behavior that we have right now.
-- 
Michal Hocko
SUSE Labs
