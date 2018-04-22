Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751725AbeDVMyD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 08:54:03 -0400
Received: from smtprelay0149.hostedemail.com ([216.40.44.149]:58027 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751377AbeDVMyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 08:54:01 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,shea@shealevy.com,:::::::,RULES_HIT:41:355:379:599:800:871:960:973:988:989:1000:1260:1313:1314:1345:1359:1431:1437:1516:1518:1534:1542:1575:1711:1730:1747:1777:1792:1981:2194:2199:2393:2559:2562:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3872:3874:4321:4362:4605:5007:6261:6506:6747:7281:7875:7903:7909:8603:10004:10848:11026:11232:11473:11657:11658:11914:12043:12296:12438:12555:12895:12986:14096:14180:14181:14721:21060:21080:21433:21451:21627:21740:30025:30054,0,RBL:71.235.10.46:@shealevy.com:.lbl8.mailshell.net-62.4.0.191 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: bed12_5cebadbfbac2a
X-Filterd-Recvd-Size: 4149
From: Shea Levy <shea@shealevy.com>
To: linux-riscv@lists.infradead.org
Cc: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Load modules within relative jump range of the kernel text.
In-Reply-To: <20180409125800.5000-1-shea@shealevy.com>
References: <20180409125800.5000-1-shea@shealevy.com>
Date: Sun, 22 Apr 2018 08:53:56 -0400
Message-ID: <87lgdfieqj.fsf@xps13.shealevy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

Shea Levy <shea@shealevy.com> writes:

> Signed-off-by: Shea Levy <shea@shealevy.com>
> ---
>
> Note that this patch worked in my old modules patchset and seems to be
> working now, but my kernel boot locks up on top of
> riscv-for-linus-4.17-mw0 and I don't know if it's due to this patch or
> something else that's changed in the mean time.
>
> ---
>  arch/riscv/include/asm/pgtable.h |  9 +++++++++
>  arch/riscv/kernel/module.c       | 11 +++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index 16301966d65b..b08ded13364a 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -25,6 +25,7 @@
>  #include <asm/page.h>
>  #include <asm/tlbflush.h>
>  #include <linux/mm_types.h>
> +#include <linux/sizes.h>
>=20=20
>  #ifdef CONFIG_64BIT
>  #include <asm/pgtable-64.h>
> @@ -425,6 +426,14 @@ static inline void pgtable_cache_init(void)
>  #define TASK_SIZE VMALLOC_START
>  #endif
>=20=20
> +/*
> + * The module space lives between the addresses given by TASK_SIZE
> + * and PAGE_OFFSET - it must be within 2G of the kernel text.
> + */
> +#define MODULES_SIZE		(SZ_128M)
> +#define MODULES_VADDR		(PAGE_OFFSET - MODULES_SIZE)
> +#define MODULES_END		(VMALLOC_END)
> +
>  #include <asm-generic/pgtable.h>
>=20=20
>  #endif /* !__ASSEMBLY__ */
> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> index 5dddba301d0a..1b382c7de095 100644
> --- a/arch/riscv/kernel/module.c
> +++ b/arch/riscv/kernel/module.c
> @@ -16,6 +16,8 @@
>  #include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/moduleloader.h>
> +#include <linux/vmalloc.h>
> +#include <asm/pgtable.h>
>=20=20
>  static int apply_r_riscv_64_rela(struct module *me, u32 *location, Elf_A=
ddr v)
>  {
> @@ -382,3 +384,12 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char=
 *strtab,
>=20=20
>  	return 0;
>  }
> +
> +void *module_alloc(unsigned long size)
> +{
> +	return __vmalloc_node_range(size, 1, MODULES_VADDR,
> +				    MODULES_END, GFP_KERNEL,
> +				    PAGE_KERNEL_EXEC, 0,
> +				    NUMA_NO_NODE,
> +				    __builtin_return_address(0));
> +}
> --=20
> 2.16.2

Any thoughts on this?

Thanks,
Shea

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6ESKvwKkwnxgMLnaXAvWlX2G/icFAlrcheQACgkQXAvWlX2G
/icsgQ//aheaP3z4bDAGD/7lFGD6JgiZWtTT66KDgfDMI+yL4JfyxcRPmBkD/8CL
cuqLsmd7WqowWF99EFD6yRu+UbT8ZInzuYvY+lQrRLjC3KmH3PX6IXZLRtS91X9I
80lP1PKKGXt0fv1JLvhRS5Syuq7Ob3tgMdQ3QDMq4K4xf9BHTIEaXUVtw4m/O/aU
zCt8NFE6ZjyHbOOiKdaYXjTw52TprsDZHP8RhGSaqlOJ9MN1aPeh+ws33wjb4Hi+
hBI6v1gDEsj+R61wZF6tN2xB9lk6tebG1/vocbmCMIM4cZ0Vir8/+9Cbsn10vLQ6
XFpjsP2MdjdekylpwBNmERCS8gPMbpSWwqTaqXJCZrqXB/53VPpqzp1qFtZBGvjC
GPCRQm2Xst9tIxSoQUcNLbcTwrXT8D38FenxX2oM9IJfY4D0TyRSVvjkPfoPqz1w
rq+Y04U6Ozxeys4DvrO7Rl0S4T3vgbSMFTCtnLtxKOJSeP4P3Fhz6gCof9YgzYYw
5J1+KZaI5x3P7L0XnzTTtY93q46DxRtoIxljqcOoH/oVRDbDQxVC+scNqPSPg1WU
9+yrQVXG6KoqN0BmEuPG6t6h25lxvf8mL41ismjMsG9dqJ7yDpOI3p8uth/T2o9a
ksx1SJUkTujBxPvHHHywdh7sVfvK6V6jVnqVStovldLuio1RZ9k=
=Hrqm
-----END PGP SIGNATURE-----
--=-=-=--
