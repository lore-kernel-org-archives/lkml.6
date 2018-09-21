Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906A8C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3358B21479
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RQ5eZ/60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3358B21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390856AbeIUXXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:23:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40666 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390615AbeIUXXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:23:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id l63-v6so6357102pga.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 10:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=OXtOYBJJ3gKOgfsFIJIO8tM7T4Rg7r4Y/p93S1VVW/4=;
        b=RQ5eZ/60SVR9sWcMmO3h/hTPR3WEzyDjVUpnChCH3wVcoedKnhO51p73V82e/zk86R
         qP/mLI8uRAaO1gpJwGeZ8lcKQds+kDwSf9BdgXdCunJLVOysLa5L/2wh+R+iP959eyJ1
         V8xiF54c2JyJN4FPg+y2kGNxAqKzXExZpzh28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=OXtOYBJJ3gKOgfsFIJIO8tM7T4Rg7r4Y/p93S1VVW/4=;
        b=AFFeHW6VBJMLa3CqfDANw3CG6ec7px7t4H+NxJxw8vyb9OP/iuAm+pd2C/x7QvQpTO
         HJ3W1GP3Bam/P2eVrU9oJOiaIVvzS0kqYdSzeszKduv70pudZZfF3Wym6VcloU/lsHZC
         ceBrvMYH6RPMpooJ33SdlIrUpXMAkOsNsVhn6+SNLzac1pjA/xQrTIeUHvU/uyhbDMyx
         b3bODziuOuTiOJ4CcD8mf2lzcrwtBKvJFQrbDHc9saBoFGTh+eTe/1pb9cICbyObWG0N
         aWggMk5NXNxypiFEQ4plL6cFuIpaZ8DZ8LQQf6lXLYZ0Dmw/pG9iSrr8rmXbdVgLYlpB
         hLEQ==
X-Gm-Message-State: APzg51CgSOW4emyjiNswD2haJk4fPZ5KG6wxiQsAFyBMzFTj0hE+m7T5
        QDp7gKCYPJdCbsrcTldQF6hzejQ/TAU=
X-Google-Smtp-Source: ANB0VdZpmGUDMgXh08SZlYRSA+w9Mnr1cOTx3AvYvGSC0ImVtDPWe1h7f/IN70NE/XGWwfkI0ZewvA==
X-Received: by 2002:a62:4f94:: with SMTP id f20-v6mr8523921pfj.60.1537551195986;
        Fri, 21 Sep 2018 10:33:15 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id h85-v6sm43324983pfk.71.2018.09.21.10.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 10:33:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Christoph Hellwig <hch@lst.de>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180921052537.GB12825@lst.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20180920223559.136915-1-swboyd@chromium.org> <20180921052537.GB12825@lst.de>
Message-ID: <153755119449.119890.13616278963313850730@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] dma-debug: Check for drivers mapping vmalloc addresses
Date:   Fri, 21 Sep 2018 10:33:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christoph Hellwig (2018-09-20 22:25:37)
> On Thu, Sep 20, 2018 at 03:35:59PM -0700, Stephen Boyd wrote:
> > I recently debugged a DMA mapping oops where a driver was trying to map
> > a buffer returned from request_firmware() with dma_map_single(). Memory
> > returned from request_firmware() is mapped into the vmalloc region and
> > this isn't a valid region to map with dma_map_single() per the DMA
> > documentation's "What memory is DMA'able?" section.
> > =

> > Unfortunately, we don't really check that in the DMA debugging code, so
> > enabling DMA debugging doesn't help catch this problem. Let's add a new
> > DMA debug function to check for a vmalloc address and print a warning if
> > this happens. This makes it a little easier to debug these sorts of
> > problems, instead of seeing odd behavior or crashes when drivers attempt
> > to map the vmalloc space for DMA.
> =

> This looks sensible to me.  I wonder if we shouldn't just throw in
> an unconditional
> =

>         WARN_ON_ONCE(is_vmalloc_addr(ptr)));
> =

> into dma_map_single_attrs, though.

Yes that works just as well if we're willing to take the overhead of the
check all the time. This isn't a hotpath?

