Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCC4C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE6D2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE6D2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbeKCEs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:48:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbeKCEs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:48:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1B90031256B4;
        Fri,  2 Nov 2018 19:40:29 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBD795D9C7;
        Fri,  2 Nov 2018 19:40:25 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [RFC PATCH] x86/mm/fault: Allow stack access below %rsp
Date:   Fri,  2 Nov 2018 15:40:10 -0400
Message-Id: <1541187610-5322-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 02 Nov 2018 19:40:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current x86 page fault handler allows stack access below the stack
pointer if it is no more than 64k+256 bytes. Any access beyond the 64k+
limit will cause a segmentation fault.

The gcc -fstack-check option generates code to probe the stack for
large stack allocation to see if the stack is accessible. The newer gcc
does that while updating the %rsp simultaneously. Older gcc's like gcc4
doesn't do that. As a result, an application compiled with an old gcc
and the -fstack-check option may fail to start at all.

% cat test.c
int main() {
	char tmp[1024*128];
	printf("### ok\n");
	return 0;
}
% gcc -fstack-check -g -o test test.c
% ./test
Segmentation fault

The 64k+ limit check is kind of arbitrary. So the check is now removed
to just let expand_stack() decide if a segmentation fault should happen.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/mm/fault.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 71d4b9d..29525cf 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1380,18 +1380,6 @@ void do_user_addr_fault(struct pt_regs *regs,
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
-- 
1.8.3.1

