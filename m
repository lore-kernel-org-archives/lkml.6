Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FD1C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E66720882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E66720882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbeGYKGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:06:51 -0400
Received: from foss.arm.com ([217.140.101.70]:34226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728553AbeGYKGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:06:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B0EB80D;
        Wed, 25 Jul 2018 01:56:08 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E670D3F237;
        Wed, 25 Jul 2018 01:56:06 -0700 (PDT)
Date:   Wed, 25 Jul 2018 09:56:04 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Dirk Mueller <dmueller@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Alex Graf <agraf@suse.de>
Subject: Re: [PATCH] arm64: Check for errata before evaluating cpu features
Message-ID: <20180725085604.GB4240@e103592.cambridge.arm.com>
References: <20180725083504.25836-1-dmueller@suse.com>
 <aea2daa9-40ef-2066-0da9-0770c3c50dfb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aea2daa9-40ef-2066-0da9-0770c3c50dfb@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 09:51:53AM +0100, Suzuki K Poulose wrote:
> On 07/25/2018 09:35 AM, Dirk Mueller wrote:
> >Since commit d3aec8a28be3b8 ("arm64: capabilities: Restrict KPTI
> >detection to boot-time CPUs") we rely on errata flags being already
> >populated during feature enumeration. The order of errata and
> >features was flipped as part of commit ed478b3f9e4a ("arm64:
> >capabilities: Group handling of features and errata workarounds").
> >
> >Return to the orginal order of errata and feature evaluation to
> >ensure errata flags are present during feature evaluation.
> >
> >Fixes: d3aec8a28be3b8 ("arm64: capabilities: Restrict KPTI
> >detection to boot-time CPUs")
> >CC: Suzuki K Poulose <suzuki.poulose@arm.com>
> >CC: Marc Zyngier <marc.zyngier@arm.com>
> >Signed-off-by: Dirk Mueller <dmueller@suse.com>
> 
> It would be good to add "Fixes: ed478b3f9e4a" (instead), just to make
> sure this gets fixed everywhere the original problem appears.
> 
> >---
> >  arch/arm64/kernel/cpufeature.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> >index f24892a40d2c..c6d80743f4ed 100644
> >--- a/arch/arm64/kernel/cpufeature.c
> >+++ b/arch/arm64/kernel/cpufeature.c
> >@@ -1351,9 +1351,9 @@ static void __update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
> >  static void update_cpu_capabilities(u16 scope_mask)
> >  {
> >-	__update_cpu_capabilities(arm64_features, scope_mask, "detected:");
> >  	__update_cpu_capabilities(arm64_errata, scope_mask,
> >  				  "enabling workaround for");
> >+	__update_cpu_capabilities(arm64_features, scope_mask, "detected:");
> >  }
> >  static int __enable_cpu_capability(void *arg)
> >@@ -1408,8 +1408,8 @@ __enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
> >  static void __init enable_cpu_capabilities(u16 scope_mask)
> >  {
> >-	__enable_cpu_capabilities(arm64_features, scope_mask);
> >  	__enable_cpu_capabilities(arm64_errata, scope_mask);
> >+	__enable_cpu_capabilities(arm64_features, scope_mask);

I forget why these were originally reordered in ed478b3f9e4a.
Was there any real reason for it?

I also notice in that commit that after the detection pass, we set
things up (in update_cpu_capabilities(), enable_cpu_capabilities()) in
the order errata, features.  Does this matter for anything?

Cheers
---Dave

> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
