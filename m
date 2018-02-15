Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755975AbeBOV1N (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 16:27:13 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35652 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755950AbeBOV1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 16:27:12 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 21A3960960
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skannan@codeaurora.org
Message-ID: <5A85FB2E.2050407@codeaurora.org>
Date: Thu, 15 Feb 2018 13:27:10 -0800
From: Saravana Kannan <skannan@codeaurora.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
MIME-Version: 1.0
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bo Yan <byan@nvidia.com>,
        sgurrappadi@nvidia.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: skip cpufreq resume if it's not suspended
References: <1516744675-21233-1-git-send-email-byan@nvidia.com> <dc33ef16-9684-3d8d-f4cc-6e24697f007f@nvidia.com> <20180205040118.GB28462@vireshk-i7> <1710637.vo8uP0oTBm@aspire.rjw.lan> <20180205090546.GE28462@vireshk-i7>
In-Reply-To: <20180205090546.GE28462@vireshk-i7>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2018 01:05 AM, Viresh Kumar wrote:
> On 05-02-18, 09:50, Rafael J. Wysocki wrote:
>> By design (which I admit may be confusing) it should be fine to call
>> dpm_resume_end() after a failing dpm_suspend_start(), whatever the reason
>> for the failure is.  cpufreq_suspend/resume() don't take that into account,
>> everybody else does.
>
> Hmm, I see. Can't do much then, just fix the only broken piece of code :)
>

Sorry for the late reply, this email didn't get filtered into the right 
folder.

I think the design of dpm_suspend_start() and dpm_resume_end() generally 
works fine because we seem to keep track of what devices have been 
suspended so far (in the dpm_suspended_list) and call resume only of 
those. So, why isn't the right fix to have cpufreq get put into that 
list? Instead of just always call it on the resume path even if it 
wasn't suspended? That seems to be the real issue.

So, we should either have dpm_suspend/resume() have a flag to keep track 
of if cpufreq_suspend/resume() was called and make sure they are called 
in proper pairs. Or have cpufreq register in a way that gets it put in 
the suspend/resume list.

I'd still like to NACK this change.

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
