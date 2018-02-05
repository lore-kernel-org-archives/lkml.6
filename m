Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbeBEIwP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 03:52:15 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:59705 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752317AbeBEIwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 03:52:09 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Bo Yan <byan@nvidia.com>, Saravana Kannan <skannan@codeaurora.org>,
        sgurrappadi@nvidia.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: skip cpufreq resume if it's not suspended
Date: Mon, 05 Feb 2018 09:50:28 +0100
Message-ID: <1710637.vo8uP0oTBm@aspire.rjw.lan>
In-Reply-To: <20180205040118.GB28462@vireshk-i7>
References: <1516744675-21233-1-git-send-email-byan@nvidia.com> <dc33ef16-9684-3d8d-f4cc-6e24697f007f@nvidia.com> <20180205040118.GB28462@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 5, 2018 5:01:18 AM CET Viresh Kumar wrote:
> On 02-02-18, 13:28, Bo Yan wrote:
> > On 02/02/2018 11:34 AM, Saravana Kannan wrote:
> > >I rather have this fixed in the dpm_suspend/resume() code. This is just
> > >masking the first issue that's being caused by unbalanced error handling.
> > >If that means adding flags in dpm_suspend/resume() then that's what we
> > >should do right now and clean it up later if it can be improved. Making
> > >cpufreq more messy doesn't seem like the right answer.
> 
> +1
> 
> > dpm_suspend and dpm_resume by themselves are not balanced in this particular
> > case. As it's currently structured, dpm_resume can't be omitted even if
> > dpm_suspend is skipped due to earlier failure.  I think checking
> > cpufreq_suspended flag is a reasonable compromise. If we can find a way to
> > make dpm_suspend/dpm_resume also balanced, that will be best.
> 
> I think cpufreq is just one of the users which broke. Others didn't break
> because:
> 
> - They don't have a complicated resume part.
> - Or we just don't know that they broke.

No and no.

> Resuming something that never suspended is just broken by design. Yeah, its much
> simpler in this particular case to fix cpufreq core but the
> suspend/resume/hibernation part is really core kernel and should be fixed to
> avoid such band-aids.

By design (which I admit may be confusing) it should be fine to call
dpm_resume_end() after a failing dpm_suspend_start(), whatever the reason
for the failure is.  cpufreq_suspend/resume() don't take that into account,
everybody else does.

Thanks,
Rafael
