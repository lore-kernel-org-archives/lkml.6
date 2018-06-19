Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC40C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCEC20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VquvI8h7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCEC20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757049AbeFSKKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:10:22 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33103 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756453AbeFSKKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:10:19 -0400
Received: by mail-pg0-f66.google.com with SMTP id e11-v6so8956039pgq.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 03:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CegfmdZRrk4O9Tyt3ZP1/aBTf9HosjBY00qSpoNf0TY=;
        b=VquvI8h7sS00OckaSnImIp4q9g4Xv1E94U4lkZQ3Pag7+oE1aj0kyVSuH192gZ0X6a
         kN+8plihPFXgFY0rA5YgJGuPYQEKOnqWExE6yppYnPlWClA6qmtSEb5UVsHVflV4MhgN
         a8XLYGpKvodEIclu/AB5aB79rWkT6CZ1qJnN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CegfmdZRrk4O9Tyt3ZP1/aBTf9HosjBY00qSpoNf0TY=;
        b=a3WUKXwuF4RzPnQK02WV9DbEIhh+QoQf2IvQZAYhOTGKRK8H3EAsY0PsKB5t8pcvox
         /K4zQpaFQ3f1Ncw55DZaQw6RPyyIrqh+qBYjc2BtmvhaSvccuM3TIWbWVYzswTUWBsCA
         lBPLONzUORpF0QMRr+rm98kt6XMMCidVyjgipFBv9JV9ORaZUPCw1YtAuJv7qwloQnWk
         MkUtQ7AHCPVmf0rZnRh7dKK3l2pjgmMJH6nKeLKuHNGpHnoX5NpxjEgl/VzWOT1st3EZ
         6vOSjETDfqfO3bg/ToD3lS9lZdYnacWbhePUGmysWVAyZC5cZquLXobYpZPx1lDqCmWt
         vlIw==
X-Gm-Message-State: APt69E2vVFtSP6yczFQjpUK/Gj/Fkw+Zx75jAyoVXWCk9lKtJYyRg4oP
        UIL+61VaSiNd4tcWAchE+mp5Lg==
X-Google-Smtp-Source: ADUXVKKuKPBnykS/X644Zu1C5cmtSoB2ZuEpcCdDWxvQahkCfpN9UrsMUqnahSyH3Fw3NaLbVhJG7g==
X-Received: by 2002:a65:504a:: with SMTP id k10-v6mr14298721pgo.151.1529403019317;
        Tue, 19 Jun 2018 03:10:19 -0700 (PDT)
Received: from localhost ([122.171.103.96])
        by smtp.gmail.com with ESMTPSA id y23-v6sm35730279pfa.73.2018.06.19.03.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 03:10:18 -0700 (PDT)
Date:   Tue, 19 Jun 2018 15:40:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     David Collins <collinsd@codeaurora.org>, sboyd@kernel.org,
        andy.gross@linaro.org, ulf.hansson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] soc: qcom: rpmpd/rpmhpd: Add a max vote on all
 corners at init
Message-ID: <20180619101016.hbgjvev7d3h4yg7x@vireshk-i7>
References: <20180612044052.4402-1-rnayak@codeaurora.org>
 <20180612044052.4402-8-rnayak@codeaurora.org>
 <414598de-00a1-9ce7-3a7e-4a95fd1bd35d@codeaurora.org>
 <f5014664-1639-c610-a50a-db66484428dc@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5014664-1639-c610-a50a-db66484428dc@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-06-18, 12:05, Rajendra Nayak wrote:
> On 06/14/2018 03:58 AM, David Collins wrote:
> > Hello Rajendra,
> > 
> > On 06/11/2018 09:40 PM, Rajendra Nayak wrote:
> >> As we move from no clients/consumers in kernel voting on corners,
> >> to *some* voting and some not voting, we might end up in a situation
> >> where the clients which remove votes can adversly impact others
> > 
> > s/adversly/adversely/
> > 
> >> who still don't have a way to vote.
> >>
> >> To avoid this situation, have a max vote on all corners at init.
> >> This should/can be removed once we have all clients moved to
> >> be able to vote/unvote for themselves.
> > 
> > This change seems like a hack.  Do you intend for it to be merged and then
> > later reverted in Linus's tree?  Could it instead be implemented in a way
> > that does not require reverting and instead is enabled by some DT
> > property?  Alternatively, could this feature be added to the power domain
> > core since it is relatively generic?
> > 
> > 
> >> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >> ---
> >>  drivers/soc/qcom/rpmhpd.c | 12 +++++++++++-
> >>  drivers/soc/qcom/rpmpd.c  |  9 +++++++++
> >>  2 files changed, 20 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> >> index 7083ec1590ff..3c753d33aeee 100644
> >> --- a/drivers/soc/qcom/rpmhpd.c
> >> +++ b/drivers/soc/qcom/rpmhpd.c
> >> @@ -329,7 +329,7 @@ static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
> >>  
> >>  static int rpmhpd_probe(struct platform_device *pdev)
> >>  {
> >> -	int i, ret;
> >> +	int i, ret, max_level;
> >>  	size_t num;
> >>  	struct genpd_onecell_data *data;
> >>  	struct rpmhpd **rpmhpds;
> >> @@ -390,6 +390,16 @@ static int rpmhpd_probe(struct platform_device *pdev)
> >>  		pm_genpd_init(&rpmhpds[i]->pd, NULL, true);
> >>  
> >>  		data->domains[i] = &rpmhpds[i]->pd;
> >> +
> >> +		/*
> >> +		 * Until we have all consumers voting on corners
> >> +		 * just vote the max corner on all PDs
> >> +		 * This should ideally be *removed* once we have
> >> +		 * all (most) consumers being able to vote
> >> +		 */
> >> +		max_level = rpmhpds[i]->level_count - 1;
> >> +		rpmhpd_set_performance(&rpmhpds[i]->pd, rpmhpds[i]->level[max_level]);
> >> +		rpmhpd_power_on(&rpmhpds[i]->pd);
> > 
> > Clearly these calls will result in max level requests being sent for all
> > power domains at probe time.  However, it isn't clear that this will
> > actually help at runtime in these two cases:
> > 
> > 1. A consumer enables and then disables a power domain.
> > 	- It seems like the PD would just be disabled in this case.

So instead of rpmhpd_power_on() we should be doing gepnd_power_on() or whatever
the API is, so the user count stays at 1.

> > 2. A consumer sets a non-max performance state of a power domain.
> > 	- It seems like the PD would just be set to the new lower
> > 	  performance state since the max vote isn't known to the
> > 	  PD core for aggregation purposes.

Right, and that's because the patch isn't implemented properly yet. I asked to
do a fake vote from some user with their dev structure, so the vote always
stays.

> Yes, you are right. I certainly did not seem to have thought through this enough.
> 
> A need for something like this came up at a point where genpd could not deal with
> devices with multiple power domains. So the concern at that point was that if some
> consumers (which only need to vote on one corner) move to using this driver, while 
> some others (which need to vote on multiple corners) cannot, we would end up breaking
> them.
> 
> That does not seem to be true anymore since we do have patches from Ulf which support
> having devices with multiple power domains attached which can be controlled individually.
> So if some consumer voting makes some others break, they should just be fixed and patched
> to vote as well. If all this gets handled centrally from within the clock drivers then we
> most likely won't even end up with a situation like this.
> 
> I think I will just drop this one unless Stephen/Viresh still see an issue with some early
> voters breaking others.

So what if the LCD/DDR/etc are getting used at boot and someone requests a lower
vote?  Wouldn't we just break ?

-- 
viresh
