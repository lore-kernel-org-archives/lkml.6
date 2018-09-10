Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27894C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D7120865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CrLQea5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D7120865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbeIJOZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:25:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46768 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbeIJOZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=teDaSrhg7+H+jyOz/RjOG4XyXD7TJuaoxB3sbcsnQ3s=; b=CrLQea5/haCmFgpBSSBnLBBzT
        HwmZriXFFN9VBYFFDUMX77Ltz21qWTPOjjpgWln8rYTqu09xEwbMdA/Ota7jimsw8+yn+AvWL7LVh
        B9x8aWqp8E2ed6BkRkgJ+pKiaTHRLSNr6jF092R/AE+sUx31O4s1tw51Olhmni7rzwdg1Adk9lbYR
        8hCBiwUnGPv4TRBUXSuf2viYvZQzJYnHdw64/mFRGvyyAESVnWHdA7TYo00yZPENd8O5DLcTgZ89P
        P3Myd1a/xO3Y+DDQQmN9rLJ4imiwgN8b2N6aGN6TDfywhPRgGOfB/V1+Z98dMDo6ve0ATJ1x+N0g8
        iuSnhrZgQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzIY1-0000KN-Ir; Mon, 10 Sep 2018 09:31:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 607CF202B2E3D; Mon, 10 Sep 2018 11:31:56 +0200 (CEST)
Date:   Mon, 10 Sep 2018 11:31:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH] locking/rwsem: Make owner store task pointer of last
 owning reader
Message-ID: <20180910093156.GS24082@hirez.programming.kicks-ass.net>
References: <1536265114-10842-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536265114-10842-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 04:18:34PM -0400, Waiman Long wrote:
> Currently, when a reader acquires a lock, it only sets the
> RWSEM_READER_OWNED bit in the owner field. The other bits are simply
> not used. When debugging hanging cases involving rwsems and readers,
> the owner value does not provide much useful information at all.
> 
> This patch modifies the current behavior to always store the task_struct
> pointer of the last rwsem-acquiring reader in a reader-owned rwsem. This
> may be useful in debugging rwsem hanging cases especially if only one
> reader is involved. However, the task in the owner field may not the
> real owner or one of the real owners at all when the owner value is
> examined, for example, in a crash dump. So it is just an additional
> hint about the past history.
> 
> If CONFIG_DEBUG_RWSEMS is enabled, the owner field will be checked at
> unlock time too to make sure the task pointer value is valid. That does
> have a slight performance cost and so is only enabled as part of that
> debug option.
> 
> From the performance point of view, it is expected that the changes
> shouldn't have any noticeable performance impact. A rwsem microbenchmark
> (with 48 worker threads and 1:1 reader/writer ratio) was ran on a
> 2-socket 24-core 48-thread Haswell system.  The locking rates on a
> 4.19-rc1 based kernel were as follows:
> 
>   1) Unpatched kernel:				543.3 kops/s
>   2) Patched kernel:				549.2 kops/s
>   3) Patched kernel (CONFIG_DEBUG_RWSEMS on):	546.6 kops/s
> 
> There was actually a slight increase in performance (1.1%) in this
> particular case. Maybe it was caused by the elimination of a branch or
> just a testing noise. Turning on the CONFIG_DEBUG_RWSEMS option also
> had less than the expected impact on performance.
> 
> The least significant 2 bits of the owner value are now used to designate
> the rwsem is readers owned and the owners are anonymous.

So no immediate objection; but I'm still hoping to some day rewrite the
whole rwsem thing along the lines we did mutex and merge the 'count' and
'owner' fields into one.

[ RT has something along those lines, and I have half a patch that
  starts doing that too, but I never found enough time to really work on
  it :-( ]

Anyway, when we do something like that, this goes out the window of
course.
