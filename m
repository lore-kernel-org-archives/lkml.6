Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4EFC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2189C20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676136;
	bh=s0tf7xE1vP2FyK7IKVzPkBK65Mepz8xmZDzZVlN2Uv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FX9XUODMKTae7S5zgbT6RwgnOFOB03isNDiARQK0gT1uzf1bt3NkvvTqtWtx8FrnV
	 XsqQOzMhXO/wWQqPdyYptpieZmowvCvv2/RCT4MXZuBLDyQcYAC3G6G1Aa+6f7yg6L
	 3ZgZhiwxwSLmFIGns3VqdHAlVRVofb7hJQa9PWvw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2189C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbeLMEmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:42:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:44742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728889AbeLMEbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:31:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CB6B20880;
        Thu, 13 Dec 2018 04:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675509;
        bh=s0tf7xE1vP2FyK7IKVzPkBK65Mepz8xmZDzZVlN2Uv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f8QYjI/sfWf68y76Y4n/1X2q3jGWriEPL72BgWUwV5DokrxvEcHM0sCWcJkrrTjrM
         UBjFrANsIeyH2PIpbvvIcLtN45CaVg8sVdbpATvqRgfWIbtBBU9XEl4IriusoTZw5E
         3V7CITmRzWWyuzZbwZ2JgGUw4e674EdLln8F4/oQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Graham Whaley <graham.whaley@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 34/41] vhost/vsock: fix reset orphans race with close timeout
Date:   Wed, 12 Dec 2018 23:30:47 -0500
Message-Id: <20181213043054.75891-34-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043054.75891-1-sashal@kernel.org>
References: <20181213043054.75891-1-sashal@kernel.org>
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
index c9de9c41aa97..fb14e7641e23 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -561,13 +561,21 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
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

