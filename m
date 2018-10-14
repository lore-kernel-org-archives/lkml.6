Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE77C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 20:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D519B20659
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 20:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D519B20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbeJOEHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 00:07:14 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36473 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725722AbeJOEHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 00:07:14 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gBmwd-0001ag-1m; Sun, 14 Oct 2018 22:24:59 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gBmwb-0002ny-4g; Sun, 14 Oct 2018 22:24:57 +0200
Date:   Sun, 14 Oct 2018 22:24:57 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>
Subject: Re: =?iso-8859-1?B?W1JDRqBQQVRDSCx2Miwy?= =?iso-8859-1?B?LzJd?= pwm:
 imx: Configure output to GPIO in disabled state
Message-ID: <20181014202457.dohwgz3frgcpdpy6@pengutronix.de>
References: <1539163920-9442-3-git-send-email-michal.vokac@ysoft.com>
 <20181012085720.GA9451@taurus.defre.kleine-koenig.org>
 <fa96ae2a-c2cc-b47a-1198-5daffa7c865f@ysoft.com>
 <20181012160854.hmgpokxgsrqdzobx@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181012160854.hmgpokxgsrqdzobx@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Oct 12, 2018 at 06:08:54PM +0200, Uwe Kleine-König wrote:
> > >> +	if (PTR_ERR(imx_chip->pwm_gpiod) == -EPROBE_DEFER) {
> > > 
> > > You must not use PTR_ERR on a value that might not contain an error
> > > pointer.
> > 
> > OK, thank you for valuable info.
> > So it seems like the I2C folks are in troubles as well:
> > 
> > 	https://elixir.bootlin.com/linux/latest/source/drivers/i2c/busses/i2c-imx.c#L996
> 
> correct. I cannot find this documented though.

I found in LDD3[1], chapter 11 on page 295:

	If you need the actual error code, it can be extracted with:

		long PTR_ERR(const void *ptr);

	You should use PTR_ERR only on a value for which IS_ERR returns a true
	value; any other value is a valid pointer.

That is probably where I have my claim from. There is no further
explanation though, so I'll post a patch adding a comment to the
definition of PTR_ERR to find out if there is a relevant reason.

Best regards
Uwe

[1] https://lwn.net/Kernel/LDD3/

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
