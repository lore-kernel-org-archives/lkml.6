Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BC4C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D172075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D172075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbeIHB5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:57:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42106 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbeIHB5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:57:13 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7260FFD4;
        Fri,  7 Sep 2018 21:14:26 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>,
        Noa Osherovich <noaos@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Kees Cook <keescook@chromium.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.18 046/145] RDMA/mlx5: Fix shift overflow in mlx5_ib_create_wq
Date:   Fri,  7 Sep 2018 23:08:32 +0200
Message-Id: <20180907210908.304323048@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit 0dfe452241f4904de497aef01ad2f609ccb9be90 upstream.

[   61.182439] UBSAN: Undefined behaviour in drivers/infiniband/hw/mlx5/qp.c:5366:34
[   61.183673] shift exponent 4294967288 is too large for 32-bit type 'unsigned int'
[   61.185530] CPU: 0 PID: 639 Comm: qp Not tainted 4.18.0-rc1-00037-g4aa1d69a9c60-dirty #96
[   61.186981] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-2.fc27 04/01/2014
[   61.188315] Call Trace:
[   61.188661]  dump_stack+0xc7/0x13b
[   61.190427]  ubsan_epilogue+0x9/0x49
[   61.190899]  __ubsan_handle_shift_out_of_bounds+0x1ea/0x22f
[   61.197040]  mlx5_ib_create_wq+0x1c99/0x1d50
[   61.206632]  ib_uverbs_ex_create_wq+0x499/0x820
[   61.213892]  ib_uverbs_write+0x77e/0xae0
[   61.248018]  vfs_write+0x121/0x3b0
[   61.249831]  ksys_write+0xa1/0x120
[   61.254024]  do_syscall_64+0x7c/0x2a0
[   61.256178]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   61.259211] RIP: 0033:0x7f54bab70e99
[   61.262125] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89
[   61.268678] RSP: 002b:00007ffe1541c318 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   61.271076] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f54bab70e99
[   61.273795] RDX: 0000000000000070 RSI: 0000000020000240 RDI: 0000000000000003
[   61.276982] RBP: 00007ffe1541c330 R08: 00000000200078e0 R09: 0000000000000002
[   61.280035] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004005c0
[   61.283279] R13: 00007ffe1541c420 R14: 0000000000000000 R15: 0000000000000000

Cc: <stable@vger.kernel.org> # 4.7
Fixes: 79b20a6c3014 ("IB/mlx5: Add receive Work Queue verbs")
Cc: syzkaller <syzkaller@googlegroups.com>
Reported-by: Noa Osherovich <noaos@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/qp.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -5365,7 +5365,9 @@ static int set_user_rq_size(struct mlx5_
 
 	rwq->wqe_count = ucmd->rq_wqe_count;
 	rwq->wqe_shift = ucmd->rq_wqe_shift;
-	rwq->buf_size = (rwq->wqe_count << rwq->wqe_shift);
+	if (check_shl_overflow(rwq->wqe_count, rwq->wqe_shift, &rwq->buf_size))
+		return -EINVAL;
+
 	rwq->log_rq_stride = rwq->wqe_shift;
 	rwq->log_rq_size = ilog2(rwq->wqe_count);
 	return 0;


