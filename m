Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DB6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4089D217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OumhfZUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387750AbeLTRQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:16:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38148 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732885AbeLTRQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:16:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so2562703wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hSPuEWRRK7wMhu9OfMbHsNDR/FeXcaBZmoLhSCUdMRs=;
        b=OumhfZUkI/U0KQevVpk3cMXgzj5YsX8TR7OYR4S4/L8vudzJ4rsoT0Kz6uG1MhPmy7
         2kLJWgPV4opvutrosIuL9SLIy/zR9txHWAR8peb7+v8VyYjD0QfQojKY8eVv7DzETQy7
         vAVPgLwyJwKtEggfm0B51PoclvvQmGRJPxBiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hSPuEWRRK7wMhu9OfMbHsNDR/FeXcaBZmoLhSCUdMRs=;
        b=HUT5tFq5UN3jAifzAXEGJ6tTumugpDpTaER9sgKFkxz9n03nzpVaDE1uSMgf7oueym
         MGj/2xyHjCtIF0Y98LWjt2Alg2ejwgnC9F/eYBDUyqt+Ww/hN/yVRU/RtLD6rv598fn8
         0S9fSNHhlRlBSBTu7Ie+U/q7M+7IwMj26VGzjn5jcaRm4JcTWoVkiaUGVUWZJjel9K98
         1dzdkl1F8EAXq2uLFHe6wA5LWUjeGLGltnHuAq130wGxSwy0OR1hwkS58Eq/p7t8UY+h
         2VKiiMqGZms/aCaldXbiBOqHmu6cZ5q9jAPzk5CeObPLJj4myXhVtabA6iuVOa/81o+5
         DY3Q==
X-Gm-Message-State: AA+aEWbOc/xrRS51FSFw9NkE0qTfzni3X6LD8dMbkfSkoYgKBnPIqziQ
        iffR4b2rY854/kKJWOZxPHG9ec4qPJI=
X-Google-Smtp-Source: AFSGD/X9HwzfwzJfpEHl4DkaDE8vakqF5lkNgW85yvdIQUa6NYwiXkTs5buTByly2RAyMT8t8WSkbA==
X-Received: by 2002:adf:e78f:: with SMTP id n15mr24059134wrm.115.1545326205755;
        Thu, 20 Dec 2018 09:16:45 -0800 (PST)
Received: from [192.168.0.40] (55.183.88.92.rev.sfr.net. [92.88.183.55])
        by smtp.googlemail.com with ESMTPSA id v132sm8379247wme.20.2018.12.20.09.16.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 09:16:44 -0800 (PST)
Subject: Re: [PATCH v10 16/27] drivers: firmware: psci: Prepare to use OS
 initiated suspend mode
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-17-ulf.hansson@linaro.org>
 <20e1c04b-870f-3213-835d-28724ef4f530@linaro.org>
 <CAPDyKFqwB0X6DwamGqYgYKsGRcZRzStT=o_AL2wGExuOkQ2rgw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <fe405425-9d94-9f14-b599-63a709e004cf@linaro.org>
Date:   Thu, 20 Dec 2018 18:16:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqwB0X6DwamGqYgYKsGRcZRzStT=o_AL2wGExuOkQ2rgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2018 16:41, Ulf Hansson wrote:
> On Thu, 20 Dec 2018 at 15:09, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 29/11/2018 18:46, Ulf Hansson wrote:
>>> To enable the OS initiated mode, the CPU topology needs to be described
>>> using the hierarchical model in DT. When used, the idle state bits for the
>>> CPU are created by ORing the bits for PM domain's idle state.
>>>
>>> Let's prepare the PSCI driver to deal with this, via introducing a per CPU
>>> variable called domain_state and by adding internal helpers to read/write
>>> the value of the variable.
>>
>> What are the domain states ? What values can they have ?
> 
> The existing psci_power_state, also defined as a per cpu variable,
> contains fixed values reflecting the corresponding
> arm,psci-suspend-param for the idle state in question.
> 
> This isn't sufficient, when using the hierarchical CPU topology in DT
> and when OSI mode is supported, because of the way we vote with the
> PSCI CPU suspend parameter. Parts of this parameter shall inform about
> what state to allow for the cluster, while other parts tells the state
> for the CPU.
> 
> The new "domain states" per CPU variable, gets dynamically changed
> when actively used by following patches that implements the PSCI PM
> domain support. Depending on what state the PM domain picks, the genpd
> ->power_off() callback sets a new "domain states" value, reflecting
> the state for the cluster.
> 
> Does it makes sense? If you like, I can try to update the changelog to
> clarify this?

Yes, it makes sense. May be give a pointer or an information about the
parameter encoding in addition to the description above can help.


>>> Cc: Lina Iyer <ilina@codeaurora.org>
>>> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>
>>> Changes in v10:
>>>       - Use __this_cpu_read|write() rather than this_cpu_read|write().
>>>
>>> ---
>>>  drivers/firmware/psci/psci.c | 26 ++++++++++++++++++++++----
>>>  1 file changed, 22 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
>>> index 4f0cbc95e41b..8dbcdecc2ae4 100644
>>> --- a/drivers/firmware/psci/psci.c
>>> +++ b/drivers/firmware/psci/psci.c
>>> @@ -87,8 +87,19 @@ static u32 psci_function_id[PSCI_FN_MAX];
>>>                               (PSCI_1_0_EXT_POWER_STATE_ID_MASK | \
>>>                               PSCI_1_0_EXT_POWER_STATE_TYPE_MASK)
>>>
>>> +static DEFINE_PER_CPU(u32, domain_state);
>>>  static u32 psci_cpu_suspend_feature;
>>>
>>> +static inline u32 psci_get_domain_state(void)
>>> +{
>>> +     return __this_cpu_read(domain_state);
>>> +}
>>> +
>>> +static inline void psci_set_domain_state(u32 state)
>>> +{
>>> +     __this_cpu_write(domain_state, state);
>>> +}
>>> +
>>>  static inline bool psci_has_ext_power_state(void)
>>>  {
>>>       return psci_cpu_suspend_feature &
>>> @@ -187,6 +198,8 @@ static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
>>>
>>>       fn = psci_function_id[PSCI_FN_CPU_ON];
>>>       err = invoke_psci_fn(fn, cpuid, entry_point, 0);
>>> +     /* Clear the domain state to start fresh. */
>>> +     psci_set_domain_state(0);
>>>       return psci_to_linux_errno(err);
>>
>> I think this change is ambiguous:
>>
>>  - if it is a change of the state because of the cpu_on, then I was
>> expecting a similar change in cpu_off and the change only if
>> invoke_psci_fn() succeeds.
> 
> You are right. This rather belongs to patch 24, as its intent is to
> deal with CPU hotplug.
> 
>>
>>  - if it is a change to take opportunity of the code path to initialize
>> the domain state, I suggest to remove it from there and make it very
>> explicit with static DEFINE_PER_CPU(u32, domain_state) = { 0 };
> 
> We shouldn't need to explicitly set static variables to zero, as that
> should be managed by the compiler.

Yeah, that was the purpose of the *very explicit* words, that is tell
the reader, the initialization relies on the static variables being set
to zero.

> Let me simply remove the call to  psci_set_domain_state(0) and instead
> consider it for patch 24.

Yes, sure.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

