Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rsO+Ce/ZHVvCcwAAmS7hNA
	; Mon, 11 Jun 2018 02:10:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0178F608BA; Mon, 11 Jun 2018 02:10:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D6E6C60850;
	Mon, 11 Jun 2018 02:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D6E6C60850
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753878AbeFKCKc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 22:10:32 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40576 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753728AbeFKCKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 22:10:30 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fSCHt-0005gr-11; Mon, 11 Jun 2018 02:10:29 +0000
Date: Mon, 11 Jun 2018 03:10:29 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: perfmon trouble
Message-ID: <20180611021028.GT30522@ZenIV.linux.org.uk>
References: <20180608184842.GD30522@ZenIV.linux.org.uk>
 <CA+55aFz9cS3m=wZxqKbzrCLEjhPoPddKw5U2MDKNqbG79Wx6bw@mail.gmail.com>
 <20180609051051.GF30522@ZenIV.linux.org.uk>
 <20180609155107.GH30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609155107.GH30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 09, 2018 at 04:51:08PM +0100, Al Viro wrote:

> Stephane, could you comment on the situation in there?  I realize that you
> hadn't touched that thing in more than a decade, but I've no idea who else
> might be familiar with that thing and it's very inconveniently special...

Having looked through that code... ouch.  It tries to have munmap-on-close,
of all things.  Which has interesting consequences; consider, for example,
	fd = perfctl(-1, PFM_CREATE_CONTEXT, &blah, 1);	// create a context
	....
	pid = fork();
	if (!pid) {
		execve("/usr/bin/something_suid", ...);
		...
	}

with something_suid(8) doing an explicit "close each descriptor past stdout"
loop.

PFM_CREATE_CONTEXT has created a context, mmapped its buffer (and stored
the address of that mapping in ctx->ctx_smpl_vaddr) and, having opened
an associated file, sticks it into descriptor table and returns the descriptor.

On fork/exec we have
	* descriptor table copied to child
	* all mappings copied to child and then destroyed by execve
	* execve ends up with the new binary (and libraries, etc.) mmapped
(in child)

Now, our careful suid-root binary does close(2) on its copy of descriptor.
pfm_flush() is called.  ctx->task != current, so we proceed to
        /*
         * remove virtual mapping, if any, for the calling task.
         * cannot reset ctx field until last user is calling close().
         *
         * ctx_smpl_vaddr must never be cleared because it is needed
         * by every task with access to the context
         *
         * When called from do_exit(), the mm context is gone already, therefore
         * mm is NULL, i.e., the VMA is already gone  and we do not have to
         * do anything here
         */
        if (ctx->ctx_smpl_vaddr && current->mm) {
                smpl_buf_vaddr = ctx->ctx_smpl_vaddr;
                smpl_buf_size  = ctx->ctx_smpl_size;
        }

        UNPROTECT_CTX(ctx, flags);

        /*
         * if there was a mapping, then we systematically remove it
         * at this point. Cannot be done inside critical section
         * because some VM function reenables interrupts.
         *
         */
        if (smpl_buf_vaddr) pfm_remove_smpl_mapping(smpl_buf_vaddr, smpl_buf_size);

... with the last call doing vm_munmap() on the area in question.  In the
address space of that suid-root binary, taking out whatever *it* had mapped
at that address range...

I wouldn't be surprised if that turned out to be realistically exploitable ;-/
Is there any documentation of that thing's semantics?  perfmonctl(2) doesn't
mention the mapping at all and link to HP site in the arch/ia64/kernel/perfmon.c
is 404-compliant.  Playing with archive.org brings a sourceforget reference,
but I hadn't been able to find anything ia64-related docs in there...
