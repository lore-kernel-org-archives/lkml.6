Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 18E1EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCAF208B4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jm4lMPtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCAF208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935128AbeFLQ5J (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:57:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53226 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933570AbeFLQ4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6cUjTbPz9UIsLT5O9WbWfRe5EMMyN9DO+r05K2EXxd0=; b=Jm4lMPtH8fWEBipc9VXwiA4E4
        rHAY885hQ9RHAvrAb9bL18oTWuTBXstoGxLD55iMXZ0Nh6EDrEinqufiESrsDQGyCJV06g0ohSCtm
        coRlldXr4E+RJ/oyDTz6CSrK5V+6Obm8WIAJOr3IXyL0x4hCHlDPmewdEPmQALgJ3VwQ3r0InXdyc
        +hZhGo3vPdI70epEIbCCVul9vgoP329OFgqCtVDh8mlkmEpde+V1CCm7b1zMz1agIVRLi2PiovStK
        yeNTyPt48Qp/tVx6DZEKzCxsGTw7yfgFDeVcUV+Caav77LjlTLavrqyfkeoN+gTq10mK3TE3jdOF8
        VeToZHd0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSmaz-0005ZI-7T; Tue, 12 Jun 2018 16:56:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ACDEB201EA7C9; Tue, 12 Jun 2018 18:56:35 +0200 (CEST)
Date:   Tue, 12 Jun 2018 18:56:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Arcari <darcari@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Donald Zickus <dzickus@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: Re: [PATCH] perf/x86: read the FREEZE_WHILE_SMM bit during boot
Message-ID: <20180612165635.GT12198@hirez.programming.kicks-ass.net>
References: <1528050223-144925-1-git-send-email-darcari@redhat.com>
 <20180604082414.GO12217@hirez.programming.kicks-ass.net>
 <e420bcc1-c75d-e6a1-0ca6-b668b6818f16@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e420bcc1-c75d-e6a1-0ca6-b668b6818f16@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 10:12:20AM -0400, David Arcari wrote:
> default_do_nmi() will process both perf events (local interrupts) as well as
> external interrupts (such as the NMI button).  The handler is coded such that
> if a local interrupt occurs, no check is made for an external interrupt.
> Therefore, if the two interrupts occur simultaneously, the external interrupt
> is lost.

ACK, NMI handling on x86 is less than ideal.

> The code above, which was ultimately discounted, attempts to avoid this
> scenario with as little performance impact as possible by reading the register
> without the spinlock for cpu 0 only (currently only cpu 0 can handle an
> external NMI, I verified this on my system by testing the NMI button with
> cpu 0 offline).
> 
> The code above is problematic for a number of reasons not the least of which
> is performance.  Furthermore, I don't see a less intrusive solution wrt
> do_default_nmi().

Right, because reading the register itself is dog slow IIRC.

> Upstream 6089327f5424 ("perf/x86: Add sysfs entry to freeze counters on SMI")
> appears to have made it relatively easy to hit this race condition.  On some
> systems, this commit has resulted in a change to the default firmware setting
> of DEBUGCTLMSR_FREEZE_IN_SMM_BIT (it is now cleared by the OS by default).
> 
> With this bit cleared, the following situation occurs:
> 
> 1) external NMI - due to io check
> 2) long duration SMI (counters do not freeze)
> 3) NMI handler runs and misattributes interrupt to perf event

I think 3 is wrong, because 2 will in fact have triggered a PMI (due to
long running) so 3 will observe a PMI and claim the NMI. No
misattribution what so ever.

Because if this wasn't the case, flipping FREEZE_IN_SMM wouldn't have
made a difference.

> Ultimately, my solution was to restore the previous behavior by reading and
> storing the firmware setting of the bit rather than to always clear it.

Ah, urgh.. what a mess. So the OS setting the bit to a known and
consistent value is 'good' IMO. The firmware magically frobbing things
is 'bad'.

Now, explain to me why an IO-check results in an external NMI, and why
there are long running SMI handlers around? Why can't the IO error not
be propagated through the regular device interrupt/state? Why are long
running SMIs required at all, ever? Why doesn't the OS handler whatever
it is the SMM does?

Are you not solving the wrong problem here?
