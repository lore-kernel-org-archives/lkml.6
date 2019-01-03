Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B8EC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7972073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731547AbfACQhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:37:47 -0500
Received: from foss.arm.com ([217.140.101.70]:52684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729598AbfACQhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:37:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A77A15AD;
        Thu,  3 Jan 2019 08:37:46 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38C763F5D4;
        Thu,  3 Jan 2019 08:37:43 -0800 (PST)
Date:   Thu, 3 Jan 2019 16:37:40 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        mlangsdo@redhat.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        suzuki.poulose@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, Dave Hansen <dave.hansen@intel.com>,
        julien.thierry@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, steven.price@arm.com,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ykaukab@suse.de, Thomas Gleixner <tglx@linutronix.de>,
        shankerd@codeaurora.org
Subject: Re: [PATCH v2 1/7] sysfs/cpu: Add "Unknown" vulnerability state
Message-ID: <20190103163740.GC3529@e103592.cambridge.arm.com>
References: <20190103004921.1928921-1-jeremy.linton@arm.com>
 <20190103004921.1928921-2-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103004921.1928921-2-jeremy.linton@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 06:49:15PM -0600, Jeremy Linton wrote:
> There is a lot of variation in the Arm ecosystem. Because of this,
> there exist possible cases where the kernel cannot authoritatively
> determine if a machine is vulnerable.
> 
> Rather than guess the vulnerability status in cases where
> the mitigation is disabled or the firmware isn't responding
> correctly, we need to display an "Unknown" state.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  Documentation/ABI/testing/sysfs-devices-system-cpu | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 9605dbd4b5b5..876103fddfa4 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -495,6 +495,7 @@ Description:	Information about CPU vulnerabilities
>  		"Not affected"	  CPU is not affected by the vulnerability
>  		"Vulnerable"	  CPU is affected and no mitigation in effect
>  		"Mitigation: $M"  CPU is affected and mitigation $M is in effect
> +		"Unknown"    	  The kernel is unable to make a determination

Do some of the "Unknown" cases arise from the vulnerability detection
code being compiled out of the kernel?

I wonder whether at least the detection support should be mandatory.
sysfs is not very useful as a standard vulnerability reporting interface
unless we make best efforts to always populate it with real information.


Also, does "Unknown" convey anything beyond what is indicated by the
sysfs entry being omitted altogether?

Cheers
---Dave
