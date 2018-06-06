Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BxQgY/MH"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 853946070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752296AbeFFGQ3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 02:16:29 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39948 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751536AbeFFGQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 02:16:27 -0400
X-Google-Smtp-Source: ADUXVKIjBNEZConqxJo7f5msqq5i2XiGykyUM0lpeMBvmPWB9GeG1SgG/7uNR4O1Lnri/ie3iaiATA==
Date: Wed, 6 Jun 2018 07:16:23 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 08/10] mfd: da9063: Register RTC only on DA9063L
Message-ID: <20180606061623.GT21163@dell>
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
 <20180602101155.26375-8-marek.vasut+renesas@gmail.com>
 <20180605075321.GM21163@dell>
 <ac43842f-7d8a-1d6d-7077-9fb58ab852b7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac43842f-7d8a-1d6d-7077-9fb58ab852b7@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Jun 2018, Marek Vasut wrote:

> On 06/05/2018 09:53 AM, Lee Jones wrote:
> > On Sat, 02 Jun 2018, Marek Vasut wrote:
> > 
> >> The DA9063L does not contain RTC block, unlike the full DA9063.
> >> Split the RTC block into separate mfd cell and register it only
> >> on DA9063.
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> >> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Cc: Lee Jones <lee.jones@linaro.org>
> >> Cc: Mark Brown <broonie@kernel.org>
> >> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
> >> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >> Cc: linux-renesas-soc@vger.kernel.org
> >> ---
> >> V2: No change
> >> V3: Rework of mfd: da9063: Disallow RTC on DA9063L
> >> ---
> >>  drivers/mfd/da9063-core.c | 30 +++++++++++++++++++++++-------
> >>  1 file changed, 23 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
> >> index eebca3442cf3..b05910c797af 100644
> >> --- a/drivers/mfd/da9063-core.c
> >> +++ b/drivers/mfd/da9063-core.c
> >> @@ -76,7 +76,7 @@ static struct resource da9063_hwmon_resources[] = {
> >>  };
> >>  
> >>  
> >> -static const struct mfd_cell da9063_devs[] = {
> >> +static const struct mfd_cell da9063_common_devs[] = {
> >>  	{
> >>  		.name		= DA9063_DRVNAME_REGULATORS,
> > 
> > Appreciate that these are historical, but these device name defines
> > make me shudder.  They only serve to act as an obfuscation layer when
> > debugging at platform level.  Please consider getting rid of them.
> 
> The macro can be shared between the core and the drivers, so the names
> never run out of sync.

Platform driver name changes are vary rare.  Even if they are changed,
even light testing would uncover the fact that child drivers do not
.probe().  Due to the current obfuscation, I currently have no idea
what this device's name is.  This technique is not allowed for new
drivers - unfortunately I didn't not review this driver in the first
instance.

It doesn't bother me enough to go and change it myself and I'm not
going to have a baby over patches not being submitted to fix it.

> >>  		.num_resources	= ARRAY_SIZE(da9063_regulators_resources),
> >> @@ -100,15 +100,19 @@ static const struct mfd_cell da9063_devs[] = {
> >>  		.resources	= da9063_onkey_resources,
> >>  		.of_compatible = "dlg,da9063-onkey",
> >>  	},
> >> +	{
> >> +		.name		= DA9063_DRVNAME_VIBRATION,
> >> +	},
> > 
> > Place this on a single line please.
> 
> This would only make the style inconsistent with the ie. LEDs entry.
> 
> >         { .name	= DA9063_DRVNAME_VIBRATION },

If that is a one line entry spaced over multiple lines, then that
should also be changed.

Maybe I will go through and stylise this driver a bit after all (but
as time is short at the moment, maybe not!) :)

[...]

> >> +err_mfd_cleanup:
> >> +	mfd_remove_devices(da9063->dev);
> > 
> > Any reason why you can't use devm_*?
> 
> Because we need to undo the MFD setup before the IRQ setup.

Sounds like a good enough reason.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
