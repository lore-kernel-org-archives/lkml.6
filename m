Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753405AbeFATiz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 15:38:55 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35439 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753150AbeFATil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 15:38:41 -0400
X-Google-Smtp-Source: ADUXVKJyVsyrAQaMq63Bxpzmdm7C3hDsI9QzRcminjtmvVdcwRnQdSRAi22O+cBSbAR6EgFu7VRvJg==
Date: Fri, 1 Jun 2018 13:38:37 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com,
        robh@kernel.org, mark.rutland@arm.com, frowand.list@gmail.com,
        matt.sealey@arm.com, charles.garcia-tobin@arm.com, john.horley@arm.com,
        mike.leach@linaro.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] coresight: Fix remote endpoint parsing
Message-ID: <20180601193837.GB9838@xps15>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
 <1527858967-16047-3-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527858967-16047-3-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 02:16:01PM +0100, Suzuki K Poulose wrote:
> When parsing the remote endpoint of an output port, we do :
>      rport = of_graph_get_remote_port(ep);
>      rparent = of_graph_get_remote_port_parent(ep);
> 
> and then parse the "remote_port" as if it was the remote endpoint,
> which is wrong. The code worked fine because we used endpoint number
> as the port number. Let us fix it and optimise a bit as:
> 
>      remote_ep = of_graph_get_remote_endpoint(ep);
>      if (remote_ep)
>         remote_parent = of_graph_get_port_parent(remote_ep);
> 
> and then, parse the remote_ep for the port/endpoint details.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/of_coresight.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
> index 7c37544..e0deab0 100644
> --- a/drivers/hwtracing/coresight/of_coresight.c
> +++ b/drivers/hwtracing/coresight/of_coresight.c
> @@ -128,7 +128,7 @@ of_get_coresight_platform_data(struct device *dev,
>  	struct device *rdev;
>  	struct device_node *ep = NULL;
>  	struct device_node *rparent = NULL;
> -	struct device_node *rport = NULL;
> +	struct device_node *rep = NULL;
>  
>  	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>  	if (!pdata)
> @@ -169,16 +169,17 @@ of_get_coresight_platform_data(struct device *dev,
>  			pdata->outports[i] = endpoint.port;
>  
>  			/*
> -			 * Get a handle on the remote port and parent
> -			 * attached to it.
> +			 * Get a handle on the remote endpoint and the device
> +			 * it is attached to.
>  			 */
> -			rparent = of_graph_get_remote_port_parent(ep);
> -			rport = of_graph_get_remote_port(ep);
> -
> -			if (!rparent || !rport)
> +			rep = of_graph_get_remote_endpoint(ep);
> +			if (!rep)
> +				continue;
> +			rparent = of_graph_get_port_parent(rep);
> +			if (!rparent)
>  				continue;
>  
> -			if (of_graph_parse_endpoint(rport, &rendpoint))
> +			if (of_graph_parse_endpoint(rep, &rendpoint))
>  				continue;

You are correct and I'm out to lunch.

>  
>  			rdev = of_coresight_get_endpoint_device(rparent);
> @@ -186,7 +187,7 @@ of_get_coresight_platform_data(struct device *dev,
>  				return ERR_PTR(-EPROBE_DEFER);
>  
>  			pdata->child_names[i] = dev_name(rdev);
> -			pdata->child_ports[i] = rendpoint.id;
> +			pdata->child_ports[i] = rendpoint.port;

You need to do a of_node_put() here for both rep and rparent.

>  
>  			i++;
>  		} while (ep);
> -- 
> 2.7.4
> 
