Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934855AbeEWWht (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 18:37:49 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42266 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934544AbeEWWhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 18:37:47 -0400
Date: Wed, 23 May 2018 23:37:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the printk tree with Linus' tree
Message-ID: <20180523223739.GP4828@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CUrluEZVXmx7ezWQ"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CUrluEZVXmx7ezWQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Petr,

Today's linux-next merge of the printk tree got a conflict in:

  lib/vsprintf.c

between commit:

  85f4f12d51397f164 ("vsprintf: Replace memory barrier with static_key for =
random_ptr_key update")

=66rom Linus' tree and commits:

  558594f3c2a5cd65f ("lib/vsprintf: Move pointer_string() upper)"
  496a9a5f3806d58b1 ("lib/vsprintf: Deduplicate pointer_string()")

=66rom the printk tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc lib/vsprintf.c
index 23920c5ff728,7649ef4ed7d0..000000000000
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@@ -1655,36 -1644,19 +1654,22 @@@ char *device_node_string(char *buf, cha
  	return widen_string(buf, buf - buf_start, end, spec);
  }
 =20
- static noinline_for_stack
- char *pointer_string(char *buf, char *end, const void *ptr,
- 		     struct printf_spec spec)
- {
- 	spec.base =3D 16;
- 	spec.flags |=3D SMALL;
- 	if (spec.field_width =3D=3D -1) {
- 		spec.field_width =3D 2 * sizeof(ptr);
- 		spec.flags |=3D ZEROPAD;
- 	}
-=20
- 	return number(buf, end, (unsigned long int)ptr, spec);
- }
-=20
 -static bool have_filled_random_ptr_key __read_mostly;
 +static DEFINE_STATIC_KEY_TRUE(not_filled_random_ptr_key);
  static siphash_key_t ptr_key __read_mostly;
 =20
 -static void fill_random_ptr_key(struct random_ready_callback *unused)
 +static void enable_ptr_key_workfn(struct work_struct *work)
  {
  	get_random_bytes(&ptr_key, sizeof(ptr_key));
 -	/*
 -	 * have_filled_random_ptr_key=3D=3Dtrue is dependent on get_random_bytes=
().
 -	 * ptr_to_id() needs to see have_filled_random_ptr_key=3D=3Dtrue
 -	 * after get_random_bytes() returns.
 -	 */
 -	smp_mb();
 -	WRITE_ONCE(have_filled_random_ptr_key, true);
 +	/* Needs to run from preemptible context */
 +	static_branch_disable(&not_filled_random_ptr_key);
 +}
 +
 +static DECLARE_WORK(enable_ptr_key_work, enable_ptr_key_workfn);
 +
 +static void fill_random_ptr_key(struct random_ready_callback *unused)
 +{
 +	/* This may be in an interrupt handler. */
 +	queue_work(system_unbound_wq, &enable_ptr_key_work);
  }
 =20
  static struct random_ready_callback random_ready =3D {
@@@ -1710,13 -1681,13 +1695,13 @@@ early_initcall(initialize_ptr_random)
  /* Maps a pointer to a 32 bit unique identifier. */
  static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spe=
c spec)
  {
+ 	const char *str =3D sizeof(ptr) =3D=3D 8 ? "(____ptrval____)" : "(ptrval=
)";
  	unsigned long hashval;
- 	const int default_width =3D 2 * sizeof(ptr);
 =20
 -	if (unlikely(!have_filled_random_ptr_key)) {
 +	if (static_branch_unlikely(&not_filled_random_ptr_key)) {
- 		spec.field_width =3D default_width;
+ 		spec.field_width =3D 2 * sizeof(ptr);
  		/* string length must be less than default_width */
- 		return string(buf, end, "(ptrval)", spec);
+ 		return string(buf, end, str, spec);
  	}
 =20
  #ifdef CONFIG_64BIT

--CUrluEZVXmx7ezWQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsF7TIACgkQJNaLcl1U
h9AFdwf/YgdjIavRRQ2/3TTIF6wvD9SGotx7Iq0J8574YCSnae6dx+lerHfDI+tu
qV1jORZ8Ps3Hw4JzgdS5Z1VO5P+1k6e9vBfASIKub24VAENO7uGff+oLrzAkkLw3
MuqF3IQoB4aOCc3yNPk1f19K1KhKSmsWQDb/7tdtY/aCqUmVI/jMias/SuYHVw0/
4g/oXblXoumvFbqtXpj+lu0mxWVKyS2SXkxPa/JbbmYlyL4FGnJyePy1ZiUIB0UL
+KnjgDHvGIjnUbcOFZARZjLkJhG5QJ8PHWWHo/D+bMV/H3dV6GQWSS1cULBzcW4j
AzE0mj50wHY1rriFF6U/snadIGfrDw==
=jeJA
-----END PGP SIGNATURE-----

--CUrluEZVXmx7ezWQ--
