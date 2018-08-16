Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F46C04AB9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A7D21480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A7D21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404127AbeHPSqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:46:51 -0400
Received: from foss.arm.com ([217.140.101.70]:38080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727026AbeHPSqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:46:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 487867A9;
        Thu, 16 Aug 2018 08:47:33 -0700 (PDT)
Received: from [10.4.13.23] (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 581953F5BD;
        Thu, 16 Aug 2018 08:47:32 -0700 (PDT)
Subject: Re: [PATCH 08/13] coresight: Add support for CLAIM tag protocol
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, mike.leach@arm.com
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
 <1533562915-21558-9-git-send-email-suzuki.poulose@arm.com>
 <20180814232053.GA5131@xps15>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <4aff79b4-593e-a19b-5e3f-de2a6d5bacb7@arm.com>
Date:   Thu, 16 Aug 2018 16:47:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180814232053.GA5131@xps15>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/18 00:20, Mathieu Poirier wrote:
> On Mon, Aug 06, 2018 at 02:41:50PM +0100, Suzuki K Poulose wrote:
>> Add support for the CLAIM tag protocol for negotiating the
>> device ownership with other agents trying to use the coresight
>> component (internal vs. external). The Coresight architecture
>> specifies CLAIM tags (managed via CLAIMSET CLAIMCLR registers)
>> to negotiate the ownership of the device. PSCI recommends the
>> reservation of the bits in CLAIM tags for self-hosted and external
>> debug use. This patch implements the protocol for claiming
>> the devices before they are actually used.
> 
> I think the first paragraph of the cover letter (minus the reference to the
> documentation since you've included it below) would be perfect instead of the
> above.
> 
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-priv.h |  7 +++
>>   drivers/hwtracing/coresight/coresight.c      | 85 ++++++++++++++++++++++++++++
>>   include/linux/coresight.h                    | 20 +++++++
>>   3 files changed, 112 insertions(+)

>> +void coresight_disclaim_device_unlocked(void __iomem *base)
>> +{
>> +
>> +	if (coresight_is_claimed_self_hosted(base))
>> +		coresight_clear_claim_tags(base);
>> +	else
>> +		/*
>> +		 * Either we or the external agent doesn't follow
>> +		 * the protocol.
>> +		 */
>> +		WARN_ON_ONCE(1);
> 
> When writing "... or the external agent doesn't follow the protocol", I deduce
> that an external agent would have trampled our claim tag.  I think this needs
> to be said explicitly in the comment.
> 

>> +static inline int coresight_claim_device_unlocked(void __iomem *base)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline int coresight_claim_device(void __iomem *base)
>> +{
>> +	return 0;
>> +}
> 
> Returning 0 would give a caller the impression the operation has succeeded when
> in fact it didn't.  I think we should return an error code here.


Agreed on all points, will respin.

Suzuki
