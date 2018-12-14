Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C46BC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C21120879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XsgLx6nz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C21120879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbeLNIZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:25:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47584 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbeLNIZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jE5kVpdlADftxEtvgMXzvTMgshsdiNRl9dZj1a7poJs=; b=XsgLx6nz6TJ8u0MUvX4EHrOUf
        yhIMJf4w/JUDi7NtOT4PsVvlH7JlKPqrfzA+alKjbmM9vKqSzVMfAAzq6yizJvLcXM9mJ5BlAtAv/
        tv4elxRLTowl3HS3G709WDZpVJqRH9v+yfl7Zpj2L/Jat1Zkj8ROZlhe3BTybedqxdztOq+jLCeAu
        c9TUYDPeK3kQZvMer2DkRHyrtLo8Dp37iKT7JIqGcgLNd7joDCDpfudSHE74H1sABgKQh7feu9E5b
        4QeFS58zw/0l3pkYUOrC4jTvfeRYA/rgC9KeC4R+FwR/jG1NnQ+ESFNKp8tfY7znRk+JfFre8EVqG
        TpQHWVo2w==;
Received: from 089144198147.atnat0007.highway.a1.net ([89.144.198.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXimb-0004l7-RB; Fri, 14 Dec 2018 08:25:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Michal Simek <monstr@monstr.eu>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-m68k@lists.linux-m68k.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Subject: ensure dma_alloc_coherent always returns zeroed memory
Date:   Fri, 14 Dec 2018 09:25:13 +0100
Message-Id: <20181214082515.14835-1-hch@lst.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For security reasons we already returned zeroed memory from
dma_alloc_coherent on most common platforms, but some implementation
missed out.  Make sure we provide a consistent behavior.
