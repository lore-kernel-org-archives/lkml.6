Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845DEC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485C620874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485C620874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967443AbeFRIdM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:33:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35408 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967430AbeFRIdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:33:10 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D7CD7BAD;
        Mon, 18 Jun 2018 08:33:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Srinivas Eeda <srinivas.eeda@oracle.com>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Zhu Yanjun <yanjun.zhu@oracle.com>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 088/189] IB/rxe: avoid double kfree_skb
Date:   Mon, 18 Jun 2018 10:13:04 +0200
Message-Id: <20180618081212.775556097@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhu Yanjun <yanjun.zhu@oracle.com>

[ Upstream commit 9fd4350ba8953804f05215999e11a6cfb7b41f2b ]

When skb is sent, it will pass the following functions in soft roce.

rxe_send [rdma_rxe]
    ip_local_out
        __ip_local_out
        ip_output
            ip_finish_output
                ip_finish_output2
                    dev_queue_xmit
                        __dev_queue_xmit
                            dev_hard_start_xmit

In the above functions, if error occurs in the above functions or
iptables rules drop skb after ip_local_out, kfree_skb will be called.
So it is not necessary to call kfree_skb in soft roce module again.
Or else crash will occur.

The steps to reproduce:

     server                       client
    ---------                    ---------
    |1.1.1.1|<----rxe-channel--->|1.1.1.2|
    ---------                    ---------

On server: rping -s -a 1.1.1.1 -v -C 10000 -S 512
On client: rping -c -a 1.1.1.1 -v -C 10000 -S 512

The kernel configs CONFIG_DEBUG_KMEMLEAK and
CONFIG_DEBUG_OBJECTS are enabled on both server and client.

When rping runs, run the following command in server:

iptables -I OUTPUT -p udp  --dport 4791 -j DROP

Without this patch, crash will occur.

CC: Srinivas Eeda <srinivas.eeda@oracle.com>
CC: Junxiao Bi <junxiao.bi@oracle.com>
Signed-off-by: Zhu Yanjun <yanjun.zhu@oracle.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/sw/rxe/rxe_req.c  |    1 -
 drivers/infiniband/sw/rxe/rxe_resp.c |    6 +-----
 2 files changed, 1 insertion(+), 6 deletions(-)

--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -728,7 +728,6 @@ next_wqe:
 		rollback_state(wqe, qp, &rollback_wqe, rollback_psn);
 
 		if (ret == -EAGAIN) {
-			kfree_skb(skb);
 			rxe_run_task(&qp->req.task, 1);
 			goto exit;
 		}
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -742,7 +742,6 @@ static enum resp_states read_reply(struc
 	err = rxe_xmit_packet(rxe, qp, &ack_pkt, skb);
 	if (err) {
 		pr_err("Failed sending RDMA reply.\n");
-		kfree_skb(skb);
 		return RESPST_ERR_RNR;
 	}
 
@@ -955,10 +954,8 @@ static int send_ack(struct rxe_qp *qp, s
 	}
 
 	err = rxe_xmit_packet(rxe, qp, &ack_pkt, skb);
-	if (err) {
+	if (err)
 		pr_err_ratelimited("Failed sending ack\n");
-		kfree_skb(skb);
-	}
 
 err1:
 	return err;
@@ -1151,7 +1148,6 @@ static enum resp_states duplicate_reques
 			if (rc) {
 				pr_err("Failed resending result. This flow is not handled - skb ignored\n");
 				rxe_drop_ref(qp);
-				kfree_skb(skb_copy);
 				rc = RESPST_CLEANUP;
 				goto out;
 			}


