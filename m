Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12DAC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA6A2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA6A2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeJLEZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:25:01 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57742 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbeJLEZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:25:01 -0400
Received: from 79.184.255.62.ipv4.supernova.orange.pl (79.184.255.62) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id d047225c2c476713; Thu, 11 Oct 2018 22:56:00 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        ulf.hansson@linaro.org, khilman@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org
Subject: Re: [PATCH RFC v1 2/8] kernel/cpu_pm: Manage runtime PM in the idle path for CPUs
Date:   Thu, 11 Oct 2018 22:52:51 +0200
Message-ID: <8161939.SRDo8Qx48D@aspire.rjw.lan>
In-Reply-To: <1539206455-29342-3-git-send-email-rplsssn@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org> <1539206455-29342-3-git-send-email-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, October 10, 2018 11:20:49 PM CEST Raju P.L.S.S.S.N wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> To allow CPUs being power managed by PM domains, let's deploy support for
> runtime PM for the CPU's corresponding struct device.
> 
> More precisely, at the point when the CPU is about to enter an idle state,
> decrease the runtime PM usage count for its corresponding struct device,
> via calling pm_runtime_put_sync_suspend(). Then, at the point when the CPU
> resumes from idle, let's increase the runtime PM usage count, via calling
> pm_runtime_get_sync().
> 
> Cc: Lina Iyer <ilina@codeaurora.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> (am from https://patchwork.kernel.org/patch/10478153/)
> ---
>  kernel/cpu_pm.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
> index 67b02e1..492d4a8 100644
> --- a/kernel/cpu_pm.c
> +++ b/kernel/cpu_pm.c
> @@ -16,9 +16,11 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/cpu.h>
>  #include <linux/cpu_pm.h>
>  #include <linux/module.h>
>  #include <linux/notifier.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/spinlock.h>
>  #include <linux/syscore_ops.h>
>  
> @@ -91,6 +93,7 @@ int cpu_pm_enter(void)
>  {
>  	int nr_calls;
>  	int ret = 0;
> +	struct device *dev = get_cpu_device(smp_processor_id());
>  
>  	ret = cpu_pm_notify(CPU_PM_ENTER, -1, &nr_calls);
>  	if (ret)
> @@ -100,6 +103,9 @@ int cpu_pm_enter(void)
>  		 */
>  		cpu_pm_notify(CPU_PM_ENTER_FAILED, nr_calls - 1, NULL);
>  
> +	if (!ret && dev && dev->pm_domain)
> +		pm_runtime_put_sync_suspend(dev);

This may cause a power domain to go off, but if it goes off, then the idle
governor has already selected idle states for all of the CPUs in that domain.

Is there any way to ensure that turning the domain off (and later on) will
no cause the target residency and exit latency expectations for those idle
states to be exceeded?

> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(cpu_pm_enter);
> @@ -118,6 +124,11 @@ int cpu_pm_enter(void)
>   */
>  int cpu_pm_exit(void)
>  {
> +	struct device *dev = get_cpu_device(smp_processor_id());
> +
> +	if (dev && dev->pm_domain)
> +		pm_runtime_get_sync(dev);
> +
>  	return cpu_pm_notify(CPU_PM_EXIT, -1, NULL);
>  }
>  EXPORT_SYMBOL_GPL(cpu_pm_exit);
> 


