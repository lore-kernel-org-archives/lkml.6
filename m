Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C34C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE5E2089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE5E2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbeJASc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:32:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34641 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbeJASc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:32:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w91BspTt1550595
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 1 Oct 2018 04:54:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w91BspMd1550592;
        Mon, 1 Oct 2018 04:54:51 -0700
Date:   Mon, 1 Oct 2018 04:54:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Uros Bizjak <tipbot@zytor.com>
Message-ID: <tip-c808c09b527cd60d9a0d53799935f75e2452174d@git.kernel.org>
Cc:     bp@suse.de, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        ubizjak@gmail.com, mingo@kernel.org, hpa@zytor.com
Reply-To: hpa@zytor.com, mingo@kernel.org, ubizjak@gmail.com, bp@suse.de,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <CAFULd4YdvwwhXWHqqPsGk5+TLG71ozgSscTZNsqmrm+Jzg941w@mail.gmail.com>
References: <CAFULd4YdvwwhXWHqqPsGk5+TLG71ozgSscTZNsqmrm+Jzg941w@mail.gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/asm: Use CC_SET()/CC_OUT() in __cmpxchg_double()
Git-Commit-ID: c808c09b527cd60d9a0d53799935f75e2452174d
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

Commit-ID:  c808c09b527cd60d9a0d53799935f75e2452174d
Gitweb:     https://git.kernel.org/tip/c808c09b527cd60d9a0d53799935f75e2452174d
Author:     Uros Bizjak <ubizjak@gmail.com>
AuthorDate: Fri, 28 Sep 2018 10:33:05 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 1 Oct 2018 13:46:32 +0200

x86/asm: Use CC_SET()/CC_OUT() in __cmpxchg_double()

Replace open-coded use of the SETcc instruction with CC_SET()/CC_OUT()
in __cmpxchg_double().

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/CAFULd4YdvwwhXWHqqPsGk5+TLG71ozgSscTZNsqmrm+Jzg941w@mail.gmail.com
---
 arch/x86/include/asm/cmpxchg.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index a55d79b233d3..bfb85e5844ab 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -242,10 +242,12 @@ extern void __add_wrong_size(void)
 	BUILD_BUG_ON(sizeof(*(p2)) != sizeof(long));			\
 	VM_BUG_ON((unsigned long)(p1) % (2 * sizeof(long)));		\
 	VM_BUG_ON((unsigned long)((p1) + 1) != (unsigned long)(p2));	\
-	asm volatile(pfx "cmpxchg%c4b %2; sete %0"			\
-		     : "=a" (__ret), "+d" (__old2),			\
-		       "+m" (*(p1)), "+m" (*(p2))			\
-		     : "i" (2 * sizeof(long)), "a" (__old1),		\
+	asm volatile(pfx "cmpxchg%c5b %1"				\
+		     CC_SET(e)						\
+		     : CC_OUT(e) (__ret),				\
+		       "+m" (*(p1)), "+m" (*(p2)),			\
+		       "+a" (__old1), "+d" (__old2)			\
+		     : "i" (2 * sizeof(long)),				\
 		       "b" (__new1), "c" (__new2));			\
 	__ret;								\
 })
