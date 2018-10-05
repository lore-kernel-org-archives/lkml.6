Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E54C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32B82087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32B82087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeJEUct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:32:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51808 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbeJEUct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:32:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0E2C7A9;
        Fri,  5 Oct 2018 06:34:04 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8F9B63F5B3;
        Fri,  5 Oct 2018 06:34:04 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 8C0081AE3326; Fri,  5 Oct 2018 14:34:29 +0100 (BST)
Date:   Fri, 5 Oct 2018 14:34:29 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Ganapatrao Kulkarni <gklkml16@gmail.com>
Cc:     Ganapatrao Kulkarni <Ganapatrao.Kulkarni@cavium.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>,
        Robert Richter <Robert.Richter@cavium.com>,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
Subject: Re: [PATCH] arm_pmu: Delete incorrect cache event mapping for some
 armv8_pmuv3 events.
Message-ID: <20181005133428.GF14398@arm.com>
References: <20181001100707.16840-1-ganapatrao.kulkarni@cavium.com>
 <20181001142914.GD9716@arm.com>
 <CAKTKpr6SQUc9EgdYL2N32a=szUmSs82Mbb4y89htbVQhTPp2rQ@mail.gmail.com>
 <CAKTKpr5+p=X6QcRp+tsxYYgirwWW=cfs7GOKyKegutEfM_W2vg@mail.gmail.com>
 <20181004122207.GE4065@arm.com>
 <CAKTKpr4a12FHkMtFNueWqQbAhT4TLw_4DLDrOD6Tjsbno28U3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKTKpr4a12FHkMtFNueWqQbAhT4TLw_4DLDrOD6Tjsbno28U3A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 01:09:33AM +0530, Ganapatrao Kulkarni wrote:
> On Thu, Oct 4, 2018 at 5:51 PM Will Deacon <will.deacon@arm.com> wrote:
> > On Thu, Oct 04, 2018 at 11:12:09AM +0530, Ganapatrao Kulkarni wrote:
> > > can you please pull this patch?
> >
> > I still don't like the idea of just removing events like this, especially
> > when other architectures (including some x86 and Power CPUs afaict) playa
> > similar games for generic events, and these events do actually appear in
> > user code.
> >
> > I also don't understand why you remove the TLB events. I think that logic
> > would imply we should remove all of the events, because we can't distinguish
> > prefetches from reads either. If we want to be consistent, then I think
> > we should just remove the OP_WRITE events for L1D and BPU -- would you be
> > ok with that instead?
> 
> IIUC, dTLB-load-misses is mapped to
> ARMV8_PMUV3_PERFCTR_L1D_TLB_REFILL(event 0x05) and dTLB-loads is
> mapped to ARMV8_PMUV3_PERFCTR_L1D_TLB(0x25). Which are as per spec,
> counts TLB access/misses for both memory-read operation and
> memory-write operation.
> 
> IMO, It won't help in keeping these events, knowingly that their
> mapping is not accurate, only thing i can say to users is , dont use
> events that are marked as "Hardware cache event"

Right, but my point is that all of the events are inaccurate by this line
of reasoning, because we don't support PREFETCH for any of them. So I'd
rather just drop the duplicate events from the WRITE entries, like other
CPUs and architectures do.

I'm about to pack my desk up because we're moving office, but I pushed out
some patches I hacked up on my perf/updates branch:

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=perf/updates

I'll post them to the list next week if it's not the merge window.

Will
