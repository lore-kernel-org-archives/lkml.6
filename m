Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCB5C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8019F25025
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8019F25025
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932174AbeGBVsB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:48:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37350 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753544AbeGBVr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:47:59 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F12B7CB7;
        Mon,  2 Jul 2018 21:47:57 +0000 (UTC)
Date:   Mon, 2 Jul 2018 14:47:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/14][V5] Introduce io.latency io controller for
 cgroups
Message-Id: <20180702144757.0138984124f97bf0b8f8de31@linux-foundation.org>
In-Reply-To: <08f3bef3-7189-a368-74d9-b4c5e0edc824@kernel.dk>
References: <20180629192542.26649-1-josef@toxicpanda.com>
        <20180702142639.752759da566fd9074cf8edfe@linux-foundation.org>
        <08f3bef3-7189-a368-74d9-b4c5e0edc824@kernel.dk>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2018 15:41:48 -0600 Jens Axboe <axboe@kernel.dk> wrote:

> On 7/2/18 3:26 PM, Andrew Morton wrote:
> > On Fri, 29 Jun 2018 15:25:28 -0400 Josef Bacik <josef@toxicpanda.com> wrote:
> > 
> >> This series adds a latency based io controller for cgroups.  It is based on the
> >> same concept as the writeback throttling code, which is watching the overall
> >> total latency of IO's in a given window and then adjusting the queue depth of
> >> the group accordingly.  This is meant to be a workload protection controller, so
> >> whoever has the lowest latency target gets the preferential treatment with no
> >> thought to fairness or proportionality.  It is meant to be work conserving, so
> >> as long as nobody is missing their latency targets the disk is fair game.
> >>
> >> We have been testing this in production for several months now to get the
> >> behavior right and we are finally at the point that it is working well in all of
> >> our test cases.  With this patch we protect our main workload (the web server)
> >> and isolate out the system services (chef/yum/etc).  This works well in the
> >> normal case, smoothing out weird request per second (RPS) dips that we would see
> >> when one of the system services would run and compete for IO resources.  This
> >> also works incredibly well in the runaway task case.
> >>
> >> The runaway task usecase is where we have some task that slowly eats up all of
> >> the memory on the system (think a memory leak).  Previously this sort of
> >> workload would push the box into a swapping/oom death spiral that was only
> >> recovered by rebooting the box.  With this patchset and proper configuration of
> >> the memory.low and io.latency controllers we're able to survive this test with a
> >> at most 20% dip in RPS.
> > 
> > Is this purely useful for spinning disks, or is there some
> > applicability to SSDs and perhaps other storage devices?  Some
> > discussion on this topic would be useful.
> > 
> > Patches 5, 7 & 14 look fine to me - go wild.  #14 could do with a
> > couple of why-we're-doing-this comments, but I say that about
> > everything ;)
> 
> I want to queue this up for 4.19 shortly - is the above an acked-by? Andrewed-by?
> Which do you prefer? :-)

Quacked-at-by: Andrew

Hannes's acks are good.  Feel free to add mine as well ;)
