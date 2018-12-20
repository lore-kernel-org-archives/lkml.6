Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E22CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F08C2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oRDDkOJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388058AbeLTRjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:39:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730526AbeLTRjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:39:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xlP1es0E/CTI638jb51O8he5KmaEfgJt9PkANcyjU3g=; b=oRDDkOJWpzAPLKWeA77FYj0CS
        HUNI2eP+1uUZC6AtOi5Hl7CdVhAkX+YfnSJxefY1LC6uMOSSkRttKoD/1x+o4RnXc0niNS0n86zoi
        6WR4BZSgjflcoS9oDio47eqOsdY2As1ieaIl9fneGaSuIDoIee8E+I/u+02VUQ7vkGG931kkNqtvi
        WZGbZg+g7u1xS6Gd6kJajjJ90y5nel9tz/ironWn8I270eimHowAkRAUsfGAMEBRo+OfY1pw0kUAc
        iI5r8nKlk/e5SfV6tRyudC5V7qNR+X+F/DusFVXfs75NI1Qy3LSDFgwaeJ4jQaqqLnW9gnDF/feOh
        ZzxovbF7A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ga2IY-00075g-9x; Thu, 20 Dec 2018 17:39:50 +0000
Date:   Thu, 20 Dec 2018 09:39:50 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Oleksandr Andrushchenko <andr2000@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel.vetter@intel.com,
        jgross@suse.com, boris.ostrovsky@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH] drm/xen-front: Make shmem backed display buffer coherent
Message-ID: <20181220173950.GA19641@infradead.org>
References: <20181127103252.20994-1-andr2000@gmail.com>
 <17640791-5306-f7e4-8588-dd39c14e975b@tronnes.org>
 <20181220153646.GA22997@infradead.org>
 <f2cfadc7-2e0b-b63d-d094-d5339b0c85fe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2cfadc7-2e0b-b63d-d094-d5339b0c85fe@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 05:49:39PM +0200, Oleksandr Andrushchenko wrote:
> This is the only patch [1], no series. And at the moment I think
> there is nothing to review as I am not sure how to deal with those
> shmem pages: this patch is rather to start a discussion on how shmem
> pages can be flushed on ARM (the only workaround I have so far is
> in this patch which uses DMA API). This is where I am looking for
> some advice, so I can implement the patch the right way.

shmem is basically page cache.  So you need to use the DMA streaming
API (dma_map_*) to map it for DMA.  You need to make sure no one
access the kernel mapping at the same time as you do DMA to it,
so the pages should be locked.  This is how the normal file system
I/O path works.
