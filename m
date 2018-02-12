Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932695AbeBLXm2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 18:42:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932378AbeBLXm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 18:42:27 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF23217A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Mon, 12 Feb 2018 23:42:02 +0000
From: James Hogan <jhogan@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Alice Michael <alice.michael@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Shannon Nelson <shannon.nelson@oracle.com>
Subject: Re: [RFC PATCH] MIPS: Provide cmpxchg64 for 32-bit builds
Message-ID: <20180212234201.GB4290@saruman>
References: <1518475021-3337-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
In-Reply-To: <1518475021-3337-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Mon, Feb 12, 2018 at 02:37:01PM -0800, Guenter Roeck wrote:
> Since commit 60f481b970386 ("i40e: change flags to use 64 bits"),
> the i40e driver uses cmpxchg64(). This causes mips:allmodconfig builds
> to fail with
>=20
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:
> 	In function 'i40e_set_priv_flags':
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4443:2: error:
> 	implicit declaration of function 'cmpxchg64'
>=20
> Implement a poor-mans-version of cmpxchg64() to fix the problem for 32-bit
> mips builds. The code is derived from sparc32, but only uses a single
> spinlock.

Will this be implemened for all 32-bit architectures which are currently
missing cmpxchg64()?

If so, any particular reason not to do it in generic code?

If not then I think that driver should be fixed to either depend on some
appropriate Kconfig symbol or to not use this API since it clearly isn't
portable at the moment.

See also Shannon's comment about that specific driver:
https://lkml.kernel.org/r/e7c934d7-e5f4-ee1b-0647-c31a98d9e944@oracle.com

Cheers
James

>=20
> Fixes: 60f481b970386 ("i40e: change flags to use 64 bits")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Compile-tested only.
>=20
>  arch/mips/include/asm/cmpxchg.h |  3 +++
>  arch/mips/kernel/cmpxchg.c      | 17 +++++++++++++++++
>  2 files changed, 20 insertions(+)
>=20
> diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpx=
chg.h
> index 89e9fb7976fe..9f7b1df95b99 100644
> --- a/arch/mips/include/asm/cmpxchg.h
> +++ b/arch/mips/include/asm/cmpxchg.h
> @@ -206,6 +206,9 @@ static inline unsigned long __cmpxchg(volatile void *=
ptr, unsigned long old,
>  #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o),=
 (n))
>  #ifndef CONFIG_SMP
>  #define cmpxchg64(ptr, o, n) cmpxchg64_local((ptr), (o), (n))
> +#else
> +u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new);
> +#define cmpxchg64(ptr, old, new)	__cmpxchg_u64(ptr, old, new)
>  #endif
>  #endif
> =20
> diff --git a/arch/mips/kernel/cmpxchg.c b/arch/mips/kernel/cmpxchg.c
> index 0b9535bc2c53..30216beb2334 100644
> --- a/arch/mips/kernel/cmpxchg.c
> +++ b/arch/mips/kernel/cmpxchg.c
> @@ -9,6 +9,7 @@
>   */
> =20
>  #include <linux/bitops.h>
> +#include <linux/spinlock.h>
>  #include <asm/cmpxchg.h>
> =20
>  unsigned long __xchg_small(volatile void *ptr, unsigned long val, unsign=
ed int size)
> @@ -107,3 +108,19 @@ unsigned long __cmpxchg_small(volatile void *ptr, un=
signed long old,
>  			return old;
>  	}
>  }
> +
> +static DEFINE_SPINLOCK(cmpxchg_lock);
> +
> +u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new)
> +{
> +	unsigned long flags;
> +	u64 prev;
> +
> +	spin_lock_irqsave(&cmpxchg_lock, flags);
> +	if ((prev =3D *ptr) =3D=3D old)
> +		*ptr =3D new;
> +	spin_unlock_irqrestore(&cmpxchg_lock, flags);
> +
> +	return prev;
> +}
> +EXPORT_SYMBOL(__cmpxchg_u64);
> --=20
> 2.7.4
>=20

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqCJkMACgkQbAtpk944
dno+Hw//T9FYzJDizLYv3MQejxSYFcOh137PFoX4zTU3qFD0gL57LGo6wXgwHH5j
YW7KzdP/EsNkeRfWBgqk2AaNBWTRUztrV814RTo1R14dFSnPumLOq/IYynmnsDo3
nvm823NCIcPvtJ9jR2PhrhFlLZuNjqBEfzYr8jdmnBkNeqAixtlpW1prymBJNwNW
/0O+2RlOlpQITUnDEbPUeZy5XkfvZTJaXZHPlBaxNuwy0iE6suWkR+Fi+XDEV+CG
8zIezG/kHDYS/JZizymDp5BzMglOXE1WR7VGGKHrJQ+D2Z/qfHEHT/chMc3JF2ce
DlN7V4yaF8+X/FnkM9A3rSreMQiREvzAB/wGve9bGuQqT5myFr4R40L3Skok9TW7
LWu9BMvIEGYnqzEgqbutsIweYgcr6vhNtZ13vxJIUtovpcbc/lV8cIBWX1L0WZ6p
940HR92VgMFJxyEaV52t4BaYb02+SvO3N+w/O3L60nAVcJSnG+4YLFRjY3xd4M/P
S+RlqK04ZqI8r5Z8srGELWfU8HRYu3GMFhu7nU0CH2+O3GtjdLzmMH5huR3DB8AV
ZHh9/lXuXfAsIiX9GXvy89rTzd5EJBPLpN9wo0JrMHHCgio/wCi7DmQJC7+p4e4d
YCHVWYxXKETa1lv8/d84GtvW5Ydb5U2Ga/GPgHyLmfZ7tlWIp9o=
=PH9W
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
