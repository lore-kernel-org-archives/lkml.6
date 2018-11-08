Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E1EECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706D820825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KNtyDBE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706D820825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeKIAkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:40:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52260 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeKIAkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oq6K4u5UbnTQBBvQt6UKSQiD1X6pewP/JAVSBi7hZ/0=; b=KNtyDBE+TptEiQnQm5O6Mwm2I
        BF4ljeRA3kHRkIXtkj8OtTPYf9/fNnvD1ELXPUs/h6r7dLSklCOjpbCnH88Vb0caunQADifZ5GYoo
        4wDim9ApQ7cFF1eddGS3upVXb3yQjXP4CvvHPnexMCY1yjCYE2rgA4oUmaG6amiPVcL7wvRaxCnNs
        z/XjOpbp/jJt4GWDE1weTovMxgwSIiUdkNI+9c9eA4gb8PqeCglPDJ4aT7z/eifm0Nn45RZnPrl6F
        WAEXhWh3G8eMqmKIA1H7UTJvCO8HhhincuVdotPhfDTVB2ZGKB1XNcpqz1CwTgwHn5A8//U5xFBpi
        SQcds60gw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKlrR-00088H-Sm; Thu, 08 Nov 2018 15:04:45 +0000
Date:   Thu, 8 Nov 2018 07:04:45 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Jens Axboe <axboe@fb.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] block: respect virtual boundary mask in bvecs
Message-ID: <20181108150445.GA31100@infradead.org>
References: <20181105102301.9752-1-jthumshirn@suse.de>
 <a97f3d77-d23b-b418-abce-2d93ed725bdb@acm.org>
 <c15244a4-9085-5255-edea-b92a9ed1307c@suse.de>
 <950a7996-e0f7-ff34-04da-47581a9496f0@grimberg.me>
 <1541607019.196084.210.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541607019.196084.210.camel@acm.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 08:10:19AM -0800, Bart Van Assche wrote:
> > I personally not a huge fan of decoding complicated expressions. But if
> > others are fine with it then I am too...
> 
> What I proposed is not a new pattern. It is a pattern that is already used
> elsewhere in the Linux kernel. A few examples:
> 
> >From dmabounce.c:
> 
> 		/* Figure out if we need to bounce from the DMA mask. */
> 		if ((dma_addr | (dma_addr + size - 1)) & ~mask)
> 			return 1;
> 
> >From dma-direct.h:
> 
> 	if ((addr | (addr + size - 1)) & ~mask)
> 		return 0;

Time for a well documented helper :)
