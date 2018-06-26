Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FCDC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52E426CAC
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52E426CAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbeFZPES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:04:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52229 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbeFZPEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:04:16 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fXpVo-0007d3-EE; Tue, 26 Jun 2018 17:04:08 +0200
Message-ID: <1530025442.9910.44.camel@pengutronix.de>
Subject: Re: [PATCH v5 0/7] add virt-dma support for imx-sdma
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>, vkoul@kernel.org,
        s.hauer@pengutronix.de, dan.j.williams@intel.com,
        gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Date:   Tue, 26 Jun 2018 17:04:02 +0200
In-Reply-To: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
References: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

I've tested this whole series with the SDMA being used for SPI, UART
and SSI with no regressions spotted. As this should cover most common
use-cases, I think this series is good to go in.

Tested-by: Lucas Stach <l.stach@pengutronix.de>

Regards,
Lucas

Am Mittwoch, den 20.06.2018, 00:56 +0800 schrieb Robin Gong:
> The legacy sdma driver has below limitations or drawbacks:
>   1. Hardcode the max BDs number as "PAGE_SIZE / sizeof(*)", and alloc
>      one page size for one channel regardless of only few BDs needed
>      most time. But in few cases, the max PAGE_SIZE maybe not enough.
>   2. One SDMA channel can't stop immediatley once channel disabled which
>      means SDMA interrupt may come in after this channel terminated.There
>      are some patches for this corner case such as commit "2746e2c389f9",
>      but not cover non-cyclic.
> 
> The common virt-dma overcomes the above limitations. It can alloc bd
> dynamically and free bd once this tx transfer done. No memory wasted or
> maximum limititation here, only depends on how many memory can be requested
> from kernel. For No.2, such issue can be workaround by checking if there
> is available descript("sdmac->desc") now once the unwanted interrupt
> coming. At last the common virt-dma is easier for sdma driver maintain.
> 
> Change from v4:
>   1. identify lockdep issue which caused by allocate memory with
>      'GFP_KERNEL', change to 'GFP_NOWAIT' instead so that lockdep
>      ignore check. That also make sense since Audio/uart driver may
>      call dma function after spin_lock_irqsave()...
>   2. use dma pool instead for bd description allocated,since audio
>      driver may call dma_terminate_all in irq. Please refer to 7/7.
>   3. remove 7/7 serial patch in v4, since lockdep issued fixed by No.1 
> 
> Change from v3:
>   1. add two uart patches which impacted by this patchset.
>   2. unlock 'vc.lock' before cyclic dma callback and lock again after
>      it because some driver such as uart will call dmaengine_tx_status
>      which will acquire 'vc.lock' again and dead lock comes out.
>   3. remove 'Revert commit' stuff since that patch is not wrong and
>      combine two patch into one patch as Sascha's comment.
> 
> Change from v2:
>   1. include Sascha's patch to make the main patch easier to review.
>      Thanks Sacha.
>   2. remove useless 'desc'/'chan' in struct sdma_channe.
> 
> Change from v1:
>   1. split v1 patch into 5 patches.
>   2. remove some unnecessary condition check.
>   3. remove unnecessary 'pending' list.
> 
> Robin Gong (6):
>   tty: serial: imx: correct dma cookie status
>   dmaengine: imx-sdma: add virt-dma support
>   dmaengine: imx-sdma: remove useless 'lock' and 'enabled' in 'struct
>     sdma_channel'
>   dmaengine: imx-sdma: remove the maximum limitation for bd numbers
>   dmaengine: imx-sdma: add sdma_transfer_init to decrease code overlap
>   dmaengine: imx-sdma: alloclate bd memory from dma pool
> 
> Sascha Hauer (1):
>   dmaengine: imx-sdma: factor out a struct sdma_desc from struct
>     sdma_channel
> 
>  drivers/dma/Kconfig      |   1 +
>  drivers/dma/imx-sdma.c   | 400 +++++++++++++++++++++++++++--------------------
>  drivers/tty/serial/imx.c |   2 +-
>  3 files changed, 235 insertions(+), 168 deletions(-)
> 
