Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753336AbeC1TCK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 15:02:10 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:45733 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753141AbeC1TCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 15:02:08 -0400
Subject: Re: [net-next,v2,01/10] soc: ti: K2G: enhancement to support QMSS in
 NSS
To: Murali Karicheri <m-karicheri2@ti.com>, <robh+dt@kernel.org>,
        <ssantosh@kernel.org>, <malat@debian.org>, <w-kwok2@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>
References: <1522168309-12338-2-git-send-email-m-karicheri2@ti.com>
From: Grygorii Strashko <grygorii.strashko@ti.com>
CC: <mark.rutland@arm.com>
Message-ID: <1ccf03e7-17b4-cf00-176d-0e41038c88f8@ti.com>
Date: Wed, 28 Mar 2018 14:01:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522168309-12338-2-git-send-email-m-karicheri2@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Murali,

On 03/27/2018 11:31 AM, Murali Karicheri wrote:
> Navigator Subsystem (NSS) available on K2G SoC has a cut down
> version of QMSS with less number of queues, internal linking ram
> with lesser number of buffers etc.  It doesn't have status and
> explicit push register space as in QMSS available on other K2 SoCs.
> So define reg indices specific to QMSS on K2G. This patch introduces
> "keystone-navigator-qmss-l" compatibility to identify QMSS on
> K2G NSS (QMSS Lite) and to customize the dts handling code. Per
> Device manual, descriptors with index less than or equal to
> regions0_size is in region 0 in the case of QMSS where as for
> QMSS Lite, descriptors with index less than regions0_size is in
> region 0. So update the size accordingly in the regions0_size bits
> of the linking ram size 0 register.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
> ---
>   .../bindings/soc/ti/keystone-navigator-qmss.txt    |  7 ++
>   drivers/soc/ti/knav_qmss.h                         |  6 ++
>   drivers/soc/ti/knav_qmss_queue.c                   | 90 ++++++++++++++++------
>   3 files changed, 81 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt b/Documentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt
> index 77cd42c..1b0878a 100644
> --- a/Documentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt
> +++ b/Documentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt
> @@ -18,6 +18,7 @@ pool management.
>   
>   Required properties:
>   - compatible	: Must be "ti,keystone-navigator-qmss";
> +		: Must be "ti,keystone-navigator-qmss-l" for NSS Lite


I think, It will be more accurate to add K2G specific compat string
like "ti,66ak2g-navss-qm":

compatible = "ti,66ak2g-navss-qm", "ti,keystone-navigator-qmss";

because 66ak2g TRM doesn't mention "Navss light" and this Navss version is used
only in 66ak2g Soc. As result, 66ak2g Navss QM is subset of of keystone 2 Navss QM 
which should be defined in DT by adding more specific compat string in addition
to generic one.  


>   - clocks	: phandle to the reference clock for this device.
>   - queue-range	: <start number> total range of queue numbers for the device.
>   - linkram0	: <address size> for internal link ram, where size is the total
> @@ -39,6 +40,12 @@ Required properties:
>   			  - Descriptor memory setup region.
>   			  - Queue Management/Queue Proxy region for queue Push.
>   			  - Queue Management/Queue Proxy region for queue Pop.
> +
> +For NSS lite, following QMSS reg indexes are used in that order

For 66AK2G NAVSS QM..

> +			  - Queue Peek region.
> +			  - Queue configuration region.
> +			  - Queue Management/Queue Proxy region for queue Push/Pop.
> +
>   - queue-pools	: child node classifying the queue ranges into pools.
>   		  Queue ranges are grouped into 3 type of pools:
>   		  - qpend	    : pool of qpend(interruptible) queues
> diff --git a/drivers/soc/ti/knav_qmss.h b/drivers/soc/ti/knav_qmss.h
> index 905b974..5fa1ce6 100644
> --- a/drivers/soc/ti/knav_qmss.h
> +++ b/drivers/soc/ti/knav_qmss.h
> @@ -292,6 +292,11 @@ struct knav_queue {
>   	struct list_head		list;
>   };
>   
> +enum qmss_version {
> +	QMSS,
> +	QMSS_LITE,

QMSS_66AK2G

> +};
> +
>   struct knav_device {
>   	struct device				*dev;
>   	unsigned				base_id;
> @@ -305,6 +310,7 @@ struct knav_device {
>   	struct list_head			pools;
>   	struct list_head			pdsps;
>   	struct list_head			qmgrs;
> +	enum qmss_version			version;
>   };
>   

[...]

>   }
>   
> +/* Match table for of_platform binding */
> +static const struct of_device_id keystone_qmss_of_match[] = {
> +	{
> +		.compatible = "ti,keystone-navigator-qmss",

		.data	= (void *)QMSS,

> +	},
> +	{
> +		.compatible = "ti,keystone-navigator-qmss-l",
> +		.data	= (void *)QMSS_LITE,
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, keystone_qmss_of_match);
> +
>   static int knav_queue_probe(struct platform_device *pdev)
>   {
>   	struct device_node *node = pdev->dev.of_node;
>   	struct device_node *qmgrs, *queue_pools, *regions, *pdsps;
> +	const struct of_device_id *match;
>   	struct device *dev = &pdev->dev;
>   	u32 temp[2];
>   	int ret;
> @@ -1700,6 +1749,10 @@ static int knav_queue_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   	}
>   
> +	match = of_match_device(of_match_ptr(keystone_qmss_of_match), dev);
> +	if (match && match->data)
> +		kdev->version = QMSS_LITE;

	if (match)
		kdev->version = match->data;
	else
		error?
[...]

-- 
regards,
-grygorii
