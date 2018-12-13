Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D581C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C6E20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675925;
	bh=IEzTQ6mp8fN1MGWL/+2aJweD5j6rfumfqslG+pd9eSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1MClpbpPbSxOt5kPHdtAp8w+fevlIfA0dT7VS26e0iaLcLRi6Bhq8CxA1KIFunlSO
	 pgOMaW9uRcgYY6qceSNRCMTzhW9IHr5C3owt9hrcB7c2U+zwRxN/Eg1GRa3umtHqdP
	 oav9+emx2bYNwWITl5D/jqSpCa2BQKO4azqOxIwU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C6E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbeLMEio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:38:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:45740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbeLMEcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:32:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9250020882;
        Thu, 13 Dec 2018 04:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675571;
        bh=IEzTQ6mp8fN1MGWL/+2aJweD5j6rfumfqslG+pd9eSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DRlmLQHKgzhF0SsBkTgpWUSX++dby5xatUnFWclJTvHg//yX5/r+sS9LrioYMJ7pM
         LpGHbeNqhM3V9WGolEbFCBZsWAUHtB/a31v7SD+aJ8JMXS3H4xVAFpiSJk4aWgCxPV
         Jofjda2fiNLWl2A6iXpc39xklOkXdyyMQDeZZ5HI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Graham Whaley <graham.whaley@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 30/34] vhost/vsock: fix reset orphans race with close timeout
Date:   Wed, 12 Dec 2018 23:31:56 -0500
Message-Id: <20181213043200.76295-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043200.76295-1-sashal@kernel.org>
References: <20181213043200.76295-1-sashal@kernel.org>
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
index 0ec970ca64ce..5d77a7491edb 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -551,13 +551,21 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
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

