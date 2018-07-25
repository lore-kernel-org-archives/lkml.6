Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90949C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4E520856
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OtiTPZrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4E520856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbeGYDEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 23:04:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34616 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbeGYDEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 23:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vseEyQ7B7P/dMO97ZbxiAJRke0PaTr9mg/p2ASQFsAc=; b=OtiTPZrYpSmBiFtEZtbPRmrhy
        6wEfGfSsjct3BPEpUyesZGk5NVo0vHS7lIIjW7I6RpFt/LWeVylx+I4UC+20p+3880jdDILwpXHNQ
        uaqLBfAW/Xl6/GhTD0Rl9cJLv8/ab1mgnOXE1yJm/BgDIwt6c1Sx28OzGsrZ96MjW+HpMSXFyqz6q
        cdusNDFeZQWsoMLX3AZLwbp113K5tHvJZ5lhh6J+lgp1qNWGS5LzrdK8EYS3q6C5db1KThYUyKGJk
        uzotbOfzIQmI/gb2uTakMnOinYV0ouCnPrUkh/UpxEHPE3hVP+dmH/IOXKiRC8SGMF+I6I9ZL47Sl
        RKvtij+vg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fi914-00062R-IM; Wed, 25 Jul 2018 01:55:02 +0000
Date:   Tue, 24 Jul 2018 18:55:02 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Tino Lehnig <tino.lehnig@contabo.de>, ngupta@vflare.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Zram writeback feature unstable with heavy swap utilization -
 BUG: Bad page state in process...
Message-ID: <20180725015502.GA16271@bombadil.infradead.org>
References: <0516ae2d-b0fd-92c5-aa92-112ba7bd32fc@contabo.de>
 <20180724010342.GA195675@rodete-desktop-imager.corp.google.com>
 <d4f4b5a1-9e31-375d-0599-b6d8b0ebc9df@contabo.de>
 <20180725013250.GA66792@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725013250.GA66792@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 10:32:50AM +0900, Minchan Kim wrote:
> Hi Tino,
> 
> On Tue, Jul 24, 2018 at 09:30:34AM +0200, Tino Lehnig wrote:
> > Hi,
> > 
> > The first build I used was from the master branch of the mainline kernel,
> > somewhere between rc5 and rc6. I have just reproduced the bug with 4.17.9
> > and 4.18-rc6. Kernel messages below.
> > 
> > The bug does not appear on 4.14.57. I can test more versions if it helps.
> 
> Could you try 4.15?
> 
> I think it's a regression of struct page field reordring and it started from
> v4.16. 
> 
> page->units for zsmalloc is used as offset of first object on the zspage,
> However, below patch unified it with page->_refcount.

No it didn't.  It's in a union with _mapcount, which is where it was before
my patches.

It's entiely possible that my patches caused this, but the explanation
you're offering is wrong.
