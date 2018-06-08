Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vMMhKROfGlutXQAAmS7hNA
	; Fri, 08 Jun 2018 15:21:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EFE46607DC; Fri,  8 Jun 2018 15:21:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7CCD1607A4;
	Fri,  8 Jun 2018 15:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7CCD1607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbeFHPVy (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 11:21:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:65118 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbeFHPVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 11:21:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 08:21:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,490,1520924400";
   d="scan'208";a="46285737"
Received: from vtangira-mobl1.amr.corp.intel.com ([10.254.35.112])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jun 2018 08:21:52 -0700
Message-ID: <228e36b1692a8676389a512f25e73affec2c71a6.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: remove incorrect __initconst
 annotation
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: Doug Smythies <doug.smythies@gmail.com>,
        Toshi Kani <toshi.kani@hpe.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 08:21:52 -0700
In-Reply-To: <20180608151411.3892739-1-arnd@arndb.de>
References: <20180608151411.3892739-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-08 at 17:14 +0200, Arnd Bergmann wrote:
> We get a build warning about the newly introduced code in
> intel_pstate_init_cpu() that references an __initconst variable after
> it has been freed:
> 
I see Rafael already addressed this.
https://kernel.googlesource.com/pub/scm/linux/kernel/git/rafael/linux-p
m/+/41ab43c9c89e06ff08a4750d1b09e227ea97894f%5E%21/#F0

Thanks,
Srinivas

> WARNING: vmlinux.o(.text+0xf9eca2): Section mismatch in reference
> from the function intel_pstate_init_cpu() to the variable
> .init.rodata:intel_pstate_hwp_boost_ids
> The function intel_pstate_init_cpu() references
> the variable __initconst intel_pstate_hwp_boost_ids.
> This is often because intel_pstate_init_cpu lacks a __initconst
> annotation or the annotation of intel_pstate_hwp_boost_ids is wrong.
> 
> This removes the annotation to keep the variable around at
> runtime.
> 
> Fixes: f50f70793d78 ("cpufreq: intel_pstate: enable boost for Skylake
> Xeon")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/intel_pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index 2065724dbffc..380936700165 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1794,7 +1794,7 @@ static const struct x86_cpu_id
> intel_pstate_cpu_ee_disable_ids[] = {
>  	{}
>  };
>  
> -static const struct x86_cpu_id intel_pstate_hwp_boost_ids[]
> __initconst = {
> +static const struct x86_cpu_id intel_pstate_hwp_boost_ids[] = {
>  	ICPU(INTEL_FAM6_SKYLAKE_X, core_funcs),
>  	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP, core_funcs),
>  	{}
