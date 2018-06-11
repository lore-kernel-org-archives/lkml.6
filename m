Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id LwnfBUc5HlvjOQAAmS7hNA
	; Mon, 11 Jun 2018 09:24:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4009F607E4; Mon, 11 Jun 2018 09:24:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7884E600D0;
	Mon, 11 Jun 2018 09:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7884E600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932741AbeFKJYg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 05:24:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49184 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754147AbeFKJWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:22:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D05431435;
        Mon, 11 Jun 2018 02:22:46 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 967013F53D;
        Mon, 11 Jun 2018 02:22:44 -0700 (PDT)
Subject: Re: [PATCH 08/20] coresight: dts: Cleanup device tree graph bindings
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, robh@kernel.org,
        frowand.list@gmail.com, mark.rutland@arm.com, sudeep.holla@arm.com,
        arm@kernel.org, linux-kernel@vger.kernel.org, matt.sealey@arm.com,
        john.horley@arm.com, charles.garcia-tobin@arm.com,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        mike.leach@linaro.org
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-9-git-send-email-suzuki.poulose@arm.com>
 <20180608212211.GG30587@xps15>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <f616c825-b459-397d-3e61-70c1f1790f4f@arm.com>
Date: Mon, 11 Jun 2018 10:22:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608212211.GG30587@xps15>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/18 22:22, Mathieu Poirier wrote:
> On Tue, Jun 05, 2018 at 10:43:19PM +0100, Suzuki K Poulose wrote:
>> The coresight drivers relied on default bindings for graph
>> in DT, while reusing the "reg" field of the "ports" to indicate
>> the actual hardware port number for the connections. However,
>> with the rules getting stricter w.r.t to the address mismatch
>> with the label, it is no longer possible to use the port address
>> field for the hardware port number. Hence, we add an explicit
>> property to denote the hardware port number, "coresight,hwid"
>> which must be specified for each "endpoint".
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Rob Herring <robh@kernel.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   .../devicetree/bindings/arm/coresight.txt          | 29 ++++++++++---
>>   drivers/hwtracing/coresight/of_coresight.c         | 49 +++++++++++++++++-----
>>   2 files changed, 62 insertions(+), 16 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
>> index ed6b555..bf75ab3 100644
>> --- a/Documentation/devicetree/bindings/arm/coresight.txt
>> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
>> @@ -108,8 +108,13 @@ following properties to uniquely identify the connection details.
>>   	"slave-mode"


>>   	};
> 
> For the binding part:
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
>> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
>> index d01a9ce..d23d7dd 100644
>> --- a/drivers/hwtracing/coresight/of_coresight.c
>> +++ b/drivers/hwtracing/coresight/of_coresight.c

...

>> +/*
>>    * of_coresight_parse_endpoint : Parse the given output endpoint @ep
>>    * and fill the connection information in *@pconn.
>>    *
>> @@ -109,11 +134,11 @@ EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
>>    *	 0	- If the parsing completed without any fatal errors.

Please note the return value description here. Further comments below.

>>    *	-Errno	- Fatal error, abort the scanning.
>>    */
>> -static int of_coresight_parse_endpoint(struct device_node *ep,
>> +static int of_coresight_parse_endpoint(struct device *dev,
>> +				       struct device_node *ep,
>>   				       struct coresight_connection **pconn)
>>   {
>> -	int ret = 0;
>> -	struct of_endpoint endpoint, rendpoint;
>> +	int ret = 0, local_port, child_port;
>>   	struct device_node *rparent = NULL;
>>   	struct device_node *rep = NULL;
>>   	struct device *rdev = NULL;
>> @@ -128,7 +153,8 @@ static int of_coresight_parse_endpoint(struct device_node *ep,
>>   			break;
>>   
>>   		/* Parse the local port details */
>> -		if (of_graph_parse_endpoint(ep, &endpoint))
>> +		local_port = of_coresight_endpoint_get_port_id(dev, ep);
>> +		if (local_port < 0)
>>   			break;
>>   		/*
>>   		 * Get a handle on the remote endpoint and the device it is
>> @@ -140,9 +166,6 @@ static int of_coresight_parse_endpoint(struct device_node *ep,
>>   		rparent = of_graph_get_port_parent(rep);
>>   		if (!rparent)
>>   			break;
>> -		if (of_graph_parse_endpoint(rep, &rendpoint))
>> -			break;
>> -
>>   		/* If the remote device is not available, defer probing */
>>   		rdev = of_coresight_get_endpoint_device(rparent);
>>   		if (!rdev) {
>> @@ -150,9 +173,15 @@ static int of_coresight_parse_endpoint(struct device_node *ep,
>>   			break;
>>   		}
>>   
>> -		conn->outport = endpoint.port;
>> +		child_port = of_coresight_endpoint_get_port_id(rdev, rep);
>> +		if (child_port < 0) {
>> +			ret = 0;
> 
> Why returning '0' on an error condition?  Same for 'local_port' above.
> 

If we are unable to parse a port, we can simply ignore the port and continue, which
is what we have today with the existing code. I didn't change it and still think
it is the best effort thing. We could spit a warning for such cases, if really needed.
Also, the parsing code almost never fails at the moment. If it fails to find "reg" field,
it is assumed to be '0'. Either way ignoring it seems harmless. That said I am open
to suggestions.

Cheers
Suzuki
