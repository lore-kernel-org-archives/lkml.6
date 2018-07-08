Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA03FC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 15:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82571208A2
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 15:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z6A2roSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82571208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932860AbeGHPUL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 11:20:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52062 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932153AbeGHPUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 11:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qMbG7zNWDrQQptyNWNKGUogqVpJud0/U1/RNlfy3pI8=; b=Z6A2roSi5QfFu/n+s1jMcIsh1
        CFGpY/vaBT+UxubH7EGaoz+ZwustCqUq8pi7ajR32Zg1/GPpCcWAlnVewFyiqM7ZjRgrK2veLtJFl
        3Te2a4FiLP5eiywrLZN8eo6iVTcY2qohULwYRc9JFERzUEaDxNwlslAenHBeiosRYBiyfPOwj70e+
        AP+RkkAFr4FLYgP8rnlmVYiEZLRBOm9oIxkDQ/tR6PXPPFqiuOu98USy2M+w70X+Hj1I90ULWR0KH
        2OiGCQCY2Fyg19haFEfEsNb6lA0YypIPO3YrND65F1B77toIfHAlomjN27zZR6Wt4FF9Q0zL3EJBe
        VKmVLz5pg==;
Received: from ip-64-134-140-74.public.wayport.net ([64.134.140.74] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcBTp-0002ce-1x; Sun, 08 Jul 2018 15:20:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-kbuild@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: include architecture Kconfig files from top-level Kconfig v2
Date:   Sun,  8 Jul 2018 08:19:55 -0700
Message-Id: <20180708152004.21679-1-hch@lst.de>
X-Mailer: git-send-email 2.18.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

what do you think about the series below, which moves the includes
of all the architecture independ Kconfig files to the top-level
Kconfig instead of duplicating the includes in all architectures?

Note that this only handles the low-hanging fruite, there are a lot
of other bits that should probably be cleaned up to be common,
but those will be not entirely trivial.

Changes since v1:
 - add back a remove source statement from arch/arm/Kconfig
 - various fixes from Randy
 - various UML patches to be able to use the common Kconfig
