Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48kscfUkHD/G1r50Mt7HvcK+ly2fiKpPGDANo5rCf6dgMLDqksqLJyuGx4HqCJq+ky0UAGb
ARC-Seal: i=1; a=rsa-sha256; t=1524405540; cv=none;
        d=google.com; s=arc-20160816;
        b=j9CNb12j6MfLeQwkwoGRcIUOO5m1bSDQG7KDS39Mrr+EapL2SgayDhPlvPix2vJHJO
         p9ZoC3uky+X4jo2JM46817qVk3OiTvP1dLkNPAOCPa014p8mFIRiPTsoaOqWA2E8xgg0
         eI9scKF5mMx4zRhQRTFJf1+oFhxJgBE3RMU7xRa3C5dbqd56PjltaRyQijMEukJNlBgg
         Zi4enCR/TCq9/jUycaExoOHCDnYlwKJez7/S8ZvhoKKmr4+EiOGNnZftdPppy0vTH0l3
         qaN3fCkOJZ9IAqJypAkP2apHTl5+y4PfoDdbanYeSPhRRXBQZ8g60QbXO2Dh/KlNfxb3
         1wGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=t0VO/jP5y2cFHEqpA1u2KRritxANRy53C/vUD9laf5o=;
        b=XB9Hr/ey6dfuASz3R3lJFIAmQEUzOXOC+Cq45w5mZukDlyMRBFQiEgls5/hAjifUkE
         J4RrtqAHVpd4AgpcGXNmG2rl4B3TAtRFe33eh9yge+iv2hKZiW5/vaDQt5bUenyKQzK7
         hIupWQo9r+jpPB/ZOc0742b6KegQPwmQ71SrzMd/aCwegG6D04ur6V/9UkIBHoBsZJJR
         XXIeVRNZ1fMGHXLEa+hiEz+ahlVq2Gve8AEOy3HGd4/Ie7hetMdO15URP1C9mCbLo6t/
         Whk4jRANRyiL/LM0pQgLVSMLitkLg+EQscQd2ixOrx2YwybNZMt28wWpUyuycoNopwwr
         Nrcg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Moni Shoua <monis@mellanox.com>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.16 104/196] RDMA/rxe: Fix an out-of-bounds read
Date: Sun, 22 Apr 2018 15:52:04 +0200
Message-Id: <20180422135109.629250106@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455063438272649?=
X-GMAIL-MSGID: =?utf-8?q?1598455063438272649?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit a6544a624c3ff92a64e4aca3931fa064607bd3da upstream.

This patch avoids that KASAN reports the following when the SRP initiator
calls srp_post_send():

==================================================================
BUG: KASAN: stack-out-of-bounds in rxe_post_send+0x5c4/0x980 [rdma_rxe]
Read of size 8 at addr ffff880066606e30 by task 02-mq/1074

CPU: 2 PID: 1074 Comm: 02-mq Not tainted 4.16.0-rc3-dbg+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
Call Trace:
dump_stack+0x85/0xc7
print_address_description+0x65/0x270
kasan_report+0x231/0x350
rxe_post_send+0x5c4/0x980 [rdma_rxe]
srp_post_send.isra.16+0x149/0x190 [ib_srp]
srp_queuecommand+0x94d/0x1670 [ib_srp]
scsi_dispatch_cmd+0x1c2/0x550 [scsi_mod]
scsi_queue_rq+0x843/0xa70 [scsi_mod]
blk_mq_dispatch_rq_list+0x143/0xac0
blk_mq_do_dispatch_ctx+0x1c5/0x260
blk_mq_sched_dispatch_requests+0x2bf/0x2f0
__blk_mq_run_hw_queue+0xdb/0x160
__blk_mq_delay_run_hw_queue+0xba/0x100
blk_mq_run_hw_queue+0xf2/0x190
blk_mq_sched_insert_request+0x163/0x2f0
blk_execute_rq+0xb0/0x130
scsi_execute+0x14e/0x260 [scsi_mod]
scsi_probe_and_add_lun+0x366/0x13d0 [scsi_mod]
__scsi_scan_target+0x18a/0x810 [scsi_mod]
scsi_scan_target+0x11e/0x130 [scsi_mod]
srp_create_target+0x1522/0x19e0 [ib_srp]
kernfs_fop_write+0x180/0x210
__vfs_write+0xb1/0x2e0
vfs_write+0xf6/0x250
SyS_write+0x99/0x110
do_syscall_64+0xee/0x2b0
entry_SYSCALL_64_after_hwframe+0x42/0xb7

The buggy address belongs to the page:
page:ffffea0001998180 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x4000000000000000()
raw: 4000000000000000 0000000000000000 0000000000000000 00000000ffffffff
raw: dead000000000100 dead000000000200 0000000000000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
ffff880066606d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1
ffff880066606d80: f1 00 f2 f2 f2 f2 f2 f2 f2 00 00 f2 f2 f2 f2 f2
>ffff880066606e00: f2 00 00 00 00 00 f2 f2 f2 f3 f3 f3 f3 00 00 00
                                    ^
ffff880066606e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffff880066606f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Moni Shoua <monis@mellanox.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/sw/rxe/rxe_verbs.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -711,9 +711,8 @@ static int init_send_wqe(struct rxe_qp *
 		memcpy(wqe->dma.sge, ibwr->sg_list,
 		       num_sge * sizeof(struct ib_sge));
 
-	wqe->iova		= (mask & WR_ATOMIC_MASK) ?
-					atomic_wr(ibwr)->remote_addr :
-					rdma_wr(ibwr)->remote_addr;
+	wqe->iova = mask & WR_ATOMIC_MASK ? atomic_wr(ibwr)->remote_addr :
+		mask & WR_READ_OR_WRITE_MASK ? rdma_wr(ibwr)->remote_addr : 0;
 	wqe->mask		= mask;
 	wqe->dma.length		= length;
 	wqe->dma.resid		= length;
