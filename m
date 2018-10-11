Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC78C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF1D2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E0wrYN3T";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lV9aG/29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF1D2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbeJLEfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:35:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52714 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbeJLEfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:35:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CB63E60BF7; Thu, 11 Oct 2018 21:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539291971;
        bh=ctmXa9N+aPJF65+eniniCAUtIddEj2hv+SV2WsQTIf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E0wrYN3TIS65R+QvRbCr2UBSmyX6dJINaVwIgytJ5ChY3urNNXWQlO0XKN4gvmGxh
         qVn+/k1U7lOQN2MlWq4XB0KFTKepRnIl8lcGlB6U7IweI55ozx2qfgvVAmifkVOkHQ
         A5uVlRWE/5N2uedFUYgBnQQ65CeDEYBMMjABkcr0=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A51726063F;
        Thu, 11 Oct 2018 21:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539291970;
        bh=ctmXa9N+aPJF65+eniniCAUtIddEj2hv+SV2WsQTIf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lV9aG/29gobbStF9T3S10IgBv27DrmVE2yK+E96wKbeu+epUpozJiBWwmPBuWIQWg
         UlUr894Ujr9uT6GrQ/6/eOYh78+vD0t0DJ52Ed5JSsSWOl/yS9FKN/u8A24H3dkach
         eXffIqnCRq1PAtKnv/6uENV26F56e8MHHR18OZew=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A51726063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Thu, 11 Oct 2018 15:06:09 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, rjw@rjwysocki.net, ulf.hansson@linaro.org,
        khilman@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org,
        mka@chromium.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC v1 7/8] drivers: qcom: cpu_pd: Handle cpu hotplug in
 the domain
Message-ID: <20181011210609.GD2371@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-8-git-send-email-rplsssn@codeaurora.org>
 <20181011112013.GC32752@e107155-lin>
 <20181011160053.GA2371@codeaurora.org>
 <20181011161927.GC28583@e107155-lin>
 <20181011165822.GB2371@codeaurora.org>
 <20181011173733.GA26447@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181011173733.GA26447@e107155-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11 2018 at 11:37 -0600, Sudeep Holla wrote:
>On Thu, Oct 11, 2018 at 10:58:22AM -0600, Lina Iyer wrote:
>> On Thu, Oct 11 2018 at 10:19 -0600, Sudeep Holla wrote:
>> > On Thu, Oct 11, 2018 at 10:00:53AM -0600, Lina Iyer wrote:
>> > > Sudeep,
>> > >
>> > > The CPU PD does not power off the domain from Linux. That is done from
>> > > PSCI firmware (ATF). These patches are doing the part that Linux has do,
>> > > when powering off the CPUs, to achieve a low standby power consumption.
>> > >
>> >
>> > I don't understand why Linux *has do* this part as PSCI manages CPU PM.
>> >
>> If we don't do this, then we leave a lot of power saving on the table,
>> when the CPU powered off. Why should the DDR and the shared busses and
>> clocks be idling at high power, when not needed ? PSCI has no clue to
>> what resource requests was made my Linux and its Linux's responsibility
>> to relinquish them when not needed. Therefore has to done from Linux.
>>
>
>Is DDR managed by Linux ? I assumed it was handled by higher exception
>levels. Can you give examples of resources used by CPU in this context.
>When CPU can be powered on or woken up without Linux intervention, the
>same holds true for CPU power down or sleep states. I still see no reason
>other than the firmware has no support to talk to RPMH.
>
DDR, shared clocks, regulators etc. Imagine you are running something on
the screen and CPUs enter low power mode, while the CPUs were active,
there was a need for bunch of display resources, and things the app may
have requested resources, while the CPU powered down the requests may
not be needed the full extent as when the CPU was running, so they can
voted down to a lower state of in some cases turn off the resources
completely. What the driver voted for is dependent on the runtime state
and the usecase currently active. The 'sleep' state value is also
determined by the driver/framework.

>> Even with all the unnecessary flushing it is totally worth it. OSI helps
>> alleviates this a bit because it embodies the same CPU PD concepts at
>> its core. Imagine if you didn't have CPU PM domain, the every CPU would
>> be flushing RPMH request, whenever they power down, because you never know
>> when all CPUs are going to be powered down at the same time. That is the
>> biggest benefit of OSI over PC mode in PSCI.
>>
>
>I am not saying every CPU needs to do that, last CPU can do that in PSCI.
>
Yes, the last CPU is what we are getting to with this series.. Now this
can't be done from PSCI. I will explain below.

>Oh interesting, wasn't aware RPMH really needs to care about exception
>level. For me, we know CPU is powering down, so it needs to release all
>the resource. RPMH needs to know that and any exception level can let
>RPMH know that. Sorry may be I don't have enough knowledge on SDM SoC.
>
Some resources are secure resources used in secure environments. They
cannot be requested from non-secure. Hence secure levels are voters of
their own accord.

Now, since we are considering linux and secure (infact linux,hyp,secure)
as separate voters they have to each request their votes and release
their votes separately. PSCI cannot release a request made from Linux.
This is how the SoC is designed. All exception levels will abide by
that.

>> Yes, we are close to having a platform have both, possibly.
>>
>
>Comparison numbers please :)
>
We are far from it, for that, atleast now. But we will get there.

>Having to adapt DT to the firmware though the feature is fully discoverable
>is not at all good IMO. So the DT in this series *should work* with OSI
>mode if the firmware has the support for it, it's as simple as that.
>
The firmware is ATF and does not support OSI.

Thanks,
Lina
