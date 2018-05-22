Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeEVTG2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:06:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35130 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbeEVTGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:06:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BCCB4601D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=awallis@codeaurora.org
Subject: Re: [PATCHv2 06/12] arm64: add basic pointer authentication support
To: Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, cdall@linaro.org,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        marc.zyngier@arm.com, suzuki.poulose@arm.com, will.deacon@arm.com,
        yao.qi@arm.com, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org
References: <20171127163806.31435-1-mark.rutland@arm.com>
 <20171127163806.31435-7-mark.rutland@arm.com>
From: Adam Wallis <awallis@codeaurora.org>
Message-ID: <daefeb1f-9553-c26d-0b35-2c4da328aeff@codeaurora.org>
Date: Tue, 22 May 2018 15:06:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20171127163806.31435-7-mark.rutland@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/2017 11:38 AM, Mark Rutland wrote:
> This patch adds basic support for pointer authentication, allowing
> userspace to make use of APIAKey. The kernel maintains an APIAKey value
> for each process (shared by all threads within), which is initialised to
> a random value at exec() time.
> 
> To describe that address authentication instructions are available, the
> ID_AA64ISAR0.{APA,API} fields are exposed to userspace. A new hwcap,
> APIA, is added to describe that the kernel manages APIAKey.
> 
> Instructions using other keys (APIBKey, APDAKey, APDBKey) are disabled,
> and will behave as NOPs. These may be made use of in future patches.
> 
> No support is added for the generic key (APGAKey), though this cannot be
> trapped or made to behave as a NOP. Its presence is not advertised with
> a hwcap.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/mmu.h          |  5 ++
>  arch/arm64/include/asm/mmu_context.h  | 25 +++++++++-
>  arch/arm64/include/asm/pointer_auth.h | 89 +++++++++++++++++++++++++++++++++++
>  arch/arm64/include/uapi/asm/hwcap.h   |  1 +
>  arch/arm64/kernel/cpufeature.c        | 17 ++++++-
>  arch/arm64/kernel/cpuinfo.c           |  1 +
>  6 files changed, 134 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm64/include/asm/pointer_auth.h

Mark, I was able to verify that a buffer overflow exploit results in a segfault
with these PAC patches. When I compile the same binary without
"-msign-return-address=none", I am able to successfully overflow the stack and
execute malicious code.

Thanks
Adam

Tested-by: Adam Wallis <awallis@codeaurora.org>


-- 
Adam Wallis
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
