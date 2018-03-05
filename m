Return-Path: <jonathan.cameron@huawei.com>
X-Google-Smtp-Source: AG47ELuWytdaDegNnCEzL9Nqqz++ETfnX3yiRNkBpzXMEH2a21n6imVsGWmcjsw2hvQJg+EfwFHO
ARC-Seal: i=1; a=rsa-sha256; t=1520260168; cv=none;
        d=google.com; s=arc-20160816;
        b=h5boTVJYPkfEqwK8JAnyQNnQRPaLvtLbOu1mhpDBp77ODucGNnDFLpXXO+P5mjTGdB
         pIcUwf92Z2cOMiucZDXnblzRSR5VY7n3urPHxfXzFqb54FH+97vvGN9a/PinS3ttzWi5
         HPPuZa/qJbSz/T4MOAjMjvywZjCSmy+P5yfSJrfY0hMajr1VVBDQ1OK4q0MokH5sfW+X
         j3P4a0Na3pYpfXQ5wO+6ULjJvc3mI9lxV539BbAtXDs9lanMx+k4WTkSXsGJQRHH55Tr
         se0JmN29iIcKFynMfA0WRHmYg1MpbwpwCsWWiecgp2Xrm+cyZeiztenfjhWVoSPIUSv9
         QIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=uS5BIiaLfQjYpTRIYoSkre9uS+HKRs4ZqIfPKKwAmNo=;
        b=tAEGeaL+Tgc45rsd2zk+Y0NVg6O/5ignNPzIHA5qS7RB36IoGsnkbMpNmLc+EVq57x
         cgxAFoMD1RBuSNTHM0lGm1LuNI0+LLmz3KzHIqRxbbLbiFi2AVAUrwedVEewZI6tM5ih
         9OYMrWqoIsjbJSofSiEGbDMTqpz+TZyT8cnmSl9UuwXTIpRcSA4vpZEvVN1U25z05WI0
         +uLhRFhNr1PFAhMIxyMEfjMth92lcGEgT0iiEG3qgGJKveosuAjz1oJIu6Vq+Pgz5Poz
         TRSmmp9vtM8+lfqZtTGGByEzCV1upq7fYPhcIrgQ0PrtLvckHlYvRI55/IsarHyhdwcS
         hqIg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jonathan.cameron@huawei.com designates 45.249.212.190 as permitted sender) smtp.mailfrom=jonathan.cameron@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jonathan.cameron@huawei.com designates 45.249.212.190 as permitted sender) smtp.mailfrom=jonathan.cameron@huawei.com
Date: Mon, 5 Mar 2018 14:29:03 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: ALKML <linux-arm-kernel@lists.infradead.org>, LKML
	<linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "Alexey
 Klimov" <klimov.linux@gmail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 06/20] firmware: arm_scmi: add initial support for
 performance protocol
Message-ID: <20180305152903.0000417e@huawei.com>
In-Reply-To: <1519403030-21189-7-git-send-email-sudeep.holla@arm.com>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
	<1519403030-21189-7-git-send-email-sudeep.holla@arm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593209580825368561?=
X-GMAIL-MSGID: =?utf-8?q?1594108326538068540?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Feb 2018 16:23:36 +0000
Sudeep Holla <sudeep.holla@arm.com> wrote:

