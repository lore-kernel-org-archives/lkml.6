Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 771C76070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932453AbeFFKQX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:16:23 -0400
Received: from foss.arm.com ([217.140.101.70]:39036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752243AbeFFKQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:16:21 -0400
Subject: Re: [PATCH 01/20] coresight: Fix memory leak in coresight_register
To: Arvind Yadav <arvind.yadav.cs@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc: mathieu.poirier@linaro.org, robh@kernel.org,
        frowand.list@gmail.com, mark.rutland@arm.com, sudeep.holla@arm.com,
        arm@kernel.org, linux-kernel@vger.kernel.org, matt.sealey@arm.com,
        john.horley@arm.com, charles.garcia-tobin@arm.com,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        mike.leach@linaro.org
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-2-git-send-email-suzuki.poulose@arm.com>
 <b0100f00-c706-3a41-ca55-3c1329c53aa3@gmail.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <16154816-2760-8582-23f1-da607b344db6@arm.com>
Date: Wed, 6 Jun 2018 11:16:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <b0100f00-c706-3a41-ca55-3c1329c53aa3@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2018 07:44 AM, Arvind Yadav wrote:
> Hi Suzuki,
> 
> 
> On Wednesday 06 June 2018 03:13 AM, Suzuki K Poulose wrote:
>> commit 6403587a930c ("coresight: use put_device() instead of kfree()")
>> introduced a memory leak where, if we fail to register the device
>> for coresight_device, we don't free the "coresight_device" object,
>> which was allocated via kzalloc(). Fix this by jumping to the
>> appropriate error path.
> put_device() will decrement the last reference and then
> free the memory by calling dev->release.  Internally
> put_device() -> kobject_put() -> kobject_cleanup() which is
> responsible to call 'dev -> release' and also free other kobject
> resources. If you will see the coresight_device_release. There
> we are releasing all allocated memory. Still if you call kfree() again
> then it'll be redundancy.

You're right. I think it would be good to have a comment explaining this
to prevent this fix popping up in the future :-). I will add it

Thanks
Suzuki
