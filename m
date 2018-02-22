Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeBVHdk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 02:33:40 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36917 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751681AbeBVHdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 02:33:38 -0500
X-Google-Smtp-Source: AH8x224q6UhtevMb1G5hk2lNe2ohrlbDgnCR9CYcaGTP2MfCkyHiPZS5mDvIYRa9sJTUJ23x36YIrA==
From: carmark.dlut@gmail.com
Cc: Lei Xue <carmark.dlut@gmail.com>, David Howells <dhowells@redhat.com>,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] fscache: fix a kernel BUG at fs/fscache/operation.c:69!
Date: Thu, 22 Feb 2018 15:33:30 +0800
Message-Id: <20180222073330.36259-1-carmark.dlut@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lei Xue <carmark.dlut@gmail.com>

There is a potential race in fscache operation enqueuing for reading and
copying multiple pages from cachefiles to netfs.
Under some heavy load system, it will happen very often.

If this race occurs, an oops similar to the following is seen:

 kernel BUG at fs/fscache/operation.c:69!
 invalid opcode: 0000 [#1] SMP
 …
 #0 [ffff883fff0838d8] machine_kexec at ffffffff81051beb
 #1 [ffff883fff083938] crash_kexec at ffffffff810f2542
 #2 [ffff883fff083a08] oops_end at ffffffff8163e1a8
 #3 [ffff883fff083a30] die at ffffffff8101859b
 #4 [ffff883fff083a60] do_trap at ffffffff8163d860
 #5 [ffff883fff083ab0] do_invalid_op at ffffffff81015204
 #6 [ffff883fff083b60] invalid_op at ffffffff8164701e
    [exception RIP: fscache_enqueue_operation+246]
    RIP: ffffffffa0b793c6  RSP: ffff883fff083c18  RFLAGS: 00010046
    RAX: 0000000000000019  RBX: ffff8832ed1a9ec0  RCX: 0000000000000006
    RDX: 0000000000000000  RSI: 0000000000000046  RDI: 0000000000000046
    RBP: ffff883fff083c20   R8: 0000000000000086   R9: 000000000000178f
    R10: ffffffff816aeb00  R11: ffff883fff08392e  R12: ffff8802f0525620
    R13: ffff88407ffc01d8  R14: 0000000000000000  R15: 0000000000000003
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000
 #7 [ffff883fff083c10] fscache_enqueue_operation at ffffffffa0b793c6
 #8 [ffff883fff083c28] cachefiles_read_waiter at ffffffffa0b15a48
 #9 [ffff883fff083c48] __wake_up_common at ffffffff810af028

Signed-off-by: Lei Xue <carmark.dlut@gmail.com>
---
 fs/cachefiles/rdwr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 883bc7bb12c5..9d5d13e150fb 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -58,9 +58,9 @@ static int cachefiles_read_waiter(wait_queue_entry_t *wait, unsigned mode,
 
 	spin_lock(&object->work_lock);
 	list_add_tail(&monitor->op_link, &monitor->op->to_do);
+	fscache_enqueue_retrieval(monitor->op);
 	spin_unlock(&object->work_lock);
 
-	fscache_enqueue_retrieval(monitor->op);
 	return 0;
 }
 
-- 
2.14.3 (Apple Git-98)
