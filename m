Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753881AbeBGKv7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 05:51:59 -0500
Received: from foss.arm.com ([217.140.101.70]:49018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753696AbeBGKv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 05:51:58 -0500
Subject: Re: [PATCH 2/2] arm64: Expose Arm v8.4 features
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org
References: <20180201103838.14702-1-suzuki.poulose@arm.com>
 <20180201103838.14702-2-suzuki.poulose@arm.com>
 <20180207104320.GM5862@e103592.cambridge.arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <336948e9-62c4-1ca0-c832-045095eda229@arm.com>
Date: Wed, 7 Feb 2018 10:51:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180207104320.GM5862@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/18 10:43, Dave Martin wrote:
> On Thu, Feb 01, 2018 at 10:38:38AM +0000, Suzuki K Poulose wrote:
>> Expose the new features introduced by Arm v8.4 extensions to
>> Arm v8-A profile.
>>
>> These include :
>>
>>   1) Data indpendent timing of instructions. (DIT, exposed as HWCAP_DIT)
>>   2) Unaligned atomic instructions and Single-copy atomicity of loads
>>      and stores. (AT, expose as HWCAP_USCAT)
>>   3) LDAPR and STLR instructions with immediate offsets (extension to
>>      LRCPC, exposed as HWCAP_ILRCPC)
>>   4) Flag manipulation instructions (TS, exposed as HWCAP_FLAGM).
>>
>> While at it get rid of the RES0 entries in the cpu-feature-registers.txt
>> documentation.
> 
> Should we write somewhere than fields that are not described here are
> implicitly RES0, or would that be too strong a statement?

Dave,

We already have the following description in the file :

"The following rules are applied to the value returned by the
infrastructure:

  a) The value of an 'IMPLEMENTATION DEFINED' field is set to 0.
  b) The value of a reserved field is populated with the reserved
     value as defined by the architecture.
  c) The value of a 'visible' field holds the system wide safe value
     for the particular feature (except for MIDR_EL1, see section 4).
  d) All other fields (i.e, invisible fields) are set to indicate
     the feature is missing (as defined by the architecture).
"

So we don't have to bother if the fields are RES0 or they get
some definitions in the future, as long as we don't expose them.

Cheers
Suzuki


