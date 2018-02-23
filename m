Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3586829-1519411458-2-5385728096403003208
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519411457; b=l1jRxtHCBRAf3mi1iA6gLwRVf82nFKA3pnzofUp61taJ61v
    CfVbAs4JWLPLcS4TPsvN2iWcAOs15gt4i7LZpE+VaVYJ+5rEY5R/1T8En+904cX9
    9uuTsy2wtTpzCshHZnqfuu7EqW+5HXvComcMRproYyQSkjCRv63wTwsWudTsG94x
    s3yUAcvfydkJXVJMI3TaT/61qkinTfVQKtkV8qZhFrwCIEtyD79HnhPckFpmrowm
    UFmRIZg9wbp7rVjZgvTXK+Hi72whpFAvVshCkZzKWubs6aggf3hc33JrfSYxhMkJ
    8vz0isZ0/pqG/Ha0ZvqPIlQmz9fft1MSwszXiEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519411457; bh=/DAi35QSmyn5aiJNcH1GvhLAuf
    R6p2SHUoeGg0tG//0=; b=TmIu7wrurFDdeqcPE87TJTJyoCq41Vl9BCOvchRZY/
    QiAhe7ucG9HKMoJSUOCsg5be6tCHRXl9v9eNz1QuxQnDLqkSVK+k6ma4IytDapUl
    JDlQggFgVJlx0dHsbVJMCw7tOUuNzMMClC6Oza4oiYg3IviQgdQUSucgLic1ocUl
    rE/eiqo5ywTyr/dH189tTufiaQaNSqEj7KsdcQMtRakShngDgedzlOC/+pWf0f4J
    fEQ9He7gxVt/Mp/sKE6VvoAoHdqiD5DDHyzcfHTBL+XwBO8p2XOnr4hHLsun54cj
    WdI/jXxi1IXcEw/ZN/ymIAcg/t8cy3sU23nRwReRR+OA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933503AbeBWSoM (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:44:12 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42450 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932663AbeBWSoK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:44:10 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.9 010/145] blktrace: fix unlocked registration of tracepoints
Date: Fri, 23 Feb 2018 19:25:16 +0100
Message-Id: <20180223170726.032303385@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit a6da0024ffc19e0d47712bb5ca4fd083f76b07df upstream.

We need to ensure that tracepoints are registered and unregistered
with the users of them. The existing atomic count isn't enough for
that. Add a lock around the tracepoints, so we serialize access
to them.

This fixes cases where we have multiple users setting up and
tearing down tracepoints, like this:

CPU: 0 PID: 2995 Comm: syzkaller857118 Not tainted
4.14.0-rc5-next-20171018+ #36
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:16 [inline]
  dump_stack+0x194/0x257 lib/dump_stack.c:52
  panic+0x1e4/0x41c kernel/panic.c:183
  __warn+0x1c4/0x1e0 kernel/panic.c:546
  report_bug+0x211/0x2d0 lib/bug.c:183
  fixup_bug+0x40/0x90 arch/x86/kernel/traps.c:177
  do_trap_no_signal arch/x86/kernel/traps.c:211 [inline]
  do_trap+0x260/0x390 arch/x86/kernel/traps.c:260
  do_error_trap+0x120/0x390 arch/x86/kernel/traps.c:297
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:310
  invalid_op+0x18/0x20 arch/x86/entry/entry_64.S:905
