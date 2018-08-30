Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F48AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D777F2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D777F2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbeH3QvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:51:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:54064 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728713AbeH3QvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:51:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 496F0AE88;
        Thu, 30 Aug 2018 12:49:16 +0000 (UTC)
Date:   Thu, 30 Aug 2018 14:49:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@elte.hu>,
        "H . Peter Anvin" <hpa@linux.intel.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86, mm: Reserver some memory for bootmem allocator for
 NO_BOOTMEM
Message-ID: <20180830124915.GH2656@dhcp22.suse.cz>
References: <20180830090319.985-1-feng.tang@intel.com>
 <20180830104401.GZ24124@hirez.programming.kicks-ass.net>
 <20180830111207.GE2656@dhcp22.suse.cz>
 <alpine.DEB.2.21.1808301352410.1210@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1808301352410.1210@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30-08-18 13:54:19, Thomas Gleixner wrote:
> On Thu, 30 Aug 2018, Michal Hocko wrote:
> > On Thu 30-08-18 12:44:02, Peter Zijlstra wrote:
> > > On Thu, Aug 30, 2018 at 05:03:19PM +0800, Feng Tang wrote:
> > > > The root cause is that when CONFIG_NO_BOOTMEM=y,  before
> > > > e820__memblock_setup() is called there is no memory for bootmem
> > > > to allocate,
> > > 
> > > Which you bloody well asked for by using NO_BOOTMEM=y.
> > > 
> > > Going down this route; adding hacks for every little thing that does
> > > want bootmem, completely defeats the purpose.
> > > 
> > > If anything, make the earlycon thing depend on NO_BOOTMEM=n. That also
> > > solves your problem. No earlycon, no panic.
> > 
> > Well, there is endeavor to remove bootmem allocator altogether. So
> > making earlycon depend on NO_BOOTMEM=n doesn't sound like a good fit to
> 
> If we want to remove bootmem, then reintroducing it with a static bootmem
> section doesn't make any sense at all.

I have actually checked the code now and see what you mean. I thought it
would be a single allocation that is needed but that is not the case so
the static buffer is not going to fly.
-- 
Michal Hocko
SUSE Labs