> The performance protocol is intended for the performance management of
> group(s) of device(s) that run in the same performance domain. It
> includes even the CPUs. A performance domain is defined by a set of
> devices that always have to run at the same performance level.
> For example, a set of CPUs that share a voltage domain, and have a
> common frequency control, is said to be in the same performance domain.
> 
> The commands in this protocol provide functionality to describe the
> protocol version, describe various attribute flags, set and get the
> performance level of a domain. It also supports discovery of the list
> of performance levels supported by a performance domain, and the
> properties of each performance level.
> 
<snip>
> +
> +static int scmi_perf_attributes_get(const struct scmi_handle *handle,
> +				    struct scmi_perf_info *pi)
> +{
> +	int ret;
> +	struct scmi_xfer *t;
> +	struct scmi_msg_resp_perf_attributes *attr;
> +
> +	ret = scmi_one_xfer_init(handle, PROTOCOL_ATTRIBUTES,
> +				 SCMI_PROTOCOL_PERF, 0, sizeof(*attr), &t);
> +	if (ret)
> +		return ret;
> +
> +	attr = t->rx.buf;
> +
> +	ret = scmi_do_xfer(handle, t);
> +	if (!ret) {
Use a goto for the error path rather than indenting all this good path stuff.
The same would help readability in various other places.

> +		u16 flags = le16_to_cpu(attr->flags);
> +
> +		pi->num_domains = le16_to_cpu(attr->num_domains);
> +		pi->power_scale_mw = POWER_SCALE_IN_MILLIWATT(flags);
> +		pi->stats_addr = le32_to_cpu(attr->stats_addr_low) |
> +				(u64)le32_to_cpu(attr->stats_addr_high) << 32;
> +		pi->stats_size = le32_to_cpu(attr->stats_size);
> +	}
> +
> +	scmi_one_xfer_put(handle, t);
> +	return ret;
> +}
> +
...
> +
> +static struct scmi_perf_ops perf_ops = {
> +	.limits_set = scmi_perf_limits_set,
> +	.limits_get = scmi_perf_limits_get,
> +	.level_set = scmi_perf_level_set,
> +	.level_get = scmi_perf_level_get,
> +	.device_domain_id = scmi_dev_domain_id,
> +	.get_transition_latency = scmi_dvfs_get_transition_latency,
> +	.add_opps_to_device = scmi_dvfs_add_opps_to_device,
> +	.freq_set = scmi_dvfs_freq_set,
> +	.freq_get = scmi_dvfs_freq_get,
> +};
> +
> +static int scmi_perf_protocol_init(struct scmi_handle *handle)
> +{
> +	int domain;
> +	u32 version;
> +	struct scmi_perf_info *pinfo;
> +
> +	scmi_version_get(handle, SCMI_PROTOCOL_PERF, &version);
> +
> +	dev_dbg(handle->dev, "Performance Version %d.%d\n",
> +		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
> +
> +	pinfo = devm_kzalloc(handle->dev, sizeof(*pinfo), GFP_KERNEL);
> +	if (!pinfo)
> +		return -ENOMEM;
> +
> +	scmi_perf_attributes_get(handle, pinfo);
> +
> +	pinfo->dom_info = devm_kcalloc(handle->dev, pinfo->num_domains,
> +				       sizeof(*pinfo->dom_info), GFP_KERNEL);
> +	if (!pinfo->dom_info)
> +		return -ENOMEM;
> +
> +	for (domain = 0; domain < pinfo->num_domains; domain++) {
> +		struct perf_dom_info *dom = pinfo->dom_info + domain;
> +
> +		scmi_perf_domain_attributes_get(handle, domain, dom);
> +		scmi_perf_describe_levels_get(handle, domain, dom);
> +	}
> +
> +	handle->perf_ops = &perf_ops;
> +	handle->perf_priv = pinfo;
> +
> +	return 0;
> +}
> +
> +static int __init scmi_perf_init(void)
> +{
> +	return scmi_protocol_register(SCMI_PROTOCOL_PERF,
> +				      &scmi_perf_protocol_init);
> +}
> +subsys_initcall(scmi_perf_init);
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index db995126134d..d80f4c9a0fad 100644
> --- a/include/linux/scmi_protocol.h
> +++ b/include/linux/scmi_protocol.h
> @@ -44,15 +44,57 @@ struct scmi_revision_info {
>  	char sub_vendor_id[SCMI_MAX_STR_SIZE];
>  };
>  
> +struct scmi_handle;
> +
> +/**
> + * struct scmi_perf_ops - represents the various operations provided
> + *	by SCMI Performance Protocol
> + *
> + * @limits_set: sets limits on the performance level of a domain
> + * @limits_get: gets limits on the performance level of a domain
> + * @level_set: sets the performance level of a domain
> + * @level_get: gets the performance level of a domain
> + * @device_domain_id: gets the scmi domain id for a given device
> + * @get_transition_latency: gets the DVFS transition latency for a given device
> + * @add_opps_to_device: adds all the OPPs for a given device
> + * @freq_set: sets the frequency for a given device using sustained frequency
> + *	to sustained performance level mapping
> + * @freq_get: gets the frequency for a given device using sustained frequency
> + *	to sustained performance level mapping
> + */
> +struct scmi_perf_ops {
> +	int (*limits_set)(const struct scmi_handle *handle, u32 domain,
> +			  u32 max_perf, u32 min_perf);
> +	int (*limits_get)(const struct scmi_handle *handle, u32 domain,
> +			  u32 *max_perf, u32 *min_perf);
> +	int (*level_set)(const struct scmi_handle *handle, u32 domain,
> +			 u32 level);
> +	int (*level_get)(const struct scmi_handle *handle, u32 domain,
> +			 u32 *level);
> +	int (*device_domain_id)(struct device *dev);
> +	int (*get_transition_latency)(const struct scmi_handle *handle,
> +				      struct device *dev);
Naming consistency would improve this.
transition_latency_get for example.

> +	int (*add_opps_to_device)(const struct scmi_handle *handle,
> +				  struct device *dev);
> +	int (*freq_set)(const struct scmi_handle *handle, u32 domain,
> +			unsigned long rate);
> +	int (*freq_get)(const struct scmi_handle *handle, u32 domain,
> +			unsigned long *rate);
> +};
> +
>  /**
>   * struct scmi_handle - Handle returned to ARM SCMI clients for usage.
>   *
>   * @dev: pointer to the SCMI device
>   * @version: pointer to the structure containing SCMI version information
> + * @perf_ops: pointer to set of performance protocol operations
>   */
>  struct scmi_handle {
>  	struct device *dev;
>  	struct scmi_revision_info *version;
> +	struct scmi_perf_ops *perf_ops;
> +	/* for protocol internal use */
> +	void *perf_priv;
>  };
>  
>  enum scmi_std_protocol {
