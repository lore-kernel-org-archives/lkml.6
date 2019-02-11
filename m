Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A244C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC28821773
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897156;
	bh=hAHYgthFgwlKnjZ47dHjGAhNAtWoXcnO9ByIoZhV+bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JO3QB8go7R0SUd6xh4P/g3MnBbFQ/o+hxhYaKXjqUkFwcRhiVfEYb3dzKTTxnSqPh
	 phaIALE+LG+bhYu4Do7+1/NMO5g5GT0iwLmGdABTGmwXRzownYOQr6hMoMD5ApUsv+
	 pxOcbkag6EKpmNV+Fk7ApO3obbMs3z8mMyPLzZe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389753AbfBKO7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:59:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:46928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389742AbfBKO7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:59:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DD5B206BA;
        Mon, 11 Feb 2019 14:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897150;
        bh=hAHYgthFgwlKnjZ47dHjGAhNAtWoXcnO9ByIoZhV+bc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c2M2+CoVDGH5z0A/SpkWKWFM/L+25HOzzTATFnZJUCK2hmvW+BzFAV5kJqdFv2ZjA
         Ewm9Bg0F/4bCen9N2nhpOfrf1hZ+u6r3ZiLPhKdlw1+QpZ8dcKvGPSX0apHCSQw/JB
         AvAuIIP0QbkZ4ZDM+EVe/yExjn2mGQWGnSdDXBbw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Michael Cree <mcree@orcon.net.nz>
Subject: [PATCH 4.14 107/205] percpu: convert spin_lock_irq to spin_lock_irqsave.
Date:   Mon, 11 Feb 2019 15:18:25 +0100
Message-Id: <20190211141835.549390951@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 6ab7d47bcbf0144a8cb81536c2cead4cde18acfe ]

>From Michael Cree:
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
index 0d88d7bd5706..c22d959105b6 100644
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



