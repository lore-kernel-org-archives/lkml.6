Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE86C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DA820823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfBVQK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 11:10:26 -0500
Received: from outbound-smtp16.blacknight.com ([46.22.139.233]:44364 "EHLO
        outbound-smtp16.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbfBVQK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 11:10:26 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id B8A051C1EBB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 16:10:23 +0000 (GMT)
Received: (qmail 8503 invoked from network); 22 Feb 2019 16:10:23 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Feb 2019 16:10:23 -0000
Date:   Fri, 22 Feb 2019 16:10:22 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        subhra.mazumdar@oracle.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Fr?d?ric Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>, kerrnel@google.com
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
Message-ID: <20190222161022.GZ9565@techsingularity.net>
References: <20190218165620.383905466@infradead.org>
 <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
 <20190222124544.GY9565@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190222124544.GY9565@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 12:45:44PM +0000, Mel Gorman wrote:
> On Mon, Feb 18, 2019 at 09:49:10AM -0800, Linus Torvalds wrote:
> > On Mon, Feb 18, 2019 at 9:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > However; whichever way around you turn this cookie; it is expensive and nasty.
> > 
> > Do you (or anybody else) have numbers for real loads?
> > 
> > Because performance is all that matters. If performance is bad, then
> > it's pointless, since just turning off SMT is the answer.
> > 
> 
> I tried to do a comparison between tip/master, ht disabled and this series
> putting test workloads into a tagged cgroup but unfortunately it failed
> 
> [  156.978682] BUG: unable to handle kernel NULL pointer dereference at 0000000000000058
> [  156.986597] #PF error: [normal kernel read fault]
> [  156.991343] PGD 0 P4D 0

When bodged around, one test survived (performance was crucified but the
benchmark is very synthetic). pgbench (test 2) paniced with a hard
lockup. Most of the console log was corrupted (unrelated to the patch)
but the relevant part is

[ 4587.419674] Call Trace:
[ 4587.419674]  _raw_spin_lock+0x1b/0x20
[ 4587.419675]  sched_core_balance+0x155/0x520
[ 4587.419675]  ? __switch_to_asm+0x34/0x70
[ 4587.419675]  __balance_callback+0x49/0xa0
[ 4587.419676]  __schedule+0xf15/0x12c0
[ 4587.419676]  schedule_idle+0x1e/0x40
[ 4587.419677]  do_idle+0x166/0x280
[ 4587.419677]  cpu_startup_entry+0x19/0x20
[ 4587.419678]  start_secondary+0x17a/0x1d0
[ 4587.419678]  secondary_startup_64+0xa4/0xb0
[ 4587.419679] Kernel panic - not syncing: Hard LOCKUP

-- 
Mel Gorman
SUSE Labs
