Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37392C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0622720864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0622720864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392660AbeKVSUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:20:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:48576 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730074AbeKVSUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:20:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4CC47AD56;
        Thu, 22 Nov 2018 07:42:35 +0000 (UTC)
Date:   Thu, 22 Nov 2018 08:42:33 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 17/24] x86/speculation: Move IBPB control out of
 switch_mm()
In-Reply-To: <20181122000108.GJ13936@tassilo.jf.intel.com>
Message-ID: <nycvar.YFH.7.76.1811220838410.21108@cbobk.fhfr.pm>
References: <20181121201430.559770965@linutronix.de> <20181121201723.948990148@linutronix.de> <20181122000108.GJ13936@tassilo.jf.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018, Andi Kleen wrote:

> > +		 * This could be optimized by keeping track of the last
> > +		 * user task per cpu and avoiding the barrier when the task
> > +		 * is immediately scheduled back and the thread inbetween
> > +		 * was a kernel thread. It's dubious whether that'd be
> > +		 * worth the extra load/store and conditional operations.
> > +		 * Keep it optimized for the common case where the TIF bit
> > +		 * is not set.
> > +		 */
> 
> The optimization was there before and you removed it?
> 
> It's quite important for switching to idle and back. With your variant short IOs
> that do short idle waits will be badly impacted. 

The question is what scenario to optimize for.

Either you penalize everybody in the default prctl+seccomp setup 
(irrespective of it's TIF flag value), as you have the extra overhead on 
each and every switch_to() (to check exactly for this back-to-back 
scheduling), or you penalize only those tasks that are penalized anyway by 
the IBPB flush.

I think the latter (which is what this patch implements) makes more sense. 

Thanks,

-- 
Jiri Kosina
SUSE Labs

