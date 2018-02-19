Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbeBSMJv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 07:09:51 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58176 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752579AbeBSMJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 07:09:50 -0500
Subject: Re: [PATCH] arm64: Fix compilation error while accessing
 MPIDR_HWID_BITMASK from .S files
To: Bhupesh Sharma <bhsharma@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: bhupesh.linux@gmail.com
References: <1519022394-11326-1-git-send-email-bhsharma@redhat.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <8c648c07-3611-bd18-eca9-3a34f43c8d44@arm.com>
Date: Mon, 19 Feb 2018 12:09:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519022394-11326-1-git-send-email-bhsharma@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/18 06:39, Bhupesh Sharma wrote:
> Since commit e1a50de37860b3a93a9d643b09638db5aff47650 (arm64: cputype:
> Silence Sparse warnings), compilation of arm64 architecture is broken
> with the following error messages:
> 
>    AR      arch/arm64/kernel/built-in.o
>    arch/arm64/kernel/head.S: Assembler messages:
>    arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
>    arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
>    arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
>    arch/arm64/kernel/head.S:677: Error: junk at end of line, first
>    unrecognized character is `L'
>    arch/arm64/kernel/head.S:677: Error: unexpected characters following
>    instruction at operand 2 -- `movz x1,:abs_g1_s:0xff00ffffffUL'
>    arch/arm64/kernel/head.S:677: Error: unexpected characters following
>    instruction at operand 2 -- `movk x1,:abs_g0_nc:0xff00ffffffUL'
> 
> This patch fixes the same by using the UL() macro correctly for
> assigning the MPIDR_HWID_BITMASK macro value.

Sorry! I am however rather puzzled at how I didn't hit this with my 
toolchain (Linaro 17.11), and neither did the LKP robot. Oh well.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> ---
>   arch/arm64/include/asm/cputype.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index eda8c5f629fc..350c76a1d15b 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -20,7 +20,7 @@
>   
>   #define MPIDR_UP_BITMASK	(0x1 << 30)
>   #define MPIDR_MT_BITMASK	(0x1 << 24)
> -#define MPIDR_HWID_BITMASK	0xff00ffffffUL
> +#define MPIDR_HWID_BITMASK	UL(0xff00ffffff)
>   
>   #define MPIDR_LEVEL_BITS_SHIFT	3
>   #define MPIDR_LEVEL_BITS	(1 << MPIDR_LEVEL_BITS_SHIFT)
> 
