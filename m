Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4197C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5822173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfAJK4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:56:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:44462 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727455AbfAJK4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:56:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D8BF3AEC6;
        Thu, 10 Jan 2019 10:56:41 +0000 (UTC)
Date:   Thu, 10 Jan 2019 10:56:38 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Michal Hocko <mhocko@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>, keith.busch@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] mm: Shuffle initial free memory to improve
 memory-side-cache utilization
Message-ID: <20190110105638.GJ28934@suse.de>
References: <154690326478.676627.103843791978176914.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154690327057.676627.18166704439241470885.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <154690327057.676627.18166704439241470885.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 03:21:10PM -0800, Dan Williams wrote:
> Randomization of the page allocator improves the average utilization of
> a direct-mapped memory-side-cache. Memory side caching is a platform
> capability that Linux has been previously exposed to in HPC
> (high-performance computing) environments on specialty platforms. In
> that instance it was a smaller pool of high-bandwidth-memory relative to
> higher-capacity / lower-bandwidth DRAM. Now, this capability is going to
> be found on general purpose server platforms where DRAM is a cache in
> front of higher latency persistent memory [1].
> 

So I glanced through the series and while I won't nak it, I'm not a
major fan either so I won't ack it either. While there are merits to
randomisation in terms of cache coloring, it may not be robust. IIRC, the
main strength of randomisation vs being smart was "it's simple and usually
doesn't fall apart completely". In particular I'd worry that compaction
will undo all the randomisation work by moving related pages into the same
direct-mapped lines. Furthermore, the runtime list management of "randomly
place and head or tail of list" will have variable and non-deterministic
outcomes and may also be undone by either high-order merging or compaction.

As bad as it is, an ideal world would have a proper cache-coloring
allocation algorithm but they previously failed as the runtime overhead
exceeded the actual benefit, particularly as fully associative caches
became more popular and there was no universal "one solution fits all". One
hatchet job around it may be to have per-task free-lists that put free
pages into buckets with the obvious caveat that those lists would need
draining and secondary locking. A caveat of that is that there may need
to be arch and/or driver hooks to detect how the colors are managed which
could also turn into a mess.

The big plus of the series is that it's relatively simple and appears to
be isolated enough that it only has an impact when the necessary hardware
in place. It will deal with some cases but I'm not sure it'll survive
long-term, particularly if HPC continues to report in the field that
reboots are necessary to reshufffle the lists (taken from your linked
documents). That workaround of running STREAM before a job starts and
rebooting the machine if the performance SLAs are not met is horrid.

-- 
Mel Gorman
SUSE Labs
