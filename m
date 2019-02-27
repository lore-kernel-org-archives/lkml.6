Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6795C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FEB217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551278620;
	bh=0moKi9ZDADvDamp5b4cHz81e+NQhJ8w3MIPUXyiDZQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t1AdF94kDpjUyAcLKWT6De5h99D+qDrreeFyfjgR1nla43ewzg5FUuqvwT1/nWu4q
	 maeVN3OjqxDwIxeeRlS+ins9tkl74N/Iq+GN975TXu8+7+bp1hCFwhTbhGLHq7GfU+
	 b/gPkxB2xM7ho8sxUN7sMi1r28dZOAUi38kT45q4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbfB0Onj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:43:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:52398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730098AbfB0Onj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:43:39 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 639DC2083D;
        Wed, 27 Feb 2019 14:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551278618;
        bh=0moKi9ZDADvDamp5b4cHz81e+NQhJ8w3MIPUXyiDZQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qsaoFDyLcZs/Ah/Mr6TLNv5rZYpyM1TMUmVS06B2IVId4IwmFjih8aaLQvZF0FtJD
         8tun5wgnh7kqQE8hP9DO/jVPKTcTlSqnHXLJTALTZppWtxnVgDUaFkowAChGupiDM1
         U6s7Iu5zYuZ5KP7nL0S6JIkOHte3oIjiGR76fYZc=
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
Subject: [PATCH v3 2/5] uaccess: Use user_access_ok() in user_access_begin()
Date:   Wed, 27 Feb 2019 23:43:14 +0900
Message-Id: <155127859433.32576.17845647712461950214.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <155127853496.32576.3705994926675037747.stgit@devbox>
References: <155127853496.32576.3705994926675037747.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use user_access_ok() instead of access_ok() in user_access_begin()
to validate the access context is user. This also allow us to
use (generic) strncpy_from_user() and strnlen_user() in atomic
state with setting USER_DS and disable pagefaults.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/include/asm/uaccess.h |    2 +-
 include/linux/uaccess.h        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3125d129d3b6..3b7502a34114 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -715,7 +715,7 @@ extern struct movsl_mask {
  */
 static __must_check inline bool user_access_begin(const void __user *ptr, size_t len)
 {
-	if (unlikely(!access_ok(ptr,len)))
+	if (unlikely(!user_access_ok(ptr, len)))
 		return 0;
 	__uaccess_begin_nospec();
 	return 1;
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index bf762689658b..1afd9dfabe67 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -282,7 +282,7 @@ extern long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
 	probe_kernel_read(&retval, addr, sizeof(retval))
 
 #ifndef user_access_begin
-#define user_access_begin(ptr,len) access_ok(ptr, len)
+#define user_access_begin(ptr, len) user_access_ok(ptr, len)
 #define user_access_end() do { } while (0)
 #define unsafe_get_user(x, ptr, err) do { if (unlikely(__get_user(x, ptr))) goto err; } while (0)
 #define unsafe_put_user(x, ptr, err) do { if (unlikely(__put_user(x, ptr))) goto err; } while (0)

