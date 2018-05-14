Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqXKl36le1PZx4aWSS2/GsFVKYW2X32+ywIfs7hNSCW2cFcWuHxHyCOx9U+eWeE+tfEVXo9
ARC-Seal: i=1; a=rsa-sha256; t=1526280693; cv=none;
        d=google.com; s=arc-20160816;
        b=P2ihDMRO+L6M3kRy1SCNqr5IwXpUFLwq3bKMvuRGXK42EJGg6XUuCRuC9w4A4pv3Hj
         z2vXIBNIzVcmkq6/f4h2mSAmX0QDAKLSzOwXLAs6lJvDKK958Q5y3+GQSuT06H5WzCzp
         g0VandsiKGZQQQK6P+9MFExnOguc1yfvRiWhWvqlPDKuQicNPHpnFKGFYmZEdgWB1tFn
         85sn/NrJunvWUfFlo1L2XbDdTzHKcP91ZmjCG46RkQJwsasn2XTLNpcn3xT7HCMYqljl
         b1HcyZDI3gIlN4RJ32iNTBQctfS0vu+kgRV33E1lLdVaWrhuCpnTUmCvOsA5+RTB29DD
         jDPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=tAJs+InvUoxhEZpvjjBAwvX8c1uy7y+yuFkVBu7UWyI=;
        b=HRJynaoyEcuG7Usg1Cbikve67ekeWq3yIu0Os5QJmLhI0QasGfHyE0xmmMCb04s7ey
         ohKlo2083rbnwudpXfruB5kDBDQmGfEguPSPT24+LweO/5uTSOuzAKXEBmv3F9rdQodM
         8OdVbeWeFD6x6QCeY0Gb7K/SW6Fwzlq5xktDtWP/KroGOJxk0a+lkjiQW5Fmnd6so7Rh
         omLIGJTiTYZP/UPAIN3OAgt+qav8KubL3c01tHsDdXCzIKAZcbmwmLLimG8NjIqIG+/+
         xWqYMFrOGfnqy/vdWFiFAKMvpgTN1CisT70erhITqxT6lcKS3IL8qB6lbJi0ewBShbL3
         xV+A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=QaeX/dI3;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=QaeX/dI3;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzkaller <syzkaller@googlegroups.com>,
	Noa Osherovich <noaos@mellanox.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.4 21/56] RDMA/mlx5: Protect from shift operand overflow
Date: Mon, 14 May 2018 08:48:26 +0200
Message-Id: <20180514064756.946926034@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421221722926942?=
X-GMAIL-MSGID: =?utf-8?q?1600421304005618954?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit 002bf2282b2d7318e444dca9ffcb994afc5d5f15 upstream.

Ensure that user didn't supply values too large that can cause overflow.

UBSAN: Undefined behaviour in drivers/infiniband/hw/mlx5/qp.c:263:23
shift exponent -2147483648 is negative
CPU: 0 PID: 292 Comm: syzkaller612609 Not tainted 4.16.0-rc1+ #131
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.0-0-g63451fca13-prebuilt.qemu-project.org 04/01/2014 Call
Trace:
dump_stack+0xde/0x164
ubsan_epilogue+0xe/0x81
set_rq_size+0x7c2/0xa90
create_qp_common+0xc18/0x43c0
mlx5_ib_create_qp+0x379/0x1ca0
create_qp.isra.5+0xc94/0x2260
ib_uverbs_create_qp+0x21b/0x2a0
ib_uverbs_write+0xc2c/0x1010
vfs_write+0x1b0/0x550
SyS_write+0xc7/0x1a0
do_syscall_64+0x1aa/0x740
entry_SYSCALL_64_after_hwframe+0x26/0x9b
RIP: 0033:0x433569
RSP: 002b:00007ffc6e62f448 EFLAGS: 00000217 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002f8 RCX: 0000000000433569
RDX: 0000000000000070 RSI: 00000000200042c0 RDI: 0000000000000003
RBP: 00000000006d5018 R08: 00000000004002f8 R09: 00000000004002f8
R10: 00000000004002f8 R11: 0000000000000217 R12: 0000000000000000
R13: 000000000040c9f0 R14: 000000000040ca80 R15: 0000000000000006

Cc: <stable@vger.kernel.org> # 3.10
Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Cc: syzkaller <syzkaller@googlegroups.com>
Reported-by: Noa Osherovich <noaos@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/qp.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -231,7 +231,11 @@ static int set_rq_size(struct mlx5_ib_de
 	} else {
 		if (ucmd) {
 			qp->rq.wqe_cnt = ucmd->rq_wqe_count;
+			if (ucmd->rq_wqe_shift > BITS_PER_BYTE * sizeof(ucmd->rq_wqe_shift))
+				return -EINVAL;
 			qp->rq.wqe_shift = ucmd->rq_wqe_shift;
+			if ((1 << qp->rq.wqe_shift) / sizeof(struct mlx5_wqe_data_seg) < qp->wq_sig)
+				return -EINVAL;
 			qp->rq.max_gs = (1 << qp->rq.wqe_shift) / sizeof(struct mlx5_wqe_data_seg) - qp->wq_sig;
 			qp->rq.max_post = qp->rq.wqe_cnt;
 		} else {
