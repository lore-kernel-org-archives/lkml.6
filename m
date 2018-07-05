Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58315C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1217E219EE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1217E219EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754026AbeGETSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 15:18:39 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7087 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753844AbeGETSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 15:18:38 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b3e6ee70001>; Thu, 05 Jul 2018 12:17:59 -0700
Received: from HQMAIL108.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 05 Jul 2018 12:18:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 05 Jul 2018 12:18:37 -0700
Received: from [172.17.136.14] (172.17.136.14) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 5 Jul
 2018 19:18:37 +0000
Subject: Re: [PATCH] irqchip/gic: check return value of of_address_to_resource
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>
References: <1530814859-11610-1-git-send-email-byan@nvidia.com>
 <20180705201327.4a4dc7dd@why.wild-wind.fr.eu.org>
From:   Bo Yan <byan@nvidia.com>
Message-ID: <5548bdf4-4e4f-a2e1-b194-da35da87e3d3@nvidia.com>
Date:   Thu, 5 Jul 2018 12:18:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180705201327.4a4dc7dd@why.wild-wind.fr.eu.org>
X-Originating-IP: [172.17.136.14]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL108.nvidia.com (172.18.146.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc,

I'm also wondering if of_address_to_resource can really fail in this 
particular case?

What if we just explicitly discard the return value like this:

(void)of_address_to_resource(node, 1, &cpuif_res);

This suppresses Coverity warning by explicitly stating we are 100% sure 
the function call will always return success.

On 07/05/2018 12:13 PM, Marc Zyngier wrote:
> Hi Bo,
> 
> On Thu, 5 Jul 2018 11:20:59 -0700
> Bo Yan <byan@nvidia.com> wrote:
> 
>> The of_address_to_resource returns 0 if successful. gic_check_eoimode
>> calls it without checking the return value. This induces Coverity
>> warning: "Unchecked return value".
>>
>> Return false from gic_check_eoimode if of_address_to_resource returns
>> non-0 value.
>>
>> Signed-off-by: Bo Yan <byan@nvidia.com>
>> ---
>>   drivers/irqchip/irq-gic.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
>> index ced10c4..0bceb10 100644
>> --- a/drivers/irqchip/irq-gic.c
>> +++ b/drivers/irqchip/irq-gic.c
>> @@ -1284,7 +1284,8 @@ static bool gic_check_eoimode(struct device_node *node, void __iomem **base)
>>   {
>>   	struct resource cpuif_res;
>>   
>> -	of_address_to_resource(node, 1, &cpuif_res);
>> +	if (of_address_to_resource(node, 1, &cpuif_res))
>> +		return false;
> 
> We've just done an of_iomap() on this resource, which succeeded. How
> can the same thing now fail? It would mean that the device tree has
> been pulled from under our feet...
> 
> And if it could happen, why is returning false the right thing to do?
> Why would we say we want EOImode==0 instead of 1?
> 
>>   
>>   	if (!is_hyp_mode_available())
>>   		return false;
> 
> As it stands, I'm not taking such a patch. It either papers over a
> bigger problem, or just keeps a warning quiet for the sake of it.
> 
> Thanks,
> 
> 	M.
> 
