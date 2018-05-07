Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbeEGWVk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 18:21:40 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:50196
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753061AbeEGWVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 18:21:34 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH 3/7] cifs: smbd: Return EINTR when interrupted
Date: Mon,  7 May 2018 15:20:02 -0700
Message-Id: <20180507222006.20781-3-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180507222006.20781-1-longli@linuxonhyperv.com>
References: <20180507222006.20781-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfDn9jugCorh4uZqMVktUN0N+LQzhLctzy3THfzRDDhqZ5I8zUFXs/zETN63ZGbVa96bWLe2WCYU6VSPwukOVC4QUpkHwLVKPsieyIm4MU8naJV9f+C77
 sNdUEEOzXxopLavAC4NhwVFUZjcWzz1NIkY1cisiG9J6QD2lDPxhdwmijVnhdE6qq8kRXA3peh+GjDFrNBzATYhrt8euL4tNPGopeXHTzT9REz04aNAQG/ib
 x77DiBMUMRMGMaP35DexGCrriI3nJ/pPh3MujSpqNSdUszvyotX9OWvAAhQie2AHPyNA9ZpOffDXVpGXuvAYwO0qDkA5vxvjqy78+OmlnG1F4BrFAXRG8Qjz
 6k15djuMB/e21Vf0+JT52GERIkAYzNgXLvFbv5SjWsXyBm+OLWFo5gYILGXr5lTbZSsRsQun
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

When packets are waiting for outbound I/O and interrupted, return the
proper error code to user process.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/smbdirect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 79b025e..b8dd493 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -1963,7 +1963,7 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
 			info->transport_status != SMBD_CONNECTED);
 	/* Don't return any data if interrupted */
 	if (rc)
-		return -ENODEV;
+		return rc;
 
 	if (info->transport_status != SMBD_CONNECTED) {
 		log_read(ERR, "disconnected\n");
@@ -1991,7 +1991,7 @@ static int smbd_recv_page(struct smbd_connection *info,
 		info->reassembly_data_length >= to_read ||
 			info->transport_status != SMBD_CONNECTED);
 	if (ret)
-		return 0;
+		return ret;
 
 	/* now we can read from reassembly queue and not sleep */
 	to_address = kmap_atomic(page);
-- 
2.7.4
