Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66025C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A25B21502
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A25B21502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbeHBMqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:46:12 -0400
Received: from foss.arm.com ([217.140.101.70]:55690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbeHBMqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:46:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B86147A9;
        Thu,  2 Aug 2018 03:55:35 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C78463F5D0;
        Thu,  2 Aug 2018 03:55:34 -0700 (PDT)
Subject: Re: [PATCH] arm_pmu: fix compiler warning in arm_pmu_device_probe
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        mark.rutland@arm.com, will.deacon@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180801214526.24599-1-chris.packham@alliedtelesis.co.nz>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <449c26bb-9d31-984e-da74-73ef1bd9a674@arm.com>
Date:   Thu, 2 Aug 2018 11:55:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180801214526.24599-1-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On 01/08/18 22:45, Chris Packham wrote:
> GCC warns
> 
>    arm_pmu_platform.c:234:5: error: 'err' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> This is because we rely on the for_each_cpu loop in armpmu_request_irqs
> to initialise err. The warning is a little bogus because we know if
> there were 0 CPUs this code would not be running.
> 
> Initialise err to 0 to avoid the warning.

Maybe initialising to something like -EINVAL would be more appropriate, 
just in case we did ever manage to get here with armpmu->supported_cpus 
unset?

Robin.

> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> This has been reported before in https://lkml.org/lkml/2018/3/5/508 I'm not
> sure if it was dismmissed as "meh, gcc is wrong" or if it was just wainting for
> someone with some round tuits.
> 
> 
>   drivers/perf/arm_pmu_platform.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
> index 971ff336494a..96075cecb0ae 100644
> --- a/drivers/perf/arm_pmu_platform.c
> +++ b/drivers/perf/arm_pmu_platform.c
> @@ -160,7 +160,7 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
>   static int armpmu_request_irqs(struct arm_pmu *armpmu)
>   {
>   	struct pmu_hw_events __percpu *hw_events = armpmu->hw_events;
> -	int cpu, err;
> +	int cpu, err = 0;
>   
>   	for_each_cpu(cpu, &armpmu->supported_cpus) {
>   		int irq = per_cpu(hw_events->irq, cpu);
> 
