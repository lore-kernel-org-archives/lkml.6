Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCD3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69168208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9xCsX4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69168208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbeK3B2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:28:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:53780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731095AbeK3B2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:28:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18520205C9;
        Thu, 29 Nov 2018 14:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501365;
        bh=DvncEL8XKxLlxqf1uOO69i1UCJhOlByYK2SppQDJW8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k9xCsX4PEpsqzVyM4YkgLSWEkSgaLvIZOZhZeRZ0QykaXySWNLNAx6b+++LTbVF9c
         G2kCCFJWRsubInBNEJk+DW847YpAPV7AEn/IvltwVjXnjtzlsT6acSlmoxwwHzW8KL
         9h88ahv9Qhin2JZySZzLClTiZILNP2WqULqkDPMU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuval Shaia <yuval.shaia@oracle.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Alex Estrin <alex.estrin@intel.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        stable@kernel.org
Subject: [PATCH 4.9 25/92] IB/core: Fix for core panic
Date:   Thu, 29 Nov 2018 15:11:54 +0100
Message-Id: <20181129140108.408252939@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140106.520639693@linuxfoundation.org>
References: <20181129140106.520639693@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Estrin <alex.estrin@intel.com>

commit e6f9bc34d3779cb7b6a337afed5de8be3f0fab77 upstream.

Build with the latest patches resulted in panic:
11384.486289] BUG: unable to handle kernel NULL pointer dereference at
         (null)
[11384.486293] IP:           (null)
[11384.486295] PGD 0
[11384.486295] P4D 0
[11384.486296]
[11384.486299] Oops: 0010 [#1] SMP
......... snip ......
[11384.486401] CPU: 0 PID: 968 Comm: kworker/0:1H Tainted: G        W  O
    4.13.0-a-stream-20170825 #1
[11384.486402] Hardware name: Intel Corporation S2600WT2R/S2600WT2R,
BIOS SE5C610.86B.01.01.0014.121820151719 12/18/2015
[11384.486418] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
[11384.486419] task: ffff880850579680 task.stack: ffffc90007fec000
[11384.486420] RIP: 0010:          (null)
[11384.486420] RSP: 0018:ffffc90007fef970 EFLAGS: 00010206
[11384.486421] RAX: ffff88084cfe8000 RBX: ffff88084dce4000 RCX:
ffffc90007fef978
[11384.486422] RDX: 0000000000000000 RSI: 0000000000000001 RDI:
ffff88084cfe8000
[11384.486422] RBP: ffffc90007fefab0 R08: 0000000000000000 R09:
ffff88084dce4080
[11384.486423] R10: ffffffffa02d7f60 R11: 0000000000000000 R12:
ffff88105af65a00
[11384.486423] R13: ffff88084dce4000 R14: 000000000000c000 R15:
000000000000c000
[11384.486424] FS:  0000000000000000(0000) GS:ffff88085f400000(0000)
knlGS:0000000000000000
[11384.486425] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11384.486425] CR2: 0000000000000000 CR3: 0000000001c09000 CR4:
00000000001406f0
[11384.486426] Call Trace:
[11384.486431]  ? is_valid_mcast_lid.isra.21+0xfb/0x110 [ib_core]
[11384.486436]  ib_attach_mcast+0x6f/0xa0 [ib_core]
[11384.486441]  ipoib_mcast_attach+0x81/0x190 [ib_ipoib]
[11384.486443]  ipoib_mcast_join_complete+0x354/0xb40 [ib_ipoib]
[11384.486448]  mcast_work_handler+0x330/0x6c0 [ib_core]
[11384.486452]  join_handler+0x101/0x220 [ib_core]
[11384.486455]  ib_sa_mcmember_rec_callback+0x54/0x80 [ib_core]
[11384.486459]  recv_handler+0x3a/0x60 [ib_core]
[11384.486462]  ib_mad_recv_done+0x423/0x9b0 [ib_core]
[11384.486466]  __ib_process_cq+0x5d/0xb0 [ib_core]
[11384.486469]  ib_cq_poll_work+0x20/0x60 [ib_core]
[11384.486472]  process_one_work+0x149/0x360
[11384.486474]  worker_thread+0x4d/0x3c0
[11384.486487]  kthread+0x109/0x140
[11384.486488]  ? rescuer_thread+0x380/0x380
[11384.486489]  ? kthread_park+0x60/0x60
[11384.486490]  ? kthread_park+0x60/0x60
[11384.486493]  ret_from_fork+0x25/0x30
[11384.486493] Code:  Bad RIP value.
[11384.486493] Code:  Bad RIP value.
[11384.486496] RIP:           (null) RSP: ffffc90007fef970
[11384.486497] CR2: 0000000000000000
[11384.486531] ---[ end trace b1acec6fb4ff6e75 ]---
[11384.532133] Kernel panic - not syncing: Fatal exception
[11384.536541] Kernel Offset: disabled
[11384.969491] ---[ end Kernel panic - not syncing: Fatal exception
[11384.976875] sched: Unexpected reschedule of offline CPU#1!
[11384.983646] ------------[ cut here ]------------

Rdma device driver may not have implemented (*get_link_layer)()
so it can not be called directly. Should use appropriate helper function.

Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Fixes: 523633359224 ("IB/core: Fix the validations of a multicast LID in attach or detach operations")
Cc: stable@kernel.org # 4.13
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Alex Estrin <alex.estrin@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/verbs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1522,7 +1522,7 @@ static bool is_valid_mcast_lid(struct ib
 	 */
 	if (!ib_query_qp(qp, &attr, IB_QP_STATE | IB_QP_PORT, &init_attr)) {
 		if (attr.qp_state >= IB_QPS_INIT) {
-			if (qp->device->get_link_layer(qp->device, attr.port_num) !=
+			if (rdma_port_get_link_layer(qp->device, attr.port_num) !=
 			    IB_LINK_LAYER_INFINIBAND)
 				return true;
 			goto lid_check;
@@ -1531,7 +1531,7 @@ static bool is_valid_mcast_lid(struct ib
 
 	/* Can't get a quick answer, iterate over all ports */
 	for (port = 0; port < qp->device->phys_port_cnt; port++)
-		if (qp->device->get_link_layer(qp->device, port) !=
+		if (rdma_port_get_link_layer(qp->device, port) !=
 		    IB_LINK_LAYER_INFINIBAND)
 			num_eth_ports++;
 


