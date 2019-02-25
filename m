Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2963AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AB32084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfBYTqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:46:23 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37077 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfBYTqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:46:23 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1PJk66I1842431
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 25 Feb 2019 11:46:06 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1PJk33h1842427;
        Mon, 25 Feb 2019 11:46:03 -0800
Date:   Mon, 25 Feb 2019 11:46:03 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-2a418cf3f5f1caf911af288e978d61c9844b0695@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, dvlasenk@redhat.com, bp@suse.de,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        brgerst@gmail.com, jpoimboe@redhat.com, mingo@kernel.org,
        peterz@infradead.org, luto@kernel.org, hpa@zytor.com
Reply-To: mingo@kernel.org, bp@suse.de, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          dvlasenk@redhat.com, brgerst@gmail.com, jpoimboe@redhat.com,
          hpa@zytor.com, luto@kernel.org, peterz@infradead.org
In-Reply-To: <20190225125231.845656645@infradead.org>
References: <20190225125231.845656645@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/uaccess: Don't leak the AC flag into
 __put_user() value evaluation
Git-Commit-ID: 2a418cf3f5f1caf911af288e978d61c9844b0695
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  2a418cf3f5f1caf911af288e978d61c9844b0695
Gitweb:     https://git.kernel.org/tip/2a418cf3f5f1caf911af288e978d61c9844b0695
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Fri, 22 Feb 2019 17:17:04 -0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 25 Feb 2019 20:17:05 +0100

x86/uaccess: Don't leak the AC flag into __put_user() value evaluation

When calling __put_user(foo(), ptr), the __put_user() macro would call
foo() in between __uaccess_begin() and __uaccess_end().  If that code
were buggy, then those bugs would be run without SMAP protection.

Fortunately, there seem to be few instances of the problem in the
kernel. Nevertheless, __put_user() should be fixed to avoid doing this.
Therefore, evaluate __put_user()'s argument before setting AC.

This issue was noticed when an objtool hack by Peter Zijlstra complained
about genregs_get() and I compared the assembly output to the C source.

 [ bp: Massage commit message and fixed up whitespace. ]

Fixes: 11f1a4b9755f ("x86: reorganize SMAP handling in user space accesses")
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20190225125231.845656645@infradead.org
---
 arch/x86/include/asm/uaccess.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index a77445d1b034..28376aa2d053 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -284,7 +284,7 @@ do {									\
 		__put_user_goto(x, ptr, "l", "k", "ir", label);		\
 		break;							\
 	case 8:								\
-		__put_user_goto_u64((__typeof__(*ptr))(x), ptr, label);	\
+		__put_user_goto_u64(x, ptr, label);			\
 		break;							\
 	default:							\
 		__put_user_bad();					\
@@ -431,8 +431,10 @@ do {									\
 ({								\
 	__label__ __pu_label;					\
 	int __pu_err = -EFAULT;					\
+	__typeof__(*(ptr)) __pu_val;				\
+	__pu_val = x;						\
 	__uaccess_begin();					\
-	__put_user_size((x), (ptr), (size), __pu_label);	\
+	__put_user_size(__pu_val, (ptr), (size), __pu_label);	\
 	__pu_err = 0;						\
 __pu_label:							\
 	__uaccess_end();					\
