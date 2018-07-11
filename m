Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B813FC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D229208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D229208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeGKFwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 01:52:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56834 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbeGKFwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 01:52:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFC7580D;
        Tue, 10 Jul 2018 22:49:50 -0700 (PDT)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60AF13F318;
        Tue, 10 Jul 2018 22:49:49 -0700 (PDT)
Date:   Wed, 11 Jul 2018 06:49:46 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     dsterba@suse.cz, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] refcount: always allow checked forms
Message-ID: <20180711054946.wdkfoou6kt2a2vml@salmiak>
References: <20180703100102.16615-1-mark.rutland@arm.com>
 <20180704084641.GL3126@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704084641.GL3126@suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 10:46:41AM +0200, David Sterba wrote:
> On Tue, Jul 03, 2018 at 11:01:02AM +0100, Mark Rutland wrote:
> > In many cases, it would be useful to be able to use the full
> > sanity-checked refcount helpers regardless of CONFIG_REFCOUNT_FULL, as
> > this would help to avoid duplicate warnings where callers try to
> > sanity-check refcount manipulation.
> > 
> > This patch refactors things such that the full refcount helpers were
> > always built, as refcount_${op}_checked(), such that they can be used
> > regardless of CONFIG_REFCOUNT_FULL. This will allow code which *always*
> > wants a checked refcount to opt-in, avoiding the need to duplicate the
> > logic for warnings.
> > 
> > There should be no functional change as a result of this patch.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: David Sterba <dsterba@suse.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> 
> I dare to give it my
> 
> Reviewed-by: David Sterba <dsterba@suse.com>

Cheers!

> as my POC implementations were crap and Mark's version is much better.

Please don't think that your implementations were bad; I just already had an
idea as to what this could look like.

> > ---
> >  include/linux/refcount.h | 27 +++++++++++++++++-------
> >  lib/refcount.c           | 53 +++++++++++++++++++++++-------------------------
> >  2 files changed, 45 insertions(+), 35 deletions(-)
> > 
> > Dave pointed out that it would be useful to be able to opt-in to full checks
> > regardless of CONFIG_REFCOUNT_FULL, so that we can simplify callsites where we
> > always want checks. I've spotted a few of these in code which is still awaiting
> > conversion.
> 
> The motivation was code like
> 
> 	WARN_ON(refcount_read(&ref));
> 	if (refcount_dec_and_test(&ref)) { ... }
> 
> so the warning is redundant for REFCOUNT_FULL, but I'm going to use the
> _checked versions everywhere the performance of refcounts is not
> critical.

If you will have conversion patches, do you want to pick this up as the start
of a series?

Thanks,
Mark.
