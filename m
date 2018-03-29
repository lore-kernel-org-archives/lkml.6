Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbeC2A7V (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 20:59:21 -0400
Received: from ozlabs.org ([103.22.144.67]:39677 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbeC2A7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 20:59:18 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 29 Mar 2018 11:58:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Al Viro <viro@ZenIV.linux.org.uk>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the vfs tree with the syscalls tree
Message-ID: <20180329115825.22297d55@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gvEy2gzolRVJ5rLfGsqpluj"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gvEy2gzolRVJ5rLfGsqpluj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

Today's linux-next merge of the vfs tree got a conflict in:

  arch/sparc/kernel/sys_sparc32.c

between commits:

  4b5d3cc0fff9 ("fs: add ksys_ftruncate() wrapper; remove in-kernel calls t=
o sys_ftruncate()")
  316dd9ee7b15 ("fs: add ksys_sync_file_range helper(); remove in-kernel ca=
lls to syscall")
  eb16d89821c8 ("fs: add ksys_truncate() wrapper; remove in-kernel calls to=
 sys_truncate()")
  cdf490758828 ("fs: add ksys_p{read,write}64() helpers; remove in-kernel c=
alls to syscalls")
  757df4a44629 ("fs: add ksys_fallocate() wrapper; remove in-kernel calls t=
o sys_fallocate()")
  50811e2580e0 ("mm: add ksys_fadvise64_64() helper; remove in-kernel call =
to sys_fadvise64_64()")
  c008a19d1399 ("mm: add ksys_readahead() helper; remove in-kernel calls to=
 sys_readahead()")

from the syscalls tree and commit:

  a00a700bdea8 ("sparc: get rid of remaining SIGN... wrappers")
  8ccb004677d1 ("convert compat sync_file_range() to COMPAT_SYSCALL_DEFINE")
  8c82ccd63192 ("sparc: switch compat pread64 and pwrite64 to COMPAT_SYSCAL=
L_DEFINE")
  3d0e354e4e51 ("sparc: switch compat {f,}truncate64() to COMPAT_SYSCALL_DE=
FINE")

from the vfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/sparc/kernel/sys_sparc32.c
index f166e5bbf506,c27e7e9e641b..000000000000
--- a/arch/sparc/kernel/sys_sparc32.c
+++ b/arch/sparc/kernel/sys_sparc32.c
@@@ -52,20 -52,14 +52,14 @@@
 =20
  #include "systbls.h"
 =20
- asmlinkage long sys32_truncate64(const char __user * path, unsigned long =
high, unsigned long low)
+ COMPAT_SYSCALL_DEFINE3(truncate64, const char __user *, path, u32, high, =
u32, low)
  {
- 	if ((int)high < 0)
- 		return -EINVAL;
- 	else
- 		return ksys_truncate(path, (high << 32) | low);
 -	return sys_truncate(path, ((u64)high << 32) | low);
++	return ksys_truncate(path, ((u64)high << 32) | low);
  }
 =20
- asmlinkage long sys32_ftruncate64(unsigned int fd, unsigned long high, un=
signed long low)
+ COMPAT_SYSCALL_DEFINE3(ftruncate64, unsigned int, fd, u32, high, u32, low)
  {
- 	if ((int)high < 0)
- 		return -EINVAL;
- 	else
- 		return ksys_ftruncate(fd, (high << 32) | low);
 -	return sys_ftruncate(fd, ((u64)high << 32) | low);
++	return ksys_ftruncate(fd, ((u64)high << 32) | low);
  }
 =20
  static int cp_compat_stat64(struct kstat *stat,
@@@ -194,62 -188,51 +188,51 @@@ COMPAT_SYSCALL_DEFINE5(rt_sigaction, in
          return ret;
  }
 =20
- asmlinkage compat_ssize_t sys32_pread64(unsigned int fd,
- 					char __user *ubuf,
- 					compat_size_t count,
- 					unsigned long poshi,
- 					unsigned long poslo)
+ COMPAT_SYSCALL_DEFINE5(pread64, unsigned int, fd, char __user *, ubuf,
+ 			compat_size_t, count, u32, poshi, u32, poslo)
  {
- 	return ksys_pread64(fd, ubuf, count, (poshi << 32) | poslo);
 -	return sys_pread64(fd, ubuf, count, ((u64)poshi << 32) | poslo);
++	return ksys_pread64(fd, ubuf, count, ((u64)poshi << 32) | poslo);
  }
 =20
- asmlinkage compat_ssize_t sys32_pwrite64(unsigned int fd,
- 					 char __user *ubuf,
- 					 compat_size_t count,
- 					 unsigned long poshi,
- 					 unsigned long poslo)
+ COMPAT_SYSCALL_DEFINE5(pwrite64, unsigned int, fd, char __user *, ubuf,
+ 			compat_size_t, count, u32, poshi, u32, poslo)
  {
- 	return ksys_pwrite64(fd, ubuf, count, (poshi << 32) | poslo);
 -	return sys_pwrite64(fd, ubuf, count, ((u64)poshi << 32) | poslo);
++	return ksys_pwrite64(fd, ubuf, count, ((u64)poshi << 32) | poslo);
  }
 =20
- asmlinkage long compat_sys_readahead(int fd,
- 				     unsigned long offhi,
- 				     unsigned long offlo,
- 				     compat_size_t count)
+ COMPAT_SYSCALL_DEFINE4(readahead, int, fd, u32, offhi, u32, offlo,
+ 		     compat_size_t, count)
  {
- 	return ksys_readahead(fd, (offhi << 32) | offlo, count);
 -	return sys_readahead(fd, ((u64)offhi << 32) | offlo, count);
++	return ksys_readahead(fd, ((u64)offhi << 32) | offlo, count);
  }
 =20
- long compat_sys_fadvise64(int fd,
- 			  unsigned long offhi,
- 			  unsigned long offlo,
- 			  compat_size_t len, int advice)
+ COMPAT_SYSCALL_DEFINE5(fadvise64, int, fd, u32, offhi, u32, offlo,
+ 			  compat_size_t, len, int, advice)
  {
- 	return ksys_fadvise64_64(fd, (offhi << 32) | offlo, len, advice);
 -	return sys_fadvise64_64(fd, ((u64)offhi << 32) | offlo, len, advice);
++	return ksys_fadvise64_64(fd, ((u64)offhi << 32) | offlo, len, advice);
  }
 =20
- long compat_sys_fadvise64_64(int fd,
- 			     unsigned long offhi, unsigned long offlo,
- 			     unsigned long lenhi, unsigned long lenlo,
- 			     int advice)
+ COMPAT_SYSCALL_DEFINE6(fadvise64_64, int, fd, u32, offhi, u32, offlo,
+ 			     u32, lenhi, u32, lenlo, int, advice)
  {
 -	return sys_fadvise64_64(fd,
 +	return ksys_fadvise64_64(fd,
- 				 (offhi << 32) | offlo,
- 				 (lenhi << 32) | lenlo,
- 				 advice);
+ 				((u64)offhi << 32) | offlo,
+ 				((u64)lenhi << 32) | lenlo,
+ 				advice);
  }
 =20
- long sys32_sync_file_range(unsigned int fd, unsigned long off_high, unsig=
ned long off_low, unsigned long nb_high, unsigned long nb_low, unsigned int=
 flags)
+ COMPAT_SYSCALL_DEFINE6(sync_file_range, unsigned int, fd, u32, off_high, =
u32, off_low,
+ 			u32, nb_high, u32, nb_low, unsigned int, flags)
  {
 -	return sys_sync_file_range(fd,
 +	return ksys_sync_file_range(fd,
- 				   (off_high << 32) | off_low,
- 				   (nb_high << 32) | nb_low,
+ 				   ((u64)off_high << 32) | off_low,
+ 				   ((u64)nb_high << 32) | nb_low,
  				   flags);
  }
 =20
- asmlinkage long compat_sys_fallocate(int fd, int mode, u32 offhi, u32 off=
lo,
- 				     u32 lenhi, u32 lenlo)
+ COMPAT_SYSCALL_DEFINE6(fallocate, int, fd, int, mode, u32, offhi, u32, of=
flo,
+ 				     u32, lenhi, u32, lenlo)
  {
 -	return sys_fallocate(fd, mode, ((loff_t)offhi << 32) | offlo,
 -			     ((loff_t)lenhi << 32) | lenlo);
 +	return ksys_fallocate(fd, mode, ((loff_t)offhi << 32) | offlo,
 +			      ((loff_t)lenhi << 32) | lenlo);
  }

--Sig_/gvEy2gzolRVJ5rLfGsqpluj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq8OjEACgkQAVBC80lX
0GxWVgf/aaSqnN9vZv21YAmINEUXAAII0f5ssJ8QODNuXKvl3QAnzBXiK7u0LUIN
t040o52Ciy6QiKU1NAU8or4QIdHVPrncLztLgg+Kvokle9frmVxTzx9tDFnJaDsO
wQorHcju0L9iLAofXJxIrMbAw/eHbiPt/5zG4smJVUI3wo9aifvN3NOXrX0jSqlp
ruuzA/NR+wYOLaoXrTUsrldKYPXMRMB93u1TYo3GZJ9HlqY09a4V7XVLMHksDcrb
iZaNxPyLaF6Sji0e5/cijTen+Tb4wPgT/Mzb70daaDfCzMskSqO38vZXKiT3WCP0
IuUk2cKyBgdy2tjYyLr7nb86tKl97w==
=SVh1
-----END PGP SIGNATURE-----

--Sig_/gvEy2gzolRVJ5rLfGsqpluj--
