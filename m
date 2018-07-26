Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E31C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CEE20862
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:38:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CEE20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbeGZV5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 17:57:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45262 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730533AbeGZV5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 17:57:01 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0DF4340B;
        Thu, 26 Jul 2018 20:38:30 +0000 (UTC)
Date:   Thu, 26 Jul 2018 13:38:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] checkpatch: check for function calls with struct or
 union on stack
Message-Id: <20180726133829.bbe2677217f905c5df11d2d6@linux-foundation.org>
In-Reply-To: <00bf258587510ee96a27918293bd4d75622512c6.camel@perches.com>
References: <1236369d28b2f1f5389ff652c4eb89e699e6481e.camel@perches.com>
        <20180726122533.104f6eea950853ef50ebc680@linux-foundation.org>
        <20180726122807.fad0566951e36d930edb6874@linux-foundation.org>
        <00bf258587510ee96a27918293bd4d75622512c6.camel@perches.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018 13:05:29 -0700 Joe Perches <joe@perches.com> wrote:

> On Thu, 2018-07-26 at 12:28 -0700, Andrew Morton wrote:
> > On Thu, 26 Jul 2018 12:25:33 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > > I'll give it a spin, see how noisy it is.
> > 
> > Actually, I would prefer if the message, changelog and title
> > used the term "passed by value".  It's a more familiar term
> > and it is possible for a passed-by-value aggregate to in fact 
> > be passed in registers.
> 
> RFC, No worries, I'll change it if it's OK.
> 
> I'm testing it right now against the last 5000 commits
> (which takes awhile here) via
> 
> $ git log --no-merges --format=oneline -5000 | \
>   cut -f1 -d" " | \
>   while read commit ; do \
>     echo $commit; \
>     ./scripts/checkpatch.pl --git $commit --types=aggregate_on_stack --quiet --no-summary ; \
>   done
> 
> It doesn't seem noisy at all, but maybe there are a few
> known structs like "struct timespec64" that could be
> excluded.
> 
> The only real hits so far are:
> 
> commit f2fb56afba11426ee5c9603b28a9827c530909c0
> WARNING: Unusual use of 'struct msm_display_topology' on stack
> #28374: FILE: drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c:149:
> +enum dpu_rm_topology_name
> +dpu_rm_get_topology_name(struct msm_display_topology topology)
> +{

hm.  12 bytes.  I don't know if this would be more efficient than using
const struct msm_display_topology*.

> and
> 
> 33477d84c26bbfa626da2c032e567a90dd70a528
> WARNING: Unusual use of 'struct cppc_perf_fb_ctrs' on stack
> #45: FILE: drivers/cpufreq/cppc_cpufreq.c:307:
> +static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu,
> +				     struct cppc_perf_fb_ctrs fb_ctrs_t0,
> +				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
> +{

Two 32-byte structures?  That seems excessive.

Yes, a warning which sends developers back for a bit more thinnking
sounds useful.

