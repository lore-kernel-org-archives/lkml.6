Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B152FC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D26520659
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D26520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbeJKX16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:27:58 -0400
Received: from foss.arm.com ([217.140.101.70]:40156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727042AbeJKX15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:27:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FC33ED1;
        Thu, 11 Oct 2018 09:00:08 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 508B63F5D3;
        Thu, 11 Oct 2018 09:00:05 -0700 (PDT)
Date:   Thu, 11 Oct 2018 16:59:56 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>, mka@chromium.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH RFC v1 4/8] drivers: qcom: cpu_pd: add cpu power domain
 support using genpd
Message-ID: <20181011155956.GA28583@e107155-lin>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-5-git-send-email-rplsssn@codeaurora.org>
 <20181011111306.GB32752@e107155-lin>
 <CAPDyKFpXJ4MbqFOmDboBuR_1sziyuDi3qgKVvhokaAnQQ+kzjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpXJ4MbqFOmDboBuR_1sziyuDi3qgKVvhokaAnQQ+kzjA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 05:27:59PM +0200, Ulf Hansson wrote:
> On 11 October 2018 at 13:13, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > On Thu, Oct 11, 2018 at 02:50:51AM +0530, Raju P.L.S.S.S.N wrote:
> >> RPMH based targets require that the sleep and wake state request votes
> >> be sent during system low power mode entry. The votes help reduce the
> >> power consumption when the AP is not using them. The votes sent by the
> >> clients are cached in RPMH controller and needs to be flushed when the
> >> last cpu enters low power mode. So add cpu power domain using Linux
> >> generic power domain infrastructure to perform necessary tasks as part
> >> of domain power down.
> >>
> >
> > You seem to have either randomly chosen just 3 patches from Lina/Ulf's
> > CPU genpd series or this series doesn't entirely depend on it ?
> 
> Yep, it not easy to follow. But I do understand what you are trying to do here.
> 
> >
> > If latter, how does this work with PSCI CPU_SUSPEND operations ?
> >
> > And why this can be part of PSCI firmware implementation. Only PSCI
> > firmware needs if RPMH votes need to be flushed or not. So, honestly
> > I don't see the need for this in Linux.
> 
> I do think there is clear need for this in Linux. More precisely,
> since the PSCI firmware have knowledge solely about CPUs (and clusters
> of CPUs), but not about other shared resources/devices present on the
> SoC.
>

I disagree. Even with OSI, you indicate the cluster power off though
PSCI CPU_SUSPEND call. If for any async wakeup reasons, firmware decides
not to enter cluster OFF, then it may skip flushing RPMH vote. So doing
it in PSCI is more correct and elegant to avoid such corner cases.

> What Raju is trying to do here, is to manage those resources which
> needs special treatment, before and after the CPU (likely cluster) is
> going idle and returns from idle.
>

OK I get that, but why is Linux better than PSCI. I have my reasoning
above.

> One question here though, what particular idle state is relevant for
> the QCOM SoC to take last-man-actions for? I assume it's only cluster
> idle states, and not about cpu idle states, no? Raju, can you please
> clarify?
>

I assume so. I did see some comment or commit message to indicate the
same.

> Historically, the typical solution have been to use the
> cpu_cluster_pm_enter|exit() notifiers. Those could potentially be
> replaced by instead building a hierarchical topology, using
> master/subdomain of genpd/"power-domains", along the lines of what
> Raju is doing. However, I am not sure if that is the correct approach,
> at least we need to make sure it models the HW in DT correctly.
>

Indeed. I am not sure how to represent both PSCI and this power domains ?
Though I believe the latter is not required at all.

--
Regards,
Sudeep
