Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB04C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB86222DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406208AbfBNPz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:55:29 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46312 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393579AbfBNPz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:55:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26E00EBD;
        Thu, 14 Feb 2019 07:55:28 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3DE33F575;
        Thu, 14 Feb 2019 07:55:26 -0800 (PST)
Date:   Thu, 14 Feb 2019 15:55:22 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH v3 4/4] arm64: kprobes: Use
 arch_populate_kprobe_blacklist()
Message-ID: <20190214155522.GA1825@fuggles.cambridge.arm.com>
References: <154998617300.21869.11457765723750331236.stgit@devbox>
 <154998628802.21869.4041705065539411318.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154998628802.21869.4041705065539411318.stgit@devbox>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Wed, Feb 13, 2019 at 12:44:48AM +0900, Masami Hiramatsu wrote:
> Use arch_populate_kprobe_blacklist() instead of
> arch_within_kprobe_blacklist() so that we can see the full
> blacklisted symbols under the debugfs.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>   Changes in v3
>    - Do not populate blacklist in __kprobe_text in
>      arch_populate_kprobe_blacklist(), since it is already
>      populated in populate_kprobe_blacklist().
>    - Add exception entry text blacklist since those are rejected
>      by in_exception_text().
> ---
>  arch/arm64/kernel/probes/kprobes.c |   45 +++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 194262fca5cd..37d913f33a89 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -465,26 +465,33 @@ kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr)
>  	return DBG_HOOK_HANDLED;
>  }
>  
> -bool arch_within_kprobe_blacklist(unsigned long addr)

I think it would be useful to add a comment here so that we remember
why this code is the way it is:

/*
 * Provide a blacklist of symbols identifying ranges which cannot be kprobed.
 * This blacklist is exposed to userspace via debugfs (kprobes/blacklist).
 */

With that, you can have my ack for the series:

Acked-by: Will Deacon <will.deacon@arm.com>

Catalin -- can you pick these up with that comment added, please?

Cheers,

Will
