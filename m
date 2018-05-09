Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756201AbeEILUF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:20:05 -0400
Received: from smtprelay0225.hostedemail.com ([216.40.44.225]:37638 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751370AbeEILUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:20:03 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,shea@shealevy.com,:::::::,RULES_HIT:41:355:379:599:800:871:960:973:988:989:1000:1260:1313:1314:1345:1359:1431:1437:1516:1518:1535:1543:1575:1711:1730:1747:1777:1792:1981:2194:2199:2393:2553:2559:2562:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:4362:4605:5007:6119:6261:6506:6747:7281:7875:7903:7909:8603:9036:10004:10848:11026:11232:11473:11657:11658:11914:12043:12296:12438:12555:12740:12895:12986:14096:14180:14181:14721:21060:21080:21433:21451:21627:21740:30025:30054:30090:30091,0,RBL:71.235.10.46:@shealevy.com:.lbl8.mailshell.net-62.4.0.191 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:ff,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: land05_74baec2beea09
X-Filterd-Recvd-Size: 5092
From: Shea Levy <shea@shealevy.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: linux-riscv@lists.infradead.org, albert@sifive.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Load modules within relative jump range of the kernel text.
In-Reply-To: <87d0yoizv9.fsf@xps13.shealevy.com>
References: <mhng-0a2f9574-9b23-4f26-ae76-18ed7f2c8533@palmer-si-x1c4> <87d0yoizv9.fsf@xps13.shealevy.com>
Date: Wed, 09 May 2018 07:20:00 -0400
Message-ID: <87zi19gjof.fsf@xps13.shealevy.com>
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

> Hi Palmer,
>
> Palmer Dabbelt <palmer@sifive.com> writes:
>
>> On Sun, 22 Apr 2018 05:53:56 PDT (-0700), shea@shealevy.com wrote:
>>> Hi Palmer,
>>>
>>> Shea Levy <shea@shealevy.com> writes:
>>>
>>>> Signed-off-by: Shea Levy <shea@shealevy.com>
>>>> ---
>>>>
>>>> Note that this patch worked in my old modules patchset and seems to be
>>>> working now, but my kernel boot locks up on top of
>>>> riscv-for-linus-4.17-mw0 and I don't know if it's due to this patch or
>>>> something else that's changed in the mean time.
>>>>
>>>> ---
>>>>  arch/riscv/include/asm/pgtable.h |  9 +++++++++
>>>>  arch/riscv/kernel/module.c       | 11 +++++++++++
>>>>  2 files changed, 20 insertions(+)
>>>>
>>>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm=
/pgtable.h
>>>> index 16301966d65b..b08ded13364a 100644
>>>> --- a/arch/riscv/include/asm/pgtable.h
>>>> +++ b/arch/riscv/include/asm/pgtable.h
>>>> @@ -25,6 +25,7 @@
>>>>  #include <asm/page.h>
>>>>  #include <asm/tlbflush.h>
>>>>  #include <linux/mm_types.h>
>>>> +#include <linux/sizes.h>
>>>>=20=20
>>>>  #ifdef CONFIG_64BIT
>>>>  #include <asm/pgtable-64.h>
>>>> @@ -425,6 +426,14 @@ static inline void pgtable_cache_init(void)
>>>>  #define TASK_SIZE VMALLOC_START
>>>>  #endif
>>>>=20=20
>>>> +/*
>>>> + * The module space lives between the addresses given by TASK_SIZE
>>>> + * and PAGE_OFFSET - it must be within 2G of the kernel text.
>>>> + */
>>>> +#define MODULES_SIZE		(SZ_128M)
>>>> +#define MODULES_VADDR		(PAGE_OFFSET - MODULES_SIZE)
>>>> +#define MODULES_END		(VMALLOC_END)
>>>> +
>>>>  #include <asm-generic/pgtable.h>
>>>>=20=20
>>>>  #endif /* !__ASSEMBLY__ */
>>>> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
>>>> index 5dddba301d0a..1b382c7de095 100644
>>>> --- a/arch/riscv/kernel/module.c
>>>> +++ b/arch/riscv/kernel/module.c
>>>> @@ -16,6 +16,8 @@
>>>>  #include <linux/err.h>
>>>>  #include <linux/errno.h>
>>>>  #include <linux/moduleloader.h>
>>>> +#include <linux/vmalloc.h>
>>>> +#include <asm/pgtable.h>
>>>>=20=20
>>>>  static int apply_r_riscv_64_rela(struct module *me, u32 *location, El=
f_Addr v)
>>>>  {
>>>> @@ -382,3 +384,12 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const c=
har *strtab,
>>>>=20=20
>>>>  	return 0;
>>>>  }
>>>> +
>>>> +void *module_alloc(unsigned long size)
>>>> +{
>>>> +	return __vmalloc_node_range(size, 1, MODULES_VADDR,
>>>> +				    MODULES_END, GFP_KERNEL,
>>>> +				    PAGE_KERNEL_EXEC, 0,
>>>> +				    NUMA_NO_NODE,
>>>> +				    __builtin_return_address(0));
>>>> +}
>>>> --=20
>>>> 2.16.2
>>>
>>> Any thoughts on this?
>>
>> The concept looks good, but does this actually keep the modules within 2=
GiB of=20
>> the text if PAGE_OFFSET is large?
>
> It's been some time since I wrote this, but I thought PAGE_OFFSET was
> where the kernel text *started*? So unless the text itself is bigger
> than 2G - 128 M, in which case we're SOL anyway, it seems like this
> should work. Is there something better we can do, without a large memory
> model?
>
> Thanks,
> Shea

Any further thoughts on this?

Thanks,
Shea

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6ESKvwKkwnxgMLnaXAvWlX2G/icFAlry2WAACgkQXAvWlX2G
/icCMxAAhcJ3dQBn1n80MQ25bYqB8naNJykEsW9wHNEXJfLPhAe8dcu1NC7Sys2u
/o6X1eYhfsEe8Id8MjJ2AV02slBjT3KNqVHbAC289olSbG27y1OcTvaobevZThK7
7G8geHeiR9A/DN8anH67WL3JbHmMUqr4bDLbsEIeL6SxIesdBjILpA76dbXCVrwO
jzsqtam3YzXxWiI3kTUzvHRZNQZZsp0/YjBkNvjmLpmhw3luh6o+T9W3Tt1rrE1X
KAd7NkSacmJXoTOa0ZZqJ10wR0l+QQfFzVWS6PUY+32EUkXhXxBeV3+zkET4B8Gm
DIVBMJS0ECZmsAGIbi/jdMtVlXi8/FL+iQijhDfxrCflAPcYoGV5c6C12Mr540Bq
1cnACaQ4/wmBTcxuUMlQoppKKgFuPhVToTb4r6Sgzw13JUmjSi4pMVp1BxuGkxrz
csg/PSS/N6dOta+gNCRtBvzC7lC5h7RIuNO9t4K3DC3A5rk2zHXtFt9pQR0Va+Km
RKm1fhDehsA5UISWD+QJGCGvCZ43/AiQ5tE2BndJ86XnVd9yURYnC0x8GwQeb33o
oeVGdigGcF0KDNEDBzK/GXZwMNsqRLns/uxgXt9K7oGfydhbEhABLi/yuhTRZ6+5
kw7FbN0JieEWfPrE5qO3ORkPv+V2dvmE9jXA/jqmOQSjgILMkfg=
=hJlz
-----END PGP SIGNATURE-----
--=-=-=--
