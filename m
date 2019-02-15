Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993BEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6E121A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388704AbfBOKXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:23:02 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44483 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388071AbfBOKXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:23:01 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1guadu-0006rX-9h; Fri, 15 Feb 2019 11:22:50 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1guads-0006Oy-2E; Fri, 15 Feb 2019 11:22:48 +0100
Date:   Fri, 15 Feb 2019 11:22:48 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Claudiu.Beznea@microchip.com
Cc:     fabrice.gasnier@st.com, thierry.reding@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, alexandre.torgue@st.com,
        tduszyns@gmail.com, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, mcoquelin.stm32@gmail.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/3] pwm: core: add consumer device link
Message-ID: <20190215102248.i2mggrw74lgs2owq@pengutronix.de>
References: <1550055012-23348-1-git-send-email-fabrice.gasnier@st.com>
 <1550055012-23348-4-git-send-email-fabrice.gasnier@st.com>
 <f6fecafc-3946-9680-c58b-a20aa46e8e71@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6fecafc-3946-9680-c58b-a20aa46e8e71@microchip.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 09:23:48AM +0000, Claudiu.Beznea@microchip.com wrote:
> 
> 
> On 13.02.2019 12:50, Fabrice Gasnier wrote:
> > Add a device link between the PWM consumer and the PWM provider. This
> > enforces the PWM user to get suspended before the PWM provider. It
> > allows proper synchronization of suspend/resume sequences: the PWM user
> > is responsible for properly stopping PWM, before the provider gets
> > suspended: see [1]. Add the device link in:
> > - of_pwm_get()
> > - pwm_get()
> > - devm_ variants
> > as it requires a reference to the device for the PWM consumer.
> > 
> > [1] https://lkml.org/lkml/2019/2/5/770
> > 
> > Suggested-by: Thierry Reding <thierry.reding@gmail.com>
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > ---
> > Changes in v3:
> > - add struct device to of_get_pwm() arguments to handle device link from
> >   there.
> > ---
> >  drivers/pwm/core.c  | 14 +++++++++++---
> >  include/linux/pwm.h |  6 ++++--
> >  2 files changed, 15 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index 1581f6a..8cb5d4bc 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -638,6 +638,7 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
> >  
> >  /**
> >   * of_pwm_get() - request a PWM via the PWM framework
> > + * @dev: device for PWM consumer
> >   * @np: device node to get the PWM from
> >   * @con_id: consumer name
> >   *
> > @@ -655,7 +656,8 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
> >   * Returns: A pointer to the requested PWM device or an ERR_PTR()-encoded
> >   * error code on failure.
> >   */
> > -struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
> > +struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
> > +			      const char *con_id)
> >  {
> >  	struct pwm_device *pwm = NULL;
> >  	struct of_phandle_args args;
> > @@ -689,6 +691,9 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
> >  	if (IS_ERR(pwm))
> >  		goto put;
> >  
> > +	if (!device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
> > +		pr_debug("%s(): device link not added\n", __func__);
> > +
> 
> Just asking... will this mechanism also be working for PWMs requested via
> sysfs? At a first look it seems not.

No, but I would not expect a problem because AFAIU userspace is
suspended before kernel devices. However as userspace might not notice
the suspend it probably fails to stop the pwm and so will likely prevent
the suspend.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
