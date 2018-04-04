Return-Path: <lorenzo.pieralisi@arm.com>
X-Google-Smtp-Source: AIpwx480iBGmbEZNXuF6wbyUQd3WY7JMwNAVmESyu6gMkgDZwe/EyQFQ8dvIasvtyg1t1ho5DvPU
ARC-Seal: i=1; a=rsa-sha256; t=1522857706; cv=none;
        d=google.com; s=arc-20160816;
        b=l16cHRE7oq/722qh0UbA73QJmEkAve7ICHYZVw5TFbTbBLqVbZCrH3b19z2zWboZ+g
         OSnOGTor07udsQPWxrbwVc5BfPQHwRnOBtC2fCx0EFyGggkwy0nWqPEpdSGo5egyzz6T
         AfCIa+w6bmL+voDNWT5nTQQceZoWZ+TQP9zpaXXEJv2d5VZq+ICOfwPe5lts3VHn0zCG
         tRzpE4q4ZnOwghG+dr59WxYHwHntxE2Ejs8Iaruq/rVS5b9pOpsHbMUHduqoaZul8nEe
         x2Jjq++X+D2vpiSrbD1JiRi/uXAKsEY46tNc+0iE0BwJFFev34DcNsg/lklQj2h+b4ta
         YySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=XMRdbyJcPPOmmYjOw9vw2elB8GE3ADAVOjGnyG6+crc=;
        b=RGnPuN/QPkXlerSOZqka5MLBxI8DeczlS2hKAXO5PpfmOSKqCm1JBd5lnLfeKFY56L
         43BJ+tQnoyI6f0nOTG7eS3yz8HuQu44V9V/iM4IuhcAnu5HFURQS4sDSJry2mHx9OtHB
         rbzKbeYz+GZiht2X5QcbdQgOrvIuZcz4Z4lAzD40Jb5uuzT1fXnjzzUdQLPnoOrjytv3
         k8AR3hZ8qMWt5JrqjeSgRvpLhwJk7fjCKZwNzWYHBma6z9jrUqmMpAMwlJHlwqmnPgwQ
         eKz0ztAyQkhzePGwvOov/CXWoSXI/BorXQlPyl/qZcPYaTH2sDhB2uz29HBaD2oeEMaL
         jeeg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lorenzo.pieralisi@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=lorenzo.pieralisi@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lorenzo.pieralisi@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=lorenzo.pieralisi@arm.com
Date: Wed, 4 Apr 2018 17:01:38 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Cc: rjw@rjwysocki.net, gregkh@linuxfoundation.org, hanjun.guo@linaro.org,
	sudeep.holla@arm.com, yu.zheng@hxt-semitech.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com
Subject: Re: [RFC PATCH 2/2] ACPI/IORT: use swiotlb_dma_ops when smmu probe
 failed
Message-ID: <20180404160138.GA9317@e107981-ln.cambridge.arm.com>
References: <1522317660-11080-1-git-send-email-dongsheng.wang@hxt-semitech.com>
 <1522317660-11080-3-git-send-email-dongsheng.wang@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522317660-11080-3-git-send-email-dongsheng.wang@hxt-semitech.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596265798784882877?=
X-GMAIL-MSGID: =?utf-8?q?1596832042059843280?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[+cc Robin]

On Thu, Mar 29, 2018 at 03:01:00AM -0700, Wang Dongsheng wrote:
> If SMMU probe failed, master should use swiotlb as dma ops.
> SMMU may probe failed with specified environment, so there
> are not any iommu resources in iommu_device_list.
> 
> The master will always get EPROBE_DEFER from really_probe
> (dma_configure) but in fact SMMU has probe failed. The issue
> causes all of masters failed to be driven.

I added Robin to pick his brain. An alternative would consist
in using a bus notifier to prevent deferred probing once the SMMU
driver probing failed but that seems backwards given that a major
reason to move to deferred probing was to remove the bus notifiers
dependency in the first place.

It seems to me this is both an OF/ACPI issue - it is not an IORT
only problem.

Lorenzo

> Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
> ---
>  drivers/acpi/arm64/iort.c | 39 +++++++++++++++++++++++++++++++++------
>  1 file changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index e2f7bdd..a6f4c27 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -774,17 +774,45 @@ static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
>  	return ret;
>  }
>  
> -static inline bool iort_iommu_driver_enabled(u8 type)
> +static int iort_check_dev_dl_status(struct device *dev, void *data)
>  {
> +	struct fwnode_handle *fwnode = data;
> +
> +	if (dev->fwnode != fwnode)
> +		return 0;
> +
> +	if (dev->links.status == DL_DEV_PROBE_FAILED)
> +		return -ENODEV;
> +
> +	return -EPROBE_DEFER;
> +}
> +
> +static int iort_iommu_driver_enabled(u8 type, struct fwnode_handle *fwnode)
> +{
> +	bool buildin;
> +	int ret;
> +
>  	switch (type) {
>  	case ACPI_IORT_NODE_SMMU_V3:
> -		return IS_BUILTIN(CONFIG_ARM_SMMU_V3);
> +		buildin = IS_BUILTIN(CONFIG_ARM_SMMU_V3);
> +		break;
>  	case ACPI_IORT_NODE_SMMU:
> -		return IS_BUILTIN(CONFIG_ARM_SMMU);
> +		buildin = IS_BUILTIN(CONFIG_ARM_SMMU);
> +		break;
>  	default:
>  		pr_warn("IORT node type %u does not describe an SMMU\n", type);
> -		return false;
> +		buildin = false;
>  	}
> +
> +	if (!buildin)
> +		return -ENODEV;
> +
> +	ret = bus_for_each_dev(&platform_bus_type, NULL, fwnode,
> +			       iort_check_dev_dl_status);
> +	if (!ret)
> +		return -EPROBE_DEFER;
> +
> +	return ret;
>  }
>  
>  #ifdef CONFIG_IOMMU_API
> @@ -919,8 +947,7 @@ static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
>  	 */
>  	ops = iommu_ops_from_fwnode(iort_fwnode);
>  	if (!ops)
> -		return iort_iommu_driver_enabled(node->type) ?
> -		       -EPROBE_DEFER : -ENODEV;
> +		return iort_iommu_driver_enabled(node->type, iort_fwnode);
>  
>  	return arm_smmu_iort_xlate(dev, streamid, iort_fwnode, ops);
>  }
> -- 
> 2.7.4
> 
