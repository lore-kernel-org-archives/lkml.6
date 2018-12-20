Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BA4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26399218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="By7ejdPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389187AbeLTS3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:29:52 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40249 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733143AbeLTS3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:29:50 -0500
Received: by mail-it1-f194.google.com with SMTP id h193so3117018ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 10:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VRAYsH2vnfRBNF1ip+ybzuzgKrpXCMUBIqg0huRiZn4=;
        b=By7ejdPhRS5/TfASPZUHsQSyNlsmkFT1gxncEszms9zKsTBtNrig/XVeMAgNzJtN5b
         wxg6pAR1d+IgVi26TtJuKrHX/x6v5yZqzWS95weE2DpkbLgi660MEn77tni9EpFGJb+O
         WPDtQGu7Id8OWRqJRsJsGbPnk3LBFT4LF4I8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VRAYsH2vnfRBNF1ip+ybzuzgKrpXCMUBIqg0huRiZn4=;
        b=QZYfwbliz2O+5TTi6kvgCaiMqB7puGDXpCyIUCOkX0+XZSHW8RPihbEUGc7j1NE28w
         7SxP6N4xR9p6Si0hEwS3pbhnuBNtjmvy0gISzPrRvCA1DqwzxBvNGLgTt4MIqJXjNNo8
         9Q1kDwjtAYwUUP25q1fXjSD0TURfXWPD1yqXMw8XiDDaHuEmo+gzFmgD0d98pAe2Soe9
         spyndni6MfpIj9vsTLSYRGG6fokPXv+qWDOoK4rBWqxr+dWGwsrGd7G6e3fIbR9WJMC0
         Nhan1KdNJWkQsfM0YKYAGS7QnGfUjy9SjMvs6XVjZRMJU6AFVbGZF7xLmyNFui5kYl8H
         DOPw==
X-Gm-Message-State: AA+aEWYRjtRXQihSftmKKE6XDoKlU+hrDblY0DcjQy/VNfbI5jLQ7T1f
        byuq9ScnPOec87KHOISF0U4eVuO8p9DA00/bWTobCA==
X-Google-Smtp-Source: AFSGD/VCt8JRek/Oh02NELNf7Bn2MwtfgccLtrghMfLs/PdGXKERgAbwExpLOgCsYRBeqsHDSBlz+YnoRQr+ThBnwAw=
X-Received: by 2002:a05:660c:344:: with SMTP id b4mr10559562itl.51.1545330589207;
 Thu, 20 Dec 2018 10:29:49 -0800 (PST)
MIME-Version: 1.0
References: <20181127103252.20994-1-andr2000@gmail.com> <17640791-5306-f7e4-8588-dd39c14e975b@tronnes.org>
 <20181220153646.GA22997@infradead.org> <f2cfadc7-2e0b-b63d-d094-d5339b0c85fe@gmail.com>
 <20181220173950.GA19641@infradead.org>
In-Reply-To: <20181220173950.GA19641@infradead.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 20 Dec 2018 19:29:37 +0100
Message-ID: <CAKMK7uF8hmO=z4jy+1b1z5ELLWpjcZpqmLoRiP2BJvwnNpOFeg@mail.gmail.com>
Subject: Re: [PATCH] drm/xen-front: Make shmem backed display buffer coherent
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 6:39 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Dec 20, 2018 at 05:49:39PM +0200, Oleksandr Andrushchenko wrote:
> > This is the only patch [1], no series. And at the moment I think
> > there is nothing to review as I am not sure how to deal with those
> > shmem pages: this patch is rather to start a discussion on how shmem
> > pages can be flushed on ARM (the only workaround I have so far is
> > in this patch which uses DMA API). This is where I am looking for
> > some advice, so I can implement the patch the right way.
>
> shmem is basically page cache.  So you need to use the DMA streaming
> API (dma_map_*) to map it for DMA.  You need to make sure no one
> access the kernel mapping at the same time as you do DMA to it,
> so the pages should be locked.  This is how the normal file system
> I/O path works.

I wasn't around back then, but afaiui drm uses shmem because that was
the only way mm folks let us have swappable memory. We proposed a
gemfs a while ago to be able to mix up our own allocator with that,
wasn't approved.

What we most definitely not want to end up with though is actually
streaming dma, because with that all the zero copy buffer sharing
tricks become pointless. There's pretty epic amounts of hacks to work
around this, I have no idea what's supposed to give here.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
