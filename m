Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF7CC677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E752098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DbDTP/TC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nqrkLfue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E752098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbeJLA03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:26:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33428 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbeJLA03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:26:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0F4DC60C60; Thu, 11 Oct 2018 16:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539277104;
        bh=abM4gFVD0dRedOLi9kPkGRGjdfI2cs5Ew38+OqETY+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DbDTP/TChcpV1MNAWQBiK5dYrkmGHgTw663hBb1zSJIPANQsL0mTzipTXV3yua5BA
         PMU5kYIAzEXhUUOjUPqQF/hh4gG/SWNN8g8YJvqligxTQVVQNVG3gi9e8vzEntqNBR
         4Hy8pN4UZECVU3K7z4rh8UwVoOEf4oyUCv4t9H54=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E867E6024C;
        Thu, 11 Oct 2018 16:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539277103;
        bh=abM4gFVD0dRedOLi9kPkGRGjdfI2cs5Ew38+OqETY+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nqrkLfueEBdyaaPv2ncCcgc9kLQ85dRrPD8Emx70Fbi9uhspv914C3EIP5BuCzhKt
         JkW0i0z4URiS/oIlzZkYCB6DMi5/b1Krlv7YniEXNibWNGa7woACbyhGvB6fffJYOb
         3ngQMQ4SS4r7GQVFP9ChBKB/tVuV+irAatMT+yxM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E867E6024C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Thu, 11 Oct 2018 10:58:22 -0600
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
Message-ID: <20181011165822.GB2371@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-8-git-send-email-rplsssn@codeaurora.org>
 <20181011112013.GC32752@e107155-lin>
 <20181011160053.GA2371@codeaurora.org>
 <20181011161927.GC28583@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181011161927.GC28583@e107155-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11 2018 at 10:19 -0600, Sudeep Holla wrote:
>On Thu, Oct 11, 2018 at 10:00:53AM -0600, Lina Iyer wrote:
>> Sudeep,
>>
>> The CPU PD does not power off the domain from Linux. That is done from
>> PSCI firmware (ATF). These patches are doing the part that Linux has do,
>> when powering off the CPUs, to achieve a low standby power consumption.
>>
>
>I don't understand why Linux *has do* this part as PSCI manages CPU PM.
>
If we don't do this, then we leave a lot of power saving on the table,
when the CPU powered off. Why should the DDR and the shared busses and
clocks be idling at high power, when not needed ? PSCI has no clue to
what resource requests was made my Linux and its Linux's responsibility
to relinquish them when not needed. Therefore has to done from Linux.

>> On Thu, Oct 11 2018 at 05:20 -0600, Sudeep Holla wrote:
>> > On Thu, Oct 11, 2018 at 02:50:54AM +0530, Raju P.L.S.S.S.N wrote:
>> > > Use cpu hotplug callback mechanism to attach/dettach the cpu in
>> > > the cpu power domain. During cpu hotplug callback registration,
>> > > the starting callback is invoked on all online cpus. So there is
>> > > no need to attach from device probe.
>> > >
>> >
>> > To be more explicit, NACK to this series(patches 4-8 to be more specific)
>> > unless you provide details on:
>> >
>> > 1. Why this is not in PSCI implementation ?
>> This is a linux activity and there is no provision in ATF or QC firmware
>> to do this activity. The task of physically powering down the domain,
>> still is a firmware decision and is done through PSCI platform
>> coordinated in the firmware.
>>
>
>Yes that was my understanding. So the addon question here is: if PSCI
>decides to abort entering the idle state, the Linux doing the RPMH
>request is of no use which can be prevented if done once PSCI f/w is
>about to enter the state. I know it may be corner case, but we have
>whole OSI mode based on such corner cases.
>
Yes, it is a possibility and worth the chance taken. On an SoC, there
are other processors that may vote against powering down the shared
resources even when Linux has shutdown and it is a very likely
possibility. Ex., when you are on a phone call, the CPU subsystem could
be powered off and the flush of RPMH requests is a 'waste', but it is a
chance we need to take. The alternate is a synchronization nightmare.

Even with all the unnecessary flushing it is totally worth it. OSI helps
alleviates this a bit because it embodies the same CPU PD concepts at
its core. Imagine if you didn't have CPU PM domain, the every CPU would
be flushing RPMH request, whenever they power down, because you never know
when all CPUs are going to be powered down at the same time. That is the
biggest benefit of OSI over PC mode in PSCI.

>> > 2. If PSCI is used on this platform, how does it work/co-exist ?
>> Yes PSCI is used in this platform. ATF is the firmware and that supports
>> only Platform Coordinated. This SoC uses cpuidle and the regular PSCI
>> methods to power off the domain from the firmware. However, Linux has
>> responsibilities that it needs to complete before the power down can be
>> beneficial.
>>
>
>I understand the need to inform RPMH. So I take only reason to do that
>in Linux is TF-A doesn't have any support to talk to RPMH ?
>
It may or may not, depending on which firmware you talk to. But consider
this, if the firmware votes for lowering resource state, it is doing it
for its exception level and not for Linux. So Linux has to take care of
its own.

>Now that we have some platform with PC, it's good to compare PC vs OSI
>which we always lacked. Thanks for letting us know this platform is PC
>based.
>
Can I take that you are okay with the OSI idea and this one, then :)
Yes, we are close to having a platform have both, possibly.

>> Isn't sharing ideas a key aspect of working with the community? This
>> series just goes to say that the idea of CPU PM domains are useful,
>> whether PSCI uses it or not. If you still need clarifications, Raju and
>> I will be happy to set up a meeting and go over the idea.
>>
>Ah OK, so this platform will have flattened cpu-idle-states list ? That's
>absolutely fine. But what if we want to represent hierarchical PSCI based
>PM domains and this power domain for some platform. That's the main
>concern I raised. For me, the power-domains in DT introduced in this
>is just to deal with RPMH though the actual work is done by PSCI.
>That just doesn't look that good for me.
>
What problem do you see with that? It would help if you could clarify
your concern.

Thanks,
Lina
