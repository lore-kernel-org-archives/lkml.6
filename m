Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0AAC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E7E20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E7E20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932813AbeFUJha (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 05:37:30 -0400
Received: from foss.arm.com ([217.140.101.70]:47806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932692AbeFUJh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 05:37:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B9EB1435;
        Thu, 21 Jun 2018 02:37:28 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C652A3F246;
        Thu, 21 Jun 2018 02:37:27 -0700 (PDT)
Subject: Re: [PATCH 3/6] coresight: Introduce support for Coresight Address
 Translation Unit
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1529319379-17895-1-git-send-email-suzuki.poulose@arm.com>
 <1529319379-17895-4-git-send-email-suzuki.poulose@arm.com>
 <20180620214157.GA20697@xps15>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <76e0bc22-468c-6215-de54-3e4ead42e17c@arm.com>
Date:   Thu, 21 Jun 2018 10:37:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620214157.GA20697@xps15>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 20/06/1822:41, Mathieu Poirier wrote:
> Hi Suzuki,
> 
> On Mon, Jun 18, 2018 at 11:56:16AM +0100, Suzuki K Poulose wrote:
>> Add the initial support for Coresight Address Translation Unit, which
>> augments the TMC in Coresight SoC-600 by providing an improved Scatter
>> Gather mechanism. CATU is always connected to a single TMC-ETR and
>> converts the AXI address with a translated address (from a given SG
>> table with specific format). The CATU should be programmed in pass
>> through mode and enabled if the ETR doesn't translation by CATU.
> 
> To me this sentence look broken.
> 

Yes, it is broken. It should have been :

"The CATU should be programmed in pass through mode and enabled
even if the ETR doesn't use the translation by CATU."


>> +static int catu_disable_hw(struct catu_drvdata *drvdata)
>> +{
>> +	int rc = 0;
>> +
>> +	if (catu_wait_for_ready(drvdata)) {
>> +		dev_info(drvdata->dev, "Timeout while waiting for READY\n");
>> +		rc = -EAGAIN;
>> +	}
>> +
>> +	catu_write_control(drvdata, 0);
> 
> Is waiting for the ready bit before switching the component off comes from
> experimentation with the HW (i.e FPGA)?  From what the reference manual
> indicate, CONTROL.ENABLE should be set to 0 first, and then wait for
> STATUS.READY.

You're right. It should be in the reverse order. I will fix it in the next version.

Thanks
Suzuki
