Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89803C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9262080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zi/wqssj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9262080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeJaCMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 22:12:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52396 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeJaCMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 22:12:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9UHDThx053338;
        Tue, 30 Oct 2018 17:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Cdf7iXB2l9L0dZYBkLoEwxtZzNFBL4TybI8Rsu/Q+EQ=;
 b=Zi/wqssjFr5z2c3BmqP9ZofHlLtA5zExpZcaTE3yJzkWWSQXytYQlGnp2C0STFpW8aUi
 SSMGGNmo/THu2YhYYF3O50y0TRQLIoFkBCRr1irRIneXvan2yJRGRzOZuuwc3vvEc+6G
 Np3NCFZZu7X+nMfixy3bmFdsPRuydsdMQBJH1osf4VxSp40W/uCeFGo2a7oAhj/Vp8QA
 6KdoZ2IostCjEq9YX9oKt4ufZ7C9p3Yumk1JHP1BVvg1qbCw+x4MsQ+3eReUeZ8AMI1r
 NNsaYfGfbPh4Pcm53mvnyZPgfKJZP8z+7Xu8D3DeegClt8lnSq3wzvb7vI/KYAfmVk7m rQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2ncgnqwtsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 17:18:13 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9UHICol028586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 17:18:12 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9UHIBRp012710;
        Tue, 30 Oct 2018 17:18:11 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Oct 2018 10:18:11 -0700
Subject: Re: [PATCH] soc: ti: QMSS: Fix usage of irq_set_affinity_hint
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        stable@vger.kernel.org
References: <20181030111103.12110-1-marc.zyngier@arm.com>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <ea4e3273-39da-d9f9-49ce-f18268767ce3@oracle.com>
Date:   Tue, 30 Oct 2018 10:18:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181030111103.12110-1-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9062 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810300146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 10/30/2018 4:11 AM, Marc Zyngier wrote:
> The Keystone QMSS driver is pretty damaged, in the sense that it
> does things like this:
> 
> 	irq_set_affinity_hint(irq, to_cpumask(&cpu_map));
> 
> where cpu_map is a local variable. As we leave the function, this
> will point to nowhere-land, and things will end-up badly.
> 
> Instead, let's use a proper cpumask that gets allocated, giving
> the driver a chance to actually work with things like irqbalance
> as well as have a hypothetical 64bit future.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> I found this one by inspection after finding a similar bug in an
> unrelated driver. It is only compile-tested. It would probably
> a Cc stable, but that's Santosh's decision.

Would be able to apply this fix from Marc for stable or it needs
to be re-posted with CC to stable ?

> 
>   drivers/soc/ti/knav_qmss.h       |  4 ++--
>   drivers/soc/ti/knav_qmss_acc.c   | 10 +++++-----
>   drivers/soc/ti/knav_qmss_queue.c | 22 +++++++++++++++-------
>   3 files changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/soc/ti/knav_qmss.h b/drivers/soc/ti/knav_qmss.h
> index 3efc47e82973..bd040c29c4bf 100644
> --- a/drivers/soc/ti/knav_qmss.h
> +++ b/drivers/soc/ti/knav_qmss.h
> @@ -329,8 +329,8 @@ struct knav_range_ops {
>   };
>   
>   struct knav_irq_info {
> -	int	irq;
> -	u32	cpu_map;
> +	int		irq;
> +	struct cpumask	*cpu_mask;
>   };
>   
>   struct knav_range_info {
> diff --git a/drivers/soc/ti/knav_qmss_acc.c b/drivers/soc/ti/knav_qmss_acc.c
> index 316e82e46f6c..2f7fb2dcc1d6 100644
> --- a/drivers/soc/ti/knav_qmss_acc.c
> +++ b/drivers/soc/ti/knav_qmss_acc.c
> @@ -205,18 +205,18 @@ static int knav_range_setup_acc_irq(struct knav_range_info *range,
>   {
>   	struct knav_device *kdev = range->kdev;
>   	struct knav_acc_channel *acc;
> -	unsigned long cpu_map;
> +	struct cpumask *cpu_mask;
>   	int ret = 0, irq;
>   	u32 old, new;
>   
>   	if (range->flags & RANGE_MULTI_QUEUE) {
>   		acc = range->acc;
>   		irq = range->irqs[0].irq;
> -		cpu_map = range->irqs[0].cpu_map;
> +		cpu_mask = range->irqs[0].cpu_mask;
>   	} else {
>   		acc = range->acc + queue;
>   		irq = range->irqs[queue].irq;
> -		cpu_map = range->irqs[queue].cpu_map;
> +		cpu_mask = range->irqs[queue].cpu_mask;
>   	}
>   
>   	old = acc->open_mask;
> @@ -239,8 +239,8 @@ static int knav_range_setup_acc_irq(struct knav_range_info *range,
>   			acc->name, acc->name);
>   		ret = request_irq(irq, knav_acc_int_handler, 0, acc->name,
>   				  range);
> -		if (!ret && cpu_map) {
> -			ret = irq_set_affinity_hint(irq, to_cpumask(&cpu_map));
> +		if (!ret && cpu_mask) {
> +			ret = irq_set_affinity_hint(irq, cpu_mask);
>   			if (ret) {
>   				dev_warn(range->kdev->dev,
>   					 "Failed to set IRQ affinity\n");
> diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
> index b5d5673c255c..8b418379272d 100644
> --- a/drivers/soc/ti/knav_qmss_queue.c
> +++ b/drivers/soc/ti/knav_qmss_queue.c
> @@ -118,19 +118,17 @@ static int knav_queue_setup_irq(struct knav_range_info *range,
>   			  struct knav_queue_inst *inst)
>   {
>   	unsigned queue = inst->id - range->queue_base;
> -	unsigned long cpu_map;
>   	int ret = 0, irq;
>   
>   	if (range->flags & RANGE_HAS_IRQ) {
>   		irq = range->irqs[queue].irq;
> -		cpu_map = range->irqs[queue].cpu_map;
>   		ret = request_irq(irq, knav_queue_int_handler, 0,
>   					inst->irq_name, inst);
>   		if (ret)
>   			return ret;
>   		disable_irq(irq);
> -		if (cpu_map) {
> -			ret = irq_set_affinity_hint(irq, to_cpumask(&cpu_map));
> +		if (range->irqs[queue].cpu_mask) {
> +			ret = irq_set_affinity_hint(irq, range->irqs[queue].cpu_mask);
>   			if (ret) {
>   				dev_warn(range->kdev->dev,
>   					 "Failed to set IRQ affinity\n");
> @@ -1262,9 +1260,19 @@ static int knav_setup_queue_range(struct knav_device *kdev,
>   
>   		range->num_irqs++;
>   
> -		if (IS_ENABLED(CONFIG_SMP) && oirq.args_count == 3)
> -			range->irqs[i].cpu_map =
> -				(oirq.args[2] & 0x0000ff00) >> 8;
> +		if (IS_ENABLED(CONFIG_SMP) && oirq.args_count == 3) {
> +			unsigned long mask;
> +			int bit;
> +
> +			range->irqs[i].cpu_mask = devm_kzalloc(dev,
> +							       cpumask_size(), GFP_KERNEL);
> +			if (!range->irqs[i].cpu_mask)
> +				return -ENOMEM;
> +
> +			mask = (oirq.args[2] & 0x0000ff00) >> 8;
> +			for_each_set_bit(bit, &mask, BITS_PER_LONG)
> +				cpumask_set_cpu(bit, range->irqs[i].cpu_mask);
> +		}
>   	}
>   
>   	range->num_irqs = min(range->num_irqs, range->num_queues);
> 
