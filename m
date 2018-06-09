Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Ksw0K57LG1ujSwAAmS7hNA
	; Sat, 09 Jun 2018 12:44:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9E4E9607BB; Sat,  9 Jun 2018 12:44:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,FREEMAIL_FROM,
	MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1ED0F6032D;
	Sat,  9 Jun 2018 12:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1ED0F6032D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753242AbeFIMoM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 08:44:12 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:48060 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753194AbeFIMoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 08:44:10 -0400
Received: from belgarion ([90.55.202.35])
        by mwinf5d84 with ME
        id wcjx1x0080mKt3N03cjyZX; Sat, 09 Jun 2018 14:44:09 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sat, 09 Jun 2018 14:44:09 +0200
X-ME-IP: 90.55.202.35
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Vinod Koul <vkoul@kernel.org>, Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>,
        Vinod Koul <vinod.koul@intel.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND v2] dmaengine: pxa: add a default requestor policy
References: <20180530201249.26972-1-robert.jarzmik@free.fr>
X-URL: http://belgarath.falguerolles.org/
Date: Sat, 09 Jun 2018 14:43:57 +0200
In-Reply-To: <20180530201249.26972-1-robert.jarzmik@free.fr> (Robert Jarzmik's
        message of "Wed, 30 May 2018 22:12:49 +0200")
Message-ID: <878t7oruya.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> As what former drcmr -1 value meant, add a this as a default to each
> channel, ie. that by default no requestor line is used.
>
> This is specifically used for network drivers smc91x and smc911x, and
> needed for their port to slave maps.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> Since v1: changed -1 to U32_MAX
Hi Vinod,

Could I have your ack on this so that I add this one to the dma slave map serie
after the merge window is closed please ?

Cheers.

--
Robert

> ---
>  drivers/dma/pxa_dma.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
> index 9505334f9c6e..b31c28b67ad3 100644
> --- a/drivers/dma/pxa_dma.c
> +++ b/drivers/dma/pxa_dma.c
> @@ -762,6 +762,8 @@ static void pxad_free_chan_resources(struct dma_chan *dchan)
>  	dma_pool_destroy(chan->desc_pool);
>  	chan->desc_pool = NULL;
>  
> +	chan->drcmr = U32_MAX;
> +	chan->prio = PXAD_PRIO_LOWEST;
>  }
>  
>  static void pxad_free_desc(struct virt_dma_desc *vd)
> @@ -1386,6 +1388,9 @@ static int pxad_init_dmadev(struct platform_device *op,
>  		c = devm_kzalloc(&op->dev, sizeof(*c), GFP_KERNEL);
>  		if (!c)
>  			return -ENOMEM;
> +
> +		c->drcmr = U32_MAX;
> +		c->prio = PXAD_PRIO_LOWEST;
>  		c->vc.desc_free = pxad_free_desc;
>  		vchan_init(&c->vc, &pdev->slave);
>  		init_waitqueue_head(&c->wq_state);

-- 
Robert
