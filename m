Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8E2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73AB32147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfBSIzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:55:25 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43561 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfBSIzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 03:55:24 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gw1BO-0003qJ-H8; Tue, 19 Feb 2019 09:55:18 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gw1BM-0004ss-Ho; Tue, 19 Feb 2019 09:55:16 +0100
Date:   Tue, 19 Feb 2019 09:55:16 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, tduszyns@gmail.com,
        mark.rutland@arm.com, alexandre.torgue@st.com,
        mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v4 3/3] pwm: core: add consumer device link
Message-ID: <20190219085516.dz5ux37kdszqkisy@pengutronix.de>
References: <1550139951-25788-1-git-send-email-fabrice.gasnier@st.com>
 <1550139951-25788-4-git-send-email-fabrice.gasnier@st.com>
 <20190218172223.lw3e5tn5hzsow6tg@pengutronix.de>
 <53bc3d80-8732-46be-caef-015998c9ad0e@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53bc3d80-8732-46be-caef-015998c9ad0e@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 09:46:32AM +0100, Fabrice Gasnier wrote:
> On 2/18/19 6:22 PM, Uwe Kleine-König wrote:
> > Hello,
> > 
> > On Thu, Feb 14, 2019 at 11:25:51AM +0100, Fabrice Gasnier wrote:
> >> Add a device link between the PWM consumer and the PWM provider. This
> >> enforces the PWM user to get suspended before the PWM provider. It
> >> allows proper synchronization of suspend/resume sequences: the PWM user
> >> is responsible for properly stopping PWM, before the provider gets
> >> suspended: see [1]. Add the device link in:
> >> - of_pwm_get()
> >> - pwm_get()
> >> - devm_*pwm_get() variants
> >> as it requires a reference to the device for the PWM consumer.
> >>
> >> [1] https://lkml.org/lkml/2019/2/5/770
> >>
> >> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
> >> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> >> ---
> >> Changes in v4:
> >> - rework error handling following Thierry's comments
> >> - turn/split pr_debug() into dev_err()/pr_warn().
> >>
> >> Changes in v3:
> >> - add struct device to of_get_pwm() arguments to handle device link from
> >>   there as discussed with Uwe.
> >> ---
> >>  drivers/pwm/core.c  | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
> >>  include/linux/pwm.h |  6 ++++--
> >>  2 files changed, 51 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> >> index 1581f6a..64e10a6 100644
> >> --- a/drivers/pwm/core.c
> >> +++ b/drivers/pwm/core.c
> >> @@ -636,8 +636,35 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
> >>  	return ERR_PTR(-EPROBE_DEFER);
> >>  }
> >>  
> >> +static struct device_link *pwm_device_link_add(struct device *dev,
> >> +					       struct pwm_device *pwm)
> >> +{
> >> +	struct device_link *dl;
> >> +
> >> +	if (!dev) {
> >> +		/*
> >> +		 * No device for the PWM consumer has been provided. It may
> >> +		 * impact the PM sequence ordering: the PWM supplier may get
> >> +		 * suspended before the consumer.
> >> +		 */
> >> +		pr_warn("no consumer dev, can't create device link to %s\n",
> >> +			dev_name(pwm->chip->dev));
> > 
> > Maybe use dev_warn(pwm->chip->dev, ...) ?
> 
> Hi Uwe,
> 
> I'm wondering a bit about this: In this case, the caller that doesn't
> provide a struct device *, PWM provider isn't responsible for that. So I
> just hope this wouldn't be miss-leading ?

IMHO it's more the wording that might make the message misleading. If
you use

	dev_warn(pwm->chip->dev, "No consumer device specified to create a device link to\n");

that's completely fine in my eyes.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
