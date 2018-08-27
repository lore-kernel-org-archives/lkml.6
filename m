Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A4EC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A18C208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c6J0eJjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A18C208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeH0MdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:33:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46616 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0MdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2KHGdxgp6qS5gq8kWhg6ykhiXOOXyyB0M/xH6sXjY38=; b=c6J0eJjIZUBqVoKwvxRNmpL/B
        OXXQtZodHledb90MT9mssZMjpz+a5UR6q7Dbi1O4rMumR+52Ui1btMujZqXD/h1r8dFnlXytu1sF1
        5qIlCEhKDSPJKmnu3ioKMmG4UYdjvBuIh9/do94rDishsQck52ErHcFwmDxYS0c1ns6RbVHM8p28e
        NpHRv6f9rxdB4p6qBt8V2m67Pl5MixTfAxeNOvqUXlQM3lIL4NgCzt431AgWzomKudAob1lh9iv1c
        OPqmRk6jQFLz9my3ndh9VKbnVgnqNGQlWgegGwMl1vsT3Ca8b/scUDXjeGuPo9jR5x5/W0eEs66eF
        jUP5UUqUg==;
Received: from 213-225-1-219.nat.highway.a1.net ([213.225.1.219] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuDB4-0002Kg-BM; Mon, 27 Aug 2018 08:47:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: cleanup ->dma_configure calling conventions
Date:   Mon, 27 Aug 2018 10:47:07 +0200
Message-Id: <20180827084711.23407-1-hch@lst.de>
X-Mailer: git-send-email 2.18.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series cleans up a bit how we call ->dma_configure and how
we clean up after tearing down a device that the method did set
up.
