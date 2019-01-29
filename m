Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E10C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B461020857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W8zUlumo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfA2SNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:13:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35188 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729282AbfA2SNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:13:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GSD9JLapBWqIj3ABdywFRH0m0lA8Ni+ahzMil/WnITY=; b=W8zUlumoTZhKLGRBXkwh4iE64S
        o8q8JjBE37//KO7xfp/vBLj/S+3/AI8cbpOIdr+Cm0FPjz1gNe4tuEIScmj1AG6R6tWYv4+5yXFLd
        Ga1mK0EjCPwyiqYwpZNqJH1rWSqd4zLHrYEpJxio+W5yhhNvTCTbvzTgiXrvJ0zaZl+EFRmLlDXXf
        BiY+LNVqJbYXtIoocOS7iQeACz2G7tCModjuKESH72rDUS0WaXIY76fN57w7av5pQf8hQY1PFW4a1
        S11irsu8Ae5ZmD9F5hqnNZ7E3gxQHtLR/1S5mlNotoUlQU6a7hZ8kfYJQf0rxayoS++HWvT4zxRdt
        LrPLVQ/A==;
Received: from 213-225-35-141.nat.highway.a1.net ([213.225.35.141] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1goXt5-00083d-Ar; Tue, 29 Jan 2019 18:13:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] parisc/dino: use container_of in DINO_DEV
Date:   Tue, 29 Jan 2019 19:13:08 +0100
Message-Id: <20190129181310.5557-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129181310.5557-1-hch@lst.de>
References: <20190129181310.5557-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the type safe container_of macros instead of a blind cast in
DINO_DEV, and turn the macro into an inline function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/parisc/dino.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/parisc/dino.c b/drivers/parisc/dino.c
index 6f348c75687c..846b59d15999 100644
--- a/drivers/parisc/dino.c
+++ b/drivers/parisc/dino.c
@@ -154,12 +154,10 @@ struct dino_device
 #endif
 };
 
-/* Looks nice and keeps the compiler happy */
-#define DINO_DEV(d) ({				\
-	void *__pdata = d;			\
-	BUG_ON(!__pdata);			\
-	(struct dino_device *)__pdata; })
-
+static inline struct dino_device *DINO_DEV(struct pci_hba_data *hba)
+{
+	return container_of(hba, struct dino_device, hba);
+}
 
 /*
  * Dino Configuration Space Accessor Functions
-- 
2.20.1

