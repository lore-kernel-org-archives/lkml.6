Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6403C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9412021760
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9412021760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932723AbeFYLsh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:48:37 -0400
Received: from foss.arm.com ([217.140.101.70]:55356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932211AbeFYLse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:48:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C7A618A;
        Mon, 25 Jun 2018 04:48:33 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AB2E3F59C;
        Mon, 25 Jun 2018 04:48:31 -0700 (PDT)
Date:   Mon, 25 Jun 2018 12:48:20 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCHv2 03/11] atomics: simplify cmpxchg() instrumentation
Message-ID: <20180625114820.zhrhcyy4s47n4r5e@lakrids.cambridge.arm.com>
References: <20180625105952.3756-1-mark.rutland@arm.com>
 <20180625105952.3756-4-mark.rutland@arm.com>
 <20180625113803.GA13628@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625113803.GA13628@andrea>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 01:38:03PM +0200, Andrea Parri wrote:
> On Mon, Jun 25, 2018 at 11:59:44AM +0100, Mark Rutland wrote:
> > Currently we define some fairly verbose wrappers for the cmpxchg()
> > family so that we can pass a pointer and size into kasan_check_write().
> > 
> > The wrapper duplicate the size-switching logic necessary in arch code,
> > and only work for scalar types. On some architectures, (cmp)xchg are
> > used on non-scalar types, and thus the instrumented wrappers need to be
> > able to handle this.
> > 
> > We could take the type-punning logic form {READ,WRITE}_ONCE(), but this
> > makes the wrappers even more verbose, and requires several local
> > variables in the macros.
> > 
> > Instead, let's simplify the wrappers into simple macros which:
> > 
> >  * snapshot the pointer into a single local variable, called __ai_ptr to
> >    avoid conflicts with variables in the scope of the caller.
> > 
> >  * call kasan_check_read() on __ai_ptr.
> 
> Maybe I'm misreading the diff: aren't you calling kasan_check_write()?

Sorry, yes -- I'll update the commit message.

> (not sure if it makes a difference in this case/for KTSan, but CMPXCHG
> does not necessarily perform a write...)

For KASAN, it shouldn't matter -- it'll only be used to report whether
the access was a read or write, and it's fine to say that it's a
potential write. KTSAN's not yet upstream, so I'll leave that detail to
Dmitry.

Thanks,
Mark.
