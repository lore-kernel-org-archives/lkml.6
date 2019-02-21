Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ED6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8643C20700
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760328;
	bh=an5e/waE/0V5d4yvzSbu+QJ684pB+xBis5on7LLVYZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iBoqLav1q4pDr99lNKzwajwlpt01g/p5hdsQ8nHTvyurMMAkoAfAWeDziVqL8RW5G
	 CFM+Rq9rMx4Tfhr6FZlMsz3mEQW0rfXRdsbDRf9wRu+AxR4lIJLqt/DiK45TCpirj2
	 gAC6CZRslKRIcYwyt9ufl7No/XRNYN9qsJCAAJGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbfBUOp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:45:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:38616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729611AbfBUOm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:42:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6B272080D;
        Thu, 21 Feb 2019 14:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760177;
        bh=an5e/waE/0V5d4yvzSbu+QJ684pB+xBis5on7LLVYZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i5eE0l7KIfLG95vzyK/uLX11VtifIur3Kh7eH/1UDgh9PXjE+ZdacucX7ZXvfurCD
         l7GpCKBZJo3G15pWVaE+4rOMMAyi++6+EF6EsGNXeP5tBaEKjSQfSCRelcZ1Rt6g9l
         aC8zB9PUSTm1nY+YeKstqOCfWgVt9Z+X/92Yt5l8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 20/32] net: Do not allocate page fragments that are not skb aligned
Date:   Thu, 21 Feb 2019 15:36:08 +0100
Message-Id: <20190221125252.077051999@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125250.855065214@linuxfoundation.org>
References: <20190221125250.855065214@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 3bed3cc4156eedf652b4df72bdb35d4f1a2a739d ]

This patch addresses the fact that there are drivers, specifically tun,
that will call into the network page fragment allocators with buffer sizes
that are not cache aligned. Doing this could result in data alignment
and DMA performance issues as these fragment pools are also shared with the
skb allocator and any other devices that will use napi_alloc_frags or
netdev_alloc_frags.

Fixes: ffde7328a36d ("net: Split netdev_alloc_frag into __alloc_page_frag and add __napi_alloc_frag")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skbuff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index eebc3106d30ef..fc3d652a2de0c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -353,6 +353,8 @@ static void *__netdev_alloc_frag(unsigned int fragsz, gfp_t gfp_mask)
  */
 void *netdev_alloc_frag(unsigned int fragsz)
 {
+	fragsz = SKB_DATA_ALIGN(fragsz);
+
 	return __netdev_alloc_frag(fragsz, GFP_ATOMIC);
 }
 EXPORT_SYMBOL(netdev_alloc_frag);
@@ -366,6 +368,8 @@ static void *__napi_alloc_frag(unsigned int fragsz, gfp_t gfp_mask)
 
 void *napi_alloc_frag(unsigned int fragsz)
 {
+	fragsz = SKB_DATA_ALIGN(fragsz);
+
 	return __napi_alloc_frag(fragsz, GFP_ATOMIC);
 }
 EXPORT_SYMBOL(napi_alloc_frag);
-- 
2.19.1



