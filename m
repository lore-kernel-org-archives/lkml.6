Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB367C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4722082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547653193;
	bh=PEudjCXimqi3wHtjBM4HU2HIpO6DWL+KSri+QLk5FTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ukE+40MrvT9e7dHVSPrX/orU+8ym+/tpkn+j5kcppw/LH7OBNnR4ijIed0ugmzdVJ
	 +GTXEdmn1eXPcvJ3Sol73XO7lbcXLoWODxvFUKJq2msbhgeW+PRF9IACqkdNSnuoef
	 QUSi8otidbiYHtYC7yHlPPjb+qZIpNeEl99RsAcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394149AbfAPPjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:39:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:48428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391472AbfAPPjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:39:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E450B20675;
        Wed, 16 Jan 2019 15:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547653190;
        bh=PEudjCXimqi3wHtjBM4HU2HIpO6DWL+KSri+QLk5FTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oaIuu4SI+d3eQeefbWuwkH8qZ8F+SCf8kKML1HTGynqR+/A8OQsRCcW6QBnd+Se8G
         sOwfZHfT3MGaAV8IXSDxt4PPOjvqfRmY4S8AEEkYrfl3jZD/Nn9m2HOz+/LqzPrnWw
         9zNe3c/h/wvGGakahDvrkEuXeXgMIfIKLg0VX45M=
Date:   Wed, 16 Jan 2019 16:39:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        will.deacon@arm.com, mark.rutland@arm.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com, ast@kernel.org,
        hpa@zytor.com, suzuki.poulose@arm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/7] coresight: perf: Add "sinks" group to PMU directory
Message-ID: <20190116153948.GC871@kroah.com>
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
 <20190115230742.13730-3-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115230742.13730-3-mathieu.poirier@linaro.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 04:07:37PM -0700, Mathieu Poirier wrote:
> Add a "sinks" directory entry so that users can see all the sinks
> available in the system in a single place.  Individual sink are added
> as they are registered with the coresight bus.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  .../hwtracing/coresight/coresight-etm-perf.c  | 43 +++++++++++++++++++
>  .../hwtracing/coresight/coresight-etm-perf.h  |  1 +
>  drivers/hwtracing/coresight/coresight.c       | 17 ++++++++
>  3 files changed, 61 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index f21eb28b6782..292bd409a68c 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -14,6 +14,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/percpu-defs.h>
>  #include <linux/slab.h>
> +#include <linux/stringhash.h>
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
>  
> @@ -43,8 +44,18 @@ static const struct attribute_group etm_pmu_format_group = {
>  	.attrs  = etm_config_formats_attr,
>  };
>  
> +static struct attribute *etm_config_sinks_attr[] = {
> +	NULL,
> +};
> +
> +static const struct attribute_group etm_pmu_sinks_group = {
> +	.name   = "sinks",
> +	.attrs  = etm_config_sinks_attr,
> +};
> +
>  static const struct attribute_group *etm_pmu_attr_groups[] = {
>  	&etm_pmu_format_group,
> +	&etm_pmu_sinks_group,
>  	NULL,
>  };
>  
> @@ -479,6 +490,38 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
>  	return 0;
>  }
>  
> +static ssize_t etm_perf_sink_name_show(struct device *dev,
> +				       struct device_attribute *dattr,
> +				       char *buf)
> +{
> +	/* See function coresight_sink_by_id() to know where this is used */
> +	u32 hash = hashlen_hash(hashlen_string(NULL, dattr->attr.name));
> +
> +	return scnprintf(buf, PAGE_SIZE, "%x\n", hash);
> +}
> +
> +int etm_perf_symlink_sink(struct coresight_device *csdev)
> +{
> +	struct device *pmu_dev = etm_pmu.dev;
> +	struct device *pdev = csdev->dev.parent;
> +	struct device_attribute *dev_attr;
> +
> +	if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
> +	    csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
> +		return -EINVAL;
> +
> +	if (!etm_perf_up)
> +		return -EPROBE_DEFER;
> +
> +	dev_attr = kzalloc(sizeof(*dev_attr), GFP_KERNEL);
> +	dev_attr->attr.name = kstrdup(dev_name(pdev), GFP_KERNEL);
> +	dev_attr->attr.mode = 0444;
> +	dev_attr->show = etm_perf_sink_name_show;
> +
> +	return sysfs_add_file_to_group(&pmu_dev->kobj,
> +				       &dev_attr->attr, "sinks");

What is so odd about this call that you needed me to review this?

And what happens if this call fails, do you leak memory?

thanks,

greg k-h
