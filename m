Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A21C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C00217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfBSKUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:20:08 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58286 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbfBSKUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:20:08 -0500
Received: from 79.184.254.15.ipv4.supernova.orange.pl (79.184.254.15) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id d8048f506a930846; Tue, 19 Feb 2019 11:20:05 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Yangtao Li <tiny.windzz@gmail.com>, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: scmi: fix use-after-free in scmi_cpufreq_exit()
Date:   Tue, 19 Feb 2019 11:18:39 +0100
Message-ID: <2386834.BKf6y2r8fF@aspire.rjw.lan>
In-Reply-To: <20190218045330.zpiivw7mvv4hzctq@vireshk-i7>
References: <20190216163148.12375-1-tiny.windzz@gmail.com> <20190218045330.zpiivw7mvv4hzctq@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 18, 2019 5:53:30 AM CET Viresh Kumar wrote:
> On 16-02-19, 11:31, Yangtao Li wrote:
> > This issue was detected with the help of Coccinelle. So
> > change the order of function calls to fix it.
> > 
> > Fixes: 1690d8bb91e37 (cpufreq: scpi/scmi: Fix freeing of dynamic OPPs)
> > 
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/cpufreq/scmi-cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> > index 242c3370544e..9ed46d188cb5 100644
> > --- a/drivers/cpufreq/scmi-cpufreq.c
> > +++ b/drivers/cpufreq/scmi-cpufreq.c
> > @@ -187,8 +187,8 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
> >  
> >  	cpufreq_cooling_unregister(priv->cdev);
> >  	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
> > -	kfree(priv);
> >  	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
> > +	kfree(priv);
> >  
> >  	return 0;
> >  }
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> @Rafael: Please pick it up for 5.0-rc8 as the bug was introduced
> during 5.0 cycle only.
> 
> The patch it fixes had this tag:
> 
>     Cc: 4.20 <stable@vger.kernel.org> # v4.20
> 
> And so will get applied to 4.20.N, I guess we need to mark this patch
> as well for stable then.

Done now, thanks!

