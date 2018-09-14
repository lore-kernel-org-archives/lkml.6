Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F81FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CE320882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45CE320882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbeINPwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:52:17 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49221 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbeINPwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:52:17 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1g0lUN-0004Cd-E5; Fri, 14 Sep 2018 12:38:15 +0200
Message-ID: <1536921493.4112.6.camel@pengutronix.de>
Subject: Re: [PATCH] ARC: HSDK: improve reset driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Date:   Fri, 14 Sep 2018 12:38:13 +0200
In-Reply-To: <20180827143803.28178-1-Eugeniy.Paltsev@synopsys.com>
References: <20180827143803.28178-1-Eugeniy.Paltsev@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugeniy,

On Mon, 2018-08-27 at 17:38 +0300, Eugeniy Paltsev wrote:
> As for today HSDK reset driver implements only
> .reset() callback.
> 
> In case of driver which implements one of standard
> reset controller usage pattern
> (call *_deassert() in probe(), call *_assert() in remove())
> that leads to inoperability of this reset driver.
> 
> Improve HSDK reset driver by calling .reset() callback inside of
> .assert()/.deassert() callbacks to avoid each reset controller
> user adaptation for work with both reset methods
> (reset() and .assert()/.deassert() pair)
> 
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
>  drivers/reset/reset-hsdk.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/reset/reset-hsdk.c b/drivers/reset/reset-hsdk.c
> index 8bce391c6943..1fd91df91343 100644
> --- a/drivers/reset/reset-hsdk.c
> +++ b/drivers/reset/reset-hsdk.c
> @@ -86,6 +86,8 @@ static int hsdk_reset_reset(struct reset_controller_dev *rcdev,
>  
>  static const struct reset_control_ops hsdk_reset_ops = {
>  	.reset	= hsdk_reset_reset,
> +	.assert = hsdk_reset_reset,

This is incorrect for exclusive reset controls.
It will cause reset_control_assert() to return success for exclusive
reset controls, even though the .assert op failed to leave the reset
line asserted after the function returns.

While calling hsdk_reset_reset from .assert for shared reset controls
would be fine, I don't see how this is necessary of useful.
If a consumer driver requires the reset to be asserted upon remove(), it
must not request a shared reset control anyway, because with shared
reset controls other drivers may keep the reset line deasserted
indefinitely.

> +	.deassert = hsdk_reset_reset,

This should be fine. I wonder from time to time whether this should be
implemented in the core, in reset_control_deassert().

regards
Philipp
