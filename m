Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D05AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FA321741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545310653;
	bh=zahJAHSTs2dZhR0xFNoyWPBP+1QzrnPyPJasnmzQjEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lJQ73R/lZbTj9qqnNCLWACTVmvxCgFITeLbH5V0kuojQL99VpytTOY6UY6SO8y5dD
	 TSDbmPqIciYdJnEPEQOQzxxznCIbexaPa7WELfbp4K1YGgLmXn3ANnritX6KSBVFe7
	 skFeEBrfHF32jGAkB7JUd0uKeaKDLUEIFBk/jajc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbeLTM5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:57:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:33086 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729731AbeLTM5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:57:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D87AACA4;
        Thu, 20 Dec 2018 12:57:31 +0000 (UTC)
Date:   Thu, 20 Dec 2018 13:57:30 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] ARC: show_regs: avoid page allocator
Message-ID: <20181220125730.GA17350@dhcp22.suse.cz>
References: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
 <1545159239-30628-2-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545159239-30628-2-git-send-email-vgupta@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18-12-18 10:53:58, Vineet Gupta wrote:
> Use on-stack smaller buffers instead of dynamic pages.
> 
> The motivation for this change was to address lockdep splat when
> signal handling code calls show_regs (with preemption disabled) and
> ARC show_regs calls into sleepable page allocator.
> 
> | potentially unexpected fatal signal 11.
> | BUG: sleeping function called from invalid context at ../mm/page_alloc.c:4317
> | in_atomic(): 1, irqs_disabled(): 0, pid: 57, name: segv
> | no locks held by segv/57.
> | Preemption disabled at:
> | [<8182f17e>] get_signal+0x4a6/0x7c4
> | CPU: 0 PID: 57 Comm: segv Not tainted 4.17.0+ #23
> |
> | Stack Trace:
> |  arc_unwind_core.constprop.1+0xd0/0xf4
> |  __might_sleep+0x1f6/0x234
> |  __get_free_pages+0x174/0xca0
> |  show_regs+0x22/0x330
> |  get_signal+0x4ac/0x7c4     # print_fatal_signals() -> preempt_disable()
> |  do_signal+0x30/0x224
> |  resume_user_mode_begin+0x90/0xd8
> 
> Despite this, lockdep still barfs (see next change), but this patch
> still has merit as in we use smaller/localized buffers now and there's
> less instructoh trace to sift thru when debugging pesky issues.

But show_regs is called from contexts which might be called from deep
call chains (e.g WARN). Is it safe to allocate such a large stack there?
-- 
Michal Hocko
SUSE Labs
