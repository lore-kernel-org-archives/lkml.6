Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA7EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D42C21871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545208308;
	bh=25FcZrnyAaynEKlrH4g1Skgm/+mVZaVhvlWlJvYz72g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0rMme88lDFwVqA7R+A6e3dWJkOUDwnNYhxnCGOilOVTqNlP5BFhHSqWEu23FJZLq8
	 1yJWTDl3Xq5keDDv3Wj2pHtsxiFHSOKiQSb7n6ePiHxVTbzslvUuC+6HNJu5Hc66M7
	 cMqmz+hAZelQFwQAXWU44tMwYZTDx+JflvkoOiOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbeLSIbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:31:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:59246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbeLSIbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:31:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA3E020675;
        Wed, 19 Dec 2018 08:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545208305;
        bh=25FcZrnyAaynEKlrH4g1Skgm/+mVZaVhvlWlJvYz72g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PowPuAL+EolvMno8YkcKQmssPmBdb9NY4utQB+xSIEdnsj3n4BI1xkAz+kqzRtH3G
         ephOW+dnQsBLxRXKOm0rzwuaoZ/OUCwWUoyAheOh2D6xzEfYkuc4mrVAj1R28coddm
         26zDkZ3lExSJZeu70zS7APiwfmvLhJzlvzNeOv2w=
Date:   Wed, 19 Dec 2018 09:31:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        will.deacon@arm.com, mark.rutland@arm.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com, ast@kernel.org,
        hpa@zytor.com, suzuki.poulosi@arm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH v5 2/6] perf/core: Use ioctl to communicate driver
 configuration to kernel
Message-ID: <20181219083143.GB31670@kroah.com>
References: <1545067306-31687-1-git-send-email-mathieu.poirier@linaro.org>
 <1545067306-31687-3-git-send-email-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545067306-31687-3-git-send-email-mathieu.poirier@linaro.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 10:21:42AM -0700, Mathieu Poirier wrote:
