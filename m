Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5D5C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE81208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE81208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbeJOTTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:19:11 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60581 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeJOTTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:19:11 -0400
Received: from 79.184.253.168.ipv4.supernova.orange.pl (79.184.253.168) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 2fde9848ee950d54; Mon, 15 Oct 2018 13:34:16 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Bartholomae, Thomas" <t.bartholomae@intel.com>
Subject: Re: [PATCH] cpufreq: conservative: Fix requested_freq handling
Date:   Mon, 15 Oct 2018 13:31:03 +0200
Message-ID: <1926816.WaOCFmosuL@aspire.rjw.lan>
In-Reply-To: <CAHKzcEPuD7nnmvBjnUNn=wb-5LfN1nHoTYBekAiBFG8Je+oPwA@mail.gmail.com>
References: <20181008150901.19667-1-waldemar.rymarkiewicz@gmail.com> <2671493.AgiGORq3CZ@aspire.rjw.lan> <CAHKzcEPuD7nnmvBjnUNn=wb-5LfN1nHoTYBekAiBFG8Je+oPwA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 15, 2018 11:34:33 AM CEST Waldemar Rymarkiewicz wrote:
> On Thu, 11 Oct 2018 at 23:10, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Tuesday, October 9, 2018 6:06:08 PM CEST Waldemar Rymarkiewicz wrote:
> > > On Tue, 9 Oct 2018 at 09:47, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Mon, Oct 8, 2018 at 5:11 PM Waldemar Rymarkiewicz
> > > > <waldemar.rymarkiewicz@gmail.com> wrote:
> > > > >
> > > > > From: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
> > > > >
> > > > > The governor updates dbs_info->requested_freq only after increasing or
> > > > > decreasing frequency. There is, however, an use case when this is not
> > > > > sufficient.
> > > > >
> > > > > Imagine, external module constraining cpufreq policy in a way that policy->max
> > > >
> > > > Is the "external module" here a utility or a demon running in user space?
> > >
> > > No, this is a driver that communicates with a firmware and makes sure
> > > CPU is running at the highest rate in specific time.
> > > It uses verify_within_limits  and update_policy, a standard way to
> > > constraint cpufreq policy limits.
> > >
> > > > > @@ -136,10 +135,10 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
> > > > >                         requested_freq = policy->min;
> > > > >
> > > > >                 __cpufreq_driver_target(policy, requested_freq, CPUFREQ_RELATION_L);
> > > > > -               dbs_info->requested_freq = requested_freq;
> > > > >         }
> > > > >
> > > > >   out:
> > > > > +       dbs_info->requested_freq = requested_freq;
> > > >
> > > > This will have a side effect when requested_freq is updated before the
> > > > thresholds checks due to the policy_dbs->idle_periods < UINT_MAX
> > > > check.
> > > >
> > > > Shouldn't that be avoided?
> > >
> > > I would say we should.
> > >
> > > A hardware design I use is running 4.9 kernel where the check does not
> > > exist yet, so there is not a problem.
> > > Anyway, the check policy_dbs->idle_periods < UINT_MAX  can change
> > > requested_freq  either to requested_freq = policy->min or
> > > requested_freq -= freq_steps;. The first case will not change anything
> > > for us as policy->max=min=cur. The second, however, will force to
> > > update freq which is definitely not expected when limits are set to
> > > min=max. Simply it will not go out  here:
> > >
> > > if (load < cs_tuners->down_threshold) {
> > >       if (requested_freq == policy->min)
> > >            goto out;   <---
> > > ...
> > > }
> > >
> > > Am I right here? If so, shouldn't we check explicitly
> > >
> > > /*
> > > * If requested_freq is out of range, it is likely that the limits
> > > * changed in the meantime, so fall back to current frequency in that
> > > * case.
> > > */
> > > if (requested_freq > policy->max || requested_freq < policy->min)
> > >        requested_freq = policy->cur;
> > >
> > > +/*
> > > +* If the the new limits min,max are equal, there is no point to process further
> > > +*/
> > > +
> > > +if (requested_freq == policy->max  &&  requested_freq == policy->min)
> > > +     goto out;
> >
> > If my understanding of the problem is correct, it would be better to simply
> > update dbs_info->requested_freq along with requested_freq when that is found
> > to be out of range.  IOW, something like the appended patch (untested).
> 
> Yes, this will solve the original problem as well.
> 
> I think there could also be a  problem with policy_dbs->idle_periods <
> UINT_MAX  check. It it's true it  can modify requested_freq (
> requested_freq -= freq_steps) and further it can result in a change of
> the freq,  requested_freq == policy->max is not anymore true. I would
> expect governor not to change freq (requested_freq) when
> policy->max=policy->min=policy->cur.

Well, that's because there is a bug in that code IMO.  It should never
decrease requested_freq below policy->min in particular.

Please find a patch with that fixed below.

---
 drivers/cpufreq/cpufreq_conservative.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
@@ -80,8 +80,10 @@ static unsigned int cs_dbs_update(struct
 	 * changed in the meantime, so fall back to current frequency in that
 	 * case.
 	 */
-	if (requested_freq > policy->max || requested_freq < policy->min)
+	if (requested_freq > policy->max || requested_freq < policy->min) {
 		requested_freq = policy->cur;
+		dbs_info->requested_freq = requested_freq;
+	}
 
 	freq_step = get_freq_step(cs_tuners, policy);
 
@@ -92,7 +94,7 @@ static unsigned int cs_dbs_update(struct
 	if (policy_dbs->idle_periods < UINT_MAX) {
 		unsigned int freq_steps = policy_dbs->idle_periods * freq_step;
 
-		if (requested_freq > freq_steps)
+		if (requested_freq > policy->min + freq_steps)
 			requested_freq -= freq_steps;
 		else
 			requested_freq = policy->min;

