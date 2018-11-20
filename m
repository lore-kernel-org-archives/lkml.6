Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADB7C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362DA2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362DA2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbeKTVuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:50:21 -0500
Received: from ozlabs.org ([203.11.71.1]:45303 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728056AbeKTVuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:50:21 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42zjvj4Kl5z9s3l;
        Tue, 20 Nov 2018 22:21:37 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Andrew Murray <andrew.murray@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org
Cc:     linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] powerpc: perf/core: generalise event exclusion checking with perf macro
In-Reply-To: <1542363853-13849-5-git-send-email-andrew.murray@arm.com>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com> <1542363853-13849-5-git-send-email-andrew.murray@arm.com>
Date:   Tue, 20 Nov 2018 22:21:37 +1100
Message-ID: <87va4s0zb2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Murray <andrew.murray@arm.com> writes:

> Replace checking of perf event exclusion flags with perf macro.
>
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  arch/powerpc/perf/hv-24x7.c |  7 +------
>  arch/powerpc/perf/hv-gpci.c |  7 +------
>  arch/powerpc/perf/imc-pmu.c | 14 ++------------
>  3 files changed, 4 insertions(+), 24 deletions(-)

These conversions look fine, thanks.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
> index 72238ee..60db22d 100644
> --- a/arch/powerpc/perf/hv-24x7.c
> +++ b/arch/powerpc/perf/hv-24x7.c
> @@ -1307,12 +1307,7 @@ static int h_24x7_event_init(struct perf_event *event)
>  	}
>  
>  	/* unsupported modes and filters */
> -	if (event->attr.exclude_user   ||
> -	    event->attr.exclude_kernel ||
> -	    event->attr.exclude_hv     ||
> -	    event->attr.exclude_idle   ||
> -	    event->attr.exclude_host   ||
> -	    event->attr.exclude_guest)
> +	if (event_has_exclude_flags(event))
>  		return -EINVAL;
>  
>  	/* no branch sampling */
> diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
> index 43fabb3..2d2b5c0 100644
> --- a/arch/powerpc/perf/hv-gpci.c
> +++ b/arch/powerpc/perf/hv-gpci.c
> @@ -233,12 +233,7 @@ static int h_gpci_event_init(struct perf_event *event)
>  	}
>  
>  	/* unsupported modes and filters */
> -	if (event->attr.exclude_user   ||
> -	    event->attr.exclude_kernel ||
> -	    event->attr.exclude_hv     ||
> -	    event->attr.exclude_idle   ||
> -	    event->attr.exclude_host   ||
> -	    event->attr.exclude_guest)
> +	if (event_has_exclude_flags(event))
>  		return -EINVAL;
>  
>  	/* no branch sampling */
> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
> index 1fafc32b..1ae1d3f 100644
> --- a/arch/powerpc/perf/imc-pmu.c
> +++ b/arch/powerpc/perf/imc-pmu.c
> @@ -474,12 +474,7 @@ static int nest_imc_event_init(struct perf_event *event)
>  		return -EINVAL;
>  
>  	/* unsupported modes and filters */
> -	if (event->attr.exclude_user   ||
> -	    event->attr.exclude_kernel ||
> -	    event->attr.exclude_hv     ||
> -	    event->attr.exclude_idle   ||
> -	    event->attr.exclude_host   ||
> -	    event->attr.exclude_guest)
> +	if (event_has_exclude_flags(event))
>  		return -EINVAL;
>  
>  	if (event->cpu < 0)
> @@ -749,12 +744,7 @@ static int core_imc_event_init(struct perf_event *event)
>  		return -EINVAL;
>  
>  	/* unsupported modes and filters */
> -	if (event->attr.exclude_user   ||
> -	    event->attr.exclude_kernel ||
> -	    event->attr.exclude_hv     ||
> -	    event->attr.exclude_idle   ||
> -	    event->attr.exclude_host   ||
> -	    event->attr.exclude_guest)
> +	if (event_has_exclude_flags(event))
>  		return -EINVAL;
>  
>  	if (event->cpu < 0)
> -- 
> 2.7.4
