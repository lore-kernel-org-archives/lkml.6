Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEBEC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F4F20C03
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F4F20C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbeHTMYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:24:55 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55918 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeHTMYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:24:55 -0400
Received: from 79.184.253.33.ipv4.supernova.orange.pl (79.184.253.33) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 46afced0d44f25f0; Mon, 20 Aug 2018 11:10:05 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Henry Willard <henry.willard@oracle.com>
Cc:     viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: governor: Protect cpufreq governor_data
Date:   Mon, 20 Aug 2018 11:07:49 +0200
Message-ID: <2923321.jmYcvy9DfS@aspire.rjw.lan>
In-Reply-To: <1534291262-4207-1-git-send-email-henry.willard@oracle.com>
References: <1534291262-4207-1-git-send-email-henry.willard@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 15, 2018 2:01:02 AM CEST Henry Willard wrote:
> If cppc_cpufreq.ko is deleted at the same time that tuned-adm is
> changing profiles, there is a small chance that a race can occur
> between cpufreq_dbs_governor_exit() and cpufreq_dbs_governor_limits()
> resulting in a system failure when the latter tries to use
> policy->governor_data that has been freed by the former.
> 
> This patch uses gov_dbs_data_mutex to synchronize access.
> 
> Signed-off-by: Henry Willard <henry.willard@oracle.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 1d50e97d49f1..43416ee55849 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -555,12 +555,20 @@ void cpufreq_dbs_governor_stop(struct cpufreq_policy *policy)
>  
>  void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
>  {
> -	struct policy_dbs_info *policy_dbs = policy->governor_data;
> +	struct policy_dbs_info *policy_dbs;
> +
> +	/* Protect gov->gdbs_data against cpufreq_dbs_governor_exit */
> +	mutex_lock(&gov_dbs_data_mutex);
> +	policy_dbs = policy->governor_data;
> +	if (!policy_dbs)
> +		goto out;
>  
>  	mutex_lock(&policy_dbs->update_mutex);
>  	cpufreq_policy_apply_limits(policy);
>  	gov_update_sample_delay(policy_dbs, 0);
>  
>  	mutex_unlock(&policy_dbs->update_mutex);
> +out:
> +	mutex_unlock(&gov_dbs_data_mutex);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_limits);
> 

Applied, thanks!


