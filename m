Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D6FC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2782924818
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CE07SxLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2782924818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752396AbeGBOrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:47:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50392 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752049AbeGBOrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RIxyoAvEXVq7ErVdn3NdwCqK/RTD/Y5WWWGe8jPXjc4=; b=CE07SxLPUpAC87sYG4CZ/H9xZ
        4oyzZaOfKhSeQPI+u+SyEnhYlIrKuHel2Byr/qhoESQq5uMDE8ijwbdDDxMoskLlb+MjSFUDO4HRz
        NVFGaxCrMV/AN9fDK22ywlnQ890JgCNHjJTxs5Q6e+t4kP9L/3vpGck+/dicITXEvZ711hA8lZGhe
        4CrmjEiR8+Q/7iGgGyjsWmFWhGcoHk9A/aZb0tmB40EH6yzOd5CjH3+I0aAifVeSx88l7PXwZhwfG
        cA6kxSOQEOTLK9wePOfOp/rjGMVYpBA4AHtwUo/ta57hns8PveJQkeBAUDW6uNqWIc3/5CWWv6abm
        vAnC/yc2w==;
Received: from [208.118.102.130] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fa06j-0000Ya-Kr; Mon, 02 Jul 2018 14:47:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: include architecture Kconfig files from top-level Kconfig
Date:   Mon,  2 Jul 2018 08:47:06 -0600
Message-Id: <20180702144711.22111-1-hch@lst.de>
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
