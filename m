Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06E4C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1722075B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kyOA4BrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1722075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933748AbeGFRHG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:07:06 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35525 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932857AbeGFRHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:07:03 -0400
Received: by mail-pf0-f193.google.com with SMTP id q7-v6so7821005pff.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 10:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=A+AU7Coob57Kx8P6f2aEN/kMWbn/fChfzDXyRaQk7VQ=;
        b=kyOA4BrYtS1O5bEeq/c3ovZpQKSJaONm4bqSxg4NpUZzMDwlG3WczN2WCpyRs8z++g
         n4OLS552yHk/qo9fxX+lGDFIQa60kSV0KwHYX/j8N4TlxvLUJQr4P9fHIzkyzTQ69LY0
         2ybp7DU7OwvoW1Zntx+LvY7s7xIT5tLY7OGYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=A+AU7Coob57Kx8P6f2aEN/kMWbn/fChfzDXyRaQk7VQ=;
        b=FckTLfIvVnj1Bsc0OGkIIMdl6578PMXLJ0RM5fGs657cHMN2dIXaz9Sj63hkwR284g
         DtUnVeI5iwpAVvy4ZgZUrt9V9KnpaoHhHRdPJmSC8rPgNEOr+tcToNB8TfliLep3T0Nq
         vj+34f1sCj9r8YmP1yK2MFmVZcNGn4KRyRuq9xP2Fy4XD3ORj6KJ9S8hJfxlMrRt0REe
         E8bsN3mzf4f26pmn0wlaTQLdsW+ou6t/MUN94wGe0GgQWW4X3cgznw0ONIzOx7f9cfYI
         TVrOD0ke5oKDHc4DihjdPraA6462JKyuyB1DTfOqgAJIkRb/XHDQ8Od1xSRSKwq3n+Ip
         LIwA==
X-Gm-Message-State: APt69E2dvOKHd5J+aPgZ44Hv5kInsfO50aXGqzy5vh/YRF1EonnVup1x
        7BudG7gOiq/RfQSwdDBx/PKDoA==
X-Google-Smtp-Source: AAOMgpetwriJix15SD6QifG1va2FnqOrUopMY6UHR/RZX1upRhecD17A+N1zl6e5+sLQm1QbVxiLlw==
X-Received: by 2002:a63:a042:: with SMTP id u2-v6mr9975121pgn.80.1530896822873;
        Fri, 06 Jul 2018 10:07:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id r6-v6sm12747895pgv.0.2018.07.06.10.07.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 10:07:02 -0700 (PDT)
Date:   Fri, 6 Jul 2018 10:07:01 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v5 04/12] PM / devfreq: Add struct devfreq_policy
Message-ID: <20180706170701.GF129942@google.com>
References: <20180703234705.227473-1-mka@chromium.org>
 <CGME20180703235030epcas4p423e7bf876628913adb3e41ffdc8ba3cd@epcas4p4.samsung.com>
 <20180703234705.227473-5-mka@chromium.org>
 <5B3C3632.1010706@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5B3C3632.1010706@samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 04, 2018 at 11:51:30AM +0900, Chanwoo Choi wrote:
> Hi,
> 
> On 2018년 07월 04일 08:46, Matthias Kaehlcke wrote:
> > Move variables related with devfreq policy changes from struct devfreq
> > to the new struct devfreq_policy and add a policy field to struct devfreq.
> > 
> > The following variables are moved:
> > 
> > df->min/max_freq           =>   p->user.min/max_freq
> > df->scaling_min/max_freq   =>   p->devinfo.min/max_freq
> > df->governor               =>   p->governor
> > df->governor_name          =>   p->governor_name
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > Reviewed-by: Brian Norris <briannorris@chromium.org>
> > ---
> > Changes in v5:
> > - none
> > 
> > Changes in v4:
> > - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
> > 
> > Changes in v3:
> > - none
> > 
> > Changes in v2:
> > - performance, powersave and simpleondemand governors don't need changes
> >   with "PM / devfreq: Don't adjust to user limits in governors"
> > - formatting fixes
> > ---
> >  drivers/devfreq/devfreq.c          | 137 ++++++++++++++++-------------
> >  drivers/devfreq/governor_passive.c |   4 +-
> >  include/linux/devfreq.h            |  38 +++++---


