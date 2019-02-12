Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A040C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B42218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YmGv8ftb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfBLHZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:25:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57438 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfBLHZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Wb7pnV+3i3FZaLJjfmv79H1IFHU+FXfS4Y6ElAo+9f8=; b=YmGv8ftbRoignSga5vqiPDpxb
        Okwynf50WQMML/zWaGKeBMO7U4d6sKkpOn96F7MRQ/WJ7YNowWJN9faZqJDXW8GWSyBUslz8tubxA
        sjQdqYsjMytrxxnCFC5jNKqj573yEN3SfNQOcVDOCSNUrJQSo1MTaJU3OxB6OjpVGCsF/dMTGhdGH
        2jofUVapbjClkO93N34YuFQhPxVb+afWu2uCx0t/+qvtnZIyzpejTYmgBV0G9ZkVAWJ8nVUC7aGTs
        t9GBSqXoelKhw0USKKT+Kkx6KWZXLUeV7mqJ1qEhy4M6n62b3scjSETirCIP32WHJs3XWwv0+QSjg
        m5+QXlCrg==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtSRf-0002O7-4N; Tue, 12 Feb 2019 07:25:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: remove block layer bounce buffering for MMC v2
Date:   Tue, 12 Feb 2019 08:25:14 +0100
Message-Id: <20190212072528.13167-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

this series converts the remaining MMC host drivers to properly kmap the
scatterlist entries it does PIO operations on, and then goes on to
remove the usage of block layer bounce buffering (which I plan to remove
eventually) from the MMC layer.

As a bonus I've converted various drivers to the proper scatterlist
helpers so that at least in theory they are ready for chained
scatterlists.

All the changes are compile tested only as I don't have any of the
hardware, so a careful review would be appreciated.

Changes since v1:
 - fix a missing kunmap_atomic in mvsdio
 - fix a stray whitespace in s3cmci
 - add new sg_kmap_atomic and sg_kunmap_atomic helpers
 - set the DMA and block layer dma boundary
 - use pointer arithmetics to reduce the amount of changes in
   various drivers