> 
> Cheers
> ---Dave
> 
>> Cc: Dave Martin <dave.martin@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   Documentation/arm64/cpu-feature-registers.txt | 18 ++++++++++--------
>>   Documentation/arm64/elf_hwcaps.txt            | 16 ++++++++++++++++
>>   arch/arm64/include/asm/sysreg.h               |  3 +++
>>   arch/arm64/include/uapi/asm/hwcap.h           |  4 ++++
>>   arch/arm64/kernel/cpufeature.c                |  7 +++++++
>>   arch/arm64/kernel/cpuinfo.c                   |  4 ++++
>>   6 files changed, 44 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/arm64/cpu-feature-registers.txt b/Documentation/arm64/cpu-feature-registers.txt
>> index a70090b28b07..7964f03846b1 100644
>> --- a/Documentation/arm64/cpu-feature-registers.txt
>> +++ b/Documentation/arm64/cpu-feature-registers.txt
>> @@ -110,7 +110,7 @@ infrastructure:
>>        x--------------------------------------------------x
>>        | Name                         |  bits   | visible |
>>        |--------------------------------------------------|
>> -     | RES0                         | [63-52] |    n    |
>> +     | TS                           | [55-52] |    y    |
>>        |--------------------------------------------------|
>>        | FHM                          | [51-48] |    y    |
>>        |--------------------------------------------------|
>> @@ -124,8 +124,6 @@ infrastructure:
>>        |--------------------------------------------------|
>>        | RDM                          | [31-28] |    y    |
>>        |--------------------------------------------------|
>> -     | RES0                         | [27-24] |    n    |
>> -     |--------------------------------------------------|
>>        | ATOMICS                      | [23-20] |    y    |
>>        |--------------------------------------------------|
>>        | CRC32                        | [19-16] |    y    |
>> @@ -135,8 +133,6 @@ infrastructure:
>>        | SHA1                         | [11-8]  |    y    |
>>        |--------------------------------------------------|
>>        | AES                          | [7-4]   |    y    |
>> -     |--------------------------------------------------|
>> -     | RES0                         | [3-0]   |    n    |
>>        x--------------------------------------------------x
>>   
>>   
>> @@ -144,12 +140,10 @@ infrastructure:
>>        x--------------------------------------------------x
>>        | Name                         |  bits   | visible |
>>        |--------------------------------------------------|
>> -     | RES0                         | [63-36] |    n    |
>> +     | DIT                          | [51-48] |    y    |
>>        |--------------------------------------------------|
>>        | SVE                          | [35-32] |    y    |
>>        |--------------------------------------------------|
>> -     | RES0                         | [31-28] |    n    |
>> -     |--------------------------------------------------|
>>        | GIC                          | [27-24] |    n    |
>>        |--------------------------------------------------|
>>        | AdvSIMD                      | [23-20] |    y    |
>> @@ -199,6 +193,14 @@ infrastructure:
>>        | DPB                          | [3-0]   |    y    |
>>        x--------------------------------------------------x
>>   
>> +  5) ID_AA64MMFR2_EL1 - Memory model feature register 2
>> +
>> +     x--------------------------------------------------x
>> +     | Name                         |  bits   | visible |
>> +     |--------------------------------------------------|
>> +     | AT                           | [35-32] |    y    |
>> +     x--------------------------------------------------x
>> +
>>   Appendix I: Example
>>   ---------------------------
>>   
>> diff --git a/Documentation/arm64/elf_hwcaps.txt b/Documentation/arm64/elf_hwcaps.txt
>> index 57324ee55ecc..d6aff2c5e9e2 100644
>> --- a/Documentation/arm64/elf_hwcaps.txt
>> +++ b/Documentation/arm64/elf_hwcaps.txt
>> @@ -162,3 +162,19 @@ HWCAP_SVE
>>   HWCAP_ASIMDFHM
>>   
>>      Functionality implied by ID_AA64ISAR0_EL1.FHM == 0b0001.
>> +
>> +HWCAP_DIT
>> +
>> +    Functionality implied by ID_AA64PFR0_EL1.DIT == 0b0001.
>> +
>> +HWCAP_USCAT
>> +
>> +    Functionality implied by ID_AA64MMFR2_EL1.AT == 0b0001.
>> +
>> +HWCAP_ILRCPC
>> +
>> +    Functionality implied by ID_AA64ISR1_EL1.LRCPC == 0b0002.
>> +
>> +HWCAP_FLAGM
>> +
>> +    Functionality implied by ID_AA64ISAR0_EL1.TS == 0b0001.
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index 0e1960c59197..e7b9f154e476 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -490,6 +490,7 @@
>>   #define SCTLR_EL1_BUILD_BUG_ON_MISSING_BITS	BUILD_BUG_ON((SCTLR_EL1_SET ^ SCTLR_EL1_CLEAR) != ~0)
>>   
>>   /* id_aa64isar0 */
>> +#define ID_AA64ISAR0_TS_SHIFT		52
>>   #define ID_AA64ISAR0_FHM_SHIFT		48
>>   #define ID_AA64ISAR0_DP_SHIFT		44
>>   #define ID_AA64ISAR0_SM4_SHIFT		40
>> @@ -511,6 +512,7 @@
>>   /* id_aa64pfr0 */
>>   #define ID_AA64PFR0_CSV3_SHIFT		60
>>   #define ID_AA64PFR0_CSV2_SHIFT		56
>> +#define ID_AA64PFR0_DIT_SHIFT		48
>>   #define ID_AA64PFR0_SVE_SHIFT		32
>>   #define ID_AA64PFR0_RAS_SHIFT		28
>>   #define ID_AA64PFR0_GIC_SHIFT		24
>> @@ -568,6 +570,7 @@
>>   #define ID_AA64MMFR1_VMIDBITS_16	2
>>   
>>   /* id_aa64mmfr2 */
>> +#define ID_AA64MMFR2_AT_SHIFT		32
>>   #define ID_AA64MMFR2_LVA_SHIFT		16
>>   #define ID_AA64MMFR2_IESB_SHIFT		12
>>   #define ID_AA64MMFR2_LSM_SHIFT		8
>> diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
>> index f018c3deea3b..17c65c8f33cb 100644
>> --- a/arch/arm64/include/uapi/asm/hwcap.h
>> +++ b/arch/arm64/include/uapi/asm/hwcap.h
>> @@ -44,5 +44,9 @@
>>   #define HWCAP_SHA512		(1 << 21)
>>   #define HWCAP_SVE		(1 << 22)
>>   #define HWCAP_ASIMDFHM		(1 << 23)
>> +#define HWCAP_DIT		(1 << 24)
>> +#define HWCAP_USCAT		(1 << 25)
>> +#define HWCAP_ILRCPC		(1 << 26)
>> +#define HWCAP_FLAGM		(1 << 27)
>>   
>>   #endif /* _UAPI__ASM_HWCAP_H */
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 1c39a635a71c..796e83dde9fc 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -123,6 +123,7 @@ cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry, int __unused)
>>    * sync with the documentation of the CPU feature register ABI.
>>    */
>>   static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
>> +	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_TS_SHIFT, 4, 0),
>>   	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_FHM_SHIFT, 4, 0),
>>   	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_DP_SHIFT, 4, 0),
>>   	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_SM4_SHIFT, 4, 0),
>> @@ -148,6 +149,7 @@ static const struct arm64_ftr_bits ftr_id_aa64isar1[] = {
>>   static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
>>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_CSV3_SHIFT, 4, 0),
>>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_CSV2_SHIFT, 4, 0),
>> +	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_DIT_SHIFT, 4, 0),
>>   	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_SVE_SHIFT, 4, 0),
>>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_RAS_SHIFT, 4, 0),
>>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_GIC_SHIFT, 4, 0),
>> @@ -192,6 +194,7 @@ static const struct arm64_ftr_bits ftr_id_aa64mmfr1[] = {
>>   };
>>   
>>   static const struct arm64_ftr_bits ftr_id_aa64mmfr2[] = {
>> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_AT_SHIFT, 4, 0),
>>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_LVA_SHIFT, 4, 0),
>>   	/* While IESB is good to have, it is not fatal if we miss this on some CPUs */
>>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_IESB_SHIFT, 4, 0),
>> @@ -1083,14 +1086,18 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
>>   	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SM4_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_SM4),
>>   	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_DP_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_ASIMDDP),
>>   	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_FHM_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_ASIMDFHM),
>> +	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_TS_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_FLAGM),
>>   	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_FP_SHIFT, FTR_SIGNED, 0, CAP_HWCAP, HWCAP_FP),
>>   	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_FP_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, HWCAP_FPHP),
>>   	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 0, CAP_HWCAP, HWCAP_ASIMD),
>>   	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, HWCAP_ASIMDHP),
>> +	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_DIT_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, HWCAP_DIT),
>>   	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_DPB_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_DCPOP),
>>   	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_JSCVT_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_JSCVT),
>>   	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_FCMA_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_FCMA),
>>   	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_LRCPC_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_LRCPC),
>> +	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_LRCPC_SHIFT, FTR_UNSIGNED, 2, CAP_HWCAP, HWCAP_ILRCPC),
>> +	HWCAP_CAP(SYS_ID_AA64MMFR2_EL1, ID_AA64MMFR2_AT_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_USCAT),
>>   #ifdef CONFIG_ARM64_SVE
>>   	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_SVE_SHIFT, FTR_UNSIGNED, ID_AA64PFR0_SVE, CAP_HWCAP, HWCAP_SVE),
>>   #endif
>> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
>> index 7f94623df8a5..e9ab7b3ed317 100644
>> --- a/arch/arm64/kernel/cpuinfo.c
>> +++ b/arch/arm64/kernel/cpuinfo.c
>> @@ -77,6 +77,10 @@ static const char *const hwcap_str[] = {
>>   	"sha512",
>>   	"sve",
>>   	"asimdfhm",
>> +	"dit",
>> +	"uscat",
>> +	"ilrcpc",
>> +	"flagm",
>>   	NULL
>>   };
>>   
>> -- 
>> 2.14.3
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
