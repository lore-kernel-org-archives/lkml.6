Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB7BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4D22086B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ds8ssu0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4D22086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeKSLYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 06:24:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57784 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbeKSLYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 06:24:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zarwFY8/rYKpT8HEb383ruGvAwzj654iYYR5hS4DF20=; b=Ds8ssu0vYG7Xok7ykW4VK0tZI
        sW10EXMxcC/eA5g0IZiE5rTXgIra7d/E7j05gZqX3fI3JAyD2Rt4M5nMQLglXzcsogkHjaY2KfneI
        mVpm1CLD+AncMb/pSWmoepW2a43Do+0Rpw/H3zwRaL/rcxoXBSUhP5XkClLRjyou0tl2dytUx4oNc
        l5uQTinv/5TYh/36Tt3JVcvqq7Wh/ZNEoSl1tDMlttHgk446WffPmqhdpeHlZpxTbbONOXI8/qa66
        T7BwTAkQNRamOUUejN29oOOVGryGiA5xatghBcIR5Z68R6LLHlybQqOcte4gkZkSYEvjQ8NjSFfj1
        TQIsJDUmw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOXxs-0002Iw-Cl; Mon, 19 Nov 2018 01:03:00 +0000
Date:   Sun, 18 Nov 2018 17:03:00 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, darrick.wong@oracle.com,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/filemap.c: minor optimization in write_iter file
 operation
Message-ID: <20181119010300.GD7861@bombadil.infradead.org>
References: <1542542538-11938-1-git-send-email-laoar.shao@gmail.com>
 <20181118121318.GC7861@bombadil.infradead.org>
 <CALOAHbAfWkAYJPTRfyPmHKSmg7UEhtnamzUVx9xd4oYkqi_x8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbAfWkAYJPTRfyPmHKSmg7UEhtnamzUVx9xd4oYkqi_x8g@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 11:02:19PM +0800, Yafang Shao wrote:
> On Sun, Nov 18, 2018 at 8:13 PM Matthew Wilcox <willy@infradead.org> wrote:
> > Did you check the before/after code generation with this patch applied?
> 
> Yes, I did.
> My oompiler is gcc-4.8.5, a litte old, and with CONFIG_CC_OPTIMIZE_FOR_SIZE on.
> > with gcc 8.2.0, I see no difference, indicating that the compiler already
> > makes this optimisation.
> 
> Could pls. try set CONFIG_CC_OPTIMIZE_FOR_SIZE on and then compare them again ?

Actually it was already on:

# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y

I happened to build it in my build-tiny output tree.
