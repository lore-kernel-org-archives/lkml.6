Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A64C67838
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8375D20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8375D20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbeLIWUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:20:39 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35404 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726547AbeLIVzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:24 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72n-0002po-IM; Sun, 09 Dec 2018 21:55:21 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72k-0003ff-R6; Sun, 09 Dec 2018 21:55:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Laura Abbott" <labbott@redhat.com>,
        "Alexey Dobriyan" <adobriyan@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Kees Cook" <keescook@chromium.org>,
        "Will Deacon" <will.deacon@arm.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Ingo Molnar" <mingo@redhat.com>, "Ken Chen" <kenchen@google.com>,
        "Andy Lutomirski" <luto@amacapital.net>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Jann Horn" <jannh@google.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.31224139@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 300/328] proc: restrict kernel stack dumps to root
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit f8a00cef17206ecd1b30d3d9f99e10d9fa707aa7 upstream.

Currently, you can use /proc/self/task/*/stack to cause a stack walk on
a task you control while it is running on another CPU.  That means that
the stack can change under the stack walker.  The stack walker does
have guards against going completely off the rails and into random
kernel memory, but it can interpret random data from your kernel stack
as instruction pointers and stack pointers.  This can cause exposure of
kernel stack contents to userspace.

Restrict the ability to inspect kernel stacks of arbitrary tasks to root
in order to prevent a local attacker from exploiting racy stack unwinding
to leak kernel task stack contents.  See the added comment for a longer
rationale.

There don't seem to be any users of this userspace API that can't
gracefully bail out if reading from the file fails.  Therefore, I believe
that this change is unlikely to break things.  In the case that this patch
does end up needing a revert, the next-best solution might be to fake a
single-entry stack based on wchan.

Link: http://lkml.kernel.org/r/20180927153316.200286-1-jannh@google.com
Fixes: 2ec220e27f50 ("proc: add /proc/*/stack")
Signed-off-by: Jann Horn <jannh@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Ken Chen <kenchen@google.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/proc/base.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -273,6 +273,20 @@ static int proc_pid_stack(struct seq_fil
 	int err;
 	int i;
 
+	/*
+	 * The ability to racily run the kernel stack unwinder on a running task
+	 * and then observe the unwinder output is scary; while it is useful for
+	 * debugging kernel issues, it can also allow an attacker to leak kernel
+	 * stack contents.
+	 * Doing this in a manner that is at least safe from races would require
+	 * some work to ensure that the remote task can not be scheduled; and
+	 * even then, this would still expose the unwinder as local attack
+	 * surface.
+	 * Therefore, this interface is restricted to root.
+	 */
+	if (!file_ns_capable(m->file, &init_user_ns, CAP_SYS_ADMIN))
+		return -EACCES;
+
 	entries = kmalloc(MAX_STACK_TRACE_DEPTH * sizeof(*entries), GFP_KERNEL);
 	if (!entries)
 		return -ENOMEM;