> This patch adds the mechanic needed for user space to send PMU specific
> configuration to the kernel driver using an ioctl() command.  That way
> events can keep track of options that don't fit in the perf_event_attr
> structure like the selection of a CoreSight sink to use for the session.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  include/linux/perf_event.h | 38 ++++++++++++++++++++++++++
>  kernel/events/core.c       | 67 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 105 insertions(+)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 53c500f0ca79..8e69b7e309e7 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -114,6 +114,14 @@ struct hw_perf_event_extra {
>  	int		idx;	/* index in shared_regs->regs[] */
>  };
>  
> +/*
> + * PMU driver configuration
> + */
> +struct pmu_drv_config {
> +	void		*config;
> +	raw_spinlock_t	lock;
> +};
> +
>  /**
>   * struct hw_perf_event - performance event hardware details:
>   */
> @@ -178,6 +186,9 @@ struct hw_perf_event {
>  	/* Last sync'ed generation of filters */
>  	unsigned long			addr_filters_gen;
>  
> +	/* PMU driver configuration */
> +	struct pmu_drv_config		drv_config;
> +
>  /*
>   * hw_perf_event::state flags; used to track the PERF_EF_* state.
>   */
> @@ -447,6 +458,17 @@ struct pmu {
>  	 * Filter events for PMU-specific reasons.
>  	 */
>  	int (*filter_match)		(struct perf_event *event); /* optional */
> +
> +	/*
> +	 * Validate complex PMU configuration that don't fit in the
> +	 * perf_event_attr struct.  Returns a PMU specific pointer or an error
> +	 * value < 0.
> +	 *
> +	 * As with addr_filters_validate(), runs in the context of the ioctl()
> +	 * process and is not serialized with the rest of the PMU callbacks.
> +	 */
> +	void *(*drv_config_validate)	(struct perf_event *event,
> +					 u64 value);
>  };
>  
>  enum perf_addr_filter_action_t {
> @@ -1235,6 +1257,11 @@ static inline bool has_addr_filter(struct perf_event *event)
>  	return event->pmu->nr_addr_filters;
>  }
>  
> +static inline bool has_drv_config(struct perf_event *event)
> +{
> +	return event->pmu->drv_config_validate;
> +}
> +
>  /*
>   * An inherited event uses parent's filters
>   */
> @@ -1249,6 +1276,17 @@ perf_event_addr_filters(struct perf_event *event)
>  	return ifh;
>  }
>  
> +static inline struct pmu_drv_config *
> +perf_event_get_drv_config(struct perf_event *event)
> +{
> +	struct pmu_drv_config *cfg = &event->hw.drv_config;
> +
> +	if (event->parent)
> +		cfg = &event->parent->hw.drv_config;
> +
> +	return cfg;
> +}
> +
>  extern void perf_event_addr_filters_sync(struct perf_event *event);
>  
>  extern int perf_output_begin(struct perf_output_handle *handle,
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 84530ab358c3..af7a53c97744 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5003,6 +5003,8 @@ static inline int perf_fget_light(int fd, struct fd *p)
>  static int perf_event_set_output(struct perf_event *event,
>  				 struct perf_event *output_event);
>  static int perf_event_set_filter(struct perf_event *event, void __user *arg);
> +static int perf_event_set_drv_config(struct perf_event *event,
> +				     void __user *arg);
>  static int perf_event_set_bpf_prog(struct perf_event *event, u32 prog_fd);
>  static int perf_copy_attr(struct perf_event_attr __user *uattr,
>  			  struct perf_event_attr *attr);
> @@ -5089,6 +5091,10 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
>  
>  		return perf_event_modify_attr(event,  &new_attr);
>  	}
> +
> +	case PERF_EVENT_IOC_SET_DRV_CONFIG:
> +		return perf_event_set_drv_config(event, (void __user *)arg);
> +
>  	default:
>  		return -ENOTTY;
>  	}
> @@ -9128,6 +9134,66 @@ static int perf_event_set_filter(struct perf_event *event, void __user *arg)
>  	return ret;
>  }
>  
> +static void perf_drv_config_replace(struct perf_event *event, void *drv_data)
> +{
> +	unsigned long flags;
> +	struct pmu_drv_config *drv_config = &event->hw.drv_config;
> +
> +	if (!has_drv_config(event))
> +		return;
> +
> +	/* Children take their configuration from their parent */
> +	if (event->parent)
> +		return;
> +
> +	/* Make sure the PMU doesn't get a handle on the data */
> +	raw_spin_lock_irqsave(&drv_config->lock, flags);
> +	drv_config->config = drv_data;
> +	raw_spin_unlock_irqrestore(&drv_config->lock, flags);
> +}
> +
> +static int
> +perf_event_process_drv_config(struct perf_event *event, u64 value)
> +{
> +	int ret = -EINVAL;
> +	void *drv_data;
> +
> +	/* Make sure ctx.mutex is held */
> +	lockdep_assert_held(&event->ctx->mutex);
> +
> +	/* Children take their configuration from their parent */
> +	if (WARN_ON_ONCE(event->parent))
> +		goto out;
> +
> +	drv_data = event->pmu->drv_config_validate(event, value);
> +	if (IS_ERR(drv_data)) {
> +		ret = PTR_ERR(drv_data);
> +		goto out;
> +	}
> +
> +	perf_drv_config_replace(event, drv_data);
> +
> +	ret = 0;
> +out:
> +	return ret;
> +}
> +
> +static int perf_event_set_drv_config(struct perf_event *event, void __user *arg)
> +{
> +	int ret;
> +	u64 value;
> +
> +	if (!has_drv_config(event))
> +		return -EINVAL;
> +
> +	if (copy_from_user(&value, arg, sizeof(value)))
> +		return -EFAULT;

You are just sending in a pointer to a u64?  Why not just pass a u64
directly instead?  Why is a pointer needed here?

thanks,

greg k-h
