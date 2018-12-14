Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8677C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F0E2147C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F0E2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbeLNKgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:36:46 -0500
Received: from foss.arm.com ([217.140.101.70]:48648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbeLNKgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:36:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DB01A78;
        Fri, 14 Dec 2018 02:36:45 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2D0143F614;
        Fri, 14 Dec 2018 02:36:45 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 6D0AF1AE087D; Fri, 14 Dec 2018 10:36:44 +0000 (GMT)
Date:   Fri, 14 Dec 2018 10:36:44 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        suzuki.poulose@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        ykaukab@suse.de, dave.martin@arm.com, shankerd@codeaurora.org
Subject: Re: [PATCH 5/6] arm64: add sysfs vulnerability show for speculative
 store bypass
Message-ID: <20181214103644.GB1872@edgewater-inn.cambridge.arm.com>
References: <20181206234408.1287689-1-jeremy.linton@arm.com>
 <20181206234408.1287689-6-jeremy.linton@arm.com>
 <901bdfff-df83-846f-1695-a89e8bbfa787@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <901bdfff-df83-846f-1695-a89e8bbfa787@arm.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 10:34:31AM +0000, Steven Price wrote:
> On 06/12/2018 23:44, Jeremy Linton wrote:
> > From: Mian Yousaf Kaukab <ykaukab@suse.de>
> > 
> > Return status based no ssbd_state and the arm64 SSBS feature.
>                       ^^ on
> 
> > Return string "Unknown" in case CONFIG_ARM64_SSBD is
> > disabled or arch workaround2 is not available
> > in the firmware.
> > 
> > Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> > [Added SSBS logic]
> > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > ---
> >  arch/arm64/kernel/cpu_errata.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> > index 6505c93d507e..8aeb5ca38db8 100644
> > --- a/arch/arm64/kernel/cpu_errata.c
> > +++ b/arch/arm64/kernel/cpu_errata.c
> > @@ -423,6 +423,7 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
> >  		ssbd_state = ARM64_SSBD_UNKNOWN;
> >  		return false;
> >  
> > +	/* machines with mixed mitigation requirements must not return this */
> >  	case SMCCC_RET_NOT_REQUIRED:
> >  		pr_info_once("%s mitigation not required\n", entry->desc);
> >  		ssbd_state = ARM64_SSBD_MITIGATED;
> > @@ -828,4 +829,31 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
> >  	}
> >  }
> >  
> > +ssize_t cpu_show_spec_store_bypass(struct device *dev,
> > +		struct device_attribute *attr, char *buf)
> > +{
> > +	/*
> > +	 *  Two assumptions: First, get_ssbd_state() reflects the worse case
> > +	 *  for hetrogenous machines, and that if SSBS is supported its
>                                                   ^^^^ SSBD
> > +	 *  supported by all cores.
> > +	 */
> > +	switch (arm64_get_ssbd_state()) {
> > +	case ARM64_SSBD_MITIGATED:
> > +		return sprintf(buf, "Not affected\n");
> > +
> > +	case ARM64_SSBD_KERNEL:
> > +	case ARM64_SSBD_FORCE_ENABLE:
> > +		if (cpus_have_cap(ARM64_SSBS))
> > +			return sprintf(buf, "Not affected\n");
> > +		return sprintf(buf,
> > +			"Mitigation: Speculative Store Bypass disabled\n");
> 
> NIT: To me this reads as the mitigation is disabled. Can we call it
> "Speculative Store Bypass Disable" (with a capital 'D' and without the
> 'd at the end)?

Whilst I agree that the strings are reasonably confusing (especially when
you pile on the double-negatives all the way up the stack!), we really
have no choice but to follow x86's lead with these strings.

I don't think it's worth forking the ABI in an attempt to make this clearer.

Will
