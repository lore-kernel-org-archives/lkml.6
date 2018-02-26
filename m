Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt3WENXqQn3XSP6oAxUmAJmRjsDhlXqWHEirG5uSArpQTyo8pOHlq+x3bx1eUg5uJG2Mks5
ARC-Seal: i=1; a=rsa-sha256; t=1519676619; cv=none;
        d=google.com; s=arc-20160816;
        b=i7PS0grmxLABvw5+HUV1Ul/y7f20f4x4HynfYDb+gvy8AKqwd0cnkfVk9d66/pABaH
         5xzX6K/LI0Y6GgNdWaHxMvKKDFHqp1oPr5Ts6qdcv4A/k0Kws8X3qdx3hVCyuGrgQcfR
         o7YFBMqi79l0N2xBQqSy5oG2u7IjqFoCKannYW5EwcEdpg4N0AV9wM629kmwVVrkH2WA
         Uw5JxSiw3e8ERonTa6yVdJdrsInP82gSxACzxsKC0KgUAF7O1xaSmDws6XnrVxTZPZdM
         BL3LTTSzvRGmfQg77ZxHbfMsCI7VsxbXaDtnr5i6/fEU+qQ65NjaiN38BtaqqnzUyyCR
         gV8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ju60a/asJwSgtKwfx2cMeNllLJ7FIzQG3yf1I1dmV4I=;
        b=odx76bEbLmd5CDKOWvjs8cSHpYHWc9q5AWwifnIkQzfwN9DlJbdBwualfhEdsS/lMS
         MNJP8NNbwvf5qgpNUvnMSlEjWcHk3IIqfCjVC0PoWPLpc7hrYACKQmTyLj20Q5QpGGyh
         h7TWTn2YHwm0R5vla+r6BazwDyR62PP7Iud6YPdEdgO7kww/0NGGe9C5NDsczIKtss2A
         EcCdMEiJthm5wmXw56MXdw3CbJJYjrK3yltznEY4JxEkTVORujIBQwF8UaEYfxKKsbTy
         NK/tw8LY/cAoRcJ542uUvhAgNY4POsH4n/pO0rymXBIwwkLanME4+6CVtH1ttn9YP8WG
         gM8g==
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
Subject: [PATCH 4.14 17/54] RDMA/uverbs: Protect from command mask overflow
Date: Mon, 26 Feb 2018 21:21:54 +0100
Message-Id: <20180226202145.232133681@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496374764769683?=
X-GMAIL-MSGID: =?utf-8?q?1593496431610792758?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -647,12 +647,21 @@ static int verify_command_mask(struct ib
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
@@ -685,6 +694,15 @@ static ssize_t ib_uverbs_write(struct fi
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
@@ -696,12 +714,8 @@ static ssize_t ib_uverbs_write(struct fi
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
@@ -722,8 +736,7 @@ static ssize_t ib_uverbs_write(struct fi
 		struct ib_udata uhw;
 		size_t written_count = count;
 
-		if (command >= ARRAY_SIZE(uverbs_ex_cmd_table) ||
-		    !uverbs_ex_cmd_table[command]) {
+		if (!uverbs_ex_cmd_table[command]) {
 			ret = -ENOSYS;
 			goto out;
 		}
