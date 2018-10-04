Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148B6C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AF620652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7AF620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeJDWvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:51:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39376 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727369AbeJDWvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:51:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94356ED1;
        Thu,  4 Oct 2018 08:58:01 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.emea.arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE4493F774;
        Thu,  4 Oct 2018 08:57:58 -0700 (PDT)
Date:   Thu, 4 Oct 2018 16:57:55 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 00/11] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM) (a subset)
Message-ID: <20181004155755.GD5233@e107981-ln.cambridge.arm.com>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
 <CAJZ5v0h7jvoa4oUeM4FgFizF_jbAonoAgP3m417n_TGqfqNsqg@mail.gmail.com>
 <CAPDyKFq0GLs2AMA+6b-Khf+4kGxzVCTvtehp-YmwV2h=_SP4=g@mail.gmail.com>
 <10136406.EY9A7BdqYq@aspire.rjw.lan>
 <CAJZ5v0iv9OYoaLYHsmdp2xbDuENPgue_mBgFujdmesnBOegRKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iv9OYoaLYHsmdp2xbDuENPgue_mBgFujdmesnBOegRKQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 11:32:41AM +0200, Rafael J. Wysocki wrote:
> On Thu, Oct 4, 2018 at 11:04 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Thursday, October 4, 2018 10:58:53 AM CEST Ulf Hansson wrote:
> > > On 4 October 2018 at 10:39, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > On Wed, Oct 3, 2018 at 4:39 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >>
> > > >> I have digested the review comments so far, including a recent offlist chat
> > > >> with with Lorenzo Pieralisi around the debatable PSCI changes. More or less I
> > > >> have a plan for how to move forward.
> > > >>
> > > >> However, to avoid re-posting non-changed patches over and over again, I decided
> > > >> to withhold the more debatable part from this v9, hence this is not the complete
> > > >> series to make things play. In v9, I have just included the trivial changes,
> > > >> which are either already acked/reviewed or hopefully can be rather soon/easily.
> > > >>
> > > >> My hope is to get this queued for v4.20, to move things forward. I know it's
> > > >> late, but there are more or less nothing new here since v8.
> > > >
> > > > I have no problems with the first three patches in this series, so I
> > > > can apply them right away.  Do you want me to do that?
> > >
> > > Yes, please.
> > >
> > > >
> > > > As for the rest, the cpuidle driver patch looks OK to me, but the
> > > > PSCI-related ones need ACKs.
> > >
> > > For some yes, but I think you can go ahead with a few more.
> > >
> > > Patch 4, 5 is already acked/reviewed.
> > >
> > > Patch 6 should be fine (if you are okay with it else wait for an ack
> > > from Daniel)
> >
> > OK, thanks.
> >
> > Do the 4-6 depend on the 1-3?
> 
> I don't see any dependency there, so I'll queue up the 1-3 in
> pm-domains and the 4-6 in pm-cpuidle.

I do not see why we should merge patches 4-6 for v4.20; they add legacy
(DT bindings and related parsing code) with no user in the kernel; we
may still want to tweak them, in particular PSCI DT bindings.

Likewise, it makes no sense to merge patches 7-8 without the rest of
the PSCI patches.

Why do not we target v4.20-rc1 for the whole series re-posting and we take
it from there given that we are at -rc6 tail end ?

Thanks,
Lorenzo
