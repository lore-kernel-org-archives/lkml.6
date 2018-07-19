Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858EAECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488892084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488892084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbeGSL3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:29:35 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54804 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbeGSL3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:29:34 -0400
Received: from 79.184.255.17.ipv4.supernova.orange.pl (79.184.255.17) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id d3584b0ba78100ed; Thu, 19 Jul 2018 12:46:59 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Ilia Lin <ilia.lin@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-kryo: Silently error out on EPROBE_DEFER
Date:   Thu, 19 Jul 2018 12:45:19 +0200
Message-ID: <2276619.pSvMmMYWG1@aspire.rjw.lan>
In-Reply-To: <20180718044422.6j4nmluynopcpqfx@vireshk-i7>
References: <20180717204821.15987-1-niklas.cassel@linaro.org> <20180718044422.6j4nmluynopcpqfx@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 18, 2018 6:44:22 AM CEST Viresh Kumar wrote:
> On 17-07-18, 22:48, Niklas Cassel wrote:
> > If of_nvmem_cell_get() fails due to probe deferal, we shouldn't print an
> > error message. Just be silent in this case.
> > 
> > Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> > ---
> >  drivers/cpufreq/qcom-cpufreq-kryo.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> > index 29389accf3e9..b8d1e6875f16 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> > @@ -109,8 +109,9 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
> >  	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
> >  	of_node_put(np);
> >  	if (IS_ERR(speedbin_nvmem)) {
> > -		dev_err(cpu_dev, "Could not get nvmem cell: %ld\n",
> > -			PTR_ERR(speedbin_nvmem));
> > +		if (PTR_ERR(speedbin_nvmem) != -EPROBE_DEFER)
> > +			dev_err(cpu_dev, "Could not get nvmem cell: %ld\n",
> > +				PTR_ERR(speedbin_nvmem));
> >  		return PTR_ERR(speedbin_nvmem);
> >  	}
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> 

Applied, thanks!

