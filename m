Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FB6ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 13:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2EC208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 13:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2EC208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeIPSjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 14:39:43 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:57068 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbeIPSjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 14:39:43 -0400
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1g1Wuj-0006jn-00; Sun, 16 Sep 2018 13:16:37 +0000
Date:   Sun, 16 Sep 2018 09:16:37 -0400
From:   Rich Felker <dalias@libc.org>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-man@vger.kernel.org,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: futex_cmpxchg_enabled breakage
Message-ID: <20180916131637.GA17995@brightrain.aerifal.cx>
References: <20180829222221.GA22017@brightrain.aerifal.cx>
 <87fty9hc2u.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fty9hc2u.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2018 at 02:16:25PM +0200, Florian Weimer wrote:
> * Rich Felker:
> 
> > I just spent a number of hours helping someone track down a bug that
> > looks like it's some kind of futex_cmpxchg_enabled detection error on
> > powerpc64 (still not sure of the root cause; set_robust_list producing
> > -ENOSYS), and a while back I hit the same problem on sh2 due to lack
> > of EFAULT on nommu, leading to commit 72cc564f16ca. I think the test
> > (introduced way back in commit a0c1e9073ef7) is fundamentally buggy;
> > if anything, it should be checking for !=-ENOSYS, not ==-EFAULT.
> > Presumably it could also fail to produce -EFAULT if mmap_min_addr is 0
> > and page 0 is mapped (a bad idea, but maybe someone does it...). And
> > of course other nommu archs are possibly still broken.
> 
> Maybe it was related to this (“Kernel 4.15 lost set_robust_list
> support on POWER 9”):
> 
> <https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-February/168570.html>

Thanks! This is really helpful; I'll pass it along.

> The Kconfig change you suggest was explicitly rejected as the fix.

Even if it was rejected as a fix for this specific bug, I think it
would be a good change for other reasons. If nothing else it reduces
kernel code size and eliminates a few instructions in some (albeit
long) hot paths.

> I believe the expected userspace interface is that you probe support
> with set_robust_list first, and then start using the relevant futex
> interfaces only if that call succeeded.

In order for it to work, set_robust_list needs to succeed for all
threads, present and future, so there's an implicit contract needed
here that, if it succeeds once, it needs to always succeed. This is
satisfied by the kernel implementation. FWIW I adopted a fix using
get_robust_list to probe just to avoid coupling the internals of
setting up the list with the bland function
pthread_mutexattr_setrobust which is unaware of any implementation
details except the location of the attribute bit.

Presumably a similar probing should happen in
pthread_mutexattr_setprotocol for PI mutex support. Does glibc do
this? musl still lacks PI mutex support so I'll save this as a note
for when it's added.

> If you do that, most parts of
> a typical system will work as expected even if the kernel support is
> not there, which is a bit surprising.  It definitely makes the root
> cause harder to spot.

I don't follow here. "most parts of a typical system will work as
expected" seems to be the case whether you do or don't correctly
probe. The only difference is whether a program that carefully checks
for errors will see and report that pthread_mutexattr_setrobust
failed.

Rich
