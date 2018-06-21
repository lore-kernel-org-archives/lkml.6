Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5905C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5AA223E7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A7NrMiN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5AA223E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933782AbeFUVaM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:30:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41882 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934006AbeFUV3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EN+3nD/qkYtsCpyrBJQJHos/PxRh9YXP5by2XKfq/1Y=; b=A7NrMiN9CBkS8Ge8q6QN/nBAD
        XgUyzPMSVPdEv066QgRq4iNiC49SEJOSJGWfomrh4BpaYEWsbnezypgDc4YPh6yxQxn9OybHaNau7
        PhizBI1hvbTmzBv06uhaBxrZZkm0IhiNh+waOfDKf8S1X+3hobeKUa4eo34umSSkQqxFJTL7Qs3jV
        /47TmUhqZYbk6cpPyJRcsurCmlNNISTte8+1meQfKSOvy55p+Iuw2l1d784WXjkRI9Zcx7yRaZIw2
        W8FS8RDdGuSi1vXajEuwevPEke8zoYErNBTGV+Ndtd01NxbK5bj0ONE2UMZUapmJM7LKVX/hqhsZc
        2u7vbaSjg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78f-0001c0-J4; Thu, 21 Jun 2018 21:29:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 15/26] ppc: Convert vas ID allocation to new IDA API
Date:   Thu, 21 Jun 2018 14:28:24 -0700
Message-Id: <20180621212835.5636-16-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes a custom spinlock and simplifies the code.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 arch/powerpc/platforms/powernv/vas-window.c | 26 ++++-----------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index ff9f48812331..2a5e68a2664d 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -515,35 +515,17 @@ int init_winctx_regs(struct vas_window *window, struct vas_winctx *winctx)
 	return 0;
 }
 
-static DEFINE_SPINLOCK(vas_ida_lock);
-
 static void vas_release_window_id(struct ida *ida, int winid)
 {
-	spin_lock(&vas_ida_lock);
-	ida_remove(ida, winid);
-	spin_unlock(&vas_ida_lock);
+	ida_free(ida, winid);
 }
 
 static int vas_assign_window_id(struct ida *ida)
 {
-	int rc, winid;
-
-	do {
-		rc = ida_pre_get(ida, GFP_KERNEL);
-		if (!rc)
-			return -EAGAIN;
-
-		spin_lock(&vas_ida_lock);
-		rc = ida_get_new(ida, &winid);
-		spin_unlock(&vas_ida_lock);
-	} while (rc == -EAGAIN);
-
-	if (rc)
-		return rc;
+	int winid = ida_alloc_max(ida, VAX_WINDOWS_PER_CHIP, GFP_KERNEL);
 
-	if (winid > VAS_WINDOWS_PER_CHIP) {
-		pr_err("Too many (%d) open windows\n", winid);
-		vas_release_window_id(ida, winid);
+	if (winid == -ENOSPC) {
+		pr_err("Too many (%d) open windows\n", VAX_WINDOWS_PER_CHIP);
 		return -EAGAIN;
 	}
 
-- 
2.17.1

