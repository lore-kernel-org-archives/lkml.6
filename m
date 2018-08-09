Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F5FC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8729121EB7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8729121EB7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732612AbeHISws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 14:52:48 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44113 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732499AbeHISws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 14:52:48 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fnnm6-0002Au-EU; Thu, 09 Aug 2018 18:26:58 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fnnm0-0006R3-H9; Thu, 09 Aug 2018 18:26:52 +0200
Date:   Thu, 9 Aug 2018 18:26:52 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Esben Haabendal <esben.haabendal@gmail.com>
Cc:     linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yuan Yao <yao.yuan@freescale.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Phil Reid <preid@electromag.com.au>,
        Lucas Stach <l.stach@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Peter Rosin <peda@axentia.se>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] i2c: imx: Simplify stopped state tracking
Message-ID: <20180809162652.r34omvkctzxte422@pengutronix.de>
References: <20180709094304.8814-1-esben.haabendal@gmail.com>
 <20180709094304.8814-4-esben.haabendal@gmail.com>
 <20180724075919.iyysd7dtbddvbavq@pengutronix.de>
 <87k1ozzquk.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k1ozzquk.fsf@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 02:06:43PM +0200, Esben Haabendal wrote:
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
> 
> > On Mon, Jul 09, 2018 at 11:43:03AM +0200, Esben Haabendal wrote:
> >> From: Esben Haabendal <eha@deif.com>
> >> 
> >> Always update the stopped state when busy status have been checked.
> >> This is identical to what was done before, with the exception of error
> >> handling.
> >> Without this change, some errors cause the stopped state to be left in
> >> incorrect state in i2c_imx_stop(), i2c_imx_dma_read(), i2c_imx_read() and
> >> i2c_imx_xfer().
> >> 
> >> Signed-off-by: Esben Haabendal <eha@deif.com>
> >> ---
> >>  drivers/i2c/busses/i2c-imx.c | 12 ++++++------
> >>  1 file changed, 6 insertions(+), 6 deletions(-)
> >> 
> >> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> >> index d86f152176a4..1db8e6790afc 100644
> >> --- a/drivers/i2c/busses/i2c-imx.c
> >> +++ b/drivers/i2c/busses/i2c-imx.c
> >> @@ -421,10 +421,14 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
> >>  			return -EAGAIN;
> >>  		}
> >>  
> >> -		if (for_busy && (temp & I2SR_IBB))
> >> +		if (for_busy && (temp & I2SR_IBB)) {
> >> +			i2c_imx->stopped = 0;
> >>  			break;
> >> -		if (!for_busy && !(temp & I2SR_IBB))
> >> +		}
> >> +		if (!for_busy && !(temp & I2SR_IBB)) {
> >> +			i2c_imx->stopped = 1;
> >>  			break;
> >> +		}
> >
> > Would it make sense to assign to ->stopped independent of for_busy?
> 
> What do you mean?
> 
> Assigning to ->stopped on each check for I2SR_IBB in loop, independent
> of the for_busy argument?  I don't think so.  The additional assignments
> would be to the same value as it is set to already.

Currently you have:

	if (for_busy && (temp & I2SR_IBB)) {
		i2c_imx->stopped = 0;
		break;
	}

	if (!for_busy && !(temp & I2SR_IBB)) {
		i2c_imx->stopped = 1;
		break;
	}

The semantic of this is the same (apart from always updating .stopped)
but is imho easier:

	i2c_imx->stopped = !(temp & I2SR_IBB);

	if (for_busy != i2c_imx->stopped)
		break;

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
