Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D63C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31EF21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfAXKfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:35:30 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:60462 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfAXKfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:35:30 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 6e16a5cb23be5aa0; Thu, 24 Jan 2019 11:35:27 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: e_powersaver: Use struct_size() in kzalloc()
Date:   Thu, 24 Jan 2019 11:34:28 +0100
Message-ID: <1645829.9I2fkU6ktd@aspire.rjw.lan>
In-Reply-To: <20190108050056.quckhd2d5ah4ywax@vireshk-i7>
References: <20190107173343.GA4258@embeddedor> <20190108050056.quckhd2d5ah4ywax@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, January 8, 2019 6:00:56 AM CET Viresh Kumar wrote:
> On 07-01-19, 11:33, Gustavo A. R. Silva wrote:
> > One of the more common cases of allocation size calculations is finding the
> > size of a structure that has a zero-sized array at the end, along with memory
> > for some number of elements for that array. For example:
> > 
> > struct foo {
> >     int stuff;
> >     void *entry[];
> > };
> > 
> > instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> > 
> > Instead of leaving these open-coded and prone to type mistakes, we can now
> > use the new struct_size() helper:
> > 
> > instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> > 
> > This code was detected with the help of Coccinelle.
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > ---
> >  drivers/cpufreq/e_powersaver.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
> > index 60bea302abbe..2d3ef208dd70 100644
> > --- a/drivers/cpufreq/e_powersaver.c
> > +++ b/drivers/cpufreq/e_powersaver.c
> > @@ -323,9 +323,8 @@ static int eps_cpu_init(struct cpufreq_policy *policy)
> >  		states = 2;
> >  
> >  	/* Allocate private data and frequency table for current cpu */
> > -	centaur = kzalloc(sizeof(*centaur)
> > -		    + (states + 1) * sizeof(struct cpufreq_frequency_table),
> > -		    GFP_KERNEL);
> > +	centaur = kzalloc(struct_size(centaur, freq_table, states + 1),
> > +			  GFP_KERNEL);
> >  	if (!centaur)
> >  		return -ENOMEM;
> >  	eps_cpu[0] = centaur;
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch applied, thanks!


