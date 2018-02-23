Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvl3YFmm+btP7NRVa7eXERZUcrjzaDm7Ghl0+YB7YuI+GMmWm6uIz9HqhWexM42Mv8Hbyaf
ARC-Seal: i=1; a=rsa-sha256; t=1519410858; cv=none;
        d=google.com; s=arc-20160816;
        b=CrEogBMSMjJ2Xla55OUdtDNfDvKmeUpf29SFaNdNRCUjSxM5l/GOf/eMhVPyPSSiiq
         7n/v+PFFQG0uuEQsnw5HaJzdFbsqmVdrRoUbaYMXXO2kOeKpe3d1Fw/Cb+0ceRDUokkp
         0PzRjyov03eNTytwJOvkq6XfTsHNmfc7MerjYZ7rmtsNtQRiqCm1LQWUMWe5dJX5G87d
         vWMdc73XHz9VUamjPE5rZ/iZ75e4h2GoAyL2KQzN+orc7bnsK5h2GMZodb349dEZj6/M
         9wUZa8vfi5s1a7dHkqzJsBiCeAbJLxgyu0tnVSbhX1qpdJD9H/B+H7/siFod5yGf42lJ
         MOzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=09yMn8NCDH691Jw1wP4oKii4H9KWeuWZ3O+EBRV2lko=;
        b=ARflL4RLJsYvXimOd/TLxUgSvUtl1ySqnKyYV8I4a/KjGDWcFdvr+X35QGYtfVSX2H
         HnrN/UV/UaUj+nk2MOgJEXMnRnqBqljPSXKlGkuU/r5Zzqed45Xsi2HJrCgIkbCYHnw9
         weEQGMSZ6IoJ4PW6rsKBsFRlq0EZ3joUCoayJmyHsxxzuegZghOSnJ5eeZYi8SkSJKcF
         9wJU3L60DkeugbNxg0pbnwfzj894xztD9o5if3X4CEdZMlv5q8XQ1Ajg00I9G6yfkSBf
         48yGZJdWqHwykUH/DnWzZ0wl8YiKmck9PbLuyAAGaAm8YT0J01pTG6otvnuGpFqjvcNt
         G7yA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.4 007/193] blktrace: fix unlocked registration of tracepoints
Date: Fri, 23 Feb 2018 19:24:00 +0100
Message-Id: <20180223170327.227559883@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217760361172848?=
X-GMAIL-MSGID: =?utf-8?q?1593217760361172848?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -300,11 +301,26 @@ static void blk_trace_free(struct blk_tr
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
@@ -1466,9 +1481,7 @@ static int blk_trace_remove_queue(struct
 	if (bt == NULL)
 		return -EINVAL;
 
-	if (atomic_dec_and_test(&blk_probes_ref))
-		blk_unregister_tracepoints();
-
+	put_probe_ref();
 	blk_trace_free(bt);
 	return 0;
 }
@@ -1499,8 +1512,7 @@ static int blk_trace_setup_queue(struct
 	if (cmpxchg(&q->blk_trace, NULL, bt))
 		goto free_bt;
 
-	if (atomic_inc_return(&blk_probes_ref) == 1)
-		blk_register_tracepoints();
+	get_probe_ref();
 	return 0;
 
 free_bt:
