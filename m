Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D52C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF94120851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF94120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbeLDWte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:49:34 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47300 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeLDWte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:49:34 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B54AA8A5;
        Tue,  4 Dec 2018 22:49:32 +0000 (UTC)
Date:   Tue, 4 Dec 2018 14:49:31 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, david@fromorbit.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com,
        jack@suse.cz
Subject: Re: [PATCH 0/4][V4] drop the mmap_sem when doing IO in the fault
 path
Message-Id: <20181204144931.03566f7e21615e3c2c1b18e8@linux-foundation.org>
In-Reply-To: <20181130195812.19536-1-josef@toxicpanda.com>
References: <20181130195812.19536-1-josef@toxicpanda.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 14:58:08 -0500 Josef Bacik <josef@toxicpanda.com> wrote:

> Now that we have proper isolation in place with cgroups2 we have started going
> through and fixing the various priority inversions.  Most are all gone now, but
> this one is sort of weird since it's not necessarily a priority inversion that
> happens within the kernel, but rather because of something userspace does.
> 
> We have giant applications that we want to protect, and parts of these giant
> applications do things like watch the system state to determine how healthy the
> box is for load balancing and such.  This involves running 'ps' or other such
> utilities.  These utilities will often walk /proc/<pid>/whatever, and these
> files can sometimes need to down_read(&task->mmap_sem).  Not usually a big deal,
> but we noticed when we are stress testing that sometimes our protected
> application has latency spikes trying to get the mmap_sem for tasks that are in
> lower priority cgroups.
> 
> This is because any down_write() on a semaphore essentially turns it into a
> mutex, so even if we currently have it held for reading, any new readers will
> not be allowed on to keep from starving the writer.  This is fine, except a
> lower priority task could be stuck doing IO because it has been throttled to the
> point that its IO is taking much longer than normal.  But because a higher
> priority group depends on this completing it is now stuck behind lower priority
> work.
> 
> In order to avoid this particular priority inversion we want to use the existing
> retry mechanism to stop from holding the mmap_sem at all if we are going to do
> IO.  This already exists in the read case sort of, but needed to be extended for
> more than just grabbing the page lock.  With io.latency we throttle at
> submit_bio() time, so the readahead stuff can block and even page_cache_read can
> block, so all these paths need to have the mmap_sem dropped.
> 
> The other big thing is ->page_mkwrite.  btrfs is particularly shitty here
> because we have to reserve space for the dirty page, which can be a very
> expensive operation.  We use the same retry method as the read path, and simply
> cache the page and verify the page is still setup properly the next pass through
> ->page_mkwrite().

Seems reasonable.  I have a few minorish changeloggish comments.

We're at v4 and no acks have been gathered?
