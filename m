Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226Xr5458p3lgPUAxLu5mGg3ayn7mX/k68V1tjWQ3tZYbwf6k4hsJ2Od97pW2Me0P2vLwFT/
ARC-Seal: i=1; a=rsa-sha256; t=1519676794; cv=none;
        d=google.com; s=arc-20160816;
        b=AfhJJBpp4wbhAn3YLhlJ7QKjpUj9Z3fMUxE6iP8NVj+R5Ey5YH6JTHP1NzspMgd5AQ
         y5fKp33m9/eTgJCvhrIwabNSBst5/a2m1WUhrm4hKzGZh+uEHc8C6QGltif33enonNqd
         jFZmhEFpsrzFh/C1rD9KlfTK4DFuuv/bzLmNIw2MkwYXNYgr8oSFCRUC7wkZe30tlTZ6
         c/bQCDCEj+w5ClgTR24KODYIhMSGsV85Ygmtd+vymd0j8wYsrJFSGAaiW3kKuAW70GM2
         r96Af+QtHzhCoRuYVFTsO9Waj80eIMYD9s6TLY0JSubpOm4HJe0DbmQgGui7btVounAr
         CDOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=719SpqiG6DCboDkP4aS8lbkoNzl/nUqrHNb49L7oV6s=;
        b=QUcMWifrLGeI+i+PjpCvaKfRy6N73gsw+SMrnn4C7hNvWUI1m40yYhfHMJijYYscUN
         PmbixFfqTjjnbuG4Kmh+3x5Fgj5dMd5Q/Le9psAQrKqbLPAAlsVR7HKvpeAzRFbn3M+D
         qEfu5o2yIdSyUrA3qtNrzMKR6RUXW4aHVA39wWAUm1V/0YO3rw5gUhX5M25pJC7ehOhX
         F0zdDo/dht9QYsmP3qUL3I9Aub/6N6SQWBrCGfGVv4dp/egnqTNm9vf6Y+Ibfmnwia+Z
         yA0lqNsLNjptnI0FkGImkEjzf7gyndeTDSQ/8NYinq3bUalhD4KEB4T4UGvxt3tiQB1v
         eBjA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzkaller <syzkaller@googlegroups.com>,
	Noa Osherovich <noaos@mellanox.com>,
	Matan Barak <matanb@mellanox.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.15 18/64] RDMA/uverbs: Protect from command mask overflow
Date: Mon, 26 Feb 2018 21:21:55 +0100
Message-Id: <20180226202154.221410409@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496374764769683?=
X-GMAIL-MSGID: =?utf-8?q?1593496615143010999?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit 3f802b162dbf4a558ff98986449eddc717826209 upstream.

The command number is not bounds checked against the command mask before it
is shifted, resulting in an ubsan hit. This does not cause malfunction since
the command number is eventually bounds checked, but we can make this ubsan
clean by moving the bounds check to before the mask check.

================================================================================
UBSAN: Undefined behaviour in
drivers/infiniband/core/uverbs_main.c:647:21
shift exponent 207 is too large for 64-bit type 'long long unsigned int'
CPU: 0 PID: 446 Comm: syz-executor3 Not tainted 4.15.0-rc2+ #61
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.7.5-0-ge51488c-20140602_164612-nilsson.home.kraxel.org 04/01/2014
Call Trace:
dump_stack+0xde/0x164
? dma_virt_map_sg+0x22c/0x22c
ubsan_epilogue+0xe/0x81
__ubsan_handle_shift_out_of_bounds+0x293/0x2f7
? debug_check_no_locks_freed+0x340/0x340
? __ubsan_handle_load_invalid_value+0x19b/0x19b
? lock_acquire+0x440/0x440
? lock_acquire+0x19d/0x440
? __might_fault+0xf4/0x240
? ib_uverbs_write+0x68d/0xe20
ib_uverbs_write+0x68d/0xe20
? __lock_acquire+0xcf7/0x3940
? uverbs_devnode+0x110/0x110
? cyc2ns_read_end+0x10/0x10
? sched_clock_cpu+0x18/0x200
? sched_clock_cpu+0x18/0x200
__vfs_write+0x10d/0x700
? uverbs_devnode+0x110/0x110
? kernel_read+0x170/0x170
? __fget+0x35b/0x5d0
? security_file_permission+0x93/0x260
vfs_write+0x1b0/0x550
SyS_write+0xc7/0x1a0
? SyS_read+0x1a0/0x1a0
? trace_hardirqs_on_thunk+0x1a/0x1c
entry_SYSCALL_64_fastpath+0x18/0x85
RIP: 0033:0x448e29
RSP: 002b:00007f033f567c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f033f5686bc RCX: 0000000000448e29
RDX: 0000000000000060 RSI: 0000000020001000 RDI: 0000000000000012
RBP: 000000000070bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000056a0 R14: 00000000006e8740 R15: 0000000000000000
================================================================================

Cc: syzkaller <syzkaller@googlegroups.com>
Cc: <stable@vger.kernel.org> # 4.5
Fixes: 2dbd5186a39c ("IB/core: IB/core: Allow legacy verbs through extended interfaces")
Reported-by: Noa Osherovich <noaos@mellanox.com>
Reviewed-by: Matan Barak <matanb@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/uverbs_main.c |   27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -648,12 +648,21 @@ static int verify_command_mask(struct ib
 	return -1;
 }
 
+static bool verify_command_idx(u32 command, bool extended)
+{
+	if (extended)
+		return command < ARRAY_SIZE(uverbs_ex_cmd_table);
+
+	return command < ARRAY_SIZE(uverbs_cmd_table);
+}
+
 static ssize_t ib_uverbs_write(struct file *filp, const char __user *buf,
 			     size_t count, loff_t *pos)
 {
 	struct ib_uverbs_file *file = filp->private_data;
 	struct ib_device *ib_dev;
 	struct ib_uverbs_cmd_hdr hdr;
+	bool extended_command;
 	__u32 command;
 	__u32 flags;
 	int srcu_key;
@@ -686,6 +695,15 @@ static ssize_t ib_uverbs_write(struct fi
 	}
 
 	command = hdr.command & IB_USER_VERBS_CMD_COMMAND_MASK;
+	flags = (hdr.command &
+		 IB_USER_VERBS_CMD_FLAGS_MASK) >> IB_USER_VERBS_CMD_FLAGS_SHIFT;
+
+	extended_command = flags & IB_USER_VERBS_CMD_FLAG_EXTENDED;
+	if (!verify_command_idx(command, extended_command)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (verify_command_mask(ib_dev, command)) {
 		ret = -EOPNOTSUPP;
 		goto out;
@@ -697,12 +715,8 @@ static ssize_t ib_uverbs_write(struct fi
 		goto out;
 	}
 
-	flags = (hdr.command &
-		 IB_USER_VERBS_CMD_FLAGS_MASK) >> IB_USER_VERBS_CMD_FLAGS_SHIFT;
-
 	if (!flags) {
-		if (command >= ARRAY_SIZE(uverbs_cmd_table) ||
-		    !uverbs_cmd_table[command]) {
+		if (!uverbs_cmd_table[command]) {
 			ret = -EINVAL;
 			goto out;
 		}
@@ -723,8 +737,7 @@ static ssize_t ib_uverbs_write(struct fi
 		struct ib_udata uhw;
 		size_t written_count = count;
 
-		if (command >= ARRAY_SIZE(uverbs_ex_cmd_table) ||
-		    !uverbs_ex_cmd_table[command]) {
+		if (!uverbs_ex_cmd_table[command]) {
 			ret = -ENOSYS;
 			goto out;
 		}
