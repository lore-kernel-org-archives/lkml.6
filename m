Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E666C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA4920827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA4920827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbeKJIzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:55:21 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:60856 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbeKJIzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:55:21 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D7D2D14BF672F;
        Fri,  9 Nov 2018 15:12:36 -0800 (PST)
Date:   Fri, 09 Nov 2018 15:12:34 -0800 (PST)
Message-Id: <20181109.151234.2231390463846593374.davem@davemloft.net>
To:     hch@lst.de
Cc:     iommu@lists.linux-foundation.org, torvalds@linux-foundation.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] remove the ->mapping_error method from dma_map_ops
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181109084632.22848-1-hch@lst.de>
References: <20181109084632.22848-1-hch@lst.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 09 Nov 2018 15:12:37 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Fri,  9 Nov 2018 09:46:30 +0100

> Error reporting for the dma_map_single and dma_map_page operations is
> currently a mess.  Both APIs directly return the dma_addr_t to be used for
> the DMA, with a magic error escape that is specific to the instance and
> checked by another method provided.  This has a few downsides:
> 
>  - the error check is easily forgotten and a __must_check marker doesn't
>    help as the value always is consumed anyway
>  - the error checking requires another indirect call, which have gotten
>    incredibly expensive
>  - a lot of code is wasted on implementing these methods
> 
> The historical reason for this is that people thought DMA mappings would
> not fail when the API was created, which sounds like a really bad
> assumption in retrospective, and then we tried to cram error handling
> onto it later on.
> 
> There basically are two variants:  the error code is 0 because the
> implementation will never return 0 as a valid DMA address, or the error
> code is all-F as the implementation won't ever return an address that
> high.  The old AMD GART is the only one not falling into these two camps
> as it picks sort of a relative zero relative to where it is mapped.
> 
> The 0 return doesn't work for a lot of IOMMUs that start allocating
> bus space from address zero, so we can't consolidate on that, but I think
> we can move everyone to all-Fs, which the patch here does.  The reason
> for that is that there is only one way to ever get this address: by
> doing a 1-byte long, 1-byte aligned mapping, but all our mappings
> are not only longer but generally aligned, and the mappings have to
> keep at least the basic alignment.  Please try to poke holes into this
> idea as it would simplify our logic a lot, and also allow to change
> at least the not so commonly used yet dma_map_single_attrs and
> dma_map_page_attrs to actually return an error code and further improve
> the error handling flow in the drivers.

I have no problem with patch #1, it looks great.

But patch #2 on the other hand, not so much.

I hate seeing values returned by reference, it adds cost especially
on cpus where all argments and return values fit in registers (we end
up forcing a stack slot and memory references).

And we don't need it here.

DMA addresses are like pointers, and therefore we can return errors and
valid success values in the same dma_addr_t just fine.  PTR_ERR() --> DMA_ERR(),
IS_PTR_ERR() --> IS_DMA_ERR, etc.

