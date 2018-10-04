Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEF8C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B274720875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B274720875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeJEOPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:15:04 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:39130 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbeJEOPD (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 5 Oct 2018 10:15:03 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Fri, 05 Oct 2018 09:17:35 +0200
Received: from linux-gy6r.site ([10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Thu, 04 Oct 2018 23:11:12 +0100
Subject: Re: [PATCH] irqchip/gic-v3-its: Add early memory allocation errata
To:     matthias.bgg@kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        marc.zyngier@arm.com, robert.richter@cavium.com
Cc:     suzuki.poulose@arm.com, shankerd@codeaurora.org,
        xiexiuqi@huawei.com, Dave.Martin@arm.com, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180912095232.2110-1-matthias.bgg@kernel.org>
From:   Matthias Brugger <mbrugger@suse.com>
Message-ID: <a08119a0-fc4e-6328-c3ad-04e5250f38d7@suse.com>
Date:   Fri, 5 Oct 2018 00:11:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180912095232.2110-1-matthias.bgg@kernel.org>
Content-Type: multipart/mixed;
 boundary="------------4BF7AA1CF640E9F502D41402"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4BF7AA1CF640E9F502D41402
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Friendly reminder, if anyone has any comment on the patch :)

On 9/12/18 11:52 AM, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
>=20
> Some hardware does not implement two-level page tables so that
> the amount of contigious memory needed by the baser is bigger
> then the zone order. This is a known problem on Cavium Thunderx
> with 4K page size.
>=20
> We fix this by adding an errata which allocates the memory early
> in the boot cycle, using the memblock allocator.
>=20
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>  arch/arm64/Kconfig               | 12 ++++++++
>  arch/arm64/include/asm/cpucaps.h |  3 +-
>  arch/arm64/kernel/cpu_errata.c   | 33 +++++++++++++++++++++
>  drivers/irqchip/irq-gic-v3-its.c | 50 ++++++++++++++++++++------------=

>  4 files changed, 79 insertions(+), 19 deletions(-)
>=20
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1b1a0e95c751..dfd9fe08f0b2 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -597,6 +597,18 @@ config QCOM_FALKOR_ERRATUM_E1041
> =20
>  	  If unsure, say Y.
> =20
> +config CAVIUM_ALLOC_ITS_TABLE_EARLY
> +	bool "Cavium Thunderx: Allocate the its table early"
> +	default y
> +	depends on ARM64_4K_PAGES && FORCE_MAX_ZONEORDER < 13
> +	depends on ARM_GIC_V3_ITS
> +	help
> +	  Cavium Thunderx needs to allocate 16MB of ITS translation table.
> +	  This can be bigger as MAX_ZONE_ORDER and need therefore be done
> +	  via the memblock allocator.
> +
> +	  If unsure, say Y.
> +
>  endmenu
> =20
> =20
> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/=
cpucaps.h
> index ae1f70450fb2..c98be4809b7f 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -51,7 +51,8 @@
>  #define ARM64_SSBD				30
>  #define ARM64_MISMATCHED_CACHE_TYPE		31
>  #define ARM64_HAS_STAGE2_FWB			32
> +#define ARM64_WORKAROUND_CAVIUM_ITS_TABLE	33
> =20
> -#define ARM64_NCAPS				33
> +#define ARM64_NCAPS				34
> =20
>  #endif /* __ASM_CPUCAPS_H */
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_err=
ata.c
> index dec10898d688..7908f8fa3ba8 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -411,6 +411,29 @@ static bool has_ssbd_mitigation(const struct arm64=
_cpu_capabilities *entry,
>  }
>  #endif	/* CONFIG_ARM64_SSBD */
> =20
> +#ifdef CONFIG_CAVIUM_ALLOC_ITS_TABLE_EARLY
> +#include <linux/bootmem.h>
> +extern void *its_base;
> +
> +/*
> + * Hardware that doesn't use two-level page table and exceedes
> + * the maximum order of pages that can be allocated by the buddy
> + * allocator. Try to use the memblock allocator instead.
> + * This has been observed on Cavium Thunderx machines with 4K
> + * page size.
> + */
> +static bool __init its_early_alloc(const struct arm64_cpu_capabilities=
 *cap,
> +		       int scope)
> +{
> +	/* We need to allocate the table only once */
> +	if (scope & ARM64_CPUCAP_SCOPE_BOOT_CPU && !its_base)
> +		its_base =3D (void *)memblock_virt_alloc_nopanic(16 * SZ_1M,
> +					64 * SZ_1K);
> +
> +	return true;
> +}
> +#endif /* CONFIG_CAVIUM_ALLOC_ITS_TABLE_EARLY */
> +
>  #define CAP_MIDR_RANGE(model, v_min, r_min, v_max, r_max)	\
>  	.matches =3D is_affected_midr_range,			\
>  	.midr_range =3D MIDR_RANGE(model, v_min, r_min, v_max, r_max)
> @@ -679,6 +702,16 @@ const struct arm64_cpu_capabilities arm64_errata[]=
 =3D {
>  		.type =3D ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
>  		.matches =3D has_ssbd_mitigation,
>  	},
> +#endif
> +#ifdef CONFIG_CAVIUM_ALLOC_ITS_TABLE_EARLY
> +	{
> +		/* Cavium ThunderX, pass 1.x - 2.1 */
> +		.desc =3D "Cavium alloc ITS table early",
> +		.capability =3D ARM64_WORKAROUND_CAVIUM_ITS_TABLE,
> +		.type =3D ARM64_CPUCAP_SCOPE_BOOT_CPU,
> +		.matches =3D its_early_alloc,
> +		.midr_range =3D MIDR_RANGE(MIDR_THUNDERX, 0, 0, 1, 1),
> +	},
>  #endif
>  	{
>  	}
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic=
-v3-its.c
> index c2df341ff6fa..b78546740a0d 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -87,6 +87,8 @@ struct its_baser {
>  	u32		psz;
>  };
> =20
> +void *its_base;
> +
>  struct its_device;
> =20
>  /*
> @@ -1666,7 +1668,7 @@ static void its_write_baser(struct its_node *its,=
 struct its_baser *baser,
>  	baser->val =3D its_read_baser(its, baser);
>  }
> =20
> -static int its_setup_baser(struct its_node *its, struct its_baser *bas=
er,
> +static int __init its_setup_baser(struct its_node *its, struct its_bas=
er *baser,
>  			   u64 cache, u64 shr, u32 psz, u32 order,
>  			   bool indirect)
>  {
> @@ -1675,7 +1677,6 @@ static int its_setup_baser(struct its_node *its, =
struct its_baser *baser,
>  	u64 type =3D GITS_BASER_TYPE(val);
>  	u64 baser_phys, tmp;
>  	u32 alloc_pages;
> -	void *base;
> =20
>  retry_alloc_baser:
>  	alloc_pages =3D (PAGE_ORDER_TO_SIZE(order) / psz);
> @@ -1687,11 +1688,22 @@ static int its_setup_baser(struct its_node *its=
, struct its_baser *baser,
>  		order =3D get_order(GITS_BASER_PAGES_MAX * psz);
>  	}
> =20
> -	base =3D (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> -	if (!base)
> -		return -ENOMEM;
> +	if (cpus_have_const_cap(ARM64_WORKAROUND_CAVIUM_ITS_TABLE)) {
> +		if (!its_base) {
> +			pr_warn("ITS@%pa: %s Allocation using memblock failed %pS\n",
> +				&its->phys_base, its_base_type_string[type],
> +				its_base);
> +			return -ENOMEM;
> +		}
> +
> +	} else {
> +		its_base =3D (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> +							order);
> +		if (!its_base)
> +			return -ENOMEM;
> +	}
> =20
> -	baser_phys =3D virt_to_phys(base);
> +	baser_phys =3D virt_to_phys(its_base);
> =20
>  	/* Check if the physical address of the memory is above 48bits */
>  	if (IS_ENABLED(CONFIG_ARM64_64K_PAGES) && (baser_phys >> 48)) {
> @@ -1699,7 +1711,7 @@ static int its_setup_baser(struct its_node *its, =
struct its_baser *baser,
>  		/* 52bit PA is supported only when PageSize=3D64K */
>  		if (psz !=3D SZ_64K) {
>  			pr_err("ITS: no 52bit PA support when psz=3D%d\n", psz);
> -			free_pages((unsigned long)base, order);
> +			free_pages((unsigned long)its_base, order);
>  			return -ENXIO;
>  		}
> =20
> @@ -1744,7 +1756,7 @@ static int its_setup_baser(struct its_node *its, =
struct its_baser *baser,
>  		shr =3D tmp & GITS_BASER_SHAREABILITY_MASK;
>  		if (!shr) {
>  			cache =3D GITS_BASER_nC;
> -			gic_flush_dcache_to_poc(base, PAGE_ORDER_TO_SIZE(order));
> +			gic_flush_dcache_to_poc(its_base, PAGE_ORDER_TO_SIZE(order));
>  		}
>  		goto retry_baser;
>  	}
> @@ -1755,7 +1767,7 @@ static int its_setup_baser(struct its_node *its, =
struct its_baser *baser,
>  		 * size and retry. If we reach 4K, then
>  		 * something is horribly wrong...
>  		 */
> -		free_pages((unsigned long)base, order);
> +		free_pages((unsigned long)its_base, order);
>  		baser->base =3D NULL;
> =20
>  		switch (psz) {
> @@ -1772,19 +1784,19 @@ static int its_setup_baser(struct its_node *its=
, struct its_baser *baser,
>  		pr_err("ITS@%pa: %s doesn't stick: %llx %llx\n",
>  		       &its->phys_base, its_base_type_string[type],
>  		       val, tmp);
> -		free_pages((unsigned long)base, order);
> +		free_pages((unsigned long)its_base, order);
>  		return -ENXIO;
>  	}
> =20
>  	baser->order =3D order;
> -	baser->base =3D base;
> +	baser->base =3D its_base;
>  	baser->psz =3D psz;
>  	tmp =3D indirect ? GITS_LVL1_ENTRY_SIZE : esz;
> =20
>  	pr_info("ITS@%pa: allocated %d %s @%lx (%s, esz %d, psz %dK, shr %d)\=
n",
>  		&its->phys_base, (int)(PAGE_ORDER_TO_SIZE(order) / (int)tmp),
>  		its_base_type_string[type],
> -		(unsigned long)virt_to_phys(base),
> +		(unsigned long)virt_to_phys(its_base),
>  		indirect ? "indirect" : "flat", (int)esz,
>  		psz / SZ_1K, (int)shr >> GITS_BASER_SHAREABILITY_SHIFT);
> =20
> @@ -1832,12 +1844,14 @@ static bool its_parse_indirect_baser(struct its=
_node *its,
>  	 * feature is not supported by hardware.
>  	 */
>  	new_order =3D max_t(u32, get_order(esz << ids), new_order);
> -	if (new_order >=3D MAX_ORDER) {
> -		new_order =3D MAX_ORDER - 1;
> -		ids =3D ilog2(PAGE_ORDER_TO_SIZE(new_order) / (int)esz);
> -		pr_warn("ITS@%pa: %s Table too large, reduce ids %u->%u\n",
> -			&its->phys_base, its_base_type_string[type],
> -			its->device_ids, ids);
> +	if (!cpus_have_const_cap(ARM64_WORKAROUND_CAVIUM_ITS_TABLE)) {
> +		if (new_order >=3D MAX_ORDER) {
> +			new_order =3D MAX_ORDER - 1;
> +			ids =3D ilog2(PAGE_ORDER_TO_SIZE(new_order) / (int)esz);
> +			pr_warn("ITS@%pa: %s Table too large, reduce ids %u->%u\n",
> +				&its->phys_base, its_base_type_string[type],
> +				its->device_ids, ids);
> +		}
>  	}
> =20
>  	*order =3D new_order;
>=20

--------------4BF7AA1CF640E9F502D41402
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

mQENBFuECLQBCAD66PIehgR5YGIOhLIDfubGmBbktra7Ix4c0uMShRkv05ZfJmPK
N50OrIm4gaQ25RMDrZd6X3RU35IsoflqTSBGoiMQmC9TklVsAfIObuNkvDMJEDXd
pvbIuYyj9QcSysHvTW9GrU/hF3uFqoPlaDmQy9TBMDDtJu8CPYVpyVnmXJvyoYa2
KE77LYXORs+eArKR8dqOK/z3zzHWMq8IieiASRcFfDZBx4fPHRZaOYkFGaLpQPfF
/bCwWWX6O6bRvx5KOWTQzt2Hp/6ZzHX+A7XY6yLY9bM18/70NICZNF8oaDN6/i/K
nMoGcugqE2Kk66hLeybFWVmFjppRt7zh6GaVABEBAAG0JE1hdHRoaWFzIEJydWdn
ZXIgPG1icnVnZ2VyQHN1c2UuY29tPokBVAQTAQgAPhYhBA1mtM782M72qvgLxkP5
4a369LqrBQJbhAi1AhsDBQkB4TOABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJ
EEP54a369LqrS08H/0gLY/JJfnC1EPWaTVmjtbL+b+m12SyQa+orJ/FVLfPePQYG
T+zSnqiz2UHCq6kj6v7alRozLwxJSDDIx2lx3eSTggEaI8SlCY3j8WhY9n7PUFC1
13qRewpEugyUjQFMRqzZd1y2C11fwHuUgLHQTOCxz8JiVuCFaBd7yR/5w/uy+pt1
XgAgRGaprsECaMCwykDvxDsWLKp4aPK2VLnJYulzDAlWQTIrMjIdSEbVlFHSfvtq
kjjHGQjXkNjbqM4EknchrmnVPLWfQQF1HnKI95A+aBbcGlx1NxQYSJJ7UXnhw+dH
HwjqYVgkDhXlWMR8VXhmXXFnWRgzZINXeHwuXkC5AQ0EW4QItQEIAMrwGOUXVhVE
kl6+IXCnD2TPqdGiuv/aKZ8yIvvD1VPw8j0kRdbsha1sIxE7cKvHcnRqKuLW6w9s
FCNaXoJBPysVDWhVdT4drpr8WtwZQG4Lqa86t5Ndz14lG3Vr/lFs07BpVbxZj2/k
RqXNZbAmCmZfZbtR55XyUz20uJxoQ0ckXOUxLA2ye0bF9DOt4SwgNgSdp668YFep
sTBPR0wRLQQpL/00z+S7fiULzUqzUq4cQPpZt7YALJ2iQoUQ93G3t95DMwdt5/tT
mnFMt8ruyP45oHO+8X6RDRSR31G34YzLWGinXPMDYZ+kjhFg3yv5m5+V6Lc2+APN
PbouD/9LEXUAEQEAAYkBPAQYAQgAJhYhBA1mtM782M72qvgLxkP54a369LqrBQJb
hAi1AhsMBQkB4TOAAAoJEEP54a369LqrRq0IAKOr8hyL+wgdqg/zd1fjCT2npur+
8ngyrqpsD/QKzSf22jyiLxVpmSDYkPEYWUd+6HR8rzBWHS5txn0ObOfKRFLpYo7G
T3NiK+H0Hf/1J7PdZv4ee7A28nSqzTR+B+wgTfYBALWuFpKh44PV4T9IVsl7oiZf
U4zbGUH4vTFCJturmJegaE8rk2Dzq0xNi0wM3ss06Hx+8XPEiZ4U4rUIbQcJvkJP
5g5MqpJlseJ9uRzXUGYx9+pu10yAIVOHGlMSnjRuHZlgKd4+1CbBR+U6/tYcvjvw
4d1CEpJq9A7GKUfII+7fIe/GaBA+DUXswVQq6GiYdfRwVWSdXWucEKvjeGg=3D
=3DAXLy
-----END PGP PUBLIC KEY BLOCK-----

--------------4BF7AA1CF640E9F502D41402--
