Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D86C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778E420656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="alL/pEIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfANLYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:24:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfANLYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hxJVZs5E5cqhZZjBbmbtMAt19nHoSSZSpcr7hJeAg2Y=; b=alL/pEIWiVg0fY5r5VB7ZtHs4U
        Tmju0HeoyRhGfjNebbF3/HSLq1TGyH69vAmsf23chYr2JZBgnkdaCzLBIo+D+79+uskYhuxZ0ef7j
        hOdzgNRtH1/z5k0g4nUTordV+IvS8AoIwcpVLd9DI6tPxaI7zjxBF1nLc1ORkVlVtiOhMd+350uM3
        9QGUTGJwrFrEWVph7UpANcviBdwDCNNXWojQGRRyRo7tizYOiC7KYFaohbotVSJNuoCi4I51TkDX8
        qw2Nr2/6EYrp6rt5BFeTuDjvdIIElZ3PJyLNm5pq8tCYOeFGvJ+gVaMwYpc5lWs7YhYvgGWNPjiR8
        3NhQZK2w==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gj0Lo-0006pl-5E; Mon, 14 Jan 2019 11:24:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] parisc/lba_pci: use container_of in LBA_DEV
Date:   Mon, 14 Jan 2019 12:23:52 +0100
Message-Id: <20190114112353.30616-8-hch@lst.de>
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
LBA_DEV, and turn the macro into an inline function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/parisc/lba_pci.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
index 63e9bc6d18de..065d88868402 100644
--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -111,12 +111,10 @@ static u32 lba_t32;
 
 #define LBA_SKIP_PROBE(d) ((d)->flags & LBA_FLAG_SKIP_PROBE)
 
-
-/* Looks nice and keeps the compiler happy */
-#define LBA_DEV(d) ({				\
-	void *__pdata = d;			\
-	BUG_ON(!__pdata);			\
-	(struct lba_device *)__pdata; })
+static inline struct lba_device *LBA_DEV(struct pci_hba_data *hba)
+{
+	return container_of(hba, struct lba_device, hba);
+}
 
 /*
 ** Only allow 8 subsidiary busses per LBA
-- 
2.20.1

