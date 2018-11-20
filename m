Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662D8C04EBB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5545321104
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VDFFI/3K";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D0R80/V6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5545321104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbeKTVQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:16:02 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58914 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbeKTVQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:16:02 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3EAF660B62; Tue, 20 Nov 2018 10:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542710851;
        bh=S63kebeHj7xBsL52Ldg+na9rIPTwdFpWMDCW19hjKBE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VDFFI/3Kp6wttWPbtG9iTqfNv5IcQScsafk447sFtaligaERgYNWUWB0QvJmKtCgv
         8RXusG9I0eou73eUkhPXwFMpbXMtAdDHCImz+RFRJEu4x6ydMI2ZYeBmHYGJ9ng72N
         BD9aHJSVpjl4/weLnXAi+bu/oFyfCpqD/RI97zkY=
Received: from [10.206.16.36] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 09A98601D1;
        Tue, 20 Nov 2018 10:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542710850;
        bh=S63kebeHj7xBsL52Ldg+na9rIPTwdFpWMDCW19hjKBE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=D0R80/V6yEiaUcFHSvxvp0N3B52ZLQtGkHFjHGP0Z6kC9iTlMqcXjRGpyS2AcdrJA
         6sUJxeeyMyjHohhL1OxyaNoTZQ2qbBCD7KWN7rHACLKrBxVj4OaZYEf5OKK8bgIGvR
         2wwMc7wQghVklriW6zBxD3knCHCUnLO4bIzjgQQI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 09A98601D1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
Subject: Re: [PATCH v8 24/26] drivers: firmware: psci: Deal with CPU hotplug
 when using OSI mode
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <20180620172226.15012-25-ulf.hansson@linaro.org>
 <9bf3713b-df00-03b3-d235-7549565382c7@codeaurora.org>
 <CAPDyKFond=Q-cWsjKwGToprjPTFj=WA_-nsAoUFJdNCdkki8Rw@mail.gmail.com>
From:   Raju P L S S S N <rplsssn@codeaurora.org>
Message-ID: <5bbdf737-2542-cd5e-f4f2-5aabe8702639@codeaurora.org>
Date:   Tue, 20 Nov 2018 16:17:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFond=Q-cWsjKwGToprjPTFj=WA_-nsAoUFJdNCdkki8Rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf, This is noticed in v4.19 as well. Could you please check if 
CONFIG_DEBUG_ATOMIC_SLEEP is enabled in your case? I think with current 
patch the scenario would be applicable.

On 11/20/2018 3:20 PM, Ulf Hansson wrote:
> On 19 November 2018 at 20:50, Raju P L S S S N <rplsssn@codeaurora.org> wrote:
>> Hi Ulf,
>>
>> Got one issue in hotplug path where of_genpd_detach_cpu calls
>> dev_pm_qos_remove_notifier which can be sleeping as per below call stack. I
>> think it should be applicable for current patch as well right? Please let me
>> know what am I missing? why didn't you see this issue with this patch?
> 
> Weird.
> 
>>
>>
>> [ 8103.221387] BUG: sleeping function called from invalid context at
>> /mnt/host/source/src/third_party/kernel/v4.14/kernel/locking/mutex.c:238
> 
> Could it be due to some other patch in your v.4.14 kernel?
> 
>> [ 8103.221455] in_atomic(): 1, irqs_disabled(): 128, pid: 11, name:
>> migration/0
>> [ 8103.221487] Preemption disabled at:
>> [ 8103.221529] [<ffffff800814dfb0>] cpu_stopper_thread+0x98/0x118
>> [ 8103.221600] ------------[ cut here ]------------
>> [ 8103.221636] kernel BUG at
>> /mnt/host/source/src/third_party/kernel/v4.14/kernel/sched/core.c:6102!
>> [ 8103.221678] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>> [ 8103.222396] CPU: 0 PID: 11 Comm: migration/0 Tainted: G        W  4.14.72
>> #1
>> [ 8103.222428] Hardware name: Google Cheza (rev1) (DT)
>> [ 8103.222460] task: ffffffc0f842d580 task.stack: ffffff8009c18000
>> [ 8103.222504] PC is at ___might_sleep+0x138/0x140
>> [ 8103.222542] LR is at ___might_sleep+0x138/0x140
>> [ 8103.222577] pc : [<ffffff80080d8f04>] lr : [<ffffff80080d8f04>] pstate:
>> 60c001c9
>> [ 8103.222605] sp : ffffff8009c1bb40
>> ….
>> [ 8103.223924] [<ffffff80080d8f04>] ___might_sleep+0x138/0x140
>> [ 8103.223965] [<ffffff80080d8d98>] __might_sleep+0x4c/0x80
>> [ 8103.224009] [<ffffff80088e4258>] mutex_lock+0x28/0x60
>> [ 8103.224054] [<ffffff800850fa2c>] dev_pm_qos_remove_notifier+0x1c/0x54
>> [ 8103.224097] [<ffffff8008517814>] genpd_remove_device+0x3c/0x10c
>> [ 8103.224140] [<ffffff800851949c>] genpd_dev_pm_detach+0x48/0x108
>> [ 8103.224183] [<ffffff80085193e0>] of_genpd_detach_cpu+0x48/0xbc
>> [ 8103.224227] [<ffffff80083edea4>] cpu_pd_dying+0x28/0x38
>> [ 8103.224268] [<ffffff80080ab2c0>] cpuhp_invoke_callback+0x254/0x5f0
>> [ 8103.224308] [<ffffff80080acdec>] take_cpu_down+0x60/0x9c
>> [ 8103.224346] [<ffffff800814d898>] multi_cpu_stop+0xac/0x104
>> [ 8103.224385] [<ffffff800814dfb8>] cpu_stopper_thread+0xa0/0x118
>> [ 8103.224427] [<ffffff80080cff74>] smpboot_thread_fn+0x19c/0x278
>> [ 8103.224472] [<ffffff80080cc0c4>] kthread+0x120/0x130
>> [ 8103.224513] [<ffffff8008084608>] ret_from_fork+0x10/0x18
> 
> Thanks for the report, I will double check my series before I post the
> new version of my series. If nothing unexpected shows up, that should
> be in a couple of days from now.
> 
> I keep you cc.
> 
> [...]
> 
> Kind regards
> Uffe
> 
