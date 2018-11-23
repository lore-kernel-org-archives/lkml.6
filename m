Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27686C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EDB205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5EDB205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440385AbeKXCdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:33:25 -0500
Received: from foss.arm.com ([217.140.101.70]:47888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440372AbeKXCdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 21:33:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 790BD35CD;
        Fri, 23 Nov 2018 07:48:42 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 218833F5AF;
        Fri, 23 Nov 2018 07:48:40 -0800 (PST)
Date:   Fri, 23 Nov 2018 15:48:36 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mingo@kernel.org
Cc:     Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] locking/atomics: build atomic headers as required
Message-ID: <20181123154835.63mkqlkn4eppegil@lakrids.cambridge.arm.com>
References: <20181123153321.8561-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123153321.8561-1-mark.rutland@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 03:33:21PM +0000, Mark Rutland wrote:
> Andrew and Ingo report that the check-atomics.sh script is simply too
> slow to run for every kernel build, and it's impractical to make it
> faster without rewriting it in something other than shell.
> 
> Rather than committing the generated headers, let's regenerate these
> as-required for a pristine tree.

> The diffstat looks nice, at least...

>  include/asm-generic/atomic-instrumented.h | 1787 ----------------------
>  include/asm-generic/atomic-long.h         | 1012 -------------
>  include/linux/atomic-fallback.h           | 2294 -----------------------------

As a heads-up, I generated the diff with git format-patch -D, to omit
the preimage for those ~5000 lines being deleted. Unfortunately, git-am
will refuse to apply that, with something like:

| error: removal patch leaves file contents
| error: include/asm-generic/atomic-instrumented.h: patch does not apply

I've pushed the patch to my atomics/regenerate branch [1] for now. I can resend
with the full context (or leaving the stale files for a subsequent deletion),
if that's preferable?

Thanks,
Mark.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git atomics/regenerate
