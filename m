Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1E0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1166F218E0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387909AbeLUBVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 20:21:16 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:33068 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbeLUBVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 20:21:15 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 6BDA572CC53;
        Fri, 21 Dec 2018 04:21:12 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 5CC5C964E9F; Fri, 21 Dec 2018 04:21:12 +0300 (MSK)
Date:   Fri, 21 Dec 2018 04:21:12 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/27] arc: define syscall_get_arch()
Message-ID: <20181221012112.GB4591@altlinux.org>
References: <20181213171833.GA5240@altlinux.org>
 <20181213172146.GE6024@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline
In-Reply-To: <20181213172146.GE6024@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 13, 2018 at 08:21:46PM +0300, Dmitry V. Levin wrote:
> syscall_get_arch() is required to be implemented on all architectures
> in addition to already implemented syscall_get_nr(),
> syscall_get_arguments(), syscall_get_error(), and
> syscall_get_return_value() functions in order to extend the generic
> ptrace API with PTRACE_GET_SYSCALL_INFO request.
>=20
> Acked-by: Vineet Gupta <vgupta@synopsys.com>
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Eric Paris <eparis@redhat.com>
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-audit@redhat.com
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---

Looks like the whole series is going to be pinged for quite some time yet,
so would you mind taking this patch into your arc tree, please?
=20
Thanks.

> Notes:
>     v6: unchanged
>     v5: added Cc
>     v2: added Acked-by
>=20
>  arch/arc/include/asm/syscall.h | 11 +++++++++++
>  include/uapi/linux/audit.h     |  4 ++++
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/arch/arc/include/asm/syscall.h b/arch/arc/include/asm/syscal=
l.h
> index 29de09804306..c7fc4c0c3bcb 100644
> --- a/arch/arc/include/asm/syscall.h
> +++ b/arch/arc/include/asm/syscall.h
> @@ -9,6 +9,7 @@
>  #ifndef _ASM_ARC_SYSCALL_H
>  #define _ASM_ARC_SYSCALL_H  1
> =20
> +#include <uapi/linux/audit.h>
>  #include <linux/err.h>
>  #include <linux/sched.h>
>  #include <asm/unistd.h>
> @@ -68,4 +69,14 @@ syscall_get_arguments(struct task_struct *task, struct=
 pt_regs *regs,
>  	}
>  }
> =20
> +static inline int
> +syscall_get_arch(void)
> +{
> +	return IS_ENABLED(CONFIG_ISA_ARCOMPACT)
> +		? (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)
> +			? AUDIT_ARCH_ARCOMPACTBE : AUDIT_ARCH_ARCOMPACT)
> +		: (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)
> +			? AUDIT_ARCH_ARCV2BE : AUDIT_ARCH_ARCV2);
> +}
> +
>  #endif
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 818ae690ab79..bedf3bf54c3a 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -375,6 +375,10 @@ enum {
> =20
>  #define AUDIT_ARCH_AARCH64	(EM_AARCH64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_L=
E)
>  #define AUDIT_ARCH_ALPHA	(EM_ALPHA|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
> +#define AUDIT_ARCH_ARCOMPACT	(EM_ARCOMPACT|__AUDIT_ARCH_LE)
> +#define AUDIT_ARCH_ARCOMPACTBE	(EM_ARCOMPACT)
> +#define AUDIT_ARCH_ARCV2	(EM_ARCV2|__AUDIT_ARCH_LE)
> +#define AUDIT_ARCH_ARCV2BE	(EM_ARCV2)
>  #define AUDIT_ARCH_ARM		(EM_ARM|__AUDIT_ARCH_LE)
>  #define AUDIT_ARCH_ARMEB	(EM_ARM)
>  #define AUDIT_ARCH_CRIS		(EM_CRIS|__AUDIT_ARCH_LE)
> --=20
> ldv

--=20
ldv

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcHEAIAAoJEAVFT+BVnCUIj64QAN+CJFaqs0fVQkjLcQmFsy5h
2um7A8pboavvEjPHETgHBwRxcPXBJvDCzUUwlHnA+sW0OOcBDDYAyLtVivXM7haq
V3fSvtuGE4L04zbkJY20PveFmpf1cy0HFyTG4RP1wyo1Fy++u/MlB42JYCYp9pfS
mhCHTb4IL2eUOA61ZHr81UHv/TCQurOfWyhL28F+YuzlSBSrYPuS/coK1QaLBxdY
ns2UTVkQhHTI2hl7za9/GgaMTDjamLqjisiv/vZOPTo0dDKFB243sJh5r0nPeVhR
Ep+smjcKmdMLgPAYe8zKzuuom+krJnDSGiPI6shEGDNybZ4yj51QseDABER7uByJ
cXhGTJ2LfI1wsh5+QFlw9j9LLhxSNS15tUtb56MI8TUFUSyYW7MFrtiAQhn3Cxl6
3mJqfae4uMB5QNDO7DpRztazu3hQlvMJj7RooqDMPV5eJQEoKTrk/BBQncfMKxCl
NUaIEvqefVUKxPUHWTIJnzqpW7LhfsaWW/P7L1sHsV8v/9jl5N+NPzgIks4ZbV+9
nGxEOrEGBwZs89rNIBPQKtgaelZ99lUc+gQ1foLfph4IMtlOvF2cC0TEN1z9rU/m
r5ZthYYLmuJN4XndfH46naUPReWjFB+F5o7cwjHPhofwKZLjUsi2KteU/6JILrEV
Pww0D9NH9z3weJWJ5oCi
=TZbn
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
