Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id VgByOR5WGVscPAAAmS7hNA
	; Thu, 07 Jun 2018 15:58:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D8CAE6074D; Thu,  7 Jun 2018 15:58:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 62A1360590;
	Thu,  7 Jun 2018 15:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 62A1360590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934752AbeFGP6U (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:58:20 -0400
Received: from foss.arm.com ([217.140.101.70]:53874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933050AbeFGP6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:58:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CE3D80D;
        Thu,  7 Jun 2018 08:58:15 -0700 (PDT)
Received: from [192.168.0.102] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F03B53F59D;
        Thu,  7 Jun 2018 08:58:10 -0700 (PDT)
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
To: Quentin Perret <quentin.perret@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mingo@redhat.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <b47cb1f1-6ca1-7674-903f-724be43a57a0@arm.com>
 <20180606143739.GF10870@e108498-lin.cambridge.arm.com>
 <20180606152000.GB15894@localhost.localdomain>
 <20180606152950.GH10870@e108498-lin.cambridge.arm.com>
 <20180606162647.GI10870@e108498-lin.cambridge.arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <2802df66-8947-dc2c-a99f-cf872ddaeddb@arm.com>
Date: Thu, 7 Jun 2018 17:58:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180606162647.GI10870@e108498-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2018 06:26 PM, Quentin Perret wrote:
> On Wednesday 06 Jun 2018 at 16:29:50 (+0100), Quentin Perret wrote:
>> On Wednesday 06 Jun 2018 at 17:20:00 (+0200), Juri Lelli wrote:
>>>>> This brings me to another question. Let's say there are multiple users of
>>>>> the Energy Model in the system. Shouldn't the units of frequency and power
>>>>> not standardized, maybe Mhz and mW?
>>>>> The task scheduler doesn't care since it is only interested in power diffs
>>>>> but other user might do.
>>>>
>>>> So the good thing about specifying units is that we can probably assume
>>>> ranges on the values. If the power is in mW, assuming that we're talking
>>>> about a single CPU, it'll probably fit in 16 bits. 65W/core should be
>>>> a reasonable upper-bound ?
>>>> But there are also vendors who might not be happy with disclosing absolute
>>>> values ... These are sometimes considered sensitive and only relative
>>>> numbers are discussed publicly. Now, you can also argue that we already
>>>> have units specified in IPA for ex, and that it doesn't really matter if
>>>> a driver "lies" about the real value, as long as the ratios are correct.
>>>> And I guess that anyone can do measurement on the hardware and get those
>>>> values anyway. So specifying a unit (mW) for the power is probably a
>>>> good idea.
>>>
>>> Mmm, I remember we fought quite a bit while getting capacity-dmpis-mhz
>>> binding accepted, and one of the musts was that the values were going to
>>> be normalized. So, normalized power values again maybe?
>>
>> Hmmm, that's a very good point ... There should be no problems on the
>> scheduler side -- we're only interested in correct ratios. But I'm not
>> sure on the thermal side ... I will double check that.
> 
> So, IPA needs to compare the power of the CPUs with the power of other
> things (e.g. GPUs). So we can't normalize the power of the CPUs without
> normalizing in the same scale the power of the other devices. I see two
> possibilities:
> 
> 1) we don't normalize the CPU power values, we specify them in mW, and
>     we document (and maybe throw a warning if we see an issue at runtime)
>     the max range of values. The max expected power for a single core
>     could be 65K for ex (16bits). And based on that we can verify
>     overflow and precision issues in the algorithms, and we keep it easy
>     to compare the CPU power numbers with other devices.

I would say we need 1). 32bit values with units and proper documentation 
of the possible ranges.

[...]
