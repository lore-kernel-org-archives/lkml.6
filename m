Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F67DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9EF2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9EF2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbeJ3FQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 01:16:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:48102 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728587AbeJ3FQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 01:16:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DD76BABC1;
        Mon, 29 Oct 2018 20:26:36 +0000 (UTC)
Date:   Mon, 29 Oct 2018 21:26:34 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: memcg oops:
 memcg_kmem_charge_memcg()->try_charge()->page_counter_try_charge()->BOOM
Message-ID: <20181029202634.GQ32673@dhcp22.suse.cz>
References: <1540792855.22373.34.camel@gmx.de>
 <20181029132035.GI32673@dhcp22.suse.cz>
 <1540830938.10478.4.camel@gmx.de>
 <20181029185412.GA15760@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029185412.GA15760@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29-10-18 18:54:19, Roman Gushchin wrote:
> On Mon, Oct 29, 2018 at 05:35:38PM +0100, Mike Galbraith wrote:
> > On Mon, 2018-10-29 at 14:20 +0100, Michal Hocko wrote:
> > > 
> > > > [    4.420976] Code: f3 c3 0f 1f 00 0f 1f 44 00 00 48 85 ff 0f 84 a8 00 00 00 41 56 48 89 f8 41 55 49 89 fe 41 54 49 89 d5 55 49 89 f4 53 48 89 f3 <f0> 48 0f c1 1f 48 01 f3 48 39 5f 18 48 89 fd 73 17 eb 41 48 89 e8
> > > > [    4.424162] RSP: 0018:ffffb27840c57cb0 EFLAGS: 00010202
> > > > [    4.425236] RAX: 00000000000000f8 RBX: 0000000000000020 RCX: 0000000000000200
> > > > [    4.426467] RDX: ffffb27840c57d08 RSI: 0000000000000020 RDI: 00000000000000f8
> > > > [    4.427652] RBP: 0000000000000001 R08: 0000000000000000 R09: ffffb278410bc000
> > > > [    4.428883] R10: ffffb27840c57ed0 R11: 0000000000000040 R12: 0000000000000020
> > > > [    4.430168] R13: ffffb27840c57d08 R14: 00000000000000f8 R15: 00000000006000c0
> > > > [    4.431411] FS:  00007f79081a3940(0000) GS:ffff92a4b7bc0000(0000) knlGS:0000000000000000
> > > > [    4.432748] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [    4.433836] CR2: 00000000000000f8 CR3: 00000002310ac002 CR4: 00000000001606e0
> > > > [    4.435500] Call Trace:
> > > > [    4.436319]  try_charge+0x92/0x7b0
> > > > [    4.437284]  ? unlazy_walk+0x4c/0xb0
> > > > [    4.438676]  ? terminate_walk+0x91/0x100
> > > > [    4.439984]  memcg_kmem_charge_memcg+0x28/0x80
> > > > [    4.441059]  memcg_kmem_charge+0x88/0x1d0
> > > > [    4.442105]  copy_process.part.37+0x23a/0x2070
> > > 
> > > Could you faddr2line this please?
> > 
> > homer:/usr/local/src/kernel/linux-master # ./scripts/faddr2line vmlinux copy_process.part.37+0x23a
> > copy_process.part.37+0x23a/0x2070:
> > memcg_charge_kernel_stack at kernel/fork.c:401
> > (inlined by) dup_task_struct at kernel/fork.c:850
> > (inlined by) copy_process at kernel/fork.c:1750
> > 
> > I bisected it this afternoon, and confirmed the result via revert.
> > 
> > 9b6f7e163cd0f468d1b9696b785659d3c27c8667 is the first bad commit
> > commit 9b6f7e163cd0f468d1b9696b785659d3c27c8667
> > Author: Roman Gushchin <guro@fb.com>
> > Date:   Fri Oct 26 15:03:19 2018 -0700
> > 
> >     mm: rework memcg kernel stack accounting
> 
> 
> Hi Mike!
> 
> Thank you for the report!
> 
> Do you see it reliable every time you boot up the machine?
> How do you run kvm? Is there something special about your cgroup setup?
> 
> I've made several attempts to reproduce the issue, but haven't got anything
> so far. I've used your config, and played with different cgroups setups.
> 
> Do you know where in the page_counter_try_charge() it fails?
> 
> Also, can you, please, check if the following patch mitigates the problem?

It's been a long day so I might be completely wrong but it seems that
the task_struct is not initialized yet so tsk->mm is a complete garbage.
I guess you want to move charging down after arch_dup_task_struct.
-- 
Michal Hocko
SUSE Labs
