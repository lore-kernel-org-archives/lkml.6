Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F73C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415BF208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415BF208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbeK1EC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:02:57 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43603 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeK1EC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:02:57 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wARH3vT71944735
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 27 Nov 2018 09:03:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wARH3uib1944732;
        Tue, 27 Nov 2018 09:03:56 -0800
Date:   Tue, 27 Nov 2018 09:03:56 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-ac26d1f74cfc19c8dc9d533b5f20e99dbee3d9bd@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@redhat.com,
        naveen.n.rao@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, bp@suse.de, x86@kernel.org, hpa@zytor.com,
        mingo@kernel.org, luto@kernel.org, jannh@google.com
Reply-To: naveen.n.rao@linux.vnet.ibm.com, mingo@redhat.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          bigeasy@linutronix.de, bp@suse.de, x86@kernel.org,
          luto@kernel.org, jannh@google.com, hpa@zytor.com,
          mingo@kernel.org
In-Reply-To: <20181127133200.38322-1-jannh@google.com>
References: <20181126165957.xhsyu2dhyy45mrjo@linutronix.de>
        <20181127133200.38322-1-jannh@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/fpu: Use the correct exception table macro in
 the XSTATE_OP wrapper
Git-Commit-ID: ac26d1f74cfc19c8dc9d533b5f20e99dbee3d9bd
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

Commit-ID:  ac26d1f74cfc19c8dc9d533b5f20e99dbee3d9bd
Gitweb:     https://git.kernel.org/tip/ac26d1f74cfc19c8dc9d533b5f20e99dbee3d9bd
Author:     Jann Horn <jannh@google.com>
AuthorDate: Tue, 27 Nov 2018 14:32:00 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 27 Nov 2018 17:55:45 +0100

x86/fpu: Use the correct exception table macro in the XSTATE_OP wrapper

Commit

  75045f77f7a7 ("x86/extable: Introduce _ASM_EXTABLE_UA for uaccess fixups")

incorrectly replaced the fixup entry for XSTATE_OP with a user-#PF-only
fixup. XRSTOR can also raise #GP if the xstate content is invalid,
and _ASM_EXTABLE_UA doesn't expect that. Change this fixup back to
_ASM_EXTABLE so that #GP gets fixed up.

Fixes: 75045f77f7a7 ("x86/extable: Introduce _ASM_EXTABLE_UA for uaccess fixups")
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-hardening@lists.openwall.com
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20181126165957.xhsyu2dhyy45mrjo@linutronix.de
Link: https://lkml.kernel.org/r/20181127133200.38322-1-jannh@google.com
---
 arch/x86/include/asm/fpu/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 5f7290e6e954..69dcdf195b61 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -226,7 +226,7 @@ static inline void copy_fxregs_to_kernel(struct fpu *fpu)
 		     "3: movl $-2,%[err]\n\t"				\
 		     "jmp 2b\n\t"					\
 		     ".popsection\n\t"					\
-		     _ASM_EXTABLE_UA(1b, 3b)				\
+		     _ASM_EXTABLE(1b, 3b)				\
 		     : [err] "=r" (err)					\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
