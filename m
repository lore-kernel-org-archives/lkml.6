Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C05C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D6B2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GU66zt5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D6B2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbeH2KTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 06:19:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56126 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeH2KTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 06:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AU+0o4ZqGSuN33LgAhFi1hYREFjJ0mquI4z5jyTQnB8=; b=GU66zt5d1a+VfzVCdwcwjey19
        2EEktFpeRD+OmNGUt3hAtN1vCL5DdVK+5psB6gP4XMBzrCpl1dyCoyHVe1jLCRuKm8p8sfN3+1HqK
        woJiy4/JeCRC2V9lx0hrnVAQVIRB+TbLffEr3HLYsyCGOut2HaC6/3bxAVi0Uh6O3bthEV0RSfJaR
        J0hk6+Of3+MKjgEy6IFHQLvZfyT6iCHVr0GaiDc5iu9X71m8ijBytUld5NZn85TvNTdOyA+Ug+sch
        IuOaUCmyNr5lqQjDyjk+Z9v501dCbjyqEG5ijh4j/7S9Ea6/av0atOmpNPP0NUad3j/ZCZ+B0sooR
        8Rvm6N4/w==;
Received: from 213-225-12-4.nat.highway.a1.net ([213.225.12.4] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1futtd-0002ie-0z; Wed, 29 Aug 2018 06:24:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Robin Murphy <robin.murphy@arm.com>, Meelis Roos <mroos@linux.ee>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: various dma_mask fixups
Date:   Wed, 29 Aug 2018 08:23:58 +0200
Message-Id: <20180829062401.8701-1-hch@lst.de>
X-Mailer: git-send-email 2.18.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warnings and regressions from requiring a dma mask.
