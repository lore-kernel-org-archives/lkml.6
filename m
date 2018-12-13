Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBA9C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8296E20849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676393;
	bh=OiFm9/BsU/J1DCkDMLd6yB+79SZ3/k2JmgY/zi8JVMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=noMUvBxV8rPNLO9GKGMKFP97DjzPg9dpR4TPg1kIcQZa6sjOI7QOF6mx0mFHHbmQt
	 aXuF4FRkWeyhD5hnfU/Ox46bsIvTu94VFRjJGrrEUmcT20hStFggjCp8GHM+hxk5ve
	 NrX/19OX1N6PCi/9InfurDSlfJ4yauZqIKKRYGbY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8296E20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbeLMEqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:46:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:43528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728370AbeLMEak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:30:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CBC920882;
        Thu, 13 Dec 2018 04:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675440;
        bh=OiFm9/BsU/J1DCkDMLd6yB+79SZ3/k2JmgY/zi8JVMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dyw3zUIjuazdemWq1cgYc4jLPACWZMDcILX+qnTfaNhpkmBBya93bcmBYpOPVmFCy
         cWoGdNC1Dc+OpKSGVknCp5IrLHWlFG/tVQRJzjRmslDNP+Or5tPZr5koOcUJfFZEIT
         VZXpEWt+L7ujWsto0WKIEiQOlMsIikG2tj3b+Uak=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Graham Whaley <graham.whaley@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 64/73] vhost/vsock: fix reset orphans race with close timeout
Date:   Wed, 12 Dec 2018 23:28:29 -0500
Message-Id: <20181213042838.75160-64-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

[ Upstream commit c38f57da428b033f2721b611d84b1f40bde674a8 ]

If a local process has closed a connected socket and hasn't received a
RST packet yet, then the socket remains in the table until a timeout
expires.

When a vhost_vsock instance is released with the timeout still pending,
the socket is never freed because vhost_vsock has already set the
SOCK_DONE flag.

Check if the close timer is pending and let it close the socket.  This
prevents the race which can leak sockets.

Reported-by: Maximilian Riemensberger <riemensberger@cadami.net>
Cc: Graham Whaley <graham.whaley@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/vsock.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 34bc3ab40c6d..731e2ea2aeca 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -563,13 +563,21 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
 	 * executing.
 	 */
 
-	if (!vhost_vsock_get(vsk->remote_addr.svm_cid)) {
-		sock_set_flag(sk, SOCK_DONE);
-		vsk->peer_shutdown = SHUTDOWN_MASK;
-		sk->sk_state = SS_UNCONNECTED;
-		sk->sk_err = ECONNRESET;
-		sk->sk_error_report(sk);
-	}
+	/* If the peer is still valid, no need to reset connection */
+	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
+		return;
+
+	/* If the close timeout is pending, let it expire.  This avoids races
+	 * with the timeout callback.
+	 */
+	if (vsk->close_work_scheduled)
+		return;
+
+	sock_set_flag(sk, SOCK_DONE);
+	vsk->peer_shutdown = SHUTDOWN_MASK;
+	sk->sk_state = SS_UNCONNECTED;
+	sk->sk_err = ECONNRESET;
+	sk->sk_error_report(sk);
 }
 
 static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
-- 
2.19.1

