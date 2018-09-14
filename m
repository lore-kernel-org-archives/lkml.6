Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8E3FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B99520866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B99520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbeINOZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:25:35 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42634 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbeINOZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:25:35 -0400
Received: from 79.184.255.178.ipv4.supernova.orange.pl (79.184.255.178) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 2c4772841bd40c62; Fri, 14 Sep 2018 11:11:58 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     oceanhe@zoho.com.cn, srinivas.pandruvada@linux.intel.com
Cc:     lenb@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ocean He <hehy1@lenovo.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: warn if HWP Native mode and OOB mode are both set
Date:   Fri, 14 Sep 2018 11:09:18 +0200
Message-ID: <13141827.DFN6g7be8o@aspire.rjw.lan>
In-Reply-To: <1532837696-11505-1-git-send-email-oceanhe@zoho.com.cn>
References: <1532837696-11505-1-git-send-email-oceanhe@zoho.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, July 29, 2018 6:14:56 AM CEST oceanhe@zoho.com.cn wrote:
> From: Ocean He <hehy1@lenovo.com>
> 
> Refer to Intel HWPM Compliance Guide (Document Number: 566474): Bit[6] or
> bit[8] of MSR MISC_PWR_MGMT is set only when BIOS select either HWP Native
> mode or HWP OOB mode. Bit[6] and bit[8] cannot be set both at the same
> time.
> 
> Add a warning message if intel_pstate detects both HWP Native mode and
> HWP OOB mode are set at the same time.
> 
> Signed-off-by: Ocean He <hehy1@lenovo.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 3c39712..678d3f2 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2455,8 +2455,12 @@ static bool __init intel_pstate_platform_pwr_mgmt_exists(void)
>  	id = x86_match_cpu(intel_pstate_cpu_oob_ids);
>  	if (id) {
>  		rdmsrl(MSR_MISC_PWR_MGMT, misc_pwr);
> -		if ( misc_pwr & (1 << 8))
> +		if (misc_pwr & (1 << 8)) {
> +			if (misc_pwr & (1 << 6))
> +				pr_warn(FW_WARN
> +					"HWP Native mode and OOB mode cannot be set both at the same time.\n");
>  			return true;
> +		}
>  	}
>  
>  	idx = acpi_match_platform_list(plat_info);
> 

Srinivas, what do you think about this one?

