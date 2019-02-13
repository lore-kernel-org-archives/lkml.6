Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4F9C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B397820811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083788;
	bh=43t9RQV0YB3jHRF5k5Bvelc+kOLLR3H2QgjnMwYY6iY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P78+ITDdNoTfCcf6EwVTwZEobmONJbi84os1g49CIN22ocLy4cwYQUguZntMobLjc
	 BcVFMZG5SHOWGq7jV29eBsBO3Q5gVPewAVHfUKk0fKpfj3behCfOSNLh4UqZDiMdDz
	 k56h/flzJp7rlVtElLZfnM3aAF/3NoSnKKXGxrn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390811AbfBMStr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:49:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:43494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406170AbfBMSow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:44:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A741B20835;
        Wed, 13 Feb 2019 18:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083491;
        bh=43t9RQV0YB3jHRF5k5Bvelc+kOLLR3H2QgjnMwYY6iY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lr02W/PpUXSKakgStbyeegPxyaMbSH5gxB9j2+K1Mi6eAE8/t8mmGpv7bLkJcVN2V
         5bOC+xh8XFzveEchtCl4lI6MUgso/w/uNNAAkaFPiAR1BCjuxjo/eBCmMI3y6zfm+0
         SRVq2suZO2Ki34ueeDiwXCgx50R0ujIyqK3WQpkY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Jack Andersen <jackoalan@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4.20 10/50] signal: Always attempt to allocate siginfo for SIGSTOP
Date:   Wed, 13 Feb 2019 19:38:15 +0100
Message-Id: <20190213183656.636948103@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric W. Biederman <ebiederm@xmission.com>

commit a692933a87691681e880feb708081681ff32400a upstream.

Since 2.5.34 the code has had the potential to not allocate siginfo
for SIGSTOP signals.  Except for ptrace this is perfectly fine as only
ptrace can use PTRACE_PEEK_SIGINFO and see what the contents of
the delivered siginfo are.

Users of PTRACE_PEEK_SIGINFO that care about the contents siginfo
for SIGSTOP are rare, but they do exist.  A seccomp self test
has cared and lldb cares.

Jack Andersen <jackoalan@gmail.com> writes:

> The patch titled
> `signal: Never allocate siginfo for SIGKILL or SIGSTOP`
> created a regression for users of PTRACE_GETSIGINFO needing to
> discern signals that were raised via the tgkill syscall.
>
> A notable user of this tgkill+ptrace combination is lldb while
> debugging a multithreaded program. Without the ability to detect a
> SIGSTOP originating from tgkill, lldb does not have a way to
> synchronize on a per-thread basis and falls back to SIGSTOP-ing the
> entire process.

Everyone affected by this please note.  The kernel can still fail to
allocate a siginfo structure.  The allocation is with GFP_KERNEL and
is best effort only.  If memory is tight when the signal allocation
comes in this will fail to allocate a siginfo.

So I strongly recommend looking at more robust solutions for
synchronizing with a single thread such as PTRACE_INTERRUPT.  Or if
that does not work persuading your friendly local kernel developer to
build the interface you need.

Reported-by: Tycho Andersen <tycho@tycho.ws>
Reported-by: Kees Cook <keescook@chromium.org>
Reported-by: Jack Andersen <jackoalan@gmail.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Christian Brauner <christian@brauner.io>
Cc: stable@vger.kernel.org
Fixes: f149b3155744 ("signal: Never allocate siginfo for SIGKILL or SIGSTOP")
Fixes: 6dfc88977e42 ("[PATCH] shared thread signals")
History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/signal.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1057,10 +1057,9 @@ static int __send_signal(int sig, struct
 
 	result = TRACE_SIGNAL_DELIVERED;
 	/*
-	 * Skip useless siginfo allocation for SIGKILL SIGSTOP,
-	 * and kernel threads.
+	 * Skip useless siginfo allocation for SIGKILL and kernel threads.
 	 */
-	if (sig_kernel_only(sig) || (t->flags & PF_KTHREAD))
+	if ((sig == SIGKILL) || (t->flags & PF_KTHREAD))
 		goto out_set;
 
 	/*


