Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512EAC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1647E20C0D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1647E20C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754595AbeGEQ2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:28:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53012 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753782AbeGEQZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:25:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C77A080D;
        Thu,  5 Jul 2018 09:25:02 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 973013F5BA;
        Thu,  5 Jul 2018 09:25:02 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id D37E01AE3638; Thu,  5 Jul 2018 17:25:42 +0100 (BST)
Date:   Thu, 5 Jul 2018 17:25:42 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [PATCHv2 06/11] atomics/treewide: rework ordering barriers
Message-ID: <20180705162542.GI14470@arm.com>
References: <20180625105952.3756-1-mark.rutland@arm.com>
 <20180625105952.3756-7-mark.rutland@arm.com>
 <20180704150645.GJ4828@arm.com>
 <20180704155618.higk5x3ngilbpxjo@lakrids.cambridge.arm.com>
 <20180704175000.GF9668@arm.com>
 <20180705101241.7q7nvmzkfsanpnbr@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705101241.7q7nvmzkfsanpnbr@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 11:12:41AM +0100, Mark Rutland wrote:
> On Wed, Jul 04, 2018 at 06:50:00PM +0100, Will Deacon wrote:
> > On Wed, Jul 04, 2018 at 04:56:19PM +0100, Mark Rutland wrote:
> > > On Wed, Jul 04, 2018 at 04:06:46PM +0100, Will Deacon wrote:
> > > > On Mon, Jun 25, 2018 at 11:59:47AM +0100, Mark Rutland wrote:
> > > > > Currently architectures can override __atomic_op_*() to define the barriers
> > > > > used before/after a relaxed atomic when used to build acquire/release/fence
> > > > > variants.
> > > > > 
> > > > > This has the unfortunate property of requiring the architecture to define the
> > > > > full wrapper for the atomics, rather than just the barriers they care about,
> > > > > and gets in the way of generating atomics which can be easily read.
> > > > > 
> > > > > Instead, this patch has architectures define an optional set of barriers,
> > > > > __atomic_mb_{before,after}_{acquire,release,fence}(), which <linux/atomic.h>
> > > > > uses to build the wrappers.
> > > > 
> > > > Looks like you've renamed these in the patch but not updated the commit
> > > > message.
> > > 
> > > Yup; Peter also pointed that out. In my branch this now looks like:
> > > 
> > > ----
> > > Instead, this patch has architectures define an optional set of barriers:
> > > 
> > > * __atomic_acquire_fence()
> > > * __atomic_release_fence()
> > > * __atomic_pre_fence()
> > > * __atomic_post_fence()
> > > 
> > > ... which <linux/atomic.h> uses to build the wrappers.
> > > ----
> > > 
> > > ... which is hopefully more legible, too!
> > > 
> > > > Also, to add to the bikeshedding, would it worth adding "rmw" in there
> > > > somewhere, e.g. __atomic_post_rmw_fence, since I assume these only
> > > > apply to value-returning stuff?
> > > 
> > > I don't have any opinion there, but I'm also not sure I've parsed your
> > > rationale correctly. I guess a !RMW full-fence op doesn't make sense? Or
> > > that's something we want to avoid in the API?
> > > 
> > > AFAICT, we only use __atomic_{pre,post}_fence() for RMW ops today.
> > 
> > No, I think you're right and my terminology is confused. Leave it as-is
> > for the moment.
> 
> Sure thing.
> 
> Perhaps __atomic_{pre,post}_full_fence() might be better, assuming
> you're trying to avoid people erroneously assuming that
> __atomic_{pre,post}_fence() are like acquire/release fences.

Good idea, I think that's better.

Will
