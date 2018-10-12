Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBA9C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EEB2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZfS4nbFz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZfS4nbFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EEB2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbeJLU1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 16:27:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57876 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbeJLU1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 16:27:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E94F360116; Fri, 12 Oct 2018 12:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539348928;
        bh=Ev0I13m5cYLwqIYwfwPSm3OR0pkwNn5w5dCv4c7K0zM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZfS4nbFzd4pwLNLQtl/VbYVuZ13PUBXAv2Va0z/rxbRormv6cUh/06nP/4+AGi8SB
         Uhz6oV9VSzxRKL06v5/vN3LsiwfqgXRiSE4geD0XUUN+CmLHvqL7wEdGeO/8gkfHJq
         IERQRroavXT0EN+lH7eKhuqj1y8IwHUa7rEg/MHI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 44ABC60116;
        Fri, 12 Oct 2018 12:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539348928;
        bh=Ev0I13m5cYLwqIYwfwPSm3OR0pkwNn5w5dCv4c7K0zM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZfS4nbFzd4pwLNLQtl/VbYVuZ13PUBXAv2Va0z/rxbRormv6cUh/06nP/4+AGi8SB
         Uhz6oV9VSzxRKL06v5/vN3LsiwfqgXRiSE4geD0XUUN+CmLHvqL7wEdGeO/8gkfHJq
         IERQRroavXT0EN+lH7eKhuqj1y8IwHUa7rEg/MHI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 12 Oct 2018 05:55:28 -0700
From:   Sodagudi Prasad <psodagud@codeaurora.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     catalin.marinas@arm.com, gregkh@linuxfoundation.org,
        ard.biesheuvel@linaro.org, robin.murphy@arm.com,
        ynorov@caviumnetworks.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: livelock with hrtimer cpu_base->lock
In-Reply-To: <20181010164919.GA16512@arm.com>
References: <8f671ebb6b331cd00ce17d111f28c548@codeaurora.org>
 <20181010164919.GA16512@arm.com>
Message-ID: <63fae7b2ef8dc4cc67928329cf7fcb60@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-10 09:49, Will Deacon wrote:
> Hi Prasad,
> 
> On Tue, Oct 09, 2018 at 01:56:14PM -0700, Sodagudi Prasad wrote:
>> This is regarding - thread "try to fix contention between 
>> expire_timers and
>> try_to_del_timer_sync".
>> https://lkml.org/lkml/2017/7/28/172
>> 
>> I think this live lockup issue was discussed earlier but the final set 
>> of
>> changes were not concluded.
> 
> Well we basically need a way to pick a value for 
> CPU_RELAX_WFE_THRESHOLD.
> Do you have any ideas? It could be determined at runtime if necessary.
> 
Hi Will,

Please share what are values need to be tried for 
CPU_RELAX_WFE_THRESHOLD.

  It would be great if it can be determined from runtime.  Please let me 
know
if any testing need to be done with dynamic detection patch.

-Thanks, Prasad

>> I would like to check whether you have new updates on this issue or 
>> not.
>> This problem is observed with 4.14 .64 stable kernel too.
>> We see this problem 2 times in overnight testing.
>> 
>> I have to add the following code to avoid live lock. I am thinking 
>> that
>> fixing this at the cpu_relax() level.
>> 
>> +++ b/kernel/time/hrtimer.c
>> @@ -52,6 +52,7 @@
>>  #include <linux/timer.h>
>>  #include <linux/freezer.h>
>>  #include <linux/compat.h>
>> +#include <linux/delay.h>
>> 
>>  #include <linux/uaccess.h>
>> 
>> @@ -152,6 +153,7 @@ struct hrtimer_clock_base *lock_hrtimer_base(const
>> struct hrtimer *timer,
>> raw_spin_unlock_irqrestore(&base->cpu_base->lock, *flags);
>>                 }
>>                 cpu_relax();
>> +               udelay(1);
>>         }
>>  }
>> 
>> @@ -1067,6 +1069,7 @@ int hrtimer_cancel(struct hrtimer *timer)
>>                 if (ret >= 0)
>>                         return ret;
>>                 cpu_relax();
>> +               udelay(1);
>>         }
>>  }
>>  EXPORT_SYMBOL_GPL(hrtimer_cancel);
> 
> This is just another bodge and likely to hurt in places where 1us is
> excessive because there isn't contention.
> 
> Will

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
