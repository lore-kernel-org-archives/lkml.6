Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17281C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B702087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732466AbfA3RSK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:18:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:40404 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726972AbfA3RSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:18:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 848FCAD3C;
        Wed, 30 Jan 2019 17:18:07 +0000 (UTC)
From:   Nicolai Stange <nstange@suse.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        live-patching@vger.kernel.org,
        Balbir Singh <bsingharora@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nicolai Stange <nstange@suse.de>, Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH 1/4] powerpc/64s: Clear on-stack exception marker upon exception return
References: <20190122155724.27557-1-joe.lawrence@redhat.com>
        <20190122155724.27557-2-joe.lawrence@redhat.com>
        <87tvhqpbzd.fsf@concordia.ellerman.id.au>
Date:   Wed, 30 Jan 2019 18:18:05 +0100
In-Reply-To: <87tvhqpbzd.fsf@concordia.ellerman.id.au> (Michael Ellerman's
        message of "Wed, 30 Jan 2019 23:27:02 +1100")
Message-ID: <87a7jirrn6.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:

> Joe Lawrence <joe.lawrence@redhat.com> writes:
>> From: Nicolai Stange <nstange@suse.de>
>>
>> The ppc64 specific implementation of the reliable stacktracer,
>> save_stack_trace_tsk_reliable(), bails out and reports an "unreliable
>> trace" whenever it finds an exception frame on the stack. Stack frames
>> are classified as exception frames if the STACK_FRAME_REGS_MARKER magic,
>> as written by exception prologues, is found at a particular location.
>>
>> However, as observed by Joe Lawrence, it is possible in practice that
>> non-exception stack frames can alias with prior exception frames and thus,
>> that the reliable stacktracer can find a stale STACK_FRAME_REGS_MARKER on
>> the stack. It in turn falsely reports an unreliable stacktrace and blocks
>> any live patching transition to finish. Said condition lasts until the
>> stack frame is overwritten/initialized by function call or other means.
>>
>> In principle, we could mitigate this by making the exception frame
>> classification condition in save_stack_trace_tsk_reliable() stronger:
>> in addition to testing for STACK_FRAME_REGS_MARKER, we could also take into
>> account that for all exceptions executing on the kernel stack
>> - their stack frames's backlink pointers always match what is saved
>>   in their pt_regs instance's ->gpr[1] slot and that
>> - their exception frame size equals STACK_INT_FRAME_SIZE, a value
>>   uncommonly large for non-exception frames.
>>
>> However, while these are currently true, relying on them would make the
>> reliable stacktrace implementation more sensitive towards future changes in
>> the exception entry code. Note that false negatives, i.e. not detecting
>> exception frames, would silently break the live patching consistency model.
>>
>> Furthermore, certain other places (diagnostic stacktraces, perf, xmon)
>> rely on STACK_FRAME_REGS_MARKER as well.
>>
>> Make the exception exit code clear the on-stack STACK_FRAME_REGS_MARKER
>> for those exceptions running on the "normal" kernel stack and returning
>> to kernelspace: because the topmost frame is ignored by the reliable stack
>> tracer anyway, returns to userspace don't need to take care of clearing
>> the marker.
>>
>> Furthermore, as I don't have the ability to test this on Book 3E or
>> 32 bits, limit the change to Book 3S and 64 bits.
>>
>> Finally, make the HAVE_RELIABLE_STACKTRACE Kconfig option depend on
>> PPC_BOOK3S_64 for documentation purposes. Before this patch, it depended
>> on PPC64 && CPU_LITTLE_ENDIAN and because CPU_LITTLE_ENDIAN implies
>> PPC_BOOK3S_64, there's no functional change here.
>
> That has nothing to do with the fix and should really be in a separate
> patch.
>
> I can split it when applying.

If you don't mind, that would be nice! Or simply drop that
chunk... Otherwise, let me know if I shall send a split v2 for this
patch [1/4] only.

Thanks,

Nicolai

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284 (AG Nürnberg)
