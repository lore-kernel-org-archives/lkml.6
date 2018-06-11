Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tXZWNdo9HlsjTwAAmS7hNA
	; Mon, 11 Jun 2018 09:18:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5CC67607BB; Mon, 11 Jun 2018 09:18:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D8F0760791;
	Mon, 11 Jun 2018 09:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8F0760791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754197AbeFKJS2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 05:18:28 -0400
Received: from foss.arm.com ([217.140.101.70]:49062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754010AbeFKJS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:18:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 940F41435;
        Mon, 11 Jun 2018 02:18:26 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D3003F53D;
        Mon, 11 Jun 2018 02:18:24 -0700 (PDT)
Subject: Re: [PATCH 02/20] coresight: of: Fix refcounting for graph nodes
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, robh@kernel.org,
        frowand.list@gmail.com, mark.rutland@arm.com, sudeep.holla@arm.com,
        arm@kernel.org, linux-kernel@vger.kernel.org, matt.sealey@arm.com,
        john.horley@arm.com, charles.garcia-tobin@arm.com,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        mike.leach@linaro.org
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-3-git-send-email-suzuki.poulose@arm.com>
 <20180608195530.GB30587@xps15>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <d06e9fdc-44c3-95bd-63d1-ff4e6f9f282e@arm.com>
Date: Mon, 11 Jun 2018 10:18:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608195530.GB30587@xps15>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/18 20:55, Mathieu Poirier wrote:
> On Tue, Jun 05, 2018 at 10:43:13PM +0100, Suzuki K Poulose wrote:
>> The coresight driver doesn't drop the references on the
>> remote endpoint/port nodes. Add the missing of_node_put()
>> calls. To make it easier to handle different corner cases
>> cleanly, move the parsing of an endpoint to separate
>> function.
> 
> Please split this as those are two different things.

Mathieu,

I can do that, its only that if someone were to backport
the fix for an older kernel, they would need to pick up these
two patches, which is still fine.

> 
>>
>> Reported-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/of_coresight.c | 139 +++++++++++++++++------------
>>   1 file changed, 84 insertions(+), 55 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
>> index a33a92e..8a23c63 100644
>> --- a/drivers/hwtracing/coresight/of_coresight.c
>> +++ b/drivers/hwtracing/coresight/of_coresight.c

>> +static int of_coresight_parse_endpoint(struct device_node *ep,
>> +				       struct coresight_platform_data *pdata,
>> +				       int *i)
>> +{
>> +	int ret = 0;
>> +	struct of_endpoint endpoint, rendpoint;
>> +	struct device_node *rparent = NULL;
>> +	struct device_node *rport = NULL;
>> +	struct device *rdev = NULL;
>> +
>> +	do {

...

>> +	} while (0);
> 
> That's a clever way of coding a classic 'goto' block.
> 
>> +
>> +	if (rparent)
>> +		of_node_put(rparent);
>> +	if (rport)
>> +		of_node_put(rport);
> 
> Perfect - thank you for that.
> 

>>   	pdata->name = dev_name(dev);
>> +	pdata->cpu = of_coresight_get_cpu(node);
>>   
>>   	/* Get the number of input and output port for this component */
>>   	of_coresight_get_ports(node, &pdata->nr_inport, &pdata->nr_outport);
>>   
>> -	if (pdata->nr_outport) {
>> -		ret = of_coresight_alloc_memory(dev, pdata);
>> +	/* If there are not output connections, we are done */
> 
> /not/no

Thanks for spotting.

Suzuki
