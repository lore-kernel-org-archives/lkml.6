Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255BCECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC82F2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC82F2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389546AbeGPIMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:12:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51356 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbeGPIMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:12:51 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1C86FCEE;
        Mon, 16 Jul 2018 07:45:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Gerst <brgerst@gmail.com>,
        Alexander Kuleshov <kuleshovmail@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Alexander Popov <alpopov@ptsecurity.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 28/43] x86/boot: Simplify kernel load address alignment check
Date:   Mon, 16 Jul 2018 09:36:33 +0200
Message-Id: <20180716073514.984005719@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073511.796555857@linuxfoundation.org>
References: <20180716073511.796555857@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Kuleshov <kuleshovmail@gmail.com>

commit a4733143085d6c782ac1e6c85778655b6bac1d4e upstream

We are using %rax as temporary register to check the kernel
address alignment. We don't really have to since the TEST
instruction does not clobber the destination operand.

Suggested-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Alexander Popov <alpopov@ptsecurity.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1453531828-19291-1-git-send-email-kuleshovmail@gmail.com
Link: http://lkml.kernel.org/r/1453842730-28463-11-git-send-email-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/kernel/head_64.S |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -76,9 +76,7 @@ startup_64:
 	subq	$_text - __START_KERNEL_map, %rbp
 
 	/* Is the address not 2M aligned? */
-	movq	%rbp, %rax
-	andl	$~PMD_PAGE_MASK, %eax
-	testl	%eax, %eax
+	testl	$~PMD_PAGE_MASK, %ebp
 	jnz	bad_address
 
 	/*


