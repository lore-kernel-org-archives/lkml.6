Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9420C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865A3206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="sL31SYkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbfAIPth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:49:37 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42439 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729829AbfAIPth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 10:49:37 -0500
Received: by mail-qk1-f194.google.com with SMTP id 68so4645731qke.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 07:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ifKPXFQEMq0fQ31cxAeybL1uE9aV1XGxmXouYO61QQg=;
        b=sL31SYknk8WpTkM/C5wuv2NsSkrYaHFrMXBysoBFqZyGG5nW/SH79HetCFAyZTZbhC
         acXrk9Ex30VCpsPR7QZEOyFcyiXK+CKbZQVDW/E3QAcnFtgjxn2QO2PXKU2KekehUJ5P
         33xNwuDm2g+oq+gn7vhfFY/MtjCltpiA/WPF63JbG386iVs32yh3sTDtOb6jr5ou+o2H
         tDVJCd89u0oL8xIdBaCSurshAR3abXXU5/EqVtriUu3d6NoQLHLVVL8Gtu6BWZ/AF4J1
         caYWVsnT753w+3vyEyS8qkV1biLB8gxC0YwydaPmMIuzXq5jcs22xnsGnbwRe+mC8nIO
         MEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ifKPXFQEMq0fQ31cxAeybL1uE9aV1XGxmXouYO61QQg=;
        b=V9o/6jF72LyIst2b0+64e/tSlaTXY2OOaJbFKZtypryaOgvE9o6Vn93EwlgB05LOxJ
         5XQG5HDpgDIwkbmzWAt7pnUIVNU8zEbiT0VgAIH+WRVXjBdVXxaZbGrMnWsuICzSNYPp
         hAeMBocyuPgWJAHy5/GzMe5AEtXnhJIia4I9xZHaopt5EIrAVbFs6V0FBd8go8Zv6LUW
         hJCOEtDGpIOnB5RP+g/XyIwx+vkpiOF35rv9lro781PDvfeBRa6eHWtj1L4h8nH6ySbi
         kuFrpsKnO0sij2jA7wlmPnwaxq2L2MxrBUSp+jrSONwQF0QmZtF+cTw8NGIcHQEd14NN
         FR4Q==
X-Gm-Message-State: AJcUukeHV86e/KqPHsag1v+e4l1VxT0bBIpQbl6n3LARtHGZweqHjPrE
        F/2Xmcl1KI126QZlvrNC51Rt6A==
X-Google-Smtp-Source: ALg8bN4o9O15Ju/ckvL0xies2OjBsPrhsQZzawA8RdBPmCGU/Kxr6bzIaKWZhZ+VMenTXPHplUihvw==
X-Received: by 2002:a37:a904:: with SMTP id s4mr6029542qke.237.1547048975744;
        Wed, 09 Jan 2019 07:49:35 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n71sm42222769qkh.59.2019.01.09.07.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 07:49:34 -0800 (PST)
Date:   Wed, 9 Jan 2019 10:49:33 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        josef@toxicpanda.com, jack@suse.cz, hughd@google.com,
        darrick.wong@oracle.com, mhocko@suse.com, aryabinin@virtuozzo.com,
        guro@fb.com, mgorman@techsingularity.net, shakeelb@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] mm: Reduce IO by improving algorithm of memcg
 pagecache pages eviction
Message-ID: <20190109154932.tpc27dk2hzeycqex@MacBook-Pro-91.local>
References: <154703479840.32690.6504699919905946726.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154703479840.32690.6504699919905946726.stgit@localhost.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 03:20:18PM +0300, Kirill Tkhai wrote:
> On nodes without memory overcommit, it's common a situation,
> when memcg exceeds its limit and pages from pagecache are
> shrinked on reclaim, while node has a lot of free memory.
> Further access to the pages requires real device IO, while
> IO causes time delays, worse powerusage, worse throughput
> for other users of the device, etc.
> 
> Cleancache is not a good solution for this problem, since
> it implies copying of page on every cleancache_put_page()
> and cleancache_get_page(). Also, it requires introduction
> of internal per-cleancache_ops data structures to manage
> cached pages and their inodes relationships, which again
> introduces overhead.
> 
> This patchset introduces another solution. It introduces
> a new scheme for evicting memcg pages:
> 
>   1)__remove_mapping() uncharges unmapped page memcg
>     and leaves page in pagecache on memcg reclaim;
> 
>   2)putback_lru_page() places page into root_mem_cgroup
>     list, since its memcg is NULL. Page may be evicted
>     on global reclaim (and this will be easily, as
>     page is not mapped, so shrinker will shrink it
>     with 100% probability of success);
> 
>   3)pagecache_get_page() charges page into memcg of
>     a task, which takes it first.
> 
> Below is small test, which shows profit of the patchset.
> 
> Create memcg with limit 20M (exact value does not matter much):
>   $ mkdir /sys/fs/cgroup/memory/ct
>   $ echo 20M > /sys/fs/cgroup/memory/ct/memory.limit_in_bytes
>   $ echo $$ > /sys/fs/cgroup/memory/ct/tasks
> 
> Then twice read 1GB file:
>   $ time cat file_1gb > /dev/null
> 
> Before (2 iterations):
>   1)0.01user 0.82system 0:11.16elapsed 7%CPU
>   2)0.01user 0.91system 0:11.16elapsed 8%CPU
> 
> After (2 iterations):
>   1)0.01user 0.57system 0:11.31elapsed 5%CPU
>   2)0.00user 0.28system 0:00.28elapsed 100%CPU
> 
> With the patch set applied, we have file pages are cached
> during the second read, so the result is 39 times faster.
> 
> This may be useful for slow disks, NFS, nodes without
> overcommit by memory, in case of two memcg access the same
> files, etc.
> 

This isn't going to work for us (Facebook).  The whole reason the hard limit
exists is to keep different groups from messing up other groups.  Page cache
reclaim is not free, most of our pain and most of the reason we use cgroups
is to limit the effect of flooding the machine with pagecache from different
groups.  Memory leaks happen few and far between, but chef doing a yum
update in the system container happens regularly.  If you talk about suddenly
orphaning these pages to the root container it still creates pressure on the
main workload, pressure that results in it having to take time from what it's
doing and free up memory instead.  Thanks,

Josef
