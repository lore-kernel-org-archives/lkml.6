Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbeDMUk2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 16:40:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750904AbeDMUk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 16:40:27 -0400
Date: Fri, 13 Apr 2018 17:40:25 -0300
From: "Bruno E. O. Meneguele" <bmeneg@redhat.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>, Luca Boccassi <bluca@debian.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lockdown: fix coordination of kernel module signature
 verification
Message-ID: <20180413204025.GC2047@rhlt>
References: <1523633272.3272.30.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline
In-Reply-To: <1523633272.3272.30.camel@linux.vnet.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 13, 2018 at 11:27:52AM -0400, Mimi Zohar wrote:
> If both IMA-appraisal and sig_enforce are enabled, then both signatures
> are currently required.  If the IMA-appraisal signature verification
> fails, it could rely on the appended signature verification; but with the
> lockdown patch set, the appended signature verification assumes that if
> IMA-appraisal is enabled, it has verified the signature.  Basically each
> signature verification method would be relying on the other to verify the
> kernel module signature.
>=20
> This patch addresses the problem of requiring both kernel module signature
> verification methods, when both are enabled, by verifying just the
> appended signature.
>=20
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  kernel/module.c                   | 4 +---
>  security/integrity/ima/ima_main.c | 7 ++++++-
>  2 files changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/kernel/module.c b/kernel/module.c
> index 9c1709a05037..60861eb7bc4d 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2803,9 +2803,7 @@ static int module_sig_check(struct load_info *info,=
 int flags,
>  		if (sig_enforce) {
>  			pr_notice("%s is rejected\n", reason);
>  			return -EKEYREJECTED;
> -		}
> -
> -		if (can_do_ima_check && is_ima_appraise_enabled())
> +		} else if (can_do_ima_check && is_ima_appraise_enabled())
>  			return 0;
>  		if (kernel_is_locked_down(reason))
>  			return -EPERM;
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 754ece08e1c6..2155b1f316a4 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -480,6 +480,7 @@ static int read_idmap[READING_MAX_ID] =3D {
>  int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  		       enum kernel_read_file_id read_id)
>  {
> +	bool sig_enforce =3D is_module_sig_enforced();
>  	enum ima_hooks func;
>  	u32 secid;
> =20
> @@ -490,7 +491,11 @@ int ima_post_read_file(struct file *file, void *buf,=
 loff_t size,
>  		return 0;
>  	}
> =20
> -	if (!file && read_id =3D=3D READING_MODULE) /* MODULE_SIG_FORCE enabled=
 */
> +	/*
> +	 * If both IMA-appraisal and appended signature verification are
> +	 * enabled, rely on the appended signature verification.
> +	 */
> +	if (sig_enforce && read_id =3D=3D READING_MODULE)
>  		return 0;
> =20
>  	/* permit signed certs */
> --=20
> 2.7.5
>=20

I agree with the solution.

Acked-by: Bruno E. O. Meneguele <bmeneg@redhat.com>

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAlrRFbkACgkQYdRkFR+R
okM9RQgAusqmb5vXEVaJ+PFyiKcqHJInZJDywwwuS8emd68anOr78WFp9eNQ4X5x
CbcJUNPC/pdX8dacb2D6KATja+tN1wnyQ1NIeKbuXWmW0xaYh9KfNcYxgTIUX3am
g2uIpKXfIxobGVtIDDtpLfCnaTKaASg1i3m2TnA9WcMnGqEzm7vcBCdfk3FoEr3d
MZDnVhl3XgzxXF3c+0Z2xpXbPvQGj7Vk8JPRLQQYoKu/xHN+SPT4QPFQEB49T3/6
gWK9DqGG3105sBx9QQ6KBonCdDehv5I9HnK9ViFpTtFaBWBtemwtjol4IOcOkkrt
y5Lh+13cUg8LTKcEOhYddl8CDjsf7g==
=gbxv
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--
