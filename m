Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeDLQoi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 12:44:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38798 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752424AbeDLQog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 12:44:36 -0400
Subject: Re: [PATCH 01/14] memory: ti-emif-sram: Add resume function to recopy
 sram code
To: Keerthy <j-keerthy@ti.com>, linus.walleij@linaro.org,
        grygorii.strashko@ti.com, tony@atomide.com
Cc: t-kristo@ti.com, Russ.Dill@ti.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, ssantosh@kernel.org,
        haojian.zhuang@linaro.org, linux-arm-kernel@lists.infradead.org,
        d-gerlach@ti.com
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
 <1523505239-16229-2-git-send-email-j-keerthy@ti.com>
From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <31688cf4-b6ca-e7ce-3407-46262006b38f@oracle.com>
Date: Thu, 12 Apr 2018 10:44:10 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523505239-16229-2-git-send-email-j-keerthy@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8861 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804120164
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/18 9:53 PM, Keerthy wrote:
> From: Dave Gerlach <d-gerlach@ti.com>
> 
> After an RTC+DDR cycle we lose sram context so emif pm functions present
> in sram are lost. We can check if the first byte of the original
> code in DDR contains the same first byte as the code in sram, and if
> they do not match we know we have lost context and must recopy the
> functions to the previous address to maintain PM functionality.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>   drivers/memory/ti-emif-pm.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/memory/ti-emif-pm.c b/drivers/memory/ti-emif-pm.c
> index 632651f..ec4a62c 100644
> --- a/drivers/memory/ti-emif-pm.c
> +++ b/drivers/memory/ti-emif-pm.c
> @@ -249,6 +249,25 @@ int ti_emif_get_mem_type(void)
>   };
>   MODULE_DEVICE_TABLE(of, ti_emif_of_match);
>   
> +#ifdef CONFIG_PM_SLEEP
> +static int ti_emif_resume(struct device *dev)
> +{
> +	unsigned long tmp =
> +			__raw_readl((void *)emif_instance->ti_emif_sram_virt);
> +
> +	/*
> +	 * Check to see if what we are copying is already present in the
> +	 * first byte at the destination, only copy if it is not which
> +	 * indicates we have lost context and sram no longer contains
> +	 * the PM code
> +	 */

> +	if (tmp != ti_emif_sram)
> +		ti_emif_push_sram(dev, emif_instance);
> +
> +	return 0;
> +}
> +#endif /* CONFIG_PM_SLEEP */
Instead of this indirect method , why can't just check the previous
deep sleep mode and based on that do copy or not. EMIF power status
register should have something like that ?

Another minor point is even though there is nothing to do in suspend,
might be good to have a callback with comment that nothing to do with
some explanation why not. Don't have strong preference but may for
better readability.

Regards,
Santosh
