Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E36C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E002083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550787286;
	bh=GDzXP+vewXnT/BOaTfeEpZjSyVo4KGn6DfNms2wc0+A=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Ef+1+0uXAXo+qZkEWMNdwav3shcq4d17CmwFiXmmlozwux2eZCn9yrV6sSUP7tqhS
	 QW/abpC7LZ7xCguZZXfmJfMr1DsTG+RbRjlhCmJdZObs4y0e59X3QkWJLq6iv5D6RX
	 zRmj7k04dDjAcVQbjC4oPHLqUG3/1GkWfrWBExmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfBUWOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:14:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:46132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfBUWOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:14:44 -0500
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5034C20818;
        Thu, 21 Feb 2019 22:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550787283;
        bh=GDzXP+vewXnT/BOaTfeEpZjSyVo4KGn6DfNms2wc0+A=;
        h=From:To:Cc:Subject:Date:From;
        b=m1rkYksyangNn476aVbGORvImpfvrRpcLoM4WbhbjBE38KoqNn2ZHxw8Nu0HbfoC9
         1X5+KdtE3hz/nAY8oz5wV2wkG7qUjrvn97NzAesqw8furxkdgXHrm6+94v6B9iWhUg
         WnsZWvTCFKe0f0iZWfwqKYYGXWBZHoJnvLPjpbuw=
From:   Eric Biggers <ebiggers@kernel.org>
To:     netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Mao Wenan <maowenan@huawei.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH net] net: socket: set sock->sk to NULL after calling proto_ops::release()
Date:   Thu, 21 Feb 2019 14:13:56 -0800
Message-Id: <20190221221356.173485-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Commit 9060cb719e61 ("net: crypto set sk to NULL when af_alg_release.")
fixed a use-after-free in sockfs_setattr() when an AF_ALG socket is
closed concurrently with fchownat().  However, it ignored that many
other proto_ops::release() methods don't set sock->sk to NULL and
therefore allow the same use-after-free:

    - base_sock_release
    - bnep_sock_release
    - cmtp_sock_release
    - data_sock_release
    - dn_release
    - hci_sock_release
    - hidp_sock_release
    - iucv_sock_release
    - l2cap_sock_release
    - llcp_sock_release
    - llc_ui_release
    - rawsock_release
    - rfcomm_sock_release
    - sco_sock_release
    - svc_release
    - vcc_release
    - x25_release

Rather than fixing all these and relying on every socket type to get
this right forever, just make __sock_release() set sock->sk to NULL
itself after calling proto_ops::release().

Reproducer that produces the KASAN splat when any of these socket types
are configured into the kernel:

    #include <pthread.h>
    #include <stdlib.h>
    #include <sys/socket.h>
    #include <unistd.h>

    pthread_t t;
    volatile int fd;

    void *close_thread(void *arg)
    {
        for (;;) {
            usleep(rand() % 100);
            close(fd);
        }
    }

    int main()
    {
        pthread_create(&t, NULL, close_thread, NULL);
        for (;;) {
            fd = socket(rand() % 50, rand() % 11, 0);
            fchownat(fd, "", 1000, 1000, 0x1000);
            close(fd);
        }
    }

Fixes: 86741ec25462 ("net: core: Add a UID field to struct sock.")
Cc: <stable@vger.kernel.org> # v4.10+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---

NOTE: I am not an expert in the networking code, so please carefully
check that I haven't missed some reason why this simple fix won't do.

 net/socket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/socket.c b/net/socket.c
index d80d87a395ea..320f51b22b19 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -577,6 +577,7 @@ static void __sock_release(struct socket *sock, struct inode *inode)
 		if (inode)
 			inode_lock(inode);
 		sock->ops->release(sock);
+		sock->sk = NULL;
 		if (inode)
 			inode_unlock(inode);
 		sock->ops = NULL;
-- 
2.21.0.rc0.258.g878e2cd30e-goog

