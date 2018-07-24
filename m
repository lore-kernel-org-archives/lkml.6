Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299A5C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41C6204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hP6XpALt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41C6204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388475AbeGXNIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:08:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54838 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388241AbeGXNIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+5kbt/k6sjr36qB4SzZX6ywfLvIyjI+q/ZtVHYrYIEQ=; b=hP6XpALtXwy4PRSrR//C6Bk8v
        4U+bznHTDGYDZKsnAd/svQS628Fo+400cwaoVfN4WBZGgj/20FcqUcJGa4Ta6HStHjTxhlw2/IYHK
        7BsqsWNsgUlnjzf2+43m2tf+ZNUQ0rhOWFImXEJG/MAWIz6Oo0DciJ8IR1g8GeyagpCVaHjxrYqqd
        NxTK8R2X7zAMF5quhKr0H0v4RsMKZLnCDYp6jJDurDKjJRjGRJtE3riNSYs9VIXEU/VAEdD6osomu
        jquICNdljV/NzqGBtLzYfKl+ENfoEK+KkRApLkRIyMmanSHM01yVGSvhgQUgqe93ECcot1P3OT2j6
        KhghEgxcQ==;
Received: from 089144194224.atnat0003.highway.a1.net ([89.144.194.224] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhw0k-0001VV-22; Tue, 24 Jul 2018 12:01:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        linux-sh@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: use the generic dma-noncoherent code for sh V2
Date:   Tue, 24 Jul 2018 14:01:42 +0200
Message-Id: <20180724120147.15096-1-hch@lst.de>
X-Mailer: git-send-email 2.18.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

can you review these patches to switch sh to use the generic
dma-noncoherent code?  All the requirements are in mainline already
and we've switched various architectures over to it already.

Changes since V1:
 - fixed two stupid compile errors and verified them using a local
   cross toolchain instead of the 0day buildbot
