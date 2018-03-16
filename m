Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsMLsKiCNsnabJ148oAizBG/0el2ZfRjop/Q93CRduZ7If9vzfsO8ss8U/tWQwiDpQg0mzX
ARC-Seal: i=1; a=rsa-sha256; t=1521214197; cv=none;
        d=google.com; s=arc-20160816;
        b=gSkHPaESqtoHY/Vn72FWrfCLORRgNsZHdiLQeUA5nPUjKLVEzBEOtZlJ3DyeqjdQPL
         4dnfA8I42h9XgVeh/cZncR/TUak0UI0yesQhUYqF4SKLBrKhZiKBLJO0mAu+gJGX4qN7
         rpD3BXh17rELoUnrUABCEthhpTpWJdDiSpd0r92tAKrQ/j6u5To2aGVt/+WNU0TBJfdQ
         ppb/2jisdzDcrTbCaDK8IFZdSSrAC0aXZtKc816S2sIVem8Ay4h6JZY8QRjoGgbLqEW3
         NVjfiv5KGh1z5WZMgEg6wwL3cj2xfhbmydjqJqHGiQq6SCmmqtINMD4UQPyjR4rm7Vv3
         +dAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bEgoJxB04wUDdoGYnceTwNagjwapa1oC5skLfuP0tXo=;
        b=hG4ln8TIGIh9s2DL7saOQbVlie09+tWVnGh9QPFbace8jy623/yDCjTHQ3jucZP/Ef
         uHdDYUlPqA0AhSDMkWa5xgUF6je9pqBdLU/nN2DW9oxzKMJU4Y7WRu/6sbau0YPVisr5
         aVDKg14Vgog5lMZvbG6mtQ50icttGxepoEoj+u7JCney5J2M3kCpbsmE+xjK0VZ44OFx
         FLaEoSYGTt6V0sFGovqGZxZ5BLCzw5ivya9j+DPiNcfqGuCzUEeSEenCxHMOKoooZZb0
         5e6t5uJWs7g3WIaZcRNqMqkoyzF8JZ/0WkSdXWeTVmDQWcvbG+uj64fzMy0FiKc1S5fy
         iDXw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzkaller <syzkaller@googlegroups.com>,
	Noa Osherovich <noaos@mellanox.com>,
	Yishai Hadas <yishaih@mellanox.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.9 03/86] RDMA/mlx5: Fix integer overflow while resizing CQ
Date: Fri, 16 Mar 2018 16:22:26 +0100
Message-Id: <20180316152317.443634666@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108505856983674?=
X-GMAIL-MSGID: =?utf-8?q?1595108698115415882?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit 28e9091e3119933c38933cb8fc48d5618eb784c8 upstream.

The user can provide very large cqe_size which will cause to integer
overflow as it can be seen in the following UBSAN warning:

=======================================================================
UBSAN: Undefined behaviour in drivers/infiniband/hw/mlx5/cq.c:1192:53
signed integer overflow:
64870 * 65536 cannot be represented in type 'int'
CPU: 0 PID: 267 Comm: syzkaller605279 Not tainted 4.15.0+ #90 Hardware
name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.7.5-0-ge51488c-20140602_164612-nilsson.home.kraxel.org 04/01/2014
Call Trace:
 dump_stack+0xde/0x164
 ? dma_virt_map_sg+0x22c/0x22c
 ubsan_epilogue+0xe/0x81
 handle_overflow+0x1f3/0x251
 ? __ubsan_handle_negate_overflow+0x19b/0x19b
 ? lock_acquire+0x440/0x440
 mlx5_ib_resize_cq+0x17e7/0x1e40
 ? cyc2ns_read_end+0x10/0x10
 ? native_read_msr_safe+0x6c/0x9b
 ? cyc2ns_read_end+0x10/0x10
 ? mlx5_ib_modify_cq+0x220/0x220
 ? sched_clock_cpu+0x18/0x200
 ? lookup_get_idr_uobject+0x200/0x200
 ? rdma_lookup_get_uobject+0x145/0x2f0
 ib_uverbs_resize_cq+0x207/0x3e0
 ? ib_uverbs_ex_create_cq+0x250/0x250
 ib_uverbs_write+0x7f9/0xef0
 ? cyc2ns_read_end+0x10/0x10
 ? print_irqtrace_events+0x280/0x280
 ? ib_uverbs_ex_create_cq+0x250/0x250
 ? uverbs_devnode+0x110/0x110
 ? sched_clock_cpu+0x18/0x200
 ? do_raw_spin_trylock+0x100/0x100
 ? __lru_cache_add+0x16e/0x290
 __vfs_write+0x10d/0x700
 ? uverbs_devnode+0x110/0x110
 ? kernel_read+0x170/0x170
 ? sched_clock_cpu+0x18/0x200
 ? security_file_permission+0x93/0x260
 vfs_write+0x1b0/0x550
 SyS_write+0xc7/0x1a0
 ? SyS_read+0x1a0/0x1a0
 ? trace_hardirqs_on_thunk+0x1a/0x1c
 entry_SYSCALL_64_fastpath+0x1e/0x8b
RIP: 0033:0x433549
RSP: 002b:00007ffe63bd1ea8 EFLAGS: 00000217
=======================================================================

Cc: syzkaller <syzkaller@googlegroups.com>
Cc: <stable@vger.kernel.org> # 3.13
Fixes: bde51583f49b ("IB/mlx5: Add support for resize CQ")
Reported-by: Noa Osherovich <noaos@mellanox.com>
Reviewed-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/cq.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -1117,7 +1117,12 @@ static int resize_user(struct mlx5_ib_de
 	if (ucmd.reserved0 || ucmd.reserved1)
 		return -EINVAL;
 
-	umem = ib_umem_get(context, ucmd.buf_addr, entries * ucmd.cqe_size,
+	/* check multiplication overflow */
+	if (ucmd.cqe_size && SIZE_MAX / ucmd.cqe_size <= entries - 1)
+		return -EINVAL;
+
+	umem = ib_umem_get(context, ucmd.buf_addr,
+			   (size_t)ucmd.cqe_size * entries,
 			   IB_ACCESS_LOCAL_WRITE, 1);
 	if (IS_ERR(umem)) {
 		err = PTR_ERR(umem);
