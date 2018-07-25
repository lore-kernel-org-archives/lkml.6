Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EA0C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191F52088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8DqYTWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191F52088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbeGYEAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 00:00:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34699 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725750AbeGYEAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 00:00:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id y5-v6so4245478pgv.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 19:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/t4WXCRdvXa7X+bDBWyNBZRhCctYOz89Abc6BCyMvYs=;
        b=T8DqYTWCDm4cJueMiJ7v/YABbthA8i7YMFEjllQEXMzCAF05YMqdXl9Yy6NzrKPpEy
         YdE8jX72T7lXsXyd6cSPIFxq5fjzSCRicL3yVdqKEAkjIq++ZBkke9YyoFMJfoTKyqLW
         vCNWHUfr21D9HYOet4NTwOJJbjCdMwz/FpKjqJWUEhWosHaMgp6oWsgR9ogcSSWZroUt
         rVDF0nTgCKVb/p0dby4JUUaX829aE8Pd9Dz183glbbLIekm4Xuh67sUKkRj4cNkMKBv+
         qVzX9waUDkRwpGVLYUrZaP2vxL4PbXoEyDVPGQ2+MJ4JPeykR94o2RkSh22CFkZ6htE6
         nzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/t4WXCRdvXa7X+bDBWyNBZRhCctYOz89Abc6BCyMvYs=;
        b=E2Crm6ZrJ/ttFv7GKDcrBNatPN8+SYK3kQ9vwHDm8d/oF/isqbVXDHfDAvxYgOE9Er
         t3JnAirwtkr1fl17d5sjm54FXg7J5uFeBv3p5aG87jAAlMwf5BYuBHjKYLx0t7BONYKf
         AkmiISaUHpbMCDJme0zCZGWAHkxDcDmjv94jQliqnkaie0OmkC62SEZD2J+juQmx9t/3
         KepTys6eDK+4vuHUlNPZVNzE56Cw8/5ryZjYfY43FL7Ip/sj34o8G1UaphJTfHbifDY7
         dEAWHm6WtQYVYd1U3OfIRQN/De8L0XCr3zWJfG3igOfQN2Ji9RpPmMH5cCP3Xj7crOE5
         MUKQ==
X-Gm-Message-State: AOUpUlEs2EW7rU3ugYs16npEE/A9RkWY1X1siURvj0i3JSUyL2EhNhDC
        xyfSD9PfhFnxodi/4m5oKNn5vlTF
X-Google-Smtp-Source: AAOMgpe37Wk319JtPCTY7nnlGmtX6L572TfB8EJsAKVHsPI/qp4baREfNt2Wn0ZmL9JZ9BzU1f2QTw==
X-Received: by 2002:a63:ab0c:: with SMTP id p12-v6mr18468553pgf.190.1532487071874;
        Tue, 24 Jul 2018 19:51:11 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id z123-v6sm17377928pfz.16.2018.07.24.19.51.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 19:51:10 -0700 (PDT)
Date:   Wed, 25 Jul 2018 11:51:06 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Tino Lehnig <tino.lehnig@contabo.de>, ngupta@vflare.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Zram writeback feature unstable with heavy swap utilization -
 BUG: Bad page state in process...
Message-ID: <20180725025106.GA99093@rodete-desktop-imager.corp.google.com>
References: <0516ae2d-b0fd-92c5-aa92-112ba7bd32fc@contabo.de>
 <20180724010342.GA195675@rodete-desktop-imager.corp.google.com>
 <d4f4b5a1-9e31-375d-0599-b6d8b0ebc9df@contabo.de>
 <20180725013250.GA66792@rodete-desktop-imager.corp.google.com>
 <20180725015502.GA16271@bombadil.infradead.org>
 <20180725021657.GA87819@rodete-desktop-imager.corp.google.com>
 <20180725023532.GB16271@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725023532.GB16271@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 07:35:32PM -0700, Matthew Wilcox wrote:
> On Wed, Jul 25, 2018 at 11:16:57AM +0900, Minchan Kim wrote:
> > On Tue, Jul 24, 2018 at 06:55:02PM -0700, Matthew Wilcox wrote:
> > > On Wed, Jul 25, 2018 at 10:32:50AM +0900, Minchan Kim wrote:
> > > > Hi Tino,
> > > > 
> > > > On Tue, Jul 24, 2018 at 09:30:34AM +0200, Tino Lehnig wrote:
> > > > > Hi,
> > > > > 
> > > > > The first build I used was from the master branch of the mainline kernel,
> > > > > somewhere between rc5 and rc6. I have just reproduced the bug with 4.17.9
> > > > > and 4.18-rc6. Kernel messages below.
> > > > > 
> > > > > The bug does not appear on 4.14.57. I can test more versions if it helps.
> > > > 
> > > > Could you try 4.15?
> > > > 
> > > > I think it's a regression of struct page field reordring and it started from
> > > > v4.16. 
> > > > 
> > > > page->units for zsmalloc is used as offset of first object on the zspage,
> > > > However, below patch unified it with page->_refcount.
> > > 
> > > No it didn't.  It's in a union with _mapcount, which is where it was before
> > > my patches.
> > > 
> > > It's entiely possible that my patches caused this, but the explanation
> > > you're offering is wrong.
> > 
> > Before your patch, _mapcount and _refcount is separated space so we can use
> > _mapcount for page->units for non-mapped pages because units is unified with
> > _mapcount. However, with your patch, now units is unified with _refcount.
> 
> No.  That's completely untrue.
> 
>         union {         /* This union is 4 bytes in size. */
>                 atomic_t _mapcount;
>                 unsigned int page_type;
>                 unsigned int active;            /* SLAB */
>                 int units;                      /* SLOB */
>         };
> 
>         atomic_t _refcount;
> 
> There is NOTHING in a union with _refcount.
> 


Confusing. Matthew, what am I missing?

Before:

counters consumes 8 bytes
units and _refcount consumes each 4 bytes so memory space is not overlapped.

        union {
                unsigned long counters;
                struct {

                        union {
                                atomic_t _mapcount;
                                unsigned int active;            /* SLAB */
                                struct {                        /* SLUB */
                                        unsigned inuse:16;
                                        unsigned objects:15;
                                        unsigned frozen:1;
                                };
                                int units;                      /* SLOB */
                        };
                        /*
                         * Usage count, *USE WRAPPER FUNCTION* when manual
                         * accounting. See page_ref.h
                         */
                        atomic_t _refcount;
                };
        };


After:

Now, units is overlapped with _refcount and _mapcount.

        union {
                unsigned long counters;
                unsigned int active;            /* SLAB */
                struct {                        /* SLUB */
                        unsigned inuse:16;
                        unsigned objects:15;
                        unsigned frozen:1;
                };
                int units;                      /* SLOB */
                struct {                        /* Page cache */
                        atomic_t _mapcount;
                        atomic_t _refcount;
                };
        };


