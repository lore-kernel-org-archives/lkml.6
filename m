Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC04ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D55E2150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J9OmCqRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D55E2150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389289AbeIUMsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 08:48:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37444 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUMsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 08:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SgClKKoWTdXoO2FwFm/OdPM91viQY43FkatOYhXrcS4=; b=J9OmCqRdBTM95oq5ed2hfkY6e
        X1C0FeHjTEu8iANcexIBvIcKkjeVrcJ9wxUhyxRJqfEUeQJ8ZucqWgfKN7zouy8wIQJ7N91HeJweh
        MNeY1qXxh177/uCm2pRZnMq9jOFJEUBim93wrqyXag/3/+gZpuCM50JOFJfh0rWJKM9bwWpnesE0a
        3PYIaLnumM+EiMK+jPicv3bz3Q+HkKVUvA7hZSAd8uKgBZvVzeuvdw1riAXly/FuMiVMEqfZ2sI2y
        r+WtOfWB2+iIrO9uyex/pTjv/o1lYb43LDCeMKU/Vt97kJGGCH3tQfz7X3cLEi7IDf2kl+T8KY2ON
        AMlaShzsA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g3FQy-0005J3-2K; Fri, 21 Sep 2018 07:01:00 +0000
Date:   Fri, 21 Sep 2018 00:00:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zong Li <zongbox@gmail.com>
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, vincentc@andestech.com,
        zong@andestech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] RISC-V: Avoid corrupting the upper 32-bit of
 phys_addr_t in ioremap
Message-ID: <20180921070059.GD8401@infradead.org>
References: <cover.1537260207.git.zongbox@gmail.com>
 <9fc325660fb1e0ef9133705f7c05784dcc12c0c2.1537260207.git.zongbox@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fc325660fb1e0ef9133705f7c05784dcc12c0c2.1537260207.git.zongbox@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 05:19:17PM +0800, Zong Li wrote:
> From: Vincent Chen <vincentc@andestech.com>
> 
> For 32bit, the upper 32-bit of phys_addr_t will be flushed to zero
> after AND with PAGE_MASK because the data type of PAGE_MASK is
> unsigned long. To fix this problem, the page alignment is done by
> subtracting the page offset instead of AND with PAGE_MASK.
> 
> Signed-off-by: Vincent Chen <vincentc@andestech.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
