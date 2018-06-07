Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id WYK6ASc0GVvEUAAAmS7hNA
	; Thu, 07 Jun 2018 13:38:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 07539608BF; Thu,  7 Jun 2018 13:38:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 89B196089E;
	Thu,  7 Jun 2018 13:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89B196089E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932769AbeFGNhk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:37:40 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:44220 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932586AbeFGNhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:37:38 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id vpdc1x00C3XaVaC01pdcYe; Thu, 07 Jun 2018 15:37:37 +0200
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fQv6e-0000CV-1x; Thu, 07 Jun 2018 15:37:36 +0200
Received: from geert by ramsan with local (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fQv6d-0000Od-VM; Thu, 07 Jun 2018 15:37:35 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "David S . Miller" <davem@davemloft.net>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        netdev@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] xsk: Fix umem fill/completion queue mmap on 32-bit
Date: Thu,  7 Jun 2018 15:37:34 +0200
Message-Id: <1528378654-1484-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc-4.1.2 on 32-bit:

    net/xdp/xsk.c:663: warning: integer constant is too large for ‘long’ type
    net/xdp/xsk.c:665: warning: integer constant is too large for ‘long’ type

Add the missing "ULL" suffixes to the large XDP_UMEM_PGOFF_*_RING values
to fix this.

    net/xdp/xsk.c:663: warning: comparison is always false due to limited range of data type
    net/xdp/xsk.c:665: warning: comparison is always false due to limited range of data type

"unsigned long" is 32-bit on 32-bit systems, hence the offset is
truncated, and can never be equal to any of the XDP_UMEM_PGOFF_*_RING
values.  Use loff_t (and the required cast) to fix this.

Fixes: 423f38329d267969 ("xsk: add umem fill queue support and mmap")
Fixes: fe2308328cd2f26e ("xsk: add umem completion queue support and mmap")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Compile-tested only.
---
 include/uapi/linux/if_xdp.h | 4 ++--
 net/xdp/xsk.c               | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index 1fa0e977ea8d0224..caed8b1614ffc0aa 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -63,8 +63,8 @@ struct xdp_statistics {
 /* Pgoff for mmaping the rings */
 #define XDP_PGOFF_RX_RING			  0
 #define XDP_PGOFF_TX_RING		 0x80000000
-#define XDP_UMEM_PGOFF_FILL_RING	0x100000000
-#define XDP_UMEM_PGOFF_COMPLETION_RING	0x180000000
+#define XDP_UMEM_PGOFF_FILL_RING	0x100000000ULL
+#define XDP_UMEM_PGOFF_COMPLETION_RING	0x180000000ULL
 
 /* Rx/Tx descriptor */
 struct xdp_desc {
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index c6ed2454f7ce55e8..36919a254ba370c3 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -643,7 +643,7 @@ static int xsk_getsockopt(struct socket *sock, int level, int optname,
 static int xsk_mmap(struct file *file, struct socket *sock,
 		    struct vm_area_struct *vma)
 {
-	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
+	loff_t offset = (loff_t)vma->vm_pgoff << PAGE_SHIFT;
 	unsigned long size = vma->vm_end - vma->vm_start;
 	struct xdp_sock *xs = xdp_sk(sock->sk);
 	struct xsk_queue *q = NULL;
-- 
2.7.4
