Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26104C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DBB2082B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DBB2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbeJ0AOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 20:14:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbeJ0AOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 20:14:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B30B3003D40;
        Fri, 26 Oct 2018 15:37:09 +0000 (UTC)
Received: from treble (ovpn-123-167.rdu2.redhat.com [10.10.123.167])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 08021611D3;
        Fri, 26 Oct 2018 15:37:06 +0000 (UTC)
Date:   Fri, 26 Oct 2018 10:37:04 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Torsten Duwe <duwe@lst.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: reliable stacktraces
Message-ID: <20181026153704.7g34j3gtlklepyvb@treble>
References: <20181026142008.D922868C94@newverein.lst.de>
 <20181026142157.B8FAA68C97@newverein.lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181026142157.B8FAA68C97@newverein.lst.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 26 Oct 2018 15:37:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 04:21:57PM +0200, Torsten Duwe wrote:
> Enhance the stack unwinder so that it reports whether it had to stop
> normally or due to an error condition; unwind_frame() will report
> continue/error/normal ending and walk_stackframe() will pass that
> info. __save_stack_trace() is used to check the validity of a stack;
> save_stack_trace_tsk_reliable() can now trivially be implemented.
> Modify arch/arm64/kernel/time.c as the only external caller so far
> to recognise the new semantics.
> 
> I had to introduce a marker symbol kthread_return_to_user to tell
> the normal origin of a kernel thread.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>

I haven't looked at the code, but the commit log doesn't inspire much
confidence.  It's missing everything I previously asked for in the
powerpc version.

There's zero mention of objtool.  What analysis was done to indicate
that we can rely on frame pointers?

Such a frame pointer analysis should be included in the commit log.  It
should describe *at least* the following:

- whether inline asm statements with call/branch instructions will
  confuse GCC into skipping the frame pointer setup if it considers the
  function to be a leaf function;

- whether hand-coded non-leaf assembly functions can accidentally omit
  the frame pointer prologue setup;

- whether GCC can generally be relied upon to get arm64 frame pointers
  right, in both normal operation and edge cases.


The commit log should also describe whether the unwinder itself can be
considered reliable for all edge cases:

- detection and reporting of preemption and page faults;

- detection and recovery from function graph tracing;

- detection and reporting of other unexpected conditions,
  including when the unwinder doesn't reach the end of the stack.

-- 
Josh
