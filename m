Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E614C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF70721480
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ehvVqcYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF70721480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933829AbeGFQg2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:36:28 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46651 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932730AbeGFQgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:36:25 -0400
Received: by mail-pf0-f196.google.com with SMTP id l123-v6so8864030pfl.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 09:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LgT2aijeViQcljpLulz4ZdJGwAyVIwV1NA4MNjvlYQw=;
        b=ehvVqcYaivU3Xkfr/6cU4K1ipobaN1CSMa5dyw2SpuNfnmXjqeLHfutb19zKVqq53b
         JQ80Mnx2/PJd31163lnZz9rkb4/BMbCYRk5BQpZYS2I67bV0Vs37OMNXlW86zXRDJYtA
         +22BccQgCDNyW0KkD3gWZWyIzrXhqQ/52kOgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LgT2aijeViQcljpLulz4ZdJGwAyVIwV1NA4MNjvlYQw=;
        b=rQeuGryEgtqEG/h/dIRYGEPEKBjEJbFQQ3Fhoz13/89IKPprDBpKL8tS9Oz00rNEbq
         wFlNDqc/Nf7Q3xlUnZlK8UHx94RDX/71TMYOr+v1cCoq5HWD9QoV9uX14jC6WlTlSDU5
         Gq649xD90WSj4ZvhxGgEuO2rPbBVtFGo+iGo9n4AVjkcKvp9UE8zal6NRY3D67MQA1EV
         9bSjApYyrY7n8w8ZdlvTJOLQNVPV8am1pPBTa8NMYOhXHW/vtL1b5C2zaGi2JXYEXu84
         AMPsb8NhF8vdk5rgNQP2s/cq66ni0obF0HWiv8VkvaXNjL5lWs+bAuVYEgKISTzBNsGw
         21MQ==
X-Gm-Message-State: APt69E2eWpoRvEWoUYVAPKkKHi1az6lwH47ZiNNBVclTTe30mlKvZZ9e
        SSFiWTLNHak45iU/hRN7hdLc2Q==
X-Google-Smtp-Source: AAOMgpf2702MSRivZsd6GH+wOtFRgF2KzNLHhruXYxITKPbsPzz6Zi/m7grc/jpLCe/M/KTCK6K3yQ==
X-Received: by 2002:a65:6688:: with SMTP id b8-v6mr4210269pgw.24.1530894985394;
        Fri, 06 Jul 2018 09:36:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id l11-v6sm12652167pgp.56.2018.07.06.09.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 09:36:24 -0700 (PDT)
Date:   Fri, 6 Jul 2018 09:36:24 -0700
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
Subject: Re: [PATCH v5 02/12] PM / devfreq: Fix handling of min/max_freq == 0
Message-ID: <20180706163624.GE129942@google.com>
References: <20180703234705.227473-1-mka@chromium.org>
 <CGME20180703235032epcas3p3443729f2230e205f1a0a4b03e6e8f62b@epcas3p3.samsung.com>
 <20180703234705.227473-3-mka@chromium.org>
 <5B3C2EEF.4080309@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5B3C2EEF.4080309@samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On Wed, Jul 04, 2018 at 11:20:31AM +0900, Chanwoo Choi wrote:
