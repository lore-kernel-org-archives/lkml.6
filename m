Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4005CC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F024C21473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F024C21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeHTPu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 11:50:26 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:58784 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbeHTPu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 11:50:26 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 79123C01D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 14:34:57 +0200 (CEST)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 40472C0F4A; Mon, 20 Aug 2018 14:34:56 +0200 (CEST)
Received: from aptenodytes (AAubervilliers-681-1-85-9.w90-88.abo.wanadoo.fr [90.88.27.9])
        by gagarine.paulk.fr (Postfix) with ESMTPSA id D81D3C0F3B;
        Mon, 20 Aug 2018 14:34:44 +0200 (CEST)
Message-ID: <412de868a8d0a41aa2256a5fbe2f3701de582e1b.camel@paulk.fr>
Subject: Re: [PATCH] drm/sun4i: Avoid failing to init fbdev without any
 connector
From:   Paul Kocialkowski <contact@paulk.fr>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@googlegroups.com
Date:   Mon, 20 Aug 2018 14:34:44 +0200
In-Reply-To: <20180820095657.rcs3wxikxprty55d@flea>
References: <20180807193919.4800-1-contact@paulk.fr>
         <20180807201801.GF3008@phenom.ffwll.local>
         <230112e8b2ad4b4e53b54fe1446e7f71aa09e514.camel@paulk.fr>
         <20180820095657.rcs3wxikxprty55d@flea>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2018-08-20 at 11:56 +0200, Maxime Ripard wrote:
> On Tue, Aug 07, 2018 at 10:31:30PM +0200, Paul Kocialkowski wrote:
> > Hi,
> > 
> > Le mardi 07 août 2018 à 22:18 +0200, Daniel Vetter a écrit :
> > > On Tue, Aug 07, 2018 at 09:39:19PM +0200, Paul Kocialkowski wrote:
> > > > Initializing and registering fbdev requires at least one DRM connector
> > > > and will fail otherwise. In order to support headless setups (for
> > > > instance for GPU rendering with the GBM backend, where a DRI card node
> > > > is required to provide GEM memory reservation), add a check on the
> > > > number of registered connectors before initializing fbdev.
> > > 
> > > sun4i is a pure kms driver, why exactly do you need it for gbm backed
> > > rendering? What exactly is rendering here, and why does it insist on a
> > > display card node, even if that display card node is 100% defunct?
> > 
> > The non-free Mali blobs provide GPU support with a GBM interface that
> > takes a DRM fd in order to reserve the memory it needs for its rendering
> > targets. This uses the GEM interface available through the DRI card node
> > (and there is no render node with the non-free Mali driver). Allwinner
> > has a minimalistic out-of-tree driver pretty much only for this purpose.
> > 
> > I crafted this patch when someone on IRC tried to get the out-of-tree
> > Mali GPU driver going with the mainline kernel in order to do rendering
> > in a GBM buffer, since it's apparently the only option for headless
> > rendering with the blob.
> > 
> > In my opinion, supporting the pipeline of an out-of-tree GPU driver that
> > only works with a non-free userspace blob is not a valid reason to do
> > anything. Still, it felt like adding support for the headless use-case
> > wouldn't hurt, whatever the underlying use case for it may be.
> 
> If you start considering the DMA constraints and the API in itself, it
> does hurt. You'll get buffers that are not meant for the GPU, and
> might not be accessible, and from another device without using
> dma-buf, which again works because the hardware is dumb enough, but is
> breaking a lot of expectations in the process.

You're right, this is too much abuse. I'm dropping this patch then.

Cheers,

Paul

> If one wants to do headless rendering, mali-drm or lima looks like a
> better solution.
> 
> Maxime
> 
-- 
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/

