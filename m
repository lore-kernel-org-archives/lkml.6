Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7096CECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0DB20645
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0DB20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbeJQWVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:21:23 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46699 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQWVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:21:22 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gCmlG-0002By-Uk; Wed, 17 Oct 2018 16:25:22 +0200
Message-ID: <1539786321.4729.8.camel@pengutronix.de>
Subject: Re: [PATCH v3] ARC: HSDK: improve reset driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>
Date:   Wed, 17 Oct 2018 16:25:21 +0200
In-Reply-To: <20181017140552.7331-1-Eugeniy.Paltsev@synopsys.com>
References: <20181017140552.7331-1-Eugeniy.Paltsev@synopsys.com>
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

On Wed, 2018-10-17 at 17:05 +0300, Eugeniy Paltsev wrote:
> As for today HSDK reset driver implements only .reset() callback.
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
> Changes v2->v3:
>  * Drop dummy .assert callback.
> 
>  drivers/reset/reset-hsdk.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/reset/reset-hsdk.c b/drivers/reset/reset-hsdk.c
> index 8bce391c6943..4c7b8647b49c 100644
> --- a/drivers/reset/reset-hsdk.c
> +++ b/drivers/reset/reset-hsdk.c
> @@ -86,6 +86,7 @@ static int hsdk_reset_reset(struct reset_controller_dev *rcdev,
>  
>  static const struct reset_control_ops hsdk_reset_ops = {
>  	.reset	= hsdk_reset_reset,
> +	.deassert = hsdk_reset_reset,
>  };
>  
>  static int hsdk_reset_probe(struct platform_device *pdev)

Thank you, applied to reset/next

regards
Philipp
