Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C6EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870C021927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfBORWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:22:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfBORWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:22:12 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 785E221925;
        Fri, 15 Feb 2019 17:22:11 +0000 (UTC)
Date:   Fri, 15 Feb 2019 12:22:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/2] [GIT PULL] tracing: Two more fixes
Message-ID: <20190215122210.517fb1f5@gandalf.local.home>
In-Reply-To: <CAHk-=wj9vT-Wma+1tT2OA7om2UVavydPv6EsPNOT658sE0Z6=g@mail.gmail.com>
References: <20190215142015.860423791@goodmis.org>
        <CAHk-=wj9vT-Wma+1tT2OA7om2UVavydPv6EsPNOT658sE0Z6=g@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 09:08:38 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Feb 15, 2019 at 6:21 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >  - Have kprobes not use copy_from_user to access kernel addresses
> >    as this is now considered a security issue.  
> 
> No, you people are confused.
> 
> The problem isn't that it's using a user access function on kernel memory.
> 
> The problem is that it's using a user access function on a complete
> garbage pointer that happens to not even be a valid pointer at all.
> 
> You get a GP fault because the code tries to access an address at
> 0x2e646c2f6374652f.
> 
> That's not a valid pointer on x86-64. Nothing to do with user or
> kernel, everything to do with "it's garbage".
> 
> Switching over to probe_mem_read() just means that even non-canonical
> address faults are ignored. But it has absolutely nothing to do with
> "kernel addresses" or any security issues.
> 
> So the patch looks like it might be ok, but the explanations for it
> are garbage and only confuse the issue.
> 
> Please fix the explanations, I don't want to have actively wrong
> commit messages for when people start looking at things like this.
> 

OK, I'll update the change log. Yeah, the bug is that we are reading
possibly bad kernel memory, which is what kprobes do.

Will update.

-- Steve
