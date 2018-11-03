Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1F9C6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE852082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE852082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbeKCTWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 15:22:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:50594 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726849AbeKCTWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 15:22:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0CC4FACFF;
        Sat,  3 Nov 2018 10:11:22 +0000 (UTC)
Date:   Sat, 3 Nov 2018 11:11:20 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Nadav Amit <namit@vmware.com>
cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v3 1/7] Fix "x86/alternatives: Lockdep-enforce text_mutex
 in text_poke*()"
In-Reply-To: <20181102232946.98461-2-namit@vmware.com>
Message-ID: <nycvar.YFH.7.76.1811031109570.21975@cbobk.fhfr.pm>
References: <20181102232946.98461-1-namit@vmware.com> <20181102232946.98461-2-namit@vmware.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2018, Nadav Amit wrote:

> text_mutex is expected to be held before text_poke() is called, but we
> cannot add a lockdep assertion since kgdb does not take it, and instead
> *supposedly* ensures the lock is not taken and will not be acquired by
> any other core while text_poke() is running.
> 
> The reason for the "supposedly" comment is that it is not entirely clear
> that this would be the case if gdb_do_roundup is zero.
> 
> Add a comment to clarify this behavior, and restore the assertions as
> they were before the recent commit.
> 
> This partially reverts commit 9222f606506c ("x86/alternatives:
> Lockdep-enforce text_mutex in text_poke*()")

Alright, what can we do. It's probably better to have this, rather than to 
trying to work this around in kgdb to accomodate the rest of the world.

> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Fixes: 9222f606506c ("x86/alternatives: Lockdep-enforce text_mutex in text_poke*()")
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>

Acked-by: Jiri Kosina <jkosina@suse.cz>

Thanks,

-- 
Jiri Kosina
SUSE Labs

