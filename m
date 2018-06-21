Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536C8C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166B620883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166B620883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933333AbeFUNY0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:24:26 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44092 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933039AbeFUNYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:24:24 -0400
Received: from 79.184.254.22.ipv4.supernova.orange.pl (79.184.254.22) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id cb89fc5d67f88bdd; Thu, 21 Jun 2018 15:24:23 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>, ilia.lin@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cpufreq: kryo: Add module remove and exit
Date:   Thu, 21 Jun 2018 15:23:11 +0200
Message-ID: <2736020.lelA2SSAlr@aspire.rjw.lan>
In-Reply-To: <20180618045550.sasilydvnlsmxzpk@vireshk-i7>
References: <20180614204212.2028-1-ilia.lin@gmail.com> <20180617200146.16425-1-ilia.lin@gmail.com> <20180618045550.sasilydvnlsmxzpk@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, June 18, 2018 6:55:50 AM CEST Viresh Kumar wrote:
> On 17-06-18, 22:01, ilia.lin@gmail.com wrote:
> > From: Ilia Lin <ilia.lin@gmail.com>
> > 
> > Add device remove and module exit code to make the driver
> > functioning as a loadable module.
> > 
> > Fixes: ac28927659be (cpufreq: kryo: allow building as a loadable module)
> > Signed-off-by: Ilia Lin <ilia.lin@gmail.com>
> > ---
> >  drivers/cpufreq/qcom-cpufreq-kryo.c | 22 +++++++++++++++++++---
> >  1 file changed, 19 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> > index 74b9b93d511b..01bddacf5c3b 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> > @@ -42,6 +42,8 @@ enum _msm8996_version {
> >  	NUM_OF_MSM8996_VERSIONS,
> >  };
> >  
> > +struct platform_device *cpufreq_dt_pdev, *kryo_cpufreq_pdev;
> > +
> >  static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
> >  {
> >  	size_t len;
> > @@ -74,7 +76,6 @@ static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
> >  static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
> >  {
> >  	struct opp_table *opp_tables[NR_CPUS] = {0};
> > -	struct platform_device *cpufreq_dt_pdev;
> >  	enum _msm8996_version msm8996_version;
> >  	struct nvmem_cell *speedbin_nvmem;
> >  	struct device_node *np;
> > @@ -165,8 +166,15 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
> >  	return ret;
> >  }
> >  
> > +static int qcom_cpufreq_kryo_remove(struct platform_device *pdev)
> > +{
> > +	platform_device_unregister(cpufreq_dt_pdev);
> > +	return 0;
> > +}
> > +
> >  static struct platform_driver qcom_cpufreq_kryo_driver = {
> >  	.probe = qcom_cpufreq_kryo_probe,
> > +	.remove = qcom_cpufreq_kryo_remove,
> >  	.driver = {
> >  		.name = "qcom-cpufreq-kryo",
> >  	},
> > @@ -201,8 +209,9 @@ static int __init qcom_cpufreq_kryo_init(void)
> >  	if (unlikely(ret < 0))
> >  		return ret;
> >  
> > -	ret = PTR_ERR_OR_ZERO(platform_device_register_simple(
> > -		"qcom-cpufreq-kryo", -1, NULL, 0));
> > +	kryo_cpufreq_pdev = platform_device_register_simple(
> > +		"qcom-cpufreq-kryo", -1, NULL, 0);
> > +	ret = PTR_ERR_OR_ZERO(kryo_cpufreq_pdev);
> >  	if (0 == ret)
> >  		return 0;
> >  
> > @@ -211,5 +220,12 @@ static int __init qcom_cpufreq_kryo_init(void)
> >  }
> >  module_init(qcom_cpufreq_kryo_init);
> >  
> > +static void __init qcom_cpufreq_kryo_exit(void)
> > +{
> > +	platform_device_unregister(kryo_cpufreq_pdev);
> > +	platform_driver_unregister(&qcom_cpufreq_kryo_driver);
> > +}
> > +module_exit(qcom_cpufreq_kryo_exit);
> > +
> >  MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Kryo CPUfreq driver");
> >  MODULE_LICENSE("GPL v2");
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch applied, thanks!

