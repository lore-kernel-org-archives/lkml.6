Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937782AbeE1Kp6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:45:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162593AbeE1Kpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:45:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Boris Pismenny <borisp@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 075/496] tls: retrun the correct IV in getsockopt
Date: Mon, 28 May 2018 11:57:40 +0200
Message-Id: <20180528100322.933116268@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Pismenny <borisp@mellanox.com>

[ Upstream commit a1dfa6812b682eef750412dd5a90e7d38d7af068 ]

Current code returns four bytes of salt followed by four bytes of IV.
This patch returns all eight bytes of IV.

fixes: 3c4d7559159b ("tls: kernel TLS support")
Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_main.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -299,7 +299,8 @@ static int do_tls_getsockopt_tx(struct s
 			goto out;
 		}
 		lock_sock(sk);
-		memcpy(crypto_info_aes_gcm_128->iv, ctx->iv,
+		memcpy(crypto_info_aes_gcm_128->iv,
+		       ctx->iv + TLS_CIPHER_AES_GCM_128_SALT_SIZE,
 		       TLS_CIPHER_AES_GCM_128_IV_SIZE);
 		release_sock(sk);
 		if (copy_to_user(optval,
