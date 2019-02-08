Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6FEC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CB020844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfBHNCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:02:39 -0500
Received: from ozlabs.org ([203.11.71.1]:39993 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727489AbfBHNCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:02:36 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43wwMG0vPgz9sNL; Sat,  9 Feb 2019 00:02:33 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: eddd0b332304d554ad6243942f87c2fcea98c56b
X-Patchwork-Hint: ignore
In-Reply-To: <20190122155724.27557-2-joe.lawrence@redhat.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        live-patching@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Nicolai Stange <nstange@suse.de>, Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Torsten Duwe <duwe@lst.de>
Subject: Re: [1/4] powerpc/64s: Clear on-stack exception marker upon exception return
Message-Id: <43wwMG0vPgz9sNL@ozlabs.org>
Date:   Sat,  9 Feb 2019 00:02:33 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-22 at 15:57:21 UTC, Joe Lawrence wrote:
> From: Nicolai Stange <nstange@suse.de>
> 
> The ppc64 specific implementation of the reliable stacktracer,
> save_stack_trace_tsk_reliable(), bails out and reports an "unreliable
> trace" whenever it finds an exception frame on the stack. Stack frames
> are classified as exception frames if the STACK_FRAME_REGS_MARKER magic,
> as written by exception prologues, is found at a particular location.
> 
> However, as observed by Joe Lawrence, it is possible in practice that
> non-exception stack frames can alias with prior exception frames and thus,
> that the reliable stacktracer can find a stale STACK_FRAME_REGS_MARKER on
> the stack. It in turn falsely reports an unreliable stacktrace and blocks
> any live patching transition to finish. Said condition lasts until the
> stack frame is overwritten/initialized by function call or other means.
> 
> In principle, we could mitigate this by making the exception frame
> classification condition in save_stack_trace_tsk_reliable() stronger:
> in addition to testing for STACK_FRAME_REGS_MARKER, we could also take into
> account that for all exceptions executing on the kernel stack
> - their stack frames's backlink pointers always match what is saved
>   in their pt_regs instance's ->gpr[1] slot and that
> - their exception frame size equals STACK_INT_FRAME_SIZE, a value
>   uncommonly large for non-exception frames.
> 
> However, while these are currently true, relying on them would make the
> reliable stacktrace implementation more sensitive towards future changes in
> the exception entry code. Note that false negatives, i.e. not detecting
> exception frames, would silently break the live patching consistency model.
> 
> Furthermore, certain other places (diagnostic stacktraces, perf, xmon)
> rely on STACK_FRAME_REGS_MARKER as well.
> 
> Make the exception exit code clear the on-stack STACK_FRAME_REGS_MARKER
> for those exceptions running on the "normal" kernel stack and returning
> to kernelspace: because the topmost frame is ignored by the reliable stack
> tracer anyway, returns to userspace don't need to take care of clearing
> the marker.
> 
> Furthermore, as I don't have the ability to test this on Book 3E or
> 32 bits, limit the change to Book 3S and 64 bits.
> 
> Finally, make the HAVE_RELIABLE_STACKTRACE Kconfig option depend on
> PPC_BOOK3S_64 for documentation purposes. Before this patch, it depended
> on PPC64 && CPU_LITTLE_ENDIAN and because CPU_LITTLE_ENDIAN implies
> PPC_BOOK3S_64, there's no functional change here.
> 
> Fixes: df78d3f61480 ("powerpc/livepatch: Implement reliable stack tracing for the consistency model")
> Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/eddd0b332304d554ad6243942f87c2fc

cheers
