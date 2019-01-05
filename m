Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C89C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 08:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4933F2063F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 08:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pRKcL6TJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfAEIBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 03:01:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48818 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfAEIBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 03:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bfBaSznlY6cW+SmB13FjMBhNJc2hhTP0V2u+8qNXe4I=; b=pRKcL6TJc+yCcPzmORLxoR+p5
        ntTthH4emAtjQtRul3rWcWYqJ/+YmfIgwy18EkLFYjfaQxN4F23U8ecXCAKWmo0M9jt03NZdN7wrc
        lLMFY+a9vUG+5lymtu7OCHEKeOtGRQfj4ljHaDtwDzLC287vQEQSROd990ZeciMIMC6jbMcoltPrg
        Ig/XK+KACFb7YDdJ0CMdzJ5kHHiA/ZYMaWkbYu+6Y5FrDywe1RdIa7pnWJOgM9JXcm9XIejXoLKd1
        RXQFDl7XCy4cpU8w1XAwPdQqPGYBNl3eUXYVbiw7w8NOkR3BU7zOJUOTnUFzBn0qGGUdPNVfv/7MG
        cfAFZaw4g==;
Received: from 089144213048.atnat0022.highway.a1.net ([89.144.213.48] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gfgtM-0000Is-CN; Sat, 05 Jan 2019 08:01:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     thellstrom@vmware.com
Cc:     linux-graphics-maintainer@vmware.com,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: fix DMA ops layering violations in vmwgfx
Date:   Sat,  5 Jan 2019 09:01:04 +0100
Message-Id: <20190105080108.14837-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

vmwgfx has been doing some odd checks based on DMA ops which rely
on deep DMA mapping layer internals, and I think the changes in
Linux 4.21 finally broke most of these implicit assumptions.

The real fix is in patch 3, but I think the others are important
to make it clear what is actually going on.
