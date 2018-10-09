Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A44C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A7E21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LqA3Leyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A7E21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeJIWOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:14:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43262 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJIWOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GMdRLubk4nflqLTkT0d/aRmd7FLJSM95/1iMCmPCd+w=; b=LqA3LeywUBT9puPnUKf4vBD7F
        OiOLPkT1oaQRJ1LcLNVHhrnlylkeLWE19tRA1Roqp9AD7qgs/kni6cqysbsB/jwSvDyBBmvr0nNy3
        /SfRs58YS7jKxpVHtYzvavSCtnWLiJgO492c2lFOU2hufbQBiSJKC0lg1TaTFrruv1oRHcpvqRGZ8
        qbx01iie1FLY1y9W/A6ZJAV7g3vZ7XOlZ4fJzzksm1i/Hw6OHYrKM+hBRz8kXdIde+ziK7nq9WJWT
        DYmdwgDsTTGs4QjcNFtWivr4beRv9NdQv4+uHG20yBdoL15+2NA1DTmynRsgSrNT0BqsnQ0lVOgpg
        nc9NLddkA==;
Received: from 089144207060.atnat0016.highway.bob.at ([89.144.207.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9tRq-0001YT-IA; Tue, 09 Oct 2018 14:57:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chas Williams <3chas3@gmail.com>, netdev@vger.kernel.org
Cc:     linux-atm-general@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: fore200e DMA cleanups and fixes
Date:   Tue,  9 Oct 2018 16:57:13 +0200
Message-Id: <20181009145720.32578-1-hch@lst.de>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fore200e driver came up during some dma-related audits, so
here is the fallout.  Compile tested (x86 & sparc) only.
