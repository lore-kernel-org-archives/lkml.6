Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55B7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AECB206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfAJWxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:53:19 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:49376 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfAJWxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:53:19 -0500
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id A59123A4021;
        Thu, 10 Jan 2019 23:42:46 +0100 (CET)
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id AF1EBFF804;
        Thu, 10 Jan 2019 22:42:43 +0000 (UTC)
Date:   Thu, 10 Jan 2019 23:52:00 +0100
From:   Remi Pommarel <repk@triplefau.lt>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Elie Roudninski <xademax@gmail.com>, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: meson-gx: Free irq in release() callback
Message-ID: <20190110225200.GC982@voidbox.localdomain>
References: <20190110184908.27413-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110184908.27413-1-repk@triplefau.lt>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 07:49:08PM +0100, Remi Pommarel wrote:
> Because the irq was requested through device managed resources API
> (devm_request_threaded_irq()) it was freed after meson_mmc_remove()
> completion, thus after mmc_free_host() has reclaimed meson_host memory.
> As this irq is IRQF_SHARED, while using CONFIG_DEBUG_SHIRQ, its handler
> get called by free_irq(). So meson_mmc_irq() was called after the
> meson_host memory reclamation and was using invalid memory.
> 
> We ended up with the following scenario:
> device_release_driver()
> 	meson_mmc_remove()
> 		mmc_free_host() /* Freeing host memory */
> 	...
> 	devres_release_all()
> 		devm_irq_release()
> 			__free_irq()
> 				meson_mmc_irq() /* Uses freed memory */
> 
> To avoid this, the irq is released in meson_mmc_remove() before
> mmc_free_host() gets called.
> 

Oups, I missed the fact that the same can happen if probe() callback
fails after allocating the irq.

I will send a V2 for that.

-- 
Remi
