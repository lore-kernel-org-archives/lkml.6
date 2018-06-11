Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0s9fNo5WHlvXdQAAmS7hNA
	; Mon, 11 Jun 2018 11:01:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D081B607E4; Mon, 11 Jun 2018 11:01:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 63E50601C3;
	Mon, 11 Jun 2018 11:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63E50601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932848AbeFKLBd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 07:01:33 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35129 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932263AbeFKLBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:01:31 -0400
Received: from weser.hi.pengutronix.de ([2001:67c:670:100:fa0f:41ff:fe58:4010])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fSKZi-0004f0-BU; Mon, 11 Jun 2018 13:01:26 +0200
Message-ID: <1528714877.2842.3.camel@pengutronix.de>
Subject: Re: [PATCH v3 0/6] add virt-dma support for imx-sdma
From: Lucas Stach <l.stach@pengutronix.de>
To: Robin Gong <yibin.gong@nxp.com>, vkoul@kernel.org,
        s.hauer@pengutronix.de, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Date: Mon, 11 Jun 2018 13:01:17 +0200
In-Reply-To: <1528729173-28684-1-git-send-email-yibin.gong@nxp.com>
References: <1528729173-28684-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:fa0f:41ff:fe58:4010
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

this series breaks serial DMA for me. I wasn't able to dig in deeper
yet. Please let me know if you can test/reproduce at your side, if not
I'll try to find some time to collect some more debug info.

Regards,
Lucas

Am Montag, den 11.06.2018, 22:59 +0800 schrieb Robin Gong:
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
> Robin Gong (5):
>   dmaengine: imx-sdma: add virt-dma support
>   Revert "dmaengine: imx-sdma: fix pagefault when channel is disabled
>     during interrupt"
>   dmaengine: imx-sdma: remove usless lock
>   dmaengine: imx-sdma: remove the maximum limation for bd numbers
>   dmaengine: imx-sdma: add sdma_transfer_init to decrease code overlap
> 
>  drivers/dma/Kconfig    |   1 +
>  drivers/dma/imx-sdma.c | 392 ++++++++++++++++++++++++++++---------------------
>  2 files changed, 227 insertions(+), 166 deletions(-)
> 
> -- 
> 2.7.4
> 
> Robin Gong (5):
>   dmaengine: imx-sdma: add virt-dma support
>   Revert "dmaengine: imx-sdma: fix pagefault when channel is disabled
>     during interrupt"
>   dmaengine: imx-sdma: remove usless lock
>   dmaengine: imx-sdma: remove the maximum limation for bd numbers
>   dmaengine: imx-sdma: add sdma_transfer_init to decrease code overlap
> 
> Sascha Hauer (1):
>   dmaengine: imx-sdma: factor out a struct sdma_desc from struct
>     sdma_channel
> 
>  drivers/dma/Kconfig    |   1 +
>  drivers/dma/imx-sdma.c | 391 ++++++++++++++++++++++++++++---------------------
>  2 files changed, 226 insertions(+), 166 deletions(-)
> 
