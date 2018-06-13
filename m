Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 654F8C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C9E208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cW/+Q+7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C9E208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935486AbeFMSqR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:46:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935043AbeFMSqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QLZ9jKIJE4YrHQA/ybmrY0ELKKqTJHo0QGS+Ii1RyEc=; b=cW/+Q+7SR2PtsmW9Sm0N3Fuyl
        NnWgMPBDsIhANmGuYoa0roKP/dGYj3tsKsoi/ccQ+2HJuod9QwaTtkS9uwyaLB8ayr7e+O1Fo0Q/S
        csYWqEVA2frlaeC4kK+CIdRCad/x92OhWq31ATkXTe+u4cdf8YpscXxSe3RRO5ljbBYDQje0ZnfA6
        tWg5sqQJbSvS3ZXRZCmkmUw9CKu7hUzfV3k8ceetwHGRwyNu1Ck81OPcaopM4L45fR1Tr+E7GsYCX
        yKoAv0BjsCyMiW9WSk/4T59BBoDQhjITUaGZ+tzQMibWjm9xRDkl+vx1H4j8QKkKwX7yUheQku2rz
        Jxd0ZVEyQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTAmQ-0001Tz-R6; Wed, 13 Jun 2018 18:46:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     hans.westgaard.ry@oracle.com, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-rdma@vger.kernel.org,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] IDR: Expose the XArray lock
Date:   Wed, 13 Jun 2018 11:45:55 -0700
Message-Id: <20180613184555.4503-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180613123403.25233-2-willy@infradead.org>
References: <20180613123403.25233-2-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow users of the IDR to use the XArray lock for their own
synchronisation purposes.  The IDR continues to rely on the caller to
handle locking, but this lets the caller use the lock embedded in the
IDR data structure instead of allocating their own lock.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 include/linux/idr.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index e856f4e0ab35..3e8215b2c371 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -98,6 +98,17 @@ static inline void idr_set_cursor(struct idr *idr, unsigned int val)
  * period).
  */
 
+#define idr_lock(idr)		xa_lock(&(idr)->idr_rt)
+#define idr_unlock(idr)		xa_unlock(&(idr)->idr_rt)
+#define idr_lock_bh(idr)	xa_lock_bh(&(idr)->idr_rt)
+#define idr_unlock_bh(idr)	xa_unlock_bh(&(idr)->idr_rt)
+#define idr_lock_irq(idr)	xa_lock_irq(&(idr)->idr_rt)
+#define idr_unlock_irq(idr)	xa_unlock_irq(&(idr)->idr_rt)
+#define idr_lock_irqsave(idr, flags) \
+				xa_lock_irqsave(&(idr)->idr_rt, flags)
+#define idr_unlock_irqrestore(idr, flags) \
+				xa_unlock_irqrestore(&(idr)->idr_rt, flags)
+
 void idr_preload(gfp_t gfp_mask);
 
 int idr_alloc(struct idr *, void *ptr, int start, int end, gfp_t);
-- 
2.17.1

