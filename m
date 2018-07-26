Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D744C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4158820685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4158820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731007AbeGZPk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730095AbeGZPk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:40:26 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC20F2064D;
        Thu, 26 Jul 2018 14:23:18 +0000 (UTC)
Date:   Thu, 26 Jul 2018 10:23:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nicolai Stange <nstange@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] x86/ftrace: fix live patching vs. tracing race
Message-ID: <20180726102317.550c986d@gandalf.local.home>
In-Reply-To: <20180726104029.7736-1-nstange@suse.de>
References: <20180726104029.7736-1-nstange@suse.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018 12:40:28 +0200
Nicolai Stange <nstange@suse.de> wrote:

> Hi,
> 
> if a user starts to trace a live patched function, its mcount call will get
> redirected from a trampoline to ftrace_regs_caller.
> 
> In preparation for that, ftrace on x86 first installs an int3 insn at that
> call site.
> 
> ftrace_int3_handler() in turn simply skips over the mcount call insn,
> effectively reverting the livepatch for that function during
> ftrace_replace_code().
> 
> This breaks KLP's consistency model.
> 
> 
> There are two possible options for fixing this:
> 1.) At the ftrace level.
> 2.) Search for a matching klp_ops from ftrace_int3_handler() and
>     handle the redirection if needed.
> 
> Both have their drawbacks, hence the RFC mode for this patch implementing
> 1.).
> 
> The main disadvantage is that it doesn't work on 32 bits (c.f. the patch
> description), but for KLP this would be fine.
> 
> OTOH, it keeps KLP specific code out of ftrace_int3_handler() and might
> perhaps be beneficial in other contexts as well.
> 
> Thanks for your comments!

Thanks, I need to revisit this code. I have ideas that would fix this
problem and improve the live patching code generally.

I'm hoping to get to this within the next month.

-- Steve

> 
> Nicolai
> 
> Nicolai Stange (1):
>   x86/ftrace: make ftrace_int3_handler() not to skip fops invocation
> 
>  arch/x86/kernel/ftrace.c    | 48 ++++++++++++++++++++++++++++++++------
>  arch/x86/kernel/ftrace_64.S | 56 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+), 7 deletions(-)
> 