> Hi Matthias,
> 
> On 2018년 07월 04일 08:46, Matthias Kaehlcke wrote:
> > Commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when adding the
> > devfreq device") initializes df->min/max_freq with the min/max OPP when
> > the device is added. Later commit f1d981eaecf8 ("PM / devfreq: Use the
> > available min/max frequency") adds df->scaling_min/max_freq and the
> > following to the frequency adjustment code:
> > 
> >   max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);
> > 
> > With the current handling of min/max_freq this is incorrect:
> > 
> > Even though df->max_freq is now initialized to a value != 0 user space
> > can still set it to 0, in this case max_freq would be 0 instead of
> > df->scaling_max_freq as intended. In consequence the frequency adjustment
> > is not performed:
> > 
> >   if (max_freq && freq > max_freq) {
> > 	freq = max_freq;
> > 
> > To fix this set df->min/max freq to the min/max OPP in max/max_freq_store,
> > when the user passes a value of 0. This also prevents df->max_freq from
> > being set below the min OPP when df->min_freq is 0, and similar for
> > min_freq. Since it is now guaranteed that df->min/max_freq can't be 0 the
> > checks for this case can be removed.
> > 
> > Fixes: f1d981eaecf8 ("PM / devfreq: Use the available min/max frequency")
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
> > - handle freq tables sorted in ascending and descending order in
> >   min/max_freq_store()
> > - use same order for conditional statements in min/max_freq_store()
> > ---
> >  drivers/devfreq/devfreq.c | 42 ++++++++++++++++++++++++++++-----------
> >  1 file changed, 30 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index 0057ef5b0a98..6f604f8b2b81 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -283,11 +283,11 @@ int update_devfreq(struct devfreq *devfreq)
> >  	max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);
> >  	min_freq = MAX(devfreq->scaling_min_freq, devfreq->min_freq);
> >  
> > -	if (min_freq && freq < min_freq) {
> > +	if (freq < min_freq) {
> >  		freq = min_freq;
> >  		flags &= ~DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use GLB */
> >  	}
> > -	if (max_freq && freq > max_freq) {
> > +	if (freq > max_freq) {
> >  		freq = max_freq;
> >  		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
> >  	}
> > @@ -1122,18 +1122,27 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
> >  {
> >  	struct devfreq *df = to_devfreq(dev);
> >  	unsigned long value;
> > +	unsigned long *freq_table;
> 
> You can move 'freq_table' under 'else' statement.

Will do

> >  	int ret;
> > -	unsigned long max;
> >  
> >  	ret = sscanf(buf, "%lu", &value);
> >  	if (ret != 1)
> >  		return -EINVAL;
> >  
> >  	mutex_lock(&df->lock);
> > -	max = df->max_freq;
> > -	if (value && max && value > max) {
> > -		ret = -EINVAL;
> > -		goto unlock;
> > +
> > +	if (value) {
> > +		if (value > df->max_freq) {
> > +			ret = -EINVAL;
> > +			goto unlock;
> > +		}
> > +	} else {
> > +		freq_table = df->profile->freq_table;
> > +		/* typical order is ascending, some drivers use descending */
> 
> You better to explain what is doing of following code.
> How about modifying it as following?
> 
> 		/* Get minimum frequency according to sorting way */

Ok, will slightly modify it to 'sorting order' if you don't mind.

> > +		if (freq_table[0] < freq_table[df->profile->max_state - 1])
> > +			value = freq_table[0];
> > +		else
> > +			value = freq_table[df->profile->max_state - 1];
> >  	}
> >  
> >  	df->min_freq = value;
> > @@ -1157,18 +1166,27 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
> >  {
> >  	struct devfreq *df = to_devfreq(dev);
> >  	unsigned long value;
> > +	unsigned long *freq_table;
> 
> ditto. You can move 'freq_table' under 'else' statement.

Will do

> >  	int ret;
> > -	unsigned long min;
> >  
> >  	ret = sscanf(buf, "%lu", &value);
> >  	if (ret != 1)
> >  		return -EINVAL;
> >  
> >  	mutex_lock(&df->lock);
> > -	min = df->min_freq;
> > -	if (value && min && value < min) {
> > -		ret = -EINVAL;
> > -		goto unlock;
> > +
> > +	if (value) {
> > +		if (value < df->min_freq) {
> > +			ret = -EINVAL;
> > +			goto unlock;
> > +		}
> > +	} else {
> > +		freq_table = df->profile->freq_table;
> > +		/* typical order is ascending, some drivers use descending */
> 
> ditto.
> 		/* Get maximum frequency according to sorting way */

Ok

> > +		if (freq_table[0] < freq_table[df->profile->max_state - 1])
> > +			value = freq_table[df->profile->max_state - 1];
> > +		else
> > +			value = freq_table[0];
> >  	}
> >  
> >  	df->max_freq = value;
> > 
> 
> If you agree my comment and modify this patch according to my comment,
> feel free to add my review tag.
> - Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks for the review!

Matthias
