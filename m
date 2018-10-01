Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF75C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E580208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E580208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbeJAVG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:06:56 -0400
Received: from foss.arm.com ([217.140.101.70]:50442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729512AbeJAVG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:06:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DFCC7A9;
        Mon,  1 Oct 2018 07:28:51 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5E1F73F5B3;
        Mon,  1 Oct 2018 07:28:51 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 0DD7E1AE3C57; Mon,  1 Oct 2018 15:29:15 +0100 (BST)
Date:   Mon, 1 Oct 2018 15:29:15 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     "Kulkarni, Ganapatrao" <Ganapatrao.Kulkarni@cavium.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>,
        "Richter, Robert" <Robert.Richter@cavium.com>,
        "Lomovtsev, Vadim" <Vadim.Lomovtsev@cavium.com>,
        Jan Glauber <Jan.Glauber@cavium.com>,
        "gklkml16@gmail.com" <gklkml16@gmail.com>
Subject: Re: [PATCH] arm_pmu: Delete incorrect cache event mapping for some
 armv8_pmuv3 events.
Message-ID: <20181001142914.GD9716@arm.com>
References: <20181001100707.16840-1-ganapatrao.kulkarni@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001100707.16840-1-ganapatrao.kulkarni@cavium.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ganapat,

On Mon, Oct 01, 2018 at 10:07:43AM +0000, Kulkarni, Ganapatrao wrote:
> Perf events L1-dcache-load-misses, L1-dcache-store-misses are mapped to
> armv8_pmuv3 (both DT and ACPI) event L1D_CACHE_REFILL. This is incorrect,
> since L1D_CACHE_REFILL counts both load and store misses.
> Similarly the events L1-dcache-loads, L1-dcache-stores, dTLB-load-misses
> and dTLB-loads are wrongly mapped. Hence Deleting all these cache events
> from armv8_pmuv3 cache mapping.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
>  arch/arm64/kernel/perf_event.c | 8 --------
>  1 file changed, 8 deletions(-)

The "generic" events are really implemented on a best-effort basis, as
they rarely tend to map exactly to what the hardware supports. I think
they originally stemmed from the x86 CPU PMU, but that doesn't really
help us.

I had a discussion with Ingo back when we originally implemented perf
because I actually preferred not to implement the generic events at all.
However, he was strongly of the opinion that a best-effort approach was
sufficient to get casual users going with the tool, so that's what we went
with.

Will
