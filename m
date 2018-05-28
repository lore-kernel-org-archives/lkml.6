Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968888AbeE1Kny (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937621AbeE1Knr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:43:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers3@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 060/496] ptr_ring: prevent integer overflow when calculating size
Date: Mon, 28 May 2018 11:57:25 +0200
Message-Id: <20180528100322.322739392@linuxfoundation.org>
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

From: Jason Wang <jasowang@redhat.com>

[ Upstream commit 54e02162d4454a99227f520948bf4494c3d972d0 ]

Switch to use dividing to prevent integer overflow when size is too
big to calculate allocation size properly.

Reported-by: Eric Biggers <ebiggers3@gmail.com>
Fixes: 6e6e41c31122 ("ptr_ring: fail early if queue occupies more than KMALLOC_MAX_SIZE")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/ptr_ring.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -450,7 +450,7 @@ static inline int ptr_ring_consume_batch
  */
 static inline void **__ptr_ring_init_queue_alloc(unsigned int size, gfp_t gfp)
 {
-	if (size * sizeof(void *) > KMALLOC_MAX_SIZE)
+	if (size > KMALLOC_MAX_SIZE / sizeof(void *))
 		return NULL;
 	return kvmalloc_array(size, sizeof(void *), gfp | __GFP_ZERO);
 }
