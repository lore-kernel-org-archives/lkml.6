Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3067AC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC93F20652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/1a+6JL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC93F20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbeJKXIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:08:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbeJKXH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:07:58 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CC332098A;
        Thu, 11 Oct 2018 15:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272414;
        bh=A2gQ7TDBXsZ+An+IGUzWx5pxL2iYLR7fIYvsnLDkqZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y/1a+6JLDlnTyhHgXeobNFgOYi7RHQKp7JVvWJF03ij1P8Bhh+QZ3uyMHR7fswoyP
         aVLpMUlGp9vVnvIEiV+19vPNZWsthJ3krtFpD50/W6c3b1DVBxeoe6DmisvDDxTbUf
         I2MdYlYQoo9hcSscoe/6ujSbOg7h6si1XrEwFN8s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ken Chen <kenchen@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3.18 100/120] proc: restrict kernel stack dumps to root
Date:   Thu, 11 Oct 2018 17:34:41 +0200
Message-Id: <20181011152553.924485370@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/proc/base.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -279,6 +279,20 @@ static int proc_pid_stack(struct seq_fil
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


