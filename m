Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbeC3WSE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 18:18:04 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:51790
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752478AbeC3WSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 18:18:01 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH 2/2] cifs: smbd: disconnect transport on RDMA errors
Date: Fri, 30 Mar 2018 15:16:36 -0700
Message-Id: <20180330221636.32512-2-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180330221636.32512-1-longli@linuxonhyperv.com>
References: <20180330221636.32512-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfOk9/GjI/YXBjbKCG+YrISH5CJBlpV5FjFxjVk1KcKuTihwxZNW6ASWujcNaHjG81LxNzrdzJquDLgEcGsEeDVkUat4rooOv15ucu+7chNBurPgV3KCt
 e6RS57aL3YOiiolbCS1pzaJVmB7Zh9tQLeHpVYJLmRYEJe5+8LAJMTX9Ej1jxI+H8v9HrWWGGfux6c61zmZcNKJLyd7Jk9qdpVe3J2P97c5yus0+V7zxw7mC
 4xqhAT/1RH5WD2riCyH/NWHYG64tg/hatJ4mSoGxu29SWO5Mr10pJBpKRpzp3xGvTaLd5C4qyDB5IZsaUTLfuXCw+/Q5WAYSUdsVEZxS9mHrxoCOPVeXQSu/
 6+PZRa0+3p0AYKnXvdDHSO/vK+73xA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

On RDMA errors, transport should disconnect the RDMA CM connection. This
will notify the upper layer, and it will attempt transport reconnect.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/smbdirect.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 3f7883e..5008af5 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -862,6 +862,8 @@ static int smbd_post_send_negotiate_req(struct smbd_connection *info)
 	ib_dma_unmap_single(info->id->device, request->sge[0].addr,
 		request->sge[0].length, DMA_TO_DEVICE);
 
+	smbd_disconnect_rdma_connection(info);
+
 dma_mapping_failed:
 	mempool_free(request, info->request_mempool);
 	return rc;
@@ -1061,6 +1063,7 @@ static int smbd_post_send(struct smbd_connection *info,
 			if (atomic_dec_and_test(&info->send_pending))
 				wake_up(&info->wait_send_pending);
 		}
+		smbd_disconnect_rdma_connection(info);
 	} else
 		/* Reset timer for idle connection after packet is sent */
 		mod_delayed_work(info->workqueue, &info->idle_timer_work,
@@ -1202,7 +1205,7 @@ static int smbd_post_recv(
 	if (rc) {
 		ib_dma_unmap_single(info->id->device, response->sge.addr,
 				    response->sge.length, DMA_FROM_DEVICE);
-
+		smbd_disconnect_rdma_connection(info);
 		log_rdma_recv(ERR, "ib_post_recv failed rc=%d\n", rc);
 	}
 
@@ -2546,6 +2549,8 @@ struct smbd_mr *smbd_register_mr(
 	if (atomic_dec_and_test(&info->mr_used_count))
 		wake_up(&info->wait_for_mr_cleanup);
 
+	smbd_disconnect_rdma_connection(info);
+
 	return NULL;
 }
 
-- 
2.7.4
