Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADDEC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019CE2089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rex5M3Yx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019CE2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbeJBVfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:35:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53212 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbeJBVfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UXJ1odgG56XIb0bDD4H56VNIGvwUIQc/306v/IvDLZs=; b=Rex5M3YxTuz8pxPwHNXdsSDWb
        dj26DStFHLNQ/ibpUtAfMCH1PZh80k/x17ZsIY0d2BN3HGC0jwG1rFQFFnocOXcCTLRvrIs4UfyV4
        eY6/lbQicJ8OTJVvJBBqlkDmQnKBlbJV9gq/HMWOjxdCQDoFYH5dWyHQLWGJIKiSEryhv+Y8pw7JP
        8a+0HzrtUXvxTq+41za0GvQp9GUVia3aYk9OzwTMy1uew8bnGAGX8JUoWT/N/x+kGKSzyMHuy9Avp
        u0uIFyodud0kPsOkr/FddsTGq/xsa9f9ev9jZYT837rZ9e3MdCt2a5vVmfZtOUFxazis1ewtVD/+W
        mDLPfLsTQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7M16-0002ok-EB; Tue, 02 Oct 2018 14:51:16 +0000
Date:   Tue, 2 Oct 2018 07:51:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zong Li <zongbox@gmail.com>
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, hch@infradead.org,
        zong@andestech.com, linux-riscv@lists.infradead.org,
        Vincent Chen <vincentc@andestech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] RISC-V: Avoid corrupting the upper 32-bit of
 phys_addr_t in ioremap
Message-ID: <20181002145116.GE3889@infradead.org>
References: <cover.1538470103.git.zongbox@gmail.com>
 <54849b9d9a709525640011814872155eafa7a9d7.1538470103.git.zongbox@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54849b9d9a709525640011814872155eafa7a9d7.1538470103.git.zongbox@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 04:52:31PM +0800, Zong Li wrote:
> From: Vincent Chen <vincentc@andestech.com>
> 
> For 32bit, the upper 32-bit of phys_addr_t will be flushed to zero
> after AND with PAGE_MASK because the data type of PAGE_MASK is
> unsigned long. To fix this problem, the page alignment is done by
> subtracting the page offset instead of AND with PAGE_MASK.
> 
> Signed-off-by: Vincent Chen <vincentc@andestech.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

(and I'm pretty sure I reviewed this before..)
