Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C94CFC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB5920660
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UsQYqjVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB5920660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933335AbeFLUAU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:00:20 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35558 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754176AbeFLUAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:00:18 -0400
Received: by mail-pf0-f195.google.com with SMTP id c22-v6so93792pfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8LkFf2fXaUU4h2T1CfgXtOWc4mSHkZzasd3tFpiF7Ew=;
        b=UsQYqjViJgkNkYe6KBgNNLXkjy21IfV4/Gt5FKY6+dJt7Ga5Lg71srswXAnEHT4bgC
         AMNIRRCv2zAvWkoVOlWMfToxc+GmDtETbDllKpva6UC+kAHEu2bBB41f381rope740TE
         ZwBUqud0cTxleZXmKr+ipUDELPTRWVDNQB87M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8LkFf2fXaUU4h2T1CfgXtOWc4mSHkZzasd3tFpiF7Ew=;
        b=uN4AGE3don5SRKmVbigxdSPM9Q/r/6kqm5VfJfFfhek2qMRU9rUJuJFn9d8OTFcDMe
         Ds4a+EmFJzlHWMqQQJuqnSdC0hcwQWbHi/ZQd0W0t6Gr+6BM8iZAuxx+5hGRCPupKc4N
         OJqHvqRWqjiGXYSBwKbWbE7SuVGJK8MRkYsOggpfBXUEM5o+/lNws9c69W6Wf8wqG7+X
         6FVRzb1FExN6rhi/Q/8YP9TGJ5nIXAUIXwe2Hx+zQGRfKXJwqgkFzBV7UncOtEBp6hui
         O9vtLnIwoG2gKIvR+WEDiJx1zPk+EswFeCE97FyR2q1KvMhvDTOJuYrcZsRCTEyBFtND
         n54A==
X-Gm-Message-State: APt69E3lqPDuNG0/h5oZIu6U6s6CjB/bOKMTIyNViFxzWN5aelt5kA3x
        aKy4cRHxQDK0Xu7WRqmpa6gXnQ==
X-Google-Smtp-Source: ADUXVKL+JyFEbismcbw9iDJA6g5wsGh4MRXTMCB+aDkarZrNU/aeFvz521s/A7CMNXsmslbefN7SWQ==
X-Received: by 2002:a62:8b9b:: with SMTP id e27-v6mr1859864pfl.82.1528833617943;
        Tue, 12 Jun 2018 13:00:17 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id k9-v6sm1212066pgs.49.2018.06.12.13.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 13:00:16 -0700 (PDT)
Date:   Tue, 12 Jun 2018 13:00:14 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v2 09/11] misc: throttler: Add core support for
 non-thermal throttling
Message-ID: <20180612200012.GA99983@rodete-desktop-imager.corp.google.com>
References: <20180607181214.30338-1-mka@chromium.org>
 <20180607181214.30338-10-mka@chromium.org>
 <20180612014911.GA35749@rodete-desktop-imager.corp.google.com>
 <20180612171140.GH88063@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612171140.GH88063@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 12, 2018 at 10:11:40AM -0700, Matthias Kaehlcke wrote:
> On Mon, Jun 11, 2018 at 06:49:13PM -0700, Brian Norris wrote:
> > On Thu, Jun 07, 2018 at 11:12:12AM -0700, Matthias Kaehlcke wrote:
> > > The purpose of the throttler is to provide support for non-thermal
> > > throttling. Throttling is triggered by external event, e.g. the
> > > detection of a high battery discharge current, close to the OCP limit
> > > of the battery. The throttler is only in charge of the throttling, not
> > > the monitoring, which is done by another (possibly platform specific)
> > > driver.
> > > 
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > Changes in v2:
> > > - completely reworked the driver to support configuration through OPPs, which
> > >   requires a more dynamic handling
> > > - added sysfs attribute to set the level for debugging and testing
> > > - Makefile: depend on Kconfig option to traverse throttler directory
> > > - Kconfig: removed 'default n'
> > > - added SPDX line instead of license boiler-plate
> > > - added entry to MAINTAINERS file
> > > 
> > > 
> > >  MAINTAINERS                     |   7 +
> > >  drivers/misc/Kconfig            |   1 +
> > >  drivers/misc/Makefile           |   1 +
> > >  drivers/misc/throttler/Kconfig  |  14 +
> > >  drivers/misc/throttler/Makefile |   1 +
> > >  drivers/misc/throttler/core.c   | 642 ++++++++++++++++++++++++++++++++
> > >  include/linux/throttler.h       |  11 +
> > >  7 files changed, 677 insertions(+)
> > >  create mode 100644 drivers/misc/throttler/Kconfig
> > >  create mode 100644 drivers/misc/throttler/Makefile
> > >  create mode 100644 drivers/misc/throttler/core.c
> > >  create mode 100644 include/linux/throttler.h
> > > 

...

