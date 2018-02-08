Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752402AbeBHME1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 07:04:27 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33942 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750877AbeBHME0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 07:04:26 -0500
Date: Thu, 8 Feb 2018 12:04:22 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com
Subject: Re: [PATCH v2 16/20] arm64: Handle shared capability entries
Message-ID: <20180208120421.GY5862@e103592.cambridge.arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-17-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131182807.32134-17-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 06:28:03PM +0000, Suzuki K Poulose wrote:
> Some capabilities have different criteria for detection and associated
> actions based on the matching criteria, even though they all share the
> same capability bit. So far we have used multiple entries with the same
> capability bit to handle this. This is prone to errors, as the
> cpu_enable is invoked for each entry, irrespective of whether the
> detection rule applies to the CPU or not. And also this complicates
> other helpers, e.g, __this_cpu_has_cap.
> 
> This patch adds a wrapper entry to cover all the possible variations
> of a capability and ensures :
>  1) The capabilitiy is set when at least one of the entry detects
>  2) Action is only taken for the entries that detects.
> 
> This avoids explicit checks in the call backs. The only constraint
> here is that, all the entries should have the same "type".
> 
> Cc: Dave Martin <dave.martin@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---

[...]

> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c

[...]

> @@ -1275,7 +1274,7 @@ static bool __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps_li
>  		if (!(caps->type & scope_mask))
>  			continue;
>  
> -		cpu_has_cap = __this_cpu_has_cap(caps_list, caps->capability);
> +		cpu_has_cap = caps->matches(caps, SCOPE_LOCAL_CPU);

One other minor thing: the original caps_list argument seems no longer
to be needed in this function after this change.

Can we rename the caps_list argument to "caps" and remove the local
variable of the same name?

Cheers
---Dave
