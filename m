Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C00DC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D51120882
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D51120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeJHRRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:17:21 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49081 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJHRRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:17:20 -0400
Received: from 79.184.255.62.ipv4.supernova.orange.pl (79.184.255.62) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 18fb83422f7cfb5f; Mon, 8 Oct 2018 12:06:22 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     lenb@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com,
        pprakash@codeaurora.org, george.cherian@cavium.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI / CPPC: Add support for guaranteed performance
Date:   Mon, 08 Oct 2018 12:03:17 +0200
Message-ID: <3282468.StlflVgT3Q@aspire.rjw.lan>
In-Reply-To: <20181007043945.19350-1-srinivas.pandruvada@linux.intel.com>
References: <20181007043945.19350-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, October 7, 2018 6:39:45 AM CEST Srinivas Pandruvada wrote:
> The Continuous Performance Control Package can have guaranteed performance
> field. Add support to read guaranteed performance.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  Documentation/acpi/cppc_sysfs.txt |  2 ++
>  drivers/acpi/cppc_acpi.c          | 10 ++++++++--
>  include/acpi/cppc_acpi.h          |  1 +
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/acpi/cppc_sysfs.txt b/Documentation/acpi/cppc_sysfs.txt
> index f20fb445135d..812574d30717 100644
> --- a/Documentation/acpi/cppc_sysfs.txt
> +++ b/Documentation/acpi/cppc_sysfs.txt
> @@ -22,6 +22,7 @@ $ ls -lR  /sys/devices/system/cpu/cpu0/acpi_cppc/
>  /sys/devices/system/cpu/cpu0/acpi_cppc/:
>  total 0
>  -r--r--r-- 1 root root 65536 Mar  5 19:38 feedback_ctrs
> +-r--r--r-- 1 root root 65536 Mar  5 19:38 guaranteed_perf
>  -r--r--r-- 1 root root 65536 Mar  5 19:38 highest_perf
>  -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_freq
>  -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_nonlinear_perf
> @@ -33,6 +34,7 @@ total 0
>  
>  --------------------------------------------------------------------------------
>  
> +* guaranteed_perf : Guaranteed performance of this processor (abstract scale).
>  * highest_perf : Highest performance of this processor (abstract scale).
>  * nominal_perf : Highest sustained performance of this processor (abstract scale).
>  * lowest_nonlinear_perf : Lowest performance of this processor with nonlinear
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index d9ce4b162e2c..5babb9402f11 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -153,6 +153,7 @@ __ATTR(_name, 0444, show_##_name, NULL)
>  	}								\
>  	define_one_cppc_ro(member_name)
>  
> +show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, guaranteed_perf);
>  show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, highest_perf);
>  show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_perf);
>  show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_perf);
> @@ -189,6 +190,7 @@ static struct attribute *cppc_attrs[] = {
>  	&nominal_perf.attr,
>  	&nominal_freq.attr,
>  	&lowest_freq.attr,
> +	&guaranteed_perf.attr,
>  	NULL
>  };
>  
> @@ -1061,9 +1063,9 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>  {
>  	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>  	struct cpc_register_resource *highest_reg, *lowest_reg,
> -		*lowest_non_linear_reg, *nominal_reg,
> +		*lowest_non_linear_reg, *nominal_reg, *guaranteed_reg,
>  		*low_freq_reg = NULL, *nom_freq_reg = NULL;
> -	u64 high, low, nom, min_nonlinear, low_f = 0, nom_f = 0;
> +	u64 high, low, guaranteed, nom, min_nonlinear, low_f = 0, nom_f = 0;
>  	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
>  	struct cppc_pcc_data *pcc_ss_data = NULL;
>  	int ret = 0, regs_in_pcc = 0;
> @@ -1079,6 +1081,7 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>  	nominal_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];
>  	low_freq_reg = &cpc_desc->cpc_regs[LOWEST_FREQ];
>  	nom_freq_reg = &cpc_desc->cpc_regs[NOMINAL_FREQ];
> +	guaranteed_reg = &cpc_desc->cpc_regs[GUARANTEED_PERF];
>  
>  	/* Are any of the regs PCC ?*/
>  	if (CPC_IN_PCC(highest_reg) || CPC_IN_PCC(lowest_reg) ||
> @@ -1107,6 +1110,9 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>  	cpc_read(cpunum, nominal_reg, &nom);
>  	perf_caps->nominal_perf = nom;
>  
> +	cpc_read(cpunum, guaranteed_reg, &guaranteed);
> +	perf_caps->guaranteed_perf = guaranteed;
> +
>  	cpc_read(cpunum, lowest_non_linear_reg, &min_nonlinear);
>  	perf_caps->lowest_nonlinear_perf = min_nonlinear;
>  
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 8e0b8250a139..cf59e6210d27 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -104,6 +104,7 @@ enum cppc_regs {
>   * today.
>   */
>  struct cppc_perf_caps {
> +	u32 guaranteed_perf;
>  	u32 highest_perf;
>  	u32 nominal_perf;
>  	u32 lowest_perf;
> 

Can you resend with CCs to linux-acpi/linux-pm, please?


