Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47878C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E8A20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbfAKJme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:42:34 -0500
Received: from foss.arm.com ([217.140.101.70]:51704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729413AbfAKJmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:42:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB7BEEBD;
        Fri, 11 Jan 2019 01:42:32 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 372233F694;
        Fri, 11 Jan 2019 01:42:31 -0800 (PST)
Subject: Re: [PATCH v3] irqchip: gicv3-its: Use NUMA aware memory allocation
 for ITS tables
To:     shameerali.kolothum.thodi@huawei.com, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org
Cc:     shankerd@codeaurora.org, ganapatrao.kulkarni@cavium.com,
        Robert.Richter@cavium.com, guohanjun@huawei.com,
        john.garry@huawei.com, linux-arm-kernel@lists.infradead.org,
        linuxarm@huawei.com
References: <20181213105924.30384-1-shameerali.kolothum.thodi@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <9046beb6-36e7-8890-5d09-fc03b6d2728c@arm.com>
Date:   Fri, 11 Jan 2019 09:42:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213105924.30384-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shameer,

On 13/12/2018 10:59, Shameer Kolothum wrote:
> From: Shanker Donthineni <shankerd@codeaurora.org>
> 
> The NUMA node information is visible to ITS driver but not being used
> other than handling hardware errata. ITS/GICR hardware accesses to the
> local NUMA node is usually quicker than the remote NUMA node. How slow
> the remote NUMA accesses are depends on the implementation details.
> 
> This patch allocates memory for ITS management tables and command
> queue from the corresponding NUMA node using the appropriate NUMA
> aware functions. This change improves the performance of the ITS
> tables read latency on systems where it has more than one ITS block,
> and with the slower inter node accesses.
> 
> Apache Web server benchmarking using ab tool on a HiSilicon D06
> board with multiple numa mem nodes shows Time per request and
> Transfer rate improvements of ~3.6% with this patch.
> 
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
> 
> This is to revive the patch originally sent by Shanker[1] and
> to back it up with a benchmark test. Any further testing of
> this is most welcome.
> 
> v2-->v3
>   -Addressed comments to use page_address().
>   -Added Benchmark results to commit log.
>   -Removed T-by from Ganapatrao for now.
> 
> v1-->v2
>   -Edited commit text.
>   -Added Ganapatrao's tested-by.
> 
> Benchmark test details:
> --------------------------------
> Test Setup:
> -D06 with dimm on node 0(Sock#0) and 3 (Sock#1).
> -ITS belongs to numa node 0.
> -Filesystem mounted on a PCIe NVMe based disk.
> -Apache server installed on D06.
> -Running ab benchmark test in concurrency mode from a remote m/c
>   connected to D06 via  hns3(PCIe) n/w port.
>   "ab -k -c 750 -n 2000000 http://10.202.225.188/"
> 
> Test results are avg. of 15 runs.
> 
> For 4.20-rc1  Kernel,
> ----------------------------
> Time per request(mean, concurrent)  = 0.02753[ms]
> Transfer Rate = 416501[Kbytes/sec]
> 
> For 4.20-rc1 +  this patch,
> ----------------------------------
> Time per request(mean, concurrent)  = 0.02653[ms]
> Transfer Rate = 431954[Kbytes/sec]
> 
> % improvement ~3.6%
> 
> vmstat shows around 170K-200K interrupts per second.
> 
> ~# vmstat 1 -w
> procs -----------------------memory-- -  -system--
>   r  b         swpd         free            in
>   5  0            0     30166724          102794
>   9  0            0     30141828          171148
>   5  0            0     30150160          207185
> 13  0            0     30145924          175691
> 15  0            0     30140792          145250
> 13  0            0     30135556          201879
> 13  0            0     30134864          192391
> 10  0            0     30133632          168880
> ....
> 
> [1] https://patchwork.kernel.org/patch/9833339/
> 
>   drivers/irqchip/irq-gic-v3-its.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index db20e99..ab01061 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1749,7 +1749,8 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
>   		order = get_order(GITS_BASER_PAGES_MAX * psz);
>   	}
>   
> -	base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> +	base = (void *)page_address(alloc_pages_node(its->numa_node,
> +				    GFP_KERNEL | __GFP_ZERO, order));

If alloc_pages_node() fails, the page_address() could crash the system.

> -	its->cmd_base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> -						get_order(ITS_CMD_QUEUE_SZ));
> +	its->cmd_base = (void *)page_address(alloc_pages_node(its->numa_node,
> +					     GFP_KERNEL | __GFP_ZERO,
> +					     get_order(ITS_CMD_QUEUE_SZ)));

Similarly here. We may want to handle it properly.

Cheers
Suzuki
