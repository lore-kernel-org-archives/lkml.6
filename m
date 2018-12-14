Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9C7C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D166420892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D166420892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbeLNLdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 06:33:23 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49620 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729499AbeLNLdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 06:33:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74F9DEBD;
        Fri, 14 Dec 2018 03:33:22 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 443143F6A8;
        Fri, 14 Dec 2018 03:33:22 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 886A21AE087D; Fri, 14 Dec 2018 11:33:21 +0000 (GMT)
Date:   Fri, 14 Dec 2018 11:33:21 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Steven Price <steven.price@arm.com>, mark.rutland@arm.com,
        suzuki.poulose@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, ykaukab@suse.de,
        linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org, shankerd@codeaurora.org
Subject: Re: [PATCH 5/6] arm64: add sysfs vulnerability show for speculative
 store bypass
Message-ID: <20181214113321.GD1872@edgewater-inn.cambridge.arm.com>
References: <20181206234408.1287689-1-jeremy.linton@arm.com>
 <20181206234408.1287689-6-jeremy.linton@arm.com>
 <901bdfff-df83-846f-1695-a89e8bbfa787@arm.com>
 <20181214103644.GB1872@edgewater-inn.cambridge.arm.com>
 <96ac8a3f-9c03-9ad9-e148-5f3422c51075@arm.com>
 <20181214112809.GF3505@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214112809.GF3505@e103592.cambridge.arm.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 11:28:16AM +0000, Dave Martin wrote:
> On Fri, Dec 14, 2018 at 10:41:42AM +0000, Steven Price wrote:
> > On 14/12/2018 10:36, Will Deacon wrote:
> > > On Fri, Dec 14, 2018 at 10:34:31AM +0000, Steven Price wrote:
> > >> On 06/12/2018 23:44, Jeremy Linton wrote:
> > >>> From: Mian Yousaf Kaukab <ykaukab@suse.de>
> > >>>
> > >>> Return status based no ssbd_state and the arm64 SSBS feature.
> > >>                       ^^ on
> > >>
> > >>> Return string "Unknown" in case CONFIG_ARM64_SSBD is
> > >>> disabled or arch workaround2 is not available
> > >>> in the firmware.
> > >>>
> > >>> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> > >>> [Added SSBS logic]
> > >>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > >>> ---
> > >>>  arch/arm64/kernel/cpu_errata.c | 28 ++++++++++++++++++++++++++++
> > >>>  1 file changed, 28 insertions(+)
> > >>>
> > >>> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> > >>> index 6505c93d507e..8aeb5ca38db8 100644
> > >>> --- a/arch/arm64/kernel/cpu_errata.c
> > >>> +++ b/arch/arm64/kernel/cpu_errata.c
> > >>> @@ -423,6 +423,7 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
> > >>>  		ssbd_state = ARM64_SSBD_UNKNOWN;
> > >>>  		return false;
> > >>>  
> > >>> +	/* machines with mixed mitigation requirements must not return this */
> > >>>  	case SMCCC_RET_NOT_REQUIRED:
> > >>>  		pr_info_once("%s mitigation not required\n", entry->desc);
> > >>>  		ssbd_state = ARM64_SSBD_MITIGATED;
> > >>> @@ -828,4 +829,31 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
> > >>>  	}
> > >>>  }
> > >>>  
> > >>> +ssize_t cpu_show_spec_store_bypass(struct device *dev,
> > >>> +		struct device_attribute *attr, char *buf)
> > >>> +{
> > >>> +	/*
> > >>> +	 *  Two assumptions: First, get_ssbd_state() reflects the worse case
> > >>> +	 *  for hetrogenous machines, and that if SSBS is supported its
> > >>                                                   ^^^^ SSBD
> > >>> +	 *  supported by all cores.
> > >>> +	 */
> > >>> +	switch (arm64_get_ssbd_state()) {
> > >>> +	case ARM64_SSBD_MITIGATED:
> > >>> +		return sprintf(buf, "Not affected\n");
> > >>> +
> > >>> +	case ARM64_SSBD_KERNEL:
> > >>> +	case ARM64_SSBD_FORCE_ENABLE:
> > >>> +		if (cpus_have_cap(ARM64_SSBS))
> > >>> +			return sprintf(buf, "Not affected\n");
> > >>> +		return sprintf(buf,
> > >>> +			"Mitigation: Speculative Store Bypass disabled\n");
> > >>
> > >> NIT: To me this reads as the mitigation is disabled. Can we call it
> > >> "Speculative Store Bypass Disable" (with a capital 'D' and without the
> > >> 'd at the end)?
> > > 
> > > Whilst I agree that the strings are reasonably confusing (especially when
> > > you pile on the double-negatives all the way up the stack!), we really
> > > have no choice but to follow x86's lead with these strings.
> > > 
> > > I don't think it's worth forking the ABI in an attempt to make this clearer.
> > 
> > Ah, sorry I hadn't checked the x86 string - yes we should match that.
> 
> This is rather why I feel these strings are either a) useless or
> b) should be documented somewhere.
> 
> Putting at least a skeleton document somewhere could be a good start,
> and would require little effort.
> 
> 
> What decisions do we expect userspace to make based on this information?

There's at least one tool that parses this stuff to tell you whether you
have/need the mitigations:

https://github.com/speed47/spectre-meltdown-checker

Will
