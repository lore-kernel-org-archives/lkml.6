Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C7CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C4822419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C4822419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731872AbeKND2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:28:22 -0500
Received: from foss.arm.com ([217.140.101.70]:59982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730730AbeKND2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:28:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19A82A78;
        Tue, 13 Nov 2018 09:29:18 -0800 (PST)
Received: from blommer (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B18573F5CF;
        Tue, 13 Nov 2018 09:29:17 -0800 (PST)
Date:   Tue, 13 Nov 2018 17:29:08 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Zhang =?utf-8?B?WmhpemhvdSjlvKDmsrvmtLIp?= 
        <zhizhouzhang@asrmicro.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mpatocka@redhat.com" <mpatocka@redhat.com>,
        "alex.popov@linux.com" <alex.popov@linux.com>,
        "labbott@redhat.com" <labbott@redhat.com>,
        "panand@redhat.com" <panand@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "zhizhouzh@gmail.com" <zhizhouzh@gmail.com>
Subject: Re: [PATCH] arm64: disable KASAN for save_trace()
Message-ID: <20181113172857.f5e34gkv4ib7ejkr@blommer>
References: <1541938036-29498-1-git-send-email-zhizhouzhang@asrmicro.com>
 <20181111172333.ov25gdmlsmhc6ysp@salmiak>
 <28fb310518294fbebf82ce22e4620cd3@mail2012.asrmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28fb310518294fbebf82ce22e4620cd3@mail2012.asrmicro.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 07:38:07AM +0000, Zhang Zhizhou(张治洲) wrote:
> 
> 
> > -----Original Message-----
> > From: Mark Rutland [mailto:mark.rutland@arm.com]
> > Sent: Monday, November 12, 2018 1:24 AM
> > To: Zhang Zhizhou(张治洲) <zhizhouzhang@asrmicro.com>
> > Cc: catalin.marinas@arm.com; will.deacon@arm.com;
> > mpatocka@redhat.com; alex.popov@linux.com; labbott@redhat.com;
> > panand@redhat.com; linux-kernel@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; zhizhouzh@gmail.com
> > Subject: Re: [PATCH] arm64: disable KASAN for save_trace()
> > 
> > On Sun, Nov 11, 2018 at 08:07:16PM +0800, Zhizhou Zhang wrote:
> > > save_trace() which is called from walk_stackframe() always try to
> > > read/write caller's stack. This results KASAN stack-out-of-bounds
> > > warning. So mute it.
> > 
> > The save_trace() function should never perform an out-of-bounds access on
> > the caller's stack, so this is papering over a bug elsewhere.
> > 
> > Can you please given an example report from KASAN?
> > 
> I'm sorry, I don't have a device with the newest kernel on hand. So my test
> is based on 4.4.145. The stack is shown below:

Just to check, which toolchain are you using? 

... and which KASAN options do you have enabled?

> 
> c4 0 (swapper/4) ==================================================================
> c4 0 (swapper/4) BUG: KASAN: stack-out-of-bounds in save_trace+0x98/0x130
> c4 0 (swapper/4) Write of size 8 at addr ffffffc09b04fbe0 by task swapper/4/0

Can you please use scripts/faddr2line to determine where in save_trace this is?

AFAICT the only 8-byte store we do is where we update trace->entries[].

> c4 0 (swapper/4) 
> c4 0 (swapper/4) CPU: 4 PID: 0 Comm: swapper/4 Not tainted 4.4.145+ #2
> c4 0 (swapper/4) Hardware name: ASR AQUILAC EVB (DT)
> c4 0 (swapper/4) Call trace:
> c4 0 (swapper/4) [<ffffff9008091a50>] dump_backtrace+0x0/0x418
> c4 0 (swapper/4) [<ffffff9008091e90>] show_stack+0x28/0x38
> c4 0 (swapper/4) [<ffffff90086252a4>] dump_stack+0xe8/0x13c
> c4 0 (swapper/4) [<ffffff900831c164>] print_address_description+0x8c/0x2b0
> c4 0 (swapper/4) [<ffffff900831c690>] kasan_report+0x210/0x330
> c4 0 (swapper/4) [<ffffff900831ac44>] __asan_store8+0x84/0x98
> c4 0 (swapper/4) [<ffffff9008090cd0>] save_trace+0x98/0x130
> c4 0 (swapper/4) [<ffffff9008091174>] walk_stackframe+0x4c/0x68
> c4 0 (swapper/4) [<ffffff90080912cc>] save_stack_trace_tsk+0x13c/0x1f8
> c4 0 (swapper/4) [<ffffff90080913b0>] save_stack_trace+0x28/0x38
> c4 0 (swapper/4) [<ffffff900831b978>] kasan_slab_free+0x88/0x1a0
> c4 0 (swapper/4) [<ffffff9008317bfc>] kmem_cache_free+0xac/0x3f8
> c4 0 (swapper/4) [<ffffff90080b76f0>] __put_task_struct+0xa8/0x1f0
> c4 0 (swapper/4) [<ffffff90081116c4>] finish_task_switch+0x21c/0x2a0
> c4 0 (swapper/4) [<ffffff90092dc50c>] __schedule+0x4cc/0xe80
> c4 0 (swapper/4) [<ffffff90092dd198>] schedule+0x70/0x110
> c4 0 (swapper/4) [<ffffff90092dd554>] schedule_preempt_disabled+0x24/0x70
> c4 0 (swapper/4) [<ffffff9008151dc0>] cpu_startup_entry+0x198/0x538
> c4 0 (swapper/4) [<ffffff9008099f38>] secondary_start_kernel+0x258/0x2f0
> c4 0 (swapper/4) [<00000001032e603c>] 0x1032e603c
> c4 0 (swapper/4) 
> c4 0 (swapper/4) The buggy address belongs to the page:
> c4 0 (swapper/4) page:ffffffbdc26c13c0 count:0 mapcount:0 mapping:          (null)5.091297] c4 0 (swapper/4) 
> c4 0 (swapper/4) Memory state around the buggy address:
> c4 0 (swapper/4)  ffffffc09b04fa80: 00 00 f2 f2 f2 f2 f2 f2 00 00 00 00 f3 f3 f3 f3
> c4 0 (swapper/4)  ffffffc09b04fb00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c4 0 (swapper/4) >ffffffc09b04fb80: 00 00 00 00 00 00 00 00 00 00 00
>       swapper/4)  ffffffc09b04fc00: 00 00 00 00 f3 f3 f3 f3 00 00 00 00 00 00 00 00
> c4 0 (swapper/4)  ffffffc09b04fc80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c4 0 (swapper/4) ==================================================================
> 
> Maybe this issue has been fixed in the latest kernel, I have no idea about
> that. Though some function has been changed, but I found the calling flow
> doesn't change a lot in the latest kernel. Could you help me to figure out
> what's wrong with it?

I can't immedialte spot what's going on here.

How are you reproducing this issue?

Thanks,
Mark.
