Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F25EC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A8D20833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A8D20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbeGYRZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:25:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41632 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbeGYRZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:25:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5533A80D;
        Wed, 25 Jul 2018 09:13:31 -0700 (PDT)
Received: from [10.37.10.30] (unknown [10.37.10.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7D883F575;
        Wed, 25 Jul 2018 09:13:28 -0700 (PDT)
Subject: Re: [PATCH v2 09/10] coresight: Cleanup coresight DT bindings
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, sudeep.holla@arm.com,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, matt.sealey@arm.com,
        charles.garcia-tobin@arm.com, coresight@lists.linaro.org,
        john.horley@arm.com, mike.leach@linaro.org
References: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
 <1531997715-6767-10-git-send-email-suzuki.poulose@arm.com>
 <20180725160939.GA24323@rob-hp-laptop>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <e96b9bda-8a58-a817-5580-7771af7c9e28@arm.com>
Date:   Wed, 25 Jul 2018 17:14:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180725160939.GA24323@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/25/2018 05:09 PM, Rob Herring wrote:
> On Thu, Jul 19, 2018 at 11:55:13AM +0100, Suzuki K Poulose wrote:
>> The coresight drivers relied on default bindings for graph
>> in DT, while reusing the "reg" field of the "ports" to indicate
>> the actual hardware port number for the connections. This can
>> cause duplicate ports with same addresses, but different
>> direction. However, with the rules getting stricter w.r.t to the
>> address mismatch with the label, it is no longer possible to use
>> the port address field for the hardware port number.
>>
>> This patch introduces new DT binding rules for coresight
>> components, based on the same generic DT graph bindings, but
>> avoiding the address duplication.
>>
>> - All output ports must be specified under a child node with
>>    name "out-ports".
>> - All input ports must be specified under a childe node with
>>    name "in-ports".
>> - Port address should match the hardware port number.
>>
>> The support for legacy bindings is retained, with a warning.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Rob Herring <robh@kernel.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   .../devicetree/bindings/arm/coresight.txt          | 91 ++++++++++----------
>>   drivers/hwtracing/coresight/of_coresight.c         | 97 +++++++++++++++++++---
>>   2 files changed, 129 insertions(+), 59 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
>> index 8e21512..f39d2c6 100644
>> --- a/Documentation/devicetree/bindings/arm/coresight.txt
>> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
>> @@ -104,19 +104,9 @@ The connections must be described via generic DT graph bindings as described
>>   by the "bindings/graph.txt", where each "port" along with an "endpoint"
>>   component represents a hardware port and the connection.
>>   
>> -Since it is possible to have multiple connections for any coresight component
>> -with a specific direction of data flow, each connection must define the
>> -following properties to uniquely identify the connection details.
>> -
>> - * Direction of the data flow w.r.t the component :
>> -   Each input port must have the following property defined at the "endpoint"
>> -   for the port.
>> -	"slave-mode"
>> -
>> - * Hardware Port number at the component:
>> -     -  The hardware port number is assumed to be the address of the "port"
>> -         component.
>> -
> 
> Why do you add this in the previous patch and then remove it here?

The only use case I can think of it is for someone to look back on the
legacy bindings, which were never documented. I could skip the parts 
that are being removed.

Suzuki
