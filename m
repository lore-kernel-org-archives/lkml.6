Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A706ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DDB2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETKH021w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36DDB2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731626AbeKIHmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:42:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:34842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728790AbeKIHmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:42:47 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D58322086C;
        Thu,  8 Nov 2018 22:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714716;
        bh=x7g0PcWDMmWKp0EiuVs1vokctitPjGao4afGn1b6NBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ETKH021wPARl7us1c4B76nps/xa9F5Jlx+7B5vv91HX23vI+dUJUCWJH2s8qEfw1z
         aJKb3YfcEQImluOJtr1F3g+2cUidxE+PAMhDOb+mlGUkJyspBhY8BVV8EVlUx77Ygn
         9K0sU2UZ6RP7Up4zguL6I+ozH+MnE/iXmnvlg57E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 083/171] ptr_ring: fix up after recent ptr_ring changes
Date:   Thu,  8 Nov 2018 13:50:53 -0800
Message-Id: <20181108215133.522643936@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



