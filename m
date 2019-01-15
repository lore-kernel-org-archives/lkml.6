Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5260C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B59920656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547531401;
	bh=OsNbKiOw4wC2BGgc0y+q1WmevhGN5MS5HBVUsKEr3Ao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UWyR6a64gfIb9SRV+HpT4VGSBMxIN68akqmnYizF1GsZwwmayqyY27Dzud1jyp3vN
	 idK5qgH8kcAhVWnlcbvI5PDhMfhiLIMg5IA2RnIJNmBoylcBX6KaCnVOY41HTWBAr8
	 c93k81Def3vtLYTdKvcSzproMlbFlvf0vid1PD2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbfAOFt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 00:49:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:58728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbfAOFt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 00:49:59 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9678B20656;
        Tue, 15 Jan 2019 05:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547531398;
        bh=OsNbKiOw4wC2BGgc0y+q1WmevhGN5MS5HBVUsKEr3Ao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YD/aV1bYlT9JBqyuX7FQozAs4TTkv/t4gLaNQr6DdeJLSC/50wtmS2upU9/fBZCaL
         gPyViv5g/QDVmYvtA9NvI0QNxfAnOEvk85lRPaMEZ4ewCCA03LMADru3uT7/OjNX/m
         26UlNHYNoeafYBNg5lDIPwEQtDg5hXKQ1u6Bc8jE=
Date:   Tue, 15 Jan 2019 14:49:55 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     James Morse <james.morse@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] arm64: kprobes: Move extable address check into
 arch_prepare_kprobe()
Message-Id: <20190115144955.b3a6cfae18035ae46ffdcfc2@kernel.org>
In-Reply-To: <92c160a8-7627-0c64-ed73-df616e9c057d@arm.com>
References: <154502881646.30629.9938335052821665530.stgit@devbox>
        <154502884653.30629.3172839440883293817.stgit@devbox>
        <aec51c10-d744-df0f-1216-d3372e779cb1@arm.com>
        <20190108113953.8bc0cc7d196ddba370377217@kernel.org>
        <b4109104-c438-f4c2-352a-d8b0ec47db37@arm.com>
        <20190109110500.b4b5049f4c67dfc85b9ced4e@kernel.org>
        <92c160a8-7627-0c64-ed73-df616e9c057d@arm.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 18:22:38 +0000
James Morse <james.morse@arm.com> wrote:

> Hi,
> 
> On 09/01/2019 02:05, Masami Hiramatsu wrote:
> > On Tue, 8 Jan 2019 17:13:36 +0000
> > James Morse <james.morse@arm.com> wrote:
> >> On 08/01/2019 02:39, Masami Hiramatsu wrote:
> >>> On Thu, 3 Jan 2019 17:05:18 +0000
> >>> James Morse <james.morse@arm.com> wrote:
> >>>> On 17/12/2018 06:40, Masami Hiramatsu wrote:
> >>>>> Move extable address check into arch_prepare_kprobe() from
> >>>>> arch_within_kprobe_blacklist().
> >>>>
> >>>> I'm trying to work out the pattern for what should go in the blacklist, and what
> >>>> should be rejected by the arch code.
> >>>>
> >>>> It seems address-ranges should be blacklisted as the contents don't matter.
> >>>> easy-example: the idmap text.
> >>>
> >>> Yes, more precisely, the code smaller than a function (symbol), it must be
> >>> rejected by arch_prepare_kprobe(), since blacklist is poplated based on
> >>> kallsyms.
> >>
> >> Ah, okay, so the pattern is the blacklist should only be for whole symbols,
> >> (which explains why its usually based on sections).
> > 
> > Correct. Actually, the blacklist is generated based on the symbol info
> > from symbol address.
> > 
> >> I see kprobe_add_ksym_blacklist() would go wrong if you give it something like:
> >> platform_drv_probe+0x50/0xb0, as it will log platform_drv_probe+0x50 as the
> >> start_addr and platform_drv_probe+0x50+0xb0 as the end.
> > 
> > Yes, it expects given address is the entry of a symbol.
> 
> >> But how does anything from the arch code's blacklist get into the
> >> kprobe_blacklist list?
> > 
> > It should be done via arch_populate_kprobe_blacklist().
> 
> >> We don't have an arch_populate_kprobe_blacklist(), so rely on
> >> within_kprobe_blacklist() calling arch_within_kprobe_blacklist() with the
> >> address, as well as walking kprobe_blacklist.
> >>
> >> Is this cleanup ahead of a series that does away with
> >> arch_within_kprobe_blacklist() so that debugfs list is always complete?
> > 
> > Right, after this cleanup, I will send arch_populate_kprobe_blacklist()
> > patch for arm64 and others. My plan is to move all arch_within_kprobe_blacklist()
> > to arch_populate_kprobe_blacklist() so that user can get more precise blacklist
> > via debugfs.
> 
> Thanks, now it all makes sense!
> 
> Reviewed-by: James Morse <james.morse@arm.com>

Thanks!

> 
> 
> Could you include a paragraph like that in the cover-letter or commit-message?
> The 'fix' in the cover-letter subject had me looking for the bug!

Ok, I'll update commit message with your reviewed-by.

Thank you!

> 
> 
> Thanks,
> 
> James


-- 
Masami Hiramatsu <mhiramat@kernel.org>
