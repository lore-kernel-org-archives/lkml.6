Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F254ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F00221526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 08:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F00221526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbeITNy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:54:29 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49774 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeITNy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:54:29 -0400
Received: from 79.184.254.22.ipv4.supernova.orange.pl (79.184.254.22) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 5a6110dc9ee753a8; Thu, 20 Sep 2018 10:12:13 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Ilia Lin <ilia.lin@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v3] cpufreq: qcom-kryo: Fix section annotations
Date:   Thu, 20 Sep 2018 10:09:26 +0200
Message-ID: <109831664.7ckmCUV2ib@aspire.rjw.lan>
In-Reply-To: <20180920002220.16644-1-natechancellor@gmail.com>
References: <20180920002220.16644-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 20, 2018 2:22:21 AM CEST Nathan Chancellor wrote:
> There is currently a warning when building the Kryo cpufreq driver into
> the kernel image:
> 
> WARNING: vmlinux.o(.text+0x8aa424): Section mismatch in reference from
> the function qcom_cpufreq_kryo_probe() to the function
> .init.text:qcom_cpufreq_kryo_get_msm_id()
> The function qcom_cpufreq_kryo_probe() references
> the function __init qcom_cpufreq_kryo_get_msm_id().
> This is often because qcom_cpufreq_kryo_probe lacks a __init
> annotation or the annotation of qcom_cpufreq_kryo_get_msm_id is wrong.
> 
> Remove the '__init' annotation from qcom_cpufreq_kryo_get_msm_id
> so that there is no more mismatch warning.
> 
> Additionally, Nick noticed that the remove function was marked as
> '__init' when it should really be marked as '__exit'.
> 
> Fixes: 46e2856b8e18 ("cpufreq: Add Kryo CPU scaling driver")
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> v1 -> v2:
> 
> Add '__init' to qcom_cpufreq_kryo_probe instead of removing it from
> qcom_cpufreq_kryo_get_msm_id.
> 
> v2 -> v3:
> 
> Go back to removing '__init' from qcom_cpufreq_kryo_get_msm_id instead
> of adding '__init' to qcom_cpufreq_kryo_probe, which causes another
> mismatch warning and add the '__init' -> '__exit' conversion noticed by
> Nick.
> 
> The alternative solution is adding '__init' to qcom_cpufreq_kryo_probe,
> removing the probe definition from qcom_cpufreq_kryo_driver, then
> changing platform_driver_register to platform_driver_probe in
> qcom_cpufreq_kryo_init, like [1]. I don't know how that would perform
> given that I don't have a way to test this device.
> 
> [1]: https://lore.kernel.org/lkml/20180919185341.31298-1-natechancellor@gmail.com/
> 
>  drivers/cpufreq/qcom-cpufreq-kryo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> index a1830fa25fc5..2a3675c24032 100644
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -44,7 +44,7 @@ enum _msm8996_version {
>  
>  struct platform_device *cpufreq_dt_pdev, *kryo_cpufreq_pdev;
>  
> -static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
> +static enum _msm8996_version qcom_cpufreq_kryo_get_msm_id(void)
>  {
>  	size_t len;
>  	u32 *msm_id;
> @@ -222,7 +222,7 @@ static int __init qcom_cpufreq_kryo_init(void)
>  }
>  module_init(qcom_cpufreq_kryo_init);
>  
> -static void __init qcom_cpufreq_kryo_exit(void)
> +static void __exit qcom_cpufreq_kryo_exit(void)
>  {
>  	platform_device_unregister(kryo_cpufreq_pdev);
>  	platform_driver_unregister(&qcom_cpufreq_kryo_driver);
> 

OK, thanks!

I'll queue this up for 4.19-rc6 if there are no objections.


