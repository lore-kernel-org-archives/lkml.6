Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752849AbeEGWyr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 18:54:47 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40827 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752158AbeEGWyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 18:54:46 -0400
X-Google-Smtp-Source: AB8JxZrko9i6Cfr/A/iqP0d2RzIyBgFziuHZM9dIa8ATYwDE/dHJdhCn3VqDtozU+oXSJw4Nt7h2/A==
Date: Mon, 7 May 2018 16:54:42 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, robert.walker@arm.com, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, sudeep.holla@arm.com,
        frowand.list@gmail.com, robh@kernel.org, john.horley@arm.com
Subject: Re: [PATCH v2 24/27] coresight: tmc-etr: Relax collection of trace
 from sysfs mode
Message-ID: <20180507225442.GC22194@xps15>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-25-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525165857-11096-25-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 10:10:54AM +0100, Suzuki K Poulose wrote:
> Since the ETR now uses mode specific buffers, we can reliably
> provide the trace data captured in sysfs mode, even when the ETR
> is operating in PERF mode.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index a35a12f..7551272 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1439,19 +1439,17 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
>  		goto out;
>  	}
>  
> -	/* Don't interfere if operated from Perf */
> -	if (drvdata->mode == CS_MODE_PERF) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
> -	/* If sysfs_buf is NULL the trace data has been read already */
> +	/*
> +	 * We can safely allow reads even if the ETR is operating in PERF mode,
> +	 * since the sysfs session is captured in mode specific data.
> +	 * If drvdata::sysfs_data is NULL the trace data has been read already.
> +	 */
>  	if (!drvdata->sysfs_buf) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
>  
> -	/* Disable the TMC if we are trying to read from a running session */
> +	/* Disable the TMC if we are trying to read from a running session. */

Move that to the previous patch.

>  	if (drvdata->mode == CS_MODE_SYSFS)
>  		tmc_etr_disable_hw(drvdata);
>  
> -- 
> 2.7.4
> 
