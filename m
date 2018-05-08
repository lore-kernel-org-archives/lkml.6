Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoolU8i3Jwol+xTwP+EN21ZIQ0olwozN4UPJiA/W1fWZANHh5QBZc/vhI24jRk4AqNtZTt+
ARC-Seal: i=1; a=rsa-sha256; t=1525767300; cv=none;
        d=google.com; s=arc-20160816;
        b=rWd3D8alII1iGUVovuqum70O1IslbiQVi7C3Zk71rBoDNmZmZVo17PxLEAqnx3qrfd
         GXIlmWiQihQSdAXWJ9EqVN4PbzL4v8nJ6piboXH75YHjdhbe+YDmA/JlizD0UpQ/rabB
         CBxUHDRotuoZHz1ixgNqxFaTehD3HyhsSzra4J9bxHIl5IzGOHZlzj8+KXR5WV9NZ6Wx
         oZtOR1BJdqdJ/xQdErE7MEX/CBpyp3O/SLMLh6sEKNr2mL1yOvLbOsBfts8S2tEMzfax
         r7gesuEkoe53t5aULPdhzYPb0elZ5eApBggiBQW2kubunSXVEsTD2m9mcUkMmBAiDPFV
         Z8hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ESV4g6ZPDVQaRnQBA+c6kTJN55fati8tl7ewOdw3ZmA=;
        b=dWQeP/V84UR7eClgQEfdgOe1dFxanxsY837AcP0uvDnrfNjiWMnbOQGJ8vXZU5T5PC
         sGqUX4m1E+6F7yTrxwtB5/EH2qVLQyjLLkCmgQWsUHmTRXI8q/OuxbjqvjpX+cEqkzJI
         WpVhCnczUS08S3DzIM8owvKSKBpNb4lYqcqhS6YR9rXqyZMvNh3DiCDwOX+v4+7FNzga
         HSKHOPwG/db7l+2A73am3tbBB6oAkUyD7eEIFkwxi1fkDb7e4zDvNGN8cea1x15GUwap
         T+pjsYVEh5rfCVCj1dQfdhhSDM3eimW6/G2tiMd5oTVI4dnnzDRmaqR4hdCo1fLx7aBy
         tZSg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=NG1ehXrn;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=NG1ehXrn;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzkaller <syzkaller@googlegroups.com>,
	Noa Osherovich <noaos@mellanox.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.14 23/43] RDMA/mlx5: Protect from shift operand overflow
Date: Tue,  8 May 2018 10:10:42 +0200
Message-Id: <20180508074007.692201053@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882854592096304?=
X-GMAIL-MSGID: =?utf-8?q?1599882973145238774?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -256,7 +256,11 @@ static int set_rq_size(struct mlx5_ib_de
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
