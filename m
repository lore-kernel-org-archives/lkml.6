Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181D7C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E5F20878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E5F20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbeLFEwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 23:52:21 -0500
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:45772
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727940AbeLFEwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 23:52:21 -0500
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id Uld9gCuEJThUeUld9gmPSE; Wed, 05 Dec 2018 21:51:19 -0700
x-originating-ip: 107.180.71.197
Received: from longli by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <longli@linuxonhyperv2.linuxonhyperv.com>)
        id 1gUld9-0002gu-2j; Wed, 05 Dec 2018 21:51:19 -0700
From:   Long Li <longli@linuxonhyperv.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Long Li <longli@microsoft.com>
Subject: [PATCH] CIFS: Avoid returning EBUSY to upper layer VFS
Date:   Thu,  6 Dec 2018 04:51:06 +0000
Message-Id: <20181206045106.10307-1-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Reply-To: longli@microsoft.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfClKI8v2oRk6JDdYiuZS2omecvMEn+QmMHXK60o81X8WC9WNllrv8KcL4ygEqW79NhzRC9UL2bjCi84P1N+mt/2vdwHGZn25cIFtgqcRdax3d7l9zrVm
 v8ZVz3xE5ksWERIhUuA+xexH0Ge7WazNGOd9sNUlrfwlOxdMAVpxQpjlX+v1pq0tKtu70LaIE9Wcg58hDQWHf73kOMiIAETCwHlOV4XlXyDgCIFpkbyu2o4D
 iaD/kQmuX+295W/6ES9QP7bzXEwxUMn0NAsxLYH20C7wkheRHYqLZaVR8me7cJzm7gScXfqTg8ACgwV7nJAAOSGtrlJdyMWnel6lCYDDcf2IiBBakNCYrj2k
 wW05vEQBDNizKDqDGex3eBuYQXt7XMFaOW9e5oeScIHoMn4AZ8220xLjNXHWv7RO5tPywoqLfUciS4M1dMOkDPxRzZrHUtKPpxv2F/bnXdCVPnZpXy0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

EBUSY is not handled by VFS, and will be passed to user-mode. This is not
correct as we need to wait for more credits.

This patch also fixes a bug where rsize or wsize is used uninitialized when
the call to server->ops->wait_mtu_credits() fails.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/file.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 74c33d5..c9bc56b 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2541,14 +2541,13 @@ static int
 cifs_resend_wdata(struct cifs_writedata *wdata, struct list_head *wdata_list,
 	struct cifs_aio_ctx *ctx)
 {
-	int wait_retry = 0;
 	unsigned int wsize, credits;
 	int rc;
 	struct TCP_Server_Info *server =
 		tlink_tcon(wdata->cfile->tlink)->ses->server;
 
 	/*
-	 * Try to resend this wdata, waiting for credits up to 3 seconds.
+	 * Wait for credits to resend this wdata.
 	 * Note: we are attempting to resend the whole wdata not in segments
 	 */
 	do {
@@ -2556,19 +2555,13 @@ cifs_resend_wdata(struct cifs_writedata *wdata, struct list_head *wdata_list,
 			server, wdata->bytes, &wsize, &credits);
 
 		if (rc)
-			break;
+			goto out;
 
 		if (wsize < wdata->bytes) {
 			add_credits_and_wake_if(server, credits, 0);
 			msleep(1000);
-			wait_retry++;
 		}
-	} while (wsize < wdata->bytes && wait_retry < 3);
-
-	if (wsize < wdata->bytes) {
-		rc = -EBUSY;
-		goto out;
-	}
+	} while (wsize < wdata->bytes);
 
 	rc = -EAGAIN;
 	while (rc == -EAGAIN) {
@@ -3234,14 +3227,13 @@ static int cifs_resend_rdata(struct cifs_readdata *rdata,
 			struct list_head *rdata_list,
 			struct cifs_aio_ctx *ctx)
 {
-	int wait_retry = 0;
 	unsigned int rsize, credits;
 	int rc;
 	struct TCP_Server_Info *server =
 		tlink_tcon(rdata->cfile->tlink)->ses->server;
 
 	/*
-	 * Try to resend this rdata, waiting for credits up to 3 seconds.
+	 * Wait for credits to resend this rdata.
 	 * Note: we are attempting to resend the whole rdata not in segments
 	 */
 	do {
@@ -3249,24 +3241,13 @@ static int cifs_resend_rdata(struct cifs_readdata *rdata,
 						&rsize, &credits);
 
 		if (rc)
-			break;
+			goto out;
 
 		if (rsize < rdata->bytes) {
 			add_credits_and_wake_if(server, credits, 0);
 			msleep(1000);
-			wait_retry++;
 		}
-	} while (rsize < rdata->bytes && wait_retry < 3);
-
-	/*
-	 * If we can't find enough credits to send this rdata
-	 * release the rdata and return failure, this will pass
-	 * whatever I/O amount we have finished to VFS.
-	 */
-	if (rsize < rdata->bytes) {
-		rc = -EBUSY;
-		goto out;
-	}
+	} while (rsize < rdata->bytes);
 
 	rc = -EAGAIN;
 	while (rc == -EAGAIN) {
-- 
2.7.4

