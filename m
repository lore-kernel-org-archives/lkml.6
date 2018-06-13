Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 316B1C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD7C2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rRXzh6gx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD7C2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934912AbeFMImr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:42:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57366 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934182AbeFMImn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9DpwGZmCm21mK463CvJk1TP+hbHB982uhRHvaedNsOg=; b=rRXzh6gxbjf/+22ja4obmS45p
        ITTnmGU57i41mwvAN6+fbrHLm/GxhT0Y+b2ddrE9ib3vsX+IlIqAWoLJUZWB9qyXOtQJYN/c8Q2X7
        P3MCQTraa61uR6GtTIfuhtjjrEmc67ajcAmS4VRuqfa9JnKsZsWOkesLOwSAuwJ9Qp2ZMdleHBuZ8
        CnCeoEG243T98VRKOKiMdfMbpk6Dk20+WBijUnRCW733wyEzTvKxGKg/37NS5ysy8OFfugYF+O9qK
        9E9D2jSwwKruhXij2Vt580FqyTzaVrF0S82CGtpTfo7BNzWMEgfnflI82wIosxL18BIkCVfj2XLSI
        dGpqQ3f5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fT1MD-0002su-Il; Wed, 13 Jun 2018 08:42:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BD82D201EA7CB; Wed, 13 Jun 2018 10:42:19 +0200 (CEST)
Date:   Wed, 13 Jun 2018 10:42:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>,
        Don Zickus <dzickus@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Weisbecker <frederic@kernel.org>,
        Babu Moger <babu.moger@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH 12/23] kernel/watchdog: Introduce a struct for NMI
 watchdog operations
Message-ID: <20180613084219.GT12258@hirez.programming.kicks-ass.net>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-13-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <20180613174141.539fc6c1@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613174141.539fc6c1@roar.ozlabs.ibm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 05:41:41PM +1000, Nicholas Piggin wrote:
> On Tue, 12 Jun 2018 17:57:32 -0700
> Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:
> 
> > Instead of exposing individual functions for the operations of the NMI
> > watchdog, define a common interface that can be used across multiple
> > implementations.
> > 
> > The struct nmi_watchdog_ops is defined for such operations. These initial
> > definitions include the enable, disable, start, stop, and cleanup
> > operations.
> > 
> > Only a single NMI watchdog can be used in the system. The operations of
> > this NMI watchdog are accessed via the new variable nmi_wd_ops. This
> > variable is set to point the operations of the first NMI watchdog that
> > initializes successfully. Even though at this moment, the only available
> > NMI watchdog is the perf-based hardlockup detector. More implementations
> > can be added in the future.
> 
> Cool, this looks pretty nice at a quick glance. sparc and powerpc at
> least have their own NMI watchdogs, it would be good to have those
> converted as well.

Yeah, agreed, this looks like half a patch.

> Is hpet a cross platform thing, or just x86? We should avoid
> proliferation of files under kernel/ I think, so with these watchdog
> driver structs then maybe implementations could go in drivers/ or
> arch/

HPET is mostly an x86 thing (altough it can be found elsewhere), but the
whole thing relies on the x86 NMI mechanism and is thus firmly arch/
material (like the sparc and ppc thing).
