Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753294AbeEGWVc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 18:21:32 -0400
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:44442
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753061AbeEGWV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 18:21:29 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH 4/7] cifs: smbd: Indicate to retry on transport sending failure
Date: Mon,  7 May 2018 15:20:03 -0700
Message-Id: <20180507222006.20781-4-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180507222006.20781-1-longli@linuxonhyperv.com>
References: <20180507222006.20781-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfEJVHCaXpk0Kz5Wn9Pm3DOBlvfoZ6nUhJxwZm6sxI33iHjr5W6a4E2AQTqgqx/TDn1RKifI5HfY+nRT7n5wTwYOBXfR+UnTBxNjjTBM4+Bi8oPp77oof
 ToUQfwUlv54WNwSM64oDscUVFf1zRVuitaVAQjzI0Y0OsMdWcsWGQIgu9aInhS+LcjtCvCuXai9yAjBoGm9elOgyNqOnB8Luzfg4l2HLa18kZll1i9k6dmXt
 pVtJta6PACJCLeX9QsEDZHIsHhJmWC4WFdJW5GapMgun7wCtNUlb+lqsq2vEUmoz3H687tyB6aE6uQUN4iG/1Ah+Y2eEcQVTsD+s/LN6+9DdLUcf5k1+nE1j
 2mX5ZBCBywMrRDPy1siSdoapa07RMzlcviMKxhDfy5KGyFPFgmbmzJLQrtaO7KG+DXG9BbI3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

Failure to send a packet doesn't mean it's a permanent failure, it can't be
returned to user process. This I/O should be retried or failed based on
server packet response and transport health. This logic is handled by the
upper layer.

Give this decision to upper layer.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/smbdirect.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index b8dd493..74620f5 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -851,7 +851,7 @@ static int smbd_create_header(struct smbd_connection *info,
 
 	if (info->transport_status != SMBD_CONNECTED) {
 		log_outgoing(ERR, "disconnected not sending\n");
-		return -ENOENT;
+		return -EAGAIN;
 	}
 	atomic_dec(&info->send_credits);
 
@@ -977,6 +977,7 @@ static int smbd_post_send(struct smbd_connection *info,
 				wake_up(&info->wait_send_pending);
 		}
 		smbd_disconnect_rdma_connection(info);
+		rc = -EAGAIN;
 	} else
 		/* Reset timer for idle connection after packet is sent */
 		mod_delayed_work(info->workqueue, &info->idle_timer_work,
@@ -2062,7 +2063,7 @@ int smbd_send(struct smbd_connection *info, struct smb_rqst *rqst)
 	int rc;
 
 	if (info->transport_status != SMBD_CONNECTED) {
-		rc = -ENODEV;
+		rc = -EAGAIN;
 		goto done;
 	}
 
-- 
2.7.4
