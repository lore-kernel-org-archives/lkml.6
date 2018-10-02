Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB3CC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E58A2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E58A2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbeJBURm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:17:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35252 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbeJBURl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:17:41 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 93DCF5AA;
        Tue,  2 Oct 2018 13:34:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Lukasz Odzioba <lukasz.odzioba@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.14 106/137] IB/hfi1: Invalid user input can result in crash
Date:   Tue,  2 Oct 2018 06:25:07 -0700
Message-Id: <20181002132505.917891806@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael J. Ruhl <michael.j.ruhl@intel.com>

commit 94694d18cf27a6faad91487a38ce516c2b16e7d9 upstream.

If the number of packets in a user sdma request does not match
the actual iovectors being sent, sdma_cleanup can be called on
an uninitialized request structure, resulting in a crash similar
to this:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
IP: [<ffffffffc0ae8bb7>] __sdma_txclean+0x57/0x1e0 [hfi1]
PGD 8000001044f61067 PUD 1052706067 PMD 0
Oops: 0000 [#1] SMP
CPU: 30 PID: 69912 Comm: upsm Kdump: loaded Tainted: G           OE
------------   3.10.0-862.el7.x86_64 #1
Hardware name: Intel Corporation S2600KPR/S2600KPR, BIOS
SE5C610.86B.01.01.0019.101220160604 10/12/2016
task: ffff8b331c890000 ti: ffff8b2ed1f98000 task.ti: ffff8b2ed1f98000
RIP: 0010:[<ffffffffc0ae8bb7>]  [<ffffffffc0ae8bb7>] __sdma_txclean+0x57/0x1e0
[hfi1]
RSP: 0018:ffff8b2ed1f9bab0  EFLAGS: 00010286
RAX: 0000000000008b2b RBX: ffff8b2adf6e0000 RCX: 0000000000000000
RDX: 00000000000000a0 RSI: ffff8b2e9eedc540 RDI: ffff8b2adf6e0000
RBP: ffff8b2ed1f9bad8 R08: 0000000000000000 R09: ffffffffc0b04a06
R10: ffff8b331c890190 R11: ffffe6ed00bf1840 R12: ffff8b3315480000
R13: ffff8b33154800f0 R14: 00000000fffffff2 R15: ffff8b2e9eedc540
FS:  00007f035ac47740(0000) GS:ffff8b331e100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 0000000c03fe6000 CR4: 00000000001607e0
Call Trace:
 [<ffffffffc0b0570d>] user_sdma_send_pkts+0xdcd/0x1990 [hfi1]
 [<ffffffff9fe75fb0>] ? gup_pud_range+0x140/0x290
 [<ffffffffc0ad3105>] ? hfi1_mmu_rb_insert+0x155/0x1b0 [hfi1]
 [<ffffffffc0b0777b>] hfi1_user_sdma_process_request+0xc5b/0x11b0 [hfi1]
 [<ffffffffc0ac193a>] hfi1_aio_write+0xba/0x110 [hfi1]
 [<ffffffffa001a2bb>] do_sync_readv_writev+0x7b/0xd0
 [<ffffffffa001bede>] do_readv_writev+0xce/0x260
 [<ffffffffa022b089>] ? tty_ldisc_deref+0x19/0x20
 [<ffffffffa02268c0>] ? n_tty_ioctl+0xe0/0xe0
 [<ffffffffa001c105>] vfs_writev+0x35/0x60
 [<ffffffffa001c2bf>] SyS_writev+0x7f/0x110
 [<ffffffffa051f7d5>] system_call_fastpath+0x1c/0x21
Code: 06 49 c7 47 18 00 00 00 00 0f 87 89 01 00 00 5b 41 5c 41 5d 41 5e 41 5f
5d c3 66 2e 0f 1f 84 00 00 00 00 00 48 8b 4e 10 48 89 fb <48> 8b 51 08 49 89 d4
83 e2 0c 41 81 e4 00 e0 00 00 48 c1 ea 02
RIP  [<ffffffffc0ae8bb7>] __sdma_txclean+0x57/0x1e0 [hfi1]
 RSP <ffff8b2ed1f9bab0>
CR2: 0000000000000008

There are two exit points from user_sdma_send_pkts().  One (free_tx)
merely frees the slab entry and one (free_txreq) cleans the sdma_txreq
prior to freeing the slab entry.   The free_txreq variation can only be
called after one of the sdma_init*() variations has been called.

In the panic case, the slab entry had been allocated but not inited.

Fix the issue by exiting through free_tx thus avoiding sdma_clean().

Cc: <stable@vger.kernel.org> # 4.9.x+
Fixes: 7724105686e7 ("IB/hfi1: add driver files")
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Lukasz Odzioba <lukasz.odzioba@intel.com>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

---
 drivers/infiniband/hw/hfi1/user_sdma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
@@ -828,7 +828,7 @@ static int user_sdma_send_pkts(struct us
 			if (ACCESS_ONCE(iovec->offset) == iovec->iov.iov_len) {
 				if (++req->iov_idx == req->data_iovs) {
 					ret = -EFAULT;
-					goto free_txreq;
+					goto free_tx;
 				}
 				iovec = &req->iovs[req->iov_idx];
 				WARN_ON(iovec->offset);


