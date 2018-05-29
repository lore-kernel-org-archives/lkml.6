Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966406AbeE2S6H (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:58:07 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37556 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965761AbeE2S6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:58:00 -0400
X-Google-Smtp-Source: AB8JxZrOfZM1Wluzh4OYq3eyUQhUKk55DpB0cJHheSP9L34UPVZ8aRS0cxN5JPR1RYUCzw8ktFK+rQ==
Date: Tue, 29 May 2018 11:57:58 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        =?utf-8?B?w5hyamFu?= Eide <orjan.eide@arm.com>,
        John Einar Reitan <john.reitan@arm.com>
Subject: Re: [PATCH 02/11] PM / devfreq: Fix handling of min/max_freq == 0
Message-ID: <20180529185758.GG168650@google.com>
References: <20180525203043.249193-1-mka@chromium.org>
 <CGME20180525203323epcas4p45ba35c38413e227f76f68fe331011b19@epcas4p4.samsung.com>
 <20180525203043.249193-3-mka@chromium.org>
 <5B0BA3BB.8060505@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5B0BA3BB.8060505@samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 03:37:47PM +0900, Chanwoo Choi wrote:
> Hi,
> 
> On 2018년 05월 26일 05:30, Matthias Kaehlcke wrote:
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
> > ---
> >  drivers/devfreq/devfreq.c | 30 ++++++++++++++++++------------
> >  1 file changed, 18 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index 0057ef5b0a98..67da4e7b486b 100644
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
> > @@ -1123,17 +1123,20 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
> >  	struct devfreq *df = to_devfreq(dev);
> >  	unsigned long value;
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
> > +		value = df->profile->freq_table[df->profile->max_state - 1];
> >  	}
> 
> If you want to prevent that df->min_freq is zero, 
> you should reinitialize 'value' as following.
> Because freq_table must be in ascending order.
> 	value = df->profile->freq_table[0];

Thanks for pointing this out!

The devfreq device I tested with (a Mali GPU) uses descending order
for some reason, and I assumed that's the usual order.

https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.4/drivers/gpu/arm/midgard/backend/gpu/mali_kbase_devfreq.c#208

It seems the ordering doesn't have any impact beyond this patch. If
the order isn't mandatory for drivers that set up their own freq_table
we should probably support both cases to be safe.

> > @@ -1158,17 +1161,20 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
> >  	struct devfreq *df = to_devfreq(dev);
> >  	unsigned long value;
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
> > +	if (!value) {
> > +		value = df->profile->freq_table[0];
> 
> ditto.
> 	value = df->profile->freq_table[df->profile->max_state - 1];
> 
> > +	} else {
> > +		if (value < df->min_freq) {
> > +			ret = -EINVAL;
> > +			goto unlock;
> > +		}
> >  	}
> >  
> >  	df->max_freq = value;
> > 
> 
> Actually, min_freq_store() and max_freq_store() are very similar.
> But, this patch changed the order of conditional statement as following:
> If there is no special reason, you better to keep the same format
> for the readability.
> 
> 
> min_freq_store()
> 	if (value) {
> 		...
> 	} else {
> 		value = df->profile->freq_table[df->profile->max_state - 1];
> 	}
> 
> 
> max_freq_store()
> 	if (!value) {
> 		value = df->profile->freq_table[0];
> 	} else {
> 		...
> 

Agreed, better use the same format, I'll update it in the next revision.
