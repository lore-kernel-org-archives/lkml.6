Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9EDC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA112083E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA112083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934143AbeGDIqp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:46:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:37190 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932148AbeGDIqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:46:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 29DC3AFF3;
        Wed,  4 Jul 2018 08:46:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D574EDAA1D; Wed,  4 Jul 2018 10:46:41 +0200 (CEST)
Date:   Wed, 4 Jul 2018 10:46:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] refcount: always allow checked forms
Message-ID: <20180704084641.GL3126@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
References: <20180703100102.16615-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703100102.16615-1-mark.rutland@arm.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 11:01:02AM +0100, Mark Rutland wrote:
> In many cases, it would be useful to be able to use the full
> sanity-checked refcount helpers regardless of CONFIG_REFCOUNT_FULL, as
> this would help to avoid duplicate warnings where callers try to
> sanity-check refcount manipulation.
> 
> This patch refactors things such that the full refcount helpers were
> always built, as refcount_${op}_checked(), such that they can be used
> regardless of CONFIG_REFCOUNT_FULL. This will allow code which *always*
> wants a checked refcount to opt-in, avoiding the need to duplicate the
> logic for warnings.
> 
> There should be no functional change as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: David Sterba <dsterba@suse.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>

I dare to give it my

Reviewed-by: David Sterba <dsterba@suse.com>

as my POC implementations were crap and Mark's version is much better.

> ---
>  include/linux/refcount.h | 27 +++++++++++++++++-------
>  lib/refcount.c           | 53 +++++++++++++++++++++++-------------------------
>  2 files changed, 45 insertions(+), 35 deletions(-)
> 
> Dave pointed out that it would be useful to be able to opt-in to full checks
> regardless of CONFIG_REFCOUNT_FULL, so that we can simplify callsites where we
> always want checks. I've spotted a few of these in code which is still awaiting
> conversion.

The motivation was code like

	WARN_ON(refcount_read(&ref));
	if (refcount_dec_and_test(&ref)) { ... }

so the warning is redundant for REFCOUNT_FULL, but I'm going to use the
_checked versions everywhere the performance of refcounts is not
critical.
