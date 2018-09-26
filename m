Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BCAC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F1C2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F1C2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeIZTuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:50:55 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47531 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeIZTuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:50:54 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <pza@pengutronix.de>)
        id 1g5A0Z-0004TO-Jg; Wed, 26 Sep 2018 15:37:39 +0200
Received: from pza by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <pza@pengutronix.de>)
        id 1g5A0Y-0005wG-1C; Wed, 26 Sep 2018 15:37:38 +0200
Date:   Wed, 26 Sep 2018 15:37:38 +0200
From:   Philipp Zabel <pza@pengutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: imx-pxp: include linux/interrupt.h
Message-ID: <20180926133738.GA19690@pengutronix.de>
References: <20180926130139.2320343-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926130139.2320343-1-arnd@arndb.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:32:04 up 132 days,  1:12, 183 users,  load average: 2.06, 2.81,
 4.27
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: pza@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, Sep 26, 2018 at 03:01:26PM +0200, Arnd Bergmann wrote:
> The newly added driver fails to build in some configurations due to a
> missing header inclusion:

Thank you, did you see this error on an older kernel version and rebase
the patch afterwards?

> drivers/media/platform/imx-pxp.c:988:8: error: unknown type name 'irqreturn_t'
>  static irqreturn_t pxp_irq_handler(int irq, void *dev_id)
>         ^~~~~~~~~~~
> drivers/media/platform/imx-pxp.c: In function 'pxp_irq_handler':
> drivers/media/platform/imx-pxp.c:1012:9: error: 'IRQ_HANDLED' undeclared (first use in this function); did you mean 'IRQ_MODE'?
>   return IRQ_HANDLED;
>          ^~~~~~~~~~~
>          IRQ_MODE
> drivers/media/platform/imx-pxp.c:1012:9: note: each undeclared identifier is reported only once for each function it appears in
> drivers/media/platform/imx-pxp.c: In function 'pxp_probe':
> drivers/media/platform/imx-pxp.c:1660:8: error: implicit declaration of function 'devm_request_threaded_irq'; did you mean 'devm_request_region'? [-Werror=implicit-function-declaration]
>   ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, pxp_irq_handler,
>         ^~~~~~~~~~~~~~~~~~~~~~~~~
>         devm_request_region
> drivers/media/platform/imx-pxp.c:1661:4: error: 'IRQF_ONESHOT' undeclared (first use in this function); did you mean 'SA_ONESHOT'?
>     IRQF_ONESHOT, dev_name(&pdev->dev), dev);
>
> Fixes: 51abcf7fdb70 ("media: imx-pxp: add i.MX Pixel Pipeline driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/media/platform/imx-pxp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/imx-pxp.c b/drivers/media/platform/imx-pxp.c
> index 229c23ae4029..b76cd0e8313c 100644
> --- a/drivers/media/platform/imx-pxp.c
> +++ b/drivers/media/platform/imx-pxp.c
> @@ -16,6 +16,7 @@
>  #include <linux/interrupt.h>

This line was recently added in commit b4fbf423cef9 ("media: imx-pxp:
fix compilation on i386 or x86_64")

>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> +#include <linux/interrupt.h>

So this should not be necessary anymore.

>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/sched.h>
> -- 
> 2.18.0
> 
> 

regards
Philipp
