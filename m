Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeEQQft (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:35:49 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45780 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbeEQQfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:35:47 -0400
X-Google-Smtp-Source: AB8JxZpgF1LaH5CTQlUxpObPSoXCkPhoz5ktQYPyIxSfE3oMRy/7aNWj9+nBvhknV7ZMEDJElVebxw==
Date: Thu, 17 May 2018 09:35:43 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] PM / devfreq: Init user limits from OPP limits, not
 viceversa
Message-ID: <20180517163543.GO19594@google.com>
References: <CGME20180516225800epcas5p188094c0edfe8a9c3ffd3bfb9e48ce87c@epcas5p1.samsung.com>
 <20180516225709.153138-1-mka@chromium.org>
 <5AFCD5EC.5080200@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5AFCD5EC.5080200@samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 10:07:56AM +0900, Chanwoo Choi wrote:
> Hi,
> 
> On 2018년 05월 17일 07:57, Matthias Kaehlcke wrote:
> > Commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when adding
> > the devfreq device") introduced the initialization of the user
> > limits min/max_freq from the lowest/highest available OPPs. Later
> > commit f1d981eaecf8 ("PM / devfreq: Use the available min/max
> > frequency") added scaling_min/max_freq, which actually represent
> > the frequencies of the lowest/highest available OPP. scaling_min/
> > max_freq are initialized with the values from min/max_freq, which
> > is totally correct in the context, but a bit awkward to read.
> > 
> > Swap the initialization and assign scaling_min/max_freq with the
> > OPP freqs and then the user limts min/max_freq with scaling_min/
> > max_freq.
> > 
> > Needless to say that this change is a NOP, intended to improve
> > readability.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Additional context: I'm considering to introduce the concept of
> > a devfreq policy, which would probably move min/max_freq inside
> > of a struct policy, this would make the initialization even
> > more awkward to read. If this moves forward I might also propose
> > to rename scaling_min/max_freq to something like min/max_opp_freq
> > to avoid confusion with the frequencies in the policy (cpufreq uses
> > scaling_min/max_freq for the sysfs attributes of the policy
> > limits).
> > 
> >  drivers/devfreq/devfreq.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index fe2af6aa88fc..0057ef5b0a98 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -604,21 +604,21 @@ struct devfreq *devfreq_add_device(struct device *dev,
> >  		mutex_lock(&devfreq->lock);
> >  	}
> >  
> > -	devfreq->min_freq = find_available_min_freq(devfreq);
> > -	if (!devfreq->min_freq) {
> > +	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
> > +	if (!devfreq->scaling_min_freq) {
> >  		mutex_unlock(&devfreq->lock);
> >  		err = -EINVAL;
> >  		goto err_dev;
> >  	}
> > -	devfreq->scaling_min_freq = devfreq->min_freq;
> > +	devfreq->min_freq = devfreq->scaling_min_freq;
> >  
> > -	devfreq->max_freq = find_available_max_freq(devfreq);
> > -	if (!devfreq->max_freq) {
> > +	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
> > +	if (!devfreq->scaling_max_freq) {
> >  		mutex_unlock(&devfreq->lock);
> >  		err = -EINVAL;
> >  		goto err_dev;
> >  	}
> > -	devfreq->scaling_max_freq = devfreq->max_freq;
> > +	devfreq->max_freq = devfreq->scaling_max_freq;
> >  
> >  	dev_set_name(&devfreq->dev, "devfreq%d",
> >  				atomic_inc_return(&devfreq_no));
> > 
> 
> This patch just clean-up codes related to min/max_freq and scaling_min/max_freq.
> It seems be good.
> 
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks for the review!

> But, I don't want to change the name from 'scaling_min/max_freq'
> to 'min/max_opp_freq'.

It's obviously up to you in the end, and I won't insist if you are
convinced that scaling_min/max_freq is the better name (I suggest to
make this judgement after a new revision of the policy patch [1],
which likely will introduce another pair of frequencies, and naming
can help to clearly differentiate between them).

> You can check the meaning of variables in comment of struct devfreq.

This is true, but ideally code should be as self-explaining as
possible (without becoming too verbose ;-), and variable/function
names are a key element for that.

Best regards

Matthias

[1] https://patchwork.kernel.org/patch/10401999/
