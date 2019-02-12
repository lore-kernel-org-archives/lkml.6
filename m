Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78146C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489C7206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549957827;
	bh=doEoHEEJFxpJh5s2UkkMEtSv47p1Dos+NTCDCKD20ZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LeXqYo5r3JB0qB1+fYcWpH2J6k3Qz/NLTxeidTkVBMANGV7uwfyAbSvr4CXaxgq4o
	 pPKQJjLLpQ1qJ3nkr5mBadqK1MOFCJhENUQal6gWcHJVabtNAInUXCQeNcObf7Cg2L
	 EWf4u8RQQw625rbaGkgc+KD/W5kdlxTr1dsYxlGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfBLHu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:50:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:39612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfBLHuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:50:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3154206BA;
        Tue, 12 Feb 2019 07:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549957824;
        bh=doEoHEEJFxpJh5s2UkkMEtSv47p1Dos+NTCDCKD20ZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QnKvLLxjCK2y717cXiFoL8W4t2PIRDjVHo4lvhFpFEO2Cuy6QpxsczeDi5u62YM4/
         BpZrBe/E/XkbnZiKwZmYBsDZQ75wZBJJOSIcHRq100Nkp/vGAm6Np1h6YnM3mTQnj8
         OA5V2KBCgNP3BdgpaF/2ci+Cpj52rFJT7k4WW2hA=
Date:   Tue, 12 Feb 2019 08:50:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, Lee Jones <lee.jones@linaro.org>,
        x86@kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] dma-mapping: remove the DMA_MEMORY_EXCLUSIVE flag
Message-ID: <20190212075020.GC5924@kroah.com>
References: <20190211133554.30055-1-hch@lst.de>
 <20190211133554.30055-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211133554.30055-10-hch@lst.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 02:35:51PM +0100, Christoph Hellwig wrote:
> All users of dma_declare_coherent want their allocations to be
> exclusive, so default to exclusive allocations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/DMA-API.txt                     |  9 +------
>  arch/arm/mach-imx/mach-imx27_visstrim_m10.c   | 12 +++------
>  arch/arm/mach-imx/mach-mx31moboard.c          |  3 +--
>  arch/sh/boards/mach-ap325rxa/setup.c          |  5 ++--
>  arch/sh/boards/mach-ecovec24/setup.c          |  6 ++---
>  arch/sh/boards/mach-kfr2r09/setup.c           |  5 ++--
>  arch/sh/boards/mach-migor/setup.c             |  5 ++--
>  arch/sh/boards/mach-se/7724/setup.c           |  6 ++---
>  arch/sh/drivers/pci/fixups-dreamcast.c        |  3 +--
>  .../soc_camera/sh_mobile_ceu_camera.c         |  3 +--
>  drivers/usb/host/ohci-sm501.c                 |  3 +--
>  drivers/usb/host/ohci-tmio.c                  |  2 +-
>  include/linux/dma-mapping.h                   |  7 ++----
>  kernel/dma/coherent.c                         | 25 ++++++-------------
>  14 files changed, 29 insertions(+), 65 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
