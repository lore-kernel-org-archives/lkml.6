Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F29C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163B2223C8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163B2223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbeKLU1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:27:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54275 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbeKLU1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:27:19 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wACAXqMY3655534
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 12 Nov 2018 02:33:52 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wACAXpXE3655529;
        Mon, 12 Nov 2018 02:33:51 -0800
Date:   Mon, 12 Nov 2018 02:33:51 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-1d8ca3be86ebc6a38dad8236f45c7a9c61681e78@git.kernel.org>
Cc:     riel@surriel.com, mingo@kernel.org, longman@redhat.com,
        luto@kernel.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, brgerst@gmail.com,
        torvalds@linux-foundation.org, bp@alien8.de, hpa@zytor.com,
        dvlasenk@redhat.com, peterz@infradead.org, tglx@linutronix.de
Reply-To: dvlasenk@redhat.com, bp@alien8.de, hpa@zytor.com,
          torvalds@linux-foundation.org, brgerst@gmail.com,
          tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
          luto@kernel.org, longman@redhat.com, riel@surriel.com,
          linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com
In-Reply-To: <1541535149-31963-1-git-send-email-longman@redhat.com>
References: <1541535149-31963-1-git-send-email-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/fault: Allow stack access below %rsp
Git-Commit-ID: 1d8ca3be86ebc6a38dad8236f45c7a9c61681e78
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

Commit-ID:  1d8ca3be86ebc6a38dad8236f45c7a9c61681e78
Gitweb:     https://git.kernel.org/tip/1d8ca3be86ebc6a38dad8236f45c7a9c61681e78
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Tue, 6 Nov 2018 15:12:29 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Nov 2018 11:06:19 +0100

x86/mm/fault: Allow stack access below %rsp

The current x86 page fault handler allows stack access below the stack
pointer if it is no more than 64k+256 bytes. Any access beyond the 64k+
limit will cause a segmentation fault.

The gcc -fstack-check option generates code to probe the stack for
large stack allocation to see if the stack is accessible. The newer gcc
does that while updating the %rsp simultaneously. Older gcc's like gcc4
doesn't do that. As a result, an application compiled with an old gcc
and the -fstack-check option may fail to start at all:

  $ cat test.c
  int main() {
	char tmp[1024*128];
	printf("### ok\n");
	return 0;
  }

  $ gcc -fstack-check -g -o test test.c

  $ ./test
  Segmentation fault

The old binary was working in older kernels where expand_stack() was
somehow called before the check. But it is not working in newer kernels.
Besides, the 64k+ limit check is kind of crude and will not catch a
lot of mistakes that userspace applications may be misbehaving anyway.
I think the kernel isn't the right place for this kind of tests. We
should leave it to userspace instrumentation tools to perform them.

The 64k+ limit check is now removed to just let expand_stack() decide
if a segmentation fault should happen, when the RLIMIT_STACK limit is
exceeded, for example.

Signed-off-by: Waiman Long <longman@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1541535149-31963-1-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/fault.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 71d4b9d4d43f..29525cf21100 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1380,18 +1380,6 @@ retry:
 		bad_area(regs, sw_error_code, address);
 		return;
 	}
-	if (sw_error_code & X86_PF_USER) {
-		/*
-		 * Accessing the stack below %sp is always a bug.
-		 * The large cushion allows instructions like enter
-		 * and pusha to work. ("enter $65535, $31" pushes
-		 * 32 pointers and then decrements %sp by 65535.)
-		 */
-		if (unlikely(address + 65536 + 32 * sizeof(unsigned long) < regs->sp)) {
-			bad_area(regs, sw_error_code, address);
-			return;
-		}
-	}
 	if (unlikely(expand_stack(vma, address))) {
 		bad_area(regs, sw_error_code, address);
 		return;
