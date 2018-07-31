Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7695C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF35208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ktSLIbm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF35208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732077AbeGaNTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:19:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43288 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731912AbeGaNTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NnXbs+3ZS/CGSdFZwLzsp6+Oqz76GR3Lf4LQ4B7iGLc=; b=ktSLIbm4s09rGsFuiVzpUPWh4
        7OouUukEUXZxRYp2hur9Jnz/zDDD0k/qbLgVrAt2+oVMRh/RrFANQqHwT8it2Uo/n3VEzOVLKcOwN
        YYE/u/0G8toYmP/7DpIka8XvIL365zKRBRzDhoX5Rkle0IzdWDXdUk7nzUZyIN4H8Mo+mHD0kw9Ae
        L4syMtza/KbvIetwYspuyOmGPvu5uFK6yd+MSa//8iI7+cur9rXofK9yopRcSQ4HBNDIyFNDyOObe
        JLNGgY5HwCSUOYQBZVOBZD4zAWr50eeh6R07jIi/tBrZQ8XPZLzN/xo2jKNNFMExDjeqK3EfvtpIm
        KKHhxzRFg==;
Received: from 089144201224.atnat0010.highway.a1.net ([89.144.201.224] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkT06-0001Hv-B0; Tue, 31 Jul 2018 11:39:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Ley Foon Tan <lftan@altera.com>,
        Michal Simek <monstr@monstr.eu>, linux-kbuild@vger.kernel.org,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: include architecture Kconfig files from top-level Kconfig v4
Date:   Tue, 31 Jul 2018 13:39:25 +0200
Message-Id: <20180731113935.6105-1-hch@lst.de>
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

Changes since v3:
 - don't allow to select PREEMPT_COUNT for architectures that don't
   implement it
 - fix usage of SUBARCH=i386 and SUBARCH=x86_64 for um

Changes since v2:
 - fix the missing sh conversion
 - handle the lack of CONFIG_SWAP support in microblaze and nios2
   properly

Changes since v1:
 - add back a remove source statement from arch/arm/Kconfig
 - various fixes from Randy
 - various UML patches to be able to use the common Kconfig
