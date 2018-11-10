Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51911C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1328D20858
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1328D20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbeKKCpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 21:45:21 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44350 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbeKKCpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 21:45:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95F3480D;
        Sat, 10 Nov 2018 08:59:40 -0800 (PST)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61F913F718;
        Sat, 10 Nov 2018 08:59:40 -0800 (PST)
Received: from cmarinas by mbp with local (Exim 4.89)
        (envelope-from <catalin.marinas@arm.com>)
        id 1gLWbi-00012c-Hc; Sat, 10 Nov 2018 16:59:38 +0000
Date:   Sat, 10 Nov 2018 16:59:38 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@gmx.us>
Cc:     open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: kmemleak: Early log buffer exceeded (525980) during boot
Message-ID: <20181110165938.lbt6dfamk2ljafcv@localhost>
References: <1541712198.12945.12.camel@gmx.us>
 <D7C9EA14-C812-406F-9570-CFF36F4C3983@gmx.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D7C9EA14-C812-406F-9570-CFF36F4C3983@gmx.us>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 10:08:10AM -0500, Qian Cai wrote:
> On Nov 8, 2018, at 4:23 PM, Qian Cai <cai@gmx.us> wrote:
> > The maximum value for DEBUG_KMEMLEAK_EARLY_LOG_SIZE is only 40000, so it
> > disables kmemleak every time on this aarch64 server running the latest mainline
> > (b00d209).
> > 
> > # echo scan > /sys/kernel/debug/kmemleak 
> > -bash: echo: write error: Device or resource busy
> > 
> > Any idea on how to enable kmemleak there?
> 
> I have managed to hard-code DEBUG_KMEMLEAK_EARLY_LOG_SIZE to 600000,

That's quite a high number, I wouldn't have thought it is needed.
Basically the early log buffer is only used until the slub allocator
gets initialised and kmemleak_init() is called from start_kernel(). I
don't know what allocates that much memory so early.

What else is in your .config?

> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 877de4fa0720..c10119102c10 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -280,7 +280,7 @@ struct early_log {
>  
>  /* early logging buffer and current position */
>  static struct early_log
> -       early_log[CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE] __initdata;
> +       early_log[600000] __initdata;

You don't need to patch the kernel, the config variable is there to be
changed.

> Even though kmemleak is enabled, there are continuous soft-lockups and eventually
> a kernel panic. Is it normal that kmemleak not going to work with large systems (this
> aarch64 server has 64-CPU and 100G memory)?

I only tried 4.20-rc1 with 64 CPUs in a guest under KVM and with only
16GB of RAM (I can try on a ThunderX2 host in about 10 days as I'm away
next week at Linux Plumbers). But it works fine for me, no soft lockups.
Maybe something different in your .config or something else goes
completely wrong (e.g. memory corruption) and kmemleak trips over it.

-- 
Catalin
