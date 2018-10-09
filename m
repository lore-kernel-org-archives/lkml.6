Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6435BC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5E4214FA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5E4214FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeJJFfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 01:35:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59204 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJFfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 01:35:03 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 575F9B69;
        Tue,  9 Oct 2018 22:15:58 +0000 (UTC)
Date:   Tue, 9 Oct 2018 15:15:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Rik van Riel <riel@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/4] mm: zero-seek shrinkers
Message-Id: <20181009151556.5b0a3c9ae270b7551b3d12e6@linux-foundation.org>
In-Reply-To: <20181009184732.762-5-hannes@cmpxchg.org>
References: <20181009184732.762-1-hannes@cmpxchg.org>
        <20181009184732.762-5-hannes@cmpxchg.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  9 Oct 2018 14:47:33 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> The page cache and most shrinkable slab caches hold data that has been
> read from disk, but there are some caches that only cache CPU work,
> such as the dentry and inode caches of procfs and sysfs, as well as
> the subset of radix tree nodes that track non-resident page cache.
> 
> Currently, all these are shrunk at the same rate: using DEFAULT_SEEKS
> for the shrinker's seeks setting tells the reclaim algorithm that for
> every two page cache pages scanned it should scan one slab object.
> 
> This is a bogus setting. A virtual inode that required no IO to create
> is not twice as valuable as a page cache page; shadow cache entries
> with eviction distances beyond the size of memory aren't either.
> 
> In most cases, the behavior in practice is still fine. Such virtual
> caches don't tend to grow and assert themselves aggressively, and
> usually get picked up before they cause problems. But there are
> scenarios where that's not true.
> 
> Our database workloads suffer from two of those. For one, their file
> workingset is several times bigger than available memory, which has
> the kernel aggressively create shadow page cache entries for the
> non-resident parts of it. The workingset code does tell the VM that
> most of these are expendable, but the VM ends up balancing them 2:1 to
> cache pages as per the seeks setting. This is a huge waste of memory.
> 
> These workloads also deal with tens of thousands of open files and use
> /proc for introspection, which ends up growing the proc_inode_cache to
> absurdly large sizes - again at the cost of valuable cache space,
> which isn't a reasonable trade-off, given that proc inodes can be
> re-created without involving the disk.
> 
> This patch implements a "zero-seek" setting for shrinkers that results
> in a target ratio of 0:1 between their objects and IO-backed
> caches. This allows such virtual caches to grow when memory is
> available (they do cache/avoid CPU work after all), but effectively
> disables them as soon as IO-backed objects are under pressure.
> 
> It then switches the shrinkers for procfs and sysfs metadata, as well
> as excess page cache shadow nodes, to the new zero-seek setting.
> 

Seems sane, but I'm somewhat worried about unexpected effects on other
workloads.  So I think I'll hold this over for 4.20.  Or shouldn't I?

