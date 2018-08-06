Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BB4C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB16214DC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fR7wB85I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB16214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbeHFKpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:45:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54054 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbeHFKpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8IPaT0Wobg/0V5tXVnsK2seHVA/CXrBBtwAwP6ULiVc=; b=fR7wB85I3NibxjLUJ5r20WaMu
        U4a8K39NBdZHEQjID6KkWjrdzWUggKEdh94cCvA3k4qfEcSPFLMqEXo9bG43yy/TOs1EYqOpKrAh1
        QfcDLoYEGVx8VGSEccv0UofdjCQnicIzMlP2axLXXF67bMjEk6pxWz6AuUFc87jDFn7CCZ0kPv2iR
        cDBO54eaULaf/zd3sJKEaqpRNEjstv3Ycj2uZhSnCbN5XLvqE8s05Ey9oMPvHdYNWOmXlf/9R8pvZ
        7GKahEBYuLBEwVwScN45OKPNkEKWbLLoqvOv7zLVbuvFZTmp15AZclPpCF3zPNk1F3/F/7HgO6Ds8
        0KCqxY5YQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmb18-0003u3-Vj; Mon, 06 Aug 2018 08:37:30 +0000
Date:   Mon, 6 Aug 2018 01:37:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: OHCI: ohci-sm501: complete URBs in BH context
Message-ID: <20180806083730.GA32650@infradead.org>
References: <1533355279-26725-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533355279-26725-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 09:01:19PM -0700, Guenter Roeck wrote:
> Testing an USB drive connected to ohci-sm501 results in a large number
> of runtime warnings.

As far as I can tell this driver uses the HCD_LOCAL_MEM feature flag
for memory declared using dma_declare_coherent_memory.  Unlike the
mormal dma mapping interfaces this special case can actually be freed
from interrupt context, and we have a fix for this warning queued
up in linux-next:

http://git.infradead.org/users/hch/dma-mapping.git/commitdiff/d27fb99f62af7b79c542d161aa5155ed57271ddc

That being said I'm generally very unhappy how dma_init_coherent_memory
turned out.  The idea was to allow device local memory to be hidden
behind the DMA API, but in general we use it either as a way to declare
special uncache system memory (which would really be the plaform codes
job), or as a magic bounce buffer like in the USB code.  I plan to
eventually untangle this, but it is going to take some time.
