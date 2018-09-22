Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD052ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF582157C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF582157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391921AbeIVGKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:10:43 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44077 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391847AbeIVGKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:43 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vds-0008BX-N5; Sat, 22 Sep 2018 01:19:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdn-0000qg-FQ; Sat, 22 Sep 2018 01:19:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Mel Gorman" <mgorman@suse.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.357269453@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 13/63] futex: Remove unnecessary warning from
 get_futex_key
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mel Gorman <mgorman@suse.de>

commit 48fb6f4db940e92cfb16cd878cddd59ea6120d06 upstream.

Commit 65d8fc777f6d ("futex: Remove requirement for lock_page() in
get_futex_key()") removed an unnecessary lock_page() with the
side-effect that page->mapping needed to be treated very carefully.

Two defensive warnings were added in case any assumption was missed and
the first warning assumed a correct application would not alter a
mapping backing a futex key.  Since merging, it has not triggered for
any unexpected case but Mark Rutland reported the following bug
triggering due to the first warning.

  kernel BUG at kernel/futex.c:679!
  Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
  Modules linked in:
  CPU: 0 PID: 3695 Comm: syz-executor1 Not tainted 4.13.0-rc3-00020-g307fec773ba3 #3
  Hardware name: linux,dummy-virt (DT)
  task: ffff80001e271780 task.stack: ffff000010908000
  PC is at get_futex_key+0x6a4/0xcf0 kernel/futex.c:679
  LR is at get_futex_key+0x6a4/0xcf0 kernel/futex.c:679
  pc : [<ffff00000821ac14>] lr : [<ffff00000821ac14>] pstate: 80000145

The fact that it's a bug instead of a warning was due to an unrelated
arm64 problem, but the warning itself triggered because the underlying
mapping changed.

This is an application issue but from a kernel perspective it's a
recoverable situation and the warning is unnecessary so this patch
removes the warning.  The warning may potentially be triggered with the
following test program from Mark although it may be necessary to adjust
NR_FUTEX_THREADS to be a value smaller than the number of CPUs in the
system.

    #include <linux/futex.h>
    #include <pthread.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <sys/mman.h>
    #include <sys/syscall.h>
    #include <sys/time.h>
    #include <unistd.h>

    #define NR_FUTEX_THREADS 16
    pthread_t threads[NR_FUTEX_THREADS];

    void *mem;

    #define MEM_PROT  (PROT_READ | PROT_WRITE)
    #define MEM_SIZE  65536

    static int futex_wrapper(int *uaddr, int op, int val,
                             const struct timespec *timeout,
                             int *uaddr2, int val3)
    {
        syscall(SYS_futex, uaddr, op, val, timeout, uaddr2, val3);
    }

    void *poll_futex(void *unused)
    {
        for (;;) {
            futex_wrapper(mem, FUTEX_CMP_REQUEUE_PI, 1, NULL, mem + 4, 1);
        }
    }

    int main(int argc, char *argv[])
    {
        int i;

        mem = mmap(NULL, MEM_SIZE, MEM_PROT,
               MAP_SHARED | MAP_ANONYMOUS, -1, 0);

        printf("Mapping @ %p\n", mem);

        printf("Creating futex threads...\n");

        for (i = 0; i < NR_FUTEX_THREADS; i++)
            pthread_create(&threads[i], NULL, poll_futex, NULL);

        printf("Flipping mapping...\n");
        for (;;) {
            mmap(mem, MEM_SIZE, MEM_PROT,
                 MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, -1, 0);
        }

        return 0;
    }

Reported-and-tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mel Gorman <mgorman@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/futex.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -583,13 +583,14 @@ again:
 		 * this reference was taken by ihold under the page lock
 		 * pinning the inode in place so i_lock was unnecessary. The
 		 * only way for this check to fail is if the inode was
-		 * truncated in parallel so warn for now if this happens.
+		 * truncated in parallel which is almost certainly an
+		 * application bug. In such a case, just retry.
 		 *
 		 * We are not calling into get_futex_key_refs() in file-backed
 		 * cases, therefore a successful atomic_inc return below will
 		 * guarantee that get_futex_key() will still imply smp_mb(); (B).
 		 */
-		if (WARN_ON_ONCE(!atomic_inc_not_zero(&inode->i_count))) {
+		if (!atomic_inc_not_zero(&inode->i_count)) {
 			rcu_read_unlock();
 			put_page(page_head);
 

