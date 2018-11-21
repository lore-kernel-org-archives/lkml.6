Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710C6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4F32087E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="T5A2zuy2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Zpt5hEdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4F32087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbeKUQPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 11:15:50 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58534 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeKUQPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 11:15:50 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B1490604BE; Wed, 21 Nov 2018 05:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542778969;
        bh=cg++jPYdvEMH05r/S5ppxU4kSI9sjHmyEPOakhsFU+g=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=T5A2zuy2u8Mm7qL4AtjLi/aedIb3sEFZJzQz1LUFWtB6w/wV2aaqBiRF5TTZ7Z9wn
         OU4N7chraN0T3OQmZNLMDatrwuHu6JdJ/WhI1zO3/Ijiksgz0nh4TLnaZNbH50VOO7
         IaSJjOu9WLOLJb3SI/zvjgm72FUenCHalbwejIQs=
Received: from [10.79.128.198] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 71AF5604BE;
        Wed, 21 Nov 2018 05:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542778968;
        bh=cg++jPYdvEMH05r/S5ppxU4kSI9sjHmyEPOakhsFU+g=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=Zpt5hEdGU3KGQq1yhkaudwFsqfquOwv6v0zOqZLSPuhvd2GphVBvhaNR8ds8/9VO8
         i9aBf0d9exQvqUqhgKF40rMlBuvse1aSNhHvrHg7QgwyZpQzQIAaUnlKh1XC8OTdwJ
         v4sYBgUXI1DqbhChAq0n2Uj7wSUV7NNc4G9r0hig=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 71AF5604BE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 4/4] PM / Domains: Propagate performance state updates
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
References: <cover.1541399301.git.viresh.kumar@linaro.org>
 <7e1ea283f9eebce081af80ddb8d3ca5c9c76cd3b.1541399301.git.viresh.kumar@linaro.org>
 <71530b01-eefa-4778-0b17-d7774eb48356@codeaurora.org>
 <20181121051626.izb6dem62zoaf2c4@vireshk-i7>
 <68a3294f-5556-4b5f-f8c7-79c20b5c70fb@codeaurora.org>
Message-ID: <5efc76bb-7732-52b6-4684-82b35ad52343@codeaurora.org>
Date:   Wed, 21 Nov 2018 11:12:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <68a3294f-5556-4b5f-f8c7-79c20b5c70fb@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/21/2018 11:01 AM, Rajendra Nayak wrote:
> 
> 
> On 11/21/2018 10:46 AM, Viresh Kumar wrote:
>> On 21-11-18, 10:33, Rajendra Nayak wrote:
>>> Hi Viresh,
>>>
>>> On 11/5/2018 12:06 PM, Viresh Kumar wrote:
>>>> This commit updates genpd core to start propagating performance state
>>>> updates to master domains that have their set_performance_state()
>>>> callback set.
>>>>
>>>> A genpd handles two type of performance states now. The first one is the
>>>> performance state requirement put on the genpd by the devices and
>>>> sub-domains under it, which is already represented by
>>>> genpd->performance_state. The second type, introduced in this commit, is
>>>> the performance state requirement(s) put by the genpd on its master
>>>> domain(s). There is a separate value required for each master that the
>>>> genpd has and so a new field is added to the struct gpd_link
>>>> (link->performance_state), which represents the link between a genpd and
>>>> its master. The struct gpd_link also got another field
>>>> prev_performance_state, which is used by genpd core as a temporary
>>>> variable during transitions.
>>>>
>>>> We need to propagate setting performance state while powering-on a genpd
>>>> as well, as we ignore performance state requirements from sub-domains
>>>> which are powered-off. For this reason _genpd_power_on() also received
>>>> the additional parameter, depth, which is used for hierarchical locking
>>>> within genpd.
>>>>
>>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>> ---
>>>>    drivers/base/power/domain.c | 107 +++++++++++++++++++++++++++++-------
>>>>    include/linux/pm_domain.h   |   4 ++
>>>>    2 files changed, 92 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>>>> index 6d2e9b3406f1..81e02c5f753f 100644
>>>> --- a/drivers/base/power/domain.c
>>>> +++ b/drivers/base/power/domain.c
>>>> @@ -239,28 +239,86 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
>>>>    static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
>>>>    #endif
>>>> +static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
>>>> +                       unsigned int state, int depth);
>>>> +
>>>>    static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
>>>> -                    unsigned int state)
>>>> +                    unsigned int state, int depth)
>>>>    {
>>>> +    struct generic_pm_domain *master;
>>>> +    struct gpd_link *link;
>>>> +    unsigned int mstate;
>>>>        int ret;
>>>>        if (!genpd_status_on(genpd))
>>>>            goto out;
>>>
>>> This check here would mean we only propogate performance state
>>> to masters if the genpd is ON?
>>
>> Yeah, isn't that what should we do anyway? It is similar to clk-enable
>> etc. Why increase the reference count if the device isn't enabled and
>> isn't using the clock ?
> 
> I would think this is analogous to a driver calling clk_set_rate() first and
> then a clk_enable(), which is certainly valid.
> So my question is, if calling a dev_pm_genpd_set_performance_state()
> and then runtime enabling the device would work (and take care of propagating the performance
> state). In my testing I found it does not.

And the reason for that seems to be that we update the genpd status to GPD_STATE_ACTIVE
*after* we try to set the performance state, so we always hit this check which bails out
thinking the genpd is not ON.

> 
>>
>> Also you can see that I have updated the genpd power-on code to start
>> propagation to make sure we don't miss anything.
>>
