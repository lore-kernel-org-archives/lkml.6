Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F76BC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E724A20857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h9nnQF0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfA2SN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:13:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35150 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfA2SNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3EpTLPTe7MxqR7rhIW83gWtXzmEP4UKkgI2JifEq9Rc=; b=h9nnQF0QAAvN7pvGRn62DMEsNk
        AxSGH6uiqzCT/H1UNvdMnvEj0gGKRwMMFNDhRhSf70lKsuir2NIE0OeJ4/Jxw4jLeTzm+qj4ROl2d
        lbXbGHhBCCwVzVF3eq2dotCD7QXeCtKcmJMKpIOZ5LuLcdEWSJ5hmRUZ/yW6kQV/D1S27no21yZ/u
        3dlvDQaNSVckyWD89eyhjQElAeReT15XqJIyiSgjtfJWIoDn5wGcMjKpzeZ3M3ezUMxavWG7WpSjo
        7GUR1IAC5dodo3ogK5uIA2Djeg7UC6flP+eZ7ieu8kcbNEDA4QI0ZCp8cdRo82WPNOQwtNTkGCzBe
        GTeQgIfg==;
Received: from 213-225-35-141.nat.highway.a1.net ([213.225.35.141] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1goXsw-00082N-Qx; Tue, 29 Jan 2019 18:13:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] parisc: turn GET_IOC into an inline function
Date:   Tue, 29 Jan 2019 19:13:05 +0100
Message-Id: <20190129181310.5557-4-hch@lst.de>
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

This makes the function both more readable and more typesafe.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/parisc/iommu.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/parisc/iommu.h b/drivers/parisc/iommu.h
index 5a38b635e963..d6fd3ab899ac 100644
--- a/drivers/parisc/iommu.h
+++ b/drivers/parisc/iommu.h
@@ -26,10 +26,14 @@ static inline void *parisc_walk_tree(struct device *dev)
 	return dev->platform_data;
 }
 
-#define GET_IOC(dev) ({					\
-	void *__pdata = parisc_walk_tree(dev);		\
-	__pdata ? HBA_DATA(__pdata)->iommu : NULL;	\
-})
+static inline struct ioc *GET_IOC(struct device *dev)
+{
+	struct pci_hba_data *pdata = parisc_walk_tree(dev);
+
+	if (!pdata)
+		return NULL;
+	return pdata->iommu;
+}
 
 #ifdef CONFIG_IOMMU_CCIO
 void *ccio_get_iommu(const struct parisc_device *dev);
-- 
2.20.1

