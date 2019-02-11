Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAFDC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852D021B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388456AbfBKTbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:31:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727862AbfBKTbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:31:52 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D62ECC0CD165;
        Mon, 11 Feb 2019 19:31:51 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA6275C236;
        Mon, 11 Feb 2019 19:31:49 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 2/2] locking/rwsem: Optimize down_read_trylock()
Date:   Mon, 11 Feb 2019 14:31:26 -0500
Message-Id: <1549913486-16799-3-git-send-email-longman@redhat.com>
In-Reply-To: <1549913486-16799-1-git-send-email-longman@redhat.com>
References: <1549913486-16799-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 11 Feb 2019 19:31:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify __down_read_trylock() to make it generate slightly better code
(smaller and maybe a tiny bit faster).

Before this patch, down_read_trylock:

   0x0000000000000000 <+0>:     callq  0x5 <down_read_trylock+5>
   0x0000000000000005 <+5>:     jmp    0x18 <down_read_trylock+24>
   0x0000000000000007 <+7>:     lea    0x1(%rdx),%rcx
   0x000000000000000b <+11>:    mov    %rdx,%rax
   0x000000000000000e <+14>:    lock cmpxchg %rcx,(%rdi)
   0x0000000000000013 <+19>:    cmp    %rax,%rdx
   0x0000000000000016 <+22>:    je     0x23 <down_read_trylock+35>
   0x0000000000000018 <+24>:    mov    (%rdi),%rdx
   0x000000000000001b <+27>:    test   %rdx,%rdx
   0x000000000000001e <+30>:    jns    0x7 <down_read_trylock+7>
   0x0000000000000020 <+32>:    xor    %eax,%eax
   0x0000000000000022 <+34>:    retq
   0x0000000000000023 <+35>:    mov    %gs:0x0,%rax
   0x000000000000002c <+44>:    or     $0x3,%rax
   0x0000000000000030 <+48>:    mov    %rax,0x20(%rdi)
   0x0000000000000034 <+52>:    mov    $0x1,%eax
   0x0000000000000039 <+57>:    retq

After patch, down_read_trylock:

   0x0000000000000000 <+0>:     callq  0x5 <down_read_trylock+5>
   0x0000000000000005 <+5>:     mov    (%rdi),%rax
   0x0000000000000008 <+8>:     test   %rax,%rax
   0x000000000000000b <+11>:    js     0x2f <down_read_trylock+47>
   0x000000000000000d <+13>:    lea    0x1(%rax),%rdx
   0x0000000000000011 <+17>:    lock cmpxchg %rdx,(%rdi)
   0x0000000000000016 <+22>:    jne    0x8 <down_read_trylock+8>
   0x0000000000000018 <+24>:    mov    %gs:0x0,%rax
   0x0000000000000021 <+33>:    or     $0x3,%rax
   0x0000000000000025 <+37>:    mov    %rax,0x20(%rdi)
   0x0000000000000029 <+41>:    mov    $0x1,%eax
   0x000000000000002e <+46>:    retq
   0x000000000000002f <+47>:    xor    %eax,%eax
   0x0000000000000031 <+49>:    retq

By using a rwsem microbenchmark, the down_read_trylock() rate on a
x86-64 system before and after the patch were:

                 Before Patch    After Patch
   # of Threads     rlock           rlock
   ------------     -----           -----
        1           27,787          28,259
        2            8,359           9,234

On a ARM64 system, the performance results were:

                 Before Patch    After Patch
   # of Threads     rlock           rlock
   ------------     -----           -----
        1           24,155          25,000
        2            6,820           8,699

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index 067e265..028bc33 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -175,11 +175,11 @@ static inline int __down_read_killable(struct rw_semaphore *sem)
 
 static inline int __down_read_trylock(struct rw_semaphore *sem)
 {
-	long tmp;
+	long tmp = atomic_long_read(&sem->count);
 
-	while ((tmp = atomic_long_read(&sem->count)) >= 0) {
-		if (tmp == atomic_long_cmpxchg_acquire(&sem->count, tmp,
-				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
+	while (tmp >= 0) {
+		if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
+					tmp + RWSEM_ACTIVE_READ_BIAS)) {
 			return 1;
 		}
 	}
-- 
1.8.3.1

