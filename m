Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E2DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C612146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551103538;
	bh=YkeYU9K+iLNPiMGrCvvnmomWHZ6kdO+Fx9BmREtfBfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z9cAhKpqiHH94ZdMUBiZcL9gahSeBvpw4GijFKuVq5hmKZvzGDUD89REcPQSkvQeR
	 OGaTeLVkYGtml17JnAEvksGqcnEqAurrgNQhFfizSgbk5BAzmM1XNV8VbTQO4vR4CY
	 e58BuOYoslZ+yjN5/XrknHjE9KGMa+UcMvxcInrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfBYOFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:05:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:51344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbfBYOFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:05:37 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B000320663;
        Mon, 25 Feb 2019 14:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551103535;
        bh=YkeYU9K+iLNPiMGrCvvnmomWHZ6kdO+Fx9BmREtfBfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GKIk0jkwqd6vzzbsO7t16xWq5bEZ25LkoHzkTe2B9ixMdzC9IUD0cubc+jYMs+GnH
         NtaxwigcZoNkn3X76zdsB1JlyNwTZsVHzR5kDMPNu0hmU5iRFx1W1wbKW0eb8yj8VS
         2uyShnqphItzk7XjP7avAnBXTNtr9nD2JVTWZfnI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 1/4] uaccess: Make sure kernel_uaccess_faults_ok is updated before pagefault
Date:   Mon, 25 Feb 2019 23:05:11 +0900
Message-Id: <155110351173.21156.682447092137241969.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <155110348217.21156.3874419272673328527.stgit@devbox>
References: <155110348217.21156.3874419272673328527.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure the kernel_uaccess_faults_ok is updated before a
pagefault can hit and the last loads/stores issued before
resotring kernel_uaccess_faults_ok.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 fs/namespace.c |    2 ++
 mm/maccess.c   |   12 ++++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a677b59efd74..88a8e0eb6234 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2699,6 +2699,7 @@ static long exact_copy_from_user(void *to, const void __user * from,
 		return n;
 
 	current->kernel_uaccess_faults_ok++;
+	barrier();
 	while (n) {
 		if (__get_user(c, f)) {
 			memset(t, 0, n);
@@ -2708,6 +2709,7 @@ static long exact_copy_from_user(void *to, const void __user * from,
 		f++;
 		n--;
 	}
+	barrier();
 	current->kernel_uaccess_faults_ok--;
 	return n;
 }
diff --git a/mm/maccess.c b/mm/maccess.c
index f3416632e5a4..7a9752d59587 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -29,12 +29,12 @@ long __probe_kernel_read(void *dst, const void *src, size_t size)
 	mm_segment_t old_fs = get_fs();
 
 	set_fs(KERNEL_DS);
-	pagefault_disable();
 	current->kernel_uaccess_faults_ok++;
+	pagefault_disable();
 	ret = __copy_from_user_inatomic(dst,
 			(__force const void __user *)src, size);
-	current->kernel_uaccess_faults_ok--;
 	pagefault_enable();
+	current->kernel_uaccess_faults_ok--;
 	set_fs(old_fs);
 
 	return ret ? -EFAULT : 0;
@@ -59,11 +59,11 @@ long __probe_kernel_write(void *dst, const void *src, size_t size)
 	mm_segment_t old_fs = get_fs();
 
 	set_fs(KERNEL_DS);
-	pagefault_disable();
 	current->kernel_uaccess_faults_ok++;
+	pagefault_disable();
 	ret = __copy_to_user_inatomic((__force void __user *)dst, src, size);
-	current->kernel_uaccess_faults_ok--;
 	pagefault_enable();
+	current->kernel_uaccess_faults_ok--;
 	set_fs(old_fs);
 
 	return ret ? -EFAULT : 0;
@@ -97,16 +97,16 @@ long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count)
 		return 0;
 
 	set_fs(KERNEL_DS);
-	pagefault_disable();
 	current->kernel_uaccess_faults_ok++;
+	pagefault_disable();
 
 	do {
 		ret = __get_user(*dst++, (const char __user __force *)src++);
 	} while (dst[-1] && ret == 0 && src - unsafe_addr < count);
 
-	current->kernel_uaccess_faults_ok--;
 	dst[-1] = '\0';
 	pagefault_enable();
+	current->kernel_uaccess_faults_ok--;
 	set_fs(old_fs);
 
 	return ret ? -EFAULT : src - unsafe_addr;

