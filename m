Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD11C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C077D206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392028AbfAPK3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:29:32 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44880 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731556AbfAPK3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:29:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3F3D80D;
        Wed, 16 Jan 2019 02:29:31 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3BDE3F5AF;
        Wed, 16 Jan 2019 02:29:28 -0800 (PST)
Subject: Re: [PATCH 2/7] coresight: perf: Add "sinks" group to PMU directory
To:     mathieu.poirier@linaro.org, acme@kernel.org, peterz@infradead.org,
        gregkh@linuxfoundation.org
Cc:     mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org, hpa@zytor.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190115230742.13730-1-mathieu.poirier@linaro.org>
 <20190115230742.13730-3-mathieu.poirier@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <9819f0ad-d735-6c50-ffca-90f08153aad2@arm.com>
Date:   Wed, 16 Jan 2019 10:29:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115230742.13730-3-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/01/2019 23:07, Mathieu Poirier wrote:
> Add a "sinks" directory entry so that users can see all the sinks
> available in the system in a single place.  Individual sink are added
> as they are registered with the coresight bus.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   .../hwtracing/coresight/coresight-etm-perf.c  | 43 +++++++++++++++++++
>   .../hwtracing/coresight/coresight-etm-perf.h  |  1 +
>   drivers/hwtracing/coresight/coresight.c       | 17 ++++++++
>   3 files changed, 61 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index f21eb28b6782..292bd409a68c 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -14,6 +14,7 @@
>   #include <linux/perf_event.h>
>   #include <linux/percpu-defs.h>
>   #include <linux/slab.h>
> +#include <linux/stringhash.h>
>   #include <linux/types.h>
>   #include <linux/workqueue.h>
>   
> @@ -43,8 +44,18 @@ static const struct attribute_group etm_pmu_format_group = {
>   	.attrs  = etm_config_formats_attr,
>   };
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
>   static const struct attribute_group *etm_pmu_attr_groups[] = {
>   	&etm_pmu_format_group,
> +	&etm_pmu_sinks_group,
>   	NULL,
>   };
>   
> @@ -479,6 +490,38 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
>   	return 0;
>   }
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

I would have  added the attribute to the csdev (say, sink_attr),
and add that to the group, so that it is easier to remove the
attribute when the sink device is removed from the system (when
we get there). It would be good to have something in place to remove the
attribute.

Otherwise, the overall approach looks fine to me.

Suzuki