> > > diff --git a/drivers/misc/throttler/Kconfig b/drivers/misc/throttler/Kconfig
> > > new file mode 100644
> > > index 000000000000..e561f1df5085
> > > --- /dev/null
> > > +++ b/drivers/misc/throttler/Kconfig
> > > @@ -0,0 +1,14 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +
> > > +menuconfig THROTTLER
> > > +	bool "Throttler support"
> > > +	depends on OF
> > > +	select CPU_FREQ
> > > +	select PM_DEVFREQ
> > 
> > I'm curious whether we're actually truly compile-time dependent on
> > {CPU,DEV}FREQ? It seems like those subsystems mostly stub out stuff so
> > they fall back to no-ops if not built in.
> >
> > I know that's not very useful for your existing throttler, since it
> > wouldn't be very effective if one or both were disabled.
> 
> The idea is not to depend on both options being enabled, since
> throttling of one type might be all that is needed.

OK, then if you fix the build errors...don't do these 'select's here?

> As the build bot pointed out cpufreq doesn't stub out all functions.
> Probably the cleanest way to work around this is to define a stub for
> cpufreq_update_policy() in the throttler when CONFIG_CPU_FREQ is not
> defined.

Might make sense.

Also, how is it that CONFIG_CPU_FREQ managed to not be defined, even
though you 'select'ed it? Was the kbuild error on some oddball
architecture that doesn't support CPU_FREQ?

> > > diff --git a/drivers/misc/throttler/core.c b/drivers/misc/throttler/core.c
> > > new file mode 100644
> > > index 000000000000..15b50c111032
> > > --- /dev/null
> > > +++ b/drivers/misc/throttler/core.c
> > > ...
> > > +// #define DEBUG_THROTTLER
> > 
> > Did you mean to leave your debug code in? Seems like you have some
> > related dead code under #ifdefs.
> 
> Yes, I left it in intentionally.
> 
> > (If you do want this, maybe it'd be better under debugfs, until somebody
> > really wants to formalize and document it.)
> 
> Since it is code that is never enabled in an official kernel build I
> found it simpler to use sysfs with a direct association with the
> device, instead of having <debugfs>/throttler/<throttler_name>/level.
> 
> If folks have strong opinions about using debugfs or not having the
> debug code at all I'm fine with changing/dropping it.

If you ever expect this to actually get merged, I'd think we should go
with one way or the other. Dead code is not appreciated in mainline, so
either make it something people can actually have a chance of using
(e.g., a CONFIG_* option or debugfs), or else drop it.

> > > +static int thr_init_freq_table(struct throttler *thr, struct device *opp_dev,
> > > +			       struct thr_freq_table *ft)
> > > +{
> > > +	struct device_node *np_opp_desc, *np_opp;
> > > +	int nchilds;
> > > +	uint32_t *freqs;
> > > +	int nfreqs = 0;
> > > +	int err = 0;
> > > +
> > > +	np_opp_desc = dev_pm_opp_of_get_opp_desc_node(opp_dev);
> > > +	if (!np_opp_desc)
> > > +		return -EINVAL;
> > > +
> > > +	nchilds = of_get_child_count(np_opp_desc);
> > > +	if (!nchilds) {
> > > +		err = -EINVAL;
> > > +		goto out_node_put;
> > > +	}
> > > +
> > > +	freqs = kzalloc(nchilds * sizeof(uint32_t), GFP_KERNEL);
> > > +	if (!freqs) {
> > > +		err = -ENOMEM;
> > > +		goto out_node_put;
> > > +	}
> > > +
> > > +	/* determine which OPPs are used by this throttler (if any) */
> > > +	for_each_child_of_node(np_opp_desc, np_opp) {
> > > +		int num_thr;
> > > +		int i;
> > > +
> > > +		num_thr = of_property_count_u32_elems(np_opp, "opp-throttlers");
> > > +		if (num_thr < 0)
> > > +			continue;
> > > +
> > > +		for (i = 0; i < num_thr; i++) {
> > > +			struct device_node *np_thr;
> > > +			struct platform_device *pdev;
> > > +
> > > +			np_thr = of_parse_phandle(np_opp, "opp-throttlers", i);
> > > +			if (!np_thr) {
> > > +				dev_err(thr->dev,
> > > +					"failed to parse phandle %d: %s\n", i,
> > > +					np_opp->full_name);
> > > +				continue;
> > > +			}
> > > +
> > > +			pdev = of_find_device_by_node(np_thr);
> > > +			if (!pdev) {
> > > +				dev_err(thr->dev,
> > > +					"could not find throttler dev: %s\n",
> > > +					 np_thr->full_name);
> > > +				of_node_put(np_thr);
> > > +				continue;
> > > +			}
> > > +
> > > +			/* OPP is used by this throttler */
> > > +			if (&pdev->dev == thr->dev) {
> > 
> > So you're assuming that all throttlers are platform devices? Seems
> > slightly shaky; I could easily imagine a similar device that's a SPI or
> > I2C device.
> 
> As of now that's the only existing throttler. Adding handling for
> throttlers on other buses that might never be implemented seems
> premature. If throttlers with other bus types are added the core
> code can be extended to support this using
> of_find_i2c_device_by_node(), of_find_spi_device_by_node(), etc

I suppose...but it feels like there should be a better way to do this
that isn't specific to a particular bus.

If you're not going to fix this, then maybe you should force callers to
pass a plaform_device instead of device, to make it extra clear that
other devices are not supported.

Brian
