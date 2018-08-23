Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C75C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0965C2154E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0965C2154E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbeHWQQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 12:16:29 -0400
Received: from foss.arm.com ([217.140.101.70]:46004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729628AbeHWQQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 12:16:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60E69ED1;
        Thu, 23 Aug 2018 05:46:55 -0700 (PDT)
Received: from armageddon.cambridge.arm.com (armageddon.emea.arm.com [10.4.13.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91E1C3F5BC;
        Thu, 23 Aug 2018 05:46:52 -0700 (PDT)
Date:   Thu, 23 Aug 2018 13:46:50 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org, luto@kernel.org, x86@kernel.org,
        bp@alien8.de, will.deacon@arm.com, riel@surriel.com,
        jannh@google.com, ascannell@google.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] mm: mmu_notifier fix for tlb_end_vma
Message-ID: <20180823124649.sopnukdu4mfz6e46@armageddon.cambridge.arm.com>
References: <20180823084709.19717-1-npiggin@gmail.com>
 <20180823084709.19717-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823084709.19717-3-npiggin@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 06:47:09PM +1000, Nicholas Piggin wrote:
> The generic tlb_end_vma does not call invalidate_range mmu notifier,
> and it resets resets the mmu_gather range, which means the notifier
> won't be called on part of the range in case of an unmap that spans
> multiple vmas.
> 
> ARM64 seems to be the only arch I could see that has notifiers and
> uses the generic tlb_end_vma. I have not actually tested it.

We only care about notifiers for KVM but I think it only makes use of
mmu_notifier_invalidate_range_(start|end) which are not affected by the
range reset in mmu_gather.

Your patch looks ok from an arm64 perspective (it would be good if Will
has a look as well since he was the last to touch this part for arm64).

-- 
Catalin
