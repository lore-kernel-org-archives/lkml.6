Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76017C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348212145D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvatuUG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348212145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbeKTEKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:10:32 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35376 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730035AbeKTEKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:10:31 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so707413pfi.2;
        Mon, 19 Nov 2018 09:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1Nz6K6tTbIPx/0PA10RXN50R62b6Obx3JqecWf0Avrk=;
        b=LvatuUG9GtDT0Ppeyo6XQfglFfwGxIt0tgOHIB5EAVsgm9bp/dP17FXcIaYV5rDzDy
         gF5Yq/F4iE9RRxwYIF4UIOw/I4eXq0mlYQ7Z5wCi+y5LcUnDl1C4Cb1iy5hCjx4hwDqy
         6dt6onHu/hccjunBEVAFZBvzn+9GOuaueub/rQk67V0vO/DdT2lrPKUllUaF/VPpZjVf
         XJ/wdHlpb+XJUS/wm6mrGUgBOIG6flPbD4wilO1SaffSOVZk+RqaRXKnmu17cCILdr3S
         Sl31LWASghOQL9xWAmYPH2DQcpScDG+PuPw1HV3j7Zx7w6sQ1Ey+eErQemWVQgXdlQtZ
         hxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1Nz6K6tTbIPx/0PA10RXN50R62b6Obx3JqecWf0Avrk=;
        b=qu9BZ/LHnIYDjVw2qAFOlad42dqJ2UkIxs/d3aIE3zIKdQRPdoywsXrBcjMVMNhVYQ
         X23PMVOEP8p13SvYE3aaqvYfOq5JP8OhOhcoQoECuO0zB9R1Gsd4iN9hCema1GhHFrfG
         3YFSdrtH+FdqMVM15O9uwNmsQ+hnbzUwLqqqQZLLOWKMnlBHhRwx07kWkrqzSemlFcAR
         QB2wIxepiMKKLf3YdiEu9SUT5Qe5veS7Z6IP+1OsXB+c4XQor0/Zu+fVhJignndSBkEC
         Gmn4OYIbEbojEeEGOr3FRSxbYagMBYR8WmdcqFGUw/Z2ZYp6Bvw+9OiPIivHx8ftbmDL
         M5yw==
X-Gm-Message-State: AGRZ1gISxC1v2BjT8bfE4x+PEeODYxyQbbCn4EuOCCew2ZsruqWy3Pqr
        sy0bfJ+arGx8ktWVAQPhVposic7P
X-Google-Smtp-Source: AJdET5eH+fpZoZsIF3LQKKvvRPLNDxq6ZKYSjKk3jrwDNCkytIh/9cDigp19VJ9l55V23SkpMa1jxA==
X-Received: by 2002:a63:f844:: with SMTP id v4mr20738175pgj.82.1542649561983;
        Mon, 19 Nov 2018 09:46:01 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v14sm58984206pgf.3.2018.11.19.09.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 09:46:00 -0800 (PST)
Date:   Mon, 19 Nov 2018 09:45:59 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] hwmon (ina3221) Add single-shot mode support
Message-ID: <20181119174559.GC27435@roeck-us.net>
References: <20181113042353.1507-1-nicoleotsuka@gmail.com>
 <20181113043248.GB11205@roeck-us.net>
 <20181113045823.GB26327@Asurada-Nvidia.nvidia.com>
 <20181113172102.GA21714@roeck-us.net>
 <20181114001141.GA14925@Asurada-Nvidia.nvidia.com>
 <20181114172330.GA25592@roeck-us.net>
 <20181117015131.GA10407@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117015131.GA10407@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 05:51:34PM -0800, Nicolin Chen wrote:
> Hello Guenter,
> 
> On Wed, Nov 14, 2018 at 09:23:30AM -0800, Guenter Roeck wrote:
> > > An alternative way (without the sysfs node), after looking at
> > > other hwmon code, could be to have a timed polling thread and
> > > read data using an update_interval value from ABI. This might
> > > turn out to be more complicated as it'll also involve settings
> > > of hardware averaging and conversion time. Above all, I cannot
> > > figure out a good threshold of update_interval to switch modes.
> > > 
> > update_interval should only be used if it can be configured
> > into hardware, not to trigger a polling thread. It should only
> > be used in the driver to determine caching intervals.
> 
> I see..so it's more like the conversion time settings instead.
> 
> > > If you can give some advice of a better implementation, that'd
> > > be great.
> > > 
> > From your description, the only real feasible solution would be a
> > generic one, with a well defined interface either to userspace or
> > to the kernel. The best I can think of would be an in-kernel API
> > setting the power operational mode via callbacks. Alternative would
> > be a generic ability to set power operational mode from userspace,
> > using an ABI which applies to all drivers, not just one.
> 
> Hmm. That would make the situation really complicated, I could
> understand your concern though.
> 
> I searched a little and found that, while the initial ina3221
> hwmon driver was under review, Laxman submitted an IIO version
> where Jonathan had a similar comments against its "mode" node:
> https://www.spinics.net/lists/linux-hwmon/msg00219.html
> 
> Quote from his comments {
>  * There is a lot of ABI in here concerned with oneshot vs continuous.
>  This seems to me to be more than it should be. We wouldn't expect to
>  see stuff changing as a result of switching between these modes other
>  than wrt to when the data shows up.  So I'd expect to not see this
>  directly exposed at all - but rather sit in oneshot unless either:
>  1) Buffered mode is running (not currently supported)
>  2) Alerts are on - which I think requires it to be in continuous mode.
> }
> 
> Since hwmon driver doesn't support buffered mode, what do you
> think about having the chip run in single-shot mode by default
> but changing it if alerts are on? Though the driver also needs
> to support to enable warning/critical alert pins.
> 
> In short, other than exposing it via a generic ABI to the user
> space, how about defining some policy to maintaining it within
> the driver?
> 
I think that would be a bad idea. It changes timing for everyone
curently using the driver. It also effectively disables monitoring,
which is the main purpose for using this chip (and other hardware
monitoring chips). This is indeed a key difference between iio
and hwmon - the main purpose of chips in the iio subsystem is to
be able report data efficiently to user space, not hardware monitoring.
I do not think it is appropriate to use iio requirements as argument
to change hwmon driver behavior (and vice versa).

Guenter
