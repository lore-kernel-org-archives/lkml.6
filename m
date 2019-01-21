Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E54C3712F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A1020861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MRFxsVSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfAUVac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:30:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55174 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbfAUVac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 16:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IDcb7s4cNraG/2a1cXf3u05xgct90adkEl26XoaC8RY=; b=MRFxsVStKsekj4UYcs0XPLSpx
        bSj7Ak2pDhMBrwVMo5FXRWO6rvWvKdTuzFTNnhR4ez40SnpfDuY0jmU5zztKhBVfjtWbVvEiYY4g0
        RUvOgGtt8ZPjtJrVSkgvJOKe9En8oXFp4OlIiES6R8cAfSeigME/YYLvFChNqYD+Y4r2YytEdTYqT
        XpB0UxG1qjvpQrWER4N5v6SfzqTz1jx1IPMjiorDIQoDewUH4bJli/Cc6S2q8OQOWoPnOx3Xd2ryt
        g5Q6MJeT1NBICzaN5m+6TwRfV2aMMPUY4hQVFLz2YkDJ/lA+aQJnhQNwa/aJc9rRaubLqfegpLzAX
        ArZ+TudDQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glh9I-0000Ls-Lu; Mon, 21 Jan 2019 21:30:28 +0000
Date:   Mon, 21 Jan 2019 13:30:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Liam Mark <lmark@codeaurora.org>
Cc:     "Andrew F. Davis" <afd@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Laura Abbott <labbott@redhat.com>, sumit.semwal@linaro.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org
Subject: Re: [PATCH 3/4] dma-buf: add support for mapping with dma mapping
 attributes
Message-ID: <20190121213028.GB28620@infradead.org>
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org>
 <1547836667-13695-4-git-send-email-lmark@codeaurora.org>
 <20190119102527.GA17723@infradead.org>
 <7ae73c39-9049-bcf6-775f-b0817ba0ec5f@redhat.com>
 <20190121083046.GD12420@infradead.org>
 <alpine.DEB.2.10.1901211142560.9631@lmark-linux.qualcomm.com>
 <0ed7875f-15e9-184f-5b99-9a53df7c8d14@ti.com>
 <alpine.DEB.2.10.1901211214570.11004@lmark-linux.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1901211214570.11004@lmark-linux.qualcomm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 12:20:42PM -0800, Liam Mark wrote:
> I have left this to clients, but if they own the buffer they can have the 
> knowledge as to whether CPU access is needed in that use case (example for 
> post-processing).

That is an API design which the user is more likely to get wrong than
right and thus does not pass the smell test.

