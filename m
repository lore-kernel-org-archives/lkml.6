Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB474C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636F82086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636F82086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbeJLTkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:40:49 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50239 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbeJLTkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:40:49 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gAwFA-0005NX-1D; Fri, 12 Oct 2018 14:08:36 +0200
Message-ID: <1539346114.6204.5.camel@pengutronix.de>
Subject: Re: [PATCH v2] ARC: HSDK: improve reset driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>
Date:   Fri, 12 Oct 2018 14:08:34 +0200
In-Reply-To: <20180928162856.4726-1-Eugeniy.Paltsev@synopsys.com>
References: <20180928162856.4726-1-Eugeniy.Paltsev@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugeniy,

thank you for the update.

On Fri, 2018-09-28 at 19:28 +0300, Eugeniy Paltsev wrote:
> As for today HSDK reset driver implements only
> .reset() callback.
> 
> In case of driver which implements one of standard
> reset controller usage pattern
> (call *_deassert() in probe(), call *_assert() in remove())
> that leads to inoperability of this reset driver.
> 
> Improve HSDK reset driver by calling .reset() callback inside of
> .deassert() callback to avoid each reset controller
> user adaptation for work with both reset methods
> (reset() and {.assert() & .deassert()} pair)
> 
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
> Changes v1->v2:
>  * Don't call hsdk_reset_reset in .assert callback.
> 
>  drivers/reset/reset-hsdk.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/reset/reset-hsdk.c b/drivers/reset/reset-hsdk.c
> index 8bce391c6943..399440f197c5 100644
> --- a/drivers/reset/reset-hsdk.c
> +++ b/drivers/reset/reset-hsdk.c
> @@ -84,8 +84,21 @@ static int hsdk_reset_reset(struct reset_controller_dev *rcdev,
>  	return ret;
>  }
>  
> +static int hsdk_reset_dummy(struct reset_controller_dev *rcd, unsigned long id)
> +{
> +	return 0;
> +}
> +
> +/*
> + * Doing real reset from .assert isn't necessary/useful here. So we pass
> + * 'hsdk_reset_dummy' to .assert callback to prevent -ENOTSUPP returning by
> + * reset_control_assert() to make happy drivers which check
> + * reset_control_{assert | deassert} return status.
> + */
>  static const struct reset_control_ops hsdk_reset_ops = {
>  	.reset	= hsdk_reset_reset,
> +	.assert = hsdk_reset_dummy,

Is this part really necessary though? reset_control_assert already
returns 0 in shared mode, so the only thing this does is make
reset_control_assert return 0 instead of -ENOTSUPP in exclusive mode.

The documentation states that calling reset_control_assert "on an
exclusive reset controller guarantees that the reset will be asserted."
Since this is clearly not the case with this driver, it is appropriate
to keep returning an error in this case.

If there is a driver that requests an exclusive reset control, calls
reset_control_assert, and then checks the error value to see whether
asserting the reset succeeded, it should be made aware that
we couldn't actually assert the reset line as requested. If the driver
can continue operation even though the reset line was not asserted,
it should ignore the error.

So if you need to hide this error, I'd like to know the actual case that
is fixed by this, to see if we can't fix it in a better way.

> +	.deassert = hsdk_reset_reset,

This part is fine.

>  };
>  
>  static int hsdk_reset_probe(struct platform_device *pdev)

regards
Philipp
