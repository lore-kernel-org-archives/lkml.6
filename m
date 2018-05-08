Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrGn8IcetTHRicS/XtBuHS2NyoXYmGYUPLT3cSU7ghn12oPobaaecLB1I1jDX4676ZM3tjc
ARC-Seal: i=1; a=rsa-sha256; t=1525767414; cv=none;
        d=google.com; s=arc-20160816;
        b=F8RS42sHr7kabDhpuFh/sQLCYRGEkYk51FSuctaDdst/bTJZESpIoS0oxTB8ZLe2uj
         Kk3hT4Lx6Pm7fWy+mnF++Pskti0y4UEnYjoTqTFuqYiKR/CKBi2bzlikXLOkAxJ1is3y
         DV27cVoE5RtlC0PX5Q5wSwHBFfzK8Ye1EzCNs7FDASQgv9bXcNM6so/W1X+IWC+GmhYo
         kYq0vjrnBTpbJ6BDcPfm7Vhv0jtMuB7j45QaEcf4jHDXquwa+UNMqFCAT5LKb000oYHU
         GqTvQg5q1xrgbancJ/OTtB+aZOoXgHBdI7cvUykmVrDY519pyPGuw0RlY95RCQKNrk8w
         p3uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=HHv7tjQjX0JVNPXmlhJHAELqOafbSEbf/AB6s1iXQQ4=;
        b=vTcYHe528/XwLsOJG7I4StwatGvfi4xDi1ggZlcQVkC07v6Oq5uo5P0DYfuEqZb8Xr
         2iBqHOnes6mub0sJWKZ78HE3e2DQCbyoQkyI5eOh0iDTP9y8qe+G+8Aaa4GzyBxj4+XR
         X6v9phmTbZy7SkLZox6A0G7wUG6rkeGfaIN08ITzI1mmnd6uDE8CJwZsk0bUAqAOCiY8
         5oxc1giaIo5ktcbMC31lMf2QnVOBypcyxa72bijrWfhAv9S3wlqqEZ/DmRLCZxp8pEjv
         zuxL9bnBkHP30olG7sTKIvBR9E0vNO/dYf9B3fUPVIvS5vBgUx1nkvqNCSEYFt/gK8p0
         r4Fg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=1HCXOIQB;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=1HCXOIQB;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzkaller <syzkaller@googlegroups.com>,
	Noa Osherovich <noaos@mellanox.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.9 18/32] RDMA/mlx5: Protect from shift operand overflow
Date: Tue,  8 May 2018 10:10:58 +0200
Message-Id: <20180508074011.776302542@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882854592096304?=
X-GMAIL-MSGID: =?utf-8?q?1599883092206944874?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -253,7 +253,11 @@ static int set_rq_size(struct mlx5_ib_de
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
