Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D653EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0B920658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0B920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeH3CVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:21:24 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:56686 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbeH3CVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:21:23 -0400
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1fv8qz-0005lZ-00; Wed, 29 Aug 2018 22:22:21 +0000
Date:   Wed, 29 Aug 2018 18:22:21 -0400
From:   Rich Felker <dalias@libc.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: futex_cmpxchg_enabled breakage
Message-ID: <20180829222221.GA22017@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just spent a number of hours helping someone track down a bug that
looks like it's some kind of futex_cmpxchg_enabled detection error on
powerpc64 (still not sure of the root cause; set_robust_list producing
-ENOSYS), and a while back I hit the same problem on sh2 due to lack
of EFAULT on nommu, leading to commit 72cc564f16ca. I think the test
(introduced way back in commit a0c1e9073ef7) is fundamentally buggy;
if anything, it should be checking for !=-ENOSYS, not ==-EFAULT.
Presumably it could also fail to produce -EFAULT if mmap_min_addr is 0
and page 0 is mapped (a bad idea, but maybe someone does it...). And
of course other nommu archs are possibly still broken.

Ultimately from an API perspective, the functionality that depends on
futex_cmpxchg_enabled is non-optional, and the current approach of
treating it as something that can be disabled via detection at runtime
is fragile and wrong.

If there are no archs that support SMP but don't provide their own
asm/futex.h (as opposed to the asm-generic one that does -ENOSYS on
SMP), the detection code should just be removed, and the SMP case in
asm-generic/futex.h should be made into #error.

If there are archs that support SMP but don't provide their own
working asm/futex.h, then asm-generic/futex.h's SMP case should be
enhanced to perform a stop-the-world IPI and then do the same thing as
the non-SMP case (disable preemption[/interrupts?], perform the
cmpxchg non-atomically).

Thoughts? Would a patch to do this be acceptable?

Rich
