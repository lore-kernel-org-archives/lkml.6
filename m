Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08907C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D0C2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697103;
	bh=Cl1eTko4iUGK2WU8wbodBAejJ2Crw/a+kDLMWX2LUgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UYVW43u9jXDRDKfB0xSEZoQqnk4SnUXlE+uejFHczvwMbuwV0KdNqFC4hqSEOtcny
	 n68NedXlIgi9HKddjnT0iJXsuRky2guEHz/B9FFWZzd3TRQ1ygg9LRV6rW1Wil0m8o
	 10Gw2iuaGLc3dK5MnJQPGEwqWIn82Vox0dE/uVfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbfA1RiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:38:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:40438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729659AbfA1PyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:54:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85E062147A;
        Mon, 28 Jan 2019 15:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690854;
        bh=Cl1eTko4iUGK2WU8wbodBAejJ2Crw/a+kDLMWX2LUgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pXoMh7mWN5UIFf1PVRRUS8fdX7QBhnwVWNF85LmyV7TKd/4QOxphj1r3Sm52/KsOe
         01VcbjdoQ8NYNV/doj/vHpIM92ErBlwD6p41GUa1mZlRbcG3705M5BEEeAf/EvZKxY
         fUXey8CamPiP4zwq08rq9yrQl7NLFDGlBl52zJls=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dennis Zhou <dennis@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.20 214/304] percpu: convert spin_lock_irq to spin_lock_irqsave.
Date:   Mon, 28 Jan 2019 10:42:11 -0500
Message-Id: <20190128154341.47195-214-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dennis Zhou <dennis@kernel.org>

[ Upstream commit 6ab7d47bcbf0144a8cb81536c2cead4cde18acfe ]

From Michael Cree:
  "Bisection lead to commit b38d08f3181c ("percpu: restructure
   locking") as being the cause of lockups at initial boot on
   the kernel built for generic Alpha.

   On a suggestion by Tejun Heo that:

   So, the only thing I can think of is that it's calling
   spin_unlock_irq() while irq handling isn't set up yet.
   Can you please try the followings?

   1. Convert all spin_[un]lock_irq() to
      spin_lock_irqsave/unlock_irqrestore()."

Fixes: b38d08f3181c ("percpu: restructure locking")
Reported-and-tested-by: Michael Cree <mcree@orcon.net.nz>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Dennis Zhou <dennis@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/percpu-km.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/percpu-km.c b/mm/percpu-km.c
index 38de70ab1a0d..0f643dc2dc65 100644
--- a/mm/percpu-km.c
+++ b/mm/percpu-km.c
@@ -50,6 +50,7 @@ static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp)
 	const int nr_pages = pcpu_group_sizes[0] >> PAGE_SHIFT;
 	struct pcpu_chunk *chunk;
 	struct page *pages;
+	unsigned long flags;
 	int i;
 
 	chunk = pcpu_alloc_chunk(gfp);
@@ -68,9 +69,9 @@ static struct pcpu_chunk *pcpu_create_chunk(gfp_t gfp)
 	chunk->data = pages;
 	chunk->base_addr = page_address(pages) - pcpu_group_offsets[0];
 
-	spin_lock_irq(&pcpu_lock);
+	spin_lock_irqsave(&pcpu_lock, flags);
 	pcpu_chunk_populated(chunk, 0, nr_pages, false);
-	spin_unlock_irq(&pcpu_lock);
+	spin_unlock_irqrestore(&pcpu_lock, flags);
 
 	pcpu_stats_chunk_alloc();
 	trace_percpu_create_chunk(chunk->base_addr);
-- 
2.19.1

