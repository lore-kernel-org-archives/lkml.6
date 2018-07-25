Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF65EC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F7B2064D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F7B2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbeGYKMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:12:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34306 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728222AbeGYKMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:12:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BD9680D;
        Wed, 25 Jul 2018 02:01:22 -0700 (PDT)
Received: from [10.37.10.30] (unknown [10.37.10.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66C843F237;
        Wed, 25 Jul 2018 02:01:19 -0700 (PDT)
Subject: Re: [PATCH v2 02/10] coresight: platform: Refactor graph endpoint
 parsing
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Matt Sealey <matt.sealey@arm.com>,
        Charles Garcia-Tobin <charles.garcia-tobin@arm.com>,
        coresight@lists.linaro.org, John Horley <john.horley@arm.com>,
        Mike Leach <mike.leach@linaro.org>
References: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
 <1531997715-6767-3-git-send-email-suzuki.poulose@arm.com>
 <20180724213031.GA22451@xps15>
 <CANLsYkwDTM2pT0JCCnLdetKoYe6xsmj48Gyb5OJFxJMmRLrZ_g@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <ea1a6672-0cbb-86b7-c8cd-0759edb94f85@arm.com>
Date:   Wed, 25 Jul 2018 10:01:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CANLsYkwDTM2pT0JCCnLdetKoYe6xsmj48Gyb5OJFxJMmRLrZ_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2018 10:34 PM, Mathieu Poirier wrote:
> On Tue, 24 Jul 2018 at 15:30, Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
>>
>> Good afternoon,
>>
>> On Thu, Jul 19, 2018 at 11:55:06AM +0100, Suzuki K Poulose wrote:
>>> Refactor the of graph endpoint parsing code, to make the error
>>> handling easier.
>>>
>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> ---
>>> Changes since v1:
>>>   - Splitted from the of_node refcounting fix, part1
>>> ---
>>>   drivers/hwtracing/coresight/of_coresight.c | 129 +++++++++++++++++------------
>>>   1 file changed, 75 insertions(+), 54 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
>>> index 6880bee..68faaf8 100644
>>> --- a/drivers/hwtracing/coresight/of_coresight.c
>>> +++ b/drivers/hwtracing/coresight/of_coresight.c
>>> @@ -114,17 +114,69 @@ int of_coresight_get_cpu(const struct device_node *node)
>>>   }
>>>   EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
>>>
>>> +/*
>>> + * of_coresight_parse_endpoint : Parse the given output endpoint @ep
>>> + * and fill the connection information in @pdata[*@i].
>>> + *
>>> + * Parses the local port, remote device name and the remote port. Also
>>> + * updates *@i to point to the next index, when an entry is added.
>>> + *
>>> + * Returns :
>>> + *    0      - If the parsing completed without any fatal errors.
>>> + *   -Errno  - Fatal error, abort the scanning.
>>> + */
>>> +static int of_coresight_parse_endpoint(struct device *dev,
>>> +                                    struct device_node *ep,
>>> +                                    struct coresight_platform_data *pdata,
>>> +                                    int *i)
>>> +{
>>> +     int ret = 0;
>>> +     struct of_endpoint endpoint, rendpoint;
>>> +     struct device_node *rparent = NULL;
>>> +     struct device_node *rport = NULL;
>>> +     struct device *rdev = NULL;
>>> +
>>> +     do {
>>> +             /* Parse the local port details */
>>> +             if (of_graph_parse_endpoint(ep, &endpoint))
>>> +                     break;
>>> +             /*
>>> +              * Get a handle on the remote port and parent
>>> +              * attached to it.
>>> +              */
>>> +             rparent = of_graph_get_remote_port_parent(ep);
>>> +             if (!rparent)
>>> +                     break;
>>> +             rport = of_graph_get_remote_port(ep);
>>> +             if (!rport)
>>> +                     break;
>>> +             if (of_graph_parse_endpoint(rport, &rendpoint))
>>> +                     break;
>>> +
>>> +             /* If the remote device is not available, defer probing */
>>> +             rdev = of_coresight_get_endpoint_device(rparent);
>>> +             if (!rdev) {
>>> +                     ret = -EPROBE_DEFER;
>>> +                     break;
>>> +             }
>>> +
>>> +             pdata->outports[*i] = endpoint.port;
>>> +             pdata->child_names[*i] = dev_name(rdev);
>>> +             pdata->child_ports[*i] = rendpoint.id;
>>> +             /* Move the index */
>>> +             (*i)++;
>>
>> Not a big fan, makes the code needlessly complex.  Incrementation of the index
>> can be done in the while loop of of_get_coresight_platform_data().  See below.

Me neither..

> 
> Void that - it properly deals with the first of_parse_endpoint().

Or may be we could do something with the return value :

	  1 - Successfully parsed and populated a connection entry
	  0 - No errors in parsing
	< 0 - Errors in parsing

>>> @@ -132,64 +184,33 @@ of_get_coresight_platform_data(struct device *dev,


>>> +     while ((ep = of_graph_get_next_endpoint(node, ep))) {
>>> +             /*
>>> +              * No need to deal with input ports, processing for as
>>> +              * processing for output ports will deal with them.
>>> +              */
>>
>> This comment has been broken for a while... It should read:
>>
>>                  /*
>>                   * No need to deal with input ports, as processing
>>                   * for output ports will deal with them.
>>                   */

Sure, will fix it.


Suzuki
