Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2097DC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5887218FF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfBHWtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:49:47 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37890 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfBHWtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:49:47 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 83684C36C;
        Fri,  8 Feb 2019 22:49:45 +0000 (UTC)
Date:   Fri, 8 Feb 2019 14:49:44 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>, Chris Mason <clm@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>
Subject: Re: [PATCH 1/2] Revert
 "mm: don't reclaim inodes with many attached pages"
Message-Id: <20190208144944.082a771e84f02a77bad3e292@linux-foundation.org>
In-Reply-To: <20190208125049.GA11587@quack2.suse.cz>
References: <20190130041707.27750-1-david@fromorbit.com>
        <20190130041707.27750-2-david@fromorbit.com>
        <25EAF93D-BC63-4409-AF21-F45B2DDF5D66@fb.com>
        <20190131013403.GI4205@dastard>
        <20190131091011.GP18811@dhcp22.suse.cz>
        <20190131185704.GA8755@castle.DHCP.thefacebook.com>
        <20190131221904.GL4205@dastard>
        <20190207102750.GA4570@quack2.suse.cz>
        <20190207213727.a791db810341cec2c013ba93@linux-foundation.org>
        <20190208095507.GB6353@quack2.suse.cz>
        <20190208125049.GA11587@quack2.suse.cz>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2019 13:50:49 +0100 Jan Kara <jack@suse.cz> wrote:

> > > Has anyone done significant testing with Rik's maybe-fix?
> > 
> > I will give it a spin with bonnie++ today. We'll see what comes out.
> 
> OK, I did a bonnie++ run with Rik's patch (on top of 4.20 to rule out other
> differences). This machine does not show so big differences in bonnie++
> numbers but the difference is still clearly visible. The results are
> (averages of 5 runs):
> 
> 		 Revert			Base			Rik
> SeqCreate del    78.04 (   0.00%)	98.18 ( -25.81%)	90.90 ( -16.48%)
> RandCreate del   87.68 (   0.00%)	95.01 (  -8.36%)	87.66 (   0.03%)
> 
> 'Revert' is 4.20 with "mm: don't reclaim inodes with many attached pages"
> and "mm: slowly shrink slabs with a relatively small number of objects"
> reverted. 'Base' is the kernel without any reverts. 'Rik' is a 4.20 with
> Rik's patch applied.
> 
> The numbers are time to do a batch of deletes so lower is better. You can see
> that the patch did help somewhat but it was not enough to close the gap
> when files are deleted in 'readdir' order.

OK, thanks.

I guess we need a rethink on Roman's fixes.   I'll queued the reverts.


BTW, one thing I don't think has been discussed (or noticed) is the
effect of "mm: don't reclaim inodes with many attached pages" on 32-bit
highmem machines.  Look why someone added that code in the first place:

: commit f9a316fa9099053a299851762aedbf12881cff42
: Author: Andrew Morton <akpm@digeo.com>
: Date:   Thu Oct 31 04:09:37 2002 -0800
: 
:     [PATCH] strip pagecache from to-be-reaped inodes
:     
:     With large highmem machines and many small cached files it is possible
:     to encounter ZONE_NORMAL allocation failures.  This can be demonstrated
:     with a large number of one-byte files on a 7G machine.
:     
:     All lowmem is filled with icache and all those inodes have a small
:     amount of highmem pagecache which makes them unfreeable.
:     
:     The patch strips the pagecache from inodes as they come off the tail of
:     the inode_unused list.
:     
:     I play tricks in there peeking at the head of the inode_unused list to
:     pick up the inode again after running iput().  The alternatives seemed
:     to involve more widespread changes.
:     
:     Or running invalidate_inode_pages() under inode_lock which would be a
:     bad thing from a scheduling latency and lock contention point of view.

I guess I shold have added a comment.  Doh.
