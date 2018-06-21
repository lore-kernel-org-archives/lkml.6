Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E8BC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9935520883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9935520883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933248AbeFUNXv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:23:51 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55030 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932742AbeFUNXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:23:50 -0400
Received: from 79.184.254.22.ipv4.supernova.orange.pl (79.184.254.22) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id fcbdce66af83b2ee; Thu, 21 Jun 2018 15:23:49 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>, ilia.lin@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: kryo: Fix possible error code dereference
Date:   Thu, 21 Jun 2018 15:22:37 +0200
Message-ID: <3263924.Aj9MpNRJPk@aspire.rjw.lan>
In-Reply-To: <20180618045523.p5keat3323wymvpu@vireshk-i7>
References: <20180614202921.32535-1-ilia.lin@gmail.com> <20180617195842.22818-1-ilia.lin@gmail.com> <20180618045523.p5keat3323wymvpu@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, June 18, 2018 6:55:23 AM CEST Viresh Kumar wrote:
> On 17-06-18, 21:58, ilia.lin@gmail.com wrote:
> > From: Ilia Lin <ilia.lin@gmail.com>
> > 
> > In event of error returned by the nvmem_cell_read() non-pointer value
> > may be dereferenced. Fix this with error handling.
> > Additionally free the allocated speedbin buffer, as per the API.
> > 
> > Fixes: 9ce36edd1a52 (cpufreq: Add Kryo CPU scaling driver)
> > Signed-off-by: Ilia Lin <ilia.lin@gmail.com>
> > ---
> >  drivers/cpufreq/qcom-cpufreq-kryo.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> > index d049fe4b80c4..74b9b93d511b 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> > @@ -115,6 +115,8 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
> >  
> >  	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
> >  	nvmem_cell_put(speedbin_nvmem);
> > +	if (IS_ERR(speedbin))
> > +		return PTR_ERR(speedbin);
> >  
> >  	switch (msm8996_version) {
> >  	case MSM8996_V3:
> > @@ -127,6 +129,7 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
> >  		BUG();
> >  		break;
> >  	}
> > +	kfree(speedbin);
> >  
> >  	for_each_possible_cpu(cpu) {
> >  		cpu_dev = get_cpu_device(cpu);
> 
> Ideally this should have been two patches as you were fixing two
> different problems. But anyway, you can go through this time.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch applied, thanks!

