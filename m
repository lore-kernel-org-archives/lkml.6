Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DD9C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC152172F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC152172F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404273AbeHGVKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:10:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33582 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733122AbeHGVKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:10:42 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AE5743EE;
        Tue,  7 Aug 2018 18:54:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [PATCH 4.9 14/17] kmemleak: clear stale pointers from task stacks
Date:   Tue,  7 Aug 2018 20:51:50 +0200
Message-Id: <20180807172342.867453448@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172342.071526922@linuxfoundation.org>
References: <20180807172342.071526922@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

commit ca182551857cc2c1e6a2b7f1e72090a137a15008 upstream.

Kmemleak considers any pointers on task stacks as references.  This
patch clears newly allocated and reused vmap stacks.

Link: http://lkml.kernel.org/r/150728990124.744199.8403409836394318684.stgit@buzz
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[ Srivatsa: Backported to 4.9.y ]
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/thread_info.h |    2 +-
 kernel/fork.c               |    4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -59,7 +59,7 @@ extern long do_no_restart_syscall(struct
 
 #ifdef __KERNEL__
 
-#ifdef CONFIG_DEBUG_STACK_USAGE
+#if IS_ENABLED(CONFIG_DEBUG_STACK_USAGE) || IS_ENABLED(CONFIG_DEBUG_KMEMLEAK)
 # define THREADINFO_GFP		(GFP_KERNEL_ACCOUNT | __GFP_NOTRACK | \
 				 __GFP_ZERO)
 #else
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -184,6 +184,10 @@ static unsigned long *alloc_thread_stack
 			continue;
 		this_cpu_write(cached_stacks[i], NULL);
 
+#ifdef CONFIG_DEBUG_KMEMLEAK
+		/* Clear stale pointers from reused stack. */
+		memset(s->addr, 0, THREAD_SIZE);
+#endif
 		tsk->stack_vm_area = s;
 		local_irq_enable();
 		return s->addr;


