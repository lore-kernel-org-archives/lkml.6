Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+WqZt83Dy05Xe/bYp+lw2P5YRxFbESPY2tIklTQVUamZ/uh116tqy2wbVNJERz15rCPJJn
ARC-Seal: i=1; a=rsa-sha256; t=1523021436; cv=none;
        d=google.com; s=arc-20160816;
        b=hFuQZE1fiCkAxLwDkFS/jYOWrzEDUechB48402DOiVLnEZcTzMzGo2GoxK6ovUsZN/
         ZxD0Q/lnChBnVfXddEAYfOAQ8TppvuUvenXLFUvktrw3Syf7CzkZXIO83VM6J1UYykbM
         HKulDrKieggps7uIiKJm4Jf8ikCgBthfLSTrTBPlmtNvyMbiImbSQwrw6WNFKpW4EVV2
         Vl7hEM7krqx+T+MxkwVe192Laod3ydcAr4WbOTeSC8UQntEmuQJ/hZX3QDlXMbiyMAT0
         0rKcBCjsohhYsW0eTgl1BaNwH4TjQppuB8iXc+8WB/B6aaqxj+mSZiH9Q2L7KiJK+NAg
         dX7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6dYocfCmlsxuhTdKZYobq8bCW1HrBcve+O/tTMKG9uY=;
        b=AmePeKWQCSYlho6HGBskJlS1I5igBtp/SJxwJSy5DSMHMSmuE9fPcWwMxakGXuI2Zz
         WdmFt9hgCbIrrWS7pRiqGKFHfbb8NCPLaMANkP8bIXVnMmXQijNhM3xXPxFLoS3SOUsx
         wJXPhDyO3hlZxJXA/2QYExMY0aHSivBXBT6ArZwSYhVlf95sAno6g8eGRqVwE6lSZS+L
         rY9aW1ttCkqbjqvPfsLzfVHZ28SkYEpMRwJISAgJZ6APHHNowYQizKLVhIriZlw6MA7P
         qJ6EAzRYU8wU590diSAeAVa3k+dNlymulTxnKD/mFHdpqt+MOWBK943fXtJZPitj78tt
         zTQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+2287ac532caa81900a4e@syzkaller.appspotmail.com,
	Leon Romanovsky <leonro@mellanox.com>,
	Sean Hefty <sean.hefty@intel.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.4 35/72] RDMA/ucma: Dont allow join attempts for unsupported AF family
Date: Fri,  6 Apr 2018 15:23:36 +0200
Message-Id: <20180406084308.090428199@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003725717324500?=
X-GMAIL-MSGID: =?utf-8?q?1597003725717324500?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit 0c81ffc60d5280991773d17e84bda605387148b1 upstream.

Users can provide garbage while calling to ucma_join_ip_multicast(),
it will indirectly cause to rdma_addr_size() return 0, making the
call to ucma_process_join(), which had the right checks, but it is
better to check the input as early as possible.

The following crash from syzkaller revealed it.

kernel BUG at lib/string.c:1052!
invalid opcode: 0000 [#1] SMP KASAN Dumping ftrace buffer:
   (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 4113 Comm: syz-executor0 Not tainted 4.16.0-rc5+ #261
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:fortify_panic+0x13/0x20 lib/string.c:1051
RSP: 0018:ffff8801ca81f8f0 EFLAGS: 00010286
RAX: 0000000000000022 RBX: 1ffff10039503f23 RCX: 0000000000000000
RDX: 0000000000000022 RSI: 1ffff10039503ed3 RDI: ffffed0039503f12
RBP: ffff8801ca81f8f0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000006 R11: 0000000000000000 R12: ffff8801ca81f998
R13: ffff8801ca81f938 R14: ffff8801ca81fa58 R15: 000000000000fa00
FS:  0000000000000000(0000) GS:ffff8801db200000(0063) knlGS:000000000a12a900
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000008138024 CR3: 00000001cbb58004 CR4: 00000000001606f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 memcpy include/linux/string.h:344 [inline]
 ucma_join_ip_multicast+0x36b/0x3b0 drivers/infiniband/core/ucma.c:1421
 ucma_write+0x2d6/0x3d0 drivers/infiniband/core/ucma.c:1633
 __vfs_write+0xef/0x970 fs/read_write.c:480
 vfs_write+0x189/0x510 fs/read_write.c:544
 SYSC_write fs/read_write.c:589 [inline]
 SyS_write+0xef/0x220 fs/read_write.c:581
 do_syscall_32_irqs_on arch/x86/entry/common.c:330 [inline]
 do_fast_syscall_32+0x3ec/0xf9f arch/x86/entry/common.c:392
 entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f9ec99
RSP: 002b:00000000ff8172cc EFLAGS: 00000282 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000020000100
RDX: 0000000000000063 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Code: 08 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b 48 89 df e8 42 2c e3 fb eb de
55 48 89 fe 48 c7 c7 80 75 98 86 48 89 e5 e8 85 95 94 fb <0f> 0b 90 90 90 90
90 90 90 90 90 90 90 55 48 89 e5 41 57 41 56
RIP: fortify_panic+0x13/0x20 lib/string.c:1051 RSP: ffff8801ca81f8f0

Fixes: 5bc2b7b397b0 ("RDMA/ucma: Allow user space to specify AF_IB when joining multicast")
Reported-by: <syzbot+2287ac532caa81900a4e@syzkaller.appspotmail.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/ucma.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1345,7 +1345,7 @@ static ssize_t ucma_process_join(struct
 		return -ENOSPC;
 
 	addr = (struct sockaddr *) &cmd->addr;
-	if (cmd->reserved || !cmd->addr_size || (cmd->addr_size != rdma_addr_size(addr)))
+	if (cmd->reserved || (cmd->addr_size != rdma_addr_size(addr)))
 		return -EINVAL;
 
 	ctx = ucma_get_ctx(file, cmd->id);
@@ -1405,6 +1405,9 @@ static ssize_t ucma_join_ip_multicast(st
 	join_cmd.uid = cmd.uid;
 	join_cmd.id = cmd.id;
 	join_cmd.addr_size = rdma_addr_size((struct sockaddr *) &cmd.addr);
+	if (!join_cmd.addr_size)
+		return -EINVAL;
+
 	join_cmd.reserved = 0;
 	memcpy(&join_cmd.addr, &cmd.addr, join_cmd.addr_size);
 
@@ -1420,6 +1423,9 @@ static ssize_t ucma_join_multicast(struc
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
 
+	if (!rdma_addr_size((struct sockaddr *)&cmd.addr))
+		return -EINVAL;
+
 	return ucma_process_join(file, &cmd, out_len);
 }
 
