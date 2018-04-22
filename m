Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+uk5rfb87OCNeQ8UbFHswo62YQLKmNadCg2famrh3cQ9c3ssF81bhKiLLCQ/onRfPn0IvE
ARC-Seal: i=1; a=rsa-sha256; t=1524405543; cv=none;
        d=google.com; s=arc-20160816;
        b=fsogayej/gk6dpCbF/QZoOHYh7i6ugDll+Ur4UqU82Drj1KcefalZpWhkW3Jndd6PA
         j9VhoCK86OExrYdAfm1irSPxce1o53LMwgPzduj1aDKPxlRiZWnZ5fLZPUV08MQFVdS8
         6Dtigqxui57GWtOAcndXVpgP1kyaQw+gapAPZIkgD3WHqyPyg99OIUzXTsaZ/bWXcyS0
         5plMvejnL2D4Ok3H/EHsZJ22xmb2RLJTRo8ywulTVAruk9i2Hkiq5LeuY3u6eipdOhC1
         SvVAu1pV7M1MIvkEOiOEQTf/25d2qSpOmay1CCzba9Ej1FguCIfHcEyAzLLIRYQJ9Q5w
         WrYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gfGrXawqkSpgdkCfAY32VQV8Xu6AzP8CjWr6LTA8mpE=;
        b=lm8Y7BNMJBNrQtWSph2sURkkS9hIIS4yeYM6QIbNX6UGh1V4ySFjA6cpDPGkFOFQP9
         Gws4rSo5tk8cSxH/ZyyCZY+N8mm4SyIuANnLN28JRUak/ELCiuxfgQeYqXyT7ZPmoFVI
         tiuyWCtM9IdCVEhtCEGl4TKlpPGgnzjx+pj2s4CDwiTHVEj03gI19HfDlA5cuZERjxjd
         0OUbY2UZvH8o3sVk/zKJpICAjUz5sG4CBryEgILeGSxhtHWlSuX8diMNzyagzI9qpRSJ
         vohYw6x0IAHh6ATDVFWCciW8Jp5Ao8NhcNriJ4WC7spAjnPH52ZRMIl/byLLxF16kIrI
         P5wA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Steve Wise <swise@opengridcomputing.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.16 105/196] RDMA/core: Avoid that ib_drain_qp() triggers an out-of-bounds stack access
Date: Sun, 22 Apr 2018 15:52:05 +0200
Message-Id: <20180422135109.681220786@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455067002209345?=
X-GMAIL-MSGID: =?utf-8?q?1598455067002209345?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit a1ae7d0345edd593d6725d3218434d903a0af95d upstream.

This patch fixes the following KASAN complaint:

==================================================================
BUG: KASAN: stack-out-of-bounds in rxe_post_send+0x77d/0x9b0 [rdma_rxe]
Read of size 8 at addr ffff880061aef860 by task 01/1080

CPU: 2 PID: 1080 Comm: 01 Not tainted 4.16.0-rc3-dbg+ #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
Call Trace:
dump_stack+0x85/0xc7
print_address_description+0x65/0x270
kasan_report+0x231/0x350
rxe_post_send+0x77d/0x9b0 [rdma_rxe]
__ib_drain_sq+0x1ad/0x250 [ib_core]
ib_drain_qp+0x9/0x30 [ib_core]
srp_destroy_qp+0x51/0x70 [ib_srp]
srp_free_ch_ib+0xfc/0x380 [ib_srp]
srp_create_target+0x1071/0x19e0 [ib_srp]
kernfs_fop_write+0x180/0x210
__vfs_write+0xb1/0x2e0
vfs_write+0xf6/0x250
SyS_write+0x99/0x110
do_syscall_64+0xee/0x2b0
entry_SYSCALL_64_after_hwframe+0x42/0xb7

The buggy address belongs to the page:
page:ffffea000186bbc0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x4000000000000000()
raw: 4000000000000000 0000000000000000 0000000000000000 00000000ffffffff
raw: 0000000000000000 ffffea000186bbe0 0000000000000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
ffff880061aef700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffff880061aef780: 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00
>ffff880061aef800: f2 f2 f2 f2 f2 f2 f2 00 00 00 00 00 f2 f2 f2 f2
                                                      ^
ffff880061aef880: f2 f2 f2 00 00 00 00 00 00 00 00 00 00 00 f2 f2
ffff880061aef900: f2 f2 f2 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================

Fixes: 765d67748bcf ("IB: new common API for draining queues")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Steve Wise <swise@opengridcomputing.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/verbs.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2194,7 +2194,13 @@ static void __ib_drain_sq(struct ib_qp *
 	struct ib_cq *cq = qp->send_cq;
 	struct ib_qp_attr attr = { .qp_state = IB_QPS_ERR };
 	struct ib_drain_cqe sdrain;
-	struct ib_send_wr swr = {}, *bad_swr;
+	struct ib_send_wr *bad_swr;
+	struct ib_rdma_wr swr = {
+		.wr = {
+			.opcode	= IB_WR_RDMA_WRITE,
+			.wr_cqe	= &sdrain.cqe,
+		},
+	};
 	int ret;
 
 	ret = ib_modify_qp(qp, &attr, IB_QP_STATE);
@@ -2203,11 +2209,10 @@ static void __ib_drain_sq(struct ib_qp *
 		return;
 	}
 
-	swr.wr_cqe = &sdrain.cqe;
 	sdrain.cqe.done = ib_drain_qp_done;
 	init_completion(&sdrain.done);
 
-	ret = ib_post_send(qp, &swr, &bad_swr);
+	ret = ib_post_send(qp, &swr.wr, &bad_swr);
 	if (ret) {
 		WARN_ONCE(ret, "failed to drain send queue: %d\n", ret);
 		return;
