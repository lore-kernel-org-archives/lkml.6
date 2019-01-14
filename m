Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A68C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A454920656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YQE73UDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfANLYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:24:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38612 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfANLYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:24:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GSD9JLapBWqIj3ABdywFRH0m0lA8Ni+ahzMil/WnITY=; b=YQE73UDb8Y0GMPdlkC7x2EAgxO
        S1vtF+JlOotjnAP06srMWRFXHs8vFG7uSJpMX1LjCkwg77k2cxzKqRrcQkj5sJc/19RxW90t9rdoa
        vsYc1UgNsvMXUrZCpI5ge1MhbKmFbJc06LYAL/4m8qJAyq26fGyEnaelb9zOfQN4g6BGIwmsuQE8o
        bALXov3Zg8Uyqc01P3sL+An5tkLGXrdQEZIFuYCtVhWoUyynLNEKpN/8IEduCrq+X7cLlFBmXuoZR
        e3p/i65bT8JRssB278EjPgsPeolwCZVgU6x1SjZyLHYhvvGzKHQvRbHFlXpg6uPfVX1UBRnzvDHwv
        NsqOHiqw==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gj0Ll-0006pc-9X; Mon, 14 Jan 2019 11:24:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] parisc/dino: use container_of in DINO_DEV
Date:   Mon, 14 Jan 2019 12:23:51 +0100
Message-Id: <20190114112353.30616-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114112353.30616-1-hch@lst.de>
References: <20190114112353.30616-1-hch@lst.de>
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