> >  3 files changed, 103 insertions(+), 76 deletions(-)
> > 
> 
> (skip)
> 
> >  
> > diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> > index 3bc29acbd54e..e0987c749ec2 100644
> > --- a/drivers/devfreq/governor_passive.c
> > +++ b/drivers/devfreq/governor_passive.c
> > @@ -99,12 +99,12 @@ static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
> >  {
> >  	int ret;
> >  
> > -	if (!devfreq->governor)
> > +	if (!devfreq->policy.governor)
> >  		return -EINVAL;
> >  
> >  	mutex_lock_nested(&devfreq->lock, SINGLE_DEPTH_NESTING);
> >  
> > -	ret = devfreq->governor->get_target_freq(devfreq, &freq);
> > +	ret = devfreq->policy.governor->get_target_freq(devfreq, &freq);
> >  	if (ret < 0)
> >  		goto out;
> >  
> > diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> > index 3aae5b3af87c..9bf23b976f4d 100644
> > --- a/include/linux/devfreq.h
> > +++ b/include/linux/devfreq.h
> > @@ -109,6 +109,30 @@ struct devfreq_dev_profile {
> >  	unsigned int max_state;
> >  };
> >  
> > +/**
> > + * struct devfreq_freq_limits - Devfreq frequency limits
> > + * @min_freq:	minimum frequency
> > + * @max_freq:	maximum frequency
> > + */
> > +struct devfreq_freq_limits {
> > +	unsigned long min_freq;
> > +	unsigned long max_freq;
> > +};
> > +
> > +/**
> > + * struct devfreq_policy - Devfreq policy
> > + * @user:	frequency limits requested by the user
> > + * @devinfo:	frequency limits of the device (available OPPs)
> > + * @governor:	method how to choose frequency based on the usage.
> 
> nitpick. remove '.' on the end of line.

Ok

> > + * @governor_name:	devfreq governor name for use with this devfreq
> > + */
> > +struct devfreq_policy {
> > +	struct devfreq_freq_limits user;
> > +	struct devfreq_freq_limits devinfo;
> > +	const struct devfreq_governor *governor;
> > +	char governor_name[DEVFREQ_NAME_LEN];
> > +};
> > +
> >  /**
> >   * struct devfreq - Device devfreq structure
> >   * @node:	list node - contains the devices with devfreq that have been
> > @@ -117,8 +141,6 @@ struct devfreq_dev_profile {
> >   * @dev:	device registered by devfreq class. dev.parent is the device
> >   *		using devfreq.
> >   * @profile:	device-specific devfreq profile
> > - * @governor:	method how to choose frequency based on the usage.
> > - * @governor_name:	devfreq governor name for use with this devfreq
> >   * @nb:		notifier block used to notify devfreq object that it should
> >   *		reevaluate operable frequencies. Devfreq users may use
> >   *		devfreq.nb to the corresponding register notifier call chain.
> > @@ -126,10 +148,7 @@ struct devfreq_dev_profile {
> >   * @previous_freq:	previously configured frequency value.
> >   * @data:	Private data of the governor. The devfreq framework does not
> >   *		touch this.
> > - * @min_freq:	Limit minimum frequency requested by user (0: none)
> > - * @max_freq:	Limit maximum frequency requested by user (0: none)
> > - * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
> > - * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
> > + * @policy:		Policy for frequency adjustments
> 
> The devfreq_policy contains the range of frequency and governor information.
> But, this description focus on the frequency. You need to explain the more
> correct description of 'policy'.

I wouldn't say that the focus is on 'frequency', but on 'frequency
adjustments', and the governor is an integral part of them.

I can change it to "Policy for frequency adjustments, including
frequency limits and the governor" if you prefer. I'm open to other
suggestions.

> >   * @stop_polling:	 devfreq polling status of a device.
> >   * @total_trans:	Number of devfreq transitions
> >   * @trans_table:	Statistics of devfreq transitions
> > @@ -151,8 +170,6 @@ struct devfreq {
> >  	struct mutex lock;
> >  	struct device dev;
> >  	struct devfreq_dev_profile *profile;
> > -	const struct devfreq_governor *governor;
> > -	char governor_name[DEVFREQ_NAME_LEN];
> >  	struct notifier_block nb;
> >  	struct delayed_work work;
> >  
> > @@ -161,10 +178,7 @@ struct devfreq {
> >  
> >  	void *data; /* private data for governors */
> >  
> > -	unsigned long min_freq;
> > -	unsigned long max_freq;
> > -	unsigned long scaling_min_freq;
> > -	unsigned long scaling_max_freq;
> > +	struct devfreq_policy policy;
> 
> I recommend that you better to move under 'struct devfreq_dev_profile'
> as following:
> 	
> 	struct devfreq_dev_profile *profile;
> 	struct devfreq_policy policy;

Will do

Thanks for the review!
