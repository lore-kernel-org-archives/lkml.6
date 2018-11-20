Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C209FC46463
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB4820831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB4820831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbeKTV5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:57:19 -0500
Received: from ozlabs.org ([203.11.71.1]:44239 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbeKTV5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:57:19 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42zk3n22Mpz9s3l;
        Tue, 20 Nov 2018 22:28:37 +1100 (AEDT)
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
Subject: Re: [PATCH 01/10] perf/core: Add macro to test for event exclusion flags
In-Reply-To: <1542363853-13849-2-git-send-email-andrew.murray@arm.com>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com> <1542363853-13849-2-git-send-email-andrew.murray@arm.com>
Date:   Tue, 20 Nov 2018 22:28:34 +1100
Message-ID: <87sgzw0yzh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Murray <andrew.murray@arm.com> writes:

> Add a macro that tests if any of the perf event exclusion flags
> are set on a given event.
>
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  include/linux/perf_event.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 53c500f..89ee7fa 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1004,6 +1004,15 @@ perf_event__output_id_sample(struct perf_event *event,
>  extern void
>  perf_log_lost_samples(struct perf_event *event, u64 lost);
>  
> +static inline bool event_has_exclude_flags(struct perf_event *event)
> +{
> +	struct perf_event_attr *attr = &event->attr;
> +
> +	return attr->exclude_idle || attr->exclude_user ||
> +	       attr->exclude_kernel || attr->exclude_hv ||
> +	       attr->exclude_guest || attr->exclude_host;
> +}

Sorry to be a total PITA, but using "flags" plural suggests that it only
returns true if there is more than one exclude flag set.

A better name would be event_has_exclude_flag() or maybe
event_has_any_exclude_flag().

If you're doing a respin anyway it'd be nice to fix the name, but
obviously it's not high priority.

cheers
