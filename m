Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932546AbeCMV0F (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 17:26:05 -0400
Received: from smtprelay0041.hostedemail.com ([216.40.44.41]:35039 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932257AbeCMV0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 17:26:04 -0400
X-Session-Marker: 7368656140736865616C6576792E636F6D
X-Spam-Summary: 2,-10,0,,d41d8cd98f00b204,shea@shealevy.com,::::::::::::::,RULES_HIT:41:334:355:368:369:379:599:800:871:960:967:973:988:989:1000:1260:1263:1313:1314:1345:1359:1437:1516:1518:1535:1543:1575:1711:1730:1747:1777:1792:2198:2199:2393:2525:2553:2559:2567:2682:2685:2693:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3355:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4362:4605:4860:5007:6117:6119:6261:6506:6747:7281:7875:7903:7909:7974:8531:8660:9010:9025:9040:9388:10004:10049:10848:11026:11232:11473:11658:11914:12043:12048:12050:12291:12379:12438:12555:12683:12776:12895:13148:13161:13229:13230:14096:14106:14107:14180:14181:14721:14849:21063:21080:21325:21433:21451:21627:21740:30054:30060:30089:30090,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: dime70_34c3d92a9e637
X-Filterd-Recvd-Size: 5423
From: Shea Levy <shea@shealevy.com>
To: Zong Li <zong@andestech.com>, palmer@sifive.com, albert@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong@andestech.com, zongbox@gmail.com
Cc: greentime@andestech.com
Subject: Re: [PATCH 00/11] RISC-V: Resolve the issue of loadable module on 64-bit
In-Reply-To: <cover.1520928420.git.zong@andestech.com>
References: <cover.1520928420.git.zong@andestech.com>
Date: Tue, 13 Mar 2018 17:26:01 -0400
Message-ID: <87vadzzmza.fsf@xps13.shealevy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello!

You may be interested in my recent patchset [1], which has known issues
but addresses the same problems yours does. It differs in the approach
taken here in that, rather than supporting GOT/PLT handling which we
can't really take advantage of anyway, we simply build non-PIC modules
instead [2]. Additionally, I see your patchset has the same concern mine
does, which is that ignoring ALIGN relaxations is not actually an option
[3]. The approach I plan to take is outlined by Palmer at [4].

As of now I hope to get back to my patchset this weekend, but if you're
close to a complete implementation by then maybe I can avoid duplicating
the work ;)

Thanks,
Shea

[1]: http://lists.infradead.org/pipermail/linux-riscv/2018-February/000081.=
html
[2]: http://lists.infradead.org/pipermail/linux-riscv/2018-February/000080.=
html
[3]: http://lists.infradead.org/pipermail/linux-riscv/2018-February/000105.=
html
[4]: http://lists.infradead.org/pipermail/linux-riscv/2018-March/000147.html
Zong Li <zong@andestech.com> writes:

> These patches resolve the some issues of loadable module.
>   - symbol out of ranges
>   - unknown relocation types
>
> The reference of external variable and function symbols
> cannot exceed 32-bit offset ranges in kernel module.
> The module only can work on the 32-bit OS or the 64-bit
> OS with sv32 virtual addressing.
>
> These patches will generate the .got, .got.plt and
> .plt sections during loading module, let it can refer
> to the symbol which locate more than 32-bit offset.
> These sections depend on the relocation types:
>  - R_RISCV_GOT_HI20
>  - R_RISCV_CALL_PLT
>
> These patches also support more relocation types
>  - R_RISCV_CALL
>  - R_RISCV_HI20
>  - R_RISCV_LO12_I
>  - R_RISCV_LO12_S
>  - R_RISCV_RVC_BRANCH
>  - R_RISCV_RVC_JUMP
>  - R_RISCV_ALIGN
>  - R_RISCV_ADD32
>  - R_RISCV_SUB32
>
> Zong Li (11):
>   RISC-V: Add sections of PLT and GOT for kernel module
>   RISC-V: Add section of GOT.PLT for kernel module
>   RISC-V: Support GOT_HI20/CALL_PLT relocation type in kernel module
>   RISC-V: Support CALL relocation type in kernel module
>   RISC-V: Support HI20/LO12_I/LO12_S relocation type in kernel module
>   RISC-V: Support RVC_BRANCH/JUMP relocation type in kernel modulewq
>   RISC-V: Support ALIGN relocation type in kernel module
>   RISC-V: Support ADD32 relocation type in kernel module
>   RISC-V: Support SUB32 relocation type in kernel module
>   RISC-V: Enable module support in defconfig
>   RISC-V: Add definition of relocation types
>
>  arch/riscv/Kconfig                  |   5 ++
>  arch/riscv/Makefile                 |   3 +
>  arch/riscv/configs/defconfig        |   2 +
>  arch/riscv/include/asm/module.h     | 112 +++++++++++++++++++++++
>  arch/riscv/include/uapi/asm/elf.h   |  24 +++++
>  arch/riscv/kernel/Makefile          |   1 +
>  arch/riscv/kernel/module-sections.c | 156 ++++++++++++++++++++++++++++++=
++
>  arch/riscv/kernel/module.c          | 175 ++++++++++++++++++++++++++++++=
++++--
>  arch/riscv/kernel/module.lds        |   8 ++
>  9 files changed, 480 insertions(+), 6 deletions(-)
>  create mode 100644 arch/riscv/include/asm/module.h
>  create mode 100644 arch/riscv/kernel/module-sections.c
>  create mode 100644 arch/riscv/kernel/module.lds
>
> --=20
> 2.16.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6ESKvwKkwnxgMLnaXAvWlX2G/icFAlqoQekACgkQXAvWlX2G
/icQMg//Veuyxbf/COwIXZiii1KT+useeuSQjczLLKn90qwPc/5zeI2slINzxVWl
LWEjZ7P4KYwXjvGBpqpjUeJGR6M6lQgtVoF4n7srqibLox03f4P5E6nOZ4fRSqo+
wcLVNt2hzPJAfNjwh1/BInl3VwzvAKsXvGbVOEAXlXwYy4r3MlJ1+qoK5bQ+9JGT
6sRAyOt+9PV8NKwrvvfwhoqTFfFRh3lXSoRPBYV8FezyJ9cia7868tlSKydig4CS
6MxYTfYkc1q3N1Fn1/jZ8JbcHteWIQTLDatBsTWcuO0lcCdMN9QuFiBz3KwxCtuo
iblZcE3VBqn7MNnFtdTOZZk0sC9fNBC9hbp+TCwXtuWA3AhCk6dPC7a9AGC1iz8z
gll10K585IYBwy4u+HAzV7kBNhuEC93yf1LSQ83vXlSVSl/roycOluYLBV3rif82
ATuPptNGYdjPoIHBEAZ2szeIazOHYtxtiNDoIp9/pi32Qv6kQnMIaeC7EL4lMw9S
4FClEOMTIyaKIG1qvG11dkBFkPkXda0tVwmghPBB9SScBuHJD54CTSaFVuWy8SFy
Y/6G5DyLBXAfNJf7FakHV0gADfAkSzo5X46hYqMKQP4WrfUhPVX1JKcvrmERQu7k
bYpk+VMJYfjswIDjv32fCa+jddsMhIMD7o36clepefL2i38rf6s=
=lysD
-----END PGP SIGNATURE-----
--=-=-=--
