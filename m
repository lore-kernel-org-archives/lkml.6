Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC37EC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E37E21ADE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PLdSb5Sf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E37E21ADE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933191AbeFUUhD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:37:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932721AbeFUUhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sGhY4WTm00CET9wC8aqetxlub3+aTf80pa+yUUBsLK0=; b=PLdSb5SfWQt4/fOWwB7NX0XJt
        PJJqSZAVVRnKs5eAkE/a41GnI2SPa60IdaPprHaMp848BZ6DmtsqGwSKD6AWnvbA720rTSaomYxjx
        N5Bcb4ZVvgNv4rFznqmQAqrAvkS4av2A/alOlH9WEPhirnyW3sY2gXYKU57X0YUxhNNJZRffJusXL
        DOe2NCBpvsroQfXDNhyOrAz2yaQ4wxk6YLupB5hvzLPeiSQgT9oRVi8i7w8mZoLK5yn/M9rkZgOwX
        Dw9817nqlpFSga49TfGIWuzVdQpGlylJuKdbpamitXwpOtx1ebfSgPMXU2HMKhqs4PvFGQgohQEHp
        AQGL9/whg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW6KA-0004Ud-DY; Thu, 21 Jun 2018 20:36:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D854F2029FA0E; Thu, 21 Jun 2018 22:36:56 +0200 (CEST)
Date:   Thu, 21 Jun 2018 22:36:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 00/16] x86/split_lock: Enable #AC exception for split
 locked accesses
Message-ID: <20180621203656.GF27616@hirez.programming.kicks-ass.net>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
 <20180621193738.GA13636@worktop.programming.kicks-ass.net>
 <20180621201851.GC114883@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621201851.GC114883@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 01:18:52PM -0700, Fenghua Yu wrote:
> On Thu, Jun 21, 2018 at 09:37:38PM +0200, Peter Zijlstra wrote:
> > On Sun, May 27, 2018 at 08:45:49AM -0700, Fenghua Yu wrote:
> > > Currently we can trace split lock event counter for debug purpose. But
> > 
> > How? A while ago I actually tried that, but I could not find a suitable
> > perf event.
> 
> The event name is called sq_misc.split_lock. It's been supported in perf
> already.

Thanks.

> > > Intel introduces mechanism to detect split lock via alignment
> > > check exception in Tremont and other future processors. If split lock is
> > > from user process, #AC handler can kill the process or re-execute faulting
> > > instruction depending on configuration. 
> > 
> > Ideally it would #AC any unaligned (implied) LOCK prefix instruction,
> > not just across lines.
> 
> This feature only triggers #AC for unaligned cache line access, not for
> other aligned (4 bytes, 8 bytes, etc). This is not explicitly said in
> ISE. I can add this info in next version of patches.

It was clear; what I'm saying it I'd like #AC to happen for any actual
unaligned LOCK access, not just across lines.

