Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42570C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12B520844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MjVKjjSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12B520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbeGaTBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:01:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46346 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729636AbeGaTBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4bbQJLEk+Yv/+9YLqko8+/BHk7PnNApUvBBAbS/hd8A=; b=MjVKjjSaxOEKA7fJvYzQ6nUnW
        Gkjs/2yR66HUDz7c53jCMd5kV0nBl3rfDsFxVEkEAqCCKr9l6zupwKPDdpKzCZeS2utrcVhdczccR
        uyPVk94DOudexnLd2KINLJhoA41vAXZzFnH4ANxVzmZUZ49jw3MlB7WQ7+iyGQF3lz1BSYGwvhYsJ
        ucEVPAGpTAYMzWSaeTlx+Y73TxUroQ9XMqJq/FJ2Ibi8ogCwY6PFfefXLpasU6ilmS4RoszhQQpKw
        mZTy1JJMwczxH4e0MwVMLC7N4SdIiYr6lOi5iOHp/2iTkdiM101x6AtVQxp0j/u9IIM1/k0cm7hpI
        bFFcyS/uw==;
Received: from 089144203113.atnat0012.highway.a1.net ([89.144.203.113] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkYK2-0002I9-Rz; Tue, 31 Jul 2018 17:20:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     Sinan Kaya <okaya@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: barriers vs I/O and DMA for ia64
Date:   Tue, 31 Jul 2018 19:20:30 +0200
Message-Id: <20180731172031.4447-1-hch@lst.de>
X-Mailer: git-send-email 2.18.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

please review these patches carefully - ia64 currenly seems to be
the odd one out in terms of barrier placement for DMA and I/O and
this patch tries to resolve it.  But I don't have any IA64 hardware
nor do I know the architecture to well, so don't blindly trust me.
