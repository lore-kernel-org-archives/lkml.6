Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753425AbeEGWWL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 18:22:11 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:60958
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753356AbeEGWVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 18:21:44 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH 6/7] cifs: smbd: Retry on memory registration failure
Date: Mon,  7 May 2018 15:20:05 -0700
Message-Id: <20180507222006.20781-6-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180507222006.20781-1-longli@linuxonhyperv.com>
References: <20180507222006.20781-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfBrIcZMnqS/l2sKVMJ8vd7oBENXuW8KQjEx/MllsKb9nN3rD58lYkss48R/aICJ5cqFS950xOkIID+IyNv2j48nJlb7NwJy6g2CfD5vhrhpOFnMn7oNd
 GUxbBnBxxvjuT98UK+q4v7m6kfH6dgJ75H88sBp0CTYZdYxkeVZtGjj23eRtuioCBzJrW6nf1cMcg1f7udSLx4jn0cyWdwaq+dw6CbzVmoP0sAQh7p9AaYko
 a0cG0q8iVQvsWC17pcCiiEuEfN2HeURdeUVG4yAcPqwHHrhHCbTr6oJ4BAeFDT63KNB8BXHiPeRmfa5gniaQBhBfkfw9tfrTmdd2/IcpvMae1OuaYjA+zM3N
 hFR3EBCLKK7hvN/MJtPen6PLZfNrzZztZYnXZ8ZGN/VxludGznFtoV5mHckhuZ9XSYjvLAZ9
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

Memory registration failure doesn't mean this I/O has failed, it means the
transport is hitting I/O error or needs reconnect. This error is not from
the server.

Indicate this error to upper layer, and let upper layer decide how to
reconnect and proceed with this I/O.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/smb2pdu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 09ca098..c72d1fa 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2617,7 +2617,7 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 				true, need_invalidate);
 		rcu_read_unlock();
 		if (!rdata->mr)
-			return -ENOBUFS;
+			return -EAGAIN;
 
 		req->Channel = SMB2_CHANNEL_RDMA_V1_INVALIDATE;
 		if (need_invalidate)
@@ -2997,7 +2997,7 @@ smb2_async_writev(struct cifs_writedata *wdata,
 				false, need_invalidate);
 		rcu_read_unlock();
 		if (!wdata->mr) {
-			rc = -ENOBUFS;
+			rc = -EAGAIN;
 			goto async_writev_out;
 		}
 		req->Length = 0;
-- 
2.7.4
