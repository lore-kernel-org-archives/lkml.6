Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE24C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF4B2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uj1hODie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF4B2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeI0TKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:10:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35290 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbeI0TKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ue5VHT/tmsT6pB1D6q0wHhapDyGIhzNAADHpAZu/cjc=; b=uj1hODieHYC8skYQgVuyUgbL/
        SZ9wtzYQXQg39EdqsmkD2wjfwnusozPUH/+xaTuxrbq2J6BNJ0412Tsa59TtsCcssSg7xPiET+j5R
        vTbXQa+cTAlscfKCi+L4caoN+lqwJuZr/2l8ztMcKUew6qMOW/Bp7lpEib26YlDXEPOPCCm2T9sC+
        n/J68rQoaNGvtlb+uXu+aWRRX5C/MZTF0PFEXP4gvIAFwtFkyprBmuQ4WTZS6xnDy40hauykzgSth
        C5tU6D3MaTbA8iwKbQjOVdmGP7KwAMO5rRGIN4B8NemWkH5ZRcXbhgR9j3Td+uuALnDxB35HURjTX
        RQEB4EWGQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5Vli-0005FI-BC; Thu, 27 Sep 2018 12:52:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9DE03206F1A0C; Thu, 27 Sep 2018 14:51:41 +0200 (CEST)
Date:   Thu, 27 Sep 2018 14:51:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        ak@linux.intel.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH V2 2/3] x86, perf: Add a separate Arch Perfmon v4 PMI
 handler
Message-ID: <20180927125141.GA3439@hirez.programming.kicks-ass.net>
References: <1533712328-2834-1-git-send-email-kan.liang@linux.intel.com>
 <1533712328-2834-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533712328-2834-2-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 12:12:07AM -0700, kan.liang@linux.intel.com wrote:
> @@ -4325,6 +4428,8 @@ __init int intel_pmu_init(void)
>  		x86_pmu.extra_regs = intel_skl_extra_regs;
>  		x86_pmu.pebs_aliases = intel_pebs_aliases_skl;
>  		x86_pmu.pebs_prec_dist = true;
> +		x86_pmu.counter_freezing = disable_counter_freezing ?
> +					   false : true;
>  		/* all extra regs are per-cpu when HT is on */
>  		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
>  		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;


How about so instead? It is very much tied to the perfmon version, not
the FMS.

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4049,6 +4049,9 @@ __init int intel_pmu_init(void)
 			max((int)edx.split.num_counters_fixed, assume);
 	}
 
+	if (version >= 4)
+		x86_pmu.counter_freezing = !disable_counter_freezing;
+
 	if (boot_cpu_has(X86_FEATURE_PDCM)) {
 		u64 capabilities;
 
@@ -4428,8 +4431,6 @@ __init int intel_pmu_init(void)
 		x86_pmu.extra_regs = intel_skl_extra_regs;
 		x86_pmu.pebs_aliases = intel_pebs_aliases_skl;
 		x86_pmu.pebs_prec_dist = true;
-		x86_pmu.counter_freezing = disable_counter_freezing ?
-					   false : true;
 		/* all extra regs are per-cpu when HT is on */
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
