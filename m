Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447F3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B0A20811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298795;
	bh=TpuwME+79ROUztRO8HsQ7hlrLKvo6hZJav3GgzpO4KY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JPY1lJu5q3yBJ/JMDGYpXN03GnKd8HknCpTRUmISw6bJ6Zxjh+zGtw67vXoaEF/Fi
	 bX5vz4RZbOLSLItCyqlLfvVXKoYLe3cDQ/p0d0VbN4/REB53t0K7Vdcehnnl3avlPG
	 Z84SW8HcEO2pgJa3/E23Jo4j2gfCFpdrSF7dFv2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733312AbeLTJjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:39:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:42680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731932AbeLTJZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:25:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAC0F20656;
        Thu, 20 Dec 2018 09:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297912;
        bh=TpuwME+79ROUztRO8HsQ7hlrLKvo6hZJav3GgzpO4KY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kOQZaW/jtBj1YX5YYIn9AXNSZEY3wGYEOU7zTYjncZrzDH2h/DAIYZq7g2n+bMMnF
         y9+N7AwRlqFz/SS08I2AuYWG9iyZcQzMDIsAAUurVs9xuTCLVluPpmo194r0xJj+x4
         ZWLFRpdnixYwhQgT5FZptpmf/daFeCmr9XTIdniI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Maximilian Riemensberger <riemensberger@cadami.net>,
        Graham Whaley <graham.whaley@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 56/61] vhost/vsock: fix reset orphans race with close timeout
Date:   Thu, 20 Dec 2018 10:18:56 +0100
Message-Id: <20181220085846.019914336@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085843.743900603@linuxfoundation.org>
References: <20181220085843.743900603@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index f800f89068db..46f966d7c328 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -559,13 +559,21 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
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



