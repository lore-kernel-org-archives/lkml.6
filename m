Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751435AbeDFAQm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 20:16:42 -0400
Received: from ozlabs.org ([103.22.144.67]:58505 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751262AbeDFAQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 20:16:40 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 6 Apr 2018 10:15:42 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the parisc-hd tree
Message-ID: <20180406101542.0bfa38a1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jMvWOgf64Sy1ND_kyJLEGTL"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jMvWOgf64Sy1ND_kyJLEGTL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the parisc-hd tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from include/linux/kernel.h:10:0,
                 from include/linux/list.h:9,
                 from include/linux/preempt.h:11,
                 from include/linux/spinlock.h:51,
                 from include/linux/seqlock.h:36,
                 from include/linux/time.h:6,
                 from include/linux/stat.h:19,
                 from include/linux/compat.h:13,
                 from arch/x86/kernel/signal_compat.c:2:
In function 'signal_compat_build_tests',
    inlined from 'sigaction_compat_abi' at arch/x86/kernel/signal_compat.c:=
166:2:
include/linux/compiler.h:339:38: error: call to '__compiletime_assert_29' d=
eclared with attribute error: BUILD_BUG_ON failed: NSIGFPE !=3D 14
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                      ^
include/linux/compiler.h:319:4: note: in definition of macro '__compiletime=
_assert'
    prefix ## suffix();    \
    ^~~~~~
include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_a=
ssert'
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
  ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:45:37: note: in expansion of macro 'compiletime_a=
ssert'
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:69:2: note: in expansion of macro 'BUILD_BUG_ON_M=
SG'
  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
  ^~~~~~~~~~~~~~~~
arch/x86/kernel/signal_compat.c:29:2: note: in expansion of macro 'BUILD_BU=
G_ON'
  BUILD_BUG_ON(NSIGFPE  !=3D 14);
  ^~~~~~~~~~~~

Caused by commit

  186536608fd1 ("parisc/signal: Add FPE_CONDTRAP for conditional trap handl=
ing")

I applied the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 6 Apr 2018 10:10:26 +1000
Subject: [PATCH] parisc/signal: Add FPE_CONDTRAP for conditional trap handl=
ing
 fix

Update the X86 NSIGFPE check as well.  There are no new fields associated
with this change, so this should be fine.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/x86/kernel/signal_compat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compa=
t.c
index df92605d8724..14c057f29979 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -26,7 +26,7 @@ static inline void signal_compat_build_tests(void)
 	 * new fields are handled in copy_siginfo_to_user32()!
 	 */
 	BUILD_BUG_ON(NSIGILL  !=3D 11);
-	BUILD_BUG_ON(NSIGFPE  !=3D 14);
+	BUILD_BUG_ON(NSIGFPE  !=3D 15);
 	BUILD_BUG_ON(NSIGSEGV !=3D 7);
 	BUILD_BUG_ON(NSIGBUS  !=3D 5);
 	BUILD_BUG_ON(NSIGTRAP !=3D 4);
--=20
2.16.1

--=20
Cheers,
Stephen Rothwell

--Sig_/jMvWOgf64Sy1ND_kyJLEGTL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrGvC8ACgkQAVBC80lX
0GyHggf/Ue/TkyWf/aXonIxndTJovt4jqgWtuzA03MlzKWT0snXKkFQUveFOLALi
1yNSd+QJWwq0FtcjrdYppGvQ9vOafXVdjFgGIWYjQ8vICGAfZRlJsYhJV64/bbG8
hjd3svTEKiae/Qq7cOmdvfpmXwwA8zqpUKwiMccgVu3oLcI76BIfyIQbYyPsxQoJ
b3EYy3YYfkb+wwiFVEKJz4jqr3mYq/TM7VRETLzzMnhSo5/lhnFke+cM45hignmS
pJKzPYsItBRuBmR7LD8TIQOR7pHiHrogMV6FNLfpJduvaqknqWL8E2lzpQDQ/jZx
Krc2rtFMyM5u3WcoRIoCAw2xvsZjZw==
=+UWV
-----END PGP SIGNATURE-----

--Sig_/jMvWOgf64Sy1ND_kyJLEGTL--
