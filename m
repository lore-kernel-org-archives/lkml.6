Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A3EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1397820663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1397820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeK0CE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:04:29 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39662 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726644AbeK0CE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:04:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A48D23515;
        Mon, 26 Nov 2018 07:10:04 -0800 (PST)
Received: from en101 (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D5003F575;
        Mon, 26 Nov 2018 07:10:03 -0800 (PST)
Date:   Mon, 26 Nov 2018 15:09:56 +0000
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        vladimir.murzin@arm.com, catalin.marinas@arm.com,
        mark.rutland@arm.com, Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 1/7] arm64: capabilities: Merge entries for
 ARM64_WORKAROUND_CLEAN_CACHE
Message-ID: <20181126150956.GA24096@en101>
References: <1541418917-14219-1-git-send-email-suzuki.poulose@arm.com>
 <1541418917-14219-2-git-send-email-suzuki.poulose@arm.com>
 <20181126140603.GA29684@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126140603.GA29684@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 02:06:04PM +0000, Will Deacon wrote:
> On Mon, Nov 05, 2018 at 11:55:11AM +0000, Suzuki K Poulose wrote:
> > We have two entries for ARM64_WORKAROUND_CLEAN_CACHE capability :
> > 
> > 1) ARM Errata 826319, 827319, 824069, 819472 on A53 r0p[012]
> > 2) ARM Errata 819472 on A53 r0p[01]
> > 
> > Both have the same work around. Merge these entries to avoid
> > duplicate entries for a single capability.
> > 
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Andre Przywara <andre.przywara@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > ---
> >  arch/arm64/kernel/cpu_errata.c | 19 +++++++------------
> >  1 file changed, 7 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> > index a509e351..c825bc0 100644
> > --- a/arch/arm64/kernel/cpu_errata.c
> > +++ b/arch/arm64/kernel/cpu_errata.c
> > @@ -573,24 +573,19 @@ static const struct midr_range arm64_harden_el2_vectors[] = {
> >  const struct arm64_cpu_capabilities arm64_errata[] = {
> >  #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
> >  	defined(CONFIG_ARM64_ERRATUM_827319) || \
> > -	defined(CONFIG_ARM64_ERRATUM_824069)
> > +	defined(CONFIG_ARM64_ERRATUM_824069) || \
> > +	defined(CONFIG_ARM64_ERRATUM_819472)
> >  	{
> > -	/* Cortex-A53 r0p[012] */
> > -		.desc = "ARM errata 826319, 827319, 824069",
> > +	/*
> > +	 * Cortex-A53 r0p[012]: ARM errata 826319, 827319, 824069
> > +	 * Cortex-A53 r0p[01] : ARM errata 819472
> > +	 */
> > +		.desc = "ARM errata 826319, 827319, 824069, 819472",
> >  		.capability = ARM64_WORKAROUND_CLEAN_CACHE,
> >  		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 2),
> >  		.cpu_enable = cpu_enable_cache_maint_trap,
> 
> Isn't this a semantic change wrt the Kconfig options? After this change,
> if I /only/ set CONFIG_ARM64_ERRATUM_819472=y, then I still get the
> workaround applied for CPUs > r0[p01] which isn't what I asked for.

You're right. I could change this to :


diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 787d785..56a921f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -313,6 +313,11 @@ menu "Kernel Features"
 
 menu "ARM errata workarounds via the alternatives framework"
 
+config ARM64_WORKAROUND_CLEAN_CACHE
+	default y
+	depends on ARM64_ERRATUM_826319 || ARM64_ERRATUM_827319 ||
+		   ARM64_ERRATUM_824069 || ARM64_ERRATUM_819472
+
 config ARM64_ERRATUM_826319
 	bool "Cortex-A53: 826319: System might deadlock if a write cannot complete until read data is accepted"
 	default y
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index a509e351..80f2e66 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -570,24 +570,28 @@ static const struct midr_range arm64_harden_el2_vectors[] = {
 
 #endif
 
-const struct arm64_cpu_capabilities arm64_errata[] = {
+#ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
+static const struct midr_range workaround_clean_cache[] = {
 #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
 	defined(CONFIG_ARM64_ERRATUM_827319) || \
 	defined(CONFIG_ARM64_ERRATUM_824069)
-	{
-	/* Cortex-A53 r0p[012] */
-		.desc = "ARM errata 826319, 827319, 824069",
-		.capability = ARM64_WORKAROUND_CLEAN_CACHE,
-		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 2),
-		.cpu_enable = cpu_enable_cache_maint_trap,
-	},
+	/* Cortex-A53 r0p[012]: ARM errata 826319, 827319, 824069 */
+	MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 2),
+#endif
+#ifdef	CONFIG_ARM64_ERRATUM_819472
+	/* Cortex-A53 r0p[01] : ARM errata 819472 */
+	MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 1),
+#endif
+	{},
+};
 #endif
-#ifdef CONFIG_ARM64_ERRATUM_819472
+
+const struct arm64_cpu_capabilities arm64_errata[] = {
+#ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
 	{
-	/* Cortex-A53 r0p[01] */
-		.desc = "ARM errata 819472",
+		.desc = "ARM errata 826319, 827319, 824069, 819472",
 		.capability = ARM64_WORKAROUND_CLEAN_CACHE,
-		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 1),
+		ERRATA_MIDR_REV_LIST(workaround_clean_cache),
 		.cpu_enable = cpu_enable_cache_maint_trap,
 	},
 #endif

---

Cheers
Suzuki
