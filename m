Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752793AbeBISEy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 13:04:54 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51140 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752215AbeBISEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 13:04:52 -0500
Subject: Re: [PATCH v3 00/21] arm64: Rework cpu capabilities handling
To: linux-arm-kernel@lists.infradead.org
Cc: dave.martin@arm.com, linux-kernel@vger.kernel.org, will.deacon@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        jnair@caviumnetworks.com, ckadabi@codeaurora.org, robin.murphy@arm.com,
        ard.biesheuvel@linaro.org
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <50a7c88f-b8bb-163e-b1c9-919c723fb05c@arm.com>
Date: Fri, 9 Feb 2018 18:04:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180209175513.17100-1-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/18 17:54, Suzuki K Poulose wrote:
> This series reworks the arm64 CPU capabilities handling (which
> manages the system features and errata). The current infrastructure
> doesn't allow fine control for handling different features or errata.
> There is one rule for features and another rule for errata.
> 
> * Features are checked only once, after all the boot time CPUs are
>    activated. Any new CPU that is brought up is prevented from booting
>    if it misses a feature already established. If the new CPU has a
>    feature not enabled already, it is allowed to boot.
> 
> * Errata checks are performed on all the CPUs and any new CPU is
>    OK to miss the capability. However if a late CPU requires a work around,
>    then we fail the CPU.
> 
>    This doesn't always apply to some features. e.g, KPTI is a security
>    feature which should be applied when at least one CPU needs it. So,
>    the tests should be performed on all the booting CPUs individually.
>    Also, if a CPU that needs this security feature is brought up later,
>    when the system has not enabled it, the CPU can boot making the system
>    insecure. Another exception is the hardware DBM for page tables. The
>    kernel can safely run with a mix of CPUs that have the feature turned
>    on and off. This again causes problem when a new CPU is brought up
>    which may not have the feature, which is killed.
> 
>    Also there are other features like, GICV3 system register access,
>    which now need to be enabled very early based on the boot CPU to
>    allow the use of Priority handling to implement NMI.
> 
> This calls for finer level of control per capability and the series
> implements the same by defining how to deal with a conflict of a
> given capability on a CPU with that of the system level state. It
> also consolidates the handling of features and errata into generic
> helpers. The table of features and errata are left as they are to
> allow easier look up for a given type.
> 
> The series also gets rid of duplicate entries for a single capability
> by introducing a wrapper entry which takes care of managing a list
> of entries with distinct matches/enable pair.
> 
> We also cleans up the MIDR range handling and cleans up some of the
> errata checks where the entries were duplicated for checking different
> CPU models. Finally it also implements a work around for Arm Cortex-A55
> erratum 1024718 based on the new infrastructure.
> 
> Applies on arm64 for-next/core. The tree is available at :
> 
> 	git://linux-arm.org/linux-skp.git cpu-cap-rework/v3

Apologies for the mess... obviously I messed up my folder.
If anyone needs the patches for testing, the branch above is sane.

Apologies..
Suzuki