RIP: 0010:tracepoint_add_func kernel/tracepoint.c:210 [inline]
RIP: 0010:tracepoint_probe_register_prio+0x397/0x9a0 kernel/tracepoint.c:283
RSP: 0018:ffff8801d1d1f6c0 EFLAGS: 00010293
RAX: ffff8801d22e8540 RBX: 00000000ffffffef RCX: ffffffff81710f07
RDX: 0000000000000000 RSI: ffffffff85b679c0 RDI: ffff8801d5f19818
RBP: ffff8801d1d1f7c8 R08: ffffffff81710c10 R09: 0000000000000004
R10: ffff8801d1d1f6b0 R11: 0000000000000003 R12: ffffffff817597f0
R13: 0000000000000000 R14: 00000000ffffffff R15: ffff8801d1d1f7a0
  tracepoint_probe_register+0x2a/0x40 kernel/tracepoint.c:304
  register_trace_block_rq_insert include/trace/events/block.h:191 [inline]
  blk_register_tracepoints+0x1e/0x2f0 kernel/trace/blktrace.c:1043
  do_blk_trace_setup+0xa10/0xcf0 kernel/trace/blktrace.c:542
  blk_trace_setup+0xbd/0x180 kernel/trace/blktrace.c:564
  sg_ioctl+0xc71/0x2d90 drivers/scsi/sg.c:1089
  vfs_ioctl fs/ioctl.c:45 [inline]
  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:685
  SYSC_ioctl fs/ioctl.c:700 [inline]
  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:691
  entry_SYSCALL_64_fastpath+0x1f/0xbe
RIP: 0033:0x444339
RSP: 002b:00007ffe05bb5b18 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006d66c0 RCX: 0000000000444339
RDX: 000000002084cf90 RSI: 00000000c0481273 RDI: 0000000000000009
RBP: 0000000000000082 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: ffffffffffffffff
R13: 00000000c0481273 R14: 0000000000000000 R15: 0000000000000000

since we can now run these in parallel. Ensure that the exported helpers
for doing this are grabbing the queue trace mutex.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/blktrace.c |   32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -57,7 +57,8 @@ static struct tracer_flags blk_tracer_fl
 };
 
 /* Global reference count of probes */
-static atomic_t blk_probes_ref = ATOMIC_INIT(0);
+static DEFINE_MUTEX(blk_probe_mutex);
+static int blk_probes_ref;
 
 static void blk_register_tracepoints(void);
 static void blk_unregister_tracepoints(void);
@@ -306,11 +307,26 @@ static void blk_trace_free(struct blk_tr
 	kfree(bt);
 }
 
+static void get_probe_ref(void)
+{
+	mutex_lock(&blk_probe_mutex);
+	if (++blk_probes_ref == 1)
+		blk_register_tracepoints();
+	mutex_unlock(&blk_probe_mutex);
+}
+
+static void put_probe_ref(void)
+{
+	mutex_lock(&blk_probe_mutex);
+	if (!--blk_probes_ref)
+		blk_unregister_tracepoints();
+	mutex_unlock(&blk_probe_mutex);
+}
+
 static void blk_trace_cleanup(struct blk_trace *bt)
 {
 	blk_trace_free(bt);
-	if (atomic_dec_and_test(&blk_probes_ref))
-		blk_unregister_tracepoints();
+	put_probe_ref();
 }
 
 int blk_trace_remove(struct request_queue *q)
@@ -522,8 +538,7 @@ int do_blk_trace_setup(struct request_qu
 	if (cmpxchg(&q->blk_trace, NULL, bt))
 		goto err;
 
-	if (atomic_inc_return(&blk_probes_ref) == 1)
-		blk_register_tracepoints();
+	get_probe_ref();
 
 	return 0;
 err:
@@ -1469,9 +1484,7 @@ static int blk_trace_remove_queue(struct
 	if (bt == NULL)
 		return -EINVAL;
 
-	if (atomic_dec_and_test(&blk_probes_ref))
-		blk_unregister_tracepoints();
-
+	put_probe_ref();
 	blk_trace_free(bt);
 	return 0;
 }
@@ -1502,8 +1515,7 @@ static int blk_trace_setup_queue(struct
 	if (cmpxchg(&q->blk_trace, NULL, bt))
 		goto free_bt;
 
-	if (atomic_inc_return(&blk_probes_ref) == 1)
-		blk_register_tracepoints();
+	get_probe_ref();
 	return 0;
 
 free_bt:
