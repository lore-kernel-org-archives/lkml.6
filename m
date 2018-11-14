Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0CDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471B922360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQniV8y4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 471B922360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732676AbeKOD1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:27:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40606 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725759AbeKOD1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 22:27:37 -0500
Received: by mail-pf1-f195.google.com with SMTP id x2-v6so8232585pfm.7;
        Wed, 14 Nov 2018 09:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=THQkpqGWdVhlq6lTUZ03lY3d0MZjiL2+uel/i3tjIb0=;
        b=CQniV8y4I3ZSZ1KPl3GHAWQ0QeqDly2dwig+BnBTr//HF/ONi6rAKbXn8qUfIBOrdw
         lsfmtTiv3Mz1P0yaJ5eUbnofRa2ZFqw6rIBtwTeGsK+jseA3fBPRwzo5mwB3hfLtT70x
         Xb4qPDlDSyHkJ0wJudpI3zHAYVlsAQC45jGfS+m1/ZGKfMl8MwVmAOzHARFoM0VzYK46
         TZjKg3x2Y1D8B1SbTb7x020sCsKvz6WQSwZIbYhffvdQVi7s5DC5+XsXjsXFHiBq49LA
         eJ+nPvsvrwbMujW4aVMIqc6Xj3uL22w2YE0Ys1aSQ/54zBBi5M/EIZmoESWBiatCPbCq
         p8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=THQkpqGWdVhlq6lTUZ03lY3d0MZjiL2+uel/i3tjIb0=;
        b=YKLe6Ri/n/zC9Adt6EERGU9P9qnApkJrlduZ8MXDsDUS9LhhO1JEtNFUCyeY0MZSaS
         j3mF5Ex2eHRBfcRiK8aE+HuvpfsRRYswurC1PLL9EyLjWOdyyyS8mXPpjtdzsWId3Sc9
         A0DCoH6FX7X5ai8dZ1uRhCmBqdpcAr/aEd78EwXwVHjWBZkUOKX/6vyedvmuAVsc2ZA5
         5c74fIgbpPRUzTWztOvhUj3EDRiivLIXNKxLXEVMTRjexr+vOfwmJxDmzSAVnubJ4/OJ
         1uMno9p5PMUkb7DLy/ke7QhMd3f1s66nvooBGAObG9g3rGdY7Q2jYrSaMAjL4a8XRYYy
         pd6A==
X-Gm-Message-State: AGRZ1gJSfYjxprabMyUsAtzMyu24drx4L6OZftagQ9GuEfMX/ZQnB4aN
        uzcfv6e1I7yrZFYxKejOduI=
X-Google-Smtp-Source: AJdET5cNA0/alWAgnzDyB2PIHw4sCrbscdJfz6BMFHWc/CXOklO2xwKrXGY8F+IwSkHFrNGBAkDoEw==
X-Received: by 2002:a62:5c6:: with SMTP id 189-v6mr2888169pff.193.1542216212707;
        Wed, 14 Nov 2018 09:23:32 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v84-v6sm33276713pfd.182.2018.11.14.09.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 09:23:31 -0800 (PST)
Date:   Wed, 14 Nov 2018 09:23:30 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] hwmon (ina3221) Add single-shot mode support
Message-ID: <20181114172330.GA25592@roeck-us.net>
References: <20181113042353.1507-1-nicoleotsuka@gmail.com>
 <20181113043248.GB11205@roeck-us.net>
 <20181113045823.GB26327@Asurada-Nvidia.nvidia.com>
 <20181113172102.GA21714@roeck-us.net>
 <20181114001141.GA14925@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114001141.GA14925@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 04:11:42PM -0800, Nicolin Chen wrote:
> Hi Guenter,
> 
> On Tue, Nov 13, 2018 at 09:21:02AM -0800, Guenter Roeck wrote:
> > > > > INA3221 supports both continuous and single-shot modes. When
> > > > > running in the continuous mode, it keeps measuring the inputs
> > > > > and converting them to the data register even if there are no
> > > > > users reading the data out. In this use case, this could be a
> > > > > power waste.
> > > > > 
> > > > > So this patch adds a single-shot mode support so that ina3221
> > > > > could do measurement and conversion only if users trigger it,
> > > > > depending on the use case where it only needs to poll data in
> > > > > a lower frequency.
> > > > > 
> > > > > The change also exposes "mode" and "available_modes" nodes to
> > > > > allow users to switch between two operating modes.
> > > > > 
> > > > Lots and lots of complexity for little gain. Sorry, I don't see
> > > > the point of this change.
> > > 
> > > The chip is causing considerable power waste on battery-powered
> > > devices so we typically use it running in the single-shot mode.
> > 
> > And you need to be able to do that with a sysfs attribute ?
> > Are you planning to have some code switching back and forth
> > between the modes ?
> >
> > You'll need to provide a good rationale why this needs to be
> > runtime configurable.
> 
> Honestly, our old downstream driver didn't expose it via sysfs.
> Instead, it had a built-in "governor" to switch modes based on
> the CPU hotplug state and cpufreq. However, the interface used
> to register a CPU hotplug notification was already deprecated.
> And I don't feel this governor is generic enough to be present
> in the mainline code.
> 
> For me, it's not that necessary to be a sysfs attribute. I try
> to add it merely because I cannot find a good criteria for the
> mode switching in a hwmon driver. So having an open sysfs node
> may allow user space power daemon to decide its operating mode,
> since it knows which power mode the system is running at: full
> speed (charging/charged) or power saving (on-battery), and it
> knows how often this exact service will poll the sensor data.
> 
That is bad, because it is not a generic implementation.
Userspace would have to account for each individual driver
one by one.

> An alternative way (without the sysfs node), after looking at
> other hwmon code, could be to have a timed polling thread and
> read data using an update_interval value from ABI. This might
> turn out to be more complicated as it'll also involve settings
> of hardware averaging and conversion time. Above all, I cannot
> figure out a good threshold of update_interval to switch modes.
> 
update_interval should only be used if it can be configured
into hardware, not to trigger a polling thread. It should only
be used in the driver to determine caching intervals.

> If you can give some advice of a better implementation, that'd
> be great.
> 
From your description, the only real feasible solution would be a
generic one, with a well defined interface either to userspace or
to the kernel. The best I can think of would be an in-kernel API
setting the power operational mode via callbacks. Alternative would
be a generic ability to set power operational mode from userspace,
using an ABI which applies to all drivers, not just one.

I don't know if any of those interfaces exists. If not, this will
require a discussion with upstream kernel maintainers, maybe with
a strawman proposal (set of patches). We can't just implement a
driver specific solution.

Guenter
