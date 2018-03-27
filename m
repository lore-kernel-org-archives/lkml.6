Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeC0HwG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 03:52:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55457 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbeC0HwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 03:52:04 -0400
Date: Tue, 27 Mar 2018 00:51:53 -0700
From: tip-bot for Alexey Dobriyan <tipbot@zytor.com>
Message-ID: <tip-bd6271039ee6f0c9b468148fc2d73e0584af6b4f@git.kernel.org>
Cc: adobriyan@gmail.com, bp@suse.de, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@kernel.org, adobriyan@gmail.com, bp@suse.de
In-Reply-To: <20180114120504.GA11368@avx2>
References: <20180114120504.GA11368@avx2>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/alternatives: Fixup alternative_call_2
Git-Commit-ID: bd6271039ee6f0c9b468148fc2d73e0584af6b4f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bd6271039ee6f0c9b468148fc2d73e0584af6b4f
Gitweb:     https://git.kernel.org/tip/bd6271039ee6f0c9b468148fc2d73e0584af6b4f
Author:     Alexey Dobriyan <adobriyan@gmail.com>
AuthorDate: Sun, 14 Jan 2018 15:05:04 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 27 Mar 2018 09:47:53 +0200

x86/alternatives: Fixup alternative_call_2

The following pattern fails to compile while the same pattern
with alternative_call() does:

	if (...)
		alternative_call_2(...);
	else
		alternative_call_2(...);

as it expands into

	if (...)
	{
	};	<===
	else
	{
	};

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20180114120504.GA11368@avx2

---
 arch/x86/include/asm/alternative.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index cf5961ca8677..4cd6a3b71824 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -218,13 +218,11 @@ static inline int alternatives_text_reserved(void *start, void *end)
  */
 #define alternative_call_2(oldfunc, newfunc1, feature1, newfunc2, feature2,   \
 			   output, input...)				      \
-{									      \
 	asm volatile (ALTERNATIVE_2("call %P[old]", "call %P[new1]", feature1,\
 		"call %P[new2]", feature2)				      \
 		: output, ASM_CALL_CONSTRAINT				      \
 		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		      \
-		  [new2] "i" (newfunc2), ## input);			      \
-}
+		  [new2] "i" (newfunc2), ## input)
 
 /*
  * use this macro(s) if you need more than one output parameter
