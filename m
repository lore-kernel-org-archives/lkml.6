Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F575C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31902087A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31902087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeJ2Xub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:50:31 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:49994 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeJ2Xua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:50:30 -0400
Received: by isilmar-4.linta.de (Postfix, from userid 1000)
        id 67AAB200910; Mon, 29 Oct 2018 15:01:28 +0000 (UTC)
Date:   Mon, 29 Oct 2018 16:01:28 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>, rjw@rjwysocki.net
Subject: Re: Linux 4.19.0 Build Error when CONFIG_ACPI not set.
Message-ID: <20181029150128.wbjtyfxwxxb7ckg4@isilmar-4.linta.de>
References: <c4c5d427-a77e-4191-a84e-43ae9299c346@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4c5d427-a77e-4191-a84e-43ae9299c346@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Oct 29, 2018 at 11:53:38AM +0100, Thomas-Mich Richter wrote:
> When I compile the 4.19.0 Linux kernel, I get this build error:
> 
> [root@f28 linux]# fgrep -r CONFIG_ACPI .config
> # CONFIG_ACPI is not set
> [root@f28 linux]#
> 
> [root@f28 linux]# make
>   CALL    scripts/checksyscalls.sh
>   DESCEND  objtool
>   CHK     include/generated/compile.h
>   CC      drivers/cpufreq/intel_pstate.o
> drivers/cpufreq/intel_pstate.c: In function ‘show_base_frequency’:
>         drivers/cpufreq/intel_pstate.c:726:10: error: implicit declaration of
>         function ‘intel_pstate_get_cppc_guranteed’;
>         did you mean ‘intel_pstate_get_epp’?
>         [-Werror=implicit-function-declaration]
>         ratio = intel_pstate_get_cppc_guranteed(policy->cpu);
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                 intel_pstate_get_epp
> cc1: some warnings being treated as errors
> make[2]: *** [scripts/Makefile.build:306: drivers/cpufreq/intel_pstate.o]
>                 Error 1
> make[1]: *** [scripts/Makefile.build:546: drivers/cpufreq] Error 2
> make: *** [Makefile:1052: drivers] Error 2
> [root@f28 linux]# 
> 
> I am building on a virtual machine.
> 
> This was introduced with
> commit 86d333a8cc7f ("cpufreq: intel_pstate: Add base_frequency attribute")
> 
> The function intel_pstate_get_cppc_guranteed() is called but the function
> definition is within #ifdef CONFIG_ACPI/#endif conditional compile.
> 
> Any ideas how to fix this?

This isn't in 4.19.0, but in current mainline, and can be fixed by this
patch which is already on its way upstream.

	https://patchwork.kernel.org/patch/10653593/

Thanks,
	Dominik

----
Date: Tue, 23 Oct 2018 21:54:03 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v2] cpufreq: intel_pstate: Fix compilation for !CONFIG_ACPI

While at it, add a few comments which config options #ifdef
and #else statements refer to.

Fixes: 86d333a8cc7f ("cpufreq: intel_pstate: Add base_frequency attribute")
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 49c0abf2d48f..9578312e43f2 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -386,16 +386,11 @@ static int intel_pstate_get_cppc_guranteed(int cpu)
 	return cppc_perf.guaranteed_perf;
 }
 
-#else
+#else /* CONFIG_ACPI_CPPC_LIB */
 static void intel_pstate_set_itmt_prio(int cpu)
 {
 }
-
-static int intel_pstate_get_cppc_guranteed(int cpu)
-{
-	return -ENOTSUPP;
-}
-#endif
+#endif /* CONFIG_ACPI_CPPC_LIB */
 
 static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
 {
@@ -477,7 +472,7 @@ static void intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
 
 	acpi_processor_unregister_performance(policy->cpu);
 }
-#else
+#else /* CONFIG_ACPI */
 static inline void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
 {
 }
@@ -490,7 +485,14 @@ static inline bool intel_pstate_acpi_pm_profile_server(void)
 {
 	return false;
 }
-#endif
+#endif /* CONFIG_ACPI */
+
+#ifndef CONFIG_ACPI_CPPC_LIB
+static int intel_pstate_get_cppc_guranteed(int cpu)
+{
+	return -ENOTSUPP;
+}
+#endif /* CONFIG_ACPI_CPPC_LIB */
 
 static inline void update_turbo_state(void)
 {
