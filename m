Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeEQWla (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 18:41:30 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42729 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbeEQWl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 18:41:28 -0400
X-Google-Smtp-Source: AB8JxZoxA0xFm+C+HhlpOH7jlhbyf/gDi7UW9QaQByfK8P6x+a1blC5P0s1xDffpk08i++7upK+uWQ==
Date: Thu, 17 May 2018 15:41:26 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] PM / devfreq: Remove redundant frequency adjustment from
 governors
Message-ID: <20180517224126.GP19594@google.com>
References: <20180516211051.78875-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180516211051.78875-1-mka@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 02:10:51PM -0700, Matthias Kaehlcke wrote:
> The performance, powersave, simpleondemand and userspace governors
> determine a target frequency and then adjust it according to the
> df->min/max_freq limits that might have been set by user space. This
> adjustment is redundant, it is done in update_devfreq() for any
> governor, right after governor->get_target_freq().
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/governor_performance.c    | 10 ++--------
>  drivers/devfreq/governor_powersave.c      |  5 -----
>  drivers/devfreq/governor_simpleondemand.c |  7 +------
>  drivers/devfreq/governor_userspace.c      | 16 ++++------------
>  4 files changed, 7 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
> index 4d23ecfbd948..31ee30622c00 100644
> --- a/drivers/devfreq/governor_performance.c
> +++ b/drivers/devfreq/governor_performance.c
> @@ -16,14 +16,8 @@
>  static int devfreq_performance_func(struct devfreq *df,
>  				    unsigned long *freq)
>  {
> -	/*
> -	 * target callback should be able to get floor value as
> -	 * said in devfreq.h
> -	 */
> -	if (!df->max_freq)
> -		*freq = UINT_MAX;
> -	else
> -		*freq = df->max_freq;
> +	*freq = UINT_MAX;
> +
>  	return 0;
>  }

For the record, the frequency adjustment in update_devfreq() is
currently broken for df->max_freq == 0:

https://patchwork.kernel.org/patch/10407827/
