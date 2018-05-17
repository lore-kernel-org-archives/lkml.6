Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeEQOLF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 10:11:05 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.85]:11570 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752002AbeEQOLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 10:11:04 -0400
X-Authority-Reason: nr=8
Date: Thu, 17 May 2018 09:11:02 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 2/2] bpf: sockmap, fix double-free
Message-ID: <96e7f5e59eacddc5e32abb72b7686c3e9163a410.1526565461.git.gustavo@embeddedor.com>
References: <cover.1526565461.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1526565461.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.172.56.86
X-Source-L: No
X-Exim-ID: 1fJJcV-000DC8-I6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.172.56.86]:58230
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`e' is being freed twice.

Fix this by removing one of the kfree() calls.

Addresses-Coverity-ID: 1468983 ("Double free")
Fixes: 81110384441a ("bpf: sockmap, add hash map support")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 kernel/bpf/sockmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/sockmap.c b/kernel/bpf/sockmap.c
index 41b41fc..c682669 100644
--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -1823,7 +1823,6 @@ static int __sock_map_ctx_update_elem(struct bpf_map *map,
 	write_unlock_bh(&sock->sk_callback_lock);
 	return err;
 out_free:
-	kfree(e);
 	smap_release_sock(psock, sock);
 out_progs:
 	if (verdict)
-- 
2.7.4
