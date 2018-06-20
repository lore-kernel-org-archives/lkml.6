Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81F7C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61624208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61624208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754590AbeFTIdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:33:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:57406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754290AbeFTIdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:33:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7E7E8AC53;
        Wed, 20 Jun 2018 07:17:10 +0000 (UTC)
Date:   Wed, 20 Jun 2018 09:17:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, willy@infradead.org,
        ldufour@linux.vnet.ibm.com, akpm@linux-foundation.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 PATCH 2/2] mm: mmap: zap pages with read mmap_sem for
 large mapping
Message-ID: <20180620071708.GI13685@dhcp22.suse.cz>
References: <1529364856-49589-1-git-send-email-yang.shi@linux.alibaba.com>
 <1529364856-49589-3-git-send-email-yang.shi@linux.alibaba.com>
 <20180619100218.GN2458@hirez.programming.kicks-ass.net>
 <f78924fc-ea81-9ddd-ebb2-28241d5721c8@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f78924fc-ea81-9ddd-ebb2-28241d5721c8@linux.alibaba.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19-06-18 14:13:05, Yang Shi wrote:
> 
> 
> On 6/19/18 3:02 AM, Peter Zijlstra wrote:
[...]
> > Hold up, two things: you having to copy most of do_munmap() didn't seem
> > to suggest a helper function? And second, since when are we allowed to
> 
> Yes, they will be extracted into a helper function in the next version.
> 
> May bad, I don't think it is allowed. We could reform this to:
> 
> acquire write mmap_sem
> vma lookup (split vmas)
> release write mmap_sem
> 
> acquire read mmap_sem
> zap pages
> release read mmap_sem
> 
> I'm supposed this is safe as what Michal said before.

I didn't get to read your patches carefully yet but I am wondering why
do you need to split in the first place. Why cannot you simply unmap the
range (madvise(DONTNEED)) under the read lock and then take the lock for
write to finish the rest?
-- 
Michal Hocko
SUSE Labs
