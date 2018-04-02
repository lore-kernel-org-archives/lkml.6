Return-Path: <mathieu.poirier@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522704881; cv=none;
        d=google.com; s=arc-20160816;
        b=jslKkXQrOSRJzUpOiE37PHxwfrjcP50+2pnv9sh0xIaQd1OY8yQOuYVaeJ8eE3ecHw
         T+YIjY1lxlcfJf7ye9p52JP7WCzL96wXR884BpfQRUwo1WeqLo08d/M2RJLuYhN1gza2
         +Jqy5ZkVo3CkozgptUBEprsDbKc43IplCGCo4PTqhQZ2etSZMKoCqld4xFjUPDL/wGfQ
         4rKy32fl7rPsMISMbsFqdkeaVik/HsoOeIARwScrztSNmMLxvnHOwe5RpI4APElp+0WO
         6BbxUt8hM561wbFRbd7mAZfPmztkZDZ+R5vJmS1tMf49D6OhXGyAbHMYhCSoquUs5z5m
         65lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=my/7ODWSnRSdp+KD1BTh9MmSkFYi9fn5/R5YAwbX9tI=;
        b=DvgeGBYMlA7GrCLiWKTLsKqcp8um4uXlIGNmA5YKxA/L2CZkQmyj7X/zDjx8FGi3+w
         jr8gl8OrD6M2umRi94JRT/XqsCVSu+JJW/xbUi/FzuFLko7NwOESW2amtRJeqRBS7Mll
         qwOkA6z4P3Wo1sYTFxQIfYCPhDNgUJeETjObLhGITYS+ZpOwiJjmL8V3DdydmC2eSEeL
         6/aLwKPqieBtouBUPMV20NqJ8gQnTxkfU6mtvkOsC+BdqWm7+PwJAcjakL0i+5B1uWWv
         qYrHGF5A90ASTgF34xodtREpatCXgSaZWNNmU7X34xIoWHTBzV/6LPmrX25haPvjkXxi
         DjqA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=bduNZ9nO;
       spf=pass (google.com: domain of mathieu.poirier@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.poirier@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=bduNZ9nO;
       spf=pass (google.com: domain of mathieu.poirier@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.poirier@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx49ha1FDrwKXkZAdsli7zao/K28ZNo7ZNCde3wpfBOjFabhPgdcEQ6MhLV1FpGMi33TfOEtOjg==
Date: Mon, 2 Apr 2018 15:34:37 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Leo Yan <leo.yan@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	Kim Phillips <kim.phillips@arm.com>,
	Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v4 5/6] coresight: Set and clear sink device handler for
 kdump node
Message-ID: <20180402213437.GE15452@xps15>
References: <1522379724-30648-1-git-send-email-leo.yan@linaro.org>
 <1522379724-30648-6-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522379724-30648-6-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596330889082321383?=
X-GMAIL-MSGID: =?utf-8?q?1596671793972155452?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 11:15:23AM +0800, Leo Yan wrote:
> If Coresight path is enabled for specific CPU, the sink device handler
> need to be set to kdump node; on the other hand we also need to clear
> sink device handler when path is disabled.
> 
> This patch sets sink devices handler for kdump node for two separate
> Coresight enabling modes: CS_MODE_SYSFS and CS_MODE_PERF; and clear the
> handler when Coresight is disabled.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-etm-perf.c |  5 +++++
>  drivers/hwtracing/coresight/coresight.c          | 16 ++++++++++++++--
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 8a0ad77..f8b159c 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -139,6 +139,8 @@ static void free_event_data(struct work_struct *work)
>  	for_each_cpu(cpu, mask) {
>  		if (!(IS_ERR_OR_NULL(event_data->path[cpu])))
>  			coresight_release_path(event_data->path[cpu]);
> +
> +		coresight_kdump_sink(cpu, NULL);
>  	}
>  
>  	kfree(event_data->path);
> @@ -238,6 +240,9 @@ static void *etm_setup_aux(int event_cpu, void **pages,
>  		event_data->path[cpu] = coresight_build_path(csdev, sink);
>  		if (IS_ERR(event_data->path[cpu]))
>  			goto err;
> +
> +		if (coresight_kdump_sink(cpu, sink))
> +			goto err;

I remember telling you to use free_event_data() and etm_setup_aux().  _Maybe_ it
made sense in the previous patchset but in this one it won't work.  We need to
reflect the current trace context, as such use etm_event_start() and
etm_event_stop().

In etm_event_start() call coresight_kdump_sink(cpu, sink) just before
source_ops(csdev)->enable().  Similarly call coresight_kdump_sink(cpu, NULL)
right after source_ops(csdev)->disable() in etm_event_stop().

Find me on IRC if you want more information on this.

>  	}
>  
>  	if (!sink_ops(sink)->alloc_buffer)
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 389c4ba..483a1f7 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -272,6 +272,7 @@ static int coresight_enable_source(struct coresight_device *csdev, u32 mode)
>  static bool coresight_disable_source(struct coresight_device *csdev)
>  {
>  	if (atomic_dec_return(csdev->refcnt) == 0) {
> +

This newline shouldn't be part of this set.

>  		if (source_ops(csdev)->disable)
>  			source_ops(csdev)->disable(csdev, NULL);
>  		csdev->enable = false;
> @@ -612,6 +613,13 @@ int coresight_enable(struct coresight_device *csdev)
>  	if (ret)
>  		goto err_source;
>  
> +	cpu = source_ops(csdev)->cpu_id(csdev);
> +
> +	/* Set sink device handler into kdump node */
> +	ret = coresight_kdump_sink(cpu, sink);
> +	if (ret)
> +		goto err_kdump;
> +

Call coresight_kdump_sink() just before coresight_enable_source().  That way if
there is a dump just after coresight_enable_source() is called we get the chance
of getting some traces in the dump file. 

>  	switch (subtype) {
>  	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
>  		/*
> @@ -621,7 +629,6 @@ int coresight_enable(struct coresight_device *csdev)
>  		 * be a single session per tracer (when working from sysFS)
>  		 * a per-cpu variable will do just fine.
>  		 */
> -		cpu = source_ops(csdev)->cpu_id(csdev);
>  		per_cpu(tracer_path, cpu) = path;
>  		break;
>  	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
> @@ -636,6 +643,9 @@ int coresight_enable(struct coresight_device *csdev)
>  	mutex_unlock(&coresight_mutex);
>  	return ret;
>  
> +err_kdump:
> +	coresight_disable_source(csdev);
> +
>  err_source:
>  	coresight_disable_path(path);
>  
> @@ -659,9 +669,10 @@ void coresight_disable(struct coresight_device *csdev)
>  	if (!csdev->enable || !coresight_disable_source(csdev))
>  		goto out;
>  
> +	cpu = source_ops(csdev)->cpu_id(csdev);
> +
>  	switch (csdev->subtype.source_subtype) {
>  	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
> -		cpu = source_ops(csdev)->cpu_id(csdev);
>  		path = per_cpu(tracer_path, cpu);
>  		per_cpu(tracer_path, cpu) = NULL;
>  		break;
> @@ -674,6 +685,7 @@ void coresight_disable(struct coresight_device *csdev)
>  		break;
>  	}
>  
> +	coresight_kdump_sink(cpu, NULL);
>  	coresight_disable_path(path);
>  	coresight_release_path(path);
>  
> -- 
> 2.7.4
> 
