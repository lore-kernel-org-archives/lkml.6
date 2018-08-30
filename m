Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6C6C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD0620837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nq0ggMDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD0620837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeH3WC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:02:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbeH3WC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bkTDtHiYssxwSppmy8xvgPn+Ex0qKqm0MV7GzJMUhqw=; b=nq0ggMDF2RR8jmRjhOGuqR9EJ
        f4uVKEnc/Lkr+Ahx9rny9zoib4oHQhm8YOHeiGGOEovC4B3tg/iTt+QFkW8/FYBdAWX5bp8ndd/RX
        +JeZBUKB7xdC1OfcoyFvQ/BrMXiuBoQcCKrR5rJgt7q6BoP+LrXeOKl2GdI5SGW6tVVl2bHJivioc
        nrpgghrWrKs1yM+BbcYvWuowDqkKYNuTwurZ4xFKll4EWaDdLTLCUjXLpnrPyZiF5ohD7SOaSra9O
        G+1HEbp1SXBxLElsHsYTeQMd5P3/XwyjUI4nHEwknS3PWACjJRzvl0hvDAHVcadiJe+MX3qKVAwKH
        Vz06v1O4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvREH-00052S-M3; Thu, 30 Aug 2018 17:59:37 +0000
Date:   Thu, 30 Aug 2018 10:59:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomasz Figa <tfiga@chromium.org>,
        "Matwey V . Kornilov" <matwey@sai.msu.ru>,
        Alan Stern <stern@rowland.harvard.edu>, kernel@collabora.com,
        Keiichi Watanabe <keiichiw@chromium.org>
Subject: Re: [RFC 3/3] stk1160: Use non-coherent buffers for USB transfers
Message-ID: <20180830175937.GB11521@infradead.org>
References: <20180830172030.23344-1-ezequiel@collabora.com>
 <20180830172030.23344-4-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830172030.23344-4-ezequiel@collabora.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	dma_sync_single_for_cpu(&urb->dev->dev, urb->transfer_dma,
> +		urb->transfer_buffer_length, DMA_FROM_DEVICE);

You can't ue dma_sync_single_for_cpu on non-coherent dma buffers,
which is one of the major issues with them.
