Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91943C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B1125D1E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B1125D1E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeFYPoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:44:07 -0400
Received: from foss.arm.com ([217.140.101.70]:60366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751381AbeFYPoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:44:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E45A7A9;
        Mon, 25 Jun 2018 08:44:04 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AD913F5AF;
        Mon, 25 Jun 2018 08:44:02 -0700 (PDT)
Date:   Mon, 25 Jun 2018 16:44:00 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com
Cc:     Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [PATCHv2 06/11] atomics/treewide: rework ordering barriers
Message-ID: <20180625154400.3wffxctuzyvlhgd4@lakrids.cambridge.arm.com>
References: <20180625105952.3756-1-mark.rutland@arm.com>
 <20180625105952.3756-7-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625105952.3756-7-mark.rutland@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 11:59:47AM +0100, Mark Rutland wrote:
> Currently architectures can override __atomic_op_*() to define the barriers
> used before/after a relaxed atomic when used to build acquire/release/fence
> variants.
> 
> This has the unfortunate property of requiring the architecture to define the
> full wrapper for the atomics, rather than just the barriers they care about,
> and gets in the way of generating atomics which can be easily read.
> 
> Instead, this patch has architectures define an optional set of barriers,
> __atomic_mb_{before,after}_{acquire,release,fence}(), which <linux/atomic.h>
> uses to build the wrappers.
> 
> At the same time, let's avoid any potential reliance on these elsewhere
> by ensuring each is undef'd at the end of <linux/atomic.h>.

> +#undef __atomic_op_acquire
> +#undef __atomic_op_release
> +#undef __atomic_op_fence
> +
> +#undef __atomic_acquire_fence
> +#undef __atomic_release_fence
> +#undef __atomic_pre_fence
> +#undef __atomic_post_fence

Due to the way preprocessor gets expanded, this happens to break the
cmpxchg() wrappers on some architectures. Without re-implementing those
with some pretty horrendous static inlines and wrappers to guarantee
type invariance, it's not possible to solve that.

As agreed over IRC, I've removed the undefs for now.

Alas.

Mark.
