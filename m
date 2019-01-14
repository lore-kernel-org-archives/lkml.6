Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE45C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A84B20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BKOUwrxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfANLYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:24:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38582 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfANLYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rwYRd+z2rpdVxb5xbqYdl+l6tXhoDRduewfCcAC9o5A=; b=BKOUwrxOuyQuG+rcZovQMzzIoB
        C0lGPMZZWbvOoJDAyXlihJdPayGvqfldy/5HL3qg4rG+NvgQ9BWjlzBnKIALWF9yHdRiacrp3EPuc
        1LY07MC3kxeQCxai2JkN9Dcq9V8dq3W1C30gnL/p9EuUZ/sI56ZGNqQRXfns9EepeyG7Zxl3SKvvg
        DkDuJIDJSAfnsmr5mAChGKeAB9V5s+Hmn3dwiXyipYyuIQspfSSYMHquWYDhmgdheThbchgFPrkDA
        m9eR3HLJ9urFuuIJ3/pDiv4Gr5KMmfpWk418JL8O7XXrJStN6AbJzoF8efEetRjuAX0s4YcmJimfn
        fqM658nw==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gj0Lc-0006ow-Fm; Mon, 14 Jan 2019 11:24:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] parisc: turn GET_IOC into an inline function
Date:   Mon, 14 Jan 2019 12:23:48 +0100
Message-Id: <20190114112353.30616-4-hch@lst.de>
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

This makes the function both more readable and more typesafe.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/parisc/iommu.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/parisc/iommu.h b/drivers/parisc/iommu.h
index c72c4fe51a3a..94d5eae98bf6 100644
--- a/drivers/parisc/iommu.h
+++ b/drivers/parisc/iommu.h
@@ -24,10 +24,14 @@ static inline void *parisc_walk_tree(struct device *dev)
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

