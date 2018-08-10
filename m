Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E98C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF1B2154C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF1B2154C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbeHJOzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 10:55:14 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52297 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbeHJOzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 10:55:14 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fo6Tl-0004JF-LF; Fri, 10 Aug 2018 14:25:17 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fo6Tf-0003P0-3V; Fri, 10 Aug 2018 14:25:11 +0200
Date:   Fri, 10 Aug 2018 14:25:11 +0200
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
Message-ID: <20180810122511.2xnelcn6tguirfbp@pengutronix.de>
References: <20180709094304.8814-1-esben.haabendal@gmail.com>
 <20180709094304.8814-4-esben.haabendal@gmail.com>
 <20180724075919.iyysd7dtbddvbavq@pengutronix.de>
 <87k1ozzquk.fsf@gmail.com>
 <20180809162652.r34omvkctzxte422@pengutronix.de>
 <87zhxuo9o1.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zhxuo9o1.fsf@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Esben,

On Fri, Aug 10, 2018 at 11:25:34AM +0200, Esben Haabendal wrote:
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
> > Currently you have:
> >
> > 	if (for_busy && (temp & I2SR_IBB)) {
> > 		i2c_imx->stopped = 0;
> > 		break;
> > 	}
> >
> > 	if (!for_busy && !(temp & I2SR_IBB)) {
> > 		i2c_imx->stopped = 1;
> > 		break;
> > 	}
> >
> > The semantic of this is the same (apart from always updating .stopped)
> > but is imho easier:
> >
> > 	i2c_imx->stopped = !(temp & I2SR_IBB);
> >
> > 	if (for_busy != i2c_imx->stopped)
> > 		break;
> 
> Yes, that should work also.
> Shorter, but IMHO a bit more convoluted to read.
> Let me know if I should send a new version with this change.

unless someone else chimes in I'd say keep it as is. I'd prefer my
variant, but I accept that this is something subjective.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
