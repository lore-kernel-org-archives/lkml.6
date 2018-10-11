Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FEDC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A8621470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GkRE8ssr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O/5B3kbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A8621470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbeJKX2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:28:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45522 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeJKX2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:28:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6990260BFE; Thu, 11 Oct 2018 16:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539273656;
        bh=t1Vo0NtjPsuSW/VmstdGm4/hznBdxfi6gzgBc4S20e4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GkRE8ssrW7pq5CSRWDHHcDcTud/7KToHVf3WPB8XVlAfce30ZLnpSwEO32W4ffosM
         Kgtf5HaG5FenMSDzVcj/+ByE2TUWIEXe/8f0UmnrPpMvSAP14/SFgmKAT3w9aCV6B4
         +hIju1tXa1T/8CdyVrm2htnzVgDSbL3pNEUOL148=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8037060BFE;
        Thu, 11 Oct 2018 16:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539273654;
        bh=t1Vo0NtjPsuSW/VmstdGm4/hznBdxfi6gzgBc4S20e4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O/5B3kbt9wRK++PEzZ/q+rtY3gSKZTAc2ngARRBi9Pqn2cPSbV1+TSeT9gyC8s/bi
         jMxZJ2Z4/h09nTNMj0GhHTUI9LMBJ6rRLb8JltG76aubilaO64V2rU0/Rz1i+Ag7FY
         wOKmyJODqkDwtTDHCFRnwdPnODO8xda03NWAFKW8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8037060BFE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Thu, 11 Oct 2018 10:00:53 -0600
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
Message-ID: <20181011160053.GA2371@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-8-git-send-email-rplsssn@codeaurora.org>
 <20181011112013.GC32752@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181011112013.GC32752@e107155-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sudeep,

This is idea is based on GenPD/PM Domains, but solves for the CPU domain
activities that need to be done from Linux when the CPU domain could be
powered off. In that, it shares the same ideas from the series posted by
Ulf. But this has no bearing on PSCI. The 845 SoC that Raju is working
on, uses Platform-coordinated and so is largely deficient in meeting the
power benefits achievable on this SoC, from Linux.

If you have looked at the patches, you probably know by now, there are
two things this patch does when the CPUs are powered off -
- Flush RPMH requests to the controller (shared resource state requests
  after the CPU is powered off and resume to the current state before
  the CPU wakes up).
- Setup the wakeup time for the CPUs in the hardware registers such that
  the hardware blocks are awake before a CPU is powered back on. This is
  like a back-off time for handling timer wakeups faster.

The CPU PD does not power off the domain from Linux. That is done from
PSCI firmware (ATF). These patches are doing the part that Linux has do,
when powering off the CPUs, to achieve a low standby power consumption.

On Thu, Oct 11 2018 at 05:20 -0600, Sudeep Holla wrote:
>On Thu, Oct 11, 2018 at 02:50:54AM +0530, Raju P.L.S.S.S.N wrote:
>> Use cpu hotplug callback mechanism to attach/dettach the cpu in
>> the cpu power domain. During cpu hotplug callback registration,
>> the starting callback is invoked on all online cpus. So there is
>> no need to attach from device probe.
>>
>
>To be more explicit, NACK to this series(patches 4-8 to be more specific)
>unless you provide details on:
>
>1. Why this is not in PSCI implementation ?
This is a linux activity and there is no provision in ATF or QC firmware
to do this activity. The task of physically powering down the domain,
still is a firmware decision and is done through PSCI platform
coordinated in the firmware.

>2. If PSCI is used on this platform, how does it work/co-exist ?
Yes PSCI is used in this platform. ATF is the firmware and that supports
only Platform Coordinated. This SoC uses cpuidle and the regular PSCI
methods to power off the domain from the firmware. However, Linux has
responsibilities that it needs to complete before the power down can be
beneficial.

>3. Is this a shortcut approached taken to bypass the CPU genpd attempts
>   from Lina/Ulf ?
>
This is an incorrect interpretation and an unwarranted accusation. There
is no need to bypass CPU genpd attempts. That series stands on its own
merits. (Thank you, Ulf). Raju has mentioned in the cover letter
explicitly, that Ulf's patches posted here are for completeness of the
concept, as that series is a dependency. But it will merged as part of
Ulf's efforts.

Isn't sharing ideas a key aspect of working with the community? This
series just goes to say that the idea of CPU PM domains are useful,
whether PSCI uses it or not. If you still need clarifications, Raju and
I will be happy to set up a meeting and go over the idea.

Thanks,
Lina
