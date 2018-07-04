Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF02C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDD123E36
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDD123E36
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeGDP40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:56:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39870 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752567AbeGDP4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:56:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08A407A9;
        Wed,  4 Jul 2018 08:56:25 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEFDF3F5AD;
        Wed,  4 Jul 2018 08:56:23 -0700 (PDT)
Date:   Wed, 4 Jul 2018 16:56:19 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [PATCHv2 06/11] atomics/treewide: rework ordering barriers
Message-ID: <20180704155618.higk5x3ngilbpxjo@lakrids.cambridge.arm.com>
References: <20180625105952.3756-1-mark.rutland@arm.com>
 <20180625105952.3756-7-mark.rutland@arm.com>
 <20180704150645.GJ4828@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704150645.GJ4828@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 04:06:46PM +0100, Will Deacon wrote:
> On Mon, Jun 25, 2018 at 11:59:47AM +0100, Mark Rutland wrote:
> > Currently architectures can override __atomic_op_*() to define the barriers
> > used before/after a relaxed atomic when used to build acquire/release/fence
> > variants.
> > 
> > This has the unfortunate property of requiring the architecture to define the
> > full wrapper for the atomics, rather than just the barriers they care about,
> > and gets in the way of generating atomics which can be easily read.
> > 
> > Instead, this patch has architectures define an optional set of barriers,
> > __atomic_mb_{before,after}_{acquire,release,fence}(), which <linux/atomic.h>
> > uses to build the wrappers.
> 
> Looks like you've renamed these in the patch but not updated the commit
> message.

Yup; Peter also pointed that out. In my branch this now looks like:

----
Instead, this patch has architectures define an optional set of barriers:

* __atomic_acquire_fence()
* __atomic_release_fence()
* __atomic_pre_fence()
* __atomic_post_fence()

... which <linux/atomic.h> uses to build the wrappers.
----

... which is hopefully more legible, too!

> Also, to add to the bikeshedding, would it worth adding "rmw" in there
> somewhere, e.g. __atomic_post_rmw_fence, since I assume these only
> apply to value-returning stuff?

I don't have any opinion there, but I'm also not sure I've parsed your
rationale correctly. I guess a !RMW full-fence op doesn't make sense? Or
that's something we want to avoid in the API?

AFAICT, we only use __atomic_{pre,post}_fence() for RMW ops today.

Thanks,
Mark.
