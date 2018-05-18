Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeERRi1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 13:38:27 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46044 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751897AbeERRiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 13:38:23 -0400
X-Google-Smtp-Source: AB8JxZrAB93acmm2wgJfrOlGyWcGJPE2aBv+zXCY6NIzaK95mCp0VNZf9drfGMOS1RX0cF7KMGeYMw==
Date: Fri, 18 May 2018 10:38:20 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] PM / devfreq: Remove redundant frequency adjustment from
 governors
Message-ID: <20180518173820.GB29467@google.com>
References: <CGME20180516211119epcas2p4370ceb0c9d959bd1441fa71493a9b0e0@epcas2p4.samsung.com>
 <20180516211051.78875-1-mka@chromium.org>
 <5AFCDE68.6000804@samsung.com>
 <20180517154705.GN19594@google.com>
 <5AFE0D2B.6090201@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5AFE0D2B.6090201@samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 08:15:55AM +0900, Chanwoo Choi wrote:
> Hi,
> 
> On 2018년 05월 18일 00:47, Matthias Kaehlcke wrote:
> > Hi,
> > 
> > On Thu, May 17, 2018 at 10:44:08AM +0900, Chanwoo Choi wrote:
> >> Hi,
> >>
> >> On 2018년 05월 17일 06:10, Matthias Kaehlcke wrote:
> >>> The performance, powersave, simpleondemand and userspace governors
> >>> determine a target frequency and then adjust it according to the
> >>> df->min/max_freq limits that might have been set by user space. This
> >>> adjustment is redundant, it is done in update_devfreq() for any
> >>> governor, right after governor->get_target_freq().
> >>>
> >>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> >>> ---
> >>>  drivers/devfreq/governor_performance.c    | 10 ++--------
> >>>  drivers/devfreq/governor_powersave.c      |  5 -----
> >>>  drivers/devfreq/governor_simpleondemand.c |  7 +------
> >>>  drivers/devfreq/governor_userspace.c      | 16 ++++------------
> >>>  4 files changed, 7 insertions(+), 31 deletions(-)
> >>>
> >>> diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
> >>> index 4d23ecfbd948..31ee30622c00 100644
> >>> --- a/drivers/devfreq/governor_performance.c
> >>> +++ b/drivers/devfreq/governor_performance.c
> >>> @@ -16,14 +16,8 @@
> >>>  static int devfreq_performance_func(struct devfreq *df,
> >>>  				    unsigned long *freq)
> >>>  {
> >>> -	/*
> >>> -	 * target callback should be able to get floor value as
> >>> -	 * said in devfreq.h
> >>> -	 */
> >>> -	if (!df->max_freq)
> >>> -		*freq = UINT_MAX;
> >>> -	else
> >>> -		*freq = df->max_freq;
> >>> +	*freq = UINT_MAX;
> >>> +
> >>
> >> It is difficult to understand why use UINT_MAX instead of df->max_freq.
> >>
> >> Instead, after merged the commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq
> >> when adding the devfreq device"), df->max/min_freq have the specific frequency
> >> value always. So, we can change it as following without UINT_MAX. 
> >>
> >> 	*freq = df->max_freq;
> > 
> > There are two reasons why I don't like to return df->max_freq:
> > 
> > 1. update_devfreq() already handles the user limits (which is what
> > min/max_freq actually are), no need to spread parts of this
> > additionally over all governors.
> 
> As I already commented, each function have to keep their own role.

Actually I agree on that :)

> Actually, this function doesn't know the future work in update_devfreq().
> Only, devfreq_performance_func have to set the maximum frequency to "*freq".
> It is role of performance governor.

My first point doesn't refer to the future work, but is about not
spreading the handling of the user defined limits without need into
the governors. Below I offer two alternatives (and a question) to
which you didn't reply.

> > 
> > 2. I plan to introduce the concept of a devfreq policy [1], which
> > would introduce another pair of frequencies, df->policy.min/max, and
> > min/max_freq would become df->policy.user.min/max. The governors would
> > then return df->policy.user.min/max, which isn't really incorrect
> > since update_devfreq() takes care of adjusting the value with
> > df->policy.min/max if needed, but it also isn't very clear. And we
> > almost certainly shouldn't additionally handle df->policy.min/max in
> > the governors.
> 
> I have not seen any patch. Also, it is not proper to discuss on this patch
> because this patch doesn't include devfreq policy(?).
> 
> > 
> > I agree though that just returning UINT_MAX isn't very clear either,
> > even though that's what some governors are doing currently when
> > df->min/max_freq is not set (which can still occur, since user space
> > is free to set the value to 0).
> > 
> > I think there are two better options than returning df->min/max_freq:
> > 
> > a) create constants DEVFREQ_MIN/MAX_FREQ and return them, this clearly
> > states the intent.
> > 
> > b) return df->scaling_min/max_freq, which is the min/max frequency
> > that is actually available on the device side, depending on the
> > enabled OPPs.
> > 
> > A slightly related question: Is it actually intended to keep
> > supporting a value of 0 for df->min/max_freq to keep backwards
> > compatibility, or should the related code be removed?
> > 
> > Thanks
> > 
> > Matthias
> > 
> > [1] https://patchwork.kernel.org/patch/10401999/ (first draft, without
> > df->policy.min/max)
> > 
> > 
> > 
> 
> And when you reply, please remain previous my comments of another point.

Sorry, it wasn't my intention to 'ignore' your other comments. Since
they made similar points as the one to which I responded I didn't
consider it necessary to quote them below my reply, without me adding
anything that I hadn't already said above.

Best regards

Matthias
