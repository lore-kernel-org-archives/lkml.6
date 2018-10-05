Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7002C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9EF206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9EF206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbeJETht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:37:49 -0400
Received: from foss.arm.com ([217.140.101.70]:50984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbeJETht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 15:37:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF2CD7A9;
        Fri,  5 Oct 2018 05:39:16 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BE9A43F5A0;
        Fri,  5 Oct 2018 05:39:16 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id C0D101AE3326; Fri,  5 Oct 2018 13:39:41 +0100 (BST)
Date:   Fri, 5 Oct 2018 13:39:41 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Ganapatrao Kulkarni <gklkml16@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>,
        Jan.Glauber@cavium.com, Peter Zijlstra <peterz@infradead.org>,
        catalin.marinas@arm.com, LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Robert Richter <Robert.Richter@cavium.com>,
        Ingo Molnar <mingo@redhat.com>, Vadim.Lomovtsev@cavium.com,
        Ganapatrao Kulkarni <Ganapatrao.Kulkarni@cavium.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm_pmu: Delete incorrect cache event mapping for some
 armv8_pmuv3 events.
Message-ID: <20181005123941.GD14398@arm.com>
References: <20181001100707.16840-1-ganapatrao.kulkarni@cavium.com>
 <20181001142914.GD9716@arm.com>
 <CAKTKpr6SQUc9EgdYL2N32a=szUmSs82Mbb4y89htbVQhTPp2rQ@mail.gmail.com>
 <CAKTKpr5+p=X6QcRp+tsxYYgirwWW=cfs7GOKyKegutEfM_W2vg@mail.gmail.com>
 <20181004122207.GE4065@arm.com>
 <b04c43bd-5c90-cc06-e2cc-ce542981853a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b04c43bd-5c90-cc06-e2cc-ce542981853a@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 01:27:08PM +0100, John Garry wrote:
> On 04/10/2018 13:22, Will Deacon wrote:
> >Hi Ganapat,
> >
> >On Thu, Oct 04, 2018 at 11:12:09AM +0530, Ganapatrao Kulkarni wrote:
> >>can you please pull this patch?
> >
> >I still don't like the idea of just removing events like this, especially
> >when other architectures (including some x86 and Power CPUs afaict) playa
> >similar games for generic events, and these events do actually appear in
> >user code.
> >
> >I also don't understand why you remove the TLB events. I think that logic
> >would imply we should remove all of the events, because we can't distinguish
> >prefetches from reads either. If we want to be consistent, then I think
> >we should just remove the OP_WRITE events for L1D and BPU -- would you be
> >ok with that instead?
> >
> >Also, looking at the code, I think our PMCEID parsing is broken for 8.1
> >parts, where the upper 32 bits of the register are offset by 0x4000 in the
> >event numbering space.
> >
> 
> Here's something I noticed:
> static ssize_t
> armv8pmu_events_sysfs_show(struct device *dev,
> 			   struct device_attribute *attr, char *page)
> {
> 	struct perf_pmu_events_attr *pmu_attr;
> 
> 	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
> 
> 	return sprintf(page, "event=0x%03llx\n", pmu_attr->id);
> 
> Should this be min width now be 4, since event width is now 16 bits (even
> though I don't know why we need to specify this width at all)?

Yeah, that is pretty weird, but the 16-bit events won't be truncated, so
I think I'd rather just leave that string as-is since it's ABI. I agree
that we probably shouldn't have bothered with the width at all in hindsight.

Will
