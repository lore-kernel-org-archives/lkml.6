Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5BCC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630372064A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQcJRa9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630372064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbeJYWsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728255AbeJYWsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:39 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD92620834;
        Thu, 25 Oct 2018 14:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476942;
        bh=Kw2iZZ6h0mKvEzC7A4o4H3W9BeE/lbRO153/dyVuR+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQcJRa9We5qmWQBi/0CuSmo2qk7AzclN10ju5qbvnT/CSyzna997J01GBbjqE0Kia
         5rpjrvpXKOlcNV/+su6K0468pMO8+DxGtx232syCUSwUwwFcIagK120PvFNERyixgG
         LNLt4cblLAG0EcIXbQ30zl9ypFf6nc/G0Mia7lmU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 53/98] ptr_ring: fix up after recent ptr_ring changes
Date:   Thu, 25 Oct 2018 10:13:38 -0400
Message-Id: <20181025141423.213774-53-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>

[ Upstream commit 5790eabc6e7c3ce2d6ca2e3bbf4de467ce2b64b3 ]

Add more stubs to make it build.

Fixes: 81fbfe8a ("ptr_ring: use kmalloc_array()")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/virtio/ringtest/ptr_ring.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/tools/virtio/ringtest/ptr_ring.c b/tools/virtio/ringtest/ptr_ring.c
index 635b07b4fdd3..b4a2e6af515f 100644
--- a/tools/virtio/ringtest/ptr_ring.c
+++ b/tools/virtio/ringtest/ptr_ring.c
@@ -15,24 +15,41 @@
 #define unlikely(x)    (__builtin_expect(!!(x), 0))
 #define likely(x)    (__builtin_expect(!!(x), 1))
 #define ALIGN(x, a) (((x) + (a) - 1) / (a) * (a))
+#define SIZE_MAX        (~(size_t)0)
+
 typedef pthread_spinlock_t  spinlock_t;
 
 typedef int gfp_t;
-static void *kmalloc(unsigned size, gfp_t gfp)
-{
-	return memalign(64, size);
-}
+#define __GFP_ZERO 0x1
 
-static void *kzalloc(unsigned size, gfp_t gfp)
+static void *kmalloc(unsigned size, gfp_t gfp)
 {
 	void *p = memalign(64, size);
 	if (!p)
 		return p;
-	memset(p, 0, size);
 
+	if (gfp & __GFP_ZERO)
+		memset(p, 0, size);
 	return p;
 }
 
+static inline void *kzalloc(unsigned size, gfp_t flags)
+{
+	return kmalloc(size, flags | __GFP_ZERO);
+}
+
+static inline void *kmalloc_array(size_t n, size_t size, gfp_t flags)
+{
+	if (size != 0 && n > SIZE_MAX / size)
+		return NULL;
+	return kmalloc(n * size, flags);
+}
+
+static inline void *kcalloc(size_t n, size_t size, gfp_t flags)
+{
+	return kmalloc_array(n, size, flags | __GFP_ZERO);
+}
+
 static void kfree(void *p)
 {
 	if (p)
-- 
2.17.1

