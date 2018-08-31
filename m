Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7125CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12EBA2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12EBA2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbeHaEZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 00:25:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52524 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeHaEZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 00:25:51 -0400
Received: from localhost.localdomain (c-24-4-154-175.hsd1.ca.comcast.net [24.4.154.175])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CFBA6EB7;
        Fri, 31 Aug 2018 00:21:07 +0000 (UTC)
Date:   Thu, 30 Aug 2018 17:21:05 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] scripts: add kmemleak2pprof.py for slab usage
 analysis
Message-Id: <20180830172105.3f30f3831c370f51e2067a6c@linux-foundation.org>
In-Reply-To: <20180830072939.i33m43mj7uslhvmz@axis.com>
References: <20180828103914.30434-1-vincent.whitchurch@axis.com>
        <20180828103914.30434-2-vincent.whitchurch@axis.com>
        <20180828162804.4ee225124cbde3f39f53fd80@linux-foundation.org>
        <20180830072939.i33m43mj7uslhvmz@axis.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 09:29:40 +0200 Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:

> On Tue, Aug 28, 2018 at 04:28:04PM -0700, Andrew Morton wrote:
> > On Tue, 28 Aug 2018 12:39:14 +0200 Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
> > 
> > > Add a script which converts /sys/kernel/debug/kmemleak_all to the pprof
> > > format, which can be used for analysing memory usage.  See
> > > https://github.com/google/pprof.
> > 
> > Why is this better than /proc/slabinfo?
> 
> slabinfo just tells you how much memory is being used in a particular
> slab, it doesn't give you a breakdown of who allocated all that memory.
> slabinfo can't also tell you how much memory a particular subsystem is
> using.
> 
> For example, here we can see that tracer_init_tracefs() and its callers
> are using ~12% of the total tracked memory:
> 
>  $ pprof -top -compact_labels -cum prof 
>  Showing nodes accounting for 13418.95kB, 92.07% of 14575.28kB total
>  Dropped 4069 nodes (cum <= 72.88kB)
>        flat  flat%   sum%        cum   cum%
>        ...
>           0     0% 56.71%  1832.15kB 12.57%  tracer_init_tracefs+0x74/0x1cc
> 
>  
> And that tracefs' dentrys use 500 KiB and its inodes use 1+ MiB:
>  	
>  $ pprof -text -compact_labels -focus tracer_init_tracefs -nodecount 2 prof
>  Main binary filename not available.
>  Showing nodes accounting for 1794.85kB, 12.31% of 14575.28kB total
>  Dropped 1912 nodes (cum <= 72.88kB)
>  Showing top 2 nodes out of 32
>        flat  flat%   sum%        cum   cum%
>   1294.56kB  8.88%  8.88%  1294.56kB  8.88%  new_inode_pseudo+0x8/0x4c
>    500.29kB  3.43% 12.31%   500.29kB  3.43%  d_alloc+0x10/0x78
>    ...

OK, thanks.  Please include this info in future changelogs?
