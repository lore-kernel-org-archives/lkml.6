Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933643AbeE2MAj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:00:39 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45081 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933391AbeE2MAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:00:33 -0400
X-Google-Smtp-Source: ADUXVKLXbnhiVY5FEHcIqum9iuG9K1tKMdx/CPvmDLE4O042Ji40uZEChLpAK6a64T5mFXo1BEZH6w==
From: Matti Vaittinen <mazziesaccount@gmail.com>
X-Google-Original-From: Matti Vaittinen <mvaittin@localhost.localdomain>
Date: Tue, 29 May 2018 15:00:28 +0300
To: Mark Brown <broonie@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        mazziesaccount@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v3 6/6] regulator: bd71837: BD71837 PMIC regulator driver
Message-ID: <20180529120028.GB13528@localhost.localdomain>
References: <cover.1527587295.git.matti.vaittinen@fi.rohmeurope.com>
 <68b0cf2c7ab5578eef2f71a33315bc8ab9a68a39.1527587295.git.matti.vaittinen@fi.rohmeurope.com>
 <20180529114740.GG23509@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529114740.GG23509@sirena.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, May 29, 2018 at 12:47:40PM +0100, Mark Brown wrote:
> On Tue, May 29, 2018 at 01:02:15PM +0300, Matti Vaittinen wrote:
> 
> > @@ -0,0 +1,677 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright (C) 2018 ROHM Semiconductors */
> > +/*
> > + * bd71837-regulator.c ROHM BD71837MWV regulator driver
> > + */
> 
> The SPDX header (and the rest of the block) need to be C++ comments.

Oh. My bad. I mixed up the C and Cpp style comments. So I will convert
the SPDX and following block to // (Cpp -style) comments.
> 
> > +static int bd71837_regulator_set_regmap(struct regulator_dev *rdev, int set)
> > +{
> > +	int ret = -EINVAL;
> > +	struct bd71837_pmic *pmic = rdev->reg_data;
> > +
> > +	/* According to the data sheet we must not change regulator voltage
> > +	 * when it is enabled. Thus we need to check if regulator is enabled
> > +	 * before changing the voltage. This mutex is used to avoid race where
> > +	 * we might enable regulator after it's state has been checked but
> > +	 * before the voltage is changed
> > +	 */
> > +	mutex_lock(&pmic->mtx);
> > +	if (!set)
> > +		ret = regulator_disable_regmap(rdev);
> > +	else
> > +		ret = regulator_enable_regmap(rdev);
> > +	mutex_unlock(&pmic->mtx);
> > +
> 
> This still has the weird locking/wrapper thing going on.  The regulator
> core will ensure that only one operation is called on a given regulator
> at once.
Ok. I''ll remove the mutex and wrapper since core handles this. Also,
after re-reading the data sheet I see that this restriction to voltage
changes (regulator must be disabled when voltage is changed) is not
mentioned for first 4 bucks. I will confirm if they can be changed when
enabled and also reflect this in next patch set.

> 
> > +static const struct regulator_desc bd71837_regulators[] = {
> > +	{
> > +	 .name = "buck1",
> 
> The indentation style here is weird, please follow CodingStyle.  Looks
> like the second level is just indented by a space for some reason, and
> there's similar problems elsewhere.
I'll change this too.

Br,
	Matti Vaittinen
